Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238D62DCD8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiKQNdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 08:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQNdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 08:33:43 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05426B206;
        Thu, 17 Nov 2022 05:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdgCdhYMV+8pQmkVDfk3goUGkfyue3e7wmWj73xRrUcbwu8pDScGYHpo45lzdYcKWurBB+G5epDqYvDrLRwGwLSndO1d8ZrBIeVa8vQyL9xvBlNK1bdBV7hd71mWB1mcJ1uVuICeigVl4X1EUIBbjdI4tF+qbEJv3tprwwqSX/86ygbwPjyGFH7og6b1KGpTWKaQ06Jnix98g0liip8IA0yvRyzfkS20KjR1Gwrq+Onotdd1cuGUZQCCBqQf8Qx/YEJrePJ+9m5pq0Fm8r6bjHkiwG2XSe6u6N5w913sJSydanSrSnTnGrOObbt7IawyuKZAYEGluI38fUA9KzEALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9F8vNZ0K7uCjaYtsonIrknuqB4S+txYNE4rGGWQLMs=;
 b=jBGZWnGW1JRpDmYixcGYejsBZIjQ8PAB7zHrW9fP5t4MB725iLLLKeBVZop8hVzGDaXpzTNLK1Qkz2cOJzxNwHAgujCqJl3iPx9YDWy7zY0KSCmwOpKPBjAYdnUwXjqF9MAERmFf6Lrca+mJQnHN7gAlj4S1PAkM25k459kYYQoKWTJ1psjVf6f8o5fD74BdF2G4raIIDeoOtPDeIeyqGfUiAstf9eVijcwJTaMdjs4e6yARe3670f9W27w3RKOjLpMcD4MMFHLQ7PPj+EnujRTTkwrO2fFZJ1U0PiuWITB4AgWCXzhjEkfDpEjs8f8SkDnEZBS80CEblB5zHaRkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9F8vNZ0K7uCjaYtsonIrknuqB4S+txYNE4rGGWQLMs=;
 b=ePJ5dJH97g75+r6Jri9fFahMKw0Tp2h4N9bTehcw0MxRDZ076w8hIvRSnk+iyrU0YYQ3CICzBMKypmOhpMELzxMLA1dQerFeNpzYMXl8GE1JnI+oy2QRhsbDVSK4MKQvktdAfXXOxbIF0oKOhbsz5kvXtWUUYmymjMRFV/PRX8aDGO+rvj/YHhgc+1Wg3Blf+Llq9qMT/Z153kThLPfEwaNrl/+FkO5Upzpt0/eTcHBxdCZhe3JKAgaMBhUlhE8Ev4zRbDlLLdZN9l4yS4R0zBxlqQ4LcI3bcqRYOGie+Szq7qe2B3gXGj7VyE0f8ZV8xY8+ar0qRrR5cSxA5WaUrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 13:33:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 13:33:39 +0000
Date:   Thu, 17 Nov 2022 09:33:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
Message-ID: <Y3Y4MlLuLotvYbmA@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de>
 <Y3U5xwujkZvI0TEN@nvidia.com>
 <87tu2ym0eq.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu2ym0eq.ffs@tglx>
