Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5005421160
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhJDOdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhJDOdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:33:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9693C061745;
        Mon,  4 Oct 2021 07:31:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23so798061pji.0;
        Mon, 04 Oct 2021 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGisZgUAndR6vbypwD4J77Oe+tJJydzPHMGBtKSc8nM=;
        b=OYkLF4jRenzIQdzKZe4qmQGMnvSK+jQXdQiOwjvl48ofn2l4BMD6xrqcWDUEhBcG52
         H0YZnDmK586+ADSnkPq2vWqxLpYoz+Dq9/jsl1ayWVFRsgrTR2HscGQxMv5QIypM6J8w
         IF921DChGFUU0Ubx8nyIOpaVWw+LRHsR/bbCwxOtGcPsWid9Gjvlmxq8ZiVPAUKx9lfH
         x74zbeEid+g9DBFRkWoOpQxyrXXRmSqTa8vzd+rpaYP+vP04HOdRd74zaMY+qd3Zu6/l
         1AfQmiDWypumIYTdoL0WXRc3u7ol/OuF0/2xM7m+HWWZZ7aIrfErYnFcc2d9kxS+SbNf
         qNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGisZgUAndR6vbypwD4J77Oe+tJJydzPHMGBtKSc8nM=;
        b=7+t1mLkBSHhLEL4/6D7GGp+P33u7fVYKyKUVwp8YVdPuwxK4yip8X3uwbOZCiUVeZp
         bRuGaSHWRovQT5Gr48AcikyQ2/NvlRtUNiVB/L8hCT8SAIZF/lf4Eh4EdbYBudas+nVS
         SNgcbqxIaQh7vF7sxwhLMpsuO3pNV/CtHkSB9kMm6Bi70YeBUKSFLYnX2CiQAN+JAA7C
         FDY/5bfcphzlsTqUh4HzDhB3ldlN1KZFcEwTle+2ysBjJ7Mos3ONkJ6MM9p7ev6cD22f
         gLMsv/5uI8HsmR3A/q1MVk53WWI7mY2o6gIuMXeCUaLCnrE1hcchcoWDMsPZIIui81cq
         cWXQ==
X-Gm-Message-State: AOAM530M9YhR5B9E+4nFEke47ci0FAkJ4YKohDKW0RNipp9IKUYo+11W
        uO3pasv1gSD+F3deX5g1Kms=
X-Google-Smtp-Source: ABdhPJwRGQEgFTrP/TcZFfidHVNYaV6yZnACSRUkg8OiMIzlF+QimixqzYdMrw3SzsANwkLpwHyDkQ==
X-Received: by 2002:a17:902:d50d:b0:13e:a44e:2d2a with SMTP id b13-20020a170902d50d00b0013ea44e2d2amr10557059plg.89.1633357872271;
        Mon, 04 Oct 2021 07:31:12 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id q3sm14489146pgf.18.2021.10.04.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:31:11 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/8] PCI/AER: Remove ID from aer_agent_string[]
Date:   Mon,  4 Oct 2021 19:59:57 +0530
Message-Id: <b4c5a5005d4549420cf6e86f31a01d3fb2876731.1633357368.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633357368.git.naveennaidu479@gmail.com>
References: <cover.1633357368.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before 010caed4ccb6 ("PCI/AER: Decode Error Source RequesterID")
the AER error logs looked like:

  pcieport 0000:00:03.0: AER: Corrected error received: id=0018
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=0018 (Receiver ID)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

In 010caed4ccb6 ("PCI/AER: Decode Error Source Requester ID"),
the "id" field was removed from the AER error logs, so currently AER
logs look like:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03:0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

The second line in the above logs prints "(Receiver ID)", even when
there is no "id" in the log line. This is confusing.

Remove the "ID" from the aer_agent_string[]. The error logs will
look as follows (Sample from dummy error injected by aer-inject):

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9784fdcf3006..241ff361b43c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -516,10 +516,10 @@ static const char *aer_uncorrectable_error_string[] = {
 };
 
 static const char *aer_agent_string[] = {
-	"Receiver ID",
-	"Requester ID",
-	"Completer ID",
-	"Transmitter ID"
+	"Receiver",
+	"Requester",
+	"Completer",
+	"Transmitter"
 };
 
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
@@ -703,7 +703,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent)\n",
 			aer_error_severity_string[info->severity]);
 		goto out;
 	}
-- 
2.25.1

