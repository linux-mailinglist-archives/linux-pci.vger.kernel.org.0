Return-Path: <linux-pci+bounces-11075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10849438D8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F592B218AC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992A16C875;
	Wed, 31 Jul 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jth3GdOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E116CD02
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464917; cv=none; b=A88hpTii0k7CiYEc9cyEh1iV6mAwgHZHohHICO2Br8LjclharsQ1Gm/yAqRjlvdCnxIGe8hTOUpH4rnBxcD5+kYde2yep4i/9c3iQ895DkQdTvPekl/Ie0C7dU3hia8zn8r6yhXeYWomyxq41A7DVTDV0snuqjATH7HqehnECNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464917; c=relaxed/simple;
	bh=ktdUo3VuS/y90V9e4gyDsQB1AciL1Vj6iMBH9PHA7hQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ikupkP5wdXISiDe21QXbTbOEf4Pc8lHRLTdPUtXvStc/at60R/VduYApkkEm6Fe1etYDGdiWCaYQkIU+lLNslf9Ud/naarPZUFo9SLPk8/wwGMup2/PS6ODv2utnaLcCgrhxXb52fiKl1j2e2wpRu2kM8AEpfWxV2XR2nSRgsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jth3GdOD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45006bcb482so31260251cf.3
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464914; x=1723069714; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylwnOpuO0B3o3dwzu5zhP3ff0eBjDChdy+VytRAtBsU=;
        b=Jth3GdODHOBf+NCNILSs9+owEDWhJOYmXKideEdCcQCKc9yXhbg3zCEuV7Yc997GXo
         VRjaZRcbFyILF6zsdzmDtvizPxE5WJaTzLVOQ9o+jIqlM+E+zl6X0qU+cQfZZV0SZ+kj
         ygs0h0PZF8Vl+2GqSAHz2QB4e9KUBUjLlHbRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464914; x=1723069714;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylwnOpuO0B3o3dwzu5zhP3ff0eBjDChdy+VytRAtBsU=;
        b=JnZIScbAbwC3L0sqtDTNrm1gda7OwrbDZe5XJe87+uMHqfJ01Os7pD/s5LinIdQHhX
         z37ugAVz+qiZkGcPnGCA40gw+InlSValdKbyI3uGWv1qqtVVWpyGiwm9mWgUnzuJokOA
         VRZWAmbox/0Watyogm0W70TSQayg34IF+yApuJd/dMG+On1Un/dI5vmWAJIYYKh/W2UG
         lt7vWx6/NO+rz0pyPNXxu1wCXAzhWg2lKEy7Y3+ED0zdRGRqawPub1ZDc4j9AfMbC9a7
         tvJQy3fAy+yH6cX42SQPm9q8K9KALHzHjk3tvRmFeTgX5RsiROO113DfsTkkrH6JgH08
         myHQ==
X-Gm-Message-State: AOJu0YzzbG3w0la4iage01PQvWXnpODcS958VJ6N+s4nNP+St1T1ijwB
	IM/RcKtOAhGoYNd/gMEnqKgBFEDR0Iu95xX2jnoSbXhj9/7yaAGHTX07Egjf7vp4EDXw8PD07CK
	aYcmf5zWf81kllhCb9PxlHr4i69nWJhI55NNBhiLmO+J9lFOE3hrD3nEXk4Dd9v8h1uumDCbiJQ
	VAVXGzIsLTsxfVsH8zgfWPQ8n1nXRuE+DZhmOfEoWQTPkUow==
X-Google-Smtp-Source: AGHT+IFwR4Jva4IlO5SairxSPbBykKoc31AdO5AtsqRwbWmbP0SsRS/EClXVJl6Lj0koeII7dR94vw==
X-Received: by 2002:a05:622a:54c:b0:450:3eb:cb42 with SMTP id d75a77b69052e-4515eae9963mr7941031cf.45.1722464914085;
        Wed, 31 Jul 2024 15:28:34 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:33 -0700 (PDT)
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
Subject: [PATCH v5 00/12] PCI: brcnstb: Enable STB 7712 SOC
Date: Wed, 31 Jul 2024 18:28:14 -0400
Message-Id: <20240731222831.14895-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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

Jim Quinlan (12):
  dt-bindings: PCI: Cleanup of brcmstb YAML and add 7712 SoC
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
 drivers/pci/controller/pcie-brcmstb.c         | 510 +++++++++++++-----
 2 files changed, 406 insertions(+), 144 deletions(-)


base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
-- 
2.17.1


