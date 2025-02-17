Return-Path: <linux-pci+bounces-21674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747BA38D2C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CB9170D36
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8023958A;
	Mon, 17 Feb 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FBRjXUfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD05225413;
	Mon, 17 Feb 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823605; cv=none; b=Xyx08DcUj7u5tx+uvVzakFjbOtm5isbxCYYlOa2eBQjuko0FsC3jIcGuzGDqfj+ylG8siCDkQ0jCLx5Mg4wXk0G47KrfdBP+1m0L4nqoXmx28DAAobJT0tOoBvG4xmTRAGy/AtdW5AJf37M37laQHKwvwhy2NWkHJkTs0SrQEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823605; c=relaxed/simple;
	bh=bmAqzR3cruiuFA1OsvrBgCt8ZyY8qSJjUU8ihUgLOrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxtPDxcPRGKnhRTB1FqPscIOxbc3a2lUdjVH0BebjVjmJdPfa5y0I9S1hGsy5wzbvHPCAmzhAfrTZKR4tsAaJGM27QdM7mYn0tR7aSkMpNNTTWB2Zk9MQPE3ii9n/cxFnpmCj4u0FrEvv2vtk2wtaXngmGjec8IgTu3kKzcTjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FBRjXUfI; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 7f2d1f7deba3e7ed; Mon, 17 Feb 2025 21:20:01 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 900CB9100B0;
	Mon, 17 Feb 2025 21:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739823601;
	bh=bmAqzR3cruiuFA1OsvrBgCt8ZyY8qSJjUU8ihUgLOrc=;
	h=From:Subject:Date;
	b=FBRjXUfI5NEbVfB2ky20CVCVp7RL7tARBaf1tV2Oajc85dAv2I41A8CRSkjcEZS12
	 2EY+PJGojyjbk6pQRIdUa/Vn2F2p0Cd32j3qU6dPBzjjg2mRat0Wi3rUvqRiDrNmsq
	 tL4HDhZk1DvztWSurn3mmbLdlGZbjs7nrKBEuTDegR/mPv51HJ9EsMLVmlqXyG+vc1
	 X1sGLJnN6nt3A/9eIzh32Gpmrdk55x9s9qpbsoXfUtV6Pp9hAithL5Bm03HGKrVzwV
	 NWWgLHXYBRnLXVTtbKbPpKjKwOVfED3J+7xSOFbXtiJVdayl5Z1ciAtwhq5WZKnTtk
	 4TUe2VbN7z3TA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] PM: Use DPM_FLAG_SMART_SUSPEND conditionally
Date: Mon, 17 Feb 2025 21:12:34 +0100
Message-ID: <4966939.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

Hi Everyone,

This is a follow-up for the discussion on the patchset at

https://lore.kernel.org/linux-pm/2314745.iZASKD2KPV@rjwysocki.net/

that suggested an adjustment of the approach.

Accordingly, this series modifies the PM core and the users of
DPM_FLAG_SMART_SUSPEND to take it into account only if it is
consistently used in dependency graphs, as described in the
changelog of patch [3/3].

Patches [1-2/3] are preparatory and they arrange for the handling
of devices with no runtime PM support in a meaningful way.

Thanks!




