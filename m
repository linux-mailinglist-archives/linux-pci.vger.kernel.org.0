Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B016917E4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 06:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjBJFNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 00:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBJFNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 00:13:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F160E70;
        Thu,  9 Feb 2023 21:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676005964; x=1707541964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pLHb5WW4IC/F3PcA0lRMj9uuO27sSbgiAlOwo8H93Zc=;
  b=UChjZEDEmU5Pz0S4rihX5I5DOdypzUwrnOye2AiPMDZtB46e9xegg8Mf
   NXZi4xdDGNw4TPqe0QC8PQJtCxS4mPwZVXpq6IEYlCI5gOsWpxkrE79cX
   qHujpC8Ce+E/2HoLZ2r00Ucs5BZ7N0wbmuTwA+BKY1dID/UnPYM9Yk2lI
   KlcJVow0Pro02pn458TaTvzRwK9IqIOgBKrqeo3c9rxT4pL1g/h7vy2Qc
   AsrTmoK8Bq8zVhjbpvFG/yOXzj1VsXWQIwBDVYGau0rn2NDKeeTal1Bsb
   qXW41PDY6ECfy1yuivLprnfENUFMmmWvat9rmOkXkgN0ARL+wNnlBkwQR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="309970230"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="309970230"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 21:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="996841618"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="996841618"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2023 21:12:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 21:12:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 21:12:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 21:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gaw1JhFp9zuQZLdKlSTUxj0Z6Xld8EklAemjRjBZul/Uxom0YF17sF0x+JqHHdM+xBJq3kGSFVVgFCgYuYrc/f+QR66UA7qyZ5s4ONZWudFEFHems1mZT1BM07LOJ1rWEKoXKHwjdujqG8pQ5LOuZl/gfaWO7ev2iu9miKmmNzbjd88h2RbCuShE4BDDT8M34OQnpGB9B3FCg4z8akUPti5r5ms8XIZXlMoAbve55emkoMd5rpeLxZQbcEDzZFpreZb8m4NqjJ3Anze3UzN2Q7GWt71Yo3IhcruIVKRKsHLi2tivKcss4U1VxxNxj1Y4WdAbT1hlVGsWdaWDtzJvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mBdQXggMa5tGM+Wf0sugJxOv2I34vm2xcBLA3z/glM=;
 b=hZzV0sw2bOaBmfkqUp/IAJ9Z2CtgiLIfBNOLKV9+douy8eReqAnzsZXGD5NA9gRhFxOseliVdQ/valnHbGS9wn+OwdIF5BlEsjWeEPjK7cQYUBbuR+Ut/Kfh2g0peO4dLxGaK8Ncv6/p6TCeLh+IeFQkVlTgwd1DTrzftptWcO/4VvtOIMLXxlFTOLBTac2Zl++KkLEb6KleQ1uwLzpUI+BdE36Oy0dO27C1nsoZNrtZn4cacODszGjqkXkt7gwtQjjuF2/Fxq4Lp7mA1WA0JUiauI4aC80pmgcfAJmgh16VjMi7Zr6OlGvcfF5UONJKwQcxWW3/dv1ezTP/daIdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 10 Feb
 2023 05:12:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 05:12:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Rix, Tom" <trix@redhat.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "darwi@linutronix.de" <darwi@linutronix.de>
