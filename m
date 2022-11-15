Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA88B629798
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKOLjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKOLjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 06:39:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74C1F9CF
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:39:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b11so13085056pjp.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S03gKeB0WYsW+/K1D69U3B60HvKmvMdZR32gNUMKvwA=;
        b=Z9g6K8xDqPVZyD4mV5SEhMpkHebEWZ9KxZnUzz2PFpC24tWb6jhuFxIRyQa3UK7+eq
         yciKswyfBm2IZY4t93TNcP+8ZCUsIDq68JfIhD2juuPeEaO9HpHV4nuhGqGIoikxFyp7
         gO6Thbl38+Xtlx3DGaftSFj6AP99Na7wqCSOtGPznz6Anb4j1SoQ1Qj9Y3FgiTlB21Hw
         J6TG7tculbPc7PZ5n4QKjfTNJ0EyMVsXcQMlikMHIMVHyVlDmJvkCmyo3quiJvJXJz0r
         VS2tn2fNbVE05UgZKstZCpkTI2n0/+k6tzNR8CZ1ZzI6xPPmN0S6NxRSQardTJmjXET9
         2O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S03gKeB0WYsW+/K1D69U3B60HvKmvMdZR32gNUMKvwA=;
        b=ggXVzSpsPgxKf/2zZrHdeJXPsUpRCoShuMX2/x94NBQ9FYzCdoso7tpXoUtEUnRHJx
         MHF5W8K91J+q+QRg0niD6HVmKc0SVp/lXecoZLn5Hmzyh/qv+GGu1ekfW2swhaI37QUz
         XbATSI1Tz8LG8XjVG2lSqISV3PMCZibp2J8hgURHgNUGJSduHC9k1sN3fuYpWVB6RQHT
         s/zYTL6WCZ2rLbzskkFRem5SdttCkk00tU3pLRprxkIAH/tQ7AJs9MWHST0ZePFxxUCn
         d6RRG2YfIHPM5ibw4MGMLY5yBDiggLbO58C/ITfO3NpiFuAL6sGKq0OWcStxDDq4n+sV
         sb2Q==
X-Gm-Message-State: ANoB5pnTWxVrcGwnexfWmHCseNPwX1+YVcNYt0YtFBjkSSLRzANj25SN
        K6jrE12KUR1rhvuPd7gmemk=
X-Google-Smtp-Source: AA0mqf7Xk3XHB2MGVEcOLDob4327rIp04mZbZ/RiozqTBl77Y6Pa4X7o5EuTsR+kM9UBpdg8/A1dYg==
X-Received: by 2002:a17:90b:394f:b0:213:6442:232a with SMTP id oe15-20020a17090b394f00b002136442232amr92249pjb.117.1668512342986;
        Tue, 15 Nov 2022 03:39:02 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id g12-20020a63fa4c000000b004768ce9e4fasm3338023pgk.59.2022.11.15.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:39:02 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v4 0/2] add hotplug depedency info
Date:   Tue, 15 Nov 2022 22:38:55 +1100
Message-Id: <20221115113857.35800-1-albert.zhou.50@gmail.com>
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

v3->v4: Add Mika's review tag.

v2->v3: Dependency comment made more precise and technical, as suggested
by Mika Westerberg.

v1->v2: I added comments that PCIe cards with USB4 or Thunderbolt also
require the hotplug feature. I also added the "default y if USB4" line
to the relevant config options, as suggested by Lukas Wunner.

Albert Zhou (2):
  pci: hotplug: add dependency info to Kconfig
  pci: pcie: add dependency info to Kconfig

 drivers/pci/hotplug/Kconfig | 4 +++-
 drivers/pci/pcie/Kconfig    | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)


base-commit: e01d50cbd6eece456843717a566a34e8b926cf0c
-- 
2.34.1

