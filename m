Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B51A2D2AB4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 13:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgLHM0g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 07:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgLHM0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 07:26:36 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCCFC0613D6
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 04:25:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id q75so2191187wme.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 04:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Znwzn0QHUv1W/0i/MR/Gyl3ZEiE2RiHMIRIM72jgdb0=;
        b=UZBjAYSuA8LXZ5KU+r9IYGP5NS2yFyKgXjYLCKZdyZ2POg2dbw4TGoq+TCVuWdttA9
         +k7iYFPxmgd6vbleXu5bVbQEpftYjHEgVU4gjjSROjnuxf2b0PNrieaJfd1a71aYnX2p
         lkCVKKpXcKPtxVuK4Xj5DctCj6dApp5MB2KkkG55kclXRwKI8/cTtOSV6qn7SgS3dyDA
         JXGnrwxDDzkGFk4iFBrs2pjvbix8TUh1nJ2/g3wOs2LVZDfnzSgPFvEsH7rLv0zL5JzB
         M0wJgellu6vIyg5kRH6YonS5gmPadj9xyvLyovE766ksC2/7nD3fXE39wW84EarjPnEq
         RqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Znwzn0QHUv1W/0i/MR/Gyl3ZEiE2RiHMIRIM72jgdb0=;
        b=EHpFDDBOV3zelauGPiaRQG5TbLSHaLynXjq2X1lexaJXko8LIRFls9pzcoXn3mxR+1
         kafgDuSZkA7wNQLtvjmIWDn5ccaQK/klZ6jKYRmwTiQe7ZG5LZ8AJfRRHZ2TGYkUoQmq
         ucVUo8nyrReT7IEcP1MWC8blKD35gE/Ww6JbnZco+Q+BvJ5ZsItZd24Nb0EzINDV/dMR
         YeFzwkcbLKftm+35JG/iiOzw9nBD1vGQz4TmRiPXAIIEa17OvcFT5nBuS9zfX2F3o0WU
         bgkjwKCCrXNLnRkymeNmuURI7VijJvE/Jm+G/O/6GwgTRxFyGxM0kIHDIXYzgUJIvNBO
         aR6w==
X-Gm-Message-State: AOAM5306FfLspZOtwNKQUgzjJ1ZFgmt9MFE2j89vRNR9by+DQwtAjfkl
        MDzO1AY/1QBs9sOAQxKzeDnDyl4v0j4=
X-Google-Smtp-Source: ABdhPJxh4Uhw/B914mHzHHIUXaPUUHExUELh7MfP0n4aS+yZtYn1EF1g5APiPwaSKxVMU7HRU6+iZg==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr3801681wme.23.1607430354381;
        Tue, 08 Dec 2020 04:25:54 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:580f:b429:3aa2:f8b1? (p200300ea8f065500580fb4293aa2f8b1.dip0.t-ipconnect.de. [2003:ea:8f06:5500:580f:b429:3aa2:f8b1])
        by smtp.googlemail.com with ESMTPSA id l13sm19765035wrm.24.2020.12.08.04.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 04:25:53 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Remove unused HAVE_PCI_SET_MWI
Message-ID: <03f20cac-708d-7897-c7c7-cb4e63cfd991@gmail.com>
Date:   Tue, 8 Dec 2020 13:16:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused HAVE_PCI_SET_MWI.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index e007bc3e8..de75f6a4d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1191,7 +1191,6 @@ void pci_clear_master(struct pci_dev *dev);
 
 int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state);
 int pci_set_cacheline_size(struct pci_dev *dev);
-#define HAVE_PCI_SET_MWI
 int __must_check pci_set_mwi(struct pci_dev *dev);
 int __must_check pcim_set_mwi(struct pci_dev *dev);
 int pci_try_set_mwi(struct pci_dev *dev);
-- 
2.29.2

