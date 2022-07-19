Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAC57A737
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiGST1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 15:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiGST1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 15:27:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AC509D6;
        Tue, 19 Jul 2022 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658258827; x=1689794827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+xL+Ta+IhkMNuj0hT4K2huLjW+C3/DYp3P3lsqFpG6w=;
  b=aORlw0IDH1sE8Nl06lcCkx6oPHgw67SZ7+w3XJBBxBg5oCBrkVjkyWNg
   jsub3uD23WeEvmt5pT8JVyhseMgbgfWAke0YyLM4w0YxEfPjbZpRSXJ33
   FD0C6is0ZDmlNwhcHqCl3c81UktFKPd772uEbzlNYoFJbvaEPCCb1DQH7
   UJbFC567fCDBLd3gKyQ9ooXEclxE8c+B+tNMCmvOQgQXBmoad029IPEkv
   WgNG6kon9D/8DlnXhUodLdEa9aZcC9PfUSEvGXs4SK1m83mt+8EJWgFy6
   v0zcutL4PrYdKCOgNZlntAZoVA0gR+ztvlgI5cxqGbk035h2x18WXrBqT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="287734026"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="287734026"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="724375651"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2022 12:27:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 12:27:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Jul 2022 12:27:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 12:27:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 12:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md7MKWbU0rHPgMtkdzfn54fAsONSy9giMr2eV2ML0XLfF/IAON643FF8N76LWBMWIOWoZsNnunnUd9e2SN1CS9x19dthyxpnhAAetE95TU5UxijeUHDvB5uWtYcnzHRF34Ow6tX4t63ow9p7Rpg7bfAlgN4bydIApIrkfabxgOoeS9c6SBoNWIHInc8hm4HtzbqQ6Xjbnnvn46xT8ZH6MC3zbO0z0x7uZYLvidSsxMfNmioAh6GNCVBibKfUASKj+IGbILSouUF0Ij+aoGhtm0+9spwkDpd59P2gcd7m+kF0rJrvbYxXjRjBFcLgAOOF0YQcYnVx9IJ8pl4Uqpf7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBeZzqSxPTUU3issTpfz8Z1tNZV40lY569upIC5YO+I=;
 b=a+C3ywUXAAN0+ILQFSTGNEZ51SAneSpoB2QhLRJF5kFYL20SXkeEwfJ6VUzG+sLpIly88X8f7jQG5D5AnL390mssddRZzJjwZMXP2M4CmVGw8CmYdOjD7BXSRLux5QjgRm+ghNLIXbujsi351kaeD5FNH1JJ8hhxT/yqqYw+Km5AZf4u9UD+BF2E1HL31pxvtWtgIrNnzu/rFyN9XO/7ql7wfvqxD4PwIwcxSAUpiabMb3JhBPFCOjMhmolR+8bo2C6CoQJeFuNx/h6MSYtVYX+VIlRXOqbnyb1NTVRm8k+5mvtzXUzu02VKa0CFeLNFCYUQOUS6YNSr/HMrQ1a4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4676.namprd11.prod.outlook.com
 (2603:10b6:5:2a7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 19:26:57 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.024; Tue, 19 Jul
 2022 19:26:57 +0000
Date:   Tue, 19 Jul 2022 12:26:55 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v15 6/7] cxl/port: Read CDAT table
Message-ID: <62d7057f47fcd_97b642948e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220715030424.462963-7-ira.weiny@intel.com>
 <165819557164.881384.15799533765517431824.stgit@dwillia2-xfh.jf.intel.com>
 <20220719174601.000020c4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719174601.000020c4@Huawei.com>
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21736b1b-8654-4e44-f0d4-08da69bca51a
X-MS-TrafficTypeDiagnostic: DM6PR11MB4676:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYV2eUprFIO7QBOTBszeTqEMg89LRdCua6NP8hrKOR+1qTtgrBCM6bqnbSDzlzPQpNU+ukkieH7w9yMsC+u7XHFeeOzoLs4BpQamBpLnftj2wErNs6R3J35J/s056A5D4oBwAqN10R1v4hkp5lF+hOsMeo3eX2o4si/PWktci8JCyisN6ST3UoQsAcVQ+nYriLdj0j/UdaWI1cwG0NsuOAvE8XFIfSo8ObkyrNTRPGLCz/78Dskm6tXpwr0OB7Cv6IrUhBV176spx0ZIL24kdcuDCEQcCaeLLjhDK+cEf4ag8axGEMeKqpD9plz4J/9m0vvGOMcyEzBHJJiYQQpgU33vcrIMbqeUJ9zTLmD4z0yM9eRgpMRrcp3wUA7mt0oMXvLz4EWr9o3iQARlNFHZvG0pFZDo79NckHbbnRWLQq6BGXawlSNlE+pMsQgr5I4pfaLgPliOAaWtaupWEDac+FRjYRlbXalO7dAomSm8WuGXPVlqaQ24f/DDY2F824a//8QMF7+KX1nJTT2o4NwzmpACJYJQubXfMDR+mlHAbuxE0AGXnhXMf+zgzHEemmJ1n/B9FGFCgr/fbbE4g4tg9wNd15Jr5K4s5PvKMPeZQOTp73hAtxEKGTPzRJlVXy5S5bd8c/a+DSjJ34VJ34MCByqoZ7deVNYDBj8g/YpaTUdg0Or6j/gRJac1ncTPWUhFQQyAALtsOCHbM6rwdvuqeBfyOoVsejBeYKnJ4z5mVMQ38nRICEjPNvNJlwhqTAvBRkQfiIXAeUzTFx4T1ByNvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(6506007)(966005)(41300700001)(6486002)(26005)(5660300002)(186003)(9686003)(478600001)(6512007)(83380400001)(110136005)(82960400001)(66476007)(8936002)(4326008)(8676002)(66946007)(316002)(66556008)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWJ9SodC30KSYaTV+MqU78yie+slrNRSBKOoLvJtkq7QMAoPVPIJX6QT+NdO?=
 =?us-ascii?Q?hxNZdxZxDz8bXhswIYuo4Qv3ipWjXorgGDXXunlE1uyDPrXDk008n8/7rHWb?=
 =?us-ascii?Q?EswPFfmUCknyigIA1XoiluMPOaM16bGGsF05me7njoHgEw1jRJJPgApE/UYa?=
 =?us-ascii?Q?QmifHFC6xp+P2LjWyYfXhKsQoNeUNgbZBhaojKrArIWVI51yXOFJmKL11rnu?=
 =?us-ascii?Q?adiHMVgzL4NP7vZu5uKKjOMIUhvXtpmVkL8RLITQsd8dKrrb7CexNC4J44/N?=
 =?us-ascii?Q?JqLHt8yEVWWwsRKCir/0juKEFK60zcL5G7jyD87EHwMHcI1edaUUhY5KEUVZ?=
 =?us-ascii?Q?KvtqilG3fN0m4BpkIva0sqkhWtqD0+sITmfELPRd7CIZV+/UWtqodSzwJJnm?=
 =?us-ascii?Q?6TT7gBc999/z8/aVtpz179Qbu2d8m/vEkXn0QkRChKC7dux1QgHZPI3z+w3x?=
 =?us-ascii?Q?G4paLFSmBm8bPZ8hu2wHI4xIK8/E28Sa+cnsqrFmJNTVbkyhVAtznOdVQYak?=
 =?us-ascii?Q?gw7WZYvG2+i4NUv9W1SU0C3XE6jGTLhm6ioDJBYaxLQ9mgVZkMbLMEBhqw37?=
 =?us-ascii?Q?lB7K4HE3nSoOIbOgTAkk5+nJJ3rBg7V/3WXHit8NcPaxFqg12Y/QkOVC1Bjw?=
 =?us-ascii?Q?02EMwOgX+KmZNj3gxxrSlu0htEG4uokKhEroRrFsK+dDtMfKyj2D4GiMF+gE?=
 =?us-ascii?Q?UfF2vDgEpZL8yb4o2qSClyZkTZms55gkwTqVVqf8fR4sPmiI3/rMUgE9pS/E?=
 =?us-ascii?Q?aLLtn/PWG8ieaxxfLbBo0/YrsV7BCxyY9Oy3g8EwdbFxcuO0BglMzhr7ajOB?=
 =?us-ascii?Q?29dOzU/7Y4N8ao84eTWTOD5d46QVdIiPAlwcm5jsQgX1e9SQMO6xKZ71DggY?=
 =?us-ascii?Q?t0dV1HNVh/0blOmky1FydUGp80JrFHDaUU8WSoFjw0fHBNeUlcUhxVHtl4of?=
 =?us-ascii?Q?WGcMQS8/AkQDEE7ojKgezgNQGYhv6/MzRmf9S5FD+yV26Hd0Z4yhnKgmEm+C?=
 =?us-ascii?Q?glJSxKaGLU9GwJz3qP8A3to00NvST+R+BNQH75QgPgJJAAmwpn4+Vo9avpZz?=
 =?us-ascii?Q?V+i+QTuczPbsdxGc6Gw/s8HWEtLKH3WGSRi/2VXr6srh9LuaAQHC1vxtYKHc?=
 =?us-ascii?Q?z+KZ6kV5z1W3fRX8rd5Y2hQZ/jhyu6JbPYibYTaMwXZEsVNrhof0T7/jfOvX?=
 =?us-ascii?Q?cTxcDYrzUxLRGEQ72yCyJM5MHsJioGDj0AV1Za9MnkkTDIY8o2hRS1z0iZa6?=
 =?us-ascii?Q?AEccSkSAWObla/Tg0kTyYfzKsWt6rj6OkLhBgCxWK9bYoWMHmxi2AyW2V5Zp?=
 =?us-ascii?Q?bgbqOrtiN4oHkCvAOLKQmJyO7/L1QrSjPmLcGFb94Wg23LONEz1S74/PZ5mL?=
 =?us-ascii?Q?Uh0wBY4Iq43p7UpcyXkqhSSn+tFmhWKl/nkQAnIo33b1rk2TlAi0BVtuaGNj?=
 =?us-ascii?Q?UweCcn+1kMLgsBFl0PSGSZhrmKiiYLs5935xd7K/VPILH+nUh/axrvfJ4iTB?=
 =?us-ascii?Q?05dAEPbO9GTUwKAkm5PpkkRLSXKLB9LLwfT4G+UmKX4P3OIO0OdOfTOcyHkN?=
 =?us-ascii?Q?NK7aNCmD9X5Oohb4TbWlarbcCWH+d5oy407sChpiATzK4wKekEj8bb7qRlUM?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21736b1b-8654-4e44-f0d4-08da69bca51a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:26:57.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trNPhsEvAQ7iSzAXWG8wUpvUIrePjrNRYiNa8tD+1tY5Z5aYjMrMoqQ7juiZkHlmcaiFuZY2t92HUVWsEDOnhFRS9/ao+MTyyHlkuQOXQgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 18 Jul 2022 18:55:01 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The per-device CDAT data provides performance data that is relevant for
