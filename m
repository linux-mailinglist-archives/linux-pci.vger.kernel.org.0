Return-Path: <linux-pci+bounces-259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352F7FE423
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D001F20610
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FD40C05;
	Wed, 29 Nov 2023 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkrHl0UL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83C4CB32
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 23:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC51FC433C7;
	Wed, 29 Nov 2023 23:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701300070;
	bh=9rdUMQCjtMr+ri5NEp2KYKHprcR+lytmbQP/lABcO2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mkrHl0ULby81el9Tdi5wmgCfn8mVc0JBY/qTBKFuTKOV/yj+7U6oroEKfKUzCOved
	 68JatSVY8amXrxWOwXp8yrL7A+igA0ZVNVPNlQnoxAdWFAzfJYZZ/yRKafewoP1fwh
	 Y7xdcggF8W5NWZFsbkbhnxj+t4zN/BLubFTqUQoPyZRD95PTbdjRkRv0QMKNisyNua
	 NxZDw+rSP2x2atemkcLccbIEpl7JvhS7iyNJn7QmPR7nwxpiRQStzFpyjPPIF/f0O2
	 enVW6eVuZbJzypOGsxMn9opRGLvyLVUg2eZn6tmaEZBqZWekXrFB81eKVM2OCdeN5R
	 KwJHqnTYXk8Hg==
Date: Wed, 29 Nov 2023 17:21:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mason.huo@starfivetech.com,
	leyfoon.tan@starfivetech.com, minda.chen@starfivetech.com
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Message-ID: <20231129232108.GA444155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124014508.43358-1-kevin.xie@starfivetech.com>

On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
> time between sending the first configuration request to the device and
> exit from a conventional reset (or after link training completes).

s/marco/macro/

List the first event before the second one, i.e., the delay is from
exit from reset to the config request.

> As described in the conventional reset rules of PCI specifications,
> there are two different use cases of the value:
> 
>    - With a downstream port that supports link speeds <= 5.0 GT/s,
>      the waiting is following exit from a conventional reset.
> 
>    - With a downstream port that supports link speeds > 5.0 GT/s,
>      the waiting is after link training completes.

Include the spec citation here as well as in the comment below.

I assume there are follow-on patches that actually use this?  Can we
make this the first patch in a series so we know we don't have an
unused macro lying around?

> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/pci/pci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..4ca8766e546e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -22,6 +22,13 @@
>   */
>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>  
> +/*
> + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
> + * Requires a minimum waiting of 100ms before sending a configuration
> + * request to the device.
> + */
> +#define PCIE_CONFIG_REQUEST_WAIT_MS	100
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.25.1
> 

