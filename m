Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428305456D8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiFIWDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFIWDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 18:03:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB91C2D7B;
        Thu,  9 Jun 2022 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654812214; x=1686348214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dp7wA7Fjlr4JEPkv3xlSNQlrL6MiikSV+btjfHrHvy0=;
  b=flOJt5yazZmTAgTfcJw//eWJ9nObNJ8p+/2eQHGrfs28j8p4t1wiWun+
   wLXIS/XZ2SHxUBgXP9UnA6/uMl8J9HXmEVkUKO6oJ4+OSZZK37ZyRTK+A
   pA4vhJYK7KYjzRi1OBLAmpiq2WOyPLxe6T0b8Vi/aKCqMFVgOFDI4Ka13
   t3EVb7khRDajXiBEaMtnMmf+V2ka3RpcFnCRR9qrs0zkpOQ4G3t4l0Zzp
   9UZ50ufKu2VFy2FTbQ1F9chJgH7WzrhoeTHBvllcBnVHcTzyrK2jn9YmQ
   c47uP/+yZRh5YLXENbhKdX9tWDA361xL8hH9JZPoKqtmIRJlHTjQMrz0V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276205365"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276205365"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 15:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="616111864"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2022 15:03:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 15:03:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 15:03:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 15:03:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 15:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/sXbLnpCedDeDNmRrraFJYWIcO9soHVaMRH0olapulT6glXVB9zi0i0t32tZG1QYw1QMPhA7koTPE3OQUrYnAJNLNz/gKwSdHHiMo6Q5pepuImZv8Vrj9AwCddPsi6ZcmKKI6LODOsFL2yj1oL4Pu/U/3Xz9iIkCDy7MXtAEiiXaA0Sfyc3zeD6H+EmlmoiigNI4JLIYF09PZ4CgsWqWyAYYpnhohskHQEVCenmnIKtiQCjlYtkamooc1lQZJdKhd7p95ru1YEjCddSBkuSuu+2qUfKl4FbWsyUSdLq8pWBGajFynZ63Jz42QnQlNnINmi30mxrJ2BBFZBIlSR/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWFd++Q5n/Dg3dVnjgRkqd9G7C39kMsJXH/phzk7FDA=;
 b=IbRq/EZNDBmM/5nD0yxkyn6E4CB2USgzshPWoTtohnm23sqIvA6ddLfBNqlDSuFxw7wyOevVwuclejQlB4mEvKIljpL4g44RE8dDeH5UjqGRSDTqnvVYbZFGn89fxom6wxd2vlX9XT5Qn7qtUcRRjZ7h12PC2URyS4PhykJ9wllZU8ZrdOBYFAY1uKrt1QMxBQ1ABpJGn+UE8XSHLVw/TsWjWHr1Yr9SVuLThE1oLmFoRenSE90WB6b0Z1DjJVpCFCb8WfwmE1tbPGpPnEjzzeOgMQK03avLZ7HvfW/pP9hUuqaxGURLbBw/8613p86XZIBehyyd6kMmybxinH/FvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SA2PR11MB4970.namprd11.prod.outlook.com (2603:10b6:806:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 22:03:31 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 22:03:31 +0000
Date:   Thu, 9 Jun 2022 15:03:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 6/9] cxl/port: Read CDAT table
Message-ID: <YqJuLwlmn0oLwHxj@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-7-ira.weiny@intel.com>
 <20220606181541.ysb3zqdpe5cuk4e6@bwidawsk-mobl5>
 <YqESPug9duS6BMfQ@iweiny-desk3>
 <20220609092738.00007553@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220609092738.00007553@Huawei.com>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e391715-7f9d-45c1-f8b1-08da4a63e3d9
