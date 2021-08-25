Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949AF3F7328
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 12:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhHYK1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 06:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbhHYK1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 06:27:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F0C06179A;
        Wed, 25 Aug 2021 03:26:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w68so20847280pfd.0;
        Wed, 25 Aug 2021 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YG+Dzwf/L1RyWfZn3OGGZtD61sWCS5iNO92JWdcbSUA=;
        b=a6ZiDE1ytbrMVXAox0M0JJUaisvQ1zhu4rsRv+hyzMeI6VWREGgDKglGLYNd3gRvxK
         N+bZxDcZdSHcGOogm9g4QSvEEc+KSVdgpzATYaTEH0jg+V6hksKzuANDbVuzIWH4Tsex
         Cn7geL6CwVedv6NibDQB3iyHp6rQasXRrYKTOTfZh+BHhBh+T8cYS6goa1zAjYcqHli0
         XnAykK8oezpKEjiUTgbYJUQ0tjIcE2VSLNK81xNos0/ZbqMNG+p90kH4LaYmoWiRbcvh
         bLtZwBrVbWlIDwMOVf5I+OSFNEx6K5tZLj5EdJZ3WTdgIOqsC/vKTUJtGWHXJ7+HFrBZ
         LU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YG+Dzwf/L1RyWfZn3OGGZtD61sWCS5iNO92JWdcbSUA=;
        b=S4ThR06ZzoqGjQp1drSfdCNt9kCjWOlfkIUSb4aIn2jEAADiY88FVBrOlK178Zfbbo
         BWlBqYkT9uBsizlicSwgb38kV45x5g6ifLPs7Xa9ldp2rO9A78wSAP6QZj8Sl5xVtr5w
         UeKXYOIpH/NXw8i7H+3ZiXX8OtL6SNdMOaRU2gHNmLz2ZOnIT2V//iDuAWodPYj+zQje
         RKFdCuhjlquNxBL+SkNlCGh5CszpgF4R+y4mqtLppc4Dmy3uwrA5ZMsbUH56YJ93vpgU
         qc4zv2bEUgv7IXLsCMxiEpz4b3hHLLiC5QIpoMp1w5KE1lvjkJ0p98+uMob2IYEaNJfm
         5bgA==
X-Gm-Message-State: AOAM530m+7EUxn7KfP6E2J64abxt61ngRQa+BWbaCoL3v4VRJCbPZp4/
        KwcYJ2JTaQ1GKfNR6Ctx8/M=
X-Google-Smtp-Source: ABdhPJyziwI7/DFjyV9RRlioGgtF5Bp4ubELXmeRU+Yr/EM5C6Hli5/hsEmCdkI4pmvT04cVVUmP4A==
X-Received: by 2002:a62:16cf:0:b0:3e1:114a:abb6 with SMTP id 198-20020a6216cf000000b003e1114aabb6mr43720882pfw.80.1629887218547;
        Wed, 25 Aug 2021 03:26:58 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id f23sm1786403pfa.94.2021.08.25.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:26:58 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bhelgaas@google.com, maz@kernel.org, tglx@linutronix.de
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu, corbet@lwn.net,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 0/3] PCI/MSI: Clarify the IRQ sysfs ABI for PCI devices
Date:   Wed, 25 Aug 2021 18:26:33 +0800
Message-Id: <20210825102636.52757-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>


/sys/bus/pci/devices/.../irq has been there for many years but it has never
been documented. This patchset is trying to clarify it.

-v3:
  - Don't attempt to modify the current behaviour of IRQ ABI for MSI-X
  - Make MSI IRQ ABI more explicit(return 1st IRQ of the IRQ vector)
  - Add Marc's patch of removing default_irq from the previous comment to
    the series.
  Note patch 3/3 indirectly changed the code of pci_restore_msi_state(),
  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c is the only driver
  calling this API. I would appreciate testing done from this driver's
  maintainers.

-v2:
  - split into two patches according to Bjorn's comments;
  - Add Greg's Acked-by, thanks for reviewing!
  https://lore.kernel.org/lkml/20210820223744.8439-1-21cnbao@gmail.com/

-v1:
  https://lore.kernel.org/lkml/20210813122650.25764-1-21cnbao@gmail.com/#t

Barry Song (2):
  Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry
  PCI/sysfs: Don't depend on pci_dev.irq for IRQ entry

Marc Zyngier (1):
  PCI/MSI: remove msi_attrib.default_irq in msi_desc

 Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
 drivers/pci/msi.c                       | 12 +++++-------
 drivers/pci/pci-sysfs.c                 | 23 ++++++++++++++++++++++-
 include/linux/msi.h                     |  2 --
 4 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.8.3.1

