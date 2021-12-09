Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04D46DFF5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 02:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhLIBEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 20:04:37 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:48661
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233885AbhLIBEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 20:04:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvCbd4kDGQut/yGBRZzq4CNcchMR16AtWmODGIpoYhfE6o/cW2HJbyFb1D2avmx0bjTptDPDifkPaz6P+q6vTs2J/3QWzGb4mj81zWrrqUqtO5taBlJQttyMjWsqwPSlrHDvbZBv8823QLHJtL+tzpaCW5OQYEaU5NqaNpSYW8CLzgQIxztaGWImlT9kGn9Uz+GAbKdwGhAEuJ+n+FJ9sSIbIvQ+6Onziq3Q26YZR0Q4xcK22Pyk7eKAiDnUmal8Gg5gUPaw7Kq0ZkdEvCNngCO+61BVGccDSnkctwoE47W5Rm8X20uvcr/HbY+y4Xaap5Yl0Ce0+MTvM0Thp6YzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgiVroL99Eb0nfuME/RPoIYITyO9tKbqxVG0UmaTgnI=;
 b=BbxTC4JvtR97/ON/xGxCiUjq9gy2if+iHF35WKBXhw5FDoB/2ZdnLObc9YVwrJJlt+ojH8jzzdiBc8S+7IT4jvX+BBwd+xagRbTGKWe51G652ZmkaCIw1Xzrb/KTmt3uz3XOBzvJS6zaWxfFxvShgxE9jHTwEhfN4jMn6XJ1h+GtmmBc05TFIGN75lgEN+lrvps9cZtFJVSCSB3vaalnIPORtCKC4FHJfJhT+DIIObK10ZrvPLNwFZVeWRpPiuC7fHjOKKgc4amsH4Yl8jeHGSmZPYY3heET1aEHBdTIFJReNDDdBMmoMxx3HmUlxK3KAqZHcpZFy47R/2fE2lConQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgiVroL99Eb0nfuME/RPoIYITyO9tKbqxVG0UmaTgnI=;
 b=szYOgFrXoNS1Q0eHU0JPXka6BAs/zPzusxtZh2SKA8Ds8Ona9pHGZuAsYMfRbAAyVpin27ERyR3DGBx7T70muSylsWw5ssJapsxVTwejCzMLOWE13r1kWTL2oFlVimRJDeiHvVaJvIUHfyx/iJwcOoyimu3VkdaiJhxwyV230RcEAD4b86FIyNesZR0+ZX+K2gZHBYT1Y7wCRpPNRF1SrMh01p+unK3kEzz6m/M16Hgf50geOIKKxLRo4r6gmoBRqjJTqOB9gVDp1I/ah82wvoVRneIgaasA0eL88yscCLke01+5w4aV3rRT2YpVc/N6v+IWSpNXQuWzIgZKVti+XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 01:01:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 01:01:02 +0000
