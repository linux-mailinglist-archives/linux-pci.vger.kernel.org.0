Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13410C914
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 13:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1M64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 07:58:56 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1M64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2019 07:58:56 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUY9w-1iRTdx29gW-00QSQQ; Thu, 28 Nov 2019 13:54:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tim@buttersideup.com, james.morse@arm.com, rrichter@marvell.com,
        jdelvare@suse.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-crypto@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/6] include: linux: pci.h: introduce pci_get_device_by_id()
Date:   Thu, 28 Nov 2019 13:54:01 +0100
Message-Id: <20191128125406.10417-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:38OkZkxKYjduW4lFWkkXpmNgmHkotIPpFTk3wHRoh85UV7/YYuo
 tgz5yik/NedusSxW1EgyG7xsdphhkXUnNg3Kaof7TO/6+C0AXpfwJ2AXjL4JM4uXw2NbyBs
 fQGSRVXajWCZNgSc2SLQluiWV9mv2n9H8XanaYTkjJ6hXiwKJTrkawaVOivTV782SIyVlhy
 rooI453gLk05E2firCNUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x/bVI3gOHO0=:b8SRXy3cQTU1GMPXvnNm9h
 MP77h4dAhjsztPhIZ5ViC2W8wpGlmZKcErot+FwRwM1cKJkIrzyAjz9ErATwDMp3R0jKJgspj
 ECwTEUh1hPWvQVjuJ0HkB+9BCXhfCKKPhMKFsd/V5poviCOQ6zhhDo6o+bXSqh7NtDTjDATh7
 dO3vF3FXIUBqM5zqEy6lbbf1AyXHkbHU7ZKB9oRELWaJaaMVyhse4C21PHDsc3ezRoriQsiHI
 95QsOlRQ11G1P8gYpSjXUkCon0JqkUSg+9HuZGHQJ8toUaeNTy2wivd4BTDY2aEve9TptIXdW
 jcA8ESAcSDd0HguDf3SiYItRbTP0gR+qcZ6VemEibxnsaGpkRgIe1wkcIHYJK+RdOitCqZ0vi
 b1LXDt22+5Khx2qOGVBYiXTdGmh3DPyY7kUe4HlYn5cG+Ashfa8A3wBRpahgUBIKC//Mtl4gq
 RWqobD9GunYu0SJX0OS7fOFs+Io93Pj5MEdiV1fqIAhVRKY3cW3Z1LsfJdEff02Rhmfn4W3Nb
 aaQFnDcAhEGAFBOGJuDZoYEtXo1djBT5gZC7ruITqXaAUuAcbxhcG5eOvFEZShpvQNs+DWbqn
 IhrqRH+g4BDor3NYDXJKsfvOQUsiOgqjv8E/WiWn+505kc/u1FpJKVS/b2TAZeaDMNFgAjLX8
 LSjgvTh/PHowNpjqchgZ+IFodjQ40iDKOpiVeNv16+Qmve0HQdVzpjww0UH0at+1yzCTaFr/v
 rd3mTknG3pz3HC9VD7s/p92p15LeTLoovZ6bNnjeICggVpLehNuNalNbEtwpvUlUj9brWG2QT
 Qdh4SaJsmg11d0aG2VQxZciM2y9hGIaHd2hXzWKKrAYXxWLNoAfpPpxkBab7RONNYNsZ/y1Ty
 +vl6YAdeoGR8p0KxwDZg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Introduce a little helper for getting pci device via struct pci_device_id,
helpful for reducing a little bit of boilerplate.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb9f371aa77c..f6650b13724a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1050,6 +1050,21 @@ struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 			       struct pci_dev *from);
+
+/**
+ * pci_get_device_by_id() - get pci dev by struct pci_device_id
+ * @id: pci_device_id struct
+ *
+ * Retrieve PCI device by struct pci_device_id struct
+ *
+ * @return: pointer to struct pci_dev if sucessful, NULL otherwise
+ */
+static inline struct pci_dev *pci_get_device_by_id(
+	const struct pci_device_id *id)
+{
+	return pci_get_device(id->vendor, id->device, NULL);
+}
+
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 			       unsigned int ss_vendor, unsigned int ss_device,
 			       struct pci_dev *from);
-- 
2.11.0

