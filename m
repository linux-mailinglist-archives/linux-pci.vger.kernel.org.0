Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A5457875
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKSWLE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSWLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:04 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18038C061574;
        Fri, 19 Nov 2021 14:08:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n8so9162930plf.4;
        Fri, 19 Nov 2021 14:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=oVfWHfQ93NSK7GJnUuUHGV5hxlYSbDYnzx268qbi4wQ=;
        b=DrMbXeGjsBIOvXymVZJLXz0Ts4VKlFMQ5+D7t0BLGO+nSns99UoImMQ9dQM0V0/ta2
         r/sq4+URBIiypx6oehS67YaPhLRyyffvsT0rpxqeSnr2KqoITs3pMhUioRLhKi5lWom3
         81D2ZM2EUp2J++43GaGS0+b3uBalOb8gDQPPRgJXYTI4Ct2JPhhS75oc7Wiw26GVm9Wa
         jny0uMveQ8QfTp8Az1ufaowlqbh74o37KX0QjmhiHhH4tNIDbHcMV3CSOJJZRzdIC5ft
         lhHmgpwIt6RJbgRxCeUwO8B7qvjoS7AMGB4ihBK+9oXZ9/Gs+HPDtfXO7QvBoLLU0E2/
         A4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oVfWHfQ93NSK7GJnUuUHGV5hxlYSbDYnzx268qbi4wQ=;
        b=S4wUAUKwFEH2mciN7hlhefHr7nnEYRq7q3OWf6Qslujs78i3lSmRbX4r1iZnM96m4A
         NOUtnJ9lMgklbbXEP8CoF1V/znlBSfMeVGZX70L1oHNY66QRgYgAXyLbgq68ks26XquX
         Oj+JXwjHEWGehhDFybXDkBr/hMmsb0L+SoPMHJHrOZBo01foEooSUMSKQYJGoiKd2xPm
         rTBYQuOG0IDHKzfLIauGxySTF7ERC8TazzRHXKFquXd6Tilnln3HkEzej5qxe7cQoy3F
         mSwZjy3HSz78RZsJRLvVM6lom677IlOz0/xgYh+t2PMO2xH9c68Py6ibNhZ7o4DCk5R0
         YTBg==
X-Gm-Message-State: AOAM530fx/faRozCgr/Adugpj0rGJ7XFI8KlzMcBmGL7S/swTbipYefd
        txeM9d1ZX9LfzxQK1O6aPIrItc+yvtvJuw==
X-Google-Smtp-Source: ABdhPJy6hljmQzcSBrpyEVHVbSYVTYLUiWYEJ667fFb1TruKTPKZac2o/MSnsjCJGs1XfIEGMWjF2w==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr3814496pjb.54.1637359681068;
        Fri, 19 Nov 2021 14:08:01 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:00 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v9 0/7] PCI: brcmstb: root port turns on sub-device power
Date:   Fri, 19 Nov 2021 17:07:47 -0500
Message-Id: <20211119220756.18628-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v9  -- Simplify where this mechanism works: instead of looking for
       regulators below every bridge, just look for them at the
       bridge under the root bus (root port).  Now there is no
       modification of portdrv_{pci,core}.c in this submission.
    -- Although Pali is working on support for probing native
       PCIe controller drivers, this work may take some time to
       implement and it still might not be able to accomodate
       our driver's requirements (e.g. vreg suspend/resume control).
    -- Move regulator suspend/resume control to Brcm RC driver.  It
       must reside there because (a) in order to know when to
       initiate linkup during resume and (b) to turn on the
       regulators before any config-space accesses occur.
    -- Commit message spelling, word choice (Bjorn, Krzysztof)
    -- Refactor a small commit that was ignoring a funcs' return
       values (Bjorn).
    -- Here is a summary of this mechanism:

       If:
           -- PCIe RC driver sets pci_ops {add,remove)_bus to
              pci_subdev_regulators_{add,remove}_bus during its probe.
           -- There is a DT node "RB" under the host bridge DT node.
           -- During the RC driver's pci_host_probe() the add_bus callback
              is invoked where (bus->parent && pci_is_root_bus(bus->parent)
              is true

       Then:
           -- A struct subdev_regulators structure will be allocated and
              assigned to bus->dev.driver_data.
           -- regulator_bulk_{get,enable}() will be invoked on &bus->dev
              and the former will search for and process any
              vpcie{12v,3v3,3v3aux}-supply properties that reside in node "RB".
           -- The regulators will be turned off/on for any unbind/bind operations.
           -- The regulators will be turned off/on for any suspend/resumes, but
              only if the RC driver handles this on its own.  This will appear
              in a later commit for the pcie-brcmstb.c driver.

v8  -- Only the two binding commits and the "Change brcm_phy_stop()" commit
       are unchanged.
    -- The code has been moved to portdrv_pci.c and bus.c.  The regulators   
       are placed in bus->dev.driver_data (bus->sysdata is already occupied
       by the Broadcom PCIe).  Two functions, pci_subdev_regulators_{add,remove}_bus()
       are created to turn the regulators on/off.  The pcie_portdriver also sets
       its pci_driver methods suspend and resume when the conditions are
       right for this feature.  (Robh for suggestions, although I probably
       erred in following them).
    -- Have the root complex return 0xffffffff on accesses even when
       the link is down and the HW doesn't support such accesses (PaliR).
    -- Just call devm_bulk_regulator_get() on standard supplies; don't
       bother pre-scanning the DT for them (MarkB).

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
  PCI: brcmstb: Fix function return value handling
  dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
  dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
  PCI: Add mechanism to turn on subdev regulators
  PCI: brcmstb: Split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Add control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off WOL regulators on suspend

 .../bindings/pci/brcm,stb-pcie.yaml           |  31 ++-
 drivers/pci/bus.c                             |  67 ++++++
 drivers/pci/controller/pcie-brcmstb.c         | 209 +++++++++++++++---
 drivers/pci/pci.h                             |   8 +
 4 files changed, 277 insertions(+), 38 deletions(-)


base-commit: ee1703cda8dc777e937dec172da55beaf1a74919
prerequisite-patch-id: 0905430e81a95900a1366916fe2940b848317a7c
prerequisite-patch-id: 710896210c50354d87f6025fe0bd1b89981138eb
prerequisite-patch-id: 97d3886cb911cb12ef3d514fdfff2a0ab11e8570
prerequisite-patch-id: 241f1e1878fc177d941f4982ca12779a29feb62b
prerequisite-patch-id: d856608825e2294297db5d7f88f8c180f3e5a1f2
prerequisite-patch-id: 92bcbc9772fb4d248157bcf35e799ac37be8ee45
prerequisite-patch-id: 6f4b1aac459bb54523ade0e87c04e9d6c45bd9f5
prerequisite-patch-id: 090ee7a3112a4ecb03805b23ed10e2c96b3b34ed
-- 
2.17.1

