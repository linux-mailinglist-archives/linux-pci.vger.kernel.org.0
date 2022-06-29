Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04725606BF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiF2Qxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiF2Qxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:53:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF02321275;
        Wed, 29 Jun 2022 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656521626; x=1688057626;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X215X69ueilej1WWR8XHJUVfpMFg+LYBw7kj+b7JUew=;
  b=ha8kRqLwe1au4hdM6BW321MBvR84sKffDfZLBQ2YyTearRD3s6XXekIO
   lCYnxGlfl54HD+AblE3131AcIAWeiPOJfeX1OBcO8+gkVN3fK9n266DOJ
   OzoRE7a9IKpeeUY+nWGU2ppUlYphzYDvXHQpjbgHulWfTfVcNapnpcTVu
   MiucvAEHpYwlRpkrGLdNSgeE0QCDsY/sLK4n2GKTHQZXRjC1dTCPYzOcq
   3oGJoKRssMSOq0aYnFr7mtV/Dqeg/kKL5bdXBwPAGRlW0A8yf9Ihg0/YJ
   jQAD17W+Mk0+o/QLEbkOPiWbMtsv3MUPkyrWBLKjuBvQa+8rvNN8gageT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346075073"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="346075073"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647479704"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2022 09:53:45 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 29 Jun 2022 09:53:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 29 Jun 2022 09:53:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 29 Jun 2022 09:53:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoVUrxA6LDQwlV5QirDdX8FyESGQ93SRR1YH+rCOud8zjYjUDYzI8+ISpyGJidb2cWzO8jXxP+J2rDAgnP3XBjcoGIVyPCwI/vofdEdHNZs4DKiNv2eHjF1dhKwpbEPobhS8QdXDUZZUyHwoGqaC2cH7r5+WZN473MThEtIia5I3X2Z2FlhB4edML+zYWq/VAVRj3mW0DW74+8QnQB65E6xAxS9LJAqRdYlWgM25JzvCucdgVcv8ltx3eNZPj82kt9VuX/hsNsCWYxmVl6P6Xnri5bKd6BYkAx8ptJC+IGv7gegToRo80bSy2U/GtrIjKcpmuoS6W+83egb7iYuChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2vDq3ZWXPQiaKfpb1JnPUOZIGftIuzr5BG9wZZjWrA=;
 b=HrdSFg1x48ycqb19wlBeLAhcdom2vliOrJNeyBo2sBonmL9DTgikOIDuJ0KVg1as1LkjCeh3nC7Dh/wj/7kOkLRcxi2HAkV389n5iMjXDfw6h5yfsKekAl00QkJa3VtMSK2zEurzUojTTNtHZgLV18iPA6DZ/JeJY07dnD11CWRBRK5z1iEMDhOCHXhODovt6HxXDivzucb4CMGs3XzY4aHmL81I0fgbGHANZJY8xf1Qoj8yeOS7redxZ4b6V1ElNu86s9XPkthRqfhBN5JjIxSwVlV3v36Pv0Fle8lmTFC+n16xqimGrncfbFXBVwWhqfOHqh3Gy+8objYKOI5z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 16:53:43 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 16:53:42 +0000
