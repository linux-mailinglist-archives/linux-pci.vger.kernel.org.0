Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E180471EE0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 00:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhLLXm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 18:42:57 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:46304
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhLLXm4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Dec 2021 18:42:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC3WFb3vfdZqwJyuPWsQLPwwW+cYXRfw4TQ7LlLwqCvkWOdqcKli+B1IlWCEoakrTmBA9dUl+LosyoOJk1q9kpuSiEMo4F4M3mtsz9YLWENGbOraMjuEZdKTey9+TAWgYJUUYzwUB+ESAsQwEkkqPDqkg+6riPfE3jFj2/1SluDEmSKLQe3JWFq+M4oDC1ml8YWkK/K0DfbPY2raugMQZAdE9Rg2IdDBaX4cmGGsW/lLwtf0mYI9XR+Wtmo3IUctMgNDWtikioGPvuqhYZpqxOLx2FT1LnpsmQlX6d41Q24lQmwoOTZyH/etseQjgV4N/8dQIOa4lP/pusykP2g3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0Vpovmm6vQTotSgXEnGEIiSXkUxHTSYHym39GNpzC0=;
 b=LcoIwF1vkZIRamOMXr69XHzO7kwIjYl1CfZpmsWFTT7EqZF2oE8Eti5Xu0QeNR7xJefFMFFX2/97BwwvK/B4OJzHYx7SqgEhooLJb9c0gLWaE58uAPNdtqete72FFQqtsQGf837qvF9CkabUiHEr1u7jNTBZA3Cuykudj2ouWUawyE7i4vSKuw6waEsvVj6Wt+a+2EuzQhYlG+VB7oLqe+CkcVYBmDQ8O4z1IBelUdiI2hAmQa6FxitncQ2catbtKkgSHPKA3XkvOG5hwAXWsNJQZh09frpnfAx3Bg09P3QPILH0wo2KZXYW4inSem+nEMfwH4LLvLNtHCA3FlPfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0Vpovmm6vQTotSgXEnGEIiSXkUxHTSYHym39GNpzC0=;
 b=lWgkH5QpL1PXAk12AuT7rIhE40FjZgJ0FqFtUrYyWpVkhqJqktbEAf0k8yTuiyZ1tNXNfFhxM1HQupanQ9piDk4o3ioo5o/BadmqmTa1UAjILF5eotU7Agsmiqq3v4IBQ9yy7RHvpHqM9nE617/yjxw4C22F80lzYDp0ZveSiWibJWVzFiqVFH+y11EoxiXl86Rig3qg63R/lAPRLfjwMU4egv2l0VyciC7q86dmOzPHlv7euqkBF4R23UjecXbgq0RwggMIXoWnXn8gMW4SIccLir0hT/oSO8wLOecJqoYMXa/uMmYkljtzXq3RmyjrzJnTrqKdihfT6BqrHXjC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Sun, 12 Dec
 2021 23:42:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 23:42:53 +0000
