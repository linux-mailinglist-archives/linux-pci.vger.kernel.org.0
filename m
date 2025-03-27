Return-Path: <linux-pci+bounces-24876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53EA73A5C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88ED1897B68
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4AE214813;
	Thu, 27 Mar 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlOy3VtR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826301B424D
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096504; cv=none; b=BVATfrrYOcSmma85rpC31l/e+IzI3xpGviYhV2fqnI72uUpy1dkqMlyFoVTBhUtGAo1OuyhT7vrT7IHXwMI/WyHFgv92MCPA/LfEzitwCdX2T+zc1MR1XSVAO8NN6tut8fbMg4e/c9uDkEQVWvNXGJlhlWq2a4Rgz6+A9kzBJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096504; c=relaxed/simple;
	bh=Qu9BXW/WwRM5yK5XxhdUNBkjNGAO4qF8Uc7STA72aI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntZ/m1uitLNciprmr+OIF3kIovjWXvooQmoxTzPOWBqYOorkjieuP4z9BLXJVVR6DTgCFrSAsVaBtegKTDiamT2i/eKyxhGYhfsLXiBJUUKQ+6TB+Oa8EzBvx19ZrJK0HZkxSfHpKYl0nXOyNCdjHQaR0K9iQ38El0mNiQC0qTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlOy3VtR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso1510325a91.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743096502; x=1743701302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHz+SaPSWGp6wDaJlC8xVhuyDfBVETPMBB/j6NeLduE=;
        b=UlOy3VtRdiJBYBJLZfrqQIq+QLBvKwwUyappCBIhqq0SCzawfKZOPMLuHRZ/tTKEdW
         G452LwrWyLe9/QQM9tyFXoSh1JRAeIuwF8PKiaLmP1pJj5bi3jh1Fa+XKnS8gqlFKWEN
         Bu+n5KtTehKfrj1ShpgvOzB4mWrzGcexUNphZ09how6igLeXnJp6ZvR/eUCeJcH84xUu
         HPT0FMHxe9rT7SpHYXZFCoyYF80UNrusu9aWJN7m5xC8ZG5xkj2KTIaTI4dynZNhULk8
         LRwXgH+cfLupw0+TIZ+UcwDY9jgbnrmpySX+2y0+7fYggUN0FfhGRVfmoc5qrvNOcipW
         RAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743096502; x=1743701302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHz+SaPSWGp6wDaJlC8xVhuyDfBVETPMBB/j6NeLduE=;
        b=XUJvnHaccr7kX40nSEKtJ7Yh1ELt6wMpXGeApu0sx7rU3hKKQgmnYWT7TZu2VyKYs4
         kScPLVZPd8H0pPAaGdUb+vfeF1rgQXkrNAsWEwQed6rtPs586Za0otIg1HrJ26w6GwN3
         vrqxs6uQApzkF+GQZy2GC5x/196pBofFUL00ML0il4HHIh6upJ0wYxi+9dqdYLulIlTH
         VZp6s450RW5biwaHsnpSRGzLMWDN07Xro2S24PC9oRQ/zSKOurn+DOclHq3EoZCI02Kl
         z5NvgUnAT9r7AcfHUjuZhuwMTBXyn1uWwuz9AvnfjfK3Ud7A00J18yBwSnbf+Lvx8gVk
         afvg==
X-Forwarded-Encrypted: i=1; AJvYcCVnHhs9G/I+fC2ShdtexdnRDfuYUYfnmgKdg4lm2YMiba691pGqpJdPvToWBm5K9j18C8s55IzawmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM711toMUwnhUuPXktXlu74OpJMT1S5hSK0RDZOwDBibjQdQwL
	EQYfSb3G2bY/yxWN79FxHewoNvBd1e3mVFeOTSSZYu2WImoJK2j8lVwVN9fmNQ==
X-Gm-Gg: ASbGncvyBOGlQ8HXnOgM4vgxpaHvWxyY+SkIRqZ7PLMJOXv3WO0UfVrmt1UihJ2bMaW
	YMHDfJsrBa64Eg7zVM533YwlMi0854Bh+nC7+mAJy0roq+xwf8SGboqkLUjZQVSVjWRDhL8LnRB
	03joxWA+maxH31zZVb3DLKFbkzn28d620pbY8X81tMcwm+sdwVqDCTmT1UOCcwM1ifOoZ483EVz
	CMiaD59UGEYaa3Zgow2O5EzQoGtGXp5mbWeEIvyMkWlT9PuDkIxVaUTzBPPFPUye1fB98eADu7e
	Khypj22kbZKErr3+DMgu3IzFLiKoreFwX3ZDC5zSAhLufKiS7zrKC/0=
X-Google-Smtp-Source: AGHT+IGqtCOWQs3SNQd1ccGYnNeLv3HOIj7c/1mVjG4p0xNEN7WwDgh3wSqvsol2pDFN1HxLXEZyGA==
X-Received: by 2002:a17:90b:520a:b0:2fe:b470:dde4 with SMTP id 98e67ed59e1d1-303a7d6629emr8930210a91.12.1743096501527;
        Thu, 27 Mar 2025 10:28:21 -0700 (PDT)
