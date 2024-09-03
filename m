Return-Path: <linux-pci+bounces-12685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1096A668
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 20:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334A9281165
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7D19049A;
	Tue,  3 Sep 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF6yylWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEC18C920;
	Tue,  3 Sep 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387912; cv=none; b=bl5tPEEpwt6/6Isj1UN+effEPGWycU6OGtVKUKHTOWrw1LnJrLHaF51O1GOZ8w0Ac3hH+PMUt1VOPhK1BxgRKdYPvT2ntZEEGIkpntkZyjCar/nThKbM02Dh9viwh1JgD90QbYCfkmvT58tXfs1++G3sdNd1jj8T/BGQ5GL5L7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387912; c=relaxed/simple;
	bh=lAc4reMSsVnb79X3z07GT39746ssq10KcRvtp8vCAxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QQTs4Z8p190qF23VS9Ore5brGQBMrLjeI6Q0k2M3UZN+xgXZBhciXGmnR/OEJ/pOZqJjlVkiFfu1CXSS7k73G0dszueqFfRMSTadrluPteCl7fP6Skabgq3zS2Oa8bDmZZqq2fk2XCDRtLYpHHp8e5ovATAZdN46Q0yL1itlESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF6yylWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3247C4CEC4;
	Tue,  3 Sep 2024 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725387912;
	bh=lAc4reMSsVnb79X3z07GT39746ssq10KcRvtp8vCAxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FF6yylWRBR7FaYEpBbMS6CxVLYSf463E35BKpBxqaXlbebuBSY5ma4qXi8eUB/PpI
	 cIsFkSEvmaQznetuVY7C4n/W3cNVXO3uSzQL2wX3AWo28glFdRtu9pzDTm6YmqljO2
	 xhnUUOImCtRIL19FCXzP0k+Ei5F8Zm2WSABHFlUNbLf7ia+ksDn+IsVtffpffpB57F
	 Mo66LTUooxtWArKL2fgyjneuCqjsMZz72/DN46rPOoVegX7VSmJYe2bGZmnr1goTD/
	 Z9aci/OrV/ALy9LCdsjPNSxkmiQ6EIz3xIlp0o3a6ElSe2TM+zODIe80OdBUkzrafB
	 WGR1Sfc/iM/fQ==
Date: Tue, 3 Sep 2024 13:25:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Gary Li <Gary.Li@amd.com>, Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240903182509.GA260253@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc99602-7bb2-4026-8122-e92f894aca09@amd.com>

On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
> On 9/3/2024 12:11, Bjorn Helgaas wrote:
> ...

> >    8) The USB4 stack sees the device and assumes it is in D0, but it
> >    seems to still be in D3cold.  What is this based on?  Is there a
> >    config read that returns ~0 data when it shouldn't?
> 
> Yes there is.  From earlier in the thread I have a [log] I shared.
> 
> The message emitted is from ring_interrupt_active():
> 
> "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"

Right, that's in the cover letter, but I can't tell from this what the
ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
MMIO read of BAR 0, not a config read.

> [log] https://gist.github.com/superm1/cb407766ab15f42f12a6fe9d1196f6fc

