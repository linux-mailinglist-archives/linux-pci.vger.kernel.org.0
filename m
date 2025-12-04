Return-Path: <linux-pci+bounces-42599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B6CA220B
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 02:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D08D302CF4F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488123817F;
	Thu,  4 Dec 2025 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvXTMHmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D81FE471
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764813071; cv=none; b=L7O54IoErXT1XTlbNvDHmP9ITBi5BNTFaZtA/W+TkFmxExBDEV4xTqqh5mojx620FfjFmwr163y4gN+RErognFffyMYGLu/t/6ONPHYANCuxu89QqPvUaHBoyO9w4cVO8ll9LcPsSoUEuoUv0qRkYRH1JBVomR6AQqivB/B3wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764813071; c=relaxed/simple;
	bh=TpUHAqE6UBhu4MruTFC47ZTyk/LHpXVEfQESeX+Zs/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXog5nBUiliNe29vIJ+k8+AL9F0FfFcaK6m6wVlZXki0JlDrKfOOWtCLLrvaQ8h8rAxNvu03ZYpm9HwOeILObGEsZd2aoTL1DweNigUzn+AGPQek1kUOcoAvli4eeLdLOLP+GJG2lYqe6Z2FbaA/KIbXUzwNo1mhuntb5N/7EWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cvXTMHmS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so247756a12.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 17:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764813069; x=1765417869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99z3TXuiGKnUbdI716ISNYmEuYSPxRxRHOFkHrMKwBU=;
        b=cvXTMHmSURRCSaXrLX/lOvWtr1Lc1MiCqLWpxR3J0OmERTnuX/dDdBl52gV+5IOTxW
         /yxK9WBqD3QOltZKS+MDz1LAzPj5AVzbi1uz6LQKkGLLBpwulrMw1EOzOb8Be+9FJdDg
         zotx5dlAwQyNR3lBnCnQwk+A22svDyB/dedOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764813069; x=1765417869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99z3TXuiGKnUbdI716ISNYmEuYSPxRxRHOFkHrMKwBU=;
        b=wAVJxfCMhnq0Hb3PywJWEj0enC5oSiGWWtCToEp08uFbyONQgNjljllD4T3vVsR3jT
         pb2f433IvxDVvToB40wKUb/Qco5w5qaKBtF+meXhjHMnhHhPVftEx1vlrCNsBuBlKGMN
         kNMvudxaUxb52Rx59Iu0+aYva5Z5KxlF4eaHTLryZUNsetlIHKAhoUtBwDZzex9JCz6o
         I2h1CgD3UYjt3YZVH47TkGpr+OIKM0VELaCgU75KiASTMlSNORjdiZ6Uy06S7vw7t+jk
         5Rd5Z4PIyDIKDxub4RXZT2XDPn8M5JBsI/2O0DR3463N5c+p0KmclXjGpZOrD2N1s7W6
         CMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7GSMWnJhBOrHLBazHjVxJfIeS1H9T0ogaMrL0uYYopxZInxveMEADhoZK++SuixE4NtBtyKVAUZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7KW2ekjjmerejf9D04njKnXzmIj9zAW6FLpQqdzPGf83l+8j
	C9nFiAImkaQGUaX5pEjFladQusTTrZET43rnWzKX/43j0WeWWT8tjcUe3jWoLpqUmw==
X-Gm-Gg: ASbGncuobmzd5Wp1eNH2cQfnjHYclbY8HBheQl3Xo/CQ49hqVGg+L5WabGCbJg+F+9f
	AkLPA1BdskBuvOLkJn/Uw10I1CYBe4xAWMV+A4xcOsCgDQM0JRDkwNaxeCfz+H7yNW9pHYoFZ3Y
	PK2X+QL0LuxZihkFWQUYWvc5YrREU0Yl+TnTxXmpGO515L2DOoinZIaENEIyQSbzblSaa/YvAK7
	R2VRF3Gc2mqkiVEj94a20r38hAIjei2wOL7Qr/J2S28QZre15AmpIaeAjgMJyFPiJrBwPXZOBZd
	P1NB+dq06iLoqoSKrLLenV90XBcRKdRBCE+WGOA6Dkg5ZaJfnB6zbeECrnctMTTwo0LIPh0IMRq
	Ljc/Qs6NSYqcNcY0fPw2J0RI4sUhCoAa/jsT63bUE3tnwTC1tW2KZU7v8HTiH6ni9FPGLOKH+No
	2m1IpPli1VM5vrTjVP17YodkMgd7EwOdDm1d8cuj0R7iCzPBHflg==
