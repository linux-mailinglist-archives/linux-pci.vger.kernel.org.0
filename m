Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD84EC85F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiC3PjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiC3PjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 11:39:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E192DA8F;
        Wed, 30 Mar 2022 08:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRIKX9UvfH2Gee70amq9fPyGJ96vHHVOKB9umObvMtrvj/+lTK45/gGkrKEUoRW0iMUPY1pvobV3qi1+Oj5dqKppEc3vxStld+uk6nTMQc0Vm5Yoo4xYypQXsz+8a9zc/JJDT5aHGXSfYvLjSAJhKoNqkg+knCUlF1zU2DokF8i1/HLazQys0MQCcAY3Ua+CcBOIUAgKoez/zyLUYdtDFIY3/Zd4xJ/ScxJ/yNqhvlgYOvtsdLeOmkAk9muAJkcO7CgMRC1XYkVQqyBDGLCiRg8h8pCQ7kPvuAG5XlBV6U5hwyl5O2VnoioItEr5QRtmIHVLnE8/FKtnbag5pTY81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnMFPCJDfkXzKnJ0RDrywa3ibQfiolNFeMoqChKw7VY=;
 b=buUUhTu4vxn5OVm1+tE6J3kv9L8vB0p7Se4dFHO61N+oX1UILRRtGG6cLpCfQeDS3Mm2jwzURJDm6Nhbg43noZ0PP9bGOaRrdr6iRjICfDjoy0nQQTGC0j3xPcteohyAe9sTGn5W8cLMf/nqk6bJqb0TZqKPco0cELWcCxWojpX2tcJJQOagIt/W2vXJOb3+Jx15ZV9BqDbz4oOrO920P0kde2M7nWnFStm7hMuL+2vi1/xwcPeEqlKoN7tdZnEDY84tZS1TGzr7u0kujdOTL1GBpYhTjpEh9vjh58e+ftROqGWqw06j7wyWxuea07cESi4LXM5VMeyw9/006x8pOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnMFPCJDfkXzKnJ0RDrywa3ibQfiolNFeMoqChKw7VY=;
 b=cvf2qcopaUaTmlkYgmh+QapNZo+Cvldx1kv0tBMM9Hn+GrsCHl4Ca3KIDW7Z/Ak/cKmULa1Hgnmdke6WuCknzOGQeO1y24gIkUqUYZ+J4vTYzywrh/nGZLobEgWeeVdfEoqyk4pKSilTouVPf858cwwm4m469pUWO07a7xH9jZEcBgM8CMOyvTvSgydU6JIbZDZIBtUZWvmiy3juzEKs8AfEgwHX75LSSejQEfkYtPkFQSCs0Z+Xykj9ogLDNC/Mf80iiU9ksb29hXAFPse9qMuZcyyCtYB9uBDvssMkkiIhxv1YfFAk5jMiJRhLqdgISuc36KJWptgCiZvnHOOHOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4836.namprd12.prod.outlook.com (2603:10b6:a03:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 15:37:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 15:37:21 +0000
Date:   Wed, 30 Mar 2022 12:37:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, helgaas@kernel.org,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220330153720.GF1716663@nvidia.com>
References: <20220330140823.28826-1-shlomop@pliops.com>
 <20220330140823.28826-2-shlomop@pliops.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330140823.28826-2-shlomop@pliops.com>
X-ClientProxiedBy: BLAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:32b::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15dace27-fcdc-4331-7a01-08da12632e32
X-MS-TrafficTypeDiagnostic: BY5PR12MB4836:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4836204D9236C850445FC37FC21F9@BY5PR12MB4836.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU5YQQU01fy+92xRw7ZbFFKBF64PD/nkAid+Ksj01qM2W3j6QusOEWhI9f0bU+ARTHHOqbXFZN9w9E1/njDKjJzDcQUauK/KSsc3ij8ymvzZO0xRTzGU/NJmuZOYudtdg9Pf4O5inF/RWUasvgS2pHAq88y5s+wM2JqRPQIpls94oKMrih9Q8MgkziVka11EHudTF7GtZmLW0qRDp8ip7GqW4UlEVoP0WTIw/0tbmbcZwv3qruDu6iawBRwu6bZzAyk32htBPF/kOAso+XqaoekgTJdI+MWRdzsjHnGNFpJTdAq299Uod+fpyD4mOqSdDs88JrEEqsUIvzFCVFKeoC9aBpS+ebGv5jAJhWAWfRwOZ+/SOi1NJF9zeMwvRyVZFDZpa0v+kFpc2TyaTUOlIyh5QNJEQi2SmL934hl9JedCYEucNCR1C6XK13AqE6J19JsfvIyzNqETeWDYr83JoyNf5fHwVO3NPWs93RR4HOXUjGzgmQQDQGTfy3i/dNx1BsyJHVYsAB8T3jZjjSsGcK8omsEWHZCRRSVkSCqKcNMAQBuQmPzFeUZq9X6Y4Q4f7KgiIJ6IuXDwlsgye8pPMHoMRTS9R9WrXZNQhKlw19IKFgqP3rd8eEQh1uHrAblPoyp0QIRYIEgoYZ7n+qUBvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66476007)(508600001)(66556008)(316002)(86362001)(38100700002)(6916009)(6506007)(66946007)(6486002)(4744005)(1076003)(26005)(186003)(2616005)(6512007)(36756003)(8936002)(33656002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yv/G9BxWtr41aw+C1NIbPiYMRBoc+vr4PCzmQer4ayvjnDfIOIOSsbmn8wzG?=
 =?us-ascii?Q?p9x86HGu8WhlfzmqNC1gs8fOrYWQN3sSPo4XzYpchpfgkaaBP4iHcMLE0NEM?=
 =?us-ascii?Q?7JdSXA8ZwDjvjr2OQ/NkAYUtlit8yuG8rfLOEMxBbLEvCzp1zp3KApHm5Of+?=
 =?us-ascii?Q?V4VPrN14HdC7/bVMPpjOGR1PbTOGmY9cD6yTxeklmvjhj36CE8B92/ZbTyKk?=
 =?us-ascii?Q?EHDA366Mz5oTFK5CZccF3GBx9RvdQj8ONXUsoR0xcppFge7zUOijVS2pd7x0?=
 =?us-ascii?Q?Sbcq6WlSwMW8BtNExDoQX9L9dGd9oBrSfMHOLCpm5AKmzoX6R1R8HSaYVgo+?=
 =?us-ascii?Q?1b2ZAoxg+O2nrDUOSmjVJucZLTZ79ysmdEoWzpdg8IMg1UdCKva+1iFbW0nc?=
 =?us-ascii?Q?VzYIs0df4keqEVvA7QZQh/Of1En4jD2dEknNYLoPX5qBo/i9Gkx33av9V03e?=
 =?us-ascii?Q?s4Z6nOe/giBfk8Oxvawi804VAi2Qlygfzp7EnlHMFm7og4R/WoVq/Gbemsf6?=
 =?us-ascii?Q?C60ocgqolIolDdHeHLfqgfKzwhd9T0iMrOqvDZm02MeJF1dw/u6IOEwLDp0X?=
 =?us-ascii?Q?HGEKfNeXWv8QTb/Grc2EWMjQpf9xJkpIy25GTH+mOQOvlt9QZidj4ldEtQQB?=
 =?us-ascii?Q?RyIwYX4MC5WwRiIbYExxHPnEoYDECD+BOPHshwRxQSYO1tuh3u9MQYC2ECuT?=
 =?us-ascii?Q?udYDd5LMJJVBo7938cCshQa0LgswdP+xPl3q+yK5pW+ffolo+yQV1A7iRB0B?=
 =?us-ascii?Q?D+Z4UmgyofojowctSsxE/iFIRyPIuesp/H+deWmgwBgSLAGggpbfVDWRPYww?=
 =?us-ascii?Q?6K83ovy+1yaSWYswC3rx3pySf9nUY3NVmgEKofzwt9mIWG00xo/kbxkK4jQD?=
 =?us-ascii?Q?ecdMQBgtMlev+coTxW+YGGl5sfdXk+9sDTBsycflDvd0Krwmved8/cSw/Lo8?=
 =?us-ascii?Q?JFoZGw18wjfJPMALAP7h5OrELDw+tiQZRFv2+71aBAIpNA9l4jr9KbJtW6wp?=
 =?us-ascii?Q?8Upj80iKUm8azUewAtFguU5+H9q/7ru9+zE335NRuVWiY3EmxGoxfG6AAE0h?=
 =?us-ascii?Q?A8VQrSoNNhJLX9M7ms4FWJLp4V5bzrYb6jQ4qTfrsJHtOWXR64013BLRN//+?=
 =?us-ascii?Q?jqQYi2t7H/3wsdjnhWgrxdMGjMhkPFc9PWgeO8ppQVTFZ1G4AgmIEkxmtbbL?=
 =?us-ascii?Q?Q8pbI5f2WiwePVqjgl8ckDh0nBncKBG92nj2HpsSm80b4ZXYWojqiAmKuJls?=
 =?us-ascii?Q?h8Qb4t73yxFioex6SaKZZY0e4aHPnyHZcU4c6NqtQEdTfZvdvAIyNiTA7bVf?=
 =?us-ascii?Q?kYR2mBOoxm3zsg5GimnCMBFp0yKw4yMiP9yYRKpcOt2DsPm+7b8KL477Cu01?=
 =?us-ascii?Q?b5oQnaaU+bhbCUJzyM6rcFBa12DqqLlZ8YFE0aNrkIW2bxlwhxsek4o0QVBb?=
 =?us-ascii?Q?PLkhx26mYU6MTj8iXiNN7llw9sPuaiqxMYBhCtVYymyEtfYwrYkltXQB9G1o?=
 =?us-ascii?Q?mbAYVJ6kVeXbHCf1rVy11FS3NElN0CqpJevnkEUMHHlAgyTOsV2BAz4IzJ5M?=
 =?us-ascii?Q?GPuT+Sd+UioJseKlkdQ8+GGbfIIGF3lB18bzkZkbtPEyzrBqQO17d+W4eXJq?=
 =?us-ascii?Q?598Lgv8z01VWjsHV/jElstHxYr5Wqn++Vzb6/shWh/zO4zYHPS7hzaZGBj6s?=
 =?us-ascii?Q?MacQmppfa6aCXYYnAEi9TShLh3IhsfLEAnCiVI8cQDEJeJJInzuudgGOMPrf?=
 =?us-ascii?Q?RY5me50tqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dace27-fcdc-4331-7a01-08da12632e32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 15:37:21.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFNJwH/Ms/GYVWd7w87kHV248SP9+APAuZ19vu4h/0cAO7Jlcgz5zZoGvRuWkl2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4836
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 05:08:23PM +0300, Shlomo Pongratz wrote:
> @@ -350,7 +353,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>  
>  	if (!root)
>  		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> +
> +	/* Is it a host bridge or a root port? */

This is a better comment:

/* host bridges must have a 0 devfn, but some of the entries in the
  whilelist are root ports that can have any devfn */

> +	if (root->devfn != PCI_DEVFN(0, 0) &&
> +		pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT)
>  		return NULL;

Indentation is wrong

Jason
