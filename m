Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395EA558D89
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiFXCsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiFXCs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:48:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236D563BD;
        Thu, 23 Jun 2022 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038905; x=1687574905;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IZV2+Qzn1GFQ0O0/0eUqPJi4hlZE+XDgqXsjxKM1npc=;
  b=YHWTLP4i0Exq7/Tmoug+0wA5ES6QM9xYqXvSBa8qX1xP5cPL9F4x/E0H
   95zaZnFKj4eVtJ1lqWeJijgcfqGAx97q0S1gudnV4UVvP86HP2cOQehYB
   GArs0dCnxzX/wSr7GcvOGF1eY0ABzXGFzRO0DwIyR0M1Bf8U4foJY06Dq
   acbxMqxlIfBzMY5ot+TBwMqkQ2oXzU38BVBS9YXAJCLjSAX3gGXfpoyAS
   C3LemvVjk+d5cbCwp7BkLP+aO2Z6VfrB/gHne644U5Dswj9c5oZUwZJVj
   LILQME32hUEoeLEMY0VjVHT7D3fnCoURhRhPcylqojAFjUrlaiENKHP91
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342592439"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="342592439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678352815"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:48:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:48:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFPHcIkDeY+4UtU3zC94nboPXRO6jmltJVINWrYoA9sUN2LzEACR9ZUBacB88AMTQF/stWwApEtud9pmBDJMuxs6kP9ACxO7DGGMBS+X65iWcgcYBFeX1+wfnshVV7MNHn5qghVZ2coQfWJZHw3AHkTkxauBksbVdeKMAIZ6pfOYJKzQRjRDY4ibuYYP6HjOEedZ1t78c5j6A+2IbDrkSjE3Z5iY+FW6w03AW42cI+NdEYVlqA53G0fFyHa6+1TUcTsk5GDE9WSUpDjO7Xu+ZcTFv7B4apFdnu68igNZQckMP9cqra7hy7+vVUra+7DlCFQuWTLDmbsfElPYnoKHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfCXqxN3oa0+Nv2NlwubJnhY3OlRpK2UjchkPbMmD3Y=;
 b=iVrzpA+kONmqwNNzbhvC5y4gCaB52Lwqk0Nv4VlOPObQ5bpb2mlEyjNYRpikLTj8rxl85sPxiidvLpezrmQbwv91C7IKBPmvaSjOaQK0fvzc89yit0txuA4wWH7y3wit0BK89OtOTFm7KuShnuNyqLqIqU2xGf7x1o2d/CIxxc4vkJFrkMSe/+bGWo0mkZvSPa5KDdQpbagOsEFnZuYRUMkQxecmi3Fw7P9e9iFK92zie3QzNBsw8T6lmBDx6TYe6I0e8u4M9VK+HV4IxYePyy1eQCVrt4uLKeoXHblu95tWZtLUr2aUsOH7MXJ8lIXGpWwCfgeSiyFRCuypA3FwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1876.namprd11.prod.outlook.com
 (2603:10b6:404:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 02:48:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:48:19 +0000
Date:   Thu, 23 Jun 2022 19:48:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 24/46] tools/testing/cxl: Fix decoder default state
Message-ID: <165603888091.551046.6312322707378021172.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:300:4b::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be69c194-6c30-4d95-7bf7-08da558bf4d8
X-MS-TrafficTypeDiagnostic: BN6PR11MB1876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmEQXnvIOKEH9qbDwC/EJk4UJbkOOju1AIvfMJ2Z4zTp3vV1IFGGIRu1Ls40EiJRSd4a9QzWLgR16fWiqzrk5SVfHGcTSf3vaaUdVRWWTQdhyc225sFPZnEd0cOHwIZ7yayiMdoDU6UuOl/E1sBTEPBBx+Dpyzb7aus8D2z/LqSJEeXKDjjO/jKLcWF3mL7S2qW3dgukmu9eypKaQC6zCllWelq7C+d1xjxkhdtDWBh8XX3d8dw8ZmeCEAnlhvVC4PqkI3vQbBd55Pjm0/AQYhcG/b4LEUZ4bv3N1RkQI8vtkb6VB54zsOW7OW5FTQYViytMIulatMqvR18PL4Y1wzZ7Ii/5PUPml7rgzo44U1d6J0BryUAUkYaUv+OUsVc2v/VmrsFwhF/RaSk3L7KiyAr1qEGMK6Jb9eFVgkJY9pDlTibh3zx1LExHXVMRYsbMB91Uln5ymsH+z/HpipDaMPPVQZwulMfaLVlqDh9pFYEJZCzoybo7xVZXwbAYK3+kdD0KuDBhlcPL9qjFUhyczWkp6/R6h7EhLNxdcO6CmHcvvd5ushtNL5j0p+zNRJ5YSgf5wqHHVpVOqCsJMW50sVkZlwOge7rkO/vhoMjU2j706oMEp5EfxbWy35NjGyCK5SHNZhdvLXuRKtn1skHZnXxcPR3LZ5Qh4Vzq44Zabdm/bHX1LceJkv7N7Kw4vl9A4XVKXlEisRf3bqpnzgQJL5D5Fduf1ZbmpdCtg1s3x0ROjd6fNB2Cr/Xuk0KmFzEL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(103116003)(9686003)(6916009)(316002)(5660300002)(6666004)(66476007)(2906002)(86362001)(41300700001)(26005)(82960400001)(6486002)(6512007)(478600001)(66556008)(38100700002)(83380400001)(6506007)(186003)(4326008)(66946007)(33716001)(8676002)(4744005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sb1KjrlY0lW8h/XlciBzfBysMDCaQU1dEeUKh9zmeZMx0bcWwdktCMbVUuMa?=
 =?us-ascii?Q?4NqRA/mFr/VzziWDPSt29ExFY4GueAKOsiht7ZILfXHHb4iYSR40LekRq06d?=
 =?us-ascii?Q?bNqSStgvo2kTmCOG6674ouLBbr5/6nm/ks4RNG2lHs8ESz6bbQOxMzizYDu0?=
 =?us-ascii?Q?yqaee7mpR1mfF9uytakHWAWY2gAL26C5Kw4MiPL31DGqs0OB+obW1jB2pG5D?=
 =?us-ascii?Q?J7x4NFlvlgH0r+TlT1PcQTRFmVdCbacCQCNo03ZHIONrHGuivrAeT0r1Z6U3?=
 =?us-ascii?Q?iMJbqVOX7V6xwSrKQ80Ch3OpOnNnND7NL4DzcrrzfG/gfVYbSqqUg+tXlvTp?=
 =?us-ascii?Q?uMRrNqMjAZryPDC6d/z1e3rT9EjzjNbUUeCB9DjM6/HhIww0CWdztQwMdRZ6?=
 =?us-ascii?Q?ZrmmrhqBdJi/IGKnyCjMNnwUspczHtiNqvpFCgXeaa0edB6DOUznsPrUU2GR?=
 =?us-ascii?Q?LseFnR7dDLh3r2nwPeBlYs9nzuxVX2pjQuc8qtwadrs0h/hm5STh0rOxdwgl?=
 =?us-ascii?Q?GbZnzOjKKGO0PNNOG8ufsln8968adsLX+CZTNJtBHCTctnu4s87R3kEJmfVH?=
 =?us-ascii?Q?tGT16QPgRA9bsxMWRon+/02oiqr9aWb4GzO55sjRwHdMuVS5MuRjWZOGMmLv?=
 =?us-ascii?Q?aks9dzDHfLcBqp3F4+gvKystOgmrVMeZRkwoMqg3KNhR1yfLM7ZrgTYuNy8U?=
 =?us-ascii?Q?g19uetUCc27n8trybrmPpQ7sxYqhqdS0RtvK0Ow1mHyu9P4OoRXbslDikcvl?=
 =?us-ascii?Q?24PkMKhH3ARQYqWymljI0qHTjOcyZ0P90Gv+0wfzWX1fEzw6p/UK8Txyma4g?=
 =?us-ascii?Q?XW7H9eZfuNeIlpHz1oxI0tEvFpdsKNmvXmq40tx4BD4dYvUty+T8shodeK16?=
 =?us-ascii?Q?FhtYRgIbLDRAHpBcRS0+Q62SAk9dw8PVfiztz0ACjsgXXWtwbvlA/3ZlaGzg?=
 =?us-ascii?Q?Jwv1QRYqsB1M55HVh20qLp/gOkrHQxD4x9jDKOdXkgUqFaAMVHhcVpIBqpCv?=
 =?us-ascii?Q?ui7jTm4HR0zGkA/hIZ3kZIIlj+CHAbMaOhg9pjEV4JWwhxMUsJIiH1NMycy+?=
 =?us-ascii?Q?2NnKdWiptB1bnXkwFZlc5allDpcMxxz+ZRCgUOVmXeDO2kzYgXRdei0wg3ga?=
 =?us-ascii?Q?94iZp/eWTTBbiXetIuA9kXrHNZHkzU7wnTlwJYLO/W23yLGwqT5TZbs6Ikcc?=
 =?us-ascii?Q?LwNYeer3UQGVqwD6eMBqW3mswajd9Uzj0bCi4G6iHfwc6IkYDH6YPm1VSy0b?=
 =?us-ascii?Q?TrCXMwQ+nu7LITOLcviSfHs1zZu2EqoqLy5h3LvLUbi9BLgKyurhNJxQhURN?=
 =?us-ascii?Q?qjsA7PkQGlrK4dxvdffeE92cL0ug930I18g4NppFh936TnLhyFz6herJ8Hfv?=
 =?us-ascii?Q?c7u8MtfrQERRtWN+v3yPcWq6ZGTum/oPQSO12L8OjqoT54Sw68SbhV6aSbdn?=
 =?us-ascii?Q?0sjProLd7Z8+eMkGHP7eeODKfntBxpuNhNvJgDvOqPIAJTi7fgHfh9q+9oYR?=
 =?us-ascii?Q?cGiNmu3BcCt1hPeHumodeXh5JpL2cNuZ9ON1Irp2aIXeqiMfd02rvZjr0744?=
 =?us-ascii?Q?v7Z6iBZXMjHRwAIPzfjplBhX0BDtArddzWtvPH7zxVxdWlyQG0oif5JNreFa?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be69c194-6c30-4d95-7bf7-08da558bf4d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:48:02.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H8aJu9DYhTQ0WsqqidoIs8Ao9oQP2E8UXiFCNS1FetG8+lgGQBT9JdNSuvFfkm385g+dAcpz0Efbm/VcNWti2kQf/kMnZDmPmh3DuupBbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 'enabled' state is reserved for committed decoders. By default,
cxl_test decoders are uncommitted at init time.

Fixes: 7c7d68db0254 ("tools/testing/cxl: Enumerate mock decoders")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index c396f20a57dd..51d517fa62ee 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -479,7 +479,6 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			.end = -1,
 		};
 
-		cxld->flags = CXL_DECODER_F_ENABLE;
 		cxld->interleave_ways = min_not_zero(target_count, 1);
 		cxld->interleave_granularity = SZ_4K;
 		cxld->target_type = CXL_DECODER_EXPANDER;

