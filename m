Return-Path: <linux-pci+bounces-10328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13EA931CBA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9543528334C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1981D530;
	Mon, 15 Jul 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie6E4w+I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D11CA9E;
	Mon, 15 Jul 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079932; cv=none; b=ryIa8v9j1V6YYhZdJDBAszwTzK1QmaOcEblG9Din4uAOnxXE1x1t9GtMX82McZ3Hf0/GEmQ9oE+4g9zR8/yupbfksjL8tLzIXLOr9ZAhLcgqFeV70zStaP0UW5SbIkwQV/pIfRQJOlc7dmpVsNKTrV2XZI3YUXlXE/dhxebyNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079932; c=relaxed/simple;
	bh=3sYQn+Jepl4NDUemgHAqThiTYJbdffNlfepowdj0XM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DIbEucXg9DICbU9+n/IJVrgzd2kAEViuHmM9HrRXcalwKp/LBDLj6T6Ae2wiMCtDTtJiLRa2mwTQsMB9kYu2mFKkEmkMQjJll7L1B+iuaac3f2qKpBo1kcY7AbbqQy3uHt3/mwZchVsiXTlaa1Nt64RvR9G2tjw92MaZHSwMC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie6E4w+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2B9C32782;
	Mon, 15 Jul 2024 21:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721079931;
	bh=3sYQn+Jepl4NDUemgHAqThiTYJbdffNlfepowdj0XM4=;
	h=Date:From:To:Cc:Subject:From;
	b=Ie6E4w+IyxnWuRi4lHGvmEzWfxoGda7leZahZG+bqbcwyXddpVWlG0xtXaiqyhGYx
	 2SdVCN6ar9DOP8xCzvTi0tAWQdoee7pAkTRPk0/VDS6amDRbwAdPE33hLgqiU/jsAT
	 FlrAnMviFuMa37CNTBcFlycd2b7gB8cfUbJc2D4tOjZvEIrGqbw5VgOod0nyO6oKZF
	 Dp4kpKZBUp4go9/eZg+l3QbDUyoEikn1cU3plT9v5oHXIQrVkAg3XP3VBW0loQ6wm7
	 ac5N9cq2FnGjxz6YiQ6XEz5Og9nvM07XS82UFl2ynR/DyxV1D/d93mhOP+4LzW5uD0
	 S2NTuUSnk3BWQ==
Date: Mon, 15 Jul 2024 16:45:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Austin Bolen <Austin.Bolen@dell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Lack of _HPX after reset, DPC
Message-ID: <20240715214529.GA447149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I think Linux is missing some important _HPX functionality.  Per ACPI
r6.5, sec 6.2.9,

  OSPM uses the information returned by _HPX to determine how to
  configure PCI Functions that are hot-plugged into the system, to
  configure Functions not configured by the platform firmware during
  initial system boot, and to configure Functions any time they lose
  configuration space settings (e.g. OSPM issues a Secondary Bus
  Reset/Function Level Reset or Downstream Port Containment is
  triggered).

Linux currently *does* process _HPX for hot-added devices.

The spec doesn't call it out for boot-time enumeration, except for
"Functions not configured by the platform firmware during initial
system boot", but Linux does process _HPX for all devices enumerated
at boot-time because it's not clear how to identify devices that
weren't configured by firmware.

But AFAICT, Linux does not do anything with _HPX in the device reset,
AER, or DPC flows.  I don't have any problem reports that I can say
are caused by lack of _HPX after reset, but it seems like something we
should fix.

If we could find a system with _HPX that does something interesting,
we might be able to demonstrate a defect by looking at a device before
and after a reset.

Bjorn

