Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5866C42B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 16:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjAPPmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 10:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAPPms (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 10:42:48 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFDC7ED7;
        Mon, 16 Jan 2023 07:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTptGHOpus90+3ou3kvIJsLxMtqvrOl74q/ipTAdQosgc1JG2h9YsXGkcXPZpa8RP1YdaEvuuAIgKPse8G8qTeWcKNXY/vG/ASjnQqgHcqgoTCKnKdxtGRa0HBRopgc5k89Wk95NJBKU1C8T7xj+iLCPxfqGH7qppkEQX4gyJ7k0S96meRHqQyjvm5a3SHHo7F6NY4CkzXX5YtOQcPt2squ7gDLciMibGdMkug7V33aT4tdSwQVckGb06e8wKG61+sffZhj2YS/qU7ocbvjhm4XqYtryl36fQJb/Y5ZwfImoF/5zjkz3UHMJtHYpehz91E76rq+Ep46ZBg6G+8NHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pi7PQavYvowI+ojX1CZBqATdwmzD7vygis1tykgKis=;
 b=MHHU3TEVaJSkmF91lWT0M49zdiTF2NHR+CqjLeftgfJyWW+mCX6Km0KioEuH9SrMsQOFW+EIbmB1yaTeIRRwBuFsLO4o309N6enabDDB5d33cW2h2pO6N50+kf3dtVGxg/dpY868Z5KsIZuvXhVG8BApDTKU51YZwVP/wM84rU5X7rvL5yudoZnCq998M3/r0lIYEi+HkS61MqW760wEogBss7PViDcsRiXgzoV8YXge6znvF1Vtx8fhm1EY6IjM4pVMy2PbgFp5t+S+RnYf45vBN87qgQBJ/edncSnZl7B11zFTVbdNZ2VbK97RPfY6kjsHwnX1xL7t5dD9vDwpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Pi7PQavYvowI+ojX1CZBqATdwmzD7vygis1tykgKis=;
 b=QjmUQqPD0aFT0EqnI0Zr45NgxOH+j0mcdO2KNj3rXcM1l4NX8xQTYA0MP0AGBCz9xxXrkKb/pncZ5BXjdLUoDay4fswEzM+6b1QNvDqM3JHzXAyjmzn2pAw4m8iTKK/T2vLV8JLFdTWkk/LeO5vbWbnfJ1L1Gls3SlQ9m/kEm6XyWJeX47daOkG8gNGk26rhMKyq3cff8ljCXslPpad+Jw8DlmTc/r9SKnuBHeu/0D1ntxBv5Zo4E9D9/RxZcgITkCwrZExPdrnd4qdjiT8SH2gOkOYV/rIQ75YTcz3GKDgDppkZeZiRbiO4moaXTfUp3URGhDSP9JphqjZ0e7lVbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 15:42:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 15:42:45 +0000
Date:   Mon, 16 Jan 2023 11:42:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <Y8Vwc/bMwvtICv4T@nvidia.com>
References: <20230114073420.759989-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230114073420.759989-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:208:23c::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f89b59-7386-49f4-a9be-08daf7d84faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1TrsPxPc0GpjFVyrlwoqwhzdSX5zq+TV375GR6J1WYkcZzOabHnSIR/Eqf63UP/boCIB48P4VT8OXIJ9FsTU3K6I6cLQ6CgWtXBJl7ojD2n5FFMKFVh8ealHaSWYmdNoK5etbvFJO++SlufFWDgWDNohPzTMqHBtU3W1QbAVnhSM6Q6tD3CQrNsKbwSPHTjAS5b7uD+2DDqZR3xOq+BfQIPKzs8zjNS31rNv6qLsHP287ys6bwe7WTrtbmzXwGaIkanLPGrrSmMIxGPtM0bGQ9T9SpEVaWPScWTZyBvBZQHeQCgWhO9b/rn7YKy9OPlZ3z2jSs623X69IUxbuUiPbwWk4g/nrRAPu+dwFTwSWw16ghD5fCvY+qcZPgVmlOb94xcSUO704m5D0S0hickc9XC+RBItODGB+Vdo1yRodZgZdT5Q0dMiFm1bXTgoFEzQwymVA83cZ008MMfZjVYSJarD83/WpLYAYuKGHgWJURLEKh6vxBtwQRWLseJzw9i6lSIlKSSXLSZOw3Lty3DJPKxU/gvNl7DnN2kkeNHrLCLw9JaF0TyY89OIeb2rWSvL+gRpmreQj9JhG8bQDX6a0EI49+sL+vQxNOAe2cVD0pcwc5i0TmjZmEVROZ5IKWsiJIN9efATyoh9dKzawP+w98ztDE3Pg9hulIisUiD1hTlZVNIuSyDesChIeSSnx46xDNZCd73T5YrEcukzKUy1x1FpXefRLgjaykwTuFs/P8cR3RhqCulvtDbTkjvIp1ckHatNMBy2BmYGGrqST9NsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(2616005)(6916009)(66476007)(4326008)(26005)(8676002)(186003)(6512007)(66946007)(66556008)(478600001)(54906003)(41300700001)(66574015)(8936002)(7416002)(2906002)(5660300002)(83380400001)(316002)(6506007)(38100700002)(86362001)(966005)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFzWnRIMFhjU25LNERTN0hZSnpJQ3JoSzhtb0MwcW9uTFp6d1N6ZEdiT1Nj?=
 =?utf-8?B?LzFRMEZzUlVzRjFxUlptYzRkTUxmclhMZUdCN0V3cDNQVVFXbi8vY2dKMjFE?=
 =?utf-8?B?VHVOa0o1UUpxYmxsVlpuZnpCWFpQaTZ2SXdJN3NNdXlPZ2VET2JWc0JETzMr?=
 =?utf-8?B?VWRKV09KRU9yelp0RVhIVXcwMjFHbDBHMjNDUlVkdFE3TS9DcHo2bjdmUlls?=
 =?utf-8?B?Y3MvSis0bzB5ck80ZDFWSVhMaVZZamF1elFqeFRSOHllM2JHNWZuUm9jZ0tC?=
 =?utf-8?B?clhiRlgvR2pOb0NJaU9jZlNaVnVaYWdTZTZCRmV5NjU1UXZIVUhQR0lTNUUv?=
 =?utf-8?B?VUR5ZXNvYTM4cHdWSjJxSnAxcGdCSW5hK0V0dFY2bldZakt5RjlxRUtxVXVI?=
 =?utf-8?B?NHJpVVAxZTF0dkoyblU3MjVvTVkreXpwYk9aYXJvakR5Q0U3QnhOYXZnQ0hs?=
 =?utf-8?B?bkNVci8rcVl6ZzM2TC9nbmtaM0pTSWRIMlQwWEkzWkg3YUV3eTJzcnpsV1Vl?=
 =?utf-8?B?MGh6VkQ0SnNCUnBhRVA0TGNpNlNpK29tTHRlV3k0T2ttMTZkRlg1WXZxNnAx?=
 =?utf-8?B?KzVseHlvVWZXY0N2TUZoQS9xeUZMVDl6SVdjNUVLdWpvVnJXSHZyUk1BUVpH?=
 =?utf-8?B?R0ZGSUNSZk01ZUNZQWVnVlUyQ3QrYmR5M25lbUg5NjJIN0NqVFIvR1ZyOVpL?=
 =?utf-8?B?MjEwNCtwRllUR3VyeDZsbFQvbGlqUzJVQVVzMlhrV1IrVUdzdkFlRW1VeHFv?=
 =?utf-8?B?aXVMdkdROW93cUV2NGtqOVVEMnRudmdKRUtCb0dPdGZVRWpJOC9WL2o0WjJv?=
 =?utf-8?B?eE8yN2kyVkZkdm82Z3ozVk14ZEZ1U1hHUzc1MnFBT1p6QVRFZnRiWUloTmVE?=
 =?utf-8?B?ZkRkeWgwWXRPd0JHYTZibzZzb0JnOVNIWFlia1ZFS0d3aGM3SXkwYkM3ZTdx?=
 =?utf-8?B?bTFiSGJOd3FHM21paFpzeWZ2UXY5TEU3amptQXNsZUo5VGp4ZVVBY1dxajZE?=
 =?utf-8?B?YlMwT0Y4bW9GOW81RjF3aHhhRFp1cGZ0b3ZNNFNUK0VIKzJ0VmZjWCsrMUkr?=
 =?utf-8?B?U0RmRDlqTnkveFNXekFNNEV2REFGUnFLWWtHNFQ0eXE1akY2VVcyS1g2Wkpq?=
 =?utf-8?B?Zm50R1l2QVZqWGRyUWRibmk0UjZUOTk5c0ZaOFR2YUFlNkg1TWJnWDAxSG9L?=
 =?utf-8?B?MHpmdmdMVjdhRDhnVFU0ajRvWG9JYmUyVXpOQ0llbHY0MDIwNVF0RFFKT3B5?=
 =?utf-8?B?OGdMTSs5VUk5VFpkaUhUcEx1VEVueHFYVUlYK2Voc3E0TE92K0hXVUlibncz?=
 =?utf-8?B?bWlHbWp4bFh2QWdaZ0NPZEpMMm5LMFFWUXBzcG4xZkdjNGxpdUQ0cHV1M25z?=
 =?utf-8?B?S3h6OUx1VGZjR0hEUEdaWFJndVdVZFJVdG55Z05DZ010TldQTXlxYW16S2Mz?=
 =?utf-8?B?VEVhTWlocVdDRzZ4cEp2Wm9VcTM0OUp6WGtZanZsYi83TXFBYWovTEprTjJq?=
 =?utf-8?B?VXhETjJ4Z0E1NjVtaG9oa3FSTVZaL3cxREpqU1VJa1d2eDZnZS9XczNlWjcw?=
 =?utf-8?B?blBiWEM3WEwxNS9hTVE0UGV0UmJSL3NQNExBNVJvRlZGcTc2d1RKaXZrSUNH?=
 =?utf-8?B?alhpdUdNckRJSENDdDVqQUFkRWNzdU5yYVJmMXc4cUlsVHBsemNoOGJWbkFU?=
 =?utf-8?B?NlpjQXVlQWVhWFI1K2xkWmh0OGlla0tncHVScCtRb0hEL1FOQ1plZmZ1emZ4?=
 =?utf-8?B?V0ZpN2R2bjJUa2RtYXlReWZ2UUZBR0I2T01VVFVKSGNTV1lRQ0JLeXJJUjZH?=
 =?utf-8?B?U1RNWHU2RXJqZGVZdnpTVVhEMktmenFqSHU4dnZDVkg3VW5YNjcvWVV0aWJ6?=
 =?utf-8?B?ekp4aHBGS0pHYnJIUnR2ZllxeGtYTFhMY0dSdFBmMGpkUlpVM0lENW5rcWJQ?=
 =?utf-8?B?U05HR0hQdWl5YVlVYm10OFRSK3JZV1RzMnlEWmxaK0FPYTE1NmVUQTE2MG5U?=
 =?utf-8?B?VUtqY1dVWkI4T0Jnam1XQkRWSi8raU91MGNZbkp2TW5URW1TNkJSQzV3VU54?=
 =?utf-8?B?aHNxMzNqVDJXSTcxRzB5OFl2OWdmeDVoZ01pRjcrYVE5bHVQeVNCK0Q0cEpi?=
 =?utf-8?Q?SPVTXtg2VlomA+wd2cjdEJ+mO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f89b59-7386-49f4-a9be-08daf7d84faf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 15:42:44.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLdi1pccP4JdR1SOkytM615vbKFoT+rzE72pRuygz6Wlba0uP1V/jVZxnuu9F7wl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 14, 2023 at 03:34:20PM +0800, Lu Baolu wrote:
> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
> Enable PASID only when ACS RR & UF enabled on upstream path") requires
> some ACS features being supported on device's upstream path when enabling
> PCI/PASID.
> 
> One alternative is ATS/PRI which lets the device resolve the PASID + addr
> pair before a memory request is made into a routeable TLB address through
> the translation agent. Those resolved addresses are then cached on the
> device instead of in the IOMMU TLB and the device always sets translated
> bit for PASID. One example of those devices are AMD graphic devices that
> always have ACS or ATS/PRI enabled together with PASID.
> 
> This adds a flag parameter in the pci_enable_pasid() helper, with which
> the device driver could opt-in the fact that device always sets the
> translated bit for PASID.
> 
> It also applies this opt-in for AMD graphic devices. Without this change,
> kernel boots to black screen on a system with below AMD graphic device:
> 
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>         [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>         (prog-if 00 [VGA controller])
> 	DeviceName: ATI EG BROADWAY
> 	Subsystem: Hewlett-Packard Company Device 8332
> 
> At present, it is a common practice to enable/disable PCI PASID in the
> iommu drivers. Considering that the device driver knows more about the
> specific device, we will follow up by moving pci_enable_pasid() into
> the specific device drivers.
> 
> Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
> Reported-and-tested-by: Matt Fagnani <matt.fagnani@bell.net>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
> Link: https://lore.kernel.org/r/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/pci-ats.h                     | 6 ++++--
>  drivers/iommu/amd/iommu.c                   | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  drivers/iommu/intel/iommu.c                 | 3 ++-
>  drivers/pci/ats.c                           | 8 ++++++--
>  5 files changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
