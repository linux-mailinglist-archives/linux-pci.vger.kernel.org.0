Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855565A1910
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiHYSvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiHYSvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 14:51:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B83A4BA
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:51:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-337ed9110c2so314102327b3.15
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=UaweP+hutoQUCrkWUYrkD+ciXP7WXgYs/dDq7y/nMqY=;
        b=RsCXT18g9rB4L6xdxOFuMmvdk3RedLQEKhf6SHh/O5yoemRRhp8mu8g4um1BhlHHWP
         XHs1/fCTCkqzMABIK1+LaKhWpLTH+NISFBrG2Pam3kumPnNsw0Jb08r1C2GLurK+7xR3
         Dw4DnUuNOlMsJBNXK4WUZRBsZKsqLPKfAkc+QKv44409bL+ATMWPUIK1GYnjJhW6wRFn
         sZNRWTExWa4hknKPzCesdVwzKz05pv7+hK6Mcl2rFa6q1GVLc9oko8BfZCLqUfC0POk2
         KYk7oCbTvcWJu/IxZlQCppiISlqauiJa+88ftnOPeNW/0zGFQb4GhDlY0XD/XOKBOP/A
         xp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=UaweP+hutoQUCrkWUYrkD+ciXP7WXgYs/dDq7y/nMqY=;
        b=GgpMSBXiMfjxY2/5MxxF45NvWO1nsofOLEBRLrXDaTwQuPhlGjTYzclZ0XcFkL9rub
         LsPs8h9N6h/zyg829kMkSLpBqKTHIq47r8SC6L6qM9lyZSOL83OHnC4XIYLHMBNwkdwt
         Lk2vcQzUZG+1QOwo8Wx9zP+yQy8JHuSLRKchqQZVuN6/JNQCOzawJlq+MW1OpZWiVHXw
         /r7meH1ltMJjjV4K7gx3HE4QLlA+h4RwRR0ndkqyXNOwkiJBsooE7md2ynqc9L0bsF3Z
         JDE5PzrWOoPkxNRgFVCjKvPs8w1r/ihmjSsetm+0oCcFWVL/pPQLHV7N7V3bG/olGSBf
         yFMA==
X-Gm-Message-State: ACgBeo3XmzpZLTB/A5fTIjpvrlXLCDASN/3zeWwHQTW9wYdOw+rpcY9G
        MvJMgI8t6hXB+ji/TdMy1ZpnBfaI14HeEqz/G5k=
X-Google-Smtp-Source: AA6agR4sOROMVTV/Pp5patOHyT6WPfqLKXz727gAhzJqf+pPwy4Afq6jTbJSFMbkOz8oYn/6g8Bv3lRvo1FTFgq+MII=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a25:d9d8:0:b0:695:58d5:e7f6 with SMTP
 id q207-20020a25d9d8000000b0069558d5e7f6mr4269117ybg.101.1661453460634; Thu,
 25 Aug 2022 11:51:00 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:50:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825185026.3816331-1-willmcvicker@google.com>
Subject: [PATCH v5 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

I have updated the second patch to first try allocating the DMA buffer
with a 32-bit mask. If that fails and the host supports a 64-bit msi_msg
buffer, then the driver will retry the allocation with a 64-bit DMA mask.

I rebased the series and tested with a Pixel 6 on 6.0-rc1
(android-mainline) and a db845c with 5.15. Thanks for the reviews!

Regards,
Will

Will McVicker (2):
  PCI: dwc: Drop dependency on ZONE_DMA32
  PCI: dwc: Add support for 64-bit MSI target address

v5:
 * Updated patch 2/2 to first try with a 32-bit DMA mask. On failure,
   retry with a 64-bit mask if supported.

v4:
 * Updated commit descriptions.
 * Renamed msi_64b -> msi_64bit.
 * Dropped msi_64bit ternary use.
 * Dropped export of dw_pcie_msi_capabilities.

v3:
  * Switched to a managed DMA allocation.
  * Simplified the DMA allocation cleanup.
  * Dropped msi_page from struct dw_pcie_rp.
  * Allocating a u64 instead of a full page.

v2:
  * Fixed build error caught by kernel test robot
  * Fixed error handling reported by Isaac Manjarres

 .../pci/controller/dwc/pcie-designware-host.c | 54 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c  |  8 +++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2.672.g94769d06f0-goog

