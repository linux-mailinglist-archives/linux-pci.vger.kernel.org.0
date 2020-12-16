Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDB2DC86F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLPVmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 16:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLPVmE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 16:42:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945BC0617A7;
        Wed, 16 Dec 2020 13:41:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so7713274plx.0;
        Wed, 16 Dec 2020 13:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vhacog6KROuyOaHV1Tr5IvYiaSiTEZ/jBTR7momdi4s=;
        b=SMuMHPx/ou/Vs5E0SDjgi/9jfTQstyVjL+/103JosBLXROYFInJulUGM1xLSifrkWm
         u0upz+Wi2/wmvhBHY/w7nuj7IQ/90TzebBtmk4GFMyU9kBQbqXkYLbktsHLGZB5OThaZ
         Q4oG14rRXEg/NsAHzQm2dIjkq2+fDEWTsAnF+HKABrggyWcjMxl2+tkagWSztSfClm94
         KXRSLkglMkk1m5zxFsCOB43MOvVQAzToqCFcHr/VI9eHBjfvqqriUCTGoPAA8/aEakfd
         kTvP0q36lAINMlooUISU/HrOzCi4b8vIYZpAOg9qXBbW4SQEIuvn3EL6GzYjRaGKQ+vW
         I3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vhacog6KROuyOaHV1Tr5IvYiaSiTEZ/jBTR7momdi4s=;
        b=KtBTJz75/3H2zTF2EmOvG0F1ocjcudHTWB5T5l+15tB+SOA5vZ9GKXVikJwwkPvcgx
         ieGKLWZ5TNNb3fJjm2xytCm7JBVd+ABBOTKU7Po53ycksKrbkOMqIYcxgNSJKICJWiLR
         dro+4YqH5GqCNZELDOfCkyq4/e3lQYGiD3ep7fHzYgWz+20doWcE5qCF1Z85jUKpUwLH
         AWwLNUVoxvtg/e+7FJWBn308TYN/GXMXkn69qZXbq215/AWU5JRNWKk3aG7PZYg2gtBB
         SMx7dsMKdzy9j0yEtHQTmjZ3UFLXqIJeHcS6gkJIevJfpagTiOuBkerb8ZmUfDRGdCKp
         UTNw==
X-Gm-Message-State: AOAM530NxzwFkShLdbuurnph5sjjPetnZTnC18o9/yL2B5Nuv8wvgcbg
        We2+dqnIyiOJ00KXV6vTX8c=
X-Google-Smtp-Source: ABdhPJw1lb1XyiwPYoN7f38+SCpOt5IXR9Tx93iWOB10VFZ3A7Q/VWdIc2y7/gQlCmEFRhWl/EexXQ==
X-Received: by 2002:a17:90b:1249:: with SMTP id gx9mr4870853pjb.146.1608154883571;
        Wed, 16 Dec 2020 13:41:23 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h12sm3612237pgf.49.2020.12.16.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 13:41:23 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
X-Google-Original-From: Jim Quinlan <james.quinlan@broadcom.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 0/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Wed, 16 Dec 2020 16:41:03 -0500
Message-Id: <20201216214106.32851-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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


[1] Applied commit "reset: make shared pulsed reset controls re-triggerable"
    found at git://git.pengutronix.de/git/pza/linux.git
    branch reset/shared-retrigger

Jim Quinlan (2):
  ata: ahci_brcm: Fix use of BCM7216 reset controller
  PCI: brcmstb: use reset/rearm instead of deassert/assert

 drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
 2 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.17.1

