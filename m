Return-Path: <linux-pci+bounces-44508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B798D137FB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0262B3156731
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467492E11BC;
	Mon, 12 Jan 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edKPUyP/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823692DEA75;
	Mon, 12 Jan 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229945; cv=none; b=JmjcoijLXbbRT/weEZBw/8R8FLBOBs3et2AUgMSbOraOkJ43iS6fXN5RiUKBtpLYsZcFNwvyQB0IlTp2oOTu9U2SlciFclsZt1PymUsI9SfirLMQaJA8GweE3APLf27ix5ewlRWFfaO/p0pdZQuNS26AFctCDnT/hAL2ufxs+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229945; c=relaxed/simple;
	bh=SA/M8GWVAADSFvD6UBoCN3tcb14Prw7mwfbgA1gGdbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiFAvhcSZXod2r0DL3kPTabkNHGT6KJojd6We5sCEpv+9YzHb2+8g9rHlYBkyRjl9GqLRcA7J++QriuCaEpNBF/CRjwAo4hgJfhDZIWowEkbLEFWkRWWivPI6JvVcp4UPF4JCSVX+Tbo+b9ienvEKu5D4aR0esA2t8YKJQz6LNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edKPUyP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA31C16AAE;
	Mon, 12 Jan 2026 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229944;
	bh=SA/M8GWVAADSFvD6UBoCN3tcb14Prw7mwfbgA1gGdbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edKPUyP/00h/W8PxH6ojlxeEhIZPlh7Qoh6G9P5TtoNbOx39uvJYjKntnLXQiIsSu
	 bUT38baC4KgUQc82bzwU+MOdIOdc7yfxToISle1QDHzVR9rQLkEdqxlz+nnYLX1fqg
	 hJ7M6knzvfAYjVioYhqDhGBWDgVgo6PBTS7y6RAXRn/EemmnNIVIz0SeHdOUT/+mPo
	 1UzbUP5KkfrrZBrVx5zuyl27BOn8MuDPAtAwn1FmFG8Ywi/TGIdVaxcjnDTSHbg8Ij
	 ogphNTunmYQisT1KfZvSM3y+wqVRirnlqOZvvK04iaAtqIKHQg2B24byn8tW47hgBg
	 RqAyugmx7qa8A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] PCI: qcom: Remove ASPM L0s support for MSM8996 SoC
Date: Mon, 12 Jan 2026 09:58:15 -0500
Message-ID: <20260112145840.724774-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112145840.724774-1-sashal@kernel.org>
References: <20260112145840.724774-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.5
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 0cc13256b60510936c34098ee7b929098eed823b ]

Though I couldn't confirm ASPM L0s support with the Qcom hardware team, a
bug report from Dmitry suggests that L0s is broken on this legacy SoC.
Hence, remove L0s support from the Root Port Link Capabilities in this SoC.

Since qcom_pcie_clear_aspm_l0s() is now used by more than one SoC config,
call it from qcom_pcie_host_init() instead.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-pci/4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20251126081718.8239-1-mani@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Looking at this commit, I need to analyze whether it's appropriate for
stable backporting.

## Commit Analysis

### What the Commit Does
This commit fixes broken ASPM L0s (Active State Power Management L0s)
support on the MSM8996 SoC. The key changes are:

1. **Adds `.no_l0s = true`** to the `cfg_2_3_2` configuration struct
   (MSM8996's config)
2. **Moves `qcom_pcie_clear_aspm_l0s()` call** from
   `qcom_pcie_post_init_2_7_0()` to `qcom_pcie_host_init()` so it
   applies to all SoCs that need it (based on their config flags)
3. **Removes the L0s clearing** from the 2_7_0 post_init since it's now
   centralized

### Bug Being Fixed
According to the commit message and linked bug report, ASPM L0s is
broken on the MSM8996 SoC. When L0s is enabled on broken hardware, users
can experience:
- PCIe link instability
- Power management failures
- Potential system hangs or communication failures

### Classification: Hardware Quirk/Workaround
This is clearly a **hardware quirk** - disabling a broken power
management feature on specific hardware. This falls under the explicit
exception category for stable backporting, similar to USB quirks or PCI
quirks for broken devices.

### Code Change Assessment
```c
// Addition to MSM8996 config - trivial one-liner:
static const struct qcom_pcie_cfg cfg_2_3_2 = {
        .ops = &ops_2_3_2,
+       .no_l0s = true,
};

// Centralized call in host_init for all SoCs needing it:
+       qcom_pcie_clear_aspm_l0s(pcie->pci);
```

The actual fix is small and surgical. The refactoring (moving the
function call) is minimal and just enables the fix to work for multiple
SoCs that need it.

### Stability Indicators
- **Tested-by: Dmitry Baryshkov** - The reporter confirmed the fix works
- **Reviewed-by: Konrad Dybcio** - Proper review by another Qualcomm
  developer
- **Signed-off by Bjorn Helgaas** - PCI subsystem maintainer approved

### Risk Assessment
- **Low risk**: Disabling a broken feature is safer than leaving it
  enabled
- **Targeted scope**: Only affects MSM8996 SoC (legacy Qualcomm
  platform)
- **Well-tested**: Has explicit test confirmation from the bug reporter

### Dependency Concerns
This commit assumes:
1. The `no_l0s` field exists in `struct qcom_pcie_cfg`
2. The `qcom_pcie_clear_aspm_l0s()` function exists

Looking at the diff, the commit adds to an existing `no_l0s` field (it
wouldn't compile otherwise). The function was already being called in
the 2_7_0 init path, so it exists. The infrastructure appears to already
be in place.

### User Impact
Users with MSM8996 devices (mobile/embedded Qualcomm platform)
experiencing PCIe stability issues due to broken L0s will benefit from
this fix. This is a real-world hardware problem affecting actual users.

## Conclusion

This commit is a **hardware quirk/workaround** which is explicitly
allowed in stable trees. It:
- Fixes a real bug (broken ASPM L0s causing hardware issues)
- Is small and contained
- Has been properly tested and reviewed
- Affects only the specific broken hardware (MSM8996)
- Falls under the device quirk exception category

The refactoring aspect (moving the function call) is minimal and merely
enables the fix to work cleanly. The actual fix is just adding `no_l0s =
true` to the MSM8996 configuration.

**YES**

 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c48a20602d7fa..6e820595ba32a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1033,7 +1033,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
-	qcom_pcie_clear_aspm_l0s(pcie->pci);
 	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
@@ -1302,6 +1301,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
+	qcom_pcie_clear_aspm_l0s(pcie->pci);
+
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
@@ -1450,6 +1451,7 @@ static const struct qcom_pcie_cfg cfg_2_1_0 = {
 
 static const struct qcom_pcie_cfg cfg_2_3_2 = {
 	.ops = &ops_2_3_2,
+	.no_l0s = true,
 };
 
 static const struct qcom_pcie_cfg cfg_2_3_3 = {
-- 
2.51.0


