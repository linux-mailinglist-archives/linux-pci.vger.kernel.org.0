Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0194935218E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhDAVVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhDAVVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:21:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F02C0613E6;
        Thu,  1 Apr 2021 14:21:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g15so2353866pfq.3;
        Thu, 01 Apr 2021 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OHE1y+eUnZAiDLwSXNcb4ovsHCQvOvUGaM/Io3DNmX0=;
        b=Sjy1iuHn9ODDZaLLgb2NNlK7G2oAtZJn/2neR52Op5u5nRlJZYNLZCWWYw/d58ckk5
         hFXfhFhu2m7CKBch0OQkKn3Oo/uxZb9UYEAuvwb/10jevc1R/rUqrmA0ak4TattNmekX
         0O62oa9g81S6JdYAwOedisooJjPJwuGEo0HT8eD7Flq27F4AQ33Iiuve8JzHXIvzrJB3
         O1s4IgS4jgcC4L0xUwffKb64cxo3w6OMG2ymhtwOYRc+fszH5Rvf2ZiSH63uB0VCkprr
         0u8HyxHZy2bRO2xfPWbeaij+rNO9B14TfjGT4MaAc4fNG/dy54gYQb57+oIe7kmRAGW7
         NbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OHE1y+eUnZAiDLwSXNcb4ovsHCQvOvUGaM/Io3DNmX0=;
        b=UhT7kmIJNQn9uK76Ei53M4AZ80tRz21OXdy6dVceZE1+QM6WphuHnLn5ei/CxMml2t
         sC20fvqtHhu26mW37toP8XYW0Hhw1QXdsjO3Yuht+beVYS5xUKtvvR+0Khs6vKsCalR8
         N4bJRrmMx56yyQWOcpZA3rDugSA4+XwdlF/toslvIp5s9UdqyNLtGZa/FY9Q1rIQFnRr
         YDMaj/k/RhRUXl7Z3BfIbQQJQ8C5vf0qasw5k2hnHx4oEPLj5IITHCuOF1wt2YCzFYME
         q2fpNuMWwjVHp6LYeuzl6Aj9Qol8mwPJAiTOgir681ReYA4sUNEjMudiTMn85r4Le+kc
         cQDw==
X-Gm-Message-State: AOAM533omhSocYNq8dO3PJS1eLrEnjbj1CMSUiJ83ycSsIq5Ucizb9GS
        PDFZNvcv5A6oZYTXQ3lF9u6MCtr9l6I=
X-Google-Smtp-Source: ABdhPJxszLrpfuP3/ZKD67bhlY85aoIE1kPVDcjSqf86JpqVUuE6MVzUfC6KWWF63z20Qun0aYENmw==
X-Received: by 2002:a63:4522:: with SMTP id s34mr9102188pga.250.1617312113217;
        Thu, 01 Apr 2021 14:21:53 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:21:52 -0700 (PDT)
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
Subject: [PATCH v4 0/6] PCI: brcmstb: add slot0 device regulators and panic handler
Date:   Thu,  1 Apr 2021 17:21:40 -0400
Message-Id: <20210401212148.47033-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
  PCI: brcmstb: Check return value of clk_prepare_enable()
  dt-bindings: PCI: Add bindings for Brcmstb endpoint device voltage
    regulators
  PCI: brcmstb: Add control of slot0 device voltage regulators
  PCI: brcmstb: Do not turn off regulators if EP can wake up
  PCI: brcmstb: Give 7216 SOCs their own config type
  PCI: brcmstb: Add panic/die handler to RC driver

 .../bindings/pci/brcm,stb-pcie.yaml           |   4 +
 drivers/pci/controller/pcie-brcmstb.c         | 262 +++++++++++++++++-
 2 files changed, 259 insertions(+), 7 deletions(-)

-- 
2.17.1

