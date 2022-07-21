Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32557D35D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGUSfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGUSfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 14:35:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF38D8C8FA;
        Thu, 21 Jul 2022 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658428500; x=1689964500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SeN6+jSQolvvYsH1u9ADEim0VcvzKRKtoYD4GQY09WA=;
  b=ffwfHS46aIPuUl9iqTpRHy+fxomJj2p5PPwQ4p338vDl/v4FxxCTfBtA
   osirkCryfQyA8qQDm+cacDM1dkQU+HIV8F6ERnX10sem93BnH1saAlx5n
   X2tiS+g0pcuvzA2ERar+ZjxiH5JPHEvfOE7a3okVsYrZ+FME6tc6lOyxf
   65VM8bbggUdFcVWiVGhj7aFws6xYYw/3ODL3YtJcF272pLNz4htpwnzQo
   t+O7d+YmsCf4KMaXgcho0SQcMnAeE2FRiwG05wdVGEl4R74qsn6Htara2
   VD3M93hT3qoTlI4prk0YR6YNez3wSAPZjyfVqz9KFE2ZYBVP8V8BFtrYB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266918395"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="266918395"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 11:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573861621"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 11:34:54 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 11:34:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 11:34:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 11:34:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 11:34:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJPdsDIslsrJLs9LrKALgLST5/FtHiLgTTSexpHWOBPR37s/mF+IyUxMYubmt6l3V2rq+HlTxQL6lid4rbcDKC3xGKo51po4ZIE9mlE9bFfe4UXzbeQvd+Qj1BSITwciYhKv98bvp/WNjsriN8ij4z1EREkExQElmHYmMXd9mRq81GTN9+57skxMnz4ibENzTCxjuUYybGmJ+gcOlc++Jy97nWZbaCl46gzE2wiADkcaLbee2uELy2JZQpfq5kXV/5RspPw7A7Zag1xRjcFxpsaSnQxACmNkGWUJrTBfoDi7IKG0ygaZIhZvzOCKV4DifqHgbMnJOuTUSnaZLJKrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDdKQevU9UDje/xIqfJBqNLmZBOjJDq70i6z8xZjybk=;
 b=kaLspXhEUvgjSMqXqOQuWUKbf7RpSSH5ca0TITOFS9fcUhAXxdwB7EnTsbnKGeUYZZgIDgtM5B5QLhJLkO8ChkbvUAnDDTmgbFSrLCYjT72fn46EtuSS7YBs/5xtW25Jk6r5ZEk5n5n9XNAn7kMeEjnAu7Fne32i9kjeW0mPCfCLoscDSQZQbGMo+X1FUdnkuO4JHCuBD+ipbuwiBfqVzUtJ4r70/lsxVyt1A6pGNvPcRB+3wHK8cl7y25RquqqUIgNN52/XbvJoz11U1LCZryYd7X6DQU2MUDATLb32VhLnJeFvMId4FY1XOvfjN89RfdhQ8TfPR7oQ6TQa/OKnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1416.namprd11.prod.outlook.com
 (2603:10b6:903:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 18:34:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.019; Thu, 21 Jul
 2022 18:34:51 +0000
Date:   Thu, 21 Jul 2022 11:34:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/28] CXL PMEM Region Provisioning
Message-ID: <62d99c4840614_17f3e8294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
 <20220720191211.00000c86@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220720191211.00000c86@Huawei.com>
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b629bd64-79c0-4dc9-1fb5-08da6b47b285
X-MS-TrafficTypeDiagnostic: CY4PR11MB1416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSt0TDQk8HYxfLIBAMIy8uQoezS6zWWUNPPbz0DjFtA57tVwdYFUyaJE+fp27W26PTHzdqxYSB74F/8ar4ZQHA4jabGBZXqNea4cuG0FHOnnpSpjW+gGbmUfc2nvGfttf7JEyFodGQ3NJ3RUYNORF8mdfLny0vV5vm5JfazQ8WqbPHb8CBu04445S3daRneyPHZjLDPUiaCo4bh2JR563QQqfJ+FlW1lkIdGDxL8cmKD5BSRkl9l2/0Tpj9IxCppdP0PLm2/aPAhSUFavmZEo40JdWpMchmmS3dSGnECsOzrCNUeTL1ooEmd2EjNKQofn37g6FK37WT0zzjglle+DM4XnY5dFFGaoMFx9Pv60Tjx1u0737tW6h6HXP2KXPS5e/tmCrD8AzeiCYC6SRwNQRglXjw+3sr+L7aIrZjgNs7Abk/F9rSxi9NC2hLSNWEqPodsm+18ER7WM6c7KBFXZUBfBXwT6XS9j/LmAjlSKqph94bSIxsi68gc9RYkirscGq4159ci/PFvGjs4PivjvP/4yQ4JTvB9XnDalpJl02PoKXBQsjbRYlBnVTFaWXWeCYdAnP1/aOT9Y8vgmJqa/A1cjepnURdLU5veOzyZmeBWO6Rt8kuaewiHXm0eudTkeTVajmmd+txP497p8+N+Dn7UVN4L+lrbFI1+ffitljdw18zlCZ6VegHPqDCFUGveyx38x7KQTjS2LVWEmhkKL2bGRCHSWJVWLoqmNJuKXJiWlU0XioKVJ3aG25XOFb+BPb5sppo8iTcRou0esISnLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(186003)(316002)(6666004)(6506007)(478600001)(26005)(9686003)(4744005)(5660300002)(966005)(83380400001)(86362001)(41300700001)(6512007)(6486002)(4326008)(8676002)(66556008)(8936002)(66476007)(38100700002)(7416002)(54906003)(82960400001)(110136005)(66946007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7PJzDGURhAadHO7YvtT2gJDfZfa38eqoWtUQ8LKT9DvuyhvKyJ2Q1/5D9E/R?=
 =?us-ascii?Q?utpDzTfPdZ4yFbfXSTPucBDwmnxQGMrjHVxr1e+FcN6IgVlsdRgJqT5BrMRj?=
 =?us-ascii?Q?Mfgo9Oa+jgBuyLRZLYWZ5hMbJt9Qi1ALiFnewT+ZoJ8l0VeiJFqNGs3K9IZF?=
 =?us-ascii?Q?mS6oBSTnZsT0kfBls2j3BoOhehooCEZIXFLV+efnQf8PQufPhaTFlDzUvm1M?=
 =?us-ascii?Q?2UF2fb+sXCsh+QtHWYIvhU0aTSSd8x0bR77Ovi0spOWEjx3wwV2uH0p3ThEJ?=
 =?us-ascii?Q?GrlUGJb/XvPNaMLDq3jdUdaej5HnRD+ichIwjoU481yoIVKKrWfH0zODbH33?=
 =?us-ascii?Q?CdvK5d3Ts7TF+DT68tz7qEKf0VSaHVPFExEtO5l9uaut+PxzSOeop/cOs869?=
 =?us-ascii?Q?j4vD95ZoXgzz8hCLDcp6T8/QQdFmIw30dSgjPxMLoOy7MwMVldPV2adiswF+?=
 =?us-ascii?Q?GUvyTjH/ZrDpkqYvPLO2BeAyWK1KxDjtKesuvcYCjqltT9WywK0aJfwhUgAG?=
 =?us-ascii?Q?UySpL2FS9lgCfZdqadVvGF5BFOHnq9Z6ZTtCgZUyLwSzuogi0+h/p+UEz8at?=
 =?us-ascii?Q?heM3hhNsiTLz6I3Afs4ngVZ1ulFyxxSli8MTXAqMLS/oSWz/k3t0dI3EfMz5?=
 =?us-ascii?Q?KSnygqGM7b5yujPJkAt57MWm1IxKtGZ1Ckg/0EVDv6GJJxmsGJILXHaKifHb?=
 =?us-ascii?Q?jI1A19Dy59g1h8SQZ9fklpJOg3BRwgDqXBC7Cdm1mA+iyhWOCdOu4uSeE1GI?=
 =?us-ascii?Q?6qkQRC9ASyJIchsIaMbBgCcmG0GHIjIhGInydD1DBYsTVCxIj7gbJMMZgbae?=
 =?us-ascii?Q?UtwRTM+dKHSJ4foPtnB38dtwn9diG2ph5602ya4WoHl+H82VtF9H/3YwIRy/?=
 =?us-ascii?Q?zslj5bvZKTqWb1NQmM5FqSYls+7P661nWiKxe2BbbVY0TxIICqs/4gfxqC4g?=
 =?us-ascii?Q?sXouVD6zeWKfZqv53U9r8TM3bgqsoR28mfyoVRnndkzoNDzBFoRxFVuT2K5g?=
 =?us-ascii?Q?+sAYxdxtsKoXjT063KxqV4CnW1Neq4JD+X6Cb73O/4jUqqcr26OradvdiriZ?=
 =?us-ascii?Q?/kcM5ibuMZu81U+x9yVJ/gf1TswzOr8Ah2Hd3WJo1q09Qv/Lry+Go8eJaKTN?=
 =?us-ascii?Q?+fHAXCvlcuShrgEDorguoc5j62DD8wdKRLzZkAR9uoi4q4aeGOtYALBLK4IV?=
 =?us-ascii?Q?ZUwrD1e32RvTzytsTUqZ6pJRp0z5CM2PA8YHoJ/UiYF5IiP7RTHGdE9qovoy?=
 =?us-ascii?Q?jhxLTxxUxhMgt3vvQc3vNEweyQOiIoalwJ6CQY2Ijce6CsjJCmc8LLB2A0iW?=
 =?us-ascii?Q?C6jmhWTpLgWyZJa1CCcp3SLXF/Rj8yFhodP+v85BG+kXXL2OIBO9i85hjdAQ?=
 =?us-ascii?Q?cd6nhNUdB/uFxe9Mwlsz80oBb8w4dIoD5zfgsT4lxwDixZVgNddNWvjNRBhc?=
 =?us-ascii?Q?CCJfsnQvn9VF/HrGeMtjHuegfMtulUGzYbB1deJ8+Cz/FDe3L0WIMXrvC82Y?=
 =?us-ascii?Q?gQYb+Y+zN7WxcZQVGrJ07Mbr8K7vYotRrRJLz3OOMkr/EHs0PByw+l9wgrYe?=
 =?us-ascii?Q?lZ3ukIjkbu5Wj/pAJM85azpc3W8E/vFyoB2WtpEG6Yhoiqoftb2u3SujGCEV?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b629bd64-79c0-4dc9-1fb5-08da6b47b285
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:34:50.9983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYz3bpWwNm6iP3sB5UKUKC4YAoYgMNU/AjIJbxO7Q8kwtmPINPBhAyGEiscY3XrwIdKOP9n1YO5Nsi9hEu5XO1IkplzN2KzRAOnM12asvww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1416
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> 
> 
> Hi Dan,
> 
> As I mentioned in one of my reviews I'd love to run a bunch of test
> cases against this,

Yes, Vishal and I are also looking to have a create-region permutation
test in cxl_test to go beyond:

https://lore.kernel.org/r/165781817516.1555691.3557156570639615515.stgit@dwillia2-xfh.jf.intel.com/

> but won't get to that until sometime in August.
> For some of those tests on QEMU I'll need to add some minor features
> (multiple HDM decoder support and handling of skip for example).
> 
> However, my limited testing of v1 was looking good and I doesn't seem
> like there were any fundamental changes.
> 
> So personally I'd be happy with this going in this cycle and getting
> additional testing later if you and anyone else who comments feels
> that's the way to go.

Thank you for being such a reliable partner on the review and picking up
the torch on the QEMU work. It has significantly accelerated the
development, and I appreciate it.
