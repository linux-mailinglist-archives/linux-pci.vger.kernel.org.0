Return-Path: <linux-pci+bounces-35106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4CB3BC1E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13543AFE99
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084A31E103;
	Fri, 29 Aug 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpZYi9LR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726E31B11E;
	Fri, 29 Aug 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473152; cv=none; b=IjQ748DZu2t9Zg+0zlrQwayVNaGT9eALJ8VyAe4iPA9q9BipaBcvxosqkltGUKfELgHlzDh8jgxMBHrZlBqraWvnJ64y4ytN3nmNXkml2UN50lLDz7Eqr0LK8PrONuYrUwCyZKKyo7taUQzOBtw9ksjFL50PPK5VfeOEYQscwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473152; c=relaxed/simple;
	bh=Eo72xAv7jghx9O6Fsf3ThNl0hq7XmmdALUKezO79nNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIw6B7gZAF60H8bhk6VkCYPY9xKzoIZ0uV3PrSc8bJGfQsSbR+6t09awdHCnVuwQy12FJARE4QqqRafzWJBZsppvD/jhZqTkKemD68s9Ah7EfMdCAdSM4PypzQz2G3DrC1JPU9ff8hIKmvtyY0wtsxsyxj+fsyMLTulxirEpHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpZYi9LR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473151; x=1788009151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eo72xAv7jghx9O6Fsf3ThNl0hq7XmmdALUKezO79nNI=;
  b=MpZYi9LR0amAAZ/KR8VIRL2nQxuG9fi8MtiWJGKxVZyZU60QH5BUobYQ
   PKinEaEubGOnjesc2oCBllJae47D8pr0zBcfZDbJ0Y25cvYEVcxuGv2h0
   uoGhwVNR/CPYVBrrDfk3TcoZaTKu6RO/TeADbll6aKTau/7RsLvGEiVOy
   bOzMWIpolLXg5Uw7Om46g998pkacTq0AhsL+ze304BRfkWMwhEKevekY0
   O+mPRKoZp9BQV3SW+ZDwHD73rTdQIZDELMCip2MrdSaFDei9AfuD9WlrG
   +G80iPFfBykoyKgekoUZFH1MIgRIV3+AYyvua9n07yEBkf9kAX8SMfgdJ
   g==;
X-CSE-ConnectionGUID: HyUyHEZTRV+M7WpVkptGOg==
X-CSE-MsgGUID: PRyqODZDS5W5lwX2+xN0tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62402952"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62402952"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:30 -0700
X-CSE-ConnectionGUID: fBAOgl62SbaSgmv6/ue0zQ==
X-CSE-MsgGUID: D/IWJmtrQTS76zWdtVSldw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169946740"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/24] PCI: Enable bridge even if bridge window fails to assign
Date: Fri, 29 Aug 2025 16:10:58 +0300
Message-Id: <20250829131113.36754-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A normal PCI bridge has multiple bridge windows and not all of them are
always required by devices underneath the bridge. If a Root Port or bridge
does not have a device underneath, no bridge windows get assigned. Yet,
pci_enable_resources() is set to fail indiscriminantly on any resource
assignment failure if the resource is not known to be optional.

In practice, the code in pci_enable_resources() is currently largely
dormant. The kernel sets resource flags to zero for any unused bridge
window and resets flags to zero in case of an resource assignment failure,
which short-circuits pci_enable_resources() because of this check:

  if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
    continue;

However, an upcoming change to resource flags will alter how bridge window
resource flags behave activating these long dormants checks in
pci_enable_resources().

While complex logic could be built to selectively enable a bridge only
under some conditions, a few versions of such logic were tried during
development of this change and none of them worked satisfactorily. Thus, I
just gave up and decided to enable any bridge regardless of the bridge
windows as there seems to be no clear benefit from not enabling it, but a
major downside as pcieport will not be probed for the bridge if it's not
enabled.

Therefore, change pci_enable_resources() to not check if bridge window
resources remain unassigned. Resource assignment failures are pretty noisy
already so there is no need to log that for bridge windows in
pci_enable_resources().

Ignoring bridge window failures hopefully prevents an obvious source of
regressions when the upcoming change that no longer clears resource flags
for bridge windows is enacted. I've hit this problem even during my own
testing on multiple occasions so I expect it to be a quite common problem.

This can always be revisited later if somebody thinks the enable check for
bridges is not strict enough, but expect a mind-boggling number of
regressions from such a change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 0468c058b598..4e0e60256f04 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -527,22 +527,26 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 		if (pci_resource_is_optional(dev, i))
 			continue;
 
-		if (r->flags & IORESOURCE_UNSET) {
-			pci_err(dev, "%s %pR: not assigned; can't enable device\n",
-				r_name, r);
-			return -EINVAL;
+		if (i < PCI_BRIDGE_RESOURCES) {
+			if (r->flags & IORESOURCE_UNSET) {
+				pci_err(dev, "%s %pR: not assigned; can't enable device\n",
+					r_name, r);
+				return -EINVAL;
+			}
+
+			if (!r->parent) {
+				pci_err(dev, "%s %pR: not claimed; can't enable device\n",
+					r_name, r);
+				return -EINVAL;
+			}
 		}
 
-		if (!r->parent) {
-			pci_err(dev, "%s %pR: not claimed; can't enable device\n",
-				r_name, r);
-			return -EINVAL;
+		if (r->parent) {
+			if (r->flags & IORESOURCE_IO)
+				cmd |= PCI_COMMAND_IO;
+			if (r->flags & IORESOURCE_MEM)
+				cmd |= PCI_COMMAND_MEMORY;
 		}
-
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
 	}
 
 	if (cmd != old_cmd) {
-- 
2.39.5


