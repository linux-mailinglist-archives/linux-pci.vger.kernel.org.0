Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA13931CC
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbhE0PI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhE0PH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 11:07:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0200C06138C;
        Thu, 27 May 2021 08:06:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so604871pjg.1;
        Thu, 27 May 2021 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5u3AdWOIvPoclQ2OovgjLJ8e0qPUkCDjr5oI2WbCEQ=;
        b=Zp9PQk3KJj5fZGBJbkfnzUJuN4DW45iVpE5/EBaNz/Ul3xnS+49mljRqL/pFl3nzak
         EhbGO4BbiEPIr1LqU8d20TwIlNZjfA6Rk5ap8H4qcfHIAp2e8zWjLl7pf/S5dAvJISen
         z5yZYBDeD4WeyhGa3sfhjgHlbUsKACPMS15D3SXSlJs0PwYEdv0zwq4oyInlKm1ESRg1
         O+e9SCe1V10X1I6W6/Rp18ndook4LWPNOlgtYwjlQtpz9+sM95Gs75eCHQA3G7Cr5gBG
         hlOiwXtug537lu/lxbREPDueHDGhFajtDz8zzV2fcBUkf1ZJneAYvZQp1iwfcL2uM5ol
         V8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5u3AdWOIvPoclQ2OovgjLJ8e0qPUkCDjr5oI2WbCEQ=;
        b=Q9cgYPi8Ri5hNuEG0/bPFWtQ4U2B7G/78rvFaFWG6J14rHCux74LPxBcMn4XOT4PmZ
         jCAlS3n6FDVDZIpRjjiWEUjTRTcdsgX7CH+rxzSK5pGHCCmdY333qRtMontQKXZte9ub
         famYcbd9Ll2bUhRu3ylVD/Z+MbtzsapDx+9D0dC/etF36r2MbUVrP/EEaZD2R9qr4R1s
         6AWJV5qtThGcSzSIEOFHwksXNB/+jwPhgimd6oSCkqeslpFc3Q9K09e+Wf7r6BsxnxI6
         u9WCh029P0NuA8FfEkiThUj/nfLX2zDo1dbLXp51v2pOPoXX45evdnrVZfxdZAOmcMLw
         r16w==
X-Gm-Message-State: AOAM530eRe/Cb6DHyJ9Sui4I1tksn3n6UY0pRrlyz8ap5Ldm1ftj9Qbd
        FWYKiTctWoEf0NPh17C89LuQmJKKll+JVg==
X-Google-Smtp-Source: ABdhPJwEKxIUpnd3u4aWjWgNUwVkFCCbuEJ/hQkbeh92KwMleMTYi5P6ttcqTs5ZDtYZOS3iA/c/JQ==
X-Received: by 2002:a17:90a:ab8f:: with SMTP id n15mr1639704pjq.83.1622127970247;
        Thu, 27 May 2021 08:06:10 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id t19sm2277523pfg.70.2021.05.27.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:06:09 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org
Subject: [PATCH 0/2] Fixup non-prefetchable 64-bit host bridge windows
Date:   Fri, 28 May 2021 00:05:39 +0900
Message-Id: <20210527150541.3130505-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

The couple of patches in the set are looking to address the issue of
failure to allocate bus addresses for endpoints requiring
non-prefetchable memory range on RK3399. The issue surfaced as a
fallout of commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to
resource flags for 64-bit memory addresses").

The fix requires a change in the PCI ranges attributes for host bridge
windows advertised in the device tree (Patch 2) but as there are
already existing platforms out there, a device tree fix alone isn't
sufficient.

Patch 1 introduces an override to drop 64-bit attribute if a host
bridge window lies entirely in the 32bit address range. This overcomes
the limitation of PCI-to-PCI bridges that can only map
non-prefetchable windows in the 32bit address space.

The patches are based on v5.13-rc3 and have been tested on a
RockPro64.

Thanks,
Punit

[0] https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com

Punit Agrawal (2):
  PCI: of: Override 64-bit flag for non-prefetchable memory below 4GB
  arm64: dts: rockchip: Update PCI host bridge window to 32-bit address
    memory

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 drivers/pci/of.c                         | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.30.2

