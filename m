Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB76C8C01
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjCYHC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjCYHCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D661A16AC7
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727769; x=1711263769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxCZujNEUTbNED023BSGdq18vAZhegc8Tr7mjQSp0FE=;
  b=n8eGSLEJmakUThu8VsNM7UD+pv0xF7oYuE3b8sXUwJZrp7ZTBUEeCk8f
   mIXFv1ccaTOc7aB8FlYDDG7mggnw5zy2acxqTA5Z1T3AAcc/X57agByxe
   wnoRctUj/iUHdCz9KHr0wGmDUOns44xu3P3Tl4tSQI97O74YcRvJHND8w
   kUlH/CqitWylh12rUkISJb7WfLVzyAmx2yPrfu+tXrKtWZvsOHR3U4JJq
   U0ZjP6pQ49sG0rne2cdf/DrCe8WhoayIcLK+6WA8U5qB1Ogi8shcYaD6n
   Oz97BreLJK4PKLurNXEc+9d1ArbWIE6wSicN9F3d71eLd5DqF4xjs4vVD
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756874"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:49 +0800
IronPort-SDR: taO9EbDo8XzBAYzp4IAJmw/olpBs3J51WCBbQOKOAWln0d3AJA57pL2vYcJDwka/Yz9Zdki0+6
 UKo3RbxbkV2ppcDVrM03sQx8m2UwZvr+UOGrrCcZQ3UmD7FYo2g4mndqNNd72nECXRftGhpbgG
 73sLnOJRhuZIdR6u4v7y5EY/lNvtOnewCPbGDAKZguKJ3IiZJqORDCL3NFLfYs68y4xy9zo999
 OFHlY44qUQlAB1qLeNKIUQNGYcTz0jyiormx4+JAnmN3COA/hyC1HaI9AcKP5uBHznWYZYF6Kh
 58M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:04 -0700
IronPort-SDR: lnWwSbnUsVKZJ4+84IaRL3I3WjBcIK9rGNkE/zigrh+WBmzHcPftVj3Owc+j6BJYEpKO8n8Smb
 U3krIIj4QUCeY1UnXIG7jusTN84PPDqvUTKLljxmgjB13qMEKto0qjjfV8FVM7wJs4CFdnlDCm
 mwQtuH+si+lWKFVS8qh+Lo2cnJfd0X0kPIC1iHQ7JguLZv59EaXvCsToa0VA9Mbobj1Qw6xUhc
 Ny0pahDXgB3y+A2L0414s5054H+CrNteD8+lRDg/P6gQmrfZ6P2NxnWLDQF8Ij8Vr1MUhX+FI5
 KbE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk9550n4jz1RtW2
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727768; x=1682319769; bh=mxCZujNEUTbNED023B
        SGdq18vAZhegc8Tr7mjQSp0FE=; b=iYunxu81F4LmZrsfAi3xWIkivYiM82pEEE
        IlnVmZnkpCTX8U88sutbMqvwyMg5eg6iaRcKtdyAUgqL20y+WynB/xd9HVmiZZce
        2NvaxC16jopZ+JyQjP/dZ4xxEubuZZFhhxFHIUiEtEgoM0364T3c91BLYPoPcv5Z
        AMR93QZhedkDM+6Kd2yeFyRBlDiz+3VaAJw8Zk78f00Yan6coTSb+RSk3EYfVhrT
        k6sFIv2kbOnw/RVaJ6SE1sUWAHKtIBx41wTswqlG0rz1yRmST9SE3b9uMG6XvwP3
        txB69V7MNBlQ3R3J0EXOT5hkzQXg61tPtUfUGspb8jysztq0LsDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SQ7RXJkvpXNp for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:48 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk9525K2Tz1RtVm;
        Sat, 25 Mar 2023 00:02:46 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 10/16] PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
Date:   Sat, 25 Mar 2023 16:02:20 +0900
Message-Id: <20230325070226.511323-11-damien.lemoal@opensource.wdc.com>
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

Command codes are never combined together as flags into a single value.
Thus we can replace the series of "if" tests in
pci_epf_test_cmd_handler() with a cleaner switch-case statement.
This also allows checking that we got a valid command and print an error
message if we did not.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
index fa48e9b3c393..c2a14f828bdf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -676,41 +676,39 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
 		goto reset_handler;
 	}
=20
-	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
-	    (command & COMMAND_RAISE_MSI_IRQ) ||
-	    (command & COMMAND_RAISE_MSIX_IRQ)) {
+	switch (command) {
+	case COMMAND_RAISE_LEGACY_IRQ:
+	case COMMAND_RAISE_MSI_IRQ:
+	case COMMAND_RAISE_MSIX_IRQ:
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_WRITE) {
+		break;
+	case COMMAND_WRITE:
 		ret =3D pci_epf_test_write(epf_test, reg);
 		if (ret)
 			reg->status |=3D STATUS_WRITE_FAIL;
 		else
 			reg->status |=3D STATUS_WRITE_SUCCESS;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_READ) {
+		break;
+	case COMMAND_READ:
 		ret =3D pci_epf_test_read(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_READ_SUCCESS;
 		else
 			reg->status |=3D STATUS_READ_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_COPY) {
+		break;
+	case COMMAND_COPY:
 		ret =3D pci_epf_test_copy(epf_test, reg);
 		if (!ret)
 			reg->status |=3D STATUS_COPY_SUCCESS;
 		else
 			reg->status |=3D STATUS_COPY_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
+		break;
+	default:
+		dev_err(dev, "Invalid command\n");
+		break;
 	}
=20
 reset_handler:
--=20
2.39.2