Date:   Wed, 29 Jun 2022 09:53:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <YryDjAO00R6sJy1d@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-4-ira.weiny@intel.com>
 <20220628151626.00001c0f@Huawei.com>
 <YrtGcNWcmzumj2gA@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrtGcNWcmzumj2gA@iweiny-desk3>
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd14edf-daa9-4081-df98-08da59efec87
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YGnAz0Jxc5IQUILjbAFfZIERdeZ/TzexIeH0Jkj0FaIsfNo4mLOom7iCPEZ6GMfDiyb9OmJbqGKN4O5Vf0G2KX+epCC/s6+X3Nua15f36K0Pr+N/DeyGgqY5zthDR8CdoFSD6dsKi9NPegjQnq6INZIR6lrH3y9Jeh4XrpNIdQPfaFc+4dMwV9UX5h11CNtQG+eALQct5uFQivMxJ34mxYM+DeEzG0PIqEa5ypw376xGeFcHmX62FbCulSUEUqjW32xURopxkSHMd15WhZB65FYMJoC8eRTj7o7sBQivmatYl1qC+9do5E0WYqlM+G13IRI5t8djbkXcogYABdx1fy56MMCTZ5Aybn6JYW7Mc4g2CwwP/2w75ydoisiboBxZMUUu7+qHd7TFSJV9I0lp9bRJ51Ixa+ZVV9oZzEA4xgmONxGKWI+qAE91y0vkqWZuZ+nTUbny7NkKorftQ0uPOZbe1x3yx7wVf9iWXEiq9B8TFRWcBR2VoWXGo9CltX7WrHAt8kortmjXDAD8qg6aptvYWqXNHdSFIN6hq2ZXm4WSbWNeXRkagaSyReT4p0eQ/SdoHHNrb4KxXHYp9fEa7X/qFj48XGbXJgY0vz4Tvwx9JeMhLoKDBs3RWHlAFITYViTSRPppcedjiv4/drRwJXpkAH64VWlLycw/TRyYxnSFvLqQB7RP15uQPaujoHu/lp0SELVmrlrTfWLsB04v7iZkYT5hTuRfzvRRBsMiR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(396003)(376002)(366004)(136003)(66476007)(54906003)(41300700001)(33716001)(2906002)(44832011)(8936002)(82960400001)(5660300002)(186003)(4744005)(478600001)(6916009)(6486002)(8676002)(38100700002)(86362001)(6506007)(316002)(66556008)(4326008)(6666004)(66946007)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4ZLgLsUwPPkGC6mDwVu1e3/WqDOYX5aFfE4g62zFuPSVnlbK2qVzAYn+cmZ?=
 =?us-ascii?Q?OldxCGZj46X7uhl+MSYiWUjEIXZrhS4k+etLtTOEJX5nbqVOgRR/yYBcAtTe?=
 =?us-ascii?Q?fZjIVf4xO7qQDLPrOTS91nQ9U1O97u1ieaIH3Jy6qzxVFHirS2Al92JX1pVw?=
 =?us-ascii?Q?sIsHa+obwGBiLQy/BqEcneCGdphJnju/n8rm0KkeRIVl9OA/Ftsm3QKPSLmE?=
 =?us-ascii?Q?VuUU7THzQMS28Y/yrDVKd85Dtl5w63qa5wt/7Uw4MdVS3/ily2Vhwi2yZ8oQ?=
 =?us-ascii?Q?sYS09b/lUGfHREQ7f7JW3MdB0I2LQQ/urfmY4EBrpV7QsulR/KJUKvvOD0OJ?=
 =?us-ascii?Q?n/ulolKT8Pv9Urhmg88dkGAxBbS8lN8BoSEtsDfMcHTR8v8yuG32+HL+VrWy?=
 =?us-ascii?Q?QWg8p8tXkVk1mwFwSW2PMcWX2Qw4A1gmvz4pWSWvyGY+F5CvhvTayBsRnWhy?=
 =?us-ascii?Q?reMCD5vQ0tfO2TSlhAKlArOU5W+x4SIrVFrnY/iENZUNh1ui8xfeRwjpBdeA?=
 =?us-ascii?Q?S12ItKiRrcroArmrIkRykaVrG1b+8PYHzFvHptClHGtzNu2i4/28EW4Z74eE?=
 =?us-ascii?Q?ialC65pV6j6vTSc3Gfzj4E5ovie8pMqYqO5Za3YDfDtTNkivGPs9udH/V9dt?=
 =?us-ascii?Q?5i+xg97RfOKv0CJlSiYEfKzyjU1cGWG8Q/evlD3tnC/vbDvQtH/JBXWcP0cB?=
 =?us-ascii?Q?X/M01WglLZ6PJdM7wbxxk8ViPMpZDOL4gX6psFntwqPJ2KbtUeqKflf21dgk?=
 =?us-ascii?Q?1/Kj6jEO/7eMKkfH/bs+yER4QyjqLDleXeRo52rBAKzonWa+U/ZO3efnh6w8?=
 =?us-ascii?Q?F6q53aMXpjzimRfooEy1KaURgM0qGsca0zAoiyxFt5DHPqnfOZRi4wMMl60J?=
 =?us-ascii?Q?gSsygIbysPJz0AWPJ/JkHpkw8WVpayqnAUvdg49zMFg0Fna06MyJtziOURMv?=
 =?us-ascii?Q?6MjSodfk0V8um3xxDu3TQqG7lSeVYigeG8q8CPh602jyMvb01hokx40XEaAE?=
 =?us-ascii?Q?4xO8nW0c/GoqlrY7Ph7MIYyrq3JmjBU0sl7chsXSLmuiYSMJ6lZy+TRjvUhK?=
 =?us-ascii?Q?lizW+dAM0VSqxwiy5QUuu4+SiaQxqbuY8SYmFXr+kC03kIksnKaGHerGvvyW?=
 =?us-ascii?Q?UUvTCE3iuJlTiCJPnsToaIljP2dt/FAK5BUzPsZCmWxjEiehmiuwqX/zE9L7?=
 =?us-ascii?Q?/gImqme0NDdql7t0F1S5d59YVXBMMef/jb/MArFi5oVe0Oz3Zdi36iqpY1Yk?=
 =?us-ascii?Q?YuuBI3dTX2ioHvv2riQP5wa0jhVJh8gOOIq/s3oRjIn99zuBTsmL7+Rtvl/M?=
 =?us-ascii?Q?yRz7OAha3cWIE2RTSUQRgiO6FG/RYgZ0T2dLMPvTNHJARsxlhHkLmziUj8CV?=
 =?us-ascii?Q?HEmjBKTDgA4uNsvTCAhkkbuy/DJh+WGYKnnAccTrtS4hrQsTk0OioyPXe1xg?=
 =?us-ascii?Q?gb9yhGPTOM7jI37NIdIYbjsqE/Z+Y31jl8HPqXVAMusvyzZ4ReWFRPsZTEog?=
 =?us-ascii?Q?jnQIxTWwyuMFKLuujJPBMpKDlaDv1DlUUGmEihiqaAvh/AltDriteFcop5Ho?=
 =?us-ascii?Q?UR1fDwd3gVVWDQcaKD/ORmLJxjHIMvAvR21+Q0fSnSH4o/Ah060sTSrtdgsF?=
 =?us-ascii?Q?5S5AMJnWH4J2ZQrpGqd2VFaFyu707yq6eNPYSksFUNft?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd14edf-daa9-4081-df98-08da59efec87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:53:42.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skOlawNnwQAnWjLUJSWTMk0AjsdfvZoJ9yLz0GGn7ovHEwYBxJ+2FrqAuUiiyt5K88CMTB/9cMAG05gaLxwDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 11:20:32AM -0700, Ira wrote:
> On Tue, Jun 28, 2022 at 03:16:26PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Jun 2022 21:15:21 -0700
> > ira.weiny@intel.com wrote:
> > 

[snip]

> > 
> > > +static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
> > > +{
> > > +	if (doe_mb->work_queue)
> > 
> > I'm not a great fan of free functions that check a bunch of conditions
> > because they may be called before things are set up.
> 
> I'll see what I can do.  I do kind of like this but I think it gets muddled and
> I'm not dead set on either way.

I've completely reworked pci_doe_create_mb() to use devm throughout.

It is much cleaner.  Thanks Jonathan!
Ira
