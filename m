Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04C665C28
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 14:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAKNIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 08:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjAKNIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 08:08:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0321A808;
        Wed, 11 Jan 2023 05:08:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYxs6Z+NRRPx7L++2oNDhTW1WBq3OB7iuSPqgwOVrOmO2arBYxLaBlGxDpJLUVy1Ju57fr3IVu2IoDVaahNVTuLmyE3+Afp5BdFilxTl/d0LCGAAlpa2jNCGML3B1YoOGKd+pSXW7cc7qChBkpakZ3NJefHLAM0cOrqQk+J/lzqDve0PvQtaOofjffsy1LsPTfinCUskFxd9bg/M0PNpSZ0xezKTA181fBdeyuEbS2DW2b4/CSkGbIE6OVgGjyJ2cBaHp7IMaKLm0zoQOlYTgZUFCBu0SLoBk+UicENo6uI3G/7FJ1vJkkAE2R5ReF56o5ZbzYOPqy9v8ogM1Cqdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ahav4ty33U0774ttbwx2cQ5QO8nrmqsur2NrS0jYNE=;
 b=AISRmCbJd5Y7u0pLojByhfV9duZsosZGi0nkva991CvLrd0SrG8LbXMZKHyCllScyV6VdqluZ0zKNeaA3REhtxTWKUi0YAgP3w05Gsx+L4BCmzyEOgULUuA9La0NNVEDn9FBXWi4cqvhrKzjZ6i4kr9jxaNQWexKISz01Lj026YFNcbVeseZmru8LvAMEDYaa46WBm3TPIjJ8v+h+SSgcVQ4v+44XCJ5g+JSBF07Ekbnrzj+iyplWsQqPK4OrjY8a23HVT+Mh/uxY/spM85fi8stgTMZK79TalfvF08Md3zg9AwO3iZ9ntBV3eZ46aRtX/Ys7ymvJ/JU1tp4XRjTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ahav4ty33U0774ttbwx2cQ5QO8nrmqsur2NrS0jYNE=;
 b=g6iKwjIdrOdDvbbToEmv4y+XDdzAWtrB9ZEJAIw3lXMuXHdineP5NNoMQe1e6XgW2mB2yQQ3+rzc3sSQm/GIdocJcSMXqy0KbPPcZbJdwTH1TWOZe7+fwYdcRwbCFSZJlCiBv1D5qojmM1ueCNHIqbyi23K/el8Iv1eYIENzba5zCMkEjnSF4ogBB3GXZUk9wM+ngn9SK1nQOX8dhZDQ2Xy19btqA6zNmKJlo3/swI0M3J7dzwX5D6Ja1+s0B18cLPNFMKXSaPHQsgnWUHw1Xj6FIYYkKaPpZQntfkK2cArvnQGJXFKQ7s0cSrS1aJYYDvlURhY8nJAls5L2Efec6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 13:08:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 13:08:40 +0000
