Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002C1546ABE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiFJQqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiFJQqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 12:46:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E883CEED0;
        Fri, 10 Jun 2022 09:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmcemmiB3/AFcWRsdXDvqmZDT4XgFao1sOf+Gm3nyNMIMVD9aEoI6e4m6qyLkciwEWi39GyLF7d27wzViCFp7dw1pnpgwKneRcO5teaDCVJqkGmVjn5Jao6ndPZEqd9JfRs0FbMHcXN+ChUFZ4J40Cy70NC2Js/2ZlECt/X/wvE4Y66OjDxrik9/g+WXGGpdDPkjMHeGQquNiJBGj8UwderI3Xz3TCDCJnRbcvN9ro3StNHwHaB2trESsa5RK1Bh/sr40qPYWcxb0YDFxSZJckhUzNviqO0I2oAGrn+R+hEJpxgk1sDnueiht3TGEHDhYZM3i+56J22dnikfpE5JYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7NCsAvoDyVeqCF9razdFlAvyiiL7zr73Cy49T7EEKg=;
 b=VzXrebODerFx2B91UrwCwgYqG9gff1dmw2JL7DxBZOZugcpWEbUMitnleXv7YtnrOoShnF8fdRpKOEfVfMXEvZx2nvwZ90vRFT1meYd2c0QnGeeZsM93Bz6PE3Z1RIRPalhI5moULjSmbu/S0SjDnzb9Q74RJVVbi11h2NEJeAK9DqRE0Pyf78mBS+K/zdOOBkFilTTPJDSyJpDk1pGE/cl1fj6vViTi1MhxS4IPv/t0CccXhOftQCrUUaXLjmczgx/f6YjitX8WMgxillcq6QHU1KOO0U3YF7GHu9e8lrW4VOnK5ILp3LnrALeyEDOBO8uHkAsbfIrqNF2SS3I4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7NCsAvoDyVeqCF9razdFlAvyiiL7zr73Cy49T7EEKg=;
 b=iJiVA8KoUNB1DiEMRVT7raU7iS23NAdVzNFgYG21zFzOOO3A9/pd2WmIaYeXxkJ+VufDGb18MfCAfXMtL6p0jJTzjoVh3ATXy1vKHeZ7Ms8JEmd7FO9YUlGUCT20CY5iZXOXM2dMilMvyzz5+aADQU8Dr+J0F+jQg8eLwN0qWbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 16:46:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 16:46:06 +0000
Date:   Fri, 10 Jun 2022 16:46:02 +0000
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
        Babu Moger <babu.moger@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/6] x86/amd_nb: Add Family 19h model 70h-7Fh IDs
