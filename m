Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B36F699C
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjEDLNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEDLNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:13:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E649CA
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 04:13:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso669307276.1
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683198798; x=1685790798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BHg5gVGq+WKFx3KhBeMhGGTvFwoSEtH3H2Bo8FpB2Q=;
        b=xAtDTPOoz1Mkj1PFq9m3aneTz3BDtiCEp86cEuDXgb8URnU1LXPoHH0CymgcBUUzZX
         w4xTvueD6OoKWGvGBwwUlk1Hyy9DqinCLvQptXKMyG69Cy2slAnkT2EYQlX5mleDAQxv
         JOnMnuBtmwOzDGLM7GTfrWspGlQMvhYe7Ry3QBuOlvx2B/dnvMSfayRSQc8Pk92fKQyz
         mOl9JN4phns36Gk68I9bAVToMCWD7z0MaPBGQy/2M+iK3RdPuWaYpv99L7DlfT3JYlk9
         VMavHNm+Ko9UL7gC6JZYofdMSwcRgRoFd7+knQDphy5JNq5gY+uBbSC/8DCTA2iU/JBH
         Ghpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198798; x=1685790798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BHg5gVGq+WKFx3KhBeMhGGTvFwoSEtH3H2Bo8FpB2Q=;
        b=i5rxeH4xXdO/BAozIUMTiIrV2avDwqlpusQQC2+IQ9SsaQOk9gKVhBLvQ4Nmf+kNzs
         v7pFwpHedkULvbfALd1yhw/nrVTYw65u371XzEXi9NxzGwNGblR4C856Wp8ZdFSE78Au
         PQi+3OGckzXH9RjwnFbselT0baQtnyxhBGsP4l2b6q71wexPciW4UW5Ss1SAzUj1e/kT
         /WdMO8C7hH4fK6JbwjP30ltSMUwtHU8QDwBZzNEeQacYE8/YFJEddM9LQAaHQElYp3fM
         e8KiUNb0HT+o4bam+F1H7FhPjPrIc2iQROIWyKIwfX3tX2kZZy7eTKleGjnUv7Mj3IZx
         GKQw==
X-Gm-Message-State: AC+VfDyazfD0Jrg2N/j9cQMTL4ngVO0J2DO/7/ivrtBp2vLB6QW8+Xi3
        MW/ELDaabCnf/53tul48Slj3wGGu2Vfsqnsdvg==
X-Google-Smtp-Source: ACHHUZ5BZ+OAxwjJvzwqKv23MuOVWfnM6hOmrcBdhPkt2fw5nQukFzE3ahGzKmR6FPFuZvauV2fZnv8N9ml2fLGiDw==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:5484:0:b0:ba1:919a:8f08 with SMTP
 id i126-20020a255484000000b00ba1919a8f08mr983708ybb.2.1683198798564; Thu, 04
 May 2023 04:13:18 -0700 (PDT)
Date:   Thu,  4 May 2023 16:42:58 +0530
In-Reply-To: <20230504111301.229358-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230504111301.229358-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504111301.229358-3-ajayagarwal@google.com>
Subject: [PATCH v3 2/5] PCI/ASPM: Set ASPM_STATE_L1 only when driver enables L1
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the ASPM driver sets ASPM_STATE_L1 as well as
ASPM_STATE_L1SS when the caller wants to enable just L1.
This is incorrect. Fix this by setting the ASPM_STATE_L1 bit
only when the caller wishes to enable L1.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - Replace "L1.0" with "L1" in the commit message

Changelog since v1:
 - Break down the L1 and L1ss handling into separate patches

 drivers/pci/pcie/aspm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5765b226102a..4ad0bf5d5838 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1170,8 +1170,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_default |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+		link->aspm_default |= ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1)
 		link->aspm_default |= ASPM_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
-- 
2.40.1.495.gc816e09b53d-goog

