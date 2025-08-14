Return-Path: <linux-pci+bounces-34074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E801B27081
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CD27AC10D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7F253B73;
	Thu, 14 Aug 2025 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luVafUmX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6B481DD;
	Thu, 14 Aug 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205324; cv=none; b=aAlSjnoAEaQtk06ldNyyUieKPIbU7OJme35Umu8BtpQ6wq63aH0r3t25YHUEcJ5fYJL3YBOnghy35MJcjKMbza/0Ltn86EQb7foW+Lu93Bd472z4GxDqbIhB2dp0Zeapxaq+aUxIdsihzSJFjWPhJaXa0Q8IuOEGlDfKxTtY4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205324; c=relaxed/simple;
	bh=SPIR3Nsw+5J3K3Ewb8jiZA+vLOjaQGkkApcnPTOLSPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TS5RWgGi4EK9cmZSETN1//GM3RjicSFwdsE1jVbjpLF1Jwc/bjZSQgOla+Lh1sL9uH5BKIf76/PhXgxeXmQYgRcvoCefRcJUIruBTWT3A2yOAqg+wCCuaDASbfwYIV8Nok8Ry04WzI20VkGkLsZGRtJ0TnMzcGrd84VdiXnjkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luVafUmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583E0C4CEED;
	Thu, 14 Aug 2025 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755205323;
	bh=SPIR3Nsw+5J3K3Ewb8jiZA+vLOjaQGkkApcnPTOLSPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=luVafUmXkK48Wbx3zLnbSoF++g69YJbKIO9NYmamezJOm9eb4seLzVQstBzNGEtfO
	 2tb9MfDmu2ynxCaA8bwbD9IExbjzQSMabId7s0712YeNhMxdWjH11pFUEJVLj6fcZI
	 PYZpHRCxxZGGO6WQ0VCvNFklMxQy/fnGkg1YHVtZ4ESyVP3vj7FQqbHEQaKHizFt4h
	 WU2uj6tLEHQADpYMtia9+/VAmUYTWr8mxEvS4reD6sbcqOagJfNaEOiD+2Y/uvUe0z
	 oHCe5NsVJe6CKIN+T13DhExo8jvcSQm927JqZRTxj9O5L5zoLZNN5esXiur6Bo+T/m
	 OooBs0t1hXnJQ==
Date: Thu, 14 Aug 2025 16:02:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 0/3] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Message-ID: <20250814210201.GA348169@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>

On Thu, Aug 07, 2025 at 03:55:37PM +0200, Niklas Schnelle wrote:
> Hi Bjorn, Lukas, Mahesh,
> 
> This series adds issuing of uevents during PCI recovery on s390. In
> developing this I noticed that pci_uevent_ers() ignores
> PCI_ERS_RESULT_NEED_RESET. I think this will result in AER not generating a uevent
> at the beginning of recovery if drivers request a reset via the voting
> on error_detected() returns. This is fixed in the first patch and relied
> upon by the s390 recovery code as it also uses the result of
> error_detected() though with one device/driver at a time.
> 
> Thanks,
> Niklas
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Changes in v5:
> - Add R-b from Lukas Wunner for EEH
> - Improve commit message for EEH (Lukas Wunner)
> - Move the EEH patch to the end so the reference to s390 relies on the
>   as is and not future state ;)
> - Link to v4: https://lore.kernel.org/r/20250807-add_err_uevents-v4-0-c624bfd8638d@linux.ibm.com
> 
> Changes in v4:
> - Add change in EEH to use the return of error_detected() in the uevent
>   just like AER and the new s390 code
> - Add R-b from Lukas
> - Link to v3: https://lore.kernel.org/r/20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com
> 
> Changes in v3:
> - Reworded cover letter
> - Rebase on v6.16
> - Link to v2: https://lore.kernel.org/r/20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com
> 
> Changes in v2:
> - Add a patch fixing pci_uevent_ers() mistakenly ignoring PCI_ERS_RESULT_NEED_RESET
> - Use the result of error_detected() for initial pci_uevent_ers()
> - Drop fixes tag in s390 patch
> - Rebase and re-test on current master
> - Link to v1: https://lore.kernel.org/r/20250424-add_err_uevents-v1-1-3384d6b779c6@linux.ibm.com
> 
> ---
> Niklas Schnelle (3):
>       PCI/AER: Fix missing uevent on recovery when a reset is requested
>       PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI recovery
>       powerpc/eeh: Use result of error_detected() in uevent
> 
>  arch/powerpc/kernel/eeh_driver.c | 2 +-
>  arch/s390/pci/pci_event.c        | 3 +++
>  drivers/pci/pci-driver.c         | 3 ++-
>  include/linux/pci.h              | 2 +-
>  4 files changed, 7 insertions(+), 3 deletions(-)

Applied on pci/aer for v6.18, thanks!  This on top of Lukas's series:

  https://lore.kernel.org/all/cover.1755008151.git.lukas@wunner.de/

Expect the whole branch to be rebased to add Reviewed-by, etc.

