Return-Path: <linux-pci+bounces-30965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D8AEBFF6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903197B81CD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51A2EF64D;
	Fri, 27 Jun 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="p6nHofRL"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF952EE5E5;
	Fri, 27 Jun 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052590; cv=none; b=hSdH5v7yy6j09Z0QiAg4Gb7iwHRTHKMACh83vQt993Qkbgm2ioipbxSexSUi+6rj+wJ2sLsjwFhABFuqGuFGaQQ80wHfssoQo9Vwsp3s9s4ai3fzdVwAqYsiutsbePi4dILpxCmyFphdVyQiY8QDupW/Sr08Hkb/5NZODzBk4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052590; c=relaxed/simple;
	bh=QfilRFKxPkwDTkuD2yLSb1hp0x9K9JFAolcqxDlnkaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/wJU5Usa0CN/lHgc1FXCemyUFyNb6QPM5zoDndCFRodnsXye4X275Q6bnKROEiaGy1IigGV1KqtKQh+C+EnD/vV9ctOm5z1m8wGnTN+v+ss00HzGR1pW7EgJVm6Qib+hZcCBVWf+CQbqZxV5WJw/ClNfT7fYOTEhMtcUKJC9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=p6nHofRL; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DA3E066DF60;
	Fri, 27 Jun 2025 21:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052584;
	bh=QfilRFKxPkwDTkuD2yLSb1hp0x9K9JFAolcqxDlnkaw=;
	h=From:Subject:Date;
	b=p6nHofRLHkYyuGJ7js9/O6SMgc4xfvTvDD57ORQzCOwIwiCdg/bpvffOmp4Y8ktwm
	 Kbe2hZZFGX5wYL181az8epNsMgm8h++mEcoukFBzjQTudbTH9YMLLdIh0e1cg4cDsD
	 DcVAxI9uHclz+SfvAyuPrhgVvYGgHZ5hFH+5gd1cfyoCuW9JvwXCaFzX48t6ueXWuG
	 ZfE62N9OS2ToraZ0Sq75D2uRxsN9Um3m3a9b47m0REdD21xniGNDdn0J62ywGvh87h
	 L3zZUeMpK7bMBpkp+ee+w1iL8YM36hklXrp+5JvDCgM61AMsqukr78IIWF26EmNlF/
	 mYiQY7iOCl3jg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 0/9] PM: Reconcile different driver options for runtime PM
 integration with system sleep
Date: Fri, 27 Jun 2025 21:05:05 +0200
Message-ID: <5018768.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTErU7IP/L2efhEPSxvFHGkD9H9880XNxizk/z/A8YVVMbbIx0WG/w6MjmzKZxgcpK9Lgs33vwksAjNGtA3gD2ptkGJNKkRFvzx7qiz6rLp9KHp4OeAgwk3cC3ARW/d4ZOJ811QaNuBI6uJRGkMMOn8IajDBvVPlN9ndBOsScnvwrVRmHEpqU+jYPrMCL/vHsusZWXogLlvKzLWF8M2E+x0QnkSFzjZ0/mTcG3gRbH8bfAr5T9DgEM1AhTL144KZkKWOsiBuhxyt4dB0sNbm3+L1Pjfrq42aP9Jk8sDe3dlf20hto8JCZ8XS0oeIQXnq1V4+ZcCuStFp9Alhu3stSMchVCENycDm/x87k7kz0M1Vf/3glcn2yvUq282T7uf0GkbaQq1BOq2JdKyhQM66vmreTKJJ3pMqqqC/iTH5u8nD5Y86z60ud4q432ahcpBu/7sSOkimxZJRHB+7S8JYzqPikzTABa1N8PelnrT4MKdx2iPy53Grqy+itZ1E9DqLRB67fC2gb4fA18Zg6jz0/2RhXgABGfPX4ZVQbjiPeFsyNw53ijN836E1QYNwDLsRoaGEjzJE9lPik6Kg0+o1ATnV9OrpUJ5RVguIvnIlnuWb+lBHGoVDAaxNXp5VD8xsFh0Id25efm67YC8VWUdfOZo79JJKomc/Jr6mIMt+J0ORVw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This is an update of the series the v2 of which was posted yesterday:

https://lore.kernel.org/linux-pm/5015172.GXAFRqVoOG@rjwysocki.net/

and the v1 is here:

