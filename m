Return-Path: <linux-pci+bounces-39325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E1C09B9C
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51DD94ECFE7
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047EB3126BC;
	Sat, 25 Oct 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed/LLqH1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1C30C60F;
	Sat, 25 Oct 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409366; cv=none; b=RI5yCVZwsa8KI0uMjua14rd7EEDDDT6QbfZk+6loMN6GJiAVJAmuXdhM3mohBS4HgTQ6On0zv1OQSX3OizQkeXje4nPRkdXLkBdRIJi03qDylh3j1BNdNfcQEfX5cxfRc0IMbYN1MzuNaBTy8ehPHgkeaF2Hd28aiVzefFEx2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409366; c=relaxed/simple;
	bh=MglaqMgclKgb3tY/AIWiioH0+xEeNgjXGS9apwIC3H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1J06r5ESpL26ammt3t+Qhq6pEqtybwlfvebWw4BRRzYBVpSNeZGs5AJWc1mRCLfOZ25SItAcvH3pnhY/2ordg7VFqngt7DnWMa0r9eVIXf7cp3kUF0VRSt0zhYJilWtbA0XvcyUjXiAZpoByHxcl9iWuZ5YQt5RvNfI5QgaPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed/LLqH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834BAC116C6;
	Sat, 25 Oct 2025 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409366;
	bh=MglaqMgclKgb3tY/AIWiioH0+xEeNgjXGS9apwIC3H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ed/LLqH1lU1EjGZaLC5aCvYCIVrR8S+5BhGRza2blLTmYGRpBtESH3uZsz4YHFo/Y
	 eLMDJ3OTK3qJA4XSj5FAKVK5imGz6TQDETJjH1J5b+6SMNAp/ukOIgat6+gQr5V1dh
	 GWiqGYBTuXzNvciNjinIvAtU9mUI8m+05r8ReqtY4344zO4pmk1Jp2D322rqxa3n/f
	 6UIbkioQVUpj4VUHdl6N2WLmIBP+YFKG90KfEc96bhRSb8A+ZgrPuP8Cg507I5PYBX
	 PI6K6KZPNucy3blFZF9lsO7/3pdJyUgAFjLTyxFa+b33AbQ3KyXJmQ8NCOi74qhCMu
	 X72FEsBF58zNw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.15] thunderbolt: Use is_pciehp instead of is_hotplug_bridge
Date: Sat, 25 Oct 2025 11:58:43 -0400
Message-ID: <20251025160905.3857885-292-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 5d03847175e81e86d4865456c15638faaf7c0634 ]

The thunderbolt driver sets up device link dependencies from hotplug ports
to the Host Router (aka Native Host Interface, NHI).  When resuming from
system sleep, this allows the Host Router to re-establish tunnels to
attached Thunderbolt devices before the hotplug ports resume.

To identify the hotplug ports, the driver utilizes the is_hotplug_bridge
flag which also encompasses ACPI slots handled by the ACPI hotplug driver.

Thunderbolt hotplug ports are always Hot-Plug Capable PCIe ports, so it is
more apt to identify them with the is_pciehp flag.

Similarly, hotplug ports on older Thunderbolt controllers have broken MSI
support and are quirked to use legacy INTx interrupts instead.  The quirk
identifies them with is_hotplug_bridge, even though all affected ports are
also matched by is_pciehp.  So use is_pciehp here as well.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it changes
  - Switches hotplug-port detection from the broad
    `pdev->is_hotplug_bridge` flag to the precise `pdev->is_pciehp`
    (PCIe Hot-Plug Capable) in two places:
    - Quirk for TB controllers’ hotplug MSI: drivers/pci/quirks.c:3834
    - Device-link creation for resume ordering:
      drivers/thunderbolt/tb.c:3256

- Why this is correct
  - Semantics: `is_hotplug_bridge` is a superset flag that also covers
    ACPI-driven slots and conventional PCI hotplug, not just PCIe HPC.
    Documentation explicitly distinguishes them (include/linux/pci.h:330
    and include/linux/pci.h:334).
  - TB downstream hotplug ports are always PCIe Hot-Plug Capable, so
    `is_pciehp` matches the intended set without inadvertently pulling
    in ACPI-only slots.
  - ACPI code can set `is_hotplug_bridge` on bridges that are not PCIe
    HPC (drivers/pci/hotplug/acpiphp_glue.c:411 and
    drivers/pci/hotplug/acpiphp_glue.c:424), which is precisely what
    this change avoids.

