Return-Path: <linux-pci+bounces-28824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082BCACBC9F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 23:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1031722D1
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A0170A26;
	Mon,  2 Jun 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4m/SaHE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14733165F16;
	Mon,  2 Jun 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748898827; cv=none; b=NUCgdzZOVahDaUDUD/Qz73r67Sl6584QT+q14ROLVWS5hFSdp/VGGTUqLCjYF9+2k+Xz08yWybMD1lzTjlXVNGTAszteUngs3Wx7okrw3/4Pak/YK8+zhnlVvsr7qWAAgrwFq0AJsc3q0Ijy94LdeaWtKLXgSkG3GOrAtO2ljB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748898827; c=relaxed/simple;
	bh=8USxg6SA8nGz3BAkEuYuS+4+eTJ3BHPZ/Z14aMgD5Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cxEca7mC8CYAXRIwohECes1hmdIg/TVfZjZF8mbcKoeTHbRlodeAN5ShQ5eaFHMWQb72wkrYZMOqyuvP70t88q6orCtRdHa2zB35lASViRYg826kYgjqBUOwtfJmSYaCEiqxJSuIxQJbGpd9v0F/xKk2UhZcq5mnpMqtCEdLuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4m/SaHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39042C4CEEB;
	Mon,  2 Jun 2025 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748898826;
	bh=8USxg6SA8nGz3BAkEuYuS+4+eTJ3BHPZ/Z14aMgD5Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m4m/SaHE8iFG6uTm85JTtjtTJIE+XALUYhiJDLcsNKo6erXpfFaE2eoftIUOtZb2i
	 2kGm4VUL7Ua/7F6a5U5aUqNink/ou4zhQ4Or1Zu7AYGVnh/ZWeSI0pyfMn30WRcQ31
	 EE7y5jSxfu0sLgGiQqM9pTqNQCecm9dKrsuKXEXhC3Td41Cj2aNiNv4pF6GrK5lFa1
	 EfDIsfRClEIUokRxgztxTyzmeHqtr5VVVhoTie87u7ngMqCcxERT0Ht1Aso+2l0gf8
	 q5ypX9vO9UXttxSnq3oiYxYVfj8lsLtaHE1ephK+mkINFt6bB+xtQFBwk5k3E3s4sO
	 ZFsT1JqbxJN6A==
Date: Mon, 2 Jun 2025 16:13:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, dingwei@marvell.com,
	cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <20250602211344.GA444082@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bixtbu7hzs5rwrgj22ff53souxvpd7vqysktpcnxvd66jrsizf@pelid4rjhips>

On Fri, May 30, 2025 at 09:39:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 30, 2025 at 06:34:04AM -0500, Bjorn Helgaas wrote:
> > On Fri, May 30, 2025 at 09:16:59AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, May 28, 2025 at 05:35:00PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, May 08, 2025 at 12:40:33PM +0530, Manivannan Sadhasivam wrote:
> > > > > The PCI link, when down, needs to be recovered to bring it back. But that
> > > > > cannot be done in a generic way as link recovery procedure is specific to
> > > > > host bridges. So add a new API pci_host_handle_link_down() that could be
> > > > > called by the host bridge drivers when the link goes down.
> > > > > 
> > > > > The API will iterate through all the slots and calls the pcie_do_recovery()
> > > > > function with 'pci_channel_io_frozen' as the state. This will result in the
> > > > > execution of the AER Fatal error handling code. Since the link down
> > > > > recovery is pretty much the same as AER Fatal error handling,
> > > > > pcie_do_recovery() helper is reused here. First the AER error_detected
> > > > > callback will be triggered for the bridge and the downstream devices. Then,
> > > > > pci_host_reset_slot() will be called for the slot, which will reset the
> > > > > slot using 'reset_slot' callback to recover the link. Once that's done,
> > > > > resume message will be broadcasted to the bridge and the downstream devices
> > > > > indicating successful link recovery.
> > > > 
> > > > Link down is an event for a single Root Port.  Why would we iterate
> > > > through all the Root Ports if the link went down for one of them?
> > > 
> > > Because on the reference platform (Qcom), link down notification is
> > > not per-port, but per controller. So that's why we are iterating
> > > through all ports.  The callback is supposed to identify the ports
> > > that triggered the link down event and recover them.
> > 
> > Maybe I'm missing something.  Which callback identifies the port(s)
> > that triggered the link down event?
> 
> I was referring to the host_bridge::reset_root_port() callback that resets the
> root ports.
> 
> >  I see that
> > pci_host_handle_link_down() is called by
> > rockchip_pcie_rc_sys_irq_thread() and qcom_pcie_global_irq_thread(),
> > but I don't see the logic that identifies a particular Root Port.
> > 
> > Per-controller notification of per-port events is a controller
> > deficiency, not something inherent to PCIe.  I don't think we should
> > build common infrastructure that resets all the Root Ports just
> > because one of them had an issue.
> 
> Hmm, fair enough.
> 
> > I think pci_host_handle_link_down() should take a Root Port, not a
> > host bridge, and the controller driver should figure out which port
> > needs to be recovered, or the controller driver can have its own loop
> > to recover all of them if it can't figure out which one needs it.
> 
> This should also work. Feel free to drop the relevant commits for
> v6.16, I can resubmit them (including dw-rockchip after -rc1).

OK, I kept "PCI: host-common: Make the driver as a common library for
host controller drivers" (renamed to "PCI: host-common: Convert to
library for host controller drivers") on pci/controller/dw-rockchip
for v6.16 and deferred the rest until later.

