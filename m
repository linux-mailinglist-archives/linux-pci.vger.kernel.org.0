Return-Path: <linux-pci+bounces-37606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A344BBDC4A
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 12:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564E74EC414
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F3262FC0;
	Mon,  6 Oct 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ42fFsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5724DFF4;
	Mon,  6 Oct 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747624; cv=none; b=ZBIBxI1IbgUtGykO6jYFF401UXNZQgX9C4hWm63luvOdrJkrlcNzGqhvGjQSBbI9JFQP4yHob3YLF+tQYkIBlySAcNbF7xnQlfLnEFtuFMha/JkYexESUbj5yGowzmzoRjmB+Gu6B6UL+CFCgPdyeconczaTBGTFWR1iYH6jj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747624; c=relaxed/simple;
	bh=e4/nZdnV1UnOi2Img4tNapF9NXHl/ngFY8QE558FNJE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q+w6Ff8M1HFwPua/qY3lOYFsVNAG4oYCPryuV79qYJgg6tVyhzK8NWkWHcFYHZwSBe7b5zgef+nHvbjVaZP8UvR8uUqwAtbt6NcyJnFSP/k9kOka1ReICIpJISqtOF5YKICxZQFs9FF9+J3KqxEM54W/b0nWPj1gCi0yHDRXgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ42fFsB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759747623; x=1791283623;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=e4/nZdnV1UnOi2Img4tNapF9NXHl/ngFY8QE558FNJE=;
  b=MQ42fFsB7s++CBuIgQNaJnPDNvO2sX92CDCkgas6t8Zs86gQ/nGju0CF
   kWhIOgl8UBEyg+JQzUvSZ8y4EXeyFuFVE/Tv4+V2v9uKRvqhCGWFzOkYl
   EhkBo52oIBlmVBF6S9OcaGydRAvLlD50UDx/CUx3k7girJyvH0x0bJ50r
   k1VNDpVN5kGZJI54O1W91VzpYfC7ve5FXLjUBTWwYuYOi2umqtM5c/G9I
   HlgoYcbY8LMzo9hbU/O2625YQvq5pQBFMoXeppdfcIPUw4ekQkOjyrFJp
   azcOElU/1tRguO9cdpATComk2CeprfwvVyFgJMjirRCNU2s+blW3otY2w
   Q==;
X-CSE-ConnectionGUID: 1pIQWdDASkmbzyCT8zS9Aw==
X-CSE-MsgGUID: uqWnIO4uTO2ECBb4vNL7Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="84546449"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="84546449"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:47:01 -0700
X-CSE-ConnectionGUID: uj71qlGYRhmsBbLiVzlkXA==
X-CSE-MsgGUID: 0bwcgZAYS7ulmPuFdgtoBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="203589823"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:46:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Oct 2025 13:46:54 +0300 (EEST)
To: Val Packett <val@packett.cool>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
In-Reply-To: <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
Message-ID: <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com> <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-482221089-1759745710=:943"
Content-ID: <34f3730e-25d8-0310-db63-6599d5a18577@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-482221089-1759745710=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <517c50e8-9498-ff9c-b988-411a2626dd5b@linux.intel.com>

On Mon, 6 Oct 2025, Val Packett wrote:
> On 9/24/25 10:42 AM, Ilpo J=E4rvinen wrote:
> > Bridge windows are read twice from PCI Config Space, the first read is
> > made from pci_read_bridge_windows() which does not setup the device's
> > resources. It causes problems down the road as child resources of the
> > bridge cannot check whether they reside within the bridge window or
> > not.
> >=20
> > Setup the bridge windows already in pci_read_bridge_windows().
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Looks like this change has broken the WiFi (but not NVMe) on my Snapdrago=
n X1E
> laptop (Latitude 7455):

Thanks for the report.

> qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> pci_bus 0004:00: root bus resource [bus 00-ff]
> pci_bus 0004:00: root bus resource [io=A0 0x100000-0x1fffff] (bus address=
 [0x0000-0xfffff])

