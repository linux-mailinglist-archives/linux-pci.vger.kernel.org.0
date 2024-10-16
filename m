Return-Path: <linux-pci+bounces-14698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538349A14CF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 23:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190DE283F1D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4601D2F4E;
	Wed, 16 Oct 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drs8pGkB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980A1D2F46;
	Wed, 16 Oct 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114310; cv=none; b=sJipab2vHMq4n1QLpKvfnDNJzp82Li2vyJGjrZ5fsXhORdQEiaTpGKTXaB5H+5tPkovk8NsyRMABje4BIYIqpLD05GFZkrBFX9w4qeAwTv1yid24VKGAFd66wBpJDKLfm6KCdvcCVkE30zXu8uQFX/7q8UrO4E/lp5BIihA0HcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114310; c=relaxed/simple;
	bh=LKS5wFCryk8nvA/PuXtU12vWsDsxmgbPYgdw+kVDHOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gs/FRLHO42VJ+g757jtLIlhJGUxd6SYp9M8xYBPANkwE8x74m8UaC/tHQXeHRfgqDF4b4HEdR8FoBaGsXSpnnF/eXxcJXmgmbliIgigh+DPXEfZPOl860fI8ULkChjr9yt6fMwJwDFqpInKe6PoIp9jRnQs/yd4NC3svKvFatx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drs8pGkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD741C4CEC5;
	Wed, 16 Oct 2024 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729114310;
	bh=LKS5wFCryk8nvA/PuXtU12vWsDsxmgbPYgdw+kVDHOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=drs8pGkBOqU0OhXFcKi1/4M7BGdYkGqrtoEpbkKDbVDq+NklcyXrCc2kw69YVAvmi
	 2jG+RyvXU8MRDJBQbpRaRg+U4iZ/pS0O6NqhdXVxRenkru85EOV+yh/rz+ZoCZt6EQ
	 BpLuE1GpWLWlS2rFKu3/REejYqdQTsWxrM/mSqOwxSXslDVnh8p4ixCGENbDrnWskS
	 6fUYy6Bixw6i9+gFXi7+yU+ExFyPY3XUzRiF1IpyejhRR0XT8KRVMfQnKwGrnQpCpf
	 ecX0weQvoPsHjHTHmj1VCOyPonKMnEp17bjoTfJyZk3R9yv9jW2BtQWbYYL40EiovG
	 J6YWdKz6noHRQ==
Date: Wed, 16 Oct 2024 16:31:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V7 0/5] TPH and cache direct injection support
Message-ID: <20241016213148.GA650694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002213555.GA279877@bhelgaas>

