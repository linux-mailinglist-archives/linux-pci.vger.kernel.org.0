Return-Path: <linux-pci+bounces-26593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAAA99715
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E3D3A4AC9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E428D856;
	Wed, 23 Apr 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU5s3wPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345728CF51;
	Wed, 23 Apr 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430654; cv=none; b=fK3c9YnM2XHvbeeL/+dek2ur+LAcS9kX29JFMtCiqNR9M1EJ6k4XcpBoeq6QYKKuentRlUptC0NCS6eB3uWJliOHDTdbi7RbvJCVyINRVc7FTSZLV4ZOODvOJZ/Ms8EpBFYcQio5cxusG+q2dTOqr2fepq3F5X176k4m7ri9sTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430654; c=relaxed/simple;
	bh=bSyyGAF7NDhuTcHIZRedFHdRfL4/pg8/D3ANmwJWapg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPmL2D8++yOKpH0shW9RNHqo7ZPrKgLra/KYuUHFRNESJ1LzkP7tcGiAtqAMA+DunTNAZ/ghm8N6g0WMvplZolhdQ6wZsExV7m//543qhVSVUmChqp4Dmt9QnnLWvjdVlsEhdcInTEX9yJiv03k5O9y3NCHraxWnQBwOAUWfYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU5s3wPF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745430653; x=1776966653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSyyGAF7NDhuTcHIZRedFHdRfL4/pg8/D3ANmwJWapg=;
  b=PU5s3wPF+XXiNzcSFPEfQRrfjIFir47k0H1hoy0LJlToxb/Ax6YXyktq
   QDAJFfmZo+gNVC39DKvafyXKNxNK22lU12Ij2s4IMI4go4Wc6APgR0RmA
   FKRHlkw9ZqaigYdymVQdWuZpTnbCw8TCJOFqxx8GECuRGZcPexPx4GPzc
   hkjGeTY95lyqsufVCOdov9469vthB/Is6Gm18h0i3P7abpCG+nmHwPQEB
   QlPucEeTYQFl6aw4vbgS84HsbTlnxezNgmnXm+Pi8cQ7vKoLGxzE44rmF
   hK5kt/QQhFovlFJIdDU+UWsP6lw2qI98YbBHJZ6sf9rBo+yQhLBktiKdj
   w==;
X-CSE-ConnectionGUID: yJznvKtrS0ynKq0XdnReeA==
X-CSE-MsgGUID: yuf9R3s4Ruu6yl3CA+dfkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47168325"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47168325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:50:51 -0700
X-CSE-ConnectionGUID: 3Zp1D5lvQ9yIKNRtoWBFlw==
X-CSE-MsgGUID: vBnpBvT/RDyuCY+UgFwLvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163350462"
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
Subject: [PATCH 2/7] sysfs: Introduce macros to simplify creation of visible attribute groups
Date: Wed, 23 Apr 2025 10:50:32 -0700
Message-ID: <20250423175040.784680-3-david.e.box@linux.intel.com>
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

Introduce macros to reduce boilerplate in attribute group definitions.
Combine DEFINE_SYSFS_ATTRIBUTE_GROUP_[COMBO]_VISIBILITY() with attribute
definitions in order to simplify group declarations involving visibility
logic.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/sysfs.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 00dc88776f21..0804bffd6013 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -303,6 +303,30 @@ static const struct attribute_group _name##_group =3D =
{		\
 };								\
 __ATTRIBUTE_GROUPS(_name)
=20
+#define NAMED_ATTRIBUTE_GROUP_VISIBLE(_name)		\
+DEFINE_SYSFS_GROUP_VISIBILITY(_name);			\
+static const struct attribute_group _name##_group =3D {	\
+	.name =3D __stringify(_name),			\
+	.attrs =3D _name##_attrs,				\
+	.is_visible =3D SYSFS_GROUP_VISIBLE(_name),	\
+}
+
+#define NAMED_ATTRIBUTE_GROUPS_VISIBLE(_name)	\
+NAMED_ATTRIBUTE_GROUP_VISIBLE(_name);		\
+__ATTRIBUTE_GROUPS(_name)
+
+#define NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(_name)	\
+DEFINE_SYSFS_GROUP_COMBO_VISIBILITY(_name);		\
+static const struct attribute_group _name##_group =3D {	\
+	.name =3D __stringify(_name),			\
+	.attrs =3D _name##_attrs,				\
+	.is_visible =3D SYSFS_GROUP_VISIBLE(_name),	\
+}
+
+#define NAMED_ATTRIBUTE_GROUPS_COMBO_VISIBLE(_name)	\
+NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(_name);		\
+__ATTRIBUTE_GROUPS(_name)
+
 struct file;
 struct vm_area_struct;
 struct address_space;
--=20
2.43.0


