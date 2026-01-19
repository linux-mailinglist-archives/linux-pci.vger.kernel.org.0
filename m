Return-Path: <linux-pci+bounces-45189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A18D3B011
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 745FE30019E4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3238829AAEA;
	Mon, 19 Jan 2026 16:10:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF2296BD3;
	Mon, 19 Jan 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839058; cv=none; b=I7neizyjlq1pGk2wWJ6wJu8Xln9FCKBHXoff89Lj/4osVPwKlVgz5mNGhBee6zRgp+eAFuiSfbXTmm8mPirv4Lyg/rTO9010ucohKlo29vF7I/j4s8xItz7ez/ZnJVOr13X+93353oHfCV3SH3HTQYs5OVWdEFAC53zuxrem4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839058; c=relaxed/simple;
	bh=fIMPR9BnUwc/oeRd/zJE7pprYwOyr9TOfqyf3HrMQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3cfH8K3zTABPXCDqS22AUsCj+eJ/PilZ4iY+mIy5C8D1l5LzPQT/hVK6btEkk0G2ABhGI8DJl8zA8rnGY58CdTLQvP+fbjPwDZOItCcycjMULu+gUROQobPFsWPPhk6sAMnBgJfg2gFgwSYMaVNUOZ8ukIIQa1AOZUzteOwnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from evilbit ([88.171.60.104]) by mrelayeu.kundenserver.de (mreue106
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MzQPe-1w3uw02Ei0-016LcY; Mon, 19
 Jan 2026 17:10:44 +0100
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add PCI ID 12d8:b404 for Pericom switch ACS quirk
Date: Mon, 19 Jan 2026 17:08:33 +0100
Message-ID: <20260119160915.26456-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l1AMYQvkbnTMNQIv4f5DExShvxTsgPThLnAJjh/xwfh6ch8DI/T
 THx6+uevCBG9H/ApJWr2+EoOMrGIhLGO5tWCX/4VF7tbDDdN9Yqz9x3WALaVl5ElQVjhtZu
 pExKvJCqIYiJQJTpgmkvBd8kZ3FI7pdXmyNw001af/u7Q2RlL17olAXkBdxaktbvBKXTZu5
 wHoogZD9hkbdU6YXWYPUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8/Eel0t3+q0=;+8BLUNLInhmtkaet8oPMkKBnBnp
 GSGoy/8fjsAZY5b4FLaUOb0NBb2OzMiLarc2mcq2v5ZrIRCIor5EWQ3BMkbpc44tiADZXynVy
 cL76VCFgQGEjiAEWhoWfcyNL/fvQnzA+dL3psTCh1Fs3FM/LDWfEL6n0WTdn1iCXWf5NLUknd
 /ju9PYlVVxe6pDADSxjF6FqHPsxue5hvv0UQAwEI2M/OibI4jawHacKK9HTSqKQYgYfnryUy/
 wWkrbDqUrRSpSbY+MDc2YVUus7UtxbQnIsJARNhcNRQ8w0ugLeoTUMeMuY8S8p77jqeWtAZKb
 maOeL+85Nqy3uXseoICm/WZDmfpxitZWTQ44ArliLBFZc1RWg6L4JGw63vZjKUMK43QTzyNgD
 hr2ww9/hjOig/CKGbUQ3iohHgNnowmrz70IF9maDNKKb8ZSX/OVL/KnYtqPnB9U82Rslaeeci
 1WYneMctAvGmarlCplonHfoARWjIEA0cwcEGJktEbGoF+Ta/H58r/XO9Ywyz0SwGDv7/YJy3B
 rgWuxyRpi9TW5K/AcnxoyYUaj4T76I+T0lgryAgAhwajqIyAM5ADgKf+h/SdMzrsH6TojkP5A
 NrY1fGo6J0UP/3p/iIvC0tvl3cK79Kw+XFzkFNd4ogPy3RetnyKAfhRkmqjLbQUPKTtJoifRc
 7z2sGpFlnXE1jhK4Es5strZB1PiPF1W2Uy58z+KN9R11jA1YfHDvfcOoHmC8WugfnyBofXqzw
 y5CzdbTsMdAde1D6QGAXoOGysRuTVwhfWIjQQnpHDW7LyOpEQdGSOkGEXQXvzACMjVXgdtFKY
 FW/+Ow+gc+3ucnnMjkjLVH0u43z6qZmdlhRk8BvsBchmIWTmvdrURj0ZElu+rrpweIPnc4U2j
 Q+zzZQlbf04g2heH+OTCfZ7HjxHaeinMrjhQBtjAZ1c3DBwzl0WCnxTOZX8u+NwPha0Z5Y9Ox
 VJ2rmXHyogZLkOZbMzUEnVhxGr/KkI+RWgUWH3PCMWDSzQllGnROeyyUJneT2ukiPdheEwI+A
 pk5LE3Pe+1wBvwAxBrNxl+f+4Ab5gl51jV/kCnGKs3S8EE5D1ekv61XivZPWL8KtEvrla0KKH
 ca/V9PwOUrOXWeoKSM4y0d0CCD36wE8tsLC56XQN+Y9utuB2aTl01fH49dHIkaI6bYl6pH9UM
 wvJ84A+hfUFGWyfMy5U5X3usKpXMxW8U/1fAoxh1K96x/Nezrma5AWk7Sx0PFLVVtJ+lF1izw
 V/NJPAJDiE1DLehPrypdQlAE1lYfNwmNYAV2GTof9Vq6DCO+5v4tKIz/qtsB3e//Un4U3CkS0
 Od4uOx/uTR6pK2dLR2AjmZhnsDzZeuwt33zt7PBwV84RJIjVvAcPK8GyRyDWE4MvGqKGuxbzx
 M/u0jmQZXvbBpsa1FWqiP2B2NzQyquJ37w7Tx9c26pYIDBx5gWp1uutdVS26i4Q3bnKNH23Yv
 TW1dm3jJQDtKrsc/2hL8zXT+GzgZgGZned/fuctfbw8nQXUcpGIi8D87ISugfFjodnCqKA/Fh
 0yTljdbTVojv9YH41TvBSTh1L3ehKlmBRU7G3byiOicSAg6QhrnUzH4ORBUFn384XlEzXNhCX
 2UPKpFz4SWT9dBslyvPjyTHYK91t+bj7ERlQ8V7Q7WNWRvYbQcybcmeabKB4lBXIrR2O2Xjf7
 ZnotxjgFgZRv2vSthGtVH+p2+mL7yxzhVlFBPk7ugdLrhBwj4shA2nV1N0WPFoIBlEY7/DrlQ
 xegoStW0FnJztlamyFs6AibW41oucXmQjCRz90wFePBeDPpAjrS50tek=

12d8:b404 is apparently another PCI ID for Pericom PI7C9X2G404 (as
identified by the chip silkscreen and lspci).

It is also affected by the PI7C9X2G errata (e.g. a network card attached
to it fails under load when P2P Redirect Request is enabled), so apply
the same quirk to this PCI ID too.

PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 4-Port/4-Lane Packet Switch [12d8:b404] (rev 01)

Fixes: acd61ffb2f16 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
Closes: https://lore.kernel.org/all/a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr/
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..c462d0ed3fd6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,6 +6188,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
+			 pci_fixup_pericom_acs_store_forward);
 
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.51.0


