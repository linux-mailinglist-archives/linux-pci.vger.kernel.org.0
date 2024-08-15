Return-Path: <linux-pci+bounces-11719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BF953DA2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5302E1F23A2A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ECC15573F;
	Thu, 15 Aug 2024 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cN9nkvdH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9C154C00
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762663; cv=none; b=O+FZbpEAv6gRFl0Qr+UzhmGQBTsq55aEDzLCBGfYWSy7StgxrMxAMXkiaM6skCqeKe9IohYZf9M9RI1Ua+ce4J4WjpEtqJF2EkjxPF5SvuarLQT6MSCxiekmfk9TYNQ9CFnOF2s5p96q33C/itftlpNqkGlHGX+siPa/hJs3yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762663; c=relaxed/simple;
	bh=/ctkKcWCCpWdIGjsBREvWsLSCJ6HIJiK6R/+XdiTcJg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=omxLT7NEm36UBeSZtnYvIsIZivhfPMQ3k3772l3A1DEymL5fHCHVgMlV91doQDN/LQpB6yqslAvg9XpoCpY4H+VV7/yKtAAdg/WiUJjmHB+16aLT3VR9BPuJHUq6AKjeTLN8OzVDTbU7QnOUh0ajlhBzqN9rqyikrGW91AGCEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cN9nkvdH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso1097915a12.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762660; x=1724367460; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/BXSeX8ciuSE3bxncnCRt5/0XxCu04J2KtFDCrsUvs=;
        b=cN9nkvdHbmTyMJEd4fx4XUatsRAkBKnYStcLaPZZuVO9VIL/Gr71FCm6oCsQxi7kjw
         f+Llxn9IRsU5xi9/YQm8k6qiwUe86URJNlKE2tKNCIxltOQgW6UDTNe1HQ7fTWpyBhCU
         6UF9UQ6nU+YH0iIjlLlW7XbsmemGzj9cJ5WR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762660; x=1724367460;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/BXSeX8ciuSE3bxncnCRt5/0XxCu04J2KtFDCrsUvs=;
        b=dJIJ0/OMrDAWqFl5uyjz+nHw6OzM4E0ftWe17EE6jPZgJZdeDxVVtb8t7Uyp8faiWa
         sC3zxrcGKfZRmfrioalMJFPu0WoaAts0rv8KqF7LHmLzLOQL9l1gqzJKq+0a5oidBeDV
         aZNBzMvTdlqQ04nhmuce0Bl8L9u27bxq6REiSIIhyXWH6AxsRZEV1W96LuLR2ej98B5E
         WMHm53Yo0LwpKcOwyAYPBxpYMWV0kYjQQZO58RSJVny2ka1Idaxa5AQ0ZHRFEbry/O7h
         EJlXSo4RRj9w/voGVMLpZ43jvEv582EaVgzlSPZnW1c++1bmPcgOxZucx/scG7GXOfrz
         wwwQ==
X-Gm-Message-State: AOJu0Ywl6jqFjG5ugTi6nmE/vQzfbjalWqTyKdVctfgPwuJa2S25syDs
	+zOt5L8Ns9hlHiFVoOBRARm3HHssr2yCaT78kE5i3ewN9PoDqzhbyEKQr91IyVtkhsNNXSLixo/
	z2To+zXTyWDENxJiGUhFA57YjreY1CayqZMzzv6xJzoUkp4yLsvku63v7w3C+UENcGP7fYL12c5
	CS1P3lqLEi/Iq16I+5e9/QjnGkRSRPEM+tuRoOLtqkXEwKEA==
X-Google-Smtp-Source: AGHT+IGJ+gVzcGOhJui5aMLA8W6K2sWN8YCFH0a2Y9yMPFBDLMrUXoiUhLy8kdY4EgdETnc/BySasQ==
X-Received: by 2002:a17:90a:f001:b0:2d3:bd64:bc7f with SMTP id 98e67ed59e1d1-2d3e00f063dmr1230821a91.28.1723762659685;
        Thu, 15 Aug 2024 15:57:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:39 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	Rob Herring <robh@kernel.org>
