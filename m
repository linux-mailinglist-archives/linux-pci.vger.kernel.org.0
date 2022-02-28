Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635E4C62FC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 07:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiB1Gdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 01:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiB1Gdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 01:33:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564F1B796
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646029993; x=1677565993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dgl5MHpfBNdimV/FG8CTQNf+n58dqrYIajNrnUwVrko=;
  b=eZnYi7KgTsCG8r627z0ljUq0hNs4gwJ9noDhtB2XvHf1l/9EQObSNi9Y
   MCGnyG8IzPjcblJmqNuEUDW2U4QFPZiFsK+qkDigBrmITTvVuTMb/kJ3h
   muF/eDWMaVFPYuqJ5OV64V7ZOO8T7OYqOT74p5HbXqoeRysHa/m+rRBE+
   rUq4youy6mHFf70FtEfkEhju7q+CxXrZfxK+TzUtiVLHvDVSbs+uMRWaO
   VYEZgUaaRynWFxH30vs6fXiuKQdFhflTWRVRylwPxaw8IVDH0xTB5XxVb
   +fjMOM4FugFas0zRaZTYExz5W9Y5qMW/ZAzW2Fpepku7L/dD771RMlqjP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="251649860"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="251649860"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 22:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="509977669"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2022 22:33:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 27 Feb 2022 22:33:12 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 27 Feb 2022 22:33:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 27 Feb 2022 22:33:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 27 Feb 2022 22:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msdnxaHHWgNekCtB+GX0KjCROstWdqOVToWC0dY3QRQlxP3yWQXRARSFuBxSbKRSX9Gg7fMn0OS02xqWsc0v8+snH7AvHcbrnunfpP8uVr01Q5qiuvr8BdL37ie4W/SDStC5BFe5zH5gCpwv733LQ7SXLc599C3u79dNwPYd4WBPsqK/joYqTMFrxCCbjuMZ1GLhDEBNG02vMhOqQ2ycOQzYxa1TetrrSO5cSpoYSZElAWMDzru0HI9wAj/L41hFcmWffxZ4Vm8CLuGRnQlxy1e7v5P5y/VqWsVzEd/oZuom9/nw1rOSH4C+mRTUi8iCmeu1MIcFcX2mp6c/5veb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSyBF3NSS9yYRr6qs+FL1pRps+/qsNG1jVLpN98700Y=;
 b=SFaqTowV2Cb/TixjqwbM91P+n8h5+PO3X1Ca5OV3eGp5Bhn1nJCxHV7VYq/IkS3IDsusiWQ8EDodtfs6WG/JVoLZ4HHW7PpZLt90jK/YU7PbMEaw41xqyzxQU5KxlzuAnAVEtGXra0ZY2bXOxPv8jsih6INeKReI/le4vXD7NkRTkyJICi7Uxp1NH+UaG5ajAKwgeLF3+NZYqo+Yyuh1j3QTy0isCMtSKfVP6sw46MhNS2YCY73WlOwIy0JyrZ4wYb98o1sQT/hIRLctvGZ9u3gflAG0MCPVJjEQIpX2C4Qc/lo5Cun6urOfOUEbaOUpKeB7f5JSP/MnQmkp6tlNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by BYAPR11MB2837.namprd11.prod.outlook.com (2603:10b6:a02:c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 06:33:09 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::e435:95a9:4a0a:8e67]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::e435:95a9:4a0a:8e67%8]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 06:33:09 +0000
From:   "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH topic/core-for-CI] PCI: vmd: Prevent recursive locking on
 interrupt allocation
Thread-Topic: [PATCH topic/core-for-CI] PCI: vmd: Prevent recursive locking on
 interrupt allocation
