Return-Path: <linux-pci+bounces-42852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012CCB05B7
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBFA130528F7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B42FE575;
	Tue,  9 Dec 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac7HoN4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52291E8332;
	Tue,  9 Dec 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292691; cv=none; b=dVudkusUukeT3duwr9ZjJubZNrEpbUPM0NmBFVCXWIJNYqNhf9NgRmZhAj54DNQj5M8WFjfEeTH8M/cSiVRspwo2a4kSCh5DRXSLwcUKMwsocwsM9FqtZ76hc2yXXu4Dqw9m8BYoRo0b4yh8pQJ4BEAM273w2B8WszHX9RWNmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292691; c=relaxed/simple;
	bh=1UBopjtk7ZBbpZOBiD36vUxARE759QXi7aFEEAeiIlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyyfstItv9Po9NJepTVS6q7BNhEgNRRQn2v1AXBORwJN1DX5jaa2X+Y/Jx6kyZc5kHpMzais6kzmxYmpBjK7CAw4RHFCJztqpqlxwA7ZK5VshhwZjnKsBJJc9vYI7q5CKEiJU4oJypuGw8JL9YLycjHVCWRKXxKqgHOrD5EjT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac7HoN4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C503C4CEF5;
	Tue,  9 Dec 2025 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765292690;
	bh=1UBopjtk7ZBbpZOBiD36vUxARE759QXi7aFEEAeiIlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ac7HoN4R9h+8h8masl9d7Nb8fwyt1pQDU7FoW9yKI/d4Pq2XP8K2iiyyVNV9hTPyJ
	 Ep+GgcZWdVjv78+vBQ7AH5EwbOvAv+dXd+suvynhY7swzPxSgxn2LYvpoGtgKXGvkD
	 NmRJx9p096YzIkNMPzVophRhpAlgWGZz3rRA9bJ+OzovNWnEaT0JNkqSMTYkVMZI1v
	 cacMiCankcmJ08bWfVtTOfxxHXD3QQwaN1tBaYxMwlzbM7uhxOpJ+1w1mb0lFhHmeH
	 xJFWotsK1Zes+g8mkkbRopdb1VVW0E0aulksErlag8ZPLA2YkAqh3Jgu1gWFputUiO
	 GlzlTFvVdptpA==
Date: Wed, 10 Dec 2025 00:04:41 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Message-ID: <xofyj6bjbpsxjpgnw6vyfpekpvsmhxcoaqm5k26yuyc2dashux@4nro7bppnwhs>
References: <CGME20251202142307eucas1p12a15e5656bb53f48f445c3056d4e3166@eucas1p1.samsung.com>
 <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <b63ec0aa-7a4a-4f8d-9b93-e724f3f2a9d1@samsung.com>
 <de80df44-f797-4e8c-a411-09ed3c1286a3@samsung.com>
 <cae5cb24-a8b0-4088-bacd-14368f32bdc5@samsung.com>
 <26a93564-fcdd-4e90-b28d-8cc84cedeaa8@samsung.com>
 <4clyxcy5pwqaz6uguxnjei4hnxsree6k2uz5upro7khuvklfyo@nc5ebeicuqw4>
 <0ee48f4a-2341-4967-aca5-3fe6b4cd5fe2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ee48f4a-2341-4967-aca5-3fe6b4cd5fe2@samsung.com>

