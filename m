Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED53F69896C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 01:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBPAoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 19:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPAoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 19:44:08 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3C42DEF;
        Wed, 15 Feb 2023 16:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFVkptLrgmR3vMzyetOYCmOQcJSMh/AGaDJJMi01g7tB8YpFcMQHez9aGDpfbFuo5T44/bLPMv5V8UG7EXJZnwRZ/FnsbeMHZYd6iLa2FQUK5NhCIcAWR8mwn+3Z7sU+w/3zo29/00TFo66/p6fTu/OrOTL3Ygkg8ILOMotEP7MUff6XdzxwmRJbH4wLfA3mjXbDyPpiMukoHW0ilrHd6sMsUlUzeCP9XIStTPAWGgXyNy+ig+5EctkoxRMALKoc6R4cLmVjrdFYbYGbKaSyODFs2hqJmPNqlH4E9bOhaIpiHGPI3HBl3iZaRkSA23PRsxP7yf0ccGAtAVagLu/NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1WiwM08iaH6dS3vN/wNueHYTM1QC3KCjdTzEEAZPAY=;
 b=Bb/JU7VnqiAdTByvWTj1FKrVqIteYPpcGJvAt0vm/L4qVPwGmhZ77Ef0wQHgS88OBS+jd3ixoc6uQnkHbD+bxvRuuz898nS6geyl4Hf39rpDNpguQJ3cdmMxWotD3tCESNVirlTi+d1wG4006hwxNv3AQAY93usUmjLpWx1knm2vomxPUrZzuoxhdJF7h9kjwTJxSqkmYLcAGvk/WGfqfDoCD/NWsd2uKJz9ln5JnmWhpzzvsgEItAxuyK6qShIl7/aPe42PmqgTWJNDUbVtEqNYL81dcZ7ZeAECk7in0n21o1VOWUMJ07QbZqQ+jkMpFtUBdD8QMQViw6CAmU82/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1WiwM08iaH6dS3vN/wNueHYTM1QC3KCjdTzEEAZPAY=;
 b=d0qPxm3EGETL6hbQbVm4OjE4a6VRg/lbZv/z02TIXQfVN/DlBZRFKNlgyEduYUCD8sL6asPidm9EekbBg/Zprodf6hE/xNcrHjVIW1kfJ8FO/30vL8z4UHS8H98646B/3O1OkUwGhH3apGPJWCyto9isL2WTjHiVAkWBcbHLLuLFX+KHjYMBfj6pEfMH3ihrwElRprGcvxVW6BQjAJs99r9zv6qmPHNsnIBZbrK8g3331CJI5oGF1s671sdP09gzJwR37Ok+XeNGQNO6tk0zBkno1sirO6e+35MFnCQd+JcctrpsGIOIjcWadt9F3qbdoK6J1qQDhHqrw7uXHcWAIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 00:44:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 00:44:04 +0000
