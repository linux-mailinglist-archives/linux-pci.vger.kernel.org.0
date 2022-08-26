Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9015A283D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiHZNIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZNIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 09:08:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6711F2DA
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 06:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiboU76lwv6bBWspChORjr5UknFui6h1jet/US0Q4IB+6fTcyah4yN24NIklVXYHVWnlzICVuFDo9DOi8B/ip+qQU3mKyPhXPhvmQLvMJf9q4cCKQxWydzpwa+XC2yt/LGca2Zitlz1IK4hBoZw0zJ8RUK1+TpZgkEfCq3iFnjUuYLvs5PmE7xgxzcOhwTQhCWa7UcgtdntMsGbgviEAUXLm5fQ9MoK98IfFNmvWaJ9ir7kHWWHradpOMQsvkcp5yf59y3FxxFh0yZ258hZgvBSM8hpLBJGkkmWaMuXflduPhOHVGJq5iaplZsoW4hgTKUGpp8iQn2DAKMUOfkUXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/8n98CMxmz/bmwz0MtNmyJWUA3xeKmajjzTiSoX+50=;
 b=kRsjUk5Y8RNCCL4ocSUMOW01JTxyLT/cRAFce5e84P/hVGKwofxBl7ptoxTO9bxktZBHGoLTO/wusZrbAuz6t/80NYWYi4J804Oxt9Jl/TkqVZRuGV5xSKjyhtboduMUGr1tI3xbNzcDpSOFTaS3MGMXBGCNxQwp/8DO9YaE8YFa0V/i/wneQByAs9u8b4R3n65otuvdecHmqtjMVLSmE+ot0PMPLHvSe9WqLViLX7SLZIvNM3w77KRetqZzM8WLdR+vK9zztrpqcy60mzig8cG/BFNjR4Z0tvNvinVGjI+6qSzKno62rWWyuzPHcJ2MN1WFbmr6iIKXaUtZHvfJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/8n98CMxmz/bmwz0MtNmyJWUA3xeKmajjzTiSoX+50=;
 b=pEE6Wx987veava8O50BGRo6jZaPyT4DxgjitqOvHW4YolI630KcGECMNNGNd/vs3VT3jEmmXKNi8QL3oIyW5kKnHJ50406UDyD8Vn4tjcwzgEzmHx0/tubSS3Xkf9504bjuiew6ZGljYxUtkJMvh6R/B7gL9Kxc5XY3URurKqZNoXQxIwLrurvypUDYme7/ZLG5ex/L2+7EomTi05TK1EYu82Bk9WRTJ8gKTvPJ1QQ97Lp3BG6yj8hJydV2HALCelJy9UW6HEuGXGkm93pXQLWEnLnBXtgqSu+kTmtBIRHnQqEZbvfHIHfPgkMQ8WthQl4anfVrDFmQQ3ek9qS+cCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 13:08:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 13:08:08 +0000
Date:   Fri, 26 Aug 2022 10:08:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josef Johansson <josef@oderland.se>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
Message-ID: <YwjFttmi09hTrQTu@nvidia.com>
References: <Yu0IwZXyTIhdALMb@nvidia.com>
 <20220805155336.GA1005417@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805155336.GA1005417@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e833fa6f-0a90-4fb3-098c-08da87640506
