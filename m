Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F27EBF27
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 10:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjKOJJY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 04:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjKOJJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 04:09:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161FBC;
        Wed, 15 Nov 2023 01:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700039356; x=1731575356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2FL3a2vQiIbl21dlpb35XgA67xUZrCgHOU7npAXZTEQ=;
  b=fP2owPRNpNkQD7MqjqPAL40eLst5p+fgU/PDXWXkIdGm+j35sDtj3f42
   1mMfhXCtGclQVLt/5gHglMYL53mJ+elq2B2FjNS6QDKtf6DljNDiPuis+
   H+xZB/L58O6WIidt4c76QIM3DKZQB+byRfeCZqSzMUGwwI4uKOF+Phllu
   NSj9LUtkcEvKyXoWFFAIEyexe80GOA9DTT/Q2IEvU2VBFLpz2zGsFekcG
   yau8VQWUFT2Rz20RMGYmeikuZBZ48worqcfKMm40WNGZNx0yezwsbKVNG
   hS8XMLYhz7kBFojsYQwzDedcivkbJkmKHh2qX8262P4mpve2WXOscW3oQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394755947"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394755947"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 01:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741380659"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="741380659"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 01:09:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 01:09:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 01:09:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 01:09:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3kGiGauc5UjNTOyK+Xl6/9OElN1F4sWPvS3PVXS9e8bp86tWmUlit/3SrsMw48XSqDZgPelT3P08JrYp7mQCSXlAoqChM/wUOldZdABNaqQ2bRCowzWjZZgAQc5FsvVELwyaQH3BkKRCs4W/vizRpOLRpZ6c/OY4mxkeNyveJZecKhM+2DZuYl1AC39WmmDXywenAyjejuG2So5jIoBmIRH/QP6kdnmFUgWTCVq6KnQJL1rPwMrjJ1jrfmstm5jNcVibdbpoYnCa7F9Epj0dbeW+ZJzff2f1h7NchRdcJLQ1EXcoCY0gobsuG2SIrjD14t2NldxDDA25lyj2REk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrK6DQ/3tK6WEd8B4I8V82r+asJ01NJ2fcBA846DxFg=;
 b=Dpq7eiT0EOldnODqX4fkRAUzgEY6/JMjPfn/eDZHw+/sgBG9HjcZog/t8rTibAOrX9723cexn5Dx7H5S81vnJ3WIMiQBhhgKt5ib452i4B1K0Yx5pbnOncfU6OUV3+vpPEehQ/CKjEg9FUu6wAcHc3AHTWIzQ0NgaE79x0ffFdRrFD6WfjSTNSiyy8vlwV9XBca/ZKh62te0mt8YRk/gnIdob2n0bV6AqGFuw7fIqsL7XJ2cTeLFetVaKPNykaonJ3+QqWsB49jpAjjimwR63klyR3edRgQ8FuLaPuZquOSSYKPmcu4IAXTO1isjWozpD3cKGhHhRjxnryJDxxEjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) by
 SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 09:09:12 +0000
