Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342B05A9EC2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIASQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIASQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 14:16:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8767755C
        for <linux-pci@vger.kernel.org>; Thu,  1 Sep 2022 11:16:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w2so17858305pld.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Sep 2022 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=UHJ+wNg6rHSLjNi/6t6DVtAkUVcspchblfn/eFkKqsw=;
        b=HrJjbOMAscprcYO5PohMvHxByNRc1LKXTo6sQZuSzgC2XApf6bfM9LFErgYqRzoCgj
         dxDAMu9X4lyR7NRhOF5reb+70GOQgQhspYNlzgiePz3BU2vBiOTc/wCgQOTBX1nvY3rl
         gRAOXKbMZo6iWwdxi5XCFMyWAK0sm8241MmfzJSwrIHCME8q/lKFVw54cv+mMAQPeY+I
         CceuLNc7YMKHS9J6H0rqi3cuooZ6w2KLQeRcyB+ueRMsAHpJMRLidojb13a8cxBWurte
         4EKxdLd+1K5ihRfvnqll1rCH5Gk6uP70mqHUGIq9SNVjwOl+S/rBWIvlyRybEnmgp4Fk
         MA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UHJ+wNg6rHSLjNi/6t6DVtAkUVcspchblfn/eFkKqsw=;
        b=k6FUPgoZ3CP7nzxqNh7LHy8Xzoag6OAaaAh3DSLRoVvWx2hKnaSO3j9gQnRtmBWmOq
         YkH5jVZ4yYN8GGdUIuZHFhnWPfBhmtuWViUFc3rHfXaK0nFIPEBdbIIZn781sTy7GvGy
         n//vVm6PGNNpNH8D4/WSfCBs4qSwzNkAOy9ef157ZOF1495v5D/Bi+y+saHHQYhraxDv
         psZYpqMR0AP2q8yr4R1wYVpEuNq1kGE73J416aRN1rxCKKo7BQiPoK1i45NDr1lEcIRh
         FOxQIv411t/6BOjELGNhlJ3N0ck2mq5pFzZ8OQ9i89B2oymFbz0TmqnWVFug5Vb8d/mq
         NGOQ==
X-Gm-Message-State: ACgBeo1k0eOKPDcvCtp1IUWXlB3wsRCuPChjd4+YcavaA42FUwv2U/be
        q3i55B6G7lTfZNJhuUqIHLj24Q==
X-Google-Smtp-Source: AA6agR6b8r7oRaI6ROi7pyqAyUtxNINQwKB8079M56A+1+FEt2RYm/zemPHbg56SBzgLUP1mE90YiA==
X-Received: by 2002:a17:903:22c7:b0:175:3682:9cf5 with SMTP id y7-20020a17090322c700b0017536829cf5mr11191184plg.150.1662056214062;
        Thu, 01 Sep 2022 11:16:54 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017519b86996sm6320538plh.218.2022.09.01.11.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:16:53 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc,
        oohall@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: [PATCH 0/3] PCI/AER: Fix and optimize usage of status clear api
Date:   Fri,  2 Sep 2022 02:16:31 +0800
Message-Id: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series contains some fixes and optimizations of aer api usage.
We add some process to clear uncorrectable error status, then add
distinction between fatal and nonfatal situations in pcie_do_recovery()
and reduce some redundant code. The series involves pci driver and
vendor driver.

Thanks,
Zhuo Chen

Zhuo Chen (3):
  PCI/AER: Use pci_aer_clear_uncorrect_error_status() to clear
    uncorrectable error status
  PCI/ERR: Clear fatal status in pcie_do_recovery()
  PCI/AER: Use pci_aer_raw_clear_status() to clear root port's AER error
    status

 drivers/ntb/hw/idt/ntb_hw_idt.c |  4 ++--
 drivers/pci/pci.h               |  2 ++
 drivers/pci/pcie/aer.c          | 30 +++++++++++++++++++-----------
 drivers/pci/pcie/dpc.c          |  3 +--
 drivers/pci/pcie/err.c          |  8 ++++++--
 drivers/scsi/lpfc/lpfc_attr.c   |  4 ++--
 include/linux/aer.h             |  4 ++--
 7 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.30.1 (Apple Git-130)

