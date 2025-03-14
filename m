Return-Path: <linux-pci+bounces-23737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FEA6106F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1154A3A045D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076E1FAC3B;
	Fri, 14 Mar 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2FFrBh4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FA6EB7D
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953140; cv=none; b=Z16exYs9x+qyUSj6dbPnGTWeIG125xbkbbBTbPGvq4+Tk605MfuSHetRnfKecJVQtU1vjsnI/rErl70vFh2F2S+FGFDhZLQejeRS3HFzZT6cx+k2Vudo94nZQNUXHnC5xhfONBJmu/PglOiRTNlu8xfP2Mev7ThOQriyzYveD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953140; c=relaxed/simple;
	bh=2JTMMazCKfTFOAdapQG9XiQQAcCAcmo0E9k4zEEKWlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti2xc5f1j4HNjwjcxQVUQtrLOlsXkPv7UBGFon1rNLBGrxXp+u4OlbO55ldkydxr+U6N9hgOWGtzjOM7nXKpTDD26wudo1+iJLlnC/jE+emCvLOgUsF+1YS+5lZzrauWnpupmgGUOko/KB/FphKOyUsb0cqXV4uYu/e10QcDyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2FFrBh4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2243803b776so56571345ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741953138; x=1742557938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q3k7fvz1tmhIjGgQ1ycjom2LPIMfNTsp0uqFM8k2kiw=;
        b=k2FFrBh4UJytmad73Y/VeYyGeUuygqFx1nXen0+3JVmmstg5JzlUiR7CPJ3T5+WEHr
         Si3vtSx2NyR8MpV63TdKov40i8dAWs7sA+0VtNFn6dTd67H9qcMSaFdGl0vorBSU/Itx
         uJumm/2s9oYMgpopfubTWpDXonO7YTthrqBPDNX6sMPaW3CE1BFSSpBI1YdpTD2/Szyf
         ZegKpxdpPb5Hf062gRLHtS0bdfDT3sTQxnSKkBmHtkVPCr0iBSqpCpSQJxaPLqltHheS
         3K34qhRFHdwqHg+yre5WHE5ocb5XOgub3YiOMqgVxgA8woZU/NbNlcexXhEdP/cbgjvn
         I0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741953138; x=1742557938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3k7fvz1tmhIjGgQ1ycjom2LPIMfNTsp0uqFM8k2kiw=;
        b=QaeGIb+892M1WgelaQ/PpJ43Lo7BoNrwVlaTLVS3XEeLxB6B2LAVC0Yj3FoQu2K0EJ
         jfMZHZe/RuhXT3yV3gMMXcoZQtdRq1J6u1+OBeSX//4TWFP2GhV6/pr/XYEslfjFos+l
         nDE3d9nY8h1bv5EZmUrzNfIyoWcLepzAJQa5XyrOJltnOhq4kyH3QR4A4OK4v0wSSeXg
         ceTFnPLfoToccZ60oXLYnMCTGjSJvPSWjDpn2lZ1lkHMwC9cU5k3kieGjpRZimZpdCX4
         FQHTWuqtKRH2wRb/jAGqbHoE4/e7i/usd/qTYHj2Vkss/E/ChBrrXgKrXHH0CpWzLElT
         rHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVrjPTEgri8E/+mHEz5RoWSaOZXOxpYQtEqk+opwDqBOezRRT70n1YuRp5JmamlV/dlZ8OKvYzSqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeulPR0oM2KUoq4Cd6LbOOtVq7GmN/P6dF/CAXGweOyYfTzI0v
	aInSIWZmNCmo8nQLiIdV89jGvSfmToT6ue737LlM7KxdayqerhpiyJXTXd6RRg==
X-Gm-Gg: ASbGncsdv/6KXSX+h7Hhzrgu/iP6z8YbAR+J7Sx6Eswv01TlYEvpo3UJUV/VdOpY8fY
	VJ6wbyjDXRMCxwEKCXXg4Bx8PHINKHAWlewKojyH0xd4e0UGadK0EoRNOxTwP6vYsiPW9caCEmm
	5C3kL5M7k7q74eLxB6XQRKic5o09axW6Q6iBs/pVC5CPLfJQSTQiXCu/KO4TJFMrnkb5+msetLC
	vFoGEr66xBFe/dZUCRmRoGmRkoYUp5YvEX9hzvv54GMRzIVG0jgWbzvqNNKgAE0F8pgbX635C3I
	7d5IeOumCh4VxAK3K/HpVjGGYC/3It7CCziqxane+RrVLRCq7zySiQ8Y
X-Google-Smtp-Source: AGHT+IG5j5a+pzEwcsJNmm0hEeTrp2CuiBSxB3Ea66ul7lGwBGWPT/QsbfK1PDyEJKG9pn3UaFiZdQ==
X-Received: by 2002:a05:6a20:7f8d:b0:1f5:80a3:b008 with SMTP id adf61e73a8af0-1f5c13165c8mr3802766637.32.1741953137749;
        Fri, 14 Mar 2025 04:52:17 -0700 (PDT)
Received: from thinkpad ([120.56.195.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115295e5sm2751523b3a.23.2025.03.14.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:52:17 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:22:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/2] PCI: dw-rockchip: hide broken ATS cap in EP-mode
Message-ID: <20250314115212.ywlee4vyuxyq4x6s@thinkpad>
References: <20250310094826.842681-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310094826.842681-4-cassel@kernel.org>

On Mon, Mar 10, 2025 at 10:48:26AM +0100, Niklas Cassel wrote:
> Hello there,
> 
> Address Translation Services (ATS) is broken on rk3588 when running the
> PCIe controller in Endpoint Mode.
> 
> This causes IOTLB invalidation timeout errors on the host side when using
> and rk3588 in Endpoint Mode, and you are unable to run pci_endpoint_test.
> 
> Solve this by hiding the ATS capability.
> With this, we do not get any IOTLB invalidation timeouts, and we can run
> pci_endpoint_test successfully.
> 

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> 
> Changes since v2:
> -Added missing EXPORT_SYMBOL_GPL().
> 
> 
> Niklas Cassel (2):
>   PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
>   PCI: dw-rockchip: Hide broken ATS capability
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 39 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  7 ++++
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++
>  3 files changed, 73 insertions(+)
> 
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

