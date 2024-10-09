Return-Path: <linux-pci+bounces-14106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8A997494
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ED7289E16
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571171E7C3E;
	Wed,  9 Oct 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z1IYlSsn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EE1E7C3C
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497448; cv=none; b=SYm7dircFynNg7yq/MR72Tr6dn8jLf9nBuFXq4YVYwTmcFy+sAmKLKZkRiw1OKHUbJwHKigBwbRMUjoHptGtQ0WraW2kINx/C+K+iCX7qdPvmkqHsRP5JCam3G+L+Ehhm3JdDclw4XERMCrub5uhwlWM6MXoVbk0wF1MU8Bii24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497448; c=relaxed/simple;
	bh=QPOanPgJFlVzW0RbJydkKyLyhAqZVaIaqthmBpKTDok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=suF1IOi0bSL0woX70xYx2rXNcDdWj1fBmmHbyE4VoMKXECsd1nDMBuVRp7Jn1+bv47O1u0i4YWjtHK3+kqx9011S3ULPkMG1YXXOeeoWsIyd3bTSjlvENtBqGkinKxxQaNmk5Vd2L4YP4Vj0ecW4w9vATChenP/WsNEO6Fy+zN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z1IYlSsn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241009181036euoutp020daf77d631c482e80bd7b1f9eeda57ff~820K3DV_F2987929879euoutp02O
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 18:10:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241009181036euoutp020daf77d631c482e80bd7b1f9eeda57ff~820K3DV_F2987929879euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728497436;
	bh=a1+aGGDY7gLXa9F7gmGdvRnsfyj86kHL0OMap4GoVSM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Z1IYlSsnSJ1X0J0fTpsWyDpH9CPR61RMdBaus+Uo/SnZI81cBGVX899SWQu2yThL3
	 StraYdFu8VtNZhFeZpy+i5A66yJwoQ28ZOAiXmKloOtDtMg4wtKSlrpBP9bIpJ7ly4
	 QpIHBmv7gmu0EcyIHiRSHorFY08D8zAZtK0amlLg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009181036eucas1p200f69168ead85ca8f38699f68e115146~820KYEAC_0374503745eucas1p2O;
	Wed,  9 Oct 2024 18:10:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 87.CD.09624.B17C6076; Wed,  9
	Oct 2024 19:10:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241009181035eucas1p1410785aa81c9ec764c44d3f6eea940ed~820KCipzQ1101111011eucas1p1V;
	Wed,  9 Oct 2024 18:10:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241009181035eusmtrp22bcbb1bedae3e13e1ca69f73ca670b63~820KB97jP0158201582eusmtrp2D;
	Wed,  9 Oct 2024 18:10:35 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-c5-6706c71babe5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.C1.14621.B17C6076; Wed,  9
	Oct 2024 19:10:35 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241009181033eusmtip19b33e071bb5937cadb301dba4902d1c9~820IOAOXx2542925429eusmtip1I;
	Wed,  9 Oct 2024 18:10:33 +0000 (GMT)