https://lore.kernel.org/linux-pm/22759968.EfDdHjke4D@rjwysocki.net/

This update reorders the patches (again), updates the changelogs of some of
them and changes the subject of one patch slightly.  It also adds a kerneldoc
comment to a new function in patch [5/9].

This part of the cover letter still applies:

"This series addresses a couple of issues related to the integration of runtime
PM with system sleep I was talking about at the OSMP-summit 2025:

https://lwn.net/Articles/1021332/

Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
pm_runtime_force_suspend/resume() due to some conflicting expectations
about the handling of device runtime PM status between these functions
and the PM core.

Also pm_runtime_force_suspend/resume() currently cannot be used in PCI
drivers and in drivers that collaborate with the general ACPI PM domain
because they both don't expect their mid-layer runtime PM callbacks to
be invoked during system-wide suspend and resume.

Patch [1/9] is a preparatory cleanup changing the code to use 'true' and
'false' as needs_force_resume flag values for consistency."

Patch [2/9] (which was [3/9] in v2) puts pm_runtime_force_resume() and one
other function that is only used during system sleep transitions under
CONFIG_PM_SLEEP.

Patch [3/9] (which was [5/9] in v2) causes the smart_suspend flag to be taken
into account by pm_runtime_force_resume() which allows it to resume devices
with smart_suspend set whose runtime PM status has been changed to RPM_ACTIVE
by the PM core at the beginning of system resume.  After this patch, drivers
that use pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND
which may be useful, for example, if devices handled by them are involved in
dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.

Since patches [1,3/9] have been reviewed already and patch [2/9] should not
be particularly controversial, I think that patches [1-3/9] are good to go.

Patch [4/9] (which was [2/9] in v2), makes pm_runtime_reinit() clear
needs_force_resume in case it was set during driver remove.

Patch [5/9] (which was [4/9] in v2) makes pm_runtime_force_suspend() check
needs_force_resume along with the device's runtime PM status upfront, and bail
out if it is set, which allows runtime PM status updates to be eliminated from
both that function and pm_runtime_force_resume().  I recalled too late that
it was actually necessary for the PCI PM and ACPI PM to work with
pm_runtime_force_suspend() correctly after the subsequent changes and that
patch [3/9] did not depend on it.  I have also realized that patch [5/9]
potentially unbreaks drivers that call pm_runtime_force_suspend() from their
"remove" callbacks (see the patch changelog for a bit of an explanation).

Patch [6/9] (which has not been changed since v2) makes the code for getting a
runtime PM callback for a device a bit more straightforward, in preparation for
the subsequent changes.

Patch [7/9] introduces a new device PM flag called strict_midlayer that
can be set by middle layer code which doesn't want its runtime PM
callbacks to be used during system-wide PM transitions, like the PCI bus
type and the ACPI PM domain, and updates pm_runtime_force_suspend/resume()
to take that flag into account.  Its changelog has been updated since v2 and
there is a new kerneldoc comment for dev_pm_set_strict_midlayer().

Patch [8/9] modifies the ACPI PM "prepare" and "complete" callback functions,
used by the general ACPI PM domain and by the ACPI LPSS PM domain, to set and
clear strict_midlayer, respectively, which allows drivers collaborating with it
to use pm_runtime_force_suspend/resume().  The changelog of this patch has been
made a bit more precise since v2.

That may be useful if such a driver wants to be able to work with different
PM domains on different systems.  It may want to work with the general ACPI PM
domain on systems using ACPI, or with another PM domain (or even multiple PM
domains at the same time) on systems without ACPI, and it may want to use
pm_runtime_force_suspend/resume() as its system-wide PM callbacks.

Patch [9/9] updates the PCI bus type to set and clear, respectively, strict_midlayer
for all PCI devices in its "prepare" and "complete" PM callbacks, in case some
PCI drivers want to use pm_runtime_force_suspend/resume() in the future.  They
will still need to set DPM_FLAG_SMART_SUSPEND to avoid resuming their devices during
system suspend, but now they may also use pm_runtime_force_suspend/resume() as
suspend callbacks for the "regular suspend" phase of device suspend (or invoke
these functions from their suspend callbacks).  The changelog of this patch has
been made a bit more precise since v2, like the changelog of patch [8/9].

As usual, please refer to individual patch changelogs for more details.

Thanks!