- Code specifics and impact
  - Quirk: drivers/pci/quirks.c:3834
    - Old: `if (pdev->is_hotplug_bridge && …) pdev->no_msi = 1;`
    - New: `if (pdev->is_pciehp && …) pdev->no_msi = 1;`
    - Effect: Still covers all affected TB hotplug ports (Light
      Ridge/Eagle Ridge/Light Peak/early Cactus Ridge/Port Ridge),
      because those ports have PCIe HPC. Behavior is unchanged for
      intended devices, but avoids misfiring if some non-PCIe-HP bridge
      was flagged via the generic hotplug flag.
  - Resume ordering via device links: drivers/thunderbolt/tb.c:3256
    - Old: Filter downstream ports with `… || !pdev->is_hotplug_bridge)
      continue;`
    - New: `… || !pdev->is_pciehp) continue;`
    - Effect: Device links are created only for PCIe HPC downstream
      ports beneath the TB controller’s upstream port, which are the
      ports that participate in TB PCIe tunneling. This avoids creating
      links for ACPI-only hotplug bridges that do not belong in the TB
      tunnel re-establishment ordering.

- Correctness and consistency with PCI core
  - The PCI core caches the HPC bit early and sets both flags together
    for PCIe HPC ports (drivers/pci/probe.c:1628 and
    drivers/pci/probe.c:1630), so `is_pciehp` is reliable and avoids
    late config reads.
  - Other subsystems have already moved to `is_pciehp` for the same
    reason (e.g., PCIe portdrv created services only when `is_pciehp`),
    demonstrating the broader effort to disambiguate these flags.

- Risk assessment
  - Small, localized change; no architectural shifts.
  - Maintainers’ acks: Thunderbolt and PCI maintainers are on board
    (Acked-by Bjorn Helgaas, Signed-off-by Mika Westerberg), indicating
    consensus on intent and safety.
  - For TB quirk, the condition remains true for all intended TB ports;
    for TB device-links, the selection is narrowed to the correct
    subset, reducing potential for incorrect PM dependency ordering. No
    functional expansion; only reduced false positives.

- User-facing effect
  - More reliable resume sequencing for tunneled TB devices (device
    links now scoped to true PCIe HP ports).
  - Avoids unnecessary links for ACPI-only slots that are unrelated to
    TB tunnels.
  - No change in MSI disabling behavior for affected TB generations;
    still prevents broken MSI usage there.

- Backport considerations
  - Dependency: Target stable trees must already have `struct
    pci_dev::is_pciehp` and the core logic that sets it
    (drivers/pci/probe.c:1628 and drivers/pci/probe.c:1630). If a stable
    branch lacks this field, it would require backporting that PCI core
    addition first.
  - Scope: Touches only `drivers/pci/quirks.c` and
    `drivers/thunderbolt/tb.c`; isolated and low-risk with no API
    changes.

Given the minimal change, precise semantics, alignment with ongoing PCI
core cleanups, and low regression risk confined to TB/PCI hotplug paths,
this is a good candidate for stable backport (where `is_pciehp` is
present).

 drivers/pci/quirks.c     | 2 +-
 drivers/thunderbolt/tb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6eb3d20386e95..214ed060ca1b3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3830,7 +3830,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
  */
 static void quirk_thunderbolt_hotplug_msi(struct pci_dev *pdev)
 {
-	if (pdev->is_hotplug_bridge &&
+	if (pdev->is_pciehp &&
 	    (pdev->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
 	     pdev->revision <= 1))
 		pdev->no_msi = 1;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c14ab1fbeeafd..83a33fc1486ab 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3336,7 +3336,7 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
 		if (!pci_is_pcie(pdev))
 			continue;
 		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
-		    !pdev->is_hotplug_bridge)
+		    !pdev->is_pciehp)
 			continue;
 
 		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
-- 
2.51.0