Date:   Wed, 8 Dec 2021 21:01:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 00/31] genirq/msi, PCI/MSI: Spring cleaning - Part 3
Message-ID: <20211209010100.GM6385@nvidia.com>
References: <20211206210600.123171746@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210600.123171746@linutronix.de>
X-ClientProxiedBy: MN2PR19CA0045.namprd19.prod.outlook.com
 (2603:10b6:208:19b::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb2b6e79-f74f-49f0-cb95-08d9baaf5e8c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53365CBDAECB06902C026D8AC2709@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e17lyaqu5o5/7p3ntAAj6KuFyP+SAvPCdw1kW0GAKs8hmKhu4dY592nfacJ7yrTk5BrFP9pF0V36OizX+xtF1NtVgZOptQAEZsjh7B3TbkBqx8DXtJAXI79pIy11DZWL4JJKHy6KUVSWDpOwBV7352R6PzvhPA9OB5NjaYgnaGu/tupK+npuXVIT6K2jVfhJhXnTAIATAWyebbCMuo+VryfQWhF3827r0aKkkehAOhWY/CIu8lCy6aei6+I/yxaljhi9hksEMGHkz6Rgb6JmkvSuw3DZzUZk1CRGzn2MMjnTCMmkcUENCwfWD2hZbLAVEOtI3d1AHOgGIlPbuWMrPD4ezMF3BR2ELZHsZ8KRf+2O9t41PkwtWCCC91LW+3lYR+RA6qjmCW2WuDjLCfMDO7R2wC2J61iyF3/enJ8eorhnjmbeV1Esu9QaBSPxm8THCNhOFoH9xnLfIXidpe9q0Z91egFxvQ8yImflH36CZ7mUxisrozqbegiINuD9WIapAVErHy9ghW+oSIzXRxH0/mWDA58eQCFTmwsVcelfB4olk2DujWCDP7IpPX76NAZTR7uSVbXnV/FkBUBg969Et8r6kRcWGne978RAJyQMAEpUZniqIVIh54uQ1Ac97J80Z+W5V8oqbXLVOHU3n2JuVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66476007)(6916009)(2906002)(66946007)(4326008)(186003)(508600001)(6512007)(7416002)(66556008)(6506007)(1076003)(86362001)(38100700002)(33656002)(8936002)(8676002)(26005)(5660300002)(36756003)(4744005)(6486002)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shMDjip6zDxHHhUR5OdRsGXgMFMHRWYs4sZfujZtVozMtzrjzTFPQjyrSIx8?=
 =?us-ascii?Q?omtSDQRdsTFLJ6Mgu2ug1Uz0h6SknWbu8DNfs8kKIHXd0lJH4IxD243tGA9C?=
 =?us-ascii?Q?4on2t4MQ+kL6XRVtdcr08oiJUYIUQp4tipOM3sCo7em07I06sow/1Ox8WixA?=
 =?us-ascii?Q?q6E2Td3wCbKPqw6FxUolKryjva/E85s18fnh7nYGoTl18eiOXm1YHxkSxXuG?=
 =?us-ascii?Q?GmaZ/ebgLDTtj3Aa3K8tIgWZ0NeQ8LSU1tAAWWuEG0C1hkrmd5Oc1vJ5OHxq?=
 =?us-ascii?Q?B12MbFmL/1kWrmhCE4WlxmszHKXkzJ4fpFhu8Cg2bCOLJQfLSvXWDlfyLVr8?=
 =?us-ascii?Q?bqki540ZTeFATnfq2wgPhSS8NHpBD14yJcImYfnOx5KiM0Li4yEVlV5Fv9IE?=
 =?us-ascii?Q?As4OvwVrxaPjfWzA3kIzAwd7SMT31z2TOhHsM+n+C4LacPRtwGHLW1PJf1NZ?=
 =?us-ascii?Q?mzDwBC1cc4ehs7pho0BiYBrqUycXMGcIsscYZPpUOU+nVGC7bQqh74mNKewR?=
 =?us-ascii?Q?vsxC0X5GcSCIhw4fFPuN5fU2RCOgAqsBJoQLgrviRZACjB+K3U72iy3wOdhs?=
 =?us-ascii?Q?N8C+kjU2bAymJlE5XWF+Um5FRcaZ6POCVo6hfecnryXLdFS9FlAspGNrziO5?=
 =?us-ascii?Q?kt0krhbNfUhavl3qbMuIzdM3H0rhf+6yuF8az15oKg3kQvCQzkNxkO5b+yaz?=
 =?us-ascii?Q?kolMo/5mZ0EJNPxq71ZA2pKn6D3gGSpxUZ3uQw3PROJj1x3nWLDimri0/966?=
 =?us-ascii?Q?UbDck4JTjuaNHqtpmKlL19UlhCn7a2R7BqRSmHuKn7/nRFIyOhLGqNrVVCkE?=
 =?us-ascii?Q?6/YXoVAz38p8o8d8/SeKvVjX58TwFmMFuHHAoZNuLQTcHm3Z7d1rFz22qP1I?=
 =?us-ascii?Q?RY+GJNiBjHLJlmtyU71FcLKEiyHHdo0DAt6KzNc538/Re22ZhEeC56Kd8bge?=
 =?us-ascii?Q?BVppaL7E5wSXf2UqHSgVN37oGpN1GUksBAlK8cbdU1alXDSYCq3aUzQ7RG1u?=
 =?us-ascii?Q?Pu7LkZUf2N6ajM5ud6T9c6aKXNEBs4qgBzL5VCgXGlciXa9EYhBbdpeGc/sQ?=
 =?us-ascii?Q?HypMDnmDr35vZcCGnkro56TJLUn2dIq/jEehKJUVHx1oXIGUp8UBpiYMrAmF?=
 =?us-ascii?Q?GT49cRyNB7ivkpviR6IPL+u1ZBvmM09Ts2k2aaomvFgje3mH2TQ5Y64dePxW?=
 =?us-ascii?Q?KFNKx43aywyGFxSGVNSxdAdOn5F+dmbnJa4hM5YxmbJkgTKtHkN2j7+3Dcwg?=
 =?us-ascii?Q?9c3hMi/76nXZbEal5CP8nmGseHAUX0hwpXM632u3E8ObsTuciqkPASfd6uaD?=
 =?us-ascii?Q?/fZTct4PYQXVfX+4gpLfIs8ltipj5tsDxHVyiZLzDWRFIjj1Mqb9SDmLSKkY?=
 =?us-ascii?Q?XWi3HLR7+UjHEfUGkPGVWnDgy/0HZHWoeVksytpNzmXSLOP7jZFj3BA3DZip?=
 =?us-ascii?Q?Kdo9gh7v8rODP8cZfy34t54uZVQAMto9DAj2dqwvBzs3xqo6/ue3k0c7z5nG?=
 =?us-ascii?Q?uT1bUnZyYkoo+joTvN7JabYbZEzdb96Gvjsf5z9r0kBYlnXHsBbw6iOSHT0d?=
 =?us-ascii?Q?zU0DcX2WcswaFrAmk/Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2b6e79-f74f-49f0-cb95-08d9baaf5e8c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 01:01:02.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac5j/fEW5mAA9d0JCPW6WGG1MEYtFnJRc1YLJlObCO0269ZPl958o0fLCYYWvNi+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:02PM +0100, Thomas Gleixner wrote:
> This is the third part of [PCI]MSI refactoring which aims to provide the
> ability of expanding MSI-X vectors after enabling MSI-X.

I read through this and didn't have any substantive remarks

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
