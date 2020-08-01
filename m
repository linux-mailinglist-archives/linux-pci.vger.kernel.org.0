Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F232235233
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgHAMZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgHAMYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75374C06179E;
        Sat,  1 Aug 2020 05:24:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l4so33946565ejd.13;
        Sat, 01 Aug 2020 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8dAqn3oyLTlTqhf29Z52aIjqvD0eEwBI3IdJNmTAKE=;
        b=P98yQ73QpNAHyJH0DhgL+VteQsL8cJWvez4VBskT+6Zy0ViH186MuBu4nRvGYARUqd
         PDUMf38OLCl5PvGAT/41B7GiPvDcOBsaM4Y1R+BKMYY18/LuAuqv44mpAEG6r1fYWcfY
         QMKLZygpMvWntgZg8e/oF7zNlaPq9OSG4dNlG19C7ej6vNjo4PPJFjvpXAMHr399/xBl
         DpMbGY848f6RaiM4HfSP1a5QFTkzZ4mmVUxFUE7Gz2pAIE0+Lq9sZeuQW4ZeMeTnwEFo
         1ZSzd6yuE5ADI8ephhkCQ2Wubpv7kQZm+Cihm/tzF0n0DyDFoVPmGuUYNiBglsxS6GpR
         f1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8dAqn3oyLTlTqhf29Z52aIjqvD0eEwBI3IdJNmTAKE=;
        b=r7xOiiXnrp1GqNkyZZUCZd041mhMXrTUzS5SRHaX3kS8TLomgPuNYX9/qNTGercbBU
         DK7ksOUBQjJd4gcFc855O7qi8HAAWXAiGiiwSwTh/yGY9DVa4zM58i7NR1VSPrCx8FVN
         K3zOf2m0OtEYso9dT5AdNX99y7Pzw2hPf/gVYCZg+J+ub7L/WwO0RLsi8gE8SERgoQlX
         vo7bx9j7BO15t+dEF9Ry257Kghtvn0aZ1Dc1yhDOvyRmpEhFbcOELeO1La94lXVaaCv5
         n6uN1CKTPsW997QrlUO/bXQ0ed+CFqknnwiGh0IwYVPVlaD0GwoXxjX+d4ACIVr50/MZ
         yUYQ==
X-Gm-Message-State: AOAM532ElYbnRbZaFLQcLaL+CKuBEutbB4eGTpn+m0E8g+poqmAnnKMD
        j63gSkDqLNa6W5wqwm797BM=
X-Google-Smtp-Source: ABdhPJyaQUgDgaB0qqpXNRYm/8ED4kbE0a2gf50gNexDXYKCzC2jeZw2r4pLhpg9owqfBDJdG1DmpA==
X-Received: by 2002:a17:906:6a5b:: with SMTP id n27mr8123629ejs.221.1596284673233;
        Sat, 01 Aug 2020 05:24:33 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:32 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Moritz Fischer <mdf@kernel.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 07/17] fpga: altera-cvp: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:36 +0200
Message-Id: <20200801112446.149549-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/fpga/altera-cvp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba..99c6e0754f8b 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -96,15 +96,15 @@ struct cvp_priv {
 static int altera_read_config_byte(struct altera_cvp_conf *conf,
 				   int where, u8 *val)
 {
-	return pci_read_config_byte(conf->pci_dev, conf->vsec_offset + where,
-				    val);
+	pci_read_config_byte(conf->pci_dev, conf->vsec_offset + where, val);
+	return (val == (u8)~0) ? -ENODEV : 0;
 }
 
 static int altera_read_config_dword(struct altera_cvp_conf *conf,
 				    int where, u32 *val)
 {
-	return pci_read_config_dword(conf->pci_dev, conf->vsec_offset + where,
-				     val);
+	pci_read_config_dword(conf->pci_dev, conf->vsec_offset + where, val);
+	return (val == (u32)~0) ? -ENODEV : 0;
 }
 
 static int altera_write_config_dword(struct altera_cvp_conf *conf,
-- 
2.18.4

