Return-Path: <linux-pci+bounces-2894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CAB844911
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 21:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1101F24E42
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998438DDA;
	Wed, 31 Jan 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="lajqxsQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C538FA7
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733749; cv=none; b=PnhEw8i1IWgMLWu5DulL8wSISzsK6wgod83mlDotWJckNqBaSqy7ABEZCZg1HLgK6TBH2SFA9YRzhay+q0Jn+LTt/k5Dc9wWlYsmhdFcdseg7WZPWWyDS8ZSJBX/t7ruTh3IDuUyYw0DUBiYhJDK+eyVcFxgY4XosJ5BuAV1JhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733749; c=relaxed/simple;
	bh=QcvO45c2FHK5MfqFL+dYpKJVkIy1NaeCB+1OaQ7RlBA=;
	h=MIME-Version:Content-Type:Date:From:To:Subject:Message-ID; b=ZUls3AidKKLsG4p4qrRES8f8FGkVe1VbR7ska4PmUuVR5VOULAE1VgIpgblvbJJHKQs/uaTApCIDH9C8MF65BGiXxUn+srOJXeqokVmjX0eiuPcsaCrLtlLKSra4VcluT1m0USVc3FfTWRDhjCzhr7gp95q1pOfoOxtF8u98Gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=lajqxsQT; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E63B6240101
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 21:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1706733738; bh=QcvO45c2FHK5MfqFL+dYpKJVkIy1NaeCB+1OaQ7RlBA=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Subject:Message-ID:From;
	b=lajqxsQTX0/5CUnBM9u2jNDqouXwDYCavh7FjOO650cNT+ERCveUXA5YbjBszyVlr
	 EfyZPkjsCilmrJoJErBAvrNSeJjDY2z3554yCmkShiDF2+zmmi6NAD7R48Sw+NjP7J
	 bbfVD7jmDZO7niedRTjBA31UASjz459YSHygeyGSFYtjSGdFlT8dU9/43g0iUWkiOZ
	 WQVs0Qy/RyjRxoN1pVzbKa1gIDFwkciXn/D+DHMTnQDVoJiR6swJF8naOyu9B5/saC
	 /aPY20vW8BRTOCAjycBoAQ0+uTeJYqBBuebHRA9fuSiuQk2vgR0ePh3+ieKdpMz9ww
	 8PIMrdFxza2vQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TQDVf2PG7z9rxQ;
	Wed, 31 Jan 2024 21:42:18 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Jan 2024 20:42:18 +0000
From: nowicki@posteo.net
To: linux-pci@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [Question] Custom MMIO handler - is it =?UTF-8?Q?possible=3F?=
Message-ID: <981728318a564e6c3d54ca76ee37348b@posteo.net>

Hello,

I'm trying to implement a fake PCIe device and I'm looking for guidance 
(by fake I mean fully software device).

So far I implemented:
- fake PCIe bus with custom fake pci_ops.read & pci_ops.write functions
- fake PCIe switch
- fake PCIe endpoint

Fake devices have implemented PCIe registers and are visible in user 
space via lspci tool.
Registers can be edited via setpci tool.

Now I'm looking for a way to implement BAR regions with custom memory 
handlers. Is it even possible?
Basically I'd like to capture each MemoryWrite & MemoryRead targeted for 
PCIe endpoint's BAR region and emulate NVMe registers.

I'm in dead-end right now and I'm seeing only two options:
- generate page faults on every access to fake BAR region and execute 
fake PCIe endpoint's callbacks - similar/the same as mmiotrace
- periodically scan fake BAR region for any changes

Both solutions have drawbacks.
Is there other way to implement fake BAR region?


Regards,
Mateusz

