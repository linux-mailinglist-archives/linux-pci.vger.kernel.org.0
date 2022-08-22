Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6EF59CAA7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 23:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiHVVS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiHVVS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 17:18:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880CDCB;
        Mon, 22 Aug 2022 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661203104; x=1692739104;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=foNtjj47Vbq3BKwGfnWl8A1W4zVrs1LEh4xJhaLoefc=;
  b=D3KKAWQFf4IMsEhkNbZPEemL+X5mkhJovm8aH+Klo98JdpIaHJdS/VBv
   hNGNBlIrreUOYcU/qFGi2Q4jTjwDNZgJbOYrWoY5sfsATYc6j07niNJ3G
   O4CUg/7j0sjIh0FXCmFVIxEIcI2YEjl4uu5VAlOJPYZ+hMzSnvRmPKeB5
   jUivUkTAYz1QllhJphLGlGfMn/ZLphMcMXVTElCCChEEy0eqgOOHUT5dA
   cz8selI2naCX0I0bckaYEuFEqMOfPINAqNZMibEG+2i9pVLqCd1U7M1ai
   pIruUiHNKDLgsx3lxvsoxmcL3slAyPKc7FLAwt/JDH8izASCaZhBcTmih
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357503877"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="357503877"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="785002335"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2022 14:18:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 14:18:23 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 14:18:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 14:18:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 14:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geQQkea3OVxf19q9umuwZ480v2n/MXZQJlaZEHSL/l2+9ln5ypHbG5IjvuSE40oTAj52OFvo2oYe9v1OJgrES5wTDqu23FypSV8EtF68utuLeV+WXO01H4Wwe44FUQbebS8TMlRwR8be8j1Cr0Uuc8LFj7hwX8r+kZYV2prTd/CfAUDw0CT4OVJbbVWddHHBOrtZzdrnmZsULfPlmKeVK2acLOjo3nG8lboLUjSDFJoF/AiGTJHkvnBhYxd1ucM6C8xX/HDR4Uvby852mavvtL41Q0tTnLHB7PtZFHMevfj7DR+RfculYwESJ6Oj3ThKzzslskuHAL8JhbuklsiHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crc9tVRHcqrvB8oESGAlQQXZ4rcS+dxMJTs+8y8dHOE=;
 b=jYjoWScMQZw9ElN0wNNRSTqGYQTejv3D4mdqtAsB+gajpqGldbsXiudL4DaeGDPaSjdAOXoFsFQwaFXbL7I+4iiYaQJCN4811QaBQQmXUTBIhmoohucjsISncP2XmnWtzVl9RP92bp7OSPt8cUTV4gCKXVZtKKhOUVD5ABg3iTd4/WwmD6Bxq0IRyTAOP/Ij7zaTjKm8ZQl9xiuQv/5t7RV2vOkKTy2T8ZSyMCr+bxRwTjv7RvdaI93JKBJ0BOrq1L5Me8uHumYPrGVhuQJLiRK6NW3d3bXoXcvSCrVlZyfDATYQFNbs6eW9aqhe2tDwBSKa5hRO++TUyQSuHocUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7044.namprd11.prod.outlook.com
 (2603:10b6:806:29b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 21:18:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 21:18:19 +0000
Date:   Mon, 22 Aug 2022 14:18:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <6303f298ef92c_1b322944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220822005237.540039-1-ira.weiny@intel.com>
 <20220822005237.540039-2-ira.weiny@intel.com>
 <YwMktMqN0oFgCeZn@kroah.com>
 <6303dcb63e3e1_1b32294d9@dwillia2-xfh.jf.intel.com.notmuch>
 <YwPpLWgG37ObTMAP@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwPpLWgG37ObTMAP@iweiny-desk3>
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff47d415-8b7d-4cea-636e-08da8483d5f0
X-MS-TrafficTypeDiagnostic: SN7PR11MB7044:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7/948PX0oTTjBdgxk7Vofs40hjxtflsSRgRpf/xTlHR1D0sE6huUXVGJP49u2MbTxPMzvGeAHaon41I4mxO+ABwxeK4uzy4Uk1erXoNxUPDKqO+otKG3XLyYXmiIi48FpxuwAbf6/gTI1JskjMKe+fGJDXwWQ1lIJP77L/mApWGnW9/YJVfK+v/ZveTx0cKHQeJbc0D4G7WT8/0NWdZZmIUOfgl39vxSaG6UL4pTyMR2EX38PoITnbDemJTKnutokW5vRNTUl20Gvkue4anqlFBwt4uTy1fc/mSe+UMxXhAs+7pR9DOUuRgDuyY++prsgQKUwLwvlrfgBpmjlDjkZnFySABN4fA5LZnaDCCeK40Kv4a8hHajU8HTxdzxcFGrpqCJ2gOHMNlNZK1iMYfjARC0iR3SHH91yDLM5tut5lIFhLF61RTAL4OIGhwWxWtvjRMUZABkrCHd+gwKHkcL8S4GemsRlLGh3T1HmC3ppJlg7X3y9nCAH2t0Y1qmSjtiI7a55crKs7737H3f/Uge9ycrzwJ+ehfz77yUdQnPbAhmv8bGqglzs4TIdXQ8T1TAulj7VG5KQgtUkdVvNjtmnVMWlTGDWPti2Kh9lzl1XTm9WBs8Xai+rCkxXvETy0umY+Ilk7HAMZmZhuPvisoWT1LL8VFMBMfiCRMOqe85CI5sFM6+quW6BnmsChTmI33UWpVePCZep2hzJoANMo8CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(396003)(346002)(376002)(2906002)(83380400001)(82960400001)(86362001)(38100700002)(4326008)(8676002)(6486002)(66556008)(66946007)(66476007)(478600001)(8936002)(5660300002)(316002)(54906003)(110136005)(9686003)(26005)(6512007)(186003)(6506007)(41300700001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYsc1k+Xta1ir9ROu3Z3uN9ZwUopVmlZ868harVpRHax35D0iwTkB5RgIPqs?=
 =?us-ascii?Q?qLGuKgY3JTHelezxV5T3munzx9/iB2JUGpKcYHO7+34Mp5fLsRScHw/N8jzg?=
 =?us-ascii?Q?GzMNYdZd0iDH8Kd6By7SAlxJM1QWK7z8SyyUuPR8c2CbyCD9HAsZ4zvGHCSS?=
 =?us-ascii?Q?dLw25gdN79B/Vyu3CtYzmdE4A2K7Lg+dMhIQ8pmqbpnijC5YYbq0EYLyvIjX?=
 =?us-ascii?Q?yg6TGbAu1iLQANZ7WfmLToaaA5U2qhWXvfVruNeV4kATWW+QaoStqAlgV8Ta?=
 =?us-ascii?Q?VnKUAR+Yhc3ZPwwftm74Nn51lzWWM9+pjZmhinmxLD7Nq8XPmkOqR3nDn0qo?=
 =?us-ascii?Q?JYiFWo89xZGxnmNVvb5GujPObBGeHg8ugDVl7ysJcS0iyJlxyLWi1pbeRqSy?=
 =?us-ascii?Q?HNg/nanW/jgqQAyDc51dWXVx8JPY22ncs4TPqr/fLzTnlprybK9BD8eumTRt?=
 =?us-ascii?Q?+hMmnYYogmQSaCwAbSipBG3rkoRm/p9wtXc1mfLPaSsKMClkB+xzvu8o5iwQ?=
 =?us-ascii?Q?lRU/zbkmcMbzkVZoH6nQPlEzXRojtVRszonyourK2Zw7q7PW0tYM/DQ9XW1O?=
 =?us-ascii?Q?2Hoe3XoNf5C8MWf38Q8cXb0tFBu2wfib0jT5KvdsqYwVAjhWdYjTjK/O5+KS?=
 =?us-ascii?Q?7jPWqEQ+fnmkj2NVgpe1pcqya9jzoak0FZ9fAQBYyGOA6qBvjMD6CXdZJa4n?=
 =?us-ascii?Q?jxGwY9Zvwiyyo2LZjQKwhVuh97kKZz8DG/cTOzX9pxKb3PB2hYmhttigcogy?=
 =?us-ascii?Q?dM0i/UvIgAB5vVhuGJvCqdKS0bFjSms0hmxKjgun83YvZzv17wwgjOigC7SP?=
 =?us-ascii?Q?Cd4YImGjE3zDtfqyaCQZewJbAADWsDlhrWmUDgvgwBUZ7Pf71Gqf72+sz4V1?=
 =?us-ascii?Q?yDkB72CMfMCjeWtrdSNhsubwu4Z1mPtEyvTzpB2y5ls9Rt97ODrKPBkLEtfh?=
 =?us-ascii?Q?7xl0bK1o69X3/H3ALYVcSvg1kVmCnxT79zzkCvGy1GE3Kq/1HEk/km/ER7xY?=
 =?us-ascii?Q?Kv6zTZ6jp2lj7Jbn52iLrg+LnpF39W8Yy4e4fMvK4gaGbDvlHnSKmUC/12v6?=
 =?us-ascii?Q?Jll0sudgZ0X4au2b/WU+QLc4h043SoLr87iiOsLSSe/vNhcVQ+sSqSGaL2pl?=
 =?us-ascii?Q?f8SldC1rXp30H4Y19A3Ux+eJNzfp0ziKC7vqENy/z7EmLLL4TMU/fW0/TGZc?=
 =?us-ascii?Q?eKW1wGrk/hzbm6Xww08IUgCpMgMRXE6yJ4C6A0dFO4qQp+nXm2CWQOm2RJ2L?=
 =?us-ascii?Q?bPgRvRmYyb8TzFM0QSugMULkWwpuP//n6l8iOKrC96mQjQ8irJb6cfmh93AA?=
 =?us-ascii?Q?HSfrP9wF6buj7E1N3imS9iBFPTutHWb17dF5i2dMIgkieQYgb7rn5H0s7URf?=
 =?us-ascii?Q?2x4xNZkOITk6RUnHwLPPDRdUaebedyXiDBqEjQNmYqVI/MShJuGoLa08GGx2?=
 =?us-ascii?Q?DQLBfxzCimjRMAmJiPmzXGyJIrr2oEBZLkROKwqmVD6n97bBv32P/dojOe20?=
 =?us-ascii?Q?dQgTFvQItBS+grWWaqVZxHbWFuOTwxZ4lgGAWpKkopwx1MevLUl2x3G9O+OO?=
 =?us-ascii?Q?kceFdyKYeHQ/z7O5RUn8Z5sF6EF6KrcsHVPcg8oSbF2ecAyzZsup4toIH+8H?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff47d415-8b7d-4cea-636e-08da8483d5f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 21:18:19.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4tO7YytxvoDYmjfwD+M6J0DGLnV0NUEbf653OQR7RvcUtkvCHDNaax6n7dsHZdduriKl92C1SqBovtX0XWIkFvNBq6nhdReq9AD5u/tuFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> > Similar to CONFIG_IO_STRICT_DEVMEM, just turn this warning off if you
> > are a distribution kernel vendor who does not care about DOE vendor
> > tools affecting system state, and turn on CONFIG_LOCK_DOWN_KERNEL if you
> > are on the other end of the spectrum and want protection from such
> > things. The warn is middle-road option that I expect most distros would
> > use.
> 
> FWIW I did not add any Kconfig for the feature.  Should I?

I think so, especially as it is a distro configuration policy about what
user-mode PCI tooling it wants to support / warn about.