Received: from DS7PR11MB6248.namprd11.prod.outlook.com
 ([fe80::7a84:6d37:1dba:d254]) by DS7PR11MB6248.namprd11.prod.outlook.com
 ([fe80::7a84:6d37:1dba:d254%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 09:09:12 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "Jesper Nilsson" <jesper.nilsson@axis.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: RE: [PATCH v2 2/6] PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
Thread-Topic: [PATCH v2 2/6] PCI: dwc: Rename to .init in struct
 dw_pcie_ep_ops
Thread-Index: AQHaFr8mZ15mqKIaoEyA4QLIBADS5rB60wJw
Date:   Wed, 15 Nov 2023 09:09:12 +0000
Message-ID: <DS7PR11MB624805FE5E2E41E43D06C0A685B1A@DS7PR11MB6248.namprd11.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6248:EE_|SJ0PR11MB6719:EE_
x-ms-office365-filtering-correlation-id: e3e319e2-682a-42b7-0e25-08dbe5ba8898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7s/mHbByKwJEdYbbR/eBaEvab6BW4MuqO3YE4jekorh6dlY2kJLUVBTdFQb8grt541ZlAzLK+G7n4mIRsNXkFB4RbxCYkCvqUhHgNO/iG/cOr8BBar1n6ZQSpCH8sUmW/1NGu/N9mWj7S2SG3uwbxrXSscuv4tq3+kuAdWVMfzMVmMWf3h7/PaYFgl4CnyGTfhTqjwH//pMNI6FAVXvW0Kbr6+byv3+rA9F/ntbq6RLXoMHIKpyosflHGHdkxsmOgO5L2dzxglQ+otAtZ6rklRJUBp09lyTzTndLAZvwiAJSIux1I/u9kMrf8aiiGrM/maxGSMsxom0lkBXPY+TaSS4OSEWurOYzBrDUGONCS1oOz7+ip1485bH7rlsBNMZDALYknU0GKTGwHBi3by5QsTqnsZb+8BR1d6V0N+nLP4DHQ4pQiMOIFxvqwdl3JEeBNcK5AEmYSxCHdKqMwGv2O4f+IftXPvdZl+6hTn5CnTZVwafpukSs8z+9M+ol1KtV0JV/8bzF8q1BLY1hdG2qOCqeTkroTgte0O3Jv4RakGb59XHp95v8EBaWIr96X4FXgd2WzQ0Wk75LG8WAMS7kb+VSJxvwyp21mqwvQNP7Zj4S3CbuMO6x3XwwIenoGrdlDBzm1IYVKzKVPsukmWwllxyWZ/nt1FvANr8vI+37m2hN3qwCsX3F0qHrEqphrPi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6248.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(71200400001)(38100700002)(478600001)(33656002)(316002)(64756008)(54906003)(76116006)(66476007)(66556008)(66446008)(110136005)(66946007)(86362001)(82960400001)(122000001)(26005)(52536014)(7416002)(9686003)(8936002)(8676002)(83380400001)(2906002)(4326008)(41300700001)(5660300002)(38070700009)(53546011)(7696005)(55016003)(6506007)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n7EbSZm08zE6C8IWavXAK8fB0T/AVac86HDsULxLSFUSRImxgUSKqllY4kYo?=
 =?us-ascii?Q?UTuEfstf19bhVHxLTfHl/U9FA9bw7R0khcOz8ylJlQIl5fbuXYC2irY1siO/?=
 =?us-ascii?Q?X88ZsCcfk4MOyNUPGM4PKQz3a6EO5CwrqHYAfhK9y2bQV3dy5Sl4svm1dc2+?=
 =?us-ascii?Q?+BEtJ3d/KelPVSulpRBe1pKOmFFl8hdhNqs2r2AUUYx6DdG1oPnuWOGOw5hr?=
 =?us-ascii?Q?uAkrTTpYpxTgKq8XXe0COgt2TkRHd7l7Zu0iLo40UevGxhpcAp6ga0lazZ1Z?=
 =?us-ascii?Q?f6YSOaSUUnzoXt/5jaJrkUVS3qVnmZGlaXh3A/0m2TpezHEqj9Totjd0UWzp?=
 =?us-ascii?Q?ZY7UVOEZ5Yc1/KbUB/xVisF7bSTDdd1RJegoEqWOWUuy8SIRYk8a1SIrUOEI?=
 =?us-ascii?Q?lcvQQ8vpc2sueDbITjSuPU5VlHghulLsZE7zUAH8XNBRUFKZbwujx5Sg0gNl?=
 =?us-ascii?Q?8ku4nTp3O9y6adUYZBFyglXKHad44i9SQ6/R4j/qhm66BW08YYDdQtAxP/uo?=
 =?us-ascii?Q?td+7ZhUHf1aoIYDV/7N8pZVaKihAFJW0xRIO7o7T+zlQZKsfLXRxVmPZniiU?=
 =?us-ascii?Q?xKXwJ3VStNj3CxnBuLzmYf9efNcqsfjzREEps119DbNwCwxBHSvCIyOELqbJ?=
 =?us-ascii?Q?8BPp++8537BseTCmW/sj7ZHNf8SQleLh8m2Xf4ev+rk5d9IX4J7/Z0u2dabV?=
 =?us-ascii?Q?LuCC84kw6G9NMutwrZN5ikKKW8rcQytDJyqZiJMqIHN1doAdJrNtA2XZoAsQ?=
 =?us-ascii?Q?TlKM5s2RBrGVjb6Hm0Ocy9amCPfrYX2J2rWfYm3p1E1cOXU7xKFW8thxqSs+?=
 =?us-ascii?Q?iXiet5auENkuSAT8lI7AZxjWG4lwFR6vCyLZI/0BRctC6eMPeb8k6axPoiWL?=
 =?us-ascii?Q?6KZ/OmX7rRnCSBVQZt2ZQ4BXF2EEu0pcjuD/E/rIeGF9Na+e6jyPVc/FihyZ?=
 =?us-ascii?Q?LbRhgQO2j7BjI9bpLcJJtu/g/bwuY+Kpg8GrrvAorb1g2toxgPCYsyy57pQT?=
 =?us-ascii?Q?Ir3rpok83FNdCyWmlNBUHNTzYr/t+u3+A0PLB/jpAOuUiCQr9WPXdKjXbp8S?=
 =?us-ascii?Q?o0NoI2DnjoMsHd1WcedrpleRDC7JoPQ3z9H35wq2SxYAdgGuCU7tVj2af2XX?=
 =?us-ascii?Q?HjqCvu/+R2hM9OGASbyT01gGCABNu7HlFVwDYZSf+DzByJ9CO+mJsJmw4zXi?=
 =?us-ascii?Q?zng/BUhTtLJ6Sm1oyo8epWBydmqWFDj7KiAL21bZik8aQtYTfRmbnn2UlhNP?=
 =?us-ascii?Q?cLrkfW89sG5zqQIFbLyeNLc86LlUJFLXmouGibUKTISKrVrjFvYWwCkjHh8K?=
 =?us-ascii?Q?D4Hnbn6XpcR38d+uJDVyC4Q7NdhJOM5q/92Gv66RwMnIxJe02wZUIfHJA5H3?=
 =?us-ascii?Q?KbtVK93fytDpJtBTl3MgIm1vpRtFjWzJWHZ9LFkoluzUDW98/jLyKPOBvEaF?=
 =?us-ascii?Q?W3e/simBB9RZS+D51KChSuakLxERROieBL/IYeeJmxjXqtA+xv+Al3suFgwc?=
 =?us-ascii?Q?1uIsOA3MhRviAIa9ZURzH/XQbMhiuQ31kaOpC98fiuD88bPK9OmU6/Sbrhxp?=
 =?us-ascii?Q?nxC0PhGjP0mDSgIJDO32dWeuEFE9puSAG1c43520?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6248.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e319e2-682a-42b7-0e25-08dbe5ba8898
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 09:09:12.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejJ2jsZFGCXp8iT06xfY70q90d8oMIT4GK7/OfHuJKJij4sQ9DU2wP76ub1W0fOBzaITuy7LsUPdevjga+W8Suhmlaa9Fj9HfIoKfD6FXY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: Tuesday, November 14, 2023 11:25 AM
> To: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; jingoohan1@gmail.com;
> gustavo.pimentel@synopsys.com; mani@kernel.org
> Cc: linux-pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Yoshihi=
ro
> Shimoda <yoshihiro.shimoda.uh@renesas.com>; Richard Zhu
> <hongxing.zhu@nxp.com>; Lucas Stach <l.stach@pengutronix.de>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; Minghuan Lian <minghuan.Lian@nxp.com>;
> Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; Jesper
> Nilsson <jesper.nilsson@axis.com>; Thokala, Srikanth
> <srikanth.thokala@intel.com>; Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com>; Masami Hiramatsu <mhiramat@kernel.org>
> Subject: [PATCH v2 2/6] PCI: dwc: Rename to .init in struct dw_pcie_ep_op=
s
>=20
> Since the name of dw_pcie_ep_ops indicates that it's for ep obviously,
> rename a member .ep_init to .init.

For PCI Keem Bay,

Reviewed-by: Srikanth Thokala <srikanth.thokala@intel.com>

Thanks!
Srikanth

>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
>  drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
>  drivers/pci/controller/dwc/pci-keystone.c         | 2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c
> b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 6125a838f4b1..1ac1be12a235 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -436,7 +436,7 @@ dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> -	.ep_init =3D dra7xx_pcie_ep_init,
> +	.init =3D dra7xx_pcie_ep_init,
>  	.raise_irq =3D dra7xx_pcie_raise_irq,
>  	.get_features =3D dra7xx_pcie_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index b02f6f14a411..644916a67a38 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1093,7 +1093,7 @@ imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> -	.ep_init =3D imx6_pcie_ep_init,
> +	.init =3D imx6_pcie_ep_init,
>  	.raise_irq =3D imx6_pcie_ep_raise_irq,
>  	.get_features =3D imx6_pcie_ep_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c
> b/drivers/pci/controller/dwc/pci-keystone.c
> index 3711347ddc87..d0f50cceede9 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -944,7 +944,7 @@ ks_pcie_am654_get_features(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops ks_pcie_am654_ep_ops =3D {
> -	.ep_init =3D ks_pcie_am654_ep_init,
> +	.init =3D ks_pcie_am654_ep_init,
>  	.raise_irq =3D ks_pcie_am654_raise_irq,
>  	.get_features =3D &ks_pcie_am654_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 3d3c50ef4b6f..4e4b687ef508 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -195,7 +195,7 @@ static unsigned int ls_pcie_ep_func_conf_select(struc=
t
> dw_pcie_ep *ep,
>  }
>=20
>  static const struct dw_pcie_ep_ops ls_pcie_ep_ops =3D {
> -	.ep_init =3D ls_pcie_ep_init,
> +	.init =3D ls_pcie_ep_init,
>  	.raise_irq =3D ls_pcie_ep_raise_irq,
>  	.get_features =3D ls_pcie_ep_get_features,
>  	.func_conf_select =3D ls_pcie_ep_func_conf_select,
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c
> b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 2f32fcd8933c..f6afa96a97e4 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -370,7 +370,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *=
ep,
> u8 func_no,
>  }
>=20
>  static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> -	.ep_init =3D artpec6_pcie_ep_init,
> +	.init =3D artpec6_pcie_ep_init,
>  	.raise_irq =3D artpec6_pcie_raise_irq,
>  };
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..ea99a97ce504 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -794,8 +794,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		list_add_tail(&ep_func->list, &ep->func_list);
>  	}
>=20
> -	if (ep->ops->ep_init)
> -		ep->ops->ep_init(ep);
> +	if (ep->ops->init)
> +		ep->ops->init(ep);
>=20
>  	ret =3D pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>  			       ep->page_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c
> b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index b625841e98aa..97088b7663e0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -74,7 +74,7 @@ dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> -	.ep_init =3D dw_plat_pcie_ep_init,
> +	.init =3D dw_plat_pcie_ep_init,
>  	.raise_irq =3D dw_plat_pcie_ep_raise_irq,
>  	.get_features =3D dw_plat_pcie_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 5c4518ad1bec..3bc03a93732f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -332,7 +332,7 @@ struct dw_pcie_rp {
>=20
>  struct dw_pcie_ep_ops {
>  	void	(*pre_init)(struct dw_pcie_ep *ep);
> -	void	(*ep_init)(struct dw_pcie_ep *ep);
> +	void	(*init)(struct dw_pcie_ep *ep);
>  	void	(*deinit)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c
> b/drivers/pci/controller/dwc/pcie-keembay.c
> index 289bff99d762..3c38e047d5ed 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -325,7 +325,7 @@ keembay_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops keembay_pcie_ep_ops =3D {
> -	.ep_init	=3D keembay_pcie_ep_init,
> +	.init	=3D keembay_pcie_ep_init,
>  	.raise_irq	=3D keembay_pcie_ep_raise_irq,
>  	.get_features	=3D keembay_pcie_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 9e58f055199a..2b6f7c144c61 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -796,7 +796,7 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops pci_ep_ops =3D {
> -	.ep_init =3D qcom_pcie_ep_init,
> +	.init =3D qcom_pcie_ep_init,
>  	.raise_irq =3D qcom_pcie_ep_raise_irq,
>  	.get_features =3D qcom_pcie_epc_get_features,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 193ed88d3c2f..1c017997fb3e 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -408,7 +408,7 @@ static unsigned int
> rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
>=20
>  static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
>  	.pre_init =3D rcar_gen4_pcie_ep_pre_init,
> -	.ep_init =3D rcar_gen4_pcie_ep_init,
> +	.init =3D rcar_gen4_pcie_ep_init,
>  	.deinit =3D rcar_gen4_pcie_ep_deinit,
>  	.raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
>  	.get_features =3D rcar_gen4_pcie_ep_get_features,
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index cba3c88fcf39..40bd468f7e11 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -284,7 +284,7 @@ uniphier_pcie_get_features(struct dw_pcie_ep *ep)
>  }
>=20
>  static const struct dw_pcie_ep_ops uniphier_pcie_ep_ops =3D {
> -	.ep_init =3D uniphier_pcie_ep_init,
> +	.init =3D uniphier_pcie_ep_init,
>  	.raise_irq =3D uniphier_pcie_ep_raise_irq,
>  	.get_features =3D uniphier_pcie_get_features,
>  };
> --
> 2.34.1

