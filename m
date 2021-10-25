Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13FA439CFD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhJYRKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhJYRJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 13:09:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68705C0432F0;
        Mon, 25 Oct 2021 10:01:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e65so11558728pgc.5;
        Mon, 25 Oct 2021 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzDmm1CSO5ys2u/cUDBI2TYr2rN5kWaOTVprB8Ko1Uk=;
        b=ZHdhSeGLURPzXaswSnZGMuZ4LcxM/+rFjEy7pPEM4C8GYgNJCYn1yIid35ljsILwQh
         U67jlu8fWxehMhq7EiQY5KE11JOQg4hoZwWbNbk61OPyY4blm1uk4YXpwJbYlOSQEGVL
         LyFNcjlOnkQHLDXAwhFbQ5tKmV62LSf0LwtAaIcxKFXkXXKeDJLLBvLoLItgpm/b1lE1
         nU+jaOi2JRN5m7b2SBmQ1HhRYU4l2RwPPDrsDxaXNfxqkUhoVDn8tN3pMYujXUAbuNuN
         cBnR7a6eqlbNs8opvXdJoT7Pe5DChrLafLFE2RQwHrcG3/HjMruSaPOds39rtNr5agiu
         ZeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzDmm1CSO5ys2u/cUDBI2TYr2rN5kWaOTVprB8Ko1Uk=;
        b=3vUesO9FExqBSuz7WbHTaJwmhE8Pu1F5qk5bxd0A4nkpcE4FCXqkwQy0PNgXwqawaO
         rnYiHShZezi9/O3+OxGhssP6eWR9SFna6byJ0T6mdWO8lSworktioJNtjpNfj3c3gZZP
         lqGcJiA53WFvs3CBK9QaOxITtve10dSvmSbu+RLS+VZi6Bu7HtGdNVWfvrbQ9R6z/xU7
         gd8pRB8KhwMT3eiEeX3QvQsQ5h0q2Imvu9QtFhnpgqm/r3TIomqAkAIH5fafJPIE/+yh
         r/IdCiBhNaRiksSorCn9eaImAoARO1+rVBMcfxfqPaZH+TKMI1c9V4Slvl2NV5ssXJq1
         +9dA==
X-Gm-Message-State: AOAM532VbiOxsYkJILBizayF8OjOi5IKWPjfBe8sZj0d6Kf6+kPAiKHB
        Mec6q5EhVq8UDeuMQ0l+1Bc=
X-Google-Smtp-Source: ABdhPJyH7J/iuk4Y6eYOW7ZypxU9kq4dQSkqOm8XsvftCh8hBtHp15bTqEuxROXH/SA1ZGpJoWeNDA==
X-Received: by 2002:a05:6a00:88e:b0:44c:c40:9279 with SMTP id q14-20020a056a00088e00b0044c0c409279mr19791608pfj.85.1635181312767;
        Mon, 25 Oct 2021 10:01:52 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:df8b:7255:8580:2394:764c])
        by smtp.gmail.com with ESMTPSA id g18sm5100858pfj.67.2021.10.25.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:01:52 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 1/5] PCI/AER: Remove ID from aer_agent_string[]
Date:   Mon, 25 Oct 2021 22:31:00 +0530
Message-Id: <a205d9c83f89a0942a3302bfa6e300121381aeb8.1635179600.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635179600.git.naveennaidu479@gmail.com>
References: <cover.1635179600.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, we do not print the "id" field in the AER error logs. Yet the
aer_agent_string[] has the word "id" in it. The AER error log looks
like:

  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)

Without the "id" field in the error log, The aer_agent_string[]
(eg: "Receiver ID") does not make sense. A user reading the
aer_agent_string[] in the log, might inadvertently look for an "id"
field and not finding it might lead to confusion.

Remove the "ID" from the aer_agent_string[].

It is easy to reproduce this by using aer-inject:

  $ aer-inject -s 00:03:0 corr-err-file

The content of the corr-err-file file is as below:

  AER
  COR_STATUS BAD_TLP
  HEADER_LOG 0 1 2 3

The following are sample dummy errors inject via aer-inject.

Before
=======

In 010caed4ccb6 ("PCI/AER: Decode Error Source Requester ID"),
the "id" field was removed from the AER error logs, so currently AER
logs look like:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03:0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID) <--- no id field
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

After
======

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

Link: https://lore.kernel.org/linux-pci/20211021170317.GA2700910@bhelgaas/T/#m618bda4e54042d95a1a83fccc01cdb423f7590dc
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