Date:   Wed, 15 Feb 2023 20:44:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [regression, bisected, =?utf-8?Q?pci?=
 =?utf-8?Q?=2Fiommu=5D_Bug=C2=A0216865_-_Black_screen_whe?= =?utf-8?Q?n?=
 amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y+18UuVTKIshk8EF@nvidia.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 323a7478-d51e-4ef8-e55a-08db0fb6e734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5lxuPqWp3/Hht4qsgHWsfHTNhjT6Aac7/DqubMwuEl8rfGUU+R5KOCz5l37PecsBAH7pAX9U54/FO7cuTIQ22gtVWb1330Ctrukrp3/bNoSoyVUe/+9oFlXMWDWg+s1evZWyerKZjOdFFKda926hmU2Hz7lEgkoD9BD8XSd5ZEAE5061EseeUdwleG1afq2F3PBasXVPMUdjnbrqOueZ1PwQf665D/qDAVx5giCvEwDTAp0oVlboSXEM6jz07+J2yaoyJYFwh0jA5YObfeGxmxs+buVH+tdB6a47/htCy3skpkQaqlSsv9D2KiDcopzybyyb7v+g+sjuxsEonMG9iPbXsvoaJtlhiF4aDaqyVAGmSUcUdIdDBWwpcLpqFBxuf3llCmeMuv+oeZDr8S078R/HBILxdgVrM6ydQkzU8HZW0zDG1BdL2heqqAMQxkM6vsc7eZRK7diYQC+RqWDCsIev40SB2qL3S5W4sqVpjDGxyTlLuExP3EbHvpQqixnLEjLFeRW29yl3+st4cmb3nCEdiEJL12V6BuUTFjvISw1ybIYGd/yhEY9mjrPyJWrsvFo4e9akWHvOlHULfHcRITNIuKxSQT+Ynod2mjuBnCB5+2eOZtjeo7xdPN7xfGFqAOZxJoIYuxS7GNmVYE2az6cY82U3jyFFzjs6Tx2KnNjUCs1+e4ELhkki2yp7zb2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(86362001)(38100700002)(36756003)(6486002)(478600001)(6512007)(6506007)(186003)(2616005)(26005)(41300700001)(66556008)(2906002)(66946007)(6916009)(4326008)(66476007)(5660300002)(7416002)(8936002)(54906003)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGNQIPMdQ4xrC9eMhoRn4fQTXVQs2scvff20VfVeX++6CV9wFe/fRRar9IB5?=
 =?us-ascii?Q?UcDTBCk6M85/BxRqiBSil96vRNsYXbdC6eZ9Z6RbGQ5zxjIjbBDguur0rByN?=
 =?us-ascii?Q?6BukQU5b4tlty4iEMNIgGOk7hXj42C6BdW/gdEJSGQ0BiN7n05ZO/FfD7kwv?=
 =?us-ascii?Q?9UMyfl3oONDAs6p/34y2CMeMJIbJ95f4MFLajxQDgUH2+3uxlg/TKspd4UuR?=
 =?us-ascii?Q?TRuHJz856Qqf8A5T+MNAFFtSaNar0JnJI8q1I5TgMkAzYLTih/F2raV/Tz2k?=
 =?us-ascii?Q?nbYjg8eZkc+2cpCSZZKHj3SBvPzrDC5Wypxjg2y+3soXlGJ9q9y/Su+bk30G?=
 =?us-ascii?Q?FgSCk9bQolQR3gb0PoOonRwpao0uJA3A8E3WOIxgR3uJLhA6G3c5xMKWTm7X?=
 =?us-ascii?Q?CkEC2/7EtbL1dUjVqRrVVINNiCF0PcUnYtWeat8Ju3V+50XR0CTqTdpCwVQA?=
 =?us-ascii?Q?I/fBT95NVNM+A70Szqra5PiLGw6B2zYjIafjMpe2uLrP/QN4a7uaV3SYHNPo?=
 =?us-ascii?Q?PEzqpQiMjQKDhBofVtSEuKvSw0nxMYOtg3v6FlGW1GjiIyyYXxHRC1E6xwIh?=
 =?us-ascii?Q?9p+kpa+QSmreGRBeemQTuvJ3eEjf/5NfbJfDrA4eA/OqmpnY+0y0OhbVFddX?=
 =?us-ascii?Q?nlF4xBsvjGO0OWpNFM8Nd2jCZ1qjavYF3a/xzSWKVbrgleNnd3FqbdU4Ygl4?=
 =?us-ascii?Q?w6eHIQsXi0M09UTPtQ4lU/X9UdfTV35Q0WeVqDWKvVwDX+e6ywksNzgWbOFJ?=
 =?us-ascii?Q?K1Tm+kOLlS68hgG491htgE+nAoA49QnZNsvAxGxg7WjSSz2eGfQKIhchcf6N?=
 =?us-ascii?Q?JYxtjYdPbkVYDVH6RXKrleIHPhNcY+uiHrNQ+xW/Lw1eGygIxDQIwXbTtBXM?=
 =?us-ascii?Q?97hINWxxSl6VS6InTruyvegTX6eU7Z1dPhMVItHGF7PYUuzltzI6wDzM+2z6?=
 =?us-ascii?Q?yofzumzrZNtasaSCE//0XCI2UI/PAx0FK0GVli1rx1MViSXoj1Mz1GDLhQdi?=
 =?us-ascii?Q?KixIK/nTTHoUBHV0EouDFWQ+Jer2F034vEfaBm0+8Ml45eCBOynt1G7ptXFS?=
 =?us-ascii?Q?ihCEgcP42ZqBDObFpOgl12WqRcED579xgzxx88SelB7BLfvKf/OsJFCuhX7p?=
 =?us-ascii?Q?Oa54NeEDQn6GJTkSxyRrb/M2ai9PCGWZdiNxQSZ/y4oY19M7n2FKtJLAYECE?=
 =?us-ascii?Q?oR5AZNLQR6Hs2KYAg6JKNF002h7AIG8PDVFm2U7FZJKxgWJaJOK2ZS0bTRpA?=
 =?us-ascii?Q?rjsL3Zt/o+t6WJg4zonn/Tsi+ffrz+L8X3BHYfULdVnChDTYKagJmmzD6xAV?=
 =?us-ascii?Q?+hfS6+Dr+yMuhU4hO0d8sQ2xi80wn/tP3uoAzrExHh9L8jXinz3CZG88oqaB?=
 =?us-ascii?Q?MazEx03AcvA1G+p+0OCX+uysT904hNuPgiL32DhBZE9Zyl93fpz4Sq7M7EeL?=
 =?us-ascii?Q?/CbEyMkw6bzSKIbME8N/RU9L3Wosn1H7f6T7vfgGLx+AijenhBOy1+Q8Ezca?=
 =?us-ascii?Q?2Ebrtpz6BYvv95/oR0Wg+OAMLzMJ+NYDEbOXsPMps1gE4TXLyjwnulaSZiwG?=
 =?us-ascii?Q?TXI9jsXHwsPbYr+87IWq7KO2e9hyaJmJkQ4goMr3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323a7478-d51e-4ef8-e55a-08db0fb6e734
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 00:44:04.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwp6GwrEFp/UGyIjsZAddWnILK412xjX455mU5IilZyB0hEsJ132zaQJGsA9I7fY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 07:35:45PM -0500, Felix Kuehling wrote:
> 
> If I understand this correctly, the HW or the BIOS is doing something wrong
> about reporting ACS. I don't know what the GPU driver can do other than add
> some quirk to stop using AMD IOMMUv2 on this HW/BIOS.

How about this:

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 864e4ffb6aa94e..cc027ce9a6e86f 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -732,6 +732,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
 
 int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 	struct device_state *dev_state;
 	struct iommu_group *group;
 	unsigned long flags;
@@ -740,6 +741,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	might_sleep();
 
+	if (!dev_data->ats.enabled)
+		return -EINVAL;
+
 	/*
 	 * When memory encryption is active the device is likely not in a
 	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
