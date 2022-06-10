Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E9546B08
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiFJQuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349824AbiFJQtx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 12:49:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2E1DA68;
        Fri, 10 Jun 2022 09:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi0gV0WMKXJ+mWxe1eQKwkZwXjQYswU7qMo75G0gK2pDqt8OLYXTVEwkWDtqdgjBn8hEXpFmAUNs7EQqTG53NaLTBy2lE5Hr2zJWVb5hRBffD/yA408MJ42CKXsBwb2OZT2jA0BXrhC/LRHwztIegiyO38qFsYqyAA/hkt4seLI7DVR4kRTlece1MXZsaMb/SAsDacwx8iTn6EnKZkglDIKp0VIAIX0BycRK2T04EaV8pHR9UNXaL+3dfIQW/RBm6tgnTPFPSal2/66KTT6YKSBlE3jnuL0dHo1+jmYwzyh5fAp7vH4acXqmB/JRZTlQGCrtAGQKI6qCekwol3a6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2urPBMckfgu/37oA+LJcjDQ/LfROzjJYZ1YZAGI1v9c=;
 b=Ma+KPb9kUDgzboODjuw5jg/bCtpVH5D4YZgIRyWjdUnm3XjBePbnpOtEhj3KhjsNdMv2bNxoHRzNeQvrDTHJCdZm3BYcSLLOP/MEtjzcKg8NpVVas9PPexIuIrfDSmbEo3TKsqeqxRDjimcuUF3lh1ioMrhidK1wrS6jrFFfjTMGxM2BzSQ2gVLfgjkaqi8U+2Zm577/Hpe9eRxINlkcNSMTH5xaooYPY1ZEfUs4CE5w6UPC4bmo+WNgrL1c63Y6J4o/HWtuVrGQpQw9KvesVQrNKL94lR73gGXayWkUimKpIQi47A+9PujDGF6NnCK4ADijeaYCtc+SYwf/W0HNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2urPBMckfgu/37oA+LJcjDQ/LfROzjJYZ1YZAGI1v9c=;
 b=ciV1WsJ+bJ7SvvFRElcCDatiyfdKxFoyEJYGAWPkvP27R28M16lvd2q4soP2BdhusyPwFbqpSf91uVs4OOllEm8n4h8dX7eUrlJtefyP3QiOQ/wT6qV/baCwNwLncmiCTPA4UQvdsqXA2JHJWjLnIvGNCXF9b38LMa0k0qCNyfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 16:49:41 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 16:49:41 +0000
