Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8826F79FF
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 02:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEEALT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 20:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEEALS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 20:11:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49912EBA
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683245476; x=1714781476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zwJ1WQfLZROrqYdQddPIL78T2ucTLzQ7evy3EpC4Jg4=;
  b=W7JypFVrbrxVD1dxNmWQddY+1K3T7zf4YUrY8+LW1pfSJFrl1fGemmPd
   /YtrTmONr54pcb0EZmkEXgzKdDTWf411CaDRLEl+gP7ZKwbTQW592VEKu
   fuFV68nuDpjGpCMNJ/TPZOZABrujJt9vbmVxqb/o4J0cN6bseCebK5YKR
   2bkChu8LVzlTZUZzYXi8TECnkKyf2G4aGs+Vm7g4Fo+u3NBkpdL1orBsm
   4AW8gzis07hyxIiTJnNf0eXraa8/OLnzC2a+cmn35hfXItdeq6AyZke3G
   v27aGOpQ+UCerNzoTbNETVnmj4UqQXnYwumQ5MNX3Es+5niLd3OxnU0vM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="352117506"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="352117506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 17:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="727792489"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="727792489"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 04 May 2023 17:11:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:11:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:11:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 17:11:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 17:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTK0udaYkqfziVOFbqgFlFhf3Ah88zKu4JXxUh06lMzHF6h9VNr8f8cYeEBWgZDBb6uZRA941vJnmY1azm2kVLLZU+cC9fwmujd2dKEQ8NsO737S9rmTPdGwLrc1QAYQdVM0PgAcyBlcHZ2/UnHj1AYSTvKZgVpZO1+SMbO1vqI3xncAfBL0UMqv22Cd9A2qySZpAT0mjydxgEfc4kCL7qbTmA2bOAUbUNGcF/i4WHZXekNKYN7J13X1prWbwlOUg5crJgdmKVOSpaI/c96neq8JDCLPuHQFZzxoBuFBVFe3dEqjHwDkV7kZNCCDC8q9CXrg9cKnwdCtIFn36w8HPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwJ1WQfLZROrqYdQddPIL78T2ucTLzQ7evy3EpC4Jg4=;
 b=NRzw7qFq3JrSSvZRcw5p4IVRBHZRG7ErkvhFEPaqO5RdOjHrSaJS9JTfyHph7z2Ky+jfJmJIYDCs8UI6yFiIRppJLzSVWj/4ud7vLzLoFF6HzOiciG+ywqV8lzvKbAmWzbhyF+3IxGhYAYCHJvA7Y/PCnHOwIuZz7lBLdEbx51mW2SLcfM/WZnBjk+K2DSYdrNxa6QNCMX4WoYZNJCFO66H58kw26L5V3Aed6wrITg05AF8br1O71jofCirwSltdyHd7xsMHpkiTjfwYxn2Ksmy+o5GKQg+9CSakXOlsIb+/rE8DQfHFRVHEu3LCDJedHKnw7H1CaUgM/Ak/PJGR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 00:11:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 00:11:08 +0000
Date:   Thu, 4 May 2023 17:11:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <stuart.w.hayes@gmail.com>,
        <dan.j.williams@intel.com>
