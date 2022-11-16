Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5B62C909
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiKPThA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiKPTg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:36:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B2DCC;
        Wed, 16 Nov 2022 11:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKgXyrgL487Wh06Vdubx825/MHVfpqewnmAuD4IzEM+vFXRKIdEfCeXO7PzY9PnYnQP5QZGEsoUpyXXHhQKXJqq4vzPOcs4A6aLxyC9CxlpUWU3OS0L29Fjb2hFtSKh2/ZQy/wlZydSGdMLP3Uv6OqJWFnFmjXaMfaiVz7FVUZelf0JKz/I9nkMi0uFtlGveBKGRgw2nadZWTAdUwvfuvoxrwagSPjggmaCW8SqnxgLo1CH217SOOa1y80Bd4beqcZJPkDKYOd9Hffc+5dHElodGOuoPdMihRdDhGlUVawrSstSdvRUUMWGg99WtEvaZLbKgw1IMfeKO//rjqknbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RcMyDVDnpbDOMU8Pz2KvOoFMLOr/6U9lzCvG2PyCyE=;
 b=nVcvmia+nttrvnxDTVRlf7vo9nLIudvP2ToRtsw2TMeriQuGXeI9if2CuxzT8785OWTO4PRefXWHP7LGya2xgs1jPfMWzZdhb+fgwZOQXfFkR4foDT8owxS0iMIgyZ2kOahKM81LEX3YIGBJeBoXQiCvr6NjMQrlrG+nZnTxPHrqXMJ7fKNh2fsd4as9de67i+AAjkKxOK1h8dV7/e6hK3gXwNTcKAhj143YVpLvUm3FSeOBicSdcyLyNqQrNzERuX9rmLpXpsXwWvWCtvNg83N+QX6hkGnUEUlaXItWnJbdFkVN4ek8DYUmFr5TFzov0QcByqDt4k4BHaau8tdnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RcMyDVDnpbDOMU8Pz2KvOoFMLOr/6U9lzCvG2PyCyE=;
 b=UYY4jWh+dP1syJi+44cUaSBczeIJX7bssGq1GZ8RMS3my+7ZXIT5Fc0f6V8s/fzjHoGb6CRJQoAj6NyRXUVC2tN9HIMfeUmudVUpztu6Ni806s7vjOUHDKc/JJJOSDGTn4hiWL7yZKsaXC6H9nezQtINBIlHwbcrE0mkyNlci6icIh+THroKxc3T/9smu66MdAy4jZWypiYrfsPR7qmUqJuFqBtUVvPlrqjYextekn41iT4+mgQKL1A0GmWUSoVPlG51+PkPvt8NBNsSVsooBppFVRXCe+Y1uUE5g31XvA8/ayb0hMI0SnQ+EF9KnUwNfTEN6C6ZfuemQQZScXBoAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 19:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:36:51 +0000
