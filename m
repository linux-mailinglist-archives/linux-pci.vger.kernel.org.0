Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449156D069
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 19:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGJRT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 13:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGJRT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 13:19:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820E0BF63;
        Sun, 10 Jul 2022 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657473595; x=1689009595;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NI/G8X7SM8DKy/txWE75pzGyF7gKPTlOzAoZmeIx5R0=;
  b=g2gvNdAgZ7O9ktfLGW8q9fNoyeFSLKw/RieRzB95E1NZqPPii0Y5YY7x
   Y0SHRAYgf7mnyI50CzrvfOMAojtNqG5+yCL2FbZC2YMJSGA9F9s5l2w50
   Oppk5K70Y65NEuhLLee6/UxLt7qji5oWfETWUFk/cZcFikWv4huAVKS98
   /DEk161T4FyHVrCVWiU5sQER0jOL7w1Ft5po4R7Sfu64nOUw+13IeRfY9
   I9/SD5JiPFE+aPsq02wjmzoHRr1+vjjDnupYxkzsvBTnDruk9+8vNs3cS
   DO064rSbc8gN+7n6ixCoX3CLRHa9UM+F/vIDsxwFrZrvieG1vRFf+YA28
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="264937727"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="264937727"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 10:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="684153345"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2022 10:19:54 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 10:19:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 10:19:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 10:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBU4zKgJW/PfrwNzal9pTs6Zm4oAsBPb/G5qG8OUwQneKpy65abT1ZNAhqG7dqdJpRqG0QPCOyIW53ND0u6sD6l4zx63ntlwXareNQTGsDUWzJ2YxZ+H4HbKT9A+6Inq0E45mZq5hYgZHUWNvFuXA1QY3UAeV8Gf15cFCu7fzFjAZrLpkhmB4vM+Y7MfTTiioM2veLHVd3F9JHCUd0I+Z9bBBa2/SICbJNhdyypwlpLJzs+/5JgZxn+A32FGBfeVduq230Y++tOSm8blGbhxDSGaZ6Pgtwd5+L/d9cPcxLLiVFG81WgBCH1+mmXAFMMk5VqRIEMNMdcUz54acqV+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOuCYhKQWfs7w/5hvHuFs32RHqaahzbFyDQO6zsOGfk=;
 b=jLqx4naPq277tQ+QALPHd+s7d7s01KEuMZmzFSDDbeTtjeWmi6cY/oge3/u2UvB0aW41bmQEfQc0Xn45SIHvE1DxAwMjkoMHvpU22Nocm+rwY8I89SSCatOB/tZeSZZ+PBp80ya5pcaZTlCtoox/dy8mal+svhnf5cJEAY5Jm/JzBNnZIrjxuuhS71sWOYiBb36HZRi/1+wla5JSkO0eWy+4FUQn4hTg+CKSXmr5VEqNmHQr0q5G0N6kPzWZJA9bLTodPqirksiTAOaR+P1I+iFszXtICDBswfA4F1Ww9fOh4JE3mjSRGdkLkFXxIIMGZE8aRv8HsU8we8njPkZ16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5753.namprd11.prod.outlook.com
 (2603:10b6:610:101::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 17:19:52 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 17:19:52 +0000
Date:   Sun, 10 Jul 2022 10:19:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 21/46] tools/testing/cxl: Move cxl_test resources to the
 top of memory
