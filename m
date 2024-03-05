Return-Path: <linux-pci+bounces-4537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DDD8729A6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65D81F2337D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B212B177;
	Tue,  5 Mar 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHiuENwA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31926AD0;
	Tue,  5 Mar 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675218; cv=none; b=D3795pQhh1OpPwS9G+fHfwXeywcPNfyKHPZxbe9Nh31oo4E3o3PUq8O4OcE0gUaNkSpkiW//V4FNixOIjXGw1QZsgyu9711QSCMQ7ePWMl8CcZq98lkLxWBAuK8p8N0qVgbuANLylP2g8TiHNbxMpka/Z/wRQk5eLh9gokfs+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675218; c=relaxed/simple;
	bh=OD6AI2U1UEuP5wU1R3uEeYZuHVK+Wompw+JThsAf25I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iy2rHFbVVVQrMi1QNvjwWAr8F5Id2t+GGRWdQOog6TcX0FbucqGeybWuk9qfG9YnQt4Y6o6p39mycr4d3p+DrxSi0X9B3e3Xvbp8UMEJf33eGW+1rgemAt4N6pa3iYsxLlxVJ5ctOVaD7WbZEG4dNJAeqWHT48J2uD7REQqHWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHiuENwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF473C433C7;
	Tue,  5 Mar 2024 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709675218;
	bh=OD6AI2U1UEuP5wU1R3uEeYZuHVK+Wompw+JThsAf25I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eHiuENwAYxHUsepW+xTvgywZLlprjoNJMN0yJ3UUR0k+RwcLSA3OMNud8SVKsZMg2
	 fE0cePXaknQfgYbddSWDI/dEWFhdn3PeYnt3baR3ewYOCHFmUchCC1dDMZG2TIQ6R6
	 A3dJ7UyHnCKlPWjglDFP2kl5pA3YdZuUHShwNHl7nhcL3D6OKXDWPxyz6M7ASE6xwN
	 6JqOrHqyF4jaMMw1SOWM0irCg7K372zEZdMQd294aZyxr6+60n4oCu1wKmJvMotCl0
	 mqGb4AdZBjFiAJM3Clx399ATS7lJdrlyal2PzRx9VbcnuIQ/1RwlpvDenzW40ZUaZf
	 5vf3aAMwPbEcg==
Date: Tue, 5 Mar 2024 15:46:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 0/5] PCI/ASPM: Save/restore L1 PM Substates for
 suspend/resume
Message-ID: <20240305214656.GA550701@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223205851.114931-1-helgaas@kernel.org>

On Fri, Feb 23, 2024 at 02:58:46PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is some rework of David's series to preserve ASPM L1 substate
> configuration across suspend/resume.
> 
> We've had several attempts to make this work:
> 
>   (unlabeled): https://lore.kernel.org/r/20240128233212.1139663-1-david.e.box@linux.intel.com
>   v5: https://lore.kernel.org/r/20231221011250.191599-1-david.e.box@linux.intel.com
>   v4: https://lore.kernel.org/all/20231002070044.2299644-1-mika.westerberg@linux.intel.com/
>   v3: https://lore.kernel.org/linux-pci/20230925074636.2893747-1-mika.westerberg@linux.intel.com/
>   v2: https://lore.kernel.org/linux-pci/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
>   v1: https://lore.kernel.org/linux-pci/20230627062442.54008-1-mika.westerberg@linux.intel.com/
> 
> The most recent posting is the unlabeled one mentioned above, and I'm
> calling it v6 and this rework v7.
> 
> Changes since the unlabeled v6:
> 
>   - Rename pci_save_aspm_state() to pci_save_aspm_l1ss_state() (this
>     is the reason for opening this again, because Vidya's patch [1]
>     had to do some incidental renaming).
> 
>   - Rename pcie_restore_aspm_l1ss() to pci_restore_aspm_l1ss_state()
>     to match.
> 
>   - Move the PCI_EXP_LNKCTL_ASPMC from pci_restore_aspm_state() to
>     pci_restore_pcie_state() so both writes are in the same place.
> 
>   - Rename pci_aspm_get_l1ss() to pci_configure_aspm_l1ss() and add
>     the save_buffer there as well.
> 
>   - Split [1/5] into two patches: move pci_configure_ltr() and
>     pci_bridge_reconfigure_ltr() to aspm.c, and build aspm.c
>     unconditionally.
> 
>   - Squash [2/5] and [3/5] since [2/5] didn't add any functionality
>     itself so they seem like a single logical change.
> 
> [1] https://lore.kernel.org/r/20230125133830.20620-1-vidyas@nvidia.com
> 
> David E. Box (5):
>   PCI/ASPM: Move pci_configure_ltr() to aspm.c
>   PCI/ASPM: Always build aspm.c
>   PCI/ASPM: Move pci_save_ltr_state() to aspm.c
>   PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
>   PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()
> 
>  drivers/pci/pci.c         |  89 ++++------------
>  drivers/pci/pci.h         |  13 ++-
>  drivers/pci/pcie/Makefile |   2 +-
>  drivers/pci/pcie/aspm.c   | 215 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |  62 +----------
>  include/linux/pci.h       |   2 +-
>  6 files changed, 252 insertions(+), 131 deletions(-)

I applied these as pci/aspm for v6.9, replacing the original unlabeled
v6 that has been in -next.

I also added the patch I suggested at
https://lore.kernel.org/r/20240223213733.GA115410@bhelgaas to disable
L1 inside pci_restore_aspm_l1ss_state() where we actually depend on it
being disabled.

Bjorn