Message-ID: <6d438995-4d6d-4a21-9ad2-8a0352482d44@samsung.com>
Date: Wed, 9 Oct 2024 20:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: Enable runtime pm of the host bridge
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, manivannan.sadhasivam@linaro.org
Cc: Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241003-runtime_pm-v5-1-3ebd1a395d45@quicinc.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87rSx9nSDZrmW1gsacqwuLxrDpvF
	2XnH2Sw+9x5htLjb0slq8X/Wc1aLBw8qLebc57O4tf87u8Xi+w8YLeZ+mcrswO2xYFOpx6ZV
	nWwed67tYfOYuKfO4/MmOY/bz7axBLBFcdmkpOZklqUW6dslcGVs/PyBuWB9VcXj35tYGhgX
	ZXYxcnJICJhIrHj6n62LkYtDSGAFo8TRcxNZQBJCAl8YJS4c0YNIfGaU+LLhIDtMx4+3HawQ
	RcsZJR7fLoUo+sgo0bDgEFiCV8BO4sSr62A2i4CKxMule9gg4oISJ2c+AdsgKiAvcf/WDLCh
	wgKOEpueTmIFGSQi0MgosfdSIwuIwyxwkVHi/fIHYB3MAuISt57MZwKx2QQMJbredoFN5RRw
	kOieuoAZokZeonnrbGaQZgmBHxwSR3dtAHI4gBwXiY1LQyFeEJZ4dXwL1DsyEv93gswEqW9n
	lFjw+z6UMwHon+e3GCGqrCXunPvFBjKIWUBTYv0ufYiwo8Sv1qVMEPP5JG68FYS4gU9i0rbp
	UGt5JTrahCCq1SRmHV8Ht/bghUvMExiVZiGFyywkX85C8s0shL0LGFlWMYqnlhbnpqcWG+al
	lusVJ+YWl+al6yXn525iBCar0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4dReypgvxpiRWVqUW
	5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwiZx8+6U0gUepmv3puXwu
	JmWnmRZuW3s91NZciHO9tfRk+orGN1c5bRgvKUgJ/Pz7yFLt2Xc7V6vVJ5ZKnLYN+xFXdX1C
	mKyYYoKHxdMbnGl3rv583B8s6lCpffvdh6SnvfOW68vub1F4u6GDxe7OKol3l1NPzy4/l3fi
	xmV+VuHgPpGw7EdVuybHn/9teXpOarFA93OBfT/fT3DWE55sG2ZU1G20ptF4EuMDz/O+TCIX
	3JqK2A7mPWeNEq+e9b/wYPGcvzzPvm89qvCZW7XLNqTmzRduncfb/FZwz5DOO/9Vfuntf+zu
	AaeO+Dg9P3s7rOzaQeUZ0jfFdvD9c3a8r3Oz31x6rtClOz1JofxySizFGYmGWsxFxYkA3FPZ
	ysUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7rSx9nSDf41qlosacqwuLxrDpvF
	2XnH2Sw+9x5htLjb0slq8X/Wc1aLBw8qLebc57O4tf87u8Xi+w8YLeZ+mcrswO2xYFOpx6ZV
	nWwed67tYfOYuKfO4/MmOY/bz7axBLBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
	x1oZmSrp29mkpOZklqUW6dsl6GVs/PyBuWB9VcXj35tYGhgXZXYxcnJICJhI/HjbwdrFyMUh
	JLCUUWLd/PtMEAkZiZPTGlghbGGJP9e62CCK3jNKLJ4+kR0kwStgJ3Hi1XWwIhYBFYmXS/ew
	QcQFJU7OfMICYosKyEvcvzUDrF5YwFFi09NJYNtEBBoZJU4t7GYCcZgFLjJKrDrZDTZJSMBe
	Ytr6XjCbWUBc4taT+WAnsQkYSnS97QLbwCngINE9dQEzRI2ZRNfWLkYIW16ieets5gmMQrOQ
	HDILyahZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBCtx37uXkH47xXH/UO
	MTJxMB5ilOBgVhLh1V3Imi7Em5JYWZValB9fVJqTWnyI0RQYGhOZpUST84EpIq8k3tDMwNTQ
	xMzSwNTSzFhJnNft8vk0IYH0xJLU7NTUgtQimD4mDk6pBqbag1UWk2r4O+asfW/0krmu3u+P
	vZJz8m9RN3Pnis9aP1/43zo2pSn3122DgGmzKv+UJxn2q02va598Y3Pi2ZPrTuau1Ow1PDh9
	gqXO9fvXyl9Xchjn10vytf3cJJV9sp3jZu/sKYIHuHh3K/484MhcMutt936Nid4Cglbr1Bb9
	XTLHkj1y5xet9C6FJWvyV564xht66tMiZ/k3cS7Gv3oyD/kHJ62xDE3yNKpL8TRL2jvFvjX7
	J+vuzPXa0vG7jCR+TNmv13s/ZNdZG5Xby97/2aom0+K+Natar7RkcprDjz9zT6+LEXxqpqzG
	aPZmW/hd0yx1A11+VZOF/xI0e6cYKOcLzmuOnM0xPUC+QYmlOCPRUIu5qDgRAIAkbfVZAwAA