X-MS-TrafficTypeDiagnostic: SN7PR12MB6790:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UlnQer6N5mjX9hQPmmKwcITzfUt3ABUG/hS9FLXa97plwcyvpJPzZes+qCkw6YgkA32AoEPUjtGUPs1DxEmk5minl6qvfIB95YdToPfI4XlV0m3vdg2rDdRrnDGAz6DKvkeVTiv/G3yHHMD/rLDiRP5QeGiK/CIzQHWdP019mjEn6kVBIQnef5xTBdlK0OiH9YYUa0LDYwOLBQlSbbZsEuvdJ0TwTMY0yeWEEruVCrJASyQzVu64KPP8kWNz05ssqfluB6L0HfzgnJZyefCH0uwsGmn8T2b9QYT5W2c2ebq+a5j4fDgfEt0xUZ35XjzsEZSwZPORsjvUXIXQO8zIKHYVOfYpEbsjZp+Q8PamXphtzO2nIHGp6QX/ohs3QZdfvBoYFf4vK4zy7HNRpzRNRYaEE9KoYR9x6BrxMaOKhU+tF6xr2GQL8HiFYfTkWvjZS3Ksybb/uKCRItRfqTxivPgfAAVDPysLwReWSFTPvtRtIAWPasnvk0RBJG53vVeUb6+uXUPKGrICxm2y0GhcFlACiyO7CJAOm789iF8uXNjBRMYj08pYSfgzpyDSebFhbmbgkjEmFfd/5IzOIyU0lYbor2tVswdm9lhVL5YqmlHpQL4Wh/LJ/f6+j3IkBjIeBCMCf4PI695ez/w9UccA/2aTWuw45jTYcyzznCjwHrNlxYRf4S1L78++sfz1MD/Y7RW1fsBngsmOxnxgT4eEQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(478600001)(41300700001)(6506007)(6512007)(53546011)(2906002)(26005)(6486002)(316002)(36756003)(6916009)(54906003)(86362001)(8936002)(186003)(2616005)(38100700002)(5660300002)(8676002)(66476007)(4326008)(66556008)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NK4BJa6HKBJIrjS2Wuox7jhJK2DDs0rPlCsopYEr+DkmDioRiE6Kk8IKWQE0?=
 =?us-ascii?Q?ytZ+gMjLvEsuOZDXAjbCaalcoWc8YfhRXZ/t3EfWg5KbQtgZp7fs8ds3t6vq?=
 =?us-ascii?Q?l40+AB+R7Lux/TxsbyLIPPZEcQtMl6wgLhG6Jz0M6K8uXcHcOgcFRyZaoh4J?=
 =?us-ascii?Q?vyBhEWB8HZxUCFQSnb4xEpznAU+F/J2T7Lei0nFfWxbpNh5SC29O457nVtGS?=
 =?us-ascii?Q?J8mdVAJg98QsMWgDcyk0yBuExZchJ09oo/eEs9P7wB3jh/GBznc6UqRzSx2G?=
 =?us-ascii?Q?J7EHTe9UAZsJFdyXLhsCy5t6bzDIm20BXbhLII7y1vzlmTvFMQSYVIeNNNTP?=
 =?us-ascii?Q?nrgqEWPlENspeOv+93z2Qg6/6q7BLBbY5YS34y3knMSRh81q/rxIwCzFL0Fz?=
 =?us-ascii?Q?0W9YioZqPfStlsFiW/xE0N9euwP5XawXWuP7GhBzqIQA2VZOmheKTxBV3qQ/?=
 =?us-ascii?Q?XAJVeGT75Y4x+GcdTEZNzG7qVnu5m+kBSE2OvZPkmz7WJ8WtDBqasErr9i8h?=
 =?us-ascii?Q?QzDm3PIrF5BR8F3DfLFAByUbUgL1ba/NCNuSCGlA5lnbjsfAeohbNvEbC8HK?=
 =?us-ascii?Q?Xnf/wA16DBKJ3HZFo2vTxfnH1i0UNmnabnXOzd4GWlB2HzfXuFHUEiCZgFXW?=
 =?us-ascii?Q?qJQMrGv1M4dplFZZhKa0/wel+BHC9i8VCN+B+B7W0hETFgNTBjCnySDBaVAY?=
 =?us-ascii?Q?wlFCqxh2O2DnxTxd83yGRTh7sN5/nGns0qgVGnQa/BmCimP4in0qh2OpB6dg?=
 =?us-ascii?Q?m4yyJpLBHy7ufi5d815Z038BAOsDaXYTb0UuKuS/o5eT0uSlCSQaRm27Q8tM?=
 =?us-ascii?Q?w971E+Z8QQ4pM7c5vfk5p8i4PYpIMAqvcOEbuwWItbu1dcEiA3sqTzu7hete?=
 =?us-ascii?Q?SOnRe9A8NBZb73CJXBJwrobrPsHaXrhYK/3EHTzqRdvPoBvyL9Y9kFqL2Jao?=
 =?us-ascii?Q?zauel0dHYQq0ITa3zcmMHgcUJJrpn27tSSsMS7Stfd6GKr1ZrvB7oT/oIdf+?=
 =?us-ascii?Q?w0cVtAniI++bPYGfQLDE3/6pL+pZeyKE2d+yXjLPN1C8rW6rea7eIeoJD3uS?=
 =?us-ascii?Q?4GQyh6361zz8VoEtO8x44qbfaKKQZtoRYArvtf1gowEXeDZ+Or2X6+akBRQX?=
 =?us-ascii?Q?zbVNl+8imRgual8PfSRS4vDtGxlRvqWSAYpuMGQuAu/pXkeZnoKfld9dLVCU?=
 =?us-ascii?Q?LxFf3wgsPm8c5eC9jx5SfJHpPyrtgQPMDriCP8+7a6JZfYAcDWktX1v15xKw?=
 =?us-ascii?Q?P2AoEiVqgoMSTMhxP/FPdixO87twle9IhUyH71sUb1oAW5+ZaSdBwxxo3/v2?=
 =?us-ascii?Q?6WZEdMm0EHJsTAH7bann7YTe/TO3ads60MAvGFx+l7tYMqTjXHYK9qrFEuOS?=
 =?us-ascii?Q?RmnM71KoP/gX2hFAqhXFj40dFUpwiIGfCL4Nz0ZLze3nYbAsJIXB5gIrGmwu?=
 =?us-ascii?Q?d3iYc/Ii/mghf5NwfcCIeJcr7654mZYDq8JPMQ36b5BWBu6iPeT4pln2me5n?=
 =?us-ascii?Q?nf5kfSg9i5gGbEmTVQrheK1YBRK0z5ub6ukDi0mZjmOn6m7l59GsCkGWUWL5?=
 =?us-ascii?Q?2cFh1Ma2wdhkLsKe7GfTurc/H5rCAj7bKI+lL6HT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e833fa6f-0a90-4fb3-098c-08da87640506
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 13:08:08.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA+6DWejeRfKMTi+2/f8/Rirgdty0Wf2YwxsKnWG1UNazaQsLSZiKuLPQzo9XlBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 05, 2022 at 10:53:36AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 05, 2022 at 09:10:41AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 05, 2022 at 12:03:15PM +0200, Josef Johansson wrote:
> > > On 2/14/22 11:07, Josef Johansson wrote:
> > > > From: Josef Johansson <josef@oderland.se>
> > > > 
> > > > PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
> > > > Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
> > > > the logic of checking msi_attrib.can_mask, without any reason.
> > > > This commits restores that logic.
> > > >
> > > > Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
> > > > Signed-off-by: Josef Johansson <josef@oderland.se>
> > > > 
> > > > ---
> > > > v2: Changing subject line to fit earlier commits.
> > > > 
> > > > Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
> > > > which ironically was what my last MSI patch resulted into.
> > > > 
> > > > I don't see any reason why this logic was change, and it did not break anything
> > > > correcting the logic.
> > > > 
> > > > CC xen-devel since it very much relates to Xen kernel (via pci_msi_ignore_mask).
> > > > ---
> > > > 
> > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > index c19c7ca58186..146e7b9a01cc 100644
> > > > --- a/drivers/pci/msi/msi.c
> > > > +++ b/drivers/pci/msi/msi.c
> > > > @@ -526,7 +526,7 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
> > > >   		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
> > > >   					       !desc.pci.msi_attrib.is_virtual;
> > > > -		if (!desc.pci.msi_attrib.can_mask) {
> > > > +		if (desc.pci.msi_attrib.can_mask) {
> > > >   			addr = pci_msix_desc_addr(&desc);
> > > >   			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> > > >   		}
> > > > 
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Bjorn, please take it?
> 
> Thanks for the ping.  Since 71020a3c0dff4 is by Thomas, and he merged
> that along with a whole series of MSI work, I think I probably
> expected him to take care of this.
> 
> This looks like a simple typo, so I think the commit log should be
> reworded along that line, e.g., something like:
> 
>   71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") inadvertently
>   reversed the sense of "msi_attrib.can_mask" in one use:
> 
>     - if (entry->pci.msi_attrib.can_mask) {
>     -         addr = pci_msix_desc_addr(entry);
>     -         entry->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>     + if (!desc.pci.msi_attrib.can_mask) {
>     +         addr = pci_msix_desc_addr(&desc);
>     +         desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> 
>   Restore the original test.
> 
> Thomas, do you want to take this?  I'm happy to merge it, but would
> like your reviewed-by or ack first.

At this point I think you should take it Bjorn..

Jason
