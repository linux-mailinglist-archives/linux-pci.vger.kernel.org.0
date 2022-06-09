Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27A544EDC
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbiFIOXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbiFIOXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 10:23:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051A2F4489;
        Thu,  9 Jun 2022 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654784536; x=1686320536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ark0roXayF/mKBG6KDiQpajzHJQh3T33GzsCRxqfOjQ=;
  b=CMKyiY8FURkFHdjJlecFnEV8mwZyega0tp0b7ejKuolTronu9FOVA4tU
   fcPBqtAINkodL1SWo+0iISgwkSaHX/ey/scvoN4G/ecbTTmPYaHY5pptt
   99I9ZfXbVhJ1KN9GaqG84gBZutS02bnVUm8cUdVlxS66yY3yurkXzaXuS
   wKH178kHv3oQ67Ei8zGRgYMm9l3TkRyaC+sWLYJwCn94+whgAtQ6A8ixd
   gktFtdHYkpxY2Eg5pkUoVfGuSkpwGpBwvMV0ai5eir5vcUYRp97pRxHz6
   prAJI9P4sAeJU0rfhP7JsnF4a5RiLN2MrqqZEicuWg9T0nwuP1nvk+SZU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257727572"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257727572"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 07:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683986784"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2022 07:22:15 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 07:22:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 07:22:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 07:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4nyn0uewGPiXsVQxWjeUifbkExSaYiHiTyLMjtBS9GqOIae7Q5sDBLRZZb/HUTHxuxtt+P2BczrVQvfuZgys1YF40UJfgB+QXEvBFPJqKp2YqD1Gnoh/FzIc+UI6rdrr31dDI3f/BTf5NS2+Qh+oTWKL4aHQ9+Z+6ypTcchxD8LFQIO/K9kbp+DfuQVPZPEqNDZMuwyRMM0r23v0UyRigVLbjhPjlVTvO7XhoMlOP0OT+ToAJbbr2FY5jukJ8SggnAlU2lOWsyXj6gkehAut6LdvqYapxnYmTs6JEVI91KSwYKzwGfUofsFP2AzdOnxvYLZrWreRKpiIckUNZG0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg1QFMV/PHGseWIA3C8Hk6BJVTAk5IS+I8Ckqe/ycGY=;
 b=BvFAQ3Jfu2icFri9toL7mMG50UsD6oKIDllBHF8PsXQo0+ISSJddT7fPLYmZ/wqp8YAbq8q3VSZUSqrAh+6+sBhuxhgjOQdiJsjar8jwRtp5SSSiLn+XHGVtpXAWE6etbztozn1uBFt3w6fRwBIEdvlEdehp4qj/BziUK/UX93kUv7I6lLIx5wVP47G/beQPRh+d0GuIlUXe0C64TsZBGoiSyt4Zt4vryoyR+oq21v/jLnC2nPecmD0sSaYOUkB2+p30WVaCsYqTQoTF4qiQ/tcdaYH3qn8abBb6RBY0iBbVJEBGeUqMPcnfuRCwSjvnXWj1oPQr2ZWQxYj5IcOJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 14:22:12 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 14:22:12 +0000
Date:   Thu, 9 Jun 2022 07:22:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>, <linuxarm@huawei.com>,
        <lorenzo.pieralisi@arm.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <YqICCSd/6Vxidu+v@iweiny-desk3>
