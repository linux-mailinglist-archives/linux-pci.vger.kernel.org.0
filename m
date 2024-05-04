Return-Path: <linux-pci+bounces-7087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ADA8BBD70
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D241C20D2E
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501225C613;
	Sat,  4 May 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNfFsUoC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169786A34F
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714843265; cv=none; b=K+0//icrBHGpVXN1VG7Uf06SXjyT/R17vSoGF3uccPYBs/d0nKcRfb2K8eNlyyH0Mwkxtcbmaxi03CAqIos2JCRiONs8lpr3DDqaIGLCPGIc+2I03QVLZuYrKpYIAW7JCiP9a7u86UNMMH4Hl5rLUnFqaSwtyGWczYpIXuQI/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714843265; c=relaxed/simple;
	bh=WEzD/Jv9LH/qgyBt7ggSJY1ZRBFRdqqvx9MwD/29YuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir7VsMYTeAdsTwcXV3b8gd+r2E4pmjN/1ZlC8/DXkd5o6/c04vTjkRgyJg5ErdBXDuZ2YlHf/DGtGJPPG2X38ljF3hZBNEN2Q8Y5EvHEgjsOS3jCEBxynJlT7f7AcMmtBjYhlSw6NkWojVztcK1PItYj01Uga9qNzIKyFtj8jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gNfFsUoC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec41d82b8bso6249375ad.2
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714843262; x=1715448062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9laX2V+CVuA7h00Ylv6RDCBuojEdnvBgJODYE51PhlU=;
        b=gNfFsUoCY6bX9KWXMGjujhC//1zRH/H3u3zzyPunLI2YaslwxmvZIErtDNXa1dxefM
         wXx0g/KizwQQ5GKYCeY7PQ7Q/cJ/UA1tKJoKWq5UqbNHkMNHBMkKhL22VbfuP1xPq+6r
         IDVbtFGB9X59iMLNWSHWah1tqLOFi+PHN/7EWbkJq6ChMfo79S7+UfZvSpmNdu4Uudxk
         rbHeu86Hn1UID7BZ1h6y4xOqV2lHE9s7GeL7Dp7V3XwkSbOvOn/ZCaK1O/8CXFeMqa9R
         LKSvBNvre/jXJ67ErIyw+SE+XLmh4FoIV7jVrh/fctnp3m2dafRstjxe8Llf6w1oDCZL
         sp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714843262; x=1715448062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9laX2V+CVuA7h00Ylv6RDCBuojEdnvBgJODYE51PhlU=;
        b=g4RZY2yZOgmM1Zpv2CGlV1N/OjjHzcmHRu4JTl6Aao0IgLpgeAiaFZKNz+d+zSiwMZ
         eIJfykQGqNsLjyABumpnSVkBp4ySsNJe5gKYZA8OfZKRztuuBVDPm2aIM8f80+c8UsIR
         S5prUggvQubClfY4LfTB2waogTJMghFOxw2CKHRsx5DAqdfMkkC28XLZ6xk38YO8gyGq
         HaENGq8LE4cqkbzHCFWaebcirHFZ4VpURW6ur2xfmuhVAmcBXPY7gCwekl0P5DWhHiyh
         /VRZM6E9QLFDkiRPvoH/uDc2f8sVpTfk8Hpz84zRtG2FwhGoWZQPwhuy1sGtRN36qhna
         EL8A==
X-Forwarded-Encrypted: i=1; AJvYcCXLcTNiXZw+8uBVBkYV5QNjle2yo1c9nFutGNtH1Ryk93Oj76jKKRXXI33y/H77m0m8Vw48FNC8T3vDfoAkf+uPrdbZ+WV0/kCF
X-Gm-Message-State: AOJu0YxhlbYL0kyEUshyflh1JCTBoDHqPFaC8H7O2LWfjCsTUp/IN0Zh
	2oyle0BoMD0UA40ekpkWp5BjdhlEdX2vw7uCsxIT1bZb6kglvgajgp2APfgpkg==
X-Google-Smtp-Source: AGHT+IFyjaSOMKjB8qp6aX4zhqJKBtMXCWvr3PoileGxES65eHv6nsequF71TgXi/KdDGzd92JvURA==
X-Received: by 2002:a17:902:d2c6:b0:1eb:b50e:3577 with SMTP id n6-20020a170902d2c600b001ebb50e3577mr7317773plc.56.1714843262260;
        Sat, 04 May 2024 10:21:02 -0700 (PDT)
Received: from thinkpad ([220.158.156.237])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902780900b001ea90148816sm5356597pll.253.2024.05.04.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:21:01 -0700 (PDT)
Date: Sat, 4 May 2024 22:50:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 10/14] PCI: dw-rockchip: Add explicit
 rockchip,rk3588-pcie compatible
Message-ID: <20240504172054.GG4315@thinkpad>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-10-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-10-a0f5ee2a77b6@kernel.org>

On Tue, Apr 30, 2024 at 02:01:07PM +0200, Niklas Cassel wrote:
> The rockchip-dw-pcie.yaml device tree binding already defines
> rockchip,rk3588-pcie as a supported compatible string.
> 
> Add an explicit rockchip,rk3588-pcie entry to make it easier to find the
> driver that implements this compatible string.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index f985539fb00a..f38d267e4e64 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -400,6 +400,10 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
>  		.compatible = "rockchip,rk3568-pcie",
>  		.data = &rockchip_pcie_rc_of_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3588-pcie",
> +		.data = &rockchip_pcie_rc_of_data,

This is not required. In fact, it is encouraged to just use fallback compatible
in DT and not add new entries in driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

