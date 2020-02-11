Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9431592AF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgBKPOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 10:14:49 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:3905
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728986AbgBKPOt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 10:14:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWPAGwkSQSo9Qcm5i/FsmEDbxmsRcsG69u4GOzc5cMsM24ROG1BOxDawPM9re7pobYDhbBKEJunDBoMdqVdTAQcMmfexAMJWniDbxVjIyVyqyixscCw9CPdOFLkGxxpRsUrSxNHzHQk43Y/2X28X2Tp/e/7kLO5+oDT/PYu8PBfveysENnsdkeJtM5Q9mNDU/wEqipn5jd1HpredjvIUdrdgdxb+YZHRJ6lx822RmtR2b23CcXHorUbvwFAY/mdRUMjYGLSTAVetTVIeYfnOnGP/fJyQuOXq44eHulTSuV2warHjDYzUQ6KMKOyxXO30qX9JlB4Jr77Z2YSi3dmrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKS0aVs2/1BfR6NyeyxhTrPrI3LZqEcDAfFy6/tanZA=;
 b=W0qtgo3kxpSJkNAnt1HpAaH8m9BgRQJtaVRSKJYdf0THLWOzpXtMxQw6YYc8s5LangGdc6z3HXFC4Gexbhl4TITNTD3LW6vd+Clc0OSaheuvA9gEkizjQ9uG5i/Zps+lD6gTs7Pb9OJKPqIn5K8qIT3GkT76ZR5ZHlR3mVz/s3GJFkkvDE/XpKgKxzIf2iVmz0bImY+i2iQfmWLXjIzP1e6zf4ogeMXackYiQSth/uz4TS0z/aMdo5W8QF+zIt/I8Va1wsrubNLjo4/rZ5kfXRLFsT5H9yYskSuY8XFqFIFUmJF9SBbpUseb7q3/I1X3AVuvgNfPzayVO8Tctes/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKS0aVs2/1BfR6NyeyxhTrPrI3LZqEcDAfFy6/tanZA=;
 b=cLYNAEzgLXMPS6nMBhXb22o736RBhsgoXju9IWnbcxw/tfjfOI1xnKKOAne8SoDXJfrj+g4lrLubCn2wf7m5e9Ls323JaVuwDAjKa1IxKwjnv4x4EYkbS8JO8ghS62JZFYceTgpX58ShqS8b10GQxWVEXA1Hxl4Hr303f771V5I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB5318.eurprd04.prod.outlook.com (20.177.33.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 15:14:44 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:14:44 +0000
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Olof Johansson <olof@lixom.net>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Li Yang <leoyang.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
 <da4dcdc7-c022-db67-cda2-f90f086b729e@nxp.com>
 <aec47903-50e4-c61b-6aec-63e3e9bc9332@arm.com>
 <CAOesGMhVA9NSbAi-BtcgQBBK90jeT+NcQ6j_FDgjuR7efE65Vg@mail.gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <f5930767-496b-2bd7-2cf6-5e68e39f65e8@nxp.com>
Date:   Tue, 11 Feb 2020 17:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CAOesGMhVA9NSbAi-BtcgQBBK90jeT+NcQ6j_FDgjuR7efE65Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
Received: from [10.171.82.13] (89.37.124.34) by LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.28 via Frontend Transport; Tue, 11 Feb 2020 15:14:42 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0158cb96-689e-4f52-9fec-08d7af051fd5
X-MS-TrafficTypeDiagnostic: AM6PR04MB5318:|AM6PR04MB5318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5318DB2CEFF3AD93209B97E6EC180@AM6PR04MB5318.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(189003)(199004)(2906002)(5660300002)(66476007)(66946007)(66556008)(110136005)(54906003)(6486002)(16576012)(966005)(478600001)(316002)(8676002)(81166006)(4326008)(81156014)(53546011)(7416002)(36756003)(52116002)(8936002)(186003)(16526019)(26005)(86362001)(31696002)(31686004)(2616005)(956004)(44832011)(11634003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5318;H:AM6PR04MB5878.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4dQ5W4PYOtXqbrehomwD+M58TNHasSZuHzvfQpgO4EjYabE7NU9+x0jknbKi3GczzgL+lU4eZVVXvFlwuN5F0GqVGeFF/oEu8Sfv/KAO3cHAVQiZz5QBK6Go+koiwWtsRMJ1IvoEQDE2o5rgS6+aSE8AGP5R07qRgLm4UnhtKBQoSuHFaOaBcMcwW77VLzYO6A7tTSoBu75P21q/vEsp63FXtJH63lYW6LOaNF412NnucqemVazpLYbWjQBQ/GupenCpw7yoV1oL2O/0CWRlPioo8Y3WCMDkZEvdplFanlUpRYCTRrJkGvvgyq1FV2fODZnQbvqCiL5vtw++iLHvXQTfmv2vLTvoecLYfofKi/CIGjmxjrVbTNn/A10wULBgA2TnkTmun11kL8q2poJ2AvFy6A6EDk8g2bFZo2pAw4x3kVO5/CbAz3xB+QUBmItSosKwXoH2kx3/7DIqmoulAKY1JTyIUeVwS6f4nchGrVhClIL1Rlxl7RsL2v9wanLqUjYfp6of3i74ydfKyGkyq/r3Vte4MDGmoT2EccXnAoiFCM95HD+fP3sMoU6mIxj
X-MS-Exchange-AntiSpam-MessageData: wo0cUvBZzOcUGxI1kRpJROQpGubqwoY8gvWkTOf0FFpY0t2ioxICZ4yVGRRrwHc2qxsS+/BkL92R810iXS23E49YvnWFofNWlzzZAdgxA7U7r8cJ3dK3AvNYcQaZGgTA6bT30NgUjaID6RR7iE34Iw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0158cb96-689e-4f52-9fec-08d7af051fd5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 15:14:44.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3thvKxcc6+j7uC+2aiYssNxTstX1s/RTYujH8nMtU6og8/xL+YXvspBfw8u257bstGDzODEaaKAHTRG2e3D15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5318
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11.02.2020 16:48, Olof Johansson wrote:
> On Tue, Feb 11, 2020 at 5:04 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2020-02-11 12:13 pm, Laurentiu Tudor wrote:
>> [...]
>>>> This is a known issue about DPAA2 MC bus not working well with SMMU
>>>> based IO mapping.  Adding Laurentiu to the chain who has been looking
>>>> into this issue.
>>>
>>> Yes, I'm closely following the issue. I actually have a workaround
>>> (attached) but haven't submitted as it will probably raise a lot of
>>> eyebrows. In the mean time I'm following some discussions [1][2][3] on
>>> the iommu list which seem to try to tackle what appears to be a similar
>>> issue but with framebuffers. My hope is that we will be able to leverage
>>> whatever turns out.
>>
>> Indeed it's more general than framebuffers - in fact there was a
>> specific requirement from the IORT side to accommodate network/storage
>> controllers with in-memory firmware/configuration data/whatever set up
>> by the bootloader that want to be handed off 'live' to Linux because the
>> overhead of stopping and restarting them is impractical. Thus this DPAA2
>> setup is very much within scope of the desired solution, so please feel
>> free to join in (particularly on the DT parts) :)
> 
> That's a real problem that nees a solution, but that's not what's
> happening here, since cold boots works fine.
> 
> Isn't it a whole lot more likely that something isn't
> reset/reinitialized properly in u-boot, such that there is lingering
> state in the setup, causing this?

Ok, so this is completely something else. I don't think our u-boots are 
designed to run in ways other than coming from hard reset.

>> As for right now, note that your patch would only be a partial
>> mitigation to slightly reduce the fault window but not remove it
>> entirely. To be robust the SMMU driver *has* to know about live streams
>> before the first arm_smmu_reset() - hence the need for generic firmware
>> bindings - so doing anything from the MC driver is already too late (and
>> indeed the current iommu_request_dm_for_dev() mechanism is itself a
>> microcosm of the same problem).
> 
> This is more likely a live stream that's left behind from the previous
> kernel (there are some error messages about being unable to detach
> domains, but the errors make it hard to tell what driver didn't unbind
> enough).

I also noticed those messages. Perhaps our PCI driver doesn't do all the 
required cleanup.

> *BUT*, even with that bug, the system should reboot reliably and come
> up clean. So, something isn't clearing up the state *on boot*.

We do test some kexec based "soft-reset" scenarios, didn't hit your 
issue but instead we hit this:

https://lkml.org/lkml/2018/9/21/1066

Can you please provide some more info on your scenario?

---
Best Regards, Laurentiu
