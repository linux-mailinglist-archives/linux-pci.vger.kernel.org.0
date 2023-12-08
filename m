Return-Path: <linux-pci+bounces-660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F81809F40
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AC21C209A3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967912B83;
	Fri,  8 Dec 2023 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="JkCFBezT";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="igyHg2+O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357B1727
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com DB965C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027136; bh=SBhBMSD/b041jxXSGOAXTq5IBUgFoQ2AEafdsjO0oPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JkCFBezTgRdLThyZe7xK47AcHiG4/CtQZe7/B7zg3q5w3mcAy0fIVEP/5PRdmNn3U
	 L9WVp4RBS2Hwi/8uvMfBz4f5qnUC3oiX8fDq8ZmlEFlmpYu0Vq1FdZYupUArh2uows
	 10FInF3Jk8NL5qAGH/OlR+mnRMPg1fWWmGT4WclJWUQgRouMqYAy8KiwvVlR8dybV2
	 MddgCzklENLEn0VcW08XZ/WcTEos9d6kWWyD+KpB4Kumhmho9Y4QP8OdnyNWjWhz1f
	 +OcW/+asLUkfHigfC3XhmZOoVCbmSODSla6QC1Ky+4ANYG7ZdivdtPzn4FOUgaqoE+
	 lIE+wXf6oF0XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027136; bh=SBhBMSD/b041jxXSGOAXTq5IBUgFoQ2AEafdsjO0oPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=igyHg2+O2trEXaqSPG6zqKhTKx706pDasCKpxQq8bNsGh7+QRU/m0/Bi/6W4RNYb0
	 5LcXIkT0/XNyuPVYpVCw4f3IPGxam9e7+tbCRWVQtTCtcuOZhdelBISVpVZrd4jkYu
	 JUgqHk6tEvljcRHG1hCHEXmefikQW4XzPul4JSv1S2bPtWD0reO3IIypbbjXMophaf
	 /jVYoz2C5+pQ6/nIBwJoLojavHlXLcgrBsIyMAju4kiWnFvIBJccGONSMfCGiIdd3p
	 w9aWGLMFniiE06R3ybttbENv0iPUPPq/LbclTHcb0/uudpGWF81uwCJYf88uupXUQd
	 AzOepwpPKC8cw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 01/15] pciutils-lspci: Fix unsynchronized caches in lspci struct device and pci struct pci_dev
Date: Fri, 8 Dec 2023 12:17:20 +0300
Message-ID: <20231208091734.12225-2-n.proshkin@yadro.com>
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

lspci initializes both caches for the device to the same memory block in
its scan_device function. Latter calls to config_fetch function will
realloc cache in struct device, but not in struct pci_dev leading to
the invalid pointer in the latter. pci_dev cache is used by pci_read_*
functions, what will lead to a possible use-after-free situations.

Example:

With patch:

diff --git a/ls-caps.c b/ls-caps.c
index a481b16..b454843 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1802,6 +1802,7 @@ show_caps(struct device *d, int where)
 	      break;
 	    case PCI_CAP_ID_EXP:
 	      type = cap_express(d, where, cap);
+        struct pci_cap* test = pci_find_cap(d->dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
 	      can_have_ext_caps = 1;
 	      break;
 	    case PCI_CAP_ID_MSIX:

valgrind run:
valgrind ./lspci -vvvs 7:0.0

...
==22835== Invalid read of size 2
==22835==    at 0x11A90A: pci_read_word (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x11EBEC: pci_scan_caps (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x11AC00: pci_fill_info_v38 (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x11ED73: pci_find_cap (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x1126FA: show_caps (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10E860: show_device (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10BFA3: main (in /home/merlin/git/pciutils/lspci)
==22835==  Address 0x5249276 is 6 bytes inside a block of size 64 free'd
==22835==    at 0x4E0A13B: realloc (vg_replace_malloc.c:1649)
==22835==    by 0x119BCC: xrealloc (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10CD2C: config_fetch (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x110DAA: show_caps (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10E860: show_device (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10BFA3: main (in /home/merlin/git/pciutils/lspci)
==22835==  Block was alloc'd at
==22835==    at 0x4E050B5: malloc (vg_replace_malloc.c:431)
==22835==    by 0x119B9C: xmalloc (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10CE80: scan_device (in /home/merlin/git/pciutils/lspci)
==22835==    by 0x10BF0F: main (in /home/merlin/git/pciutils/lspci)
...

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lspci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lspci.c b/lspci.c
index 9452cd3..071cc11 100644
--- a/lspci.c
+++ b/lspci.c
@@ -107,6 +107,7 @@ config_fetch(struct device *d, unsigned int pos, unsigned int len)
       d->config = xrealloc(d->config, d->config_bufsize);
       d->present = xrealloc(d->present, d->config_bufsize);
       memset(d->present + orig_size, 0, d->config_bufsize - orig_size);
+      pci_setup_cache(d->dev, d->config, d->dev->cache_len);
     }
   result = pci_read_block(d->dev, pos, d->config + pos, len);
   if (result)
-- 
2.34.1


