Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF006B0254
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCHJFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCHJEr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E09AFDB
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266279; x=1709802279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNNBPPwx3BeLf51ftFKDBjdeNrqS7hVotbLqERxh9VU=;
  b=OXCTEIDIj0yxNgsqmX2qALt3gut0ylG3QPYtTFH5vjq3rchdBPe2zu7n
   kz0mwd4p7pSJoKCPZkSFkPhAgLWviE8NLzXBR991Mf90AMUxTOmG8AQ8R
   VgSXBykYuFmM6u99UxNGUf/CN9TuNS7MnBt9saYBhg2esw8EyGCVNoAz8
   YWAdOCXfB9CYGPOzOcH9iRZy9Hc3lk+ShGj5Rmrjh68CpEqaeNxSsOnlI
   Weqb4NZ0fuwMjmTH8w17jOKYNLWoLrVsurrnH1wbC4ZXOPDlzVClPRykL
   y4rlZ33x95fDQBeKFgNLBBCRMIqHNxYX7G3BWwkSePl/N/BE55/S/giDv
   w==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880582"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:44 +0800
IronPort-SDR: 9LreVowlPPKXM7oevq8PCTVeEZHywabT9v9IWbVrMFCdvkUbIn4CenrVVOvLbzyqymqf7z92cX
 PjHvWkqj9cU7iKvBTT8HfsPnvBRIrXihwnorGGRgYTpZK7NGPGeXknGHlurhsUY/eqHvgH59EM
 wq0mS4ALGkjciHtDefhB97W59aWoDNdPvHaDe4xOh1WliJTrhxdbhR/tFsMGmf7fXUwM5MNsXP
 TlXvS3EY/PgKvS3qBkTKM2xXN5WQxStpy3XR1+QmL6eUkWHvFJyfwBFR2DCamI574NPP+VlcMe
 TvU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:42 -0800
IronPort-SDR: nxQtXTc4CZi90YVwTnMS3nMoT+caqqYgtWkzkQhRdqcEfLfV9C8M4G9HDyZWt2ZriIeK40vZxy
 kgb5iahCaEiSuA5mkQ6e4zUj8z5Is3A19rhNmdHqteX0ZLnetJaTrUJusXDVjZFbDedUFC3pOr
 JmyHQYZ7WuIEiPQtX/fm384qeuW0d5YKRYFKczMo3kPWf8slkMi/6fLOB8krovoC3UaJ0TiEJJ
 DUe0BwSU5H4r0A/hKsXz6G6gbMcIDIQFwY9xiNmuMIfDvLjdrHgw1RJRAagGlagNCeoKdhjkVL
 eZk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZS4Szcz1RwqL
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266224; x=1680858225; bh=nNNBPPwx3BeLf51ftF
        KDBjdeNrqS7hVotbLqERxh9VU=; b=TGPl+6/vUwxSaiJMCycHS0F6ymENj01AhH
        RUbLECRmf+BJLlWb7eCZV7o63Pud21vULUyXSEs651hptZmsmv2yJxRJgbTC0tmv
        4Apni0r0dOI2PYCTY8esP/+3D+Lo8yZf1j45vszI8NcP+kKtXoisDNPX/zR7pGsK
        W7LjvySxdv6bc9nYj9LsyQoLZSUu9WlWMeBirzZT3kaEoO12wWAiumjWyq3FEO9W
        toSSWQfR/NTxwe8ccgHHMg0MHS2bPasrX9FldCluCq3qFZSVAHvgxo3P1BCsPssg
        0VVR/ofTV5qwqO9RuebIAdBSKAlaodw6sOMDhsRwIHRgZiIpnWVw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YUAHgLgvA0D2 for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:44 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZQ4Sy9z1RvTp;
        Wed,  8 Mar 2023 01:03:42 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 15/16] misc: pci_endpoint_test: Do not write status in IRQ handler
Date:   Wed,  8 Mar 2023 18:03:12 +0900
Message-Id: <20230308090313.1653-16-damien.lemoal@opensource.wdc.com>
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

pci_endpoint_test_irqhandler() always rewrites the status register when
an IRQ is raised, either as-is if STATUS_IRQ_RAISED is not set, or with
STATUS_IRQ_RAISED cleared if that flag is set. The first case creates a
race window with the endpoint side, meaning that the host side test
driver may end up reading what it just wrote, thus loosing the real
status as set by the endpoint side before raising the next interrupt.
This can prevent detecting that the STATUS_IRQ_RAISED flag was set by
the endpoint.

Remove this race window by not clearing the STATUS_IRQ_RAISED status
flag and not rewriting that register for every IRQ received.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index 24efe3b88a1f..afd2577261f8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -159,10 +159,7 @@ static irqreturn_t pci_endpoint_test_irqhandler(int =
irq, void *dev_id)
 	if (reg & STATUS_IRQ_RAISED) {
 		test->last_irq =3D irq;
 		complete(&test->irq_raised);
-		reg &=3D ~STATUS_IRQ_RAISED;
 	}
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS,
-				 reg);
=20
 	return IRQ_HANDLED;
 }
--=20
2.39.2

