Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBA6C8C04
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjCYHDA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCYHC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC968166FD
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727774; x=1711263774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6fb/ATpu4bjomFurbyO/sIS4IvcEwK34bItru+sYXM=;
  b=SXEURKL3yXm1lj1FsyMVgfL0T9hpd7ZwXqxiTX8Hg7+itIpGelzsQ1m6
   /h9nEj7F2VSDZHSenmYey3Mx8rcT/F3zZGC5s/LSPDpLVQT/I7DSuYYAI
   Ca+5Zu2XVcy6ctmc/UR1HzoNvJZ8KfIJaaA3OpmdNcWUBMqOXTqk/dKCf
   vAiSYUgiHNWfK8jCPTOP0WirkVTZuAt0luxGx6JIxX3G9v0z/8c9icNQX
   V+R9xkIApMd6HqthnVFhx2TrMQOTYXodx7xBKCOrA6mk9VVAJhbmgXo7z
   qhmzJAkAcNbVTfrV2oCeV5q31wxxJqlO+3/yDEkyL8mVCSr+/ViCiydzW
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756914"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:54 +0800
IronPort-SDR: Xj32pD+NBZcLFnUVuP6cQIkMoi3ocj29VbG27Y28ABNOK+9wHX3WL9+rVQ71P8e73RrJFQAmIx
 Ov4tGhB+ufsSLBEcercupeaoNjdrhrRvF8hhm8o26XtSQL5w+ddgv2JDB9fphaflbQ3N8MJO1q
 abbW7+Jz44ZNwNnySVeWH4+a/YsETsxbJvwgVVFvDPngjxBy/P/glF02JbA18UUoWMjdVj4NU+
 rRiNY1RyQ4/QRf63lCSGTdDeU8sNiHT8ZbP0jbe1HoK1XSi/snJNx8eNQoSmBP2NNEt0xNepuZ
 jl4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:19:09 -0700
IronPort-SDR: sqYLNDLtobcSI76eAYWWiXg5Vmk6w1vm7p0Xai0/+mucUhXMbdx3aZfcj0/W1aDcrJUY/ral55
 GcsKnQz79O653ubjAeIosqWiipZGhExTaMw5+pWhWB9SW4KBIqos4DWtrwYSyR09TdYLny2ocl
 1KVh3cXZ42qe4ZSjQ+DInxbqzNZA2512NotF1OX/hiGOHoF2rKpbjy5+USwv3vO2u3thvV6KhF
 s8BMtObNnnVyh5cdZ9quMO6ExVO6Q7zi3mOnlBkiJv7DgY3ctfohsztpXvJzKeq7L15a6ITdlw
 dLA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk95B3Pgmz1RtVy
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727773; x=1682319774; bh=c6fb/ATpu4bjomFurb
        yO/sIS4IvcEwK34bItru+sYXM=; b=G/GlGhN4Yc/681OmHAJT2EJaai00I0hN15
        IpWZTI+fbDg06kjb47fixzXOhU3uVDgzG42Cmshyr0HLU/ev4udYPD31famC/l6+
        PuJvcuFnoE2Kd4bHdo3JXKzFduF+PcBimq3zv/Gwa09fjAlZgLqORnOHPetjgXXq
        KkDBFxOWqSUUPLIatzUntoQphJ9xxX5j79F7sSzdUfk9NM4dHJIoA5BawY7i59bf
        tcZlDG5jFz5usjm8M5LGYuQVkdovKXGKm8VTsVSLkLcOsdH4fzJxAgTuuIfZDII3
        x8xmVUGPAg9SHjvGZcqEdkbWxK9KXVz7E9gAeyTFBqZbj/BfubGg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7c041ywl5Fss for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:53 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk9581lN4z1RtVn;
        Sat, 25 Mar 2023 00:02:52 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 13/16] misc: pci_endpoint_test: Free IRQs before removing the device
Date:   Sat, 25 Mar 2023 16:02:23 +0900
Message-Id: <20230325070226.511323-14-damien.lemoal@opensource.wdc.com>
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

