Return-Path: <linux-pci+bounces-18408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F19F1538
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF57188B6FB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2521019CD08;
	Fri, 13 Dec 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPO4ih82"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D118CBE1
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115670; cv=none; b=njbcXdKQhgk7/kLiIbHMtee/ggpqlYu0LEDK4g88lMDODLwUqF+A2CuLY17Nod6Y3aHx0XCvx8Xmnnbby83ilCLLhSGz/cjkE2ayLBJgVUEmR4tq3cUSvtJ0juYr1ky6hDPy2G0I97S67BPd9/Z4JCNucI8TLFMGDPFAi+L1/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115670; c=relaxed/simple;
	bh=7jOG+o7F5M/VMegqZfzT9Z8E032Zvghu26tlXZAuE/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DY/ZwLsx73M9t6D4NkUN2uGa/qV1gnkRsLUsYMOsqFlwnImGP8w/oSOdODUtchWgphOL16o/gjgUDKG9iylSb4BplZSqL5qV1xaCRsiwgcghOCsd7+etNHt4+ijmouxme0KvMGUMGPY3scUwWmPt7n4iKrsBv2LPUGrQTB3xC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPO4ih82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7FEC4CED0;
	Fri, 13 Dec 2024 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115669;
	bh=7jOG+o7F5M/VMegqZfzT9Z8E032Zvghu26tlXZAuE/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CPO4ih82cSgdYBNR7WBnc7NlxoIoq1eOEjReuR9YPb98FNr4eeVCoAB8qInt+1vYG
	 VtwsiOCBqOfPN6AZ5jsDPwfsnP3eEINt7uk4cw25CNUe2awL3wFD00rbYeB6BVABiA
	 K3j9dhHe65+oJ/nz+vIdTMPJwdwKPE6ggLQrqv2/wGhYbaWANkd/2K6dww0kR3rkP7
	 ejuQfFgs3UynXIvZqYMD6aZGFfQkPcX0/GvKg0Fsxr4oXEL4E8brn4JY6wrB44umF9
	 /1ft8Y/QFPjQYis2UHp8rKooyrqjTJS82WgKqkDQP1Khf/e3q9StaZqmV9F8rpYKfw
	 i9dSMLRD5DuUw==
Date: Fri, 13 Dec 2024 12:47:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Add Rockchip vendor ID
Message-ID: <20241213184748.GA3424367@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734063843-188144-1-git-send-email-shawn.lin@rock-chips.com>

On Fri, Dec 13, 2024 at 12:24:02PM +0800, Shawn Lin wrote:
> This patch moves PCI_VENDOR_ID_ROCKCHIP from pci_endpoint_test.c to
> pci_ids.h. And reuse it in pcie-rockchip-host.c.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczynski <kw@linux.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v3:
> - add commit log and reuse this ID for more places
> 
> Changes in v2: None
> 
>  drivers/misc/pci_endpoint_test.c            | 1 -
>  drivers/pci/controller/pcie-rockchip-host.c | 2 +-
>  drivers/pci/controller/pcie-rockchip.h      | 1 -
>  include/linux/pci_ids.h                     | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47..b5c8422 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -85,7 +85,6 @@
>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
>  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
>  
> -#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
>  #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
>  
>  static DEFINE_IDA(pci_endpoint_test_ida);
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 5adac6a..6a46be1 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -367,7 +367,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  		}
>  	}
>  
> -	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
> +	rockchip_pcie_write(rockchip, PCI_VENDOR_ID_ROCKCHIP,
>  			    PCIE_CORE_CONFIG_VENDOR);
>  	rockchip_pcie_write(rockchip,
>  			    PCI_CLASS_BRIDGE_PCI_NORMAL << 8,
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index a51b087..f9eaac9 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -198,7 +198,6 @@
>  #define AXI_WRAPPER_NOR_MSG			0xc
>  
>  #define PCIE_RC_SEND_PME_OFF			0x11960
> -#define ROCKCHIP_VENDOR_ID			0x1d87
>  #define PCIE_LINK_IS_L2(x) \
>  	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
>  #define PCIE_LINK_TRAINING_DONE(x) \
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d2402bf..6f68267 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2604,6 +2604,8 @@
>  
>  #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
>  
> +#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
> +
>  #define PCI_VENDOR_ID_HYGON		0x1d94
>  
>  #define PCI_VENDOR_ID_META		0x1d9b
> -- 
> 2.7.4
> 

