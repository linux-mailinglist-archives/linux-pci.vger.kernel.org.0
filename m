Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84C636651
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiKWQ6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 11:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiKWQ6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 11:58:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB811C13A;
        Wed, 23 Nov 2022 08:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGMNgffqMz4bTi5SpWDG2unQixutApLXaWwGk0EacE9S2yzV/3ve3cofdUfs7xfsrl3XgbF6JgdVWJTs/3JnJoWxWnz2EkCCb/9hcAZhICZzi6RV51nbaogOKob3U2kxCPlKbOfRce2EcOaDcXjcoR32EOenRoerdHtyofo7geDeXAL0/6hqoHDevPkHKU7+jhjzTzncI3Dv0nemQX8Bp2ame10ZasFm23nhdCcH4a3rQ5hv5hbhB3UXjCQ5SpSQiS00W74Li57bNk24siI6gfjBnPZaI9A24oMHPdjJxv2s5ixthxqKA/enp4s1J8zNz6w6B587jN3+0oOoKK5Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQcl8QAJu3P8GiFGKyNLJ2jPtqiz+9EGgjJHlzGIiX0=;
 b=fyhYRVNHTs7vVFRM8Yy2AOZEiu1Z5M/5EdpS4MKMbF4arRSeypJF6fHYe997OaSVxfB8z0T2j/z4WM2piPGuhBiM15a/vuBrmWttLCLuhEXAjFnS9Ic8R3Q6nNgpPssCQWWLrbryFoQRjZmW5d0dFhZJyolb9ApmYCzd8qLgHRJiV6+ydHtuk+d8ZAvWPREwCmqIgGb8w4kTyNAvTmpk2SM1Eon8nHhbZT5/MlluuSCIBmN7IbSerxnFZ55KnmmfbdLxxObNjpUHy454+vRc8/2R4TNm490jjHoXUmzDsAgrm6qwvJGoJfWoxq+h59Z/TojLjQF1o7pGmuTRgSyYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQcl8QAJu3P8GiFGKyNLJ2jPtqiz+9EGgjJHlzGIiX0=;
 b=lDDYZi9kXMYxqAF2Z/kjsRrPwYzSQFyjRpb3ECSEIY6AsPzXqHq36AlghkQfVPRyeSZBl4S0lFxMSmol77sxlRvSccuwDpKAa6Ksq3kynuZhnOiWFqV+rle8Kq6M54lo4sBnDrQVARzIPYiie/LeAL0kBaYLISRCC3xFurBxLMLSySLz+LwQdjjEGGZ24hFhxiVTTgqcrxSKK95XWXTG7pNwqIfamT94Pn29JKCzAmVg+AQZfAyuxJHcWK4QxD7ikUhQSpFcI//wHpd6ujCenZg/r8cXi61Vwa78SZGSDPAeLHfIV7bO7TvGNgqxFUJu5gqY3lzljMuauSPSO816nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 16:58:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 16:58:24 +0000
