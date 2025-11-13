Return-Path: <linux-pci+bounces-41030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9EC552C5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6335D4E9A8C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608B199931;
	Thu, 13 Nov 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0VRMzbx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF813188596;
	Thu, 13 Nov 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994690; cv=none; b=pbOBevy+33gKgxV7DUey3rj2ZPqEg3Pn+BjCFyijm6zi/rW+GKBkLRcFdgV3G/X33SbiOxkJdz8ld/HvFezI99cHLm40RHCcCArk3m8zrQPWiAP/7lgoz3AUTFldb7+zBXlZ2zKMaR8rWF+s2HQpR6gFeUQyrzZmN1jHEfP38To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994690; c=relaxed/simple;
	bh=57ae9P0/hhPWmajdru2W+nfLg3XVRIoY0iNOydVXYn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=krCvtwmfB9CMSHUocrtVXBB5MFykyeXQSsfj3N3gwdulja4lU5ptqQEZW+b7rev66aPneuGv7XUHBQqvIdjl4S5yBnhPyqOGI4F8ttkzjJlr0PpPo18OXfTOSwoZ0gC32Q60vY9kWQsZwDCVoZqlI2VZx9TYFyZkI773C8lsXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0VRMzbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBCC16AAE;
	Thu, 13 Nov 2025 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762994690;
	bh=57ae9P0/hhPWmajdru2W+nfLg3XVRIoY0iNOydVXYn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o0VRMzbxfOdJ0k1X0t5Em0PgWLCWr3i/rM9WQcSQt9kJFNb2oWS5gVBVdgG7g39JX
	 kZlFpNmIptAr9SEP1VGZStCJVUH7E/0KKLMdQIS7tswdVSjj2kzHGOuKpYe/AJY9ms
	 8PxC6ObQ7IL8uEB8FrdyApoSnGQtMmu3iwv6Ua46RjGTkUwnlo8fF2/ldbT7euyJrs
	 pTQaihVFnTbk8ok+d4MEo0PEfPe5VaOkwN5E6Z2zugPqos50/MjYQh2gkZJhRbYijr
	 QS+Uv+Gu7nw/lIPHs84aFKTeECQ+fP8BUu9KVn6NR3XGjvz5lodc1QIwnjk8VQdWRl
	 /TtwB3dFoBqHQ==
Date: Wed, 12 Nov 2025 18:44:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	debian-powerpc@lists.debian.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251113004448.GA2251273@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4331d1c-8695-19c3-608b-210b3242aaf0@xenosoft.de>

On Wed, Nov 12, 2025 at 04:40:18AM +0100, Christian Zigotzky wrote:
> On 11/11/2025 01:20 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 11, 2025 at 06:15:20AM +0100, Christian Zigotzky wrote:
> >> On 11/07/2025 06:06 AM, Christian Zigotzky wrote:
> >>> On 11/05/2025 11:09 PM, Bjorn Helgaas wrote:
> >>>>> I tested your patch with the RC4 of kernel 6.18 today. Unfortunately
> >>> it
> >>>>> doesn't solve the boot issue.
> >>>>
> >>>> Thanks for testing that.  I see now why that approach doesn't work:
> >>>> quirk_disable_aspm_l0s_l1() calls pci_disable_link_state(), which
> >>>> updates the permissible ASPM link states, but pci_disable_link_state()
> >>>> only works for devices at the downstream end of a link.  It doesn't
> >>>> work at all for Root Ports, which are at the upstream end of a link.
> >>>>
> >>>> Christian, you originally reported that both X5000 and X1000 were
> >>>> broken.  I suspect X1000 may have been fixed in v6.18-rc3 by
> >>>> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree
> >>>> platforms"), but I would love to have confirmation of that.
> >>>
> >>> Hello Bjorn,
> >>>
> >>> I will enable CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT for the RC5 of
> >>> kernel 6.18 and test it with the X1000.
> >>
> >> I tested the RC5 of kernel 6.18 with CONFIG_PCIEASPM and
> >> CONFIG_PCIEASPM_DEFAULT enabled on my X1000 today. Unfortunately the boot
> >> problems are still present.
> >
> > Thanks.  Can you post a dmesg somewhere so I can see what the relevant
> > device IDs are?  Can be with any kernel, doesn't have to be v6.18.  We
> > need the Vendor and Device IDs to add a quirk.
> 
> X1000 kernel 6.18.0-rc5 dmesg:
> https://github.com/user-attachments/files/23491291/dmesg_x1000.txt

Thanks!  This shows all the Root Ports are [1959:a002]:

  pci 0000:00:10.0: [1959:a002] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:10.0: PCI bridge to [bus 01]
  pci 0000:01:00.0: [1002:6898] type 00 class 0x030000 PCIe Legacy Endpoint

I'm confused because Hypexed's 6.18.0-a7-dmesg.log from
https://github.com/chzigotzky/kernels/issues/17#issuecomment-3400419966
shows the same Root Ports, and apparently it booted fine even though
we enabled *everything*: 

  pci 0000:00:10.0: [1959:a002] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:10.0: PCI bridge to [bus 01]
  pci 0000:01:00.0: [1002:6610] type 00 class 0x030000 PCIe Legacy Endpoint
  pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2

It's *possible* that ASPM doesn't work on your endpoint (AMD Cypress
XT [Radeon HD 5870]) but does work on Hypexed's endpoint (AMD Oland XT
[Radeon HD 8670 / R5 340X OEM / R7 250/350/350X OEM]), but that seems
unlikely to me.

Maybe we just give up on ASPM on the [1959:a002] device.  A web search
doesn't show many users of it, so I don't know how many people would
care.

Bjorn