Date:   Wed, 16 Nov 2022 15:36:50 -0400
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
Subject: Re: [patch 22/33] genirq/msi: Provide MSI_FLAG_MSIX_ALLOC_DYN
Message-ID: <Y3U70tdfYC+dFhts@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.521387616@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.521387616@linutronix.de>
X-ClientProxiedBy: YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a094f8-f5a3-4b5e-330f-08dac809e8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzhpo1dW2Va6Ydp/TLps3plAWcdeEe9lKCsLoh0NkZwiF4DpA+Ykk61yzOOq/OmIpSSBjbPhwF5u8Svxqr4PBrd0vpDzEZKRk8cbbQTbIKR7fUhEesOurNKR4+m3y1e2ixpq/4qSQwQNZ21vy84R0qYjF7wwotRR7m/UNhsjVQVvxhK/bjrcjhCiOrFAnhuUPaqnQjYgue2MCvSpSD3SwQUMzCnDoXXgyQSbFGQY1SdawAyxFyyyw6duEUQbz0BPtkyqpNnkEKuhvYq4NUuRlluQQ/iIkhDLCDWRLZDxd4zzX7xYDaFstTkUe3ISw0dF1FpVnzcnShF53YdKRJfDCpeHOJM2vKNMi8vMoPulZhPOzUVB7pjb4xK+Ey4tbE23ixhVnfgFNJTrv7t+g4tV0OA7ZE+Dkc7NiuZWymJOWalWa0zsD4P+FfAeaK1ClLIlI2VeaN083IrlTELwv2YrJFxo93zV2oMwOFttFOqCDw/GRVjrZ8YBhDeKE4UsAb0XFqv4Dp5nfeSAJj/kAOiyg+1/OZznUjAzEb3FHzv31SowG72MBS/mtmhme5VR5bpmtSI0m1Lw0C6D3bDGUY9v6Yhqd+pMPGO8gyBLBZazW6FR4/A4Sh7bDm1E2U26vajup2HCjz58Hg90oXWuFS9E6JHjPszEesPZ9JLfdx2xdASS13KYl9L2T9Y3+c+yyDLd6ocjF/+P+YfmSxoRm+l+DIZMYf5Xw2ir49yhT02RciDLiuBtuSxlvvmfGA+9gpyc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(5660300002)(26005)(2906002)(66556008)(66946007)(66476007)(8676002)(4326008)(6512007)(4744005)(7416002)(2616005)(8936002)(316002)(41300700001)(6506007)(36756003)(86362001)(83380400001)(38100700002)(478600001)(186003)(54906003)(6486002)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55mtJrgh0vwMQlGlJXN+Y6IcIS8U4A04YcNv8PUQFLxzfy2ALGofoP36Qm1y?=
 =?us-ascii?Q?Lv5wdlZdXvE7oQJex0MM8+nurtnGHaw9PcFsVWlid+TSxTf4121jcgzN2Hj1?=
 =?us-ascii?Q?xiORGp0rhki2KPCrGau6NlrgHl3dV4dQ5Lbunkj3J40CE5nZHLyWlqwnEEir?=
 =?us-ascii?Q?BQ3C/5yXHwC58FZjpBOBrS+ykli7GPblhMCJYdmNo4JlFSmLEV/mrmBGLNnN?=
 =?us-ascii?Q?K1E5Z1KrCNADI0UiFeV8qQivndG0aBdnsZWE7fhWZJOFZpgBeHKxCZA8H6E0?=
 =?us-ascii?Q?WEaq0rhHh7yG7379Wyowb2Zt+a9BqRRdHwpp//1OBOCUZH4hK0dFDf3tGJGW?=
 =?us-ascii?Q?Dp4BL/bhp0cse1/WmkVJYyjg0eaz5MKuBiyeKC0BKHauvbn5DV6Cgpw6X5Jc?=
 =?us-ascii?Q?QICiMGh6yWABz2MIFbP74HXBcyhSGqGY/AVZEvCc6/YYCd7xM4qAUorRwCxL?=
 =?us-ascii?Q?7DPVQkOa0qqoyK6pJDgdARX3JMMuPh33jNWumIsf3HpqRWYZ60gCIIr57YNd?=
 =?us-ascii?Q?4Yxvoho2rT2UhWZcVaLwfzY+PzdT0RrcfqbD+JDX8dvyzD78h83F8r3qMqcv?=
 =?us-ascii?Q?eaGumH0C4pafog/Icut8V22Ojo7q3FgP+Kx5/REQ0MxZp2QiN+Ksi15GOOUx?=
 =?us-ascii?Q?KOvuBdw4oKquWnX8mlUrUFZA8MtTZ+/kZbfEL1rVGEk3ywXYCpmkRjkEL1mL?=
 =?us-ascii?Q?ASiVkqnt9DBjYNJde7i7Stxf5XHWfIvrPg9I7n5ZseIVZ525VE/hLXHGKQVl?=
 =?us-ascii?Q?AYE5ZFM4bDZM9Fg5v87RtNC6t9QvVEbQex88eMx0BmoJC9uwPCOwKm5vgxA8?=
 =?us-ascii?Q?KOnzapD5GNj8ItFsvu3ajuQCreMwT0aeI860n5FTykaEF5qMbWTD0zaMDXwn?=
 =?us-ascii?Q?qvqVSIqe8QHPJdDlciNu3h1AXTxdiEpQDQxVSZh3A5Gv+qvZt2BLZTJs5kv+?=
 =?us-ascii?Q?0Ke34EBnXQAsEnNrcx20CkVPU5/GE6xlh3HAce/h17/PRFqx9kawd35E/xDR?=
 =?us-ascii?Q?l4fOI9kh6AJZ1Zt+mFEn51U7Q/CLeiqQBw+eXXxy7tznkRcLaQGD6DbOdkX/?=
 =?us-ascii?Q?dhVcTjViOTV2EQeiKYKJ6CyVU/NXHAzDE+zKHmLjAQnRKWJHpZCg8LYUSAkk?=
 =?us-ascii?Q?UHZhGlvA3BRWPqkv+x5VH2lsTNYBTXkrgBDB+dBpMG7wzA59AAgE6Bh7L4aJ?=
 =?us-ascii?Q?16oOw6HbyL2lH9o3P8+OXum2QgN5Zm/MICKn7YytQBIHxtIOcVUJiQfN0mMv?=
 =?us-ascii?Q?+ZagG/XjqxE8hcG4rAUZrNzXolIw1yWnntZ+tqZv+ILNfamr6TalYum4izOp?=
 =?us-ascii?Q?MFS9A2MVJEVQXjbcVVC+8bXNqjES1X8ORkxTCqOEPQXIXgDRBM+9H4153kpd?=
 =?us-ascii?Q?yyFw2lwBzwddzZt1Bd5H/1mmaNvwm+v806nCaRS0dTRqQDh9PbZFjHgldktt?=
 =?us-ascii?Q?j8MfDHF0U/8yzfXnKpohLI4JruD/4DQRBesip5s29Ul8Xh5+ZxeAK8Gbil/I?=
 =?us-ascii?Q?eId3tOajgkND0qEBXv9VUJzMRCIfTuVUzFN0UuS4CiHjHCnL0+tf6Np0Y2jW?=
 =?us-ascii?Q?/xtGuR4SswV0vz/O1A10C/Lr8TBpCl9D9gotWyHc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a094f8-f5a3-4b5e-330f-08dac809e8da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:36:51.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjh6IACIPMLpWSiT4xaGw5ZoG7xZqKk5RGN9WrlowifqULh9O7PSvBbvqan8N2Ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:46PM +0100, Thomas Gleixner wrote:
> Provide a new MSI feature flag in preparation for dynamic MSIX allocation
> after the initial MSI-X enable has been done.
> 
> This needs to be an explicit MSI interrupt domain feature because quite
> some implementations (both interrupt domains and legacy allocation mode)
> have clear expectations that the allocation code is only invoked when MSI-X
> is about to be enabled. They either talk to hypervisors or do some other
> work and are not prepared to be invoked on an already MSI-X enabled device.
> 
> This is also explicit MSI-X only because rewriting the size of the MSI
> entries is only possible when disabling MSI which in turn might cause lost
> interrupts on the device.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
