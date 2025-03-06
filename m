Return-Path: <linux-pci+bounces-23059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F3A54B5A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3223A1733E5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B9208989;
	Thu,  6 Mar 2025 12:59:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F8204590;
	Thu,  6 Mar 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265985; cv=none; b=F9eMxBR9W1QjHe+Iuhvc+bo+FWDqfPvx6C0clCczIqo7X7CB07tE4XQx0s7EnY5ab8Dp3MdVOMsnK0yPSHWq/yfz1xvDNqPE7ikS4mpyf7y7ffimkPa6HdCBd0o73qKPnGr/yISNkH3fB7s0XkvmkmSnnBSeqcnBdFF6hgTAb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265985; c=relaxed/simple;
	bh=xUm6f5Z+U5Dg9T+/xMzH7X6StiSVpIrgpbnfs1y8T/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVG5X2BgA4xQjZpseQ+wMtnWDkjCjim3tLsk2xqBCArU66l04Vc0UVjDYEuOusTTQpATkD1noRVZTry2+jb+aJKeZEirQ+vYj1A2McSAR5ktcpP09gg/JlVwCew6aV4wUsvBIZAtSK78jlr4mR7p9fc7K5Qt81RobcYf7GoFGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223785beedfso9295255ad.1;
        Thu, 06 Mar 2025 04:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265984; x=1741870784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXr7uDsRH7CN7dqPEAo/8hwLOM1h86DbnHP38hRdbbI=;
        b=GEJ5jBx/JWWmouR9K6oELvOAjXw6sR6tSYxGGBIa8rmM14XG7oxhfd2HQ8r/WVwXv8
         3D0aJfEQ+PftgX+GjVMmF1Xtr9D6foz4QbHOsFdeU1sJtDGP6MDtndcxseYdWfwXQZO8
         cPcwGFt+T7oaYMOPXeIIomZFH5a7bbjcDkqXdD4ZZDgyEhBD3Z4WlVD12e+aFjv/RlyT
         DA5j9aYu1ypTG8rEPRc2CZ7WKML2G+Dwn45NvD2m0JZI2xVcTEGcSXiN1w4S5s3fDVu8
         RoUSPFlKLYlTNHxyF91qW5qLln3hJz7NFlfRP2VKQx5R3G2gehMiUQKh9+U5DF9ezwkB
         uEyA==
X-Forwarded-Encrypted: i=1; AJvYcCU+OJ1eBv+M/4RjUI9YvUQBNk555Du6pirbPrlxJu8l0PRwXc7swR/snFyusccGlRwp0+LyaAS+ie/W@vger.kernel.org, AJvYcCU9aAy63g/ByjXBubjC3tdKwIYzdaszxF5MmbPQFkG72yWFUQWZ8iHdQ4CSK62nWlAXTo9XbqgWbaDL@vger.kernel.org, AJvYcCUgEnmAWKkHxgwbl5AeZRNlOjzGk3GnRLBEy65roYe2e/6VqoZCoR+92TvL1tqkMjNdkg74sBbyMojgANqOpA==@vger.kernel.org, AJvYcCVEBeUY4+HLYSX4HSMkRRVBKVnsMgnx3laVok8A/vXm4L59ZxhPFp+VMsjS+Yo6xUd4cJBBnnfrjzhbbyrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Zt9sMvXJVLQ4jzCDkyr00E58+4vYo4cwSyc9XhqxSXGhPqRG
	4S1nAjGMO4TLWSH17ej8WBKSXXnoBzoywcmgoiYaXw+NHQUO+7F8
X-Gm-Gg: ASbGnctU6Drko2ovZCHGAk7JpUyX/NwTQBu9/lJzVulJ1qjlsQZmxJZfSDSan/q0P6n
	q/pmPPIxzz9sw8J9xM/4FZ+szOwxxBf6WRY8CnktL2F2cSMHP2hFXa37+YrbX0FbG1sXNeRPsJ7
	rANT6z1FXjqvdt1wlqDIXvgW0jMTVsJcz2QqxMunuAfQ9+OG0l6KtwJBqISSmntml6IdAAkW+Cu
	T6ktqygauS5KKK3vECCZ9PM20xhZZNDCpPK1/DcZ/NrFLYzb68IXbBTsv89zZGdAausZ2X6PKhc
	JssAMUoCnAEUD+3/aPaIXSYfSJ8saxtavfZK/0+dK9ShrUpO2annemlFqUIf2GUk/lhI4f4Ls+m
	mVh0=
X-Google-Smtp-Source: AGHT+IHHCa1Mc9CIwvi5u0s8WOcN8dtXSdGTpXdZKm7WGs3OoKGtYXz/T4gD/S03NyAlHNoX9UMNIA==
X-Received: by 2002:a05:6a00:2e20:b0:736:3954:d78c with SMTP id d2e1a72fcca58-73682b737c4mr9780918b3a.6.1741265983562;
        Thu, 06 Mar 2025 04:59:43 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af2855c63besm894935a12.12.2025.03.06.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:59:43 -0800 (PST)
Date: Thu, 6 Mar 2025 21:59:40 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v11 0/7] Add PCIe support for Qualcomm IPQ5332
Message-ID: <20250306125940.GC478887@rocinante>
References: <20250220094251.230936-1-quic_varada@quicinc.com>
 <20250220144551.GB1777078@rocinante>
 <d399a2be-3010-43fc-9531-e4f3560ea6df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d399a2be-3010-43fc-9531-e4f3560ea6df@kernel.org>

Hello,

> >> Patch series adds support for enabling the PCIe controller and
> >> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
> >> PCIe1 is Gen3 X2 are added.
> > 
> > Applied to dt-bindings, thank you!
> I will send reverts for these. This patchset affects users without
> mentioning it and without providing any rationale.
> 
> What's more, it introduces known to author warnings just to fix them
> later...

The following commit:

  829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg' definition for IPQ9574")

Should no longer be present.  However, we still carry the following commit:

  f67d04b18337 ("dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller")

Let me know if you want it to be removed, too.

Thank you!

	Krzysztof

