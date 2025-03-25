Return-Path: <linux-pci+bounces-24688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E8A70775
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 17:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7663A72F0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B525F7B2;
	Tue, 25 Mar 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDMqUQSp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9525332E
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921601; cv=none; b=eRqpl71YhtcqQX95bgr2WH4V3auByodP4Z1GEa7+2Z40143YHer9VVOZjSwVDN2Zp0S7R3cZyJZJUdt6+s9QPooI2SiyJl/enDxYA9MSV+a/IxX7+jOYV6sccPxphLISGmWG+9Y2/nQWpkBHD/RGXUbdrolMGlYRzo9vw3O8/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921601; c=relaxed/simple;
	bh=hrscfi/ZD9RvG2QzoVS3y13ZwZsl/TSjrSnTmcB0MJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrD69Cfg4eDINiEWR4tBkC/93fpBYFro9xnmk6cF27mDmulGEDKb5zllF6L/pkjLmbs1Q86+dsDuog8y21nY6mz/PgF+S6+lOLkulyiGma48atfSenyd2trvFawmX+UHFKeIox7mW2YgciNBGU4lxT67w8ScuvgkXz7zcfJ48dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDMqUQSp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso120891185ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742921598; x=1743526398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5L9ZiZQAjB02Svt4Qm10JSTX6pFY5X9IvVK51QfXpvc=;
        b=nDMqUQSpqbcDSUT9SnxNOPxIdm6kapAuQhQ/X5K+TlsJ+AsHOtayWKo2q9UYXi2OkB
         WrTmXMwXIpMuGage6hzq4Rda5mVpldQMr1dzmai8EJH+GbO3mby25kxBseyA5C4WE9+6
         vzG8/eKaMHGJrhlyzv8voZ4fDViCZNAXZqTD4uO+kZPEU1OjHxjPBw9AGQvyQG4PqfHq
         80cwL9i1QU2BHvbO9Gj5U40vTFfmHiN8BVdAcPt4kyEggUvylkZdE0QBU9K5q9Z90LnF
         6IgBFZjWpj3U0z/U73wYtBE7c557Qbip86rENTDuMrX0B8I2fGoYvfyRm/jWUC6Tc+zE
         VLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921598; x=1743526398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L9ZiZQAjB02Svt4Qm10JSTX6pFY5X9IvVK51QfXpvc=;
        b=hzEnaGrJhmhy8ai13srAZ1B9i5nYP9dnRsRfKXzwY+NSQcSkXop1v1RVmanxeQt18J
         ePGnFCMh8+l2+QrLD4L4AaozSAOXijT4rLHNN9PD/Vkp+4ByTEO44vr9gzqqjoeTYC5Z
         wX+bX6QInSn29FsIDNHH0OiNL0A1wARVOgNVM8+s87hxRO6ZwuR7B9NoBFFsQ4OQRV5r
         4BEVznW4/GySU4Xb1fpCISrjBgywyNl7pDwn6GVLKFO1Zk0/fbU8a/qUP8Osvv2b4O7k
         cq6Xx0/MvpdxzZpDU0cSgMxbGB0TX9WRpF7YIAuaSHqUI5BHY1YOzdNFJB12O0Uq2vAr
         /J3A==
X-Forwarded-Encrypted: i=1; AJvYcCX9zWwnaj/f+gF5m71jnB13XAopq06rXObjdJUCcJ+bdzpjWVTPPlqCbRUSmRKi/BMQ35jdWAQUCM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gyXa4Hr2TvYCWHRZNtqVLWAlH64oacj6MfR7/8SX8jg1w81p
	DG2ZjvxrPo5fJwZnVwSkJI+grzLs2l+7kpjX0nDdcOKTxxFyqXsg64OGL3CM/A==
X-Gm-Gg: ASbGncvwnHc9jWnvpyTu9xxNyQ4nhvWexU8MWHC3rKT+PvSxOmmazu5s+SztC96+whm
	2Hr3yTZLtEq1HlCb2xCFiFTpEJUwyl5j6WXLMVvk9UUm/VueQy/IGulr1wQBcLgwPU3sMExaAEq
	ACPHeMVaDyQ9RaJZAGxj7hdac3gdSf3qZO9K/PLY3S3PHUg5JOrdC5KsmToejhesNZNEcatQn+F
	2i6KRjx3U/O+pgqd9W059/6HXXX10+DqhgB5FraVhjTqeXBWXSfc/QS1/SBlNizT80aqTx2t72y
	TEdP0YDYkU8aFQ11SE6kRcmbdwQUDZEb8bAQbgjFxRV4mv4lJPOqAOjY
X-Google-Smtp-Source: AGHT+IE9jFkoNlNzUIhIhtPYr1hz43laKNyex5k4hiZRJylP0309zHaG4irN98J58MRDRzo0Phd2MA==
X-Received: by 2002:a05:6a00:84d:b0:736:a540:c9b5 with SMTP id d2e1a72fcca58-73905a2763bmr24061167b3a.22.1742921598338;
        Tue, 25 Mar 2025 09:53:18 -0700 (PDT)
