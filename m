Return-Path: <linux-pci+bounces-39322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C846C094C3
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCEF5342A1F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E593093AA;
	Sat, 25 Oct 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="junmb6Ab"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0A3090F7;
	Sat, 25 Oct 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408958; cv=none; b=AWMEgGWo722+KldlXwuiqKXlFnGZnb92hvYPjZXG3RlwY7AHaRF5OVoYJvWrdsHCb6UOUwtQ8l+LeSWzwPy4pjeePJskZ3l6s3LbeD+B/4gvRbeInJk9sVSTJY+PoL/59QgdsLdGvZ3z+imcxp+LpxIlZUuhZS40SOmlBgJpoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408958; c=relaxed/simple;
	bh=MmWCn+a9rvnlVuGi+Ff6hilOGPA6cq70LX1d0Blxq8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJNDpG/QeEDpv8DTR8O1AeymKwGoKPaYxXxbtY/Un8WeQQwEq/BPKftnKOwS7TgP4yNL0aKvn8ZsnK7PK7U16vUNZOhOKEGAw5NE5rqfuksnJAadGegaDDawOQFFcdWIezEEvjVm8UQtNUtekyaTMK0npMWVHAwP0dccJ5Yjmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=junmb6Ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C6BC4CEFB;
	Sat, 25 Oct 2025 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408957;
	bh=MmWCn+a9rvnlVuGi+Ff6hilOGPA6cq70LX1d0Blxq8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=junmb6AbxhpbuQ6c+Ud6Im+Ez3/61c6UDXJhpNS9jltZ86god4r4AlNEFsV/TnJuB
	 SG3kx6T/ZOzsSC7CLqpKL+n3/JSYbFn9iFEPmK5iNqT4kHS1dfb/FBUue4tX4fRzd4
	 t3oFKNicPZgpngio2KkNrDe8cOYkCy7eWyNScmVhc+hemU0nA2rzNgcovuPA1ZbKNt
	 NU21GNChQScl5hKyk+pFEi0UfqiuRyr6wRAr3bcDkFcBfQDFdrezazbqvcfDLo77Uq
	 bdR+8hmCracrJSLUWkYRdB1bf8wUsc6W3OysvYyrX+QiWNgPCam9RBLuWVUt/kCPbu
	 zb9yz/wAs5+qg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] PCI/PM: Skip resuming to D0 if device is disconnected
Date: Sat, 25 Oct 2025 11:56:22 -0400
Message-ID: <20251025160905.3857885-151-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 299fad4133677b845ce962f78c9cf75bded63f61 ]

When a device is surprise-removed (e.g., due to a dock unplug), the PCI
core unconfigures all downstream devices and sets their error state to
pci_channel_io_perm_failure. This marks them as disconnected via
pci_dev_is_disconnected().

During device removal, the runtime PM framework may attempt to resume the
device to D0 via pm_runtime_get_sync(), which calls into pci_power_up().
Since the device is already disconnected, this resume attempt is
unnecessary and results in a predictable errors like this, typically when
undocking from a TBT3 or USB4 dock with PCIe tunneling:

  pci 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible

Avoid powering up disconnected devices by checking their status early in
pci_power_up() and returning -EIO.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[bhelgaas: add typical message]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://patch.msgid.link/20250909031916.4143121-1-superm1@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- The new guard in `drivers/pci/pci.c:1321-1324` checks
  `pci_dev_is_disconnected()` before touching PCI PM registers, so
  surprise-removed devices short-circuit with `-EIO` while keeping
  `current_state = PCI_D3cold`. This prevents the guaranteed `"Unable to
  change power state..."` error emitted when `pci_read_config_word()`
  hits a vanished device (see `drivers/pci/pci.c:1326-1331`), which
  currently spams logs whenever users undock TBT3/USB4 systems.
- Callers already expect a negative return in this scenario—the pre-
  change path hit the same `-EIO` branch after the failing config
  read—so observable behaviour stays the same aside from eliminating the
  noisy and misleading error message. `pci_set_full_power_state()` and
  runtime PM resume paths therefore retain their semantics but avoid
  futile config accesses.
- The fix is narrowly scoped to PCI PM, introduces no architectural
  churn, and relies only on long-standing helpers present in supported
  stables (confirmed `pci_dev_is_disconnected()` in tags like `p-6.6`).
  It neither alters power-state transitions for healthy devices nor
  affects platforms lacking PM caps because the new check comes after
  the existing `!dev->pm_cap` fallback.
- Avoiding config transactions on removed hardware reduces the chance of
  host controller complaints and matches other PCI core code that tests
  `pci_dev_is_disconnected()` before issuing requests, making this a
  low-risk, high-signal bug fix well suited for stable backporting.

Natural next step: 1) Queue the patch for the targeted stable series
after double-checking those trees already expose
`pci_dev_is_disconnected()` in `include/linux/pci.h`.

 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cdd..036511f5b2625 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
 		return -EIO;
 	}
 
+	if (pci_dev_is_disconnected(dev)) {
+		dev->current_state = PCI_D3cold;
+		return -EIO;
+	}
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
-- 
2.51.0


