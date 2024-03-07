Return-Path: <linux-pci+bounces-4604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1C287540A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B5F2882AD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801DA12EBE0;
	Thu,  7 Mar 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="k5rhW30Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DE12F5B4
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828205; cv=none; b=sNsI5Wyoy+xeG9NXk8iQOPw4SLWLOBc4BGniU0mBBrukn8s36cJOYGYi3irAS4iEpCDoR+XaptWGY8yjMNmOdnl1LVdeTm9MNl3Ol3pSt1lb2IOIU+qVj6EhLZPwkHqzD2kUw1BfQrLVkAsQWAds90XjAj1P+Y3xj8EKN2iTmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828205; c=relaxed/simple;
	bh=ZO4fm184p2T5iWnJQVOJ1oFdljQ764lQWrYywKTchPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDuA7HyIXcX7T0x+0GH0YldTUB5w6/Dcl1tbsfgNJGLMh6tjg4tIlw6P/8HXTi06xT59JeEOkW0pWimRQ4ViC2LxbtWSIXyTIHQfBhInIHaiHiQHYHPEAXiAlieUvH0MUxd+/E7+S0KuUrkW5Yo2Mjaeh9PKPFFiQ+9vI+F6pVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=k5rhW30Y; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 709E143435;
	Thu,  7 Mar 2024 17:16:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709828200; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZO4fm184p2T5iWnJQVOJ1oFdljQ764lQWrYywKTchPY=;
	b=k5rhW30YT7tbY0sStK5avjOqVQIBBe6hwYg06ZU8JXTSwv2bq+TqLt1sYyrSvY6yntmj6A
	m57waE6UriZUAyT/xKm9Jmz4dyORKkx/+XGkV3n+WKxB6zZeSW3L97WPXI5jS5m5tM3vEV
	b5wqEwsdAcB6As9oa8WJxKi70MHFJK2pkSJLz7ERaYXTvUliTz8S4BdT1T8w6aZDyrr1/0
	U53djgp4Q2lrkfC1j3ziZajofHTi0rMFKuiO7a2YC11bm1/I6atZjPP/JJi/bPjwcesk66
	AYZkbL8uPJUMBf11k1O79GxLpP02tQMohkxFt5MpSg4qyGt03TZjP3LVt4FE6w==
Message-ID: <130ae0778852d863b8ce6ae785f62976831ed27e.camel@exaion.com>
Subject: [Regression] [PCI/VPD] Possible memory corruption caused by invalid
 VPD data (commit found)
From: Josselin Mouette <josselin.mouette@exaion.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 07 Mar 2024 17:16:39 +0100
In-Reply-To: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
References: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

(resending since apparently UTF8 encoding didn't make it through VGER)

We've been observing a subtle kernel bug on a few servers after kernel
upgrades (starting from 5.15 and persisting in 6.8-rc1). The bug arises
only on machines with Mellanox Connect-X 3 cards and the symptom is
RabbitMQ disconnections caused by packet loss on the system Ethernet
card (Intel I350). Replacing the I350 by a 82580 produced the exact
same symptoms.

A bisect led to this change:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit
/?id=3D5fe204eab174fd474227f23fd47faee4e7a6c000

Reverting the patch and adding more warnings (patch follows) allowed us
to identify that the VPD data in the Connect-X 3 firmware is missing
VPD_STIN_END, which makes it return at a 32k offset. But I presume the
VPD data is incorrect far before that 32k limit.
[=C2=A0=C2=A0 43.854869] mlx4_core 0000:16:00.0: missing VPD_STIN_END at of=
fset
32769

Bjorn advised (thanks!) to look for what process is reading that VPD
data. In our case it is libvirtd, and enabling debugging in libvirtd
turned out a very interesting exercise, since it starts spewing
gabajillions of VPD errors, especially in the Intel 82580 data.

That igb data does not look corrupt when we revert the change mentioned
earlier, and we don't see the packet loss either.

I'm not proficient in Kernel nor PCI internals, but a plausible
explanation is that incorrect handling of the returned data causes out-
of-bounds memory write, so this would mean a bug somewhere else, still
to be found.

If this hypothesis is correct, there are security implications, since a
specifically crafted PCI firmware could elevate privileges to kernel
level. In all cases, it does not look sensible to return data that is
known to be incorrect.

--=C2=A0
Josselin MOUETTE
Infrastructure & Security architect
EXAION

