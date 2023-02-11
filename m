Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B4692C64
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBKBEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 20:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKBEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 20:04:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85175F53;
        Fri, 10 Feb 2023 17:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676077462; x=1707613462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c2bmEP1JatFqeCiRle+0UUMs2zY4dS4ClWtp7C0ktrk=;
  b=ReTJZk5KP0xRLpNLCQ1ruwNYWVTfgqqSw1Snnon2AnvQigxMiTmGDpEz
   zndacRTE2JMLVhJidk1UezhAJuNq7CKrp0YlAW7bqO2u1QdElujbgVrD6
   2sjz5M0zhhZ+Xh1CTfq/g3/x2/G0ul9lR9DYnE4snN7LXzt/EwFGa5//B
   klUjU+20Jn8oRq1Zqs+grWpC3eaAqe9eQrQsGGYCWFCWOtZHw4yTv2K6R
   oqc8/Ox6/XVAc3GH0LpWZyw3eUU9Hwtzmq6kysvIqmgyPjfRybRJjGAaN
   Ik2NJkhhqht9d9izHPlbt/6H8tezZan7p/3YFjzh5jruGggpMnfamFQdV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332706656"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332706656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 17:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913722498"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="913722498"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2023 17:04:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 17:04:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 17:04:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 17:04:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 17:04:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2v+xMZungMg2ObnIiPXeRZkaNg3lbfcxapjNdlRO8DWoJXbDUznRMBTdX1EohLs50sM4xawAxAKlOors16bz3WklbReOaPJt9yR7CJfeoTxEGGQPEYgqq2i6DbpxmqerD5xdGCkkXsrMerwN/zlGXHrWocB/5VUtHfx/7gNdtFCHcI2IPxKQLCRkQqGuaUD8ohkNeHJ+zoYvKnA3q/GbANX02vb7ZRcZ124m2Yndf2pxfnICwQD1jL4zzhs+bBWbcrmaj8wV3dMemRvdUiGgNV/glxS5ofTRsU9ggRSklK4EZ5iYYW8GVCzfn2umNZUSmDm+N+BDLev7Xx2AqFmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1FHOQ46lSFyzlwI6IIaKcn2oS/eggfyHk2En2p8U68=;
 b=XG9dA4sj1d3GdRW69A8FLHi+aIT1mGk48UUFGeg6gVXVeCKECJoB69XVrUAz4xggs0ZRrnBWm13xVld/XVumJdLN6rtawnbmX7jXHJ7w7Y1oFVUi0j87PK5p3XhHI6OejcDIfBBYBT+oKlsG8qu19ufgE2WmLp2ljD87eBRtyhXJOLVeIx/maO/wpYIWE1QC4KvjoxB0p/eNCNrEukGjSA5OoKDwEFVbHbFtB+qGtSj9FBplhR1JswDuQb07H2LlI91Xl4Tew1ixVnGs/Ev79F2OkFjIVsvxqJkcrgmUzrgxn1cjNg/cB12WI9rHa8nzRC1GsXIAzCTebFCm3rWW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 01:04:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 01:04:07 +0000
