Return-Path: <linux-pci+bounces-22004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78FA3FBEF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0BD1890879
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47C213E76;
	Fri, 21 Feb 2025 16:41:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E2213E86;
	Fri, 21 Feb 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156107; cv=none; b=ZnX45JBP+/9g5fCtW/ImIa9qjc0D1UjvmrSLdMrBP2TiIrKsULJ4zcG8W33IsRk544NFI0np29bmxektfemSXl0JtVO8W2MpDPYnJqvfwKDcVzNHvIMkD6cvIuzSe70mQrSJ64OofLDhQvUhLsOblcVj9VQ24xIT19WUVzF0tAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156107; c=relaxed/simple;
	bh=rGj8fLxC+DbsRLOLS3hgJBvDEhbTKQm4KfLHu/2Ak7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAvSHgsLOAK9ZyvFXNCjtksa7nuh5iwNw6k+HftukiRRskvqSzUWrTUx3oKwEe3u5kpOR5JvQ9NJtnkX9PSd3KWaK6Lb4HYSBGLDxErECEi398cLGMe8ovdg6aWXlGudldgu+K7H2mh+WnpMjPPmGCzfjblez68EjaejKBE+HvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c2a87378so41203375ad.1;
        Fri, 21 Feb 2025 08:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156105; x=1740760905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/mZpUlTquvoeG2x+zrnqFQnXFtT8HSXqVWnUe58Y60=;
        b=n2YGA5OL3O633C55xoAtjhWAi69Te0wFNG8f1fhGREdelADHxI2vEVm8B8EqhSq5MA
         9LPs7AlxJXJcYBwwIezoq/mtAidVsfwaSeOQV5gMvRPCe+zSb5MylghxgS2YylBNGFli
         ha32v9fF5ffQJB72jmHqvgf8mGBC67sbTgvBSNEZsjNA8L7zwyT0ua31misNb5ymnAnU
         3VxgJQr4II03ClLm46ddBQ/iaahB7r5AiV0dvJ6EBBsgUoIzk9AnLC5uNHbiRDrj5ETf
         NVHooSmYvuGbSs5whQzostDvK/GuY9/xnwTeBVylR73v5upmhBF5YK58DfhuaEi1F5Ou
         FmQg==
X-Forwarded-Encrypted: i=1; AJvYcCU61nx77+9gw/fxL4xtIB0kolGRBt/YyxxgVJ7V+BQJ7t2G5Qk3xG3XULsRc9WEZRvemW9sBjuop0Dp@vger.kernel.org, AJvYcCW5qKg73bYm9j9/YFFZEA+y1/JFqDvem/gKDXYqFW5Cw3LV5wq8jk+sdLo63OJhI+thEhzEsaqty9jj@vger.kernel.org, AJvYcCWc+vhBWFDcZj7/4iEyxPn51klTLAaW2zjUcFeP9do3Gcj/XhJ2kYSL6cZ6X1lcAPdYlz8gCX7+00zKElvp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3a2D6fs9XfRtlbOOpl+WhmxTkrrY//NBdtRTG818ggF6raq3/
	/q4bWJKMOgdXWRIpCS+Nl/mZXgc4oYRKmOLO21nzINqMi5+O+3TB
X-Gm-Gg: ASbGncvxC53en4bixjj0SADXpB5Ndv6OVBbNaACPvZJhfF5HkSMcvye8AKKrq5vg212
	uwTADYJasnVgVdgo8ycY545mJyiqLzS33E6Fi/d/oWoOPqk5zlo/933Fe5T75VuaYmDu4gLOyvV
	liIDmYoJrIQK+NTPpID/hRBAARtpQoH1p9xBp7tiTPDES0+6b3MqiZ7jpPB/4LHFZyYMGQoJgmx
	juJlmLQ/UKwVghpb+YmWaVT6evXYlP3xEkv83GuGbhh6VoT5LFFiHfoh1K+sEUERU93QZo6L7sT
	+rb1oy1nufKtgeqZqtX8Zm9mVlNvycB3dJeOnpMtKBMBYmNYDyuevAWzpn/3
X-Google-Smtp-Source: AGHT+IGZgFr4e+ti4ywsqozeP9Q/hpPpDceJnTxW596GOTY6Jvj+Hq6k+LvsAwG53T/F0Tm60pwrKw==
X-Received: by 2002:a17:902:d4d2:b0:21f:4b63:d5c3 with SMTP id d9443c01a7336-221a0edbfa5mr55123455ad.12.1740156105171;
        Fri, 21 Feb 2025 08:41:45 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d4bcsm138904485ad.144.2025.02.21.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:41:44 -0800 (PST)
Date: Sat, 22 Feb 2025 01:41:43 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 04/11] PCI: brcmstb: Reuse config structure
Message-ID: <20250221164143.GF3753638@rocinante>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-5-svarbanov@suse.de>
 <CANCKTBsm6o9yaSenj-wft+n0uX-HNRjpJjkZaQcn4t474fXtow@mail.gmail.com>
 <CANCKTBuMOk9ASfPydcKHQgaQF4p7m7ryYezcLPdBEM2ao3LY3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBuMOk9ASfPydcKHQgaQF4p7m7ryYezcLPdBEM2ao3LY3g@mail.gmail.com>

Hello,

> > > Instead of copying fields from pcie_cfg_data structure to
> > > brcm_pcie reference it directly.
[...]
> Sorry for the late notice but I get a compilation error on this commit:
> 
> drivers/pci/controller/pcie-brcmstb.c: In function 'brcm_pcie_turn_off':
> drivers/pci/controller/pcie-brcmstb.c:1492:14: error: 'struct
> brcm_pcie' has no member named 'bridge_sw_init_set'; did you mean
> 'bridge_reset'?
>   ret = pcie->bridge_sw_init_set(pcie, 1);
>               ^~~~~~~~~~~~~~~~~~
>               bridge_reset
> make[5]: *** [scripts/Makefile.build:194:
> drivers/pci/controller/pcie-brcmstb.o] Error 1
> 
> It appears to be fixed with the subsequent commit "PCI: brcmstb: Add
> bcm2712 support".
> 
> Can you please look into this and see if you get the same results?

I applied this series to controller/brcmstb recently. As such, we can fix
the issue directly on the branch, there will be no need to send a new
version.

That said, I can wait for Stanimir to see about a fix or look into this
myself if needed.

The 0-day bot will pick this now, and I expect it to have the same build
issue.

	Krzysztof

