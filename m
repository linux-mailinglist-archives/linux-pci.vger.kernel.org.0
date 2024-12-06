Return-Path: <linux-pci+bounces-17869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E1C9E78FE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 20:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC42837EF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA821CF5DF;
	Fri,  6 Dec 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP7HNvjR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD9153812;
	Fri,  6 Dec 2024 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513477; cv=none; b=Yb+xde2USR19B3TG6j0VJEOWoFnluwDWsefqXSRtNG787ZKNxl1IJZ8TiezKhF5909PTRglRpHxMuYGPUQktVBv1OtgItBhEhqKkng6AijojAndt17Z8A8BtGJyjHJcgvWI6RTi19XsFpcOgH3u/oGohqZ7LXUPow6UnHlQhBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513477; c=relaxed/simple;
	bh=+OWDOFChEvpUYMYVfu8uMEknqRcVsM4mtaouTlOUxCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSivV3N8WudpIKzCObApq18ufEwCFOQuZOCy5pgQDpr1SR810Ntvw968dd7H7Ce4hZOZ1Ra0CJtmuhOSrlPwiYAExPqa3sRy4xL9mh56UPZqt0AiTXXh56L+FoCASETkjqwaMIUZU8RBKUhbgY8KX2sR5lK7cwlSKZKDLrWG+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP7HNvjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AAFC4CED1;
	Fri,  6 Dec 2024 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513476;
	bh=+OWDOFChEvpUYMYVfu8uMEknqRcVsM4mtaouTlOUxCw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cP7HNvjR/UDe9RQgZd32FUBE/j34ckESAtRoVZk4JeAhvT8L8Wo1I1nWwwv+fRhQi
	 KIKl9+Q9/S8z0D65s41IZpY0sGNL/G2YYB57pWitdLk0gCHFV34k8DlP5r0YVZplT+
	 2WFsJaxT89zJ1/SqdhZhpee9Wrmwo9b0eqnM+sVRB/38Iph8/iAlSl1rjTrGcrjnnI
	 JtIWz4/r9w3vifeOlLxiAMyQEJvV3Jf28F+vnXWjzN8aiG2vqypVhH9Ioh4v+APvFy
	 4iJw0wLbuAlHSttkfAh1slGQCSSzn3Tm2DpjSSbbISZz9nQKLdtRw10R7LPkMliATQ
	 ptxs8zOgMlyHg==
Message-ID: <91b501c0ce92de681cc699eb6064840caad28803.camel@kernel.org>
Subject: Re: [PATCH v9 6/9] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kw@linux.com>, "Maciej W . Rozycki"
 <macro@orcam.me.uk>, Jonathan Cameron	 <Jonathan.Cameron@Huawei.com>, Lukas
 Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, Krishna
 chaitanya chundru <quic_krichai@quicinc.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, 	linux-pm@vger.kernel.org, Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>,  Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, niks@kernel.org
Date: Fri, 06 Dec 2024 20:31:10 +0100
In-Reply-To: <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
		 <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
	 <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 19:12 +0100, Niklas Schnelle wrote:
> On Fri, 2024-10-18 at 17:47 +0300, Ilpo J=C3=A4rvinen wrote:
> > This mostly reverts the commit b4c7d2076b4e ("PCI/LINK: Remove
> > bandwidth notification"). An upcoming commit extends this driver
> > building PCIe bandwidth controller on top of it.
> >=20
> > The PCIe bandwidth notification were first added in the commit
> > e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> > notification") but later had to be removed. The significant changes
> > compared with the old bandwidth notification driver include:
> >=20
---8<---
> > ---
>=20
> Hi Ilpo,
>=20
> I bisected a v6.13-rc1 boot hang on my personal workstation to this
> patch. Sadly I don't have much details like a panic or so because the
> boot hangs before any kernel messages, or at least they're not visible
> long enough to see. I haven't yet looked into the code as I wanted to
> raise awareness first. Since the commit doesn't revert cleanly on
> v6.13-rc1 I also haven't tried that yet.
>=20
> Here are some details on my system:
> - AMD Ryzen 9 3900X=20
> - ASRock X570 Creator Motherboard
> - Radeon RX 5600 XT
> - Intel JHL7540 Thunderbolt 3 USB Controller (only USB 2 plugged)
> - Intel 82599 10 Gigabit NIC with SR-IOV enabled with 2 VFs
> - Intel n I211 Gigabit NIC
> - Intel Wi-Fi 6 AX200
> - Aquantia AQtion AQC107 NIC
>=20
> If you have patches or things to try just ask.
>=20
> Thanks,
> Niklas
>=20

Ok I can now at least confirm that bluntly disabling the new bwctrl
driver with the below diff on top of v6.13-rc1 circumvents the boot
hang I'm seeing. So it's definitely this.

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5e10306b6308..6fa54480444a 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -828,7 +828,7 @@ static void __init pcie_init_services(void)
        pcie_aer_init();
        pcie_pme_init();
        pcie_dpc_init();
-       pcie_bwctrl_init();
+       /* pcie_bwctrl_init(); */
        pcie_hp_init();
 }


