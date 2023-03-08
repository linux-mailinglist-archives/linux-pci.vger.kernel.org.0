Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDF6B0246
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHJEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCHJE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B28D28237
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266251; x=1709802251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VGNqT1k82z7drWFYM5NgfNIaHrg6B+xRVIL+gTOAs7Y=;
  b=Ha2dRCoTvbJQhjgq5Q7e8tf7p5tN74F/EyaA00KPZFEtPPoe/LdeTBjf
   wDPvdFDh5oXbw9hKHDfVVtSZBUQJw/KdFsVsFH4RafvSrxrBMfa/Gn/Os
   Jk2vM/O55FkW4EALeLfJ9PdixWYZqVQGIdld/lHwj0cmgi5WnmV2weskZ
   u+RGBoC9iKNNWKA6flNWmzAQYbxpwFKt2chTTaNfP9wCo6qnm4Sk7p0cT
   tK07VrvglHOnr5VQePhFK2WFbWnUFpoMwsi22Y+0wgZqYE+HdqRj4/EVL
   WgpiTTAi9Dr/m3b60dMVRtJSZmlO9ABVT6iDKfoGFlPxxeFSKleB2pfrZ
   A==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880543"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:23 +0800
IronPort-SDR: ZL9goySBlCp6NkZEFdBaUqvgOgx6k9fdjc2ZLIb5T8rNgvoUPjSPUO41GEQpHZV5HXv6HzIBwy
 6RO3rw2uvY41cMt50yuUWzhhUScwqaY9BDLYQa2U+Mzn/LbmmpWYLNxFmDyLRQmWLGW7s6tdYZ
 3ogT1eKUU8/DQ0qp8o334to15572ipRxIWyFGyOqHAshCvaL0XYD19j9E5qKtvAvgCulRuJMUb
 bkGt1XeqelO25xWfCMo7yyr6ODv+5Kcbmn5WkaqrGgdj8bWKG/Cm6553gFoduAdqIrXv5HyAnG
 eus=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:20 -0800
IronPort-SDR: PczpF6iinySX+lN+9n6UUqU7qJeccX7nDMfPr2eODp5KUu0O0sCRHD1fzKo0hhqJIOcePXWa31
 uY6dkbyeDFnVLntK+H1zzZ9PDO1iyaHD/PATBNvl1VINKxNYkbgwwBpSnmA3N3eg7PZlkZ/G+x
 NOYZc6PITGhjuNsQzeSKl41uYYui+MmCuMMvR8gAc0j/WY9Q7ZCcqKUJ0Ig333dLL8LrPo1+b/
 co1RpWf8OdN6uIldL3tISZmx4AGAcFXesJ87OzC7nNX42VL2DsTu1WXVrE3JALHJC0ed/SDZCk
 9BY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZ265j9z1RwvL
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266202; x=1680858203; bh=VGNqT1k82z7drWFYM5
        NgfNIaHrg6B+xRVIL+gTOAs7Y=; b=HStkEYa0KcVnhGDvp6rC+q8zJAqu+L8khH
        hbfTm9Pd/Ycu7xgTN8dAUN0inwYzcXBPGaB/zeXH6zeZKdM4Mr+B5DsgrtJfRFGN
        MlCMyl1QCETtQ4Rym4PYxV9APFbCIyJxEX7XghWeBUvtU63A2LkP888GfVv+aqAg
        hHBRwJhKf5W0bomiJVdBkZfKLQ/wGW0j/bmmtYIg6ehSi0yQ/o6yjOUYCoQFiYb5
        8OkEpt4G/8de9DxpG2pb8PBnQru1eG8ydvAQI6xO5W1+ufOD6SZSAPgcsLp87IYP
        l27nU6LRktLoPM1i6awaJt1azWhEtpGTDZgg+V9u+h+0sm7om0iQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uc-hptn-PAiX for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:22 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZ04SXQz1RvTp;
        Wed,  8 Mar 2023 01:03:20 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 03/16] PCI: epf-test: Fix DMA transfer completion initialization
Date:   Wed,  8 Mar 2023 18:03:00 +0900
Message-Id: <20230308090313.1653-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

