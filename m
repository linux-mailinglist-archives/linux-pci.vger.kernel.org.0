Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70A28F8DA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 20:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgJOSrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 14:47:31 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:7137
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbgJOSrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 14:47:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksXbbaTwpWZa2EBbmgX0ndnLyYEiHUgHu68MZeceST6edg62XNYIt5JU+qaeHmXjpAmadkPR2Z+qxk2udYcFgSITDGx5yopV2lCP6fPeO+ka4C1e7muTKvJowVfjZPjTb0UNH8cwP9JMGSw7rW7TwZ9gbFF4nbvxvm0YvTVdjbUpwULItZKAoR6z3n4RAPit3wvLQ2Z1YosHiP2BPxRH7Tt20R4Qch7EFNeG3qR1XR2l8J+yVv/Ld/GnjDsHiIEPuS4m1nDAE8oFRNNXcVPfElcv469dtO/PyXGWCUTCf6m0Ec5zBtqq+T4TN47o/cX5L43g6SXYF6YkuyWqd9bDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fHuiCQRS5UoBd54X6UeRBASz0k141okFm92cyxhQbA=;
 b=FSfKzKy3VtnefDBrT2IH1xbNGT4ff8Z47iee67cErEePw4T54+2sN9GPT8tDvAWJ4RAJqxkQ73wvKZ2NdHYygcCn0AEMAFZV7MTO18FiqTZbyDnuGQPJETFkkgOhxSXO29YzOZ7vRLnm8px5a89CrPOBT2tqJ/8L/BbfESjfguO1tfZZhCEwYa71VY87YAbmnF/NMF2+WfsDhr61TDkkz6QKlqVf40680CDRL2HiEp2bDzMkQZUNE4g7rOCnZuOuki6OcWWKg00BK+ZkW3HPFhNydbZyUXmdb+N0hDvGM9t+zUmmtMoKCj1U4b+YDn/dE8ggc5yrD1RaAJIZeR4XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fHuiCQRS5UoBd54X6UeRBASz0k141okFm92cyxhQbA=;
 b=aT3j/vBwHofMgQH2w3CAqNG5DgmCevBizHk8jfGnjZeg1TRrlxMnD6/rIOYozEbfnvFmgbA6p5+j2xAjYK0AgPnMQuUdGD3roSl2xAu1/eEBYP7fBSHfOf/ZIlB3O+GT+TuPvCHMGDNFjc7N0yPtwUhoyJeJdTmEWSjsAwG2wsQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3157.namprd11.prod.outlook.com (2603:10b6:a03:75::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Thu, 15 Oct
 2020 18:47:28 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 18:47:28 +0000
Subject: Re: PCI, isolcpus, and irq affinity
To:     Keith Busch <kbusch@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
 <87a6wrqqpf.fsf@nanos.tec.linutronix.de>
 <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
 <20201012190726.GB1032142@dhcp-10-100-145-180.wdl.wdc.com>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <c1747780-cfac-abe1-eb58-5de532c28fba@windriver.com>
Date:   Thu, 15 Oct 2020 12:47:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201012190726.GB1032142@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [70.64.73.216]
X-ClientProxiedBy: BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25)
 To SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.12] (70.64.73.216) by BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Thu, 15 Oct 2020 18:47:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e57f62-beac-466c-0d96-08d8713ac3dc