Date:   Fri, 10 Feb 2023 17:04:05 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 04/16] cxl/pci: Handle excessive CDAT length
Message-ID: <63e6e98537c7c_1e494329496@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc907e2-1fea-4128-9553-08db0bcbe059
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zln7OlsfzSYyrfmBr2xLM++9GONnnOjeHNwjBIkWklCIe9Qg5yjSIKAC7GN4BMUIUJMI6gRFxmRdhLcMWLqppfBJWhBLME8AD6nQKO7LS0jhhfU4RphJRb6DtF1CYsNlTsKOxcDL6uPAT0+sFWQ/2fonN2uhgP3e80aaUu1+9YErj5kt7A/bYB6Vq2517rWPK16uKAt8UXHyxOdIWY6MuyYvJafV1Arulzx7alzfXzq4NesUHdgS+mxN0YF2vGwF5muvAI3ODF2vRcCneX0DVd8rXqYrX/YZxiOto9L2i/mQfCUzBsU9qy4OY/6OZ7hEbBM16Ak0QBaJHkj/iMlnvrJe1CVv8+Cekn8lscI4p0Kq70PObWnV99WQ/oJg7dIkr0J4S5Hz5SbqpvhZvC3HN+5Yn4RXO6ue4ey25df3E71lSVRs8/5IMwUDIvFK2euCYZHdCcv3Ucnvm43UOKBEdtsMnemOw5u8+iRYFcLWXm3wwNi8lsyVV0kPK+Ir26JN1+fgrlDysu3yMVrCGwMftp098tbTYd/X9JJkC1hxfnTFLyz2KDhqBxXDZtF0Pd6mbSuOOX/0AoxwLqJc7ZapJ6dMPOabLxI1q43YS5JhE8F+Kmw2BdMNQlv2vvUYH+T520WnzVjI5GumAzemlEM/Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(82960400001)(86362001)(8936002)(2906002)(66476007)(66946007)(4326008)(66556008)(8676002)(5660300002)(41300700001)(9686003)(83380400001)(316002)(54906003)(110136005)(186003)(26005)(6506007)(6512007)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59u/7QGJt6jGRBdkjTa600HYOIdktEiibVxa+qKsDAraUYdBehmTm4OeI/Mt?=
 =?us-ascii?Q?Qa4KRlUnw53xBJ8Hsm3XUsIUwVGlOjb5vn7E6gqMhUhE3qfCLRJnnDyuC6eL?=
 =?us-ascii?Q?/a72aTk8BgLfbjmumugEopNpwpe+6+uHNUEhO4FBrDKdhEnvHmHqxzrg5hPA?=
 =?us-ascii?Q?h5dB8qcW34Bc5SLc2zGRFSoJnajM96RoXKT8MI7BmoK7JcKMuGgGQ/R9U7VX?=
 =?us-ascii?Q?J0dKoolX7HK5fVYxhNPPyrN359DStlA8RKLbWVfsLyf2oN2tM2twytKGzgCb?=
 =?us-ascii?Q?01Rye2DkoDSq7WH+zbFvz0kRljV9H+asAYct0ZcluFQoPNvMMWcWvF9O9YuA?=
 =?us-ascii?Q?QH+1OA37+NFok7Xo7j3ZeQdgL0T15hIOprgkWSnJ3qWj9UynEny9kZIa9Mku?=
 =?us-ascii?Q?2KecQ5JqmNyV/zIwWOXUW3WXb/9DmuP5A5wN8cWITaEq9gw1kdvU8OZ0G5b0?=
 =?us-ascii?Q?3AfEcUvf09BsnjBRPfbrtD1BKEBCp9tgXazaeJJiWlo/2PyYWzwqztRMYVrC?=
 =?us-ascii?Q?B6hEtjd1RS+FMB7DtCAa1ltjf69H3rwOfUg/i90Ks3NShndTc4IdyB098yVM?=
 =?us-ascii?Q?z2EavNUMro+Qw4cjpmGFfkHK+Z1PLR5CvBWf4qOsWHTG1DcXa1rqQ48oeiAo?=
 =?us-ascii?Q?A4hVXdRIwK0qJObznqKKQ/Ximax2wRZJTTloN/vl3VufDQSDp3DLz9/lzMhz?=
 =?us-ascii?Q?SPDQ6Z6GpKcqUrN2Dc2Ne4OxXgw0uie7pjcErSS0KxNmL2PuIi9VnOHdjBoT?=
 =?us-ascii?Q?X2IyZFVbArc7mPmQLuUsHFQ3YhAhu5rWIVpYW2XPl9FvsYYkbQhGTHNg8OO0?=
 =?us-ascii?Q?ZLFVyMsgOd4kfCkr0N5HgwseBK17hLuWnkEmTs1FvfdVMrquWxXwMPNZ3/7O?=
 =?us-ascii?Q?YLBOzgMypiHZc5klnOiqbup6zOcGeIB3U2BhCpTonrUPdT9miTJIzybHNfqm?=
 =?us-ascii?Q?DsH8RYWdD+zLGqQtHWS5gUupAQ4+VQ9S67Hpj16euRk5zLCqbY4SPvvqdxac?=
 =?us-ascii?Q?VHkGDK3NdEldD+RR/Al1MAWycBvZFWWD6NxzplFsYpfY+CRZi0+XciL8dBNs?=
 =?us-ascii?Q?lsxnfjxXGMEjXuQ75bZ+EIAubti75dRyvFA4krIoNfPyfEq5xJ5/eJyVtrik?=
 =?us-ascii?Q?EtcHqTIUiO99k0XYtIAbLgRy29i0xkRHiB9hpeCmLbAEMIfGi1VmcuEpXThH?=
 =?us-ascii?Q?KpxyPimq0ZL1PifWDkBXCmyhittvcMqBkoTdFFvLQ0x4T5VXA3tUbgQgpY/o?=
 =?us-ascii?Q?Sg37XXovKVbpwnf5PqC+TlliRHO6XfxAeyJozwywFjXBJOu8+nojXJ3rL7z9?=
 =?us-ascii?Q?c7zPwK9J9pnV59rFaTlCzGEcPUZI8oqGVivRcag/QXrzMnUZ9QuXcyYYchyN?=
 =?us-ascii?Q?h0E7iCccv9t7KK6BPcKp3sN/2epLf4NOGFfYM9fyWrUu3hMXY+hZVFRqfNQn?=
 =?us-ascii?Q?1/C5siuINRSb1LlWd0wKpqQkCc0KT3MV9fMHjpExOiPbBbf6i0w/nkCGEzCp?=
 =?us-ascii?Q?FDf5U9uH6Qp72l/b0RFGQO5U94/7GqzFSOl/S24J3NZSuMYZu5wrrsp7b+E7?=
 =?us-ascii?Q?QuFbmdB4hEe0FXW4dTkzzZJkrSjzZaFj/h5BPmDsQ4QW71suBkeEgADIpztJ?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc907e2-1fea-4128-9553-08db0bcbe059
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 01:04:07.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd4+NnwWMfRBqKjmUUSBtFr20MhhEf9YQWIlViZVvdqAeoZAN/uDQyRrQaLne8/3Fv+LwMgVC/t3njzEIIFjn5e67mMhGAaEJqKexmG11xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> If the length in the CDAT header is larger than the concatenation of the
> header and all table entries, then the CDAT exposed to user space
> contains trailing null bytes.
> 
> Not every consumer may be able to handle that.  Per Postel's robustness
> principle, "be liberal in what you accept" and silently reduce the
> cached length to avoid exposing those null bytes.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a3fb6bd68d17..c37c41d7acb6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -582,6 +582,9 @@ static int cxl_cdat_read_table(struct device *dev,
>  		}
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
> +	/* Length in CDAT header may exceed concatenation of CDAT entries */
> +	cdat->length -= length;
> +

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
