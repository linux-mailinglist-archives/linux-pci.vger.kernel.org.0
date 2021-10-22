Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523374378AE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhJVOJj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhJVOJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35CC061764;
        Fri, 22 Oct 2021 07:07:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f5so3390892pgc.12;
        Fri, 22 Oct 2021 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/agOmz3U1kToZEfpYBZeBgjrCZIKo2iOjjILiNmM8SI=;
        b=d3sxm3/W05ryib4Gky/py2cbH7wU13kNcndQ+arph/+tRLtrUST0ILkziVU5hRxdFL
         tFkN2D9lSgK0UdB04rd4/e6nrWxa+ctJ31FRpvMB7NugBGNVBuACNtzAtpdOAIp1xk21
         lFP8iGhBKr/1dU1KB37z+MQ4rbY9WxnDCFYaUygZm/6W69Hrf2qpo7w7aN7/HCFWVk3r
         tx2er1jnuRbGsrKXsBbTGSNCw+/o48o0zckbQ2sHe7JSfd9zn1/mom01ueO+1JRFdMqz
         pjQtYoOYwbgzyNqh8uafiDxRwJdVMzaCvMOpABzEkRdLb8EGgeD55xdoxY3ddqWsvjeH
         AXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/agOmz3U1kToZEfpYBZeBgjrCZIKo2iOjjILiNmM8SI=;
        b=D6enRBDG0ZuPrSDgiuL3rZFloyptC06bdbXdd0l2HgdLvO6HFYdIOzc1ecEgjoVN1a
         8R3d6CBocGeju42e6DV9RQuhV7ob3yEOhu/45a+WCkXxvTnu94RmpowyNQe1arTLgRHL
         MK1x8+fGZefSFZijsm7Fm7bf4fkeFo8TF4KlVxQXE1Po+V3PuGn4Cr4fPDuHAf1jLooM
         Wo+AjUwiAZ6JsbmOLb08E1Pl2KJscSlPYuoGwQ2TqF3+g02NTGVJ8OpXK8WLI1DggkCM
         2D8MYHLp90P1n83Gv/QTX1J1mUXGDubJNNi95mkw5OxooGekU08ZJ0RMogoQoPwDVfG4
         56cg==
X-Gm-Message-State: AOAM533afWKl5n6e6p94nfQDTr8ckK25kwbv352I1HoDE2gpFyS+l2nE
        q+R97MLH0QHBOpCW/B2WV7ZfdhzqjSu7cA==
X-Google-Smtp-Source: ABdhPJzhIgzFcIrVWCevrBOk6am7e3ctM7HrhXOX6Kb2DYJntrfUXK6b1J+DZKiZ++UxKQu4kB7wyw==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr9514pgu.82.1634911640310;
        Fri, 22 Oct 2021 07:07:20 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:19 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Claire Chang <tientzu@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/6] PCI: brcmstb: have host-bridge turn on sub-device power
Date:   Fri, 22 Oct 2021 10:06:53 -0400
Message-Id: <20211022140714.28767-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v5 [NOTE: It has been a while since v4.  Sorry]
     -- See "PCI: allow for callback to prepare nascent subdev"
        commit message for the cornerstone of this patchset
        and the reasons behind it.  This is a new commit.
     -- The RC driver now looks into its DT children and
        turns on regulators for a sub-device, and this occurs
	prior to PCIe link as it must.
     -- Dropped commits not related to the focus of this patchset.

v4 [NOTE: I'm not sure this fixes RobH and MarkB constraints but I'd
          like to use this pullreq as a basis for future discussion.]
   [Commit: Add bindings for ...]
     -- Fix syntax error in YAML bindings example (RobH)
     -- {vpcie12v,vpcie3v3}-supply props are back in root complex DT node
        (I believe RobH said this was okay)
   [Commit: Add control of ..]
     -- Do not do global search for regulator; now we look specifically
        for the property {vpcie12v,vpcie3v3}-supply in the root complex
	DT node and then call devm_regulator_bulk_get() (MarkB)
     -- Use devm_regulator_bulk_get() (Bjorn)
     -- s/EP/slot0 device/ (Bjorn)
     -- Spelling, capitalization (Bjorn)
     -- Have brcm_phy_stop() return a void (Bjorn)
   [Commit: Do not turn off ...]
     -- Capitalization (Bjorn)
   [Commit: Check return value ...]
     -- Commit message content (Bjorn)
     -- Move 6/6 hunk to 2/6 where it belongs (Bjorn)
     -- Move the rest of 6/6 before all other commits (Bjorn)

v3 -- Driver now searches for EP DT subnode for any regulators to turn on.
      If present, these regulators have the property names
      "vpcie12v-supply" and "vpcie3v3-supply".  The existence of these
      regulators in the EP subnode are currently pending as a pullreq
      in pci-bus.yaml at
      https://github.com/devicetree-org/dt-schema/pull/54
      (MarkB, RobH).
   -- Check return of brcm_set_regulators() (Florian)
   -- Specify one regulator string per line for easier update (Florian)
   -- Author/Committer/Signoff email changed from that of V2 from
      'james.quinlan@broadcom.com' to 'jim2101024@gmail.com'.

v2 -- Use regulator bulk API rather than multiple calls (MarkB).

v1 -- Bindings are added for fixed regulators that may power the EP device.
   -- The brcmstb RC driver is modified to control these regulators
      during probe, suspend, and resume.
   -- 7216 type SOCs have additional error reporting HW and a
      panic handler is added to dump its info.
   -- A missing return value check is added.

Jim Quinlan (6):
  dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
  PCI: allow for callback to prepare nascent subdev
  PCI: brcmstb: split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Add control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off regulators if EP can wake up
  PCI: brcmstb: change brcm_phy_stop() to return void

 .../bindings/pci/brcm,stb-pcie.yaml           |  23 ++
 drivers/base/core.c                           |   5 +
 drivers/pci/controller/pcie-brcmstb.c         | 231 ++++++++++++++++--
 drivers/pci/probe.c                           |  47 +++-
 include/linux/device.h                        |   3 +
 include/linux/pci.h                           |   3 +
 6 files changed, 286 insertions(+), 26 deletions(-)

-- 
2.17.1

