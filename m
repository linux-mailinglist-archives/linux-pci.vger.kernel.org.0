Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA25637DD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiGAQ1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiGAQ1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:27:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9751427C0;
        Fri,  1 Jul 2022 09:27:29 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c137so2195854qkg.5;
        Fri, 01 Jul 2022 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JJ7doVRZNwpC70V4XQcn4y7lc0hc/wFbR+0jLkxn3As=;
        b=bd2+z6vZUICl18680/QipZAbBDdU3y+PmJKXBAXU2hDYUvn9+suNyVPOHRHqeNE/SE
         f45lcn031T4CgSDV4bNGnm8Va7kDiXTR/rDkGKin4toezdT9gymt2rJ/d/r2E8BbLrDa
         kbrU1q6qcyg3PSzd3kjohrltsRnqGqrsktkeExhrXxZOSOxtnRs+zQ1k9qzlipZy2T5w
         OSl80Pa0aNUpfzie0iLL1jd+O0ujhAF6okCv/UbUwMbe8Ay98faR71SRUwWm0dUOThAA
         9fBMGKZCx5Wy59pEq1GORASdXpFPvRKA7oyiPx0rCootpgAF1GSC3AL9b6BSzNWYGCdf
         8SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JJ7doVRZNwpC70V4XQcn4y7lc0hc/wFbR+0jLkxn3As=;
        b=lpPoZDLdKKYpJBZcl2SljsoSYdEgeL9Cd7wG/WZzmX8HxFzUXAKPM1Kl48qT0bvNED
         zSJqLV8VlsQ7YtnEqftoGJaFfKTCRXYulY3g3kuPcoGah2OWqJLQh5jm4A7vhoiTZJ4b
         xHIEXn582MbFi4Oq7Xg10Y1S4iXLdoFlOo2WOAPLGqD18obGTN0+NrISyoL9RQni1tMH
         IZsjuaJ8ELFGxXuIQ65Qhn/fog5YEZTUO8sPHorohiutJC9VbOq3DGMC6BANdggkrKcV
         leQKEpjTO4DlfHpEXP0L6hy8IkZ2FqSjmMkL9az1cJDICj0q9xezHiL32LFWliEz3W6H
         jZcw==
X-Gm-Message-State: AJIora9L6CrpyjIPy1CPkam4naaCqC08e39OEzH6ByABSAdrsXvulp66
        CsduDxL/wRbQDnXm5gGUsQT8a1tMIEU=
X-Google-Smtp-Source: AGRyM1uup+RcgIVrKSFw0ywkVopm8MkjHXuSYY9LS2DicIn1vTCvNwS22beAkHcxzxPGorQlwc88Mw==
X-Received: by 2002:a05:620a:15d3:b0:6ae:ea81:76ec with SMTP id o19-20020a05620a15d300b006aeea8176ecmr10952926qkm.617.1656692848760;
        Fri, 01 Jul 2022 09:27:28 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006af08c26774sm17316175qko.47.2022.07.01.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:27:28 -0700 (PDT)
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
Subject: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
Date:   Fri,  1 Jul 2022 12:27:21 -0400
Message-Id: <20220701162726.31346-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A submission [1] was made to enable a PCIe root port to turn on regulators
for downstream devices.  It was accepted.  Months later, a regression was
discovered on an RPi CM4 [2].  The patchset was reverted [3] as the fix
came too late in the release cycle.  The regression in question is
triggered only when the PCIe RC DT node has no root port subnode, which is
a perfectly reasonsable configuration.

The original commits are now being resubmitted with some modifications to
fix the regression.  The modifcations on the original commits are
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

Jim Quinlan (4):
  PCI: brcmstb: Split brcm_pcie_setup() into two funcs
  PCI: brcmstb: Add mechanism to turn on subdev regulators
  PCI: brcmstb: oAdd control of subdevice voltage regulators
  PCI: brcmstb: Do not turn off WOL regulators on suspend

 drivers/pci/controller/pcie-brcmstb.c | 257 +++++++++++++++++++++++---
 1 file changed, 227 insertions(+), 30 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.17.1

