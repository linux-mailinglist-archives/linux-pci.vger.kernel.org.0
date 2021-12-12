Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2F471EC6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 00:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhLLX2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 18:28:05 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:25312
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhLLX2F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Dec 2021 18:28:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8TkPhBPTzRjTgno7mafcpSY3HGcch+XSmGbUCxrN+Fb6ijkvsWs8UkustpQbNna+QcTASjwGhq1q2JGz5jG4D9idSrEx2dcj18JAtgaQ+yIyJCvm0ZcTBP2xCBWcQB3tl6KrMiIIjbQfv9LX9dDbZ7GxcSKZa+AIoYFL/hOI0i4w95LAX9fD3tMQtGtykKTZF1uyB+YgwAOzOoG7YlRuqlpVoC5NCpubK4EhyrBHpR92UAGqqFfVyM5N+J63gNYYdr5NFJRncYngobV/pm2PT6lpIEMXOMVQIfUyTZma6N2aplpsxuuf9SkOYcfEWAPL4RXPo7UtaDUD5zW/NrXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeJJo1tbQoO6wky1sCAjsOVnxXWiJ+2cWKF9ndw66Ec=;
 b=kEnmHNCrrOqPKdfcwsjaXav4fhZn3cbquG34flwNDuEaOO3relWd2YhynUx3eDX8oqinqBDyQb7Ur79cF6E6Ai9bs5/U9KsBEvfeVuUHCHS3gVuG+PL1ZEiCcu2LEqB+QTzTFcJDmpfkIwubC+BsgGuGZoB/18/Jq/aU9kp9l2kHKnHlgFWNb9Aotg/yLY1lgYhmI/N8MhVwU9TbMxqihwltnML4L79XK7Fonc5pgvjklXzppJaEDk10vO4rbXV7Q2RZMhs4d/K8ls2LWcwzZJV6un2xWvtcaiKBIbmflVDQHpVYTk4t+f3uKQgeso6PRLZphVRaxUkZ9k5g/SKYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeJJo1tbQoO6wky1sCAjsOVnxXWiJ+2cWKF9ndw66Ec=;
 b=AZ8PQoEKo99j3VBcsS1HHKdilP3FNkWASKScKmdbwLsvGg0PhyXsJcv4+pRRknD5jbLDIGpNw4OIHfMSDj79T8AFABPJlT6pdsc+S6RvdU57dKcf4liqB0DjWDUzh1WVUhyFKG4MfCV0IDNsZhvLGwC5yGhv0F0j2C7I28cr6RV7XHq16mAi6gayGK2IaYWKtjWzVP+wnh6JwaDQkAQYoMljIZ+kYnbcSmWeELny545Rda78ijnWRW/B+h1Nhe471XREsKr9eie3JzWQLf+yyZfZWA1KWZ2CcwJNnMxZqsJpdxxofoqrbFEo9FGWwR3aKAGdqL5Zw5d8XbmA8vyrtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sun, 12 Dec
 2021 23:28:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 23:28:01 +0000