So this looks the first change visible in the fragment you've taken from=20
the dmesg...

> pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
> pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
> pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]

=2E..What I don't understand in these logs is how can the code changed in=
=20
pci_read_bridge_windows() affect the lines before this line as it is being=
=20
printed from pci_read_bridge_windows(). Maybe there are more 'PCI bridge=20
to' lines above the quoted part of the dmesg?

> pci 0004:00:00.0:=A0 =A0bridge window [io=A0 0x100000-0x100fff]
> pci 0004:00:00.0:=A0 =A0bridge window [mem 0x00000000-0x000fffff]
> pci 0004:00:00.0:=A0 =A0bridge window [mem 0x00000000-0x000fffff 64bit pr=
ef]
> pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
> pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]: a=
ssigned
> pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned
> pci 0004:00:00.0: bridge window [io=A0 0x100000-0x100fff]: assigned
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci 0004:00:00.0:=A0 =A0bridge window [io=A0 0x100000-0x100fff]
> pci 0004:00:00.0:=A0 =A0bridge window [mem 0x7c300000-0x7c3fffff]
> pci 0004:00:00.0:=A0 =A0bridge window [mem 0x7c400000-0x7c4fffff 64bit pr=
ef]
> pci_bus 0004:00: resource 4 [io=A0 0x100000-0x1fffff]
> pci_bus 0004:00: resource 5 [mem 0x7c300000-0x7dffffff]
> pci_bus 0004:01: resource 0 [io=A0 0x100000-0x100fff]
> pci_bus 0004:01: resource 1 [mem 0x7c300000-0x7c3fffff]
> pci_bus 0004:01: resource 2 [mem 0x7c400000-0x7c4fffff 64bit pref]
> pcieport 0004:00:00.0: PME: Signaling with IRQ 186
> pcieport 0004:00:00.0: AER: enabled with IRQ 186
> pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
> pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no spa=
ce
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: failed to assign
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no spa=
ce
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: failed to assign
> ath12k_pci 0004:01:00.0: BAR 0 [??? 0x00000000 flags 0x20000000]: can't
> assign; bogus alignment
> ath12k_pci 0004:01:00.0: failed to assign pci resource: -22
> ath12k_pci 0004:01:00.0: failed to claim device: -22
> ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -=
22
>=20
>=20
> For comparison, with this change reverted it works again:
>=20
> qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> pci_bus 0004:00: root bus resource [bus 00-ff]
> pci_bus 0004:00: root bus resource [io=A0 0x0000-0xfffff]
> pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
> pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
> pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci 0004:00:00.0:=A0 =A0bridge window [io=A0 0x0000-0x0fff]
> pci 0004:00:00.0:=A0 =A0bridge window [mem 0x00000000-0x000fffff]
> pci 0004:00:00.0:=A0 =A0bridge window [mem 0x00000000-0x000fffff 64bit pr=
ef]
> pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:00:00.0: BAR 0 [mem 0x7c300000-0x7c300fff]: assigned
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci_bus 0004:00: resource 4 [io=A0 0x0000-0xfffff]
> pci_bus 0004:00: resource 5 [mem 0x7c300000-0x7dffffff]
> pcieport 0004:00:00.0: PME: Signaling with IRQ 195
> pcieport 0004:00:00.0: AER: enabled with IRQ 195
> pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
> pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1
> ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> pci 0004:01:00.0: ASPM: DT platform, enabling ClockPM
> pcieport 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigne=
d
> pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
> ath12k_pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigne=
d
> ath12k_pci 0004:01:00.0: enabling device (0000 -> 0002)
> ath12k_pci 0004:01:00.0: MSI vectors: 16
> ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0
>=20
> Not quite sure what's going on with these windows..



--=20
 i.
--8323328-482221089-1759745710=:943--

