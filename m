Return-Path: <linux-pci+bounces-14847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701EB9A3762
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A56A2856B3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F66185B68;
	Fri, 18 Oct 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RyEtbPf2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7B2BAEF;
	Fri, 18 Oct 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237187; cv=none; b=KPW8J+RylZz/rsJbkxoWwKc3CHp5+KP8OydyQ+mRmRgwQnZb7/hh2TXODTvxEdCFZ9oyV9tulKoHr/QwfXxqtoGKfqYnSwQmjS230BPO64OwD6jD3ZjlKUgg5qtamgGPFdZwcT0qsOt9qYmBnOTnC2w9FBxdJY8Ta5TvXuyFGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237187; c=relaxed/simple;
	bh=Z5lqgdu3QSwVsuXkMGkVZ3xJQKisy5Du43JgtY5KHNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZG2jfzukRUlhmfy/YdmXCvhMLRjqZ5c5yjfvye4GL0S6BkUe/ewn1ZFpt7QigXKgagt3QS6I2R6xbUCu9KCnS/DcMHFm4O7G+mq+qcw+Mfy5Jo8U61jSmlJexOSVCGeQNZJVOR2Ag2/89+iRwcXwMetI7V/cZGyBoiiC9pH6s2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RyEtbPf2; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729237124;
	bh=goLD3c2EsP+Ks0KHFgizL7VRQZT50MHFMUI14wvatVk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RyEtbPf2M06iJTQcEknwZvOdrPEdaDsHpnYYOzljS1F9vf2wKPU4tVLbrazTSo7CO
	 z+QB5n+Pp/qDVkUqTqNV5hOc5aQ/ITwj/VdM7oE8KoL/neZFZZgjbKkXlaX7AyaQJC
	 +Yrg4XMk/Eb8zTDEsRFz+AwHKoWDsQV3ZA5HzE3A=
X-QQ-mid: bizesmtpsz9t1729237109tab4vls
X-QQ-Originating-IP: 4YMVo5aBURMdTnar6yySxjTeT+t7YqnD3e0o3vNJffk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 15:38:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9120631587002057877
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>,
	SiyuLi <siyuli@glenfly.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19/5.4] PCI: Add function 0 DMA alias quirk for Glenfly Arise chip
Date: Fri, 18 Oct 2024 15:37:49 +0800
Message-ID: <B7F5C8CEDD17AEFB+20241018073750.48527-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ONJthgsgJlmJASbrSi6l3AMb7a38Jzf7ne1N56oxisjy0163boZsX72A
	pnr7wyXbGpB5+oEhyzJ7HRp9y22y91m4oGswVOFNZgWl83j5MwD1TS4ONnj/Jvm4liKRWLG
	3bp+s2viQ38zqse+nU9JIP1tmvp2WpHNqI4N3dIuIsq7qkbtTzSBLdTLmlIqajVuUcst9g8
	6HNZBQxTSaXtyPwd4rZUQIcjr+knzAG9rkByxxVTdVYq4NXlAE2/ZhJrfj4FG8286oTh8mv
	YnW0mXjkdQjRq6hEg9IKZM6MLFxlrrcroyz9iCwATCD9gy2bLeMIK9oRDkyU2veKUX+X6Yw
	IWJurc+rKMfDvMiBnLfj/J6k0rnJ533IqJuXUGt3nwKwgmgtlHl3owxG/aGpbuEdpSGfE7b
	ZL1AWlwvEmPjW6zdZ+c41nmZKR6amLWViE2r9p2mq4qH5QzngClxMIroPX8EBW2L0bqMaYO
	vsU1WSzhh7Fi2VnTtIu59yIWtadeXUU5hjpgZfY6VPMZih2UVMrrMnYqsiUrErIZQTDN0Sz
	nljsRn4b0oxWH1I6yvfjX8V6CRD2eTitqW19UmFC3+/S2agZRlL1tXYLwT1LGnQ9E+YH8N6
	2IIJRmtgrOyCFbH/3ND8bykDS26aw1WXPjSN5dzqt1G17fhXl9K6bKUG4WzIR15yl/Q6jaQ
	qIXXnpXt5v28yUQOf+/gpMQixoWiGcd3yq731R6yieIMnyRnas7szqB1p09O1vtM0G/sLol
	L+ReFuPUNpawY4vmikJpCaM+iFGwOZSGrSx8MwuHHfrrn3ss+kSq7syErSCgTtgkEKTvNHy
	4q4m01/1OODWk+1Fvvlfzs5pApMXCGsSDC/oc81sY3memypOHABJsqzvnhBiS07/+KmUQQy
	bBb7zdmTfyL3RupzjGMo3r65p7VKOelVsAL4PSroF29A6gsOqma+LyEuGazopknNMzmWLWy
	GNvj6BmtY0ARrCYh5setikXfn5H9NXslVcJ7M8MQ0SbhtdzF7eT2YeVWeoU653iZiPxo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

[ Upstream commit 9246b487ab3c3b5993aae7552b7a4c541cc14a49 ]

Add DMA support for audio function of Glenfly Arise chip, which uses
Requester ID of function 0.

Link: https://lore.kernel.org/r/CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com
Signed-off-by: SiyuLi <siyuli@glenfly.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
[bhelgaas: lower-case hex to match local code, drop unused Device IDs]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pci/quirks.c    | 4 ++++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bb5182089096..566bedc5836b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4042,6 +4042,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 
+/* Some Glenfly chips use function 0 as the PCIe Requester ID for DMA */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3d40, quirk_dma_func0_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3d41, quirk_dma_func0_alias);
+
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 91193284710f..5f996cf93c13 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2647,6 +2647,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
-- 
2.45.2


