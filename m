Return-Path: <linux-pci+bounces-6134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA478A1B05
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229212868FA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA2202A5A;
	Thu, 11 Apr 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="epIK0n5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC320221E;
	Thu, 11 Apr 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850218; cv=none; b=ZaiQw3ik3n4sdWUYUI65+quuPN3J6mAGUgPIzCgAwzO3IuC7BZBGEGv+7J+xRdbi0D6s5K/BqwRNzCkK+EGmDqadLuNE0VtvP/r8QCFZM7qTI2zOlqOU0YuVgnogds7V0DlMLxfQStC5DaM34W2/eP9LV+NFs1ErWyfFTVRDLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850218; c=relaxed/simple;
	bh=Mo8q+6TVzNpOkq7R1IuTVIjTaKbcaUOLO5q+UD3bQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD0CmhkSmlduaaR8iLHg2zUWOKbBb/D+5A5N5sSC55f3w1fUFI/8ElxGlCPbVqNAhyz5GpGBbZbyvGzaWtI6wWNLxafU9B3VOmGURV0bE3u0xqviDoXSYdg7XEKLqajgDQfjCMJTwGOdt6/mp8vzZzbPdNgOIK7iPF9RySAQLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=epIK0n5y; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712850213; x=1713455013; i=parker@finest.io;
	bh=FVDjHOAyY1jlw5Y+A9WL4QWb/bltRVutt7yXYkqT2Kc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=epIK0n5yHQdzJruVmMFCXHw8FVV6uQbZ30AuyZP6ADuMYStMRn9wz1KJrrr5l+3b
	 EVp0OCe7JPYrrzrsSfeWeM1P2ZBrTfrdDdyoC+Lh5YkBvCyrXxGIemJvJvyxzjR1w
	 7rkgKHQwbbHCS+ET2hOC6T10WAhwIER2t+/IoPsmpFVS98bI2s4ifpUS4gJ/vBGc9
	 X47DuEDHDvf1kSYOE9TVUTGamr+3PTsF888mSHmlMOec4oWHRjgpvVDeh48oQ2p6o
	 dWHYOAVORt2bnWlCovgxGHxDd48AcRrKd/nrf7M0tRQplEX7jW4veepz8GwoDUmaS
	 QDbMtWD4dWcjCuqGtg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MTjFe-1sLRRE2l2u-00J6kz; Thu, 11 Apr
 2024 17:30:04 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH 1/2] serial: exar: add missing CTI/Exar PCI IDs to include/linux/pci_ids.h
Date: Thu, 11 Apr 2024 11:29:26 -0400
Message-ID: <936439b200c810f83076a710eab81acd1e79ec83.1712846025.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712846025.git.pnewman@connecttech.com>
References: <cover.1712846025.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pl9kdTije93xR5aiQyhexgoauf6lISgmx4hUN/HHF9OX6y+t839
 l2RueScXeRBrn5inDDt5SRpEBWY/vFWoLM4oFuxPNpw58AZ9hSq8dqNg/vr09t44FnDD5dR
 aXSOXiYnkM14I8c8iyLeJEybHMdPWHtXr0WqJtOPs8aAv3ppoKzNyLkATtMpcgH43yDqlN3
 8SLCdgjsniC8W0dvfvPPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LMeSVELGH1s=;o6i50hBp8znzirjmnsNUIS22hla
 C1DVmIGSrEdbd0wom/hIYjnCOM7GBN2YLgTUPbTYn2UiUZjBa0/f1M/HZOmuml34qvd9Mz+7S
 iZ4YA/NMuQiPvSXTlUX+TK/YE+kWAXDjFga5cVsVFjfbQIxT9mPtoFNCKur5FR1xWDSIzByh8
 SMjd2STgZsTE+OXGX8qhpMFFyC8hP9577uKCfZ3b3RuJ1InQmmeb70FXlTheRK25WBmNKcJa6
 nOdARFUv2M3YQ3f3pQ0NzuLL1MFl16uJDT2DokACkqTLtFIAjvben95iqwGvzj6Rq4ofgkkN2
 mY3zBh6NM8/MIThnv9A/5I2lyz1j3yCOE1dcVRelbzZPfd9bsUHgR7ARN+pq6dWXThL54hw0p
 7fu0jyekcXpfbps25MLNeSw7PP7nmR7d+qR80RphHxDTQhMnr72uAgt7x3/O9lwfac2nAaWvZ
 uP3FeriemiINH5xWhawWoatjWffta0juJ5VN770Kzh8uaLNjPNY2zc2zqi4t7YbK/i1Ppy/XT
 bcYhvYQ6FsWdOtymTDTR1sz4gM+hx/Bq3i++rK57c7W2FIm9hZqtWH4k84ht97/S4jQ6vz8y+
 Vk08mNT/5hGZYu2mTYrpQ1sa41A1KfeLR9K166swzCEbTTedXc6ZpSjX2taANWanqh8BTM7Qe
 xrIMUZDdI2c1IowrWeRL8lWAFhrV++GurU8IpJD/HxRVwkro22v79UruDhAy0zQKireF0EJiO
 rnALxjMZusac6+sK1CVdjjZJPCXSCYwS8KAt74fI3Qi0SWOq1yflAU=

