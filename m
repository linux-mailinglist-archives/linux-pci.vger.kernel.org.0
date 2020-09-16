Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAA26C33F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIPN1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 09:27:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19197 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgIPNXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 09:23:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6200a20000>; Wed, 16 Sep 2020 05:10:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 05:12:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 05:12:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 12:12:29 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 12:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc0B3ZgaKk7MTSQwEdYcMCqTNMs2n2eMSuQ+sDTaKpDeoAs6A0qLcuMiGyfzLQFXqYeCQgYVEbMMGkIo8ipkIk3p5AxhNszm4ZEWsb+HFhnC4De2nK8qWvkq8RtjNxrTpZ2AX0MdSeiEUsgGmSYJ59D8tnln5OhNEoYtyFgEz0Pllm/lxYWXWkcO4+mFBQywkoRRxAoea2xPBt48eEnAcd6yKT/ur9ObOtDYRsFwjRZJuovZhy2kTUnJkAHujCY2GB96SRQ8gnzqGqhhc4ZxvAtwsWgPkmnKe2PrRtEy8mBuh3zYApGmBajTiJw5mN9fPM2dZrYRXayfy30wq6+wqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEYSW9CYfBN86OGt4UFtx2Xt71OFv3zQakK+lmlZJpg=;
 b=B42M9cjggRf5218ePH/fn11FevSMvpDqway8TP6HOf6GWqUnpzssSAyqaQPqcaGGC4Q9N0bQTB1NWJv0i9U4fLFlquK38T/kkqp0r62WbwoFfy3GoLVLjMyMWKeHvj3k+EWeoAL7l86x6TfvzBHgAeTvFCdc1IfxQC9CngU0bqvBllK/VIV2gH4NjyLUsxEC7R1EISptTZaEhYDA8EKq+OEpcYYjgNIUIv/eICtF+lLyIKI6Sbd/GPXC09OMhqPK+COT4uVHft8Ru6R+wW/MLNetjo+6noCTo8s7R/kUB+6eg2k6sdbY665s61SgF8Ge2rQS2OomcR0sP2b0kMhoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 12:12:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 12:12:28 +0000
Date:   Wed, 16 Sep 2020 09:12:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916121226.GN1573713@nvidia.com>
References: <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Wed, 16 Sep 2020 12:12:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIWIU-006vYF-5w; Wed, 16 Sep 2020 09:12:26 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a9b77b-1798-4686-9534-08d85a39c760
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4266AA7E90217A654FAAEC49C2210@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOmmZsSCTmy3Uw0xzfei72evi1kBHwklYSFIV2/1pD0Ff5wBkbo9LqMjvXCZk4nwNP9YAwG0RF4x+E6FhHTqhQwUH5VbMwAyyunYH2c0q1O+Ip4SMeIxEksIEXobX/AlI8yB8Y6Q0XIzdcf2mg4O6rC5SUQmb3f6ny9nHz0aHitItTHzo6/5PJnKa0q9n+Wg5qoxXclsx9Zi7KK0Oh36mNAcc1UBDyt1mAJrmUOHZ63fbfCP2DpY1ctSbOgJVrWiCx2Y2M9aJLAJe/sJTi3gaUj/8qYKZaZGN3xNuMChq1a+KuY/8D7b/EDJSlwjMi30RKokiqTrYgRijz/OJL0T68hrHkFcjlPbVRi5FTfzdZxCvzgJ5QZzG571TPp/zAhD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(2616005)(478600001)(186003)(426003)(6916009)(83380400001)(4326008)(86362001)(54906003)(36756003)(316002)(26005)(1076003)(8936002)(66476007)(66556008)(66946007)(9746002)(9786002)(2906002)(5660300002)(33656002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FPQZVd7QOskheVNfvqNxIa6MkMgR0WX+TbLN5uZJniYlOXXy/jyGvWRRWSrork6k5xYEclE3m04jDr707fKJwAnyx99lI4VtlN0bbBPyH9nZ8dw38ui0Jiv0jvA9/Nsy3DHj5vDhybK4irax3CElNvdZMSmi0I+VngQrq971Cm5H4UDIe8vywOPeGS6sOKbp7NiXDPjNE4evddQk3imnLHozQpLNcHGo9CISHXsIjRshKcAgydjE9GpMbEdbrTeGil1LsM5335JiMe2crIcLBsRGf6pDb4iVe2BXdfTx12d+oe8D99oaoIOmwkQrwR3QngKXJbjhl4lm9kYCAZSUNU+7FxIUp6CNvOBD6Dj9pTELzVlFjxZ7jqvurxy4c8VZzedBWo2J93ZQ/5iZ7eh+R3PtmeTrgvM0AXHPbwr7IvDaZ2U4/WwVfulfBbhvQRnwSBP5+Ki1u5k2YsIGPyzzyPV8xJI0iVIXx5I45HS0C6ApUHkGjQa9bAzlm/PAc35biuv4igXp5blC6qJwdA5EMFHdACzqpt21Ai6lp8uXCPd9SJK008KBtMGvnTVKkUbvAWSfDZtHwWCAKk0FgMd4CLX2igR11zxTkLNn7FdyTLLBzx0JCFIC3r4LsoB08rW0T6lOyEyEjWxYULNMvf9CRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a9b77b-1798-4686-9534-08d85a39c760
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:12:27.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl0zX1hEXVRAo5dvVqwmn5yQ6JXdPJDXgNbYiKL6iP6cAF8UszDg1C/my6mpI8gH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600258210; bh=bEYSW9CYfBN86OGt4UFtx2Xt71OFv3zQakK+lmlZJpg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Tw4navf4EVQyB/SVmCSSFBNmfmsWZC+dbUXlkzOIwyrihb7Qbb0CEF+SiJ+2l/zR0
         uB/ZQmgY//t1zHo81Bh9Xu0yUzlnJBT8QKPC6wccud45VjsopRNwO79k56+NlU3PST
         AUjk4Fgl+rNrHob+ANhSD+YwxWvAZ1HlqAGaSwnsAto4veScH6O3UbVN+TmIvAr+Rc
         4ziTq+95AzhaEGkO0UHxSVD6MYBoDFbj9Fso2FHPy5I4yJubgmTcul3aZ4Snmc/0Oq
         /8Ny6Fco/WuOHmHxhpVbTEkJpzq7z6r8wdE7gXKBnGtgmAFVlZUtV/gS1MJlP2Tr7a
         M3wt8aZxl22kg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 05:59:24PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-15 at 20:40 -0300, Jason Gunthorpe wrote:
> > Not quite, upstream kernel will never use WC on those
> > devices. DEVICE_GRE is not supported in upstream,
> > arch_can_pci_mmap_wc() is always false and the WC tester will always
> > fail.
> > 
> > > With the patch, those device will now use MT_DEVICE_NC.
> > 
> > Which doesn't do WC at all on some ARM implementations.
> 
> Lovely... this is arm64 btw, still the case ?

Yep

> Also we could make this a variable rather than a constant and choose
> a more appropriate set of flags at boot time....

It is a function, so it could check the CPU ID for the known broken
devices and block them.
 
> > > Why would that be a regression ? 
> > 
> > Using the WC submission flow when it doesn't work costs something like
> > 10% performance vs using the non-WC flow.
> 
> You mean the driver uses a different path to the HW which ahs that
> overhead, not that MMIOs have that overhead right ?

The different path has overhead of doing extra useless MMIOs because
they don't combine

Jason
