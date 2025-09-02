Return-Path: <linux-pci+bounces-35339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC0BB40E92
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 22:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948001A879CB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D1212F89;
	Tue,  2 Sep 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX3RMnNG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFA19C560;
	Tue,  2 Sep 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845151; cv=none; b=CJKFtKn6LwEGMKUAFSlxC9IyZlT5SGrZ2cpYQGZrt7zSXqvza2nV0mdGjGGctF605HY3x8vE+2NBf3PTwVrPx1wqV1pN06IzvwimjqnewiOBmMaKjwwfavDYEydMt2e16ZV4bLCJlOUTCMvfWyy5TTpoEO6PQVEl80re0ggLdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845151; c=relaxed/simple;
	bh=aN+hgxqhYaMjS0OXhoT6xA2ZJ5xTCuRclQagaKdbDmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsWxA2E0zA6gZO5QzTjoh/n/B7A3BQAV5E65/jIuNSC5wFjHcn5w87hLjwFJ+sRvG03pTueUdCO2WuHyDuVgdcb+TOvuYSD/yKVN7INIq6+FPNUxIDc1EIzptja8O5BCzatCiRIDN8P1Z2iifTOOVOScIcepAvtTBxCiyPyk7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX3RMnNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB34C4CEED;
	Tue,  2 Sep 2025 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756845149;
	bh=aN+hgxqhYaMjS0OXhoT6xA2ZJ5xTCuRclQagaKdbDmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX3RMnNGwDfunjeKLJnizcoSlSH0Y96fUw8jlru3J3uExFS0QX07rGRMViPRYkwyG
	 rLOZwz4/fbRsYq8fScmJ1zxfA2nbTqxA5W2IGEvPDGSrIyFpCEqB2AsPU1z2RNdyaW
	 WJWGDwpDPCIMnyeRidGkbkIdlyFErMaCZ3BL2+NnCBnSsdqsIhMtBT/UgLZhk8b5Sk
	 AQOePqYHwZTuLwfoY5xqfc8q59IzkwM+eV5olmMmM8HWgjht1HycdDnFFqhYY3bLO+
	 tK+lXj09ZHfqtxIcAVpYcQ/9iF/w1pv9K1NxhES/F1zXVSfwocnzAQlz5lfk+1q89l
	 8WwY0XKaAIpLg==
Received: by pali.im (Postfix)
	id 9BE454BB; Tue,  2 Sep 2025 22:32:26 +0200 (CEST)
Date: Tue, 2 Sep 2025 22:32:26 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jan Palus <jpalus@fastmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
Message-ID: <20250902203226.u4i43vygl4bl2dqa@pali>
References: <bug-220479-41252@https.bugzilla.kernel.org/>
 <20250820184603.GA633069@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820184603.GA633069@bhelgaas>
User-Agent: NeoMutt/20180716

These issues have been discussed more times for last 3 years.
Tested changes which are fixing real bugs and are improving the
pci-mvebu.c driver from people listed as M: in MAINTAINERS are being
rejected or silently ignored. And untested changes which are not going
to fix any bug are being accepted and causing new regressions. People
then reporting bug reports to M: people who cannot do anything with it.
The only advice which they can get is to not use mainline kernel.
This pci-mvebu.c driver in mainline kernel is broken and nobody wanted
to do anything with this situation for last 3 years, I was pointing for
it more times. Due to this I'm ignoring bug reports for pci-mvebu.c
driver for mainline kernel.

