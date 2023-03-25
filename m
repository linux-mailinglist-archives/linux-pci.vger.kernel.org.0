Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121A36C8BFA
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjCYHCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYHCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04214200
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727756; x=1711263756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mBNv4vFEtRrRogU1bpDNqFs895hGS3croCKNhICIOZA=;
  b=LLxnY16/iCXFzwnhHDtGWkut/iIhkjg8id+CSWuojkkyuzJjMGyn7sqn
   pXU9Fe4+AYKTcD1d/cS0fPSa6NKwULSG0wADj4zeUNrStU6vp5zZBSWVd
   8Y/HtnE8lRie3pUoALCgE/nDs1djCRRLpBgu0eBWGQwvaLXu6YEmt3mDO
   NtBeLT8ps23dwwFRy8klJVzfH6P7rI076y3uLU6YalCSpCLqPO/m7Aza2
   lYxzwsh8Y3tjrqV32teZQQHmUC3+sCPU6A6qJqFeEQlud8jI2eIEZ7CWk
   0s9V60PnbnpknocwfXpDmmdxwiLWFQkSlz4CkTeOOLLpfteNOcTL6eZuP
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756692"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:36 +0800
IronPort-SDR: sQJgW0QUnE3zjMwOLInm7aRsdf/ZEdWnlzi60QcJWxZ0BWI+7kk9horJXSTjV55RKDHGnL9kFq
 Tq38ZMWpK9c901iwL7nr57e6flYHUDn1dSJANAc8dErbwAtvEurgG1C+AkL/oFXx3ALT1vsYqY
 EKjiLRyCzDUMo/iusApyDOlKiRhfAUN00BLGqcmsbeMdfzienAlEvG3n140nP2kD7kOTs8WMkb
 K1z0q1hr3HE61enYkBNHAAnq8nqctK2CrL5UjNOy5RLkAHX4KS1qYEdY9dxHHP7mwok04gwrYb
 ap4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:51 -0700
IronPort-SDR: jQHb5vp/SUAPzdggVibGzOa4+gi4giz+r0xqv/U4NhuG3oovq74KPUEsq6QzvN9DS4yYi2Pu+i
 mW6FRFWr72pSNjnRN8tlPA+Ft/h04t/unPITs1jKHJywOAuO2HqrsQorrGXUn20rUKOA4skfrc
 UZE/wkQSvJbvyrO9QR9SKgy3Fsud6cwa2/FdR6wETiTyGqIdufKsAs57gRiq+mZSUTPJmcO2e9
 QTrXC5xYXii/ufvFsR3PCYsYTVlgq02NWGrL4sNGR10U9lc4eIqOKX2c4T8RknlsV8UeBcX2uu
 UhM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94r0ghBz1RtVt
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727755; x=1682319756; bh=mBNv4vFEtRrRogU1bp
        DNqFs895hGS3croCKNhICIOZA=; b=Y+yUHVN481irTSxovwlRnTHO8VRH5axgyH
        xK9ew9B3qLNNwTY/ik6/AWg61btuuqAlGR1I8LNSAqdmZbyOIPKkqnBl5uiYwrQY
        hRzr3t1/tbD4Ri9QAcFhiJTruS2SkK9iJjriGsvt6h6s14lGti13YpePm1ITzH45
        DdfcbqT77EiyQazsMcR6I1Z3l+aUNTfMZl7BM5e/jDW0Ggrrx6gZGkLGHGp3isIW
        mGqB140C7tKSQHd26LMSbSEQP344NaUICNjnFSxqWecPOoem0uR6+XA7T9Gknuy/
        nc78uyHVltuddgddh+eHnuWma4Rut3f2cXWzTJGzXjiPrezD1IdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dAWpUvHBtgPm for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:35 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94n69J2z1RtVn;
        Sat, 25 Mar 2023 00:02:33 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 03/16] PCI: epf-test: Fix DMA transfer completion initialization
Date:   Sat, 25 Mar 2023 16:02:13 +0900
Message-Id: <20230325070226.511323-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-initialize the transfer_complete DMA transfer completion before
calling tx_submit(), to avoid seeing the DMA transfer complete before
the completion is initialized, thus potentially losing the completion
notification.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with =
DMA capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac..d65419735d2e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -151,10 +151,10 @@ static int pci_epf_test_data_transfer(struct pci_ep=
f_test *epf_test,
 		return -EIO;
 	}
=20
+	reinit_completion(&epf_test->transfer_complete);
 	tx->callback =3D pci_epf_test_dma_callback;
 	tx->callback_param =3D epf_test;
 	cookie =3D tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
=20
 	ret =3D dma_submit_error(cookie);
 	if (ret) {
--=20
2.39.2