X-MS-TrafficTypeDiagnostic: SA2PR11MB4970:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB497089D5C51652D0371A31DFF7A79@SA2PR11MB4970.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRIBcm/bz7JvFAJlkC7nauALAPFl1gozKDoSUCUNRPZlpnbj2/8XmViiSr7NfIO+7iegZJT0+/eZ4lKL8Mg79LNeSf9f8JlsC3GWvyK+DOU4u4QElrDK3uKm6Ca1Kbc0+3zPDM7tEjRGodKmYxQv3gUizAZsV6RxkEL0vkwml5ykSHK7G4bx+2AXSPNCYD10yoYs3FXVWBTfiUGbSUQ/K3u8u7YS979cPp/RjQ06Yx0Jn7MjIp/Jj2wjXVyrtP8DcEbMMRevkcNRlyE9KAaBJHFe8sBrKhbhMZCHB16FcDEJIcVawcOhDH/GrIuRRsaVXm298K9JlTi6zayYMTqeKyihywYCNhFbVXWxuAiOnfFOKDi93VH2H0SJZGy0kRStZ53oRHm7uCaS2sirSbNSqZHHNLYBzVqMXZohCEKWUVeHV0WvCzr2cBGRSWm5+lE8s3B/QTHMqflWu9VVoNpfhw3mG+jEVImt1l9MlQH0xIWCUq7T+Jd5IiQrEu/ru7AGaa8gruvFqeH7sP3hZLsbMaVT0V9vb5Gf1wiCz70Qc+MLmDyGBVYE6KUBnx9OuAGVPJyxoTCJ+Vy4mmHLkw7wZiC1Ol8167akeMWzUEME8lbtMH5hwUA/FtK90qIrU0FBr6HSWlZT/cIS024ekA1Lzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(2906002)(9686003)(44832011)(316002)(186003)(66946007)(54906003)(4326008)(6916009)(66556008)(8676002)(38100700002)(66476007)(26005)(53546011)(6512007)(83380400001)(82960400001)(508600001)(5660300002)(6486002)(6506007)(86362001)(8936002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HHmHG+pNR+3zlkWaRmHd9LP/h3mG1hsZ1aS8fGEZcDSqKZG56nDmEsWr4g1g?=
 =?us-ascii?Q?DisNEeA7716uQWr+866do/+CIjSAf/Y5YmBYm8mPjZtGxm+hlwqwrYONrsgs?=
 =?us-ascii?Q?T3/9mBtipBpy9lDho/KJBaeUsNraE6fKATcT1Qmq6PiR9P+24qP5BrxXHICK?=
 =?us-ascii?Q?r3i99nzacEBFzv2xX32brZrbc/YE26+K3/29Wgt4CMx1HH8070tW3XQyXUoD?=
 =?us-ascii?Q?mYI9zPeHisRPdMMPxddPhsz1uFLWJSC0XQJsiqs3K5Y9bl96pZoo2wqaDPQw?=
 =?us-ascii?Q?OwB5u5nGfV4RZgmSKPiW/+9sZkmFctU6cGKIN0/ib1ex1vafO9k8SK7SJNEr?=
 =?us-ascii?Q?uTKloLNaNVVe0Tkv2R9rQcjJhfRIA+2uP+Z404RBK7xcSmA1rOCqgCnj8XFX?=
 =?us-ascii?Q?y4rJmeygQ3qsKt/7jxhD0hh76OnjWw+844Ph+yZUpMBsp+aoaAmUcsEuVwxV?=
 =?us-ascii?Q?XJQfFtooZvTPa18O4Pw0cucI49zolybCocyY1br254hXIbmuCO1FHnlC2e/C?=
 =?us-ascii?Q?HyPfiaMvadAM7o9oF9/SK9U9Xb5VTZEErXmA6tDXM3cg8ux5J3pkgdHXP3SV?=
 =?us-ascii?Q?pllZkshAveCCGs+W0oVqOpKUixlTnStdHACsf3kUg+pVQV8ya1xO1AA5sVFX?=
 =?us-ascii?Q?2JLtLsfO0FyjqW4vOBV2HMOau/zCrZVf8L37ep62+0ZKu5kQUEWe/Jz5ABgF?=
 =?us-ascii?Q?tU9Hq3VaEeMzvLUrAwSESUmSdbPfr+/zmRhdiTa+2FlBTBnS2YUCO6E2xVxF?=
 =?us-ascii?Q?rdKBcoc8aEwzPZcDkogfdBNdQonJT0eGOduQ264hDA7Dr0aObLG8PVo6v717?=
 =?us-ascii?Q?1lNB72nV/5nbNAIuYNLeVSOa5/GPkOMUsLCw8U/PTrCzr+ziCu4mxgqmAWuN?=
 =?us-ascii?Q?ceXTBmOP1K5ogxrrZn7fVIQQPGCEHE0ll8XGoUsjtYNg+rzk290JPxRUnNum?=
 =?us-ascii?Q?pwW+jcldzPOuhpv+oCPFDIK9OSExR61hk7rS2fFqD0VQSUxmC4tOjJfz95tm?=
 =?us-ascii?Q?E43IwhF0/Mqe76sEuKccIJOLG3rlNfrfmuO8Mu1DQVpKRnVOAlLZJZ8GSHM1?=
 =?us-ascii?Q?FytoYG4P2CNQsTDuOGZH6q2ENoe0y4ZzJCpgAFQ4mKdDy3eUW3D6Xym98X+M?=
 =?us-ascii?Q?G2pPKlsZLxhL230JkitWC0u23jLFKhY8fvzcti5u/wu6/RCPCQeO30OzmyA8?=
 =?us-ascii?Q?iQubIBFW4VZYDJckWghA/3vv7RYtnLeE6lv1VabbCujJ0KWktNoNpZHmNazI?=
 =?us-ascii?Q?zoABR5by0s8mSgLGK8dJrKK9Sy8cC646gWHhwXtfNcHR9UDr4aEoBKo7J31e?=
 =?us-ascii?Q?GXHrgby9+ZDBjnIE7n6fYe6v2cTYfIYl7GKiN711n2Nl9U6uCDRU+REVm4fN?=
 =?us-ascii?Q?vUadX7OlItgEXxkLqtFV/YYIWvcrZbuEiL3zt9FkXcja066GAYkbkeYaZE2F?=
 =?us-ascii?Q?CMURV8uf2Ht61pXJf/PdsDgikLJuoJC/0J6Yb1kbhaH3iWZVpfGZT1+T38Bs?=
 =?us-ascii?Q?R9qcfU1M7O/64nTmF268I69WURZldWjWzuNfgaYWg2u9joS3V4b8mbT/EZ1B?=
 =?us-ascii?Q?9GbEG+4TDFCRSuXP5D4cR9nQc2iuDJ5Jm5kK1rsWALvI21AtxqY/+HvwCDC6?=
 =?us-ascii?Q?NoAbwEJS7CnJCPloPHRd0+ogtSA6bYEb6SOZBjs7pGgvkK1eNQ66i0NHr5vu?=
 =?us-ascii?Q?Kc20i3+8FUj/Pic5+y+AU+IaOtsSd2oYyU3t9FL2BvsSamGUxBxFsjAjki6Z?=
 =?us-ascii?Q?ORG+bjaghj36VKv2c/mriJyauTyiRo0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e391715-7f9d-45c1-f8b1-08da4a63e3d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 22:03:31.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMhyoMBKJWVhBJ3L/FfuT2NlgKpSkcws/mjVjrWllPu+VhegX5TXrxQEPJPsrJJ6od29sySmeSoqxuhuUlR1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4970
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 09, 2022 at 09:27:38AM +0100, Jonathan Cameron wrote:
> On Wed, 8 Jun 2022 14:27:14 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Mon, Jun 06, 2022 at 11:15:41AM -0700, Ben Widawsky wrote:
> > > On 22-06-04 17:50:46, ira.weiny@intel.com wrote:  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >   
> > 
> 
> [snip]
> 
> > >   
> > > > +
> > > > +		entry = cdat_response_pl + 1;
> > > > +		entry_dw = task.rv / sizeof(u32);
> > > > +		/* Skip Header */
> > > > +		entry_dw -= 1;
> > > > +		entry_dw = min(length / 4, entry_dw);
> > > > +		memcpy(data, entry, entry_dw * sizeof(u32));
> > > > +		length -= entry_dw * sizeof(u32);
> > > > +		data += entry_dw;
> > > > +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);  
> > > 
> > > [0] looks suspicious...  
> > 
> > Actually I have to claim ignorance on this one.  I've carried this from
> > Jonathan's original patches.  I'm not as worried about the [0] as that is just
> > the first dword.  But I'm confused as to this entry handle now.
> > 
> > Jonathan?  Help?
> 
> Looks right to me.  The entryhandle is a field in the upper 16 bits of the
> first dword defined in Read Entry Response table in the CXL spec and also
> used in the request of the next entry (which is more or less a CDAT structure)
> Two magic values.
> 0 -  CDAT header (request only - can't be returned)
> 0xFFFF - No more entries.

Thanks!

> 
> As we are reading the whole table, we write 0 to first request and from there
> on use the value returned in the response for the next request until we see
> 0xFFFF and stop.
> 
> Note IIRC the meaning of entry handle was clarified in a CXL 2.0 errata as
> was a bit ambiguous in the original spec (we had two QEMU implementations
> briefly and they did different things :)

I see it now!  I'm going to add a define for 0xFFFF as well.

Ira

> 
> Jonathan
> 
> 
> > 
> > >   
> > > > +
> > > > +	} while (entry_handle != 0xFFFF);
> > > > +
> > > > +	return rc;
> > > > +}
> > > > +
> 
> 
