Return-Path: <linux-pci+bounces-41128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36700C58CDA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C56A3B227C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524F35770A;
	Thu, 13 Nov 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VB/CmBlI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9D359701;
	Thu, 13 Nov 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051281; cv=none; b=r9HQit7fNQh3QUYN2UMcKYjuBR2OI0g3XxNWzrfR5pne5rXU8dKkIqyGLl0UVcDYRDrd8hzu+eeEYI9+UzYpoh+uGyr7XH5Kn5IE+0sBRDXDBHIHhF6QawakVhJ9q81ADIJxu5rprX3nwzJTix0B1zJtpjOCa7QwHQWsEje2ByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051281; c=relaxed/simple;
	bh=MVDaAvkelaEcHOmBsAKoL7x0hnHzvyKwT0qtGb/G8DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQeXUpQbdCX6Bf3hvAXlNReOhDBDMEayNsCdrR7E2yBWtAM5bEb4SrL9Pk8QjhBGgWs1yopYTl2MLlALYWoB6gZhWrXZdcJGH7o5iGeJ3tdgFKTRFBG/PY6FcrmwJ+ji7ROw7jC8E7GRsVMiluXz4VD23QDUuu9MHzG9OwtmRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VB/CmBlI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051278; x=1794587278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVDaAvkelaEcHOmBsAKoL7x0hnHzvyKwT0qtGb/G8DA=;
  b=VB/CmBlICm1zZREeaAtvmuDKnMGy9LT9LLPEFpJCnutLp12L6kcoGb9C
   el7Eu1l2PW8NnCXY2tn/mcRnDeTmQkP/TrqYnMPI2zWzIExrQvIkts9dg
   RQVPG9a1Yp6xm9KhrKc7BfGk8Vtbplk4Y6N85Yidxm0MomU3ksLpG0xvJ
   nVj5/A/8XlFy5O7H/v2hEIQMBxqBICXJC6zk6h5/LcwfaqCUO70rsp6Uo
   EEMQQG76Lz8fus9bSgpCf/M+d80zfJ9qwvnc3O2BXOfoTHwm7K+9yyo+C
   D3YjrXb8i3cNzDW3QqaIRkFkP2HdkXBlEHOKkJGv6EJIQ5bPHrr5yChOF
   w==;
X-CSE-ConnectionGUID: XVdyA0O8RzC9w8sfa640fQ==
X-CSE-MsgGUID: ECXkCCvBQqun9GQp1rOOUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65176223"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65176223"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:57 -0800
X-CSE-ConnectionGUID: AslXPsLmQdiqPBGhi2cnOQ==
X-CSE-MsgGUID: oo/KyPEhQ+K9TOFXLFU/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189971963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/11] PCI: Add kerneldoc for pci_resize_resource()
Date: Thu, 13 Nov 2025 18:26:24 +0200
Message-Id: <20251113162628.5946-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As pci_resize_resource() is meant to be used also outside of PCI core,
document the interface with kerneldoc.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e4486d7030c0..558e452fc799 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -455,6 +455,25 @@ void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size)
 	resource_set_size(res, res_size);
 }
 
+/**
+ * pci_resize_resource - reconfigure a Resizable BAR and resources
+ * @dev: the PCI device
+ * @resno: index of the BAR to be resized
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ * @exclude_bars: a mask of BARs that should not be released
+ *
+ * Reconfigures @resno to @size and re-runs resource assignment algorithm
+ * with the new size.
+ *
+ * Prior to resize, @dev resources that share the bridge window with @resno
+ * are released (unpins the bridge window resource to allow changing it).
+ * The caller may prevent releasing a particular BAR by providing
+ * @exclude_bars mask but it may result in the resize operation failing due
+ * to insufficient space.
+ *
+ * Return: 0 on success, or negative on error. In case of an error, the
+ *         resources are restored to their original places.
+ */
 int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 			int exclude_bars)
 {
-- 
2.39.5


