Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6C7870DF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjHXNx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbjHXNxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:53:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C41711;
        Thu, 24 Aug 2023 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692885186; x=1693489986; i=lundril@gmx.de;
 bh=8Sx7IfXlBO0nta4oj0WEvvvCjn730eqgmmBBj0HjAFU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=BgzbE1huFHb321k8fNMvsJwKqJQDzncGEUxP0X/3tvxLRGmwgD2VL6acsZljG23fVH1yO7P
 Ck5i2IgFzDpqCKAldmRDBx/lengphmwfS4+zI+raBL9kbZwVayk1lwu5uVBvhkTAc9bV+0zQt
 KRAQ1iycZordIGbVDNf7R/TS7qlZXIROsBLjXCWZFBaKlgd1LblsBmP214U400N+5xqkQpBs5
 93hbxwJ74kuPvLsS2fazoo5NUxx0NaaR47n/5jt6TjcWVPnmxk91CvpI9xnLSHPzubDHXCJPf
 4kynPJ5pRaw81BtRM8Wl/b+pv/aN3Wnrt+vO4RAQzUFK5yBgnF5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from flatline.fritz.box ([82.135.64.125]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1qPW8Q3LzX-009kcv; Thu, 24
 Aug 2023 15:53:05 +0200
From:   Ingo Rohloff <lundril@gmx.de>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pci@vger.kernel.org, Ingo Rohloff <lundril@gmx.de>
Subject: [PATCH] wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi Redmibook 15 Pro (2023)
Date:   Thu, 24 Aug 2023 15:52:32 +0200
Message-Id: <20230824135232.5000-1-lundril@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QM8feTFRc2YtYaaf45Kic69g5xazyHtFHQXhIYKZwIjryyNGbIp
 GJMrmIKTmIk8X6NbeyEUFzKLYDlZWfy4avhieGTh3iY6DNCEv1JO8FN8pb4O0Mbco1Eg8TJ
 AcNpbKgVtkTp8MvqMmJO6/pXiRCJxp64iWG+4TeRTEFJY7KaTjqiYwt9CMfLZy1k31kent1
 paL7IcSRRfMh2Ss01uXsQ==
UI-OutboundReport: notjunk:1;M01:P0:9EdXq8fSVNM=;tiNFlbo02zsiCMrSiu4WV0MHlQN
 xb0vd4qbqxScz8EB5X3Ha5Q2fsfVIJtVibyZT5FAnVhv+yye9aHiF1LkEQFMQqfJwA9Hr901J
 TSSueyk27cEkbPE3OIs2LTUEJ5dddz1fGy6eQGNA57Jh3MZvkPaQn5ioUPGJ3I53RlLqwsZ7N
 uqluK46Z6eMeMXgAGzmA4t2KAWHzsiI0dyLQ0x+4scYjsAvn/0f6mml48A5vUhNg6qowegMVH
 cKGTh/R1yUvHjppht8DuCWXlvUiIEVAQuEGWToe6YtciaB4EQk+3jT0vGzDSWpX+UpR7439I3
 g3Lbs0vF6fWoFoKv2uLpQZTLB7xVfJt+Bdzu43XRL3MjLTzuDyUJ40krLeuqXhZ9lxzooFZOn
 c7wvMC6ZVSRQWmHAxSM/j35HioCF5BIMBEf10Q5qSRvC3MWLieS0z9EsJiDXvHUxdemkaJ5qm
 viN5lO1ASCs/vn4Hkdg59KcU/XpHPso+3N0hGr/UrBNz2RGbcm+rl38XKBmefIlicL/v5n8uW
 qCTThguBrf8SMtgSb9img2BNC4Lf65Nm6lu7+cZR8ElECMmfqjkBEqN3Va2Hn1jimW0jEHS8X
 iBCDTz9xJbaGU4dlZxbi7y4cSbWwVMnX0Ao2QvHKxcD0rU6o2B9qzGkY027+7ccnrK/DsNdPv
 +q9Cf7YSMeoFvRvU2vg4tkd3x+Ng7fd8eBgYyrFlK7VxSA8NJuNoYYYJ6OJf1s272s16lJ3Bh
 XU4SPtMvkiKEIdmodM4uMTkd7NbE1ws35fapnBpV7ZfGrjkmRvEI8Nyz5DI0Zzc8A11HyN3hq
 75zTHfltgNgpBfY0ZuPxU0MGp31sfYMUkUABMme0PguTwM/qsUYL3+pv5GbycqAfNLbqSSHlV
 8snU/XfP3HhBK8WuCQe+f9P5ArV7eBj/FRuZ1RZFSEXdtXI3Sp7IDV5KBmdCFrNQC2QJdf1ug
 ZA3Nzg86rRpOU2fyrWwItCAFLZw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
 include/linux/pci_ids.h                         | 1 +
 2 files changed, 3 insertions(+)

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
index 2dc75df1437f..c2d5c482cd7d 100644
=2D-- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2126,6 +2126,7 @@
 #define PCI_VENDOR_ID_MYRICOM		0x14c1

 #define PCI_VENDOR_ID_MEDIATEK		0x14c3
+#define PCI_VENDOR_ID_ITTIM		0x0b48
 #define PCI_DEVICE_ID_MEDIATEK_7629	0x7629

 #define PCI_VENDOR_ID_TITAN		0x14D2
=2D-
2.25.1

