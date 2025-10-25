Return-Path: <linux-pci+bounces-39320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06454C09560
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B23188D43B
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E430595F;
	Sat, 25 Oct 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6QfyUlm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488F30595B;
	Sat, 25 Oct 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408893; cv=none; b=TPwb9OsRT/7ypwcR0kftLn4jFiZpwsZKXAKi1Dw4ZGfWvS1a2kxv6i782OJui/IgkZJPr1Sev5VHQFFoYGnkW2oMQZ65kMrLB+DY69YM1m0y9Bw9fiplvD3jCQLT48evaUTMKeqvDKN/T8BkF+CHa5+r9eey23uON2XBKpVoyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408893; c=relaxed/simple;
	bh=Sa72g+/+++YpryrxfPg5VslBUSQzfQ/CjzT1VO5oNow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9wC/i5JKSXYkECpK0LCxV6Dhg+18cHQMWw71zsLUworglhZkNKwFc9gmo6KlD3dPH7EvulXw05EmOcUqfOo64f8Pug9EWYFp8wKhL3AOBbO10TTkbzmvu9lmo/WHL71qdiw1XDyvAzI3ilYAXhqDRnjzCpULS+19DnnzOIUXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6QfyUlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EBC4CEF5;
	Sat, 25 Oct 2025 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408892;
	bh=Sa72g+/+++YpryrxfPg5VslBUSQzfQ/CjzT1VO5oNow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6QfyUlmi3CziC/eYEjkKrNH3w6oci60IOBZ/2dqysgcrHEoUI/TnBCo6cBhK2rh1
	 SzO143ePWkHbj3dcUhXaIc+/0pnYdHdFXKQFWZ3Ls7aYSjnmmZY9bYB/IVMNFyuH3T
	 IBvDPkDmwCSF+yhx40sAexUOKhq4iU0FCBBbMu1fWeBL/tqWqFWWl8H1svcLdiNopP
	 GJZa3r+a1lIfM4zCyZM+px1wAJxGnhvJtVKEusi4MXP/YBFNvHG7tVP0yAkviwcF70
	 2PfnlpBj10Hs8GEbl+bufwW4Kl2l7ZNeumD+L4M7cFv/cxNBTyKNE+1HPIHlbGX36U
	 awnwC3VOnrnzg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sasha Levin <sashal@kernel.org>,
	gerald.schaefer@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] s390/pci: Use pci_uevent_ers() in PCI recovery
Date: Sat, 25 Oct 2025 11:55:48 -0400
Message-ID: <20251025160905.3857885-117-sashal@kernel.org>
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

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit dab32f2576a39d5f54f3dbbbc718d92fa5109ce9 ]

Issue uevents on s390 during PCI recovery using pci_uevent_ers() as done by
EEH and AER PCIe recovery routines.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Link: https://patch.msgid.link/20250807-add_err_uevents-v5-2-adf85b0620b0@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation
- What it changes
  - arch/s390/pci/pci_event.c: Adds uevent notifications to the s390 PCI
    error recovery path, mirroring existing AER/EEH behavior:
    - After driver’s error_detected() returns, emit a recovery-begin
      uevent: the patch inserts pci_uevent_ers(pdev, ers_res) in
      zpci_event_notify_error_detected() (arch/s390/pci/pci_event.c:85).
    - On recovery failure, emit FAILED_RECOVERY: the patch calls
      pci_uevent_ers(pdev, PCI_ERS_RESULT_DISCONNECT) in
      zpci_event_attempt_error_recovery()
      (arch/s390/pci/pci_event.c:178).
    - On recovery success, emit SUCCESSFUL_RECOVERY: the patch calls
      pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED) after an optional
      resume() in zpci_event_attempt_error_recovery()
      (arch/s390/pci/pci_event.c:178).
  - drivers/pci/pci-driver.c: Makes pci_uevent_ers() available when
    building for s390 by expanding the ifdef to include CONFIG_S390
    (drivers/pci/pci-driver.c:1591).
  - include/linux/pci.h: Similarly expands the prototype guard to
    include CONFIG_S390 so arch/s390 code can call it
    (include/linux/pci.h:2768).

