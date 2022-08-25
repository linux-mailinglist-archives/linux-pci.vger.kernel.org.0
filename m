Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9235A19FF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiHYUES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiHYUER (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 16:04:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8168DBFC5B;
        Thu, 25 Aug 2022 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661457852; x=1692993852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tB2wdaChLAMhmcAUQKmsvRBfJgMd0G4q9L8QFJ/IRiU=;
  b=YIOQFsDWk6g6Kf/Zw18RkUYGk3WP4KA6eM9wPbuqh74lrjJwHqCkhaOd
   H97H8uJPdzBGEId1WuIw/fx+oCBVZ0UPkggSgS95/ZJGmGFwxMWKyC27E
   yotESVm0ZUcnPcBOSTjLY9g0yhEvBbIPOLLZ4K3fxERIALBOlJSXWUQkV
   XoM9uOsINzS4S/G4PqET0EeeWXmAF8s+w0v6Itk/ztV6k3Py3jMrE/W8L
   iyuMGyYG8DUAoUAPGMopoYxUiAcuJAemu27bbARaqFcMCmu2n05ejVPGy
   /im8G8LVu1rt2LCq9BWcdqY7cekWTKqC8oq2D589EfZSbOnn5+eygWxBo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295620963"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295620963"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 13:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="699595460"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2022 13:03:45 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 13:03:44 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 13:03:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 13:03:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 13:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsrUi3BU3iWHDt0P1E4+XYufWKFGuWBEwrBdmEYEHQDQ/wvJ9Z4yBzUIfKPdwKjBP3+/GH7NJnNwdLI2N12bvgrTAFtTaf7cdwS1cX6RsZhvorAAEKDJV16CZWoFT0T7xXNz4M0ukQPdyYU7I+FQ4CRfZRgmXNJJeWnB7Yo/wDDOmZ1E6RP2aUUmvQ+61is19bOhlLaA7u7oSD9DZWEMCyXrRpNrDJ7JMjGEOwTB1hvXypZdieG2agt4TqBS//XAGLyRayotuxWb2OARLpx2nEFJyw/0OiVr4+zo9e/YNwfV6amejClVbjztxOHC50ZPoJ7pXpCRMjDc5BHRXAmhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Z2YOflrUAoCZJ9fqBweW2TCEM16pBPDmi/a/tXnmM=;
 b=NKENVYJF8JAyP1Uvswco6S54pROuUORcuLhEpdTVd2o129ujBerTw8XxAXC7OwHlX86S1jm9DPRKbv2Dr+zZweVe6BTbyaFheYnpNm7cpzDNhbmQPfwgNtH9YfJ0E7uXnrj5oeWeqTwSlG02Gv7q3YBxJhq+xXgrIvMh+HhDXwuRMsSfUxGManHIeG321u18nNQKim+65893VRrN63SVvu1NTJwi+ZlaSUS8jKdzSmi37jNY3UsRxEVj3kQ1Tss4DhhwSfaAnHHVvZgOJ1UsFxQM+z/ypguN9/LuhUpxbJTzUMu6xkbojWAUHRQR9NpohFB7JNgH4eWu6J/6cAaOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 20:03:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 20:03:42 +0000
Date:   Thu, 25 Aug 2022 13:03:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <YwfVmlissGgXo+Y8@iweiny-desk3>
References: <20220824232450.723179-1-ira.weiny@intel.com>
 <20220824232450.723179-2-ira.weiny@intel.com>
 <Ywcl6HPZ4HYCc641@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ywcl6HPZ4HYCc641@kroah.com>
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73bb8e15-4565-414c-3fff-08da86d4e8df
X-MS-TrafficTypeDiagnostic: MW3PR11MB4523:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SV+xcmreu7TOQuctk+/+CadZj2BEoZ5lJwefBOd7H0yTqd6b+2wDUgq9DC1EBtFKhuHLNl3r0Sukfb/vEkMn/KmZxVv0wyrBvX2CjJSnCjExbWeiZbpXNoTvIIADJ4wREuOUekhW8hwsdXpcTNnd/9ZBgRdbt7ReKh8bfGi7aadqE3kLqow4Tw5fiJ2JRL7tcsMMf0CRFZIccSD2iKa9+uRclm2VfbA+ajpMYhuC2PrME+OmNeyNpjniylKCAHZ7MYhQk4wbrmQLfF8yjoJ+lgXIEmPuetHFTiwgCwyG66lAyxE8eWo0ZO7KYK/Do278Kw+KdJ4eu+sLXlaTRJm1vidE8BJvhr0iKqvOHoiVhycX3BkBVS495WXC1qYZq8C5YNbpa7RJw4GSnbGToPhURVwtEZSIsWifn4q014k5+yMxgAISjUzwsh+yl9xr+ZVmk3be22EKglyKUVsCWHKjyHRDRynmrpmyXcvdI9w3YIA+8QUPoyjUa7F20/JLWYwHWqPF159LezSdPdruzcs7bjHU6WkNH65faibzwKPpu0jXFB/v/zgwwOUWM/0BmEJmqGV8ZAV5YyFeMYciCKcCA18Q70/0HCGXBU0A51HSJEA5RgUTHhtW15jCvwUpat1vWjuvWVzHVrJmpKN51FWhzhm9lgEfUmisoJ7B/N0TCdCvkfcNIS1nt0u5Rpb7Sd5wXkip55ANT/4aiwCoGt8y5j60KStFMgBaVhagz/VK2m8fCWrW64dJX9d1VY2E0Ffg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(8676002)(4744005)(54906003)(2906002)(6916009)(4326008)(316002)(66946007)(66476007)(66556008)(8936002)(5660300002)(44832011)(33716001)(38100700002)(86362001)(82960400001)(6506007)(6512007)(6666004)(26005)(9686003)(41300700001)(6486002)(83380400001)(186003)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9D46ZmQf5DBrTNZLRJy8V9tcpDfzDDepJ1o1zehPTqvchm/DbHKUvEZZ7JsS?=
 =?us-ascii?Q?sakT2WH28OwWuTpGW1KEQsXRTOvBIiHxG8czT91wUEbkc9DtAHL5ngbvzBKv?=
 =?us-ascii?Q?WFnf1P8gG/s3xp8gK5ErliTCiOPdNrW2o86l07OR2RnzhTD4S/RSa0TOgE/Z?=
 =?us-ascii?Q?0HAQoYJaE9n6sA8orF1AIVKZMF4NiQvxxFAi94vW9mSozn6jRmtVdC+xyzw4?=
 =?us-ascii?Q?UDC+ubS8977xnrcv+sqX3jkzjztACxZ8xJD487ZwPYB7PHTVJr+feLHab9ag?=
 =?us-ascii?Q?hrjo3fXpgzMuF84dLkftO/IV16KJCI4Svg63g8tjPeKo+7Z7CSLBcM+6fiKN?=
 =?us-ascii?Q?gyPTUxOnS3X3tpILMl7lRBVrV49u4LIXPjJTwoXq31LPLg4BYLF/xtxu+/cl?=
 =?us-ascii?Q?AiXRPRSCO4Z7oKbDUbSavrUsbft/FRCC2uhKXVQOYhvSLerhCOU4610As2Md?=
 =?us-ascii?Q?90TlCnhUA1jirkvXhb4fRphZ1Xnu/RLaAFx4pn/+geFdj2sStqSVEsVZbySp?=
 =?us-ascii?Q?135qqi+ueaflVgxzfF6lQ4fHxw7FvfikJgIIbkYQ4oYkjB8vlzEHm8cf4ySy?=
 =?us-ascii?Q?sblVQ7UnCP8RliGMsoOZ2Vx1lqaWp/a8qz66yfzzGRJbCX/tXgv+O5G/ZEqT?=
 =?us-ascii?Q?c5CuW6rdKMw/7XwKk2G05Nbcp+ykddlJLhJQQmCuTqRNyw7M1tqJrCnoBdBp?=
 =?us-ascii?Q?8fePeBwyPWNvRVjgAkTPzv+UNajMRSADoRSUIXReTvHrOA6dlWdxOiEFI9Dd?=
 =?us-ascii?Q?dYOW/zAX75Nv0iXvkp1VvmZNVep71RMk5dGneuHmEyTtmoI5h0z/tx6kke9f?=
 =?us-ascii?Q?GAhmhqwTAKp/3xZ8HTLxX2Cc466PL76T0SMSrAL4FgNz2z5oTCe0Bya3hIRk?=
 =?us-ascii?Q?qFV0PwtVZBM2ZkCIAsfOSq1snYNxKnvv5o/92vrZwVBtUw1gApCRnr9nzjzS?=
 =?us-ascii?Q?Hx+w6HGZwoyZhyGASIh5y3KeWbKkbZrZkK4tKV8dKtagGIVKzvj2bWuSsXFM?=
 =?us-ascii?Q?c1y9u/yWj2GnvWh1mGFUZtpZNS5zNstUYMgxoVOwPMkICqTzF4tPkh5L5uL+?=
 =?us-ascii?Q?xqlnUDjy4mkcjLlbe+H5FKvmU+8zniElJ//eXgb+9YmGJxvkKsDV3PhIzwbe?=
 =?us-ascii?Q?yZIk/KZ7Bun9ZkYkIRPCsxxjNchV2Z7dNp7kulX7w96VbS9ihpf8syT4WlL1?=
 =?us-ascii?Q?lJzyMkwWN+qZDuxr4XszvIMaCKU9I2vQR7gAAXWHr2qTeFvn2oGS2PMt62zS?=
 =?us-ascii?Q?zTbSgxcYsYV+0ad3U8cms0m7KpnhA2EAIzRl3rslI3n53ZS0PqLAltTIQ3xw?=
 =?us-ascii?Q?PHjkSrU6pFiWSSR/TkPTfXT5vpLggOIHLzpTDp4b1szR9Ol4Nr9CvDn7jbnl?=
 =?us-ascii?Q?D3k5cEsL54892Z5eqsdTttcXxuC6jrIjiL+YKPS3ux6wp5FsyoSQbQNqRvAq?=
 =?us-ascii?Q?4yDcrvKf0KrKZirpwQcoadIyJ7JMCgOIE1YJpx3fxHmTHNBW2sT7oUvccLJ/?=
 =?us-ascii?Q?BAjR+xAyZCB5SXgx+mDbV5qpmNFfO2qnz+3b6S+1EMvUHmYWhowh4/nupqUX?=
 =?us-ascii?Q?g4AABJrp++653sg7U9nd5bZoLHAK3CDSgzd/05RD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bb8e15-4565-414c-3fff-08da86d4e8df
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 20:03:42.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLkAqJHIzPKqNZg/7HsvMvWx4CHf1ImUaZKOyd8qHBz2P83NJ7O9MWpOimcV/8fdXVD+L9wf04IGlzUfTAyWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
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

On Thu, Aug 25, 2022 at 09:34:00AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 24, 2022 at 04:24:49PM -0700, ira.weiny@intel.com wrote:
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -409,6 +409,7 @@ struct pci_dev {
> >  	 */
> >  	unsigned int	irq;
> >  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> > +	struct resource config_resource;		 /* driver exclusive config ranges */
> 
> Naming is hard, but let's make this obvious what this resource is for as
> your comment states.  How about:
> 	struct resource driver_exclusive_resource;

Done.

> 
> Other than that, looks better to me, thanks for the update.

Thanks!
Ira

> 
> greg k-h
