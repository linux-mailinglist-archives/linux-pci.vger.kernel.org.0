Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9F34AF31
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZTTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:19:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B105C0613AA;
        Fri, 26 Mar 2021 12:19:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k10so10087391ejg.0;
        Fri, 26 Mar 2021 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8t/h5pyXfOSMK2z3ITB4dIfcODUGYWdUiC+0wCde4Ns=;
        b=YGkJ8KjNzvWStMb5bJ8lOVWoUSdWdng5iHacMKSM0ip8sZCDeOSSc23Tn/R4Fk4Zm4
         FDtpNUTpj0nRV5JLSUyQPbW42uIjWr7WAY9judgaL6xjaEw+AFlMuaJUHvxkrmakp5Nv
         p5Z/A6UdealHtn3Oy0tXUNrV5O/RKWSiXrFNFWH5JdE88opPYORHULsC3ZRz2ysFaEdU
         RKKuws/CGr2i+QxaMs9upxMPfCZk8nN4lwZE3N9/7yCiZk4Lbs4ii6JtAC3gej8MrltG
         YGgT28CRL+gUljukyNVjg6SkicDldA+Q3uL5a1aAc7gX3D5qN1Y2q5avIg3CyLuR+GDO
         +bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8t/h5pyXfOSMK2z3ITB4dIfcODUGYWdUiC+0wCde4Ns=;
        b=PNCr3y1TlnfEylkzTYyRevYGt/dK51JxKq33CFkZ4lXjLWrOnr4oAAXMD8X/zmVlS9
         /UiZRX17fTe5AUsfX7tXDVPIeBPaVoyjjM8Jtt7oR50CtIYLEMlF7WyEC7Mp0UZOS07n
         dzkBxJyz/vEgUMtRFK6M5mWiunzM+ht2OtiS4SyPeeUZL3Em1zTqgJ/PyehcW/iTXhxS
         uqYAZrNoHgWl1sLUd9bFfcQdgDeGwcDmGQnCwurciatYE9jkZktO21E0W5D9UBctMZcf
         RsYExx9QBIN6xnSHvsrspZPOFStf7MLX6XyJpk58qny42qT17+3XDM5/AXGsYC+e9yM2
         O9CA==
X-Gm-Message-State: AOAM533pijMaOYVkPOGYprDM1Ed77KbHr+YDmbvVP5wp4FVwZPChsaRi
        UelQZM9zdKDL+Ia7KQM+N8pCV9aIrYM=
X-Google-Smtp-Source: ABdhPJxjTF5C5+w89dYokY2z8QFo/IArOjhYLJJ5hnFH3EkHL/dePu9qIe6IZXywTibdgUPeFQul4Q==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr16148371eje.7.1616786350966;
        Fri, 26 Mar 2021 12:19:10 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c19sm4739373edu.20.2021.03.26.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:19:10 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 0/6] PCI: brcmstb: add EP regulators and panic handler
Date:   Fri, 26 Mar 2021 15:18:58 -0400
Message-Id: <20210326191906.43567-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
  PCI: brcmstb: Add control of EP voltage regulators
  PCI: brcmstb: Do not turn off regulators if EP can wake up
  PCI: brcmstb: Give 7216 SOCs their own config type
  PCI: brcmstb: Add panic/die handler to RC driver
  PCI: brcmstb: Check return value of clk_prepare_enable()

 .../bindings/pci/brcm,stb-pcie.yaml           |   6 +
 drivers/pci/controller/pcie-brcmstb.c         | 271 +++++++++++++++++-
 2 files changed, 272 insertions(+), 5 deletions(-)

-- 
2.17.1

