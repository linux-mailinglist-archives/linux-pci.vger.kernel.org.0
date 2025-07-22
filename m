Return-Path: <linux-pci+bounces-32726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59206B0D9A0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EEF6C4F3A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604C2E974D;
	Tue, 22 Jul 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZE+SifE+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884782E9733;
	Tue, 22 Jul 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187374; cv=none; b=ccDtKE3rdU60cgOm/mtSbgT7kHcSgSJkbFFpttS+/RdNkn+YmFAVF+vSxYlliFg9yMwzGENbWQ2f882d7HIwO181NYr02ZXvgq8PsNxrbR3Oz7qfkiO7pQbDMnrYQiSJx6Ul04vvoFY/L+joJkBcisj18briw2FTF2OGaM/rx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187374; c=relaxed/simple;
	bh=ugYgb0RNPFqmdXsGr0G/GGIYY2Anwmf6OjdxW7Uub6E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JZvL/DM7R1gH+RS4DbsZbLqZuiY5h1r9V/VxbTjLSRjb1V3sCe56XA+D950txCKwCnPcJd3urijRnm30zC9NHP5IWErO223ICElLWR6D4gi0BWGSRnlEpATdcQNsh4/enon7DofVAhrOOiZ3LpMuonFhTS77MPAYoqV6hFfMNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZE+SifE+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753187373; x=1784723373;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ugYgb0RNPFqmdXsGr0G/GGIYY2Anwmf6OjdxW7Uub6E=;
  b=ZE+SifE+0EJ9uS04jZVCTZqBTsG+9lFb/GWt7Aw/JP/cCoF1MaS94pM6
   JxDlUzJ0ARzoDdSahyHYHyHfIBb9ggbXHr/2EY92eQm362CXW7x26BLWt
   egeNZ9Bnmb/lcxOKv2iCKLPfJmfCdRivRbItnoASkVrNSAHsRUrYalGa4
   9QcJ2Sv3GMOb+gec3BOpU7OdgVMDfSKkuL0GA6FfQwrWaXhNPnlhtlv7a
   JH/xpKzhHIIf6p+IHEaJU+xK5ynGZufcCJIRxgfe7UCKM+QM0HClDg3qc
   3ErQwgeoDsm0+pukde8kqUv7W7ix4iuhEOlIci4Jsu3PJCXC0wuNBpq4N
   Q==;
X-CSE-ConnectionGUID: EBs+HQPoQT6/qN8fsRFiWg==
X-CSE-MsgGUID: OWEPZKTGRviNmDuLUMS6fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55376698"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55376698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:29:31 -0700
X-CSE-ConnectionGUID: tfh2GasuSKmcPJKOS2cYAg==
X-CSE-MsgGUID: 4/tBAQZUT3elnO5/NEQTaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158446969"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:29:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Jul 2025 15:29:20 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: Matthew W Carlis <mattc@purestorage.com>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, anil.s.keshavamurthy@intel.com, 
    bhelgaas@google.com, bp@alien8.de, davem@davemloft.net, 
    linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
    naveen@kernel.org, oleg@redhat.com, peterz@infradead.org, 
    rostedt@goodmis.org, tianruidong@linux.alibaba.com, tony.luck@intel.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoinggt for
 hotplug event
