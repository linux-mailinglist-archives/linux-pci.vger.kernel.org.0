Return-Path: <linux-pci+bounces-6999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F28B9865
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EFD1C236E1
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029AD58100;
	Thu,  2 May 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DQqmBh4m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91557871
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644161; cv=none; b=sNYwRdEbPcjoWsBYThB/ZwEtMKMj7+VClbljU4k9KKvCx1EcQw3abrZJ/FEChWk601qN9NfkyMgGGDB7pkLu+3KerBY+OH0lcTHyN4eViZ31mJbl9rJhGMeFedXjiliZgrsTsLOlzrBv/ckq/Mw1fvVzpkxKxKtUCaElrQ4coX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644161; c=relaxed/simple;
	bh=Jyakk2Re/yXumSvffFIqIAQUyky6V4gBP2YcQa+LJI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6/ePA1kHfvjP7TZi6yEOp6ttnqCeRgBGpRp6saRf7GhCvMgdeHeI22HQZ+jaI16KLCtIILNp2QkMpWAfuMxmY9uhxvv3mP+oyQkMwgLaQn4aM9/ZmkWuY9GAD/YbII0Do+dLVRhlcsBkgN8RSYbaqyCGWsMhGDLOnnwevPqgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DQqmBh4m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso7983805ad.2
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2024 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714644160; x=1715248960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kMTT3PzTLyPVaeH+DM1bYJEhGQDgrI4wH+0p7ikXNM=;
        b=DQqmBh4mp6/pzjPZTKqH0p2FqsO02oCnzubXyzXAeTGoYGfn6wHXxecXlsfx1ltAHY
         TTeATZziUIZhC3Y4NurLD8gWd9QT5KBP7KZdJnwyeZrkrxgy6rQPWcODJEzP3QOhji94
         qafZmuoJnnwLvtKssFFMf/FsYoGTgwUz0GDH6u04iyPkccTBg4WXd9fO8YfL+8YtkVHP
         ZJakestkypepSyAfoIhJRJ6vXqhdDeL+G6D6aukxxv6aK1sUZNyNa4LbWsoNjNFmG3L5
         IhEtUmEQGoR4ZoM+OkwUcyGbEFQSPQN9GRGf4Nw1gv3oWOJDtPWDajn1xdO4AbPHqIBs
         9kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714644160; x=1715248960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kMTT3PzTLyPVaeH+DM1bYJEhGQDgrI4wH+0p7ikXNM=;
        b=m9Kt57ZfXC2jfJoaEJ4aeXUmVUmMCzUjSZpiF/VYvuqa2A5e2QzZo7tA4r89HDliiM
         +WboYGlOljxnJ/HWBvHIDTo3v8q4CSLn9x1mKP1PnR2/V7BrITZwFL6apnAAp6Khq7FB
         WYoLnuMrcj9yqZp+j/y3hRBzNlFXTenoc1vv01Gq73zz3FMbf9Hp/WAQmMcqF0Gmbm+y
         LV8tRF0ZwRqxCi8bCVPfouKY4aKpXc4lUHgBDLKpFnVxNb72ijtcp6jKVNwWG0NzEfHb
         lVpkHLuGtnhGIVD62c5s5SZE+0fw4apMIiwhbTAIxBvOak63KBIosvd8NMO26R7IlzEo
         yrOA==
X-Forwarded-Encrypted: i=1; AJvYcCUuNPe/0dZNxhoqeoEGU+auZ1Oi+Gp9lFLbE9iKxtepHpHcaPDXbMeC0ZnJCaMDHZW/PXDT9Cru5hd43+wSmQLDpzK61T3WB6Mq
X-Gm-Message-State: AOJu0YxHnpcSbnFAUf9Z1jiKPi4+VpJDL74S7Pru62GeAuF8N91gQSTb
	J8JDb7W2Q3taLKImZwZ/NUKbefssW0hwY7SJk42DrvOXMo7fTI4ppKOuscXGojE=
X-Google-Smtp-Source: AGHT+IFMGhdu0SIDQn/0fGRllf2r0ZaqwxTF1S1fhXPFoF9kfSM7pOtZuP9eC/v0lBtCNsAcHvZnOg==
X-Received: by 2002:a17:902:ce8e:b0:1eb:5323:c320 with SMTP id f14-20020a170902ce8e00b001eb5323c320mr7103763plg.56.1714644157999;
        Thu, 02 May 2024 03:02:37 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b001e604438791sm896026plk.156.2024.05.02.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 03:02:37 -0700 (PDT)
Date: Thu, 2 May 2024 15:32:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <ZjNksbTQF1lMQ0k0@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
 <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:24:14PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> > Add a new function for RISC-V to do any architecture specific
> > initialization. This function will be used to create platform devices
> > like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().
> 
> What is the special about this architecture that it requires a separate
> initialization that is _not_ going to be in other cases?
> Please, elaborate.
> 
This init function will be used to create GSI mapping structures and in
future may be others like iommu. Like I mentioned, ARM already has
similar function acpi_arm_init(). So, it is not new right?

Thanks,
Sunil

