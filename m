Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6002D5F0740
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiI3JLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiI3JLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 05:11:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CDB45047
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 02:11:00 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7AAFE3FFE0
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664529058;
        bh=3EwN7ICYiqgTYVQO2ot2VfpryeYvkvfH7StD/2CT2TA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R7k4s/+JvD44S9U+yj/9ffjD3/UYFaO8N7owrxz2+T8ceHqWM5DTIwsZHnM+HjcHH
         lN5XrvVCD1QUw6WrsPINWGHPEbCHD5Stz9je7nwTYu2PtyeqgL+jwWb7UB5AaA6Kl0
         wnBNVja+gL9Z0OFOR917m0x+4eg/ku3h6Cg2o3aEI72qzp133smoYiVDh4hOJ9sBab
         /UERYDza76Um4TQfsNUsjofe6dKY10iNQ5NrS1PCFsu9/94Om/27n8l48iZIRP73Zz
         gVV1FTW0kSekTwQwuKeLecb2huA6K+Pkn2nDKzXZfpcN/GG3Am4Ia+eXz7ogNPc1kd
         wY5Qz8M76PBIg==
Received: by mail-pj1-f70.google.com with SMTP id m2-20020a17090a158200b002058e593c2bso2343802pja.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 02:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3EwN7ICYiqgTYVQO2ot2VfpryeYvkvfH7StD/2CT2TA=;
        b=0OXOpCYfDvCd7LttKbLGRTT3NuxVugwquMR9fgZL3Fz2y2m1WPVjFJSel7rM0ATnc+
         qO5gdpDF7vJO0CR0VPgva6pXoRx5fMHf5ZWuSFjlRTkmGIvoNScXxN5+PzLrw+O+GuEm
         OCJ1q7Z06+Ddjsw7zetY4a3ZDy5WYoDr/v6JEIWFVkZu596OmzJsZF6+PcgSZkNH7kdU
         5KkB0JABTM0R5OI0kHc6kNK5HRFu6kofgdSWXwG7hxhAUhbRLvHZ4DvnQm8nLVMF4jX0
         JiEfmbjbTJC0QPLoyoCzD9UVeYTzvcl0TK19kbbZhVU2WgIcO0HcWKWctAMilgCpJfDj
         NL6A==
X-Gm-Message-State: ACrzQf35u18DFeqlQzdbysP818D3wFXkz+V+XYSH/OSEHKKfYEJI8hzE
        Yzx0mW1VoeT3sfXbrs1h2hel0oJ35Y0FILG2Xk/MWzUb1U1pI4wT6vgh6cAPhjfl0LoE7K3p6CG
        BlVybxPWXeevGdWr2T6pEqKsDs2GWeeXPWsagbA==
X-Received: by 2002:a17:902:e846:b0:17c:a00b:69c1 with SMTP id t6-20020a170902e84600b0017ca00b69c1mr1299094plg.143.1664529057119;
        Fri, 30 Sep 2022 02:10:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7p+cTf1lW/V8rs3eKZXr6tS966Ojg7mXPPBy2dHAgLVDEp55KpJUQ+4bPTnlgIK7SLCre3mw==
X-Received: by 2002:a17:902:e846:b0:17c:a00b:69c1 with SMTP id t6-20020a170902e84600b0017ca00b69c1mr1299066plg.143.1664529056766;
        Fri, 30 Sep 2022 02:10:56 -0700 (PDT)
Received: from u-Precision-5560.mymeshdevice.home (2001-b011-381d-9173-bb82-1440-19c3-59f5.dynamic-ip6.hinet.net. [2001:b011:381d:9173:bb82:1440:19c3:59f5])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d10100b001785dddc703sm1360115plw.120.2022.09.30.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:10:56 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     bhelgaas@google.com, mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] PCI/ASPM: Make SUNIX serial card acceptable latency unlimited
Date:   Fri, 30 Sep 2022 17:10:50 +0800
Message-Id: <20220930091050.193096-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SUNIX serial card advertise L1 acceptable L0S exit latency to be
< 2us, L1 < 32us, but the link capability shows they're unlimited.

It fails the latency check and prohibits the ASPM L1 from being
enabled. The L1 acceptable latency quirk fixes the issue.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..e1663e43846e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5955,4 +5955,5 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, aspm_l1_acceptable_latency);
 #endif
-- 
2.25.1