Received: from thinkpad ([120.60.136.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a28059e8sm9333330a12.20.2025.03.25.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:53:17 -0700 (PDT)
Date: Tue, 25 Mar 2025 22:23:10 +0530
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
Message-ID: <ycv74l5nop5mptj6uobuacffnwho2gvznh4dhxagupt5gh6x4k@vgik7ouydy6f>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
 <a4n3w62bg6x2iux4z7enu3po56hr5pcavjfmvtzdcwv2w4ptrr@ssvfdrltfg5y>
 <6fa2bd30-762b-4a3a-b94f-8798c027764a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fa2bd30-762b-4a3a-b94f-8798c027764a@quicinc.com>

On Mon, Mar 24, 2025 at 04:48:34PM +0530, Praveenkumar I wrote:
> 
> 
> On 3/24/2025 1:26 PM, Manivannan Sadhasivam wrote:
> > On Fri, Mar 21, 2025 at 04:14:43PM +0400, George Moussalem via B4 Relay wrote:
> > > From: Nitheesh Sekar<quic_nsekar@quicinc.com>
> > > 
> > > Add phy and controller nodes for a 2-lane Gen2 and
> > Controller is Gen 3 capable but you are limiting it to Gen 2.
> > 
> > > a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> > > one global interrupt.
> > > 
> > > Signed-off-by: Nitheesh Sekar<quic_nsekar@quicinc.com>
> > > Signed-off-by: Sricharan R<quic_srichara@quicinc.com>
> > > Signed-off-by: George Moussalem<george.moussalem@outlook.com>
> > One comment below. With that addressed,
> > 
> > Reviewed-by: Manivannan Sadhasivam<manivannan.sadhasivam@linaro.org>
> > 
> > > ---
> > >   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 234 +++++++++++++++++++++++++++++++++-
> > >   1 file changed, 232 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > index 8914f2ef0bc4..d08034b57e80 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > @@ -147,6 +147,40 @@ usbphy0: phy@5b000 {
> > >   			status = "disabled";
> > >   		};
> > > +		pcie1_phy: phy@7e000{
> > > +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
> > > +			reg = <0x0007e000 0x800>;
> > > +
> > > +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> > > +
> > > +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> > > +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> > > +
> > > +			#clock-cells = <0>;
> > > +			#phy-cells = <0>;
> > > +
> > > +			num-lanes = <1>;
> > > +
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		pcie0_phy: phy@86000{
> > > +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
> > > +			reg = <0x00086000 0x800>;
> > > +
> > > +			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> > > +
> > > +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> > > +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> > > +
> > > +			#clock-cells = <0>;
> > > +			#phy-cells = <0>;
> > > +
> > > +			num-lanes = <2>;
> > > +
> > > +			status = "disabled";
> > > +		};
> > > +
> > >   		tlmm: pinctrl@1000000 {
> > >   			compatible = "qcom,ipq5018-tlmm";
> > >   			reg = <0x01000000 0x300000>;
> > > @@ -170,8 +204,8 @@ gcc: clock-controller@1800000 {
> > >   			reg = <0x01800000 0x80000>;
> > >   			clocks = <&xo_board_clk>,
> > >   				 <&sleep_clk>,
> > > -				 <0>,
> > > -				 <0>,
> > > +				 <&pcie0_phy>,
> > > +				 <&pcie1_phy>,
> > >   				 <0>,
> > >   				 <0>,
> > >   				 <0>,
> > > @@ -387,6 +421,202 @@ frame@b128000 {
> > >   				status = "disabled";
> > >   			};
> > >   		};
> > > +
> > > +		pcie1: pcie@80000000 {
> > > +			compatible = "qcom,pcie-ipq5018";
> > > +			reg = <0x80000000 0xf1d>,
> > > +			      <0x80000f20 0xa8>,
> > > +			      <0x80001000 0x1000>,
> > > +			      <0x00078000 0x3000>,
> > > +			      <0x80100000 0x1000>,
> > > +			      <0x0007b000 0x1000>;
> > > +			reg-names = "dbi",
> > > +				    "elbi",
> > > +				    "atu",
> > > +				    "parf",
> > > +				    "config",
> > > +				    "mhi";
> > > +			device_type = "pci";
> > > +			linux,pci-domain = <0>;
> > > +			bus-range = <0x00 0xff>;
> > > +			num-lanes = <1>;
> > > +			max-link-speed = <2>;
> > This still needs some justification. If Qcom folks didn't reply, atleast move
> > this to board dts with a comment saying that the link is not coming up with
> > Gen3.
> > 
> > - Mani
> The IPQ5018 PCIe controller can support Gen3, but the PCIe phy is limited
> Gen2 and does not supported Gen3.

Hmm, so if a Gen 3 capable device is connected, the link will not work at Gen 2?
It seems so from the error that George shared previously.

> Hence, it is restricted using the DTSI property.
> 

Ok. George, please add a comment for the property stating the reason.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

