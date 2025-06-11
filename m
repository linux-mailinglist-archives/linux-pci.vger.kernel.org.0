Return-Path: <linux-pci+bounces-29383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1CAD4728
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 02:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE953A853B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166CEBE;
	Wed, 11 Jun 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R/EKBSn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D818D;
	Wed, 11 Jun 2025 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600355; cv=none; b=D/opyKCWiBDjkBa+3vBQq3Nl2NDS1YssNzyXMQ+XqaPa1+JRePiNgjmCwuDtez6sddclDvl6H33OmGMicW+LE4Kaxdardf3bGppaO2XUhood//Oa3lOkV5RBZdDMxGWgvIPPrQybGGuB6FuNF4Zd+wcvN2F/Icamfyl7PgsM1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600355; c=relaxed/simple;
	bh=xrMPuWiNi/gejtKkOmDTuFDh4hly1QjLzqZNLt+Jw/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCxvqelE+gkGBvAOfWCdeCYJ5cDRxaTmpb5kEQhfZ5i2v7Lo5yU4tCQmEYKJcfWtYQYF2zogT6deaec689KdLFQhkW8tApnWr+n6w3EHoZJFrofE0DcWBPfqY0ppA4HRiXNr1QfPTWtQWR99RUGq/doW8ojWIxWW3XWiKQNSpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R/EKBSn+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-grwhy-1BDK8.redmond.corp.microsoft.com (unknown [70.37.26.40])
	by linux.microsoft.com (Postfix) with ESMTPSA id E98882115183;
	Tue, 10 Jun 2025 17:05:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E98882115183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749600354;
	bh=5VoXRwFp1c8WtDCCDppOEkR6jDKDxpkeb7vMY/1s3Lk=;
	h=From:To:Cc:Subject:Date:From;
	b=R/EKBSn+CF/W79rKED7Rk9jrfi4mwt9ltEy7hctDyQ46M658jhwdMYhEnM81E1TG2
	 9siGPTASSuPxnJNYjO5sEeDa5LT/W3xTUI+1oP9Klb8pU3pdq/004Af4XlnTCosUL4
	 4hIk01uIxyAfeRS+isKV2eQKKxpVhuzuBT/PQf10=
From: grwhyte@linux.microsoft.com
To: linux-pci@vger.kernel.org
Cc: shyamsaini@linux.microsoft.com,
	code@tyhicks.com,
	Okaya@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Date: Wed, 11 Jun 2025 00:05:50 +0000
Message-Id: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Graham Whyte <grwhyte@linux.microsoft.com>

Add a new flr_delay member of the pci_dev struct to allow customization of
the delay after FLR for devices that do not support immediate readiness
or readiness time reporting. The main scenario this addresses is VF
removal and rescan during runtime repairs and driver updates, which,
if fixed to 100ms, introduces significant delays across multiple VFs.
These delays are unnecessary for devices that complete the FLR well
within this timeframe.

Patch 1 adds the flr_delay member to the pci_dev struct
Patch 2 adds the msft device specific quirk to utilize the flr_delay

---
v2->v3:
- Removed Microsoft specific pcie reset reset, replaced with customizable flr_delay parameter
- Changed msleep in pcie_flr to usleep_range to support flr delays of under 20ms 
v1->v2:
- Removed unnecessary EXPORT_SYMBOL_GPL for function pci_dev_wait
- Link to thread:https://lore.kernel.org/linux-pci/?q=f%3Agrwhyte&x=t#m7453647902a1b22840f5e39434a631fd7b2515ce'

Link to V1: https://lore.kernel.org/linux-pci/20250522085253.GN7435@unreal/T/#m7453647902a1b22840f5e39434a631fd7b2515ce  

Graham Whyte (2):
  PCI: Add flr_delay parameter to pci_dev struct
  PCI: Reduce FLR delay to 10ms for MSFT devices

 drivers/pci/pci.c    |  8 ++++++--
 drivers/pci/pci.h    |  2 ++
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 include/linux/pci.h  |  1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.25.1


