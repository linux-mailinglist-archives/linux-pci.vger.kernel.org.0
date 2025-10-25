Return-Path: <linux-pci+bounces-39326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F4C09BF0
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8204FAA02
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80730E859;
	Sat, 25 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOcKMjis"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C23043D9;
	Sat, 25 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409457; cv=none; b=ttDRgzLFHwVx4VJilcAojyFNdsBbELeoLv1c9kPe3T/IlfBkeVyO0MttbscCBn162f5aHJHSWc7jRl0jp9v/jrRRetv4ZBVrZ1Iay4bABNcbs/J/7j6AwrSRjWRFwwMJ0xDChRqr5o0jCMmhllayAVDjSPJfdkh6b6Xgg1V4eUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409457; c=relaxed/simple;
	bh=f2mXaMdRp5tDwnL9/a/EtwaLIu81gOvYcVwx5gGo0Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOByyjNvPE51MHaxYfybMbf7L0F/Cq+TUCS148RVNwJu1khaWnZwfoG0PuTj0oobgFdM8GilTMzTkRsrH6BOyrhsGCy7ZzbkENRmHsJx31PiE0iz5YnDAp31UEAm5EJ0G0t/3n2Fs9cYjbl9r/wdhXs3CMg7z8A/Kw/vDsP8V0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOcKMjis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BB2C4CEFB;
	Sat, 25 Oct 2025 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409457;
	bh=f2mXaMdRp5tDwnL9/a/EtwaLIu81gOvYcVwx5gGo0Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOcKMjisDr8RTnjytlIPfw7mDluky3udoGpenqUk8Anmwni24QNA1Keiy4sMHClhE
	 dWG7irViRQBVX0H7gHVfCODhjLllbcgu2xgGMcnVhGIELC0fopRfVPvALHLB4wO2/u
	 vDmie2J6nSqoSiqmTMJN1BaimgbcMgyxAYX5QZxxThOZUSnqrmHnmWeVFtbXR/9oPj
	 7sTfXnInLkHugtih2CgHEzGGbKCN3sZ66Pp8L3+eSdNgzVWyiEXTD3UU04VqWT9F5R
	 8I4l6gQhZYXLMBArFDKaFpcWmNQ5F93mpeld9XhlTcw9/KDt0xxPvKb+aTaf3kskbL
	 vVd6z9tE7HfXA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	s-vadapalli@ti.com,
	bhelgaas@google.com,
	alexander.deucher@amd.com,
	kishon@kernel.org,
	18255117159@163.com,
	alexandre.f.demers@gmail.com,
	bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.10] PCI: cadence: Check for the existence of cdns_pcie::ops before using it
Date: Sat, 25 Oct 2025 11:59:23 -0400
Message-ID: <20251025160905.3857885-332-sashal@kernel.org>
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

From: Chen Wang <unicorn_wang@outlook.com>

[ Upstream commit 49a6c160ad4812476f8ae1a8f4ed6d15adfa6c09 ]

cdns_pcie::ops might not be populated by all the Cadence glue drivers. This
is going to be true for the upcoming Sophgo platform which doesn't set the
ops.

Hence, add a check to prevent NULL pointer dereference.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
[mani: reworded subject and description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/35182ee1d972dfcd093a964e11205efcebbdc044.1757643388.git.unicorn_wang@outlook.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
**Why Backport**
- The shared Cadence core dereferences `pcie->ops` unconditionally in
  several hot paths (`drivers/pci/controller/cadence/pcie-cadence-
  host.c:534`, `pcie-cadence.c:109` and `:140`, `pcie-cadence.h:497`,
  `505`, `511`). If a glue driver legitimately leaves `ops` unset, the
  host setup oopses during probe.
- The new in-tree Sophgo driver (`drivers/pci/controller/cadence/pcie-
  sg2042.c:35-69`) deliberately does not populate `pcie->ops`; without
  this fix `cdns_pcie_host_setup()` trips the NULL dereference in
  `cdns_pcie_host_init_address_translation()` immediately, so the
  controller cannot even enumerate.
- The patch simply wraps each dereference with `pcie->ops &&
  pcie->ops->...`, meaning existing platforms that register callbacks
  keep identical behaviour, while platforms that do not provide optional
  hooks now fall back to the previously implied defaults — avoiding the
  fatal crash.

**Risk**
- Change is entirely in guard logic, no register programming altered
  when `ops` is present. For platforms that rely on
  `cpu_addr_fixup`/link callbacks, the functions still run because the
  pointer remains non-NULL.
- For platforms without callbacks, the driver already relied on the
  default behaviour implied by the inline helpers; the patch just
  matches that expectation. Regression risk is therefore minimal.

**Next Steps**
- 1) Smoke/boot-test on at least one Cadence RC platform (e.g. TI J721E)
  plus the Sophgo SG2042 host once both patches are staged, to confirm
  link bring-up stays healthy.

 drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
 drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 59a4631de79fe..fffd63d6665e8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -531,7 +531,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
 
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440ee..61806bbd8aa32 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -92,7 +92,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
 
 	/* Set the CPU address */
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
@@ -123,7 +123,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
 	}
 
 	/* Set the CPU address */
-	if (pcie->ops->cpu_addr_fixup)
+	if (pcie->ops && pcie->ops->cpu_addr_fixup)
 		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
 
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 1d81c4bf6c6db..2f07ba661bda7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -468,7 +468,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 
 static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->start_link)
+	if (pcie->ops && pcie->ops->start_link)
 		return pcie->ops->start_link(pcie);
 
 	return 0;
@@ -476,13 +476,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
 
 static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->stop_link)
+	if (pcie->ops && pcie->ops->stop_link)
 		pcie->ops->stop_link(pcie);
 }
 
 static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 {
-	if (pcie->ops->link_up)
+	if (pcie->ops && pcie->ops->link_up)
 		return pcie->ops->link_up(pcie);
 
 	return true;
-- 
2.51.0


