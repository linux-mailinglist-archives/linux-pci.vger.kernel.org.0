Return-Path: <linux-pci+bounces-30652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB4AE8EA3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D256B3B867B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA292E337E;
	Wed, 25 Jun 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="QWjWKb8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E922E06CB;
	Wed, 25 Jun 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879553; cv=none; b=PGs5vgYm/XqFVqyCoF38gJyYrWLRtvvgt1VYt7wO3L1zpm/i6YX96Cl9Izk9pWeD0oA2nKzhCuNKd3d0nYGx0yt/wF7QuFHYdEdxaWgdkvoLSepDJ2hPTJ8NDueBRWGNOwW1/TdlVyNxwQT++ZWuAjpOvSXwB6u4KaSAUxhe6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879553; c=relaxed/simple;
	bh=hmrKts0Cj5W0Nq/BZNCa1eR3tuKdtdeIKoLG3NRiGOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKRqY+TuWY2ojlc1XFmDfquQ5YO930OwuFclyUMMCZXFp3emmdP4NGYF5n2r0IHUIwUSvsCJiaAtHBoUa2O5+CEBOS4gD1WvHmMem4i6vjeVaRwFJ/0Z/BHYU7BCp8xn8/HKrEz3xj/7my3jNdtizl91g6iDPXbkBwVvc4iW89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=QWjWKb8k; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F2FCA66E81B;
	Wed, 25 Jun 2025 21:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879547;
	bh=hmrKts0Cj5W0Nq/BZNCa1eR3tuKdtdeIKoLG3NRiGOQ=;
	h=From:Subject:Date;
	b=QWjWKb8kjgJAe5MM8mnD7FCCICRawJecc+y+G8Vri5UUqmeYPCucE2MAmxk6nsqoW
	 lkMiziGdNlfTGRVx05tTMJPj3qLMej7Yu1siidZ3Sh3SgpQ/UHPGNC0h/kpZXhzBli
	 HHhXI29iI4MT4YiTRB3DeNZiHHGB8nrQ8W5N9JeNeKjiT6DXotIizOY1edhqzesmeH
	 pP2AAFKiuraIWd/rY43t2fu/wJhHEhr3qmMzavrtbmO+MzKkNsJ1BD2DyDHP/aT3Hd
	 iDoeGWKPxKrhFV8zMIdgGcrbD/s+v1YvGmWXes7O0tZxl28PTyPKtsceYwx11qxpzL
	 PRyDkbsZlVWCg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 0/9] PM: Reconcile different driver options for runtime PM
 integration with system sleep
Date: Wed, 25 Jun 2025 21:14:49 +0200
Message-ID: <22759968.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTE5RyGhYEnHKx0FDugxbJmCauj5vYnYws48HjIhwkhXJIvFh9Qz8A3kiS3Rl6dQYOtmcKcRmnGzimuTmjw1uDJMOjQZUdFpWBn+d6wykJwlUNqhFD3l0irdhng27N06IRY3qi/I3q90b26XqOrlbON3RLb4gIi1zrVyDD4clJf/azOQcDVYdgTMc9KbWgZNdm5NjCzxZbrne92LZ/dueTMYMm5U9aYl1x0R+t+BVYNpH023sP/UVLouANhfxoQ68ovBTHGKTI9h3reC8oQ0DzmF1Du1IDnkA7M4Y/gAq1X2Ehx7syvr/teP+YHR/a/cqgLXQfT1DddfQqncTqNzIyiVGOMKlZWO9T7bB8f5hetCkn8VAGt8Vx4j++VWN9Xclnk0sGrmo0xGiWSqXH/Tozb04B4Ie7ccc1nIyeYSniDEDP0MCvCYBKFdhaourSaSX3E2AwKYNuCuDwMvN/QA6is/ky6yBSZQTOlfIxTh9sOmY6f+n5N4eYeRykAHQSkkSGBU6o4TZ5QB1uLuKVOhNN+45gybkIlfeFMtl/y/KLGg2oHQX1mWc95oUHXohK8Qx6YA77kBiqgCiAjzuGz7g4nutfjzLfkMwcDH6XAckLKPjBK0z6/vJi5nU7vPs8XUFfv+EmQjYm/T02tbMSfuEy6EMwZTHeJ56GE0LPRlzYnQkQ
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This series addresses a couple of issues related to the integration of runtime
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
'false' as needs_force_resume flag values for consistency.

Patch [2/9] makes pm_runtime_force_suspend() check needs_force_resume along
with the device's runtime PM status upfront, and bail out if it is set,
which allows runtime PM status updates to be eliminated from both that function
and pm_runtime_force_resume().

Patch [3/9] causes the smart_suspend flag to be taken into account by
pm_runtime_force_resume() which allows it to resume devices with smart_suspend
set whose runtime PM status has been changed to RPM_ACTIVE by the PM core at
the beginning of system resume.  After this patch, drivers that use
pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_SUSPEND which
may be useful, for example, if devices handled by them are involved in
dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.

The next two patches, [4-5/9], put pm_runtime_force_suspend/resume()
and needs_force_resume under CONFIG_PM_SLEEP for consistency and also
because using them outside system-wide PM transitions really doesn't make
sense.

Patch [6/9] makes the code for getting a runtime PM callback for a device
a bit more straightforward in preparation for the subsequent changes.

Patch [7/9] introduces a new device PM flag called strict_midlayer that
can be set by middle layer code which doesn't want its runtime PM
callbacks to be used during system-wide PM transitions, like the PCI bus
type and the ACPI PM domain, and updates pm_runtime_force_suspend/resume()
to take that flag into account.

Patch [8/9] modifies the general ACPI PM domain to use strict_midlayer
which allows drivers collaborating with it to use pm_runtime_force_suspend/resume().
That may be useful if such a driver wants to be able to work with different
PM domains on different systems.  It may want to work with the general ACPI PM
domain on systems using ACPI, or with another PM domain (or even multiple PM
domains at the same time) on systems without ACPI, and it may want to use
pm_runtime_force_suspend/resume() as its system-wide PM callbacks.

Patch [9/9] updates the PCI bus type to set strict_midlayer for all PCI devices
in case some PCI drivers want to use pm_runtime_force_suspend/resume() in the
future.  They will still need to set DPM_FLAG_SMART_SUSPEND to avoid resuming
their devices during system suspend, but now they may also use
pm_runtime_force_suspend/resume() as suspend callbacks for the "regular suspend"
phase of device suspend (or invoke these functions from their suspend callbacks).

As usual, please refer to individual patch changelogs for more details.

Thanks!




