Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5E6B0253
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCHJFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCHJEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B3BB
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266277; x=1709802277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6fb/ATpu4bjomFurbyO/sIS4IvcEwK34bItru+sYXM=;
  b=DeHxM8oEp8m4zkWj3/+nopJYm7Ah1i3iY5psvmOMrsa/9KHFLUfi3RBv
   eZWCPp5kHWIpXcLLAlNVZAm9SdHYVr4c0aTddX9xRDYHs1l00Upzk5cz1
   QVSBiPWnIHvRHQafYnNwzoPffKnTNumH1ijS/UCimhgo3QiwBAGvsWlt0
   0qVxc5GgUKKovDEwve1p5fyjM+M5Wnx9UYo9lKWYOvR+21aITW0pTSK7/
   UWbdNUPq4O++3O7W/W+GZyGT1FkLtJJxKAN8p1X3TRkJ0d3h97kVg6uq+
   7JqTiF+kN7PSPgZZdRStfJTt1/5fGndxFv4iLo+A8Um8Vx3u/Vlrz12JG
   g==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880577"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:41 +0800
IronPort-SDR: n/zPGuPZF6uOBklpYlL8B625G5xjH8n1IOivPdZsjbIyomxm6fRnL37sAMTR4YJpL9bou1tSyq
 4XMgjDkMp4YVo/Qa2/27LkUorUflyTUEp49nEzl+dTMED41qk7ZS0spA958c+0URy+T0rN//Kk
 le3+di6BTcli/dRkrBdjsWLWMM2oVOHAwRCkcW6yX9zFNu4Qp0/kzGwX8t+fYFnVlalnv12vtb
 RhCJbQ0ySwvIoE8ZlBhIWlLyUDxC5uzkN6IAMiBVrSuhQ9GwHGj9e6efSUHHmJLpxl69rU4XGu
 /xw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:38 -0800
IronPort-SDR: si2Y5ICgJk/S6ThnQWDxssv69IuZGfrYaaXx9lpOjsHvFlbrcE28N6gqyvoWVFxBclXXuP0DAf
 EJbA153GkaYmmFpXlwUQUo+fNcC9YP4Va5umlLrHvlp1y5X5wFkdOmdeABuedaar+aTOY/W30W
 23JEjziTbCYovo1DuElRz3IV/rFNtr4fS25G1s1/9NhSm0MtzEDbJpfpWVy8olz+qi/8yVr8v6
 44E5rTSkB0CO7Qgc/RumhYCxzZbM9fgqy1uRGFuqr/RFCZHc9jPsji7LOSAXKquEyOTV/eshCQ
 q1o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZP0fN4z1RwtC
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266220; x=1680858221; bh=c6fb/ATpu4bjomFurb
        yO/sIS4IvcEwK34bItru+sYXM=; b=SD5Y+A2QNAkZwql1A0LGUSLq1xuMzvwUBq
        8r6LTW7eHVhnjTOjzn5MXnN4fiRDDXaSgYlzoRZTScpJIs0gMjgUkyO3eSOQGLZS
        vYppmLkAWaysWUT3Mrjgo423BOhwSdH6NOeMZAF9VyFd/P4tTNnKa3xqMlElPyNr
        +bFBz3EcjeiyLWtpsmvLoUL4Y0auTLAhbvioHh2gnrZkSUp4LSd4ZOH0bdGUO5rx
        p52qX2aJGDkvNppZV//N2R2L45uvoN/Fm2BefVMDv6W1KLglKyLHRnlzmdzw83Eb
        hZPTNSwEk5hcNOwggWJCJHE9zo9Oiv4eSvwzi/r4/cponOkWxO6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fRL7czUNH1sl for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:40 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmZL6sqFz1RvTp;
        Wed,  8 Mar 2023 01:03:38 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 13/16] misc: pci_endpoint_test: Free IRQs before removing the device
Date:   Wed,  8 Mar 2023 18:03:10 +0900
Message-Id: <20230308090313.1653-14-damien.lemoal@opensource.wdc.com>
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

In pci_endpoint_test_remove(), freeing the IRQs after removing the
device creates a small race window for IRQs to be received with the test
device memory already released, causing the IRQ handler to access
invalid memory, resulting in an oops.

Free the device IRQs before removing the device to avoid this issue.

Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index a7244de081ec..01235236e9bc 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -938,6 +938,9 @@ static void pci_endpoint_test_remove(struct pci_dev *=
pdev)
 	if (id < 0)
 		return;
=20
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -947,9 +950,6 @@ static void pci_endpoint_test_remove(struct pci_dev *=
pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
=20
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
--=20
2.39.2

