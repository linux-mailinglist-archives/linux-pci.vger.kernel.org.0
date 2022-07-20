Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0F57BE40
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGTTGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGTTGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 15:06:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282F655BF;
        Wed, 20 Jul 2022 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658343966; x=1689879966;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W8xLERWI7GSyChLrfRy+wAEOyXHuBLnqCJFx5/FSW9c=;
  b=FIGp4+tDbCZb4rQi4+D2pH8ivG0woSB6xIaeHsOgshbZvUYgi9v/howE
   tRwbLnf9/xLlOUD8AI+22Xv3d1Dm54isbT+5sikVM06N7q/ueCFqx8Uai
   YRvDEKW1STWuF+WhSB/219eL1eEB0Qv3BrpfpyuzQqzD7f9+MRfi1i9Ui
   N31067YneSuAdBwaIRyPYHZuZphqy3ZxqD/iDEXL9TBe2EweuAhs4o+SE
   a4MadFDsA35j1qrlE8vci+b6DjoRbgPkTMh4unBxy6A9v+MKam7rwyGZr
   GyoIycfU8Hlzs6c9mISSI59JXYc0C2jqsTD5nBm0x/BbW2MrdKdZ9gQiG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="288021905"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="288021905"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 12:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="602057727"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2022 12:06:04 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 12:06:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 20 Jul 2022 12:06:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Jul 2022 12:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyi/xhAHo9HFa7FY3o9lBmqiibiwIN/8WPF10yVquXIYfWykW/pCLVR6mRPc6bV8cCgIli7Em/zAyljxVtTBRQlzunWLRLNyzjLq+VSFlkDqUWg5nzfngbMYYUh9mts4qKuRxwNRV3eG+L+tu/jezmxpLKx8/MI8w9YppIdGYF73eG3mqDkeaF+eeLF0UoU6iTF57ducDNmkuu6Rar7EP9XbrGdU8eGaBn2/yiOmglhRxwCyru4z8ekYHxyWpsfAOO2LhhG8y+FNEMSUY/oQWAdSk+wCj0cfmPDIgq5ZrQuDtM09nth2KkBdcDIcuEcpZsOFJwNiQ5dcuVwZZVKD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVBwtfaOW0bXH2kb6T3AFJ0Hq31DiN6suf8EWxj8Vts=;
 b=CJLL3YVoj2+ceOgbqZ607t1e09sUKWrZ+xvTaHUWdnjWb4Jsawh2QtDR9NTB/adyTFgkUZAP/SFXOT404YGQmcWyXGR1uK0z2rTuZz9x2z2PotdqjJY5FW1w7hxRr6Al1JXWJv++rZOhM1citmGNcMh+NVP1mi3j7zHcXcdIFMohvdvm7wX2Xy7ynxBRxIlrMZQE3V/uP/Z/6Lcx0O3N7JkDGwFYO3kXjvXh4eAuM9dPzmb+zszS3QYSef4UT7LyurmeMPXL/pE6Bsuh0hqzM+j7/7sdsd++rmwVMnDA3P6C2EBCKQnTvNEp64Q/86X8OVt1Q9ntbuHx1lYJxym/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1576.namprd11.prod.outlook.com
 (2603:10b6:910:d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 19:06:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.024; Wed, 20 Jul
 2022 19:06:01 +0000
Date:   Wed, 20 Jul 2022 12:05:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@lst.de>, <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 21/28] cxl/region: Enable the assignment of endpoint
 decoders to regions
Message-ID: <62d85217911eb_17f3e8294fa@dwillia2-xfh.jf.intel.com.notmuch>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
 <165784336184.1758207.16403282029203949622.stgit@dwillia2-xfh.jf.intel.com>
 <20220720182601.00001307@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220720182601.00001307@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f70ea5-d131-4e46-19d2-08da6a82e31f
