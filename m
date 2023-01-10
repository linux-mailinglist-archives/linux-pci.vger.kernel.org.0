Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20A6641B0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 14:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjAJN1A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjAJN0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 08:26:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE544765A;
        Tue, 10 Jan 2023 05:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5KjfCeDLmkZ2r9sPxIDKeCHm4eyBKgIY9++grzZ9IZeNUT0HJG9Ub6lRdR2OosQuSnJEs2DOY7zzhVFwvg88KdZt+i/XqLrFmDGGuqHBfKI7bLr7Jh6BgaZh0oqbbzbZsI+/PjDzddx1jASUy/pg/jBPgaBs/ReuZtUT2dkRUx3ccVgfUXGSS1RB1ZJ3boy+3pjEQFy+OBmLov91Hfau/S9KcZvSdjrBWLHbJ0NNrOto3ADjuhmsmpSsRZFVOGHcC9psgK/YhHbmaLnSBRp4k2GmS+o+FqoofU59+Bnumh1+X2nrUd/ordy8U3duU9ek97DawR9CUX929EHPF9Yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meZQwNlzPWxJGmSdggnEC8F+UR+wCQ/fTvqckuydb74=;
 b=KdFzKM7TnNmDIFxkZ2drAbJNwaUyu+bwSikdb3Nsh4rqgLtvEhjIc/osH6sVsWxzXznOpdrPEv1ZQywQEHwPA6Gylwrsk536ohJ6amJPQiSYii/MLWEqQLzKAPp4XswMfOEZ3MQty57Fa3tOIm1xwkVGTNgqnqUYRNPCIEBgBwmx96fhHMauEnhWkslTqmcYbHaTYv1YNLJspK3/dZkZQrukDoZo5mavwiEs4L3d4nC+1EVcnpwP6SqiK44dRabmKvNS4iyiB+pI8SQWHU9u5iRdi9ctGzoD3D2+ZMuwHpVySugLPFmLNitAtnr1V8xsjBBuMR88nJ78sKhrJK79FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meZQwNlzPWxJGmSdggnEC8F+UR+wCQ/fTvqckuydb74=;
 b=tJ+rZwHDsSynGRTxPp/qIjf2EfxDLGKDdnmWB9KQORAX8fCwHfchiMHyY8jSWrX0aUcUREaLVV2WLJL21xB8AvtqbMXPCgffllgNK9m3Kd0ygSu7bZ0gboJ6Kqh5IsfR4DW40lZoQrJgFCarsQkG4kW/Uo6BGgMLBwkVeICZKN7in1+/NQr6cuG6m2z+VNgrUfMKuQpnR+rrfDlCvUfDtfJiua+PuW40a81wGuWqzo3FGeO4ImxZTmHhq0WAyBQWsjslwLhv+rp8Nx29Gy/m9EmXeJLQo4kPzITEPBOaj26VB6k+Ti5itEEHY08YEKH3H+36XE3Qw9IcHnyjBTqBIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:26:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:26:00 +0000
