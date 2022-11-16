Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E54662C723
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiKPSCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiKPSBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:01:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B86163159;
        Wed, 16 Nov 2022 10:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldyZN40kbcMnl1K6ceuAeAq6PDQ7YVXbGFFNnz8n9QM2rAJaJfntGGVHVwuplZechspY58s9rj7+OBEjK/mlUdE2pBIzCVCWcAFYZtAZSy3Ih+sXrkQrhW1SPk5wdL39iJmTIVw45xF8nhvFFnbbBprpGo3AqaNelLaKePLknemMNZiD31pMGRuhbA6yTaDnUg8TKr1v0a5rfjjQzPcoTRAeZs/ZgVKxpli1jjtYX96IfNGzPrgniROAE3V9Tx7peedc+wnvFPgY18bSpw/WLKvAMzKdjqYl9PD04V/RKvZTBSOUsbf6vaSTtbhZwX3VBDk/sWbF/+qG378qbiZeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktQ7KO9mKi+IFvBBhu7tPy86W8zphl8ov3HoCgohtdM=;
 b=hpj1iM7Mywr4kJCxwZhmePKM7lGHLmKtcfaF5Ed//LmF1dttd797jRtL3/mdZ6JBdxZPZP1EWHZ43HK461DOHZW+wcG0vFZymY337OrQ4CSRo5IQKRplsO8P0GBvRkDy17uTdM/rIKiHHaeAn8hcG/F1lTUmHf9uHaq+MccxyIOR51r43jF9RMPQGSWWAfNP4uRxYFuYEDkAKCDk8bjaZKRp7vj6rGZJbGnVmYhJjMj2CBin5KTTH4dLMp3ZBrDfr00C7wpyc4VIAnYbQ74VrwYX5Z1UE/M/OYxj7b7/Abq1AogtJ2cA2b11J/jTSSxrV9emqrh6jJIU2YZGRrkJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktQ7KO9mKi+IFvBBhu7tPy86W8zphl8ov3HoCgohtdM=;
 b=mMI7gV/9tZqKXFBmRSoKQYe7e+cGlqs5M41K20FJv+ef8aTOQNKEWQr2jVWFiJUzEG/Ka3QIhdN8A9UtEyFTkkAvrZ1PmuJ6yKu3WT9VmXiL1LALmCVMVukth8fa9A4hvqogbo768fy6YqH50nCtjCUm+g1hRQOApvG3Ne7qHHCYiW8fpH5+Os5E2plrNJVO13cXwrznXOCCzjdvAsPan1ArPOXzj7N4o25IQY4QjUblBdA1I22emJxp6Wr0+9qE/XXWNc5tm84hIvlJpRjyN3CjZgQbf2Ef2GjHXwlR9UrsThNjsVG1MBI41cECiTAoRr0p2l4K0eKl/u96FaKZ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 18:01:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:01:40 +0000
