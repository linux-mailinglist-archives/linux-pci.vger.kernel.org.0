Return-Path: <linux-pci+bounces-22105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB50A40A3B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754A7421DD3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FC142E7C;
	Sat, 22 Feb 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osH0V538"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33613C81B
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242675; cv=none; b=TiIq+10fEmbrsB6IoIdw9bEABBGEbCy/PzWGIv5GPalM2Yj/U9FgmGHGyTbfXJecj+nhJGwEAjtWs13FgwI8T6TNiV3DZSxAOIMaSldnQR5EVY7Daxsc+Gru0Q6dSfA4G1n69L6jUktJNBxDCJeb3/cDJ61N6PZbAs7aeSAMzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242675; c=relaxed/simple;
	bh=L8IhYJZqTL+VAFgPJyw5O+dgm0yXbcW4d8tIgufYAhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdUcZ5Ci4IpEAmVxFSbxAhd3GYiXhBbAP7J2RmHlYYVKqxzBNN0A+SJYRIJEpDv9iM7o3WoQIwI1lINFs9PbxsTNtVtz5x0yNBhpcw5bGNnVBIf67GtTrU9XAm/RKK/lHSZ1j0O8rUSuIN5niux2zpgALw2Ba2Q9CZRFm0MAGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=osH0V538; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d398bea9so47399595ad.3
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740242673; x=1740847473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9f7uZjtHK+lQIbRAC4oC1UZT/44Vy8koxrXiqt6OwY8=;
        b=osH0V538Hbt0Odk6RyZpKHYTCYA//YA6ShdFoi+2mJp8K68rD4a6NwRguVKkXk7RKy
         rAUVXUfKc4L89vhaF9/k1QFn29ozzY9RFFEw91Che0LoKRi/VMH4bxh2mgYcK57slQ9y
         pPoowdUo4un3Mjd/e117cfoqstT3OVGIiT0ME/OwJgKiY/1WWR2J0/Q7AmxvikwzCFbr
         dFacsh2046igUU8iKyC124DKQ1irIzPU2WLgtf0ARWllwZuNvKpP0UMiNGfogmwjcGUn
         Pv7p5sxP1yTITO162cL4PItZSA+RuJo7lBC+f2gbDKeo1r6hbZX/SB2J+BY0w2KTjZ3L
         /BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242673; x=1740847473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9f7uZjtHK+lQIbRAC4oC1UZT/44Vy8koxrXiqt6OwY8=;
        b=U1L21MU4tjE+HE+ltQz5jdxMsp2xGbIiWRuJYFtTS78ozCSck3A36kf97kZduG7i41
         4nXz50qbDsdQh+R79bA58Egmz0yRjIvBJC8EmJqVGsPbfsN81tAqL/YD0WYKAV2kJ7G/
         BSMuMfzwqmJicTFaH3c1Vl5J3NVas5OD311keDWkTqH1MoSBt6xS+b6YiIKQKiQdB0AQ
         u+c1iyU7nYfJNwGfxqrhBgqZyeg5ZTV1d+/w7pxbrIEQyMzxzj/Xz0SxqJ8uk02XDf27
         0XCYWZBc/50jRikaBW5VP0IFAgadTCaowO846jevMroOIR08rHQOfbyFPx0PejW0Ql3K
         bjnA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ArUe7MlKobB6yvxoKkFw6veeGTJdscEqutsrmELZ1+IiifuDT9jdzuUsr7Ywt8wT1e+HbsqAm+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUryTtZZ8FG6mkAz6IRdGRG/eXF6MkT+ippGYuaWU2ZXhvKnij
	DQQx0FFsg258OTT0z3cpVbhzbmWkOL/dssLsqHFUGWVuGd/9MFACoyDljJXiOg==
X-Gm-Gg: ASbGncvWYgCohdfqXt2LjxRhee1++W64pNf21B4jAcOy0vasB0fWKfaefm0Kpzg0lrd
	eMo1zqJcd+M6lHC+dudALUhU4NCCkihC0SVja55QYMq5hxhF4suQKnGTc1Kahe1d4ZuhdqTh3oI
	oDQe1KTuIrXoshkxsBsHEtf3gRpUjkczK7t0zVLUhFtaohAJ6DBA+3TVk3UKS8czHgOCizewi/3
	hzX/iy77GJyOGUVE39ExcO72KrtnSvnEdJhzewU7OMUekPstA+7PD1p6Uz8IMy/rRnkuvLquWFp
	pzDB3/eZcfZJwwklFLsivrNe0mnBJrWgk+gxCg==
X-Google-Smtp-Source: AGHT+IGZNd7JbH7rVNtNivVdsM8aE1a1IdZv+AIk3ODGAEKzzGY0D6UbBx86tKJ6P8fBBfE/PVEofw==
X-Received: by 2002:a17:903:2f8f:b0:220:d7f9:9ea8 with SMTP id d9443c01a7336-221a10ee47amr93976375ad.26.1740242673342;
        Sat, 22 Feb 2025 08:44:33 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537c921sm153046605ad.104.2025.02.22.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:44:32 -0800 (PST)
Date: Sat, 22 Feb 2025 22:14:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Slark Xiao <slark_xiao@163.com>, Qiang Yu <quic_qianyu@quicinc.com>,
	Mank Wang <mank.wang@netprisma.us>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] pci_generic: Add supoprt for SA8775P target
Message-ID: <20250222164426.5esw7aygsz6eouvz@thinkpad>
References: <20250221060522.GB1376787@rocinante>
 <20250221215445.GA363532@bhelgaas>
 <20250222075347.GC1158377@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222075347.GC1158377@rocinante>

On Sat, Feb 22, 2025 at 04:53:47PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > > > This patch series add separate MHI host configuration to enable
> > > > only IP_SW channel for SA8775P target.
> > > > 
> > > > And also update the proper device id for SA8775P endpoint.
> > > 
> > > Applied to epf-mhi, thank you!
> > 
> > I see "[2/2] PCI: epf-mhi: Update device id for SA8775P" on
> > pci/epf-mhi, but I don't see patch [1/2].  Where did that go?
> > They seem related, so I would think we'd want to merge them together.
> 
> I asked Mani whether he would prefer for me to take the entire series via
> the PCI tree, but he said that the first patch should go via the MHI tree.
> 
> So, I assume Mani will take it, then.  Mani, thoughts?
> 

Yeah. Patch 1/2 should go via MHI tree as it is purely an MHI controller patch
(a.k.a host side patch). Whereas patch 2/2 is an endpoint side patch.

> > Also, in [2/2], I guess the .deviceid change is known not to break
> > anything that's already in the field?
> 
> Mrinmay, are you expecting any issues with this change?
> 
> Per the c670e29f5bfe ("PCI: epf-mhi: Add support for SA8775P SoC"):
> 
>   Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
>   SA8775P is currently reusing the PID 0x0306 (the default one hardcoded
>   in the config space header) as the unique PID is not yet allocated.
> 
> I think, we should be fine.  But would be best to confirm that.
> 

SA8775P with upstream endpoint is not used by anyone outside Qcom till now. So
changing the PID is safe.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

