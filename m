Return-Path: <linux-pci+bounces-2119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DA82C41B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA0828547B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932317C7F;
	Fri, 12 Jan 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/it6ZRJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A081757F;
	Fri, 12 Jan 2024 16:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5983C433F1;
	Fri, 12 Jan 2024 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078712;
	bh=6BMDfJ5c63lfLV+AgM5FqKmFO/iabKogwK/rRP83CI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S/it6ZRJzqE59hXdX3tLslvvnHCf7nPCJEBt1pv9HEHDmtmqvX9FY4MBiOp9ROPpH
	 URStaObMvnyhJRqYcWfOmofllck+lV5RyS4z3LkMwp8p8493KKkm3b/JRd7qS7pn1u
	 IaFS0oOfW+xfjdAA6FTM/hVgVnFD/GvOSCMm8E27PvbMMFMQgIQip+mD9QlexYgjaP
	 QK2itt5Uh4x5G5bv7CDmLq0i+bc0wIZJaLmV4UM4K1CQOlKwcWg1H9VgozmKuy9iWz
	 HjsvD306JQDVchYbwxWa/l81qIgMgu4+nhGyrcTgt1hO03mM6SP7tBfgmB+dLG7JKH
	 +edfStHMgp5fw==
Date: Fri, 12 Jan 2024 10:58:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, will@kernel.org, frowand.list@gmail.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 2/2] PCI: Add support for "preserve-boot-config"
 property
Message-ID: <20240112165830.GA2271982@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110030725.710547-3-vidyas@nvidia.com>

On Wed, Jan 10, 2024 at 08:37:25AM +0530, Vidya Sagar wrote:
> Add support for "preserve-boot-config" property that can be used to
> selectively (i.e. per host bridge) instruct the kernel to preserve the
> boot time configuration done by the platform firmware.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed issues reported by kernel test robot <lkp@intel.com>
> 
>  drivers/pci/controller/pci-host-common.c |  5 ++++-
>  drivers/pci/of.c                         | 18 ++++++++++++++++++
>  drivers/pci/probe.c                      |  2 +-
>  include/linux/of_pci.h                   |  6 ++++++
>  4 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 6be3266cd7b5..d3475dc9ec44 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -68,13 +68,16 @@ int pci_host_common_probe(struct platform_device *pdev)
>  
>  	of_pci_check_probe_only();
>  
> +	bridge->preserve_config =
> +		of_pci_check_preserve_boot_config(dev->of_node);

Thanks for leveraging the existing "preserve_config" support for the
ACPI _DSM.  Is pci_host_common_probe() the best place for this?  I
think there are many DT platform drivers that do not use
pci_host_common_probe(), so I wonder if there's a more generic place
to put this.

I see Rob's concern about adding "preserve-boot-config" vs extending
"linux,pci-probe-only" and I don't really have an opinion on that,
although I do think the "pci-probe-only" name is not as descriptive as
it could be.  I guess somebody will argue that "preserve_config" could
be more descriptive, too :)

Bjorn