Subject: RE: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Thread-Topic: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Thread-Index: AQHZPNBWS3WtUj6eQUmM/aZAFGIoka7Hot8w
Date:   Fri, 10 Feb 2023 05:12:40 +0000
Message-ID: <BN9PR11MB527699243353309A1DDFEFBE8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
In-Reply-To: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6329:EE_
x-ms-office365-filtering-correlation-id: 87fcca31-d12d-4cd8-25b8-08db0b256ee4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOSdU6IEZ00Sf8lU/cpnMM8fr7q36MNGcbt2WhD7c6fDlLrcdyPlWTrqbbbVrjRGGZQSYade9Aoi8GK9Z2j2gbjYxb9zSsfjqf23h8SxliEW6R2CpsWFCNysC+riK9E2dBGG80AbxCZCI4KDnWfdS0kjVDWEEfM7gsRkdpW0MrRVQnUO/AWBv03TZ3ucYzwQXxUdgQBSCan24CK2V1H5E5UgYhUgTqJfJQoC+h4FbwFEGNNP/LBTmzGuDoRpLilQNIzMkcE581t5uiQUbeO1rVb3GBkLg4f5H35YfHwRhQgiA9MtJ9HwcjYXPd8gH+xSxAYi6n/AO4EvS96w7C6XscpPVIhSSv2Z7oxRi4wSnm5fO5S1rtn+tCaeo3t6lqz7VoiQq2X91Mh1EsjwwoSnw4YD9RC1muZ3CDFtzongHAo64vooU/qMEiKmFPY0K2GsAfUG1etnEqmVAAzWGlAT/BcEMNTC+ZAv89NisD55+jDPaspMFToBjCMGe4UbYApbLugk8B31OwW8eXj/GATZuxW+CGFQn9cHNAZpDb8hLBkwE3In0AGRbKoPWuVY3+PtXKqBDHjnZQ91dMQs0OALXwBI9hXLfMWIk7m8XFHLeUsxqwu0hjJC++GVIJ3ED8VdKl6HUOVDS1qh9jdxuNYbB+uCUkRpC54M9i3W4IfwJIqZ8ZG16AtTdScdMOSuo+L9wM/kYZf1iPh3UccDzjIJrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199018)(5660300002)(8936002)(2906002)(83380400001)(66946007)(122000001)(52536014)(66446008)(82960400001)(186003)(38100700002)(41300700001)(316002)(26005)(54906003)(76116006)(6506007)(8676002)(66476007)(86362001)(4326008)(55016003)(64756008)(71200400001)(7696005)(38070700005)(110136005)(478600001)(66556008)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6mhbn8Tt9WPZBz4ZBRis4W7GJr4zu3QPxDIPemVxk/pUUInpbl9nDWI87Uq6?=
 =?us-ascii?Q?R6r+6aETTHhZJ8MtBVBPMAzO2Rwgrj+/qnlotxFA1PTkvfZCGeXbyeIWB+bv?=
 =?us-ascii?Q?lM7PDFGwkdmQjHwZ0rSQMOrlaFTjiNEFYyBuiSjhlcA5zaPFjM4NQUnex33U?=
 =?us-ascii?Q?kCCc75M79DB3hG9Wu9ZdwAAZJHAdblDIyomIclCgjxOPn99q5vDlkCdQKQxu?=
 =?us-ascii?Q?qKg092gt0u0MrSZ4hVkH3by6ym935ipZRtPIJJXApIHeNkZq4LV9D+1JLT3L?=
 =?us-ascii?Q?C1R/NEVRMZHQYhDxQZ1PcHDLRfGADzxjB7aQBQ7QhRnS0GM+fYZVU21c7Cy0?=
 =?us-ascii?Q?7dEKkxVzLPQLIYus1SjCrmzCSnVfqX7ZMRsi/0Obv6fOF2Oo9fNhdk9wn4y3?=
 =?us-ascii?Q?e70DQ9DM2oDXbkIpV5tXtwvrSxW0+OiH8nB4778uX5tZr/6+MlsrNlv2g3kh?=
 =?us-ascii?Q?HNHUk8iEYaINVGvoXnjhyeoBlbZKDeImFoJHOzKISjE0BXq3CD88TAmcbBq9?=
 =?us-ascii?Q?IG9geq0Dssj0FnHF5bwV8hxxmItcbxi9YAIu4+WIH6PF4C4h1ib+uMIs8H/1?=
 =?us-ascii?Q?iT4B44wN1NXAnvNLptyAIKfAzCJp/BB23TDzZk7jizvk5s0/D8FKdlJ5pFJ9?=
 =?us-ascii?Q?hzpv01koUp8JIrNYxl6U9F13b1+SoBmfolvXo6QxgIyb3o18s3QR+mEvpcUq?=
 =?us-ascii?Q?ArLCh9wW8QfwKX2qA9S/+iPkct5s06FBIqZKG9lLcl9AOudvyOrUh3C0WhoI?=
 =?us-ascii?Q?GHWDwd++hEz7n/UV4B2lFSNQKrlRIofgnejatI6a+ZESxRLjbYezU0QxKMO0?=
 =?us-ascii?Q?kDnzwepDgP0l70mAs42VUZwcFK4+MpopMiSCZcVs4z4bkWMLsh6IBfZXgksy?=
 =?us-ascii?Q?LULl8IahkFb0ioA97UYUo88fKjEevov0MUKe4d7juI0qR4JT9mGPlEaTi55C?=
 =?us-ascii?Q?FBQRTzCnPTeBM8NEHQfw8unWlcZaU1nKji3kCPo5cwUJ+MgbI1aNYcrwY5u1?=
 =?us-ascii?Q?WTIC7RovOvTc7VPXqBUsxB4kEQz0ZmXdg14SIT44DpyZIn/jxhWI0WvS0KcN?=
 =?us-ascii?Q?DXJYAO/Tj3n8wGcVpaSrCsrlZig9+cYaHFzrcVBhtxzMbarbPqcdVP3gF3bd?=
 =?us-ascii?Q?VHRVgId3iuRaHUlJTcgsGCZu11wVPOV40ohTQIMWLcubWjJswxAo267XHsI+?=
 =?us-ascii?Q?HBYgeeWm632oqQAf94WKkwi0Lro4x9TC0tR2bAHjXQgL3VIszaTKpOq5wutG?=
 =?us-ascii?Q?UPYvMLAahej+z6tbQCKT9Foj/FH52aOsRMKaOpAUi4sFJF496Oih/7JPrUWK?=
 =?us-ascii?Q?A5ohCra58Wv8CxIh6XNBATNN6ON+P5fxQR4LuhcJIPbAZ4okhhCXfbr95RVe?=
 =?us-ascii?Q?MhQADo/ExMf0tH7ajp+M1b82NIhl1yBs4sn+rRwMCVJe1P8eewQ9Fjs1EjKp?=
 =?us-ascii?Q?aTl72v7QG5BM0yswqpwkknNT9h4AWpQibU3fm2DT+pP6YFdwDFPt1jnULfUo?=
 =?us-ascii?Q?dvCawCZ8sTLqWB4LT/BcoX1oI0E0FMxMFGNEJtu6yk9j9Wi/bSmq6QPvGcKj?=
 =?us-ascii?Q?SlwixJT4sCv8IExRzFTS5/1WXF5WIj4BuH0MvH9L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fcca31-d12d-4cd8-25b8-08db0b256ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 05:12:40.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHbkG81STrSJSD42InnPJS/OTm5ILPa/CJTcJo8k+bW8dA4hmMMd2o/f/q7jw+rZemSwO6l4s2hG15RiFWfXBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Chatre, Reinette <reinette.chatre@intel.com>
