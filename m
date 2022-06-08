Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F9D543EB3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiFHVio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiFHVin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 17:38:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7306F473B4;
        Wed,  8 Jun 2022 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654724322; x=1686260322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AMaxdsxmqwDZgsdYHXJ491YfgblGYmLozlawVHZCcn4=;
  b=joBeROkqMxoDSzEQxDjwGriIQOJ8Qd4NXcEvP2sIJwR7arBCS+iuJs32
   cugQ9Pbyf7Nu/hcoyRG7HPbV7MJZ6HGg9uy3L26y83VKT4/CvnTZUG5Lf
   rqXLcth6hrwVi/N2Zvk65GERmoR/+8xcXaB7Cm59vnutFAR+nPSnT/R2n
   V/i/ShvtvIGrqvSbAVCPzt2ggeiWPBEnlHOmzpdWHa9phBX+PbY+rF6Du
   nPX9RyStH0GypXgQ7/Jp7V4qD/u77R19RoMQ06GL0L4o1N27aQDY1MZIR
   aGC+rexhiOHac1YE7fDHrg2g6GsJbPDnYjVlN9veDuwm/UtEX3TiFhYjF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="341151818"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="341151818"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 14:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="555610734"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2022 14:38:41 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 14:38:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 14:38:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 14:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Ai39mJWdnLNptXHQ7pvsTtSrIigmtmqgrPGFpUjzDFEk3zTu8oaW0RLrEBZDa9/ieT/ayC1sO0f9N+lQvlHd64WoPoY6M2jr0YI4fs0eA6tlt4H26h5Sq+glUvPvdfmU8u7bSMrWRQuI5bybJM0wc9ipPdD+LLn8TtL2klipfX2VO3deX815pI7HNzZe9L3GU9Un9QwpAhe1GUxWsKlEUojaIdJTWyN6uPwyIw0aOMMxDSRV2GPp+kqas8R7hR0OrUwWsfGdpXOjrFwbSAkZHd1TB5l1S9ZMPJpyzFCKvikIt90d5D+hhIGFeare8nbP1GLAqxVk4w3uuCfoTwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJsqUvg6rfNnk084D0qO6VLmqe/LkDnNJJ/dsxvZvG8=;
 b=b9b1NZsFSBth35zNGlCWnmIrxTQjM/NpZlxONMCB+Rn8MImsIZji8ExDIb6hJHBwOpXoGiXeRmsN71ix2NrHi+jAcCKBDO3Ueh6czX6OBgYBprOwE2iVYzstPvLdNeBHlzkJM2qGaAkyh+yDAgJpQxyhEx8PF++1pOD2HhKeRqek6QoJWh77b7EL8+G1zsTIsejrx4xNMlVZliDVSRRI+yL/+vCpheTSigMNVbsEoqrSHMQ9AAk0grk7TsF6ka0YeC8b5FYU1nFROP/TpVaU0IZSKKjOlGhs9oX6xGFR9qz/4cnholC31F9TxiGq3vNER0ETGniBPERJb4a5uGOgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM6PR11MB3449.namprd11.prod.outlook.com (2603:10b6:5:d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Wed, 8 Jun 2022 21:38:40 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 21:38:40 +0000
Date:   Wed, 8 Jun 2022 14:38:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports CDAT
Message-ID: <YqEW21rs+LkOHOWS@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-6-ira.weiny@intel.com>
 <20220606174819.hhnb4jh27nxxvrdf@bwidawsk-mobl5>
 <YqD7BZnbK4wuN6Zm@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YqD7BZnbK4wuN6Zm@iweiny-desk3>
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce76b2f-0a0d-471b-f17e-08da49974093
X-MS-TrafficTypeDiagnostic: DM6PR11MB3449:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3449A24739C75329CFCDC21EF7A49@DM6PR11MB3449.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5L0Nthr2hKIULlqd//St6I2bK+6FlJ5QmUv7COsuUtOINRWj9T6a3fGzjiZvacku8k7G5nXZuQu74XBA+pYCQr3rg+sflmJ4d+NuxzUcFPNYID93CplMJMmeOI9nniQ1uUdf3UwDlbYOVDfLKAo068UcEw3DlSyxjQVlr8u0W1hC5MXUis3Ta5jPMjhK583SwRJCvGyj5AkXV6y4SqNwY9H/QkR5IlU3nA/J5ZHZiufTptPqrWbfIVfFM5bar29wXsgtam16Clck5U+06uigk2ijQkcAxBNGql9ZXO7JpRDdFZSxi+euXKrI9sPeZtNGx7h83FhqytTc3MTnjRlY1I2iO71xjnoFg2ShSpHHQzBlZ+7cptYHdJxPBRWDA5by43bhhxTPfauSnP5beVmmEZdtw9qciRN8wdirpsGH0mDSMJ3qtDdwC+BjAwsoqspzmiIh5EoibzkLrE1gigRFpPFucE4PaybSmkyUoWB4GC3PuXOGbcayeerZEPdlq0OIxcSO3EScoIiANuc9AQTZm4wpZUZttpN7ro1H6UD7QxHiTvEMMGaLM5QSFH/j9AvL77WHcmjZQSW92/aJ1wozHEYyaUM/cGY+50eESt0rHX/mwlizp9zpz6+4VFF9eN9zKdJiAqGFmIE9R1UA0Bavk1DajfqwxmaJqYL8DIzoAlPqaJV2XCKP+IfOGMzc64V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(53546011)(6506007)(8676002)(316002)(6666004)(82960400001)(83380400001)(54906003)(6916009)(66476007)(66556008)(38100700002)(4326008)(66946007)(508600001)(186003)(33716001)(5660300002)(2906002)(44832011)(8936002)(26005)(6512007)(9686003)(6486002)(15650500001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wo325Oeb753BRRYW5+YvaAneETX3oLP/c7TNF5IKgQR1d0D2DQshIAC1jM6p?=
 =?us-ascii?Q?TC90APyLb+Socq58JNXAPWFHBd7RZZ3olHkFUz1CLA8obP7hbn73F+1xHEUR?=
 =?us-ascii?Q?GHAcKmluQVIUXJSuBkXnNsOrVxvOg5AQzhcMy9B2KNxG6DW3WSSEOsjcNAe9?=
 =?us-ascii?Q?hk4cn50r0pnggS9nlL6vQZXG8GiQ2dj+OBM8Ob9lu8QolmOIByFDR3tZp9hc?=
 =?us-ascii?Q?0Zd9yrJ5KN4opMsQVzZfIMVCKwi9wtSnjkrWKnTgbiprxS2dsPcBipBi/kqj?=
 =?us-ascii?Q?oxCIGvo83NE16Nt16Gqr2ra1LN9aCY3Ggj6cf8S293VLF6krlJqfcK60klsq?=
 =?us-ascii?Q?7RN3sWXqIwo7tTjwGdjVTQNxi0w3J0r1RZD4sm/gjdbNycntLZJwbJFsFYg4?=
 =?us-ascii?Q?LVinF3bc66s+y/yiL88TJrTCMX4HJQHykvO2I7jw35q6pDa/us3fJ9+Si3oL?=
 =?us-ascii?Q?4AYhK2uEErvr6EOxwGpgqareb3fvhsbLxMCtsYXMA/5PzkfcadtXalisZ1c/?=
 =?us-ascii?Q?7Rd4Litf5i/ahnKCs/fFMx3EILDkiK7KK6jql6+/qW4FpQ12+Z/J2Wqdt0A6?=
 =?us-ascii?Q?KiPDyjfS+9W37GHj/+tMMpXvMzvmM5knVfiJBCUPzsBPDE3X2zAI0EQnIdJh?=
 =?us-ascii?Q?kHILIOaBNsKlP5yzLskgACJfFWJnOc1ulBjrPJXmnpzP45jxlKJ8VYo+anT9?=
 =?us-ascii?Q?UXVPgvSmT/fKAyM35a71In6qGiO8tTREVB1lGIW6AbLBgZpsyzC9LvhDxbRK?=
 =?us-ascii?Q?ZAsFRut0loVgFSjYVjmIWvDcUjvDpYr/h4PggKN4fRftYhsK/Vro49b37rPe?=
 =?us-ascii?Q?pL2bPFeKyaTcQQ2NVZbfNNR1shSslmrrKYPt4IW4kwiY7QIgGzQT7NKa/GQt?=
 =?us-ascii?Q?ewGNTmJf1HO5bgcU8Mn9fqsn/T54D52Teq/ihPmpENdscqUOwLwRJFq2f3eV?=
 =?us-ascii?Q?YOZHhF2VxlTNubcwHByT/rliZWIX8TNmOwr+R/FUMPdfWqy9ALYw5lklGZ4c?=
 =?us-ascii?Q?Z5H7OqYJBKOkJCcB0wNmvyOy9RGJialKX1C7NZzJsCGnwoV9j055RIsKjO0Q?=
 =?us-ascii?Q?xu9P27e4BQpWCRVqFPiJbglpcMUcYwTkWQX2HH+zt/R55/jKelHxSGnyeIRj?=
 =?us-ascii?Q?TlN/fX8ZRL/WUhwj58AlcXyNDH42Eijk3hZUYgxC6PJIgPVwgB1F1FWRNOak?=
 =?us-ascii?Q?vvK7zzSh99zBX4oii3imcuZiJbFBR+I+8/7CuXyk2n9vJrX+tqp8cxOao+aN?=
 =?us-ascii?Q?vfiOtH/WcQXIM09ZM2t2LCs4pXwK3QkbuNuyIaVwqT5f8q36FgmV8y3ppimp?=
 =?us-ascii?Q?TyXLgmmV+VydSlcQGkqS6SrynSMFjYzk90JTJBbZbwnmiuPLae0wM/qyAN0e?=
 =?us-ascii?Q?/LRFka6OP0vLTOglCafvTkIE+zVTDFuWMwogoi/iMawL+1hNc5ixGLBSmUl8?=
 =?us-ascii?Q?7fsmFJzRmA/EUB5bhetM+fKfkf6Na+l5GBG5BBu+KlWbscpmq5miB8wx14JL?=
 =?us-ascii?Q?sbfqIHsuACnE+0VEmIma65cj7PdPMNok28tdyrITB0PfB871eR+Frp1obfpX?=
 =?us-ascii?Q?VpxgasBSklsqu21eb3Yop8Y0cr9NAxL26KMauJwMz0lQSpxMJHbQvOGzb27f?=
 =?us-ascii?Q?dpySsrEgyzqIgpSSwL0YkV6oxk/y7o8Y+GUBcx3PY4rgd8CL4lmPvf4fH45A?=
 =?us-ascii?Q?fqj2pW7BpAyiSjA/gBfAL9h9F1cE4WM8oBCvsULv/AQMVp1GTh3JXcsRiJN6?=
 =?us-ascii?Q?9tapKiW7vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce76b2f-0a0d-471b-f17e-08da49974093
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 21:38:39.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xmOpGqnyAwoAQjErfMs+pd/acl7YJ+hzocW8p6oqTudm8RA769E3IYhFWJWdTbYKK9OEfZ2+0o6q2FEJmBf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3449
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 12:39:49PM -0700, Ira wrote:
> On Mon, Jun 06, 2022 at 10:48:19AM -0700, Ben Widawsky wrote:
> > On 22-06-04 17:50:45, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 

[snip]

> > > +
> > > +/**
> > > + * cxl_cache_cdat_mb() -- cache the DOE mailbox which suports the CDAT protocol
> > > + *
> > > + * @port: Port to containing DOE Mailboxes
> > > + *
> > > + * Cache a pointer to the doe mailbox which supports CDAT.
> > > + */
> > > +void cxl_cache_cdat_mb(struct cxl_port *port)
> > > +{
> > > +	struct device *dev = port->uport;
> > > +	struct cxl_memdev *cxlmd;
> > > +	struct cxl_dev_state *cxlds;
> > > +	int i;
> > > +
> > > +	if (!is_cxl_memdev(dev))
> > > +		return;
> > > +
> > > +	cxlmd = to_cxl_memdev(dev);
> > > +	cxlds = cxlmd->cxlds;
> > > +
> > > +	for (i = 0; i < cxlds->num_mbs; i++) {
> > > +		struct pci_doe_mb *cur = cxlds->doe_mbs[i];
> > > +
> > > +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> > > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS)) {
> > > +			port->cdat_mb = cur;
> > 
> > What happens if cxl_pci is unloaded after this? Would it be better to copy out
> > the CDAT info? Otherwise, I think you need to hold a ref on the PCI device
> > (though I only took a quick look).
> 
> <sigh> I thought that could not happen but I see I was wrong.
> 
> A reference will need to be taken for at least the duration of the query.
> Originally I had this set up to try and make it easier to query later.  But I
> think that is a waste ATM.
> 
> I'm going to rework this ownership.

BTW this means this patch is going away.  I think just searching for the
mailbox with CDAT support on each query is the way to go at this time.

Ira

> 
> Thanks for the review,
> Ira
> 
