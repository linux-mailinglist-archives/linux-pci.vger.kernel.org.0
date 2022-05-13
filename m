Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75A526CBE
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 00:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384802AbiEMWBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384799AbiEMWAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 18:00:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A158E5B;
        Fri, 13 May 2022 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652479252; x=1684015252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+WglABce5zRgnS1yFpd1VSqyFIdxu1j5KiN7McuGb8=;
  b=Z4C2Vof+3aFFzv/VLM1SRcn1g49KG4e23jG5UcvSjz4E/hE1r/DsFv6R
   kV7MYVzDuno3qaZUMw/CJ9tS1Ssqq0nAMOYFVt/FgXkx6Ey0ywjBFkOfm
   dFq5jl/8TspAxB/7MX+LpBihJvvc09jQNyZvkB6U481ntfBf/wpGntH6H
   OrEDu0O+nvcSGiHIt5k1iI5ckhXJuf2sCOCIYmHLFI+mlOQF/DhnBsqUM
   GZtfnh+U85a4QxRjZV/p+BJKtsbqmMTKqRaIzptmm+EgxHpYkuBxpvQHe
   f/x/7S9tZKolSbQEwbHWlxfvCra69F22bUwPDQ+a+UnGQjFbj+8YEd1YK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="257971685"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="257971685"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="543451431"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2022 15:00:51 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 15:00:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 15:00:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 15:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv1+/pweT2gh+GZMl8qR902Mocz3s2ZC64RaoxGkv7eZxhWspcd/2SSQUAssV0zKQIfis6bMBFxWUjM7HQbkKg2Db0h4cJOftH8qSvntHPUao6lXYcEEUdRJ/ofzz7PHrR8Q17RO1+DMAvllbAVflEI6DXFXER/YcdFDIKd5qFuCc38ekUSzOOsQy7AkkZlls1hO8AXAgoxnmwaLqwR9jt1PeELiHWsiv7OYC8oSr5yfkMh0INw/8AcRRyV1GXGBHHa7ZpYf/ygs9TPNhUHdBuEBPrrRSrTzPJVi9tGDE4h2gx5JfTyy4jubUg/003SRABBszDANukyU60NjqbbW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tpnBRuj0tkiGEVaTlb5V968v53ptgK7hBHdVjJNp9U=;
 b=Wh6VDb6/8KgnzkhWNQQZm3/AsZdWrXV15/hDEgA9LP6FBkEa7gm5dbrRonvQypm8ezdNUlbxlCkjOVv9XMK1vlAHkfAyU9Ef2zzzVP3XSP1lvzZYycZMR+XGgh3Roe0PuhZo7frmZ3vfO6jDcsM4Cx5OHKIZK0d5lhGXzk6NscyVKQiSkJg25W0O6hfrdwXDjjeVYYwbGD4m0OaLhn7frTusaR1mTl16gbIwCPZRPBn3hLxmgavmExOOFYMiS3T0+Gb6+2s/FofczVL8U0nj8xDz9spov1MrNU85nfcDm6AKg8f/71NazWOMFGdyjXlsShFHLwF0PUqVnsGEUk+MSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13)
 by DM5PR1101MB2171.namprd11.prod.outlook.com (2603:10b6:4:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 22:00:48 +0000
Received: from SJ0PR11MB5070.namprd11.prod.outlook.com
 ([fe80::88b8:b97a:4081:86a]) by SJ0PR11MB5070.namprd11.prod.outlook.com
 ([fe80::88b8:b97a:4081:86a%9]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 22:00:48 +0000
From:   "Jingar, Rajvi" <rajvi.jingar@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Thread-Topic: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Thread-Index: AQHYXA5UPJiB5F+tTEizlP3KdPFknK0bVgkAgABBM4CAAALHAIAADAkAgAHHxRA=
Date:   Fri, 13 May 2022 22:00:48 +0000
Message-ID: <SJ0PR11MB5070B095B8A28634B43A231F9ECA9@SJ0PR11MB5070.namprd11.prod.outlook.com>
References: <CAJZ5v0g_p+Yb-VLo8b6-SYU17=GQOqZh2E5-52dkq-3rzU=57A@mail.gmail.com>
 <20220512183540.GA859016@bhelgaas>
In-Reply-To: <20220512183540.GA859016@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f2d6a7-5267-470b-39bd-08da352c09cc
x-ms-traffictypediagnostic: DM5PR1101MB2171:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB21714C0DF1B48F0926A827879ECA9@DM5PR1101MB2171.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ozcZ2y5hXBAlmHBgtV06c4vlDYon5HFdOvXyYTS/WR/dpZ+RUfVpuuQyAzezVA2i0vEv6QryyCXyMXMpK4ie2KqtArdGHpG3iMz4r+ojhvLA2u2wnnSzB9uhGdyZDyfwN2AG29pLy3jkaqCJ4UQO5+fUFTgTgnt/pcVDTvI9ZYA/x0ZEDt5VzR1vrNm/ZG5WJ49HB0vr8y42yVKV5xQic7bXi7jfEp6tDBYe0qhEExU3AAU6xw8faL+YP1VbKPsTx0y7i8RTRceKzlrkFPVT3bOnnOwpO3sT+UlevGXi+2y/CJ6LyV2VY2gjvuSfnuhPnwk4b8REinlBu5Uu0XcASmqByyGiokS7ym+ihEvgSRcxE7z4fVVpqV4NwoxwmaMLSKMQPl8B9iY8jRp8LK3wNOx21wzVuV+l6sWlpJ3LQy8JGdnRuYZATWxvHOcHEWWlHEGayYDzKtjbvH6z7SSM5lXAJ/otYQz4yZaO/ys1opcqOR9hlyQ0mlL8MOk0HzA+AfZiUkhEdlkVj+WVunYLmjH8VWYbbP597+LwZ2Cy9ih3F85pcezkoT+q+koOcrugoawVgEuqGbOA1PKcCpuL7+pTSqSvXvgGIZvNTM9lTqf+mVX2t6aljbCH/Ck0awryL17ROtg7kxC75Pkx46aoKqT3GAI2vF+34mP9L7eLTkcNs3aSpn2zuQwrl9ExLaQPBiUC4hOyq/XfsCbSWWUsqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(66556008)(66946007)(26005)(55016003)(8676002)(4326008)(38100700002)(86362001)(71200400001)(38070700005)(9686003)(186003)(508600001)(2906002)(7696005)(52536014)(5660300002)(33656002)(8936002)(6506007)(53546011)(83380400001)(316002)(110136005)(54906003)(122000001)(82960400001)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zlA0QGqcHCLuhZDX2hW1XCAWSwL2CCmQ1+2skl7zhzsm2cwvuDAHB0WWziB2?=
 =?us-ascii?Q?vd97asNOzMK+cXy6fBCjUTKrXYG+hZUNlbPU1M3wRRJGaFypVM14zIVYD59f?=
 =?us-ascii?Q?PI53Zre8qHV/WBz3rdu4uaTlCyruW05D/g03NOgp/QNN0VYxRuzHHNe/f9H/?=
 =?us-ascii?Q?Ga7yfjhW3JqiibI4LR9wq0avKdxELSG3WvramJ4/oU6e3EZNLl2dpbFCf3Tw?=
 =?us-ascii?Q?bs7L+wlDsHw1YEC9C8gJdmUP1S/Gs9Nx0YMN4SVRfj54IhlUq23f3j8vML4Z?=
 =?us-ascii?Q?8DiPtI1HZeDyk/SuuTOZFN2vIlZX5nO70tRObQwoEs2gzf7UMNUbAfm5A8JO?=
 =?us-ascii?Q?zi+mgIZX3Qsb9pfkdk8hV+J8XL7yLMspn7n1HEcq2g7jinNF1X2X5mOBd1OJ?=
 =?us-ascii?Q?FAblGQOSmd6RQce+31bPA3vnbKRImUSSe18qoOzuQ4Zq0VbYEYxebyXhORZa?=
 =?us-ascii?Q?6c2Lc2LxgvgdUQZ2AEqirmdTyZbfw9WFPLWS1Otau/MHz92Ls/4Qwp4/vRcg?=
 =?us-ascii?Q?J7s+6LqzTMavWtQRds/UNbbNNaJgLP/h/75LeQH+kYDcwtktwn6ZvYbMGfCr?=
 =?us-ascii?Q?jz6h9CMJETdBMVBSTY76eM1S4l8EZ9HIs/2SWC3V9B+4dXCEmoP2uzfMsB9h?=
 =?us-ascii?Q?YyZMmWusYjS56s21B0Y2I+8l3W7dTGKtovZePpxWwrDhmjukr2BHMZdhUCQe?=
 =?us-ascii?Q?klmLYeb7+sMs9HHYUgUDrAfhUqlE5UShU6jME8k+2xutxvbhrCklByaBrg+/?=
 =?us-ascii?Q?LaIfTkkssrhDMh2Y2M1oD50UBDZk90KfP+XOGjXy6bRPLL4FEjXmJ8OD2mup?=
 =?us-ascii?Q?f7ZWNyfCbawFnzmg9mKjJvzkcHVdxz1vPORfAUg2HxPe1iNL59SPNpYkQujw?=
 =?us-ascii?Q?WOmXWBBLxD8g5YCNzKS20e3imql8mV5PDkCWxSvht9CaMft9+DTTPDksMY77?=
 =?us-ascii?Q?A/UsWCF61Gut5rGx056kc9wPCAOe2yTxqLqir8E+AEts0ZcitbhISSbN6Wdw?=
 =?us-ascii?Q?Bw8aPd0whCS2XL4d/gjtRFnGiAMsg0tOS+77MBjpY7D28cbk0ZFQnRPX/bV+?=
 =?us-ascii?Q?4UtQmEbU3ALtON1RLVaaqDm1T59jAj4etDiuvVi9JkVYHvGt8AFONWHLErQf?=
 =?us-ascii?Q?5gc97TvnMgo/rzEo8b8WHNlFQRDW3RxLFqbuImQbmNDatAIAiXVTZ+UlQJae?=
 =?us-ascii?Q?BV6yYDhnALY4mkKqiMNvQmw8Wr4b2f7WE7oiQa1x/7JApvr/YliFNVX8M30l?=
 =?us-ascii?Q?gHiU+n7c2Wb+tHAeHj0YI7gaoVFzGhLpDsAutIEYgX6soqXS+l3may1YCxWR?=
 =?us-ascii?Q?vCy1TfQsWkSshHB9PTj7I5RX8o+T2B6bHPzep8MqtBHbDpFlHbUtRyxBYyy7?=
 =?us-ascii?Q?P1fzJFU10BLTvsQcqdbUJkcUYPFL8yKCx7swiCIFXWMhSX+eoVHUVcYjwbyb?=
 =?us-ascii?Q?7da2zNL1rbtHQ8TyZSRHyy5IMbR2WCFXcYkcf1ejAdR6lfKD4paUZmqQQszD?=
 =?us-ascii?Q?RaY42+S+BcpM4/q3ngFQpWHTHOfYhgBJKJmAzKNPDc9rf5FOGvtKDhpcqpRX?=
 =?us-ascii?Q?/2RmurKKVx0fXLfSd3nxV7MVb9Z/EitTrNGGns/hJ2aa0R808s1S5GFevrjy?=
 =?us-ascii?Q?D3JV64XQRsWJAAw7kYz9aQgfFUKnlkpgPY3DynnCE3FxmYR/9DOOwRZY8BVx?=
 =?us-ascii?Q?4GS3Orf95kftYcH89KJz3WRIB5piks+4GO/FgoQecFQW7VMNDk3Bp7YrVeyN?=
 =?us-ascii?Q?vaArfRJZ4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f2d6a7-5267-470b-39bd-08da352c09cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 22:00:48.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tH1npf3oDyaVADNTdpWpVNGm63Qv+pdlBNIT6DSTSNkdx4ipMTQA47IxpFstAT3pOMIC28UqUylyEliLt9v5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, May 12, 2022 11:36 AM
> To: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; David =
Box
> <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>; Lin=
ux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> pm@vger.kernel.org>
> Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable=
 PTM
>=20
> On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
>=20
> > > > Something like this should suffice IMV:
> > > >
> > > > if (!dev_state_saved || pci_dev->current_state !=3D PCI_D3cold)
> > > >
> > > >         pci_disable_ptm(pci_dev);
> > >
> > > It makes sense to me that we needn't disable PTM if the device is in
> > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > driver did.  Why is that important?  Why should we not do the
> > > following?
> > >
> > >   if (pci_dev->current_state !=3D PCI_D3cold)
> > >     pci_disable_ptm(pci_dev);
> >
> > We can do this too.  I thought we could skip the power state check if
> > dev_state_saved was unset, because then we would know that the power
> > state was not D3cold.  It probably isn't worth the hassle though.
>

We see issue with certain platforms where only checking if device power=20
state in D3Cold is not enough and the !dev_state_saved check is needed
when disabling PTM. Device like nvme is relying on ASPM, it stays in D0 but=
=20
state is saved. Touching the config space wakes up the device which=20
prevents the system from entering into low power state.

Following would fix the issue:

 if (!pci_dev->state_save) {
                pci_save_state(pci_dev);

               pci_disable_ptm(pci_dev);

                if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
                        pci_prepare_to_sleep(pci_dev);
}

> Ah, thanks.  IMHO it's easier to analyze for correctness if we only
> check the power state.
>=20
> Bjorn
