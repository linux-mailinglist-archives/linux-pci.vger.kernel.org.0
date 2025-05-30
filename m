Return-Path: <linux-pci+bounces-28710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CAAC8CFC
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520F21660BF
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5C20B806;
	Fri, 30 May 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTDUWXrj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A711FDA7B;
	Fri, 30 May 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604846; cv=none; b=DnQkHktowdWP7e6W6KZGOGFyq5Qae84PwC65DjPQ/FVf3t6eDllu8oDQ2TFEbFz8a9ebmpsKkPsl4NFqWdr30OmN5cj07Rkp06Xjacli2BQHAJ/PDXlTsqwzNiJMdAzBcEYHkpAGzEMTTPBq8ZnbdGtPm8qXfsoVb5X6ixijBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604846; c=relaxed/simple;
	bh=zOCveCCe34VEq6t903fuoOoYk3Yyf1DbV6pHAyiwueA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZwfnWVpx03wcWzvrCA59hMHQSvToEvUueoSPODn8cg1pxDkEg7+rJVrJLWGhjnAVy/9sOqdpoj3Spceeuz85EonFGIGBLnPQvg0MqWYUbfz6uPZ7GFBZY6XndrCXg5GOo8+aOLvzlHWQYQLHgDb7jP4dfK1zR39h9u0T0tdATls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTDUWXrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FBFC4CEEA;
	Fri, 30 May 2025 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748604845;
	bh=zOCveCCe34VEq6t903fuoOoYk3Yyf1DbV6pHAyiwueA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OTDUWXrjxfeL26hXG9wadvD1pP1t5Am6DLw7haCwKURsI+4B5n6IycmwhLGLQe5Sv
	 9KmXAAyWbIly/941Sez2E434xCskAbE7ZYjV9umZFMwiMWfYKIG3sRvkmjdc0mARJt
	 mAMTBIojb+efjIKDwYcmiOzdsKC6Cir2QuK9ZxDO0tn1e4xN4pB6xzKXBK6w99IJQV
	 Rd6YiSPc9pbxBZEyIpIpKNq5Q3puB2waXHLRwKK75CdfQ8up39wiyyrlrPK1Vd2vgN
	 iupwJIHfDQ4nmJ5vrtnzz9tjpyRPpDPxhFKBcT05AKkcMGg/sT+liHrJ9aU0ac+Ot+
	 fhX43O5Jq4ySA==
Date: Fri, 30 May 2025 06:34:04 -0500
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
Message-ID: <20250530113404.GA138859@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fr6orvqq62hozn5g3svpyyazdshv4kh4xszchxbmpdcpgp5pg6@mlehmlasbvrm>

On Fri, May 30, 2025 at 09:16:59AM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 28, 2025 at 05:35:00PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 08, 2025 at 12:40:33PM +0530, Manivannan Sadhasivam wrote:
> > > The PCI link, when down, needs to be recovered to bring it back. But that
> > > cannot be done in a generic way as link recovery procedure is specific to
> > > host bridges. So add a new API pci_host_handle_link_down() that could be
> > > called by the host bridge drivers when the link goes down.
> > > 
> > > The API will iterate through all the slots and calls the pcie_do_recovery()
> > > function with 'pci_channel_io_frozen' as the state. This will result in the
> > > execution of the AER Fatal error handling code. Since the link down
> > > recovery is pretty much the same as AER Fatal error handling,
> > > pcie_do_recovery() helper is reused here. First the AER error_detected
> > > callback will be triggered for the bridge and the downstream devices. Then,
> > > pci_host_reset_slot() will be called for the slot, which will reset the
> > > slot using 'reset_slot' callback to recover the link. Once that's done,
> > > resume message will be broadcasted to the bridge and the downstream devices
> > > indicating successful link recovery.
> > 
> > Link down is an event for a single Root Port.  Why would we iterate
> > through all the Root Ports if the link went down for one of them?
> 
> Because on the reference platform (Qcom), link down notification is
> not per-port, but per controller. So that's why we are iterating
> through all ports.  The callback is supposed to identify the ports
> that triggered the link down event and recover them.

Maybe I'm missing something.  Which callback identifies the port(s)
that triggered the link down event?  I see that
pci_host_handle_link_down() is called by
rockchip_pcie_rc_sys_irq_thread() and qcom_pcie_global_irq_thread(),
but I don't see the logic that identifies a particular Root Port.

Per-controller notification of per-port events is a controller
deficiency, not something inherent to PCIe.  I don't think we should
build common infrastructure that resets all the Root Ports just
because one of them had an issue.

I think pci_host_handle_link_down() should take a Root Port, not a
host bridge, and the controller driver should figure out which port
needs to be recovered, or the controller driver can have its own loop
to recover all of them if it can't figure out which one needs it.

Bjorn

