Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715EC665D76
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbjAKOOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 09:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjAKOOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 09:14:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C507018E3D
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 06:14:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxcedfsJ5FS9+2vbN8RwtcspY1IxnKaeK3P58ULkPgfDE62U3akSnJtVWglbHLpottgr3dJgGbKpxQWLYrnEaAMHmvkWstj/sNXv1Rtq4OVMbV8AynKFLV9pumUdvcSOnCwMhj29kPfsOPbTSQntDggMTMwoqOM8BEl202uaFra9pIaGINcnsjWAhw4nVsZz8fqhVKTl5bz+6PNHqgFNBGcBtHaVmImtKDCWQFHDf+CaGPQaqdXI7AqggCw1OFZdWI0ZcgMWMt+Pg600VrCvXE501DyQG0af0JisV+TRggbtvTC/gq7TlifmIG/np9jBz1ZmpZLbLF0EipOJ0QADeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsPJ7Lyim13DW7ratv2V4/iD1wnaNiC+l+2ucJ88pqU=;
 b=BOilfq9+6MzohJaPiSpu4mqst0AeGRNRQCMePfn3KTof7+J7mZ9PO2z1oPVa6jWV8CYwi/H0gaVRma5tyP+9NehFnZ5SQhlzdYQIdICHZMFKkMUpIZsTcR2KVve9pEDNTvSRcAdhtPUWYypcCRgSFTJhDhVB//qxe6mLCZpg8uLCmf0IOkQ1VACVdV+gUsGW/GyfzIb3rx1tIkq1zbMPERksj/hddHJpdFWTbNwclj6PKg3d7PPp6nG9id8M1Xd94tt6+fFnoShPDJweygzWYleMI7Lzevss481+gXFbxlPhfYzFFcpO+Eji6K68XPs02rSMaiw4QVcy1hgO5D1XDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsPJ7Lyim13DW7ratv2V4/iD1wnaNiC+l+2ucJ88pqU=;
 b=bLhygpeQc42CtXK68Kn+ZkE5v1g3RJUa/BEK7vz/Qw3xu7Qd07lndbcQuwGjSFOgNAO+/B5onE9yr2+DO4stYLg2+F72R7PJdS87j5XDGKXTbcQRZeBF68bKOuwlM2wC6HR9Bzo1xvSZX9t6/grEQIi4TqDIcq59Eufn8cFmla/FpQUZxMR6uhnh9oYtJJ2t7+jbugCalwBRkBP9+jHZye2BrViWaRAmduOOTYnO8KJOOJvyLkYYEcj7CrfPG1ny0dX6C+J6bF07lzCQk3Z+HbEQAYaSuwZHB8VVuCD+LVapWd6gfVBqnSLSGfSR57Fo3Q2PbD3egJRJ6hZdD18ctg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 14:14:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 14:14:37 +0000
Date:   Wed, 11 Jan 2023 10:14:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Message-ID: <Y77ETB282pVL9/x6@nvidia.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com>
 <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
 <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