On Wed, Oct 02, 2024 at 04:35:55PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 02, 2024 at 11:59:49AM -0500, Wei Huang wrote:
> > Hi All,
> > 
> > TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
> > devices to provide optimization hints for requests that target memory
> > space. These hints, in a format called steering tag (ST), are provided
> > in the requester's TLP headers and allow the system hardware, including
> > the Root Complex, to optimize the utilization of platform resources
> > for the requests.
> > 
> > Upcoming AMD hardware implement a new Cache Injection feature that
> > leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
> > Coherent DMA writes directly into an L2 within the CCX (core complex)
> > closest to the CPU core that will consume it. This technology is aimed
> > at applications requiring high performance and low latency, such as
> > networking and storage applications.
> > 
> > This series introduces generic TPH support in Linux, allowing STs to be
> > retrieved and used by PCIe endpoint drivers as needed. As a
> > demonstration, it includes an example usage in the Broadcom BNXT driver.
> > When running on Broadcom NICs with the appropriate firmware, it shows
> > substantial memory bandwidth savings and better network bandwidth using
> > real-world benchmarks. This solution is vendor-neutral and implemented
> > based on industry standards (PCIe Spec and PCI FW Spec).
> > 
> > V6->V7:
> >  * Rebase on top of the latest pci/main (6.12-rc1)
> >  * Fix compilation warning/error on clang-18 with w=1 (test robot)
> >  * Revise commit messages for Patch #2, #4, and #5 (Bjorn)
> >  * Add more _DSM method description for reference in Patch #2 (Bjorn)
> >  * Remove "default n" in Kconfig (Lukas)
> > 
> > V5->V6:
> >  * Rebase on top of pci/main (tag: pci-v6.12-changes)
> >  * Fix spellings and FIELD_PREP/bnxt.c compilation errors (Simon)
> >  * Move tph.c to drivers/pci directory (Lukas)
> >  * Remove CONFIG_ACPI dependency (Lukas)
> >  * Slightly re-arrange save/restore sequence (Lukas)
> > 
> > V4->V5:
> >  * Rebase on top of net-next/main tree (Broadcom)
> >  * Remove TPH mode query and TPH enabled checking functions (Bjorn)
> >  * Remove "nostmode" kernel parameter (Bjorn)
> >  * Add "notph" kernel parameter support (Bjorn)
> >  * Add back TPH documentation (Bjorn)
> >  * Change TPH register namings (Bjorn)
> >  * Squash TPH enable/disable/save/restore funcs as a single patch (Bjorn)
> >  * Squash ST get_st/set_st funcs as a single patch (Bjorn)
> >  * Replace nic_open/close with netdev_rx_queue_restart() (Jakub, Broadcom)
> > 
> > V3->V4:
> >  * Rebase on top of the latest pci/next tree (tag: 6.11-rc1)
> >  * Add new API functioins to query/enable/disable TPH support
> >  * Make pcie_tph_set_st() completely independent from pcie_tph_get_cpu_st()
> >  * Rewrite bnxt.c based on new APIs
> >  * Remove documentation for now due to constantly changing API
> >  * Remove pci=notph, but keep pci=nostmode with better flow (Bjorn)
> >  * Lots of code rewrite in tph.c & pci-tph.h with cleaner interface (Bjorn)
> >  * Add TPH save/restore support (Paul Luse and Lukas Wunner)
> > 
> > V2->V3:
> >  * Rebase on top of pci/next tree (tag: pci-v6.11-changes)
> >  * Redefine PCI TPH registers (pci_regs.h) without breaking uapi
> >  * Fix commit subjects/messages for kernel options (Jonathan and Bjorn)
> >  * Break API functions into three individual patches for easy review
> >  * Rewrite lots of code in tph.c/tph.h based (Jonathan and Bjorn)
> > 
> > V1->V2:
> >  * Rebase on top of pci.git/for-linus (6.10-rc1)
> >  * Address mismatched data types reported by Sparse (Sparse check passed)
> >  * Add pcie_tph_intr_vec_supported() for checking IRQ mode support
> >  * Skip bnxt affinity notifier registration if
> >    pcie_tph_intr_vec_supported()=false
> >  * Minor fixes in bnxt driver (i.e. warning messages)
> > 
> > Manoj Panicker (1):
> >   bnxt_en: Add TPH support in BNXT driver
> > 
> > Michael Chan (1):
> >   bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
> > 
> > Wei Huang (3):
> >   PCI: Add TLP Processing Hints (TPH) support
> >   PCI/TPH: Add Steering Tag support
> >   PCI/TPH: Add TPH documentation
> > 
> >  Documentation/PCI/index.rst                   |   1 +
> >  Documentation/PCI/tph.rst                     | 132 +++++
> >  .../admin-guide/kernel-parameters.txt         |   4 +
> >  Documentation/driver-api/pci/pci.rst          |   3 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  91 ++-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   7 +
> >  drivers/pci/Kconfig                           |   9 +
> >  drivers/pci/Makefile                          |   1 +
> >  drivers/pci/pci.c                             |   4 +
> >  drivers/pci/pci.h                             |  12 +
> >  drivers/pci/probe.c                           |   1 +
> >  drivers/pci/tph.c                             | 546 ++++++++++++++++++
> >  include/linux/pci-tph.h                       |  44 ++
> >  include/linux/pci.h                           |   7 +
> >  include/uapi/linux/pci_regs.h                 |  37 +-
> >  net/core/netdev_rx_queue.c                    |   1 +
> >  16 files changed, 890 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/PCI/tph.rst
> >  create mode 100644 drivers/pci/tph.c
> >  create mode 100644 include/linux/pci-tph.h
> 
> I tentatively applied this on pci/tph for v6.13.
> 
> Not sure what you intend for the bnxt changes, since they depend on
> the PCI core changes.  I'm happy to merge them via PCI, given acks
> from Michael and an overall network maintainer.

Given the ongoing discussion about the bnxt_en patches, I dropped
those, so the PCI tree pci/tph branch now contains only these:

  e045e5c1c706 ("PCI/TPH: Add TPH documentation")
  d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
  f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")

This is headed for v6.13, but the branch should not be considered
immutable, and it may be merged during the merge window either before
or after the netdev tree.

Bjorn

