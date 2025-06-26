Return-Path: <linux-pci+bounces-30809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C781BAEA524
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69AE4E2164
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C72F0E48;
	Thu, 26 Jun 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="T0n6IXdY"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A92F0C47;
	Thu, 26 Jun 2025 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961754; cv=none; b=YLpjBMj3eVznpnKLyOoIB0yqh//9BiRSjGinPKSytp7qk3vP5gncA7RF+FhRf2m9Ujsie01pG+BfrdPXvWN/svHfVmZCfYyTs/KJ6tOXsqrAVGf9NDpKQzabfSPBQKfVz1I01djf65JPbHd+yAsiExz6nTLYrNTRjyaQ0K6s+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961754; c=relaxed/simple;
	bh=wINTbjSgE4hGTShU/WIi/YnLh3esbBO5/BZuSV/Ss6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUzSbuMImzY9aJIwa1baPvyuD2W2g61u7GTVpCk7cqDyRcoyg9GIFtsu0ZahkIspxXf/AgPgLiMEd5TMqs2iSq6fVVLh0id06X4ikkwzO1jsEx4z4snZhyEDQ6Yq/q2NciEdlsOXMT98nNBynKdUPI2LybJ1M8NgD3T/S8U9Exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=T0n6IXdY; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0363066E9B3;
	Thu, 26 Jun 2025 20:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961751;
	bh=wINTbjSgE4hGTShU/WIi/YnLh3esbBO5/BZuSV/Ss6M=;
	h=From:Subject:Date;
	b=T0n6IXdYhMe/hcTSZCIsnX40sD0W5OiXNCgZZ3WP7anD3JaJnT7P8A7fg3t8zHNlL
	 zzsXVKEEPTNdsLeqAKOBVY+0EN05ZNFevW4aSSBFsqMq0FdW4ieCobGpJWrlnfVtW0
	 aac/f8la00px9KphVgclu3zU6DbOctwb6nTA0uDcYHF6F8RlVqJlKif5UR8xpjH26i
	 R5ic7GUgFAi2xNoZBqMcYcYvRu8gkkZRzKULalW4oCioRDZ1RWf5yeJZxqoU47tJNu
	 4aBGpxz1d2J+m8WFfu6yfl444zmDzjWp69NjGlPqt+tNh+iJBK9n/2b+s9KI284ElG
	 9pzG2ePCwDRRA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 0/9] PM: Reconcile different driver options for runtime PM
 integration with system sleep
Date: Thu, 26 Jun 2025 19:56:15 +0200
Message-ID: <5015172.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTERS9BO6oFQrrKZvnjMLMhdxIjD6XTwY2np/2vb7rNOSSHXNNt9K8uhYOcu0GDQLMt+XBrMOqWs4K95ZBhlK8LjOX4FCYPC9tKINH38R6K+WTYb2AiWSb5pM4nk++djRgOCEoUDu5vU2Nt+trUEnM0akRY0i33LV3dxLykM/H0odvvgRjjlgeNZPkA1LEPZexEERpLMGCoqxV/VJx4JxSR7Vg80JzNeL2yXO0Mmf0et8u9bNy55ikrF8ic0eAo2pKFhaxz3IWgZYTdsTxlR3iEnQk4YYNSBE+MHpyS/+ATIWG1EqnktUYq0D3wtjTcsLEQCgMyhr/gN0TdAb/7/JLuTYTZULX/yzzRqEGd4iAn1bkDUw7W4Q/vy4BBLKp4rMPIxo+QqNnAsrLAgytIhhLs92YCVsx/aU8EpVN0sY4cTBeFJRRMUxK1F1a+gxCpkMrq+OqnD2YiR0oZEozpP4c1FFtxpR9aelDojZIsJ0uy+1l3sjqLgQS2doExld/C1Dp0ulMbAK9qw7QfOoNkVeVrjSUFiNtPjg8ZUoqIaOyEoRVkUCq3LdwaHbvizvqsoSuJ5oHOxnVemfWVibLeqL9HfUp3jpe3acOz+rpimarciXk5IozFrh+JTvXypls7ks5WdOJ5tGJYUhS/xib1wVgS2CCzDZqeCBavwsiUphwiNsQ
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This is an update of the series posted yesterday:

https://lore.kernel.org/linux-pm/22759968.EfDdHjke4D@rjwysocki.net/

which first of all fixes the patch numbering and makes some changes
resulting from the following discussion.

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

Patch [2/9], new in this version, makes pm_runtime_reinit() clear
needs_force_resume in case it was set during driver remove.

Patch [3/9] (which was [4/9] in v1) puts pm_runtime_force_resume() and one
other function that is only used during system sleep transitions under
CONFIG_PM_SLEEP.

Patch [4/9] (which was [2/9] in v1) makes pm_runtime_force_suspend() check
needs_force_resume along with the device's runtime PM status upfront, and bail
out if it is set, which allows runtime PM status updates to be eliminated from
both that function and pm_runtime_force_resume().

Patch [5/9] (which was [3/9] in v1) causes the smart_suspend flag to be taken
into account by pm_runtime_force_resume() which allows it to resume devices
with smart_suspend set whose runtime PM status has been changed to RPM_ACTIVE
by the PM core at the beginning of system resume.  After this patch, drivers
that use pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND
which may be useful, for example, if devices handled by them are involved in
dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.

Patch [6/9] (which effectively is new in v2 because it was not submitted
previously by mistake) makes the code for getting a runtime PM callback for a
device a bit more straightforward in preparation for the subsequent changes.

Patch [7/9] introduces a new device PM flag called strict_midlayer that
can be set by middle layer code which doesn't want its runtime PM
callbacks to be used during system-wide PM transitions, like the PCI bus
type and the ACPI PM domain, and updates pm_runtime_force_suspend/resume()
to take that flag into account.

Patch [8/9] modifies the ACPI PM "prepare" and "complete" callback functions,
used by the general ACPI PM domain and by the ACPI LPSS PM domain, to set and
clear strict_midlayer, respectively, which allows drivers collaborating with it
to use pm_runtime_force_suspend/resume().

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
these functions from their suspend callbacks).

As usual, please refer to individual patch changelogs for more details.

Thanks!