Date:   Wed, 23 Nov 2022 12:58:23 -0400
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
Message-ID: <Y35RLzzvXYRisIBX@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de>
 <Y3U5xwujkZvI0TEN@nvidia.com>
 <871qpzkj9k.ffs@tglx>
 <Y3uzVJ/7ecL8DBK7@nvidia.com>
 <87bkp0hzai.ffs@tglx>
 <Y3wreJlD/7TsMCme@nvidia.com>
 <87k03mg1fc.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k03mg1fc.ffs@tglx>
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0308d057-3d0a-49dd-f4b9-08dacd73eeff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VC+89eISBy5HfTvpXaKNXZ7+Segy3YTf9zTKMhrgS8Pl5uqMRLNudw9EAqgcyL3q682+fycB0nsS5TucdBOy3S5dUwphsptsnQgdULzOYZXTjCisey0jLDI6JFpz76A4J00G2Bp0ppRJbvt3+3MCyQhVqDV/LhK1Mwt3i3eC11UxfNulS6xoaY2SZrF2PPQEhQ5r+QeHlMOvusHulL/dYJ11R8X4O3NH41aufH6o7ztqKsou8DajBVXOcYUsvgsqgcC0THRcJ3IC3QC/05bQZdrFnZMWijBpEffIULkbt/EjeJ64Wu0dnZELT4+98RWZz7JxpcNuoPw5qnsvecDIEvT3vCyZI/QQCf6IXcWnFEZVxWZOpgJPLHr3FF0bDUwcnVjJGI9mXtYy46G/g+KbL82s2W17ZMh4kQJRpCR5kwMra+4lTRD2mT0Iis1u3/ERvnLGOxiVQODWpqGjpc6E2Mg3b+Ff6TehkEZMHx4PuosO0fgbUza1x3ijjKNrlXPBfo5O+8g0LRS8OZc6KCT0AQQj7V0Px+F2ch5zBNE/JB5BpOuxo09TurBkafGiexfysR/j9+eWdvfMek0+p0K7Rt3gTba77iNSicTLPqG8+m++OgdVZA42JXkMC6plb1CY3E5VaYhXpx7KEwOPvcK3Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(38100700002)(86362001)(8676002)(41300700001)(6486002)(8936002)(2906002)(4744005)(4326008)(5660300002)(66556008)(66476007)(316002)(26005)(6512007)(6506007)(2616005)(6916009)(66946007)(54906003)(478600001)(186003)(7416002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lHQDV6acKWNFdc/wkHel1UFO48eZT9CLlO4GvV+XlAGXvOc0EZT/CUafbIvS?=
 =?us-ascii?Q?xgYsM1C0vZZnZn7eVL62JypVHmotoBSuc4KR5G3rNiF0GGnURSQtB9EvQbp8?=
 =?us-ascii?Q?Q1aisO8pvmk60lu6msEhYqK3Qi3SrpQ5b8uEHDjpfHVI1+HtXKBwrXfkxB0Y?=
 =?us-ascii?Q?sASHCi+EFUEMoZaz+2T/n6YqkDZ0YmJTk5swUvat0neXMOj+thdz9e/V+TZp?=
 =?us-ascii?Q?gIe+PDEX0o5t1u+ETsSU4K37hgrUMhN1eESZQRMOJ5mNrMiJTFlYMtCt/wBQ?=
 =?us-ascii?Q?uIfKZ+KPgw4WH+crGHxAMB0WKBNJJRM+vNusC6Ae4w4m0EkmmIGxl5mnVr4D?=
 =?us-ascii?Q?gL+zxF/XBoxolVgql7baEPhFZJa2yESUQJKxqbEBFJUoLpXgFUAjq3Bae7GS?=
 =?us-ascii?Q?2f0MbQyTdbd2emoyRtIJftx3rG4xcHguI4NFxj2noCulRLr8SsJfcSU+wPX0?=
 =?us-ascii?Q?NEro/DDxORSnMYiQN32dh+5ae1BpdnNuHwiij5thGJOHrzBDmSJ3gak1Hq6o?=
 =?us-ascii?Q?jsfZAh20NVqn7ny0YVlrTHvT+X4tJjF8z4P0ua5bkCj7vzfegpWOixeNLO1T?=
 =?us-ascii?Q?CWnxdUX2hhr0nkWY7WBfqpMGXaUpyKEk04m5CUV2R92TExd7u4VdVrOKXVsw?=
 =?us-ascii?Q?aAdHsXzupM+lbkkjn9+d+dzCPvsAGYJq9hiDw/maTzcy2TTKj+A2XZ6RErBA?=
 =?us-ascii?Q?MOzdX0jCA1BprS6C0wnoQ0S1RtJMc5AG8j8rdMcIE+saeb9SgWljZAhraKRE?=
 =?us-ascii?Q?ZHd2sHzMnoYdz3hzVr5g+HllC0NxDPTmBmWe7ff2bnMQ+sz7enhNZi9Zi5dk?=
 =?us-ascii?Q?ljfcHIQtRrygnaPfvDORTFnSqjFjExMpTofU1Yy198VIrXnN6LCnYsf5kVMs?=
 =?us-ascii?Q?NsFAHoF1UwEbSq7/Gaqz6kWg8FFDLhmlYbjdgJ0dcJmdNzYUJCpS7/3oxFna?=
 =?us-ascii?Q?mayAI2VQ2Cxa+wRClgQZzaG/V/Gbx9MQXZpOceQISaow2sNpY36ivItV456l?=
 =?us-ascii?Q?rTl6FAyJ9FYvjwVuta6YPWahBfg7W6LKLglqnhSql/wVhOG9/0C5jdFmlIFb?=
 =?us-ascii?Q?ECfq1reldtvc03bBedhu8GNZIkOqkVbodmeCSTDR4KWZTzfNx3uHMPeamqd8?=
 =?us-ascii?Q?uETXmZ6e17IHdvXQZ7vWn+UED3BynmEKFizWNab3TTaCBKpOUJyO9W1zzHOm?=
 =?us-ascii?Q?M86qCCVlSYj5OUeDOE4cBZ4WdUMMEeDXV0TsaHW5VoRAVAWI+8c5YTDGL8WP?=
 =?us-ascii?Q?O2+tyubHh/AdXV2/o/kOpBDXOVcZUDjD8J8dXh/vdMzdNRWTus4k1uw0NHMR?=
 =?us-ascii?Q?27IuUxom5jCUzNbVSgKA0nGq0ASPfM4TtoFul/EMxo0hFvs2FQERwqsCOA8R?=
 =?us-ascii?Q?DGZxL1U6HjSuXWNAjV+wFhILNV4jRTAzZqDfZfhLdD6slMX3S4iqASlEii2G?=
 =?us-ascii?Q?fqtmdTUsd6TM8kACUPaYLdFEaYJDbCnu5VmwqHbBBk98BY98CopSDKpgF4rN?=
 =?us-ascii?Q?ClT4hvzpIs5oq0Exjl4HmmSrQ3EacloFLUlECgS+PLPDElDbxzOdMepvkUbd?=
 =?us-ascii?Q?4oqDFa2j5ShexCI3AJM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0308d057-3d0a-49dd-f4b9-08dacd73eeff
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:58:24.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nROVEFCdqp9Ht9f0o0Jo8Zt/sc59KjjeeazQQnpmkg9RYmYAhkZXsv6F8KTQoBLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 09:49:11PM +0100, Thomas Gleixner wrote:

> I guess we're nearing bike shed realm by now :) Let's pick one evil and
> see how it works out. Coccinelle is there to help us fixing it up when
> it turns out to be the wrong evil. :)

Sure, it is all changeable

I find your perspective on driver authors as the enemy quite
interesting :)

Jason
