Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830286E5789
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjDRChz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 22:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjDRChx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 22:37:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C5F40D2;
        Mon, 17 Apr 2023 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681785472; x=1713321472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XkS8Nl+S/BNTsu3WEeWUkENgPerzyGwAFgzfit6rtkw=;
  b=NrBZdEEl2/dsBT8lmlYOLeDJtuY2+/eQFZV/IY13CmLBGei9eZ9Yw59L
   NwAIK+At2Tj4fulNvT32doMjOJnBiNPuG8afvSimVfFTyYIIJ8fcU4ZOI
   aNWontKFvXw/JZkJsJ5nn3skLlMms4b3O/woWbRS9GIYC387KMduVZ9V8
   e/+LtlQTJhS8ThwAtMt7OzsZAV+MT8k9jDarDZqjReEHFDm65mjKJYp7g
   p2cLlh1oa58biUO7xSZg4X2biPHl8tsfpaGig43RorN2jJ9dtRwzcejkT
   BqtFSMbZYLtWGHhcZUk/KKGiCccqiT32HgaFrLXWDoVib2y5vjT9qzs1x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="343809856"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="343809856"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="668319851"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="668319851"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2023 19:37:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 19:37:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 19:37:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 19:37:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 19:37:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fksfNOl5xPOcC6knlTxYQqTRWXW9zsTNHeoUx6kutOHnHe+6entL6vR5OeWKriYEMv/tGgFbICrUPw9CyALEgkv7TjqgqofqoPtmPyuqkEHmiEwu2Zb0Zbl4VLKa1LhiWkfFWiIchLKEIyAnC0p2kq+EX4imAkUFC06c6SYzTnB81FY7HzNfINbePv7FGCWvPyf/jE+imFNesqOJdOj7DwCHVjDaThydBV2hKvIUSCfWG3agS/ZGoVJrw2FNL++FkHih/LVgD92iqHFo4G0KCjYBxobQHOfAehOBseoa69OFAV0embD8tkR2EAQp/eZ1FVi7o5lePhtneV0Ik9ODyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zib61m6NcjiPEa1wBCn7AMlO/ibQmmwuFVfJvlYsUig=;
 b=oR+IHA/omLv40AgbUvVm6MK0NkH+t6CDpfpYJxOeFIVSd1jC9QxfXkegj/pFuZiE5+vzXdgBj6zUHPzhei5fNktsWkDJbhfmYUuylXLfAQ9Sn6XcUZVz+Efp2cle9eV7Yuz0XvyoBazMuqJu1fa4JRkCKRn4ih06cWA+CE8spAaaUSv6N7CWaOkoPQ0mgom2lSsq7mWpdVZwr1z6xjviM+NnCy+GV2aYCxQfo0kcfwbE8hSZL7nDJHxwx4B/g82RNtGWgShjF650pT07Dt4p4Blq00cjeRU4m9HDPiD8fTZdd13s4fR72VVjnjBOFBlHyondntSZTiKJUtSysWhznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 02:37:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 02:37:48 +0000
