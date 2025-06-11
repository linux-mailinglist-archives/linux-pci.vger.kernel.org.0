Return-Path: <linux-pci+bounces-29490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A491AD5EBC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D533A9324
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496618D;
	Wed, 11 Jun 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSVdE0v7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29E283CA2;
	Wed, 11 Jun 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668486; cv=none; b=WPgIB1/jdp6xHG+G3A9C2AqlP89m1JKnfN9axsON03lreLITwhIJ+7AUGhrdzDFdWGivSJ0r7BTxmgoS74K1LzjdCfhuwCHFY2C7zq2hDqtDGWAMUZbph98F9cEKXUf8gMTUJMy0m9a0yqZV+5UIAH9/WWp03S4BU0RmEctfXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668486; c=relaxed/simple;
	bh=hfeyK/eTihwmpGVnQxX1pqhXZgt2fJWgCy74pCgGR4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOoZXjmRsvmg5lr5b/TamEBexMOGrdEKcQC6XlWc4CqTldYw++PzTE6nOQFSb+3E9OOVG4X//6/Yd3Nd3SfSJ6c6+d+2VC/vTNaoV6Uhyg4HAgHhD+0oBS6/ZsfrqvCFtMNV96ftaGjbhBCKIxE9ePYi3jTPSxi2r7irENFvKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSVdE0v7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso972673b3a.1;
        Wed, 11 Jun 2025 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749668484; x=1750273284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZGyYXYc3SZhPlDKvAJZs+fBk6MmM4JqN/0ybuzC+cc=;
        b=cSVdE0v7hSRFE8CX3luHIjIN7QUgIOIB67zdckBiVF4NpoOHZCa9gjrxw1LojGOzK7
         pDwiuv9NfRfca5Xlbj6zekuqBC652sV+P7D4KNxI3dZ/ZEzuxe0Mu3HpFiBQhKJruyfP
         EnYrtqiRmdApcatTpz0qZaHmR6CD2chRn/EKt3unllofLL8epnFCfEzf8JC7j2Gxvjh5
         DFrgip/YM2JQGE29TnOEzcjCMABitMDz65/5hM9RijFM3N8ZRtBzEB0GX4fGEcET3n0B
         qGuUtG5ypBT2SXupHR3/vrf2SpI0jzuZkUfKeUyO8y43aeSpGFrnRGToqBlKUMuZXAmt
         f+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749668484; x=1750273284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZGyYXYc3SZhPlDKvAJZs+fBk6MmM4JqN/0ybuzC+cc=;
        b=PvkWqQE6x16dPQJXKdJnpf3tMYZzP89oTO3c1Zmc/XhZokCQ/K5DCjiQueWpz76p2D
         LQXO8fWYxaGgqaUg1f6jAxCCplzaO7t7ADIWvirW6I0UTVsousrgO0MAaGiEdV1DQvnK
         nqP6zSV5dKmJXHhOzLT7rtLeKmV+sRE9LUpklEEnKZvIH3eFkc3ANLY8dbQzgQexkRTs
         v43l23jwrqDnvqdSXCtSMkWPWkhz4cfcUc/zUk4o6VND1FH6FxR5XSHYAF143uBZueuW
         sT+K9UaKEeDXOm7s1GINlVlfSA5CxbpQNQHXbozPo7gZe7IH0TUV0Ppi9FwZm6MlPvTt
         vxSw==
X-Forwarded-Encrypted: i=1; AJvYcCUrsy6yjLW0hj0qId26fndCdceRWq4hLXB7Nbw2oDygcfcSoYQ4BckSDk1y1AwyzaxhqIRIV9wC7Zyi@vger.kernel.org, AJvYcCWR0TDoeylBhvOer/SK0GrOZJvwq9r5AapzcSvInBvOgu6l18GZPV6DwN1G/YenyYq6EhmHRrMH6inUoeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EA6GROqH4QySpcREeJcNIpxvS9MWIRSWuh4uem0yQm1IiR8v
	CHilznHDDsHED2zMTZWkRgdmvxkFpGEiLWnQXG9Xm4JN6rXMCP3Ubvgs
