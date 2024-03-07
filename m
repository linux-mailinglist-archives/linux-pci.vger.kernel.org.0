Return-Path: <linux-pci+bounces-4605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9F87540C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70581C20382
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FF12F36D;
	Thu,  7 Mar 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="MehtYLsa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7E12F5B0
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828232; cv=none; b=MIGBfdrkYx75asB7wmp+44STjBrewfFsJSrQnox/rRGqcIGaaGAtXdLlyNjXUL9tad7dewXJQxSvpO6daaQZtN558DMOap1AMd+I9FK02GHE4zgSD4ZMDh/Kkb3O4AcMTaTbGAWC2EzTYdoXYAZZB6iZHteTdgRXOMBXFmFhv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828232; c=relaxed/simple;
	bh=UYAAPWz8WExvy9B3BpabeQV+vgbzDDuAuK1yqFkYrlU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=rGiNp8vzqWpiEbv+Fs2WFT3phfQntUaXjeFNRoQVFL7lseZOkYcxr7zflEl7qALdIHLyizjH1nfXi+w7xNh485wqqqnnvlWmaPL3o1mHeB/pkWIso+fUIDWjA1mqh7OgwbwwJt/aIZ4p7bmf8KPyM7SL8qcTJwwbGPqA7WK8L/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=MehtYLsa; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABC0445334;
	Thu,  7 Mar 2024 17:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709827673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=n0G1A5WQM4caf34zzMboXrvTeMyF/XZeF/ZNMHiGQRY=;
	b=MehtYLsaG2wJKdqnXpaOPr5VH2SG+evzR0ekvOOr9PkcaDUlUmGUTP1hg0WiqBqEduBubt
	jfRVbtjkdV6Zuv+Bn2CCDbu256KBdP9YE71WtmhD5CtX0PKOMp46SXVKQpeiJ6UHJ50bYX
	n27suXKAEdTEpnjfELQxG4gHFUDodVRfViDKv4EM7GKuekqH8/cP6rfejRSNnYACJXUmya
	6C7BBxJi+uia5jGmDw2LHkJEeW9Yy1OEbdnhAqIhv3eJSmw2kYCHKy5Bp7phIMpbrgDlXS
	Wr0toPsxaS9WB/N5KF4oNuPnoVYfG47g92FNNghAM+uIxTugx2c9E3Q1noHRUA==
Message-ID: <aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com>
Subject: [Regression] [PCI/VPD] Possible memory corruption caused by invalid
 VPD data (commit found)
From: Josselin Mouette <josselin.mouette@exaion.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 07 Mar 2024 17:07:50 +0100
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

We=E2=80=99ve been observing a subtle kernel bug on a few servers after ker=
nel
upgrades (starting from 5.15 and persisting in 6.8-rc1).=C2=A0The bug arise=
s
only on machines with Mellanox Connect-X 3 cards and the symptom is
RabbitMQ disconnections caused by packet loss on the system Ethernet
card (Intel I350). Replacing the I350 by a 82580 produced the exact
same symptoms.

A bisect led to this change:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=
=3D5fe204eab174fd474227f23fd47faee4e7a6c000

Reverting the patch and adding more warnings (patch follows) allowed us
to identify that the VPD data in the Connect-X 3 firmware is missing
VPD_STIN_END, which makes it return at a 32k offset. But I presume the
VPD data is incorrect far before that 32k limit.
[   43.854869] mlx4_core 0000:16:00.0: missing VPD_STIN_END at offset 32769

Bjorn advised (thanks!) to look for what process is reading that VPD
data. In our case it is libvirtd, and enabling debugging in libvirtd
turned out a very interesting exercise, since it starts spewing
gabajillions of VPD errors, especially in the Intel 82580 data.

That igb data does not look corrupt when we revert the change mentioned
earlier, and we don=E2=80=99t see the packet loss either.

I=E2=80=99m not proficient in Kernel nor PCI internals, but a plausible
explanation is that incorrect handling of the returned data causes out-
of-bounds memory write, so this would mean a bug somewhere else, still
to be found.=20

If this hypothesis is correct, there are security implications, since a
specifically crafted PCI firmware could elevate privileges to kernel
level. In all cases, it does not look sensible to return data that is
known to be incorrect.

--=20
Josselin MOUETTE
Infrastructure & Security architect
EXAION


