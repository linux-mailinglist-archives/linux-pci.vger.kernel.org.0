Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236104473CB
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhKGQcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhKGQci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 11:32:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345EC061570;
        Sun,  7 Nov 2021 08:29:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b15so33452507edd.7;
        Sun, 07 Nov 2021 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdQHN8nbaGWGXbiZ7KQ1sI8LP21i7umOPWJHxTLsAdE=;
        b=FqQ7YkHncoqGlJlvBE+aU2k++3K0YfcgGTeAiXIh1DFzWpm0b5ftj6LVZ6F8EdL88c
         X6SZvOl6rW/HBJZSGydIOjFnWhoxmq+BHHIE8HIQFBAYn3wTo2Frk/Mdpt8wQ/sem7FB
         BKItyj6DaqvwYLslxBQnVjx7SKDLrvx0A6xvqK/ekhD+E5arDpvvU5iVh+08f0JyvtXk
         t36j7rGJ3SLytGGqakXpCbtZY94s+1xlUOT1XLaoL0hjSqZwepXXZMTew0XizRhR42Rg
         vD36aagYq0RfZjv0j5ccSG3pw5/Ze8T+vDf6SSqOSU3R2qPnkcs/E8kuyjNs9R06KSwV
         Wj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VdQHN8nbaGWGXbiZ7KQ1sI8LP21i7umOPWJHxTLsAdE=;
        b=52kCd38jBRSmkHlipZsX6jJ/BysOzVuLgeGLNEeoaxEHYWG3AFs7iDZPHAP8QW6kRV
         iL6+gGXCc87aaQFZaqe7/HlkzKUUoqEGkq2TIZE5wxt5ZFCrrcB8L3Wqblw3BPXtW6li
         cFbLMSNB5Varen1v2q2ipEu4LXUq+pyMEtqml0SpQOsaKY0q2pluxpNV3Fosg7gguNWi
         Tp7YMGUZxTkcB7LCN+QWVNjrgPSRN9GcVZecUsNg4236XHRKLq/5nyNfpxQ93yghQsxI
         rVvAvQhcJgTwnaEkKQalpculMFHCGmzYW/AuBmLDUbUkUbKZQbH2iSmO8TWENVZe8+pS
         Zw5Q==
X-Gm-Message-State: AOAM533C4svT4JVwoqvCaAty6kJTtUL2NSVzhXgddbP0ZkpGjmTegSMm
        sHVPnQu0fDpEbIIL4QgsumM=
X-Google-Smtp-Source: ABdhPJw8K3ON7+/hoX6qk/Za4IPaUHbJhwhY3ni0IcO1UgOtYFPXy2iP4eGGTD38T3JeIaF4huiDLQ==
X-Received: by 2002:a05:6402:2920:: with SMTP id ee32mr74431789edb.136.1636302593735;
        Sun, 07 Nov 2021 08:29:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id hq37sm7195270ejc.116.2021.11.07.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 08:29:52 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/5] Remove unncessary linked list from aspm.c
Date:   Sun,  7 Nov 2021 17:29:36 +0100
Message-Id: <20211107162941.1196-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An extra linked list is created inside aspm.c to keep track of devices
on which the link state was enabled. However, it is possible to access
them via existing device lists.

This series remove the extra linked list and other related members of
the struct pcie_link_state: `root`, `parent` and `downstream`. All
these are now either calculated or obtained directly when needed.

VERSION CHANGES:
 -v4:
	- Fix uninitialised variable.

 -v3:
»       - Rename pci_get_parent() to pcie_upstream_link() and improve
»         the logic based previous review.
»       - Improve the algorithm to iterate through the devices

 - v2:
»       - Avoid using BUG_ON()
»       - Create helper function pci_get_parent()
»       - Fix a bug from the previous version

Bolarinwa O. Saheed (4):
  PCI/ASPM: Remove struct pcie_link_state.parent
  PCI/ASPM: Remove struct pcie_link_state.root
  PCI/ASPM: Remove struct pcie_link_state.downstream
  PCI/ASPM: Remove unncessary linked list from aspm.c

Saheed O. Bolarinwa (1):
  PCI: Handle NULL value inside pci_upstream_bridge()

 drivers/pci/pcie/aspm.c | 153 ++++++++++++++++++++++++----------------
 include/linux/pci.h     |   3 +
 2 files changed, 95 insertions(+), 61 deletions(-)

-- 
2.20.1

