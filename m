Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF53629668
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiKOKyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiKOKyM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 05:54:12 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409172657F
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 02:52:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p12so12816242plq.4
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42IQKpN2gTnHgK72jIRRNxSRwfYSbIRCOOmqDVaFgq8=;
        b=lsqnf7DWd8DacYeQ1b52XYWPZVn8685DeWxqXGfxHEIaRFJvtRIns9U6/yXoAujck5
         T8xqGRykgJRzx9GPCyjSPm9zDfp9zmVW0SxrSz1jJ4O42wB3dxbr/UvZPFnuOzvsvPhh
         JGv8mcOhIpqNO7ZZtiq6ZAvChF9pJ9xHUtJCHcq4U0oFFNug/GrvWi2+SS2PlFnBcaBX
         D4eH7oLIG/YNq8ebv5CniosRhxQGHv53PITpExh3rU0q86A/2I9ElYErnu5S7tT+fdZC
         jTtn8/fPyPPULJ0f6FWQ0M72/YPiEuGQK5dlsHk3F7wP1NAi2xVaSLvW2dMLWWWeGpf4
         xNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42IQKpN2gTnHgK72jIRRNxSRwfYSbIRCOOmqDVaFgq8=;
        b=izVvK8lwsH47yVI4SPORWz87jvLHQ9rrGKEg47ZKV75nahO+Iyr8BTAgvX+VEeCCGA
         O/X9qy9rvjNkYzDY+hNQr8hpbC5UqGOSrkhkEGY37Goaz2YJn8jzrYeesQXSKrVnEr5r
         06/WjFEoTIIAHgTXcBoHEGNcdFsNZNnTznuMDcj2Lz6H+1HlyJkEMJGUSlxsJ6LrvWK8
         6dOcyNRCjtBVRER/L9dc0VzA5PeijiFJHCYzfH8wmU9zwUmEsvRfpjvTH/6YpYGzid9e
         XdJ2WgDGG5coc6pN5JYYWvxa7SsyTLUV//XcYI6fco0B9o8gHQBf4LXpLEay20iHmY2N
         M4jQ==
X-Gm-Message-State: ANoB5pmgMLZWoI1+a0UXV6Mt6ExvQFscWRgZxl9OS7fmz6UlsnEouGxe
        VDBfCmhSH6EcHDFGU0bhm/rRDYA+FnUqzw==
X-Google-Smtp-Source: AA0mqf69nFYSMipQFrdZNBlRSuvzpRJoSaYfSuKDmeWLriLHgTIu9MBz9GWhTJZJX6jy4xf4Tn+fjw==
X-Received: by 2002:a17:903:3308:b0:186:fb90:5758 with SMTP id jk8-20020a170903330800b00186fb905758mr3413669plb.115.1668509566457;
        Tue, 15 Nov 2022 02:52:46 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b00470275c8d6dsm7325129pgk.10.2022.11.15.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:52:45 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v3 0/2] add hotplug depedency info
Date:   Tue, 15 Nov 2022 21:52:38 +1100
Message-Id: <20221115105240.32638-1-albert.zhou.50@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2->v3: Dependency comment made more precise and technical, as suggested
by Mika Westerberg.

v1->v2: I added comments that PCIe cards with USB4 or Thunderbolt also
require the hotplug feature. I also added the "default y if USB4" line
to the relevant config options, as suggested by Lukas Wunner.

Albert Zhou (2):
  pci: hotplug: add dependency info to Kconfig
  pci: pcie: add dependency info to Kconfig

 drivers/pci/hotplug/Kconfig | 4 +++-
 drivers/pci/pcie/Kconfig    | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)


base-commit: fef7fd48922d11b22620e19f9c9101647bfe943d
-- 
2.34.1

