Return-Path: <linux-pci+bounces-33797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD6B2187B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 00:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21DD188CC9C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7D227B8E;
	Mon, 11 Aug 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd7Z01q+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13C1534EC;
	Mon, 11 Aug 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951832; cv=none; b=i7QwblNCLBm6zrF2eGVyyhCLyE7BIYkK/4WY6UrdvxtgwKCsIR2fEilJzf6A460/80lHZDDaM/K35GsD12ZPSzbk/qBxBRDtgOHFhPrtI91cLmlu7bwySR807EBrDmDSnHGCtm1Ev3yy9CyHW8qdPKFmRY4nq7QjgxtaDwpy7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951832; c=relaxed/simple;
	bh=BHC2PaOipQkOGJeNqMzGGbEYJmtGfbmzKcpLNaqKa4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO3L1PG0zLUMOEyrtLblVGt12DTr5olHXKKg74+RiwUGl22GEA83uessUchDE1ofGJB9KWMaLaykBMg51OeDZ07TQTV8QDu0+UZgY0/7bg/X4bHjbolkj8RwwIP6rEihAdLDE9FxojS496MH3EZPezgLCYXUI1JmMEGL0tvyUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd7Z01q+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b9a23d633so5255130e87.1;
        Mon, 11 Aug 2025 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754951829; x=1755556629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEuotSwqWZ/MkjucAhLMiVpBxJcWCdl28iP05ia7lo8=;
        b=Cd7Z01q+n/wN2LTgrph1PozAfLrleqonBHsT3UMIfJDOSEePa5TTKPzs/8JCm2HwOt
         hDQgqohWcaWgQ1CGEB8XRb173tkQZmQWUDOQ/1y8T/KwGJ1hF6huSeNtAd9pYvl9CJB4
         TyESaIgSOGxuM29E3anRldC9Pjww1H9PZQqoC/7yAaJ/u7p8raE5P2d9kFddK1ixHRP0
         kFCN3klJMbK1OGP56+J3ghSrGn3sP7PB1CNqidUYnZmxebKQVZHSDnPeQ0GiwnpvTYSr
         FKISdA9xUWRP0zezIA1IwFcskD0ytBd3YDDYnjxZ2BuLYcEGZuHqzhnodsoqxmFjmuuK
         SrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951829; x=1755556629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEuotSwqWZ/MkjucAhLMiVpBxJcWCdl28iP05ia7lo8=;
        b=jc/EqV++32zk1eRcGZ9jAacOJHry3x+05cv5uClZWZiDcxuYjvpr7+akjJNpBnyDuI
         AX1A5k1YliOHE7ISrjDY8xgrxNugqzr2udVSpeRbIub2ml2h/7dlhySD9PzRfy4Ro9qb
         uz50rhnVfxyOQbiJZI4J/j0fHUGxyTCkPPLavXsXcdO67F2ENlesKS6YjM3sef2HBDdO
         9vGR6gb8HZgU/dE8L9G/F11VKzeGlxf/QTu89jf2fy90oRrmPgfxqEb+Zlyw2kzvtjl7
         OGd6mFNKYOrb/nIaBTUvdyvMPlkTEDacF/0SyRVdAcgGzTWhl3vXO2HpIs49peRHZUnm
         8f+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+JwRKlS4b95Hdr0Fac3eCc+tRI0ppOq04GPWB/fb29YYO7bjsbnmRrrQjzH5nYPlyOlHoVuB3Apw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0E6XcUvKMchv7Na9haqXtNzMoRvMK/G9lLSUVDp6L9+SG2CHq
	ZdHvM40kVT4Y9cJ5GlF0tv0qw+AC7qn3xEMfr3bMDMa6pAPrrbCmsGkB
X-Gm-Gg: ASbGncveFyZIjp8DpjG84MHKSuGXjsp+vjV6l94atUxnAg9QK7SJKfNOFN1Kg2deZ0/
	K6/lh5XpxIWd5+Jf+m5oH+hc9+mWYrGhi/SrRlaosZBzF3DPSsswot5INf6E4YjbPpHceVqPjKI
	hCK2Ulqy512vjO2RzZ30PI8HbC4VhI9IEwCcwifz6p5jCbLdqq6Vzt3s6OpO0dsIwQH1lPT4MDb
	GTFcp8iFAaUn+qkuhm7rJboiEgBud9U7dQMnB7hOdX0neiXeF2VjjBxM4DTt14Ki7Qj8gasQDnU
	NembBpFxF8P3RivHDa5iARKbZufFlH0HIcS7RAbwoxM1Z0uBVcapFXmx7hQ6XODCBe1ckrvDA5p
	tMeXqF63gszi3FREpzpuk0g==
X-Google-Smtp-Source: AGHT+IG7o8c1sMrDu/4k1FVO6jnMSQcLHiH19xx1OuiiqRQ3hrO+0JzqkSZ6kgjh/tKd6cNT1qzImQ==
X-Received: by 2002:a05:6512:2313:b0:55b:81cb:538e with SMTP id 2adb3069b0e04-55cd8c45f0bmr345642e87.26.1754951828682;
        Mon, 11 Aug 2025 15:37:08 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b88caf0ebsm4477529e87.154.2025.08.11.15.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:37:08 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:36:20 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Jonathan Cameron <Jonathan.Cameron@huwei.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 4/4] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags
 for SG2044
Message-ID: <h6sz4hsvajq5pbcd6m2byctdpg6yhjhwbecsqc4o3npieswxov@u3myntmq2xwa>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-5-inochiama@gmail.com>
 <87349y7wt9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87349y7wt9.ffs@tglx>

On Mon, Aug 11, 2025 at 04:33:06PM +0200, Thomas Gleixner wrote:
> On Thu, Aug 07 2025 at 19:23, Inochi Amaoto wrote:
> 
> > The MSI controller on SG2044 has the ability to allocate
> > multiple PCI MSI interrupt if the controller supports it.
> 
> interrupts ...
> 
> Which controller?
> 
> if the PCI device supports multi MSI.
> 

The PCIe controller, in detail, the Synopsys DesignWare PCIe controller.
I will update the comment.

> > Add the missing flag so the controller can make full use
> > of it.
> 
> Again, the controller does not make use of it. The controller supports
> it and the device driver can use it if both the PCI device and the
> underlying MSI controller support it.
> 
> 