X-ClientProxiedBy: BL0PR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:208:51::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c08a8e-3c1b-4d3d-e67b-08dac8a05672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlOleX7TS1lGJIn8T/CEBCvX6Sjn1O/tQ4PKr+insSAE0zYi0BPpv3jDO9GKinKJvrpf3e/CFfmxmRPGGCxrO30tmJtqX/3YMwjx1l1A4ibfgmRUaHq+HD/sDXbGfYjBTJEtanQkmaBm/moqq12e59hhJ9JK9L6P3KRaF22yQq76J4KSDpRVTFuLZgkAfj8pfvbSgP/5KtlMhaUUPprQxQHxzYF6elHlmwGh8ZKxJNwAWoVxXdiBirysnB5d4KUWVhgivZ8PIJ57hclehRPiM2UWtav3gB/Jfh504j8Xvu4hh2SkYJZR4WtDoklZt6dzatK65OiQCVKOaoEqXz5FCOiuS0/4jdUf7EOUioCWKqFvCQ+F+e/XKHNrcVdXDpYK3Mw3ALkISy2tnnVo7s5LPASw0gDJrbJNpjwv9vj33eTIPKFaoNzTJzdBWNtt/1mzfV+BCQlC5Z3HFHYb6w0Q0x6jblBjK253pGxM6VgKDaWxP/tdUelPI15VRPWovxysflHgoKHbmjEQrIsDhrercGpHUHCF70/gaUB0sLUdW3OEnAFwvhI1l/uBxHy7QOXif7/7QKMnfguoRZtNFNcfBRe3EQMvKAu3qoHHWFgcRPHfz4BPLLGL4DGTEt/vXrYC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(38100700002)(4326008)(2906002)(8936002)(66556008)(66476007)(66946007)(8676002)(7416002)(4744005)(5660300002)(86362001)(316002)(478600001)(2616005)(54906003)(6916009)(6486002)(41300700001)(36756003)(186003)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYP5ul4qi6mZU8NB1gN26o+BDmAEF2iO68OsuiwmIwdfdPdx5U/gAt9WpyGG?=
 =?us-ascii?Q?v0KAA4JBWziUOyHm8ErtqRut8FesZS+WnXY99TUVWn6p8BIMOeRK2Hatpk25?=
 =?us-ascii?Q?PAPNl0stlUHHcLwZW4MRqCVwmbOg/G5jgDndPZ/XukuaXO8lHdJYb+tnITct?=
 =?us-ascii?Q?Laz+emYmsvUrqmatnU04cvDFLKNna3/4/2xLQcRM2qw5u2M+Xhq3rV/vDGBP?=
 =?us-ascii?Q?H2nH3JJBNe2DMlmu1jMUjPYUWFRdmv8up3kvk7nC8H0Ngn21BRBrfisOIXKh?=
 =?us-ascii?Q?AcgxYMIa0fnwBQvPaD0ZlYh1/NgNllA0iHGP4s/n6zgu6wxlpIwn576HWcUu?=
 =?us-ascii?Q?X9SmU/2yW6xNSXDxrbCZCGW56X8lO7J/s0leCQe7hmBDnKHGv6RQ8b6Uhfgj?=
 =?us-ascii?Q?u6I6+dWvlgGM+Rq6RF9WBQfxxW8qVhg9RejTOnuhLSXcQjMXwvRc9xHeYNGS?=
 =?us-ascii?Q?jlZUTuWpXe/lVBdu0H+O00mmW8BPFptkJ7bYcKgq7hOdHkHQCpGQYw6njQA/?=
 =?us-ascii?Q?Tx9OAo2MUxlYN/BZ9FQY5hiOdcSR/7lWufUFmddUevhY2uOAFlwQyZGQ11k+?=
 =?us-ascii?Q?+P8G+mLr/Va+CGPwjIHCNJ0A45wCLa8qVOqUjjn1agLJJfcP/6zd4e5qMsBf?=
 =?us-ascii?Q?/wtUFLFAYRZKR+GkMc2oTKM0hVzod2ntZcmfUapd5765CJhxa5TGiU05iE02?=
 =?us-ascii?Q?g7mdv12Wha6P6memD+jzVRx5ecvG6c3eklLMoy/oqlwzW1lalz7pVrjFyvsA?=
 =?us-ascii?Q?OQsOjQ5hUgUXQ1j1mA0XiOuAd3P7MZRKxMlYj1ChpglatVSFYaGxOHyRoxQx?=
 =?us-ascii?Q?HqmR7f5UsVwdOTpF4OmolRhWuEmL7cO2sOON7aQteJY0lokK7tZSSRuk5FEV?=
 =?us-ascii?Q?B0Art1yYxamgmE2rvWdwSlwSXLJWSLw+suoueEn8I6ETQnXmbYUxkOG71DjQ?=
 =?us-ascii?Q?zxlcjQoR+I8ecU5mG77RyY+WxOZ6DXxm7uPPvjmuts+PmO/uVSoNfUZh6RcR?=
 =?us-ascii?Q?hZlybzzs9erTDePcmLkgDu064OPfM6A1WgUEH3mkeAhBdi5RDA70ouyQc+if?=
 =?us-ascii?Q?Rsq33D9p8mai3S7ujwxvJRQC8zawa7umVcDiNgLd0N5B5ly1CCBC5658iiaQ?=
 =?us-ascii?Q?8D5shaLv5NG0Z173yd/rjkQKMvQTm2uCOXok1zu8txA8eNGS/B2Q5q7MmYnM?=
 =?us-ascii?Q?Rqrr6ZHTtnvvlt5yxqhEByEtBisfSuxKEK3X7nArBu22qRnZF1sAfDIfedL6?=
 =?us-ascii?Q?+lZb3G4icStHADauwCobbFjse8GJ4/6mMWqhh9A0TMjzt0QM5cy0VdbehvfB?=
 =?us-ascii?Q?gwZFi2D/2qP6QIzqf9+VFhqhHcmCkPa8DzLXqEtzzBpFG5z24rqIE3MnJphU?=
 =?us-ascii?Q?1ZHZ1Dq/mt1LXIN3tM4dh/eaiFS4Mx1mK9o6N1d80M1YNCtamst3Y39tFPwQ?=
 =?us-ascii?Q?VfzUsII6VMjN4hl7kMlsB/maOudn4PEKMRwcNNwS9H8u5xgDihVh3oWWjnfn?=
 =?us-ascii?Q?8nmMkaTcgpd6bLoSg61duZUAunWb7HHm74/y0C+OHWl2RfWEUbFGNcYp6Uh6?=
 =?us-ascii?Q?iVqaZCVcVmwmFbCkOnQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c08a8e-3c1b-4d3d-e67b-08dac8a05672
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 13:33:39.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+MvSr+Blfbv5BRxzOyCGjcAucYXMwsBoXC67RDbS/+n//cqukTr9kTu1TccMjuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 09:48:45AM +0100, Thomas Gleixner wrote:

> > We've used 128 bits for the PCI descriptor, we might as well like
> > everyone have all 128 bits for whatever they want to do
> 
> Not sure because we end up with nasty type casts for

Something like:

void *msi_desc_device_priv() {return dec->device_data;}

As netdev does it?

Jason
