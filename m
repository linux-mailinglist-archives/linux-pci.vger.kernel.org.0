Return-Path: <linux-pci+bounces-36000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697EB548C2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5630A56736E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF42DF71D;
	Fri, 12 Sep 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OqAPmlMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF927CCC4;
	Fri, 12 Sep 2025 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671705; cv=none; b=h/dI4U47hbfKn6IhBD59hkdPEPuzfbL4wNzaARFapVAR2mrvgaY5Pxr8CjmxLnN+WXVuZBnBzbJdfe3p8mzKpk34INTcPQt9M2jGrdc5MT3debHSHYonrkc/9aNQyZeYECCH6r9rMth0lR/iy9a0VrthuVawwR2lvTvkGEvHnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671705; c=relaxed/simple;
	bh=CFr0GsRX1ePBBaWO+P0uLssrp1EXY24CAwGtNTif/Mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FEpqn0N4gvAeIhAmZi8K6vnTGZA5Ovw8dBfsSByM7LQvqoJLojI3Bz1Q2PBRCaQSqhCF1CgQPFTK8/Uqt8GsTWN03ZdJaxZQaKlXK9AcjB+AB1ynATWzXTJ+NDklzKaTapAAK6ByHafQZneD6Wl8z2MmQAvdazagr3V4WkFDMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OqAPmlMA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CA89L71011360;
	Fri, 12 Sep 2025 05:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757671689;
	bh=QAI1/iuQnmfWqwTdKggQ6qlQpdt/mhf+D90s4RMqkNI=;
	h=From:To:CC:Subject:Date;
	b=OqAPmlMAOuoKOdqjkDQVk7CR8Zfr19sScOkUTLrQ9o40U29VXVT5qcbB+0zUFJgyC
	 ATU1kr8XH8wO2J8FsofrFlavpJEZZw3D9em9ZpQCFnsdi1/fYEEw2kEOIF3M6LR0MC
	 fFIHP6GLgpgy0CCjwk3di+0WUK90kIcw19WXiq64=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CA89vI1904747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 05:08:09 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 05:08:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 05:08:08 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CA83MG3740807;
	Fri, 12 Sep 2025 05:08:03 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <sergio.paracuellos@gmail.com>,
        <18255117159@163.com>, <jirislaby@kernel.org>, <m-karicheri2@ti.com>,
        <santosh.shilimkar@ti.com>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/2] PCI: Keystone: __init and IRQ Fixes
Date: Fri, 12 Sep 2025 15:37:57 +0530
Message-ID: <20250912100802.3136121-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series is based on commit
320475fbd590 Merge tag 'mtd/fixes-for-6.17-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
of Mainline Linux.

The first patch in the series has been posted as a Fix in contrast to
its predecessor at:
https://lore.kernel.org/r/20250903124505.365913-10-s-vadapalli@ti.com/
based on the feedback provided by Jiri Slaby <jirislaby@kernel.org> at:
https://lore.kernel.org/r/3d3a4b52-e343-42f3-9d69-94c259812143@kernel.org/
Since the Fix is independent of enabling loadable module support for the
pci-keystone.c driver, it is being posted as a new patch.

Checking out at the commit of Mainline Linux which this series is based
on, I noticed an exception triggered by the pci-keystone.c driver during
its probe. Although this is not a fatal exception and Linux continues to
boot, the driver is non-functional. I root-caused the exception to
free_initmem() freeing the memory associated with the ks_pcie_host_init()
function in the driver before the driver's probe was invoked. This
appears to be a race condition but it is easily reproducible with the
Linux .config that I have used. The fix therefore is to remove the
__init macro which is implemented by the second patch in the series.

For reference, the logs for the case where Linux is built by checking
out at the base commit of Mainline Linux are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/f4891b707921c53dfb464ad2f3a968bf
and the logs clearly prove that the print associated with free_initmem()
which is:
[    2.446834] Freeing unused kernel memory: 4864K
is displayed prior to the prints associated with the pci-keystone.c
driver being probed which is:
[    7.707103] keystone-pcie 5500000.pcie: host bridge /bus@100000/pcie@5500000 ranges:

Building Linux by applying both patches in the series on the base commit of
Mainline Linux, the driver probes successfully without any exceptions or
errors. This was tested on AM654-EVM with an NVMe SSD connected to the
PCIe Connector on the board. The NVMe SSD enumerates successfully.
Additionally, the 'hdparm' utility was used to read from the SSD
confirming that the SSD is functional. The logs corresponding to this are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1b09a12a53db4233e82c5bcfc0e89214

Regards,
Siddharth.

Siddharth Vadapalli (2):
  PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on
    exit
  PCI: keystone: Remove the __init macro for the ks_pcie_host_init()
    callback

 drivers/pci/controller/dwc/pci-keystone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


