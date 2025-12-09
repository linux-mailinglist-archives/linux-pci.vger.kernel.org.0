Return-Path: <linux-pci+bounces-42834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A7CAFBEA
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0DA930989FC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8475322768;
	Tue,  9 Dec 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExIvycfi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B432142A;
	Tue,  9 Dec 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765278962; cv=none; b=qV5PHn55QabJGoHPiIjqVU8CT5eEARBX2MdW5j7dD+eMwlVQALugYKFoWBf4TXNVIPpsZfe5uQXupf5nF9kZ0xmoW/cwkDptBOmdKykj2nczlROJMyrHSM5ymqG/fxYngtknrj9SnPiWnChViunf9FoCUokICdiAfA9KvJ4/S1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765278962; c=relaxed/simple;
	bh=DZXYRWC4FNGveUsqZ647BbdX3RbOUO/uYKkr9cSpsy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvaxZO139SV+HGyoQLBJSY+JBKKzHhTdRjZdzYAoQ25nRjfJeoYuLW/efKpRSGT20jNTe+0laBVp1bLW6r1Pplfo/ECuUFAG5rPoGH9hVyorl34BIr+gD/3vmhXRRZE5l+fIePJpK2BBwNpuTTslqZnRCRIDsCapsl2S/z+4TV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExIvycfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA17C113D0;
	Tue,  9 Dec 2025 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765278961;
	bh=DZXYRWC4FNGveUsqZ647BbdX3RbOUO/uYKkr9cSpsy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExIvycfi51pTPIg2e0V/FFK8r4eS/belW4kOH7PS6Ntq2ZMV379QmCVK6ZRvN/III
	 EJ+pkJuS6XX+Pp1sBaJwwZ10aIAcsMgIPO5jMbb5klGKUjcsXgePs4H2I59rq2zSDo
	 mtrsorMFgJ9RgXH8xoj5x4iBwdsluy5O/PaIw2FENHwc47RyWGeBetsSgKrXzDK6b2
	 Ve84OalSfkOw3OBSawdXarSQkV9t8DXVTZ+2XNvuVut5+DPpTJPvn8erjVstUnHroL
	 7u6M9EGmjbwVjyh4hHpRIKX8oYmxBFu9PkXRsTkHyOCqlo5Gx7Jpxado8Q5FJKFZkz
	 B5k7Vb2Y5Lo9w==
Date: Tue, 9 Dec 2025 20:15:52 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Message-ID: <4clyxcy5pwqaz6uguxnjei4hnxsree6k2uz5upro7khuvklfyo@nc5ebeicuqw4>
References: <CGME20251202142307eucas1p12a15e5656bb53f48f445c3056d4e3166@eucas1p1.samsung.com>
 <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <b63ec0aa-7a4a-4f8d-9b93-e724f3f2a9d1@samsung.com>
 <de80df44-f797-4e8c-a411-09ed3c1286a3@samsung.com>
 <cae5cb24-a8b0-4088-bacd-14368f32bdc5@samsung.com>
 <26a93564-fcdd-4e90-b28d-8cc84cedeaa8@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26a93564-fcdd-4e90-b28d-8cc84cedeaa8@samsung.com>

