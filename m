Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E268A246
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 19:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjBCSwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 13:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBCSwl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 13:52:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83C9F9DD;
        Fri,  3 Feb 2023 10:52:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erxYqtEzr8Blkw7gVQRpKc2Aub0tJv1/jCGLr29JnJxQHGfbOxzb4nWI4FOxHMMRVzLRL8FuL2SBkg/c7W+vgpqjFXhjVroNHul5E7u9JOXR8En7opEcWrJqUy+95ZtsDD9gRk+XUVMeMC8sYRsBEprCxEnhIPQNVCgo8miRogrIg45A8WAtAvncHo+aOA8X5lWHV4+9ZSSLp0xuKWAIcFLQEuyB47d5aHFz3mTneYgF1MezH199COopWy3Wj2/muSpsPprF00K4oUkSkhGpImiTwZT7NUnPW5DJyuSmUHazZKpmIG3OkD/hMlo+f4KC+CrqyiGJVa20vr4dQ8gzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7/S0qHfm8J2YDs9e2MHlHOiHwqFWe4UZ9gbqHWadfQ=;
 b=KSFU3lnRfoz5WNf9zaMYGVtzgqnKmZIsa8CbrtfSBJURlR9dca+iYTRjBS092vGtxz2wBhs6gvZZElWC+yrtBJXNOwaO3fi+5mItTI3XHzs2IGJGs/QRQavVLyExcTdDlvSLXC5cqctR57ctncSeX1DZvE1mQqCpvBxiQ5S67c/taz4f993w8asCcdtqa8JZPQOpj5YdvGgydS3+af81etBFaSUyMoR3Vhg34ha+y6Jv1S3ZfDO980nts5ZCNjG+Q0YPPuAcWEnnvzJe9BOro+TzAs+LIPBTcsjaN3WkiVrsBKqF5eaomytzPdzvwYYy4D2MIAa0iRu52M6WUms4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7/S0qHfm8J2YDs9e2MHlHOiHwqFWe4UZ9gbqHWadfQ=;
 b=r6/ylwF6LozLcLhJOuTdjZkp+MSFudZz+ZRjx+3OYvhnL0UxwFE41gQsKwuLr3Gaue0ndMqWHmB2UcSlmdbEFcFrAc0zjvxQf8v6w0e1dhvlbffoq0W6IUtCxV2rRxLBMzzP6JRNBf+6sk/kFawhU6bWZhiAZ8VrP9Pm0XMOBjjFTJ5XgoJK1ZpabsgYj5Ayldv6sWzq7xDH9+fap+cFY0JNlTuMBwSXSBqpHeT2eSg+HRAgcUwuXQZZtPHI/JhMza3FRp4dunA/Mnwndv0bFLJAvK/26OtTe9CHLq0IlJovID4X9DVOjLV4pcM8Ci3wCjMJXiUaRtbv59g/wGVbqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 18:52:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 18:52:38 +0000
Date:   Fri, 3 Feb 2023 14:52:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <Y91X9MeCOsa67CC6@nvidia.com>
References: <Y9wg0Znc0tRWj4O9@nvidia.com>
 <20230203182045.GA1972366@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203182045.GA1972366@bhelgaas>
