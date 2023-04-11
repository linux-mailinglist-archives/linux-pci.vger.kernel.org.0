Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F736DD8FD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDKLLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDKLLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:11:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24544A2
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:10:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c0b8ca2d1so148835057b3.17
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681211458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8qMlgNbDx0jGULJ7F2Nuk2N1BwNFYg0vrO1o3nyayg=;
        b=N0/T70b3fIPZ53RB6G6QenDZdRwcJY2stYCyJiPmm6TcktCybmJRrf8vAj6q9M9qLi
         k2guPXtD6gacaWHrr3Ts2f5OMEiI18cDhRDxD9vCuyJPlsAZHwjYkVhAnccW4di0zPJR
         0zeQJ6494S//aADB6yTvsoTYNZ2S3ca/hgAFfK2TR+myYdiNe7VvhuDR9beVPQQcVe1H
         H4mUTwjuK4O5TVY6Gh/9qmDcDQyi90plmE7ruRrdPzMH5DACpGOxS4mIpFf+6uyCL3MN
         j9STIIs0f9ZakMLG252wk8Bly/GG1UthAhz+vRuv1SS9dSihFXCJ5IfaxlbVpfplVcZe
         AgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8qMlgNbDx0jGULJ7F2Nuk2N1BwNFYg0vrO1o3nyayg=;
        b=y8tg3cfl5HXsGePalRWQEVYMlbrhSQTPPJYrUZ8AfpvMYlJyCmVTpCWLAWSgmI7Ey0
         Au7hGO9Oq8Bu0CZmA5eCd7D4qCBdvlzhj5I2qGDKWVGDh+gLIXh4g1HNZbg+fEwE//VI
         BQaA/fyaq1qf+aW+/xR5LQc92zRPEP5zDKxh2dngSPykWRtYLyMz8+BSvu/MIYt1cprx
         uI3sNPBbQBpaGRtoEnCDKVqwMZcOy6tqLRt0IQR9gszneb5TfU8aniVLSoN3R5wYqzaW
         lB3J9Cf6Vp5rV+j8i7fbetz8x1710+sI+EaqNFHSQjGRc3j6GJ8o8rgiCfugBENK8RbL
         /FKQ==
X-Gm-Message-State: AAQBX9d/FCjAR4qj7IbK5ClzQHWiXJB60wSr+Vvl7+DVn8WbvDdnmNkX
        DJ6Z0kWX/KycQygIYoGBByobtuccIJwP9XxIuA==
X-Google-Smtp-Source: AKy350bofEoA/nGomWSRbgETszSYLdfqX0zuvh/oiBf02sBr71iLWapjXWt89sE2X0WivKY/wWEMU5Qqrj7ympQGww==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:c904:0:b0:534:d71f:14e6 with SMTP
 id o4-20020a81c904000000b00534d71f14e6mr7423066ywi.9.1681211457905; Tue, 11
 Apr 2023 04:10:57 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:40:32 +0530
In-Reply-To: <20230411111034.1473044-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230411111034.1473044-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411111034.1473044-2-ajayagarwal@google.com>
Subject: [PATCH 1/3] PCI/ASPM: Disable ASPM_STATE_L1 only when class driver
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the aspm driver sets ASPM_STATE_L1 as well as
ASPM_STATE_L1SS bits when the class driver disables L1.
pcie_config_aspm_link takes care that L1ss ASPM is not enabled
if L1 is disabled. ASPM_STATE_L1SS bits do not need to be
explicitly set. The sysfs node store() function, which also
modifies the aspm_disable value, does not set these bits either
when only L1 ASPM is disabled by the user.

Disable ASPM_STATE_L1 only when class driver disables L1 ASPM.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
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
2.40.0.577.gac1e443424-goog