X-CMS-MailID: 20241009181035eucas1p1410785aa81c9ec764c44d3f6eea940ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241009181035eucas1p1410785aa81c9ec764c44d3f6eea940ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241009181035eucas1p1410785aa81c9ec764c44d3f6eea940ed
References: <20241003-runtime_pm-v5-1-3ebd1a395d45@quicinc.com>
	<CGME20241009181035eucas1p1410785aa81c9ec764c44d3f6eea940ed@eucas1p1.samsung.com>

Hi Krishna,

On 03.10.2024 08:02, Krishna chaitanya chundru wrote:
> The Controller driver is the parent device of the PCIe host bridge,
> PCI-PCI bridge and PCIe endpoint as shown below.
>
>          PCIe controller(Top level parent & parent of host bridge)
>                          |
>                          v
>          PCIe Host bridge(Parent of PCI-PCI bridge)
>                          |
>                          v
>          PCI-PCI bridge(Parent of endpoint driver)
>                          |
>                          v
>                  PCIe endpoint driver
>
> Now, when the controller device goes to runtime suspend, PM framework
> will check the runtime PM state of the child device (host bridge) and
> will find it to be disabled. So it will allow the parent (controller
> device) to go to runtime suspend. Only if the child device's state was
> 'active' it will prevent the parent to get suspended.
>
> It is a property of the runtime PM framework that it can only
> follow continuous dependency chains.  That is, if there is a device
> with runtime PM disabled in a dependency chain, runtime PM cannot be
> enabled for devices below it and above it in that chain both at the
> same time.
>
> Since runtime PM is disabled for host bridge, the state of the child
> devices under the host bridge is not taken into account by PM framework
> for the top level parent, PCIe controller. So PM framework, allows
> the controller driver to enter runtime PM irrespective of the state
> of the devices under the host bridge. And this causes the topology
> breakage and also possible PM issues like controller driver goes to
> runtime suspend while endpoint driver is doing some transfers.
>
> Because of the above, in order to enable runtime PM for a PCIe
> controller device, one needs to ensure that runtime PM is enabled for
> all devices in every dependency chain between it and any PCIe endpoint
> (as runtime PM is enabled for PCIe endpoints).
>
> This means that runtime PM needs to be enabled for the host bridge
> device, which is present in all of these dependency chains.
>
> After this change, the host bridge device will be runtime-suspended
> by the runtime PM framework automatically after suspending its last
> child and it will be runtime-resumed automatically before resuming its
> first child which will allow the runtime PM framework to track
> dependencies between the host bridge device and all of its
> descendants.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This patch landed in today's linux-next as commit 02787a3b4d10 ("PCI/PM: 
Enable runtime power management for host bridges"). In my tests I found 
that it triggers a warning on StarFive VisionFive2 RISC-V board. It 
looks that some more changes are needed in the dwc-pci driver or so. 
There is a message from runtime pm subsystem about inactive device with 
active children and suspicious locking pattern. Here is the log I 
observed on that board:

---->8---

pcie-starfive 940000000.pcie: port link up
pcie-starfive 940000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [mem 0x30000000-0x37ffffff]
pci_bus 0000:00: root bus resource [mem 0x900000000-0x93fffffff pref]
pci 0000:00:00.0: [1556:1111] type 01 class 0x060400 PCIe Root Port
pci 0000:00:00.0: PCI bridge to [bus 00]
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: [1106:3483] type 00 class 0x0c0330 PCIe Endpoint
pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
pci 0000:01:00.0: PME# supported from D0 D3cold
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:00.0: bridge window [mem 0x30000000-0x300fffff]: assigned
pci 0000:01:00.0: BAR 0 [mem 0x30000000-0x30000fff 64bit]: assigned
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x30000000-0x300fffff]
pci_bus 0000:00: resource 4 [mem 0x30000000-0x37ffffff]
pci_bus 0000:00: resource 5 [mem 0x900000000-0x93fffffff pref]
pci_bus 0000:01: resource 1 [mem 0x30000000-0x300fffff]
pcieport 0000:00:00.0: enabling device (0000 -> 0002)
pcieport 0000:00:00.0: PME: Signaling with IRQ 53
pci 0000:01:00.0: enabling device (0000 -> 0002)
xhci_hcd 0000:01:00.0: xHCI Host Controller
xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:01:00.0: hcc params 0x002841eb hci version 0x100 quirks 
0x0000000000000890
xhci_hcd 0000:01:00.0: xHCI Host Controller
xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device 
with active children

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1+ #15438 Not tainted
------------------------------------------------------
systemd-udevd/159 is trying to acquire lock:
ffffffff81822520 (console_owner){-.-.}-{0:0}, at: 
console_lock_spinning_enable+0x3a/0x60

