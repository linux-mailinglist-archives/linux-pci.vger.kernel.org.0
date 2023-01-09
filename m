Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C466277A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 14:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjAINoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 08:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjAINnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 08:43:47 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DB3474E;
        Mon,  9 Jan 2023 05:43:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEo0mgI1MqEoc6k+ZOzSybeWxYIimLugpJVQcaku/q0xilmtNwwmmQnJOHFHVE6eN2R2lBM6f2XvmXs/SfUK9jLAa3xhLp6qY5+Oy6+wxq6QK2o9y5b+/gbCpqkJPUft5PF6Rr0TgrEojfRANExzki4x7uMsqvM8uk4PgUOloBYNyHlPqbOJkmDXwF5qeF9HT7l+jKrzTdqA4+bjCDKTmv3HiFT7PdELzp9jsQ8efD4Xcw6DQTMuhr4K11SLdFl4PF27CtbTX2Y0dNkMA05fDQ0UhIFx9p/Jm2HV3Ca8EPfQfs81Y/F5d2ETMDkrqCvNVmezeDFXS1Ip7HjdoQ/NJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj8BP9xPNjJMBJQXV8+VkFvkrFH/AM/nKiXxfDPLAw4=;
 b=Jahi4OD/wgFWzKwHifu9+5pINscIufyvpyKMndux9PJl3SURyvztkPuXVk0wyShtf98rmgV1r1Z0pBZwQNxrIPGhjcrBqdAdjm8IemLDOryWbgobJtJLFtVA5qFkalwy3+uq0EeqZZ0VKieMbDKJLqa4GXkDlBUv89JPfVRbsVcWdJNEaWjN+gEsRbM5J8WHlgtQaRZOiZDfFnmPqUvRt+fubk//WJ5YlMPbgL4HCicAiiBalzrXOsA6kGqVSst8Fds/piVflptjeCKFqNvKRD00va13j+i7uH2SRu9XylLSPd3AH/bl1Xy/SkUa7iinfo4+LETYCci8ubG+zSOX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj8BP9xPNjJMBJQXV8+VkFvkrFH/AM/nKiXxfDPLAw4=;
 b=tVurA441jMC4alDvvkqHOnFdIA/T/tbpyvNG8Bvi0hYfbhcPoeloHMt10UpmpC6kbD0t1sxESQImD+AAYhWmTrTEY0xN5eDZBXBsz05io9yt/PGA85oo9hfC+4Cx0IbyzMKTFhjp76icESH9SRzcNLFHLn+3HFqn/IIsS7rBTUPdY9u4ZW+2spwdj2cNMBaShJ4L1bDPrXXBpDqwKfms3LKvQAYVC//mWAwV3arRgHNslEAVJV4+OUloCGp7w8Mselvxn0eQNjpDOUdVfU1N4oQ+olzX5HIohjwe3N7ufYsrFA1G4TlKwArKTUCWK8J6Ue9XR5grL0i/NDkQ20qVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:43:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 13:43:22 +0000