X-ClientProxiedBy: MN2PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:160::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adda383-3625-408e-f891-08daf3de2bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Evw2LX9ftaMb6/0qABDb6/f9a21eltlRz2erBlH28fj41dCISVDW9ct29fjPhaikJZ3TmMaW26VgiJnlxvgBlKaEcjFIiL2fAu5nLm+OKS/YcSZljXG6m0p9NqTqM3AxqoDXEM46lrSRM+BepF4JDkzMp2qUg6pEgE8vMoxRQhcDkxy5G+KsyqMdGVTQE4J9FNj1NkwlAwe+MUyTi6e8xD3vVFZinYF77mOtElmqX/pXVjuA8X7pd8A42aGKbu/x8nmQyHc02zGv9nQBTgsci9qm8KtTFNqVcL7JxD2XjD9uLhAdcoEe9Z0HfOs/GFxDWYXN4gP6APkSHqojbPZvR/0wLC6dmgvWbt3kc3eVUYPl3pCXT7jrJihM8b6AIVwhG807863Sw2uJ/KW8DTGvbRi6X5dJp8Q44fe3bv8EAVu3O5Wi3gDPOqojmzHVtrgIMNPoNKyADPwcELI0wcwjxn1idO0ynsQPqtO7vDxxkeaUia4KJ7Ojro2542A9uqIAlAP728l3zpNogDdWz3/0EpADhLss80C4DVu8R71FGEsVJi0xQWkYfz2TdBHNNzqZV8WCm34ScvM4QmE39YPWh/t2XTaUpKdplL1zImqvKE+wtky+jmHX4VI1HTvrikS4alnruFznveQ58ZtlmEJ0xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(8676002)(66946007)(41300700001)(2906002)(8936002)(5660300002)(36756003)(4744005)(6916009)(66476007)(316002)(6512007)(66556008)(54906003)(478600001)(6486002)(53546011)(6506007)(4326008)(26005)(186003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FBVUg3aVNHVzhIMVdQVW1wQlgzS1NLZmlOMWhjRzZMN2wyUzNHWFFvS3FV?=
 =?utf-8?B?VmluQzV0aWxCb1l2VFNIdFROdDFqODk1eXRlS3c2ZkVGSTg1cm5lQnQ4dlJq?=
 =?utf-8?B?M3QwZVVxazI5TnUxS2pGMHhSU2Z2bUxTMHJSbXNaQkpzU05GSWpwNlgrY2tz?=
 =?utf-8?B?ZmhWMmM4bUQ5VjBSVzFNTmE1Q3NJRkorelJiZGlmOVpKbXRwT25UNmw3R2xX?=
 =?utf-8?B?QTkzcUU1b0Q3ejZjcFRIbHVHMDBpMHNaeEhpbXhDblNnZk1KdXZ1cHpGU21Z?=
 =?utf-8?B?N0FBblNkcklwTUx5OEs2Rk43OTBjWnJYRjFVSll6cWprcHRUQ3R1emJUdUpq?=
 =?utf-8?B?eE1nOU9vSGwrdjh4YzRJRTgzYS8vOUQ2dW1qWjhUc3grbkNnZSt3R0RvdnBW?=
 =?utf-8?B?dG1icFVRNUJxQWRoMDJSY1hQMHB5K2NaUDFqS1dlWGoxd2dsWnJzU0VhdUdU?=
 =?utf-8?B?V3JLdXJRSTdZRmlEMFJyL1E2QzAwZmZ1SzZoMGR5aEsrS1VWT2IwWFJtMyta?=
 =?utf-8?B?RXJ6QmNMOGFzVWFUUThNTy9vQk0xQTFNSlhiYTl6cHJOLzRtWTdwL3AyMGR2?=
 =?utf-8?B?ekxBTVlPdW15NTdlOU5EZnNhS2dycWtISGNYVTh0UEYvcjRISFVTRm80ODJv?=
 =?utf-8?B?ZUczNUJ5dHZkam5sbXpsV1dCN3NtZ1pJTDZpbHlmNCtJSHJBM0FlT3BQYWtw?=
 =?utf-8?B?dFpuYm1zWThEK3pUK1NCdlE3L1VjOE9FcU4vd2JMREs1cEszV0hxUzVaZk1F?=
 =?utf-8?B?L2RZajdlblRFWVNvQTM5NENPZkNQek5zUUNlNVN1eUR3ZDRUUXRDYjBOajln?=
 =?utf-8?B?bkQxZFR4ajJFR1ZrVWZLS2M1bSt2UTRWUGtHcHZwZVNmOTVQVzl1Z1JzQVZT?=
 =?utf-8?B?WnQ2blB2WU9Gb0FYckM0MTdGdEpRZ0hZeGNDS2h4OFBqemd6cXVRcU5ib1JJ?=
 =?utf-8?B?Z01JNjNkVlJXdEdJdStvL1Z3QUoxa1h1VVFRdFYvYTFDRDVLTHdrUDFhcE9J?=
 =?utf-8?B?OGpDdWhzc0JjSjFSc3VsWk04T0h0ZFB5SEh2QTlXRGJSSmZOa1M1NGlOVVND?=
 =?utf-8?B?SWxyTWtBRzNRUEl6WXl6d2tYa1hYczZvUnc0VzkwZGx0MVBqb05JMityNy9i?=
 =?utf-8?B?cTdES21DTmJYZXY4THBkenVPcXVOSmhLdFhibDk5Y1doTHZKVHdTTUxZV1Vq?=
 =?utf-8?B?VjRoTWJzdEhlMm1FSHluakZUQWtySmZ1N29hQy9DbERPMzVWZnNpMFNqbWVE?=
 =?utf-8?B?cDcvRURlVVFPRjJ6d21qZk1ZMHZ1eG9uNjVWVnhMWVBZbHN2c2xqcXRzd3RP?=
 =?utf-8?B?V1orbytSam1qWThsRnZIOThOSXJyU3E5UUpFZXhER0p2TmlldkozeE1tM3Jm?=
 =?utf-8?B?SXFZZHFVTHhocnhoNm9DakdoQk1tZ2pPZEhaMmVsT2hrT1JDTGd0ZUF2cUhL?=
 =?utf-8?B?aWYwcEVpN2RFTWx2cExrSGF6R1FnOGdrNHNjSWFXcjRGWWNMMTluUVpVR2wr?=
 =?utf-8?B?TVpPSHZYeGdRbzlNcy9ocmJxUzZnZHlNY2JCeU91d1BUM2M2RzBQVnhrRC9C?=
 =?utf-8?B?UUFucFRzVTVGTkxsazFxOGRxdElSUmRBU1Nwaml5eVkvU0toQjVlVk5GanBP?=
 =?utf-8?B?bnpIZk1pa2VOQzZGL0d3eXNKalZDQnRHVWVxc3QxMkN3RFEvOVBMQWlLa2xt?=
 =?utf-8?B?RUtBZVVwdndWUEx5a1pnTkJOQkZlQ0lweUZSU1VVcWdoR2t3ZGpmNCtpblFS?=
 =?utf-8?B?K201dkNtZS8vNUYxb2RkeU52NTBFMTE1Qmt4dGFEVEJLSmdDeU01V3N5SnMr?=
 =?utf-8?B?M01EeTR0RWduUlBFbXlITEFxQzdBNDE1U2dmK2IyNy9HVC9UanZVMGpvL1VR?=
 =?utf-8?B?eGpYcm4rWEdjb1NNUXJtUDRhSS9CVmliSkhNYm02SzVlL2Z0Mmt1dzZVc0ox?=
 =?utf-8?B?RExReGxPZU0ya1hka3hDb1N4aWp3WE5qT3VsSkhBYXN1STZoay84bnp6R1VT?=
 =?utf-8?B?WWw1QW1MWkdFNkJGeWw3MWZRd1BHSXRqdlZRbGZXWDlQQ282aDlkMllPa2xM?=
 =?utf-8?B?SXBOZkVCTk5yL0JoT1FpdklaaU9LNHU1Z2VpcEk1VnE3OXdpeHorcGlQN0tq?=
 =?utf-8?Q?IbGJKCIs6EuZB/JNKT4uaXANu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adda383-3625-408e-f891-08daf3de2bf5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:14:37.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p47qZe/RsV8TmdXAV3En9sNzH2gFPkAC9x+PbHJGSom7onyfXEuf6Jk3CDcheXvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 09:54:03PM +0800, Baolu Lu wrote:
> On 2023/1/11 21:44, Jason Gunthorpe wrote:
> > > iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
> > > handling for ATS, so here we could check the info->ats_supported flag if ACS
> > > needs to be checked or not.
> > *groan*  this is seems wrong 🙁 Lu why are we doing this inside iommu
> > drivers instead of in the device drivers to declare they want to use
> > PASID?
> 
> Currently it's common to enable pasid in the IOMMU drivers, but device
> driver has more knowledge of the device, hence it makes more sense to
> move pci_enable_pasid() to the device driver.

So, lets fix it that way.

Add the flag to the pci_enable_pasid(), set the flag in the AMD
IOMMU's special AMD GPU only path assuming the device will always use
ATS

Do not set the flag in the other iommu drivers

Baolu will send a series to move the pasid enabling from the common
path to the drivers

Jason
