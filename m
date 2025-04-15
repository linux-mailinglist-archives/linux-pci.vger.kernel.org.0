Return-Path: <linux-pci+bounces-25913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41029A8955A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA4518987B0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921224CEE4;
	Tue, 15 Apr 2025 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ON63hOS+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F823F410
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702905; cv=none; b=O6Xr14qGpbhyy4dKjbp5bGQkdpeMuRtimIAvoOV2HkKENIl3f4iVnxvSjVq70/3KlGeKdB9eqL4RHYLMy9qcwI2/aFQDGOKrFNVpq2vvhzuCR5N3XegdFYlKUfcg1ndvEWziB0moPLYZGQHzgZYEq3Fx+9xwmMbxCFExKSd1TU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702905; c=relaxed/simple;
	bh=YL5QJ110xB5bIstZFqLfAhe6+k8X5YNSR1kmNf8Sb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tuv8zx8hznDhXiK+VJTfKv1b7nqk7DTQfoO+0i/R0MZzqBMg4OnCTzkeriEM7SM334p4NQBiGWxQWewtiODgyOJK0aJsXMynvR6s5M8U2o0iaAs/joZqHBM4QYix+++P5wqBWjdNZa2Pu7OYgWy5Q5W3CDJuV4Y6Xh0IZ+muq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ON63hOS+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301302a328bso5102167a91.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744702903; x=1745307703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OAto5TMsyfm0PnIWFCrMK2YomypnAVk8abWD+aRoNLw=;
        b=ON63hOS+eyH/EAiaIay06G0QAqs1s7XB2LSLl146SotkR8kx2/1kiPqpSTDQ09O+HD
         31UsPWK5kFrGN9oDrf1vGOp9jLCmBS8Xlw8oNXEhN359r1SPKnR/zdyD9cbf+PTGBx3h
         y+B/VGkjmEXPxvtxIBscNff90XFueT7F9VFXA6Qli+tO02nGPkWCMg0JAgXG4dSGd6Fq
         3mOKt0a/D9yi4roHx3gyVkIdycl1TQGdfMSOX0oQMcaguRITDi8+uzh+9zdHJqfXfsiD
         98vRuRt2gF6JtToY+iTer4r0tdEKeYeu3E7H9RZ53jeWyd6rhAfUlEMkA6t0KsIyMHfY
         kFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702903; x=1745307703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAto5TMsyfm0PnIWFCrMK2YomypnAVk8abWD+aRoNLw=;
        b=KdhKH+fjAmrQ3OBUPA42u/suPN14JTeaXswSmxsutwNmMddxRghg80QY9tc1I1LHPC
         UrWzFxS4fmKUegvdkH11ob6EGOG0jIxe4jf8BwjbrI8/DBnoQB4qqp4mR46QtE/+INeG
         U7/LnM/mXOK779SuoNVCLsKrOmuMr4uKgdmnJ3wwc92upNSW3iM5M3iNRdveJlw94O7l
         AtfvhG+PubL55CpQIIBcWWr8AVKekQt4bvb+VOGrQs7mSj+Vdlnq3V2RVdZ+zjzr0hEQ
         0OUUSL3/5oP9YfxAOUkF2bn091AhaZ72tikQYwzfoGOHe4YXWNzOnEO/dB70GbuHhOBv
         rs4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCwxPz6Yar6TiBznQgkXNAtt2weOKkiLI0aU6xiZWoFtpXCsQEcaeZvmIFKMhE4Ny4y0wZzIwX/VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IbLcyuzhGVt1RvBnfqPRfY/nSOmBPfyfzDQMf8BAx44x32IO
	G2iLYyUttiQfqU23A5r5K7O4AhO7UcCM0SUDWa0oZ2kUQK+xljDSxnTi4oivl88EUe4AQ2H19E6
	6GQ==
