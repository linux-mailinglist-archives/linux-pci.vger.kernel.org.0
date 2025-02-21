Return-Path: <linux-pci+bounces-21998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3B2A3FB67
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD43D865372
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0701F2C5F;
	Fri, 21 Feb 2025 16:16:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD081E1C36;
	Fri, 21 Feb 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154609; cv=none; b=mUg4DmpKpW6+A85qhfSNuCpD7+7uY10HyJk9Lq0howhJI803o3nWQDvDlu3s3lxieBY2SOkHH67F7FWSADsJIcuCrI9M5dNM0BbnoWxXmXmQEYVqV7j3DoixgNIvgEL76yv3Z3nWMgPeMla1CpLZ73WKeCNklW5laYXCPwbxt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154609; c=relaxed/simple;
	bh=62BjU1wiNs+I6ByCG2YQUuxnFrCx1qtKkdARbuTJls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/QTlQWZVBlS6V0DB5/miIRS3YvrQLg3/MrTzU4R9vgIVKI7pyF41W8OkkEIpIdwmJyvWwX1Dj5QftHRbwZMzhxXtsV2gd1boJDhMYBp9zil1M0Tq8JaUtSYp/ph5QEkH4AC229Rw5yKwCxf5xqedokniDKG6RTi8TYv0XT03vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so3784328a91.2;
        Fri, 21 Feb 2025 08:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154607; x=1740759407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtzdmLHWgF7iyekmReF4eZfVX/GiXF6V9kKExFtIjGQ=;
        b=Tq3AqJ+T0xkzas9AkCLCOZctX4qBM1tTg1ISxc2ZxRXH8RGbmV58HHc6gXOOZv74mS
         gslnacapKOx2+XhK+om/SURVI+uDUZ8esb116hNCmpG12qHIHMx+LNt6VeKSAwi5L4Hd
         BFC45H3+MpDgT0gcwitnNCJ5MDxSy80GrVS1VxH4wsvNYFa67KqxOYOYVjO3ktPv90mB
         xXTiGG30Du3kOvh4IyFqUoLgpuyCEuGCqU0pWFcbZwcprSe1jTi0/KLvQTcv9jX3g7Aq
         mcvev3vTIlr8RaDoZ3VNS6HXmfM8jvY3Vq/cUiC+vHeE4i9TePkxeHsVhLFf5dVnPIou
         /Rlw==
X-Forwarded-Encrypted: i=1; AJvYcCW21XvV7esrVKwLo6HCQ4ytCHmaLuNRLTO1bwWD84CN9NDOZw1JyRi4QaUaQSlTaxldws45PSJWVR/z@vger.kernel.org, AJvYcCWCvFWjr4gi/21BfNucbThU2LGtkOCtDCenNgi33csh/5RV9ovDafoV0HnG8nEuFKMU4GmmaIENv8iNqCF4@vger.kernel.org, AJvYcCX4qIKaHk2fAccbqAKbLzZWLPCG4u1Og/uMIJZ04mUytdDC0AKQLgJ8gmSP/GnQS61l3HLfa093sQLY@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSNnXZEk45zd6udajaDUvXAALrhv6lESkWlJ4l+3jkQQvEUMf
	Z6BGBRR3aHtd6z/fjXjLedlD4Y628iWKO1/OgAR0WG1txUK1Nq32
X-Gm-Gg: ASbGncu+gJg+dhu4aeuW+QtyFs64fCb6EZmobL42W1ZiuNqabWGcowHeD12J60zXtPp
	I0Mn9jDnbzNhapKCtKlski/4IKQuOg0N3Fq34RORq0W49tUgvXE4xGOyLncEiyMhncKMMcxAlDJ
	u7/Q39Gfz1FglIdwSEXlDWZeBRYYpcARj9rCapIjOhlOlZ+o5r0MPOe5/uOiBF5wUScjInXgsFf
	j44GffrUlMrnQdqYZt8Qz5mr7KCZr6KdMiF7SCI4bJyK5HP0iENp3RItCkeuvp7KwM8YfxKq7GO
	iSDIuIE3m6j1mTmw6YKWG7DTE8Uk/p+zWpccqsPVseGEemsESwk/4Jc4wOzx
X-Google-Smtp-Source: AGHT+IEDUawQ7p9G7A8dpF66pDVzseghqUjomgJNjmCvXMcR3CS02dZrBRorlwXIR837s2Xy/Uu6aw==
X-Received: by 2002:a17:90b:5292:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-2fce77a638fmr6700136a91.11.1740154607259;
        Fri, 21 Feb 2025 08:16:47 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb05f715sm1586207a91.24.2025.02.21.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:16:46 -0800 (PST)
Date: Sat, 22 Feb 2025 01:16:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 06/11] PCI: brcmstb: Add bcm2712 support
Message-ID: <20250221161644.GA3753638@rocinante>
References: <20250120130119.671119-7-svarbanov@suse.de>
 <20250212180237.GA85622@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212180237.GA85622@bhelgaas>

Hello,

> > Add bare minimum amount of changes in order to support PCIe RC hardware
> > IP found on RPi5. The PCIe controller on bcm2712 is based on bcm7712 and
> > as such it inherits register offsets, perst, bridge_reset ops and inbound
> > windows count.
> 
> Add blank line between paragraphs.  We can fix when merging if you
> don't repost for other reasons.

Updated directly on the branch.  Thank you!

	Krzysztof