Date:   Wed, 16 Nov 2022 14:01:37 -0400
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 38/39] genirq/msi: Remove msi_domain_ops::msi_check()
Message-ID: <Y3UlgY/pKHR1z25Q@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122015.807616900@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.807616900@linutronix.de>
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: b59ac2c5-1d37-4bbb-bceb-08dac7fc9cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOEm5lic5t+ClyJ/4lpHMmXr/EBHiVi3bPOc86fdOtxl6TUo7RLo06dWt5LXPPpeO3gLuaDVSNCbcFUF4ulYYbpIVNthzp9dD5FeSBVn1JRHQ3S4dRdxF+FTjh6Xzx4+oDvfxmgj7+quXzkMFsv3xToWuu1PubbD8FtG3S4XwIPXl/y3nDJdGPnCEeP7PrFkAFSg0qjBr2ZUMlXti2O02TBY6LBGDg8Xvh7ue5AS6MAagpRzkr6r6wrKHpeUM+75BS1+L+Idb8vUCrQQQKsV2K+HG44qMFHzAJDIHDL3gArZywQX8/YHFWIcS8qkkAOAHSOCbfevxrUMEFN0OQC8tQxolwU+jvS+dPVdctB6LDiB1OWV+eHkFsZ13ibIYODPPyy/+xdyhE42FzOojTC7FAMrNQNyz00B8fXB3x4WuZWT3SMsPEYTPjZxZallcjeScSfF0BIDAodBL+STekREyNm4GT4+kcvHDGif4DfePt2xlpfnyb7OeYN0Gzd+iMoFlQ5UKa5Scu2WB+gRIcPw7B4xxpkx4AJe7gmhjJsXKDgwDM4BiXdAtEdCwlIoiM6RuE9qsDlaKNfUvcjSOOo/nfYzGhB78mVkSMX2K5cYXhCphwPGNoEyG7mgXO/aNIb15vnoZMW5OXRNT8cQJ8Ay2rmsNqSS0rp3GTi5NxKQ+Q2Lpm1qN+xlyU5T1lYPmgwa7lePa7qQLgzQkHjTOaKppg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(6486002)(38100700002)(2906002)(4744005)(66476007)(66556008)(66946007)(41300700001)(6666004)(86362001)(8936002)(4326008)(8676002)(7416002)(5660300002)(36756003)(316002)(6506007)(478600001)(6916009)(54906003)(186003)(83380400001)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ctYNA2wEbY4u2J6/W/bj8JTDEW0Ratpye5QZSMXgC40EcihQuBk7JXsTclII?=
 =?us-ascii?Q?lUpNpNdPexSstFyBaT0IZMWrOgaKc5cyEGPGeMYi6ix4i5HjO1id03lUYGS/?=
 =?us-ascii?Q?qnKnd9XUZfvJZFqMmrcq9ds/F4RZlMmcAjGObQ8P8vBOIPxdHrY8wumfmfGW?=
 =?us-ascii?Q?eppkVy4ZnAu7sP84fplUQ6Z5WYsMtT2CQjTNjnRQFme+oDXKq49ZjCZi6his?=
 =?us-ascii?Q?PjPZk2rEKJLGN092veTWyc8YoJpTlR1W37RSXokD+G5eOGbQWZt6ODXhX3JQ?=
 =?us-ascii?Q?KT6QPEnKvsyAQzHTbr36PmuZOgINs3QhzuDD9jlilV2jJQsvPaRRE/0TVrFF?=
 =?us-ascii?Q?y5wSnIN53R+rKlIOO4XDyn1NCCUYNHRKXcYX1fTpT2Ikp27aFTmnBPn+JhL6?=
 =?us-ascii?Q?i6GpPWXcX6sRCoJ0PSjJc1aQWmKz6RYIRHqT8Ui+9QZd7pbssl6w5K3NfUzK?=
 =?us-ascii?Q?ltfhc5+VnBbfMJSvzA0m/98KI4lcDnnA/70azY1AySmzZfow8khOT5LpNT1C?=
 =?us-ascii?Q?gjiZsEbjAHhdkMPKWj3H14olwBLGvcmPRjQnNozOCiLTf5Gcs0rcYoC1lL4U?=
 =?us-ascii?Q?Gz96xrAV8GPGEdExbwIhW9DpyFMwLkD3cwtR2kPkuZj3TtXCfVoAFOyIo1w3?=
 =?us-ascii?Q?HAkMG3ixbn348iKzYrEb+XY+aaClWQ7f9wdEEgCRKjbnwYEtjMoX3lLESuKl?=
 =?us-ascii?Q?vdwq6LMhIoSkSwf2Y76bVPs9t6CN905itUtxM/Lu+AADjPoA+MT6YIZOw7gE?=
 =?us-ascii?Q?X0sjUuepOt12FWfSscxhm9brFbtdq148IRawo9XB5/x9r++dMzIn6cHkSQs1?=
 =?us-ascii?Q?LzUkAf32bLfW2S7xbgooHou91zfLGJpuS/0e4+Epp9Y9uQlBZz2kU2J+QTE5?=
 =?us-ascii?Q?e7Xntb5RVL40reUTHP3fiAZLnCLONkszMZb/Zh2FBaTW9QhBcxlVkeXtOAGL?=
 =?us-ascii?Q?fI9DoqZtserYFcHNVb+C5wU7Nb9DppS4/uAU7O8ql5aa3Sm68M+kmU9kclMi?=
 =?us-ascii?Q?rnYVVVqo0OfCpXwG8+qjhqZhKPnUyTLm6CrwonIakb77NTcWZSXA7Up3/OML?=
 =?us-ascii?Q?DgR9iKiwz17gqkydIS5Hv+sUEa5iecSGLQPJI8pk6EiM/TjVEDPehwb69qr+?=
 =?us-ascii?Q?GjaEOKtphHwXSh53+5BsK705CH5aGWr+XQmJEXoG4xrXEGB3dFd80VHcTuAH?=
 =?us-ascii?Q?iNvYRfl32K8BUAvm1cpJf78pxpqM3ZFCnxcKNRXO61VkQrElCI036E38jUVu?=
 =?us-ascii?Q?vT+UWNb4/hQWE4By44a99F3DjUJdwbDlOX5vf/FBeeM9RYWvffLntiPNVyxz?=
 =?us-ascii?Q?vD+BTlFLZIFtJ+ap2N7a6sGygg1Dv/WyqPN98EB51FugUx75rcWfNSWQxgxf?=
 =?us-ascii?Q?TWFACh0GWOP8gRv7/4GzmC7L/DO4NyPj0LTnkrE+dA0xpbRvZaKeTWTb0UPd?=
 =?us-ascii?Q?7C/kxd5s8QHdBM0wHf0TbWCdSj+85M8Ji4DmFo1Cmu4YmSNGUfGxf9bEEbxM?=
 =?us-ascii?Q?184iurPtkpPCvG4yp+toYKZN2zjHfu4y60jFsIa4k6BsYRAYV797Yc3cPwtI?=
 =?us-ascii?Q?joit57RlEFz0cdnzzsJN4Z0Qz3T7SZaDNTrcPt8p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59ac2c5-1d37-4bbb-bceb-08dac7fc9cdb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:01:40.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9c+uNcfGy0vKQOWmA8KRasH0ibLbW0qGwmSggFPHMyUOq9MUTQBrA5T8vjyDHvJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:15PM +0100, Thomas Gleixner wrote:
> No more users.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |    4 ----
>  kernel/irq/msi.c    |   17 +----------------
>  2 files changed, 1 insertion(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