Subject: RE: [PATCH 3/3] misc: enclosure: update sysfs api
Message-ID: <64544998badde_2ec5d294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
 <20221117163407.28472-4-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221117163407.28472-4-mariusz.tkaczyk@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: f64d2ef4-e12e-4723-a0a5-08db4cfd3977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvnfSKePwOD07Qed3o3zNJUcrK9d6sqr5A0ozZkBC9NE7uhaqSwKB76lrlVZR39wwpyo+iJGV4CVNvM/OkQh+1BhzsfzCWApvb3x6QaySuQeILtOO9iJOf84xUzpgpeoe8bEZqagkLL1nLqf9WfA3bKrEk7Kn+npgYxuSujE+KOUlGtxxwKjDaG2SNSy//1hDOBh/55OL6BEDCVLhd3/3CLA5zo0UHcZORjubWYO6plgBymW0YiRksd0B9HBydz1SYUnAfk5GKgOADnFpy8yXZ3OjG97HZvmEWmgw/J+yD1kUIQQ8epKyEm0Vw3yGVW7EQuK3r2PDJEk3u+wZ6CUFiHSO1pAvSqQlH5GNguRh2ybuMwx43iHV7R8eJfXPxV8wX9ZpaXn2FIr10ypw8NIe4B1YmhYHpY6C9nR69GOiEfdbsx6cPn39lGutTwa+1pX3lq4h6t1RY49GSrUSqlt/qnBU1z/ywiWp+L0hd8tMI9ooEuqgfD+VdEE8v3nfPfFNrzWXIonWHymMljTNqWWcN3L+alrVMvo1KScWSEK6dpYnCjGj+BzYUQ6r9JkafFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(6512007)(6506007)(26005)(9686003)(186003)(8936002)(66946007)(8676002)(4744005)(316002)(2906002)(41300700001)(83380400001)(6666004)(15650500001)(38100700002)(4326008)(66476007)(86362001)(82960400001)(478600001)(5660300002)(6486002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3SzGtihBtPOpIJR7j20ax2IUP/AgN+yuAWt0o6wzDCqu8gsX3ZZtROxrp4v?=
 =?us-ascii?Q?1+YGQDWBR6nSM3WzoEYiqCNH1rDZXUUlcNXeAKah8gpEVmUXOBfImyrbutde?=
 =?us-ascii?Q?1+bjfmwPabLpH+n2BhyfbEhM76Vb7I3ZpLUqVRJA3rtA6id9JAvsv2GKfjso?=
 =?us-ascii?Q?JugjppoRwmG/aKuTLJv58mWZr5i1rtYpiWWFfDRSyfE+5b+vcPTVj2BBoCh/?=
 =?us-ascii?Q?SOaYL9jH+MXRN381Bjuap2djnk877eh6oS3rvxbekRPo0ZpBC+a81O50BU5C?=
 =?us-ascii?Q?NanB773O6KXgZgTAvqUp96amVtqohEvYKbhiTnWcc+qnddrSUWoqK3KPGbly?=
 =?us-ascii?Q?IvnHXyrEsg21TLov+szLoXw/cSNu6fVHD9tJUEfL8y9u1+wOB2GSTjS7tPmI?=
 =?us-ascii?Q?ERr0apqPqX/UNiZ1RG11Psbsz+xivC11BTPDMM2EZACTbrppse2OTmbj3oDj?=
 =?us-ascii?Q?WfyP+mI1T0ulDhLiAh67SSYCK6YYKuaYnC0b7Ctk1DQk274w50sKkTRJKG2b?=
 =?us-ascii?Q?ZSsaFdQzpSPlMO5Cu8i8zYHxoNvgPJRaUc//kzCyqi+QfUUGeHjBlsORuAlE?=
 =?us-ascii?Q?yzuV4p+VIaHmpAJAVV5RSWTtWJaRnSJ96umc9/lYoWgTJYAhLnMMMcOhoCzn?=
 =?us-ascii?Q?l3oluwPpalvobUn1OKANgwCN7ItZUBpGyxMFTNd2dszhArhBYMsq/AgGi1SE?=
 =?us-ascii?Q?NRgshddvr4vfWxQiXix4xtN17FUs1mpo8w/a82aOiVBEZGE6EAKxYC28Fs66?=
 =?us-ascii?Q?uUOMrhmxsSvsSdtwdeAzn4yAKTyHsKWj8c2TOWwsoYYP/CngLlwxwKDzjDo8?=
 =?us-ascii?Q?M++uDG9D/xzb8C5zHyUX0MvDhx/Hz6IGDT/ng0aNNAE0plp1xSGduOTEo1jr?=
 =?us-ascii?Q?4gEuNB6jyhEn90tvMweG9ZSM6szAXNwOjdzR4Xn6rIpCb81Eagu4mczeg1Cj?=
 =?us-ascii?Q?qpc55XluQrPaErf/9OE88HdK56H8D0001WrV9g32cggDbgaytrJhaf2H10Rn?=
 =?us-ascii?Q?mBiaw39IM1n+T8aqQHDWkEhrvP1VGdOEXhj81Y7n+dtErnAP0PnfvPGIOE8a?=
 =?us-ascii?Q?ubF3gFmXh20o/mMqOhzxGnfiUeHtEsvgvaU04caQuXuZeMVP0fz6nLG+HNqs?=
 =?us-ascii?Q?1gTTyn1AAiwLtFN83/rLi80dISAoXPRgO/XPZlfisefGdy6rorl4jbSBnJKO?=
 =?us-ascii?Q?8kQDhkptxuNom2wBEFZobrDVFNlaPiDVbxQpbkQUkoMgC4NLZ3Zu91VbTW/0?=
 =?us-ascii?Q?JQ48ZwBCYe/ShJN1nI+vs9cjbqSifLv73fdVs3wKwhfTEED/MNrU7qpsXm+G?=
 =?us-ascii?Q?2T1GVxazpTBX3OgJS2laj/8IaoYQ3elaOXmz9bOUZQGkwfv9l9/uP3+7Vo2n?=
 =?us-ascii?Q?LuGcOjRJdFgvH5CnV6y/jhukkNmxJml5fzbUwKJ0MXugr1jxkl7DVDl7g9Lz?=
 =?us-ascii?Q?qOzKJh8iHFEALOVtC4V+mf9kaz+onanBaDy7ZhXj18pYufZEsBwoicvQ9wKB?=
 =?us-ascii?Q?zfAH/rNwGq2SeBDNHIRROHa0iZBCjc3NfAO6q6mkiXG8RYgFvhJRfuZ3QDSS?=
 =?us-ascii?Q?X+At2bwRTZFbpMChsQ8sxwIxsHAhCdRF5UnWj6wZvq8JaMaaYpmaeiflulsX?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d2ef4-e12e-4723-a0a5-08db4cfd3977
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 00:11:07.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCzo9P6PiUiO5BTwAZ1KHubbQFDf1TVIqQB8zXoLLMb63aVVIT/j/TycqvQ5sPj3o/ynQ+8JZxaOzy6P6x3HuukMln8srg+8VtGkHt7hM5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mariusz Tkaczyk wrote:
> Use DEVICE_ATTR RW, RO and WO macros. Update function names
> accordingly.
> No functional changes intended.

This looks like a nice cleanup to me, but I think you missed that
ses_set_active() updates ecomp->active. So even though
ses_enclosure_callbacks() does not publish get_active() it is still the
case that active needs to be DEVICE_ATTR_RW(). In fact with your change
in patch2 it now *requires* that ses_enclosure_callbacks() adds a
"get_active()" implementation. In that case it's going to need to cache
the last active setting which basically means dropping patch2 because it
seems more awkward to require "get" callbacks when cached value from the
last "set" is sufficient.
