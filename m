Return-Path: <linux-pci+bounces-33581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B0FB1DF0B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75F91882646
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EFC282FA;
	Thu,  7 Aug 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heOOZV2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52124B29;
	Thu,  7 Aug 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603157; cv=none; b=uE99LOloifvA64hPLqfGkMkPsFHNgGbXkmT+h5B8XvYzkaLXS9Vks6IPzJb9MhTdzGR2nIYhosqCskXLv0yCBtNS1YXdEuevZafkrGmPSmayFCM9FKdqj5ttW2bubK+lvGj3MXINNWwKeiputnAX70xP4counErdpaOYJHqg/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603157; c=relaxed/simple;
	bh=L+NVF+13JGNJ3SpYwk9loHGdcV3JgX/IGVOXLZzuTfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iLX1I1bihXtkuAHNjMFyrk1hfE867kZA5oxjgDfqeuDVr5ae/IbCeW+J3EMFtcNtgVcqcIaS7mclHHpr6kgjTeGjwAj2fLXvueDoPaUNYulAoKDKuJmX6djWbd4zeFAEYuI42P3uLgwhzFoJOzVdSic0OHm51vU3PQyh3Fv0aLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heOOZV2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115ABC4CEEB;
	Thu,  7 Aug 2025 21:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754603157;
	bh=L+NVF+13JGNJ3SpYwk9loHGdcV3JgX/IGVOXLZzuTfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=heOOZV2a83lmdFL5bz1KDJ5ite60lE0S8k5/wfaozDWClL5eEKb2bljH34aAk8Q6K
	 nZ1YbhteXS+n3GPaIk/qdLyFjHL1H5n9pPFDuAyQe+aNu5hD5SH0H6u1aO26munw0m
	 AhF65+g8i56YXA57CCwdBxc+9ai/a3u/R6g6+EMNyE+0qQz5oZQR2x1S1AR0Stvc/6
	 +LpgtOvczEQpH5Y2yTrmmHXMye6pHUEeoJIhQitSGua7mAV/rLvPfSQRwMY0LdWF8+
	 Ym7diOR228PwuWX0YsOqupBF3REe50ULO0OJ/puvzI+JcUASHMwlyjfihttb9gW6N8
	 ryjlwihN7bHxA==
Date: Thu, 7 Aug 2025 16:45:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Message-ID: <20250807214555.GA63946@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-6-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:53AM -0700, Dan Williams wrote:
> Establish just enough emulated PCI infrastructure to register a sample
> TSM (platform security manager) driver and have it discover an IDE + TEE
> (link encryption + device-interface security protocol (TDISP)) capable
> device.
> 
> Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
> port, and open code the emulation of an endpoint device via simulated
> configuration cycle responses.

s/existing a/existing/

> The devsec_tsm driver responds to the PCI core TSM operations as if it
> successfully exercised the given interface security protocol message.
> 
> The devsec_bus and devsec_tsm drivers can be loaded in either order to
> reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
> cases like TDX Connect where the TSM is a software agent running on the
> host CPU.
> 
> Follow-on patches add common code for TSM managed IDE establishment. For
> now, just successfully complete setup and teardown of the DSM (device
> security manager) context as a building block for management of TDI
> (trusted device interface) instances.
> 
>  # modprobe devsec_bus
>     devsec_bus devsec_bus: PCI host bridge to bus 10000:00
>     pci_bus 10000:00: root bus resource [bus 00-01]
>     pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
>     pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
>     pci 10000:00:00.0: PCI bridge to [bus 00]
>     pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
>     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>     pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>     pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
>     pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
>     pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
>     pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
>     pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
>     pci 10000:00:00.0: PCI bridge to [bus 01]
>     pci_bus 10000:01: busn_res: [bus 01] end is updated to 01

Most of these messages don't seem relevant to DSM/TDISP/etc.  It
*would* be useful to have a hint about what specifically makes this an
IDE + TEE device.  Capability visible via lspci?  Are devices at both
ends required, e.g., a Root Port and an Endpoint?

Oooh, I see (finally).  This hierarchy is all totally fabricated, no
actual hardware involved at all.  You did say that above; it just took
a while to sink in.

>  # modprobe devsec_tsm
>     devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
>     __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach

s/tsm/TSM/ in the message
s/ide/IDE/
s/tee/TEE/

Looks like spurious spaces inside parens?

> + * The expectation is the helpers referenceed are convenience "library"

s/referenceed/referenced/