X-MS-TrafficTypeDiagnostic: BYAPR11MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR11MB31579F655CDFA36D7034ACC0F6020@BYAPR11MB3157.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXvCJP0huvihwj066cE5a2fTUf//B1StK4ZhOLQQe1Mv43ywx5dQ900Qa1HX1edrSR6ohLbbiN2h0ZQZsm13kTF53wAA7/rFwz2H2P0PkbHTR+VSspVkBONXkMtd5v+ZyteRbxVDQLcZ1NjzXq8YVr/LpkWxC3FEsuiVxl/iMcmz3S3pzc4y134gBnU+AmAm1i3gf53Unnkkj+PZK6ZI5l1tG/CafE1JWHA7AILsB9riuZZCpFLUcT1MFJTyVSo6FaswbcNfWObcZ5Vsx6i4EW9vDtXSOpdnxq7PinhTuhmNlrG/VjUnu+voL5/itV1PPZfnYXqiv2eoHQPqNw2QFh6AwNVEHl4Ay2IPCeU52Xa/FeQbtV34K8JWFG7PBzuWrzRRjefrzrAE/Xb/xVHLqS7zEbPaWDcHLJtv0bMaPsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39850400004)(86362001)(2616005)(6486002)(6916009)(44832011)(66476007)(66556008)(6666004)(34490700002)(52116002)(66946007)(8676002)(5660300002)(31686004)(54906003)(316002)(16526019)(8936002)(956004)(2906002)(31696002)(186003)(83380400001)(36756003)(478600001)(4326008)(53546011)(26005)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: khZQhXEciZWOlcgFfl8m5r0IUe9cei/RWLvYaeazgvM9HslWVY1XPzkP6XcwpboDv1L1XGRNTywN+m8NXKWRX0n3OPighU/KQvsr44k9+zVxmoozz+iEVpSBDNCx45feVI048tJf0+y1HGFbSu/0z5rwCfLi1qaEP4lTlw0qH1bsPnu+CoNFagOCz2CPP4GRIFmrFPVvpdP6dULW8sL8B9P0DBNpfTN6Cb9z73Pl74jxaI0AFGgPePLO8kHOE55H3smBVtMnuXGQByzucPdOItiis5CCjOSojGvmH40jhV9aiHtmIwmbR4kSeSAJ14caEXB8a1TDv+L3yYR0a6Tov9rXyRwZDnlqaT+lT/DKvdxI2Y4nyE0nJ/6w9ROOVyGR/TbqWnwfm0zCDy/UfCoMgy4VvMGqxGolpvj2rTci60Hlv2d0Q7Yssv6gJ3Rc3rShvR5styfdGG6CCeMtL62RmVJuG6dYyUDcpTBPkDjFEgAAI39hbKTC4zv8gaGyg6h7nhNade6RehQ8iS/Drrxc7R9Lbbn55GFLWnH77wHeUulFATzWVK3LBYFqXoxLl8Swf//Kc9ukYzJZ4chh/7IXBqDXrjR0X1ULvPm9yjj3w1RVmhug3WCTA3uyZLizDtvgHdT+V9lblvtMRMvg+VqLAg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e57f62-beac-466c-0d96-08d8713ac3dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 18:47:28.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtaVRQ0fylm1fb8S/Bml/uffkN59236HNpjp5v37kecfk1D+ma4+qmJ7lGoS1Dds3xXhaPJYNDf/bhWCNy5rTYdETYX02LICP76E8qy1s44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3157
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2020 1:07 PM, Keith Busch wrote:
> On Mon, Oct 12, 2020 at 12:58:41PM -0600, Chris Friesen wrote:
>> On 10/12/2020 11:50 AM, Thomas Gleixner wrote:
>>> On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
>>>> On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>>>>> I've got a linux system running the RT kernel with threaded irqs.  On
>>>>> startup we affine the various irq threads to the housekeeping CPUs, but I
>>>>> recently hit a scenario where after some days of uptime we ended up with a
>>>>> number of NVME irq threads affined to application cores instead (not good
>>>>> when we're trying to run low-latency applications).
>>>
>>> These threads and the associated interupt vectors are completely
>>> harmless and fully idle as long as there is nothing on those isolated
>>> CPUs which does disk I/O.
>>
>> Some of the irq threads are affined (by the kernel presumably) to multiple
>> CPUs (nvme1q2 and nvme0q2 were both affined 0x38000038, a couple of other
>> queues were affined 0x1c00001c0).
> 
> That means you have more CPUs than your controller has queues. When that
> happens, some sharing of the queue resources among CPUs is required.

Is it required that every CPU is part of the mask for at least one queue?

If we can preferentially route interrupts to the housekeeping CPUs (for 
queues with multiple CPUs in the mask), how is that different than just 
affining all the queues to the housekeeping CPUs and leaving the 
isolated CPUs out of the mask entirely?

Thanks,
Chris