Date:   Wed, 11 Jan 2023 09:08:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [regression, bisected, =?utf-8?Q?pci?=
 =?utf-8?Q?=2Fiommu=5D_Bug=C2=A0216865_-_Black_screen_whe?= =?utf-8?Q?n?=
 amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y76013iImTTbfaHG@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com>
 <7c2af186-5868-d962-f810-ef810fbd074c@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2af186-5868-d962-f810-ef810fbd074c@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0287.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b87a1b-e837-4d69-4894-08daf3d4f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FD0jkwu/YuGWOn8ZAIb+uKUw4ZEUbmWnPMDdqrgouMVfQlCeWEd+zt8nCnjMtxy9IZsjKAkuudTWm7qokKFvBtLfTf4Hbp0aqpg+eo2JD/VCqfG5AEUh/h3zMGUYY1dUEls6Z4hPMg6SmVRH243gTIydvsZdMk7r5z8vMMgH45PHmEP/t5A8nAE2fvNIZRmMqD10n5M3RMx4L7faVCn8tpBjNtoAq1PfHCLW89Nm32O4xtMkfbAZye2dhMy90t+7+/KgSrE9x/81X/W7s7kzm2OEvzrA18/hjyaDlkHiu82vyIOF1SxIuRzjVI+JZ/BpVpjOWJlmBc8YecZS8nExn1LpyAtRJZzODZgUH52eHs5pEHNlZ/CYc9/QbrIiXns/JKbTRZjlkYRcI4FBANT+OMxO7HGynRyxilVVtTdNvhXfRU4af0sWkHHJKU2peEioTFUDqZYj5Qt5AHdnHTD1Zq0KC6CA7dJNeKhSWPlxPeljudf6s0/C8sBNLzHbMcWLmUvUjnipetvs9utE+JYxEiXfpTrQ1tn+bwz6+kJWaYY4Jbxd+cbfmmKXu1S1sJmmxKANBbpX+s2qLDDSEn04GXLBjykvuAxMf6gOogXtdGa7FBdjJqkAQGdcorGaS/7Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(36756003)(4326008)(66946007)(8936002)(2906002)(6916009)(66556008)(66476007)(4744005)(86362001)(7416002)(5660300002)(38100700002)(6486002)(478600001)(54906003)(316002)(2616005)(53546011)(41300700001)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIFsJcjaHbGXoVlsAbdLrI5UH6wYmHLQQBzBziqdvjq8sMX7DwLp1ZoIF9yY?=
 =?us-ascii?Q?YpR7rtOn4pVysuJkDYcOgbV6OsaCN8hd/U3cYCrkb5xGb7+rQFHW5GrJIjUL?=
 =?us-ascii?Q?woPzl8jUrpVFf0M9YfCU2+x+5u5nTMCUp9rBW0brUSH26cNNgxX2THjzBoqo?=
 =?us-ascii?Q?7DVOaeRaL29JEZm1frt5MR07EXl4SpenOxAhfPabWET/o4S3w/LbRfoSntZw?=
 =?us-ascii?Q?pOuKmuGFeMTsDyxxOHeaM8gRBXRqFsw+jqtCTLdQOi++8VY2SriC/5wbkSBf?=
 =?us-ascii?Q?o1n+x6XYlf8r0QPx6mkvc7l5H+3xuJl7g87++mD1EeXwLfcwy59f2H1LowKi?=
 =?us-ascii?Q?smCzX9yIuLIr/zy1hBMZ/YRjyyRVhuocCCiYbRS0fSZBdH1F3xBF3+UVw6nY?=
 =?us-ascii?Q?urFWVKoZ+/CNx6KD45IeSz2qLOzTA4BCy0TMPMOGF4NYAQGyIq7QlNQEz+4p?=
 =?us-ascii?Q?YmE6P4pC1fJ6MZQ8/N3Yh2KFbb8FHnaXsLxnQZ9GF+5M0xXPylQLUm/MA6Rp?=
 =?us-ascii?Q?Zqolj3MO8PtYam8lXJSLRG8Pjr0PMssByvKLiNrjJ/vacSXKdarbz8hA4Mvf?=
 =?us-ascii?Q?akmD3wZ6CHp0pHWcWbYQ+nz32JbscU6cpAAS+139RKxanKY9ycmBrblDK2Z1?=
 =?us-ascii?Q?adRVeCVM7QQ/pOcJfFMqJ3LAfVgbsEmVLchxCgaLlYlOtlJItkByXkELirIj?=
 =?us-ascii?Q?U5iFM1f7rmLMakskMx5OqSNy9tCrm8sWcx5ri+EgsMwex4H4QRLkBtZf6jU4?=
 =?us-ascii?Q?yKUY8MboLssKl8D5zVKGK17n7rjkMZsa1pSdgmj01VFqsdDSlftSV1wmibt2?=
 =?us-ascii?Q?seT79WnF1mdyRJbbTQgDvuP0Rv9EMCtihGH/VMQDdQC6UvedEuCEil/lDl+Z?=
 =?us-ascii?Q?RuH+2pZAwWubBsiV4gxpafk34dV82O7NkQEtgRpc6ID2T7K3h3/VZ36xR0Tg?=
 =?us-ascii?Q?AO9ZHr2R72EtpzcUQWLgypH2E/WQw94U5wWknZG595Bs57kURognoDWYu0ou?=
 =?us-ascii?Q?6Axlzxy97zFJCQDH5sNtaE0CGmS2m/vYkLbUCGysXHLUAlW/m1r0hrTUCeWO?=
 =?us-ascii?Q?kk7McjcryY7ZojnE2Hz9HcXbsguPZE1v8sYIrTsElG7x92zFu0Jl2txuVZJr?=
 =?us-ascii?Q?6Xij93E+qWm4DTi4JnBKGTD1rmZx4CZynvL18PybK2cZER/xK1xB+UovY1UU?=
 =?us-ascii?Q?r4jTwL32Jk2sW3R8PPQTq58P+KwpcYQ/lUYE+AzBO6Vny6OFEkEL/t/0t1rd?=
 =?us-ascii?Q?aBB8agtbEjq68CxkudhhH/6SdQOqbGB8JLLpLe/9JzNzu5BR7zsqsFaxUk1a?=
 =?us-ascii?Q?ihRIUfVWfdL4ReXKsBxYmZxmf8Jct7Af8i2gSjHVY7Ld0tKRIsLUjpBBzwr/?=
 =?us-ascii?Q?BixTLjoazvGtt/6Hyo64l78J3A9BilOdePeNfswQp77YoXeUHYHmqzOkEHDE?=
 =?us-ascii?Q?OzL4dP6+GZtILqeXasaa0ejeRQ9i+lj0TCLB3BKU3DSFxeZES31IolruR8xc?=
 =?us-ascii?Q?Hy2jmtrMju2Kw7L623B3A/xEdJRb3epqVY2Yb6IcCotZs7mgv/muqDFO6254?=
 =?us-ascii?Q?dIB9tFJjv2uDkNpKf+jihAbXAAd0qgKcoZy5z4bR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b87a1b-e837-4d69-4894-08daf3d4f54e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 13:08:40.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlEEdKPd3WeLhhe543ybgP70XilEQmxp7ODZxLSAVBFW7d8t9LrCaLj5+OJINdf7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 11:16:32AM +0800, Baolu Lu wrote:
> On 2023/1/10 21:25, Jason Gunthorpe wrote:
> > > +       } else {
> > > +               if (!pdev->bus->self ||
> > > +                   !pci_acs_path_enabled(pdev->bus->self, NULL,
> > > +                                         PCI_ACS_RR | PCI_ACS_UF))
> > > +                       return -EINVAL;
> > > +       }
> > Why would these be exclusive? Both the path and endpoint needs to be
> > checked
> 
> If the device is not an MFD, do we still need to check the ACS on it?
> Perhaps I didn't get your point correctly.

It always needs to check the path

Jason 
