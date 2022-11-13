Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620FF626F47
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiKML2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 06:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKML2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 06:28:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388CFD1F
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 03:28:18 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y203so8652541pfb.4
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 03:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqwkt+NWyzhPZ44c557n7gXYjHmUr7T/4GrL/NLw/wE=;
        b=EWsAKffGtIZPwiazAn4QAjcfKcM2T2JGbO6nbqC1iZzI3lE1jTFwK93yWHzCg6HMTT
         PHw+drjYU21eePWEUOsrjsAwVhExgPgFz9qaVtfcxhBodOlrjfVMLhANj9HxMtejoKfC
         /huNt2c/9VIIRIy7t7PBZ1rhS3D7bbi+gw4pB9lJt6wWdmeqmQk6MCMYGTc2JDPTIeKu
         JiwSUp2DvehQPnYDqebTAgOaiFvS8bp/0QeCt2SyqvHtatEhD8cSsNie7EmbyEs+u4Vo
         b7uXDmmc/c7f8/1Vked3QCl13Sj+cY1VYE4s5hoIODHiHkvLGfXeWYyyr37jlfYMHLE6
         ieog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqwkt+NWyzhPZ44c557n7gXYjHmUr7T/4GrL/NLw/wE=;
        b=yQXp7cDUC6+aEMOpChe/RzmjBN+MFUxElg9/ABv+h8kC7H3smLfveax4AEQ6zhFQQ1
         sIwOOu9+eqDK/jMDLjsaQKhfgvKXPseZ+/UGWXcaapqWW6FeADCEG1kTTTLmCSjSbgxT
         JwH+0gk3KOAj55GWLGE3AAvKXpLy671xOS/t+eQH/whdHDP8ilKhM2EtvagWSWyUHX62
         VfPK9fhAfXhiQgHiCd3d0NkfLK7oGUZhPHFzLgtfPZMoAcanEWXztUDuuLyVcctX4v5u
         rHdTAsYM2o6s59Z82QlM/J3Z3GM1LUZtI368sxYH3QL1jbFfiqxnQWVHhlCfvkkKxi80
         lCGA==
X-Gm-Message-State: ANoB5pkiAYD92/cch7fiUPvajPnmvMGxwdopeWYlCbziGRQlomUrE9YH
        8tBtTWLhnBup6k/DhEnrt5hW57wtEYvj1g==
X-Google-Smtp-Source: AA0mqf4yVslqR0olq7mhqoFnq9UVavQmEbygXyUIpkqYwr8uDZTB/dft0vLjxH5euyZghpeWbunI/w==
X-Received: by 2002:a63:644:0:b0:476:87ad:9c12 with SMTP id 65-20020a630644000000b0047687ad9c12mr176441pgg.230.1668338897491;
        Sun, 13 Nov 2022 03:28:17 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id z68-20020a633347000000b0046fe658a903sm3987439pgz.94.2022.11.13.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:28:16 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v2 0/2] add hotplug depedency info
Date:   Sun, 13 Nov 2022 22:28:09 +1100
Message-Id: <20221113112811.22266-1-albert.zhou.50@gmail.com>
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

