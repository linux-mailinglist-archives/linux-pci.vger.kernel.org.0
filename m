Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDF4403B2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhJ2UFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2UFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:05:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65DFC061570;
        Fri, 29 Oct 2021 13:03:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v1-20020a17090a088100b001a21156830bso11426815pjc.1;
        Fri, 29 Oct 2021 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=CD0Ppn2nedztgflSM0GT6miv660hCRYTlpvYGrTEVmc=;
        b=c40Rae/wnHyVhugcgh192ae3Q6rIm71vIlXZyddZ+BApyZvnhsj2KW21ZIoxspIbNB
         NfIOUjrGjI3T4v6U0yPoUfT9ZEJrWUO5ErGsnx3iu9TbBOWeKtgEXJ+BW2deeO03elW9
         Sg9QV2srOzOUbmEiP2CuEHjaxcNJE6yiuMTW1jVYKMgNgfMpbsVyYRsKPVlN8C0fyhch
         lKRk1OoLddxC395H1BiT2gHTncnp6mJtXgVJ9otaG9fChs2jOQ0t0mdeqRH8tOTzkxho
         Nsgc9WKY55PEqSmEDXNDgyPYYh75S5ipXfkoUoxdvPVy8BljWMePEGCmy/FDzJu2kfWu
         2Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CD0Ppn2nedztgflSM0GT6miv660hCRYTlpvYGrTEVmc=;
        b=TPmzCDNh+SokN8rr08pU6vWTk6xpOKgVon095wrBr4VllyTezWYHRVxzZVOPnNVea9
         lD7dWFTLEfXatZV0r+1CSuGAfglWYwET7lrfEUDhwU6cwTIdXj9CCjVIoCzuMzqgW5En
         JsYmM1OlsZ+/qg2vERXsoLb7ELzyOcCHGgXKGBpeimxgTEeAcs55bsucqZW+ArC0HSOK
         NuCU+6gfgQpgOh05c3X4Ek/y+25O8nNqzR8YeD6zUN7kBaZ64gvUFeJSPvxdzu6LKI1v
         Z+gAHxOzeBs6j4lVdPQbkrkU7NTH8PEHZXtXk25G452TTZGWZnYc0wzTu34rsbkmKuTQ
         lYtA==
X-Gm-Message-State: AOAM533yTkyzBRgdrpSPDkwkBdFckriLZGQSUNn8fB4+T6MJJDB3rhuC
        usonl1u43Jn29qGI5qSShmh0Scel3L/RJA==
X-Google-Smtp-Source: ABdhPJy/KfEnayPUU1Tvi9Lcz5RXzn6GtjdRqeUCch1RvSVVaIRIZN0uDw8aiq9PZTcYhoO8Aq09Cw==
X-Received: by 2002:a17:90b:1bd1:: with SMTP id oa17mr13380789pjb.26.1635537804185;
        Fri, 29 Oct 2021 13:03:24 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:23 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v6 0/9] PCI: brcmstb: have host-bridge turn on sub-device power
Date:   Fri, 29 Oct 2021 16:03:08 -0400
Message-Id: <20211029200319.23475-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v6
     -- Dropped the idea of a placeholder regulator
        property (brcm-ep-a-supply). (MarkB)
     -- device_initialize() now called once.  Two
        commits were added for this.  (GKH)
     -- In two cases, separated a single function 
        into two or more functions (MarkB)
     -- "(void)foo();" => "foo()".  Note that although
        foo() returns an int, in this instance it is being
	invoked within a function returning void, and foo()
	already executes a dev_err() on error. (MarkB)
     -- Added a commit to correct PCIe interrupts in YAML.
     -- Removed "device_type = "pci";" for the EP node
        in the YAML example.
     -- Updated the URL related to the voltage regulator
        names on GitHub.  Note that I added vpciev3v3aux.

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

Jim Quinlan (9):
  dt-bindings: PCI: correct brcmstb interrupts, interrupt-map.
  dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
  PCI: move pci_device_add() call
  PCI: separate device_initialize() from pci_device_add()
  PCI: allow for callback to prepare nascent subdev
  PCI: brcmstb: split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Add control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off regulators if EP can wake up
  PCI: brcmstb: change brcm_phy_stop() to return void

 .../bindings/pci/brcm,stb-pcie.yaml           |  35 ++-
 drivers/pci/controller/pcie-brcmstb.c         | 243 ++++++++++++++++--
 drivers/pci/iov.c                             |   1 +
 drivers/pci/probe.c                           |  61 +++--
 include/linux/pci.h                           |   4 +
 5 files changed, 308 insertions(+), 36 deletions(-)

-- 
2.17.1