Date:   Tue, 10 Jan 2023 09:25:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
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
Message-ID: <Y71nZuF5wQp3eqmn@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bd86e2-15fa-4989-fd75-08daf30e36d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfw8UTz0Qf9SG4i5uhTNJPOVMndb2fN3pEyZ6TzJrVlnDUOZKnc1Bu+AZt/3R/RgBq4gGoZ/1ReVV0A5XgYJoEBcvCgRA3pbnC41ADKgo0ATzWauq0WySDGY7kgAimWqkgrJY2WK2R1ai1gDsZDbchYIpBFLNTHWBsEdUlSwxOF2w/85NEx56BOdSBLTmDzj+K8/owibozINU4VQ2A0nH7dVHUUQ1JhZG3PNMMqgh7AKyiu037X2/JmXNpO0rxL9fiA+A93HdYm7iEVWMysC2jrUTZg6oMURse3xjhaBD9xLf+jjqKe5g+aK1Ngbx24/IBKmuTRce0ZLouJHkl4QgFVN0vfVotSEGVYfrvwh/X7vIRgEaz4gX2mhcH+fXqf0wq8eWzoJpgudBf9lw1XVd7eTK1hz5px3oW7FaC7Ndm4PvjaxjnV3yrUwFyyMvRu1R3SkjBu89SQEFQWdIlXDgC1eI5bdrls6b2xbVmG1Lr62FKbtCD/hQqsrTFghUYIfhyTI9bQQ9kcJRnearia8gMmC7rI0J0uKz0TDQb5k6ls3AgjY62KDf/JaV3DgF5fOdlz1S/nacPky6ONsh/w2V15waMfVmBDH1HYYYyOULRWdu4IuXIx1QE4sGLa8txo5ACljsqzK2etwmh0dIIgT9AZYPLO+eNeiCJ4EjsV+MMPlOnCQbsEfMvQs9ljE5R+CUGTHshx0CMpxCnX6Z+fEkyReJ2feCe7Vt+XqwK4lAbS9w2pAI6d2Wso2yZ0n4AgKaMClFkhZMtA/f0/8zFWUVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(86362001)(36756003)(7416002)(8936002)(5660300002)(966005)(83380400001)(6486002)(6506007)(53546011)(478600001)(2616005)(26005)(186003)(6512007)(38100700002)(41300700001)(4326008)(66556008)(66476007)(66946007)(316002)(110136005)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkNrg0KyDZEtZpEcwwqUqDfNSHjPmoD+KA1ehM+8PqcByTF7FNpQApgy4x9d?=
 =?us-ascii?Q?MXLSFAGtNMmTkvaziy3ETBk+OBJNeBf+3awJGNteiTQolbNdb26uQ75XVSk+?=
 =?us-ascii?Q?Q+ob1GUu78y4QgxwilE131eBztffqAWBQwZsaOggrfg6b7L3dGiCLjPBzmPF?=
 =?us-ascii?Q?rm+9SC4QjS6adPpF0Wk8NtN1cvB9GwXREwOC6db7nB1uULa2KZxz2BPzsx6E?=
 =?us-ascii?Q?UARmDp1xQ1CX7kM9DAmlVnXpq+9d2sOrd1Y1zHgYka5iENV5R2YH0K4p+10X?=
 =?us-ascii?Q?CMWPltc5oNrGUlQHHnOUZKv4mnA18kugbZIos9wTdDLNVt+gApWxvPOTKEK+?=
 =?us-ascii?Q?EdXYK6itiuhOWG6L4/eIXZ3kcwT0/fVoc/Biey+611huqHb2EImx96XqFPSl?=
 =?us-ascii?Q?nN5h0NExhOaxYdjAzIijOtIQknhPUjVpHLYWm+l1YvLNfa597jfnqjvJQE0l?=
 =?us-ascii?Q?WV4R19HOjT1YCdXv0oRugJKtBlhd1qF78MVHD7+DW+tE1487nmzckuSrkPx+?=
 =?us-ascii?Q?yQXion/Bs2eNCAcuRhHlkW1fn3nU96h6UBfFz4BJ2AvdyiIKo7Q4jQ41WMrc?=
 =?us-ascii?Q?t59KlnLtHVinKQIj2Slpyz+2efAyxEeIObgULVvE6epK3ychHGTlp6AfydDW?=
 =?us-ascii?Q?yaH3d3Hgh+1vt2jRmKX48772L3cT7tTPCJKDeGTikEK6YLPEpVi8WTfaCSF4?=
 =?us-ascii?Q?aM+P9o2f6pUcEfxTwEK+dR45vqb0jgbVH4AkjVU/LXR4Mt5Fog6zTh2TKGU+?=
 =?us-ascii?Q?15aqoufF5mZw7CrIZuTV1hqi3PZpSPlBhi91yXeXXumI6QDATItHwcD/FgQc?=
 =?us-ascii?Q?JuIDTHJnPTeSjj8uPEpcJ4Ee9UXg2skmUDZyTMZJ4T2Tt7UVZokpToG0RZBF?=
 =?us-ascii?Q?s38sH4ZUI25R8IqxCvqV3JOiSontxoUnFgZNQUNQ+OzqYCyNatp+rvvScONx?=
 =?us-ascii?Q?lk1yI6HbW/f96FR5EHgEK5/Ux/Y0U4SAX7v84uzCi2US+RP19tp0+l5cJa59?=
 =?us-ascii?Q?LozFgW0J8vuhh29LxHqnyghQogQui1iXWXm22iWr2hYxgsoiVkq8AhuXmPAF?=
 =?us-ascii?Q?U69kGWxoe3ybhmR9DCA6X2KoKW/JBnPdlUsBYLPg9qt1LbDJMqRG+3XYSq1z?=
 =?us-ascii?Q?5uWJxwWzh0cq8bhOx5coYDFSRcDEIIR8+Vgaljxe8/wNGIQzPkcq0S5PHLoW?=
 =?us-ascii?Q?ndxBXpuUfrBaGllCv2qJD8c59/ZQ6s0d7qCoKNYTfuwdcQMKzSghPJ7JQF7w?=
 =?us-ascii?Q?FSyQSwWbbibF3vlkSqxC65NjQHuzMSNkYustZxzBnvgHmFYi4AxGh755abxe?=
 =?us-ascii?Q?ZhqJ7ZWmW3+BT7gqitRa9lTdrcIq6VgdIzNTf0Jy59FtmfB4XAcs7FpuQBx0?=
 =?us-ascii?Q?bvRajU1X4D6Bk5CFMDq1k3s0QVyZEAPJnI3QoRIi4TOzdfg5vppAaqDXXg3g?=
 =?us-ascii?Q?HWGBxUA4qiF5R4/dHaW+DV4LBxgKF0Mfhk1887p+/+YH/cmLrEA9kXwmtDoR?=
 =?us-ascii?Q?62sJmXSiiM/ni1Xxtt7OKW0/SuyzjAN+aQ8jixzaCKUW0amMCgHDV187TT4H?=
 =?us-ascii?Q?pY5R2Y3irSWtagudK2vupnKvTLLCYTNEmYzfPoGX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bd86e2-15fa-4989-fd75-08daf30e36d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:26:00.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkudYMYOFIE+ltRC4ORwJSBXzRQ2Gbhwhq320Mz0IWi8/4Im83ACiDNYG7wWiX4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 01:48:39PM +0800, Baolu Lu wrote:
> On 2023/1/6 22:14, Jason Gunthorpe wrote:
> > On Thu, Jan 05, 2023 at 03:57:28PM +0530, Vasant Hegde wrote:
> > > Matt,
> > > 
> > > On 1/5/2023 6:39 AM, Matt Fagnani wrote:
> > > > I built 6.2-rc2 with the patch applied. The same black screen problem happened
> > > > with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
> > > > patch twice by panicking the kernel with sysrq+alt+c after the black screen
> > > > happened. The system rebooted after about 10-20 seconds both times, but no kdump
> > > > and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
> > > > requested.
> > > > 
> > > Thanks for testing. As mentioned earlier I was not expecting this patch to fix
> > > the black screen issue. It should fix kernel warnings and IOMMU page fault
> > > related call traces. By any chance do you have the kernel boot logs?
> > > 
> > > 
> > > @Baolu,
> > >    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
> > > with your fix it didn't enable PASID and hence it failed to boot.
> > The ACS checks being done are feature of the path not the end point or
> > root port.
> > 
> > If we are expecting ACS on the end port then it is just a bug in how
> > the test was written.. The test should be a NOP because there are no
> > switches in this topology.
> > 
> > Looking at it, this seems to just be because pci_enable_pasid is
> > calling pci_acs_path_enabled wrong, the only other user is here:
> > 
> > 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
> > 		if (!bus->self)
> > 			continue;
> > 
> > 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
> > 			break;
> > 
> > 		pdev = bus->self;
> > 
> > 		group = iommu_group_get(&pdev->dev);
> > 		if (group)
> > 			return group;
> > 	}
> > 
> > And notice it is calling it on pdev->bus not on pdev itself which
> > naturally excludes the end point from the ACS validation.
> > 
> > So try something like:
> > 
> > 	if (!pci_acs_path_enabled(pdev->bus->self, NULL, PCI_ACS_RR | PCI_ACS_UF))
> > 
> > (and probably need to check for null ?)
> 
> Hi Matt,
> 
> Do you mind helping to test below change? No other change needed.
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..48f34cc996e4 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -382,8 +382,15 @@ int pci_enable_pasid(struct pci_dev *pdev, int
> features)
>         if (!pasid)
>                 return -EINVAL;
> 
> -       if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
> -               return -EINVAL;
> +       if (pdev->multifunction) {
> +               if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR |
> PCI_ACS_UF))
> +                       return -EINVAL;

The AMD device is multi-function according to the lspci, and we
already know that 'pci_acs_path_enabled' will fail on it because that
is the problem..

Actually, I remember it is supposed to be like this:

 https://lore.kernel.org/linux-iommu/Ygpb6CxmTdUHiN50@8bytes.org/

The GPU and sound device are considered non-isolated by the group
code, presumably because of the missing ACS caps.

So, if I remember the issue, PCIe says that MemWr/Rd are routed
according to their address and ignore the PASID header.

A multifunction device is permitted to loop back DMAs one function
issues that match a MMIO BAR of another function. eg the GPU could DMA
to an MMIO address that overlaps the sound device and the function
will deliver the MMIO to the sound device not the host bridge even
though it is PASID tagged.

This is what get_pci_function_alias_group() is looking for.

Multifunction devices that do not do that are supposed to set the ACS
RR|UF bits and get_pci_function_alias_group()/etc are supposed to
succeed.

Thus - the PCI information is telling us that the AMD GPU device does
not support PASID because it may be looping back the MMIO to the other
functions on the device and thus creating an unacceptable hole in the
PASID address space.

So - we need AMD to comment on which of these describes their GPU device:

 1) Is the issue that the PCI Caps are incorrect on this device and
 there is no loopback? Thus we should fix it with a quirk to correct
 the caps which will naturally split the iommu group too.

 2) Is the device broken and loops back PASID DMAs and we are
 legimiate and correct in blocking PASID? So far AMD just got lucky
 that no user had a SVA that overlaps with MMIO? Seems unlikely

 3) Is the device odd in that it doesn't loop back PASID tagged DMAs,
 but does loop untagged? I would say this is non-compliant and PCI
 provides no way to describe this. But we should again quirk it to
 allow the PASID to be enabled but keep the group separated.

Alex/Christian/Pan - can you please find out? The HW is:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca) (prog-if 00 [VGA controller])
	DeviceName: ATI EG BROADWAY
	Subsystem: Hewlett-Packard Company Device 8332
00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini HDMI/DP Audio
	Subsystem: Hewlett-Packard Company Device 8332

https://lore.kernel.org/all/223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net/

> +       } else {
> +               if (!pdev->bus->self ||
> +                   !pci_acs_path_enabled(pdev->bus->self, NULL,
> +                                         PCI_ACS_RR | PCI_ACS_UF))
> +                       return -EINVAL;
> +       }

Why would these be exclusive? Both the path and endpoint needs to be
checked

Jason