On Tue, Dec 09, 2025 at 01:00:55PM +0100, Marek Szyprowski wrote:
> On 09.12.2025 12:15, Manivannan Sadhasivam wrote:
> > On Tue, Dec 09, 2025 at 09:28:38AM +0100, Marek Szyprowski wrote:
> >> On 09.12.2025 08:31, Marek Szyprowski wrote:
> >>> On 04.12.2025 14:13, Marek Szyprowski wrote:
> >>>> On 03.12.2025 13:04, Marek Szyprowski wrote:
> >>>>> On 02.12.2025 15:22, Manivannan Sadhasivam wrote:
> >>>>>> This series fixes the long standing issue with ACS in OF platforms.
> >>>>>> There are
> >>>>>> two fixes in this series, both fixing independent issues on their
> >>>>>> own, but both
> >>>>>> are needed to properly enable ACS on OF platforms.
> >>>>>>
> >>>>>> Issue(s) background
> >>>>>> ===================
> >>>>>>
> >>>>>> Back in 2021, Xingang Wang first noted a failure in attaching the
> >>>>>> HiSilicon SEC
> >>>>>> device to QEMU ARM64 pci-root-port device [1]. He then tracked down
> >>>>>> the issue to
> >>>>>> ACS not being enabled for the QEMU Root Port device and he proposed
> >>>>>> a patch to
> >>>>>> fix it [2].
> >>>>>>
> >>>>>> Once the patch got applied, people reported PCIe issues with
> >>>>>> linux-next on the
> >>>>>> ARM Juno Development boards, where they saw failure in enumerating
> >>>>>> the endpoint
> >>>>>> devices [3][4]. So soon, the patch got dropped, but the actual
> >>>>>> issue with the
> >>>>>> ARM Juno boards was left behind.
> >>>>>>
> >>>>>> Fast forward to 2024, Pavan resubmitted the same fix [5] for his
> >>>>>> own usecase,
> >>>>>> hoping that someone in the community would fix the issue with ARM
> >>>>>> Juno boards.
> >>>>>> But the patch was rightly rejected, as a patch that was known to
> >>>>>> cause issues
> >>>>>> should not be merged to the kernel. But again, no one investigated
> >>>>>> the Juno
> >>>>>> issue and it was left behind again.
> >>>>>>
> >>>>>> Now it ended up in my plate and I managed to track down the issue
> >>>>>> with the help
> >>>>>> of Naresh who got access to the Juno boards in LKFT. The Juno issue
> >>>>>> was with the
> >>>>>> PCIe switch from Microsemi/IDT, which triggers ACS Source
> >>>>>> Validation error on
> >>>>>> Completions received for the Configuration Read Request from a
> >>>>>> device connected
> >>>>>> to the downstream port that has not yet captured the PCIe bus
> >>>>>> number. As per the
> >>>>>> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and
> >>>>>> Device Numbers
> >>>>>> supplied with all Type 0 Configuration Write Requests completed by
> >>>>>> the Function
> >>>>>> and supply these numbers in the Bus and Device Number fields of the
> >>>>>> Requester ID
> >>>>>> for all Requests". So during the first Configuration Read Request
> >>>>>> issued by the
> >>>>>> switch downstream port during enumeration (for reading Vendor ID),
> >>>>>> Bus and
> >>>>>> Device numbers will be unknown to the device. So it responds to the
> >>>>>> Read Request
> >>>>>> with Completion having Bus and Device number as 0. The switch
> >>>>>> interprets the
> >>>>>> Completion as an ACS Source Validation error and drops the
> >>>>>> completion, leading
> >>>>>> to the failure in detecting the endpoint device. Though the PCIe
> >>>>>> spec r6.0, sec
> >>>>>> 6.12.1.1, states that "Completions are never affected by ACS Source
> >>>>>> Validation".
> >>>>>> This behavior is in violation of the spec.
> >>>>>>
> >>>>>> Solution
> >>>>>> ========
> >>>>>>
> >>>>>> In September, I submitted a series [6] to fix both issues. For the
> >>>>>> IDT issue,
> >>>>>> I reused the existing quirk in the PCI core which does a dummy
> >>>>>> config write
> >>>>>> before issuing the first config read to the device. And for the ACS
> >>>>>> enablement
> >>>>>> issue, I just resubmitted the original patch from Xingang which called
> >>>>>> pci_request_acs() from devm_of_pci_bridge_init().
> >>>>>>
> >>>>>> But during the review of the series, several comments were received
> >>>>>> and they
> >>>>>> required the series to be reworked completely. Hence, in this
> >>>>>> version, I've
> >>>>>> incorported the comments as below:
> >>>>>>
> >>>>>> 1. For the ACS enablement issue, I've moved the pci_enable_acs()
> >>>>>> call from
> >>>>>> pci_acs_init() to pci_dma_configure().
> >>>>>>
> >>>>>> 2. For the IDT issue, I've cached the ACS capabilities (RO) in
> >>>>>> 'pci_dev',
> >>>>>> collected the broken capability for the IDT switches in the quirk
> >>>>>> and used it to
> >>>>>> disable the capability in the cache. This also allowed me to get
> >>>>>> rid of the
> >>>>>> earlier workaround for the switch.
> >>>>>>
> >>>>>> [1]
> >>>>>> https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> >>>>>> [2]
> >>>>>> https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> >>>>>> [3]
> >>>>>> https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> >>>>>> [4]
> >>>>>> https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> >>>>>> [5]
> >>>>>> https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> >>>>>> [6]
> >>>>>> https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com
> >>>>>>
> >>>>> Thanks for this patchset! I've tested it on my ARM Juno R1 and it
> >>>>> looks that it almost works fine. This patchset even fixed some
> >>>>> issues with PCI devices probe, as I again see SATA and GBit ethernet
> >>>>> devices, which were missing since Linux v6.14 (it looks that
> >>>>> I've also missed this in my tests).
> >>>>>
> >>>>> # lspci
> >>>>> 00:00.0 PCI bridge: PLDA PCI Express Core Reference Design (rev 01)
> >>>>> 01:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 02:01.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 02:02.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 02:03.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 02:0c.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 02:10.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 02:1f.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device
> >>>>> 8090 (rev 02)
> >>>>> 03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial
> >>>>> ATA Raid II Controller (rev 01)
> >>>>> 08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057
> >>>>> PCI-E Gigabit Ethernet Controller
> >>>>>
> >>>>> However there is also a regression. After applying this patchset
> >>>>> system suspend/resume stopped working. This is probably related to
> >>>>> this message:
> >>>>>
> >>>>> pcieport 0000:02:1f.0: Unable to change power state from D0 to
> >>>>> D3hot, device inaccessible
> >>>>>
> >>>>> which appears after calling 'rtcwake -s10 -mmem'. This might not be
> >>>>> related to this patchset, so I probably need to apply it on older
> >>>>> kernel releases and check.
> >>>>
> >>>> Just one more information - I've applied this patchset on top of
> >>>> v6.16 and it works perfectly on ARM Juno R1. SATA and GBit ethernet
> >>>> are visible again and system suspend/resume works too, so the issue
> >>>> with the latter on top of v6.18 seems not to be directly related to
> >>>> $subject patchset. I will try to bisect this issue when I have some
> >>>> spare time.
> >>>>
> >>>> Feel free to add:
> >>>>
> >>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>
> >>> I spent some time analyzing this regression on Juno R1 and found that:
> >>>
> >>> 1. SATA and GBit Ethernet stopped working after commit bcb81ac6ae3c
> >>> ("iommu: Get DT/ACPI parsing into the proper probe path") merged to
> >>> v6.15-rc1.
> >>>
> >>> 2. With $subject patch applied to enable SATA & GBit ethernet again,
> >>> system suspend/resume stopped working after commit f3ac2ff14834
> >>> ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> >>> platforms") merged to v6.18-rc1.
> >>>
> > Yes, this was expected as if you don't disable ACS, it will cause issues in
> > detecting the devices.
> >
> >>> If I got it right, according to the latter commit message, some quirks
> >>> have to be added to fix the suspend/resume issue. Unfortunately I have
> >>> no idea if this is the Juno R1 or the given PCI devices specific issue.
> >>
> >> And one more note, commit df5192d9bb0e ("PCI/ASPM: Enable only L0s and
> >> L1 for devicetree platforms") doesn't fix the suspend/resume issue
> >> either (with $subject patchset applied on top of it).
> >>
> > Interesting. Can you do:
> >
> > echo performance > /sys/module/pcie_aspm/parameters/policy
> >
> > and then suspend?
> 
> After the above command, system suspend/resume works again.
> 

Ok, so ASPM L0s/L1 seems to be the issue. But I'm not quite sure why it causes
issue during suspend/resume. If the device/controller doesn't play well with
ASPM L0s/L1, it should atleast cause the issue before entering suspend.

I'm clueless here atm...

- Mani

-- 
மணிவண்ணன் சதாசிவம்

