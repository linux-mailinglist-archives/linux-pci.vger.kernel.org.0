Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163EB4AB015
	for <lists+linux-pci@lfdr.de>; Sun,  6 Feb 2022 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiBFO7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Feb 2022 09:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFO7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 09:59:14 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:59:13 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96293C06173B
        for <linux-pci@vger.kernel.org>; Sun,  6 Feb 2022 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644159552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uX4lWbiYHZ8NWu80q7dFh0qDvrig4tAryOtejA4ht4k=;
        b=g4Y9L8tJu7JPIiqjt+gelFXayMiIQw+UE4IFgIsY4LG7Ap9ehuSflOt4Pa5VvrFbbMCKky
        YR/wk8dZk6rWtMhOGaElA1Ebk/SP/T05vsND4vvNftR9F714Y7/eGCRb8DjE1DvKUb1M3t
        jVhqnIj6sFieJ1rbW1cDsQQ7KHId+zw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-hEoXsMYIMom8YcXVMHOquw-1; Sun, 06 Feb 2022 09:58:08 -0500
X-MC-Unique: hEoXsMYIMom8YcXVMHOquw-1
Received: by mail-qt1-f197.google.com with SMTP id a6-20020ac844a6000000b002cf3968d32aso9112875qto.1
        for <linux-pci@vger.kernel.org>; Sun, 06 Feb 2022 06:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uX4lWbiYHZ8NWu80q7dFh0qDvrig4tAryOtejA4ht4k=;
        b=OsdEfVPsQ6y3GMjeGo5WJ161W8+zwVtKGNovUn1xwWXHCKrs95pAOb0P3Dy4QY2I//
         tc4o4mlsKEs3eycuPvm3+CPmgXDt1uk7QIwp2bn8ctRD9IF2zGbv3M5v3C8u8H5J5zjt
         6BBmExxKMhpMFIzs4KEvjJcm2buwCT3RqnjDpbY9DowqZJBc5pVBh43NYsU/WW/CnPDL
         jYgMNHbRBJJOgJ3Az74dX0O/0dp+y4ys9E/RIEQRAc4L2QSEFmpx+LIjkC1VDpMWvKJh
         F1tfOXBqSQUJnXF7Rwie4aNODda5Qgm6fqGdJMeY0bhC/h/22jIN+W1gIiGGU3amvciY
         gAWw==
X-Gm-Message-State: AOAM532dbFRKHOTrVazJrIPujaS9KaglwLcWX1rCyQj8Uvhmh1QXheT6
        ERPt+isvKWdmKiALMYs9VwKJWvs8NOOxEpOsI+e+hk0I6i0bxmg2Ira/ygVG9j5ErHE5xY6cwFJ
        jBsnogdH/bbWodHNluEWX
X-Received: by 2002:a05:620a:210d:: with SMTP id l13mr4202090qkl.276.1644159488354;
        Sun, 06 Feb 2022 06:58:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzMMFTsVYuA3WsMa5aAtZSa2Zi+YOirEF8uFgzKhOcPAqZ1RB6Xj6uxrY4Qwi7RDDYG5p59A==
X-Received: by 2002:a05:620a:210d:: with SMTP id l13mr4202080qkl.276.1644159488194;
        Sun, 06 Feb 2022 06:58:08 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l202sm4030030qke.66.2022.02.06.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:58:07 -0800 (PST)
From:   trix@redhat.com
To:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPI: cleanup double word in comment
Date:   Sun,  6 Feb 2022 06:58:03 -0800
Message-Id: <20220206145803.2011247-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'on' and 'those'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/Kconfig    | 2 +-
 drivers/acpi/pci_link.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ba45541b1f1f8..9b93d8f328d4a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -301,7 +301,7 @@ config ACPI_IPMI
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
 	  uses the IPMI request/response message to communicate with BMC
-	  controller, which can be found on on the server.
+	  controller, which can be found on the server.
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called as acpi_ipmi.
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index d54fb8e54671d..58647051c948a 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -185,7 +185,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 			if (!p || !p->interrupt_count) {
 				/*
 				 * IRQ descriptors may have no IRQ# bits set,
-				 * particularly those those w/ _STA disabled
+				 * particularly those w/ _STA disabled
 				 */
 				pr_debug("Blank _CRS IRQ resource\n");
 				return AE_OK;
-- 
2.26.3