In-Reply-To: <fcfc51c0-6a1f-435b-844b-4daba132f7b6@linux.alibaba.com>
Message-ID: <d3de8888-5ba8-c27c-2a6a-eecf3cc284da@linux.intel.com>
References: <20250717235055.GA2664149@bhelgaas> <20250718034616.26250-1-mattc@purestorage.com> <e92f8d1f-457c-4248-8397-81b0e20ff4af@linux.alibaba.com> <11119800-3b6a-a683-3500-115a057c2826@linux.intel.com>
 <fcfc51c0-6a1f-435b-844b-4daba132f7b6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-198401369-1753187360=:920"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-198401369-1753187360=:920
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 Jul 2025, Shuai Xue wrote:
> =E5=9C=A8 2025/7/21 18:18, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Fri, 18 Jul 2025, Shuai Xue wrote:
> > > =E5=9C=A8 2025/7/18 11:46, Matthew W Carlis =E5=86=99=E9=81=93:
> > > > On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> > > > > So I think your idea of adding current link speed/width to the "L=
ink
> > > > > Up" event is still on the table, and that does sound useful to me=
=2E
> > > >=20
> > > > We're already reading the link status register here to check DLLA s=
o
> > > > it would be nice. I guess if everything is healthy we're probably
> > > > already
> > > > at the maximum speed by this point.
> > > >=20
> > > > > In the future we might add another tracepoint when we enumerate t=
he
> > > > > device and know the Vendor/Device ID.
> > > >=20
> > > > I think we might have someone who would be interested in doing it.
> > >=20
> > >=20
> > > Hi, all,
> > >=20
> > > IIUC, the current hotplug event (or presence event) is enough for Mat=
thew.
> > > and we would like a new tracepoing for link speed change which report=
s
> > > speeds.
> > >=20
> > > For hotplug event, I plan to send a new version to
> > >=20
> > > 1. address Bjorn' concerns about event strings by removing its spaces=
=2E
> > >=20
> > > #define PCI_HOTPLUG_EVENT
> > > \
> > > =09EM(PCI_HOTPLUG_LINK_UP,=09=09=09"PCI_HOTPLUG_LINK_UP")
> > > \
> > > =09EM(PCI_HOTPLUG_LINK_DOWN,=09=09"PCI_HOTPLUG_LINK_DOWN")
> > > \
> > > =09EM(PCI_HOTPLUG_CARD_PRESENT,=09=09"PCI_HOTPLUG_CARD_PRESENT")
> > > \
> > > =09EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,
> > > "PCI_HOTPLUG_CARD_NOT_PRESENT")
> > >=20
> > > 2. address Ilpo comments by moving pci_hp_event to a common place
> > > (include/trace/events/pci.h) so that the new comming can also use it.
> >=20
> > Ah, I only now noticed you've decided to re-place them. Please disregar=
d
> > my other comment about this being still open/undecided item.
> >=20
> > > For link speed change event (perhaps named as pci_link_event),
> > > I plan to send a seperate patch, which provides:
> > >=20
> > > =09TP_STRUCT__entry(
> > > =09=09__string(=09port_name,=09port_name=09)
> > > =09=09__field(=09unsigned char,=09cur_bus_speed=09)
> > > =09=09__field(=09unsigned char,=09max_bus_speed=09)
> > >   =09=09__field(=09unsigned char,=09width=09=09)
> > >   =09=09__field(=09unsigned int,=09flit_mode=09)
> > > =09=09__field(=09unsigned char,=09reason=09=09)
> > > =09=09),
> > >=20
> > > The reason field is from Lukas ideas which indicates why the link spe=
ed
> > > changed, e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
> > >=20
> > > Are you happy with above changes?
> >=20
> > Since you're probably quite far with the pcie link event patch too give=
n
> > above, could you take a look at the LNKSTA flags representation in my
> > patch and incorporate those as well as there seems to always lot of
> > uncertainty about those flags when investigating the LBMS/bwctrl relate=
d
> > issues so it seems prudent to explicitly include them into the traceeve=
nt
> > output:
> >=20
> > https://lore.kernel.org/linux-pci/7c289bba-3133-0989-6333-41fc41fe3504@=
linux.intel.com/
> >=20
> >=20
>=20
> Sure, Thank you for the feedback.
>=20
> I like the LNKSTA flags, LNKSTA flags provides better genericity
> compared to the custom reason field I initially proposed. But it may
> cause confusion when used in pcie_retrain_link(). However, I've
> identified a potential issue when this approach is applied in
> pcie_retrain_link() scenarios.

I was trying to say the flags should be in addition to the other=20
information, not replace reason.

> Consider the following trace output when a device hotpluged:
>=20
> $ cat /sys/kernel/debug/tracing/trace_pipe
> $ cat /sys/kernel/debug/tracing/trace_pipe
>            <...>-118     [002] .....    28.414220: pci_hp_event: 0000:00:=
03.0
> slot:30, event:PCI_HOTPLUG_CARD_PRESENT
>=20
>            <...>-118     [002] .....    28.414273: pci_hp_event: 0000:00:=
03.0
> slot:30, event:PCI_HOTPLUG_LINK_UP
>=20
>    irq/57-pciehp-118     [002] .....    28.540189: pcie_link_event:
> 0000:00:03.0 type:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s
> PCIe, width:1, flit_mode:0, status:DLLLA
>=20
>    irq/57-pciehp-118     [002] .....    28.544999: pcie_link_event:
> 0000:00:03.0 type:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s
> PCIe, width:1, flit_mode:0, status:DLLLA
>=20
> The problem is that both trace events show status:DLLLA (Data Link Layer
> Link Active), which is the direct reading from PCI_EXP_LNKSTA. However,
> this doesn't accurately reflect the underlying context:
>=20
> - First DLLLA: Triggered by board_added() - link establishment after
>   card insertion
> - Second DLLLA: Triggered by pcie_retrain_link() - link retraining
>   completion
>=20
> ( I trace the events in pcie_update_link_speed() )
>=20
> In the second case, the more relevant status would be PCI_EXP_LNKSTA_LT
> (Link Training) to indicate that link retraining was performed, even
> though the final register state shows DLLLA.
>=20
> Question: Should we explicitly report the contextual status (e.g.,
> PCI_EXP_LNKSTA_LT for retraining scenarios) rather than always reading
> the current register field? This would provide more meaningful trace
> information for debugging link state transitions.

I'd prefer it coming from the LNKSTA register (TBH, I don't see much value=
=20
in synthetizing it at all). If we start to synthetize them, it will=20
potentially hide hw issues. I see on some platforms two LBMS assertions=20
per bwctrl speed change (which is done by retraining the link), one with=20
LT=3D1 and the second with LT=3D0.

=2E..But I never meant to replace "reason" with "flags".

> Additionally, I'd appreciate your thoughts on the overall tracepoint
> format shown above. Does this structure provide sufficient information
> for hotplug and link analysis while maintaining readability?

I don't have ideas how it could be improved beyond having those 4 flags=20
available. I suspect noone does as we've not had ability to collect this=20
information before when investigating issues so we're yet to understand=20
all its potential.

--=20
 i.

--8323328-198401369-1753187360=:920--

