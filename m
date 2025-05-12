Return-Path: <linux-pci+bounces-27570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33ADAB339B
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 11:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4613117A5E3
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD93A25D1F6;
	Mon, 12 May 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPkAx3Nh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB925C71F
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042113; cv=none; b=QET6WCs9ysk6abkQ/VMeFNFKPhhUxgesB1MIL4F02siBhxK9LQk5qvktwBDmko+qDFJe7fao+i0z5PU41aths3ooMEQqGRfLn9qwWJ0d+hKEf1KNOaFvdETWPqy9vttbgbHrFus0m79pF8/w0C/zU30v4aT7qoNzL0elG8K4Igs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042113; c=relaxed/simple;
	bh=CpB29nfeh+74onqZIS8kilH7g8wHJqIXvo0/71lZb7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYRkLWhKJFJSngOzMbsQE1mGeoV8LY/hgcTgZ1179zn3i9rUt9xbc3dck+wLGbNRtmRiAgsMiVLfo6ROlrm8mFzjQ072484MRkqMtk9kC2Z5D2NUBumjJGafnZHH9ZKDCBarUT+3anhaiRLkOfJcPx70tpekJVNumGNQkhTeWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPkAx3Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15499C4CEE7;
	Mon, 12 May 2025 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042113;
	bh=CpB29nfeh+74onqZIS8kilH7g8wHJqIXvo0/71lZb7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPkAx3NhXVAGX4ZUH8TQoDaMlbe+3oCEkWRDEs4tpCO4y8lU6zAgFHiu0Zt/NZu7p
	 M6MUxSGcIvAOJZzbAL2U8be+Llfw3ZU00Y+rP3nUuU+FwFQGo9eIZq8HpZKU/UYeEi
	 vBWsQQRPTngOdfi6IkYa0tx1vfsmEFW++C+/YN4F0dfSINOugFhAAmTndw6ad2z+UG
	 2+Fe8SPcEcYg0sBijtuQfzTf/FA2p+wgjTRf1awpl5u5+3TKIKrM380XKWi2PepOVP
	 Uht3T8msHkDp64t8P4aiGdhgD9ENqiyYGzy++qy7Okzuf+1Mj+DmUo9cV7ybLvmu0D
	 zFh4oOYllLsmQ==
Date: Mon, 12 May 2025 11:28:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>, dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
Message-ID: <aCG_PC3llyx3bs34@ryzen>
References: <20250430123158.40535-3-cassel@kernel.org>
 <tmtm4od4paptgbiodq5cezltsy6njoyeet7mcsq7rq3m7zcz5z@thpqdtzpskgx>
 <aB8762GD_iI5G5LY@ryzen>
 <kgw4y5mrvt3g6vnnkiaicufticbpyc5vmhbo6ee4g7ayg2hntt@fogtz5lizk5f>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kgw4y5mrvt3g6vnnkiaicufticbpyc5vmhbo6ee4g7ayg2hntt@fogtz5lizk5f>

On Mon, May 12, 2025 at 01:00:02PM +0530, Manivannan Sadhasivam wrote:
> On Sat, May 10, 2025 at 01:43:39PM +0200, Niklas Cassel wrote:
> > On Sat, May 10, 2025 at 11:27:55AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Apr 30, 2025 at 02:31:59PM +0200, Niklas Cassel wrote:
> > > > While the parameter 'interrupts' to the functions pci_epc_set_msi() and
> > > > pci_epc_set_msix() represent the actual number of interrupts, and
> > > > pci_epc_get_msi() and pci_epc_get_msix() return the actual number of
> > > > interrupts.
> > > > 
> > > > These endpoint library functions just mentioned will however supply
> > > > "interrupts - 1" to the EPC callback functions pci_epc_ops->set_msi() and
> > > > pci_epc_ops->set_msix(), and likewise add 1 to return value from
> > > > pci_epc_ops->get_msi() and pci_epc_ops->get_msix(),
> > > 
> > > Only {get/set}_msix() callbacks were having this behavior, right?
> > 
> > pci_epc_get_msix() adds 1 to the return of epc->ops->get_msix().
> > pci_epc_set_msix() subtracts 1 to the parameter sent to epc->ops->set_msix().
> > 
> > pci_epc_get_msi() does 1 << interrupt from the return of epc->ops->get_msi().
> > So a return of 0 from epc->ops->get_msi() will result in pci_epc_get_msi()
> > returning 1. A return of 1 from epc->ops->get_msi() will result in
> > pci_epc_get_msi() returning 2.
> > 
> > Similar for pci_epc_set_msi(). It will call order_base_2() on the parameter
> > before sending it to epc->ops->set_msi().
> > 
> 
> Yeah. I was pointing out the fact that bitshifting != incrementing/decrementing
> 1. And you just mentioned the latter for both msi/msix callbacks. I can ammend
> it while applying.

Thank you!



> > I am a bit worried about patches after the cleanup getting backported, which
> > will need to be different before and after this cleanup.
> 
> We can add stable+noautosel to mark the patches to not backport.
> 
> > Perhaps renaming the
> > callbacks at the same as the cleanup might be a good idea?
> > 
> > It should be a simple cleanup though, just do the order_base_2() etc in the
> > driver callbacks themselves.
> > 
> > We really should rename the parameter of .set_msi() though, as it is totally
> > misleading as of now.
> > 
> 
> As I said above, we should keep the semantics for 'interrupt' and make changes
> accordingly i.e., by doing order_base_2() inside the callbacks as you suggested.

Yeah, I agree, better to rename the parameter of the existing callbacks that use
mmc/mme to interrupts, and actually perform the cleanup so that the take interrupts
instead of mmc/mme.


Considering that it is only 4 drivers, with a maximum of 4 callbacks in each driver
that needs to be cleaned up, it's not so bad.

Since we seem to have identified all the weirdness with the existing APIs,
let me try to cleanup this mess this week.


(Would be nice to get this fixed queued first though, so cleanup patches can
come on top.)


Kind regards,
Niklas

