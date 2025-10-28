Return-Path: <linux-pci+bounces-39554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44111C16364
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C5B3B0273
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E35346E59;
	Tue, 28 Oct 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKeiTJNX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B928D8D1;
	Tue, 28 Oct 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672984; cv=none; b=r7xZAI5TE+x7UfXkfAZd+SfqwUD1STArPmW3DmQv++vK0GIIx8VcX2EN9E/nMlfEgQ4m/SwgwQDfqVagVHTDotz31DiSLX9rM2C2ePIGb7wJHkwFND2vtosqahdRmFIvQ9aGvuzmokGE8+hNEFHWRJ8BCtiooLPIBdwmPyrTXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672984; c=relaxed/simple;
	bh=bZ8RzX3XhmEbNTDlxF5oMlGveV2u4y/v84rMSalX5XY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihhq0FZt9nL0gMYQ5ixPqw7gxUdVaHC3u0mdXISPagc53OYIR/CzrU8dfGV+ZwCifd5qMFXcQfj4VEXBg3AzYYlwmQjE0ASJdEfjMfYPyiO3isCh9f+44KfmpQqUzwmKsDL0/wkptSnMsKy9aVI1DC5QApp8ShNfej5tm3lZIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKeiTJNX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761672982; x=1793208982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZ8RzX3XhmEbNTDlxF5oMlGveV2u4y/v84rMSalX5XY=;
  b=BKeiTJNXmnxznDnQxOkZiaj7r+6s9/MY/wFmWcO6VxAJbJjHItqTsmcV
   LJl/GtHVuNWcxqzeL6D17pDcYIOJILt7Arvqi61nz/nrEz0jqpcrehzzp
   PYuQrmRpA5Wd0UViMm9ZYBtauO8RlytVipyE9cKuNxnMqcoLgaolwl4zE
   yqjfC/+9CVjeSWU9VhtSVK4KOFdlK8uAUrRjljuu7WUQPOMW52qIHGOAN
   R7VJT+U64mLljBhEwOWXPdz8MClaeYH708VTr3GxvfUSCvZfx1+OONT2n
   qNckHiM9tq0xvLKxnXA+2VIWOhU7y7h6rMJOrNHW5VOL2CvSkVyqrOJN+
   A==;
X-CSE-ConnectionGUID: Mz6WSF0JTYqVUbAAPgBLBw==
X-CSE-MsgGUID: nAKLDDWwQreazz8D9A1gTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63690080"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63690080"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:36:20 -0700
X-CSE-ConnectionGUID: TkYtyQbvR7qXL+36gyfpQg==
X-CSE-MsgGUID: uP1tK2S7QiS2CwBKUQKvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190548630"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:36:13 -0700
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
Subject: [PATCH 1/9] PCI: Prevent resource tree corruption when BAR resize fails
Date: Tue, 28 Oct 2025 19:35:43 +0200
Message-Id: <20251028173551.22578-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
References: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
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


