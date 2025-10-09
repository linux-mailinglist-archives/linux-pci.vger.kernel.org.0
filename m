Return-Path: <linux-pci+bounces-37749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F47BC7744
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 07:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B43EF34E692
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 05:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26370156661;
	Thu,  9 Oct 2025 05:43:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064534BA49
	for <linux-pci@vger.kernel.org>; Thu,  9 Oct 2025 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988620; cv=none; b=ZEMW7tUXoiVaQMcxCox1IWxdles34Qnd79g3jPLXx9hHweE89S+c+BI9KkMo6MVjEIO6tuQSKvqsNu5ewN70H7cCDyWWzvIU4mPwmA1xmpk93DqbAUHHcaXFNJH3GNPIPsIYloF0i5wwUwACRZJLNLJP73oGN17Ks6yzM3ItSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988620; c=relaxed/simple;
	bh=VOVBebjpCzg4TRKJB/BXCbL8HZotuVtqC8n0FVw+9SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhLIHogEqTGSQGE20r6gJWFomUQTB8TfnI8HLvsc2xyrGvZbWA1hRHLZadNJhkEFuon1YxmCC59mIYs7fhE3Rwur1jX9I84kmku5CsztsFm0vEN+ZfI0/61PN0Q9fYniHl4MRrbDMjGpqTOtyzWibOQZ69OnF4o1IFpTKwEYnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B668320083CC;
	Thu,  9 Oct 2025 07:37:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A8524495692; Thu,  9 Oct 2025 07:37:06 +0200 (CEST)
Date: Thu, 9 Oct 2025 07:37:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <aOdKAp8P0WwVfjbv@wunner.de>
References: <20251008195136.GA634732@bhelgaas>
 <bf9ca58b-b54a-42fc-99f7-4edaa7e561f3@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf9ca58b-b54a-42fc-99f7-4edaa7e561f3@xenosoft.de>

On Thu, Oct 09, 2025 at 06:54:58AM +0200, Christian Zigotzky wrote:
> On 08 October 2025 at 09:51 pm, Bjorn Helgaas wrote:
> > On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
> > > Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
> > > 
> > > Without the pci-v6.18-changes, the PPC boards boot without any problems.
> > > 
> > > Boot log with error messages:
> > > https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
> > > 
> > > Further information: https://github.com/chzigotzky/kernels/issues/17
> > 
> > Do you happen to have a similar log from a recent working kernel,
> > e.g., v6.17, that we could compare with?
> 
> Thanks for your answer. Here is a similar log from the kernel 6.17.0:
> https://github.com/user-attachments/files/22789946/Kernel_6.17.0_Cyrus_Plus_board_P5040.log

These lines are added in v6.18:

  pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
  pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
  pci 0001:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
  pci 0001:01:00.0: ASPM: DT platform, enabling ClockPM
  pci 0001:03:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
  pci 0001:03:00.0: ASPM: DT platform, enabling ClockPM

Possible candidate:

f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")

More lines are added in v6.18:

  pci 0001:03:00.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 04] (unused)
  pci 0001:02:01.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 03-04] (unused)
  pci 0001:02:02.0: disabling bridge window [io  0x0000-0xffffffffffffffff] to [bus 05] (unused)
  pci 0001:02:02.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 05] (unused)
  pci 0001:02:02.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff] to [bus 05] (unused)
  pci 0001:02:03.0: disabling bridge window [io  0x0000-0xffffffffffffffff] to [bus 06] (unused)
  pci 0001:02:03.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 06] (unused)
  pci 0001:02:03.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff] to [bus 06] (unused)
  pci 0001:02:08.0: disabling bridge window [io  0x0000-0xffffffffffffffff] to [bus 07] (unused)
  pci 0001:02:08.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 07] (unused)
  pci 0001:02:08.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff] to [bus 07] (unused)
  pci 0001:02:10.0: disabling bridge window [io  0x0000-0xffffffffffffffff] to [bus 08] (unused)
  pci 0001:02:10.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 08] (unused)
  pci 0001:02:10.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff] to [bus 08] (unused)
  pci 0001:01:00.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 02-08] (unused)
  pci_bus 0001:02: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]
422a445
  pci_bus 0001:03: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]
424a448,460
  pci_bus 0001:04: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]
  pci_bus 0001:05: resource 0 [io  0x0000-0xffffffffffffffff disabled]
  pci_bus 0001:05: resource 1 [mem 0x00000000-0xffffffffffffffff disabled]
  pci_bus 0001:05: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]
  pci_bus 0001:06: resource 0 [io  0x0000-0xffffffffffffffff disabled]
  pci_bus 0001:06: resource 1 [mem 0x00000000-0xffffffffffffffff disabled]
  pci_bus 0001:06: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]
  pci_bus 0001:07: resource 0 [io  0x0000-0xffffffffffffffff disabled]
  pci_bus 0001:07: resource 1 [mem 0x00000000-0xffffffffffffffff disabled]
  pci_bus 0001:07: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]
  pci_bus 0001:08: resource 0 [io  0x0000-0xffffffffffffffff disabled]
  pci_bus 0001:08: resource 1 [mem 0x00000000-0xffffffffffffffff disabled]
  pci_bus 0001:08: resource 2 [mem 0x00000000-0xffffffffffffffff 64bit pref disabled]

Possible candidate:

fead6a0b15bf ("Merge branch 'pci/resource'")

Adding Ilpo to cc.

Unrelated, it looks like 6a1eda745967 ("PCI/AER: Consolidate Error
Source ID logging in aer_isr_one_error_type()") erroneously omitted
a closing brace in the "no details found" string:

  pcieport 0001:00:00.0: AER: Correctable error message received from 0001:00:00.0 (no details found

Thanks,

Lukas

