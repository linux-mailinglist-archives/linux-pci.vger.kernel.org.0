Return-Path: <linux-pci+bounces-37496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68DBB5C9B
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 04:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F89A4E2FE9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73132C17B3;
	Fri,  3 Oct 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCE8GpUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C927510E
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759457062; cv=none; b=VvD7eUOFyhVs+7phM2zBR5VtJ9rXElDvV1dkrQ43ss8zRyxR7DPfvZuAftH2pFO5tfTnCvJCg3BACOn7EB4Z+z4nD6cCoWggBloT9Sa2IxKJRLEelGTMyKeAxJEJOvfKeSQ9vU/khUr1WxbF4c41QSiN7Lm6gBaYLrrQiO5HakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759457062; c=relaxed/simple;
	bh=Pipoy1XBbds2PlnklTKlbqV5Zk1mn6VbZPmBLBLrsLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD3aturZGfptCpWPaR7JYa7+1dF4vUZaRf8xqq34iAdfYfvmtrAG/+SuzB5ROd0uf+Vfck1/RTMXPhhniQPc6f+43fWlS0lyEwYbROD9qAIXIwgcweh7iLAWyczaYrCb7Gn0NQdQlIqX7o0AYY2JubYDqshe2JaYCOhkrPxJhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCE8GpUp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso1812199a91.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 19:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759457057; x=1760061857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPj4N/rg4SEFd6nYGGwkaDff/FuT1pDCqQiR8KahPrY=;
        b=eCE8GpUplPzmvoCDTEd9eZyRlENmSw2CXONJwGyWU6Y8RClAD9sczPMCGJ/nVEfeNQ
         Y2F55ETem5Gy3G6VIT0GkBrcRCTqiNI/bgXO6u/KWJCqmtTzHe44MdQVIb/j01zYuxXj
         xyZDwZLzrPFLhKE6WNfx7tSaq1fC5My7xx4a2Eu1uymjUAHX8p3D7TYz3vb5itc9snd5
         kLTF1hQ9AeNHFPUuZMrbZw1MNaBpcbAdJ9SUzkNHAfijbJBAWGYXi0Gi4n0oB21MfUHe
         fUQEfBYJCuMprt+Dk5p+y/A+/6X9J4ukXXE3FtqtnY0QnHjLHUFoJy4HoGOLmHkvNbh+
         hFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759457057; x=1760061857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPj4N/rg4SEFd6nYGGwkaDff/FuT1pDCqQiR8KahPrY=;
        b=XcilhoyecxRywkriwTBZk+zNTpUkHzuow6ED87zq2ZwpJbz7KgO8sR5tmceuQupvcM
         pNGAb/9Y/B/W3VJ7MetRTfAsGw4U9Acgb8riXvVq9FA5FeOeVD546NpgwlNi4PS9tTeT
         vIaiiuiiK3cMLZ7w5ZHOk0ey91w5FZ3857BYNQcnCsc6iSqNAmtgPg3Z+dpPAFnxtUqP
         X2yR8zJBZOUM8uH7xT+0Y66GG2LmqJ756poKEn2o0KlBTqhs/m5AIdRtWG5j00GtT9c+
         115uzJzagxnkbGeltWu1ZXHtHAgkVt8pS9B65T8xJM+oYD6fys2gU3+G64PG3fCXy5No
         TAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzjv+SNQHeNEEfwnhxWn5LZ7Ms7Udp6/jU8U2oS8AY11Ek/DXW0YHbyUrSPwvpqIRZTi0sOqcACFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4RZmCj+7Q62du2D5AADXoQHTUi1DguKu5wb5ihq/snC9XAS7N
	V+TsiCMTKtfLDtiTrWQRwawFy2fdcJgu0O+c5c6jZ47H9p7ZCDVsL2d1
X-Gm-Gg: ASbGncuZ4xcmbSily3izD98qzinQ5gRYsN9bJkWlO6AsHdV+r6yjYSiHO6C8PjaQqWp
	90c5sybhaw/b6BneboWf8oCilRTV4RTkQnqxHPtyuC5imcBnF/R8r4Q3ouneNq7QYcsYVHPo9gA
	mwJzkUsGfXtvy6eG5wGtp92/GuNiwdj6KXpE7yMI0SwBCZfD2umdF0ezpFk3T+pvMepq7DW+4a2
	0GgO9iMmLvC9k4HPCCObJJAc0BTYqwdKFAmZGHlza+Cu8K5EuTbL+jql2A7eC0EPhFiLdu1B/eh
	ypY0bYrhgxNlIH51WvhW7H2D6KGfHDdfBlGpUwJL5MvrrQcra4RlKmifmXGoNmTYy4fN6yHL1mh
	15RWogtHtTNjoQU5X6VR+5dI8CNFfByD4hb/boI9eqdvhnA==
X-Google-Smtp-Source: AGHT+IHn7vuMvBOMCFhdWNq+HKu7oYdcjqZnf8CFJ6x31g+GFu/ht3yUh0/GtT4ZLdiBWKZ5FvUL/Q==
X-Received: by 2002:a17:90b:38cb:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-339c2705e45mr1606187a91.7.1759457056786;
        Thu, 02 Oct 2025 19:04:16 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-339a701bf31sm6262637a91.19.2025.10.02.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 19:04:16 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:03:43 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <wfdzfzzemspxjecijckhrzurdfuxebnxff4lyyrcw4zrqcxio5@z4uaz3hcty6f>
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
 <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
 <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
 <b955d5a6-5553-4659-b02a-a763993fcd82@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b955d5a6-5553-4659-b02a-a763993fcd82@panix.com>

On Thu, Oct 02, 2025 at 06:51:09PM -0700, Kenneth Crudup wrote:
> 
> 
> On 10/2/25 18:30, Inochi Amaoto wrote:
> 
> > Can you have a try on this fix?
> 
> Bootloops, unfortunately, and very early on (in fact, so early ISTR we'd had
> a conversation previously about the first iteration of these efforts).
> 

Weird, this seems like affects more than the vmd itself.
I think I need to know hierarchical information of the irq
controller. Can you do me a favor for rebuilding a kernel
with CONFIG_GENERIC_IRQ_DEBUGFS enabled and check the
irq information under /sys/kernel/debug/irq/. Any of the
vmd irq and NVMe irq should show the information for it.

Regards,
Inochi

