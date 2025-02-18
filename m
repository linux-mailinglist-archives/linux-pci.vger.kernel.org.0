Return-Path: <linux-pci+bounces-21762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0769A3A89C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364C71890773
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38C1D6193;
	Tue, 18 Feb 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lgunc9eD"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52E1BC065;
	Tue, 18 Feb 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910066; cv=none; b=sdBLqGJRs/0swA9UBu/GLxPqR5qDy3IxSqK+fnfQqrh84d8n5DlI1bptkHTheiF4/cf6YxW216xnEo5gEaD27R5U5JjJWiM0W7QjrXF64i2JfpaxjMrCVYSyvbFmIDhfuxNhAhUEK4sh44LVE7Tn2gqniWqHNSUmdgzR23pAxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910066; c=relaxed/simple;
	bh=i33dTSeYvt6pAnKPn2/SembgQRoq+U8dsM0rlrRnu7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMkZzkSHNZ0sfiz+5VxGcYX2tIc7FiZYy+4CsbO+pAjECy4uSY9MLPlKzphdif9MBdeT4LBDDQpvWhPTIhkr0i1NiJ0LgYCqFr6N4yerFPgkThzsxI4Co+fkfYghsKsUaM5+otjhQb6kPEWAygDGaJT6g2GsGDeHztRXLZHSXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lgunc9eD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 23ad9d96bbb82d25; Tue, 18 Feb 2025 21:20:55 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2C5C696554D;
	Tue, 18 Feb 2025 21:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739910055;
	bh=i33dTSeYvt6pAnKPn2/SembgQRoq+U8dsM0rlrRnu7A=;
	h=From:Subject:Date;
	b=lgunc9eD88bTKqg9cWDpJ/7t4ju0rsoBrmHuprkNVEUVlIfWoqMQgSEXQojhdTiYn
	 p95x2uZ2b75PX8wO+zQ1pMVZyHL9sxPsPTLgmqHMtpDURw10x1jM4zUFqEXQ8oYiVm
	 xxYkwY3MgQ+BvhaFZ93G/tfXuC7Hu2HkLKRHHwUh9HNsx9bIA4ItsALo0/39n3od9f
	 h2S2QYRdFWYk+wbFH1QP/IuyXWjfViCaJC4BMbQ5bxqd2KdiOP0j0SZbDZpVFF5C8Y
	 RdfCwfy1LxOeQg7kWxv/NjPac2EKco8ul1/PlYtO0QkZ1vz1KLrgsHzKtxmba2Z+2D
	 LdDFQgEV6rBUA==
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
Subject: [PATCH v2 0/4] PM: Use DPM_FLAG_SMART_SUSPEND conditionally
Date: Tue, 18 Feb 2025 21:09:37 +0100
Message-ID: <12612706.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

Hi Everyone,

This is an update of the patch series at

https://lore.kernel.org/linux-pm/4966939.GXAFRqVoOG@rjwysocki.net/

which was a follow-up for

https://lore.kernel.org/linux-pm/2314745.iZASKD2KPV@rjwysocki.net/

This series modifies the PM core and the users of DPM_FLAG_SMART_SUSPEND to
take it into account only if it is consistently used in dependency graphs,
as described in the changelog of patch [3/4].

Patches [1-2/4] are preparatory and they arrange for the handling
of devices with no runtime PM support in a meaningful way.

Patch [4/4] is new in this series and it adds an optimization on top of
the previous patches.

Apart from adding the new patch, this update addresses review comments
in the other patches.

Thanks!