X-ClientProxiedBy: BL0PR0102CA0026.prod.exchangelabs.com
 (2603:10b6:207:18::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba00048-1bb7-4a71-85f0-08db0617d1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8u2bQmMq7VYR1gKimRcCWSBxh5Mqx/Zx4g4dSTKjwY4unOLpEBPbPezNvA2ru8peQE6HsZQaXMLpD1vBKzREuaQ+YJPVoTpqlqY7hRQfERvmgfhjbwtdRc4FqMPb32Hf39RtcOpbYrxsMYUi+yJgflegI8pl+8UvrEWiNPWjDekZqr8G6bl0A/bPlmoL1Owj1sJtCmLGvdGbHTAF5ZgnrHw9FR1A3g2iLwQuHIWfdLqPnFU/XwYSempyBTYkgy4D+bHwQ2xQuHfQMOxLYdSG7cqK1PELk27S/6Jnk89eY2SKv1AWzxfPp7v7guJrePYj24Z0n9zjPe/7TmbC32ruM2JF9r6rvB5fA/rq+oU9cvhu2WkpY1w+bRZ+8jAaf8rYdUJm8fXv/X+QFpmUMtNF6O0SlJ8/KLWoveROJbKWBBV4OiOZFAHuLdDbDT7SeQYKbfZwh8LdkTdCLEYNaKB9UxJJ3O6DJyeJ64SRbVyBOeiCDXfsQCMYsjgHSKQcgRiZBWPLO2+bKpwp97UnO73UpdfKHmchyCIwSJMwLwaFk7yYfi1OmWBCqSsZLE6X2QJAoernzz2TpvlV4Z2xOYKyfH6hm71vWp6Lx8aAf8aTkSmuoEfyrdlg4Uwg6aggb5Y71P2ylR/5sWsnzY/QkJ5Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(83380400001)(41300700001)(66476007)(66556008)(8676002)(66946007)(6916009)(4326008)(316002)(8936002)(54906003)(36756003)(186003)(6512007)(26005)(5660300002)(7416002)(2906002)(6486002)(86362001)(2616005)(478600001)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zIZj4ZlyFLldWk7lXqfboLT9+oIEEJpSRAeoQVlvddEdLt3hoxwPF4TTvZT?=
 =?us-ascii?Q?BzwgomjIQ/FrrK8Rg/HSdDAxLg1alEd8NstWtQmTqJV5A0gX3PlIFoFVV19H?=
 =?us-ascii?Q?UMVnEq1uWs6DO4GSJwSJ8ChTz3yqTNN+g/z4TkcAnjWk2UlZvDFPLinntP4z?=
 =?us-ascii?Q?C9N107JWFPcmevUJwch7iVY6CdZpxq522ib//SJgyTSt7krabqcO1TQ2ag1p?=
 =?us-ascii?Q?IGU8pmhPvh/xQQOc3wayvMBhHHX3NJPTdsnteytDsGU0XOTqq4VebpBhPggx?=
 =?us-ascii?Q?RQhESSFGDlX6TT3BoCf4Tc9O/KqbbWZc9DJKKltEmr6w9rIOVjFCgAXyrt/Y?=
 =?us-ascii?Q?6Ln/a7bNEve0J6aS//yv/MkcxoAuBsoqC3Mrn77pyjcNL1k6mJmMqmd0mCAx?=
 =?us-ascii?Q?QuflN4jDO/FRWTgK1cCy5m/hMGlfx62kV0DelnoZisZKI8lA0YJ3TNIC6ZwN?=
 =?us-ascii?Q?7VByAfEwW9sHv7Mv3+yWagJG1gWbxE9MMmo3vDYh+yFHhjgElubywHB0Zp5I?=
 =?us-ascii?Q?2HPtQG5ipDV9tP5H2Tm4ZJZTSvPHNn4CBC2L4DL2EUVlxPxpkgNtSVpQ3njt?=
 =?us-ascii?Q?SOhF8Y9NM7rhVP6C3ChEnzVSin5sgYMXxQryYbQPmLlSgfrGYUiS0vq8BJEE?=
 =?us-ascii?Q?O8OjHvd3rMF/QtNS8V9E3pW1MXjUKvyZE3+Ujzt+HdNH3nxjhQx488FlQPZy?=
 =?us-ascii?Q?9EFW5+FN5jhY1JqMchucnSj3OhAA8NsJFTUfkjxKcna+g3B4SPU3NI0ueUTd?=
 =?us-ascii?Q?yYViPo4YeVCSY0MIOV8LLBMp/M0aH4iv35Ks9/ilcsUJSMEiLMnluf3A1X1R?=
 =?us-ascii?Q?G7Hl0kbMgDrHNCrJPGJUgMbmR1Mv+g9vO3gKlFnVISq8ec3H7eKeCl0+4czK?=
 =?us-ascii?Q?ubnL6AaWDK6vsALlXDQFcsoqrXpaBmZDe8z+FJv3O4F6YZ4eWKiZq/eBrEJO?=
 =?us-ascii?Q?YaXdQxSgJNYNHmm1qeH0UJSNl+UXan5deZvpyQIftftr3WFLmNm6Z0wCgG3z?=
 =?us-ascii?Q?k9GdMaSZ+F/5l3SRSIdaZrOn3nzSOsBd+chwrMgvOCA1npUTRc+9wa2uv9sr?=
 =?us-ascii?Q?+WlSlI+TOJnhp+u6hOfm3YyFfFzoNmUpqtZI69wGKjyaFuDdfNMzP6ukO7DP?=
 =?us-ascii?Q?m2yHcp93zTGdICy0h9b34kMX0K6ea5wqb7pjd8RMEkXh80z4mSRijPxdDvGP?=
 =?us-ascii?Q?a7mgRM8G3pOLie1kIcAf/eCCVGIwvgz/zBj2ywm0vF+72ZaqwKDce9hzgBPE?=
 =?us-ascii?Q?ElTHLvD8V6qom3i8xCd2+0QKf89qr63dvJZdzphqCi3xYDl/ZmPfJVCS3T3w?=
 =?us-ascii?Q?Dfh1dgm5lKCDNwJNq3IXDU9l4/GYRopDU8DH4iqx6/Awvkq6DkPmI4fKC5ue?=
 =?us-ascii?Q?ob2sMwarkmlpQ/+YhUSLgDFeKhDQ/83T/5EtWhTTr8zA6RY1K8ftwJ3MpBUJ?=
 =?us-ascii?Q?7/dlXymCfMrViqrEP4t9SJWPh4OSL0/PW891hXCbqTH4iVeEL1knYEnDhIAZ?=
 =?us-ascii?Q?H7A3CKzO/htdGCBlyWUWnh/8kSL/EXKjQdrWgSrBP7ymkHUUf8GQBrnYXuWE?=
 =?us-ascii?Q?sLLvyKoVd1kYmi8mxBJbMrh8qlCxt1mOm1M/Dkas?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba00048-1bb7-4a71-85f0-08db0617d1d5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 18:52:37.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEtzNHRmoAEfbakMHv9DFoGB+BcSdpLsRQmRqHLwjgUYTBzgsWSmH+iVbRUAhMSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 12:20:45PM -0600, Bjorn Helgaas wrote:
> > The PCI rules are a bit complicated:
> >  - A simple MemRd/Wr with a PASID will be routed according to the
> >    address. This can be mis-routed
> >  - A ATS translation request with a PASID is always routed to the host
> >    bridge
> 
> From a PCIe point of view, I think these cases are equivalent because
> a PASID prefix doesn't affect routing (sec 2.2.10.4).  A Translation
> Request includes an Untranslated Address, and if that happens to look
> like a PCI bus address, I think it will be mis-routed just like a
> MemRd/Wr would be.

So, I trusted AMD when they said this is why their platform worked, I
didn't check carefully the ATS spec language.

But looking now, I agree. I don't see any language that says ATS is
routed differently, if anything it says it is routed the same way as
MemRd.

AMD folks?

If yes then this has all been the wrong direction.

> > > Do IOMMUs allocate (PASID, Untranslated Addresses) that look like
> > > PCI bus addresses?
> > 
> > Yes, because it is mapped to a mm_struct userspace can use any mmap
> > to access any valid address as an IOVA and thus PASID tagged
> > translation must never become confused with bus addresses.
> 
> If PCI bus addresses are carved out of the Translated Address arena,
> the MemRd/Wr TLPs should be fine,

Yes, that is my point that Translated requests are fine because they
already carry a Translated address, and by its nature a Translated
address cannot be mis-routed.

The spec actually talks about this whole issue see the NOTE at the end
of 10.1.1

Per that note, for Linux, the "implementation constraint on the TA" is
that the TA requires ACS so that Untranslated always routes to the TA.

The AMD defect is some BIOS's on some of their SOC's don't report ACS
for the MFD, even though it does presumably implement ACS.

> Are we on track to fix this before v6.2?  

AMD? Did the patches you were talking about to fix the oops in the AMD
driver land? Can we rely on that to fix the black screen for v6.2?

Otherwise I think the PCI core is correct here and I'm loath to change
it to work around a GPU driver bug. The GPU driver should understand
that PASID is not supported because the PCI core says so. It shouldn't
crash and blackscreen.

Keep in mind, from a PCI perspective, this protection is a security
senstive check, described in the spec. If we drop it we expose
platforms using SVA to a potential security issue upon
mis-configuration.

So, I'd much rather leave the PCI alone and see that the AMD driver is
fixed.

Jason
