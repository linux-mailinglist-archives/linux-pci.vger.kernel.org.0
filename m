Return-Path: <linux-pci+bounces-28837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F1ACC085
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6679D7A3388
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4F268685;
	Tue,  3 Jun 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JulYCSmX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D48267F64
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933571; cv=none; b=mvErAbbwpVnUNb+7JO2FvQk6AQF4dxIZrlC30hSGsNaqbO4waS0yzdEVargLYOgMFHwdyP/B5YrFRtNNqPY4kopgfEp1aew5EFEbaWlJbIla38ZOTM7iF2SPcOikEqscw1eiwaEDBoOA5PcIi8AW9uJTqstR0fTfyzU0eP1elb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933571; c=relaxed/simple;
	bh=a2Xhzzi3QY9KeC6g0mvy+JMY/3ewUcjrru9xzEIQsXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLIVTkoS2UUBdxPAbs7+9D2x4a/4HfJBGrgvMCvENOy9kU1brPsZHG58NJdY+1I4/CdxPJFd5GlBlSCkr8NwDQWEukJfV6vzMnmJMJP1WU6Rxx/V2TnwUem7KqZrCL5r8svGs3CGsbdREFsBoz/hCT4y6yUlsGcNIJM9ZMJZ/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JulYCSmX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2d46760950so5044881a12.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2025 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748933569; x=1749538369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wxJyD1Wr6giGGGMhwdcwxe8wm378R6kiZUi+LdBaw9U=;
        b=JulYCSmXmnzIfSHXAWo8n6FCZuy+TYeBCvu5wclg24pD7lmI5rGOCqifUTR3mN2UMJ
         7d4qLPY+wMnhZnhTRmHQgWJUshuPEt0ggjxFDzMjtjjusJYzA3qcWX42PTFD0oPhW4LX
         EAeZX8YZt40tip6eo4RAbmNM4mzRPlxo10uN6XqpL7Fjmg5ee3Skkvp1d/p73n8/9rNh
         7PM+3bVu4ay4eK3pXw2btIqkKLV+M1B9g8JYWTVm3iD8a9MoMdeMu2IZYKJ8VOnrwfv/
         vWbEIFTqiKjHefFZkW6qgq+Tb5y2flIkxKfZiHBgdmANicfAGDt5goPPDUXQQnEn41Ke
         ndHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748933569; x=1749538369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxJyD1Wr6giGGGMhwdcwxe8wm378R6kiZUi+LdBaw9U=;
        b=EDpe+B6xia2DyI92QFPuVCS2bBpCQ1lq6C1Ebf36H1/ZWuo0RSWr2B0POyLnp7SEtT
         AVA6kw/19pvmLxvetDkYIJENU1fkiX1LSb7KtR/hWYVowd1cVB5TD047xNKWImK+m4Np
         qy8ZsTXMzHZoOFhq2sy6bAuvI5bfzuiDXH6FkSxK2+giWud2FpwghLIME7TTxW4iEaK8
         undL/VpAUOvKF5jXQ7G8Uj3GHs+RRSTZH7BM7axgPsDt1gyyzLKLkdOWmv8vozQz1+rA
         TCYuFyE3pxUHNaeaTZwBnUpYAEmFfPHKapzMx+1o5V0Gz54r0a5KXKJVzNP7VeCyk4td
         12vw==
X-Forwarded-Encrypted: i=1; AJvYcCWsI9TNMCyr3no/r6GZ3DDY5J38nc9sG2/WiAI5aMxQ1Xu+vjTw0FqGAm/nu17/xxaNqewVomiRT5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzonQEP/qR6J28/L/jOPRLQeU+zYVv2ePsLxhinPo06TwOQRuIM
	ww+ZFFpwxfLJqVRHEJtxv5+4yndh9dffTDq3xZRmK6zUvO+vyguBSWJPguij8ouLOQ==
X-Gm-Gg: ASbGncsBukNjhJVklJIiRlvh0pV8H1qu27UQyxUDzeSb4Z21oHBsvLpu5qlFcBJ/MSU
	C0LHbu8RGR5nHeAuEwo1eeKKbAwXXLDESqhXUKvkqBP3xuC7UNGv2mSTmsb3PBUxw+P8TH3LAGE
	YMhIieaBAM8l75PhGTicUEVbgzcPgImJ2/iQDEbE12dKAwPdU3aSEqq23pQS9ROTkZieCZGLFcz
	qrbSdW545JiWfs2albU5fDN/wR7QJD70AUiuaVQ73KAbVK7Nb/jeoZmfXNvct+d0AKguZXsBBiG
	wRb+0RjqSQBcWw8rg77HK9QzUDlUBvs64Pn9H8IaHmMQ59Sui4LhXJ+oMh/y1gJG
X-Google-Smtp-Source: AGHT+IHYXjOCnfjKFDJMsvXQhP7ZQM81wMsQjlNn1UPAKq3ILM9rjBY85bZGaOI3BGHiLdo5YQgppg==
X-Received: by 2002:a17:90b:5790:b0:311:c1ec:7d11 with SMTP id 98e67ed59e1d1-3127c73d3c9mr19065135a91.18.1748933568932;
        Mon, 02 Jun 2025 23:52:48 -0700 (PDT)
Received: from thinkpad ([220.158.156.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e30cb3bsm6616776a91.38.2025.06.02.23.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 23:52:48 -0700 (PDT)
Date: Tue, 3 Jun 2025 12:22:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
Message-ID: <pb7rsvlslvyqlheyhwwjgje6iiolgkj6cqfsi6jmvetritc7lr@jxndd5rfzbfy>
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
 <r4mtndc6tww6eqfumensnsrnk6j6dw5nljgmiz2azzg2evuoy6@hog3twb22euq>
 <0e1d8b8e-9dd3-a377-d7e0-93ec77cf397f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e1d8b8e-9dd3-a377-d7e0-93ec77cf397f@oss.qualcomm.com>

On Tue, Jun 03, 2025 at 12:03:01PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/1/2025 12:35 PM, Manivannan Sadhasivam wrote:
> > On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
> > > There are many places we agreed to move the wake and perst gpio's
> > > and phy etc to the pcie root port node instead of bridge node[1].
> > 
> > Same comment as binding patch applies here.
> > 
> > > 
> > > So move the phy, phy-names, wake-gpio's in the root port.
> > 
> > You are not moving any 'wake-gpios' property.
> > 
> ack I will remove it.
> > > There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> > > start using that property instead of perst-gpio.
> > > 
> > > [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
> > >   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
> > >   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
> > >   arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
> > >   4 files changed, 14 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..3dd58986ad5da0f898537a51715bb5d0fecbe100 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -709,8 +709,11 @@ &mdss_edp_phy {
> > >   	status = "okay";
> > >   };
> > > +&pcie1_port0 {
> > > +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > +};
> > > +
> > >   &pcie1 {
> > > -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > >   	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
> > >   	pinctrl-names = "default";
> > 
> > What about the pinctrl properties? They should also be moved.
> > 
> pinctrl can still reside in the host bridge node, which has
> all the gpio's for all the root ports. If we move them to the
> root ports we need to explicitly apply pinctrl settings as these
> not tied with the driver yet.
> 

If the DT node is associated with a device, then the driver core should bind the
pinctrl pins and configure them. Is that not happening here?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

