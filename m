Return-Path: <linux-pci+bounces-39017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B5BFC3AE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF44625A98
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F0347BBA;
	Wed, 22 Oct 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx5shfkU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD9347BC2;
	Wed, 22 Oct 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140067; cv=none; b=nXgE193qnIsuf/BWhkyNVEy83/L+NwA52IhEZQ1Jdv26xOed5blYBBELX0S/ZjQKxfVG/UJ3a0TjN38qa8zO6Q4ieFJ8jRhukWKu1hBBEFfBOTn68HNSraSL8JuWtklulWPILXNiIRSBv4oVnpnE16UoKRVHkJUsVfQXaY0o89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140067; c=relaxed/simple;
	bh=Ew29Btz/2o1XyiScu8yLVhe48HekjowiHOdS1N1YhSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+kmEdWOLfGW7zaXjf6NswVhBSh1HGUooDaLR8ic9eoMwsUmxLY5im/AUVJH1vNLpXbeKneZRSeJBWVc7Gk/3IZB16UfW1hljC4q4ZkgrhGULKUW9OHktQ7PrY+jOsqNXQnF7ejMgYaFxZNxXA2Ici5c1PV11HUvBLD+eNQSgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vx5shfkU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140065; x=1792676065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ew29Btz/2o1XyiScu8yLVhe48HekjowiHOdS1N1YhSE=;
  b=Vx5shfkU5qqRoGARG+ao/U/5+prfxjFBgOB8I4sVLooh6FXEVyl4ASUu
   +KxwcrkFE4qEGpAKHBLZWduX2ihB07MSxPfeZvXVHrU//duKVM+5Jng+w
   VXC2uNf7oywv1uWU3TDn6deR6clGikkdBiquuoehlc+bj8NDc/qK5V+de
   1wa9F6F5wDwvRxLRT3ADSNwHMek1fkxJbcA2+cPwkdApp8zIb5UckfEOR
   XMqUjGD4cyLLUoqU8xHeXJkJbkzjDeGM4zbI587JRT5Koshr5+juFgyE1
   lXmpEA/00RBtZZKMepfdKQMLdL7NJ3mXgc0JzLa6+h053dK45q/Ggs+cv
   Q==;
X-CSE-ConnectionGUID: hxfIZGuuR4C2sn9r3xrudw==
X-CSE-MsgGUID: BJ3izRg1TlKIsuNIcfT+yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65904096"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="65904096"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:24 -0700
X-CSE-ConnectionGUID: BFekWB/xTVGgxSjhxDFjVA==
X-CSE-MsgGUID: tVe9t5DKSi2KlJ2r004wnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="188156754"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 03/11] PCI: Move pci_rebar_size_to_bytes() and export it
Date: Wed, 22 Oct 2025 16:33:23 +0300
Message-Id: <20251022133331.4357-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
References: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_rebar_size_to_bytes() is in drivers/pci/pci.h but would be useful
for endpoint drivers as well.

Move the function into rebar.c and export it.

In addition, convert the literal to where the number comes from
(PCI_REBAR_MIN_SIZE).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.h   |  4 ----
 drivers/pci/rebar.c | 12 ++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fffd0a0cc803..939a3a84b06e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1023,10 +1023,6 @@ void pci_rebar_init(struct pci_dev *pdev);
 void pci_restore_rebar_state(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
-static inline u64 pci_rebar_size_to_bytes(int size)
-{
-	return 1ULL << (size + 20);
-}
 
 struct device_node;
 
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 342b47022a5a..1d30dbb7fe82 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -35,6 +35,18 @@ int pci_rebar_bytes_to_size(u64 bytes)
 }
 EXPORT_SYMBOL_GPL(pci_rebar_bytes_to_size);
 
+/**
+ * pci_rebar_size_to_bytes - Convert BAR Size to bytes
+ * @size: BAR Size as defined in the PCIe spec (0=1MB, 31=128TB)
+ *
+ * Return: BAR size in bytes.
+ */
+resource_size_t pci_rebar_size_to_bytes(int size)
+{
+	return 1ULL << (size + ilog2(PCI_REBAR_MIN_SIZE));
+}
+EXPORT_SYMBOL_GPL(pci_rebar_size_to_bytes);
+
 void pci_rebar_init(struct pci_dev *pdev)
 {
 	pdev->rebar_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540221d0df0b..0a50912c5ce5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1422,6 +1422,7 @@ int pci_release_resource(struct pci_dev *dev, int resno);
 
 /* Resizable BAR related routines */
 int pci_rebar_bytes_to_size(u64 bytes);
+resource_size_t pci_rebar_size_to_bytes(int size);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 
-- 
2.39.5


