Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA37737AF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 05:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHHDZH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjHHDYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 23:24:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A4C2100;
        Mon,  7 Aug 2023 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691464962; x=1723000962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HwaKI05+VXOgrnWmAiRSiZAUkKmxHUHpHkxC/0JWdMs=;
  b=HWYBQURs2IZO+tBGWGnnuzUzGT2x3ej4NJWfKntLiXgp0CkfNoSvPQS/
   b/cMB3P5zSE+FU/oR19J9vt3A7Svy/vzl7s+uQo2YFphhMsTKX67Snsi/
   4MlXybhlUBzh6jhpdl1smcQ4OaZLTRiJYu69p5ZkWDagfOtPUcdE3SEDL
   YtSo6ZgDFsGV9gIYMKk2invDj9AJnPM7L8LvY7IAcd7IEXZ7nWMFNiFxZ
   vibQuRC1MhjxIyhgZuqjWFgloHiddTaoaXy0YoM/3Orbk0lVMtNnf26u0
   nLF0PzOtd2/MeXQAsMe0JQ2R9+HH/kvsxmkumLzs9oFbyGX5gNxgy4ZdM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437036223"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437036223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874571207"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2023 20:21:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:21:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 20:21:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 20:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDtadJfo40w3r4ZiwijSXn7T2zroYCvr2LjATL07PDir1mgLl2SzGzh5eCOuzdntS8gMmFY3d1TqGYFElXKUPiC8dOQsbdFuolnhYQLIrZn7o2caRa/FhkKJ5QDC4WiPLlneOiebhR+BeptnouBVQr4+RREByqsfpmes1l5xKJruVbRCiaqn+LFLp0VHFG3UBzq0gIsufIry/fxQqffwp9G1LxhVL4DVWXEprhz9AcBGRv5UopG/pAunn23jAh5Wxxk/tdZS8J7bPoVHE2NqAAezPedVH4WiXzT0X1sYquOMg0vC2ttmLCe4Ov+OoiqmdNlLOnqJWBFDzPG039GWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwaKI05+VXOgrnWmAiRSiZAUkKmxHUHpHkxC/0JWdMs=;
 b=OrN2eiu6XZ7Sh81WUw5dyLd+SlE/Njj0yuZqmeN9Rs+zyfkefXa8pXQAF7IHIbJZ3YF40rjJDfc8STFbLtq6I5C2jnsE/gHqzpW5NgunLFTQphW9ECmGeezbJlqjRuVE50NmjW4YQrpr/+2SOPpMor7zB2rALNbSQAH76GgfeTkS7q5/NjNvFsSfTkk0u5SsmbTsJsp3FKVJH3ILbYpGp31bmkCVk9eqFVBsZudwu+dv+tBil/zm3n78UxxkupzmFtpKK4kqZyBW5+t2CtkkG6E7kzt8kAidZ778oXeiLe/gAm60Od2GvRSEDbIzevYo23wlEVPdJzw16CinEG6gqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 8 Aug
 2023 03:21:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 03:21:11 +0000
Date:   Mon, 7 Aug 2023 20:21:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 3/3] cxl/pci: Replace host_bridge->native_aer with
 pcie_aer_is_native()
