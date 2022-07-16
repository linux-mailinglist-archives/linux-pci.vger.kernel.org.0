Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5985771C9
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiGPWZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPWZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275D1C90D;
        Sat, 16 Jul 2022 15:25:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 23so7471232pgc.8;
        Sat, 16 Jul 2022 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DD9+PSwr6U6sHyRODEYS90F8ToJiRT1Fstf8yvbN2dY=;
        b=mOlGlmoVlrkAh9J+MareGX9X6NFNX2mFkM9+DhYHDooKBT3BQ03XwCuHddQ1xI9mK9
         2VH7LIDVqSZwM/OTIAIonH+ZMG9ikVqRWRfNS1n78mAIhOki8satfZoFeRgs7ecQKHKb
         8rJy6Obg7vjLSt13yyw91WgR7S9llNj7T53GI1iSrCz3fhPhIOupeKZXmMp3OsE4BLsv
         t3CjRhcTCx1f9+PAvD9NfoRl1Ox6gAsEs1wqlgk2gzwiTNI9MgHQ6ds73rZpmzWbc0pD
         DDz0z2xvMsGuz2DmQF5EWDMJYah3Wb1nwQDrRxzcqCQZS6iPUq5e3cM7OM18gfFaIGow
         hXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DD9+PSwr6U6sHyRODEYS90F8ToJiRT1Fstf8yvbN2dY=;
        b=j0dTGE3yTkssP8RthcToCDjVvJnI2AY5CIT8KpVH9Rv4hrnFUTsdMLHc/xVZNV8uQ9
         ncrdegNyF8K1lfbc9qo/I55OLM3kQ7ukX0ogY6YeTTlTlQIsDPPKe942CvwNxoBAwY0r
         N7H5fJmb62HxQSD2u8RLecpEvaBvmFetHm0kUOOZXB8dQDoRpSs6cVSm0JEUTUlst/QU
         klBHoDb6DjUYk5TmkeRQo9HgkpQ5UFvXYuUFL7n+Ovz4XPD/97d3BdGVvyp23xO0jWI0
         l4k14Spk2co0n8TRBiL00oKbhI74XUz1Impjs3TzKY81RIpZSkjoIyCqCg++enZSmO0B
         V+dA==
X-Gm-Message-State: AJIora9BN5nn5TMa3s//5lH2GA48fSn6PE2g6AwPMS0nq5r3MC50zd20
        FqRGj9111C0lSzNUdy/TmAyGvdalyO4=
X-Google-Smtp-Source: AGRyM1sevGz6TvgsR/3v2+nd0Kl/YAE4nAjg1/EV+OylXhhmE0kDW8PJjvm3WkoXnlHg1yki3Nb80Q==
X-Received: by 2002:a63:4c05:0:b0:419:78b2:d775 with SMTP id z5-20020a634c05000000b0041978b2d775mr18068145pga.62.1658010300468;
        Sat, 16 Jul 2022 15:25:00 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:00 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/6] PCI: brcmstb: Re-submit reverted patchset
Date:   Sat, 16 Jul 2022 18:24:47 -0400
Message-Id: <20220716222454.29914-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

V2  -- As v1 included the minimal code to fix a regression.  v2 does
       the same but adds some improvements suggested by Bjorn.
    -- In the unlikely but possible case that some other driver
       starts using the port driver's dev_data field, do not overwrite
       it but issue an error and return.
    -- Functions probe() and resume() do similar operations but
       did them in a different order; make this order consistent
       for both.
    -- New commit to remove forward declarations.
    -- New commit for only the PCIe config-space access "refusal mode".
    -- brcm_pcie_linkup renamed to brcm_pcie_start_link
    -- Add '_noirq' to the brcm_pcie_{suspend,resume} function names
       to match the dev_pm_ops names.
    -- Changes to commit messages:
           o Explain why we are splitting a function in two parts.
           o s/RB/Root Port/

    NOTE for Bjorn: The two commits "add mechanism .." and "add control ..."
        would probably be more clear if they were squashed.  They are kept
        separate as the first one's code may someday be moved under the Port
        driver.  As such, there's some churn.

    NOTE for Bjorn: There is no hurry on Broadcom's side wrt which
        release cycle/phase this patchset is applied.  It goes in
        when you think it is ready.

V1 -- Resubmission of patchset after original was reverted for a
    regression.

    A submission [1] was made to enable a PCIe root port to turn on
    regulators for downstream devices.  It was accepted.  Months later, a
    regression was discovered on an RPi CM4 [2].  The patchset was reverted
    [3] as the fix came too late in the release cycle.  The regression in
    question is triggered only when the PCIe RC DT node has no root port
    subnode, which is a perfectly reasonsable configuration.

    The original commits are now being resubmitted with some modifications
    to fix the regression.  The modifcations on the original commits are
    described below (the SHA is that of the original commit):

    [830aa6f29f07  PCI: brcmstb: Split brcm_pcie_setup() into two funcs]
        NOTE: In the originally submitted patchset, this commit introduced a
        regression that was corrected by a subsequent commit in the same
        patchset.  Let's not do this again.

        @@ -1411,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
            if (ret)
                    goto fail;

        +       ret = brcm_pcie_linkup(pcie);
        +       if (ret)
        +               goto fail;


    [67211aadcb4b  PCI: brcmstb: Add mechanism to turn on subdev regulators]
        NOTE: Not related to the regression, the regulators must be freed whenever
        the PCIe tree is dismantled:

        @@ -507,6 +507,7 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)

        if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
                    dev_err(dev, "failed to disable regulators for downstream device\n");
        +       regulator_bulk_free(sr->num_supplies, sr->supplies);
            dev->driver_data = NULL;


    [93e41f3fca3d  PCI: brcmstb: Add control of subdevice voltage regulators]
        NOTE: If the PCIe RC DT node was missing a Root Port subnode, the PCIe
        link-up was skipped.  This is the regression.  Fix it by attempting
        link-up even if the Root Port DT subnode is missing.

        @@ -503,11 +503,10 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)

         static int brcm_pcie_add_bus(struct pci_bus *bus)
         {
        -       struct device *dev = &bus->dev;
            struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
            int ret;

        -       if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
        +       if (!bus->parent || !pci_is_root_bus(bus->parent))
                    return 0;

            ret = pci_subdev_regulators_add_bus(bus);

    [1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
    [2] https://bugzilla.kernel.org/show_bug.cgi?id=215925
    [3] https://lore.kernel.org/linux-pci/20220511201856.808690-1-helgaas@kernel.org/

Jim Quinlan (6):
  PCI: brcmstb: Remove unnecessary forward declarations
  PCI: brcmstb: Split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Add "refusal mode" to preclude PCIe-induced CPU aborts
  PCI: brcmstb: Add mechanism to turn on subdev regulators
  PCI: brcmstb: Add control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off WOL regulators on suspend

 drivers/pci/controller/pcie-brcmstb.c | 438 +++++++++++++++++++-------
 1 file changed, 332 insertions(+), 106 deletions(-)


base-commit: c5fe7a97f20c7f3070ac870144515c0fabc6b999
--
2.17.1