Thread-Index: AQHYKlQaq8Kc16ejmUqAFojLkryF/ayohQYg
Date:   Mon, 28 Feb 2022 06:33:09 +0000
Message-ID: <PH7PR11MB5819423323A534DA4076790ADF019@PH7PR11MB5819.namprd11.prod.outlook.com>
References: <20220225141550.162490-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
In-Reply-To: <20220225141550.162490-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12621583-585e-47d0-0796-08d9fa842fbd
x-ms-traffictypediagnostic: BYAPR11MB2837:EE_
x-microsoft-antispam-prvs: <BYAPR11MB283775B2EAB8B2830D4AC368DF019@BYAPR11MB2837.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xhB2mNSiKZFmHF4/s6as67V7wmBeolQD9YKagr/PG1x1XuV4c0nE2f44HMhFluGUFPwaM5nRqWtU3PH0f5CHFaYf6pwMIsaef8eRDXSlZ1mDuEHIZ+lmiEjEWU8XpqfnYLNMHNESlDo7jQr/erxbb1Fa/pTibG1CQG80DGaivvB9WGXVH6I+Bii+a90LvcOlLMjHrr4TAcBZ+pO0m7smQms/yAcWzt4WDx54WJrR6byUELJKEAlpYKHM/gaLLEy0UraR4TuK8XBsDgQ3xsdlZ0JC/oFXKtweSuXojlVksXsmMGH8pCOM21wFU0eed5PSZhiQuLG9/lJJ2NLenH8hiYpMLw0W5EGzHDkPPOHc7IhYyfPmO7cAtxAXGgCuaRGnK1+azvbtUP05SD9cqRPzzCI6en8KogIW3Yn/WkHbdd4EHRKHDSpqOcjS46O4Q0RKBge+6dtmSgFX6mZh7YXjzLnAEpt+KfdVurKxPnn5hvoMSnWH8Z8svA4aevFmcXWfAM1C/VT3XUntSIxAUxxYxeE+Ks2EKNRwqrBlBxjHoZg5kk9/B3QZejtBRCsxZDsn84tOsedigqoH4flfeFUHljzVSYX2YbpspIqnYUjF1Kw/lwzFq1ic6tTOvgbW2WKMxvCB7bhyxvJMPUxhQYf1OEvSwiz4GshZ5txADjVpJUxOnAag24Nm+MgbfKH27ryNGTbiU7j5upY+B00pjDyFtZrqsrRqT5QDW3YwTB1and77ot7iBla4kEgR1hu41ZytM7Ksh2qwvEkj80UaKaBq+s5OQHhkwW5dO9EK/HvWF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(38070700005)(66446008)(52536014)(966005)(71200400001)(54906003)(33656002)(316002)(6916009)(86362001)(26005)(186003)(508600001)(38100700002)(53546011)(55016003)(122000001)(2906002)(9686003)(5660300002)(66556008)(64756008)(7696005)(66476007)(6506007)(8936002)(8676002)(4326008)(83380400001)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1oCrvg0pbHlLs0QBrjKo4/edn0Ymzgqj3A7dnhcbcfGs6wvD5SMX2o+nGcWA?=
 =?us-ascii?Q?7l9kOl4zPHmZBfp8pjGgXu+iDp8hJqnZCHrFibzILvTvKWdf0BTpw50k5MkJ?=
 =?us-ascii?Q?fEo2EaLnUu3yKaT5xPsKVxal9+09S/bHiSy7pcE3J4rhaJxKLOiKmvknOQvX?=
 =?us-ascii?Q?Uw4uzmZALyVtuWCvcAEq4qP/hIXzYlMSKJTnThDEV+xK3RNp5gjUDsindpsM?=
 =?us-ascii?Q?Cz8BsCTRamsWWaTTfUBX3Oy+Ey0yBybsPklOuhfr1TIdG8x3P1LE1hni5qkx?=
 =?us-ascii?Q?Mt+mF52sKkuJDWtTXUbCVxZBhjem4LfxBm9nsEUmr6ObAmnZU0Qg+z7xNUui?=
 =?us-ascii?Q?knVwIlkIxWesuBX7uBdyMj9EzbPO1n1EP+l5XVi7xEP73HRB3eNS++Dwk0mp?=
 =?us-ascii?Q?8v0PvfRmpdeounDH2fJOvUJmc88Q6B7ciqu6m3C+nKe937eJghgZe/ZMNU2E?=
 =?us-ascii?Q?KveoZAkpTAdt5qEyT5KvSZ32pqNdNRa59Td+Y1FbOi34aPczqscY4Hz34Wtu?=
 =?us-ascii?Q?aDuMnfXSeEfdPPch06LLcKU2eFtVTGu87S/y+4boI8IKW5c3vhIot+rOog+x?=
 =?us-ascii?Q?dtlpo4XtrnYDZblfAzTsrP4N/6o3TxwigwVlNBqZLZd0gbZ6SGbmJBL6mTuS?=
 =?us-ascii?Q?VhK+n36uPmBmjD8XC9WeLzvkqvCtjdMlUtpXAqMnHQuoefdO4yHriR11U1ku?=
 =?us-ascii?Q?6Z9MTZYycACSJT9WSRxni00N8IEeMT8LJlvT8DF4SYnDGK4keQ10Tuenf30k?=
 =?us-ascii?Q?XSct381xs54PJu45Vyhaxksq8F5GMIyAxiBMy2mKkVxs3ZNKNSmtU9LLf9zu?=
 =?us-ascii?Q?hiUcJv8f/V4pHUp9u0vgh5nL+dm9smz7JHXZA3VJ6Q7laUARN5/UF2/AC3fb?=
 =?us-ascii?Q?Ec8GJvEsA0y5xKJKrW+NE8RAIKr5foo6B4halsQC8RNTi4UphgKXSoR8pVJI?=
 =?us-ascii?Q?Xc/4Nb6RZPEOu4EiMyZAISs/FT3jK2ALV1j3mnRPenpMS9RoLT2F/gFntLBL?=
 =?us-ascii?Q?bLFh/SGDgB+QV2WBTUZzjSX94p10h7emBHeJgm3xjaxo6dPqqSdkHQ9kNIx4?=
 =?us-ascii?Q?8/Omy3Z4nxbgnlvDJ1T5GI9iKscbGKgjmZ6M95eayX6pkTpJG0LXawLhWfx9?=
 =?us-ascii?Q?/As9wDxZWtZy9zrDXjrzVJ10isVETQK5G8/+xiQN6NLl+aU5kfPlFjglXXZm?=
 =?us-ascii?Q?dbCSsq3tmxcxldpSfJuE1uk9isPkhDwBBNxLLXv0xFGcE1oqhvA492N6gqBe?=
 =?us-ascii?Q?SAUcMyR79ahNHh6FYOu/eYLr3oJL6634WwsE2jyzzfYrqefK5VINkO+QsD2w?=
 =?us-ascii?Q?I59nTRzHm7Z6AkgZy228Eo19Hu7P0nOD77uCsnWRDiJTSNYJN1Gjy5eN7Y99?=
 =?us-ascii?Q?44UcvrleuXHShgoLGBFEw/qYiV/nco9WolrF8KVrght5oN/gBCj3QLkhEWFr?=
 =?us-ascii?Q?RKL0ETQUkdVyhwukpthiDkNxqvZCgY1lWDhTDEyffMH21GcO6AnkMtyRbPzU?=
 =?us-ascii?Q?SofDVZSBdbVMym4MgxlCr3jxs4uqAJRYwMy6yLPHmoH4+4vhOlHnCFxTpibo?=
 =?us-ascii?Q?ZSvs/owVWR68+N+KJkg6nbjuWdcsmUXr07kI/WpyavJqAJyPX8vfvVSuWnHR?=
 =?us-ascii?Q?iEuJUhUo/r3o39i9BtrFeHsacnEK84nKgr3iw1tMVM3rBX1o+MmmcbZU4EtE?=
 =?us-ascii?Q?IIZtsVIhrgIHLOTAoLL3KiMg9WapVQvIsLlkB/OFwtezvYEWWCxocoKl4FvT?=
 =?us-ascii?Q?LZis5Tl7AKs91Appuxx/NLGa25qoestFLfwhvGtcmRmrr+SJrGJb8FZzyVc7?=
