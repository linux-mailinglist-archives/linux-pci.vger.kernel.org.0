Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09F24210F3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJDOKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJDOKQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:10:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C5C061745;
        Mon,  4 Oct 2021 07:08:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p1so8541016pfh.8;
        Mon, 04 Oct 2021 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pG3mj4bKDd7l8ZFqHwjB1MgvpFgzE+2HiTROeiz4Dcw=;
        b=lilGDKkKstiY05E5PyE6eTWtE6sIolLARmbbIcr/hqOA8+se7jC/6nCaMMxpRTSwVK
         UeugaZA+ONPjmn8b7h3jTo6EWExYu9ijMWFU//wEGelNg79uZwL0xe4SBkDT8c0evCBV
         vnYV47fu3GZkLLBReTPf/YnjCzvvOkKOFy/3uEVFQQAyrBBrx633MXBGh4QOWFFcBC6p
         ugF4m9gGPaEQyA6xHFbo3xSP+HRVs0zaWtZybBOaNMJbIOR5ihBDblAIC408n29OvxJN
         mlddVJqrtP9y1cs+I8juih3VPe2CvbZvu+c52hM36JIhR74DyDqzsXyq47rYZl0QU5oe
         WvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pG3mj4bKDd7l8ZFqHwjB1MgvpFgzE+2HiTROeiz4Dcw=;
        b=pbaW0pSK5KD6LvGZM1gle+r8qKV1AgsEmLVWfo3saswD7J6RoN0q0DcnFW/UfPq9Bd
         e9QtGm2TmJm+32iqV6Lecsv/r7b1OfFnW/zkoYF3D4+9PVoMucVRy+FctSDfurtFQEsC
         VRBEdMhup1p5jTzIiWmRUD6vBUo3ppbLzZj/t0bIo8GtsCD0EFjrW4YI+TVMfYwPd2FR
         6Z4Y9eauyC9BN758JViqlRTY/AyHI6jDxTDCGKn+hivnmSDEl4azQTJrLD2qsc5T5TeI
         IAcj9MZ+KQKLCjmEE92dP/IMEikeiutizWXSHRdnWwfj1b2RXtWwzF1YoV1TInoZRkj6
         txDg==
X-Gm-Message-State: AOAM533FMZpPsh9hHRFtdJUiZyJpYFcgAJskIU7TBZBTFyieNhrwPXZx
        NcNhnoI8yx0bM4unqhxVNpw=
X-Google-Smtp-Source: ABdhPJxi5ObVFVVBq0INJgWYPzDSEXSeO16X87FcHRyfY9VfsWk60eCRTs+ik8NdZ3TgjzfU1+S0PA==
X-Received: by 2002:a05:6a00:140c:b0:447:96be:2ade with SMTP id l12-20020a056a00140c00b0044796be2ademr25904944pfu.26.1633356507042;
        Mon, 04 Oct 2021 07:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:08:26 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/8] PCI/AER: Remove ID from aer_agent_string[]
Date:   Mon,  4 Oct 2021 19:36:27 +0530
Message-Id: <b4c5a5005d4549420cf6e86f31a01d3fb2876731.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
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

