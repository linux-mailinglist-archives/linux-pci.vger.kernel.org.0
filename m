Return-Path: <linux-pci+bounces-11136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7294529E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 20:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4D4284A0F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08044148FE6;
	Thu,  1 Aug 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz5l7dUK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6414884E;
	Thu,  1 Aug 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536117; cv=none; b=tPqP8vTy/0JOhNEtymbtP+/bN43lRuRNUTnK5r9ZErXLEPlo/uCFXK+CwPQF+duXU2zP2o5JgMXryYRQroLcLhfmBXCQ3mSgz4vuumYqFyaEuG3/ZrRqv+Bwc8193JxiDVMfMIXIfDxle9sc3IKMRWxhzJqNsptLt105jQGspSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536117; c=relaxed/simple;
	bh=5znrj0EhunF6k3XbmNw8kPtsm/aXgUILrMyz5SSUYe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OqPQcaZKUo2udbCajRdMPX/8D68DY4qLst4yaLEjPBtJMf+2aVe8sxoH6RgM1bLKyc7rHApS/6DquHu2ZPxuFRLnWtC2qsz45DyepqP8YODGNv7sWr6mUITLIHEM1BACVXfVqxfyfKCGUbKrLnjalycyEa3jOaFV4UGA7mRV7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz5l7dUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0412AC4AF0D;
	Thu,  1 Aug 2024 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722536117;
	bh=5znrj0EhunF6k3XbmNw8kPtsm/aXgUILrMyz5SSUYe4=;
	h=Date:From:To:Cc:Subject:From;
	b=iz5l7dUKFHc1K8g+lB3hienFaMQE36/5Z4RCxgi2wzFvq0+Jtx7ng/mCBg+df63Ou
	 mUkzte9ScFCEIYmeCox1Njx0Ji40KTvUIh+FaTKQ0/QS8LMnLdBvI/TykPBOMBy4H1
	 NPMft2xmslMwgsBBXplLp+MD7rLEEV7yzplaxJaMHn/0aFOWdwussQ7Yj+kE140v56
	 quGSEULuY32e/Vy9ScQ3oZ/z/H3RcSCF42LeHiHkOtiXQ6kyx8TPE2tzUBkroYqD0o
	 asDqIIAxqpIfOGD2NP9boZgMKIVjoMsGb912RjvSS5Y9F36UDA/0byrweyw2IPaSQ6
	 EQPo3BQkPaI7A==
Date: Thu, 1 Aug 2024 13:15:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Blazej Kucman <blazej.kucman@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v6.11
Message-ID: <20240801181514.GA112131@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-fixes-1

for you to fetch changes up to 5560a612c20d3daacbf5da7913deefa5c31742f4:

  PCI: pciehp: Retain Power Indicator bits for userspace indicators (2024-08-01 12:58:03 -0500)

N.B. These have been in linux-next since July 26; I updated the commit logs
today to add a Tested-by and an error message.

----------------------------------------------------------------
- Fix a pci_intx() regression that caused driver reload to fail with
  "Resources present before probing" (Philipp Stanner)

- Fix a pciehp regression that clobbered the upper bits of RAID status LEDs
  on NVMe devices behind an Intel VMD (Blazej Kucman)

----------------------------------------------------------------
Blazej Kucman (1):
      PCI: pciehp: Retain Power Indicator bits for userspace indicators

Philipp Stanner (1):
      PCI: Fix devres regression in pci_intx()

 drivers/pci/hotplug/pciehp_hpc.c |  4 +++-
 drivers/pci/pci.c                | 15 ++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

