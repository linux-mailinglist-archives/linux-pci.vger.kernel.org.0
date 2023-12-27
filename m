Return-Path: <linux-pci+bounces-1416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C881EDD9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8818D1F215D7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186BC286AC;
	Wed, 27 Dec 2023 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="QBL/iHH0";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Vj9LGVKZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5724B2F
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 32DF9C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670361; bh=SBhBMSD/b041jxXSGOAXTq5IBUgFoQ2AEafdsjO0oPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QBL/iHH08aFeUTb13vnjMrlymbnGA0PInTKP1c8DV9fH82J3pmemwcFGnw+G2NAm9
	 3bsQgIA5uF8Ccse8U01vLlD0qpeyrJPWOVFLADMCuMPgmsUI3LtstnDc00tSCXOeO0
	 X+MIksIFI+ayEExRpRQRsFiSnilEwVPpthedT+l1Q26w7iMryqTj4F7NWRBFLay6uY
	 Xag6480UhGnwCSIGaJ3lPrRzh7/fPmcQ/xSdwqzyBs6LJ2A4i4Sstk8M+7X5H5JzGc
	 Sgf13yK5ccnkKn4wce3K10KxpT4PJjETe9rkQtA60//h6LaBHdUzJjKw6lQYYxeZ8f
	 Ux0igA/dbFT0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670361; bh=SBhBMSD/b041jxXSGOAXTq5IBUgFoQ2AEafdsjO0oPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Vj9LGVKZ0ypC8e6QD4u6K9kOyByCNNjwolgEVntqVDOYyGJcUvbnuFDu9k3VCeNxU
	 Did5SBr17URGWTjqBi+0P9PtJtE7Tr26kZ6v3HdGkONVO8VfzLwX3fv2nzmX0MJG+M
	 bweyhHJMYWYESJNiF3nfaPkXSfn3UU3wUf6YGgvxxWvGW7etmNcQ+PKl4BCgzYkNd5
	 zPA7htUQa+rnm7+ywcGegrM87VeXPYBZV09WLskhXwZjQaa7hGfURDbHq9wgjUMrVp
	 CCP4B4HyiLvRiWYIJQFW7PMOxCxzdl4reoPIKEJ93062mdYb8LXqV4a8JghTAoJ8zU
	 BSwZuhO53DeMA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 01/15] pciutils-lspci: Fix unsynchronized caches in lspci struct device and pci struct pci_dev
Date: Wed, 27 Dec 2023 14:44:50 +0500
Message-ID: <20231227094504.32257-2-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

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