but task is already holding lock:
ffffffd6c0b3d980 (&dev->power.lock){-...}-{2:2}, at: 
pm_runtime_enable+0x1e/0xb6

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&dev->power.lock){-...}-{2:2}:
        lock_acquire.part.0+0xa2/0x1d4
        lock_acquire+0x44/0x5a
        _raw_spin_lock_irqsave+0x3a/0x64
        __pm_runtime_resume+0x40/0x86
        __uart_start+0x40/0xb2
        uart_write+0x90/0x220
        n_tty_write+0x10a/0x40e
        file_tty_write.constprop.0+0x10c/0x230
        redirected_tty_write+0x84/0xbc
        do_iter_readv_writev+0x100/0x166
        vfs_writev+0xc6/0x398
        do_writev+0x5c/0xca
        __riscv_sys_writev+0x16/0x1e
        do_trap_ecall_u+0x1b6/0x1e2
        _new_vmalloc_restore_context_a0+0xc2/0xce

-> #1 (&port_lock_key){-.-.}-{2:2}:
        lock_acquire.part.0+0xa2/0x1d4
        lock_acquire+0x44/0x5a
        _raw_spin_lock_irqsave+0x3a/0x64
        serial8250_console_write+0x2a0/0x474
        univ8250_console_write+0x22/0x2a
        console_flush_all+0x2f6/0x3c8
        console_unlock+0x80/0x1a8
        vprintk_emit+0x10e/0x2e0
        vprintk_default+0x16/0x1e
        vprintk+0x1e/0x3c
        _printk+0x36/0x50
        register_console+0x292/0x418
        serial_core_register_port+0x6d6/0x6dc
        serial_ctrl_register_port+0xc/0x14
        uart_add_one_port+0xc/0x14
        serial8250_register_8250_port+0x288/0x428
        dw8250_probe+0x422/0x518
        platform_probe+0x4e/0x92
        really_probe+0x10a/0x2da
        __driver_probe_device.part.0+0xb2/0xe8
        driver_probe_device+0x78/0xc4
        __device_attach_driver+0x66/0xc6
        bus_for_each_drv+0x5c/0xb0
        __device_attach+0x84/0x13c
        device_initial_probe+0xe/0x16
        bus_probe_device+0x88/0x8a
        deferred_probe_work_func+0xd4/0xee
        process_one_work+0x1e0/0x534
        worker_thread+0x166/0x2cc
        kthread+0xc4/0xe0
        ret_from_fork+0xe/0x18