Date:   Sun, 12 Dec 2021 19:42:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20211212234206.GO6385@nvidia.com>
References: <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0qvfze.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf0qvfze.ffs@tglx>
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75bcb45a-5a9d-43ae-14d1-08d9bdc91dcc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5189B8B297380C6843F5DC3FC2739@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdtI9ZGXLMjR9jAG7a3fQtI9GKIFtDXLsKgXy49L5AMR1U5BoFPjpyVR4ShcKECorIPbT4zqHydv26MtZ0Ud3eDIrjH8UbWbAppShAy0lpWTJAMrYERkr+DixQrvhm47SDhvbRfim6sHNesd6Puw1n2sMU6i7pQt1WeDDEXqIleaWQX73AgJISiIdiN10rGW12r8DcFDyBNz+AgdIq75CvOpn7+GeZsDnqm03VekZ9yiG/eNwBhl46uZvR54LfUoWAiujGyrQ9ChoSwZXBwfPlf/YJId4dPE/w1LSokFViukXd+TWF9Eya/xvC1Prs/E4ZklYs3mp/ANbcsApRawbg2MuKFWNeMcEVBI8ZvhXCKvDav0OUuj8Us4woNDyWIE+R5CN9XZOO+YtRm/yk7198/6O1ne7iaxYIl87w22pApbWZvTyXli5ouZjN4rAs8jn3hvH1rJqNq35jD7ANcWmTwxd3y+YOx3L9sCUiszmm50/Je3dijS1oSiEIXlaKHWOhGrSIgaGfWsbk6UEbj1ZI7FPGAvfBhrjFXcFGkq6ZzOitFO4H2MwhhwM7BN2K8AdEfaT6+WrZpzwvwfH8VKebcDKtRzzxH+Uh38hRGD82Rou3L2hWz+j1NS65PbHHMehgv7XSsmXId+TQvcqoWdEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(36756003)(6512007)(6486002)(2906002)(8936002)(26005)(54906003)(6506007)(2616005)(33656002)(8676002)(6666004)(66556008)(186003)(5660300002)(4744005)(86362001)(66476007)(66946007)(6916009)(83380400001)(508600001)(1076003)(7416002)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qs/JYJvTCIiPEhbM7KQfQcilivWDeDAZAyL9wFnOG9am2T8pfjam5qw8PNv?=
 =?us-ascii?Q?3uAiwKPOk4Zo3Nzsx1YuRyDzrI6HcakpBZua8TQd2/OsrCfanKSwMl39JMHv?=
 =?us-ascii?Q?CUKzzJf+Qhc6vuQftzPNJUsh5lbaRy1uMn1wjCV64ItDp/BoswHQ+DX5fkbX?=
 =?us-ascii?Q?OP6WeQS71SH8AOLCHL+vbxEVh0/Us2PW6pbWZHt+WGNaHggFcFfNnN+z8RC9?=
 =?us-ascii?Q?hRBHp4DyK4gmMbJtCXgXDWdu7I0oW3DlN1JTymEaAVaDAfnLmn36gJ/lzRwO?=
 =?us-ascii?Q?Pv78ras//8usBfs6sH+Z6Cnn/F/OSp6tM5StajRoBV5T0INFzTrD5MJvv0cF?=
 =?us-ascii?Q?AvtaqOHTjmTK0ktzFTqnN61YB7sOJJo29jBW9AIpbWmf3fjDYe3EMIqiuGUs?=
 =?us-ascii?Q?IotpcI6LEF3BgqQLRXVQvhGia2rSUO9bQ6QLk2wtJt7DkhUBu5wPCL9T3f7c?=
 =?us-ascii?Q?VVLSLIhGfOyMGM0AWDYgI60NpnK5D4KIJaTtnp+3UQklMJ204QNEVB7UB9bu?=
 =?us-ascii?Q?wy3rIwn6w5RuOCN3k5/D6dzJtLA6AMkoLQa94viZwokJdQkB4kZOVXxSmG6b?=
 =?us-ascii?Q?Di/0U1AZvfR/RJBrYnsfYjje/a4Kol7BKJHTDFkXNv7awxEkasZD6NPxhpUA?=
 =?us-ascii?Q?+I5Vq/hVpygKBz9j6jnu61GFx5v9hkcDi5dPNr15UzZpEcdyYFG049naQubK?=
 =?us-ascii?Q?BR+k1AWOaxRBPLNyiiPXgZO1fIqcWY+IIUITkvTVrzPP71fVWpFZgOk8Vgxj?=
 =?us-ascii?Q?rUX79hmlE4BU3bINx2ACs1kMcjkNIaYl+/C80/+Lg41OVWyhCEWDv1wBesGt?=
 =?us-ascii?Q?h+jVyYb9NtK/bzVdnJfrQW0mi2ByRxe6DdhSCg1MFjp0HCnIoaNq5izuZy+1?=
 =?us-ascii?Q?t2q5ufjsEukwlo1Cnh94P0Trkhvq/WRD+6n2f/URDlgxzdOfWPUfwvMLv8UI?=
 =?us-ascii?Q?s07hz0PDc6/2+3HKbv5W2sos62d9bpjL96bwRwgU6VPF4DiuFdx7iAG2N2CL?=
 =?us-ascii?Q?TcoYP4L1C1IzRt/4raJlTdWcGC3MKxOIvJpVQGDnPrsEUA39tQOeV19T1YGQ?=
 =?us-ascii?Q?Yf8mM7qbFVibJttmQRsM4Qiv7VZ7fxE0o1IdAoT7y8MmwDKZoEmmHt2uHOUg?=
 =?us-ascii?Q?qP2jwmSXcmVvF1hn0XMCq5BKBA86BhDUYkhWFfjyktoEkaWQ8GwhN0BO0Uxr?=
 =?us-ascii?Q?J+VcHYdGvKTKOtKQELRdijjfBq8cjFGQACvgAlQccnkkEP+6DueiQ9qBb80G?=
 =?us-ascii?Q?l6nUXb0LVHZWtMtxUIYCq1GYhJA2531BMdvDQHAy151VmaSSCwtz4ZjOfa5w?=
 =?us-ascii?Q?9NEcZ7nz3P+U9+dVzCf0v/jwmJ1bHAb8SgRgsafgRKjTU/Y0yk0sXvrx1Nas?=
 =?us-ascii?Q?FGZNFOav/WnAWgv49yVp+cb5u+i5fKeco3pb8mTu4/TsGDKwX4XqtueyydJC?=
 =?us-ascii?Q?5b+tS0BikpjzHhz8iiIZs4lBBQFssf44mC3rfjbxPN7fIMirTfop17T3aF8M?=
 =?us-ascii?Q?C4kIxe+w7/sk69jvll5DwyD5W8gfKZzTuow3A1XkYd8MdRpTzCuZfoQZdcU6?=
 =?us-ascii?Q?vCmREsxMCGff4zGbsLY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bcb45a-5a9d-43ae-14d1-08d9bdc91dcc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 23:42:53.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqeEBk9m/aMKOxlbaNkfd5Jax0mGlr2RTRFiSnOPQNnzc/ILQoUU3jgAKHGXBH2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 12, 2021 at 01:12:05AM +0100, Thomas Gleixner wrote:

>      PCI/MSI and PCI/MSI-X are just implementations of IMS
> 
> Not more, not less. The fact that they have very strict rules about the
> storage space and the fact that they are mutually exclusive does not
> change that at all.

And the mess we have is that virtualiation broke this
design. Virtualization made MSI/MSI-X special!

I am wondering if we just need to bite the bullet and force the
introduction of a new ACPI flag for the APIC that says one of:
- message addr/data pairs work correctly (baremetal)
- creating message addr/data pairs need to use a hypercall protocol
- property not defined so assume only MSI/MSI-X/etc work.

Intel was originally trying to do this with the 'IMS enabled' PCI
Capability block, but a per PCI device capability is in the wrong
layer.

Jason
