Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADF44488E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhKCSwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCSwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CD4C061714;
        Wed,  3 Nov 2021 11:49:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so2111958pje.0;
        Wed, 03 Nov 2021 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3TUt2HAWz62F5Cjx111xJfglPvqm3GTWL2L9Knx1dck=;
        b=JHwZYdJqKRnTc44EBfVUZOT/kAGAK0crYduiqYGonc+MCsF6NFKfm7j+BpBok+3N7u
         0gFQECVu2oeMclysYC1qQpve7oQlQ70+eugKMA7f+UFQd7/jYcyW6q6zlTUGDMwtWwsN
         LutWqjBiVcQT7n7rEaXf5DEcZ5JiDSlg5V4puW/xEAQBGn4GSIHiVtfckHzTGBhzrd7f
         5NdsJbHp9QcUJIPzoUuxLlwGOLnJZGze6cn0hBLGkyaxnjON0vZPIsWNlc4u5rwAe6tB
         /hajt2DTRzYEe5jyAckGcVQgX5SGgjuReBVN6lF4XBtgs93ckRgCbfmrf/aVZs6rcfKX
         88Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3TUt2HAWz62F5Cjx111xJfglPvqm3GTWL2L9Knx1dck=;
        b=Hs+eIB/Mbjk1x39c/rfGjNFiFNkDRCzMsIOXvluPXBB4A65kk78i5WV+abnHHR6J2x
         fGlr1g3CXQ/VaktahZofABeOwIzgyla4EP7TBKF7/G4EQ2Pm2dZY9VfKYDrJnwwcJi/c
         9tZEZPGXhvk2X3LFh40xCTJHxavmlZcdES6RmaUiKsEHkvLwy1YHF7SmVbhXje5IkWI7
         LUZR5m/Ue3yaan4tJksJ7Ks5q6D6m8Ax4ELnlRqmqTm9ZnX8Td5gKpkWLwA8F98L0Qzw
         4VPa+ZFQ/KdIkjZI99vNGJCctJqHFywzphNExr1ffvFeORUvrWS+epObVfG+Y/LHSboR
         +iow==
X-Gm-Message-State: AOAM5328jNtRDsi07Er5sIGAYSBaZ83IMMnixv0DYrVlMeg1bRuMqWJS
        41luTH0M3HlbJVj0UX+4cKkkNSFtQo2n6g==
X-Google-Smtp-Source: ABdhPJxeWVpSrOhvFAtC0Ejv/vDroGUJizuSgT94TfsRd7f61drsrbu0QQsJelUeBxhgK5EYEQL1/A==
X-Received: by 2002:a17:902:900c:b0:13f:974c:19b0 with SMTP id a12-20020a170902900c00b0013f974c19b0mr39501804plp.12.1635965385874;
        Wed, 03 Nov 2021 11:49:45 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:45 -0700 (PDT)
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
Subject: [PATCH v7 0/7] PCI: brcmstb: have host-bridge turn on sub-device power
Date:   Wed,  3 Nov 2021 14:49:30 -0400
Message-Id: <20211103184939.45263-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v7  -- RobH suggested putting the "vpcixxx-supply" property under the
       bridge-node rather than the endpoint device node.  Also, he said to
       use the pci-ops add_bus/remove methods.  Doing so simplifies the
       code greatly and three commits were dropped.  Thanks!

    -- Rob also suggested (I think) having this patchset be a general
       feature which is activated by an OF property under the bridge node.
       I tried to do that but realized that our root complex driver
       controls the regulators with its dev_pm_ops and there is no way to
       transfer this control when using general mechanism.  Note that
       although the regulator core deals with suspend, our RC driver wants
       the right to sometimes to preclude this for WOL scenarios.

    -- One commit was added to change the response to the return value of
       the pci_ops add_bus() method.  Currently, an error causes a WARNING,
       a dev_err(...), and continues to return the child bus.  The
       modification was, for returning -ENOLINK only, to skip WARNING &
       dev_err() and return NULL.  This is necessary for our RC HW, as if
       the code continues on it will do a pci_read_config_dword() for the
       vendor/id, and our HW flags a CPU abort (instead of returning
       0xffffffff) when the is no pcie-link established.

       [NOTE: MarkB, I did not add one of your two "Reviewed-by"s
              because the commit had a decent amount of change.]

v6   -- Dropped the idea of a placeholder regulator
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

Jim Quinlan (7):
  dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
  dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
  PCI: brcmstb: Split brcm_pcie_setup() into two funcs
  PCI: pci_alloc_child_bus() return NULL if ->add_bus() returns -ENOLINK
  PCI: brcmstb: Add control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off regulators if EP can wake up
  PCI: brcmstb: Change brcm_phy_stop() to return void

 .../bindings/pci/brcm,stb-pcie.yaml           |  31 ++-
 drivers/pci/controller/pcie-brcmstb.c         | 233 ++++++++++++++++--
 drivers/pci/probe.c                           |   3 +
 3 files changed, 250 insertions(+), 17 deletions(-)


base-commit: 8e37395c3a5dceff62a5010ebbbc107f4145935c
-- 
2.17.1

