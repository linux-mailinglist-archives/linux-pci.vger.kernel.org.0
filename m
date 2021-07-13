Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3753C68AB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 04:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhGMC5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 22:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhGMC5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 22:57:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6FFC0613DD
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:54:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso1186451pjp.5
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 19:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BJvQLOjsl0gAGxHxBpVZlBksMhyHLgr2VpfSWU0djEQ=;
        b=LOq5AtbLxPPaTzVUgPka2d5dQ3lxkfE2BVJo5G4NhinBzDwZXhGdRCwvXszkvMfJdN
         lLtS4QzEAVLGKrVTnC/a+92vAdruhEEHlXmmglbxdzKUdRxOBF+2WnG7e7qLK4YYYmKz
         Iqk8QZKNpsz7q/tfIM8VhUM6oCRC0DWozhLJU7rOS01QIPbTce+LBo9IV6Vzi/n/wiN4
         vgX/hQDDZQgc3XoheAgX93Qs4/oUCbOkBxjjnjWa7QXpKWG7lRPRuSQE0meK2wPbJEcm
         LwZ2MygQD2cY1kZmn356e+74JqkDQkM05akS+dh3zHwzNHRGzLp7nMuZWnN+01bWbaa0
         7Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BJvQLOjsl0gAGxHxBpVZlBksMhyHLgr2VpfSWU0djEQ=;
        b=AeeMQHjULdVBCVeRxGye504YN5czRuW3TqbojvStgYcn/WHylb3gH7RkxAqW7W4Nsa
         KNC0gxwx0qLkt3vOgXYMq2YVyBmlpHBNRNRd/B6KkLYJYE6Ml6jTwU7p88ygXSkQhVre
         DTwA24nNHxm0WOSJNxCPiht6YO3CRkXgzkeTcWDivKt8YGhKVqt5QteSthX6IS2meKcQ
         gCPI1KVXZCFes5eNLQRXJMt/r1qS40beheOOp0Jp2SDmK5cblSMG6J58zCGMwmwa6ODq
         5x5LLINcHPQ1R8Q20qb0ohmpWX7usAS63BwqjVeLgNSHOj/1j+ve6jCebPlxEG7++lyG
         e4gg==
X-Gm-Message-State: AOAM533p9tfW2XWpAzZJb65cQBLmrlg1i2UOlvLoDnYLS5bY4k+tqBRG
        tCyuxC4d01mg0tohhWgn0k0bNw==
X-Google-Smtp-Source: ABdhPJzB2iow+jCc4PtywBKulgRSR7U6GcQRKsJyADcUkhs5KcS+v2we0L2qTCHKR45KDhVy6wjEzw==
X-Received: by 2002:a17:902:7d8f:b029:116:4b69:c7c5 with SMTP id a15-20020a1709027d8fb02901164b69c7c5mr1682692plm.58.1626144894904;
        Mon, 12 Jul 2021 19:54:54 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.134])
        by smtp.gmail.com with ESMTPSA id r14sm19303344pgm.28.2021.07.12.19.54.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jul 2021 19:54:54 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
Date:   Tue, 13 Jul 2021 10:54:33 +0800
Message-Id: <1626144876-11352-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices have PASID capability
though not supporting TLP.

Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.

v5:
no change, base on 5.14-rc1

v4: 
Applied to Linux 5.13-rc2, and build successfully with only these three patches.

v3:
https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
Rebase to Linux 5.12-rc1
Change commit msg adding:
Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/

By the way the patchset can directly applied on 5.12-rc1 and build successfully though
without the dependent patchset.

v2:
Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn 
"Apparently these devices have a PASID capability.  I think you should
add a new pci_dev bit that is specific to this idea of "PASID works
without TLP prefixes" and then change pci_enable_pasid() to look at
that bit as well as eetlp_prefix_path."
https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/

Zhangfei Gao (3):
  PCI: PASID can be enabled without TLP prefix
  PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
  PCI: Set dma-can-stall for HiSilicon chips

 drivers/pci/ats.c    |  2 +-
 drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.7.4

