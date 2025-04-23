Return-Path: <linux-pci+bounces-26595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E200A99716
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46944A2358
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C328EA44;
	Wed, 23 Apr 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5Eq98EZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7228D830;
	Wed, 23 Apr 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430655; cv=none; b=hY3P2Bj+UZgTYpa5EjHA9s7wc8rsCsbVCDVqq9sVTQJDDANy6FD4707BJS0F+M10KMT2Pt44IVLAUmUWs8vSZryiGKqcehDrbcNWsf+zQ02n4pRCGLdpMltXIOYiuJ7bWhM+eVIS+dtn5jbiLyTqOqIHHgq/AQshpgkdJhYwsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430655; c=relaxed/simple;
	bh=4u53bdRqrxzWq/iPTyUJM9eZJs7UD/VsGD1bWIkiQ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDZQrXyMzAOQDmKCo3XRzn3fYxJVLKU9E/1arHjiQ1+j3/ODY6qvijGKxcN0t5vff8B5KATAnS9AabDB2OZeeOD9fchTuyH3miYq+2xQkBuheoA5nbw/dXVYOLS/XxMXOzGVaH0B/QhjEfE+CiSzCK5XgZLj58JszQKa379FR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5Eq98EZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430654; x=1776966654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4u53bdRqrxzWq/iPTyUJM9eZJs7UD/VsGD1bWIkiQ6w=;
  b=J5Eq98EZKXw1PvBTMgstAYioQpwvw3efkdIT2Ia+WAZaAEaSEVJxHj/T
   OoP5GY7WS3YMZEBvMAuz77eyAt6B5pvJ+4r82BBw9DeXuMZPxcA2/tgTp
   uNVF1yQ468OklQ/YJS2IClj9CI6hvDKgwmbteRQySk9HNJOqxJffMbZ9h
   sJDAomrXR4V7NA5tg5VLH0SXItuxPMV6kFEhRoOS2a1tYG2/Jx1ISeIQm
   lH4n2L6wrtj8z1zEJJqKA5JS1l1/ooE686KncM07BheIX7ze5U6800lVD
   0z0+IIbjX7pw4cjw5IOhFcozvz+7m1thuo6yhbm0uRcqYJU1MVm4MmlSo
   w==;
X-CSE-ConnectionGUID: F+gemsb8QAqykPBAsvE0sg==
X-CSE-MsgGUID: SvS+rZkyTZqkznpZtq6ZvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168343"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:51 -0700
X-CSE-ConnectionGUID: UtMSOq5hRtKpzaJUR3IMWg==
X-CSE-MsgGUID: 1nSsHHFLTvSVb510yhqoOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350469"
Received: from ldmartin-desk2.corp.intel.com (HELO debox1-desk4.lan) ([10.125.111.241])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:51 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: corbet@lwn.net,
	bhelgaas@google.com,
	kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	david.e.box@linux.intel.com,
	dan.j.williams@intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	linux-sound@vger.kernel.org
Subject: [PATCH 4/7] pci: doe: Replace sysfs visibility macro
Date: Wed, 23 Apr 2025 10:50:34 -0700
Message-ID: <20250423175040.784680-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423175040.784680-1-david.e.box@linux.intel.com>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace deprecated DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() call with the new
DEFINE_SYSFS_GROUP_VISIBILITY() helper for the pci_doe_features_sysfs group
in drivers/pci/doe.c.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/doe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index aae9a8a00406..18b355506dc1 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -119,7 +119,7 @@ static bool pci_doe_features_sysfs_group_visible(struct=
 kobject *kobj)
=20
 	return !xa_empty(&pdev->doe_mbs);
 }
-DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
+DEFINE_SYSFS_GROUP_VISIBILITY(pci_doe_features_sysfs)
=20
 const struct attribute_group pci_doe_sysfs_group =3D {
 	.name	    =3D "doe_features",
--=20
2.43.0