x-ms-exchange-antispam-messagedata-1: AREg/Fd0PxgIJQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12621583-585e-47d0-0796-08d9fa842fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 06:33:09.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyktD0fT+lZL6AYyYMrFYYsHujsBd6tdw96dcwn6eKknqpZf9YLAHrnpgWR5+nP5lTB5NSDIS00GPgIWujwFTb9eGITydJSghTwwWkXEERX+OW+7u5epIbbvweAqMz3/Cv+Az9W69jb7B9hqCrAiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2837
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

Please ignore this, patch https://cgit.freedesktop.org/drm-tip/commit/?id=
=3Dba1366f3d039e7c3ca1fc29ed00ce3ed2b8fd32f has already landed today in drm=
-tip.

Thanks,
Tejas

> -----Original Message-----
> From: Surendrakumar Upadhyay, TejaskumarX
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Sent: 25 February 2022 19:46
> To: intel-gfx@lists.freedesktop.org
> Cc: Thomas Gleixner <tglx@linutronix.de>; Surendrakumar Upadhyay,
> TejaskumarX <tejaskumarx.surendrakumar.upadhyay@intel.com>; linux-
> pci@vger.kernel.org
> Subject: [PATCH topic/core-for-CI] PCI: vmd: Prevent recursive locking on
> interrupt allocation
>=20
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> Tejas reported the following recursive locking issue:
>=20
>  swapper/0/1 is trying to acquire lock:
>  ffff8881074fd0a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x30/0xc0
>=20
>  but task is already holding lock:
>  ffff8881017cd6a0 (&md->mutex){+.+.}-{3:3}, at:
> __pci_enable_msi_range+0xf2/0x290
>=20
>  stack backtrace:
>   __mutex_lock+0x9d/0x920
>   msi_get_virq+0x30/0xc0
>   pci_irq_vector+0x26/0x30
>   vmd_msi_init+0xcc/0x210
>   msi_domain_alloc+0xbf/0x150
>   msi_domain_alloc_irqs_descs_locked+0x3e/0xb0
>   __pci_enable_msi_range+0x155/0x290
>   pci_alloc_irq_vectors_affinity+0xba/0x100
>   pcie_port_device_register+0x307/0x550
>   pcie_portdrv_probe+0x3c/0xd0
>   pci_device_probe+0x95/0x110
>=20
> This is caused by the VMD MSI code which does a lookup of the Linux
> interrupt number for an VMD managed MSI[X] vector. The lookup function
> tries to acquire the already held mutex.
>=20
> Avoid that by caching the Linux interrupt number at initialization time i=
nstead
> of looking it up over and over.
>=20
> Fixes: 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
> Reported-by: "Surendrakumar Upadhyay, TejaskumarX"
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: "Surendrakumar Upadhyay, TejaskumarX"
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/r/87a6euub2a.ffs@tglx
> ---
>  drivers/pci/controller/vmd.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c =
index
> cc166c683638..eb05cceab964 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -99,11 +99,13 @@ struct vmd_irq {
>   * @srcu:	SRCU struct for local synchronization.
>   * @count:	number of child IRQs assigned to this vector; used to track
>   *		sharing.
> + * @virq:	The underlying VMD Linux interrupt number
>   */
>  struct vmd_irq_list {
>  	struct list_head	irq_list;
>  	struct srcu_struct	srcu;
>  	unsigned int		count;
> +	unsigned int		virq;
>  };
>=20
>  struct vmd_dev {
> @@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domain *domain,
> struct msi_domain_info *info,
>  	struct msi_desc *desc =3D arg->desc;
>  	struct vmd_dev *vmd =3D vmd_from_bus(msi_desc_to_pci_dev(desc)-
> >bus);
>  	struct vmd_irq *vmdirq =3D kzalloc(sizeof(*vmdirq), GFP_KERNEL);
> -	unsigned int index, vector;
>=20
>  	if (!vmdirq)
>  		return -ENOMEM;
> @@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domain *domain,
> struct msi_domain_info *info,
>  	INIT_LIST_HEAD(&vmdirq->node);
>  	vmdirq->irq =3D vmd_next_irq(vmd, desc);
>  	vmdirq->virq =3D virq;
> -	index =3D index_from_irqs(vmd, vmdirq->irq);
> -	vector =3D pci_irq_vector(vmd->dev, index);
>=20
> -	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
> +	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip,
> +vmdirq,
>  			    handle_untracked_irq, vmd, NULL);
>  	return 0;
>  }
> @@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  			return err;
>=20
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> -		err =3D devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
> +		vmd->irqs[i].virq =3D pci_irq_vector(dev, i);
> +		err =3D devm_request_irq(&dev->dev, vmd->irqs[i].virq,
>  				       vmd_irq, IRQF_NO_THREAD,
>  				       vmd->name, &vmd->irqs[i]);
>  		if (err)
> @@ -969,7 +969,7 @@ static int vmd_suspend(struct device *dev)
>  	int i;
>=20
>  	for (i =3D 0; i < vmd->msix_count; i++)
> -		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
> +		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
>=20
>  	return 0;
>  }
> @@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev)
>  	int err, i;
>=20
>  	for (i =3D 0; i < vmd->msix_count; i++) {
> -		err =3D devm_request_irq(dev, pci_irq_vector(pdev, i),
> +		err =3D devm_request_irq(dev, vmd->irqs[i].virq,
>  				       vmd_irq, IRQF_NO_THREAD,
>  				       vmd->name, &vmd->irqs[i]);
>  		if (err)
> --
> 2.34.1

