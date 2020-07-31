Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAA233DC7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 05:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbgGaDkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 23:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbgGaDkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 23:40:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972FFC061574
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 20:40:16 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1C375891AD;
        Fri, 31 Jul 2020 15:40:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596166810;
        bh=c3Mb1DFTef2VM1YjD4w1WXqceQCGAk0yf6N673Ih9A8=;
        h=From:To:Cc:Subject:Date;
        b=mAWv57ldWaW48EWrAMTR4vWHTBrzmVBRnSTLQgW6CQZHVCyZ3V1fqVrAh89dY1ys7
         mSk7O/z9ikVKXxlpD3BJtGuKE7N/h1OH30QKn5mDJlbJ0Ciuj0GABHlkdI62zuIINe
         yQ9ZiBU1/+UP7pYCFPIrsGyYkI5XgvpVszqs8YEz6aiSOG628ilmHz5xzYiAj0R81k
         pQGFWIMmWARnCL6h8Y0lRgizmlSIZIume6p0zbNsYvdi9tYwTCBvPcs5RpRi11Cvcz
         UP9cbIpkRceVJqKvjxkiGUc6bUaKgEJUt9WXUtanWxUMBL/Brg3inhuTlf9e0fhL7j
         tlfC33cGKtVAA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f23929a0000>; Fri, 31 Jul 2020 15:40:10 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 3296E13EEA1;
        Fri, 31 Jul 2020 15:40:09 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id D9315341110; Fri, 31 Jul 2020 15:40:09 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] PCI: iproc: Set affinity mask on MSI interrupts
Date:   Fri, 31 Jul 2020 15:39:55 +1200
Message-Id: <20200731033956.6058-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The core interrupt code expects the irq_set_affinity call to update the
effective affinity for the interrupt. This was not being done, so update
iproc_msi_irq_set_affinity() to do so.

Fixes: 3bc2b2348835 ("PCI: iproc: Add iProc PCIe MSI support")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
changes in v2:
 - Patch 1/2 Added Fixes tag
 - Patch 2/2 Replace original change with change suggested by Bjorn
   Helgaas.

 drivers/pci/controller/pcie-iproc-msi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/contro=
ller/pcie-iproc-msi.c
index 3176ad3ab0e5..908475d27e0e 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -209,15 +209,20 @@ static int iproc_msi_irq_set_affinity(struct irq_da=
ta *data,
 	struct iproc_msi *msi =3D irq_data_get_irq_chip_data(data);
 	int target_cpu =3D cpumask_first(mask);
 	int curr_cpu;
+	int ret;
=20
 	curr_cpu =3D hwirq_to_cpu(msi, data->hwirq);
 	if (curr_cpu =3D=3D target_cpu)
-		return IRQ_SET_MASK_OK_DONE;
+		ret =3D IRQ_SET_MASK_OK_DONE;
+	else {
+		/* steer MSI to the target CPU */
+		data->hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cp=
u;
+		ret =3D IRQ_SET_MASK_OK;
+	}
=20
-	/* steer MSI to the target CPU */
-	data->hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu=
;
+	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
=20
-	return IRQ_SET_MASK_OK;
+	return ret;
 }
=20
 static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
--=20
2.28.0

