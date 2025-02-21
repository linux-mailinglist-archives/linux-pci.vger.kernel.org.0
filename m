Return-Path: <linux-pci+bounces-22001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835DA3FB45
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8203BB78A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11871ADC6F;
	Fri, 21 Feb 2025 16:23:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAE1AF0B8;
	Fri, 21 Feb 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155005; cv=none; b=pR51n3KQr/3t+eYDPk3J4WiRznPlA1aQ6/HkOIrWuMLdYcwVg5F4HZnfD4IIByB+9khu5kEgo+RRDtR/7+gDfQVuelFDAP9ARdgurvnNnt17egOySZitNtHFDkf2LQQoAQQGg0xSPyKvxLDOLqey1vWBJpmqTSTfbEP7S15hr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155005; c=relaxed/simple;
	bh=h/T2p8PhwABwt31/Iqz8HRPa+7IdK39YSrNwY6k1pe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd4gC7wSXcHfLMjPjIDuidSVaAfQCvqg+RJ0pceT27Zgs83Q5hZfs1fK/5Qkx/Amzi72M76g+/vSYh2/s/y5EmANZqwRHyB6ybEkpus5W9zHO1Hqi4Tl8n3reRedyXRWPMc25cj8GpKquttMidZ4W1KB32OiSiF5fAkM53PkSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e83d65e5so45523135ad.1;
        Fri, 21 Feb 2025 08:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155003; x=1740759803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITi5eWVIokI8NX7Dfs1unagdyttshAyr98E6hiT7dVo=;
        b=Q+vJJ4/QaGzDcn48c1gv6VjuYSauT68Oz3s7oTiivJr4/7ZZ/K8Y/9//+Dv8ZocKu0
         Cgp1gfLnEyAwr0UZX8NJpu5m+N6+f/MlWLo8BeciaCKSuAZffuJDfzhAQ0g7OGJNv+9U
         Xak60klM+s1uVJlesX55wXxWlcl7qKT6B0x/s+ynNJay+KQWb3HI89k+jdc5Gi0NmxIz
         xmcbZwjTlcPBYmfVXRgKDoYOtf/mQMaA+b/Lxu2dK47HwkRixwjFqITJdeIUP5AWl6Io
         ujIBM/JlHKd5PrBkC0HJ0mk1YKWj17ehM+A6o0VlbSAbr7+yyGgysdVYI92Wp99D3cPS
         AwNg==
X-Forwarded-Encrypted: i=1; AJvYcCVHwQN+25RiuU/m9AWtYY7/aHh97lHp5hEgDC9NGf/mzSx7pIj3VyeGz+M+FdKR15w2+S0N3DM/oWO302Dz@vger.kernel.org, AJvYcCWAkKl80FUybPJvMbb2buI4m+7JrZ8L0LaMvPi0D4KV6XKPiqDcEwc+EwL4Zhs9qHI6/yqdsphnn8FJ@vger.kernel.org, AJvYcCXLpVHOlSjBVp6UZtXT58+IposncQ5IlP6AGvhs9NukkuqJmf8Gg8JCffrgH64JRkpaG24QrdwDLJhZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9O96DSu9pI1smYMP2Xey2VaZEFbP+AjI6V/e+1wcUXqq58Oqx
	a+YpZcmpY57O3JS4ope8UWTqiBETW6OnFJhI7HXlLdXL11UsAPPu
X-Gm-Gg: ASbGncv5JzJNxftHtUl/r4U+KU4z5KPM8JOcCh0L84YsRiqAvkgj8OH/ko3VZX0IM4y
	8Q3aL2Vcrm0geCAw1/9z1taeuuxh0NSVnWtKQ/Kf+sdq5BqSc59B5cxBgAYxrLleGS6qN7uJHeS
	4aXZB8l9mYEj/B1opJv+s3pfRO2TfuA7JTdzTMVTlXO0Kgu97gSeY217z/yXuCgtgIv+at8hTEV
	C5SC+jVT8QY9BbU9lX8GWDUERPtG7iDCLfh4Kg/HaZASE2hpjn190IiVbInzhkg4AxCl+RWD6CI
	d4GIUDO0V88nXazxCNm3aiqRQMBKMdC961l3qS5imJ22jnVynJrI2nV2zNGN
X-Google-Smtp-Source: AGHT+IH6382mgQ/qs604OZFx5389HScCACYI476oB/HnFj1e8TkJWM8SG7lXAnABvg5u4OW6bEYXTA==
X-Received: by 2002:a17:903:32c2:b0:220:d078:eb28 with SMTP id d9443c01a7336-2219fff356dmr48806535ad.48.1740155003489;
        Fri, 21 Feb 2025 08:23:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556e169sm139087635ad.192.2025.02.21.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:23:22 -0800 (PST)
Date: Sat, 22 Feb 2025 01:23:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 03/11] irqchip: Add Broadcom bcm2712 MSI-X
 interrupt controller
Message-ID: <20250221162321.GC3753638@rocinante>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-4-svarbanov@suse.de>
 <87bjvs86w8.ffs@tglx>
 <b1009877-6749-4bb1-95b9-ae976bef591c@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1009877-6749-4bb1-95b9-ae976bef591c@broadcom.com>

Hello,

[...]
> > As this is a new controller and required for the actual PCI muck, I
> > think the best way is to take it through the PCI tree, unless someone
> > wants me to pick the whole lot up.
> 
> Agreed, the PCI maintainers should take patches 1 through 9 inclusive, and I
> will take patches 10-11 through the Broadcom ARM SoC tree, Bjorn, KW, does
> that work?

No problem.

As such, when applying, I took all the patches from #1 through #8 and
dropped #9 as it has been superseded.

	Krzysztof

