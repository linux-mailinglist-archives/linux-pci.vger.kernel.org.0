Return-Path: <linux-pci+bounces-21460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC7A35F19
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BF8176521
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2CF264A88;
	Fri, 14 Feb 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2IAxK2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED3263F4B
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539377; cv=none; b=UqNxV0RPpWn71sU7TvSA7AZXMg1O059poc/HYvAVdv5HaUuN5/0d3yoJjhOmyn15Qe1lZ3hqDm61UupmbE/63RIgfghXUbgVN5xUXtjdFaOyVn+z3uiW/i7/zNceh4ea7WY98TC5jexmDZPUz6Kcae6EenV3ntPkKomI60cCZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539377; c=relaxed/simple;
	bh=pWZjOIvAdjT6JfA3vcCeZG20HLsqwLE8w4nVMAYXnl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYnHMnlj4WOqc11I3TnsWxdlUdOn73VbCr+8CDkccHTACJt4Iur05/CyyHD33FR0X+XqpGH5NH+/JCtqppZyfXwVQQmJDtTH5EHq48lCvXo4dSDaG/WRvFjzokYrLabnWDDnQlds5HXvoaM/bUpE+TYrT81rgOQvtwaN2K1YVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e2IAxK2y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f8263ae0so34467265ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539374; x=1740144174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S9I+jjcPbUp0BbQYQVtg0pUppikDLXkHzO0OowWPexo=;
        b=e2IAxK2yaF2CN1op+zXJgA4yg6c9ldAN9Vo6Ufy0jSptzmscRlNXkO9+MHFZyckEdF
         0IXMWEs0VsdWpyWAk1F3F0WPJcrrQ/mqdKP92EppCRkarZ7yKd7VtptgGWcG02fSMcY6
         /MhZJlNTJMamRc5wA6uLLdJ5PNkIZnzFOvj67SMbzHa5lOmnyxp/ipxXq8TrLUh8h8wf
         VDi1tTSSZQ0eNAyHNpQDtQule5GN5/Ki/rB39J1n/yFNn87VTZIuPCzE+bwTyP5G0Dbs
         6buLXVpXfBdIxx7KaIWLtV/SBioDRAxlBoBCcGu63dL0YkaGbzOlFxkY1itlW5WwkK43
         NpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539374; x=1740144174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9I+jjcPbUp0BbQYQVtg0pUppikDLXkHzO0OowWPexo=;
        b=gNG2n8fgKvw6CjTcLF63fKuKXu4F7QvXaQwEKs2UjpqNOzbWN2wH0Slx1hUUZ5RVhk
         TNsML39kkj2Yq1R6SbybhAwgiBMeTM8CyLx+lWNFMpczcOyaygM6V1KRu2KIJgGP4rEw
         5Y6dVs20X57G5EwGY77cj7twTco7gr6QrQBhnADJgzjWf+wPPA8wnUA6nN22j9OBcp4n
         iqHxR4d7WZT2VZ+oa1cwY0PXIGx/3qOsCQJxxVWFHIVcJgBYPBzqFsNWlxAGUBQ8q69T
         toU6UCvYza8nLxOfEpGmHtefkwgW9r+mmtwPMbbvyj49mvmQgvU0tqut7R4RubRVVWol
         Qq/w==
X-Forwarded-Encrypted: i=1; AJvYcCWzQkahUgROurv0ZbIkZ6+s7ORoL5ly57TReFka1TQ2VbDjzSXFxRXtSxAW9wVu63gRcV5VlJcKGpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvTkbK2NMsVHZxWonBtysfYn+JsHYlb6x9Zx5RpJgGuZ0iel7
	y/sHkRBTyZcmPU9640NQDqUfIYiXTUeBWso8R4QtPerePk+0GLI1hJb1KprAKw==
X-Gm-Gg: ASbGnct5WN92MkmyJmVBsqTrtzF6ORrKoXX9iqL663ZpoQb8wQL7rLAGx279bwS1ydm
	rYbGfuYuAkhQSWofHLsAXN6qzm2Az3F4OFMEzs1ivSBxFzdhJ5hgPhBZug8LT/ygVwhgbFEbkUb
	MvaDuK1XAKXaI3+8xqs2dLiBJ37f7iUje7AEH6/0TBgDm86/en41Xyv4DNlgmhcPrlpnA4kIjiA
	BE5epgiZNdZKSFN3QXVSqNd5/edcKtJxOWwgMgiEsEjDUNSXQdMr6kZwQW8lKvlHJEvs92dQRQS
	7uxXE3gW6QDWlnVJa8qFJDyVt3AQA8Q=
X-Google-Smtp-Source: AGHT+IFjWeTr8NsPM9DoEj6yyWP+W7LUbBHpeCWXKCgYoJEQixcGBYlU/CED0PUuiTC1uWtJJjfaNQ==
X-Received: by 2002:a17:902:d543:b0:216:501e:e314 with SMTP id d9443c01a7336-220bbafa000mr181903825ad.20.1739539374586;
        Fri, 14 Feb 2025 05:22:54 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:250c:8408:d2ac:10db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d7bbsm28739255ad.182.2025.02.14.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:22:54 -0800 (PST)
Date: Fri, 14 Feb 2025 18:52:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Message-ID: <20250214132246.o5oimrm5ojrcbf4z@thinkpad>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
 <20250214084427.5ciy5ks6oypr3dvg@thinkpad>
 <be824a70-380e-84d0-8ada-f849b9453ac0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be824a70-380e-84d0-8ada-f849b9453ac0@quicinc.com>

On Fri, Feb 14, 2025 at 02:18:48PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/14/2025 2:14 PM, Manivannan Sadhasivam wrote:
> > On Mon, Feb 10, 2025 at 01:00:00PM +0530, Krishna Chaitanya Chundru wrote:
> > > Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> > > rates used in lane equalization procedure.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > > This patch depends on the this dt binding pull request which got recently
> > > merged: https://github.com/devicetree-org/dt-schema/pull/146
> > > ---
> > > ---
> > >   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > > index 4936fa5b98ff..1b815d4eed5c 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > > @@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > >   			phys = <&pcie3_phy>;
> > >   			phy-names = "pciephy";
> > > +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>,
> > > +					  /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
> > 
> > Why 2 16bit arrays?
> > 
> Just to keep line length below 100, if I use single line it is crossing
> 100 lines.
> 

You *should* keep it as a single array even if it crosses 100 column width.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

