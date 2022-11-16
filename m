Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180CC62C75C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiKPSOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiKPSOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:14:25 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FDB627EC;
        Wed, 16 Nov 2022 10:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POP7HAVDZad8h0GwTXq+JuGq/o0eUnbJg//XfD9r8YDpb3FD0BXlOXrfiY7G4uoFbk4EbmF2daTHnZ1Eo6pNHff3Sw4UYGppZ6v3ewGpVVVy8MV03koFQzESKna3fqiEat4SGx9fBnU0+9jWs0X9zHqrxJFxfdsjunT/7nbfJ1vexdN/HwQIe7pJyrBlC4rzOOaKpDt/Y21wQ7h6WdXzbYVTCcpTwMu3ltPZr09xTW6bVfFeYzINYEZTd+AeytXUclGlT4vkLt8o1R1KpHpjPMPX42TdOdhtskoARiNXRZXgT7FPG+T3pJItjMnu2CR8LaUuiCYZtSwwaeT6jMlQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO88lhzxJxJJy/I5mTe1TFHHnXrg5PWFoJpvi4aCWf8=;
 b=L71C/PoJJ5+bwjSq3CQspO/86runuY1WSLk6DnaWXBvLDDfxUourcjQyZ4rNntyPfw+4j2nNw0r0sYJjPmPHR/oEPTUgg1QgWv7Lq+qX1f5q3RwCUfNT3kWJz5fQ1kVPrrfDshEheYejF/qIrR0LSKA9hPwSGzRfTEht5wTFHu6eRAVIZzTgtFseJB/r2t0JRY9MSM1aeHFXeOc8AZ4Z+V6wSyvuioRA5gPQ+MWnaG4AXAezcsyWWvjeKxMmZrNUGvb5SeF+qYy6ARPPPlicrr0rEcq/43bEnUOUyjlwG5D4VDdHkgvyqPGoeiPIQ1G0m2W+2+BeabTvuTKCKyUFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO88lhzxJxJJy/I5mTe1TFHHnXrg5PWFoJpvi4aCWf8=;
 b=YxL0aPzX45AVHVYDauqie0QPBhhqdbyQ1MGDWO2dvpbauhIwaNNsdV2O5LMSwwl6Ldtiden8K4Rc4QKTksY1WOlzswYBv02FITVeGFltfGscb4w6Bkm4q3qaohr4kXeEaoME2xKfbHQXiU6iNepWF5WzG6rsAO6zzPydCFI81QBz7Ei/dizQioRPXqbcQc+X0JovvpnUX7cJP9nP09QDFBvNol8g/QJPFCZ54mqjybBg/CbIf26GLph+StXae1VQ13eU/VWn3mSxvQNkkygMkOOB/HBadvRGS35e2sahbY+tFmp49qYVM16i8jQAhayu9WQSGsfyvWXppFs2JCtViA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 18:14:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:14:21 +0000
Date:   Wed, 16 Nov 2022 14:14:18 -0400
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
Subject: Re: [patch 01/20] genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to
 MSI flags
