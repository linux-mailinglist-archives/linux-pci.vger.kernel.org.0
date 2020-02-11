Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A81590D2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgBKNza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 08:55:30 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:2167
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729728AbgBKNz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 08:55:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8SMXDLv95fz+PPZK0PSOhdZoQWu067TbiYIgnBod+F3Uq3PxI0uiK7vCI+Jlv++j+cAyGFlnyuwahxmaOqMOQQDQTbujmhPvRW3rzfAlPY6TqSNzuViTcFWgHQE26Jt/G+LR42Lm96Nzc0R6H60Mpw20BQT8MGSeAsDWVcqULtrO7h7V8OaHNuonNl5cmoE0sFxJm4rNZn2Mq5kH6QwGAASbb7ZIf3oSSrTDpDR/ToPjxu10Fgva/mfWp3HggXp6DVWy5ph3KFSW8xPNIQp/pNEps/bs/om57ZWf8DBgneeFQPZb4/a4VFQvJzqn0vUC5wskqCGWoMJgzLGnqpnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnvDDsjv8utb67OlAZqt+PpsW2P4WIynQMWEWfZalzE=;
 b=Q0NKslzo/WzkwNdbWGy/xnev+kN3LbFqlu7ektpbj8/Jps21mznSKShB0BDeTI26kaIz93ObLW6jFGzB2VWnKbXf2nqdwf8hf3qu7iZYqSNuLzpGv8rmcfVLxZAhWvGBsoVskIYvCRY0V212YxjA+OZEgV08Wpjl56XcHx0QS+mmXFBQn0fYVksCWk7uzV8vf5/8lPZ/DNzJC6F7U06UqGIOBRvhtDsu2a3zZ4SphDswjAHUZYvZ2Q5UEDaI4mRRh0C3nclzpoXEnhuKUSUrUCTVtQS1IPoGrmSa4+O95lzXnGnLb/jcovgoyObvoT2hfQecZvRcQ1jNQ9ldvz9PTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnvDDsjv8utb67OlAZqt+PpsW2P4WIynQMWEWfZalzE=;
 b=g1t2BGTGysXp78pJoR5Ds92d6uQkReD5MBua1LphZqceW/UeefbrGaPN73ZaJzf8JC6Uo6fkhcOhdaIZJarT8cz42oZsmPHae7OGFf8QzGd3v/OAgU3t6d5bzgMonxDYQfbB0oMkYtdk0A0SI33M1qq284ortijuWCVPEPF6NH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB5734.eurprd04.prod.outlook.com (20.178.87.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Tue, 11 Feb 2020 13:55:24 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 13:55:24 +0000
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Robin Murphy <robin.murphy@arm.com>, Li Yang <leoyang.li@nxp.com>,
        Olof Johansson <olof@lixom.net>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        <linux-arm-kernel@lists.infradead.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>
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
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <27e0acfc-0782-bd97-a80e-1143f1315891@nxp.com>
Date:   Tue, 11 Feb 2020 15:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <aec47903-50e4-c61b-6aec-63e3e9bc9332@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
Received: from [10.171.82.13] (89.37.124.34) by LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 13:55:22 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93f3a63c-5f17-44c6-771e-08d7aefa0a55
X-MS-TrafficTypeDiagnostic: AM6PR04MB5734:|AM6PR04MB5734:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5734802C02AE5FA70C212F98EC180@AM6PR04MB5734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(2906002)(16526019)(186003)(54906003)(44832011)(110136005)(2616005)(956004)(81156014)(316002)(81166006)(8936002)(8676002)(16576012)(31686004)(52116002)(478600001)(5660300002)(6486002)(36756003)(4326008)(31696002)(86362001)(66476007)(66946007)(7416002)(66556008)(26005)(53546011)(11634003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5734;H:AM6PR04MB5878.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Va7D8uyZr2ZQJgTL2VClD4gO4c2KFrHu1m+xvDPe0M6crf3CxICXtgoIaQfhNvH3twPRFFRl5J0/6aczZf70ijSXAq7HXt9aq3Imu9HL/A4pTwXhUCdCWhBT6DM9kUordA6nMb2mH0dBm3ZpvJvghJf+b1QOsmTSHgRhQHNxZ3T8my4I8W0dy6Kd25Y0PG/HR0Cnc/48A9qMh2y3OE6r//90YkUYyeweQZfoaJQHbEgYIP3Ov9k3/1Yw9AWw4N0jwp0jRIaRR8x1jHnpx7PERovyePLThHg1Yr/rw5rg9NPTHAXMT27ztTp0imRowNVNYYjbiIW1AzFPJhHaRkV04h6RTyMk5v+D/1vhl45GdIRoeI3hvvpqoGx0kxRzlmDQBrX5VVFt7/PLqO0a1WDRw7ZmCyZ1RdKMBKotluoLtb5WipdVBnh8tG5BbVoMwE+AShGwrllavXyTuQry9gQCfZUS1DFpfIGD0F23s0RCCy2wes7SAgCWi0COumunmBF
X-MS-Exchange-AntiSpam-MessageData: z3kyprvyf8AczE6ke7SbnmLLhNXJRJj8P3k1esD1Ncx7XLa0sMpV2YIppyA9icOqGuCqcbeav67WKS2y3UpQqXPJ4DyN8PPzv1sttXu5RnGzJYNLFiHlLTO00iwe7QJtSykfA63L36t8g/S1e3SpgQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f3a63c-5f17-44c6-771e-08d7aefa0a55
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 13:55:24.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uK2KU5Bcm5m/IW271CaIPeNZbycKs3re6viMQG3pe411HHY0F1TEK2M54emdh0Mcmc53Jn7zfSfxESmLYx9TAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5734
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11.02.2020 15:04, Robin Murphy wrote:
> On 2020-02-11 12:13 pm, Laurentiu Tudor wrote:
> [...]
>>> This is a known issue about DPAA2 MC bus not working well with SMMU
>>> based IO mapping.  Adding Laurentiu to the chain who has been looking
>>> into this issue.
>>
>> Yes, I'm closely following the issue. I actually have a workaround 
>> (attached) but haven't submitted as it will probably raise a lot of 
>> eyebrows. In the mean time I'm following some discussions [1][2][3] on 
>> the iommu list which seem to try to tackle what appears to be a 
>> similar issue but with framebuffers. My hope is that we will be able 
>> to leverage whatever turns out.
> 
> Indeed it's more general than framebuffers - in fact there was a 
> specific requirement from the IORT side to accommodate network/storage 
> controllers with in-memory firmware/configuration data/whatever set up 
> by the bootloader that want to be handed off 'live' to Linux because the 
> overhead of stopping and restarting them is impractical. Thus this DPAA2 
> setup is very much within scope of the desired solution, so please feel 
> free to join in (particularly on the DT parts) :)

Will sure do. Seems that the 2nd approach (the one with list of 
compatibles in arm-smmu) fits really well with our scenario. Will this 
be the way to go forward?

> As for right now, note that your patch would only be a partial 
> mitigation to slightly reduce the fault window but not remove it 
> entirely. To be robust the SMMU driver *has* to know about live streams 
> before the first arm_smmu_reset() - hence the need for generic firmware 
> bindings - so doing anything from the MC driver is already too late (and 
> indeed the current iommu_request_dm_for_dev() mechanism is itself a 
> microcosm of the same problem).

I think you might have missed in the patch that it pauses the firmware 
at early boot, in its driver init and it resumes it only after 
iommu_request_dm_for_dev() has completed. :)

---
Best Regards, Laurentiu
