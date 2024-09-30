Return-Path: <linux-pci+bounces-13645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E6498A355
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF5028228A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD63191F94;
	Mon, 30 Sep 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IP0G/DQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F318E777;
	Mon, 30 Sep 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700288; cv=none; b=IaawRkhoWVwHgndFg16Wa+6Oox3iBr1SozE/zZ3nzIitGlkwSr4exGyZOwrKGRO9XkQd7p8UFZ44hPE8nv4KLqbuKG6bB5cLx7LunotUIjdvhzaRqiXJOczj9YfxP/06U85ncqhOovWFIVo8r1pBzE+GoPagvGRwylMou3eIslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700288; c=relaxed/simple;
	bh=IReanmSWLd3b00W7N/qiJ5ZQYXmlydCyWLLtmq8jQq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rnZPlMTMlOAZx1GspRFzaaiURJyIbBbAEgZIB6VL5fH1NxFxbxMJoqI6JcfXoVo0Q/pRBv2gf3BN59ha7jYxcuUTLCbr23+LGEC80OrgrNB9MO5eYjB+mPOM8hZc1tliaPZeyWcWLZJIRrtu9osRzpJ0i24wzFom+aMaisH4goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IP0G/DQy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727700287; x=1759236287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IReanmSWLd3b00W7N/qiJ5ZQYXmlydCyWLLtmq8jQq0=;
  b=IP0G/DQyYKH+t3LkS4BEKnc+2fKTDuqqr1ReYuq7pIerzWXCLnEU6wkS
   oboZcycFeke7JY2lsbKUKTGDukiksw1UlSHvRI4Nh6i+W69FDV/GlwFPB
   In6nEXj3QlE/jsG3EsV6bp9tCwRrDwTnPMSxM0OczhPxd76d9GnAWSZ6s
   lQGGwW9xlEqDi1SyX0L+tc5LdKEVwFpLDqZ35cnZTEeMsbvFetjcK+6De
   sZnQEjWR+iXvgsi7ogh2uwHjqcIbYQQmGjrlEIx6wxXYN0eKk1S2c8TlE
   c1ShRrco9IdWJsyPM+q1MOE1O3Rtp8yxYD0vvw1bzb0D1VeYAYLttKHqZ
   w==;
X-CSE-ConnectionGUID: R2aP91sGRgGejr1aLWeH/w==
X-CSE-MsgGUID: ykHO7DQgSG6K0kobdTe5Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30581219"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="30581219"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:44:46 -0700
X-CSE-ConnectionGUID: 1wmUZtGeTzS4hcQ2uI8Dlw==
X-CSE-MsgGUID: CxQCXpvXSiqJZp5j91uuvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73690541"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:44:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: hotplug: Remove "Returns" kerneldoc from void functions
Date: Mon, 30 Sep 2024 15:44:36 +0300
Message-Id: <20240930124436.17908-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_hp_deregister() was converted to void by the commit 51bbf9bee34f
("PCI: hotplug: Demidlayer registration with the core") but its
kerneldoc still describes the return value. pci_hp_del() and
pci_hp_destroy() have been void since they were introduced in that same
commit.

Remove the return value description from the kerneldoc of those
functions.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 058d5937d8a9..69b18b07f60a 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -498,8 +498,6 @@ EXPORT_SYMBOL_GPL(pci_hp_add);
  *
  * The @slot must have been registered with the pci hotplug subsystem
  * previously with a call to pci_hp_register().
- *
- * Returns 0 if successful, anything else for an error.
  */
 void pci_hp_deregister(struct hotplug_slot *slot)
 {
@@ -513,8 +511,6 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
  * @slot: pointer to the &struct hotplug_slot to unpublish
  *
  * Remove a hotplug slot's sysfs interface.
- *
- * Returns 0 on success or a negative int on error.
  */
 void pci_hp_del(struct hotplug_slot *slot)
 {
@@ -545,8 +541,6 @@ EXPORT_SYMBOL_GPL(pci_hp_del);
  * the driver may no longer invoke hotplug_slot_name() to get the slot's
  * unique name.  The driver no longer needs to handle a ->reset_slot callback
  * from this point on.
- *
- * Returns 0 on success or a negative int on error.
  */
 void pci_hp_destroy(struct hotplug_slot *slot)
 {
-- 
2.39.5


