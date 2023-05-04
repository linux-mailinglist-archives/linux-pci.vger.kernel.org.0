Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221D6F699A
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEDLNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjEDLNJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:13:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC7E1FC4
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 04:13:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso10429615276.1
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683198787; x=1685790787;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BH4WBziygnQRWRTZBQhSJElnF8mfHsMnhfpWAznOWVQ=;
        b=1UctfMAs4Ca1b7Hl5+6WTMqmR/mb7/A8Sux2t8a8TQX1vOD1vO9Qy7c7GGnO6f89X4
         C4ajKGYDnF2yhr1Dv5zxR2+dbmSyxBnwj2ZBFGtqMcobL0YH6OgaE5D2GtrJniuh+MzI
         HGz+mecHOJkuYmX4LAfHsVCpcqcJoS6zS28J4xuEDmp4M/BOWXM+Y2t55R3fsoD8fZNp
         A0lKW0JQkWaDBo78lIHnE+JgJQ6FleK6ViJMACUu97aFF/GQoSRDAg2fpXDGlsEpH7ho
         8SUR7R5YFiKBUOaMvStNpFmsVZ4OS5N+S5NUTsuCu3AubVhEqmzsZWKfk+3gBbodpVjv
         cErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198787; x=1685790787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH4WBziygnQRWRTZBQhSJElnF8mfHsMnhfpWAznOWVQ=;
        b=RDZ8ZEN2oWV8VYDpolV6vQjBaa5z003AVaYJcGZbTMLTZGM/0tHS5aDm/8/RHPQkLF
         1HDyL06aAEIdk/DL2fZbhZ+ezDps7C5fThkTV5fn6CWhFLuj139WncR4Ht7SmbTfXq7Z
         Nd2cQ++tsxuz38nVt/cC71dj8hC9TU9BOCmBWD2575ZfrTTbMxjHLcGU9Kd8kXiaO2eW
         4PyV2SkNQrRcECYTjC0o/WNLa78eay06HyBm959/8wniMZ2mCphPvrslEYzbIlfSpCXX
         ER9wNos02MLEk98sC0w3a2uYZZ5NgK5kmuwlnN22KadBVXHdZLQ1czRZGI8UxtlInt3k
         x4FA==
X-Gm-Message-State: AC+VfDxtnRKRtXxSB/9HKSjlzVGbDvTb4ktW9ZkuiQqtzBhx1H239G4m
        bRu7M5O72UWE51k7p0fZG28n5986GySDTkFaxA==
X-Google-Smtp-Source: ACHHUZ6ynKojAIoX8YjZus3yiyfXJNxpPDr+SO0SG8PPZJo74ujTGw/+VSq5iBXkXEDCJZZpPVJhfJZE9ZsiU9AK4A==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:690c:b9a:b0:55a:5e16:af7e with
 SMTP id ck26-20020a05690c0b9a00b0055a5e16af7emr1289240ywb.2.1683198787101;
 Thu, 04 May 2023 04:13:07 -0700 (PDT)
Date:   Thu,  4 May 2023 16:42:56 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504111301.229358-1-ajayagarwal@google.com>
Subject: [PATCH v3 0/5] PCI/ASPM: aspm_disable/default state handling and
 other trivial fixes
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

On going through the aspm driver, I found some potential bugs
and opportunities for code cleanup in the way the aspm_disable
and aspm_default states are being handled by the driver.
Perform other refactoring as well.

Changes from v2 to v3:
 - Commit message updates

Changes from v1 to v2:
 - Split the patches into smaller patches
 - Add the patch to rename L1.2 specific functions

Ajay Agarwal (5):
  PCI/ASPM: Disable ASPM_STATE_L1 only when driver disables L1 ASPM
  PCI/ASPM: Set ASPM_STATE_L1 only when driver enables L1
  PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1ss
  PCI/ASPM: Rename L1.2 specific functions
  PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check

 drivers/pci/pcie/aspm.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

