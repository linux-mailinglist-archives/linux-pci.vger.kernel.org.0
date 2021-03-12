Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE733989A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhCLUqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhCLUqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 15:46:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD3C061574;
        Fri, 12 Mar 2021 12:46:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id bt4so5723151pjb.5;
        Fri, 12 Mar 2021 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uyc93HGp2D/EW62YXel9R0cKe9c26VfmUeDhxPO+GF8=;
        b=csVc7H2US6vnNfcX0dEhVrz8kERcIVoSS0k6v78mdzUlTK0RzKMZY1ugJ65i64vB2w
         G4HiRKSxsJU8B0zbcJoD1324xlBSOAkVbJWjD7VjTumOJCI4w+s5eZZyJqP7hEF+1hai
         jOsFRMwzI1FmIdyRnb4sgGoAlPq0nWxD0tyPWZ2iBgshZSqY2mds9bW2RG4/WkVTtysZ
         c+52UlHZ3XHMs+AzKukOPvfYuJ2H5XpKp8F6AnctbjORsv8FhMnKTVh3WIPgje3BsFFN
         wrI41O0Do9EFMnIE4kvSWVt1l9Ip/5peAxHgwNjbOFTdQyMQJEchZQknGaalc5XaZWqx
         RAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uyc93HGp2D/EW62YXel9R0cKe9c26VfmUeDhxPO+GF8=;
        b=O4f6R/lhn3ZT8Z2TStufub+T8bciv8wmZ9ewqITkc2n69qrd251um2H0cZpfzBigt8
         tifyOkY+lh6APZy3++C4OQZtIYIL21KLbw2671wIBhzcAAgdpqfNpXF5oJBp9kAdeiUy
         nVdU+1H7PjSorKHl8V5/DuxHiVGFt5TFBUJhuALLHxiVnYBjCSZ/GsCeuioVE4S7B+0Z
         HTr0CoiQBKhKkFTWMBVaIp/AXWGOp7ypqsabW9ILqge95H9aqb8qeoC/pBgCtXdvObws
         YH155hjdXqPyKrTecv1rt4g9znYKltMoJWMXmd3NSiDaqB2r/fYa5HnJnoBDH5x46b6y
         Lo8g==
X-Gm-Message-State: AOAM533cVglDriSQEoWNofntTHOUjB7lCrFhf59FdMH9CBvChVAsNgbF
        ObYivVwOe+4/69LPYh5rY6A=
X-Google-Smtp-Source: ABdhPJwjWkwtxqes8zJU1+Jj3IFTZRU9ZV/TeHdE9HfbWT5/b3A/w3czHqQ20VOVF9svtYAUX6zPMA==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr157306pjs.38.1615581973426;
        Fri, 12 Mar 2021 12:46:13 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i22sm2959613pjz.56.2021.03.12.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:46:12 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 0/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Fri, 12 Mar 2021 15:45:53 -0500
Message-Id: <20210312204556.5387-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v5 -- Improved (I hope) commit description (Bjorn).
   -- Rnamed error labels (Krzyszt).
   -- Fixed typos.

v4 -- does not rely on a pending commit, unlike v3.

v3 -- discard commit from v2; instead rely on the new function
      reset_control_rearm provided in a recent commit [1] applied
      to reset/next.
   -- New commit to correct pcie-brcmstb.c usage of a reset controller
      to use reset/rearm verses deassert/assert.

v2 -- refactor rescal-reset driver to implement assert/deassert rather than
      reset because the reset call only fires once per lifetime and we need
      to reset after every resume from S2 or S3.
   -- Split the use of "ahci" and "rescal" controllers in separate fields
      to keep things simple.

v1 -- original

Jim Quinlan (2):
  ata: ahci_brcm: Fix use of BCM7216 reset controller
  PCI: brcmstb: Use reset/rearm instead of deassert/assert

 drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
 2 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.17.1

