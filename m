Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7566F699B
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEDLNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjEDLNO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:13:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA932D51
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 04:13:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a7d1f6914so4195117b3.1
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683198792; x=1685790792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BACe8oAsJls97Ud0XHa81Wel0w9BVG2GDsrufMZ/Pl0=;
        b=1GiuVcNBi9oEBXA0yIhcUizZZi1SJEw+LjmxtHzmka55TfjUwoZgvnyE6PAlH0H3EV
         TPQTxrn0WmaciVWhT+Z0pzzbf07uU9tkIjHKJUnw3cHbbmta95pu2dIczBPVo+NcyGXv
         Mx+0EY6q4fIze+mximWB4CN9nd8r2y/Jm1PljnQK4Z3kIYcc1/X2TXQVeSMxhaHcc6Kf
         dt1e4RszivBoslXjsbw+Xui510Mebbyk91yf4qNGWFKTzGbGYB0ooZU+WnTpU4BK3mBZ
         H9ZKY3ZE165HL6vxmQ4BJhTBNZLogLCyINrDNjx9gZomzHxiW1skAKEP1cOvaKwANKQr
         F2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198792; x=1685790792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BACe8oAsJls97Ud0XHa81Wel0w9BVG2GDsrufMZ/Pl0=;
        b=Vje2/RoB7A/pgTXARggpC3MDH0VC3JavPXgSKrfqf8c84EtHFwwuZeOwjPP9GuV0Hg
         YEYH5JNUEtOZjn1soFK/z4RcmxmvF3wD+gSnhgH6QDWV6N4eUfd5f9zk6Ni872hdPrVA
         /oSca4UJh2uVfEWkp1tXHMqeWyJDQVKNX8NAcVUvSFeWcIg4TRnf03POp8xGBkH3pw60
         weWQWz0e8KqD/Fl3dormIU93/Cg3YCU9r8LjwQaaOo3cxJj8TYZZKy9nAi3+mJ12L0Wv
         iOKGh01MgC239JQc/2M+7kNwWGJhRJoaxU9LL1+tPa5gFSfEO+yosFsRXFBxjMLn4hWB
         MKvg==
X-Gm-Message-State: AC+VfDwSXwjgT/2xkro07XpEzieb/S6c2HHyqxOlPFAoiYdz2NJNi10M
        1rZbw97QiPojf9CPAy41O7TYvZqmR3qaGTWqcw==
X-Google-Smtp-Source: ACHHUZ6A7i7h5CJ3OBZ2bATKkJuBCN2of4XNEVVd2ZpGmguA01XfWkWVAJQAbj5aPYiSRcS0WJdjNogdJ7+EYzjJag==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:4149:0:b0:55d:8472:4597 with SMTP
 id f9-20020a814149000000b0055d84724597mr324024ywk.10.1683198792626; Thu, 04
 May 2023 04:13:12 -0700 (PDT)
Date:   Thu,  4 May 2023 16:42:57 +0530
In-Reply-To: <20230504111301.229358-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230504111301.229358-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504111301.229358-2-ajayagarwal@google.com>
Subject: [PATCH v3 1/5] PCI/ASPM: Disable ASPM_STATE_L1 only when driver
 disables L1 ASPM
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

Currently the aspm driver sets ASPM_STATE_L1 as well as
ASPM_STATE_L1SS bits in aspm_disable when the caller disables L1.
pcie_config_aspm_link takes care that L1ss ASPM is not enabled
if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
explicitly set. The sysfs node store() function, which also
modifies the aspm_disable value, does not set these bits either
when only L1 ASPM is disabled by the user.

Disable ASPM_STATE_L1 only when the caller disables L1 ASPM.
No functional changes intended.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - Better commit message

Changelog since v1:
 - Better commit message

 drivers/pci/pcie/aspm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..5765b226102a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1095,8 +1095,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		/* L1 PM substates require L1 */
-		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+		link->aspm_disable |= ASPM_STATE_L1;
 	if (state & PCIE_LINK_STATE_L1_1)
 		link->aspm_disable |= ASPM_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
-- 
2.40.1.495.gc816e09b53d-goog

