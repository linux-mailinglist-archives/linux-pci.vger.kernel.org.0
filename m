Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88AB422EFC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhJERV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhJERV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:21:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E3C061749;
        Tue,  5 Oct 2021 10:19:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa6-20020a17090b1bc600b0019ffc4b9c51so2495868pjb.2;
        Tue, 05 Oct 2021 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjHgR4yuS2vTaKg7fKfhOjl8nNl87X4AMEmWTqe3CAo=;
        b=UvpRegiHO4NAWwEm0An/S746HVyraL1+IKlEUHsK7b4F732ko1nh7S4XAi2+ZFi0b6
         bj5GWF90SjpxzdpcbIVIimMhy10JdsL4iUHsdJGc7jTOfFL5A/B863nlU7PLVeyVe86m
         ttiIP1ALgJkzIYlfgAGNKSIlvlHYsd1kA3M1Rs2Ot3MNkOwV8KjIalam0TrlZODMnqkM
         dwaQ6z9hB42hc5w5gQom8SeKIt/CGM5sRwLYouk6LtfJmwRoxXlZAZp9uFb3M2XuSv9o
         5Yf9C/0A8wDenXF5AwdJW1tVNKkVNrkT7LdOXxhF+wmBMKU+ZmbfNqmGwS664+mwVcrP
         8R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjHgR4yuS2vTaKg7fKfhOjl8nNl87X4AMEmWTqe3CAo=;
        b=yoXM4yLtWPcdDousUlY8livvRW4kPLGhqJ8xODljNwriCLwVIksF3PuxyPI/pDFI36
         lp0KUZVIRK0WA+gt6YB3RjX+PCcbB5slzOP27YPBwcPZ0xp9mpnEatDMXYZjCdT+4fN7
         HZWkn3QiIGK19cNZcdb0+VynJU0cXiCmMl4zHYjtZ3qJSpLmtjZlUJgp3z+RZfHkbVtk
         wC18xRB4qAkMe16FJLqFQSuxrNSoR68QQC0+cR86yjtAYRYt4dw2jrSaNiZjLpe2/cd2
         2S1S9bhHsNUq7UV0wfqb+zyKSU82ma/aRbi8ZYkzf7e/9ImcBJRsbmEAO1b/UD6CwZey
         XOBw==
X-Gm-Message-State: AOAM531jJa5yuvgIcypv9KGlhQtJXbIBWTBI9xYw+w89jxUr8P36HS5O
        1V4BORkBrC4/6MQR8LcK4rPeRPd4lutI27zoZ6w=
X-Google-Smtp-Source: ABdhPJxzVl2CYXY1+jXkMgxI7lgjA4Vhcp7jsudKPrO1RBAfCZVLiTcwITS9ttdeflkxxCh6kEfNHQ==
X-Received: by 2002:a17:90b:3e8d:: with SMTP id rj13mr5241539pjb.183.1633454375892;
        Tue, 05 Oct 2021 10:19:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:19:35 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/8] PCI/AER: Remove ID from aer_agent_string[]
Date:   Tue,  5 Oct 2021 22:48:08 +0530
Message-Id: <22b2dae2a6ac340d9d45c28481d746ec1064cd6c.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
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