Message-ID: <62cb0a36426fb_3177ca294f2@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603886021.551046.12395967874222763381.stgit@dwillia2-xfh>
 <20220629171110.000009b4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629171110.000009b4@Huawei.com>
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9fd350-7bcc-469e-f828-08da629866c2
X-MS-TrafficTypeDiagnostic: CH0PR11MB5753:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exu65PfpojDrsKJLpEDaffo7BoUrGOaNW8Ah9Nbnc/rZOmvKzszDuj9I/rR6qIEYjrRPrFQBhIZ8qycmagL+L8e8h+IQzY42x7npp00Mzz7UHnUTpc0EnTGq5nxfULw7V9iuB0isJAapU+QpNWDDWz0EOUurIPhHU7wH8hVcE3qJEkvyVkh8bJYFkh3JV492N1KnwaG1Ns7COS90smVp3g4/K+aE0+ARNqwLdaUtPRKdy/u/ImBL/8wC6lTSOljYrkBqT9olgpJ4j4shjBtlokQISnHD3fgYna/IBHIrdmzI9RDN8mivgv7yRw1HnaRPEBmqJpwlgI9BM+qrOVyUjaHnpnDj1W7lAPBqHw/ejSdaviL82niWiuxoDsketsq6tfPB0rDfIipHQ7Ve3YHHkYTZBbqeLdcr/bO6YkzWQlYNwu0nwpaWSSdBlvddRODEVBguX7N6/kuMyKJ4CUyBgNxv7Jraxe8reA8lO9TIBQRpoIcQLIWCKdZWbXQcdS4rMjEm2zDoZCxCl7Bh61l8NVb0HWLhIxtettP/irnAfVWPZWqNDajh/E7Ui6t/F+q0gODgMqe2RRXgawSdnMjcFqIBIcl8Su9waqvWaFgbyZc3ZrsrV6uaQIAwZQ8BLVmCTNYuQaxU3EkdyeujDhSjotnKS30+OV/iKUhaYa4saF2LHbL2hzgArQBqIt5sIp2oAOFHDskhdFfQx0FB866Cc+0gbiO19M8HdrAVwOhC5Tj4Ti7JiblTHhJo9Og6gBKlqUjyirjH62wbSfU5gA9ZxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(366004)(39860400002)(478600001)(82960400001)(6512007)(26005)(110136005)(38100700002)(41300700001)(6506007)(186003)(83380400001)(9686003)(4326008)(5660300002)(8676002)(2906002)(316002)(66476007)(8936002)(66946007)(86362001)(6486002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NoxianwNMhs6rxRqd9Sm0Ul4px3GFibftC0BMjnIMi77GjmkOQmqQR1YduTg?=
 =?us-ascii?Q?mxlmEpk4v+qrZCt23ZHhm5C/NRU8SqYz4Jfa69eLisND8RbAqOW5wGNGkJUA?=
 =?us-ascii?Q?zEtwGM0TdCv9cpkL5HHRSpHGRRByR1bscuzSLQ1p3hnTSaX8Dk8lUPfebE/b?=
 =?us-ascii?Q?Nzcy7HCsj6a55/BA68L8jQhIC03w8Y81atbRPV5sP6R6RBD0i6tFrtSw+k+3?=
 =?us-ascii?Q?XNPnv18pc61xY+u2b4nwlKzXIJShs06iNF97GpNKxPyetj6mNrpgeruh8/zl?=
 =?us-ascii?Q?Gq1WxnMekZHk2zRBb8/l2l7FmOfoZsY4qXtUxveN0AgA7/ZcBs4x/SClJskR?=
 =?us-ascii?Q?+48Dflv747N8DzgXOA7QHxMjged2sJ+emmRP6I6O0nO+yHM7aZnpeNM1mGWA?=
 =?us-ascii?Q?xGQ8NA3bIUgTvPaPkH9ZoCRcWwRzbtXiOgmGWB9WJ0xGXMoOLsOS7kLuyIQa?=
 =?us-ascii?Q?HZx2Ufj5d5ua3oWiDkg9VyXdkFj017rJY76+2xqGyescwU59CA083BnjNq7P?=
 =?us-ascii?Q?OI8OcJd2C8xM/S9xykg6UFyl57ntjoSuHwJnaQzkIvhKUAFx0c55VdsmGWN/?=
 =?us-ascii?Q?CKmHbHhStC1+NvPV7tN938aovmqNqSe3octNzmJOe2LygX7eprKXpyqN5bCF?=
 =?us-ascii?Q?fX3+65mgZwcBrO/NSGLAcbQQrAhOL674RUwNPpvDY+EL3cDdXSqMH63tAzWU?=
 =?us-ascii?Q?nqtIed5Fu+2H0w/ASKpQYkuIiw2qOKTKiKtefO8ipk/0rR2scpwaNaFNLBZ8?=
 =?us-ascii?Q?MqHXbKNRHJf24Q+9N55DLXyNfYy3E7pOXofyBV4+ZSQDJZDd28R9mfhKmuio?=
 =?us-ascii?Q?B6ZSRixVomIBYzUyGbH8fUPO0XwJheXvewUcKZD3YjfmxXUUyWYtpV1Qq69Z?=
 =?us-ascii?Q?FDOgo/pHJpYXVbYFw9YloMVsKrd2c+5/Dv4379sPynoJ0MngiNInNG0umbK3?=
 =?us-ascii?Q?hwEVkViqxvRYEDwcF4B0fwgoY4GSnBOlSnSuGE89x7VvZ0XaRnpIpGBPaism?=
 =?us-ascii?Q?+sQVrXKcHE0XSAqXuCeiJf2yMVBVTeFrJLY78aFHeZy/6UJ0sNmsyKT/AqkR?=
 =?us-ascii?Q?PNwIEm7n85Vmpbv0ZxUIyWhLqPh7G9JNoPBIdNftM5yZk8etSxG3LpcqECju?=
 =?us-ascii?Q?yYB7uZNx9CpjCPnLAW3MttqMI2ISy6Lua+9ozGvnB8gHbTprKWRn7fMhdW6k?=
 =?us-ascii?Q?siMasGDhY/BquOQ2OLE4MzjQ6yr7YlGx+iplYXdMQ983S43zH2rnDNY/xfHZ?=
 =?us-ascii?Q?e3ddli5FCbsL3f3k8+qxZUyjKB4gOB1aLi1ahFyLCKqohWCKPUr+G8Wo7LIQ?=
 =?us-ascii?Q?jIDgQv/vBxOeVyoC2S0vxIebfSKsverAGLItar31wzYOsTGkv2+eueZ6T/uh?=
 =?us-ascii?Q?iU7lTigcefh1fHJqTrSBgvjGwMV7/1gFI6b5XthYNXCyxLqheohX3ckxGK9z?=
 =?us-ascii?Q?+EX2CLj0UHC8KFCnSwFPevrD4aBt94H0wpiyzielzb0KjR7xmLyQiNXtcmXP?=
 =?us-ascii?Q?PItzEPxZoDkco8JLtrGT7tQpfHvNRXC5bwCfWas3844HomDC75kW2rDoIM7u?=
 =?us-ascii?Q?N1WwTj8cKP7h84c9tYynzBdtJjNF+BNxFoHbwVTwH6sj/RPAUMdWbDTgHkI4?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9fd350-7bcc-469e-f828-08da629866c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 17:19:52.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0Qt9xAsVqOzf+pJ177JX48dsbu3vh1bN6ZXfAcWQyPj8nD3/u/UbwRxXc9703VhsFIMfhqFHeHL1JAwzl09RvscMsD1ieuoSD8//Q0O0kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5753
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

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:47:40 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > A recent QEMU upgrade resulted in collisions between QEMU's chosen
> > location for PCI MMIO and cxl_test's fake address location for emulated
> > CXL purposes. This was great for testing resource collisions, but not so
> > great for continuing to test the nominal cases. Move cxl_test to the
> > top-of-memory where it is less likely to collide with other resources.
> *snigger*
> 
> Seems reasonable, though I'm sure someone else will have the same
> idea for some other usecase and we'll keep moving this around...
> Ah well.

Indeed.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

> 
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  tools/testing/cxl/test/cxl.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index f52a5dd69d36..b6e6bc02a507 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -632,7 +632,8 @@ static __init int cxl_test_init(void)
> >  		goto err_gen_pool_create;
> >  	}
> >  
> > -	rc = gen_pool_add(cxl_mock_pool, SZ_512G, SZ_64G, NUMA_NO_NODE);
> > +	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> > +			  SZ_64G, NUMA_NO_NODE);
> >  	if (rc)
> >  		goto err_gen_pool_add;
> >  
> > 
> 
> 


