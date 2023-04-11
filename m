Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B16DD8FF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDKLLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDKLLO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:11:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8258E4210
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:11:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f6474b2feso22300357b3.5
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681211463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov/mNuHCriSJNK+j92LJ7xxXi3IiZ7Lg7C3ge9u+upM=;
        b=CFtgh+9uEhowZGpk6SzBRxW36tLl8YchhHynUd6PmcGJQ/7tChidXuHNTtfifOqw6B
         1XwIkybHoouWs+wnmvg8aJ5QpaYw4jq23wjmBlaqHr8MhexIt6PpjToPMLGiMQSNAR38
         /Aw0WT2s7eHYuKoB7hZ5IXXg1ieAl3xi4RZXnkbmHCLgxwFetHQRqw27JTqnBrZuxrPq
         CZB/T4K1VaIWSF4CXQ5apAzRrxf1CRSTegygUaKo7LQrB4v+y7DLTNJlvCSkGqSlRbFT
         Nmh2SpbwgX+2N0EVb+n2pLZtl9vL9uQr61i13G5xcbye1VGY8eGcGZsT5Z4MOkyqatT7
         5O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov/mNuHCriSJNK+j92LJ7xxXi3IiZ7Lg7C3ge9u+upM=;
        b=I57OjCIS8TKDUS/p9j747vYqoBe61dWAaXHOfGYzRoIXmpxXq1sVpcAVzomHJuxKp+
         dLlHLbirJDnT2LyBy0GRGfCmSBc1rn1w5fNewWsOZJlr/VW7SoucxEdm+iCV8vyHEcLW
         JROEoag9Kgyt/3s3ilU1FrtdxSvlz71Qa1lI996X2lBtlobiTYd/hQIAFvmJxXZ2mOCb
         REMBFR0LMPNLzKDtb3LQBDgQzYkFy4lnOKcJh+S7LmcznfXmXAJ6zm5PaP/aZHlyyS2T
         Qs4r60AM+eRmuviPHNjD0i6ax1oktu9cM8Eqw1qpOrVpxWmYLnTjpZkfc3se9N0WBK5E
         DuNQ==
X-Gm-Message-State: AAQBX9cvBjrOqeWLu97jEe5/pzyRAAsJuQ0qPFYqYqh0QUu3ZE2Xnsri
        Opt4pP6o2ljRazWEU23/uLPGyBkj/SnDGJoPcA==
X-Google-Smtp-Source: AKy350aJPDMi1ru/nTyvdLI8YpfZDRSbAqxsadZMBD4IpIReRo3FQJMuiwh4qgI9FWf6YvxNY6kqAZXYatxIo3HgcQ==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:b714:0:b0:54b:fd28:c5ff with SMTP
 id v20-20020a81b714000000b0054bfd28c5ffmr8221904ywh.3.1681211463835; Tue, 11
 Apr 2023 04:11:03 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:40:33 +0530
In-Reply-To: <20230411111034.1473044-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230411111034.1473044-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411111034.1473044-3-ajayagarwal@google.com>
Subject: [PATCH 2/3] PCI/ASPM: Set ASPM_STATE_L1 when class driver enables L1ss
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the aspm driver does not set ASPM_STATE_L1 bit in
aspm_default when the class driver requests L1SS ASPM state.
This will lead to pcie_config_aspm_link() not enabling the
requested L1SS state. Set ASPM_STATE_L1 when class driver
enables L1ss.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
 drivers/pci/pcie/aspm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5765b226102a..7c9935f331f1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1170,16 +1170,16 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_default |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+		link->aspm_default |= ASPM_STATE_L1;
+	/* L1 PM substates require L1 */
 	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_default |= ASPM_STATE_L1_1;
+		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_default |= ASPM_STATE_L1_2;
+		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
+		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
-- 
2.40.0.577.gac1e443424-goog

