Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57D01FF84E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgFRP4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgFRP4s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 11:56:48 -0400
Received: from mail-pg1-x564.google.com (mail-pg1-x564.google.com [IPv6:2607:f8b0:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F184C06174E
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 08:56:47 -0700 (PDT)
Received: by mail-pg1-x564.google.com with SMTP id e9so3077643pgo.9
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=footclan-ninja.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvKoI8PMZzGI+SB60fJLf0VL2ZLdzN79PVHR+4htig8=;
        b=s3iDJs3leT+5hMurR0CCOMGi18ZAu4OuV5nCjuYJF3v6ZCb06x7Pm7EM1illjr/u9d
         7wkWrvpPS+HhPjBj2ohIzW39xNw2DrQAp1n03STbFn55hXCf36iUbBtSh0TJbsI6whPm
         sIpdWt+Cty8Wb5NsWUZS3EGhChG33MJSC832lJoWN3hqo0jWjGyGhuc4ZgE1WxQrtmJT
         MeNCea0OdUgZlWlvUNCo/NsM3gc4jszRUDke/zdepiY+Y2FvFhDIGtFpQ1iavnc1+cFA
         jrQtM28vsvpoc9sNiWk5hzvjkx0t3qjgVC/qdzCT4opUkIpfVXikGO/jalrsTE8WJre6
         w0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvKoI8PMZzGI+SB60fJLf0VL2ZLdzN79PVHR+4htig8=;
        b=Z22BwP5YlNyj9vVfUG8Me88nW24krWELC7sYG8Cq2bYHgpeNa3zG0Uv4xgRuZF4L/y
         NCZffZbqaUdrGj/OTUh/4mY/2RqLmhpTcdEi7TtVJaTiQSPxSlfPglXFLRygo65W+Cax
         nuzCM5yh5EAJ0xKyvw3ZxpBPJ0MlYTa7K7bQrKZwHKzesNvfAYwFOUQbxLDlwzGL8nbq
         fYMfz4rpWAUrqfmRATnoOiNqGvIJJeMvlUQS3nElWqwUamMxsPuF4yApHdViJbDZf+II
         bG4YsNVA/HRehuzsU3Cu5qt8a9EfOt3UMsmsyWDN/NMesmHfrrV5wKI2fJG4buzkdcZk
         mjUg==
X-Gm-Message-State: AOAM530PbNetKl+paglndbqb3jstB73ObMmdH7bgpEVLR7Xcql4l13eX
        dyrjpr3FU5zX2vOlMJKl1iF0d7iGxQoQCWRWtG3CohlWQ3hnlA==
X-Google-Smtp-Source: ABdhPJw55PL0GjhYtbJiaokFl4eJuuGOYegFYT65bzjaA7qnmg26Lt+qEVKvP7WiFqwvz0ef2PncAS2U8scE
X-Received: by 2002:a05:6a00:14d4:: with SMTP id w20mr4240127pfu.279.1592495805652;
        Thu, 18 Jun 2020 08:56:45 -0700 (PDT)
Received: from localhost.localdomain ([49.195.72.212])
        by smtp-relay.gmail.com with ESMTPS id y1sm355578pjy.0.2020.06.18.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:56:45 -0700 (PDT)
X-Relaying-Domain: footclan.ninja
From:   Matt Jolly <Kangie@footclan.ninja>
To:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matt Jolly <Kangie@footclan.ninja>
Subject: [PATCH] pci: pcie: AER: Fix logging of Correctable errors
Date:   Fri, 19 Jun 2020 01:55:11 +1000
Message-Id: <20200618155511.16009-1-Kangie@footclan.ninja>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AER documentation indicates that correctable (severity=Corrected)
errors should be output as a warning so that users can filter these
errors if they choose to; This functionality does not appear to have been implemented.

This patch modifies the functions aer_print_error and __aer_print_error
to send correctable errors as a warning (pci_warn), rather than as an error (pci_err). It
partially addresses several bugs in relation to kernel message buffer
spam for misbehaving devices - the root cause (possibly device firmware?) isn't
addressed, but the dmesg output is less alarming for end users, and can
be filtered separately from uncorrectable errors. This should hopefully
reduce the need for users to disable AER to suppress corrected errors.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201517
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196183

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
---
 drivers/pci/pcie/aer.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..131ecc0df2cb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -662,12 +662,18 @@ static void __aer_print_error(struct pci_dev *dev,
 			errmsg = i < ARRAY_SIZE(aer_uncorrectable_error_string) ?
 				aer_uncorrectable_error_string[i] : NULL;
 
-		if (errmsg)
-			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
-				info->first_error == i ? " (First)" : "");
-		else
+		if (errmsg) {
+			if (info->severity == AER_CORRECTABLE) {
+				pci_warn(dev, "   [%2d] %-22s%s\n", i, errmsg,
+					info->first_error == i ? " (First)" : "");
+			} else {
+				pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
+					info->first_error == i ? " (First)" : "");
+			}
+		} else {
 			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
 				i, info->first_error == i ? " (First)" : "");
+		}
 	}
 	pci_dev_aer_stats_incr(dev, info);
 }
@@ -686,13 +692,23 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		aer_error_severity_string[info->severity],
-		aer_error_layer[layer], aer_agent_string[agent]);
+	if  (info->severity == AER_CORRECTABLE) {
+		pci_warn(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+			aer_error_severity_string[info->severity],
+			aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		dev->vendor, dev->device,
-		info->status, info->mask);
+		pci_warn(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+			dev->vendor, dev->device,
+			info->status, info->mask);
+	} else {
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
+			aer_error_severity_string[info->severity],
+			aer_error_layer[layer], aer_agent_string[agent]);
+
+		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+			dev->vendor, dev->device,
+			info->status, info->mask);
+	}
 
 	__aer_print_error(dev, info);
 
-- 
2.26.2