Message-ID: <YqN1Skf2eBr093IZ@yaz-fattaah>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602201137.1415-3-mario.limonciello@amd.com>
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44160e53-d69a-46ff-1a85-08da4b00b66d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5170:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB517050482820DCC311DADA6BF8A69@CH0PR12MB5170.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aX+TIHmxwaCufJ2LTgEssCsPENV813o1okR194epzFLcUxjjQV/W8I3RElsPPMudstZYM2T9gVK5mEr07J9PqpEeauAZkmKXiTSYUpRwmykRZS8H2JhRdBeBl3+r8rDT5QAys+/BpmYKPzwOSf+WxR920patfjIGS8TBbSVCX2+8eZKaYfBEDXqzF2d1oDfXb9Xds3oNhys/fFQNWvSPuzX/UOspQoWdD86zImhdzECJIIQ2EVTG6rafBtEMO/BCuLbjZJhyoqhIHW9jCWqWrKJlmlZoJeU6qZ1r7IAzJnFNEvjkImJd2eGkaiEgayx8KC3SdxAo1UzJxyZqxbk0hNCmdRlprkE4gqUIQJ4u4kAOMqnWY/Y7cSFSwoBTRY7DDeYv7PtJ5q/W6lQT2yztflrqCMsezBuixTSJb8h7lBT25KP4ufdgpzGi2qC3UggodpHtbtxCToXW/eNnw0V/Ujd3+HpVeI1ZHoR/yCKQJ5eQO0xPkmuj4I3SHwbPiGy26JcIVxcUGBSktkY//9GV8iaFN8c2rJcWDRRyPubGO/eqXZN2wmUNP3mloYXKLvie6DeTD4fbJ8PzDwZ6Un2REoA6gYV1PVunxm/kqen4rUdRPQ3ZeL5OjIRTFlbV9HP3iuLaOKssBcE/b6S1R/Wnuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(316002)(6862004)(6636002)(66946007)(5660300002)(8936002)(7416002)(4744005)(66476007)(6506007)(2906002)(44832011)(6486002)(508600001)(54906003)(6666004)(33716001)(9686003)(6512007)(26005)(86362001)(66556008)(8676002)(4326008)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lo/dwV9o5DsPJ0EFlF3GjsSxdgeHquOerhIGQtIG9fhSwk/dDHLEVaEBvqQW?=
 =?us-ascii?Q?M4mW2mG96T3mNhzIO/yD70Z1eyqTWHJoZZq9Enhmbt4Wha/e0w/wrAm78NyB?=
 =?us-ascii?Q?e4A8DDUv1sRBADi6kJh873DH6lJesPTlNTpXOa1uGYJcgUS94jCZCBBX69tG?=
 =?us-ascii?Q?+tbPGLjVhFoElZmsBcQAKC8EEb6Mt2mpkJ5R4w9RAXl7h8dArvU7VCvMMHsR?=
 =?us-ascii?Q?9laDvz7fVC8tfiNpIHSAhow7yVEB1qyRwLb+ADQkftetOVEa6kK8l2pEzA4D?=
 =?us-ascii?Q?CAQTEDT4tuWNsRz7QCap9Xeyxp6CONprRvfL7ESi/n3morXa/GGVSr6altdX?=
 =?us-ascii?Q?U6r5KKh8/yw91e+vRWBQLAnkoUnzBvUiZkIfrrM8Ch96R0jMFVylW2nC46Ib?=
 =?us-ascii?Q?PbuR6iPsz8oJB6dMp/MrN+MHOTQRJSlWmCokI9X1tksfDqEJ4hUeS4U5vbp8?=
 =?us-ascii?Q?sTak7RmfmNZgXf0QN5iXvJYJRkHP0UCUVgDYGkYZOxiECBeKw7Q1vtScJcIy?=
 =?us-ascii?Q?E3p4cl7r4QPhpqQbL+lm6qvhTBvYRRP0ZGVNGRtqJpxpSGZA7ZHqLlpSrJnO?=
 =?us-ascii?Q?fkA4U09ZkYQFTSoq64bZEco8dVEtSzZp4v3K4MIZuMBc1ltSwMMOCtuB+s02?=
 =?us-ascii?Q?suX2eEhoL6saYfiMuoOYTRPGiz8Ov1FxD5za/MFUJZPJw/sRmpbJc46EKwdQ?=
 =?us-ascii?Q?PcMV8orezBWqoZRaooK03ws3iFE1rcVARsMR5IFuELnNmqpH9xK+bEcz63x4?=
 =?us-ascii?Q?ST85HS94kAvazHQvNkHKeCQVFAfqpOSRJfFFCCAS/nIuQGpXWFhYoqVHc4S3?=
 =?us-ascii?Q?oVHQuxlRin4TuD+7OwTz1CSS9QyOwMtEgkuVTVZz6wSxbG8EYDUAf3mTRLqX?=
 =?us-ascii?Q?TnP1zJ3o+CBPMdQMs9qJa3qyQ9aeIibKZ8jXepzPZb2pOjOLzzMUqYS2S1bT?=
 =?us-ascii?Q?Aq1YEkQ13gZONq/BPKuIsZ7Q9iG2e0NPH9BtTGpAY/CiR30Olg/uL1lgC5iI?=
 =?us-ascii?Q?LyRD2qru3L9RI4FLZgkLVA7v1g12BYrHPtWWAB6QuyRQ/h2mjGYZpu7gaFRn?=
 =?us-ascii?Q?sSPeYp4cMiqE+2/bjBL7V9iZCjdGVvGJl01pAgT1susofD1BOatsQs8RitYB?=
 =?us-ascii?Q?87++0f03k9a2DstLdQBh+RvFCzgjWthUitXxkVRGjfGcoSy4OLpgV+ApLTUD?=
 =?us-ascii?Q?IK7InD2NtvtS5VQVjMNoNRkhz1mJMsTn9BwcCktRAmVoTB5A6TLnCRvPDj1j?=
 =?us-ascii?Q?lNis0xZiYFnnyx5gT66I8uflrU4QhhZ6WamnBf4iaX5SmV9I2I2a6IZKhtYR?=
 =?us-ascii?Q?WbEiW131ONqlE9NkVMjJYld77j4q/gCLxwMxrvN7Ku1meN1NgI1YlDVhJne3?=
 =?us-ascii?Q?1b0RN3Wc1GFQl6qTqYF97JR+h3JFaqJ9d7MxyGkljH5xPMe2vy7oITT8Xedz?=
 =?us-ascii?Q?9919WXehBPxFYvTQu9yZVLd0jrH3xcMq8vplgyTUyw/nI5nblO65tP/BCkuA?=
 =?us-ascii?Q?mWh6USfkZY4podMXqamCno/+MwgE7O8Ecu/q/2HZpyRL5oRv+TVLHnW2D4an?=
 =?us-ascii?Q?5An7UuX60xJMkq8QdNK3zlpfuG1zN41WzZzXXC/1fUKtxEVi0yRF8tuxXzqn?=
 =?us-ascii?Q?oj9lkKYs1IGUEkx5yb4h7NSsxKTDYYpM7371u//jSEf/gGqDTs0f6zUWPxz5?=
 =?us-ascii?Q?A7ROXhLZm/LRk6+soB2LIQBySZV60wx5vb+GYaQrjJR32daoPtwA7zRRJoue?=
 =?us-ascii?Q?1HGkDTCV9A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44160e53-d69a-46ff-1a85-08da4b00b66d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:46:06.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBFwXPGclLO31WcSfa8gsznEGIgQf57SeE8XLH1x4+JB3Y4wutxIeRBnqVXwfO/zGnt1Aktts3PReKkdmhbJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 03:11:33PM -0500, Mario Limonciello wrote:
> Add support for SMN communication on Family 19h Model 70h.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c | 4 ++++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 60c7bd525237..15295f5d9aca 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -32,6 +32,8 @@
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
> +#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
>

The IDs are correct. But can you please group the "ROOT" IDs together
including PCI_DEVICE_ID_AMD_19H_M40H_ROOT? Otherwise, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