> > mapping which CXL devices can participate in which CXL ranges by QTG
> > (QoS Throttling Group) (per ECN: CXL 2.0 CEDT CFMWS & QTG_DSM) [1]. The
> > QTG association specified in the ECN is advisory. Until the
> > cxl_acpi driver grows support for invoking the QTG _DSM method the CDAT
> > data is only of interest to userspace that may need it for debug
> > purposes.
> > 
> > Search the DOE mailboxes available, query CDAT data, cache the data and
> > make it available via a sysfs binary attribute per endpoint at:
> > 
> > /sys/bus/cxl/devices/endpointX/CDAT
> > 
> > ...similar to other ACPI-structured table data in
> > /sys/firmware/ACPI/tables. The CDAT is relative to 'struct cxl_port'
> > objects since switches in addition to endpoints can host a CDAT
> > instance. Switch CDAT support is not implemented.
> > 
> > This does not support table updates at runtime. It will always provide
> > whatever was there when first cached. It is also the case that table
> > updates are not expected outside of explicit DPA address map affecting
> > commands like Set Partition with the immediate flag set. Given that the
> > driver does not support Set Partition with the immediate flag set there
> > is no current need for update support.
> > 
> > Link: https://www.computeexpresslink.org/spec-landing [1]
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > [djbw: drop in-kernel parsing infra for now, and other minor fixups]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> One comment inline that basically says the error message will do for now
> if we race with an autonomous update of CDAT by the device. (see response
> to earlier version on why that can happen).
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 7672789c3225..9240df53ed87 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> 
> 
> > +/**
> > + * read_cdat_data - Read the CDAT data on this port
> > + * @port: Port to read data from
> > + *
> > + * This call will sleep waiting for responses from the DOE mailbox.
> > + */
> > +void read_cdat_data(struct cxl_port *port)
> > +{
> > +	struct pci_doe_mb *cdat_doe;
> > +	struct device *dev = &port->dev;
> > +	struct device *uport = port->uport;
> > +	size_t cdat_length;
> > +	int rc;
> > +
> > +	cdat_doe = find_cdat_doe(uport);
> > +	if (!cdat_doe) {
> > +		dev_dbg(dev, "No CDAT mailbox\n");
> > +		return;
> > +	}
> > +
> > +	port->cdat_available = true;
> > +
> > +	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> > +		dev_dbg(dev, "No CDAT length\n");
> > +		return;
> > +	}
> > +
> > +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> > +	if (!port->cdat.table)
> > +		return;
> > +
> > +	port->cdat.length = cdat_length;
> > +	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
> > +	if (rc) {
> > +		/* Don't leave table data allocated on error */
> > +		devm_kfree(dev, port->cdat.table);
> > +		port->cdat.table = NULL;
> > +		port->cdat.length = 0;
> > +		dev_err(dev, "CDAT data read error\n");
> 
> This will be sufficient for now for the race against autonomous CDAT
> update potential issue mentioned in earlier review.  If it happens
> and someone really cares they can unbind and rebind the device.

Even it is too late to change the spec, which I do not think it is, it
is not too late to make a public statement that Linux has no interest in
supporting such shenanigans outside of a documented set of explicit
commands that have a CDAT-update side effect.
