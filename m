Return-Path: <linux-pci+bounces-30207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59776AE0D29
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 20:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC13A1C21756
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4830E858;
	Thu, 19 Jun 2025 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgGZFW+/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A330E829;
	Thu, 19 Jun 2025 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359069; cv=none; b=nVDpJO3wgZMXBWR7qqQ3efv6vItdkVSI8tZHs6oZLphnqSWVBjMSZfuUZ3C9EFqMdvNwEttfPIYrt0hFcVgdVwLRHxbFgUmheWCi7V+AiLC2zfTVbgQbUKto09lULqw29B5QsH+IWFcwoLa2YUpBwQ5R7HgPPrXUPfhbgwfdUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359069; c=relaxed/simple;
	bh=V6FgTW5bpQroTIYKEuUph17GQ4t3LAmXbkQjPBSHntQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4R0F8kJo1ruyBVFzzOHUlG3BLhhzGIcroZ1v4LpNbKK38C3CN80m2WAmgGcIU21yxsEvaMhZkAkAJnBdYgQW98peMkRuKVVtO3bm85Bnmni+wVn44wna67jP3OdUjJnCfzTqLLMBwqiNdx3E02sXdpW0glPusRSLXPoOFPRXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgGZFW+/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso867689a91.0;
        Thu, 19 Jun 2025 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750359067; x=1750963867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fG8L2UBhkMD+msjH2Zyh8X1xh8BD75kzdzrp0NcX/38=;
        b=hgGZFW+/55lw/EvxhymxJZoFdEP3/zsfgHhvIUAGiDRKuIAClK30a0MoFXnvjrAz4O
         asOrb7ARDPhFgt0rEADY/RsJrWb9CER2eFF9xFTaOPgbBxaieWhofSy0Z1T0nA3u71nk
         LEcV6gfU2TAg2yKLuqL1INWQNI5VrJvsVI/LPhYC0NUeA4csdtnIbikXlvHOZHPLW3Cn
         rIh1wCSZbtrgblgvUtuuEjSsykHXsDwUxj8vItNwYPLnjKIrk4k+vzSz+W6k4jcRRhq8
         gyjtYFu+J8rt6LzFPDPek8qELrJbaq6EcmI8hSocTPcSENQoyGkFYJF2oo2xDtXLFvdC
         rkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750359067; x=1750963867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG8L2UBhkMD+msjH2Zyh8X1xh8BD75kzdzrp0NcX/38=;
        b=SqbqQUmtSP+WC9JJA8lJXE7j9U0WtTMdvMwMiPN4E2aBM39Il3y5nPRtzw9h5RoBuP
         EkcGRmCL2OBHJ/zb70U5xpXow0kLLnvNTgdYCTDKYX87d7wJedlkWgD/L9DEnqCwkhW1
         df92ShkqyEtJrPVD2/jciIfLT3FqEKUYyu4OSn8U0/Sve1Z7BZCTdSNq8+VNy4c8TdV0
         qRDSr56nsgZ7pcsf7qeyR4sh+Igq3QcdvyLozNE53kIgdLtOaPJxGnGr/F5UlV9ARslV
         3N8P1U3LfsQ0BueLKmqtuGCauOITaljtRGhsW3SzZ6prVWeJad45R4W+coMlwuldDUs2
         Q3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUNqtfW7q9coctMC6kKdd1NUa1d4ouB0BgTcF0qKY1GS44IAuaBnyA8gBbGw/IPvcBiHU1EyYaLU71W@vger.kernel.org, AJvYcCXC11SmN5R4wFL3lWl+rPVEppCA8cmO4Ga/rSe7RLGZz47UlBNww+Zh8kzEJEnDjN9JCOgMReutwUqnhoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvNAEs8Q5/QuyPWvrgTNdbhcxvsAWSd/szYG4WgJbf9nVC38w
	bM6otIouF1qBvZLjSJYXSpPf8lxgrMYEBMMqrtj50Q98RLEN9gtlIEMNSvwc40Wo0iQ=
X-Gm-Gg: ASbGncuEgaMljAZP0MNFBPyRzv9GiPj8elTtQN+xc13zBJ5QH0BvJsj69O1LjS7Vb6O
	vUOKP6wyxMSXSfSyswtgsQj+m2RzC1ZpVq6rTIDhjpBO54m+H8oDEgzkvHdYIfMGrparwnFN/01
	hr0TjcgZtAf8QwRhUIpXYriGDPp0WxH8/J3cCgnn1NK1Q9pP72SVsADcrsNODgXpUYnx1Sk0/UR
	ydEqbMl8mgh2l8hF7YctvRp5R8nFjnicFv0clTrOjLQDwfDgFy/W3XKtPNjV59oxDzqTs6qR715
	LA9cY95se32arr66Hr+tHQCUFgNbEeOCMRuJ7eTb5wsse8nkc4yXVZ3inyGa+Aq8f/q7fjLbBWH
	Oqw==
X-Google-Smtp-Source: AGHT+IHY07cWD3/UkHvQ+C8XH2o0tDncDzeMoJCIlVijlJqxL2AQusdDBC+VP0O6B4Op+4zXXreWaQ==
X-Received: by 2002:a17:90b:5625:b0:313:bdbf:36c0 with SMTP id 98e67ed59e1d1-3159d5779femr676440a91.0.1750359067287;
        Thu, 19 Jun 2025 11:51:07 -0700 (PDT)
Received: from akshayaj-lenovo.. ([2401:4900:8839:85c6:508e:51d2:91e1:30dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71d49sm44927a91.5.2025.06.19.11.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:51:06 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	mani@kernel.org,
	manivannan.sadhasivam@linaro.org,
	kwilczynski@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: Add error message when AER_MAX_MULTI_ERR_DEVICES limit is hit during AER handling
Date: Fri, 20 Jun 2025 00:20:30 +0530
Message-ID: <20250619185041.73240-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a PCIe error is detected, the root port receives the error message
and the threaded IRQ handler, aer_isr, traverses the hierarchy downward
from the root port. It populates the e_info->dev[] array with the PCIe
devices that have recorded error status, so that appropriate error
handling and recovery can be performed.

The e_info->dev[] array is limited in size by AER_MAX_MULTI_ERR_DEVICES,
which is currently defined as 5. If more than five devices report errors
in the same event, the array silently truncates the list, and those
extra devices are not included in the recovery flow.

Emit an error message when this limit is reached, fulfilling a TODO
comment in drivers/pci/pcie/aer.c.
/* TODO: Should print error message here? */

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v1:
- Reworded commit message in imperative mood (per Shuah’s feedback)
- Mentioned and quoted related TODO in the message
- Updated recipient list

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


