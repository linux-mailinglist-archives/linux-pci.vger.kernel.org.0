Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7744CC5D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhKJWU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhKJWUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA4C0797B7;
        Wed, 10 Nov 2021 14:15:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so2662875pjb.1;
        Wed, 10 Nov 2021 14:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=69vMvvE2cprNe4+bCiFoRLb6bmwjY4O5LSR5eyVyxtI=;
        b=FnWLG98Sg6NoaNxwSaRE7rrdeXVTHwafp6jwu32Dn4Fw0vO3kjnHvfxDZKBDnMzxMI
         EBGmaWZgSLYc6Hz5QTcMFNX744hpWVY2JsFLeqycsME8oQtqkq5mZ6kgazjsWmx76NCX
         zuC3ZI9yH2n5t2BHJBPRtNtZNXTLzFm3Pj+emIg4r3Sher0EN76wHikhg2YQg3RdmQAG
         G/3vkUEZoZLpuvMGtfqZWIBXhbJjUyC9YNXfsOYnGB2+f3oGgxVVAUW5Ol0k4ztviECi
         wIBz+SapqRBJCXMmLtMfq23oI0Z3v++tF/YXKb7glgRIb9v7jF4VmSVA96Pg4M+Jc72Y
         mmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=69vMvvE2cprNe4+bCiFoRLb6bmwjY4O5LSR5eyVyxtI=;
        b=EeYn/Q5UA4klXIkZzkEZxk7Jq5TeB2RrwbNR5m/OILVQMMNejryIO1PwUS5e+exEZq
         h9CmkMMNsLBFRJMJjBQwgpxLA4xKQ/Fag8S8f8T5llPwxWnPYdG0t3BNAK+/UWWGxASc
         /jGADOgZ+UAXFq/J49U5ESTymzIz2jpiNAzvSO/yR2MbMrTwSpjJf0VAbVaqstV6J489
         Jsuy5Vbi5qEBGUw26FUQdoIprxLAH1N4zmTLBlo4BBPVFeygDurxVLT6lIu712TdDNv8
         q/V5wFYgnaRJkwVugV55kAKXEinHN51pY5q/j9055E3AcbkdzUv3CYN2p4UqOcIpPcfG
         6J8g==
X-Gm-Message-State: AOAM532nTuD+GXInxdZyClvLikrjnAFRPkN0L1G8xJ3RNnAQPOUvOD9R
        5dt3iK/C+8+28jT30/T0CTKKpJCDNBAKrg==
X-Google-Smtp-Source: ABdhPJyx9o2LWwNRlvv5wGQyKHWHi7P+VZuHbxhkQ/ott356kWzisQeAWsRR2vaij5T4IGBmAZCIXQ==
X-Received: by 2002:a17:90a:db89:: with SMTP id h9mr2709388pjv.71.1636582502766;
        Wed, 10 Nov 2021 14:15:02 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:01 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <kbusch@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 0/8] PCI: brcmstb: have portdrv turn on sub-device power
Date:   Wed, 10 Nov 2021 17:14:40 -0500
Message-Id: <20211110221456.11977-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v8  -- Only the two binding commits and the "Change brcm_phy_stop()" commit
       are unchanged.
    -- The code has been moved to portdrv_pci.c and bus.c.  The regulators   
       are placed in bus->dev.driver_data (bus->sysdata is already occupied
       by the Broadcom PCIe).  Two functions, pci_subdev_regulators_{add,remove}_bus()
       are created to turn the regulators on/off.  The pcie_portdriver also sets
       its pci_driver methods suspend and resume when the condirtions are
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

Jim Quinlan (8):
  PCI: brcmstb: Change brcm_phy_stop() to return void
  dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
  dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
  PCI/portdrv: Create pcie_is_port_dev() func from existing code
  PCI/portdrv: add mechanism to turn on subdev regulators
  PCI/portdrv: Do not turn off subdev regulators if EP can wake up
  PCI: brcmstb: Split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Add control of subdevice voltage regulators

 .../bindings/pci/brcm,stb-pcie.yaml           |  31 ++++-
 drivers/pci/bus.c                             |  72 ++++++++++
 drivers/pci/controller/pcie-brcmstb.c         | 131 +++++++++++++-----
 drivers/pci/pci.h                             |  11 ++
 drivers/pci/pcie/portdrv_pci.c                |  86 +++++++++++-
 5 files changed, 292 insertions(+), 39 deletions(-)


base-commit: 8e37395c3a5dceff62a5010ebbbc107f4145935c
-- 
2.17.1

