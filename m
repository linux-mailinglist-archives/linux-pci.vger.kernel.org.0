Return-Path: <linux-pci+bounces-5762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106328996C3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 09:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA2DB23601
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A512D1FD;
	Fri,  5 Apr 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHrlE0Ny"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870812EBEE
	for <linux-pci@vger.kernel.org>; Fri,  5 Apr 2024 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302858; cv=none; b=L+B8TX2NnujV2woh/uTMeMggqPG6DnaAZbLiTXZyzX+PWSk+92nSuxqlmyjqxUys8w2KEAByVUNwXb9bWYcjRDe2S79AxZ6xvi+B8AhsXNBPpb9ejCW75ydokZAadwO13zZz5u0RSCswk9IAhgp8ckE8lxUHo8WJfDQvfSwis9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302858; c=relaxed/simple;
	bh=TlV2tfNsy0zEXW78TY+Y9hKkNagEtGiiitnOqeo8Nr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXQTqgryQ/PLeMrRKUCNxvu2KcU5VCv4kN/zsyRNDGUMiu9HKscyoUU89jx2eD769MEPoK0CzMMkKwX2+FdcTwpZBFwLd+J6TlJ53SDTcFaCIKAWaHpzN2odBOqeIDtpwzMoXJf1UMMGwWQ99byUVcq4KJxaeMwnKrcmKTN6icM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHrlE0Ny; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso1404133b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2024 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712302855; x=1712907655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1a6gAQh2PhrhPbXculVO9O3NtZn8zLGPDuyjie7Sr0=;
        b=RHrlE0NyBj9DZq6tajOxAjVnUDk3t2Kjq/T3h7fg6hknd8mVeNu//PpgZrEdiGR7LW
         /1NdqJmH1sZtfqKdOVSPtDSDsc1nHYnS04SXAFpKW50x3G4npFMfSYxary7bRX6aWROP
         RIEy93zhapai3yWdwkfIWFc4ur/qUQp2VxhIcw9EonqjosCu0a7cPG/pAqc/FkaEOINF
         TlrILtZEGaGvoAUPIfze3BtRapD6GX27RE0SGe63KEZrg3u78GyNSZlrPe7NRQIIEDxu
         IBAQ7hlv+R6hpYqvG/4EqucG/KctvaMZIz9VwKNCsj9piInQcExEFjH+4g1bY0qZSBEn
         /8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302855; x=1712907655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1a6gAQh2PhrhPbXculVO9O3NtZn8zLGPDuyjie7Sr0=;
        b=FchLKazy2watV6HNI+xG+omvZtLLfTdq8C9PvIaa4VRyx2kwFyVEyP74uQ305w/ldA
         jOHqlxyeKAVU9ON8TS4FErBwzzd+KbzA6JOHDxODOa2A9y7uaiu/aBXTpRu0ad5l1Zqw
         eRrJhz35OzVInH0HAD7y3ZldzSFNHegRgKBXRqZ0MS2XPj308ABjxdzA8RgRjzsveUzf
         i2UhpX0g7y7rVVmmiuDs6xQIoyYJWZUooRWmZIUx8QsoUOpDcUGxIGyfEbVQ6NX4W6zN
         nYvRh1MFYyHL993B9M/a/n2OQQKq/7ybilJdTsjNzsHp2XZg2+wSLYL2UR+8kwgLfJTF
         uGgg==
X-Forwarded-Encrypted: i=1; AJvYcCVLd0qGveHR0PCjDdBqe949xzzdL0zVb5maUeA1cyyZczKvUG1UfLX0qHeI4mB3C6ms6hinFAVm4MMsNlR3LC9rWjt94rcJjcID
X-Gm-Message-State: AOJu0YwUAPPLmjsR5VzGezghIExnXQarn6P+eYEhYAXm8D/RzA+IB5Ig
	3rOgyXR56A9TKhNULXJJGRQeQc5V+uSc5zDS5I7aXkmQMDB4MokbVDYqLmKuSg==
X-Google-Smtp-Source: AGHT+IGQzPSdv4xCm9KGESdaqlLSMA46b1EcN3+jKD7raTmoSF2Zx46In/rvazfGN0hikiiMIMSQ5g==
X-Received: by 2002:a05:6a00:3c8c:b0:6ea:b48a:f971 with SMTP id lm12-20020a056a003c8c00b006eab48af971mr941273pfb.2.1712302854931;
        Fri, 05 Apr 2024 00:40:54 -0700 (PDT)
Received: from thinkpad ([120.60.67.119])
        by smtp.gmail.com with ESMTPSA id q26-20020a63505a000000b005df41b00ee9sm820523pgl.68.2024.04.05.00.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:54 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:10:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v8 2/7] arm64: dts: qcom: sm8450: Add interconnect path
 to PCIe node
Message-ID: <20240405074044.GC2953@thinkpad>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-2-158285b86b10@quicinc.com>
 <4bd2e661-8e1e-41ff-9b7f-917bb92a196d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd2e661-8e1e-41ff-9b7f-917bb92a196d@linaro.org>

On Wed, Mar 06, 2024 at 05:04:54PM +0100, Konrad Dybcio wrote:
> 
> 
> On 3/2/24 04:59, Krishna chaitanya chundru wrote:
> > Add pcie-mem & cpu-pcie interconnect path to the PCIe nodes.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index 01e4dfc4babd..6b1d2e0d9d14 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -1781,6 +1781,10 @@ pcie0: pcie@1c00000 {
> >   					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> >   					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> > +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
> 
> Please use QCOM_ICC_TAG_ALWAYS.
> 
> > +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
> 
> And this path could presumably be demoted to QCOM_ICC_TAG_ACTIVE_ONLY?
> 

I think it should be fine since there would be no register access done while the
RPMh is put into sleep state. Krishna, can you confirm that by executing the CX
shutdown with QCOM_ICC_TAG_ACTIVE_ONLY vote for cpu-pcie path on any supported
platform?

But if we do such change, then it should also be applied to other SoCs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

