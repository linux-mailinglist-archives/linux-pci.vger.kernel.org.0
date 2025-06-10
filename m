Return-Path: <linux-pci+bounces-29308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95302AD339F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065B9160103
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42F28C87D;
	Tue, 10 Jun 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaxSDMoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EA28C85B;
	Tue, 10 Jun 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551547; cv=none; b=iuDXl1NycHZF9y/xK6LfkuUlXYP6b7vZTrnd4MjwkKokBr/Cea6YwzritfmCEmqDUGB0VEn5xCtrvXQb/TO//AXev/DkwWvvnCXb+OSV6hiEx4xt6y++2c+D6QkFU3dCQrSiqB47u/hDoh8p2tAuk4ODsiMspgiwL2Xk5nOfXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551547; c=relaxed/simple;
	bh=kQ7eYwOpFPv9CngYpa+QKJMvmianUETvSqt5sYi5nBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3hu+ua/MQ00tiH7OBoGqHYlgJbhinbOW2DTNWmHnFW5pePLlhJLe2wjqtLBT0r3Fyh8vQgVSj6znyrMtRTLii1mQ/9JjdGUNEuRkJutXqvlXE8C2KS8uauuW4hNhSqYnljMugtLkQdoDPdZ6SEc8o4kKQHQ1yT5tLYb4MJUYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaxSDMoZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749551546; x=1781087546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kQ7eYwOpFPv9CngYpa+QKJMvmianUETvSqt5sYi5nBQ=;
  b=OaxSDMoZVjxh0SGnRqGtaQa0t7BIrJ7nuGJmqLrHj1u8Gppei8hhDZqF
   cgFtySWoSGXW+5xZ/M7S+Z8Ze3Yc7vGSIGDb7jDH88zjJb8QGbCGdAujr
   dGYf3QcATCTIsXKcI/pCXLTPkqdxpeozhzusL/0IXHqLxuFDd1c9f+oe7
   ne9RaEJocr5y8eM9m5+xn4sj54scF+fjpWlCUCB2ciNbdplHgD+QvghY5
   Ysr7r82mK8wSiux2ZqVjrjZXpuOZktHrNpalyYX6/pkHNSbubgZCqdFaG
   /21L69Zknk9p1W/qUHiQQku8AHayLeBe4Qfs4l/xZmB2O/tUqHVtHKiEa
   g==;
X-CSE-ConnectionGUID: Pzzg55nsSIONI0aOFCgkHg==
X-CSE-MsgGUID: tnR/ujAMS2i7zGBcPPC0QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55447231"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="55447231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:32:25 -0700
X-CSE-ConnectionGUID: jGYXhpl4TOKd4azWR42nrg==
X-CSE-MsgGUID: m8xgEuH6TQiYsYoqUXWoVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="151670941"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:32:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] cxgb3: Use FIELD_GET() for PCI register fields
Date: Tue, 10 Jun 2025 13:32:04 +0300
Message-Id: <20250610103205.6750-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
References: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of literals and open-coding shifts and masks, use FIELD_GET()
and the correct field define from pci_regs.h.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index 4e917a578c77..171bf6cf1abf 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -29,6 +29,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */
+#include <linux/bitfield.h>
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
 
@@ -3262,7 +3263,7 @@ static void config_pcie(struct adapter *adap)
 	unsigned int fst_trn_rx, fst_trn_tx, acklat, rpllmt;
 
 	pcie_capability_read_word(adap->pdev, PCI_EXP_DEVCTL, &val);
-	pldsize = (val & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
+	pldsize = FIELD_GET(PCI_EXP_DEVCTL_PAYLOAD, val);
 
 	pci_read_config_word(adap->pdev, PCI_DEVICE_ID, &devid);
 	if (devid == 0x37) {
@@ -3400,7 +3401,7 @@ static void get_pci_mode(struct adapter *adapter, struct pci_params *p)
 
 		p->variant = PCI_VARIANT_PCIE;
 		pcie_capability_read_word(adapter->pdev, PCI_EXP_LNKSTA, &val);
-		p->width = (val >> 4) & 0x3f;
+		p->width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 		return;
 	}
 
-- 
2.39.5