From: Parker Newman <pnewman@connecttech.com>

- Added missing CTI serial car PCI IDs
- Added missing Exar XR17V25X PCI IDs
- Moved XR17V4358 and XR17V8358 PCI ID defines to pci_ids.h

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c |   3 -
 include/linux/pci_ids.h             | 104 ++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 0440df7de1ed..eb00fcd79a8e 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -46,9 +46,6 @@
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022

-#define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
-#define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
-
 #define PCI_SUBDEVICE_ID_USR_2980		0x0128
 #define PCI_SUBDEVICE_ID_USR_2981		0x0129

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a0c75e467df3..971c1a1c98e7 100644
=2D-- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1809,35 +1809,76 @@

 #define PCI_VENDOR_ID_ALTEON		0x12ae

-#define PCI_SUBVENDOR_ID_CONNECT_TECH			0x12c4
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232		0x0001
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232		0x0002
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232		0x0003
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485		0x0004
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4	0x0005
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485		0x0006
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2	0x0007
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485		0x0008
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6	0x0009
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1	0x000A
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1	0x000B
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_20MHZ		0x000C
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_PTM		0x000D
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_NT960PCI		0x0100
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_2		0x0201
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_4		0x0202
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232	0x0300
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232	0x0301
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232	0x0302
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1	0x0310
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2	0x0311
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4	0x0312
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2	0x0320
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4	0x0321
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8	0x0322
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485	0x0330
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485	0x0331
-#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485	0x0332
+#define PCI_VENDOR_ID_CONNECT_TECH				0x12c4
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X          0x110c
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X          0x110d
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16                 0x1110
+
+#define PCI_SUBVENDOR_ID_CONNECT_TECH				0x12c4
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232			0x0001
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232			0x0002
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232			0x0003
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485			0x0004
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4		0x0005
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485			0x0006
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2		0x0007
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485			0x0008
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6		0x0009
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1		0x000A
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1		0x000B
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_20MHZ			0x000C
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_PTM			0x000D
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_NT960PCI			0x0100
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_2			0x0201
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_4			0x0202
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_TITAN_8			0x0203
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232		0x0300
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232		0x0301
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232		0x0302
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1		0x0310
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2		0x0311
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4		0x0312
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2		0x0320
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4		0x0321
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8		0x0322
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485		0x0330
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485		0x0331
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485		0x0332
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO        0x0340
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A      0x0341
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B      0x0342
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS           0x0350
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A         0x0351
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B         0x0352
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS           0x0353
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A        0x0354
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B        0x0355
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO      0x0360
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A    0x0361
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B    0x0362
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP             0x0370
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232         0x0371
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485         0x0372
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP           0x0373
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP           0x0374
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP           0x0375
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS      0x0376
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT   0x0380
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT  0x0381
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO        0x0382
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO    0x0392
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP        0x03A0
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232    0x03A1
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485    0x03A2
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS 0x03A3
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XEG001               0x0602
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_BASE           0x1000
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_2              0x1002
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_4              0x1004
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_8              0x1008
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_12             0x100C
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_16             0x1010
+

 #define PCI_VENDOR_ID_NVIDIA_SGS	0x12d2
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018
@@ -2048,9 +2089,14 @@
 #define PCI_DEVICE_ID_EXAR_XR17C152	0x0152
 #define PCI_DEVICE_ID_EXAR_XR17C154	0x0154
 #define PCI_DEVICE_ID_EXAR_XR17C158	0x0158
+#define PCI_DEVICE_ID_EXAR_XR17V252	0x0252
+#define PCI_DEVICE_ID_EXAR_XR17V254	0x0254
+#define PCI_DEVICE_ID_EXAR_XR17V258	0x0258
 #define PCI_DEVICE_ID_EXAR_XR17V352	0x0352
 #define PCI_DEVICE_ID_EXAR_XR17V354	0x0354
 #define PCI_DEVICE_ID_EXAR_XR17V358	0x0358
+#define PCI_DEVICE_ID_EXAR_XR17V4358    0x4358
+#define PCI_DEVICE_ID_EXAR_XR17V8358    0x8358

 #define PCI_VENDOR_ID_MICROGATE		0x13c0

=2D-
2.43.2


