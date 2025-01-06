Return-Path: <linux-pci+bounces-19346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64158A02DCB
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA3C188189D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304C166F1B;
	Mon,  6 Jan 2025 16:31:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491819B5AC;
	Mon,  6 Jan 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181061; cv=none; b=cjLbtSZ+VuwXpLd5R7sqtZHmovjA/4QBTxfgtCkiu967JFcYTLcurrxH02uNnOpRifb/PyvSUrQNpxOWCfTJkgmRvtNRZ++lRgJ+X1ae27WyCCZF0PWKw+WXbBKWYbvuQc6mdkuTcvDorU1HtVXBUQLyiHwwc4mS6N6Un3q1xUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181061; c=relaxed/simple;
	bh=fiYhWWUEkQtXWQl7GF36gYeh48y8NdsFHycng1jlbNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jCKibl2mfabc/Rem4OhO3Nmj6J9kN24PMHEYZWqaQYiF2i/6TxI8jlOXQtKK6/YGSiVejCPpKPSmnBtk3qxanAvkBTefH133FE/DkV3u8/0e5YF7sQJwARWvFYQK/KWDlfs05EX+4K5BiBdTvb+y1NIszQOM9rML/YWBYUoYKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B4F3143D;
	Mon,  6 Jan 2025 08:31:25 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com [10.118.91.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E01053F673;
	Mon,  6 Jan 2025 08:30:56 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	bhelgaas@google.com
Cc: wei.huang2@amd.com,
	honnappa.nagarahalli@arm.com,
	dhruv.tripathi@arm.com,
	rob.herring@arm.com,
	jeremy.linton@arm.com,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC 0/2] GENL interface for ACPI _DSM methods
Date: Mon,  6 Jan 2025 16:30:43 +0000
Message-ID: <20250106163045.508959-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linux v6.13-rc1 added support for PCIe TPH and direct cache injection.
As already described in the patch set[1] that introduced this feature,
the cache injection in supported hardware allows optimal utilization of
platform resources for specific requests on the PCIe bus. However, the
patch set [1] implements the functionality for usage within the kernel.
But certain user space applications, especially those whose performance
is sensitive to the latency of inbound writes as seen by a CPU core, may
benefit from using this information (E.g., the DPDK cache stashing
feature discussed in RFC [2]). This RFC is an attempt to obtain the PCIe
steering tag information from the kernel to be used by user mode
applications. We understand that there is more than one way to provide
this information. Please review and suggest alternatives if necessary.

The first of the two patches introduced in this RFC attempts to overcome
the kernel-only limitation by providing an API to kernel subsystems to
hook up relevant _DSM methods to a GENL interface. User space
applications can invoke a _DSM hooked up to this interface via the
"acpi-event" GENL family socket, granted they have the minimum
capabilities and message formats demanded by the kernel subsystem that
hooked up the _DSM method. This feature is added by extending the
"acpi-event" GENL family that multicasts ACPI events to the user-space
applications such as acpid.

The second patch of this RFC hooks up the PCIe root-port TLP Processing
Hints (TPH) _DSM to the ACPI GENL interface. User space applications
like [2] can now request the kernel to execute the _DSM on their behalf
and return steering-tag information.

[1] lore.kernel.org/linux-pci/20241002165954.128085-1-wei.huang2@amd.com
[2] inbox.dpdk.org/dev/20241021015246.304431-2-wathsala.vithanage@arm.com

Wathsala Vithanage (2):
  ACPI: Add support for invoking select _DSM methods from user space
  PCI: Add generic netlink interface to TPH _DSM

 drivers/acpi/Makefile                 |   3 +-
 drivers/acpi/{event.c => acpi_genl.c} | 110 ++++++++++++++++++++++-
 drivers/acpi/acpi_genl_dsm.c          |  76 ++++++++++++++++
 drivers/pci/tph.c                     | 121 ++++++++++++++++++++++++++
 include/acpi/acpi_genl.h              |  54 ++++++++++++
 include/linux/acpi.h                  |   1 +
 6 files changed, 360 insertions(+), 5 deletions(-)
 rename drivers/acpi/{event.c => acpi_genl.c} (63%)
 create mode 100644 drivers/acpi/acpi_genl_dsm.c
 create mode 100644 include/acpi/acpi_genl.h

-- 
2.43.0


