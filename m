Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF03317C1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 20:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCHTvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhCHTux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 14:50:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF44C06174A;
        Mon,  8 Mar 2021 11:50:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kx1so245837pjb.3;
        Mon, 08 Mar 2021 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bY74PhrcbsYLS+QDyU3MBxV+McRj9LMSdo3Kk9RWRkg=;
        b=hFZ+OV0Zfp62Rif2msJxt7slp2M6Q4APkfoZCGAmtNqchtwTavb/mwijGLNqSJinLX
         hhhPz38e3kQXh3p1DU93WGYa79aql659bp1K68ELlacKb9FdR+uZIiNHo3mO1X1/aLOp
         fzYO58wLbAzj/00Z1IXzOzoOh7QkkjspFA71ZLr0SpsITOn7qklSl9n3BmNp0xyjWkTZ
         QqS5QRxy0jZT5939jb8pB8OmJlWlvkHLBRbXZmhlQDZUqeTgSsNeK2eoLvYwfaRzKTEG
         d4nTb2QnbnNzltQ3P6id1SJYt32hygkZHPFunrbZITdCQRFJpogQkPq2F1w+pecbV7+K
         bjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bY74PhrcbsYLS+QDyU3MBxV+McRj9LMSdo3Kk9RWRkg=;
        b=l7IvpgOcqbDXpEnLMIVYu0L3E0iC7rvIOxMCdOh1yxixyHlK+qxmeSd0jAQ4bzjwQo
         Ad6o667Dv+Tws+0fSUu/Gj3ijmpBWMcEyis+C6YrJEbIXehPxZnebo9elax7lebNWVtI
         COqAxs3W+fZrdW9xOujpFkiO8BZppIhEpHhfjxaIi0e8NAzLeC0AkHC9uieyhmT9mmgl
         07yZ+y+4bYy7/OgAibcAstLhHKyM9krKbLoqycvH6HdJGcCnDpRGVEo6n6vqSblppOQQ
         NwtYl2z8ANAwem5+xmhFxHVi0fLBdHLlfhvyT8uX9XFKDp4gxcqrXU1TkMTN7upAXFr2
         khKg==
X-Gm-Message-State: AOAM533WpCW0p2Vk2d5YcOy6HgJwTOwyQ4082fjUwo6NHQkg8m2fcCH7
        6cldQxBuchk/V5boxCUb1jw=
X-Google-Smtp-Source: ABdhPJytrq6G86DLRkdh6BNezs5lPObsRvdSjg7HGEWs3wCHL+H/n3Hvj2UHf8a+2tMjllTrtiExvQ==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr501499pjb.119.1615233053241;
        Mon, 08 Mar 2021 11:50:53 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y1sm64685pjr.3.2021.03.08.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:50:52 -0800 (PST)
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
Subject: [PATCH v4 0/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Mon,  8 Mar 2021 14:50:35 -0500
Message-Id: <20210308195037.1503-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
  nPCI: brcmstb: Use reset/rearm instead of deassert/assert

 drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
 2 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.17.1