- Why it matters (user-visible impact)
  - Brings s390 PCI recovery uevents to parity with AER and PowerPC EEH:
    - pci_uevent_ers() already emits ERROR_EVENT=BEGIN_RECOVERY /
      SUCCESSFUL_RECOVERY / FAILED_RECOVERY and DEVICE_ONLINE=0/1 to
      userspace (drivers/pci/pci-driver.c:1591).
    - AER and EEH already use these notifications; s390 previously did
      not. This omission prevents userspace from reacting consistently
      to PCI recovery events on s390 systems.
  - The change enables standard userspace tooling (udev rules,
    monitoring scripts) to receive the same recovery lifecycle events on
    s390 that they already get elsewhere, which can help automate
    remediation or logging. It’s a clear correctness/observability
    improvement, not a feature addition that changes kernel behavior.

- Scope and risk assessment
  - Small, contained change:
    - Adds three calls to pci_uevent_ers() in the s390 recovery path; no
      core recovery logic changed.
    - Only adjusts preprocessor guards to build pci_uevent_ers() for
      s390. No behavior change on non-s390.
  - Consistent with established patterns:
    - AER calls pci_uevent_ers() after error_detected() and on
      resume/failure; this patch mirrors that sequencing for s390.
  - Low regression risk:
    - Only additional KOBJ_CHANGE uevents are emitted during rare error
      recovery flows.
    - Calls occur under the same locking pattern used in AER (s390 uses
      pci_dev_lock/pci_dev_unlock, which wraps device_lock, consistent
      with AER’s device_lock usage), so no new locking hazards.
    - No ABI change; only adds uevents that other architectures already
      emit.

- Stable backport considerations
  - Dependencies: pci_uevent_ers() exists and is implemented in pci-
    driver.c (drivers/pci/pci-driver.c:1591) with a prototype in
    include/linux/pci.h (include/linux/pci.h:2768). Older stable series
    where pci_uevent_ers() lived in different guards may need the guard
    expansions this patch includes. For supported long-term series
    (4.19+, 5.4+, 5.10+, 5.15+, 6.1+), pci_uevent_ers() is already
    present; just ensure to add CONFIG_S390 to both the definition and
    the prototype guards as in this patch.
  - No major architectural changes; change is limited to s390 PCI
    recovery and one generic helper being compiled for s390.
  - While the commit message does not include Fixes:/Cc: stable tags,
    this is a correctness/behavior-parity fix affecting real userspace
    observability and is minimal risk, making it suitable for stable.

- Conclusion
  - This patch fixes a real behavioral gap on s390 by emitting standard
    PCI recovery uevents that already exist on other platforms. It is
    small, self-contained, and low risk, with clear user benefit. It
    should be backported to stable.

 arch/s390/pci/pci_event.c | 3 +++
 drivers/pci/pci-driver.c  | 2 +-
 include/linux/pci.h       | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index d930416d4c903..b95376041501f 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -88,6 +88,7 @@ static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 
 	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
+	pci_uevent_ers(pdev, ers_res);
 	if (ers_result_indicates_abort(ers_res))
 		pr_info("%s: Automatic recovery failed after initial reporting\n", pci_name(pdev));
 	else if (ers_res == PCI_ERS_RESULT_NEED_RESET)
@@ -244,6 +245,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		ers_res = PCI_ERS_RESULT_RECOVERED;
 
 	if (ers_res != PCI_ERS_RESULT_RECOVERED) {
+		pci_uevent_ers(pdev, PCI_ERS_RESULT_DISCONNECT);
 		pr_err("%s: Automatic recovery failed; operator intervention is required\n",
 		       pci_name(pdev));
 		status_str = "failed (driver can't recover)";
@@ -253,6 +255,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	pr_info("%s: The device is ready to resume operations\n", pci_name(pdev));
 	if (driver->err_handler->resume)
 		driver->err_handler->resume(pdev);
+	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
 	pci_dev_unlock(pdev);
 	zpci_report_status(zdev, "recovery", status_str);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6405acdb5d0f3..302d61783f6c0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1582,7 +1582,7 @@ static int pci_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH) || defined(CONFIG_S390)
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860d..7735acf6f3490 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2764,7 +2764,7 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
-#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH) || defined(CONFIG_S390)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
-- 
2.51.0