-> #0 (console_owner){-.-.}-{0:0}:
        check_noncircular+0x10e/0x122
        __lock_acquire+0x105c/0x1f4a
        lock_acquire.part.0+0xa2/0x1d4
        lock_acquire+0x44/0x5a
        console_lock_spinning_enable+0x58/0x60
        console_flush_all+0x2cc/0x3c8
        console_unlock+0x80/0x1a8
        vprintk_emit+0x10e/0x2e0
        dev_vprintk_emit+0xea/0x112
        dev_printk_emit+0x2e/0x48
        __dev_printk+0x40/0x5c
        _dev_warn+0x46/0x60
        pm_runtime_enable+0x98/0xb6
        starfive_pcie_probe+0x12e/0x228 [pcie_starfive]
        platform_probe+0x4e/0x92
        really_probe+0x10a/0x2da
        __driver_probe_device.part.0+0xb2/0xe8
        driver_probe_device+0x78/0xc4
        __driver_attach+0x54/0x162
        bus_for_each_dev+0x58/0xa4
        driver_attach+0x1a/0x22
        bus_add_driver+0xec/0x1ce
        driver_register+0x3e/0xd8
        __platform_driver_register+0x1c/0x24
        starfive_pcie_driver_init+0x20/0x1000 [pcie_starfive]
        do_one_initcall+0x5e/0x28c
        do_init_module+0x52/0x1ba
        load_module+0x1440/0x18f0
        init_module_from_file+0x76/0xae
        idempotent_init_module+0x18c/0x24a
        __riscv_sys_finit_module+0x52/0x82
        do_trap_ecall_u+0x1b6/0x1e2
        _new_vmalloc_restore_context_a0+0xc2/0xce

other info that might help us debug this:

Chain exists of:
   console_owner --> &port_lock_key --> &dev->power.lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&dev->power.lock);
                                lock(&port_lock_key);
                                lock(&dev->power.lock);
   lock(console_owner);

  *** DEADLOCK ***

4 locks held by systemd-udevd/159:
  #0: ffffffd6c0b3d8f8 (&dev->mutex){....}-{3:3}, at: 
__driver_attach+0x4c/0x162
  #1: ffffffd6c0b3d980 (&dev->power.lock){-...}-{2:2}, at: 
pm_runtime_enable+0x1e/0xb6
  #2: ffffffff818223b0 (console_lock){+.+.}-{0:0}, at: 
dev_vprintk_emit+0xea/0x112
  #3: ffffffff81822448 (console_srcu){....}-{0:0}, at: 
console_flush_all+0x4e/0x3c8

