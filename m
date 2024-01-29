Return-Path: <linux-pci+bounces-2699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D350184009F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA1D1F2180A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A754760;
	Mon, 29 Jan 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Roy6NipE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9154BCF;
	Mon, 29 Jan 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518434; cv=fail; b=mZh3/Q5AYN4KsW0ORm68QQXry3k8NlsBkC+85px+LlgPFWZbrYITSF/IPdgQK2q8vz3xnt7mm8XGZCKlEgyRPF0KCFfE/aaaQvrPoP42B8H9TxFRdyyPuj+UqbmZB7EKFkkl1x9rKxIxkfGikPtI8xUyprL2Q0803ujHHFgUwXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518434; c=relaxed/simple;
	bh=BC+OsVh3sLzev/p013IVSgKk+vtmjKgt5PHtYiwlAHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X2gPxV/31WzA2ZGIqpH7iOR/yHhg6OsE/9cX4LyxkydtMStXmbPNaY0BBMLv8nh729HJ9tO2onT1HFc2dg45m2UEfUdZQRgB3rnAWv14Ara/teD06m53ST+CWLG0aeOZInOQuE0TreJi6RxubELy3Aoh1SdTJsPPCXDHvvpIKwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Roy6NipE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706518433; x=1738054433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BC+OsVh3sLzev/p013IVSgKk+vtmjKgt5PHtYiwlAHY=;
  b=Roy6NipEcD5VFeZXFRosdbRIwHo4lk3NFe77LJyBmSerlGeb9uFNvWMz
   hYfX7HWA5PUIK9Y4StO0cBVayV40uDAGHZr9bLZKmyaUBhh74NPC/orgr
   uNKAyJ2oXMkaqNTFYDu1Rh35jzj7NSHvwyWgmMemo7ZkZcycOgQrZyevc
   0UegQTycvw5m9thgeQvSb2FHtIKZHe0Z07sf3UE4cCMWNHHuyluEJP4v4
   BEeBmjX+fhQW0aDjhDDZHHyu/7d9XHsPha4TSNSFGV2wOIe5qhea+oeN3
   7U/3+Dfo9CzdAMY2XChTLQEJKXudo7a4WMsbdhiIRuEFPZtsUXRpZXEkF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10008281"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="10008281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960840669"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="960840669"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 00:53:52 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:53:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 00:53:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 00:53:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSWgsjBnjU44Tms1W21tQpA9abcRcK95mxKtIY5sCQur7EJNbReWmxus0RLZNPaD4zKPE/g9BWmDfYbrCaMqtWJf/nVoM3VTmDQxBzCY/qUQXFQphRRBv5w+TcI2jToyiRTPMtXHjyswrJ6Es5tqhfqsJ/elyyvb0COUwYTIb2RzWhCG5eGrD9XW/k9BBnrvOT41B9A+I3EhTnCRXZZnMCzNaiLYaNRDBLjg+DvGDFCDnVuXejEc8p4vl2eEycL+JBKY+Dl0jT30kyzUikpEea15NTuwsL1ZDGy9E0ZPSsmym2krTJv1g8x2yAn4xPaZFYfLC6RQHcvb3p7xE+fwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RgL+Iqv6zvY/gg1+odxKddIlsSnzCAwF3kARfrpauI=;
 b=YVKC53r8V+wmcFwNRFJMcwSZo4WZT7EtE8Jsolqkv4JGh0mwvy3aIVQC52ukeuzDhVcpf2Exbx9vP64GsCKFiyz16/qeJMgS9HK500JlmvFJeevCOVxHBsl5P9N4ZqSQT9eRJfMz0W5T5cJPzpY/gcmS5Y8iDh+lTPMWt3Rx1J1YZLUROegweXufwpePgORlP0DZTOS0uQDsbynfs3IQhG9Zkg3YsbyNSeOpAy03TVeD2OpIOM6fevHws7HgIprBIU0KXX/j13KMTbrHAJ719UCmNDvmgZL+6eyy6afZDpKmXOOpuASGXYsgYzZPtmzYzsZ3I9WMnvOHt+7Z3d8QRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:53:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:53:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Haorong Ye
	<yehaorong@bytedance.com>
