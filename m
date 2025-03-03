Return-Path: <linux-pci+bounces-22842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD99A4E109
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B44176DF0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED420B21F;
	Tue,  4 Mar 2025 14:29:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDE20C014
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098595; cv=fail; b=cDHyMVTPj9DgLAXUHAqhtbrMvQp/1PnCeqsW0oEcrU1cqlFbQJf4vH9iOP2Rw2I7GYdmelWLrB7EOc3ed2gti615FDdDhUgvtQGI0hF4idB+OJpkWLhkUJnmxDmIu1XlpL1q4d2NoCa7RVwpTNdbYqKk7Gsp0jO17DH47XhB0NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098595; c=relaxed/simple;
	bh=8RXLXxd5WErFhtNI1U1XH6Y12wckRSVfpIeTmcbIwIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SAy/3QYPlcigp9Bsjy5Wpp3MJAEJtJaG6ODLNTr9HT5r1LL/XEIJndFq9/hG+WL2ClZGdp1gNzs8eDadGYHaluVjX53BYMnNFjEx2GmyzyuxjV+RN+5Slfu2y2PkTrpzF0ytrpRa/F257P/PdwRYsgvVYBV3mrt4+WhqhoPH2Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=159.226.251.84; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id E2FEF40D570C
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:29:50 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dMJ3NdTzFwRN
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:28:12 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 030E842725; Tue,  4 Mar 2025 17:28:04 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541087-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 14B0B420E7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:22:06 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 5920D3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:22:05 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47FA7A63D3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F4F1EA7E8;
	Mon,  3 Mar 2025 07:21:49 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21F12B93;
	Mon,  3 Mar 2025 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986508; cv=none; b=bZqstpOQXoybNzZPWA95/04gdxs8sG8juTXXQ9OpqhHs8fj2Zm9qITSqnm4mnoo4ZbWmrgfH4BiQjRCzO/RX+fMEZ4+4C3Nt5Jq8sb4RAc1wN8cQ7qvdhWgsASHy60hnbyzjB/YHFK7lOBKz7D6N5W1SCuU1GPwmlontRE1nCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986508; c=relaxed/simple;
	bh=syPmBwmUMBo0QIBV7GdWdnT0SdfzyuqB5EAPVxcSIkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1ABFjE+1i86e878x0HwMTNP1mDYnrEY3yuG8hJgj0Nz3YEHdabds3SxYYkv94zax5n570pehBzrbi0PT9MqIF59Um0GlTF/jGlhfDgn40HUJg3vtYUznm3b5Ci5jJbkIERpnMuJGTjfMuO9WM9rBUFwAe0Buw8z/ZpWrHM+ROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAD3_6NvWMVnHYCuEQ--.60251S2;
	Mon, 03 Mar 2025 15:21:28 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: bhelgaas@google.com,
	treding@nvidia.com,
	arnd@arndb.de
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] PCI: fix reference leak in pci_register_host_bridge()
Date: Mon,  3 Mar 2025 15:21:17 +0800
Message-Id: <20250303072117.3874694-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:zQCowAD3_6NvWMVnHYCuEQ--.60251S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13GrWUGF4kuFy3ZF43Jrb_yoWkArXEgr
	109Fy7Zr4rG3Zagr13ArnxZr10k3ZFgrWfGr48tFZ7ZayrXFZIg3ZxZFWYyr17Ca1DCr1U
	J3WDXr4DCr1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dMJ3NdTzFwRN
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703294.52388@ZYo3+KJRwm+ss/2jPv7aBA
X-ITU-MailScanner-SpamCheck: not spam

Once device_register() failed, we should call put_device() to
decrement reference count for cleanup. Or it could cause memory leak.

device_register() includes device_add(). As comment of device_add()
says, 'if device_add() succeeds, you should call device_del() when you
want to get rid of it. If device_add() has not succeeded, use only
put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch description.
---
 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246744d8d268..7b1d7ce3a83e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1018,8 +1018,10 @@ static int pci_register_host_bridge(struct pci_hos=
t_bridge *bridge)
 	name =3D dev_name(&bus->dev);
=20
 	err =3D device_register(&bus->dev);
-	if (err)
+	if (err) {
+		put_device(&bus->dev);
 		goto unregister;
+	}
=20
 	pcibios_add_bus(bus);
=20
--=20
2.25.1



