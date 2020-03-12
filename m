Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BE183B38
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 22:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLVV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 17:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgCLVV1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 17:21:27 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8B3206BE;
        Thu, 12 Mar 2020 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584048086;
        bh=7QxQN2DwLQDaVoXZb2JtRCzxu6x2CTMFwMZ1K7jh2Tw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QqRSOd7LF3x7XcKV2ckDTs7eei1HR1cy25PL5NuTve+HDQbfdSyp8CF+vk+l6giQ4
         u3TU2kj8GRNgjxzk74X0Ojxauu/0EYksv/nxCZHLDY0/m+lr+Nj2deVAcUKn/iC3Mx
         8/LOU5eJCGAMcwqjgAe1ZLJi8w879jpNlPq1YdfQ=
Date:   Thu, 12 Mar 2020 16:21:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
        baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH v2 02/11] PCI: Add ats_supported host bridge flag
Message-ID: <20200312212124.GA178131@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 01:44:57PM +0100, Jean-Philippe Brucker wrote:
> Each vendor has their own way of describing whether a host bridge
> supports ATS.  The Intel and AMD ACPI tables selectively enable or
> disable ATS per device or sub-tree, while Arm has a single bit for each
> host bridge.  For those that need it, add an ats_supported bit to the
> host bridge structure.

Can you mention the specific ACPI tables here in the commit log?

Maybe elaborate on the "for those that need it" bit?  I'm not sure if
you need it for the cases where DT or ACPI tells us directly for the
host bridge, or if you need it for the more selective cases?

I guess in one sense you *always* need it since you check the cached
bit later.

I don't understand the implications of this, especially the selective
situation.  Given your comment from the first posting, I thought this
was a property of the host bridge, so I don't know what it means to
say some devices support ATS but others don't.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: try to improve the comment
> ---
>  drivers/pci/probe.c | 8 ++++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..b5e36f06b40a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -598,6 +598,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +
> +	/*
> +	 * Some systems (ACPI IORT, device-tree) declare ATS support at the host
> +	 * bridge, and clear this bit when ATS isn't supported. Others (ACPI
> +	 * DMAR and IVRS) declare ATS support with a smaller granularity, and
> +	 * need this bit set.
> +	 */
> +	bridge->ats_supported = 1;
>  }
>  
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a9de..9fe2e84d74d7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,6 +511,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> +	unsigned int	ats_supported:1;
>  
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
> -- 
> 2.25.1
> 
