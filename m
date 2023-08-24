Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF177870AA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbjHXNmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbjHXNm0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:42:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2C19BD;
        Thu, 24 Aug 2023 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884521; x=1724420521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nen7yQELC0i9x/FB23xTRuNIW8tVu0uF/NbwWIleIu4=;
  b=BqYJSA8WDVraEkVQbNODe7dxaWpcr2HWDqWKjOL5dQy6KR+rC86bmFIi
   +odKczdEsv5fpdH2DoTMeo1HptQjCiWOfY8d2cpFTvLLLd1tAXrJTXuAE
   qC/hmRKOt9uE3RU6IV5aoKQfv7HA1vQNxiRHRCCeDG/cw2SPkb++VN1iC
   TP2TD8mzmJHMLysmoTKCjp83BOb2CnIZ9CcdYukGzeW9Bdkz/RQmSxFng
   r7SqYPmDwsD4VU9xpPDIIjVjx61YZ2iBEVvUizHZv8EAFiM/ECQIMoDr+
   p5aLpskuschb8pWXWWN8S76AmbUzwUWGcOKePHTjQB4w6rqcTdlsJ4ly1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792634"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792634"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802540120"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802540120"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:34 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/14] hwmon: (sis5595) Do PCI error checks on own line
Date:   Thu, 24 Aug 2023 16:28:31 +0300
Message-Id: <20230824132832.78705-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of if conditions with line splits, use the usual error handling
pattern with a separate variable to improve readability. Handle error
print with a label instead of trying to chain everything into a single
if condtion.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/hwmon/sis5595.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index b0b05fd12221..0a0479501e11 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -798,7 +798,7 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 {
 	u16 address;
 	u8 enable;
-	int *i;
+	int *i, err;
 
 	for (i = blacklist; *i != 0; i++) {
 		struct pci_dev *d;
@@ -818,8 +818,8 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 		pci_write_config_word(dev, SIS5595_BASE_REG, force_addr);
 	}
 
-	if (PCIBIOS_SUCCESSFUL !=
-	    pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {
+	err = pci_read_config_word(dev, SIS5595_BASE_REG, &address);
+	if (err != PCIBIOS_SUCCESSFUL) {
 		dev_err(&dev->dev, "Failed to read ISA address\n");
 		return -ENODEV;
 	}
@@ -836,22 +836,23 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL !=
-	    pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable)) {
+	err = pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable);
+	if (err != PCIBIOS_SUCCESSFUL) {
 		dev_err(&dev->dev, "Failed to read enable register\n");
 		return -ENODEV;
 	}
 	if (!(enable & 0x80)) {
-		if ((PCIBIOS_SUCCESSFUL !=
-		     pci_write_config_byte(dev, SIS5595_ENABLE_REG,
-					   enable | 0x80))
-		 || (PCIBIOS_SUCCESSFUL !=
-		     pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable))
-		 || (!(enable & 0x80))) {
-			/* doesn't work for some chips! */
-			dev_err(&dev->dev, "Failed to enable HWM device\n");
-			return -ENODEV;
-		}
+		err = pci_write_config_byte(dev, SIS5595_ENABLE_REG, enable | 0x80);
+		if (err != PCIBIOS_SUCCESSFUL)
+			goto enable_fail;
+
+		err = pci_read_config_byte(dev, SIS5595_ENABLE_REG, &enable);
+		if (err != PCIBIOS_SUCCESSFUL)
+			goto enable_fail;
+
+		/* doesn't work for some chips! */
+		if (!(enable & 0x80))
+			goto enable_fail;
 	}
 
 	if (platform_driver_register(&sis5595_driver)) {
@@ -871,6 +872,10 @@ static int sis5595_pci_probe(struct pci_dev *dev,
 	 */
 	return -ENODEV;
 
+enable_fail:
+	dev_err(&dev->dev, "Failed to enable HWM device\n");
+	goto exit;
+
 exit_unregister:
 	pci_dev_put(dev);
 	platform_driver_unregister(&sis5595_driver);
-- 
2.30.2