Subject: [PATCH v6 00/13] PCI: brcnstb: Enable STB 7712 SOC
Date: Thu, 15 Aug 2024 18:57:13 -0400
Message-Id: <20240815225731.40276-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

V6 Changes
  o Commit "Refactor for chips with many regular inbound windows"
    -- Use u8 for anything storing/counting # inbound windows (Stan)
    -- s/set_bar/add_inbound_win/g (Manivannan)
    -- Drop use of "inline" (Manivannan)
    -- Change cpu_beg to cpu_start, same with pcie_beg. (Manivannan)
    -- Used writel_relaxed() (Manivannan)
  o Use swinit reset if available
    -- Proper use of dev_err_probe() (Stan)
  o Commit "Use common error handling code in brcm_pcie_probe()"
    -- Rewrite commit msg in paragraph form (Manivannan)
    -- Refactor error path at end of probe func (Manivannan)
    -- Proper use of dev_err_probe() (Stan)
  o New commit "dt-bindings: PCI: Change brcmstb maintainer and cleanup"
    -- Break out maintainer change and small cleanup into a
       separate commit (Krzysztof)

V5 Changes:
  o All commits: Use imperative voice in commit subjects/messages
       (Manivannan)
  o Commit "PCI: brcmstb: Enable 7712 SOCs"
    -- Augment commit message to include PCIe details and revision.
       (Manivannan)
  o Commit "PCI: brcmstb: Change field name from 'type' to 'model'"
    -- Instead of "model" use "soc_base" (Manivannan)
  o Commit "PCI: brcmstb: Refactor for chips with many regular inbound BARs"
    -- Get rid of the confusing "BAR" variable names and types and use
       something like "inbound_win". (Manivannan)
  o Commit "PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE..."
    -- Mention in the commit message that this change is in preparation
       for the 7712 SoC. (Manivannan)
  o Commit: "PCI: brcmstb: Use swinit reset if available"
    -- Change reset name "swinit" to "swinit_reset" (Manivannan)
    -- Add 1us delay for reset (Manivannan)
    -- Use dev_err_probe() (Multiple reviewers)
  o Commit "PCI: brcmstb: Use bridge reset if available"
    -- Change reset name "bridge" to "bridge_reset" (Manivannan)
    -- The Reset API can take NULL so need need to test variable
       before calling (Manivannan)
    -- Added a call to bridge_sw_init_set() method in probe()
       as some registers cannot be accessed w/o this. (JQ)
  o Commit "PCI: brcmstb: Use common error handling code in ..."
    -- Use more descriptive goto label (Manivannan)
    -- Refactor error paths to be less encumbered (Manivannan)
    -- Use dev_err_probe() (Multiple reviewers)
  o Commits "dt-bindings: PCI: brcmstb: ..."
    -- Specify the "resets" and "reset-names" in the same manner
       as does qcom,ufs.yaml specifies "clocks" and
       "clock-names" (Krzysztof)
    -- Drop reset desccriptions as they were pretty content-free
       anyhow. (Krzysztof)

V4 Changes:
  o Commit "Check return value of all reset_control_xxx calls"
    -- Blank line before "return" (Stan)
  o Commit "Use common error handling code in brcmstb_probe()"
    -- Drop the "Fixes" tag (Stan)
  o Commit "dt-bindings: PCI ..."
    -- Separate the main commit into two: cleanup and adding the
       7712 SoC (Krzysztof)
    -- Fold maintainer change commit into cleanup change (Krzysztof)
    -- Use minItems/maxItems where appropriate (Krzysztof)
    -- Consistent order of resets/reset-names in decl and usage
       (Krzysztof)

