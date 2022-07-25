Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E492580175
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiGYPQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiGYPPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:15:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A45419293;
        Mon, 25 Jul 2022 08:13:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so10678440pfb.13;
        Mon, 25 Jul 2022 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vClZEDHW/p/nRPc4T2OtKWpsEU80qB0nIfVJ1m6OHYg=;
        b=PiD+kKPGc4Pm9OcZQZJwoMV3H+yXJCQjYhEzcQJJYC2lKA2LyX9CNLTurlguPmz/BD
         N6jJGH0qORg74v0B7iaS52QPlrLohHdqbARsv1KrPjuEX575/HlU3fgBxP9rFn1JbFOs
         8LfPqUSH7qL0BbkY5LU6M3Sn/vOCsV6x+GZVbLdEMSTeBtcTAnhTskxx7QraJKs8x/1M
         uvD6mEzN6OF4vfBD64EOdKSwRoyUuB+o/uvthi8MgGPBX/Iq31tZlASDKPHnb5rh8SWo
         WgFLYdUvp127aYedetMr5vIlqH5JjOrCpCIwlHHitnTIYGE1ijc2cLnR5hTuaV2POFBr
         2auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vClZEDHW/p/nRPc4T2OtKWpsEU80qB0nIfVJ1m6OHYg=;
        b=kAktalVQBkQtaSJCSgIsMxK7DfujsAZ8s+gYN7It+9Z2UWobHDbU9An6xMGfycd3Sg
         XywOwRxaDOCxtypI/Li9agmnhUlX1W509uJ65p9bqDp6E0iQyiYebCpjfAieItHvCmyJ
         QpficXOdN2iJvhUb27M9ZTz9TpztXH5djJjMzD0ZDLAz6DiZPKoNoPk6VVvUEXJGxFy2
         plWMOYHHnOEM5nPFuxPnGyJt9lyVuintEU+VE+nHFTmVj4Ay/i3WiVhlap2QFyDtnnrL
         y/UO3LhjlfaepX9kvXWsQPwW50feQjdo/b+RxOh72Xy+jsC3PsTL11Y+K9EXkWvxiz+s
         UAUw==
X-Gm-Message-State: AJIora8jHgcHVtmU51+t4u7h8UsxvKXg630XRNrJOldYmr6I9Mx/p40I
        TnEk7m04BskUgZpNms5of582AUjEsT8=
X-Google-Smtp-Source: AGRyM1sODvWco/wy/JwP4+nnbMCuyaPj/uRKlViVYr6xlq2RO9aNdFighhUzr9JC6hRduAn8/tZWMA==
X-Received: by 2002:a63:4e09:0:b0:412:1ba3:672a with SMTP id c9-20020a634e09000000b004121ba3672amr11728676pgb.597.1658762000782;
        Mon, 25 Jul 2022 08:13:20 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:19 -0700 (PDT)
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
Subject: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
Date:   Mon, 25 Jul 2022 11:12:49 -0400
Message-Id: <20220725151258.42574-1-jim2101024@gmail.com>
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

v3 -- Replaced "refusal mode" commit with one that gates config
      space accesses based on link status (Bjorn)
   -- Restrict the brcm_pcie_start_link() code to only those things
      related to link-up and put the rest in brcm_pcie_setup()
   -- Added commit to change map functions to end with 'map_bus' (Bjorn)
   -- s/0x060400/PCI_CLASS_BRIDGE_PCI_NORMAL/ (Pali)
   -- Limit config space accesess to 4k window.
   -- Remove wording in a commit message that said the regulators
      could be endpoint power supplies

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


Jim Quinlan (7):
  PCI: brcmstb: Remove unnecessary forward declarations
  PCI: brcmstb: Split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Gate config space access on link status
  PCI: brcmstb: Add mechanism to turn on subdev regulators
  PCI: brcmstb: Add control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off WOL regulators on suspend
  PCI: brcmstb: Have .map_bus function names end with 'map_bus'

 drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
 1 file changed, 341 insertions(+), 135 deletions(-)


base-commit: e0dccc3b76fb35bb257b4118367a883073d7390e
-- 
2.17.1

