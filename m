Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84677988E9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbjIHOgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjIHOgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 10:36:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB4113E;
        Fri,  8 Sep 2023 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694183776; x=1725719776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EbdRNchmn/QzUbRwXGRJx8LBhK30qk1bPMTjrWD58pU=;
  b=MTr5K/qPXuviTfXcTscyUCsmFNw+81wkDj5ZRBhiZHf0GzMdSujcPfO1
   Rp+6SOdAer6yhLJH/P0kBxMGuyMZ73zQCKyK+HIxUpV8nksr5yUkZIa50
   R55CkUV1bwFXq+Q63G0PB7m+1hsNNMRrERGDewE/FXd9hbx7MmHLhbi7r
   fGpgMM4wWj3WHjBYNRrUok8yULa0yckmWiCgXdQV7v4sY3mb4bLZ929OT
   JVB0NtOGdtnWeOqUnxqTuMGfVOmH5UHL5wWz5P1n4LACAlI2X6hN9D/mw
   4FDFo3YifiT+pRqh1i1rMo95lct2iQcmkY2HzVano1qrZjCvahYpAUceo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="408647320"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="408647320"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="735968915"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="735968915"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 07:35:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 07:35:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 07:35:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 07:35:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 07:35:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn9U+opvwIeOnMhsicUmLjghXvFKrIYSctAOlV0R5w6SUHlXioa6JUbcjNU+ZKjfw04el5PjhW7UKGugpjybkkHkp0vhsIdkK58f08SzTjly4fho1OuYe5gtbgRzNpMGbwTgZ9Gy1VtXWoR62hTH5MYfHmy0wFTOwWxCfn6oZCuHFKb+cTbMs3FPUd9biC5+TEKDdFEbDOby2rz4pnCaw924K7ZrWaseruNtqrmlAYXNBn7ADhmm0YhbACaclhlEe1iyyn858luWk8xo/Q0ILtI5TGaAZG6QKorqFwqrHm3yz3kk8aOjqQZ04oWLf9Dots7qgX+oXZUDwo6vZUnW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc9x2wgZsbpa8I5QpMf4E8QS3n5Sld/KU6VbO81YXx8=;
 b=bTP+RedIZGA4KGFWwWNE+jW1IAGkUDjeqUgBB1Ki0DFID2dcOBu6k4cYw7TWNawe4yGHEQkFs8twCZCMgFHyfZoF6HJCAa8pXhUvZDO8TevKgqZa0Jx/IHAikEkok7gsQjwAN0z/uaUKtaAa4qMj9SfIgWP731Mo1Uj9I31PQvwv7iSSkepd5o392RcDeItq2ExJl7LS0AxY83ocUM7ODbYiJ1q3m3T1Uxbd30QAdl+Ei2N35Bl05XK6sN5nI12falGZmygCIEe71+tN3JQU3Wp5OpIIvHOEtFYsbVEV3WpdilNLBg+/mxAQ4rvhLPh57QAFwv2Uu35BNDlwgsIldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 14:35:30 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:35:29 +0000
From:   "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Thread-Topic: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Thread-Index: AQHZ4LKiIDprQWqup0eKm2uSyqkaFrAOCSaAgAKepjCAADvsAIAAHRTg
Date:   Fri, 8 Sep 2023 14:35:29 +0000
Message-ID: <BY5PR11MB4306D2438CF3A387403CF9E0FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
References: <BY5PR11MB43060919B690263A0B1EA291FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
 <20230908124700.GA292601@bhelgaas>
