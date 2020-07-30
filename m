Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C5232A78
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 05:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgG3DiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 23:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG3DiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 23:38:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A7DC061794
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 20:38:05 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6E3C58066C;
        Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596080280;
        bh=rFG+x9+HZow4TfntuPbVyKu06FhRpSlKls/VE8rrwy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NxsGlQYxKUvwG4/yFORQSC1CkP7rmui3UCdjn/IKcuC8MacOpU20yqC998oGNuGxX
         gZg67tr4OdejJopPRUKGdN0d1LXDls6OC6Tak9/B3fCJ5GdKwRwwF46g+Jzlls9Bit
         Im0ALqoAcnli1W3to1odZ1maSOINii0iFsifHInsT7sl3n1M6q1qQ2qR3xksztPwKI
         MRYa3AJzzViqsJEFDt/8QzjJLUhmMHlm+5KWevVL2n/dk0vZOlnTDSqIACAA2+gMsU
         3tZfj2JDhsNbhXvoT+J7KWj3A4uVkFMrSW7Jtqtf+AXQl74iGbsktUNFQzMUQyVGAj
         kuUfQlFNGhqdQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f2240990001>; Thu, 30 Jul 2020 15:38:01 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 047A813EF9B;
        Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 407DF3410D3; Thu, 30 Jul 2020 15:38:00 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 3/3] PCI: iproc: Set affinity mask on MSI interrupts
Date:   Thu, 30 Jul 2020 15:37:47 +1200
Message-Id: <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
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

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
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

