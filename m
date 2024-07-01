Return-Path: <linux-pci+bounces-9536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A091E98C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475501C20E5D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9516FF47;
	Mon,  1 Jul 2024 20:26:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EE2AD0C
	for <linux-pci@vger.kernel.org>; Mon,  1 Jul 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865573; cv=none; b=pmPYvAnmYutQI5Xl8yMdkkWQ421W+P02zceKfXWReWzKCbxy72Dq09dSs+SMuUdQL5Uqt5rlsmupbLj6TRtTlZYYDG2VxbH1FcEd07GMNzPLfRhRP5UF+XBUNnsB0t4z6lJrYRelb1E8eg2iuYCmAnj2uwmDd2ZxaWWsP+Qv650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865573; c=relaxed/simple;
	bh=RUpTbYrbFnD2A3nYaID1YzxGkz/7ue/e6QEQXSZFTEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUrwVLqeWUyMPEiQHngrSETwkmlt1JJLJgPRxuijJHono4pYrblzkXFVKEEyTdUIzbgzVPORnrKac8e7+yNpddiM2EGAqO4ybhqA8bev5e8PBffcRue2e6Jg7htKNbuvd9G/m+0kyeIIjGKmX4m6BgI1+BT5Qoa3WUtDLUQQnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so24601515ad.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jul 2024 13:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865572; x=1720470372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI6uii23gEz50DacL2OQ4dR3F5oxIfsVcOBkpzCjqQI=;
        b=bD4farD2WoO/tHfPGMg8yp4ufg0ZmUducTIU27TxqrMe+JwJeLgZMVtXC9XbIh2tq8
         Ccv5GTYEHVOnRPPT4s++AReEwZ7EX30+j2KHirwoyrae+n8jvIV8Eio2moPA1dPP37yF
         WLanTG5Aks0dIPNIOp/sMn5zdvc2dfz/G5y3H/8UedixLLHoAJ7bp877Ec1aZWqhX4bg
         LgvDhDgygYS7NqNubQnLxeWX5ujfA8bYM6BiKJeOd5uT9k9YjtH1mbHLXoQv0ruEFvav
         5GqTmOzz8klCGLdDKSNyYkJN+ydEPNPouIsR+HipETbyqiz0cLymQKcX6ZYVsb5Fsde2
         wNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXltqxGaf4+qms/PCl4AeJpsJ/OunbIGdE0f3s9uC+TeGHKfUIcajyTi8Ca4X376P2G8/CAs79+QBhMFwmrTbxPm1bALL+eNR73
X-Gm-Message-State: AOJu0Yzf70b2WAD03bK95CZNvdwUWpSw/7RVA8rcF+yCoVfiYke2Mfii
	uHfkWdjtNyim1Yo9+1V6HGisjLxsaNe9Usi3EEM5cS+3M0h7ypt1wM6uCU2rHgo=
X-Google-Smtp-Source: AGHT+IEQtz+k2yOiy0OPRjJGu/WMCDh9JvomCRm2O4gzVFCwVMYRFXSFPzdUIk1iZMIP97VfWYn2Eg==
X-Received: by 2002:a17:903:11d0:b0:1f7:22b4:8240 with SMTP id d9443c01a7336-1fadb4d18b5mr108830415ad.29.1719865571786;
        Mon, 01 Jul 2024 13:26:11 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15bd0edsm69148775ad.306.2024.07.01.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:26:11 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:26:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and
 hot-removal
Message-ID: <20240701202609.GF272504@rocinante>
References: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>

Hello,

> Keith reports a use-after-free when a DPC event occurs concurrently to
> hot-removal of the same portion of the hierarchy:
> 
> The dpc_handler() awaits readiness of the secondary bus below the
> Downstream Port where the DPC event occurred.  To do so, it polls the
> config space of the first child device on the secondary bus.  If that
> child device is concurrently removed, accesses to its struct pci_dev
> cause the kernel to oops.
> 
> That's because pci_bridge_wait_for_secondary_bus() neglects to hold a
> reference on the child device.  Before v6.3, the function was only
> called on resume from system sleep or on runtime resume.  Holding a
> reference wasn't necessary back then because the pciehp IRQ thread
> could never run concurrently.  (On resume from system sleep, IRQs are
> not enabled until after the resume_noirq phase.  And runtime resume is
> always awaited before a PCI device is removed.)
> 
> However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
> called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
> of secondary bus after reset"), which introduced that, failed to
> appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
> reference on the child device because dpc_handler() and pciehp may
> indeed run concurrently.  The commit was backported to v5.10+ stable
> kernels, so that's the oldest one affected.
> 
> Add the missing reference acquisition.
> 
> Abridged stack trace:
> 
>   BUG: unable to handle page fault for address: 00000000091400c0
>   CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
>   RIP: pci_bus_read_config_dword+0x17/0x50
>   pci_dev_wait()
>   pci_bridge_wait_for_secondary_bus()
>   dpc_reset_link()
>   pcie_do_recovery()
>   dpc_handler()

Applied to dpc, thank you!

[1/1] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal
      https://git.kernel.org/pci/pci/c/11a1f4bc4736

	Krzysztof