X-MS-TrafficTypeDiagnostic: CY4PR11MB1576:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 402ZY8eS3QdjvqNfiIvACMQZ4IDt/V+mFja+pjwK4e6om3uOJTNee96O1RWIlzRTJVwANWqLLh8j6GwjbwBGXYvOLjYyf6M/MuFpPAlhImv75+NqafgCCSjgMKPjQbB70eyZBSuxO/OwbIYn1isX9CwIeyD6pT+UqO22Wl4h38Na68mwmn9W/K9RrE5dnONVUs/m9+L2r55072GBPmPzb+FLbfTypmAvu6PqR52gyosJarWniFHBkcGdmWfkHTyEQon3DxIT3UbHKGz8rcGU6mXLEIoK0EG9Y6j+DnipipBpxo9J1Y/RxxqW+MGX/C6QAAv152uqRYhXgcsoYhD9gGlg/ddusCWfENwyTy+tKl9wR7FeY1bJ5UwGe9CIphcdjafZWUrQiVMZTneXY2f/AUnRiG/7IyO7cE4qjkdap59vCEVsq6u/k7viRPzR7tiG5t3Z3pdQFaku7j2dDxmQr6CENsxSEtFhjWZPYwmobVi0PnTqRolU86YPb/+pEjhx+LBiy4b+9JjlI4fBLwdW6KqSCYYWYol7fRMXPt0LZxh050I4aM5gATgGmj1YWZEnddeI18HJEqSFG27vYZMNESZaOXj/MZqPxhujr5Owg5V84+TLvCTD4wc4Kt9Uzv+DxM+wf23ghoAXjvncRQNH0NLopbKh/vkqGu9j6KIu3FfYAzjVqkaTOgHvkY2uzCxJg58a0WnYoHpyZLtRwzKynr+3uT5TtSFj1CvBvk/5EWiMFzPqkQo7+081FmkbG4n0bAgUC6W4FVVbrctRn1dZKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(6486002)(4326008)(8936002)(6506007)(5660300002)(86362001)(478600001)(6512007)(2906002)(41300700001)(9686003)(966005)(82960400001)(26005)(186003)(8676002)(83380400001)(66946007)(110136005)(66556008)(66476007)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s3QVD4h1dWZ2mjvSiHc4ZIiL2ZMukr3cemAJ4gFgCvQGRuRTrCIcSEOEFh/r?=
 =?us-ascii?Q?kQJFMb5tFv3yOuKZMp2jJ24IR7idNgCf5X1RbE72HpDJ+OSKti4GMKKR3POU?=
 =?us-ascii?Q?V+7KhP24LZdhC/Lk5/KcBLVowhg7FiLgorfK+hp/a5r1lg4FdXPj1U0HZfVt?=
 =?us-ascii?Q?dAOKftNQXezrxgWoUheNUB1kQxZjgR9Yq5G6gC/EYGIWBasbTbEmwmI8QKh0?=
 =?us-ascii?Q?2UEzG3Swk4455rHVb5E4fhGpFO8hguiyEbHnjfRpwx3fXQecipM7TjSowz7p?=
 =?us-ascii?Q?Q+QoqjD5DV3qO48uOjo2bdvszPcFvNGyejdFd1RlyJLxrRKIKuougJrtwLhv?=
 =?us-ascii?Q?sIrZKKyo3rKJdbS+fRlHSOMbPRN2PlBtVJuGG61uIesdUgNEKae7vXFuQeMx?=
 =?us-ascii?Q?lRjPBHP1k8FG2WOT2mseLZgqt6nfw1Dzi2Td+zIDbx0bG+9bpLNdQqNoTB6a?=
 =?us-ascii?Q?ltM0zrxHRiAzr/hO1HVo+55cYlnWcOx2oR8ujTkGl/qnADsoYDQoCiubp5v/?=
 =?us-ascii?Q?qmxmkh51nhhMNhf8fwDpXca612a5rInCQB1iWnapI4uz7ZZssYUEKG677lvX?=
 =?us-ascii?Q?4+xU2Wo3AR7Yfk2PRTXTMGyXuzuKActfemphycTdUBF/SoHNNt2ngKvSFnaT?=
 =?us-ascii?Q?+f4+88a9Qitt6oQ/ZvYR0gtWXkHuYxxGfKhWapcg0gbVtEAZhFK3rYDF/KHE?=
 =?us-ascii?Q?Hs0yV6SJyM7VtPb0HgAzdlZrmfSuGra+VkaTTu5jsp8FESpudaQixqjWEt2r?=
 =?us-ascii?Q?LV4Fe7lUmpCYF5L2rpaltsb7KaSQA1EqxyWEV6jZKwBHw116zdOH6vH+acON?=
 =?us-ascii?Q?z6Sa/mfTXVvumxQts+Qiu70WzMNZsQmHFJyzD8mYqBQFbpbPPddhF/DkVq+8?=
 =?us-ascii?Q?6q0Ni2J8vdkLshbfR/QJONZPltrszMYyI6RyKWvV5nCetXwbTkWrtXmtET6r?=
 =?us-ascii?Q?b/NNRoJiT4Dbn35y6RDPdfPrHsxj4KxNss5JzQlalhy+jC176xwcaOjYd9cG?=
 =?us-ascii?Q?9cABRaBxTf4kZBphDINfM6Q+JyggM8UPcIhLr9zLwlrBbttB7evF8bqwQX8m?=
 =?us-ascii?Q?RT7TNQ1OppuwUN7m89djVr/Qv+urWHOs9pEE+oC07VBxPkj0J3y2e/KmflMt?=
 =?us-ascii?Q?gPV8OWeNPeUhUTq9SWW+0M+1gFtW6QNDa3h1CeIhhCb5OHudusPFBslxSzXB?=
 =?us-ascii?Q?DoL+I0T4OlM7PLomxDPBjRXnkZgSOSc4CRUoNEmrV6KnegsHCESYqdSlExOJ?=
 =?us-ascii?Q?H9D+TstfuizohYmGp6iHsfKlFsAMALzqZ7jjA0NHNy9IgEkgvF9VG4TFmuG5?=
 =?us-ascii?Q?S/OrzLLzYPxCtgkffGpbU1JDk9j3vDGzJAopTg8XjFCY1Gb+QVJRKHQoQa2t?=
 =?us-ascii?Q?Wgdg0q59r0vXoIfHdG9+6Z2d2AdSDCEWnNkI2hiwS+hlTXMGqiEWg+5MGd5h?=
 =?us-ascii?Q?yNTcfp4vySH4m2BqNcR74rq7FT/7jn1LEcSIi+LDKkmwH6E040m3tOiD6gaD?=
 =?us-ascii?Q?aqs1HfV4dGwwfufZhocTUlWFKSTCFKGmk5txz1POBDUy360K941mewNxjXer?=
 =?us-ascii?Q?iRSfc5uvqg5fsXm3oqNRkr+aIxt+JVaslWjp76Dp2IyhWji8knTOKdkwFB3J?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f70ea5-d131-4e46-19d2-08da6a82e31f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 19:06:01.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDN3f9XEkBD9nbPOTrIcBP+Ueh96CsIzDwBBdpGCVEcsTnVYAOc1+9EesTeXNI2TRHa+HhG6BlZKrAhxlyfP9VxWAFs/fFmuicpbvtI+bVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 14 Jul 2022 17:02:41 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The region provisioning process involves allocating DPA to a set of
> > endpoint decoders, and HPA plus the region geometry to a region device.
> > Then the decoder is assigned to the region. At this point several
> > validation steps can be performed to validate that the decoder is
> > suitable to participate in the region.
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I think you've lost some planned changes here as typos from v1 review
> still here as is the stale comment.
> 
> With those fixed
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
>  
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index b1e847827c6b..871bfdbb9bc8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> > +/*
> > + * - Check that the given endpoint is attached to a host-bridge identified
> > + *   in the root interleave.
> 
> In reply to v1 review I think you said you had dropped this comment as stale?

Correct, its gone now along with some other 0day robot reported fixups:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/region.c?h=preview#n1099
