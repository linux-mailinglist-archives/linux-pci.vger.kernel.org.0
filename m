Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B17481CF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGEKQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEKQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 06:16:06 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD0180;
        Wed,  5 Jul 2023 03:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688552153; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TO6CBiZM6rIvspbbCHpYwuYx131U55KHTzl6zYjuIem9eFoOzWBUVmKAPJH4O/iqJNGJl53ZeNoC5N5WT5O8Fy8rrJy5lNMbKn91eNarLyPqunG+9amng/ZoRRNkvPDAoo9c7gNiRU6ZTBI3W1neYjr8uV1QDZ4QEiRzz07iMjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1688552153; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ORF7Ovs8ZIRMgtit0KQW/qwrGTpNeUvZ6qy0scFOmfo=; 
        b=mjNfPRgzKZmDKXtyngbIboAw1fS0KTcsbNUirmwgDH4cp36IRJDZWyumEHLuoXOvSuK/qOCOEI+n8mmUdHUlp7hE1vJ4j1lQ33sf2RhYUcKOjjrk3jJaH+rhg8IDk3N4xn207h04gpAroFSo7zCAAnVDHrRBHYCKozeBokm6HSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688552153;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=ORF7Ovs8ZIRMgtit0KQW/qwrGTpNeUvZ6qy0scFOmfo=;
        b=J43UCRVChYV0ylWPgjjT5A8Q5uURtmGig7XxWGNT+lFnNerL80vbJdn+VFCJzoJO
        x4ZK2a79saV7P/Uu8+19I1RoAShwMkq1zGUKXTAfPZqb5w8Og9ytwxA7KpxrIr2t+Fj
        yVABDip1QuKTqvQk3hMXi/wKoUxbo/vT07S8XD1c=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 16885521516611005.9087764533741; Wed, 5 Jul 2023 03:15:51 -0700 (PDT)
Date:   Wed, 05 Jul 2023 18:15:51 +0800
From:   Li Chen <me@linux.beauty>
To:     "Tom Joseph" <tjoseph@cadence.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <189258d19e1.1132188131010980.7371471641115980549@linux.beauty>
In-Reply-To: 
Subject: [PATCH] PCI: cadence: remove unused cdns_plat_pcie->is_rc
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We already have cdns_plat_pcie_of_data->is_rc.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index bac0541317c1..e091fef9c919 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -18,12 +18,9 @@
 /**
  * struct cdns_plat_pcie - private data for this PCIe platform driver
  * @pcie: Cadence PCIe controller
- * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex,
- *         if 0 it is in Endpoint mode.
  */
 struct cdns_plat_pcie {
 	struct cdns_pcie        *pcie;
-	bool is_rc;
 };
 
 struct cdns_plat_pcie_of_data {
@@ -77,7 +74,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
 		cdns_plat_pcie->pcie = &rc->pcie;
-		cdns_plat_pcie->is_rc = is_rc;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
 		if (ret) {
@@ -105,7 +101,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
 		cdns_plat_pcie->pcie = &ep->pcie;
-		cdns_plat_pcie->is_rc = is_rc;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
 		if (ret) {
-- 
2.25.1