stack backtrace:
CPU: 1 UID: 0 PID: 159 Comm: systemd-udevd Not tainted 6.12.0-rc1+ #15438
Hardware name: StarFive VisionFive 2 v1.2A (DT)
Call Trace:
[<ffffffff80006a02>] dump_backtrace+0x1c/0x24
[<ffffffff80b70b3e>] show_stack+0x2c/0x38
[<ffffffff80b7f8f8>] dump_stack_lvl+0x7a/0xb4
[<ffffffff80b7f946>] dump_stack+0x14/0x1c
[<ffffffff8007fbc2>] print_circular_bug+0x2aa/0x350
[<ffffffff8007fd76>] check_noncircular+0x10e/0x122
[<ffffffff80082a3c>] __lock_acquire+0x105c/0x1f4a
[<ffffffff80084148>] lock_acquire.part.0+0xa2/0x1d4
[<ffffffff800842be>] lock_acquire+0x44/0x5a
[<ffffffff8008b3e8>] console_lock_spinning_enable+0x58/0x60
[<ffffffff8008c0c2>] console_flush_all+0x2cc/0x3c8
[<ffffffff8008c23e>] console_unlock+0x80/0x1a8
[<ffffffff8008c710>] vprintk_emit+0x10e/0x2e0
[<ffffffff80b79ec8>] dev_vprintk_emit+0xea/0x112
[<ffffffff80b79f1e>] dev_printk_emit+0x2e/0x48
[<ffffffff80b7a006>] __dev_printk+0x40/0x5c
[<ffffffff80b7a2be>] _dev_warn+0x46/0x60
[<ffffffff807037ae>] pm_runtime_enable+0x98/0xb6
[<ffffffff02763240>] starfive_pcie_probe+0x12e/0x228 [pcie_starfive]
[<ffffffff806f83f6>] platform_probe+0x4e/0x92
[<ffffffff80b7a680>] really_probe+0x10a/0x2da
[<ffffffff80b7a902>] __driver_probe_device.part.0+0xb2/0xe8
[<ffffffff806f6112>] driver_probe_device+0x78/0xc4
[<ffffffff806f6278>] __driver_attach+0x54/0x162
[<ffffffff806f42e6>] bus_for_each_dev+0x58/0xa4
[<ffffffff806f5c9e>] driver_attach+0x1a/0x22
[<ffffffff806f54ce>] bus_add_driver+0xec/0x1ce
[<ffffffff806f7112>] driver_register+0x3e/0xd8
[<ffffffff806f80cc>] __platform_driver_register+0x1c/0x24
[<ffffffff027ea020>] starfive_pcie_driver_init+0x20/0x1000 [pcie_starfive]
[<ffffffff800027ba>] do_one_initcall+0x5e/0x28c
[<ffffffff800bb4d8>] do_init_module+0x52/0x1ba
[<ffffffff800bcc8a>] load_module+0x1440/0x18f0
[<ffffffff800bd2f0>] init_module_from_file+0x76/0xae
[<ffffffff800bd4b4>] idempotent_init_module+0x18c/0x24a
[<ffffffff800bd5fc>] __riscv_sys_finit_module+0x52/0x82
[<ffffffff80b804a0>] do_trap_ecall_u+0x1b6/0x1e2
[<ffffffff80b8c536>] _new_vmalloc_restore_context_a0+0xc2/0xce
pcie-starfive 940000000.pcie: driver: 'pcie-starfive': driver_bound: 
bound to device
/soc/pcie@940000000 Dropping the fwnode link to 
/soc/pcie@940000000/interrupt-controller
pcie-starfive 940000000.pcie: Dropping the link to 10210000.phy
device: 'platform:10210000.phy--platform:940000000.pcie': device_unregister
pcie-starfive 940000000.pcie: Dropping the link to 10230000.clock-controller
device: 'platform:10230000.clock-controller--platform:940000000.pcie': 
device_unregister
pcie-starfive 940000000.pcie: bus: 'platform': really_probe: bound 
device to driver pcie-starfive
platform 9c0000000.pcie: bus: 'platform': __driver_probe_device: matched 
device with driver pcie-starfive
platform 9c0000000.pcie: bus: 'platform': really_probe: probing driver 
pcie-starfive with device
pcie-starfive 9c0000000.pcie: no init pinctrl state
pcie-starfive 9c0000000.pcie: no sleep pinctrl state
pcie-starfive 9c0000000.pcie: no idle pinctrl state
device: 'phy:phy-10220000.phy.1--platform:9c0000000.pcie': device_add
devices_kset: Moving 9c0000000.pcie to end of list
PM: Moving platform:9c0000000.pcie to end of list
pcie-starfive 9c0000000.pcie: Linked as a consumer to phy-10220000.phy.1
pcie-starfive 9c0000000.pcie: host bridge /soc/pcie@9c0000000 ranges:
pcie-starfive 9c0000000.pcie:      MEM 0x0038000000..0x003fffffff -> 
0x0038000000
pcie-starfive 9c0000000.pcie:      MEM 0x0980000000..0x09bfffffff -> 
0x0980000000

--->8---


> ---
> Changes in v5:
> - call pm_runtime_no_callbacks() as suggested by Rafael.
> - include the commit texts as suggested by Rafael.
> - Link to v4: https://lore.kernel.org/linux-pci/20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com/
> Changes in v4:
> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> Changes in v3:
> - Moved the runtime API call's from the dwc driver to PCI framework
>    as it is applicable for all (suggested by mani)
> - Updated the commit message.
> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> Changes in v2:
> - Updated commit message as suggested by mani.
> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> ---
>
> ---
>   drivers/pci/probe.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..8409e1dde0d1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3106,6 +3106,11 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>   		pcie_bus_configure_settings(child);
>   
>   	pci_bus_add_devices(bus);
> +
> +	pm_runtime_set_active(&bridge->dev);
> +	pm_runtime_no_callbacks(&bridge->dev);
> +	devm_pm_runtime_enable(&bridge->dev);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pci_host_probe);
>
> ---
> base-commit: c02d24a5af66a9806922391493205a344749f2c4
> change-id: 20241003-runtime_pm-655d48356c8b
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


