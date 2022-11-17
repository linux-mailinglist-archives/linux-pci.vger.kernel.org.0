Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E362CF75
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiKQAWZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 19:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiKQAWY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 19:22:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D104D5CF;
        Wed, 16 Nov 2022 16:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHCQRJOfH5dtgPxLeJ9eMHrU21kwgvAZYgZ0aoK6wnDjLoP/hOH4Ri6V9via1wtHLdhL6bYqilfN62yEgmowNRVjrNWf5iKvdnUX6mOGOoihKErZ7Tyv7OTgssE8XPNIftrJx6Ow1VTRLfYtAgdF8DPHO8ABA3iiYcdzn2V5D2UcT3vY/cFJR+bLDGBoRSlP4TXUFHD8vSw6THdQKnXhkFCSHT2fYp8NHWxKxaKbYCtiipsLpxvPpJZFSQ/Mt/F9PAA7Lw5s8NFHxfp5J2W8GI91GJjfVB707DQFwURvWoIU7+DjF2rIdYjV8ocbm0PiIrITWf8clCUE7IK0BxTyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLgDJd+6uDy9X7zTMk2krxpfn6XJpuMz0QebTLombOg=;
 b=cwNSKo/kfkSzyJPDtTxnV5zQd94sOYSIsHNjZprE0T4iYlKJsAxHcLpaExWNt140K1SNEo6qYwYZnNwQu68ADdXLiIEXNhu91ZkJDIM+tPrBhlU99M3JzfVc087q8bV7uhgjUunwW0W3Eiq2c3/+UxxEowEmu8enal5EnBAptvVTvG0QjiPYIz0d+7IwdmiLL3Qx47MTPk7yy4VP2ERjfkxBENDOwb2aI4+SbDbc6/J2BU8ihpdmSP+xyM6Zxevj8ltgUVcv7Ni8/K3tbPWeBvdmYaOhKLDH90QXr55VDPCsylpyHsT7WJb22+np0IY81o7sR2RD0lAc1YsSfkGODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLgDJd+6uDy9X7zTMk2krxpfn6XJpuMz0QebTLombOg=;
 b=W5TQZ+6U/1Q9ZgSjlYRH8++uwWsauGaBN8cb0W1cN7IeaxdkuHg0JL/tfSkUiGHbqgnMn4wCTFlIFjdGC0ulPpwK1379DnVYSA6ohw/iQf1HgBetwhMLizvkHAMDeeQd1zEuR+GffDEdDiwVUsGEG+C17ApvUzksxCqoJusuNUK9ueUBhaS+/5Ax2Zw/XHzIqRYQEz8lHO4qPdsUvNHB9UiMW7m39Y9nT1ElMU0JlEjl/D0ovk5KMYJHuTSo/UIvHwQK5WJ98C6/VOSfSeh8CRUe/twm7KBx46Qr71w+BIzWaOBPcynxoOpH97M+kQsQQ75GSY+8cTy6Kxtc+uVDbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 00:22:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 00:22:20 +0000
Date:   Wed, 16 Nov 2022 20:22:19 -0400
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
Subject: Re: [patch 12/33] PCI/MSI: Add support for per device MSI[X] domains
Message-ID: <Y3V+u+h7jGbRj3cE@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.951710169@linutronix.de>
 <Y3U2QFeoDB17kbIC@nvidia.com>
 <87tu2yo77n.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu2yo77n.ffs@tglx>
