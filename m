Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B226A50C5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 02:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB1Bj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 20:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB1BjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 20:39:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEABC651;
        Mon, 27 Feb 2023 17:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677548360; x=1709084360;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TP4GrkEq0Ntqy487Fv5s/cQR/ML6kgsowM9dKKBFA3Q=;
  b=USqVZlVHuoGotkkEz2npMP4qmF7UBwZBw7lSGgmFh2uwa3zLWbQCMul5
   yGOqQIRzmsgBLG5ySYa2I4Fmfg/i2UzJRD0Rwnk80hcFDMwFEE3u+gSGd
   Rele/RCBmYR5TZdTdc9vP6l/JqL/YfPdtKWoONrsFOVR5XBmmI/m8DNHU
   5iiEalXqpSbbFqs67Vd6Og74BeVxGCFzeB52WZsEeJfyfIMz5nunZD3/3
   PcEbEHeUqPbLdFMOCp2NnpV5+6yy8uNSA05hOiqdSF8u61+DXZf82VTSt
   ffExd7h3uaciFZkd73WwtzHgVPi9w0LF7FUj4RDOuof1+nfJhNpux5C/L
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="331496396"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="331496396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 17:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="783636430"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="783636430"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2023 17:39:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 17:39:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 17:39:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 17:39:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 17:39:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmN0ZBZQwT8Hx4Qp25WEcmUnSABuN6MxnDoXcITTgXrJLvviv5gwKG4gpyLLKyQxqFc6ynxvyp9jNwRrnLTr4PIYLQ/12o9QcaTuJmYbFXQRmnceLRtUwl0VhYnYBtlk9gW0fYHbBrhq/X8M7Dk0PWhoOEFXMFGSCtqCPech3gkU4pRxPk4w2h/Kzi+Kxn12e6k4AVV8Ie4kLiIu6rWyJRggZhRwmAHNR6Ud0t453sQkTmnMGJbHab6wbcQgxVEpptbFXdaGSHyivUUDUnEkvZKQoQj/hVQUbfoWpkKRS6zNyeouLSObD7xlfFHEO8e35hrCNgAfFkSenXW7kY5AQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ySDYJDruUi0gO20eWdW7g7lbz95dWbcDT/MhP7m0tU=;
 b=O9pCLMIiJ8MABwtetoCXhzRETXERFivCtCw+pwDnwmzaPEGipflamKSlgyiiXW9ZIzD0gjiHJ82Cg/aGl+rEyHwfWJGsJdmQeSd6RVCxWUJ3m1tpWpadEn8DHGSdgFDaLsl8GF3Shlgcm9mP38uiQDLuatR0RmKTcvZH0c54iSccQQxBClZBw5x/oMEHZrcKybt53KPDq4ewXykbb2ZaHOngXf9gX612QXNAF1GY9fO0czChpdhQUGQ1WL41hDFJrwzyLBhS0iLldZVEWc9IcGfrdfCw64ot6lYcc7FfN766TSjCDBkSGBrEwtOhGdcoEjZQRyi9gNl0ypQpjUc5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 01:39:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6134.025; Tue, 28 Feb 2023
 01:39:11 +0000
