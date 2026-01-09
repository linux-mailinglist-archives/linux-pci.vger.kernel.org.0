Return-Path: <linux-pci+bounces-44369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93ED0AE05
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D2B6301AA9D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC23612E0;
	Fri,  9 Jan 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB2LnEl2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE235EDA8
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972295; cv=none; b=c0V49UajiDpAL4yWrVeG8CRqJeBcC45AhniyklerAhbWL63rdiqUNCZqSAbNNgqEAdw7eGNsS8cb2ZOidRinkWz52U/AC9kjvV3rVUpSjTiSdFZyzzkolWGDmhUh+qEAFveMNV33ALkc5K79iru0f9owfb3zmjUcgeVOt80AjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972295; c=relaxed/simple;
	bh=PNsXW6CJ2qiIlIxis39oUHrxJteeO07/ZsmmS2gQ3ms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tc4wRtEjBcLMRVxwXimLkm4zO6MzxxB6TZZQ19X3psGnT8GpzYud1sa2z1yC83mb/a1qv5Sk8immifpSYiEg1a9YtNvWwM8BSoHi+mbI8THjznRXLosGs+AYHEjbmPCJlEidjH6mIHHp1a5BmOxjlotWUbfkhcIqbTMvPBnt5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB2LnEl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4040C4CEF7
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767972292;
	bh=PNsXW6CJ2qiIlIxis39oUHrxJteeO07/ZsmmS2gQ3ms=;
	h=From:Date:Subject:To:Cc:From;
	b=MB2LnEl2orYjty+EVgzHiDFFzsdZCrOaV6f81Z66wifYZEruh5yM2wjjLjcFGR45j
	 WaJK0IkYswUm6MhmS3xZt8RLmOaANgu0Vvk1+QIzliDBB0eDtyfqLsEfae9uDJMSfz
	 j9ldHm5inIa1l5WWpQdH0NQ8jd9Nzdi7oB1w4DT3nAawTbYtsTDWg2/mgeUaP6bvz+
	 I5TP44B5LHPnzVRMUnRe8su4X5djZQTQt6w2cu/VUN+oZUUJ9hgkJGeBasvmNjdCNX
	 QIt82YcmDcS9kgqZ3Xsqv6a4eGEHqy8sIihggSHgnL6KnVPjiHa8J0B1b/SCLq0Lfo
	 wSz8Yq8dmhFwg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4557f0e5e60so2827849b6e.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 07:24:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPXCaiMLYQymT9dGcKrd3ilvFmqPsCQqbF6iNKDz6pSVBm7s1SbD6w/mB+D5VWzqwg5mRRzYfRM2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1g32i7SJeWrcs7ObUG3p5DfioAyUpundh1S9BCsYEmAyYoba
	XPU04R8Gt7cceUkYWM/PVzbP/WeS/oYjXeGKpoWwr58Wr/+p57RPRoyD0REfQntH2CzE7ojuccL
	eRhOg/RmaocjGuG27aQ7sxLxNVeLDAuw=
X-Google-Smtp-Source: AGHT+IGb5e4hjxYGgifLNRbfYY3P5AGI+XBzAKVXqPu5/0ZQmNlopciguHcvjAlonmBGqbRWe1BTvUjQzBZMOeaOdlM=
X-Received: by 2002:a05:6808:1b0a:b0:45a:639c:99ca with SMTP id
 5614622812f47-45a6bccffeemr4605039b6e.1.1767972291787; Fri, 09 Jan 2026
 07:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 16:24:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ioRVFo16psNNWeFaWCCew-X1-zoxfJWggo8eWGOrbP3w@mail.gmail.com>
X-Gm-Features: AQt7F2ogZfBq6ZXKbckhKopt7hX3zghk_xVVVituuZVAmst4i8QCTiqGuC-GwGY
Message-ID: <CAJZ5v0ioRVFo16psNNWeFaWCCew-X1-zoxfJWggo8eWGOrbP3w@mail.gmail.com>
Subject: [GIT PULL] ACPI support fix for v6.19-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.19-rc5

with top-most commit 1ca8677d9f3491e51395b0e6b9a2b7a75089dc6f

 ACPI: PCI: IRQ: Fix INTx GSIs signedness

on top of commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb

 Linux 6.19-rc4

to receive an ACPI support fix for 6.19-rc5.

This fixes the ACPI/PCI legacy interrupts (INTx) parsing in the cases
when the ACPI Global System Interrupt (GSI) value is a 32-bit one with
the MSB set that is interpreted as a negative integer and causes
acpi_pci_link_allocate_irq() to fail and acpi_irq_get_penalty() to
trigger an out-of-bounds array dereference (Lorenzo Pieralisi).

Thanks!


---------------

Lorenzo Pieralisi (1):
      ACPI: PCI: IRQ: Fix INTx GSIs signedness

---------------

 drivers/acpi/pci_irq.c      | 19 +++++++++++--------
 drivers/acpi/pci_link.c     | 39 +++++++++++++++++++++++++--------------
 drivers/xen/acpi.c          | 13 +++++++------
 include/acpi/acpi_drivers.h |  2 +-
 4 files changed, 44 insertions(+), 29 deletions(-)