X-Gm-Gg: ASbGncsscvB+bF8z46+TiusomUM9ExdAbFwe8zPvEHRN5XYnxbMvZ+0Nx98/ccBUWf6
	OCJF6YX9Bt8mW56KZu8JKtAa9DCu0PyfZoiP9Uy3jq8G0nONo+a558b+s0Hnyy3iIxXXAcFyPCj
	26kBC673Xf7xGVAxzjBxK/QJxQgiW/B7ZNB59T5JyMQ5zqD0xOLv4yVx7sgq+LMiszrY6PwGAmQ
	I3+xkRJ6mou5k1hhRKN9p4dNgQPOAjt2TSiuVMVEXqbnBDWg+BQEU3aly0sz74D241r7E/VWOMQ
	FQgOYqTgWtjMehFzOOxhb0zLluvYAtTxelZb76PwKBUsKpffaw==
X-Google-Smtp-Source: AGHT+IGKE+4zKM94UuTJQK/vyjfN6oxik3zVIACkmE5DFSJGrhrXSedhBxQ3pi+f1PJx7Y4YJ1fP+g==
X-Received: by 2002:a17:90b:17ca:b0:301:6343:1626 with SMTP id 98e67ed59e1d1-308236281f7mr19205173a91.1.1744702903554;
        Tue, 15 Apr 2025 00:41:43 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e6c8sm12572515a91.14.2025.04.15.00.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:41:43 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:11:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: Move phy, wake & reset
 gpio's to root port
Message-ID: <tsnvoy2spr2dtqt3q2cnvl7rxobjgcgxntxb6rjtjdeej625i5@35je7sp3xqea>
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
 <20250414-perst-v2-1-89247746d755@oss.qualcomm.com>
 <ody5tbmdcmxxzovubac4aeiuxvrjjmwujqmo6uz7kczktefcxz@b6i5bkwpvmzl>
 <6db146b9-ad63-42c7-9f33-83ecf64ed344@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6db146b9-ad63-42c7-9f33-83ecf64ed344@linaro.org>

On Mon, Apr 14, 2025 at 02:50:19PM +0200, Caleb Connolly wrote:
> 
> 
> On 4/14/25 10:04, Dmitry Baryshkov wrote:
> > On Mon, Apr 14, 2025 at 11:09:12AM +0530, Krishna Chaitanya Chundru wrote:
> > > Move the phy, phy-names, wake-gpio's to the pcie root port node instead of
> > > the bridge node, as agreed upon in multiple places one instance is[1].
> > > 
> > > Update the qcom,pcie-common.yaml to include the phy, phy-names, and
> > > wake-gpios properties in the root port node. There is already reset-gpio
> > > defined for PERST# in pci-bus-common.yaml, start using that property
> > > instead of perst-gpio.
> > > 
> > > For backward compatibility, do not remove any existing properties in the
> > > bridge node.
> > > 
> > > [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   .../devicetree/bindings/pci/qcom,pcie-common.yaml      | 18 ++++++++++++++++++
> > >   .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml      | 17 +++++++++++++----
> > >   2 files changed, 31 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> > > index 0480c58f7d998adbac4c6de20cdaec945b3bab21..16e9acba1559b457da8a8a9dda4a22b226808f86 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> > > @@ -85,6 +85,24 @@ properties:
> > >     opp-table:
> > >       type: object
> > > +patternProperties:
> > > +  "^pcie@":
> > > +    type: object
> > > +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> > > +
> > > +    properties:
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      phys:
> > > +        maxItems: 1
> > > +
> > > +      wake-gpios:
> > > +        description: GPIO controlled connection to WAKE# signal
> > > +        maxItems: 1
> > > +
> > > +    unevaluatedProperties: false
> > 
> > Please mark old properties as deprecated.
> 
> Since this is a trivial change, just moving two properties, I don't see why
> it makes sense to deprecate -- just remove the old properties, and move over
> all the platforms at once.
> 

This will be an ABI break. You should not remove properties all of a sudden
without first deprecating them (even if you convert all upstream DTS at once).
ABI is for older DTS also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