V3 Changes:
  o Commit "Enable 7712 SOCs"
    -- Move "model" check from outside to inside func (Stan)
  o Commit "Check return value of all reset_control_xxx calls"
    -- Propagate errors up the chain instead of ignoring them (Stan)
  o Commit "Refactor for chips with many regular inbound BARs"
    -- Nine suggestions given, nine implemented (Stan)
  o Commit "Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific"
    -- Drop tab, add parens around macro params in expression (Stan)
  o Commit "Use swinit reset if available"
    -- Treat swinit the same as other reset controllers (Stan)
       Stan suggested to use dev_err_probe() for getting resources
       but I will defer that to future series (if that's okay).
  o Commit "Get resource before we start asserting resets"
    -- Squash this with previous commit (Stan)
  o Commit "Use "clk_out" error path label"
    -- Move clk_prepare_enable() after getting resouurces (Stan)
    -- Change subject to "Use more common error handling code in
       brcm_pcie_probe()" (Markus)
    -- Use imperative commit description (Markus)
    -- "Fixes:" tag added for missing error return. (Markus)
  o Commit "dt-bindings: PCI ..."
    -- Split off maintainer change in separate commit.
    -- Tried to accomodate Krzysztof's requests, I'm not sure I
       have succeeded.  Krzysztof, please see [1] below.
  
  [1] Wrt the YAML of brcmstb PCIe resets, here is what I am trying
      to describe:

      CHIP       NUM_RESETS    NAMES
      ====       ==========    =====
      4908       1             perst
      7216       1             rescal
      7712       3             rescal, bridge, swinit
      Others     0             -


V2 Changes (note: four new commits):
  o Commit "dt-bindings: PCI ..."
    -- s/Adds/Add/, fix spelling error (Bjorn)
    -- Order compatible strings alphabetically (Krzysztof)
    -- Give definitions first then rules (Krzysztof)
    -- Add reason for change in maintainer (Krzysztof)
  o Commit "Use swinit reset if available"
    -- no need for "else" clause (Philipp)
    -- fix improper use of dev_err_probe() (Philipp) 
  o Commit "Use "clk_out" error path label"
    -- Improve commit message (Bjorn)
  o Commit "PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific"
    -- Improve commit subject line (Bjorn)
  o Commit (NEW) -- Change field name from 'type' to 'model'
    -- Added as requested (Stanimir)
  o Commit (NEW) -- Check return value of all reset_control_xxx calls
    -- Added as requested (Stanimir)
  o Commit (NEW) "Get resource before we start asserting reset controllers"
    -- Added as requested (Stanimir)
  o Commit (NEW) -- "Remove two unused constants from driver"


V1:
  This submission is for the Broadcom STB 7712, sibling SOC of the RPi5 chip.
  Stanimir has already submitted a patch "Add PCIe support for bcm2712" for
  the RPi version of the SOC.  It is hoped that Stanimir will allow us to
  submit this series first and subsequently rebase his patch(es).

  The largest commit, "Refactor for chips with many regular inbound BARs"
  affects both the STB and RPi SOCs.  It allows for multiple inbound ranges
  where previously only one was effectively used.  This feature will also
  be present in future STB chips, as well as Broadcom's Cable Modem group.

Jim Quinlan (13):
  dt-bindings: PCI: Change brcmstb maintainer and cleanup
  dt-bindings: PCI: Use maxItems for reset controllers
  dt-bindings: PCI: brcmstb: Add 7712 SoC description
  PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
  PCI: brcmstb: Use bridge reset if available
  PCI: brcmstb: Use swinit reset if available
  PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets
    SoC-specific
  PCI: brcmstb: Remove two unused constants from driver
  PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
  PCI: brcmstb: Refactor for chips with many regular inbound windows
  PCI: brcmstb: Check return value of all reset_control_xxx calls
  PCI: brcmstb: Change field name from 'type' to 'soc_base'
  PCI: brcmstb: Enable 7712 SOCs

 .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
 drivers/pci/controller/pcie-brcmstb.c         | 513 +++++++++++++-----
 2 files changed, 412 insertions(+), 141 deletions(-)


base-commit: e724918b3786252b985b0c2764c16a57d1937707
-- 
2.17.1


