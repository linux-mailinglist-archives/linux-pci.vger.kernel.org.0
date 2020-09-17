Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D826DA69
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIQLiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 07:38:00 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:19855 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgIQLhn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 07:37:43 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:37:40 EDT
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63494d0000>; Thu, 17 Sep 2020 19:32:29 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 04:32:29 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 17 Sep 2020 04:32:29 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 11:32:25 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 11:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/hU1Xb3F5qHwwtBVe8ywxX5/4QoaLxEBB7R4Q/WKZ8H445/XZhttIvkrGL/wnwDZoXa2sIPei2WceFyv2T31N3aYgU8bY9YTpr3MF9kJgjplE+UU53KtF2iofwmBgeVs6oO+81fMXJystHdStXSTJS1UP0IOdO6u6FCOIBsadOTP5/w74sb8W/MYELE3SLONbS8vh6RXYWDUYYl74jgy+DfT2zelTPaqbuyKRxNJWHbM44yKSxmpSv3a8Lz4X2+CKdodYvAPtVS6dCDV/c2sHuL6AAlY2rAAifntkhBDpuDPJz/SNp/wpbgFeoEwaeTji7IKAZnKykZdq74q5fpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMloEs2OJvzqHjkveAYpZ03oJ0AdBGCE4ZSSuMFW35E=;
 b=CQc+64C6r2dTxiW/+jorenveEpBXQMmKHM9eYHYu9Mf+Q693iCgRmOk+Xj7h7RdNFi7BcBnc7Udn3Jp4wl+TZFr/Z9bLRRreSwPs/OBrmJ4OqHbdXiuE2MvZcr7v85Cw4k0VsKKpCE0NktFfEIEEAodLZVhzis2SNou7qCpPwbDTAckONcJHsErE9qZpTY2/hMSj7HKPvyJOgEjSFqBYsSPl/pJARJ4zmo1w6t5Szycv0aXkh7BJkGQkkEBp47zdFWYhK5k8tsiOE3M3BEvbccD4JhgHMhfpGbvKcxXAByZKs+SisGtccOry2RPWkWElvUdIRMeZCiX3rW6MdUyR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 11:32:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 11:32:23 +0000
Date:   Thu, 17 Sep 2020 08:32:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200917113221.GG3699@nvidia.com>
References: <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
 <20200916121226.GN1573713@nvidia.com>
 <28082ccc715a9fba349ae6052d5c917ae02d40fa.camel@kernel.crashing.org>
 <20200917102819.GA2284@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917102819.GA2284@e121166-lin.cambridge.arm.com>
X-ClientProxiedBy: MN2PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:23a::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 11:32:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIs9F-000Q8z-GT; Thu, 17 Sep 2020 08:32:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa1526a-069b-4cfe-906c-08d85afd58a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-Microsoft-Antispam-PRVS: <DM5PR12MB243930C7495916748F80E094C23E0@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/i3S68G3HNG3UK1r5x9rKxXc6RDhekef203iysJfKyyRsayvHm6X5DMlsPbdKDPnpdplLAievXm3sKWfI1shc7Xr2psayVRoqNeJ87E6nbR1iSPgJUjt0L2Yt/Sx22eJLb4PyeAhPnTiS12FnDyGapvV7kG8/zWmt1iMluoqOP9MigrYtF7PIbOzBkjNcLAGXgZdncHlrVKTL2h7uKda0WlLCIQPbUxJGV1z4mdJfY/zvSF173GdgGXVK0rXqbObXvHRdc7bTekLvViikYwgayeiOSX7IUEjn5Z3rLN4UycHrrSvX8035nppQflkfZxPV97OAjnOmJZCGE45ZfHPhE6j6gtysnnYkNnKLUwtmZuDrp0FvBf9ofQxZ6gEjoF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(9786002)(9746002)(33656002)(26005)(4326008)(36756003)(316002)(5660300002)(478600001)(4744005)(2616005)(1076003)(54906003)(2906002)(66556008)(66946007)(8676002)(6916009)(66476007)(186003)(8936002)(426003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mqxP3j0Ig/j5TzLibE3oCpktmC+Kv+aNP1ErNw/WlRXSBpNpgu2jWsB+V7HsTGrgx0DBQuE1TmRsxX6jJ3zy8DdL+BcofuKBHyK13QOkzZKZh8ACHfKwZhrWbOtrGdgAxS35tNcNiOolUIjjr3+OqyYWKZ1ztX71/ba/rDULwDIOt0aigdEoBZsiFK46PANMtHqlC7Leex2No10ILo1VHqgNbXDYWab+m4tciZjnoksWZ87i9CT+2yke97P8hOEjMCiXtcc4we4xpL+rIMlxVD8yT40m6F1e04qKnYDrOADzngkTpFSVFNa1gnb5pL+N4UAvGT2oJ3F0gXjeEiyhwQYDzmlhguz0KYzhym5V6QaWKBi3yQxSvDPw1ll1/BlPqCzipOfthHzVq3H85RYw/MwglzBIaSYQLK7WvDY/bXzgAREIQQOBIkapAuWwy/IsV/xB/r2K+btGQ4wxiboU5dEBioYBP5VEiriksoIWXSt9FrhIQRSJiFnq4Z8eG8hg6Ql6ljqebKwNn+bARzIdi0nTv9bBNzP3G+yPQN5HHqa1AcozbCmuYILOhHMXu06gdq/xEh6yfM/k90i/JIPHAnz0Ao7w1QXbQykPcf78soaklCGWK9lXQlwmVwMRx8ERflMAQir58VnL4ElNyjEVVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: faa1526a-069b-4cfe-906c-08d85afd58a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 11:32:23.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hE9FsDwKC3yVsSOYD0+NpKeVGw6YYkLlQERVjwgS8QoiX9m8U2VCRqekUrvj6Ej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600342349; bh=AMloEs2OJvzqHjkveAYpZ03oJ0AdBGCE4ZSSuMFW35E=;
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
        b=Dpeimn7TXOjjg21KX/KAwJlUBXDTGEniy3g+08+81ZqpjE8m2sHZC8s4PiO3D72YP
         nbAxFXOyK+IX62GQoJj1a6ApROF5XxeXnbECiyALkPL1YtOkpj3XJAFU4Y0eJjuEi4
         KPMLid/+OzbhmOvXaGYbG+f2bkrFov8b3gKuDV3rUV1lxG4Ur1zKe2Ntc6wr++eqQF
         zqx/E84Q3BQT+fQDezoYdwf56UJpdtDZu9c12shZe58/CP5tgQtZ/p+UXAB6RJgbUm
         c9NZsEynaoOHY7RPUj7fEYRPAbGXnn9iG5owd47wkPIqjqqIBqqCg6EVmDahrNh5MT
         NEmz38AK1GmwA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 11:28:19AM +0100, Lorenzo Pieralisi wrote:
> Unfortunately if we merge this patch we _do_ know from this thread
> that userspace will suffer from a perf regression on TX2.
> 
> Either we ignore it or we write some code to prevent it
> (ie first step make arch_can_pci_mmap_wc() return 0 on TX2 -
> possibly using the arm64 errata detection mechanism).

If anyone complains they can send the change to arch_can_pci_mmap_wc()
- I'm pretty sure nobody will complain due to mlx5

Jason
