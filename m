Return-Path: <linux-pci+bounces-21770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CCBA3ABD5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D5E188B3C1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD81B6CEC;
	Tue, 18 Feb 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVE+IoFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654F286297
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918396; cv=none; b=X4SdW4FeohZuo91m7xmO1o82Oin7TozzV86jh86Yymgd5588+8SfGhiuMEXnX++Q19Wyc1nemVY+DTm0dq8QsctOg2WFsQRsK4ghljCodMezwl7Ros47neRFdNZkrvUv69FF40POyqkTI5roVV7qnOINmjxdXZ6MtfwH2dbrxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918396; c=relaxed/simple;
	bh=1uueerDudQDzZM3rMjq1jkGqVCReNeWeedbmGZ7WwGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YSpJtqQ0fv4N6rNJqVunWmPEtUNsXwzhgpQcBAJ2CmzpVnsnn7SSyP7aML6aXJSlsjGL+a9Iu5jD/Y2QeFyYYCRKqAGjHcuCEWo412177YNk6oBlg0fcnISfHZ3019sjADZDdq5dNsesIUB2FdxJ5rQSGmoYE0u+GfYykezfqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVE+IoFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F21C4CEE2;
	Tue, 18 Feb 2025 22:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918395;
	bh=1uueerDudQDzZM3rMjq1jkGqVCReNeWeedbmGZ7WwGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iVE+IoFaXWo8WVx6/0+PaF3CnXwscKlA4xl4fpgvGengoBrdGXy8mkRT2zK6OLzUt
	 DWPavIQXis1YNQ5qV3abNFrWBX5h+4xnu4c0QsNoD3bbIj1WCT+JElOGyVG4hWp+5/
	 QRexkChB71Udn/RbwcSmWh1JZOmcFGNpV+iqSkxv9whO82VcRr56RtUZ3MH4Mb8IOh
	 4KidYcyIeuReqEn1e/bR50BottqttBIYXQ7LC+VzNKfExAV81BGz1se5ru23G5PZ6D
	 ctHrfozEaommAcPaEOjUB/n1Kk3aX0GAtnSzjBrr0x4J1QzSMNwkhlYLw4YDixks83
	 pvgh7P17Nw8lw==
Date: Tue, 18 Feb 2025 16:39:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Shradha Todi <shradha.t@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Add Rockchip vendor ID
Message-ID: <20250218223954.GA197669@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218092120.2322784-2-cassel@kernel.org>

On Tue, Feb 18, 2025 at 10:21:21AM +0100, Niklas Cassel wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> This patch moves PCI_VENDOR_ID_ROCKCHIP from pci_endpoint_test.c to
> pci_ids.h. And reuse it in pcie-rockchip-host.c.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczynski <kw@linux.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to pci/controller/rockchip for v6.15, thanks.

> ---
> Hello PCI maintainers,
> 
> This patch was previously part of of series that seems to have stagnated.
> Bjorn did provide his Ack on this patch for that series, however, I suggest
> that this patch is merged by the PCI tree.
> (Shradha's series will be merged via PCI tree, so we will need this patch
> in PCI tree anyway to enable Rockchip in the DWC specific debugfs file.)
> 
>  drivers/misc/pci_endpoint_test.c            | 1 -
>  drivers/pci/controller/pcie-rockchip-host.c | 2 +-
>  drivers/pci/controller/pcie-rockchip.h      | 1 -
>  include/linux/pci_ids.h                     | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..b002740acf8d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -88,7 +88,6 @@
>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
>  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
>  
> -#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
>  #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
>  
>  static DEFINE_IDA(pci_endpoint_test_ida);
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 5adac6adc046..6a46be17aa91 100644
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
> index 11def598534b..14954f43e5e9 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -200,7 +200,6 @@
>  #define AXI_WRAPPER_NOR_MSG			0xc
>  
>  #define PCIE_RC_SEND_PME_OFF			0x11960
> -#define ROCKCHIP_VENDOR_ID			0x1d87
>  #define PCIE_LINK_IS_L2(x) \
>  	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
>  #define PCIE_LINK_TRAINING_DONE(x) \
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index de5deb1a0118..e1a270e7e0c5 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2609,6 +2609,8 @@
>  
>  #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
>  
> +#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
> +
>  #define PCI_VENDOR_ID_HYGON		0x1d94
>  
>  #define PCI_VENDOR_ID_META		0x1d9b
> -- 
> 2.48.1
> 

