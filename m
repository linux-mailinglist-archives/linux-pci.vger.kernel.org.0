Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B7F542513
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbiFHBDB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 21:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835729AbiFGX4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 19:56:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3D8156799
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 16:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E931B82477
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 23:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8704AC3411C;
        Tue,  7 Jun 2022 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654644590;
        bh=QywdRCanIVgahFW8cGIoUSxQQVtKtWIE2FYSNlLI/wk=;
        h=From:To:Cc:Subject:Date:From;
        b=E0+7wYHJMHNQPFrfZ0TnhICa9KP+x6Vub0zipXnNgyLtu8iti2k4gqN8UfVqojGAf
         7mHXQmu0HzPKs/UMVhGDG8vDBYLVLMTKhk+Rp07b7H/pwyccCUGcpIeoHCxzx5sLbs
         hh0Cp5kuPShao6zPnecvGY5KcrMtC9NHKbw26XH6bUXJ5SGyCT82sMjiqybbUt5HHl
         9IP/jAOAOjWFKnz9TE/rHeJ7bo3lVNiKgkLqvjTWN66PYp35+1eAybWuMwhOKvmqZJ
         Ox+3gADbnBJiz8CGey5kTOH9OFBE/THF6DwHGatSFJbQYkmXrebVXXTW+eSMhT6IPp
         KItbf4pPibKPQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/doc: Convert examples to generic power management
Date:   Tue,  7 Jun 2022 18:29:46 -0500
Message-Id: <20220607232946.355987-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
deprecated.  Convert sample code to the generic power management framework.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pci-iov-howto.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/PCI/pci-iov-howto.rst b/Documentation/PCI/pci-iov-howto.rst
index b9fd003206f1..27d35933cea2 100644
--- a/Documentation/PCI/pci-iov-howto.rst
+++ b/Documentation/PCI/pci-iov-howto.rst
@@ -125,14 +125,14 @@ Following piece of code illustrates the usage of the SR-IOV API.
 		...
 	}
 
-	static int dev_suspend(struct pci_dev *dev, pm_message_t state)
+	static int dev_suspend(struct device *dev)
 	{
 		...
 
 		return 0;
 	}
 
-	static int dev_resume(struct pci_dev *dev)
+	static int dev_resume(struct device *dev)
 	{
 		...
 
@@ -165,8 +165,7 @@ Following piece of code illustrates the usage of the SR-IOV API.
 		.id_table =	dev_id_table,
 		.probe =	dev_probe,
 		.remove =	dev_remove,
-		.suspend =	dev_suspend,
-		.resume =	dev_resume,
+		.driver.pm =	&dev_pm_ops,
 		.shutdown =	dev_shutdown,
 		.sriov_configure = dev_sriov_configure,
 	};
-- 
2.25.1