X-Google-Smtp-Source: AGHT+IFvnri2mh9npGsPKxAY3C1HmUov4Cgkz8425q7v12Udu1UK+pVLvAsk8UXu+jiHgwDvDcmvpQ==
X-Received: by 2002:a05:7300:dc8e:b0:2a4:3594:72d4 with SMTP id 5a478bee46e88-2ab92d545b0mr2673849eec.3.1764813069154;
        Wed, 03 Dec 2025 17:51:09 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:e953:f750:77d0:7f01])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2aba83d2a5fsm712051eec.2.2025.12.03.17.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 17:51:08 -0800 (PST)
Date: Wed, 3 Dec 2025 17:51:06 -0800
From: Brian Norris <briannorris@chromium.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Message-ID: <aTDpCpLUzxnAmvt6@google.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>

Hi,

On Sun, Nov 09, 2025 at 10:59:42PM -0800, Qiang Yu wrote:
> Some platforms may not support ITS (Interrupt Translation Service) and
> MBI (Message Based Interrupt), or there are not enough available empty SPI
> lines for MBI, in which case the msi-map and msi-parent property will not
> be provided in device tree node. For those cases, the DWC PCIe driver
> defaults to using the iMSI-RX module as MSI controller. However, due to
> DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
> when MSI is properly configured and supported as iMSI-RX will only monitor
> and intercept incoming MSI TLPs from PCIe link, but the memory write
> generated by Root Port are internal system bus transactions instead of
> PCIe TLPs, so they are ignored.
> 
> This leads to interrupts such as PME, AER from the Root Port not received
> on the host and the users have to resort to workarounds such as passing
> "pcie_pme=nomsi" cmdline parameter.
> 
> To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
> from Root Ports when using iMSI-RX as MSI controller, which is indicated
> by has_msi_ctrl == true. This forces a fallback to INTx interrupts,

But "has_msi_ctrl == false" does not necessarily mean it's using an
external MSI controller, does it? It could just mean that there's some
per-SoC customization needed via the .msi_init() hook.

In practice, that's only pci-keystone.c though, and it's not really
clear if that's some modified version of iMSI-RX, or something else
entirely. At any rate, I suppose it's best to only tweak the things we
know about -- unmodified DWC iMSI-RX support.

> eliminating the need for manual kernel command line workarounds.
> 
> With this behavior:
> - Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
>   components.
> - Platforms without ITS/MBI support fall back to INTx for Root Ports and
>   use iMSI-RX for other PCI devices.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +	/*
> +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
> +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
> +	 * interrupt handling.
> +	 */

Personally, I'd suggest including more of the "why?" in this comment, as
the "why?" is pretty perplexing to an uninitiated reader.

Maybe:

	/*
	 * The iMSI-RX module does not support MSI or MSI-X generated by
	 * the root port. If iMSI-RX is used as the MSI controller,
	 * remove the MSI and MSI-X capabilities to fall back to INTx
	 * instead.
	 */

> +	if (pp->has_msi_ctrl) {
> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);

Removing the capability structure is a neat idea. I had prototyped
solving this problem by adding a new PCI_MSI_FLAGS_* quirk, but that was
a lot more invasive. I like this idea instead!

This looks good to me, although maybe the comment could be updated. Feel
free to carry my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I'd also note, not all devices currently actually define their INTx
interrupts (such as ... my current test devices :( ), and so
pcie_init_service_irqs() / portdrv.c may fail entirely, since it can't
really provide any services if there are no IRQs for those services.
That does have at least one bad side effect: that the port won't be
configured for runtime PM and won't ever enter D3.

I wonder if we should allow pcie_port_device_register() to succeed even
if it ends up with an empty 'capabilities' / no services.

Brian

> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> 
> -- 
> 2.34.1
> 
> 