Date:   Mon, 9 Jan 2023 09:43:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [regression, bisected, =?utf-8?Q?pci?=
 =?utf-8?Q?=2Fiommu=5D_Bug=C2=A0216865_-_Black_screen_whe?= =?utf-8?Q?n?=
 amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y7wZ+SvT455HS2b6@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <Y7gs0zYKp/VXACBi@nvidia.com>
 <bb865b8f-6f8f-769a-6364-d46b45caca85@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb865b8f-6f8f-769a-6364-d46b45caca85@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0063.namprd20.prod.outlook.com
 (2603:10b6:208:235::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c176ff9-6ba8-46b4-f1a4-08daf2477964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Q4BEuUpjkvLUEjFHz7v4P+3a11BN2ZtalnylJ06OXgH+FslOpwkfUdIDS101C0uvRv6WbeZGHLyzio1iG9iD3r29/KQjw58AyDbwovu13XBNxKslDNVxSJMbjkGMC/VkRbLu/mCNnKKm0tOQlVYdN5lZNU7nXrRrKXzcdUED5Ii+Ar4rNFVuvGbmtCCbWyPbOTlkeGfHsgpPaChG0jreTn6NbEAMUE3qsDLhudQVGdrMazaWw7ch9zEI57GFC2qso4q4T+OPMQ2j0rdfrJwaZ14lVDrbjtQGKnTtlB9VxhAO2R+xRsTLHgFZjpNjMvR4t7BTMrqI3e6rSjxpTy8zNwDCTHF96dZ6r+5MhyliVXbvkZFbz6CRRo6QY49uLA5GJqUTWObGR92rZHuVDo0kIqz8nRURa4QV3Qoc0TEQEqs+2DW1m9jYwt6untHokyUlLekNdSUQlb1gSG0nhVreCuTPZw3h2HNFjY2clvtM6f56w3FdH4bgxf7D3VfGhSsxhZ9wS/xwZZR7Ous3knR2Te45ATHvEQDdqo38Ts26HODERf7ggOknei+tIbRfIqVQmO7Fm7k3WLAZFVoNT7M31nmCFBCWFp2vxwgMat2rizFA+OzlSqsuDej2C3MJM0RZtjYs0tweVmfLlGu0eEmhSNMLKGBwJNn+unKUIeRl0CNzUZiyLOTCRd7lC+MdEiQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(41300700001)(54906003)(2616005)(316002)(66476007)(36756003)(6916009)(4326008)(66556008)(66946007)(86362001)(38100700002)(5660300002)(83380400001)(7416002)(8936002)(2906002)(6506007)(53546011)(6486002)(6512007)(186003)(26005)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EdfabGIqSPqtPc9/Q2TsthzklkE8SNjC6NreYiKjtOa7LdrQt9gL9i36QdBk?=
 =?us-ascii?Q?uK1yPc7k92vfhj8eMmOY12hrjO5MjUdRMiLwtDoGVJSePsvO6UQQmoOrqfPB?=
 =?us-ascii?Q?yc3wf3hDA1LOfr40nDzgM2MpSN8ccai7UTBaqECGBpFIMxSb4sQCx+uVPk2q?=
 =?us-ascii?Q?I5iSEEmL49b4Af+14TCLJ9H6swfWBb6jM/P193ncQ6dumjGBkj6g8D8ka3tV?=
 =?us-ascii?Q?hK5vBQBmo2OGD5ILn1zSYVJdA/6PicGo1PJov8/uJA8GpaWHKR8Gxl+GNdcO?=
 =?us-ascii?Q?xsTXLf9pPOL8pOUTMsHyzk92JGgxPbY1cMjgTz+e8SVhVpz7RuqJFSzwojze?=
 =?us-ascii?Q?zOkfW1khxVIFbC+2gGB7Fuv3AzxDX933GNK434Sbq95oGGjt1cW9Iz2epHq3?=
 =?us-ascii?Q?E9P1I3K1EyMMrl0JPN9H0D0R+YkhFo7IQ1qUqZlIGMisAvXHiTqSBRCaZf/+?=
 =?us-ascii?Q?Lb3j6iPQbN60Ch2YAdS2524W2eQoOAiy9+phJUcVt+GaXSne04/rjpQjlv3h?=
 =?us-ascii?Q?Vf6tzvdmEfeZcebSqe3jY7xzbG3B7Gq1ulc0ptS7JDhwjIKG7hTuPo0/fvtz?=
 =?us-ascii?Q?8UfhUVPcZRvEwnzbrW4z075bg9NuQbMec2pCM6vJVangeqJRp0uhup7AIMaI?=
 =?us-ascii?Q?y1r17GmwiPgRrZvSVBOyyUPhgOvpx8x73V9aH5zTYYNxmliYjmal+kuAI6Zo?=
 =?us-ascii?Q?39JxPLhYE0Dul31dk/4X9Kh39sjYlhK4+nAzB6MTI253oxHy39a+OA9Yv9a5?=
 =?us-ascii?Q?TcdbKEYW95qZNJ0y/0TZ3IrI9XYkTcD660oP0GkUzN/bn8moqOa1BxnFwnzB?=
 =?us-ascii?Q?mhGnYrEKjwSIGGOWYBHzCAmt+IkNTLzT/9yKCoFAtfSzguiCZrK3Qx44u3V6?=
 =?us-ascii?Q?HemX6MHvfWjhIWbOB7SfOvh7dMXG4rRoh+EljOOvHqA0Sb25EuQDPHMLhiPY?=
 =?us-ascii?Q?oia/7HsD8XRij1s2IQIZ4/B2iIpawpofM9nMyCbVfw+BFEMuOkMGSs+WnAdV?=
 =?us-ascii?Q?lXEGTZIrdAMuwr/5a25+coi480aJS+iqmsCzltxIXXodQcgWUvQPLQjIJzzJ?=
 =?us-ascii?Q?vAw91dD9CkKr9B7y6sh4DiBWqcvNYuQWecK1EieTUgr6NLcGOEszGM+kCONr?=
 =?us-ascii?Q?o/Kpy3Qd3qxz+I3ofak7/PFHoDJ+DxCaXSkvQqnuBtBbDT7T4TtjYwlWj8Ao?=
 =?us-ascii?Q?OO4AwtjyxNTw7ZhQ8Ze+CO1JjFJntuPPZmex0x70Gc3oedrvi+/NuxJWYSne?=
 =?us-ascii?Q?Y8GleTQh6FnoOKO6+i6NKlMbwpcBOQaklOVy8BC5KQs9ADWbexHtftUHH8Tf?=
 =?us-ascii?Q?guOhilY/sfa7zRCN6DWA/LZbDTFTLys6DPAVg2KaPmyIP0wjdOc0Vuq0bNxb?=
 =?us-ascii?Q?RT7FBT7zjcajACLW/8U2mGl6JkGTZ1CAiqwKDQVw1yes4PhSaY3LjyDj4Gxj?=
 =?us-ascii?Q?4/d8gCnwaTXylgvgYZcYZOmvxcUs/kvy75mqP5hmXJvTvdab3yp+6SZiL7/5?=
 =?us-ascii?Q?9V+TiWF2UillF8wnnmYr0L0EdLOlY3EOINubHseDTfCS4YhMecnZgHwuXwZm?=
 =?us-ascii?Q?wqQn41EuXE1bjBZZOhWMNrx0kYeRI7eJFygCyiw4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c176ff9-6ba8-46b4-f1a4-08daf2477964
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:43:22.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxlCN//FQaCmKVrIP18tIrLay1sIXBUzF7wpoBaucjlswqaGeXRMaGEGVo0grfDZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 07, 2023 at 10:44:46AM +0800, Baolu Lu wrote:
> On 1/6/2023 10:14 PM, Jason Gunthorpe wrote:
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
> > > 
> > > Thanks for testing. As mentioned earlier I was not expecting this patch to fix
> > > the black screen issue. It should fix kernel warnings and IOMMU page fault
> > > related call traces. By any chance do you have the kernel boot logs?
> > > 
> > > 
> > > @Baolu,
> > >    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
> > > with your fix it didn't enable PASID and hence it failed to boot.
> > 
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
> Yeah! This really is a misuse of pci_acs_path_enabled().
> 
> But if @pdev is an endpoint of a multiple function device, perhaps we
> still need to check acs on it?

Ah, I don't know anything about what this means from a spec
perspective.

Certainly if a function can internalize MMIO and loop it back to
another function then it surely is not OK for PASID either, nor should
those functions be in different iommu groups.

So, either this never happens for some spec reason, or the test in the
iommu code forming groups is incorrect.

Jason
