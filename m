Return-Path: <linux-pci+bounces-3062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA258483D0
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 05:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F94CB23E3D
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 04:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C41C3D;
	Sat,  3 Feb 2024 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yr40aX5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D991101D0
	for <linux-pci@vger.kernel.org>; Sat,  3 Feb 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936122; cv=none; b=SRSMN030JZT+O+3VsbloVeqMzkidQ8A/PpL+UAGu2+3d5OGQYI2XE84tdNdOePeBd98NSYSfcBoHYaMaCNicuPeYakqL624T1Igjw03WLKczl083Q9KjU3p4GvyB1kGW/DQbT5xOfAmvsqqJwUx8xbMN2AmXWUMkRdeeaWVUjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936122; c=relaxed/simple;
	bh=prhyuYpiyJHE3S7DnClC1gPKzqdA5hlwv1JmdIn2t4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CULi8ny0q6Nn/jl4OtWCxG2jN01ztp/sxybgHeydqu31PIvEKQ554rSWhqB+yBLVBb0r6EFIu79LKKPiPbAPS1kfNHw7YJzeHg002vqAtm9cUcBoxfS3RmVDoprHNzjQg3001+xpzBogn6Eju05UXAOkkIKGXDX6DXd7dhNYd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yr40aX5V; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bba50cd318so2184759b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 20:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706936118; x=1707540918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=liH+UlEUy0/qdW3w6rXrGrhdkv4ggd+gQjsdMoONLdg=;
        b=Yr40aX5Vdwd2PrAPmusyeO5XUqyrEkqohDXyXoWBJa6AzbvSk2dkmN5xfEEDR0wA1y
         m1Tpm8iz3T6X6MI+3FwJcMYNcaOKLXwHNfqoTIWTOfMlgHh0f+wvtqnlOCtqMa+vCE4k
         nuu7PNmp2ccsaFS899sPRwM/9aRLETZy9UGMxLYxM2JgthLw2RqQfqaWDoVEYM02QxXF
         z5SkYCkF4lvF40gi2sx0FeziFMyeboqBx0VgKlBkJjzwuUW0RqEjmeKgDisGFIOC9pfw
         e3WcX/fcZbjj0hfnObLxSZsopjelgUfPMlsgQRF16vJ69HLZkBXc7qZmGrsMDrYfpApR
         SVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706936118; x=1707540918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liH+UlEUy0/qdW3w6rXrGrhdkv4ggd+gQjsdMoONLdg=;
        b=Tlmk36ZA3sew16XXNewDpmVtKhcSkNvtzXn3GI81wD23/SH5kWf4t6hturbhrX4ngP
         aAhnimd1A16VDfupq4wD/gYYSI/9dCrP3sjB5W5mopjhTSQMdHXy5Rsbt+NEMV5QbbL6
         9VHP9mzFM3TCqdHrgCPSXUuOzE4BX5H1P/maImwwiQjRUSjCf9WHl4/Sth9n3Gqu8HkS
         ux87o3M5bAfU3+wk3YkXeDbAyQV8wz6nVvgkHyrejt9wZcz4ELQ97iWoBH9u70C8Y/Mm
         CiZk8OOSaWJP/12HWqOI5MM0/oe6anAcp5pv//jCbYEdkaIXa7bOvmz2AswJaCyvBAIy
         o1+g==
X-Gm-Message-State: AOJu0Yy5sCnNCq1JvSM1YINr76qFvpbuTqUgVKoFcpi+HYP92zx3dGfl
	5SwjvfJ1/Q2+1rCg3BFTDpB8+89VIXF4O+Y680eOFrswUG0RwPBS6h4OcQ/tlw==
X-Google-Smtp-Source: AGHT+IHdMv2idNnsnA2Q8aRKwiJvIlzhH8ITKTDULVqn1uKBYYZSSnoU26Aac8cRhwlwGKan8m52Qw==
X-Received: by 2002:a05:6808:2120:b0:3bf:ce2e:c4b2 with SMTP id r32-20020a056808212000b003bfce2ec4b2mr417298oiw.50.1706936118304;
        Fri, 02 Feb 2024 20:55:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXUa+col4sTfn88a4vmaccjdk3Lpyd+XnHeUvYW4WBO9Sd+nRVAAP1o5/Cp9h6wpuhupUU8LRF7jkbplfeUvpukjn5WF17Z0UhUjI7Jw6yzxbRRJ4nqJwNhx0i5r9vcTmVl/MC0Fzu+ENJMxDhKhKAh9/BPhM/MrEDKMcb4c+FeqZuwdKRxJQBWVcRHnX2S1xiWSyG570oeU3f9HYGmvDCykKjennYFQDpfxSHoGj4xMJjU8wH+bgrqS4+cMXcGJsXZWuF7tzB9DfbGFRQQiELRLvyqw5CCuK5a2waOP7r0NCwUwPBCUDBAG9pYi0up76Uuv5k2r1zqZk25e06PjZo4TThSaHHUfrSx4QKMiMI6NSAjnnGdX+rfdNqXFLMr+LcDuagUSV3H
Received: from thinkpad ([117.202.187.138])
        by smtp.gmail.com with ESMTPSA id y11-20020a62f24b000000b006ddc7de91e9sm2467321pfl.197.2024.02.02.20.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 20:55:17 -0800 (PST)
Date: Sat, 3 Feb 2024 10:25:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable D3 support for Qualcomm bridges
Message-ID: <20240203045512.GA3038@thinkpad>
References: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
 <20240202090033.GA9589@wunner.de>
 <20240202100041.GB8020@thinkpad>
 <20240202193326.GA29000@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202193326.GA29000@wunner.de>

On Fri, Feb 02, 2024 at 08:33:26PM +0100, Lukas Wunner wrote:
> On Fri, Feb 02, 2024 at 03:30:41PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Feb 02, 2024 at 10:00:33AM +0100, Lukas Wunner wrote:
> > > Please amend platform_pci_bridge_d3() to call a new of_pci_bridge_d3()
> > > function which determines whether D3 is supported by the platform.
> > > 
> > > E.g. of_pci_bridge_d3() could contain a whitelist of supported VID/DID
> > > tuples.  Or it could be defined as a __weak function which always
> > > returns false but can be overridden at link time by a function
> > > defined somewhere in arch/arm/, arch/arm64/ or in some driver
> > > whose Kconfig option is enabled in Qualcomm platforms.
> > 
> > Hmm. If we go with a DT based solution, then introducing a new property like
> > "d3-support" in the PCI bridge node would be the right approach. But then, it
> > also requires defining the PCI bridge node in all the DTs. But that should be
> > fine since it will help us to support WAKE# (per bridge) in the future.
> 
> I'm not sure whether a "d3-support" property would be acceptable.
> My understanding is that capabilities which can be auto-sensed by
> the driver (or the PCI core in this case), e.g. by looking at the
> PCI IDs or compatible string, should not be described in the DT.
> 

We cannot whitelist platforms in DT. DT should describe the hardware and its
capabilities. In this case, the "supports-d3" property as I proposed [1] tells
the OS that this bridge is capable of supporting D3.

Blacklisting/whitelisting belongs to the OS. We can however, whitelist the
bridges in PCI core. But that has the downside of not being useful to other OSes
supporting DT. Hence, a DT property that describes the hardware capability
makes sense to me.

- Mani

[1] https://github.com/devicetree-org/dt-schema/pull/127

-- 
மணிவண்ணன் சதாசிவம்

