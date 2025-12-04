Return-Path: <linux-pci+bounces-42610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F3CA2A19
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3610730039FA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC81D5178;
	Thu,  4 Dec 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=teika@gmx.com header.b="SHVONeQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3472B9BA
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833279; cv=none; b=M7cyeGSD3PG0fJKVuvI1yU8YUB6vHuyqP6kDrfX9VDAebcWIQdtfRN4dapvT7e8NnPfPLA2/ZyH1FDPX/JKro2d0DnozDF1USgLKFj1pa1K2+0iUbdJH7qkMUUoeaDJtWLdMWpi6+p/XTAOwpp+H1ioAgXwIy+YObNtxqVBmd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833279; c=relaxed/simple;
	bh=gWV3pxGfOpwnrXJzKvmTsk76VRdhRoDfaxivespj/U4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sBqDGnQ+FZpRzXFetV5NgcN/+tya5y+ATZ0rFVG3J3JL6pglwoijIhEEgfee5CEt2EAsxwMXTVEnNHzbCnhwjHVCjPu0dG1lDHEHhcZaYXtjrW1t5ERWp/n/U7xNov2RGHEW2P/IrWMYgo8s4pmG7pRsejHj5WaTbAnF8d3IWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=teika@gmx.com header.b=SHVONeQs; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764833265; x=1765438065; i=teika@gmx.com;
	bh=gWV3pxGfOpwnrXJzKvmTsk76VRdhRoDfaxivespj/U4=;
	h=X-UI-Sender-Class:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Mime-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SHVONeQs+Rpf6Ma0F5spwRHDT5oSiUGN/NrkRvjNl1z9eLCs/kg+JIM8U7JtEinh
	 ATotFCCalNzKinB5dQNL6QUywWtFezy2eFr59vVPiRIEK61AySgzb0BMfBY63ShpC
	 gYOA14VQMhPr9qytbD+QL/Kp3lklHkI+zzSpEiHXgasEvYXNHbNFI3Olf4HqaKr1I
	 6tykQYxNE9/w/VU/l4SmRCtPPnPRlMHFihUYA0cMKeDs0v3BYKxdwPghwHeMz6JKn
	 NFdPKgqbzUql13zGHzELJjR/C2RshGdHH/etMrvQItWulfYHcXe6hZP24hB2WVm22
	 SZegmCs5Z761S2Dr3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([153.161.204.57]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKbkM-1vm1z22eFQ-00QQ1r; Thu, 04
 Dec 2025 08:27:45 +0100
Date: Thu, 04 Dec 2025 16:27:26 +0900 (JST)
Message-Id: <20251204.162726.629872510136678985.teika@gmx.com>
To: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, aros@gmx.com, superm1@kernel.org,
 ilpo.jarvinen@linux.intel.com
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 220729] dmesg flooded with
 "PME: Spurious native interrupt". AMD, related to audio.]
From: Teika Kazura <teika@gmx.com>
In-Reply-To: <20251104200516.GA1866276@bhelgaas>
References: <20251104200516.GA1866276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7GqBwkbcW3c/BVKGEx0O1dSnPAY/qWu5XiQ1FpOwcbTZtvHQeC9
 F3Pe6pmvG2dUv/gU7tn9XLBGnLDc/6SKn0X2LRiQ2HanRj7ATS+TvLVzziQXLk01/5vC+Ji
 AOpTOjiMAhkJKHSLj/J24fk2hkaVSSTNw/0USgaQLdtvuZ+FdgZR08mzVYCD1qaLX5JFPhW
 ji4S5YIsUvHJpri/xIvlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0jMkwxuWQGw=;d8SRUk2BuaGU4Snm1wu0swW2scb
 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

From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [bugzilla-daemon@kernel.org: [Bug 220729] dmesg flooded with "PME: Spurious native interrupt". AMD, related to audio.]
Date: Tue, 4 Nov 2025 14:05:16 -0600

> It looks like PME and bwctrl share the interrupt; Teika, if it's easy
> for you, you might see if this is reproducible without bwctrl.
> There's no direct config option for it, but I think you could remove
> bwctrl.o from drivers/pci/pcie/Makefile.

Unfortunately, compilation fails, like this:
------------------------------------------------------------------------
ld: vmlinux.o: in function `pcie_retrain_link':
/usr/src/linux-6.17.9-gentoo/drivers/pci/pci.c:4746:(.text+0x9fdfb1): undefined reference to `pcie_reset_lbms'
ld: vmlinux.o: in function `pcie_failed_link_retrain':
/usr/src/linux-6.17.9-gentoo/drivers/pci/quirks.c:135:(.text+0xa27105): undefined reference to `pcie_set_target_speed'
...
-------------------------------------------------------------------------
Ok, let us give up this route. This bug is not fatal. Thanks a lot for your reply.

Best regards,
Teika

