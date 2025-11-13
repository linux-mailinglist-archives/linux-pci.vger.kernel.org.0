Return-Path: <linux-pci+bounces-41122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C6C59167
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81B555421CC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB399357A3D;
	Thu, 13 Nov 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaFMDke3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848D357A2C;
	Thu, 13 Nov 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051223; cv=none; b=cpv+rkioUg6UA3T/2Ptq7w/TPHQQ+l2K8oIGPuh/BJmsDf/EhFEt+IJZlOoZ5XyOfyfAYbyDSNHGnexArzJJFC8nQJv1J0zHl4FHO4+7rp8dsaMvIbkSsBiFxMnudrV3hyKSFWa55k9LGEsLWeB5CImUh6UHWW1eN1IUcKHdu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051223; c=relaxed/simple;
	bh=pP2qdP4u+ICU1JJgrdkxbA70iheGpoJDi0HzNQQbOZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzVx81Hs6WskGp+kzJ5Es7JZnm8DLfi3FdeaTJlqW8LZKxTuTtd2WGy4cfVFncUmB6weEkYZHeID4kgmDcIPVW6wqiLMd//GZw9W9U3BQojoggNHXm+qA0cW+pPkD0gHH6kEpfTtv9G28fPvIWyKQF1US4G0vwEK3bHqgVmV3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaFMDke3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051222; x=1794587222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pP2qdP4u+ICU1JJgrdkxbA70iheGpoJDi0HzNQQbOZg=;
  b=IaFMDke3Oa5an5NYdLuBsEVdSph2ensXehKEBuGQl0TkTc6+QGYkMEmR
   GZqRN6dmklg6keG+R6RJL9TjD1zsQdSmBmEPBnIcvOmmmgFxZI23zdn98
   0PaYL2Cr5/JMiiKRVA6EcAZvVNWaW1cZa7GHMzK5N1wJAMW7jWTVuJENy
   iL8kv3KJDWyVwNihBX7jyjaUHQwJAzRQ7Bv46lyAJnVXlq5HHosMmNJtz
   +oNSpf32aRamIqco84Ap3KKA+miy/jaRTh304Q5gJsNNYQX2V/1KAnMS8
   UuzYQM7OWy7BC2eyHhjuPoLyU3t9AdptAXurQJ6UY4FCgl4hjQo/nYG/0
   Q==;
X-CSE-ConnectionGUID: kAGFCe+ISGuGEBluXYbcjA==
X-CSE-MsgGUID: +VyFH1yUQs2tzjJEHlngnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68766578"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="68766578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:26:54 -0800
X-CSE-ConnectionGUID: Ut4d6JHtRUWL2VMj1wFksA==
X-CSE-MsgGUID: qC0+uIqVRhWYCEbRTmVR9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189553797"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:26:47 -0800
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
Subject: [PATCH v2 01/11] PCI: Prevent resource tree corruption when BAR resize fails
Date: Thu, 13 Nov 2025 18:26:18 +0200
Message-Id: <20251113162628.5946-2-ilpo.jarvinen@linux.intel.com>
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

pbus_reassign_bridge_resources() saves bridge windows into the saved
list before attempting to adjust resource assignments to perform a BAR
resize operation. If resource adjustments cannot be completed fully,
rollback is attempted by restoring the resource from the saved list.

The rollback, however, does not check whether the resources it restores were
assigned by the partial resize attempt. If restore changes addresses of the
resource, it can result in corrupting the resource tree.

An example of a corrupted resource tree with overlapping addresses:

  6200000000000-6203fbfffffff : pciex@620c3c0000000
    6200000000000-6203fbff0ffff : PCI Bus 0030:01
      6200020000000-62000207fffff : 0030:01:00.0
      6200000000000-6203fbff0ffff : PCI Bus 0030:02

A resource that are assigned into the resource tree must remain
unchanged. Thus, release such a resource before attempting to restore
and claim it back.

For simplicity, always do the release and claim back for the resource
even in the cases where it is restored to the same address range.

Note: this fix may "break" some cases where devices "worked" because
the resource tree corruption allowed address space double counting to
fit more resource than what can now be assigned without double
counting. The upcoming changes to BAR resizing should address those
scenarios (to the extent possible).

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Link: https://lore.kernel.org/linux-pci/67840a16-99b4-4d8c-9b5c-4721ab0970a2@hogyros.de/
Link: https://lore.kernel.org/linux-pci/874irqop6b.fsf@draig.linaro.org/
Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4a8735b275e4..e6984bb530ae 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2504,6 +2504,11 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		bridge = dev_res->dev;
 		i = pci_resource_num(bridge, res);
 
+		if (res->parent) {
+			release_child_resources(res);
+			pci_release_resource(bridge, i);
+		}
+
 		restore_dev_resource(dev_res);
 
 		pci_claim_resource(bridge, i);
-- 
2.39.5