Subject: RE: [PATCH v12 2/5] iommu/vt-d: don't issue ATS Invalidation request
 when device is disconnected
Thread-Topic: [PATCH v12 2/5] iommu/vt-d: don't issue ATS Invalidation request
 when device is disconnected
Thread-Index: AQHaUmYzrQ08B6c1X0Sf33u4K2TbKrDwe42A
Date: Mon, 29 Jan 2024 08:53:48 +0000
Message-ID: <BN9PR11MB5276AEEB81124D55B087F4FB8C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-3-haifeng.zhao@linux.intel.com>
In-Reply-To: <20240129034924.817005-3-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 7f89d061-26ba-483b-40e0-08dc20a7cec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWG3DVwqCnPlLU/BCBJL67Ayi4Dr+9I43QSsSozyc22GH+pkdMrEugfyflpx/Dp/TlYIi5oHAb93JvTQGTotXXliPNovBhbhhEPBrs6Z4H+mLIYaS8UbEFspwOvCve1oL8YELWnley4wcsWuQ5dIB+lsym+Wp0soCjp35HHpaslgtwDEZ76uscBiBrQCHQUsmTi0621Z656w7JuBngB0pu0LZeaPHAwp0ar27rcEE0mqbtlQM8xjJ0FiA019BvKk3y0YFORVRe7XpP70J4oF+/l+QjW7kB8N5JQ8ZFNc2rB1Qteytb2j4yMxCWyn4N5S+qIAffXnQpboVIIHTioAW5ezre1lvsZhttHGvhGR2bK6P0VO5xNViJp1W7/OLPY3Ioc3y6FlrWx6U1YRb6eJFdoodVgHy8IhictaoW3Jf9uSdqqDiO4NHBI6lHneS7ldbMJHcINisCBK/XFKOe2jwjbN+uAqi6I91VHSl85bbgc+Jj+VOGORggHqWhMVLUaANNDSMGAWWczPRFmLW/cDp6/vUy0kk1ZzEkRLL7qevzq0xPNu6d7aob7neVMkdAFB/8BwX1vZjHQVRVhtAZSdfWMaNaklPULD2YPiqGm2BIIZUYrUetFAwX4EbhYO9+h7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38070700009)(55016003)(54906003)(7416002)(2906002)(4744005)(6506007)(7696005)(5660300002)(71200400001)(9686003)(76116006)(66946007)(66556008)(316002)(110136005)(4326008)(52536014)(26005)(64756008)(66476007)(66446008)(8676002)(8936002)(122000001)(38100700002)(478600001)(33656002)(86362001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1QLN9u0gS3FPRSG3rl2Shq/gw8tfS57lKIrqfezpIfewHUS8afionH9DSRtC?=
 =?us-ascii?Q?WqWFokks8LV/OunDmUFI+AAaiG4sLDOJlJBkz+9ZTebNHLlq1eHgpTAvvP9h?=
 =?us-ascii?Q?s/jODCVYPMpPbtOd9t9GQpM1Y0fED6y2YvrhRajGXHkVNdo++wKYl+OrqsMi?=
 =?us-ascii?Q?/Er0QQYP7xvGeCXsdePOTwu4mwWZBU4iYN2lldYEuZJI3PheuH0Isvzp0Cpk?=
 =?us-ascii?Q?hPxIR7Xtnhpewq4X5UjszQiRcPXpbrtZ9LVOLStkKiNA229id72c9ERGWty5?=
 =?us-ascii?Q?6H7wMsfSqreSr28Kk5mLmU5WEUh1+G2D/MZOiiACwZvrXPfXnXWfTWJkbpPr?=
 =?us-ascii?Q?KW3QGIgm4tqOb/x7ZFOC/rQjrhavsZkFXLMX6MWHlfi5BV3tdZlSoBtZ/A+J?=
 =?us-ascii?Q?226mved4weh4CsPWbItV9tCHzeneQ4FFy1N7iSHSBJnJ1ZyPb+8a/cABB9ug?=
 =?us-ascii?Q?XHb18b3jCtNZxdJ0fH4mypLjsaTEpkAJbpCC7myji6FUbXGFjepMyHtV+8pw?=
 =?us-ascii?Q?3FzaBwednwFimA+dik7gf7K/P1zzZxQzuQeZuRm33I3MDW5zQRRLx69V97rW?=
 =?us-ascii?Q?sYo61fEpuiKP/lKOQ2vD2VshEHaLAh7XGwxguJTcp/gq4EdySz6SJxiPAreJ?=
 =?us-ascii?Q?TkOLaBCqmb6zvxxccngKORuue5DL+Jpe8p1gIHisBC6hR1hX8fVllyhgIsOm?=
 =?us-ascii?Q?EiXl6GUOnCHlyfTqTW2FDcNEEDroM6/py29CZ3JTXiD5ZDPfiCT7X5skRrEe?=
 =?us-ascii?Q?REZu9/rTABDQer2fkmQBCuJEQ6fB7rxLLJENH8aqwUHNAYfOto9EbsV6CWAR?=
 =?us-ascii?Q?Ei8hRzk1rYDNaaIR9y2BNbdc4spLTnDeJDwEXgOvWw5qqvV2b8DTXTs3hTN+?=
 =?us-ascii?Q?PV7Gr5gv74TPawdKNNfwiirfeSs2bxidinKQy41qUscU3Dpe+xdx8WT0AFWb?=
 =?us-ascii?Q?FdJF0418Cli6uH2FhermO++Q5tWtf4dXca1WOKCSELErczOwrDTqWcw47FwX?=
 =?us-ascii?Q?8s12nHJ/CH/sRr1UNfm62vKK+NOGS1fOg4w4OQFwx4vNgTw3DIsC2cB5k9ss?=
 =?us-ascii?Q?jpMHR0N1JZrJqnVKVrXeULy9wHI3hfX4pkiZXxBEI9V1ZxzaIwj5/Vdua1Lm?=
 =?us-ascii?Q?hsKj5U1VXDMdr97fLWzKzdl3DwrsV5Vbyc488QtdSYgMByeshQSqSOYtvA2y?=
 =?us-ascii?Q?ii6/OAo/VzZrANyGQGnKmj1S5dO3trVUeP6c34UShwIT6FJYfNCQIWaDz1rO?=
 =?us-ascii?Q?bNryh1Z8L5wwQyRo/idRvL51SGhyhxpMJUai35P1UECZis4AOWLeZWzsTXQY?=
 =?us-ascii?Q?b+uSWwPvr6n9HYVlinmnhgN5T7qiBtaHjruKhJbh0bRNJMPpeLeD5HqBOa85?=
 =?us-ascii?Q?+/229i37JwbdhvdTIDApXhkVwegLrtaBesJXkn8V94u0M4S0lK5NDZS7yxw5?=
 =?us-ascii?Q?PCbGUnP/eFlkrEAlXvvUQiZUu1DDxE4cZWTgQSyNYkGMtTLqmFd0NlzuH/Dh?=
 =?us-ascii?Q?skSlLNNGJPFT87RI6cV3yZmdq4c11ZXaoK++jeN3K6/UDn9mUWl47LlXk1TV?=
 =?us-ascii?Q?qkCgW5ZLcYjZI/M3Tn+b/AdDWOp15MTuzVofJQQJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f89d061-26ba-483b-40e0-08dc20a7cec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:53:48.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y5EJTUDFVNtdTdNPKF6xIeL+sUyTsXT7kmyxclTVdyVZcLEBy+Uw0SndGi3Z8Y/283yTAfTfk9AN03ds+Uqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Monday, January 29, 2024 11:49 AM
>=20
[snip]
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
> Tested-by: Haorong Ye <yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3239cefa4c33..953592125e4a 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -214,6 +214,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu
> *iommu,
>  	if (!info || !info->ats_enabled)
>  		return;
>=20
> +	if (pci_dev_is_disconnected(to_pci_dev(dev)))
> +		return;
> +

the long commit msg doesn't tell the fact that this is not a full fix.
surprise removal could happen after that check so there could still
be chance seeing timeout.