Date:   Sun, 12 Dec 2021 19:27:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211212232758.GL6385@nvidia.com>
References: <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16894ac3-9985-4889-e13a-08d9bdc709d8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55385843E582801961193810C2739@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNEOyrH5uPc6d0FYYVNRo36RDEOojF8VA9sT4SKq5SEDWuQcEmhj71LQqGt9qm5U9uU8/TzsktxQvpDq45729d5Dds/K7UaOOZZ1SQ8/SA+ilFL/71nNJCWuKGRZ2OFGOtcw4EmvR+98NzVJu+g2RFTn8IdyESvJUw28mHVlwaLLSjlv6d2Q2VymWe7tGoJjXZy1I5bP3NcXu7uGa/9rOGYM2+fnIn4/el3QDuB2+jNU11JHKpCBB9MmiLrzbNF8CJvshkbFvRLw1o+JbZYXTZf6ZaCpobyQ2D7tnJHAJ90w4y9lzInpfpBemUzors5M01DLehcKOyPr2KXeScHzOoF2R4SAhXz2mjrWQkoW3IeQRHoBBEQhzx4yse1cyG5sI7gjaHLMTNrkPZIPq3FsdelLXxdihmd+Ig0bHPDtC6qjtQ7deAU0Ef7liFibpxNuvU1EvbkN8F7zDpuyA6eXC8N6rKHvmiBDi3mHbF8RhOd3nDytNk4EGL7wjU4amrj+yl6IAf9TTpbcGtS/bAq24mixg+t8/iUc/Dmg8HNuuNq6nHW3nuDc0GJfAlSD9uf1Rft7/PQPMdWgkHh4yTBtJIcHzPR4u5fWb+rHn9vDen6UadztNogOy8QYAdMgNqRA4jJDgflrLqG7RLNJltAfzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(36756003)(316002)(4326008)(7416002)(5660300002)(54906003)(66946007)(8936002)(6666004)(66556008)(8676002)(1076003)(2906002)(66476007)(508600001)(33656002)(26005)(6486002)(38100700002)(83380400001)(186003)(6506007)(86362001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdoZzhEU054L2xYZ0VJSm82WjNhaXNjZTRINlhZUHVtTmhqYlFWSVUzNWps?=
 =?utf-8?B?bVczL3Q3V0Q1d2tzeG92WWpRWVBld3p1M210UkN6ejV2aFhlWXViL3krN2o3?=
 =?utf-8?B?RFFYOWlHZlY2Nk1kYllWbDRYWjdJZnhPSENxd1E5RXJXYzdWWFFPMkw3aWU1?=
 =?utf-8?B?bDhxSnZwWmE0YS9nSHd6R2ppaFU0b3JISk53M3ZoSEtkYkFJenhJY3IzQ1dr?=
 =?utf-8?B?VDJkNVQ5QmJjaWFWRng5QXBlQXdQc25xV1M5c3R6RkR2UmY0bFJINEtHVW1K?=
 =?utf-8?B?anBoaUQzWEVETGZXblYrR2t0aWk4VUpxMU54ajhWelNZcFNkWDJHdWwwUTlE?=
 =?utf-8?B?QVV5bWFzQzhsVkJIV2FFS3hBTVFkSWVOdC9WZ2NBRE1CREFham9CTmxZQ2li?=
 =?utf-8?B?aTdtZGJnMXU2WmVPLytzenZ6b1liYlJTbWpwcm1mZjhib1U2YzR5YUVtVC9U?=
 =?utf-8?B?clVybkV2WWpiaWRPUHYwRXpmd2M0YkZLUitYazVXT2xKZ1ZkdUdOdU9vQy9K?=
 =?utf-8?B?eU9mOTQwKzlkL01yYXFMWlVCalVzVXN2NVU1WWpkdG0wTGpZNDBGbjZzVTU4?=
 =?utf-8?B?Q0dRSnpNZFc3bVRUZW9Ndm9TeG84MHVKOWdqL1dma1hOT0txejRqbUhGVUtl?=
 =?utf-8?B?c2pValR3T1Z3bStSbGFjbW93aGxzcHE4aFdpZjBEaEdlTVV2R29jSmY0MEVK?=
 =?utf-8?B?emlpekJCTkpsQWpXb1BwaFlpM2hQeE5yZGN2NUh1OHFoLyt2djl5eGcrdUdq?=
 =?utf-8?B?cm1SN2RQNExadWxSRGlIbkhyNDZIZVhvdzhLUWMwYU52TUlkdUdKNXNkVGRz?=
 =?utf-8?B?Yis1ZTV2SUIweUNiK1BWVVlFbDhmZ21RZy9Wc010eE9sV1VTMnlBcUovMzBt?=
 =?utf-8?B?bEowVXowcFVoSmhsZFYrQ2ErNWplNWEybGJjRTVIbGVkcHZ2cFREQUw4RUw5?=
 =?utf-8?B?emVDcWpwZjRHaFkxOTV2d2t5U21BUm9PM0p2UU8vMzNtdUlTUGtGeVJFaTBU?=
 =?utf-8?B?OVQ3UVc3emN2aXBjbUNldHl2ejIzQkZUejBHTk9rMG5ReTk2WjV4UFZvL09s?=
 =?utf-8?B?WjVrSGsyUWQvenBNOUwxQXhuU3YySS8zalRRNGNJbGZxdEY5R3BILzl1NllB?=
 =?utf-8?B?MVhnSytDVXJJWUVUM1BJUXhUQzZDa2pOZkxxSSswR2tpYzVtRTY5QkRsbUVX?=
 =?utf-8?B?WHBERkx2Zk5HU3pMc2JzWUpVakptQzFrUVpPYmpQTHJKUm1uQlNsQjlqdnNj?=
 =?utf-8?B?Vk03eWNEeWJmbjFhc1FjVkZ1MlE0ZjFIQ09UcGlzTk50L1IxVnBzSDlUejFM?=
 =?utf-8?B?WVFjZDQwTUFGWGlucm9TYndpNURnVGVxcHg1UHhPSUJMbWxhSUJZQW9jM1dU?=
 =?utf-8?B?cmxCdm85NmQrSTBHc1pPS3l0VklWYXdlbldnbCtKOFl3bnlXMlE2NEFGamlR?=
 =?utf-8?B?ZWIyM0hJYlhpdXdia3R3alRoTWpUN3E4aHVDSCtvNE1VMVM0KzZjQmE0bEVu?=
 =?utf-8?B?Y3MzcVZmaWJWR2E0a0Y3OGtIQmJRUFc2RFh6RmNxVTB6bm83M3QwMUtsc2NO?=
 =?utf-8?B?YkFoZ01DTWhYZWorV0FiQ3VpZ3VkRXRlSHhmNE9FNndzUEllREhReFVKM3dS?=
 =?utf-8?B?S3Q2T2ZYVWlOa3ZLQ3NZekVmbXc2RkNyV2ZIQVVBRFBBdGluUDB1cGNQUTEr?=
 =?utf-8?B?WDZsMExFV3ZocHlYWDBMeExINkJhVlVjSEN5QzNReHNFNzVsMWpPNFBTNEQ0?=
 =?utf-8?B?ZzduN1plbzFtTm1Ncm5JbnZNUkpwb01jYTNoL2cvUUN6ZlBmYWVoZTBWS1gz?=
 =?utf-8?B?ZElXelNvZjRGUEQvNUpkNytDQnpyS2duQzA4MmJUZXdFUU1mclgvbDk0VEV3?=
 =?utf-8?B?TlhGZHUwTTFIU0Q0ekhXeEN3RVlmeHRFVWpsYkVMQTZORFZDVDIwandJU2ZX?=
 =?utf-8?B?SlEwQmtCajExWGxscHh0WWlwOTR5eHloMC9lWFUrNDJrTkh1MGh2S0RlcXVw?=
 =?utf-8?B?RWdHN2lnS05XbVNZcWFjOEN2VUpZR1pIMkJOZnhrVUhieWhZYlhHNFlpRDFR?=
 =?utf-8?B?THRtSlFCcUZORnZTZVNRQVo5a3d5WS9SZ2s4VFUvWUlCY2o2MkF2K3NTSEVj?=
 =?utf-8?Q?/cDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16894ac3-9985-4889-e13a-08d9bdc709d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 23:28:01.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ax/OJ08AZALj2IHd774FgQp1WEUTVa4YFbpoHYNNoRLiHeKPzk0Rijm+++xZYSNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 12, 2021 at 08:44:46AM +0200, Mika Penttilä wrote:

> > /*
> >   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> >   * which allows direct access to non-MSIX registers which happened to be within
> >   * the same system page.
> >   *
> >   * Even though the userspace gets direct access to the MSIX data, the existing
> >   * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
> >   */
> > #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE      3
> > 
> > IIRC this was introduced for PPC when a device has MSI-X in the same BAR as
> > other MMIO registers. Trapping MSI-X leads to performance downgrade on
> > accesses to adjacent registers. MSI-X can be mapped by userspace because
> > PPC already uses a hypercall mechanism for interrupt. Though unclear about
> > the detail it sounds a similar usage as proposed here.
> > 
> > Thanks
> > Kevin
>
> I see  VFIO_REGION_INFO_CAP_MSIX_MAPPABLE is always set so if msix table is
> in its own bar, qemu never traps/emulates the access. 

It is some backwards compat, the kernel always sets it to indicate a
new kernel, that doesn't mean qemu doesn't trap.

As the comment says, ""VFIO_DEVICE_SET_IRQS interface must still be
used for MSIX configuration"" so there is no way qemu can meet that
without either trapping the MSI page or using a special hypercall
(ppc)

Jason