X-ClientProxiedBy: BL0PR02CA0141.namprd02.prod.outlook.com
 (2603:10b6:208:35::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdb01f0-54d1-4f13-3690-08dac831ca98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMwHaNEOr7jQRkgAizxkWTyn/0TofYjtuGcAEWTpaJBMGcgFeRAjLcLURYRDO4BGKtIuVpq5bxlObbPM/4cG3jlcUl3hvmhbuamAtvkOE1k6/o/V6zFZIXIMTFClN3GuxoBCQFgq39j+YtrpSMxqqfhKy84pUkjydMkA7AaSizmFJDdvqaAvOtaFL7bBgy9sQSGG+It88yRIv6lEKIYPZg1TjvmtDEiSZMVhmcvECrD4ELDeXfb7eFtBRceHioaFWd9nqiGmQrtTQyewfuQNLI0FIwZzZSWFW37FYmk5IYPC5hjshAEO+6EQVYenIl27l0xluGLeN5nI9VQMepLrooJFSK9AwLa760otir37lVkBcaObErAS7eRcz+nGUXAnMtRXcNb3eG12ttr3BkWsbzxIMfIjO5XSFMBj4PP0XrZc/eUO1sJOxKNFuEcbKl+WBTUaUhrQG7daqvZXfIHfJ/itLJnX21nJsK3ACZi0b4CRkoiR+ODVOcUnnUVvJe5Q2g7/28p4myYzEpI1gXFPAup51MY1hS1ZiTvdeFJy2JtKty5DToulrGrYzEqtilvqBSaEj+U0xbM9vhftN6HMn78p4rf2htz554uVhV5lwC0akWewOaaru9PWdEnMOF8Z8IrtO8MQt7bnhe4jNYv+CwrZTNcFjvXjA2c3R/TcMXs+Hf1Qe19+LRxuk58D4BY1pJtjac9e7iotKwMkCholKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(2906002)(7416002)(4744005)(5660300002)(8936002)(41300700001)(83380400001)(66476007)(4326008)(66946007)(2616005)(8676002)(66556008)(86362001)(316002)(54906003)(6916009)(36756003)(186003)(6512007)(26005)(38100700002)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WN7LJXijHxg5GYGyeTGMHkhqQtq4wWH2KqvJ4+/KStPETzUYvTnXu+eJ8YRd?=
 =?us-ascii?Q?tJMUU4afP2EbyOVQ1rk+2IVMHINWNVQl2JiuxNjU7Zq8GKncNpB4N2r+Finv?=
 =?us-ascii?Q?CKDHhicGxUfv03l7q9UJaNu/+0shn94AG6XJXkNM3TtsAed6T3pgJgdqXcUf?=
 =?us-ascii?Q?oIJvItDuxyEqYKckJtkac+UCmSS6VQIze9z5B7YWv7d6zlh3wCybcmGLIiKb?=
 =?us-ascii?Q?5qD4VJ1lLr/EgCzyzNfM5xQ+qKY/QrW3sszH+/YKpqjs5wuTEyzs2PFdwMEc?=
 =?us-ascii?Q?M8EWgYesjMozJV1sJ/pdQstWfDBsQc5EX8o3PJqUwFq67KPHMOT1KM1e0tox?=
 =?us-ascii?Q?H2Xq+SwdGeYjD1Syvw+Jd+uhbbhXwmKPrt1x10qPJNTlgBYS9EfMpFh9DhJa?=
 =?us-ascii?Q?TG5gGqpRoeXFkarDRTPvDrRx0Q6eCbHf5j5B0pBrzk8RCJQqg+H8Iree8x8A?=
 =?us-ascii?Q?nTwqXlmTzHCFYSczsgYiutCVgztpz/4AGHUXYypl9XxsLo/FTugI5jt+/Fhs?=
 =?us-ascii?Q?gQvcuo0ZJVi8u4M+xHGkMkMIMYwU1Yt1imbQKairqV3qTZzStOtgLn4o97Fx?=
 =?us-ascii?Q?OL65AlMy49OwLTQY/vQnPL7vwVcMgxY9dIOEmj0hsjmIZBD5Q0Xn8N2SXMyJ?=
 =?us-ascii?Q?9WLRtyeHWaZ1liOfsTOhtoHoEK0hQQwnhgDJ0S956gGNdz7/4CWhfdaUsThp?=
 =?us-ascii?Q?oPa77TrTUeTIna1WDFEjiQHhgkho2uWBmwiD8uytWNTlL/O7PaJNXf4xaJ9b?=
 =?us-ascii?Q?nssYZEx97KkrzvA7U6vA0b5fRRQUR2xbgaJ7zqqVDHY0eeUWtP87WWXwAveL?=
 =?us-ascii?Q?Jt0FSAPzruhASP4LuUa8u3aouuNFyuniYLoE2dObamI5aDrLQ4FPd8RP3ipZ?=
 =?us-ascii?Q?X9AkH3QV/gT+/hpL/Qf2jH/zZ8MS8Oq2EpK6gqaAnZpXAoiHnDhZNswMgY05?=
 =?us-ascii?Q?O/AoJ+ryeBHc3yjuWMFdmBkM7Ki5thjsvIK0lLaA/bCrIItBcRRD4aZkiPKq?=
 =?us-ascii?Q?jTXd8N+lKemARgZaO60F48TGxTssBSijfrDnguG77ZRBEyCTnvprXI+Y+ZIv?=
 =?us-ascii?Q?Jdth6fsC+nJBEqAt6nHRvW3WtllRzRvzDPNBto8+atRRP1zQ8bIIrnkOe8EH?=
 =?us-ascii?Q?m/IGA+MnxyeChkfWo6gY+dCl09pTHnZWWakPqqyhKfEDqnWIJg0m6ks3MmzN?=
 =?us-ascii?Q?rn3mSLZ8bqetKv/MgvmDbN47n9JYhPbKwMrT2n/FYKeRk0UyAHJlqEFs3z8T?=
 =?us-ascii?Q?5Iy8hmebvfIMOOLMtgspPNWxJHFBM8gaJ7L5i8UlTfxEfGASGzGoymMrH4lQ?=
 =?us-ascii?Q?pX2ApZE210JsAN6HHWbIAmh1tra08xw+43KD7s+uZm37LPDkTIZCryUE0IJH?=
 =?us-ascii?Q?uDsPQkXovf/SICkXI6gkhEGxVjRjaUDxiMK4AODPczgQcbOoB+APt4z26xmG?=
 =?us-ascii?Q?C2OYrfvI/z9PSqozkpO6uTerLkxLc/kZo/wwxpGuvqgqpaBEXUpur3J9Djxi?=
 =?us-ascii?Q?8hQlh5UvH31TM+bI1yRtbz+gJa2OhGGbvvQT/tar+dYCuX77jN1DVKTzSWYG?=
 =?us-ascii?Q?su+9f6c/IqNnWGSSbbM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdb01f0-54d1-4f13-3690-08dac831ca98
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 00:22:20.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBb7OVd0NOd3q8FhySgsJAeVgdTubp1qHBcwgEuPvocMPM8J8h3rt6+CeYVfCGJb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 11:38:52PM +0100, Thomas Gleixner wrote:

> >> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
> >> +{
> >> +	if (WARN_ON_ONCE(pdev->msix_enabled))
> >> +		return false;
> >> +
> >> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
> >> +		return true;
> >> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
> >> +		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
> >> +
> >> +	return pci_create_device_domain(pdev, &pci_msi_template, 1);
> >
> > Hardwired to one 1? What about multi-msi?
> 
> MSI has exactly ONE descriptor whether it's single or multi-MSI.
> 
> Multi-MSI can have several interrupts hanging off the same descriptor,
> but that's not how MSI looks at it because you write ONE message and the
> hardware does the substitution of the low bits depending on which vector
> is raised.

Okay, that is very clear, maybe this in a comment right here ?

Jason
