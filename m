Return-Path: <linux-pci+bounces-23637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B13A5F7E5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754663BFF41
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD4267B87;
	Thu, 13 Mar 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekJan3Iz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301A11CA9;
	Thu, 13 Mar 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875831; cv=none; b=cl98+EGB7njOvOILvoKi/okdPk+wJW+suqfKs3hptlxYLliKk808M8GwufzdpHpCAwljF4aWii7oJlpW/eO4fuJygOEQ2WniGLHcywge+bhZPMKltpn0/vIowzYIFC5Hxm9wEIF70IUi+epwH5G3Ewj/LAoAqfM2jGZg741h7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875831; c=relaxed/simple;
	bh=2fdbuVhPg4Vhlm8L304BHMT/y8IBVAmlG1rv8SPh6C0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Or/Fk9ZZyqef8CFHkd3GCh0j4MfHM7lZewwY39Fzs9yFoigMqoi2aOCIUlCRo7OhUzvmQpAjm4gjENhZVWYchz+Cc0OwV75ZFn6IH2wUlAs/ON9QyJJKw8A+JNjrMNt2kBrtq31tgMLdzA5gaNfFCQR8bVfyT3Cay+4bN8hZ0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekJan3Iz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875830; x=1773411830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2fdbuVhPg4Vhlm8L304BHMT/y8IBVAmlG1rv8SPh6C0=;
  b=ekJan3Izup1P3ncLs8v6MPb5sKt/qM/zYdVy0EcqTzjCgzPm784Zh2DK
   rBvDi38zriTlIU5XNyJQZGxaIgkMV0MOCcYGWYMUzRwrs7AhZvitxfHfu
   GVwuI/1sipdtIHuLb0EvQGzNFWP7TXkfZY/826IVXjhaYCvu9JnnGZkQw
   EDdv5z72XAjEbkrBuO2Dqu4qJAhmk8epBv8ToTzj1Q7uhuWOXMT9It1So
   87KxTHXPGtTwCdNjZk8M6xnaeK85q0wK0C3OWvfBaUg6hhnNigOSiRy10
   4o4DpTmKXnvuAqMqP2gQJ8QHTYrbjm4DLBjIh0u45Vel8MvMygLrtJy8x
   Q==;
X-CSE-ConnectionGUID: seVfd9NsTWisF8ys0ELRjw==
X-CSE-MsgGUID: f7uG+Sb4RBOYVH9xAiBILQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173436"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173436"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:23:49 -0700
X-CSE-ConnectionGUID: JQHWou4WRxS2Kt/oHxIz1A==
X-CSE-MsgGUID: CDSbp1L0RKWO9yWcNLAyeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126027223"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:23:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Guenter Roeck <groeck@juniper.net>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] PCI/hotplug: Fix interrupt / event handling problems
Date: Thu, 13 Mar 2025 16:23:29 +0200
Message-Id: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

It was reported introducing bwctrl broke attaching a PCI device into
VM. I tracked this down to problems in hotplug interrupt and event
handling where hotplug code assumed all events are for it without
proper checking. As a result, the extra interrupts that occurred due to
bwctrl caused hotplug pick events during slot reset due to shared irq
and eventually hotplug unconfigured the card spuriously.

This series fixes the hotplug slot reset so that no hotplug events can
be picked up during slot reset which was the original intention of the
reset code but it failed to synchronize its intention with the
interrupt and event handling.

I've intentionally split the three patches because to be careful and
allow bisect to detect if the two follow up changes make assumptions
that do not hold water, but logically they belong to the same single
change altering the synchronization between the reset slot and hotplug
event handling. It should be technically possible to fold them into the
same change, but I feel there are benefits of keeping them as separate
so bisect can see them as separate changes.

The fourth patch fixes an oversight I found while reading the HPIE
related code and is unrelated to the other three patches.

As there were small changes into the first patch since Joel's test
to address Lukas' comments in the bugzilla thread. I'd prefer him
to test it again, just in case, so I dropped the tested-by tag until
that happens.

Ilpo Järvinen (4):
  PCI/hotplug: Disable HPIE over reset
  PCI/hotplug: Clearing HPIE for the duration of reset is enough
  PCI/hotplug: reset_lock is not required synchronizing with irq thread
  PCI/hotplug: Don't enabled HPIE in poll mode

 drivers/pci/hotplug/pciehp_hpc.c | 39 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