Date:   Fri, 10 Jun 2022 16:49:36 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, babu.moger@amd.com
Subject: Re: [PATCH v2 3/6] x86/amd_nb: Add Family 19h model 60h-6Fh IDs
Message-ID: <YqN2IMRbmn3s8ly3@yaz-fattaah>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602201137.1415-4-mario.limonciello@amd.com>
X-ClientProxiedBy: CH0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:610:11a::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f9efb4c-4692-4724-c59b-08da4b0136b4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB168422B6076DE2831DBB79DBF8A69@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvoT46aU2SiYfIzvu27yCwl7lJypgIvmRnlHSrXbUVMeyFY0JUXEFrrEK+eEaI/afKzvwwHVNJeMGw/Gy4PFCYOZS3YkYzRetrFwXpFId5jibvhLx4XtsaAPYqLqi2hXdje46WGn4qLCDOBV1T9PKll1e34gbkXC1LCpmz7IDjtfD4+FZbDRGUNxrZRhNtzDoPt32/FwqG48I6WbluKEA84grqE8qEdkQ7AKgcD3ADkroUwcAnRKvmHRnEz/W9rijoQFktktTfMHAWi8LS0qM+T2MApCzpOuuAtMc+ybv/4XqhT1ZpxsgNl16IMCdILVo/N/ziZDnSr6fW1Sjc9TwGYM0rtpYLz5JkwQw1+EuAXQQHPCVSkrJe2jyGPygLhGd3k6JAgITtedaTwecbSPH1wK9JiMjpzcUNWj6qIVEH07aWXo/RhkW6H2PlhhGmrtfY0wi5CwHe5Z6zd9+EILwu/TPAIzNeQEjHITq9IlYv34Z3avVX7GSsylC9t4w6BOh8XfLJYGbQFxivspMg+Zl9uqv/XU/nYwNMIsnqyyO89YFt+QJwS96O+OCWTf2/uX7NCrsJ8C5Ssvp29hInT49bF6/MpEs4kV3A2ChxSD0HfSKy19J2sPhX1eHJJea5ABxr7aOQfKev/fyYNBgI63Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6506007)(2906002)(6666004)(26005)(6512007)(9686003)(6486002)(508600001)(6862004)(4744005)(86362001)(186003)(7416002)(8936002)(38100700002)(5660300002)(54906003)(44832011)(316002)(6636002)(66476007)(4326008)(66946007)(33716001)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNFdCJ6g1c8COHh00BzvxQpIWA3HepUJxQlp9slQKxsKjxb7EqlzFaYQPEdr?=
 =?us-ascii?Q?q0kJXqSpw5mVLSAd9jqRc+ZFDgvxTC+gGO3djIvdySEiBAhxXKG2pK0cB3YV?=
 =?us-ascii?Q?zrrLVso3aS1dv3NMdRE06Ala2dsfr4lYIHYNPTIBVSyzlxvsM0/s/1rcUdEX?=
 =?us-ascii?Q?AsvWPSLhBFsbGdetbt5oT0IPgwlG0x0YGcwETHx63fyDiiGS2dzdNHJIbRoS?=
 =?us-ascii?Q?hyJTtG5m2D/1TE7ERLHRZRA9Khb5tM8NxBqgCNT48Z7MZzj9GrB2lllPuq+J?=
 =?us-ascii?Q?sHCEX1Tt6sOBcyN4Tx/WdSLMO/tWwYXSb/iDCopyqbzML1iFVv7QQMP6xSZk?=
 =?us-ascii?Q?zksLy/qODByHiKpZrk2k0SMj6EUn8WZmWI5Vp602qNO78HKPcVA+LrBND8zS?=
 =?us-ascii?Q?x1LIE7tQy/+fndllRn/pc7h1KWmMJS3NKAM2FiM6C9Kk+CbS63uE0QF4E4Yx?=
 =?us-ascii?Q?Gnr7VtyanOjHuQedLMTEBka/G8hcJ0M4iSCG9Re4H5/v98WlD2U9fx8x3DR4?=
 =?us-ascii?Q?lyDcCTKlBw2RSstTVWJGL8vZAU/iUb3D25dyXjFAC+KKxPgyWi8pqMttzHu3?=
 =?us-ascii?Q?/Cv8oeMTWm4o1eZlru0jarflN/WuJaQgoQgHPenaB4vZi1A37edSzcwjB0TE?=
 =?us-ascii?Q?gQyQwgRToxoraIo/kxX20b17iPlQgkCJxwwHSGiBwpqGkA+ht7ld8ZLYjw8B?=
 =?us-ascii?Q?oQOUH68IkaHQGHygFrf2hDHDs0O/a1wROVsJPC/LBTAu3eKcXUJV5CyPhqzy?=
 =?us-ascii?Q?R5DkR+mHSwPiMroNE6xhhdG+/airWRtzbNB2Z1Bpy+3uZPUsRQkiqRtWCoyi?=
 =?us-ascii?Q?HiG1grGKwXQhJxzzWN+joqcNdLk72a4vwuTfEfOMpMW6ismQ4UtYQHBXobA8?=
 =?us-ascii?Q?4DLRKvheLmTJEWhXj7gxuAoya5E3vDrg/LYfurFJXshPNvppwpXdUanh9Y/D?=
 =?us-ascii?Q?Ud/lv4GqQI0CgLNyb0UVNGkj0IpvPSYqca//JN74d/ZzuOmoyEeBxZyp6RuG?=
 =?us-ascii?Q?i+A2Oo3OAbCOENz0dYKDGvYnDhH2RL8NjpL8ePIAi9O0bXSfTZPuWYfg3SYM?=
 =?us-ascii?Q?yX79Ps5coB1POGAtU7hzbZLsoL0WXJqT1CrTTXxn2o+t+3PKTUbFdE++DgDD?=
 =?us-ascii?Q?zSeN/Gi8r061otuEcScpQlRSal87ycphdCUL8nvUBfZCWZGrsrMFjqm8m8Ui?=
 =?us-ascii?Q?ASkXBGEQujsRyzSk5tuUupS8rvO/1UvaTkmRCenR7Q51zoNs8wweAfwBXS6P?=
 =?us-ascii?Q?6/VMVnQmY+gATo0wusTOPe9aIJEqmxNx6ABYilXK0PUu0iR+WOHx9TpKPVgY?=
 =?us-ascii?Q?KQ52BJgKxCqSDoak64j1r8Apt7rKWHf8lPbNKx3ECJnQ7DA1rs8KfhLs9N/m?=
 =?us-ascii?Q?oLd1p5dkB2xgSWubnmb+XH6AQmtO7mfgbcUNS5mQJ76ilgA1Sgm2grDRVKhP?=
 =?us-ascii?Q?l4/VKKynUjW2ASupCFT1poNcROyGokkDbaP5WjcIxwHuvJM7neKRpcy9x69o?=
 =?us-ascii?Q?Vg6xdWFniaUf3Utfcz2/YLQgTjKkgDQCEjr1ccUvl7gRP5EXwohRvhWls2yU?=
 =?us-ascii?Q?cS8z8h7jBgKrdgBvw5JoIo87CNrjU8DQ8ZuPznKR50fBOG6JCz9JM/gJnQf9?=
 =?us-ascii?Q?WpV9Tt0xBTP/WbTOrEB7p/aMitCoss45T08beHWn5vBUGyqnKAQXFUDJ2uAD?=
 =?us-ascii?Q?U05vAC45N0cAXpYiMoadBZQTULprtooGAY5n//glnbhBhR+TKzzXS8Kmrf6V?=
 =?us-ascii?Q?3c589KBmJA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9efb4c-4692-4724-c59b-08da4b0136b4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:49:41.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f6Mbp5PqufB5pR2//tipSjGWYSitRLC0EUbL7OBmcURFzP5y41P06VdfW1tb63f0U9lNv3tbSeuUg3ER7R2OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 03:11:34PM -0500, Mario Limonciello wrote:
> Add support for SMN communication on Family 19h Model 60h.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c | 4 ++++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 15295f5d9aca..491669c24ffd 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -32,6 +32,8 @@
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
> +#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
>  #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
>  #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
>

Same here about grouping "ROOT" IDs. Otherwise, looks good.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
