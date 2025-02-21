Return-Path: <linux-pci+bounces-21945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C9A3E9C6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E129219C0C99
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57112AF19;
	Fri, 21 Feb 2025 01:18:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81045009;
	Fri, 21 Feb 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100680; cv=none; b=XL4iLwgTjVqA6O3lXQ/gyZSPdTBoGNVnibdxYdnb8DJ752AhJiHjnzBLUJiuBJ15DdBBzxA+VSD1e3kiZFe/44vv6ta+jjoMVjhzZok7VfTTTFoGHxVh6RRNnfKkUM5IQg2rGMHls6sKtV7aRsvCJoZAC+JVH9ql7pb+RbQ79qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100680; c=relaxed/simple;
	bh=w/wHhqZ60M2rVKS74re1Ys5b3Nn7e/itXBY5RYwCdUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRhAN6IPQmpYh3jvKmkrSDpGSboOvl7m2PomW3Kez6Ta6DXzYKKENLASTNonoGcLeXpibMJoX4HasHHlaqFnu5pTvrVal+EmeOs15j4UvVZOnpaVHoiFiC/RuU0GAI3LgEDh/Wz8LKM9zbWm9ctJFn7rEjcNhwAqf4gtJN4SpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c665ef4cso26029305ad.3;
        Thu, 20 Feb 2025 17:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100678; x=1740705478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRDnaSQYuA7AXNjVck19mgs0g9VBHJmey8gvy5+nRVQ=;
        b=EQLmgUWR3KpwDOOntQsPb+UumNfjGDx66EQ67LF/dMepa0ISgfRte0tKCZfjiWfoxF
         4CrJzwxdEaEXpFpE4K1tXPJ7U3FJ9yVjLWN2wKjTySo1hZyNnQgmKbzdmhpiQoFWU9ud
         hgrEKQ5LQUMOA6EJ46FH1DEOIhbpdnV1EBuuMwpPwjDObbVPcLtfTCE4Q6flJ3Ft2I4Y
         pW8e4ZJ8GQ3uxDGFkpW1ptpw0aCRdKMDR+pPwZwbAGdQHPbbc65bMNk4/JerSPSgGqZA
         LFwOiMffyb9o9PWiJUlNPceumw07JV9kb+TFSzu/UKXS7o8MaCjmrnJGXJP6VOCqIfiy
         zXTA==
X-Forwarded-Encrypted: i=1; AJvYcCXPjQoydMrmThUHL3+B1lntC+vCudLHVaoaoBe0icNi+FWb3Gf9iDSwRxTpV93qylMIg42p2c50ek2T@vger.kernel.org, AJvYcCXQQTjwY7XGTv6omli/WHnSWCFw2Cv/PkJnIu96dFnxxK1kDvWhw7AfsQYDD5I8faqk5sKJQmVh/9KHNgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCy+Av8R8gxRG5+G5kP9gTQ3RbiV+trLruITVktouAq9MMROSe
	ZxHy81e9HSji+uWGtYLYzXces2bLHSaphWAVXN6AZzzNVIS7wXKW
X-Gm-Gg: ASbGncussd7L/meCZAk1E/+ysi0PpDhFDjGto3Qzuhlh6JrIn4g00fPTDk5J/jMh7dC
	6w1MTCHLldwRE6WxKpFZ0l2O/03KCkd8FJNMLyiP9Z4aTNN4GCk5UEWikyER5srhj2HgoVOT1zQ
	gBGy8GwSmPdxl7tZdgSzOOm9gZtcX/SXitxr41UtxJkyncNwcsTv/BedYomRJOyvXnqZnygL05V
	DYFkULreQzEadsfdameoleBWKa+TRF74le30YoDkEV8MHTvYSsqjbYKLfSgr7ahgpcPnNREKY+C
	KLyZlypj2J2MXjWH6Z87SeYTbPHAYId4c+1GPI43j/rsRovbeA==
X-Google-Smtp-Source: AGHT+IHLcykA8fts8RT8gddOQgn2Exio4nrAweQFXPHSKIaj6lxr07hzXrGZs2H+GOTF69rjVciZJA==
X-Received: by 2002:a17:902:d484:b0:21f:164d:93fa with SMTP id d9443c01a7336-2219ff82783mr15228375ad.6.1740100678359;
        Thu, 20 Feb 2025 17:17:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d559830bsm125343855ad.252.2025.02.20.17.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:17:57 -0800 (PST)
Date: Fri, 21 Feb 2025 10:17:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-pci@vger.kernel.org,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t.
Message-ID: <20250221011754.GE2510987@rocinante>
References: <20250218080830.ufw3IgyX@linutronix.de>
 <20250220225948.GA318342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220225948.GA318342@bhelgaas>

Hello,

> > The access to the PCI config space via pci_ops::read and pci_ops::write
> > is a low-level hardware access. The functions can be accessed with
> > disabled interrupts even on PREEMPT_RT. The pci_lock has been made a
> > raw_spinlock_t for this purpose. A spinlock_t becomes a sleeping lock on
> > PREEMPT_RT can not be acquired with disabled interrupts.
> 
> I think this is missing a word or two and should say:
> 
>   A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
>   acquired with disabled interrupts.

I changed the commit log directly on the relevant branch.  Thank you!

	Krzysztof

