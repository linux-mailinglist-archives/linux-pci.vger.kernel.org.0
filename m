Return-Path: <linux-pci+bounces-4518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC12871E2E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A26B20B39
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916357333;
	Tue,  5 Mar 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZmY4lgUL"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767E54910;
	Tue,  5 Mar 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639144; cv=none; b=SPHPNDmEoIFklrYV7mKzq4QTyA32ARNy0t5Ke2pZDstdb0Bjdg0edr/5hKU7vvdpNNLo3sE0iCLsacFANyDjOMeWNOXNDNdQxg4qvHQhKDRtsvSUPVebXedsl9LExXWxHhZ+5TM64uL56n+4PhA0rvKEybWKA33JLINPShh6Xhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639144; c=relaxed/simple;
	bh=FHUHlLigDUUjjEfAgynun0/iQyt0bpAOryZ/isN6/Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+R0ilkiRV8QabhzyksteLNI7vN/2u5XOchkPGBkM1TCpyyPi+HBbVEG3OqUZ44X7Bi1rKj1AifOBidqyfRZVQU1SjQCHzfpCnbbB5LZr0ysTDPnyCA/1TXKN5d72prR8ruYZJv2H8QiZM6s8RnMl7des0Nxz7657Ouekc8Mm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZmY4lgUL reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 774bf1c7206d9c9b; Tue, 5 Mar 2024 11:45:39 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D152C66AA0C;
	Tue,  5 Mar 2024 11:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1709635539;
	bh=FHUHlLigDUUjjEfAgynun0/iQyt0bpAOryZ/isN6/Cw=;
	h=From:To:Cc:Subject:Date;
	b=ZmY4lgULCHBNmKGSZrEKSFDn7qZkfBnuwQiT6SudrIYceXh7lJpAlIWnOpyP4yqx8
	 Q9YiCUEYFjcEMaKdnD6M4F8LDPyfGDm/uBy/F/MqDL9S7wHKSfL4XLyHuYTB5akHM6
	 TeTBuWaet63AqwC328mM1yA0KPr4tFkDxCuBH+FXfeJLD7XkHvFwTd/MNirNM0K0yc
	 b6mbgbv97F9I+UHX7Twkhp8O8R2BgpFNKNJEjQe8pgJ68TpVl3izmc8CqQFYAoPltY
	 7SPMHmNm2OhTe5GVrZ37bPR05fxHkDwlj7pMfPvyRZo1oi4FRae0r38KA2yreDogsp
	 Rv9IY9yYHZgtw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ricky Wu <ricky_wu@realtek.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject:
 [PATCH v1] PM: runtime: PCI: Drain runtime-idle callbacks before driver
 removal
Date: Tue, 05 Mar 2024 11:45:38 +0100
Message-ID: <5761426.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghl
 rdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A race condition between the .runtime_idle() callback and the .remove()
callback in the rtsx_pcr PCI driver leads to a kernel crash due to an
unhandled page fault [1].

The problem is that rtsx_pci_runtime_idle() is not expected to be
running after pm_runtime_get_sync() has been called, but the latter
doesn't really guarantee that.  It only guarantees that the suspend
and resume callbacks will not be running when it returns.

However, if a .runtime_idle() callback is already running when
pm_runtime_get_sync() is called, the latter will notice that the
runtime PM status of the device is RPM_ACTIVE and it will return right
away without waiting for the former to complete.  In fact, it cannot
wait for .runtime_idle() to complete because it may be called from that
callback (it arguably does not make much sense to do that, but it is not
strictly prohibited).

Thus in general, whoever is providing a .runtime_idle() callback, they
need to protect it from running in parallel with whatever code runs
after pm_runtime_get_sync().  [Note that .runtime_idle() will not start
after pm_runtime_get_sync() has returned, but it may continue running
then if it has started earlier already.]

One way to address that race condition is to call pm_runtime_barrier()
after pm_runtime_get_sync() (not before it, because a nonzero value of
the runtime PM usage counter is necessary to prevent runtime PM
callbacks from being invoked) to wait for the runtime-idle callback to
complete should it be running at that point.  A suitable place for
doing that is in pci_device_remove() which calls pm_runtime_get_sync()
before removing the driver, so it may as well call pm_runtime_barrier()
subsequently, which will prevent the race in question from occurring,
not just in the rtsx_pcr driver, but in any PCI drivers providing
runtime-idle callbacks.

Link: https://lore.kernel.org/lkml/20240229062201.49500-1-kai.heng.feng@canonical.com/ # [1]
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Ricky Wu <ricky_wu@realtek.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -473,6 +473,13 @@ static void pci_device_remove(struct dev
 
 	if (drv->remove) {
 		pm_runtime_get_sync(dev);
+		/*
+		 * If the driver provides a .runtime_idle() callback and it has
+		 * started to run already, it may continue to run in parallel
+		 * with the code below, so wait until all of the runtime PM
+		 * activity has completed.
+		 */
+		pm_runtime_barrier(dev);
 		drv->remove(pci_dev);
 		pm_runtime_put_noidle(dev);
 	}




