Return-Path: <linux-pci+bounces-37839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6CBCF012
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 07:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FBD3A67EC
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 05:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2911DB122;
	Sat, 11 Oct 2025 05:25:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34685626
	for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160338; cv=none; b=MQJHxvTGZq2GQ7t3KXzpS2fy5FJ7aUV50Lu2NJr6PQxJjnPQeHkv7YXLdfd3R3J5fxUawtBC9kgCykLT8w8O505ckG9xDFF52XHYEP8QZ4msiL9Ge2smpUH7lTphvoCeOAfUEPCWTEPyB2g5QMIfhPgBKztBhkZT71mirBpz1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160338; c=relaxed/simple;
	bh=jnDEddd1YPP8astawqBpwuTquwaj7eZYM/w3d6YyLN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwCX+UnWkQjF88Fe/VP2cjQJZDzsWR2zdWCyTwDexCBue19iIOwacscqlUxLZxoWmJyJKUgjKUXGg5s+cozeWAYYVqyuXoQ9l6k0I3/UzuHVEOULhJoh+6/D5V60EHJY823VVKAlEcLR57VIBT91aE8eWnOThyvNZVhv/dWkenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C3D2E2C06F50;
	Sat, 11 Oct 2025 07:25:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 852524A12; Sat, 11 Oct 2025 07:25:26 +0200 (CEST)
Date: Sat, 11 Oct 2025 07:25:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <aOnqRqmHfaguJqyS@wunner.de>
References: <20251008195136.GA634732@bhelgaas>
 <bf9ca58b-b54a-42fc-99f7-4edaa7e561f3@xenosoft.de>
 <aOdKAp8P0WwVfjbv@wunner.de>
 <d89576ac-c34c-4832-b51b-cf6f60c5c85c@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89576ac-c34c-4832-b51b-cf6f60c5c85c@xenosoft.de>

[cc += Mani]

On Sat, Oct 11, 2025 at 07:12:49AM +0200, Christian Zigotzky wrote:
> On 09 October 2025 at 07:37 am, Lukas Wunner wrote:
> > On Thu, Oct 09, 2025 at 06:54:58AM +0200, Christian Zigotzky wrote:
> > > On 08 October 2025 at 09:51 pm, Bjorn Helgaas wrote:
> > > > On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
> > > > > Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
> > > > > 
> > > > > Without the pci-v6.18-changes, the PPC boards boot without any problems.
> > > > > 
> > > > > Boot log with error messages:
> > > > > https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
> > > > > 
> > > > > Further information: https://github.com/chzigotzky/kernels/issues/17
> > > > Do you happen to have a similar log from a recent working kernel,
> > > > e.g., v6.17, that we could compare with?
> > > Thanks for your answer. Here is a similar log from the kernel 6.17.0:
> > > https://github.com/user-attachments/files/22789946/Kernel_6.17.0_Cyrus_Plus_board_P5040.log
> > These lines are added in v6.18:
> > 
> >    pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> >    pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
> >    pci 0001:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> >    pci 0001:01:00.0: ASPM: DT platform, enabling ClockPM
> >    pci 0001:03:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> >    pci 0001:03:00.0: ASPM: DT platform, enabling ClockPM
> > 
> > Possible candidate:
> > 
> > f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> 
> After reverting the commit f3ac2ff14834, the kernel boots without any
> problems.
> 
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> platforms") is the bad commit.

Hi Mani, your commit f3ac2ff14834 is causing a regression on certain
powerpc machines.  Any ideas?

Thanks,

Lukas