References: <20220609124702.000037b0@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220609124702.000037b0@Huawei.com>
X-ClientProxiedBy: CO1PR15CA0108.namprd15.prod.outlook.com
 (2603:10b6:101:21::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b92095b-46e7-4296-5a63-08da4a2371be
X-MS-TrafficTypeDiagnostic: BL1PR11MB5304:EE_
X-Microsoft-Antispam-PRVS: <BL1PR11MB5304CCB8624DF8DFBB623E3DF7A79@BL1PR11MB5304.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6x5ysJ3M8Sb0h02n/HyMOxdrsz5Dae9l+g9sJcW2ejXFk9Oymujl/CWBHuOpKX6piXIWHFFA5QEVjIV1WEMSJtC5dO0+akCLNxaEfsqdK3EWhLcqmuGlpWSHBKTu830fNn7IHmb02NJSD/5Gw8eA4dYtbS3vLtmCFChlB2gP+mQBxMoCMA1lXcDqDjLkwqj7pe1JAdu5T1xx3Tb5Z7Cs36acx+cTw1j1s/tbEW2Xzyiczm08ml3lVzB4r3b963h2vLm/AIFJzcBmESb4OxEciLwyvAmhDLdcc8j8Isi93PMG1iFCCfaN5kQzRsteIlD4WyOlLGhXFE8shFY8rGerXllWwrgvcei6sZLfR+ZkAi1Mvu5QzulUEXEOIDzgDOF4r1u4XS3lNw/suO6WiS/YDyra05xGbEC+LglDVtUtiHa+kibHfq1xm5SDBZi6jIQ4FeNZqXs2MlCeX+uPYQyDiQ2SOst7fN23vWZZGDxiB3aPJcqK+BRm5WMsfE1gMeEVxBRRRUdGQH5JTpNfrqAU5cXffeHvvhOhm6BNbzBYbu3RG0miTQbW5VyXnRk0SYnD6/Li85LBcNkw/h6JW7JTUDSSa3ZQ+Gm/4crmruKtdX5uMza0QxlozbcZxxqMOVo4hu56Cp54RTaKpca/DGG0yaOXO0ce26DHbopZNEDeEpsU6NvX61TrmdFgPZQthYHApiiS4by0/RyES6KKEGG9R/ENFODQX8CEYAymrOeMKp3b8sAHpln/A7BrkV4PclFEDM70VaduhGHKdD2MW9V7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(186003)(66556008)(4326008)(316002)(66476007)(8676002)(66946007)(6916009)(54906003)(508600001)(26005)(6512007)(9686003)(7416002)(44832011)(5660300002)(84970400001)(6666004)(33716001)(82960400001)(6506007)(86362001)(2906002)(8936002)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/TvETKMS896AG17oaUDm0P/0h4HlFZz8KQk58S2A0ZJBDSoD93+KpORrwZDn?=
 =?us-ascii?Q?16dwRKfxvwMcvEA4UeFT+Eb30+2cffde9jo1t0djJFXQyc6lJb+5KZowZEXM?=
 =?us-ascii?Q?0yHdiX9Dqm2SIwwYlR1CG9h8kUXE3+CUDsgRR/mj/AtvM6dup7pRnSHygp39?=
 =?us-ascii?Q?ts27UIPipWv8z4MoCwZ6lXOMwMMPMPP81TO3YKW63KsKs3ViqIeXZsAgGJTX?=
 =?us-ascii?Q?pjji2/LZ7WNExz4knhuWXDDqO97H6IUp890GNz6uNCIIqy40AJkHgv8sGZcB?=
 =?us-ascii?Q?pf9MisBUUZYADBe+tGNCJxq3Oe60ma81L/HpB5NQhzXBkG+WeqVtFk7VwYyA?=
 =?us-ascii?Q?lanCPaE2CCATQCDKzjX4hgUKr8DFo15te9mzf8SCDYQaMn7nxWZALE5AjmRZ?=
 =?us-ascii?Q?n5sqPzZE7+Zn3d2/lL+dCFAeYBekmvMP2wKiGf1b4cUcFVi8i1S0M0nnFHMy?=
 =?us-ascii?Q?bJLBw3Ndjx7zxPN2lbSLWPzPMjEVLcot+R57X9TUr4CU7JSipuKsmDiA7+PM?=
 =?us-ascii?Q?n0CSUj9RWMJK8pl3987Ye7v1mTkH1TckU4KCpz397f4L2NzdR3Fq+0xOq/kD?=
 =?us-ascii?Q?Omuyn0mtsbYlcipiHsTlCzfcUij4hKPItc655mmJfBr3YOjsmGw+hpdBjNxh?=
 =?us-ascii?Q?un+m8icq0IwwbO2fvVEnhXx7pgJn5WrGVeQw+HSOgTuxQzX1/ng3/KTINf/o?=
 =?us-ascii?Q?jCo1hi+dGwxs7IJCGibN4j7Yp1vCIcVnI10bxT9fOQku3PR0H9U6EJoYYfjL?=
 =?us-ascii?Q?doehd8IszuGpZsF/iqythA7Xh+9GYCgBtyIhxBxU//enHIdVkp/fsQbHKfyv?=
 =?us-ascii?Q?FSIDq6dUrYzSiIVdPH3o9HrFe37CP8o/sHgVV/UXRQxresajgssa/Xzfkvre?=
 =?us-ascii?Q?5jvpMVMSCNqjWeGWC1quQuzF41cgMPSB8I4v8fDNrX4LRK2OGIxNrrLnyvCZ?=
 =?us-ascii?Q?REgcyXe+1tt+2ERMTAUPrSTJWijijRg6bhTTlp3beHB/dNoeFOBEEHys3wwZ?=
 =?us-ascii?Q?9jD8RVMSIj9IPbaWew4NAiTeDmARMthwKYdtkMSJ0/eO5ofGxVxS7SEU9C7Q?=
 =?us-ascii?Q?WOPWDrsogDoAQdQbpiv/8q7G9nvQOmT4X03UqnQyObSJdbXpHxeXt6G8ufWU?=
 =?us-ascii?Q?EGVcnbUmhmatCShcbguz9v2ORQKVzqrgu3obtMp0c0NhVn7QxZx4+t/0XLIe?=
 =?us-ascii?Q?ytW6f/5Oa/AbvN4yny1BDhtg8MebgNRpBqGz5wgnShpItiJzzFQTE+Yyc2Kv?=
 =?us-ascii?Q?LRri3LxqkQpsDHqz5VBxUINaXL8tuSBQL1004FXsnMf4LUHphtxZ2kIA7QA3?=
 =?us-ascii?Q?CDf/jJqg+VV7jgj3woRtcYTffuQA4RVvijWmEpfY+mWq6ilc3+jTe6CKEZ2u?=
 =?us-ascii?Q?qyNl4j3xhJkTSs13vd2oVaqWdmiegNxc2XCWASZuBv9A+jvtQBLx8rQoE//A?=
 =?us-ascii?Q?tvpkCLtCsYrNiK5B4Urrsjb30jm5ccqniZUQ78RCdUuZmcVRj77ym1GwlTh3?=
 =?us-ascii?Q?Z1AR7lVGIFvk4WmNW3MnZ1v05krog4F3f75M7FC2hnm5PqOpNk4HFTIjbAJV?=
 =?us-ascii?Q?7j8xGdRS6l1BBn80mt+NnZQ27o7zy5YvwQGgm2HRp6AIoABprzhqnkr1WiP+?=
 =?us-ascii?Q?qcKqKKdSElZ59m1ZjbWU5IsQe+w+7AV/lsIpnvMm9Whu4ZVvSZ1j+YEnczhl?=
 =?us-ascii?Q?hV74pvKvyzPxK/oY9pRl/djaOEcrUh9MF9Is94pAZMht2kOuAiOwTd9DLxde?=
 =?us-ascii?Q?moqO0N7i7CJ9mmR0D+cfTEIH5hVLpWo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b92095b-46e7-4296-5a63-08da4a2371be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:22:12.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjN6Oxs6x7Tgx/xTNWjr/AqwMsuWYC7THbVOSAGvizxr4LJPnVDZeUsHomuWgSjHM8Br3tmA5zoyrwPe/zSoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
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

On Thu, Jun 09, 2022 at 12:47:02PM +0100, Jonathan Cameron wrote:
> Hi All,
> 
> +CC list almost certainly misses people interested in this topic
>     so please forward as appropriate.
> 
> I'll start by saying I haven't moved forward much with the
> SPDM/CMA over Data Object Exchange proposal from the PoC that led to
> presenting it last year as part of the PCI etc uconf last year.
> https://lpc.events/event/11/contributions/1089/
> https://lore.kernel.org/all/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
> I'm continuing to carry the QEMU emulation but not posted for a while
> as we are slowly working through a backlog of CXL stuff to merge.
> https://gitlab.com/jic23/qemu/-/commit/f989c8cf283302c70eb5b0b73625b5357c4eb44f
> On the plus side, Ira is driving the DOE support forwards so
> that will resolve one missing precursor.
> 
> We had a lot of open questions last year and many of them are
> still at least somewhat open; perhaps now is time to revisit?
> 
> In the meantime there has been discussion[1]:
> [1] https://lore.kernel.org/all/CAPcyv4jb7D5AKZsxGE5X0jon5suob5feggotdCZWrO_XNaer3A@mail.gmail.com/
> [2] https://lore.kernel.org/all/20220511191345.GA26623@wunner.de/
> [3] https://lore.kernel.org/all/CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com/
> 
> Perhaps it is worth putting in a proposal for either a session in an
> appropriate uconf at plumbers, or maybe a BoF given it is a
> broader topic than either PCI or CXL?

Yes, while this could work as part of the CXL uconf it is probably a more
general topic.

> 
> We'll still need to dance around work in various standards bodies
> that we can't talk about yet, but it feels like it's worth
> some time hammering out a plan of attack on what we can
> discuss.
> 
> Rough topics:
> 
> * Use models. Without those hard to define the rest!
> * Policy.  What do we do if we can't establish a secure channel?
> * Transports of interest.  Single solution for MCTP vs
>   PCI/CMA or not?
> * Session setup etc in kernel / userspace / carefully curated hybrid
>   of the two (Dan mentioned this last one in one of the links above)
>   There may be similarities to the discussion around TLS (much simpler
>   though I think!)

I think this is something which really does need some face to face (or virtual
face) time.  FWIW another idea from Christoph is kernel bundled userspace code.

	https://lore.kernel.org/linux-cxl/YoT4C77Yem37NUUR@infradead.org/

I'm not sure any real implementation would be workable.

> * Key management
> * Potential to use github.com/dmtf/libSPDM - is it suitable for any solutions
>   (it's handy for emulation if nothing else!)
> * Measurement and what to do with it.
> * No public hardware yet, so what else should we emulate to enable
>   work in this area. (SPDM over MCTP over I2C is on my list as easy
>   to do in QEMU building on
>   https://lore.kernel.org/all/20220520170128.4436-1-Jonathan.Cameron@huawei.com/ 
> * Many other things I've forgotten about - please add!
> 
> So are people who care going to be at plumbers (in person or virtually)
> and if so, do we want to put forward a session proposal?

I have submitted a non-CXL topic in the arch uconf and was hoping to go in
person but I'm unsure of travel budgets.  I will likely be virtual if I can't
attend in person.

Ira