> Sent: Friday, February 10, 2023 5:49 AM
>=20
> pci_msix_alloc_irq_at() and pci_msix_free_irq() are not
> declared when CONFIG_PCI_MSI is disabled.
>=20
> Users of these two calls do not yet exist but when users
> do appear (shown below is an attempt to use the new API
> in vfio-pci) the following errors will be encountered when
> compiling with CONFIG_PCI_MSI disabled:
> drivers/vfio/pci/vfio_pci_intrs.c:461:4: error: implicit declaration of\
>         function 'pci_msix_free_irq' is invalid in C99\
>         [-Werror,-Wimplicit-function-declaration]
>                            pci_msix_free_irq(pdev, msix_map);
>                            ^
>    drivers/vfio/pci/vfio_pci_intrs.c:461:4: note: did you mean
> 'pci_ims_free_irq'?
>    include/linux/pci.h:2516:6: note: 'pci_ims_free_irq' declared here
>    void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
>         ^
> drivers/vfio/pci/vfio_pci_intrs.c:511:15: error: implicit declaration of\
>         function 'pci_msix_alloc_irq_at' is invalid in C99\
>         [-Werror,-Wimplicit-function-declaration]
>                    msix_map =3D pci_msix_alloc_irq_at(pdev, vector, NULL)=
;
>                                       ^
>    drivers/vfio/pci/vfio_pci_intrs.c:511:15: note: did you mean
> 'pci_ims_alloc_irq'?
>    include/linux/pci.h:2514:16: note: 'pci_ims_alloc_irq' declared here
>    struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,\
>                                     union msi_instance_cookie *icookie,
>=20
> Provide definitions for pci_msix_alloc_irq_at() and pci_msix_free_irq() i=
n
> preparation for users that need to compile when CONFIG_PCI_MSI is
> disabled.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
