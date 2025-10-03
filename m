Return-Path: <linux-pci+bounces-37537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A18BB694E
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C5A19C5041
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A02BFC9D;
	Fri,  3 Oct 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9aYLMas"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF128504B
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492912; cv=none; b=MZ/vSobwG4P4ZdLJVx+Yf0D/qjcglWiwTkrqnwEIBsWzIjmmVlpY2ldgCReDajptNJg9K6whKKVFo5wrd9oz1yLZ5sb/OnZBXnEHJxebo5t5XTds2MSt+tK7Qyd/vkJl2pPkL6xYrIDKt6vU/+7STDwiGpoq74aG30CLQ/aIYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492912; c=relaxed/simple;
	bh=YIg2RQgishuV94QdfOKYWn8qpWb4YgBsJyz2vghL4lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRjKrUpeXBd4I1P1wMDJhq/Vot/lkufWsDYsT/aVEIGLAsmWw8lay9AZxRI8c3HvZpJICVG4ScAhMyoMKAHiFkY7Tg6nuOikPF3Kewj3y3HsHdE2wS5L46xJYF6l9eRxy3I6t7lTaW8m6wxsfVI0g+adUs6a8nweAb7hqRxnVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9aYLMas; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso2177686b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759492910; x=1760097710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+plbhlob9YcBFO8BeB/hWZf83Lnb18iiE2kNKy+zUSg=;
        b=m9aYLMascZNAeP5PPLESPqnACwwydILe//XpHQgEZjGt1sfUafzJ4gtj8G6w4sEtxQ
         SJep6iQ3ilpcWY0NccIT4GKySYkCVbMydj7wxF3FV3yeL/p37m+UNDzVHoVjWTSwC9+o
         tlnsmV4Lt3EsymNnkn6nXoXfYpbb8doys2fJn4nZPyKn7OCL8Ibsq48oINdF0AbJvtds
         gpoku3V/LShJ0hG3FQ8nkm2AWpesKVIDeT4SELLeVLGYIbYszMf6WRGff/qOEIvbqVxx
         gZtN4Tkg7zxyIXei+iZQilyDozHnCiAnmNAIM9O764KI0TPv0w89EUCv0ZdMVvxmk6pY
         +hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492910; x=1760097710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+plbhlob9YcBFO8BeB/hWZf83Lnb18iiE2kNKy+zUSg=;
        b=v7wNTXmvJEoapvfiQx/qiWor9LHJ2Jofxetqp1tAntX910+8IASXw9VPwybulv5dES
         QLBVag5xALGwgI7JFxAGTE2F63ObXP10ASKQciY8ZS8mmyBCCYeRMeNQaTWZlX0WC1sY
         6WsGtn/j5WDMeITnb5FNp+cFhYuL9ah5ol0BOKW9dseUs+fxFabzFQaoVicsDeTtvLAR
         ppXL6DJrfnbz5zbhE7IZFCByddzKMZXmGIyFhMnO8NPkIq0z9Ol8kNHctCivwrJ0b5CI
         AjAowrkBKC6PLac7avimf6msyihfbQbNllt/QMXp/YqF9qv11JYVuo5mZYGlP010TAJq
         Cgkg==
X-Forwarded-Encrypted: i=1; AJvYcCUs+LaIJMdeGdc3cmarp92d5Py0u7fB8FSnTSCdWXIcL8HE+NCkc+t+F30Vt1I6JwuQ2xSJKHmWiYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QOccchYP10XtoM4JBuvLhDHiMXgG9SobUCnWzi91McfZRG3p
	6kiPDnq15+WzhPxOc8abIslwLiFRjL2BTvL6LKYiJ4aeQz2OHh7ZnTSO
X-Gm-Gg: ASbGncsWlQCCjEv0zxJ/qa0RMUgPGiiDd4LOZ3ajylnAkpmMj6u+LzQUGZ3bzvQ0ax0
	RCvnVxItN8xxp1Q9LqxkZ1Rzia64l19vXjQt6tkuP0O4iN4Wli0YxqzEwOiMrmVEODDr7dh/Xch
	BIexq972puGzLMCQXmDn3jBTj0995kucAgiu1qnPNKg/lc2i42S7/xQwsHLNvfKSNEFkBvnuhMH
	wYBm5dNtlK0zyPF0jJ8tO2W5TDEXdV7aO/HLeZhJ9XECCceirod6ZxJdDkY6fKjETjtBkIboz1V
	supRaxIbhTzqC08Hjun2q43kTuGVIeNo+kxKeuXI4pluv1ywXg4YUTZa7ufRwJGrlDbGN59Ttc6
	j1gN9AL9zNdQJYDLkuidpXqHkwUPQgIgyIDqG6hH4vJEtFA==
X-Google-Smtp-Source: AGHT+IFouDwvvaffaEAmj9GbxgwLZT9mUY2e45pPFI0b637/K439Mb23m7oAWfi2kidjhR0byJ9CcQ==
X-Received: by 2002:a17:903:15c7:b0:25c:4b44:1f30 with SMTP id d9443c01a7336-28e9a6568dbmr31771875ad.45.1759492909773;
        Fri, 03 Oct 2025 05:01:49 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d12608fsm49273855ad.33.2025.10.03.05.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:01:49 -0700 (PDT)
Date: Fri, 3 Oct 2025 20:01:13 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t>
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
 <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
 <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
 <b955d5a6-5553-4659-b02a-a763993fcd82@panix.com>
 <wfdzfzzemspxjecijckhrzurdfuxebnxff4lyyrcw4zrqcxio5@z4uaz3hcty6f>
 <69a89a6f-1708-4e34-86a4-f8f3a74e4da2@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a89a6f-1708-4e34-86a4-f8f3a74e4da2@panix.com>

On Thu, Oct 02, 2025 at 10:36:35PM -0700, Kenneth Crudup wrote:
> 
> On 10/2/25 19:03, Inochi Amaoto wrote:
> 
> > Weird, this seems like affects more than the vmd itself.
> > I think I need to know hierarchical information of the irq
> > controller. Can you do me a favor for rebuilding a kernel
> > with CONFIG_GENERIC_IRQ_DEBUGFS enabled and check the
> > irq information under /sys/kernel/debug/irq/. Any of the
> > vmd irq and NVMe irq should show the information for it.
> > 
> > Regards,
> > Inochi
> > 
> 
> /proc/interrupts and egrep -r . /sys/kernel/debug/irq attached.
> 
> 
> Also, FWIW if I revert back to the commit in the Subject (but no further),
> and comment out the
> .irq_startup entry in the MSIX msi_domain_template struct, the system boots
> normally.
> 

I think I know why, the reason for this behavior is because I register
the irq_startup and irq_shutdown in the template msi domain, which is
called in the irq_startup() and irq_shutdown() and mask the enable/disable
callback.

And there is a diff for you to verify what I say (Just for verification,
not a formal patch), it should work for you.

```
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1bd5bf4a6097..8abca46c9b73 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -309,6 +309,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
 
+	info->chip->irq_startup		= NULL;
+	info->chip->irq_shutdown	= NULL;
 	info->chip->irq_enable		= vmd_pci_msi_enable;
 	info->chip->irq_disable		= vmd_pci_msi_disable;
 	return true;
```

If this is worked, I think I should find an formal way to adapt the
new behavior. (convert this into startup/shutdown or maybe mask/umask).

Regards,
Inochi

