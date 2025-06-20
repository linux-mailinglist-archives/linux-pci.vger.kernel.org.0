Return-Path: <linux-pci+bounces-30222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BEDAE116E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 04:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24CD1BC1E55
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38E1C6FF6;
	Fri, 20 Jun 2025 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFeEyTcK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582C1BEF77;
	Fri, 20 Jun 2025 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388138; cv=none; b=CRDNYNQJvhXiPXMmtJDzcsGOD18MA7hJIG8UBryIhptXsVe0kU4SrFLd93HWR5H0LWo1JKj8U4MEq73csRZYI71WZbc18a95r0gouV+//SSNatLt6Ca139OPqTxHVJScxKPawZC3rMDRbeQ26Ot1Vf2tLJCyYsDPft5mzMfDx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388138; c=relaxed/simple;
	bh=khwsZciLm67e+YcdaFun01XDJAxstzMnwavStsqulIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9XVzZXpY+Eh8QlcFq/ABNsdwBKmKHi2HT6zGUUssYRgQ2zNtC+Qvue6Y2gnQ6Z4Werlz76fYOLEfEr3WoxK6NKxj5G7rbLg4HIwh6d1oEDtGRsp7epG7mEewoV4KrzVlowPsGiBMTGkYzaI2uWD7BStKriJI2oEIjVhZDZ6JVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFeEyTcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C844C4CEEA;
	Fri, 20 Jun 2025 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750388138;
	bh=khwsZciLm67e+YcdaFun01XDJAxstzMnwavStsqulIc=;
	h=From:To:Cc:Subject:Date:From;
	b=RFeEyTcKBc+AEB3MIx6/2r5LiYwQgWaAYnCRV2cw88nY79zSSEG64rJtbgp5tWVCd
	 RFaz+w8M9Ob1ibsxNCpymWLu3+hBbR9u3LHveMi/vdBiMJNTBKsYCsrAqxw1Cocu/r
	 wJyK7viTO2lGvOjFEDyZAIfAMvX9S6OGPPtlqjrqGBxYJPYgpzr6fmggSK9FBdp4cP
	 yYnDXjCdC4HQYxgam23uXkeyFq+4IdGHlUo5wSnbjWSdLwqQ+HLOM0xqJRuhuK3JSP
	 Bk1QZ/Pa41T5+MXrK6gJgTTW3Mk/79ndYRYoQy2or5sYKesWlG/5wvuUWb3K/iieeL
	 /7oyroTw7RR7g==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/2] Don't make noise about disconnected USB4 devices
Date: Thu, 19 Jun 2025 21:55:33 -0500
Message-ID: <20250620025535.3425049-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 or TBT3 dock is disconnected a lot of warnings and errors
are emitted related to the PCIe tunnels in the dock.

The messages are loud, but it's mostly because the functions that
emit the messages don't check whether the device is actually alive.
The PCIe hotplug services mark the device disconnected, so that
can be used to avoid an unnecessary wakeup on a disconnected device.

There is also a case of a runtime PM imbalance from this situation that
is fixed.

v2: https://lore.kernel.org/linux-pci/20250616192813.3829124-1-superm1@kernel.org/

Mario Limonciello (2):
  PCI/PM: Skip resuming to D0 if disconnected
  PCI: Fix runtime PM usage count underflow on device unplug

 drivers/pci/pci-driver.c | 3 ---
 drivers/pci/pci.c        | 5 +++++
 drivers/pci/pci.h        | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


