Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF91F8795
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jun 2020 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725267AbgFNH5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Jun 2020 03:57:25 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:6039
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725265AbgFNH5Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Jun 2020 03:57:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR6lcSe6YtO9i9QLKJt/uWICpLBgHQXHqLwJJTLg9/sL21r/GRllpuJoAhG3OX/P6/i2gezynDW8qGEnrjl3vXdo2SY5g22/tl/x1EQvfEiE0+QdpyhrgQosm4kNGPcopG0a8EQVz5w0BZNJMuPbraLNbRVUPkSh5PbIcR9t64jzXx4rtCHcjMuN0ag4VEr6W6Msuu2Iy2/9zfivgYLSNzxd/7ZCbyUqaaTHkzpLtCFeNyVDD/sWI5OP4VkbLwSrN72xslzsDXWtag53n+/wqOCfke1ec1o4pa7uG+ko99OX1Dzczj5OLRpxlDBivEVUnvjdsz9M2sAlispZ+S/PUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+eTnTc9HLcEEEFc26iPVik0r+ZKT3IOm1+MzJFE+hQ=;
 b=lekgC9AJVeLjxKufPWcoXaVst360744ToqOMnM2pmJGRFsevX+4uTR5+30dk2v/zaOoA9AYI6nEjEMTYVPLGgtvFxs4Pk0bjvsJpuyIzUO7fXT/lF400Z+oy9PpfLfgJn3sSRHmXfyNnKrxWnjA7KoUUdev3SX8MZ2uD9mUj6I0Z0Ykft4/jRwwR25j2QtvHbMi9UqQkSuTMBD/lMAYpCtDBBUrtGMoLj2lcslDBcAcMoFw7mHiyUfpKFuJZctdGXvSCvk4n75iSCKG+NbPedWrnUXOntbBldisNPSjn3SYIg2RzcV5DOCccMLXOSvfJ/iuBowHw0Vbh1qgaU2HQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+eTnTc9HLcEEEFc26iPVik0r+ZKT3IOm1+MzJFE+hQ=;
 b=P/YJWn7JrVvByglldEYkIA1aDjq1lWs3V2AXQJCToYecMeaI/O27Jd9ylO/9iyNw2Wc7hQRr3h7QY0+PrdpHGuIzFfjQeoFg5pDhYpm3G6kOl5ocmi/J4K30VjPBTEQ79K/clThBPmWikOpWg2k7Zwz8QM/RnJAwWMVD/czENlY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DBBPR05MB6299.eurprd05.prod.outlook.com (2603:10a6:10:d1::21)
 by DBBPR05MB6409.eurprd05.prod.outlook.com (2603:10a6:10:cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Sun, 14 Jun
 2020 07:57:13 +0000
Received: from DBBPR05MB6299.eurprd05.prod.outlook.com
 ([fe80::15f3:26da:d6fb:a29f]) by DBBPR05MB6299.eurprd05.prod.outlook.com
 ([fe80::15f3:26da:d6fb:a29f%5]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 07:57:13 +0000
Subject: Re: Adding support for Relaxed ordering on a non-root device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>, linux-pci@vger.kernel.org
References: <20200611223618.GA1615826@bjorn-Precision-5520>
From:   Aya Levin <ayal@mellanox.com>
Message-ID: <378c5405-e5d2-eff1-7b35-5b3c5f73fec2@mellanox.com>
Date:   Sun, 14 Jun 2020 10:56:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200611223618.GA1615826@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::27) To DBBPR05MB6299.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.13] (77.138.160.220) by AM4P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Sun, 14 Jun 2020 07:57:11 +0000
X-Originating-IP: [77.138.160.220]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94e4d767-ba79-4a70-8c60-08d810388c11
X-MS-TrafficTypeDiagnostic: DBBPR05MB6409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR05MB6409FCEAAEA7E5A38E79B313B09F0@DBBPR05MB6409.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04347F8039
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1B5QYo0SXdVhS+Ai7MYKyHXU3dozbolpgLrl3STZvZRRzCipUsZBEsQTk2gWcgzlyFTUncX0nY1ZpQATlEtX8IMM2QtdP0XXJAoIQyJ8R2/hNV/C6hFQpmbdMSvFmjLeiL11ceYnk/silBef8Ex0jp+K5TkMHIbT90CVi5WL+y7P4S1SpyG4vcaw1AGl+3x7dT7ImzEGMKHN4RfVvHHjD17UZRyrSqMKx61mXivw0cj7fTsiw4mN0aKqYpx29YuiI+rpuWyKXxpXymzRDYzCds0f4Ls/6um+ox1vEFerfT7uBpiMo9Mf55VNzSaiNY/fVWYBxdrKE2U1MDKo9Zqhq4o0FaAxkMqpr5DVmu5rq74o8x0yB9K8PXg7sd71DiWa6OU/tygp0tvU4p6DFsQGa1mQsSmYj4L7kYNqm05xtik6vWQ4bySInIig9lfQbYQO1xOJd19VonB1bHYtyjoSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR05MB6299.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(52116002)(4326008)(6666004)(86362001)(54906003)(31686004)(316002)(2906002)(16576012)(6916009)(6486002)(31696002)(16526019)(186003)(30864003)(26005)(8936002)(66946007)(2616005)(5660300002)(53546011)(8676002)(66476007)(66556008)(36756003)(966005)(83380400001)(956004)(478600001)(43740500002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZISKRV7xad7/uBTYoBtMfb3MuWUOf2rl4sdq+dcI3xT2QqFA2U0jRd6KgU7uRukvCp8AaUq8W97uralYWvXnC3NK/MRN8aJmCc28EygtDih2g+FB4U7TZ8veiYkkHCGWrN4Z8vtimi6LOAXVFUWrzLPCy6lyfVierg2SckoNkZuWO8/U+LernMFzTOBdP6I4rvbCeyLKRHzcoJ+hRs1PjNGU/vBhK1JIGIzOWzYQpfupseq21w4RX91qWtjEK2/QMDCraXKm8mpZrh0eK6ETL4gExXFA3KezMgaDdU98D1AP1HhfBnJcUhBlq+CV5Q0UZmqUJmHfWamkApS3i3aB3zMjdyyi29Tod/++A6fUMN2j6TsFQpV6JahiO8iZrvjw+jcox0xD+dGb86HoUPk+uVMhi8JRDPo7vRRyt7hs/KQXL3UNGb2n7eCmcNEzXvzOnChWQFrB389KCgL23/U3pxVAap1X+TBpIUnuyYVEE8Y=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e4d767-ba79-4a70-8c60-08d810388c11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2020 07:57:13.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0OULvhPx194vXVfHca8nMGXrRXp/k6cw6DNGYs7LgF+UjPPhSEYHpRe3NTlE1rzgLydMvP2bTjAb65YjGkLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6409
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/12/2020 1:36 AM, Bjorn Helgaas wrote:
> On Mon, Jun 08, 2020 at 03:44:04PM +0300, Aya Levin wrote:
>> On 6/5/2020 10:08 PM, Bjorn Helgaas wrote:
>>> On Thu, Jun 04, 2020 at 03:35:48PM +0300, Aya Levin wrote:
>>>> Hi
>>>>
>>>> I am writing to you regarding your commits titled:
>>>> 1. a99b646afa8a PCI: Disable PCIe Relaxed Ordering if unsupported
>>>> 2. 87e09cdec4da PCI: Disable Relaxed Ordering for some Intel processors
>>>>
>>>> While adding support to relaxed ordering on Mellanox Ethernet driver I
>>>> tried to avoid the Intel's bug with pcie_relaxed_ordering_enabled.
>>>> Expecting this to return False on Haswell and Broadwell CPU. I run
>>>> this API on: Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz (I think it is
>>>> a Haswell, right?) and the API returned True. What am I missing?
>>>
>>> The quirk is based on Vendor/Device ID, which of course is a problem
>>> as new devices are released.  What does "lspci -vn" show on your
>>> system?
>> Please see attached file (output too long)
>>>
>>>> In addition, I saw your comment in pci_configure_relaxed_ordering
>>>> (pasted below) the non-root ports are not handled since Peer-to-Peer
>>>> DMA is another can of warms. Could you elaborate on the complexity?
>>>> What is the effort to extend this to non-root ports?
>>>
>>> There's some discussion about this here and in other parts of the same
>>> thread:
>>>
>>>     https://lore.kernel.org/linux-arm-kernel/20170809032503.GB7191@bhelgaas-glaptop.roam.corp.google.com/
>> Thanks,
>> So I am on the right path just with unexpected return value.
> 
> I'm not sure what you mean.  Do you need anything more from me, or is
> everything now working as you expect?
Yes, I need your input:

I am using this CPU: Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz and I get 
true from pcie_relaxed_ordering_enabled.
Do you think this is expected?
If not, what is wrong in the current code? and what should be the fix?
> 
>>>> ---------------------------------------------------------------------
>>>> static void pci_configure_relaxed_ordering(struct pci_dev *dev)
>>>> {
>>>> 	struct pci_dev *root;
>>>>
>>>> 	/* PCI_EXP_DEVICE_RELAX_EN is RsvdP in VFs */
>>>> 	if (dev->is_virtfn)
>>>> 		return;
>>>>
>>>> 	if (!pcie_relaxed_ordering_enabled(dev))
>>>> 		return;
>>>>
>>>> 	/*
>>>> 	 * For now, we only deal with Relaxed Ordering issues with Root
>>>> 	 * Ports. Peer-to-Peer DMA is another can of worms.
>>>> 	 */
>>>> 	root = pci_find_pcie_root_port(dev);
>>>> 	if (!root)
>>>> 		return;
>>>>
>>>> 	if (root->dev_flags & PCI_DEV_FLAGS_NO_RELAXED_ORDERING) {
>>>> 		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>>>> 					   PCI_EXP_DEVCTL_RELAX_EN);
>>>> 		pci_info(dev, "Relaxed Ordering disabled because the Root Port didn't support it\n");
>>>> 	}
>>>> }
>>>>
>>>>
> 
>> 00:00.0 0600: 8086:2f00 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [144] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>>
>> 00:01.0 0604: 8086:2f02 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>> 	I/O behind bridge: 00002000-00002fff
>> 	Memory behind bridge: 93c00000-93dfffff
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 00:02.0 0604: 8086:2f04 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>> 	Memory behind bridge: 93f00000-947fffff
>> 	Prefetchable memory behind bridge: 0000000090000000-0000000091ffffff
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 00:03.0 0604: 8086:2f08 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>> 	Memory behind bridge: 94800000-948fffff
>> 	Prefetchable memory behind bridge: 0000000093a00000-0000000093afffff
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 00:03.1 0604: 8086:2f09 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>> 	Memory behind bridge: 94900000-949fffff
>> 	Prefetchable memory behind bridge: 0000000093b00000-0000000093bfffff
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 00:03.2 0604: 8086:2f0a (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>> 	Memory behind bridge: 94a00000-95bfffff
>> 	Prefetchable memory behind bridge: 0000033ffc000000-0000033fffffffff
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 00:05.0 0880: 8086:2f28 (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:05.1 0880: 8086:2f29 (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit+
>> 	Capabilities: [100] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>> 	Capabilities: [110] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>> 	Capabilities: [120] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>> 	Capabilities: [130] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>>
>> 00:05.2 0880: 8086:2f2a (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:05.4 0800: 8086:2f2c (rev 02) (prog-if 20 [IO(X)-APIC])
>> 	Subsystem: 8086:0000
>> 	Flags: bus master, fast devsel, latency 0
>> 	Memory at 93e08000 (32-bit, non-prefetchable) [size=4K]
>> 	Capabilities: [44] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [e0] Power Management version 3
>>
>> 00:05.6 1101: 8086:2f39 (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Kernel driver in use: hswep_uncore
>>
>> 00:06.0 0880: 8086:2f10 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 00:06.1 0880: 8086:2f11 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 00:06.2 0880: 8086:2f12 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:06.3 0880: 8086:2f13 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 00:06.4 0880: 8086:2f14 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:06.5 0880: 8086:2f15 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:06.6 0880: 8086:2f16 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:06.7 0880: 8086:2f17 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:07.0 0880: 8086:2f18 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 00:07.1 0880: 8086:2f19 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:07.2 0880: 8086:2f1a (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:07.3 0880: 8086:2f1b (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:07.4 0880: 8086:2f1c (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 00:11.0 ff00: 8086:8d7c (rev 05)
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, fast devsel, latency 0
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [80] Power Management version 3
>>
>> 00:11.4 0106: 8086:8d62 (rev 05) (prog-if 01 [AHCI 1.0])
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 80
>> 	I/O ports at 3078 [size=8]
>> 	I/O ports at 308c [size=4]
>> 	I/O ports at 3070 [size=8]
>> 	I/O ports at 3088 [size=4]
>> 	I/O ports at 3040 [size=32]
>> 	Memory at 93e02000 (32-bit, non-prefetchable) [size=2K]
>> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>> 	Capabilities: [70] Power Management version 3
>> 	Capabilities: [a8] SATA HBA v1.0
>> 	Kernel driver in use: ahci
>>
>> 00:16.0 0780: 8086:8d3a (rev 05)
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, fast devsel, latency 0, IRQ 255
>> 	Memory at 93e07000 (64-bit, non-prefetchable) [size=16]
>> 	Capabilities: [50] Power Management version 3
>> 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
>>
>> 00:16.1 0780: 8086:8d3b (rev 05)
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, fast devsel, latency 0, IRQ 255
>> 	Memory at 93e06000 (64-bit, non-prefetchable) [size=16]
>> 	Capabilities: [50] Power Management version 3
>> 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
>>
>> 00:1a.0 0c03: 8086:8d2d (rev 05) (prog-if 20 [EHCI])
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, medium devsel, latency 0, IRQ 18
>> 	Memory at 93e04000 (32-bit, non-prefetchable) [size=1K]
>> 	Capabilities: [50] Power Management version 2
>> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
>> 	Capabilities: [98] PCI Advanced Features
>> 	Kernel driver in use: ehci-pci
>>
>> 00:1c.0 0604: 8086:8d10 (rev d5) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>> 	Capabilities: [40] Express Root Port (Slot-), MSI 00
>> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>> 	Capabilities: [90] Subsystem: 1028:0600
>> 	Capabilities: [a0] Power Management version 3
>> 	Kernel driver in use: pcieport
>>
>> 00:1c.7 0604: 8086:8d1e (rev d5) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=00, secondary=07, subordinate=0b, sec-latency=0
>> 	Memory behind bridge: 93000000-939fffff
>> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
>> 	Capabilities: [40] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>> 	Capabilities: [90] Subsystem: 1028:0600
>> 	Capabilities: [a0] Power Management version 3
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Kernel driver in use: pcieport
>>
>> 00:1d.0 0c03: 8086:8d26 (rev 05) (prog-if 20 [EHCI])
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, medium devsel, latency 0, IRQ 18
>> 	Memory at 93e03000 (32-bit, non-prefetchable) [size=1K]
>> 	Capabilities: [50] Power Management version 2
>> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
>> 	Capabilities: [98] PCI Advanced Features
>> 	Kernel driver in use: ehci-pci
>>
>> 00:1f.0 0601: 8086:8d44 (rev 05)
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, medium devsel, latency 0
>> 	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>> 	Kernel driver in use: lpc_ich
>>
>> 00:1f.2 0106: 8086:8d02 (rev 05) (prog-if 01 [AHCI 1.0])
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 81
>> 	I/O ports at 3068 [size=8]
>> 	I/O ports at 3084 [size=4]
>> 	I/O ports at 3060 [size=8]
>> 	I/O ports at 3080 [size=4]
>> 	I/O ports at 3020 [size=32]
>> 	Memory at 93e01000 (32-bit, non-prefetchable) [size=2K]
>> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>> 	Capabilities: [70] Power Management version 3
>> 	Capabilities: [a8] SATA HBA v1.0
>> 	Kernel driver in use: ahci
>>
>> 01:00.0 0200: 14e4:165f
>> 	Subsystem: 1028:1f5b
>> 	Flags: bus master, fast devsel, latency 0, IRQ 82
>> 	Memory at 93b30000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93b40000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93b50000 (64-bit, prefetchable) [size=64K]
>> 	Expansion ROM at 94900000 [disabled] [size=256K]
>> 	Capabilities: [48] Power Management version 3
>> 	Capabilities: [50] Vital Product Data
>> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
>> 	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
>> 	Capabilities: [ac] Express Endpoint, MSI 00
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-05
>> 	Capabilities: [150] Power Budgeting <?>
>> 	Capabilities: [160] Virtual Channel
>> 	Kernel driver in use: tg3
>>
>> 01:00.1 0200: 14e4:165f
>> 	Subsystem: 1028:1f5b
>> 	Flags: bus master, fast devsel, latency 0, IRQ 83
>> 	Memory at 93b00000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93b10000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93b20000 (64-bit, prefetchable) [size=64K]
>> 	Expansion ROM at 94940000 [disabled] [size=256K]
>> 	Capabilities: [48] Power Management version 3
>> 	Capabilities: [50] Vital Product Data
>> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
>> 	Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
>> 	Capabilities: [ac] Express Endpoint, MSI 00
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-06
>> 	Capabilities: [150] Power Budgeting <?>
>> 	Capabilities: [160] Virtual Channel
>> 	Kernel driver in use: tg3
>>
>> 02:00.0 0200: 14e4:165f
>> 	Subsystem: 1028:1f5b
>> 	Flags: bus master, fast devsel, latency 0, IRQ 84
>> 	Memory at 93a30000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93a40000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93a50000 (64-bit, prefetchable) [size=64K]
>> 	Expansion ROM at 94800000 [disabled] [size=256K]
>> 	Capabilities: [48] Power Management version 3
>> 	Capabilities: [50] Vital Product Data
>> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
>> 	Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
>> 	Capabilities: [ac] Express Endpoint, MSI 00
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-07
>> 	Capabilities: [150] Power Budgeting <?>
>> 	Capabilities: [160] Virtual Channel
>> 	Kernel driver in use: tg3
>>
>> 02:00.1 0200: 14e4:165f
>> 	Subsystem: 1028:1f5b
>> 	Flags: bus master, fast devsel, latency 0, IRQ 85
>> 	Memory at 93a00000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93a10000 (64-bit, prefetchable) [size=64K]
>> 	Memory at 93a20000 (64-bit, prefetchable) [size=64K]
>> 	Expansion ROM at 94840000 [disabled] [size=256K]
>> 	Capabilities: [48] Power Management version 3
>> 	Capabilities: [50] Vital Product Data
>> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
>> 	Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
>> 	Capabilities: [ac] Express Endpoint, MSI 00
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-08
>> 	Capabilities: [150] Power Budgeting <?>
>> 	Capabilities: [160] Virtual Channel
>> 	Kernel driver in use: tg3
>>
>> 03:00.0 0104: 1000:005d (rev 02)
>> 	Subsystem: 1028:1f49
>> 	Flags: bus master, fast devsel, latency 0, IRQ 37
>> 	I/O ports at 2000 [size=256]
>> 	Memory at 93d00000 (64-bit, non-prefetchable) [size=64K]
>> 	Memory at 93c00000 (64-bit, non-prefetchable) [size=1M]
>> 	Expansion ROM at <ignored> [disabled]
>> 	Capabilities: [50] Power Management version 3
>> 	Capabilities: [68] Express Endpoint, MSI 00
>> 	Capabilities: [d0] Vital Product Data
>> 	Capabilities: [a8] MSI: Enable- Count=1/1 Maskable+ 64bit+
>> 	Capabilities: [c0] MSI-X: Enable+ Count=97 Masked-
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [1e0] #19
>> 	Capabilities: [1c0] Power Budgeting <?>
>> 	Capabilities: [190] #16
>> 	Capabilities: [148] Alternative Routing-ID Interpretation (ARI)
>> 	Kernel driver in use: megaraid_sas
>>
>> 04:00.0 0200: 15b3:101d
>> 	Subsystem: 15b3:0047
>> 	Flags: bus master, fast devsel, latency 0, IRQ 91
>> 	Memory at 90000000 (64-bit, prefetchable) [size=32M]
>> 	Expansion ROM at 93f00000 [disabled] [size=1M]
>> 	Capabilities: [60] Express Endpoint, MSI 00
>> 	Capabilities: [48] Vital Product Data
>> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
>> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
>> 	Capabilities: [1c0] #19
>> 	Capabilities: [320] #27
>> 	Capabilities: [370] #26
>> 	Capabilities: [420] #25
>> 	Kernel driver in use: mlx5_core
>>
>> 05:00.0 0200: 15b3:1017
>> 	Subsystem: 15b3:0020
>> 	Flags: bus master, fast devsel, latency 0, IRQ 133
>> 	Memory at 33ffe000000 (64-bit, prefetchable) [size=32M]
>> 	Expansion ROM at 94a00000 [disabled] [size=1M]
>> 	Capabilities: [60] Express Endpoint, MSI 00
>> 	Capabilities: [48] Vital Product Data
>> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
>> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
>> 	Capabilities: [1c0] #19
>> 	Capabilities: [230] Access Control Services
>> 	Kernel driver in use: mlx5_core
>>
>> 05:00.1 0200: 15b3:1017
>> 	Subsystem: 15b3:0020
>> 	Flags: bus master, fast devsel, latency 0, IRQ 83
>> 	Memory at 33ffc000000 (64-bit, prefetchable) [size=32M]
>> 	Expansion ROM at 95300000 [disabled] [size=1M]
>> 	Capabilities: [60] Express Endpoint, MSI 00
>> 	Capabilities: [48] Vital Product Data
>> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
>> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
>> 	Capabilities: [230] Access Control Services
>> 	Kernel driver in use: mlx5_core
>>
>> 07:00.0 0604: 1912:001d (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	BIST result: 00
>> 	Bus: primary=07, secondary=08, subordinate=0b, sec-latency=0
>> 	Memory behind bridge: 93000000-939fffff
>> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>> 	Capabilities: [70] Express Upstream Port, MSI 00
>> 	Capabilities: [b0] Subsystem: 1912:001d
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Kernel driver in use: pcieport
>>
>> 08:00.0 0604: 1912:001d (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	BIST result: 00
>> 	Bus: primary=08, secondary=09, subordinate=0a, sec-latency=0
>> 	Memory behind bridge: 93000000-938fffff
>> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>> 	Capabilities: [70] Express Downstream Port (Slot-), MSI 00
>> 	Capabilities: [b0] Subsystem: 1912:001d
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Kernel driver in use: pcieport
>>
>> 09:00.0 0604: 1912:001a (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	BIST result: 00
>> 	Bus: primary=09, secondary=0a, subordinate=0a, sec-latency=0
>> 	Memory behind bridge: 93000000-938fffff
>> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>> 	Capabilities: [70] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
>> 	Capabilities: [b0] Subsystem: 1912:001a
>> 	Capabilities: [100] Advanced Error Reporting
>>
>> 0a:00.0 0300: 102b:0534 (rev 01) (prog-if 00 [VGA controller])
>> 	Subsystem: 1028:0600
>> 	Flags: bus master, medium devsel, latency 0, IRQ 19
>> 	Memory at 92000000 (32-bit, prefetchable) [size=16M]
>> 	Memory at 93800000 (32-bit, non-prefetchable) [size=16K]
>> 	Memory at 93000000 (32-bit, non-prefetchable) [size=8M]
>> 	Expansion ROM at <unassigned> [disabled]
>> 	Capabilities: [dc] Power Management version 1
>> 	Kernel driver in use: mgag200
>>
>> 7f:08.0 0880: 8086:2f80 (rev 02)
>> 	Subsystem: 8086:2f80
>> 	Flags: fast devsel
>>
>> 7f:08.2 1101: 8086:2f32 (rev 02)
>> 	Subsystem: 8086:2f32
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:08.3 0880: 8086:2f83 (rev 02)
>> 	Subsystem: 8086:2f83
>> 	Flags: fast devsel
>>
>> 7f:08.5 0880: 8086:2f85 (rev 02)
>> 	Subsystem: 8086:2f85
>> 	Flags: fast devsel
>>
>> 7f:08.6 0880: 8086:2f86 (rev 02)
>> 	Subsystem: 8086:2f86
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:08.7 0880: 8086:2f87 (rev 02)
>> 	Subsystem: 8086:2f87
>> 	Flags: fast devsel
>>
>> 7f:09.0 0880: 8086:2f90 (rev 02)
>> 	Subsystem: 8086:2f90
>> 	Flags: fast devsel
>>
>> 7f:09.2 1101: 8086:2f33 (rev 02)
>> 	Subsystem: 8086:2f33
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:09.3 0880: 8086:2f93 (rev 02)
>> 	Subsystem: 8086:2f93
>> 	Flags: fast devsel
>>
>> 7f:09.5 0880: 8086:2f95 (rev 02)
>> 	Subsystem: 8086:2f95
>> 	Flags: fast devsel
>>
>> 7f:09.6 0880: 8086:2f96 (rev 02)
>> 	Subsystem: 8086:2f96
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:0b.0 0880: 8086:2f81 (rev 02)
>> 	Subsystem: 8086:2f81
>> 	Flags: fast devsel
>>
>> 7f:0b.1 1101: 8086:2f36 (rev 02)
>> 	Subsystem: 8086:2f36
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:0b.2 1101: 8086:2f37 (rev 02)
>> 	Subsystem: 8086:2f37
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:0b.4 0880: 8086:2f41 (rev 02)
>> 	Subsystem: 8086:2f41
>> 	Flags: fast devsel
>>
>> 7f:0b.5 1101: 8086:2f3e (rev 02)
>> 	Subsystem: 8086:2f3e
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:0b.6 1101: 8086:2f3f (rev 02)
>> 	Subsystem: 8086:2f3f
>> 	Flags: fast devsel
>>
>> 7f:0c.0 0880: 8086:2fe0 (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> 7f:0c.1 0880: 8086:2fe1 (rev 02)
>> 	Subsystem: 8086:2fe1
>> 	Flags: fast devsel
>>
>> 7f:0c.2 0880: 8086:2fe2 (rev 02)
>> 	Subsystem: 8086:2fe2
>> 	Flags: fast devsel
>>
>> 7f:0c.3 0880: 8086:2fe3 (rev 02)
>> 	Subsystem: 8086:2fe3
>> 	Flags: fast devsel
>>
>> 7f:0c.4 0880: 8086:2fe4 (rev 02)
>> 	Subsystem: 8086:2fe4
>> 	Flags: fast devsel
>>
>> 7f:0c.5 0880: 8086:2fe5 (rev 02)
>> 	Subsystem: 8086:2fe5
>> 	Flags: fast devsel
>>
>> 7f:0c.6 0880: 8086:2fe6 (rev 02)
>> 	Subsystem: 8086:2fe6
>> 	Flags: fast devsel
>>
>> 7f:0c.7 0880: 8086:2fe7 (rev 02)
>> 	Subsystem: 8086:2fe7
>> 	Flags: fast devsel
>>
>> 7f:0d.0 0880: 8086:2fe8 (rev 02)
>> 	Subsystem: 8086:2fe8
>> 	Flags: fast devsel
>>
>> 7f:0d.1 0880: 8086:2fe9 (rev 02)
>> 	Subsystem: 8086:2fe9
>> 	Flags: fast devsel
>>
>> 7f:0f.0 0880: 8086:2ff8 (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:0f.1 0880: 8086:2ff9 (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:0f.2 0880: 8086:2ffa (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:0f.3 0880: 8086:2ffb (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:0f.4 0880: 8086:2ffc (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> 7f:0f.5 0880: 8086:2ffd (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> 7f:0f.6 0880: 8086:2ffe (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> 7f:10.0 0880: 8086:2f1d (rev 02)
>> 	Subsystem: 8086:2f1d
>> 	Flags: fast devsel
>>
>> 7f:10.1 1101: 8086:2f34 (rev 02)
>> 	Subsystem: 8086:2f34
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:10.5 0880: 8086:2f1e (rev 02)
>> 	Subsystem: 8086:2f1e
>> 	Flags: fast devsel
>>
>> 7f:10.6 1101: 8086:2f7d (rev 02)
>> 	Subsystem: 8086:2f7d
>> 	Flags: fast devsel
>>
>> 7f:10.7 0880: 8086:2f1f (rev 02)
>> 	Subsystem: 8086:2f1f
>> 	Flags: fast devsel
>>
>> 7f:12.0 0880: 8086:2fa0 (rev 02)
>> 	Subsystem: 8086:2fa0
>> 	Flags: fast devsel
>> 	Kernel driver in use: sbridge_edac
>>
>> 7f:12.1 1101: 8086:2f30 (rev 02)
>> 	Subsystem: 8086:2f30
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:12.2 0880: 8086:2f70 (rev 02)
>> 	Subsystem: 8086:2f70
>> 	Flags: fast devsel
>>
>> 7f:12.4 0880: 8086:2f60 (rev 02)
>> 	Subsystem: 8086:2f60
>> 	Flags: fast devsel
>>
>> 7f:12.5 1101: 8086:2f38 (rev 02)
>> 	Subsystem: 8086:2f38
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:12.6 0880: 8086:2f78 (rev 02)
>> 	Subsystem: 8086:2f78
>> 	Flags: fast devsel
>>
>> 7f:13.0 0880: 8086:2fa8 (rev 02)
>> 	Subsystem: 8086:2fa8
>> 	Flags: fast devsel
>>
>> 7f:13.1 0880: 8086:2f71 (rev 02)
>> 	Subsystem: 8086:2f71
>> 	Flags: fast devsel
>>
>> 7f:13.2 0880: 8086:2faa (rev 02)
>> 	Subsystem: 8086:2faa
>> 	Flags: fast devsel
>>
>> 7f:13.3 0880: 8086:2fab (rev 02)
>> 	Subsystem: 8086:2fab
>> 	Flags: fast devsel
>>
>> 7f:13.4 0880: 8086:2fac (rev 02)
>> 	Subsystem: 8086:2fac
>> 	Flags: fast devsel
>>
>> 7f:13.5 0880: 8086:2fad (rev 02)
>> 	Subsystem: 8086:2fad
>> 	Flags: fast devsel
>>
>> 7f:13.6 0880: 8086:2fae (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:13.7 0880: 8086:2faf (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:14.0 0880: 8086:2fb0 (rev 02)
>> 	Subsystem: 8086:2fb0
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:14.1 0880: 8086:2fb1 (rev 02)
>> 	Subsystem: 8086:2fb1
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:14.2 0880: 8086:2fb2 (rev 02)
>> 	Subsystem: 8086:2fb2
>> 	Flags: fast devsel
>>
>> 7f:14.3 0880: 8086:2fb3 (rev 02)
>> 	Subsystem: 8086:2fb3
>> 	Flags: fast devsel
>>
>> 7f:14.4 0880: 8086:2fbc (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:14.5 0880: 8086:2fbd (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:14.6 0880: 8086:2fbe (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:14.7 0880: 8086:2fbf (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:15.0 0880: 8086:2fb4 (rev 02)
>> 	Subsystem: 8086:2fb4
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:15.1 0880: 8086:2fb5 (rev 02)
>> 	Subsystem: 8086:2fb5
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:15.2 0880: 8086:2fb6 (rev 02)
>> 	Subsystem: 8086:2fb6
>> 	Flags: fast devsel
>>
>> 7f:15.3 0880: 8086:2fb7 (rev 02)
>> 	Subsystem: 8086:2fb7
>> 	Flags: fast devsel
>>
>> 7f:16.0 0880: 8086:2f68 (rev 02)
>> 	Subsystem: 8086:2f68
>> 	Flags: fast devsel
>>
>> 7f:16.1 0880: 8086:2f79 (rev 02)
>> 	Subsystem: 8086:2f79
>> 	Flags: fast devsel
>>
>> 7f:16.2 0880: 8086:2f6a (rev 02)
>> 	Subsystem: 8086:2f6a
>> 	Flags: fast devsel
>>
>> 7f:16.3 0880: 8086:2f6b (rev 02)
>> 	Subsystem: 8086:2f6b
>> 	Flags: fast devsel
>>
>> 7f:16.4 0880: 8086:2f6c (rev 02)
>> 	Subsystem: 8086:2f6c
>> 	Flags: fast devsel
>>
>> 7f:16.5 0880: 8086:2f6d (rev 02)
>> 	Subsystem: 8086:2f6d
>> 	Flags: fast devsel
>>
>> 7f:16.6 0880: 8086:2f6e (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:16.7 0880: 8086:2f6f (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:17.0 0880: 8086:2fd0 (rev 02)
>> 	Subsystem: 8086:2fd0
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:17.1 0880: 8086:2fd1 (rev 02)
>> 	Subsystem: 8086:2fd1
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:17.2 0880: 8086:2fd2 (rev 02)
>> 	Subsystem: 8086:2fd2
>> 	Flags: fast devsel
>>
>> 7f:17.3 0880: 8086:2fd3 (rev 02)
>> 	Subsystem: 8086:2fd3
>> 	Flags: fast devsel
>>
>> 7f:17.4 0880: 8086:2fb8 (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:17.5 0880: 8086:2fb9 (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:17.6 0880: 8086:2fba (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:17.7 0880: 8086:2fbb (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:18.0 0880: 8086:2fd4 (rev 02)
>> 	Subsystem: 8086:2fd4
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:18.1 0880: 8086:2fd5 (rev 02)
>> 	Subsystem: 8086:2fd5
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:18.2 0880: 8086:2fd6 (rev 02)
>> 	Subsystem: 8086:2fd6
>> 	Flags: fast devsel
>>
>> 7f:18.3 0880: 8086:2fd7 (rev 02)
>> 	Subsystem: 8086:2fd7
>> 	Flags: fast devsel
>>
>> 7f:1e.0 0880: 8086:2f98 (rev 02)
>> 	Subsystem: 8086:2f98
>> 	Flags: fast devsel
>>
>> 7f:1e.1 0880: 8086:2f99 (rev 02)
>> 	Subsystem: 8086:2f99
>> 	Flags: fast devsel
>>
>> 7f:1e.2 0880: 8086:2f9a (rev 02)
>> 	Subsystem: 8086:2f9a
>> 	Flags: fast devsel
>>
>> 7f:1e.3 0880: 8086:2fc0 (rev 02)
>> 	Subsystem: 8086:2fc0
>> 	Flags: fast devsel
>> 	I/O ports at <ignored> [disabled]
>> 	Kernel driver in use: hswep_uncore
>>
>> 7f:1e.4 0880: 8086:2f9c (rev 02)
>> 	Subsystem: 8086:2f9c
>> 	Flags: fast devsel
>>
>> 7f:1f.0 0880: 8086:2f88 (rev 02)
>> 	Flags: fast devsel
>>
>> 7f:1f.2 0880: 8086:2f8a (rev 02)
>> 	Flags: fast devsel
>>
>> 80:01.0 0604: 8086:2f02 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=80, secondary=81, subordinate=81, sec-latency=0
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 80:02.0 0604: 8086:2f04 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=80, secondary=82, subordinate=82, sec-latency=0
>> 	Memory behind bridge: c8100000-c90fffff
>> 	Prefetchable memory behind bridge: 0000037ffc000000-0000037fffffffff
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 80:03.0 0604: 8086:2f08 (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=80, secondary=83, subordinate=83, sec-latency=0
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 80:03.2 0604: 8086:2f0a (rev 02) (prog-if 00 [Normal decode])
>> 	Flags: bus master, fast devsel, latency 0
>> 	Bus: primary=80, secondary=84, subordinate=84, sec-latency=0
>> 	Capabilities: [40] Subsystem: 8086:0000
>> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
>> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
>> 	Capabilities: [e0] Power Management version 3
>> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>> 	Capabilities: [110] Access Control Services
>> 	Capabilities: [148] Advanced Error Reporting
>> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>> 	Capabilities: [250] #19
>> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
>> 	Kernel driver in use: pcieport
>>
>> 80:05.0 0880: 8086:2f28 (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:05.1 0880: 8086:2f29 (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit+
>> 	Capabilities: [100] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>> 	Capabilities: [110] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>> 	Capabilities: [120] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>> 	Capabilities: [130] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
>>
>> 80:05.2 0880: 8086:2f2a (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:05.4 0800: 8086:2f2c (rev 02) (prog-if 20 [IO(X)-APIC])
>> 	Subsystem: 8086:0000
>> 	Flags: bus master, fast devsel, latency 0
>> 	Memory at c8000000 (32-bit, non-prefetchable) [size=4K]
>> 	Capabilities: [44] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [e0] Power Management version 3
>>
>> 80:05.6 1101: 8086:2f39 (rev 02)
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Kernel driver in use: hswep_uncore
>>
>> 80:06.0 0880: 8086:2f10 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 80:06.1 0880: 8086:2f11 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 80:06.2 0880: 8086:2f12 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:06.3 0880: 8086:2f13 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 80:06.4 0880: 8086:2f14 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:06.5 0880: 8086:2f15 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:06.6 0880: 8086:2f16 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:06.7 0880: 8086:2f17 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:07.0 0880: 8086:2f18 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
>>
>> 80:07.1 0880: 8086:2f19 (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:07.2 0880: 8086:2f1a (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:07.3 0880: 8086:2f1b (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 80:07.4 0880: 8086:2f1c (rev 02)
>> 	Subsystem: 8086:0000
>> 	Flags: fast devsel
>> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>
>> 82:00.0 0200: 15b3:101d
>> 	Subsystem: 15b3:0043
>> 	Flags: bus master, fast devsel, latency 0, IRQ 216
>> 	Memory at 37ffe000000 (64-bit, prefetchable) [size=32M]
>> 	Capabilities: [60] Express Endpoint, MSI 00
>> 	Capabilities: [48] Vital Product Data
>> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
>> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
>> 	Capabilities: [1c0] #19
>> 	Capabilities: [230] Access Control Services
>> 	Capabilities: [320] #27
>> 	Capabilities: [370] #26
>> 	Capabilities: [420] #25
>> 	Kernel driver in use: mlx5_core
>>
>> 82:00.1 0200: 15b3:101d
>> 	Subsystem: 15b3:0043
>> 	Flags: bus master, fast devsel, latency 0, IRQ 258
>> 	Memory at 37ffc000000 (64-bit, prefetchable) [size=32M]
>> 	Capabilities: [60] Express Endpoint, MSI 00
>> 	Capabilities: [48] Vital Product Data
>> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
>> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
>> 	Capabilities: [40] Power Management version 3
>> 	Capabilities: [100] Advanced Error Reporting
>> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
>> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
>> 	Capabilities: [230] Access Control Services
>> 	Capabilities: [420] #25
>> 	Kernel driver in use: mlx5_core
>>
>> ff:08.0 0880: 8086:2f80 (rev 02)
>> 	Subsystem: 8086:2f80
>> 	Flags: fast devsel
>>
>> ff:08.2 1101: 8086:2f32 (rev 02)
>> 	Subsystem: 8086:2f32
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:08.3 0880: 8086:2f83 (rev 02)
>> 	Subsystem: 8086:2f83
>> 	Flags: fast devsel
>>
>> ff:08.5 0880: 8086:2f85 (rev 02)
>> 	Subsystem: 8086:2f85
>> 	Flags: fast devsel
>>
>> ff:08.6 0880: 8086:2f86 (rev 02)
>> 	Subsystem: 8086:2f86
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:08.7 0880: 8086:2f87 (rev 02)
>> 	Subsystem: 8086:2f87
>> 	Flags: fast devsel
>>
>> ff:09.0 0880: 8086:2f90 (rev 02)
>> 	Subsystem: 8086:2f90
>> 	Flags: fast devsel
>>
>> ff:09.2 1101: 8086:2f33 (rev 02)
>> 	Subsystem: 8086:2f33
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:09.3 0880: 8086:2f93 (rev 02)
>> 	Subsystem: 8086:2f93
>> 	Flags: fast devsel
>>
>> ff:09.5 0880: 8086:2f95 (rev 02)
>> 	Subsystem: 8086:2f95
>> 	Flags: fast devsel
>>
>> ff:09.6 0880: 8086:2f96 (rev 02)
>> 	Subsystem: 8086:2f96
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:0b.0 0880: 8086:2f81 (rev 02)
>> 	Subsystem: 8086:2f81
>> 	Flags: fast devsel
>>
>> ff:0b.1 1101: 8086:2f36 (rev 02)
>> 	Subsystem: 8086:2f36
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:0b.2 1101: 8086:2f37 (rev 02)
>> 	Subsystem: 8086:2f37
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:0b.4 0880: 8086:2f41 (rev 02)
>> 	Subsystem: 8086:2f41
>> 	Flags: fast devsel
>>
>> ff:0b.5 1101: 8086:2f3e (rev 02)
>> 	Subsystem: 8086:2f3e
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:0b.6 1101: 8086:2f3f (rev 02)
>> 	Subsystem: 8086:2f3f
>> 	Flags: fast devsel
>>
>> ff:0c.0 0880: 8086:2fe0 (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> ff:0c.1 0880: 8086:2fe1 (rev 02)
>> 	Subsystem: 8086:2fe1
>> 	Flags: fast devsel
>>
>> ff:0c.2 0880: 8086:2fe2 (rev 02)
>> 	Subsystem: 8086:2fe2
>> 	Flags: fast devsel
>>
>> ff:0c.3 0880: 8086:2fe3 (rev 02)
>> 	Subsystem: 8086:2fe3
>> 	Flags: fast devsel
>>
>> ff:0c.4 0880: 8086:2fe4 (rev 02)
>> 	Subsystem: 8086:2fe4
>> 	Flags: fast devsel
>>
>> ff:0c.5 0880: 8086:2fe5 (rev 02)
>> 	Subsystem: 8086:2fe5
>> 	Flags: fast devsel
>>
>> ff:0c.6 0880: 8086:2fe6 (rev 02)
>> 	Subsystem: 8086:2fe6
>> 	Flags: fast devsel
>>
>> ff:0c.7 0880: 8086:2fe7 (rev 02)
>> 	Subsystem: 8086:2fe7
>> 	Flags: fast devsel
>>
>> ff:0d.0 0880: 8086:2fe8 (rev 02)
>> 	Subsystem: 8086:2fe8
>> 	Flags: fast devsel
>>
>> ff:0d.1 0880: 8086:2fe9 (rev 02)
>> 	Subsystem: 8086:2fe9
>> 	Flags: fast devsel
>>
>> ff:0f.0 0880: 8086:2ff8 (rev 02)
>> 	Flags: fast devsel
>>
>> ff:0f.1 0880: 8086:2ff9 (rev 02)
>> 	Flags: fast devsel
>>
>> ff:0f.2 0880: 8086:2ffa (rev 02)
>> 	Flags: fast devsel
>>
>> ff:0f.3 0880: 8086:2ffb (rev 02)
>> 	Flags: fast devsel
>>
>> ff:0f.4 0880: 8086:2ffc (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> ff:0f.5 0880: 8086:2ffd (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> ff:0f.6 0880: 8086:2ffe (rev 02)
>> 	Subsystem: 8086:2fe0
>> 	Flags: fast devsel
>>
>> ff:10.0 0880: 8086:2f1d (rev 02)
>> 	Subsystem: 8086:2f1d
>> 	Flags: fast devsel
>>
>> ff:10.1 1101: 8086:2f34 (rev 02)
>> 	Subsystem: 8086:2f34
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:10.5 0880: 8086:2f1e (rev 02)
>> 	Subsystem: 8086:2f1e
>> 	Flags: fast devsel
>>
>> ff:10.6 1101: 8086:2f7d (rev 02)
>> 	Subsystem: 8086:2f7d
>> 	Flags: fast devsel
>>
>> ff:10.7 0880: 8086:2f1f (rev 02)
>> 	Subsystem: 8086:2f1f
>> 	Flags: fast devsel
>>
>> ff:12.0 0880: 8086:2fa0 (rev 02)
>> 	Subsystem: 8086:2fa0
>> 	Flags: fast devsel
>>
>> ff:12.1 1101: 8086:2f30 (rev 02)
>> 	Subsystem: 8086:2f30
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:12.2 0880: 8086:2f70 (rev 02)
>> 	Subsystem: 8086:2f70
>> 	Flags: fast devsel
>>
>> ff:12.4 0880: 8086:2f60 (rev 02)
>> 	Subsystem: 8086:2f60
>> 	Flags: fast devsel
>>
>> ff:12.5 1101: 8086:2f38 (rev 02)
>> 	Subsystem: 8086:2f38
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:12.6 0880: 8086:2f78 (rev 02)
>> 	Subsystem: 8086:2f78
>> 	Flags: fast devsel
>>
>> ff:13.0 0880: 8086:2fa8 (rev 02)
>> 	Subsystem: 8086:2fa8
>> 	Flags: fast devsel
>>
>> ff:13.1 0880: 8086:2f71 (rev 02)
>> 	Subsystem: 8086:2f71
>> 	Flags: fast devsel
>>
>> ff:13.2 0880: 8086:2faa (rev 02)
>> 	Subsystem: 8086:2faa
>> 	Flags: fast devsel
>>
>> ff:13.3 0880: 8086:2fab (rev 02)
>> 	Subsystem: 8086:2fab
>> 	Flags: fast devsel
>>
>> ff:13.4 0880: 8086:2fac (rev 02)
>> 	Subsystem: 8086:2fac
>> 	Flags: fast devsel
>>
>> ff:13.5 0880: 8086:2fad (rev 02)
>> 	Subsystem: 8086:2fad
>> 	Flags: fast devsel
>>
>> ff:13.6 0880: 8086:2fae (rev 02)
>> 	Flags: fast devsel
>>
>> ff:13.7 0880: 8086:2faf (rev 02)
>> 	Flags: fast devsel
>>
>> ff:14.0 0880: 8086:2fb0 (rev 02)
>> 	Subsystem: 8086:2fb0
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:14.1 0880: 8086:2fb1 (rev 02)
>> 	Subsystem: 8086:2fb1
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:14.2 0880: 8086:2fb2 (rev 02)
>> 	Subsystem: 8086:2fb2
>> 	Flags: fast devsel
>>
>> ff:14.3 0880: 8086:2fb3 (rev 02)
>> 	Subsystem: 8086:2fb3
>> 	Flags: fast devsel
>>
>> ff:14.4 0880: 8086:2fbc (rev 02)
>> 	Flags: fast devsel
>>
>> ff:14.5 0880: 8086:2fbd (rev 02)
>> 	Flags: fast devsel
>>
>> ff:14.6 0880: 8086:2fbe (rev 02)
>> 	Flags: fast devsel
>>
>> ff:14.7 0880: 8086:2fbf (rev 02)
>> 	Flags: fast devsel
>>
>> ff:15.0 0880: 8086:2fb4 (rev 02)
>> 	Subsystem: 8086:2fb4
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:15.1 0880: 8086:2fb5 (rev 02)
>> 	Subsystem: 8086:2fb5
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:15.2 0880: 8086:2fb6 (rev 02)
>> 	Subsystem: 8086:2fb6
>> 	Flags: fast devsel
>>
>> ff:15.3 0880: 8086:2fb7 (rev 02)
>> 	Subsystem: 8086:2fb7
>> 	Flags: fast devsel
>>
>> ff:16.0 0880: 8086:2f68 (rev 02)
>> 	Subsystem: 8086:2f68
>> 	Flags: fast devsel
>>
>> ff:16.1 0880: 8086:2f79 (rev 02)
>> 	Subsystem: 8086:2f79
>> 	Flags: fast devsel
>>
>> ff:16.2 0880: 8086:2f6a (rev 02)
>> 	Subsystem: 8086:2f6a
>> 	Flags: fast devsel
>>
>> ff:16.3 0880: 8086:2f6b (rev 02)
>> 	Subsystem: 8086:2f6b
>> 	Flags: fast devsel
>>
>> ff:16.4 0880: 8086:2f6c (rev 02)
>> 	Subsystem: 8086:2f6c
>> 	Flags: fast devsel
>>
>> ff:16.5 0880: 8086:2f6d (rev 02)
>> 	Subsystem: 8086:2f6d
>> 	Flags: fast devsel
>>
>> ff:16.6 0880: 8086:2f6e (rev 02)
>> 	Flags: fast devsel
>>
>> ff:16.7 0880: 8086:2f6f (rev 02)
>> 	Flags: fast devsel
>>
>> ff:17.0 0880: 8086:2fd0 (rev 02)
>> 	Subsystem: 8086:2fd0
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:17.1 0880: 8086:2fd1 (rev 02)
>> 	Subsystem: 8086:2fd1
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:17.2 0880: 8086:2fd2 (rev 02)
>> 	Subsystem: 8086:2fd2
>> 	Flags: fast devsel
>>
>> ff:17.3 0880: 8086:2fd3 (rev 02)
>> 	Subsystem: 8086:2fd3
>> 	Flags: fast devsel
>>
>> ff:17.4 0880: 8086:2fb8 (rev 02)
>> 	Flags: fast devsel
>>
>> ff:17.5 0880: 8086:2fb9 (rev 02)
>> 	Flags: fast devsel
>>
>> ff:17.6 0880: 8086:2fba (rev 02)
>> 	Flags: fast devsel
>>
>> ff:17.7 0880: 8086:2fbb (rev 02)
>> 	Flags: fast devsel
>>
>> ff:18.0 0880: 8086:2fd4 (rev 02)
>> 	Subsystem: 8086:2fd4
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:18.1 0880: 8086:2fd5 (rev 02)
>> 	Subsystem: 8086:2fd5
>> 	Flags: fast devsel
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:18.2 0880: 8086:2fd6 (rev 02)
>> 	Subsystem: 8086:2fd6
>> 	Flags: fast devsel
>>
>> ff:18.3 0880: 8086:2fd7 (rev 02)
>> 	Subsystem: 8086:2fd7
>> 	Flags: fast devsel
>>
>> ff:1e.0 0880: 8086:2f98 (rev 02)
>> 	Subsystem: 8086:2f98
>> 	Flags: fast devsel
>>
>> ff:1e.1 0880: 8086:2f99 (rev 02)
>> 	Subsystem: 8086:2f99
>> 	Flags: fast devsel
>>
>> ff:1e.2 0880: 8086:2f9a (rev 02)
>> 	Subsystem: 8086:2f9a
>> 	Flags: fast devsel
>>
>> ff:1e.3 0880: 8086:2fc0 (rev 02)
>> 	Subsystem: 8086:2fc0
>> 	Flags: fast devsel
>> 	I/O ports at <ignored> [disabled]
>> 	Kernel driver in use: hswep_uncore
>>
>> ff:1e.4 0880: 8086:2f9c (rev 02)
>> 	Subsystem: 8086:2f9c
>> 	Flags: fast devsel
>>
>> ff:1f.0 0880: 8086:2f88 (rev 02)
>> 	Flags: fast devsel
>>
>> ff:1f.2 0880: 8086:2f8a (rev 02)
>> 	Flags: fast devsel
>>
> 