Date:   Mon, 27 Feb 2023 17:39:08 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alexey Kardashevskiy <aik@amd.com>, Lukas Wunner <lukas@wunner.de>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
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
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
Message-ID: <63fd5b3c3a276_2765229470@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
 <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: d505321f-6d9d-49b4-5419-08db192c9739
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIwKMQixgDHVwH3z95lzIrnnxXIlWQj6IGhFbnui+PBiub5wxgYNzyfSS7J1GmFrkrXbc8a9XeJYTPQLHsJ2SZqa6sHzL0s222u7miG4pG+J+QhlCMdZMkHJTX3aPRB2kNvUnS4NiNcP77iJvCjiPlWQadpZI9Kc6cTJhd7fXxEeKyliEmLI3CtPQyXxblslwapY951n5xOlGzOudXdMrZN6Y6Bzj0TUZg9u8Wur37iOBUHAvUyt+Jbkk0gWPrS2KYQmM5LRZQyYqd3htujlp8GQTITkU4Aq19aq5pQFfeBlKxwJpuhlx/oogns+nHFHDjmr+/Q9KgYpNm6Sx4ArAeoLisHkhc+VAmskZ/kXi/GDCjy9AwpQ164Qebyd3chHDQlz+HCR0vJY0WvRZ2LyfKKmvPNGzjmVYCvY5RT0cSQ/4LSqTT8UyxxmfP4pWwKCgClzWdWyycnJf9vdgiIuNPYZCDCOeFv3Y281SkVxmc4hWmBC6xPQOt8fIX49wol5rTOQGLQspwkbhYh/n/yQx37/uqY/dG51AAA4GVKQ9YYnjTqwbfMdaHRMMeMs3jOBMsw4kVvBFlrdIqKt6IYokNgpjOdaf/bWN5ai1idsS+oWGIg0KoFrWtiQ52GlXxO+t1vrghPgXa0bx/VPpe6idA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199018)(4744005)(5660300002)(7416002)(86362001)(8936002)(478600001)(6666004)(6486002)(186003)(26005)(66946007)(6506007)(9686003)(4326008)(41300700001)(53546011)(6512007)(66556008)(110136005)(8676002)(66476007)(38100700002)(54906003)(82960400001)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P9tzgg/j2Arh5+yBU4AW19IQpGFcyr2FY8UfzxY0Zm5wywOMDnzXFseRrrN0?=
 =?us-ascii?Q?Uxy13OIMJ+P7d07wJxnT39odCLWwUMqt3+fYEy053CGtnNg4aeIhLiFBvXS+?=
 =?us-ascii?Q?iXNJvLyOdE5c2rp21g+vFYAJDY+MBFaX0bhkPkShITfbEDG7fvfVtYgFuh7P?=
 =?us-ascii?Q?kIa7iEWf68jbqC6zrFRX0yzyHZRFDLbUqzg85BxI3oFLsXPRm6ye+beb/4Ir?=
 =?us-ascii?Q?U35elW7Wyz2fhNXjKa1oZlZyoM/ezZ25/aXqF1V9zlv5hOQsontfouJP+VWW?=
 =?us-ascii?Q?ZBdtLFhqoWiCxClnQpWXIl++3WhzbgXCc15QldwJnFAF1PUr06vpnw8DzUcP?=
 =?us-ascii?Q?5PyJpWj7gbxOglr4MVocP8zgL8NzuSjbY6w2CAzzKIZTHuOfgIjUQwaLbVAu?=
 =?us-ascii?Q?CjcfcfQAPRYf6qVVvMEuIC7tahEVaZIIMU+V1sSMdiOO6a75aUO77leF4qF7?=
 =?us-ascii?Q?PvXw4v7USlI0ffTluHz9CFfqS5tHs7crsNFJbTvXM8b95V8z1S1O3+SpZ/7p?=
 =?us-ascii?Q?jDTvGBbrjyJAbugnib7iroRFzVGQvWRJcv87hfJT2wYOViA9w/3nzRaZwqCF?=
 =?us-ascii?Q?Yqy3QxnUyza3XCkmC2AE0UR59tZs4tPPRLbBzg40OXpvCbAcv0YDldvJ12qA?=
 =?us-ascii?Q?XvPrALJCLK/vqwK4JrnYtv5zv7HooGpNuPP2GiTdey8z4nnyrwgB9VUfvFzu?=
 =?us-ascii?Q?e9yuS8peM99GHAypwsYDJQFWRVcLcip+3+awsK9nAWxBCzJUiqE9hshcwRpR?=
 =?us-ascii?Q?P78RXYE3oP5r3jIMn4nLmxYo2j4GWXFPmhaa0J6JrTucAyeQHOx0LlYExMr3?=
 =?us-ascii?Q?8qh2CjZvwqqkCxszOwEYPMYVWTUfbCnhl3cOkdGLH+QHXN+5I5wLSzVq72x3?=
 =?us-ascii?Q?TpUmkUL2zWbewl5QO79k/zzcGguLo1b7m44g+98PhGSh7RdrhJP2JM48NTyk?=
 =?us-ascii?Q?UKYibvq2dBjcdWWY05QOoXfwlYQv2jms4jg5ybjIRFjUyO90QOjcufcZJlW0?=
 =?us-ascii?Q?Ivns6FNkMk4C5DnCbWyl688KbPWnBPM/7JmCnO2XxONBv2f+PtbGlaX40aoo?=
 =?us-ascii?Q?ehS8djBFPxsEZOeygyGNhG9o00h/jKy4ylwoTLb+j7TvPe/Jm7wbpXCfOJxe?=
 =?us-ascii?Q?H1Ov2eRJ5yMUKooBIL4hVyRMYSUXMOkQA80gmQqyYbPGPW4fqbZwjSf0krHM?=
 =?us-ascii?Q?bB+CZKlLm/YxCVHO0gEYjQsS49QK1y5Er2RFDtxyEPuTp4yyn3y9UIIoFrG2?=
 =?us-ascii?Q?FVuRzxrOSTQ/OQh3zUIcyVWM+ChDVxmc8ngUZrqlLwyI/gPq/YMWVxwfI3H+?=
 =?us-ascii?Q?TgNMhPrbvxqzv7uu4Qk0X7/ZwnURobMyDvyUV3UCtwmvowZZiMRLbs8gMWSA?=
 =?us-ascii?Q?66sM8KzsJipGunjva0AMoPuM+gHfAhVQL4ec/lHC8pJFnVQAwwdn9I9rtmNz?=
 =?us-ascii?Q?R/rJ5bgsteKjvNIOhToHEcJqy9VwclR6bTsP+cNzpeJ2SWDU0KxD66EsFyj2?=
 =?us-ascii?Q?SSH2e6+e4EIs2tBHRe1iLpawIFsvEsREajOuEERoNAZVxRO601uwdVZhy0Q6?=
 =?us-ascii?Q?078WnLD3nWUjFLaYmE2Er8A0bDV+XOZapWGhcMPbGYuwu2VJfug8mGyu5QZQ?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d505321f-6d9d-49b4-5419-08db192c9739
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 01:39:11.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDVCF3J42Yj9Mg5bWTajTsbTTAQGsUMW4y2fWevnGlGkYN3O14QtcQmLQdBHQF0LYJV/aQF6Q642rzmaxri9J3NDO8WjFR30A8r3ANleMqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alexey Kardashevskiy wrote:
> On 11/2/23 07:25, Lukas Wunner wrote:
> > Currently a DOE instance cannot be shared by multiple drivers because
> > each driver creates its own pci_doe_mb struct for a given DOE instance.
> 
> Sorry for my ignorance but why/how/when would a device have multiple 
> drivers bound? Or it only one driver at the time but we also want DOE 
> MBs to survive switching to another (different or newer) driver?
> 
> 
> > For the same reason a DOE instance cannot be shared between the PCI core
> > and a driver.
> 
> And we want this sharing why? Any example will do. Thanks,

I understood "sharing" in this context to mean that the PCI core can use
the DOE instance and the device can reuse the same *through* the PCI
core. So for example an SPDM session can be established by the core and
used later by the driver.