On Wednesday 20 August 2025 13:46:03 Bjorn Helgaas wrote:
> [+cc maintainers, regressions list]
> 
> Jan, thanks very much for the report and the bisection.  Could you
> attach the devicetree you're using to the bugzilla?
> 
> On Wed, Aug 20, 2025 at 05:43:39PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=220479
> > 
> >            Summary: [regression 6.16] mvebu: no pci devices detected on
> >                     turris omnia
> >           Reporter: jpalus@fastmail.com
> > 
> > Booting kernel 6.16 results in no PCI devices being detected (output of `lspci`
> > is completely empty). Bisected to:
> > 
> > 5da3d94a23c6c1ee1f896aeeb00965eacf1d0bb3 is the first new commit
> > commit 5da3d94a23c6c1ee1f896aeeb00965eacf1d0bb3 (HEAD)
> > Author: Rob Herring (Arm) <robh@kernel.org>
> > Date:   Thu Nov 7 16:32:55 2024
> > 
> >     PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
> > 
> >     The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> >     but it's still just normal "ranges" as far as parsing is concerned.
> >     Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> >     instead of open coding the parsing.
> > 
> >     Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >     Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >     Link: https://patch.msgid.link/20241107153255.2740610-1-robh@kernel.org
> > 
> >  drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
> >  1 file changed, 9 insertions(+), 17 deletions(-)
> > 
> > 
> > kernel 6.16 logs following mesages related to PCI:
> > 
> > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie: pcie0.0: cannot get tgt/attr for mem window
> > mvebu-pcie soc:pcie: pcie1.0: cannot get tgt/attr for mem window
> > mvebu-pcie soc:pcie: pcie2.0: cannot get tgt/attr for mem window
> > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address
> > [0x00080000-0x00081fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address
> > [0x00040000-0x00041fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address
> > [0x00044000-0x00045fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address
> > [0x00048000-0x00049fff])
> > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > PCI: bus0: Fast back to back transfers enabled
> > pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
> > pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
> > pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
> > pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
> > pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
> > 
> > 
> > while kernel 6.15 logs following:
> > 
> > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie: pcie0.0: Slot power limit 10.0W
> > mvebu-pcie soc:pcie: pcie1.0: Slot power limit 10.0W
> > mvebu-pcie soc:pcie: pcie2.0: Slot power limit 10.0W
> > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address
> > [0x00080000-0x00081fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address
> > [0x00040000-0x00041fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address
> > [0x00044000-0x00045fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address
> > [0x00048000-0x00049fff])
> > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:01.0: PCI bridge to [bus 00]
> > pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
> > /soc/pcie/pcie@1,0: Fixed dependency cycle(s) with
> > /soc/pcie/pcie@1,0/interrupt-controller
> > pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:02.0: PCI bridge to [bus 00]
> > pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> > /soc/pcie/pcie@2,0: Fixed dependency cycle(s) with
> > /soc/pcie/pcie@2,0/interrupt-controller
> > pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:03.0: PCI bridge to [bus 00]
> > pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
> > /soc/pcie/pcie@3,0: Fixed dependency cycle(s) with
> > /soc/pcie/pcie@3,0/interrupt-controller
> > PCI: bus0: Fast back to back transfers disabled
> > pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > PCI: bus1: Fast back to back transfers enabled
> > pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > pci 0000:02:00.0: [168c:003c] type 00 class 0x028000 PCIe Endpoint
> > pci 0000:02:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> > pci 0000:02:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0000:02:00.0: supports D1
> > pci 0000:02:00.0: PME# supported from D0 D1 D3hot
> > pci 0000:00:02.0: ASPM: current common clock configuration is inconsistent,
> > reconfiguring
> > pci 0000:00:02.0: ASPM: Bridge does not support changing Link Speed to 2.5 GT/s
> > pci 0000:00:02.0: ASPM: Retrain Link at higher speed is disallowed by quirk
> > PCI: bus2: Fast back to back transfers disabled
> > pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> > pci 0000:03:00.0: [168c:0033] type 00 class 0x028000 PCIe Endpoint
> > pci 0000:03:00.0: BAR 0 [mem 0x00000000-0x0001ffff 64bit]
> > pci 0000:03:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0000:03:00.0: supports D1
> > pci 0000:03:00.0: PME# supported from D0 D1 D3hot
> > pci 0000:00:03.0: ASPM: current common clock configuration is inconsistent,
> > reconfiguring
> > pci 0000:00:03.0: ASPM: Bridge does not support changing Link Speed to 2.5 GT/s
> > pci 0000:00:03.0: ASPM: Retrain Link at higher speed is disallowed by quirk
> > PCI: bus3: Fast back to back transfers disabled
> > pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> > pci 0000:00:02.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02]
> > add_size 200000 add_align 200000
> > pci 0000:00:02.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> > pci 0000:00:03.0: bridge window [mem 0xe0400000-0xe04fffff]: assigned
> > pci 0000:00:01.0: PCI bridge to [bus 01]
> > pci 0000:02:00.0: BAR 0 [mem 0xe0000000-0xe01fffff 64bit]: assigned
> > pci 0000:02:00.0: ROM [mem 0xe0200000-0xe020ffff pref]: assigned
> > pci 0000:00:02.0: PCI bridge to [bus 02]
> > pci 0000:00:02.0:   bridge window [mem 0xe0000000-0xe03fffff]
> > pci 0000:03:00.0: BAR 0 [mem 0xe0400000-0xe041ffff 64bit]: assigned
> > pci 0000:03:00.0: ROM [mem 0xe0420000-0xe042ffff pref]: assigned
> > pci 0000:00:03.0: PCI bridge to [bus 03]
> > pci 0000:00:03.0:   bridge window [mem 0xe0400000-0xe04fffff]
> > pci_bus 0000:00: resource 4 [mem 0xf1080000-0xf1081fff]
> > pci_bus 0000:00: resource 5 [mem 0xf1040000-0xf1041fff]
> > pci_bus 0000:00: resource 6 [mem 0xf1044000-0xf1045fff]
> > pci_bus 0000:00: resource 7 [mem 0xf1048000-0xf1049fff]
> > pci_bus 0000:00: resource 8 [mem 0xe0000000-0xe7ffffff]
> > pci_bus 0000:00: resource 9 [io  0x1000-0xeffff]
> > pci_bus 0000:02: resource 1 [mem 0xe0000000-0xe03fffff]
> > pci_bus 0000:03: resource 1 [mem 0xe0400000-0xe04fffff]
> > pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> > pcieport 0000:00:03.0: enabling device (0140 -> 0142)
> 
> #regzbot introduced: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")

