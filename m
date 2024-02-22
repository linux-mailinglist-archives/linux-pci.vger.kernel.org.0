Return-Path: <linux-pci+bounces-3888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF838603C2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBB81F28038
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592471740;
	Thu, 22 Feb 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtgCmtGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58117175E;
	Thu, 22 Feb 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634463; cv=none; b=iIyv7c6s9CTN9ayuCYvKpYHJaZhX0Q5ZYLxxq+X/ZI56TO7v0sqmOZGbsVChQJYthLFTTUwgv28XEJVjzSzTl46HqHJH0RcHtdK66bmEoUTFqjGaSr+W2pfrYJ/Ve4yfX8O5+zImPzkC0zK8uF8EvvzmiNzXijQMHyA+Cx2znwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634463; c=relaxed/simple;
	bh=r1Jpoa9EFW+a4dM8IBgDTBKhMjLnmgNWSsg+i9Enaak=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS/wngtszLwGDQZG+Bd35O3+31A9ueQweKg0JvArNESItfq5k3LZzw2Lk0+OXQJHqHVqEDJILPHf89UgZ66fZTuRInX7ypajRgktm37TOJQeBt2AaN1CM8qZtUh4owWx+4IDwKeELooH9u9ax4Aka43JZpCR0gdZHNjC/nF6zQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtgCmtGo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708634462; x=1740170462;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1Jpoa9EFW+a4dM8IBgDTBKhMjLnmgNWSsg+i9Enaak=;
  b=CtgCmtGofVpJNvuVVUhLPElfXgw2d+o/p7XrICKZ/LBBTV4kC/bEfwgn
   7J39u/a0b5auTWCEmDQOb1Xltm7aKxpkSMwgG6n5R27GD0kolVqXkyez9
   uT8jhoPv2/+G2HpgOpcgFnvqE38w+KNnjgK98RhBeISwFLY+Ov48CoNMy
   x8WWlKlDNUg9FaXiQyxHvhv6dWCLgASdL0OsLpk2WxkOCOESZycTzRncL
   r4LCBhdLHimN7pGAf+iAby37trUn9wO1WM1Q1BC/WfQxX0uwwSwhrJaQ4
   tXsP+RxjEewS0o5rvVhdGybxnA198gruvDR1M7COmPpqdwU5www1qEsHK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="25358670"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="25358670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913585401"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913585401"
Received: from wyeh-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.77.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:41:00 -0800
Subject: [PATCH 2/3] sysfs: Document new "group visible" helpers
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Date: Thu, 22 Feb 2024 12:41:00 -0800
Message-ID: <170863446065.1479840.10697164014098377292.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add documentation and examples for how to use
DEFINE_SYSFS_GROUP_VISIBLE() and SYSFS_GROUP_VISIBLE(). Recall that the
motivation for this work is that it is easier to reason about the
lifetime of statically defined sysfs attributes that become visible at
device_add() time rather than dynamically adding them later.
DEFINE_SYSFS_GROUP_VISIBLE() tackles one of the reasons to opt for
dynamically created attributes which did not have a facility for hiding
empty directories.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/sysfs.h |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a42642b277dd..dabf7f4f3581 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -105,8 +105,42 @@ struct attribute_group {
 #define SYSFS_GROUP_INVISIBLE	020000
 
 /*
- * The first call to is_visible() in the create / update path may
- * indicate visibility for the entire group
+ * DEFINE_SYSFS_GROUP_VISIBLE(name):
+ *	A helper macro to pair with the assignment of ".is_visible =
+ *	SYSFS_GROUP_VISIBLE(name)", that arranges for the directory
+ *	associated with a named attribute_group to optionally be hidden.
+ *	This allows for static declaration of attribute_groups, and the
+ *	simplification of attribute visibility lifetime that implies,
+ *	without polluting sysfs with empty attribute directories.
+ * Ex.
+ *
+ * static umode_t example_attr_visible(struct kobject *kobj,
+ *                                   struct attribute *attr, int n)
+ * {
+ *       if (example_attr_condition)
+ *               return 0;
+ *       else if (ro_attr_condition)
+ *               return 0444;
+ *       return a->mode;
+ * }
+ *
+ * static bool example_group_visible(struct kobject *kobj)
+ * {
+ *       if (example_group_condition)
+ *               return false;
+ *       return true;
+ * }
+ *
+ * DEFINE_SYSFS_GROUP_VISIBLE(example);
+ *
+ * static struct attribute_group example_group = {
+ *       .name = "example",
+ *       .is_visible = SYSFS_GROUP_VISIBLE(example),
+ *       .attrs = &example_attrs,
+ * };
+ *
+ * Note that it expects <name>_attr_visible and <name>_group_visible to
+ * be defined.
  */
 #define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
 	static inline umode_t sysfs_group_visible_##name(            \
@@ -119,7 +153,9 @@ struct attribute_group {
 
 /*
  * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
- * attributes
+ * attributes. If an attribute_group defines both text and binary
+ * attributes, the group visibility is determined by the function
+ * specified to is_visible() not is_bin_visible()
  */
 #define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                             \
 	static inline umode_t sysfs_group_visible_##name(                \