In-Reply-To: <20230908124700.GA292601@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4306:EE_|DM4PR11MB5424:EE_
x-ms-office365-filtering-correlation-id: 0818fe42-5cdf-41c3-f012-08dbb078d9c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6N4bDooEfsauqTvd7IPTkC6ZKRbSLBFxtNPN78NCBN7AdQzAdoA7UItdQlX00gxDXv1gORPGr0A5QmzEzhES3YyUzp0Zg1c5NYAwLo+7QI55tTVSdzPiR/8AIm2WQEU/5sW3uCvOnKOL/7Zju7lXteKrF4SJOpyKcgkGCGuJDeB+xoOz9LRJAUCSvnpOfJNrssJpjvUyATqT3oVYCg7WEgul8//GXcYurCO4ab7RhrjeY0/ZJwGg0VUIZ1v+GaOqvq2jTb8mtlmBr+MWUOMgzJjBiG4/EYMo4qMV2UWnm3PYTYxB7lusqXJzC4snAE0S46pLRMyQeNg1AKYx1JRUrrB/7T77JSfF6g7Rr6I0G7AA38+cM+b2ZGSGzlX7IJokXeU162zT9j+VsxkJIfjtofrvajYItQhgpJfIhIIIbA4/EV8bxfDOzAtZ3NT4Fe44qW8TrdnNfPuZebnhivoYox/U0PuaWkvdXS3Tkc8EqMuSaf8rF9QVFc/hvsFu0sqiesu21KBw3IxOFr1pBSY8lTN+a/aRJag9ckxa32b5qzIXA88aUf4cgg2w+czc7NF63c8X/tdem9dWNLIsxqS7DMI5EHBFbtv0eekA5wTvxrs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(53546011)(7696005)(6506007)(41300700001)(316002)(122000001)(2906002)(478600001)(33656002)(86362001)(64756008)(66446008)(66556008)(66476007)(38070700005)(76116006)(6916009)(54906003)(38100700002)(82960400001)(66946007)(71200400001)(55016003)(5660300002)(83380400001)(52536014)(8936002)(8676002)(4326008)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OihK7Ml2vfn20wnzWQyHTCcKykaluulty7zvjMz/LqLPmCH3h3qV1098chgi?=
 =?us-ascii?Q?q7VuzTyf449sTxDd9JcyiXajfKjBZVx81t2dZAAe5XsRrXijJmyPiLs9M1GZ?=
 =?us-ascii?Q?8lvbN50lC4M/7Z8yZLflJt0UkYA1cHU43RKpR2NVoPbtsjUCyoUVEcIe1948?=
 =?us-ascii?Q?G1TUW56Wt5u0P52YD+mzfNRA2mHseBWR0xwRCnjUStQeOEqJYo7i1e/BDmSW?=
 =?us-ascii?Q?WY9cQ4UAganeV9xMuwoNB7AZkyko/AC4RzByK3B6r92+j5/rSVBR5K0nspvb?=
 =?us-ascii?Q?fOnggiSu2laAqpkV8+YwyxLHOlyifr8GG/gPFTcOH+j1foB9SNbrSXdoXRxl?=
 =?us-ascii?Q?3gGmWs3rkYXHVDsuhjPJtq5aTehtTyrDLanc1tvbBrV2BEfxgGeLkZRSjcFe?=
 =?us-ascii?Q?jS7Y2jDH4CDhxXIm188q0YC1YQPCmeLO306MHOAJbFF9yOx1yhSBVJ6dwsgl?=
 =?us-ascii?Q?fJo3kRhFsbw+20rOfbPz8Wqp4U4w0rdSXfYyiBPPCoVlzpLkvR15OE9f9z/e?=
 =?us-ascii?Q?DkdIw8cRi/SalKSrHnS8kE1AL0vvsccgA2TxgHwm0V3RnujsDozLJJA3uo5j?=
 =?us-ascii?Q?zJ6CGj0FYHW2Hd8ehhyf5vPt28wzq4a8mabJRK1pmv0iE0z+9kAZO8QqnzK8?=
 =?us-ascii?Q?Szm3CO0cUkSck31TuJDvSojl3TdSTYEIfBpzzqE6+L3pCvSOzg+YZYRBRnLc?=
 =?us-ascii?Q?xux2RdnRbaKSFz4xEEw78wZWZejOtRy0OD0uBgkNqIv7MgaP4xs77BNMSbng?=
 =?us-ascii?Q?oz7Xb9/r4FBmrtZcsbafna5Wvbf3sqzbmgYvpF27c7ydrXSHSe7NH0xOBAiV?=
 =?us-ascii?Q?tMmwPJQS15O+jyxPp/jemICOqbS59arphCs7gwNIMX87j2dy3WPOuVKZIn45?=
 =?us-ascii?Q?YZGozB/xwKlN0PuhwIsveX9lrI8el6CNgkbs4tO2VNGj2093Uo/CVSp/RlIh?=
 =?us-ascii?Q?2WrY+LAf7nShu2dzKhzOniPen+HlZUZ315ztzRCPg66cM5KDx43PyQivwaZi?=
 =?us-ascii?Q?tTbcoHwfuWUypBb8epsCvVppbAq9mbHWdsjpz8bw6ahlzqGI88UTzCyWLZwg?=
 =?us-ascii?Q?dVoDLca+lW/mURWbZCXqge9WGZIufXWGJbhGh3V/fK0oZcUswTThqrO6uLzR?=
 =?us-ascii?Q?BnhT7cmsphgflFJGmcA+5qZg9kLmm0//IdOFvzZeWONBxP85r07wMzR7Mkz6?=
 =?us-ascii?Q?4sJ3z+//E6DPzrgVJv5XSPD90sPgJj/On+Oi9yqtMCmCl2DG/oZyUK8NKg2C?=
 =?us-ascii?Q?OrrvQ8H/Bb8rPpJNEFxwnnahuPXrkXborCWIwa5lhB96jO/fTXpNpKREzQEq?=
 =?us-ascii?Q?ncUL7nbmcfnxZIyurQOA6ZYmDnlzbJidFoNunwztTskeGw9nOQtq/6bU2CfF?=
 =?us-ascii?Q?tcizsupniyNw9ofH79HoRDhdgFNljWxfWmZeo111c7MjlQxV2LvbOrhqETBO?=
 =?us-ascii?Q?R02AMZOM9cJ4b8SBI8Z7OMQPzMe8sYYQLHWdIMjGiR+7ycDUtdad+L2FqPcC?=
 =?us-ascii?Q?05lG1fq+wmJ7kS7WqRSso/9xoHHpy52KYBkKqddl45JF9VEvTpVdvY3X0SRR?=
 =?us-ascii?Q?a1YsPPyTHGloDnGDrIyBuWSPKmw8XzzWlmhBt1lG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0818fe42-5cdf-41c3-f012-08dbb078d9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 14:35:29.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3mUo5tsivQkTkQEAoRMd6xJnklc4k929bAWX+VwW11axV2wXpcM2nkBmRFw4TOYsns88EOhg8d607xBFtLBpViyL+PxcQJjzCauwC3rpLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5424
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 8, 2023 6:17 PM
> To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPG=
A
>=20
> On Fri, Sep 08, 2023 at 09:15:09AM +0000, D M, Sharath Kumar wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>=20
> > > > +static u32 port_conf_off;
> > >
> > > port_conf_off looks like something that should be per-controller.
> > Specific to agilex, will rename to "aglx_port_conf_off"
>=20
> This comment was not about the *name*, it was about the fact that it's a
> single instance that applies to *all* controllers.  It might be the case =
that
> current hardware only supports a single controller, or that if you have
> multiple controllers they all use the same port_conf_off value, but for
> generality, values like this would normally be in the per-controller stru=
cture.
>=20
> Bjorn
This driver supports 3 controllers/family ( arria, startix, agilex )
This variable is only for agilex
What is ur suggestion ?
To add in controller data structure (struct altera_pcie_data) ?=20
