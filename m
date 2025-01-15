Return-Path: <linux-pci+bounces-19893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF83A12461
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82E1169089
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03E1C831A;
	Wed, 15 Jan 2025 13:06:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDD2459D5;
	Wed, 15 Jan 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946374; cv=none; b=sMF3nN7bCbSA50F9FOAADpuYYO93lCuWkm2UH9X7vEajz4hwu4fuPWaRwU162xiAWGNu63WS8z3V5+Ai0bufsQrZscBMDB5a+Ifg5NwbNgVuH+ux1OHITN6fq/RnxzqNmpwD2MPNHCjhLzf3zwDm8jCnWgtK9li3g4CGT1tFNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946374; c=relaxed/simple;
	bh=IcErqgkVtojnS3l7Vk5cUhVIaizwZ2PN7GlLBEXgIZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QucPpeCULdMX8WU3Bz7OiAhI6tdTdPWKb/gDCOW40nN+PRQ8YfBuAz/eE3zRqC8EKklcZz8bWjHmiCKN5ykzw2a5Ofag3CZZ63EkPw6VQvbTahJhbW6IpC6wF75BmhwZGCU6MSTxNujVrgQQbLGxxgyyiGZQj527DdB1CRWDD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21631789fcdso10146645ad.1;
        Wed, 15 Jan 2025 05:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946372; x=1737551172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7fe4W5yc3F8Xv0So0kkrSAGzgbnJTso86hkv0C/0xo=;
        b=F8mfMvrzIRGldYinvEZHbXhfGhcHNS+qBulf8BgAh87J4lyDS5zfYtmv3rs7qz9aJ0
         mrQIlabHpE9vESBKTz/KkknYW2UVS4Kklswjj/JxtMvJYej59IqcyfZH2gTEqW9Zg3Pt
         +H3IFjdu2P/nMyAUntFH1zkOwlre4V9c9UUuXXIV82cLjicHFoxOVQ7T8xjaqxorr9AI
         3K0C2EmZdSbIV5e/XFF5dEwxqV4dDwq7Uue/Zx72ZZQMeeqpWyh0M8vKvoCzx/Hkajek
         Ss/Y+g2WWVYbYGqG/a0NRI7lgugNqfhH0ZnVCtazf3sgmghaSXkJ/pnrmZrFs2kZ+9LA
         TMRA==
X-Forwarded-Encrypted: i=1; AJvYcCV1P9diu6xeVo26+HaedeNXR7Y/KiYId7zUxO6xFV1Q815tL/uBFpDpEcPVWcOqL0t3Bu3dr5OdWFyO@vger.kernel.org, AJvYcCW234fo6hI8TyYEyQ+iuD/emge5f0Qf6RDYToMN7Gda48wdj1R6J4qS7/vWbGbziGJS450NELpddq82@vger.kernel.org, AJvYcCWTcoIVL+qaMUAcKZVWSI7xeIxW8UHPsCn69T1UcRPb02M8ZFC5aUk1broq4NIaX+oTXeKiSgrT+ffdWv3m@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOL0C3Pk2b2v9R0Rgqy1ijCHxXU7wJO9hCWegdVe/duEEJ6X1
	s004tjmzZs693KYImSqW/4vpcHRrIUDzssyvtieTXm6L9YRLIery
X-Gm-Gg: ASbGncs4Ur8Bh/2HnfiUoa+nN5fvusurZAg3+gFqJbXmYg8vry7tYJ6pFFkVSqCyhya
	h1WiUZY5ztfPb/p0/n8Z0tExP1Ju5vIKA94SJTIakgY+vaI6BoXYwfySLC2JkrngAFVtjpmdba/
	Xh6Gyd0J8GUGoNc123Nrzo3vV0ghK4kWUQp4kmbbeJV3K4oxdY5jTT9AFXSVBz42uWWqY4AYrI6
	0yaNjCqeBjPkY7iwX5jWyJebUBGPVZzcq1svivXA2lkvUBC3nJMxkwM09v/gYEJPMI3AFibNrZ5
	ZMZ33eKiYnZiYME=
X-Google-Smtp-Source: AGHT+IH7Jz31AbcmjVSbvq5BrZBB3n03YE0IrL+y2Ko96uKhRd1FiR82/SvqmJ8dZ/Wra69YjzLPHg==
X-Received: by 2002:a05:6a21:338f:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1eb0235a1f9mr4919297637.0.1736946372423;
        Wed, 15 Jan 2025 05:06:12 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a6b4sm9361210b3a.60.2025.01.15.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:06:11 -0800 (PST)
Date: Wed, 15 Jan 2025 22:06:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	frank.li@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Message-ID: <20250115130609.GT4176564@rocinante>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20250115130406.GS4176564@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115130406.GS4176564@rocinante>

Hello,

> > A bunch of changes to refine i.MX PCIe driver.
> > - Add ref clock gate for i.MX95 PCIe.
> >   The changes of clock part are here [1], and had been applied by Abel.
> >   [1] https://lkml.org/lkml/2024/10/15/390
> > - Clean i.MX PCIe driver by removing useless codes.
> >   Patch #3 depends on dts changes. And the dts changes had been applied
> >   by Shawn, there is no dependecy now.
> > - Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
> > - Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
> >   i.MX95 PCIe PM supports.
> 
> Applied to controller/imx6 for v6.14, thank you!

Richard and Frank, please have a look at the code to make sure that
everything looks fine to you.  There were some conflicts while I applied
the series, and I want to make sure that nothing is broken.

Thank you!

	Krzysztof

