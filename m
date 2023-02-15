Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDE6974D8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjBODWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBODWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:30 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C42B60B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431338; x=1707967338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2VT/sdm6SvvLqOCHKDAB8W/lpODc5iwnE+Tpa+Nv/gU=;
  b=AoJ71rNZAvmYzg6XGNCv4CqJ5/8lnSnfvcEosOhL7Izvol6ONGFTSv6G
   B+1kWul7Qg7eu7YaUDIBHb8KSr/NWCwiJ09kUIekfo5XEg9uDUG+NmFfd
   bFf60Loz6iWr6TB35xRIXKZHNhv951k8aCNqSTqLQgQK1YIz3iCWL1UM6
   GRxZtCk5io7RL1J8E+3fXwtV7h6ISH5eZUi+Tv4ysLJqLWt/GUZ3xMY5j
   nJGZDtywO+2nqavHFFM3TUb+Jx5xcnkeHsRxokAJZIrZJpLOMjE9zCCPV
   nVQoI1GRTkPMgKr3JYEC3xJvM7vUuSw/FL+vU8KiCmjOKXCwoKRZpiUEO
   g==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351471"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:18 +0800
IronPort-SDR: kHcKWJu3mSNyIcTeCXYqtMywD9Yw4VOH9bRskrUxmYPlFi5jEHb8TDG4T0J88XrKt0bk8xOTd7
 zzS6S2xEQmArY4/ebS9r3TEGWKlZVJeOD73b2s9NFTUGfvis6ZFf5a88TZiM643gRGD4Di06gI
 U7DLdJc/FhxYC0qmRHFj/AQpCeKRPkSFeQ/YeqDUovP8d7hGJQ08G+op6DNrXdC5cVUGzwPAMV
 tVxFneHe5vUjRWNZp1p8lacy30FwxOsx6OlUjpDuYCGnbOKZM4MZumsV5gQglh+dLmgVrvKgRQ
 5fk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:41 -0800
IronPort-SDR: +QhHBKRIN2T3ccIQS53qPCKlqJRfzlQmpzSqYYgGq3oVOtqvF7VZlTQA/wMYOhkL5B/pSDTLbJ
 xwm+f+MuRf+pwXeTYYKja7nhJn4Iigm9veFVKqHMtDgvBQRwjXZUBFsmTaIMbmhIlrOcTaugxu
 1RS84QpFyMQXIyb52Iik255PViF7GAxgSCw/ISmTbY1JLpV4NgWYXWNa68dPHbxVhrq520bQHQ
 hJGCkjA9DPVhwllKQUmY1Am4cq9hxmwDmGwXlbc6/bU7m8ELfL6u24efUOAsOPyQ42NgtwD7vh
 t7E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGk0B03r3z1RwvT
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431337; x=1679023338; bh=2VT/sdm6SvvLqOCHKD
        AB8W/lpODc5iwnE+Tpa+Nv/gU=; b=QpaDgsL+UMmyIuhAExPnkZOcufiBYsrbHc
        iBgu/VcIvaDaKsnxL7N5wkJWtLiP6bCWvHl/7r99Qy/oy6zv4IiaES0Lha2tetGX
        t0hJIyTWrH5opVCdQ2uEzuX0evUznxangb4EJq6GNs40WZbEIB+sl05xG7EdotSM
        Pj7QlyKmbF8anAxR7c7wMpMWzjT5g4ykccdjJraAcHEwPvLVYRSLGismKFjOr44d
        IRMnOxO976Gi2emyYaD7hWUUHfTDHfNuW433FTBCurr57dWKRFZ0llwc4NBpJrRV
        1KQDHMdpNIEVdDHPy1RVdpzX7ecG/vz/0WJI5nJNxMGmn1+rYjCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RxP1_eGbswAf for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:17 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGk076PK3z1RvLy;
        Tue, 14 Feb 2023 19:22:15 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/12] misc: pci_endpoint_test: Re-init completion for every test
Date:   Wed, 15 Feb 2023 12:21:53 +0900
Message-Id: <20230215032155.74993-11-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The irq_raised completion used to detect the end of a test case is
initialized when the test device is probed, but never reinitialized
again before a test case. As a result, the irq_raised completion
synchronization is effective only for the first ioctl test case
executed. Any subsequent call to wait_for_completion() by another
ioctl() call will immediately return, potentially too early, leading to
false positive failures.

Fix this by reinitializing the irq_raised completion before starting a
new ioctl() test command.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
index c1370950c79d..baab08f983a2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -725,6 +725,10 @@ static long pci_endpoint_test_ioctl(struct file *fil=
e, unsigned int cmd,
 	struct pci_dev *pdev =3D test->pdev;
=20
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq =3D -1;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar =3D arg;
--=20
2.39.1

