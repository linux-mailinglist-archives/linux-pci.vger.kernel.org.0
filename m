Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651667898E9
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHZUDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 16:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHZUDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 16:03:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3072C2;
        Sat, 26 Aug 2023 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693080194; x=1693684994; i=lundril@gmx.de;
 bh=VKmid4DgGwdhkduyFFOwkjxOAZ+7/XvDyZOOaVvaafk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Z/Wz3DSv2iGqskTDMScoquO/B+5EmamBn4A3EA6zRRUOF61rXDTs+K1QLiXghL/Ym4NK467
 m1FN/dRyaz42ZXRBDO/CD2R2l/wHQT6HepEC6i5BssEz+rRvPh+DtzM6CXdlbo2qHOksNu9Mh
 lrPY8YwrcD6A75YBvfuX0h1TYXL04cXnMMTcVmDVImFe6dwImrMREgjOHr3+WjK3IlC6ZF55K
 Ax8LKB6msoTwiE3APxdWiyCwnAW7Egpcnu1AITaGPpBQ+CAsWbK2s9usz/SWekZnTW3fSTYBS
 BAuqCVSW+RjpdqidEMWyiA2P3OKRdPFjyZFIiVWKTcYCh37PPNFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from flatline.fritz.box ([82.135.64.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1pgmJl1trX-00ty7C; Sat, 26
 Aug 2023 22:03:14 +0200
From:   Ingo Rohloff <lundril@gmx.de>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pci@vger.kernel.org, Ingo Rohloff <lundril@gmx.de>
Subject: [PATCH v2] wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi Redmibook 15 Pro (2023)
Date:   Sat, 26 Aug 2023 22:02:41 +0200
Message-Id: <20230826200241.5077-1-lundril@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6HXsIeaGdaVYxWnfks5S8gUzsa+W+nEDtWV4ESWV1Ns7HZie/7y
 RpEWLjRSlhjQLc5jDfIKxqgEMvuSG9lJvR5qt4Ni9LpkmdEZ5WdiOSJmsTG4InPFt8bKcoh
 peqjtoUPRk5c8g4WzVD6srTLsv8HlaWO/6r1Zc3xhu4vSmgrNTBQNF3S92ZxpchPMHTQ9dL
 qheb1QOi0prZEbnhAR8xA==
UI-OutboundReport: notjunk:1;M01:P0:d7mXSTQLF/U=;lEF8NTLf8pBeUbRM8C2BfCfesw7
 iA5qu7oEgHBFpEIAztmJW7rDLG0+k00WMqzalLJXj3XLF7XbNPtv7l5qACmEKdsnWkOHTbUtZ
 kieytIjW7kt58XPd2tA0HEzuUU4uicwgI61IE5VxJYFMrig+eNkafxJXfVEKoDfXE+g9e9lRz
 4ijDHkeHLFflhFJpKLHUXJ36knSC3MumOVftRAzlevkLTF5nSOcwYv1i9Ms5NUiwd6hH+kGXs
 2y5qWZ9pGI4nCmtA+mrYdCYqvFSimdDTDKZ7wMnSWwq678lzkNyt2QNGsb2qSrrppJwdKuYuv
 ikmgarYDKhGb5qj40tHjzY0IJwzHeuUDylFXFktSUep0qv8wsb07iPSLzAA884Qwlwcjk1xwT
 7gLtfe0CZ2zQy57Y35uWv8PyKuITJGlLkgblnV+wd0wJC6mlfDEOKikkZkqryoNDi9f9Wxhld
 I87xlld9iIyr5TFpQI5pd3w+M8b2OXTmhz/PbhxckdZhHWYBiOhgUPA5HiOysOR9t+b8BDzBE
 vX4SiFxYPZi5eK9kf4PidaRtSWXxJca8F9sUGNhjEYjpapsXX9qoOXfc8FjiTVNtOwKtNlKIy
 cGRjfMR4g1hXOp4k0pRSmgtDX9YwVhjs8sBf/kpEYTZSoE35o8lZltHIZCw3RVBvMmXG2mxyn
 mOnlHGxvvvJ8QzSLd9K8LKU4XSk4ICBhTW5gUeVjcbKWUwaUCuVm/hIFoTgDZg2YLMlrLS4Q3
 GFVKl5gyUL4EAqv+PECahvY3qge62ZQINLkdvMt2fsGsKUH+995H0ShRV2VPzxxjSV04eosLh
 /YpxqsMDre0fopVx/m/jHvYA+AEqKOm3B7S8axuLoHqWlcNCGGr/MFwhEI/v1kuPQ1JUJZhrU
 u31nSDfr92i4o2dPsOIUPPHCgvmAjzhuStVebgddWUkGinZSfle9WT6ivEem8+Of54pdrgDzW
 2PI0x080g1BKgXRJ7kpU78UX14M=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the Xiaomi Redmibook 15 Pro (2023) laptop I have got, a wifi chip is
used, which according to its PCI Vendor ID is from "ITTIM Technology".

This chip works flawlessly with the mt7921e module.  The driver doesn't
bind to this PCI device, because the Vendor ID from "ITTIM Technology" is
not recognized.

This patch adds the PCI Vendor ID from "ITTIM Technology" to the list of
PCI Vendor IDs and lets the mt7921e driver bind to the mentioned wifi
chip.

Signed-off-by: Ingo Rohloff <lundril@gmx.de>
=2D--
Changes in v2:
As requested, move the definition of the PCI Vendor ID for
ITTIM Technology to the (hopefully) right place in pci_ids.h
=2D--
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
 include/linux/pci_ids.h                         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net=
/wireless/mediatek/mt76/mt7921/pci.c
index 95610a117d2f..ed5a220763ce 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -17,6 +17,8 @@ static const struct pci_device_id mt7921_pci_device_tabl=
e[] =3D {
 		.driver_data =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922),
 		.driver_data =3D (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ITTIM, 0x7922),
+		.driver_data =3D (kernel_ulong_t)MT7922_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
 		.driver_data =3D (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..6ae1803bcd2f 100644
=2D-- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -180,6 +180,8 @@
 #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
 #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8

+#define PCI_VENDOR_ID_ITTIM		0x0b48
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
=2D-
2.30.2

