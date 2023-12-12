Return-Path: <linux-pci+bounces-796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDD80E990
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434852815A6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B25CD11;
	Tue, 12 Dec 2023 10:59:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9BF3
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 02:59:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id DA99C3000119C;
	Tue, 12 Dec 2023 11:59:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CB9904A5FD; Tue, 12 Dec 2023 11:59:34 +0100 (CET)
Date: Tue, 12 Dec 2023 11:59:34 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	helgaas@kernel.org, dwmw2@infradead.org, yi.l.liu@intel.com,
	majosaheb@gmail.com, cohuck@redhat.com, zhenzhong.duan@gmail.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: PCI device hot insert is not detected
Message-ID: <20231212105934.GA15015@wunner.de>
References: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 04:04:41PM +0530, Ashutosh Sharma wrote:
> Removed one NVMe drive (pci address 0000:83:00.0), it got unbound
> successfully from "vfio-pci" driver but saw below error in the syslog.
> 
> can't change power state from D0 to D3hot (config space inaccessible)

This is normal, the drive's config space is inaccessible after removal.


> Then after 2:30 min approx, re-inserted the same drive to the same PCI
> slot. But the drive was not detected.
> 
> Dec 11 23:54:39 node-4 kernel: [183672.630191] pcieport 0000:80:03.2:
> pciehp: Slot(14): Attention button pressed
> Dec 11 23:54:39 node-4 kernel: [183672.630195] pcieport 0000:80:03.2:
> pciehp: Slot(14) Powering on due to button press
> Dec 11 23:54:44 node-4 kernel: [183677.671931] pcieport 0000:80:03.2:
> pciehp: Slot(14): Card present
> Dec 11 23:54:46 node-4 kernel: [183679.783922] pcieport 0000:80:03.2:
> pciehp: Slot(14): No link

The link doesn't come up, so the kernel gives up on the slot.

I don't know what the reason is, could be a hardware issue or
protocol incompatibility.  This doesn't look like a kernel issue.


>  |           +-03.0  Advanced Micro Devices, Inc. [AMD]
> Starship/Matisse PCIe Dummy Host Bridge
>  |           +-03.1-[82]----00.0  Samsung Electronics Co Ltd NVMe SSD
> Controller PM9A1/PM9A3/980PRO
>  |           +-03.2-[83]--

Adding Mario, Smita, Yazen from AMD to cc, maybe they have an idea
what the issue is or how to get diagnostics on this Epyc platform.

Start of thread:
https://lore.kernel.org/linux-pci/CADOvten7jG7KjW6W1MRd7i8_E18L0xCCaCzmZOY_vvgJhdfOSw@mail.gmail.com/


> admin@node-4:/sys/bus/pci/slots/14$ sudo echo 1 > power
> echo: write error: Operation not permitted

This doesn't work, try "echo 1 | sudo tee power" instead.


> lspci output of the pci port:
> 80:03.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> Starship/Matisse GPP Bridge (prog-if 00 [Normal decode])
[...]
>                 LnkSta: Speed 16GT/s (ok), Width x4 (ok)
>                         TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-

This is from a "Link up" situation (DLActive+), it would be more
interesting to get lspci output of the port in a "No link" situation.

Thanks,

Lukas