Date:   Mon, 17 Apr 2023 19:37:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <643e0279392f_1b66294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-7-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0e0ad3-0252-46a8-56d7-08db3fb5e5ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UhnwgHk29V5h49h2hG3l9dCHIVl8Jfc3uo/QvrLvHF6Tjl2z1SfzCHjFwyl6xNb/ScJ61jR9qmHPF9WmJu+D/F2tGvLRi6Yi2HWvCMO8I8mca2sSo9sgyfvXUe2uX++N5boTV5NqVM3mh1RLV22nleCPTX30Lr8ldGssfPZsyG/WqfFbGdPe084GSUkTSqtIunQBtxcxI2q26l0SycqkLVX+T1nHeZSiothjWv+bXExhWdhmvMrk7XGNYZZKCY3TO1S2V9wYYaihv3YwytFjaX2YHs5F1SAaZLnw08rbWEM0ushjv6hi86HFmMSmefHmizl3Ad6GuHOhDbzuwQE3L8/FahiFwjwvLImpF/tvY+FJdM0BY659M50HG6W7nab+OooubPtAU9iM3mu2COkW0c2DNRLBBDYwscCMDWRq1FVTiwGJ2xaKrv1hF01KpZCcSlFjM5mCDk6ZByXvD4B8aGHMMDn0LmCO2OVIHLOB1rUcQ7yGuo3p99MBXCpFORLrtXRYVFyigI1l/HW5nrckjdNzpODs90k0pGW/wT1bUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(6666004)(478600001)(6486002)(83380400001)(82960400001)(316002)(41300700001)(4326008)(66556008)(966005)(186003)(9686003)(6506007)(26005)(6512007)(66476007)(66946007)(5660300002)(7416002)(2906002)(8936002)(38100700002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qh28q8YCCzItHetswUw/pSSsb18pdqTDGSiCU8zIAvDGpEbHB3aGN1y0IQQc?=
 =?us-ascii?Q?KWyAch078RDREIb6Iw5GtRua7NoSNF4QwCF5d35KTMsi7umw09DDa4lHZ/yN?=
 =?us-ascii?Q?C9rV/x8G0gZMobKOBuBi7JA9PGF1QafS+qz5iU3gUXlV4lvMyhP6bCpf/I9S?=
 =?us-ascii?Q?VOrBJ8KxeyVwVYtqtTDmygh5gUjJmJR9YXzIQUwVZ/Ekx3Ekqx/EyX0eaBsI?=
 =?us-ascii?Q?7EK2s1/d2KU5fcHFrvxBvXvOpyhvwsbDDtlp7UrVWhL+z8nhIlA9ZoD/ajtB?=
 =?us-ascii?Q?T9FvfVJKJ7/cPOM9eQex30caLdHOHBArA12XFucRcwcDAfR9c0/lK7zdpAsS?=
 =?us-ascii?Q?xTb3ZDOOya8yNqFCZ3tGsazrat9nAcs6ixMcS7Be28SMLXo4El3OgBCPWjDq?=
 =?us-ascii?Q?ZWZd+KTg4JzI86xg3MaguxdfpjHVflbCV2qQIYcDraZxfzid6YT7sG0VG0VP?=
 =?us-ascii?Q?9DS2n3qLASJpLiK8pQO7Lh7bFu49+RR1MYRnDGqe4TYqg+wsFerMCU1GIY3G?=
 =?us-ascii?Q?oXpVZ1BwB9i9QUIcoU1Hz6D1AVQ3V9jL12BOAJ9bicaSHxv57VGH8p5wNiwF?=
 =?us-ascii?Q?M537GrIqJ41p1MDdiO6yG4U26MxAWk1kgXljzCNj/43z0YVjHwuyPVIZNVI+?=
 =?us-ascii?Q?5NSqAIlikgnM2/X1B91omjli7iU71k7T5uuPPA4zd7un/dZXBD8X2NTEc50b?=
 =?us-ascii?Q?JD+FQ0gZltpRQxQmljkH2OKEZmurzHXg/yFJBdX43dEpQwcrrma9Q58+Zpxf?=
 =?us-ascii?Q?BR/c16ruEXWHCKHse9HJHJo8vrCwDeIo7IJWs633ZdprkPA90/OTAOD52yXK?=
 =?us-ascii?Q?5sSaihnmq7Rf0VS3rPIJI7DG+as9xlvh3frf522/URdmpoKdAqBWzTteblEs?=
 =?us-ascii?Q?NqLw/mgfhMauHUrEa06fwK5LXFU12JDtDJzUWveGNsKbC7xF1sRrhaR48Mvg?=
 =?us-ascii?Q?DYkrLp9muGR+6O/Z4h0j+VW3orEUG3M0JH7AeWucgd2peJ9NWT4o4oT5qRFI?=
 =?us-ascii?Q?6DNFhJ2TmsoiYjIkT582U3EYrnKydnYhmaVhMRh7qGxEDxOP+a7pvYBJ3IA8?=
 =?us-ascii?Q?NRNyQilanf9GvElwxABj7EuwoCO2pQ1267Pxjk8jwoyhrn1UnuONR5OaBpWF?=
 =?us-ascii?Q?FKKAufwpyo7yFit/cwkzsE6NNa6hZAWB02CIuLCIgjL+qPKU1Yb8FRQYnHaO?=
 =?us-ascii?Q?w80LkuKhWjAR+k18MUXHrIjZ1iDXic7x1drDXv80Bqryvi6f3OSdiDcimQto?=
 =?us-ascii?Q?E0Caq7pQJDe83K+eB8ltE1HT9haVrLMOazyp8Ccd66xP7J91FMxcjqT03Ctp?=
 =?us-ascii?Q?EOmoar0vZhbbXLvhn2mXm8WchLXeNoZQUMxbLgcExRIQBn10Cdipm4RSr/Ck?=
 =?us-ascii?Q?FlQ+989BSQyTmw0u42iuO02tlkPRrjXKextM9d6hLl81vSDsl1huxIpzaHpQ?=
 =?us-ascii?Q?/R9/OpBUIdbkBhsXWAdZwKWjC/YFVTkA9izMcuxIYZ8edzSUQ9MgP0/7LbvZ?=
 =?us-ascii?Q?0+HnCafNVrU3m6s/gI0tgK9GVJuEIC0sOzJe8VWL1UjL7nnZbVLOxXrV9/6I?=
 =?us-ascii?Q?7k3umfvTDmlFjuU3ODKyoEU6V5Xsqh9ILTbnGig0BAkEdTd5TLf+NMxnjFu0?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0e0ad3-0252-46a8-56d7-08db3fb5e5ad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 02:37:48.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Dfa5okU0yEn9waREzch2wmH1wce/m8FYrk5KLrN9SqpeE1GYzlqcenH0Bgh3iES5084YJ5bc3P7ysJdAyn4GCElYv8xmDI3I/swB82s5lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> RCEC AER corrected and uncorrectable internal errors (CIE/UIE) are
> disabled by default. [1][2] Enable them to receive CXL downstream port
> errors of a Restricted CXL Host (RCH).
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> [2] PCIe Base Spec 6.0, 7.8.4.3 Uncorrectable Error Mask Register,
>     7.8.4.6 Correctable Error Mask Register

My comment on patch5 to make CXL link details a first class property of a
'struct pci_dev':

http://lore.kernel.org/r/643debf5af445_1b66294f4@dwillia2-xfh.jf.intel.com.notmuch/

...also applies here.

Other than that nothing more from me on this one beyond what Bjorn and
Jonathan have said. I do agree with Robert about being cautious about
only enabling this for CXL devices for now and not all internal errors
for all AER capable devices globally. The rationale being that CXL
devices are a new link on top of PCIe and abuse/reuse internal errors
when they are conceptually functionally equivalent to PCIe link errors.