Received: from thinkpad ([120.60.71.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3e132sm172524a91.4.2025.03.27.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:28:21 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:58:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: george.moussalem@outlook.com, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nitheesh Sekar <quic_nsekar@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	20250317100029.881286-2-quic_varada@quicinc.com, Sricharan R <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <vgohpbmbhghooeb6byur2wx535sa7tdmtsu5orgzr26hnaw2yg@aibeo3gqiztn>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
 <a4n3w62bg6x2iux4z7enu3po56hr5pcavjfmvtzdcwv2w4ptrr@ssvfdrltfg5y>
 <6fa2bd30-762b-4a3a-b94f-8798c027764a@quicinc.com>
 <ycv74l5nop5mptj6uobuacffnwho2gvznh4dhxagupt5gh6x4k@vgik7ouydy6f>
 <988510be-ee5f-49c9-a5a4-074c51245f95@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <988510be-ee5f-49c9-a5a4-074c51245f95@quicinc.com>

On Wed, Mar 26, 2025 at 01:11:35PM +0530, Praveenkumar I wrote:
> 
> 
> On 3/25/2025 10:23 PM, Manivannan Sadhasivam wrote:
> > On Mon, Mar 24, 2025 at 04:48:34PM +0530, Praveenkumar I wrote:
> > > 
> > > On 3/24/2025 1:26 PM, Manivannan Sadhasivam wrote:
> > > > On Fri, Mar 21, 2025 at 04:14:43PM +0400, George Moussalem via B4 Relay wrote:
> > > > > From: Nitheesh Sekar<quic_nsekar@quicinc.com>
> > > > > 
> > > > > Add phy and controller nodes for a 2-lane Gen2 and
> > > > Controller is Gen 3 capable but you are limiting it to Gen 2.
> > > > 
> > > > > a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> > > > > one global interrupt.
> > > > > 
> > > > > Signed-off-by: Nitheesh Sekar<quic_nsekar@quicinc.com>
> > > > > Signed-off-by: Sricharan R<quic_srichara@quicinc.com>
> > > > > Signed-off-by: George Moussalem<george.moussalem@outlook.com>
> > > > One comment below. With that addressed,
> > > > 
> > > > Reviewed-by: Manivannan Sadhasivam<manivannan.sadhasivam@linaro.org>
> > > > 
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/ipq5018.dtsi | 234 +++++++++++++++++++++++++++++++++-
> > > > >    1 file changed, 232 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > > > index 8914f2ef0bc4..d08034b57e80 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > > > @@ -147,6 +147,40 @@ usbphy0: phy@5b000 {
> > > > >    			status = "disabled";
> > > > >    		};
> > > > > +		pcie1_phy: phy@7e000{
> > > > > +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
> > > > > +			reg = <0x0007e000 0x800>;
> > > > > +
> > > > > +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> > > > > +
> > > > > +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> > > > > +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> > > > > +
> > > > > +			#clock-cells = <0>;
> > > > > +			#phy-cells = <0>;
> > > > > +
> > > > > +			num-lanes = <1>;
> > > > > +
> > > > > +			status = "disabled";
> > > > > +		};
> > > > > +
> > > > > +		pcie0_phy: phy@86000{
> > > > > +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
> > > > > +			reg = <0x00086000 0x800>;
> > > > > +
> > > > > +			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> > > > > +
> > > > > +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> > > > > +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> > > > > +
> > > > > +			#clock-cells = <0>;
> > > > > +			#phy-cells = <0>;
> > > > > +
> > > > > +			num-lanes = <2>;
> > > > > +
> > > > > +			status = "disabled";
> > > > > +		};
> > > > > +
> > > > >    		tlmm: pinctrl@1000000 {
> > > > >    			compatible = "qcom,ipq5018-tlmm";
> > > > >    			reg = <0x01000000 0x300000>;
> > > > > @@ -170,8 +204,8 @@ gcc: clock-controller@1800000 {
> > > > >    			reg = <0x01800000 0x80000>;
> > > > >    			clocks = <&xo_board_clk>,
> > > > >    				 <&sleep_clk>,
> > > > > -				 <0>,
> > > > > -				 <0>,
> > > > > +				 <&pcie0_phy>,
> > > > > +				 <&pcie1_phy>,
> > > > >    				 <0>,
> > > > >    				 <0>,
> > > > >    				 <0>,
> > > > > @@ -387,6 +421,202 @@ frame@b128000 {
> > > > >    				status = "disabled";
> > > > >    			};
> > > > >    		};
> > > > > +
> > > > > +		pcie1: pcie@80000000 {
> > > > > +			compatible = "qcom,pcie-ipq5018";
> > > > > +			reg = <0x80000000 0xf1d>,
> > > > > +			      <0x80000f20 0xa8>,
> > > > > +			      <0x80001000 0x1000>,
> > > > > +			      <0x00078000 0x3000>,
> > > > > +			      <0x80100000 0x1000>,
> > > > > +			      <0x0007b000 0x1000>;
> > > > > +			reg-names = "dbi",
> > > > > +				    "elbi",
> > > > > +				    "atu",
> > > > > +				    "parf",
> > > > > +				    "config",
> > > > > +				    "mhi";
> > > > > +			device_type = "pci";
> > > > > +			linux,pci-domain = <0>;
> > > > > +			bus-range = <0x00 0xff>;
> > > > > +			num-lanes = <1>;
> > > > > +			max-link-speed = <2>;
> > > > This still needs some justification. If Qcom folks didn't reply, atleast move
> > > > this to board dts with a comment saying that the link is not coming up with
> > > > Gen3.
> > > > 
> > > > - Mani
> > > The IPQ5018 PCIe controller can support Gen3, but the PCIe phy is limited
> > > Gen2 and does not supported Gen3.
> > Hmm, so if a Gen 3 capable device is connected, the link will not work at Gen 2?
> > It seems so from the error that George shared previously.
> No, that is not the case. The link will work with a Gen3 capable device at
> Gen2 speed. The failure log shared by George indicates a PHY failure, which
> is due to IPQ5018 PHY's hardware limitation.

It doesn't matter. If a Gen 3 device is not going to work with the controller +
phy combo, then it is a host hardware limitation. But I'm OK with adding a
comment and limiting the controller link speed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