On Tue, Dec 09, 2025 at 09:28:38AM +0100, Marek Szyprowski wrote:
> On 09.12.2025 08:31, Marek Szyprowski wrote:
> > On 04.12.2025 14:13, Marek Szyprowski wrote:
> >> On 03.12.2025 13:04, Marek Szyprowski wrote:
> >>> On 02.12.2025 15:22, Manivannan Sadhasivam wrote:
> >>>> This series fixes the long standing issue with ACS in OF platforms. 
> >>>> There are
> >>>> two fixes in this series, both fixing independent issues on their 
> >>>> own, but both
> >>>> are needed to properly enable ACS on OF platforms.
> >>>>
> >>>> Issue(s) background
> >>>> ===================
> >>>>
> >>>> Back in 2021, Xingang Wang first noted a failure in attaching the 
> >>>> HiSilicon SEC
> >>>> device to QEMU ARM64 pci-root-port device [1]. He then tracked down 
> >>>> the issue to
> >>>> ACS not being enabled for the QEMU Root Port device and he proposed 
> >>>> a patch to
> >>>> fix it [2].
> >>>>
> >>>> Once the patch got applied, people reported PCIe issues with 
> >>>> linux-next on the
> >>>> ARM Juno Development boards, where they saw failure in enumerating 
> >>>> the endpoint
> >>>> devices [3][4]. So soon, the patch got dropped, but the actual 
> >>>> issue with the
> >>>> ARM Juno boards was left behind.
> >>>>
> >>>> Fast forward to 2024, Pavan resubmitted the same fix [5] for his 
> >>>> own usecase,
> >>>> hoping that someone in the community would fix the issue with ARM 
> >>>> Juno boards.
> >>>> But the patch was rightly rejected, as a patch that was known to 
> >>>> cause issues
> >>>> should not be merged to the kernel. But again, no one investigated 
> >>>> the Juno
> >>>> issue and it was left behind again.
> >>>>
> >>>> Now it ended up in my plate and I managed to track down the issue 
> >>>> with the help
> >>>> of Naresh who got access to the Juno boards in LKFT. The Juno issue 
> >>>> was with the
> >>>> PCIe switch from Microsemi/IDT, which triggers ACS Source 
> >>>> Validation error on
> >>>> Completions received for the Configuration Read Request from a 
> >>>> device connected
> >>>> to the downstream port that has not yet captured the PCIe bus 
> >>>> number. As per the
> >>>> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and 
> >>>> Device Numbers
> >>>> supplied with all Type 0 Configuration Write Requests completed by 
> >>>> the Function
> >>>> and supply these numbers in the Bus and Device Number fields of the 
> >>>> Requester ID
> >>>> for all Requests". So during the first Configuration Read Request 
> >>>> issued by the
> >>>> switch downstream port during enumeration (for reading Vendor ID), 
> >>>> Bus and
> >>>> Device numbers will be unknown to the device. So it responds to the 
> >>>> Read Request
> >>>> with Completion having Bus and Device number as 0. The switch 
> >>>> interprets the
> >>>> Completion as an ACS Source Validation error and drops the 
> >>>> completion, leading
> >>>> to the failure in detecting the endpoint device. Though the PCIe 
> >>>> spec r6.0, sec
> >>>> 6.12.1.1, states that "Completions are never affected by ACS Source 
> >>>> Validation".
> >>>> This behavior is in violation of the spec.
> >>>>
> >>>> Solution
> >>>> ========
> >>>>
> >>>> In September, I submitted a series [6] to fix both issues. For the 
> >>>> IDT issue,
> >>>> I reused the existing quirk in the PCI core which does a dummy 
> >>>> config write
> >>>> before issuing the first config read to the device. And for the ACS 
> >>>> enablement
> >>>> issue, I just resubmitted the original patch from Xingang which called
> >>>> pci_request_acs() from devm_of_pci_bridge_init().
> >>>>
> >>>> But during the review of the series, several comments were received 
> >>>> and they
> >>>> required the series to be reworked completely. Hence, in this 
> >>>> version, I've
> >>>> incorported the comments as below:
> >>>>
> >>>> 1. For the ACS enablement issue, I've moved the pci_enable_acs() 
> >>>> call from
> >>>> pci_acs_init() to pci_dma_configure().
> >>>>
> >>>> 2. For the IDT issue, I've cached the ACS capabilities (RO) in 
> >>>> 'pci_dev',
> >>>> collected the broken capability for the IDT switches in the quirk 
> >>>> and used it to
> >>>> disable the capability in the cache. This also allowed me to get 
> >>>> rid of the
> >>>> earlier workaround for the switch.
> >>>>
> >>>> [1] 
> >>>> https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> >>>> [2] 
> >>>> https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> >>>> [3] 
> >>>> https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> >>>> [4] 
> >>>> https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> >>>> [5] 
> >>>> https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> >>>> [6] 
> >>>> https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com
> >>>>
> >>> Thanks for this patchset! I've tested it on my ARM Juno R1 and it 
> >>> looks that it almost works fine. This patchset even fixed some 
> >>> issues with PCI devices probe, as I again see SATA and GBit ethernet 
> >>> devices, which were missing since Linux v6.14 (it looks that 
> >>> I've also missed this in my tests).
> >>>
> >>> # lspci
> >>> 00:00.0 PCI bridge: PLDA PCI Express Core Reference Design (rev 01)
> >>> 01:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 02:01.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 02:02.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 02:03.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 02:0c.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 02:10.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 02:1f.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 
> >>> 8090 (rev 02)
> >>> 03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial 
> >>> ATA Raid II Controller (rev 01)
> >>> 08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057 
> >>> PCI-E Gigabit Ethernet Controller
> >>>
> >>> However there is also a regression. After applying this patchset 
> >>> system suspend/resume stopped working. This is probably related to 
> >>> this message:
> >>>
> >>> pcieport 0000:02:1f.0: Unable to change power state from D0 to 
> >>> D3hot, device inaccessible
> >>>
> >>> which appears after calling 'rtcwake -s10 -mmem'. This might not be 
> >>> related to this patchset, so I probably need to apply it on older 
> >>> kernel releases and check.
> >>
> >>
> >> Just one more information - I've applied this patchset on top of 
> >> v6.16 and it works perfectly on ARM Juno R1. SATA and GBit ethernet 
> >> are visible again and system suspend/resume works too, so the issue 
> >> with the latter on top of v6.18 seems not to be directly related to 
> >> $subject patchset. I will try to bisect this issue when I have some 
> >> spare time.
> >>
> >> Feel free to add:
> >>
> >> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> >
> > I spent some time analyzing this regression on Juno R1 and found that:
> >
> > 1. SATA and GBit Ethernet stopped working after commit bcb81ac6ae3c 
> > ("iommu: Get DT/ACPI parsing into the proper probe path") merged to 
> > v6.15-rc1.
> >
> > 2. With $subject patch applied to enable SATA & GBit ethernet again, 
> > system suspend/resume stopped working after commit f3ac2ff14834 
> > ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree 
> > platforms") merged to v6.18-rc1.
> >

Yes, this was expected as if you don't disable ACS, it will cause issues in
detecting the devices.

> > If I got it right, according to the latter commit message, some quirks 
> > have to be added to fix the suspend/resume issue. Unfortunately I have 
> > no idea if this is the Juno R1 or the given PCI devices specific issue.
> 
> 
> And one more note, commit df5192d9bb0e ("PCI/ASPM: Enable only L0s and 
> L1 for devicetree platforms") doesn't fix the suspend/resume issue 
> either (with $subject patchset applied on top of it).
> 

Interesting. Can you do:

echo performance > /sys/module/pcie_aspm/parameters/policy

and then suspend?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

