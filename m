Return-Path: <linux-pci+bounces-42999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A95CB8EB0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C1E305FE48
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC87252292;
	Fri, 12 Dec 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CofnFnK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40865256C6C
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547275; cv=none; b=MPuX98TFdaszpNcAAa0DK6DjCL8SR8JVrfU9tx8EVekFiBakdSyQkofDnFcdyq6zC4KgN8KDLssn7wJBgm/HvXQevi3TWwNDLXsb/WK70M96tWtS6WjFeFR/wWNoLEEPODC5Qkir8M4tV30FfZyfEg5N1ve++hCsKW+p40NFf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547275; c=relaxed/simple;
	bh=ERh4A/fa/3EomeuKeJVcjaQG6RPT6qs8hlm76hkoa1c=;
	h=Subject:Message-Id:Mime-Version:From:References:Content-Type:To:
	 Date:Cc:In-Reply-To; b=oZY6qDujCLCmirn6bmB383NBDHTF1kYp/p0TQIyuv41V68TZQ60WMbgx2HBQ0jpb6NY6Sb0Bifn8A8nmStmKG6Hdh1wdvneyZ3ilsxHSRnF+FalzsRl6vmmpD+Jxu4+7BewNf16tdd7X/ohQli35q597HrU+G9BpQqPM3grCeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CofnFnK7; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765547260; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ERh4A/fa/3EomeuKeJVcjaQG6RPT6qs8hlm76hkoa1c=;
 b=CofnFnK7SPLuOxnSFerlHGUc7euSuMwBw65EWUn55HI2yT9SAddZEEBHZKgHSvg27y3N2M
 SBhYiJcZyZ1SyWeRrFQydAV6viVpzQsYOnag6IID9syItwpt1/mVvusHupNKJ18uHBs21v
 z/owo3b2BIzOUxeAf+lXIYFi+XxMDbWBiW3H1rNz9EIzEL+vxvzOf2OSLSgXTNFhLNTYkx
 Yvm1zE74fws2PJEte3DYUrBrPd00gbJ7+DYUANtlsFnRTMUt6On/uYzfKd4HKEX3yuPXvK
 /OP3u1WmzhfmMl0ZrZlWmrnvkylNBNAhbvLZ8udveTUY+Z+FKryc7s/hirQnAw==
Subject: Re: [PATCH] PCI: Remove redundant pci_dev_unlock() in pci_slot_trylock()
Message-Id: <20251212134725.2461-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
References: <360c5c8e-dfc7-a88b-fa20-a157da87ea74@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
To: <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Dec 2025 21:47:25 +0800
X-Lms-Return-Path: <lba+2693c1cfa+da8c12+vger.kernel.org+guojinhui.liam@bytedance.com>
Cc: <bhelgaas@google.com>, <dan.j.williams@intel.com>, 
	<dave.jiang@intel.com>, <guojinhui.liam@bytedance.com>, 
	<kbusch@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
In-Reply-To: <360c5c8e-dfc7-a88b-fa20-a157da87ea74@linux.intel.com>

On Thu, Dec 11, 2025 20:13:59 +0200, Ilpo J=C3=A4rvinen wrote:
> > Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> > delegates the bridge device's pci_dev_trylock() to pci_bus_trylock()
> > in pci_slot_trylock(), but it leaves a redundant pci_dev_unlock() when
> > pci_bus_trylock() fails.
> >=20
> > Remove the redundant bridge-device pci_dev_unlock() in pci_slot_trylock=
(),
> > since that lock is no longer taken there.
>=20
> Doesn't it cause issues if trying to unlock something that wasn't locked=
=20
> so saying its "redundant" seem a bit an understatement?

Hi, Ilpo J=C3=A4rvinen

Thanks for your time. The commit message was a bit brief, so I've sent v2
https://lore.kernel.org/all/20251212133737.2367-1-guojinhui.liam@bytedance.=
com/
with more details.

Best Regards,
Jinhui