X-Gm-Gg: ASbGncvclGI6Zynu5qfwFZLhoeu4LZHRpZdDaguRrrQzggBel3H2qauT6QM/mnzFtyz
	MRxhqNFtUX7mo87woWjn2EEv6tqBHo9Eyfx/zeZweEobhB7P0QCqIqXSqTFsgFT9CibBrwJB8rv
	dvRgtsYnvevL5AnuwE9JalLhRbJhnuh2q5Mm/Cw++mYnnVkgPutigvAJ6nrzmHP1STF43GU+sRP
	chvQ9z/vloAnm8OSKo+O7AqNy9aGyJnX6HMaz0lE8zVyttjxQKmZ4A7aUyYtH+x0zx3XgkmCcgR
	4OucxgyKY0c7HJQRxEqbmhpgkAyUJCWd8ntmlU60tOzlnuUorTFirL21ow2pCjOcNNVEydgFiHv
	P
X-Google-Smtp-Source: AGHT+IEMmil3asp25VvB9Lf6ITUkxC/JbPLatMIJdku5ioTE3FR6q5SQWOrizUA/z/Q7dClNFGB6kA==
X-Received: by 2002:a05:6a20:244b:b0:218:1fa6:420e with SMTP id adf61e73a8af0-21f991040a6mr797761637.13.1749668483580;
        Wed, 11 Jun 2025 12:01:23 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:8839:85c6:8863:1c9:9e9c:ef7d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f892f57sm8766759a12.66.2025.06.11.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:01:23 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kwilczynski@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	karolina.stolarek@oracle.com,
	lukas@wunner.de,
	pandoh@google.com
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Add Error Log in case when AER_MAX_MULTI_ERR_DEVICES limit hit during AER handling.
Date: Thu, 12 Jun 2025 00:30:53 +0530
Message-ID: <20250611190056.355878-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an error is detected at a PCIe device and the root port receives the
error message, the threaded IRQ handler aer_isr traverses down the
hierarchy from the root port and keeps on adding those pcie devices on
which error has been recorded into the e_info->dev[] array for
respective error handling and recovery. The e_info->dev[] array has size
AER_MAX_MULTI_ERR_DEVICES which currently has been defined as 5.
This change adds an error message in case this limit is hit.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Testing:
========
Verified log in dmesg on QEMU.

1. Following command created the required environment. As mentioned below a
pcie-root-port and a virtio-net-pci device are used on a Q35 machine model.
./qemu-system-x86_64 \
	-M q35,accel=kvm \
	-m 2G -cpu host -nographic \
	-serial mon:stdio \
	-kernel /home/akshayaj/pci/arch/x86/boot/bzImage \
	-initrd /home/akshayaj/Embedded_System_Using_QEMU/rootfs/rootfs.cpio.gz \
	-append "console=ttyS0 root=/ pci=pcie_scan_all" \
	-device pcie-root-port,id=rp0,chassis=1,slot=1 \
	-device virtio-net-pci,bus=rp0

~ # mylspci -t
-[0000:00]-+-00.0
           +-01.0
           +-02.0
           +-03.0-[01]----00.0
           +-1f.0
           +-1f.2
           \-1f.3
00:03.0--> pcie-root-port


2. Kernel bzImage compiled with following changes:
	2.1 CONFIG_PCIEAER=y in config
	2.2 AER_MAX_MULTI_ERR_DEVICES set to 0
	Since there is no pcie-testdev in QEMU, it is impossible to create
	a 5-level hierarchy of PCIe devices in QEMU. So we simulate the
	error scenario by changing the limit to 0.
	2.3 Log added at the required place in aer.c.

3. Both correctable and uncorrectable errors were injected on
pcie-root-port via HMP command (pcie_aer_inject_error) in QEMU.
HMP Command used are as follows:
	3.1 pcie_aer_inject_error -c rp0 0x1
	3.2 pcie_aer_inject_error -c rp0 0x40
	3.3 pcie_aer_inject_error rp0 0x10

Resulting dmesg:
================
[    0.380534] pcieport 0000:00:03.0: AER: enabled with IRQ 24
[   55.729530] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addition of PCIe devices for AER handling
[  225.484456] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addition of PCIe devices for AER handling
[  356.976253] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addition of PCIe devices for AER handling

 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac66188367..3995a1db5699 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1039,7 +1039,8 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 		/* List this device */
 		if (add_error_device(e_info, dev)) {
 			/* We cannot handle more... Stop iteration */
-			/* TODO: Should print error message here? */
+			pci_err(dev, "Exceeded max allowed (%d) addition of PCIe "
+				"devices for AER handling\n", AER_MAX_MULTI_ERR_DEVICES);
 			return 1;
 		}
 
-- 
2.43.0