Message-ID: <64d1b4a38af7d_5ea6e294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: c97a23d9-2b9b-4b39-2522-08db97be838b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ekxTUrQwNGI+Yi6rtcZYlpNveEW6zhFHGsogLahUyse5uHvbsjrkp6x2rbEvTVJmfPi+lJer4PfzCAlSh5M9hNqz7H4Xm7KIfNzl02jr5Hl+8LCfuwlj9gJRiXoysocwjcl3U6EHThR6WwrAG547hUyykX4sjJbA6hYkI9Zwyi5a/M+Y+2EL1H3GTuDKumB74lqI9AeCincL36qtYu+nnJXbMHwMgxEv3am90mwK3mFWc4IR7pE9IkI5oNFz7IJf0WYSmUiaHqT4jJdykP7MzhJsITNcCz4wpn45/Wbcg69uqXS3X0enC46CuQHQtFnyCahFfso2EFp7zTjtZCBJ2BAYNI6Zsz/PbBd/g4kTFAxzC6/HDQmQYUHUvetcJwi7RU0VHpWaE94eRCHiOo5nXZ6yZZKA8hxim4dh59QkDaMYbUebReii3yqH1tvAVUrDxg8uNzk8KxJMh0xqgfsrx0Am/JSqU4ZFszRRDgKb1NoFnapI5hj5KgryOOiu7/n16o0rgoyywShzBZSOVfvkfzflcS/rm2HKxfmxU2VTxFFnEhFEILmRqYRwlkJ7/08PMCeJibAKtw+bTRLiIaA2sCDukZ/pE2nyfU1tznOt6vjMZoCfFi3lLXODqRBGKHNHFNxyrkaiWqdW1k95zvAJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(1800799003)(90011799007)(451199021)(90021799007)(186006)(66476007)(5660300002)(86362001)(558084003)(316002)(8676002)(4326008)(38100700002)(8936002)(54906003)(66946007)(7416002)(66556008)(41300700001)(82960400001)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LweJzzOlHwgcUwLrLFmDMiXnhnEmhhRmJFGZ6BBwb5b6uBtUzOMAFcb/ddPk?=
 =?us-ascii?Q?dIxjEJhSty3/CTjd1/ng5e+e/d8tWe3emEThuNeh/UZHkGlsuGY5NOhLaWea?=
 =?us-ascii?Q?R6vFf1luvqWiPMWTPHPY+M+uCVA6rvjQkQfywL29lWHHOZnUL5UeoLwUvh51?=
 =?us-ascii?Q?qwSIjTYmFv+yOJedukqE8pOKalyUnRP5J1aXJD3zFVfLMo5TbwbPoWn5hYKK?=
 =?us-ascii?Q?RxBS2rBwsVH/eyXIrJOlS3vCa5AWAQ620Bqukbg8Jr7E57/Iprd+q7TLicbr?=
 =?us-ascii?Q?i3IWWRL5N5CbaeSVp/6ZphxC6ZwuQZdRNny+ruxkmvujUifHDM842XnJoCeR?=
 =?us-ascii?Q?NTpBU1IL7Kg+hX0nf4UMUx0SS/F3y+XVAibqgdgseztM9mB2spX9p9s0QqgL?=
 =?us-ascii?Q?ubhhnOpdkmhUPjbx5vjkl5yiCmvDF45L8J1M7uDWytO8LVGw5grWR7pK4bFK?=
 =?us-ascii?Q?nvqnIGpXKALT4//9YJDFlae7ph7ToAqT7UoOIwVUwQE4yjZWadoWvqg4mX7H?=
 =?us-ascii?Q?trDt+Lu1TF90UG+MQlbuNHBnVhSR5bFy0Uyd4z1xN/Dmzdf3fyskD1GBzZQy?=
 =?us-ascii?Q?w87K6bTfRXEF3iWgCSp84QRssY9X4ap8qKpJxIouZM2L5WznUnogjn0SGqB/?=
 =?us-ascii?Q?76wPf9o0mTZWjuhjnT7JQqsWr5dPYQmMRxYYdefeUZAwjr8TR2flq5PTcRyS?=
 =?us-ascii?Q?UGwX2RhWOcCP39/HU88i6Se2zf3B4lQcLXjJ3PwXKYKTR+sYLJv6Xb0afTli?=
 =?us-ascii?Q?FOBdX8bSGz7SHaao0LRO8wUq+Ll0Es1XYLHa/KgsrMoAswIGe2cSAcesqaSk?=
 =?us-ascii?Q?1tQomilaYyR78CgqccviA2K55XCO/Qf5tUuVVZS6ap6RJ3H4aRK0hVxhE/ys?=
 =?us-ascii?Q?jg3cfuPtbk2uDkLY4piyMv4iYQaxmPfJ4pj8xvwDTVkKE0rJ4ZHm90sr7Nl0?=
 =?us-ascii?Q?sqG1dx/g/DvYJhrgdjg3lzgwPwuqVo9y5uFkxvcdcvXuft/ddmvGgcrNdyVR?=
 =?us-ascii?Q?FlyNOg2VucY2wkkEOFhpqkqTc17THqD6F60Oty9ZRPNZcaPXcsHDrHk1/nPY?=
 =?us-ascii?Q?GakI4U7tnQ2cYqnWwvIEZf8M+3UWP79hxJqCAOYJqmRl0LXeerJ6dLL4iQYx?=
 =?us-ascii?Q?zBQO9KY2s40UxVLUKLgnzvKnn9l9QUGrUuVQKXHp+g/OcOlHBekGg9gtptNS?=
 =?us-ascii?Q?1oAwnsACLY6OOq0kIQM6SIQqwg47pAIdRD39SJrXZhIksVC9UKZ8Hgy95x+n?=
 =?us-ascii?Q?hDJgd2CgSotrv1CMqdCUC1LsQXBJ6IebA6tCh5APLPsNDBtCImmyjH7SBAp/?=
 =?us-ascii?Q?9x4TaQVemATelhk+RiSKC9WHKYO8z+pWO6h0WclK4Lc4gj2cmYNqdcZ3MfwB?=
 =?us-ascii?Q?z+JxkX052PvqdknskB9BdG2yV4UvEUtSiqYqzO8ZAy0nKpUWnT2pEuV5cBq7?=
 =?us-ascii?Q?zqTFe0Kzl9OTybklcaHgue4GOYy8qUiPuZOuZDuJhtjDjRncbvoOdOf45/DD?=
 =?us-ascii?Q?8nXETHF+jZ2NhV41UIyzsyZsEioekDoRJ6kMRB1q+jv19VccSbues6IYHCqN?=
 =?us-ascii?Q?fvxCq7e0iBsg4zDDN9KudV97RZz8Rn4sil1O9bkLIwiWyiu8LnCvhf37eSLu?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c97a23d9-2b9b-4b39-2522-08db97be838b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:21:11.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCD8uXymq+qfeg1Dipw26VVt4sunHPIbWmeFVJuouPtXP+QNLlZuVAOAuZQRRxrUQddWRgvBcw6rlFV/vQbUybb7Yyf+Z2MMM5MlejtYcwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Smita Koralahalli wrote:
> Reuse pcie_aer_is_native() to determine the native AER ownership.

Looks good.
