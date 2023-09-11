Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42179B528
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbjIKVid (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbjIKNgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 09:36:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E453106;
        Mon, 11 Sep 2023 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694439361; x=1725975361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sPco7ZeO+L3i96iJT6arwv+JQNNnLzDPu/Hcx3+O9mo=;
  b=j9fBYO0l0PYuQtvbmJ5t3IzCLzSDh2sEpsFKHRHMtPIkxA3JUoMteT6L
   KHnAR1zkwGcdHMA/K2O++LRPFOu/W/10iXwhH7nRk/qpumlkBBxogW4bH
   bRZbEcShuDZhr3HK40vVKE1EuYfaXi/fbirjWLntLSp/9d+JYCNn5Ug7v
   MLqKim/WA1tWQgqhpILUiRODVAPZBVOJiCUg0ZLInfDV2nmmXvXqeNaAB
   31fNyj8Jylq52cAvCOFKevaitN/B/NU3CCpBL8hUelMzM0lqwLbH1r1w7
   LEcJxqqVJzJoE8khgQcrNCjQ8mBmeBfm5datykG2KAmekcxmaB221zfK2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377994554"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377994554"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="719987034"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="719987034"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 06:35:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 06:35:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 06:35:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 06:35:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 06:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te1WRBAcoGMDxjS95E5LvLTkCrXto9gAn1UcgmMcZNIFTaPp4TN51jVZlpT+mjkOHDYPqlH7ZXypBGT65D/fwkALhrnXp/2xJLBw41zrffmmsSCQepSNB/2ofTluvqSI35CDUhAH/y0Lu3pSyvZlUqCiKTtfFxbp+0eASpWYe9d878nzLgu1etAly2jtlfPOid8Kj9z0LWcOhG/atMJYX+G9/1xNhtLJC8oXmNB7dBtBdS0s4V8LuvYYhoRl1c6uHtyjaTjt47QEviACBxdBzuYfPSLH/kCJtlzP6JnsHQA47+5h4HKKtKeGm+4n7VDr8dqRqAGbRpSfK0BNXdduSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+X7a9mQZCJ7wDOgz1Ke05/bjkNkCWOtx3a3yLjzIPM=;
 b=P1oSifw4xwEK0cR7+evvXZoLcwAhYoN6bDrGgVMoH0qYSWE874pf5eqYV41311QXz4Wy5WjbPx6iobOvRhFNQRSedFNz2b04wrinb1ntN8hTPWwt1LIEpdLDkiwg1xvDCcEDBOBo6FUXFwc3RIwo4TClckh+VComtbCXCN8nE4Q6sx0e0PdK2XciuO7htsWy/kw7322rKXtygYk8kvBXjTsJeEGOTqCb2CrZ33Ms+eBhIanjlgF1g5EhydHNGDFeM18TczlpAddyzS1rLEJWxqT5FdWSc+krqYzE48KLNXiKwiMubaEZ9WUeXa527NKGOXK9eJ1KofdgdZ1VrKh+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 13:35:23 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:35:22 +0000
From:   "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Thread-Topic: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Thread-Index: AQHZ4LKfP35QHhRaeU6oLkLTKU8nJ7AOCAkAgAKeUdCAADyNAIAADpbAgABpLACABE0ykA==
Date:   Mon, 11 Sep 2023 13:35:22 +0000
Message-ID: <BY5PR11MB43063E99F07BD65651092D8FFDF2A@BY5PR11MB4306.namprd11.prod.outlook.com>
References: <BY5PR11MB4306A066509DC8CB2ECEC164FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
 <20230908195242.GA304243@bhelgaas>
In-Reply-To: <20230908195242.GA304243@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4306:EE_|IA0PR11MB8353:EE_
x-ms-office365-filtering-correlation-id: f90add71-edb1-449d-b9fe-08dbb2cbf30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Aq57K5qAeZD11j4dza5MfdtYb5uxqTyzaxzLiGA5G+zEc4g75bwlgkBL35O1ck8BqP82GrUziFOy3srVbrf1fl74T80MhWOpBWuHvTcaMTcdlGfGbJsYo/rlRgHakhaO8tYYzyfKiAJZ2m8Rh2VZadmaWQveZ/1l1IkWF+RK97RmK8rrOMzWc3MW6+A0ymU2z9ztjbh/VB40z84elj4Zr4D4IfJtZZZocpIyUbH70q30Q3SxR+xep0n5IuMo9YvlS7ef+uMv1LqAmQ7GlRYyB1ZT5fXDUtJ85+KWXdmyGCmT8PH7I1+Vhnf23htkrM2m5B+japl9xiSMS+qKjwq6DNSubAR+FTF/Ge7jFg9Sm2r9tVdSkuFKlckQgBheL/6JTX3t06qdIIegw4QvPMAeBIhfi69sZcsONGY9TPhQ5fn4I+ithQMIA/52jpFOuKdrVkB4vFS4tQT9AWcu/6itpXrdqJinMSGJaFcxlSKlaFrG2c/uOAK07o06L1eyEtGFIwOCLK0w1WgOiJ8Oj7WKg4MpaMr7RovK9X8K0Rg+VA9K5k2kmLPHbLAxvFI5vpVZblBf9hnXOlxlGBr06cmDCq0nYrfY1x6Z6VLRkmml3jYoFNGSrOaQQXRt3jTi6qX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(1800799009)(186009)(451199024)(7696005)(6506007)(53546011)(71200400001)(9686003)(478600001)(83380400001)(2906002)(26005)(66476007)(66946007)(64756008)(66446008)(66556008)(54906003)(6916009)(76116006)(316002)(52536014)(5660300002)(4326008)(8936002)(8676002)(82960400001)(86362001)(33656002)(55016003)(38070700005)(38100700002)(41300700001)(122000001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?43LZ0Y+I9jfEIgdQki6dtMMgfBToqTVVMSs/Ls/RhISXVOXZjswf8KpkiKlR?=
 =?us-ascii?Q?gFC+9RaxWJYNUbgYBJis2mViUfQ7xKGRRF11KEdvHQ6+VvREK5t+qIlu0Gok?=
 =?us-ascii?Q?zg82nSp1Vpl9CPvcD6K6O6oqigdNNlOCKmGhI6etsguiHMWGnjur0l1/91Up?=
 =?us-ascii?Q?HQeTIWRZUWnD7U5myZbvEe1JkAMqf9+0T/FYGhlhFiNwHPohcXJnlajFY+MV?=
 =?us-ascii?Q?bZBGRUK02NdrYP5c/urooNh7d54GuwIYEZROdFlLO9Arshu/zhaw0Fk7S+Qv?=
 =?us-ascii?Q?GQ9RKtCGpYp/dfWVDEnaAjHsrRQRCGxYtsPEhOP6caZtpmTC6lo1pcD/6fOd?=
 =?us-ascii?Q?akiLQzs4q6aobyMrGmIJc3le2D49UDNgDzeYdbMexIzFdfjKjkVuXPGpAAdn?=
 =?us-ascii?Q?4sjaMZ4ECfdcXCXjzlzag5tgPOX/WsZodGqPAzjj7E96qigGoJz+uzAQL6PF?=
 =?us-ascii?Q?yF1PiI0Y9bn6r6eY5rGTSqGs1pQLxxzu5pA8J4EWiOSc23zNxo54s51n+Yxg?=
 =?us-ascii?Q?dJlGW1c70lEWTIkXTFLS1M5JmSBQv62dqVOHgdMybY5PJbZ0tlme+qDFNx0S?=
 =?us-ascii?Q?vYgdgbtepibjJ1m3p7TjxMzjeWWkPnWmSOoVcaAbzzZSB4SiePR4G+9GuXjA?=
 =?us-ascii?Q?hDWQwhjSLd0i0h4lrHj6R1IP7TaQRLTZm1SGSR5Mo1fhtKbR1hXkjxo3p6dh?=
 =?us-ascii?Q?376HZNgocEUaC+XgsjPqotc2X/T2GxnxcdLliTQOHTpuEW+7eDCJIDnr4isq?=
 =?us-ascii?Q?4nu0LXX+1F2e2PNgIEHfzt5hlegfd/hfKz72IELsP7Ci8LkeucsgAaRrIKc7?=
 =?us-ascii?Q?lFpjqUTrc8Y7zNI1UvkQuca8PjL6iZ0ZkL/8s7UsHj7AfS0iyDb0j/k+zjkG?=
 =?us-ascii?Q?iY4Fs8NI9en8td5IT3/M3gx40cbwrXMt4EBo/Q9JSD4RxXmbpwTYvFFyGvIl?=
 =?us-ascii?Q?dqz9PxPkm5jnTGq3NqksoMhhVzycF6HDhOK3vvrf5sTyYvLL/sdoZimcHXRu?=
 =?us-ascii?Q?UzNNyMQq5x2gTXlG+GX5F0ddrSqStESrwscleCXfuAhSs4lc+grosf6snhW6?=
 =?us-ascii?Q?59TVWoIaHBdZz2CRW0XOpLIADvHmD1T8oSpLGYX+WpUUYnLVqi29fW06TWGY?=
 =?us-ascii?Q?4pyHKHN9KCglI1EXBNwFyYMFW5QmcIQYImYoBlUhFys4vm+jopZjF+3Pfijj?=
 =?us-ascii?Q?JoytnCsjHjbRRNmaRPL3L5Ef+8kQaRRIS1ouYZKLZ90QGUUC5gImLvngaOD6?=
 =?us-ascii?Q?LqYkyXWGqZEl8ePOLgCBFj5VNBLDj9i5koxHbHqimtX9mMzW6V6+NZdA+UQR?=
 =?us-ascii?Q?pqm6Mv8hGS2CqitnBmTYw7MKMepf4d72b6XjdIPuBta2o9TMMHLA5Eg0sqmS?=
 =?us-ascii?Q?zyR1n6HepkHPVWldHYqZIXUKKc8WaZLHaBGtCnkuHJvVZ9nwOD8gUZqJWHUa?=
 =?us-ascii?Q?aWNHKZG7ybqEe8pgHbFin/2qqyH5xhVtH3kSN0L6ouTXcJd+ljeGF9B62rTA?=
 =?us-ascii?Q?/FX1mxwC6W5uLgSLcBHwEy8NoHOmCA/vAmAvmm7CrMCMDYd06ELJkyr2L1mE?=
 =?us-ascii?Q?iOB2iWaNAwjkmssU4idP6zGeL7nskowQ5NO2fRlQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90add71-edb1-449d-b9fe-08dbb2cbf30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 13:35:22.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOT4qk8CRQkJIXsWTejsKcFrgIpWX9Y0NHXN62DTOhtJGPATjhGazLuJ/jYtBSMZBiXtFwcRBA7lEsOu8h7nJgNt6DX/K5XAJ4bwSwyy5MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, September 9, 2023 1:23 AM
> To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting n=
ew
> platform
>=20
> On Fri, Sep 08, 2023 at 01:40:13PM +0000, D M, Sharath Kumar wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org> On Fri, Sep 08, 2023 at
> > > 09:09:34AM +0000, D M, Sharath Kumar wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org> ...
> > >
> > > > > > +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > > +			unsigned int devfn, int where, int size, u32
> *value);
> > > > > > +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > > > +			unsigned int devfn, int where, int size, u32
> value);
> > > > >
> > > > > "ep_read_cfg" isn't the ideal name because it suggests
> > > > > "endpoint", but it may be either an endpoint or a switch
> > > > > upstream port.  The rockchip driver uses "other", which isn't
> > > > > super descriptive either but
> > > might be better.
> > > > >
> > > > Ok will change to "nonrp_read_cfg" ?
> > >
> > > I think the important point is not whether it's a Root Port or not,
> > > but whether it's on the root *bus* or not.  In other words, I think
> > > the driver has to determine whether to generate a Type 0 (targeting
> > > something on the root
> > > bus) or a Type 1 (targeting something below a
> > > bridge) config transaction (see PCI-to-PCI Bridge spec r1.2, sec 3.1.=
2.1).
> > >
> > > There can be non-Root Ports on the root bus, so "nonrp" doesn't seem
> > > quite right.  "Other" would be OK, since that's already used by other
> drivers.
> > > Maybe "type0" and "type1" would be better and would fit well with
> > > the root_bus_nr check you use to distinguish them?
> > >
> > Situation is
> > Root port configuration space  - memory mapped Non root port
> > configuration space - indirect access/proprietary access
> >     Type 0 for devices directly connected to root port
> >     Type 1 for others
>=20
> "mm", "ind"?
Memory mapped -  configuration registers available at pre defined address
