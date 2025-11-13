Return-Path: <linux-pci+bounces-41126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13796C5934D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07DD55441A2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8E3590AC;
	Thu, 13 Nov 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIZJcWcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214163570B0;
	Thu, 13 Nov 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051260; cv=none; b=nu9qyXvFsLLYRPw6OQ2njSQ5164PtS9dMCcHWCK797tzOiyu0Y7jR177SLFJ5EUWTaXkoV/97DmOV2Tbo4Kpc+YHiKJRsbSXvXhtbdJF8WqfRm4m0DcXcqf+MxziMuNHPhjPERnAWl4G6T/QLAIeVoheMXwqru89khHYSsdf1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051260; c=relaxed/simple;
	bh=h3nrujcBusoF0SQ2oOAT+J5w7BXLt6Ag/5weFGZmhGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u33TelHG2JKnXvyjSc23w8vbv8HNz6k4x1ZPdX0qeZ/dx94/ppVX7iYR1vZ9+HNyr0lqd/+KDUA68HoZNPjz39XkcEcYM3opISkMAZum+IuDvwhWpaAAuEdrAGhHfCveGSRiO8aAzaGuS9liD+tBQNLxdwVqI6i+1j9IvH3k0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIZJcWcA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051258; x=1794587258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3nrujcBusoF0SQ2oOAT+J5w7BXLt6Ag/5weFGZmhGg=;
  b=eIZJcWcAZTE1eFw4ILxzfiiaVYVYJ6A0rgKt4m+C4jei/0svUMWmojwE
   MeL5MoxLOvUUYWZWYLLZ7XI/Gyg6CAS5H8Vn4vJwAO1FuRAugyAgaWpZZ
   IGivJ08NoOF7LONMKZzW3lov/JBdUQi2iURvB2fyuKLhGfacvL54WHOy3
   yXc3Lmndp7bKMF8wMaxGAfnZ7wcjWqwN9dw41gLw7YLWlHHdeiLlr02Ia
   EedpvU2eyyDyqnU6PjTwewAZBG0a7kuCKnO32TSSmtPYFPhYEtxYNvVAK
   GUCfJsKwOdaa+wMWjLkbUl+dTcIQfOz//EvlHBDECMLSEAsJJZ1tqBo6V
   A==;
X-CSE-ConnectionGUID: l2MIo1LATfueVB6dbPCsyQ==
X-CSE-MsgGUID: hdlrdxF5Rei+zX+pNd0iug==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65176181"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65176181"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:37 -0800
X-CSE-ConnectionGUID: 098LOjq3Tr6F3fHuG5VUhw==
X-CSE-MsgGUID: +GMSlqWxSnaC2LaB9MLYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189971888"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:33 -0800
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
Subject: [PATCH v2 05/11] PCI: Freeing saved list does not require holding pci_bus_sem
Date: Thu, 13 Nov 2025 18:26:22 +0200
Message-Id: <20251113162628.5946-6-ilpo.jarvinen@linux.intel.com>
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

Freeing the saved list does not require holding pci_bus_sem, so the
critical section can be made shorter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1a3d54563854..51f5e5a80b54 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2513,8 +2513,8 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		pci_claim_resource(dev, i);
 		pci_setup_bridge(dev->subordinate);
 	}
-	free_list(&saved);
 	up_read(&pci_bus_sem);
+	free_list(&saved);
 
 	return ret;
 }
-- 
2.39.5


