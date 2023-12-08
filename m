Return-Path: <linux-pci+bounces-661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759B809F42
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BCE1C20C89
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C612B87;
	Fri,  8 Dec 2023 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="oIu+EoyJ";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="l0m0TQOf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AA1733
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 53536C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027149; bh=9nDLKbYdYrtPbPc+dke5n4p/Ias9emN9HC1PJDouES0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oIu+EoyJSTuxu2fK+fL1tZonIbniF8x9wddv3tvzNF+yt+fzkhKuhyJI/UWzQ+Pz5
	 QoQrYuxThb5rb7YM5zM83V7ZOiCxBQzeEa+9k+qLFrG3LNICOUXye94E3vqpRq/Zax
	 ie9r0mPzVm6rwvSx9YoB+6rd/ZUtJaqCRDfIAX+HzqLZedgEu8VpisXLsoOp3Nx+vA
	 dAbQQ80qYCHowGlDWF7AvbMc5WZB9bCrMxHFb8p8dFqUPpTLoSCvviXpU0g4bMoPiR
	 bHsqkm8uEOpYWlNTlsg2X/OZaJbkRAy3dWOcLkIbE4DQ/VhzwXSiT19Z8/wZp9G6Vw
	 OSw/NTHh5zR0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027149; bh=9nDLKbYdYrtPbPc+dke5n4p/Ias9emN9HC1PJDouES0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=l0m0TQOfoyQPN3BlO62ifu+VszHn4fQPf9maHGqvg9s1wnsy8WNLQ2JXY312fVxKn
	 Vt0fxnwxWd0FfCP7Ac75EdRu+grX5ffuAwAuWA3lHQc4pNzS5MfQZYvsfyi4AtB9I1
	 aEcZINQoeO0VPwme2D5eoUWoWa4QWWxAiaTKmE7hHquZ8/lWVRtWj74OQVd7BxdWnq
	 gqajhZhbQpSHiakmn9tYqED43nHjVUZOZfpWSum2LlqAV3hrpmXKcBBsmiGmIep0/t
	 EMgmzYqHYvCZKH331v5HKaNNFId+TIxbXHXLY+KKn90uFv7CmmnfGfmq6cUbyhQ+EM
	 zWQ4mjODAguEA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 07/15] pciutils-pcilmr: Add all-in-one device margining parameters reading function
Date: Fri, 8 Dec 2023 12:17:26 +0300
Message-ID: <20231208091734.12225-8-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Implement a function that performs all necessary actions to obtain device
margining parameters for subsequent processing without running the actual
margining test.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr_lib/margin.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin.h |  4 +++
 2 files changed, 89 insertions(+)

diff --git a/lmr_lib/margin.c b/lmr_lib/margin.c
index 38a80bf..41c8fbf 100644
--- a/lmr_lib/margin.c
+++ b/lmr_lib/margin.c
@@ -414,3 +414,88 @@ void margin_free_results(struct margin_results *results, uint8_t results_n)
   }
   free(results);
 }
+
+bool margin_read_params_standalone(struct pci_access *pacc, struct pci_dev *dev, 
+                                    int8_t recvn, struct margin_recv *caps)
+{
+  struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  uint8_t dev_dir = (pci_read_word(dev, cap->addr + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_TYPE) >> 4;
+
+  bool dev_down;
+  if (dev_dir == 4 || dev_dir == 6)
+    dev_down = true;
+  else
+    dev_down = false;
+
+  if (recvn == -1)
+  {
+    if (dev_down)
+      recvn = 1;
+    else
+      recvn = 6;
+  }
+
+  if (recvn < 1 || recvn > 6)
+    return false;
+  if (dev_down && recvn == 6)
+    return false;
+  if (!dev_down && recvn != 6)
+    return false;
+
+  caps->recvn = recvn;
+
+  struct pci_dev *down = NULL;
+  struct pci_dev *up = NULL;
+  struct margin_dev down_w;
+  struct margin_dev up_w;
+
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+  {
+    if (dev_down && pci_read_byte(dev, PCI_SECONDARY_BUS) == p->bus && dev->domain == p->domain && p->func == 0)
+    {
+      down = dev;
+      up = p;
+      break;
+    }
+    else if (!dev_down && pci_read_byte(p, PCI_SECONDARY_BUS) == dev->bus && dev->domain == p->domain)
+    {
+      down = p;
+      up = dev;
+      break;
+    }
+  }
+
+  if (!down)
+    return false;
+  if (!margin_verify_link(down, up))
+    return false;
+
+  down_w = margin_fill_wrapper(down);
+  up_w = margin_fill_wrapper(up);
+
+  caps->dev = (dev_down ? &down_w : &up_w);
+  if (!margin_check_ready_bit(caps->dev->dev))
+    return false;
+
+  if (!margin_prep_dev(&down_w))
+    return false;
+  if (!margin_prep_dev(&up_w))
+  {
+    margin_restore_dev(&down_w);
+    return false;
+  }
+
+  bool status;
+  caps->lane_reversal = false;
+  status = margin_read_params(caps);
+  if (!status)
+  {
+    caps->lane_reversal = true;
+    status = margin_read_params(caps);
+  }
+
+  margin_restore_dev(&down_w);
+  margin_restore_dev(&up_w);
+
+  return status;
+}
diff --git a/lmr_lib/margin.h b/lmr_lib/margin.h
index bb57a76..13cfa73 100644
--- a/lmr_lib/margin.h
+++ b/lmr_lib/margin.h
@@ -172,6 +172,10 @@ union margin_cmd margin_make_cmd(uint8_t payload, uint8_t type, uint8_t recvn);
 dev, recvn and lane_reversal fields must be initialized*/
 bool margin_read_params(struct margin_recv *recv);
 
+/*Fill margin_recv without calling other functions*/
+bool margin_read_params_standalone(struct pci_access *pacc, struct pci_dev* dev, 
+                                   int8_t recvn, struct margin_recv* caps);
+
 bool margin_report_cmd(struct margin_dev *dev, uint8_t lane, 
                        union margin_cmd cmd, union margin_payload *result);
 
-- 
2.34.1