Message-ID: <Y3UoetfKnFJjzdpC@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.104870257@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111132706.104870257@linutronix.de>
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: e631633c-99c6-40fd-eb02-08dac7fe6237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3xt1yi+enaHrU8Kd/kvfZJ3KhO7sTZOgD55RxLrCrnMGxJQMHme/9b/BysVP6Q+gGTU8tlvhR64ILVhDBS4ZgwXi0HvDqSGtSTtcv28ElZvmM0drMcSeURs5CPftXM684hlfedbGlwfwLDQAeDz6pqfUqFX7WgnAmTq85MG3fn/s2xOif6PZwxqUHw5snCTT27jnS3mQYG1GXcnsumsMuPkPwdGfEuYR5s3WgXHLMrtIETNafi8w9AoTjKGQcBZeUIvYW70OjuimR4nQuE52/VT+OO2apz5/E7cWQuy25iEjoblKrUuUpHkN61e8GDItDmiDwdeAl4rdcJTYdxqKWOtefnXesRTlnpK1rb5J8Z1BSo8ICMFznuJH7M0VhRKbxq4FC36g9Wer3RWU23mXMbFxXZnR1VWnlcL+32FVTHeO2SqLKDncJqF09hqjbTUG1z8BK1GqwW4940uUIeKG0RgXuyrae/gpkQUu+VcmNdmFz+yXtxKZ61RqNuN0KgHHkU5Y05lIpqvKNzn1rxYjNpkqlafxvNmKOaIawVEcCvn+4jx0BU5kn3YNZd+czXh8wxgr0KCNqFidWmyKo9NNp12PK0/Bew/DYLcldSzFsNSZ5kkhQ3yaiHB6txG0wTDJbVl3M5YhyadssERJpJzlR5RLLO7IQl1iOgiTlmhwCAenQirB8zOKvUszr0Fy7TdpESYmi+BFRjicVl3BI6+qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(2906002)(8936002)(7416002)(5660300002)(4744005)(41300700001)(4326008)(83380400001)(66946007)(8676002)(66476007)(66556008)(86362001)(36756003)(316002)(6666004)(6916009)(54906003)(186003)(38100700002)(26005)(6512007)(6506007)(2616005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yG7F2Bz4ps8kfxcklhz1litj4EdrnYQk4UW+0F7l64lItrNZ1dQM7B5Y0don?=
 =?us-ascii?Q?NccIcrqoJPGSdAC16Yp8dnjgyQZ5ATlb0EXd9FI8U/RhIB4h+6yX5ALFpHdv?=
 =?us-ascii?Q?Sb/M3kgk3nz+Ddjm/TD6uFc0/tABACNj9HI75FREzZFSIXGIQtfLDO7Y8gaT?=
 =?us-ascii?Q?FcuQ4Cw5qvmXjpldiVMYyj7HIzmGYeL05VYkSGiXGaMThUTJ1q6lKV0k4GLm?=
 =?us-ascii?Q?HAbNh86Sk6lbsvlAWlDka9m1yku+/LNAEz6NKp63lAvpime7vTDu342dq0MS?=
 =?us-ascii?Q?WTtX6BNPVeDiFOqCq9eQEjPqIhzzlLZNOHjdvfBAW3h7qYp0HW7aqfPmFutS?=
 =?us-ascii?Q?ZM3GE+WuVHVXAAaYRlvb9ggTL9zpF47rwMuMqt3xoirOo6b6urd+kjcOUOZj?=
 =?us-ascii?Q?+x52ijK/zbrpdHrRJXyNgZ6v3uGz1GdPZ2J6b9rOX9xkfCwZs5t9rEnsEV0o?=
 =?us-ascii?Q?mlXYGp9kBnaSASfQ7yOwxqubhNgy61lUf1ByS76eEaGOp35oLtIl7p+rtgIE?=
 =?us-ascii?Q?BFe+WOn01kQUnelKNw9HuDt0JKTJJa/2+aIWgHZLPVWagubbSfxi+v6HwJdN?=
 =?us-ascii?Q?B6T99sXkNEaSDug6p6qt9l7qkM3AI6a/E28zVGwUcXZmavFUWPA6OvLTbcXc?=
 =?us-ascii?Q?3Ux/M/cZJ+zsEHYB/KuMkGvLdviOYp0XA0vUL9l2bKZAkOgNd7nouu55D+bp?=
 =?us-ascii?Q?ZikfQydn8a2DAH1S4/mZhF6VBghrCrWwldzWaOunAwfBusEtHYr/bq78ksYq?=
 =?us-ascii?Q?/1cfkfybcLNPDGw1o2GBCuhfnm1zk1A9XySPefPffh+OFn8mXMTVuaAa0qnr?=
 =?us-ascii?Q?5na+Ph93s+Rg4WpYlZwd2tp/5QEqjuislL6P1hgVMqztXTzU4Q8bfLPmCHIv?=
 =?us-ascii?Q?+C/vDjaRQcetXI2SnFt2wNGYNyWAvb4tUkhfgWZ3rv5CAlD+P1vgG2pb52Nn?=
 =?us-ascii?Q?Sp+jZoPW7K0WXf6VddZ/rXOxXGXKh65RrZLLTMUWEjvo/5/71oAujd5jfqYX?=
 =?us-ascii?Q?gnXtdqKoLlYHKHb8aCBaG+S/u2QrXGxFUjarwKfNF2GMXFOHBMgchI6iGrag?=
 =?us-ascii?Q?ju6yMF1esdNsRX3zPZx7up7a8HLbSmhcKub6linjnmm1XeZ4nkU5PmhwM1ky?=
 =?us-ascii?Q?29/C4tkNWf2fS4tnUW3Kr+MWWj/MGfAK/+XVJ9UPq1Tv/QEJr8s0DrRO0qsS?=
 =?us-ascii?Q?+MMyYXd8H1vfAhbHfCVgBwtAj8KbUcokp/AbvitxCLwOL/mEwMB7thC22zt8?=
 =?us-ascii?Q?HSYY9FPq7zE3SfLpzVcxhuMa4uJwnpL8jYYL/+8hd2ydLZbwnHM2idq159+A?=
 =?us-ascii?Q?YaJegH1LwAsUv9A5JAjuxWlQfPBHaRC6zjz42ju+JR31oqHtiY4WbmwARPXu?=
 =?us-ascii?Q?3UVEFncnT3VLxRpQBqAs91Endq74qc9NCmmp6EHby0HpPhyHE8Gly73bSSMf?=
 =?us-ascii?Q?tbXlH43eATMgtLZkGLfSteOEInHYaQxzhyD8p4dxr5N6UtAPJ61jpi+mOcPw?=
 =?us-ascii?Q?EpAU2VhFodA+0JFYlLqz0XnEoA10fVJxN+U2p8GiSKPupHXYDz4jZnhIISCi?=
 =?us-ascii?Q?X2DtqpFRGzXAnrqdI6p/h4EU2N7nvb1snuzoYnWD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e631633c-99c6-40fd-eb02-08dac7fe6237
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:14:21.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXAnL+dAdHtSAuuc6c12TPAN+YVKoWWhNfytVrCHvg7mGYcN3NFwaTa2xxKH7dl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:56:39PM +0100, Thomas Gleixner wrote:
> It's truly a MSI only flag and for the upcoming per device MSI domains this
> must be in the MSI flags so it can be set during domain setup without
> exposing this quirk outside of x86.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/apic/msi.c |    5 ++---
>  include/linux/irqdomain.h  |    9 +--------
>  include/linux/msi.h        |    6 ++++++
>  kernel/irq/msi.c           |    2 +-
>  4 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
