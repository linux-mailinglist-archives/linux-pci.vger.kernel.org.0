Return-Path: <linux-pci+bounces-247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1677FDD2E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782941F21001
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC8644362;
	Wed, 29 Nov 2023 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GuU8Z8+S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qCBS19nT"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830510D3
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701275768; x=1732811768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=34O9c9S2Dk/hvpInB8uJULAV+eVOR6c637oXc4MzSbQ=;
  b=GuU8Z8+Sg6kpTNYQbO012aVCYjCAHhiyubsDgOPVFyn6orSaPpxwkMMf
   6bM0sXR0ZAVfoUJBYS93ek8EHL36tc2CTF0Ezsj4hDsx3xAbwcmE6X0i8
   zsNhQausXX4xoDWepreJQTNEtEPJwfVRHuvqskKLrDGcGJ6L1Y5SR7gcM
   0e85eLtDk2/n8XF+Nm4q6dbfTiAx/VWIsrREBL2/DcNL/dzsvhwKcVZlI
   gnxI016YizpHNhlKGhK0wZtkndL5fJhhWu14QeovwsMUT+jmemWKBNORe
   nCeAQueHcIbDUgkaDO0bfOw1E9D5qYb3dy/wywri5lqkb+fQZDRkzmXfo
   w==;
X-CSE-ConnectionGUID: uKDnU9SIRHavuhbl7fCclg==
X-CSE-MsgGUID: qNTSZS3gS2mX9V6u8TtX6g==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3485014"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2023 00:36:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL3HuNJJh3hC9b4e8JN0vaaBmP6HTWmE67S3wZckVGY74E4zvm3YmBpePGFdfSnpLAiBq7SgLoVaxmLvUt0FBk05B/Totpk59W2qyKOOZy/1CMH9XVszaCEJWTl+xRpIhPPZMH7+LinvM5cI8uUT/vgcyRbNBASJ/RtoUtTsssFly13M94YhCWWYZObdAB2pkoJhHJNuBRKlrVAwUmzzBO6OXrY/RT2N0Xtq5s8kn08Sc76DnihYl9cVfxxB+tYjE6GAaUKV/iRAQoHXEf1vwFSTLZd38xaD37oWU2xkJgG1rEozyM0I9eH7+OwPb2p45xMOqPNLucnKqs9ZWR6j3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvVZcFQ7DacB0U3Tym9dA+URBhnN84tCMHhHkNZDDjw=;
 b=gJGY9pxlCllwCP/3CN3jQN9AVfdEUfrvtbGm6kc/F/ULrZBf8SEUdItVjLOFnQ9VpIiZtctKvYbdtMhGDtW0V112Oa61NPWr1vcQgbIYFpqKgYIUuVID7tKVlBAwNjWUVemYvttegIyBNYT39HKKI9f/z/Tmtm28+hYvskVQEX4HmXZapv1mdX8dZkzKVSFxtjsm1bthouId5oYc/ELJ/E4PuHyeM0kPgBrK3AngCpjhGZlwXkX7oUWZ6H+lI+cERU0DTx2suiCjkCHt2AlfDCnhnn7vSplzaPtUxisRgHV+X4lw66bvsJFqoF6IQtCNtSm35qp2M67dcIDYppe4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvVZcFQ7DacB0U3Tym9dA+URBhnN84tCMHhHkNZDDjw=;
 b=qCBS19nTVYOW3IQod8q9ETlfHDuojAZ/EkIk285UarWmDbFhdBxPUOxcOniHhCAYcWG3AcXK/JEQllx/iFB4nfbz3e6PAsCTO57qn5JlnFmKI/FvPe+ME4faIcMF7kZC1vcw04vrSnOIIj/HGV0eWkMWCapemqJrzN0gQ5Ekcgs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB7979.namprd04.prod.outlook.com (2603:10b6:208:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 16:36:04 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 16:36:04 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index: AQHaIiIryDDmjYJXQUiqpuEqK4O7WLCRLOCAgABGvQCAAAxigA==
Date: Wed, 29 Nov 2023 16:36:04 +0000
Message-ID: <ZWdob6tgWf6919/s@x1-carbon>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon> <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad>
In-Reply-To: <20231129155140.GC7621@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB7979:EE_
x-ms-office365-filtering-correlation-id: c7e82691-1c4c-47fa-5cf7-08dbf0f947b8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 683+8iIXC2n+5jbbIN3d64XIhi87/Wsq/UrwaqLIAOCD/wtTk2d/j7TWoGVJX96FI9eQiogwv7uw0SXMYcXwOT9ZDwkQUzsAhI3I5kd6teIXlf4gJ1hfNk3C2gG3IFY6bzPiaZ8PDH5d4klnI+ZNgMHhh7zOyXjSqMpNPPblcOxIuqKNNrhD/2F8MSVrGST0aLE3zGg6HsBNrTxIyogVj5bd6Ud+iX5n4BOuX3apZEGqz5nYXQBmX6p1GMqC5p7a5ORLdmD0h5ZuLBzs4X/txV5Tc2W3OXkOpgpDk/AI22qNEqFHa+eOKWqP5aXAtoexwZCnrTewwlfU5pvkagxiNass1Bk+MvArR3j6e1sLAy4q+7KXkJdj+IzT8ct3v/6x/VSmwOirr9NrEu2ccrR3BSKIbqu9suPaK8KqeFiRcWU75cHklzr0MJX2HisNr/2oOedbvBDMWYp+Msv/GSyQpa5ScMdY9Ju3/JSn/2ApO1+MmRzPwdBfyRnErxvo0nL/TLB/DBiN9uFnSD0v5akI9YXZUS3vq0bLHkEyIRdCHIcehsDA/P7ZoQ/c1NFqi8xXSd5kKokGQvIRuVPj2NtNDnS7RpW6HZZdKyzazaZ79t2qbf7ECBh8rdfofjCf0i6H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82960400001)(122000001)(38100700002)(83380400001)(2906002)(91956017)(86362001)(5660300002)(8936002)(8676002)(4326008)(33716001)(6916009)(76116006)(316002)(66556008)(64756008)(66446008)(66476007)(54906003)(66946007)(6486002)(478600001)(71200400001)(41300700001)(6506007)(9686003)(6512007)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f4b6/g4eEYelLD0seVkqyHc5p1+rJkHMi2mdqfB3A+olFy9B8rcAen7yBbIw?=
 =?us-ascii?Q?fmx37hIBvJaMLYbyG52FF0gEaFm7rJyZI8o6kWWHNUz9grG0ow1Hb95BkrX1?=
 =?us-ascii?Q?nyoK2xAkDg52A6Jygofa+iK8swq3bLC2cH5zdi1d493pa8DEMePo8lvtKjxB?=
 =?us-ascii?Q?ya494DMMWotXSIP8OBPFZqn/LTIXxca9jlXPdG1J/bwLPxRTUHxC14gCfnSd?=
 =?us-ascii?Q?NtfK+9VL/L6sEEiVrwPCXcIKlGeA/WIz82JDXsBXqEq3wxndgO6T5gg5jC6Y?=
 =?us-ascii?Q?SqM0LBuYX7avAuv4uKzYWCPix7/wfrYuTf083GodSth+sFG7wRGLHA5NA8SR?=
 =?us-ascii?Q?BJSxeCVKnJuYVP8HbZJs70hSsHmZd1cDreCxkINndoBEEVAeX/yNFzYYjDrS?=
 =?us-ascii?Q?tHGq14x58mc1W4jenu7ErwfftxmXdTm3RzSmqCJmNe+NlOoQ3Cp/1UwZVga7?=
 =?us-ascii?Q?SQFIYaofRTbe/CD3snD0tnGo4tYCymGKQFOJgg6s3HhulBckalp/xQ3QV5fO?=
 =?us-ascii?Q?MMmPvXbuvidIaZZSH4zJZgKcaV7Xg3ks1BLjvqlW7kSUiaPv1/Fmhha1MJvt?=
 =?us-ascii?Q?PWcxmh0QTmXCmA0TBpWcxFeCo7o+/cWwOSpguSO+C7Oj7exB3U7JQHcXo5v7?=
 =?us-ascii?Q?IOWHfubArL2vF9lz6wkEqg2lxinogEtCMhVj/yz3NAJcPExvpe/PuepAMT5u?=
 =?us-ascii?Q?Oqyr5Cmi9hlfYzJrsUNYPNqAtmyqhZXN2T6cnUxVIFMPJG+yTnRbGkEwvJEp?=
 =?us-ascii?Q?tWsWr/BpuywFJ3OpTXf9Z4rUpNts5QALAdm3rIsq/UecMkhmC+VyF5qtX9At?=
 =?us-ascii?Q?sDpPzczq5LEL5V74WCdMsXEruhqnshAWwxFey1TlYm2/Nw6OW0V68/9cunn8?=
 =?us-ascii?Q?PYVACz1O2jUGoIJkCg6HzWoQbxx/xS9LA4R/3vuplC9gpi0wSU+IVlSmmoGh?=
 =?us-ascii?Q?RBmd4d2pt1E0WwrQX7Whttgzh5lanMlleU/amsZKfCOQt+Bp6ro3Wb/PS5Pn?=
 =?us-ascii?Q?4/B5L9jy1EXgwBcWk/k6bXXwicYoyG54NPC15zbCY9ytJLZdzcvE3DWJ/p0u?=
 =?us-ascii?Q?86Ef4KAqmvIOwXBVCxJkvKAQgmRGdEqHRn/zfxqVfJaQwvKb5bhOLl0+SRZa?=
 =?us-ascii?Q?31shg+lqczRSt+9AK/6HemMpyEPNWtVs5PMcckCASloIZbkhtpxyCab4hp9N?=
 =?us-ascii?Q?skC20d6aTgsrJBAbc7FHSgALN4A4O5S3xg5ojSO0eXWsYTQ3qoDr0kS/InGI?=
 =?us-ascii?Q?1vo8NTzxQIjsbisLMEP9E+DkbQJ0AHa4H6VMnksE/2BrhdjXSzXEglS/GWQv?=
 =?us-ascii?Q?dcx+YeWX8wuq8F04GwAmXHTCM8SNGDIRHvXI2VlhP6BcAQIIqiCdRfdUR/Pu?=
 =?us-ascii?Q?C28PCXR5nr+HAfmMpnvD/tyHWtuoN2f4kcpdssDnGGS90hDf5ZB2Kxevskii?=
 =?us-ascii?Q?8bWRPCE/BhL7PK/znRyyja5+SDlbw2oBRXYWt0+IYuCVrk4nNloP7h0AW2VJ?=
 =?us-ascii?Q?M+WCFe92a3ChRcgZQmoDrlV4c+JmWDoo9aRbs8Z0jXfebg/MUEFi17XbZCzV?=
 =?us-ascii?Q?czjwI7JgRs9n/fuCnazaNAZsRIybiLtIy+YpcvLMvDT6uWJiiyuILMtCYnw7?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFFAD388C31B2F4DAD9542EFF01833DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dakSwkGVFax+ox2/A9auWAWdfXjcrxn9Dzef2MCONYRg9yNdVoApPtvcgCEhbvNw1TDqCo3GVwKkEkUP3elvKtgPfc2mE3t5zlA0ARwG98YZfeDWoR89wcljKhacfevVXyzAIvPvORTkTZh2RablqfBJZaX0Ej727g0qOdiYXpVuVQ+6aS2CTmSfP2UWlvccQ++zOhVwmInmgPcEqR+lcXBTTCMxTcUBbhCbjuB4WfbSgo5OiJfjNFYi2oD8vmXWWRr167GLiJHK6L+sn78P/81TU5ZppM2+Nd7cmcUhIW/Z6jigjNU2zpzzr9yBZ+4PjT1FTFiwQOeQFANIgEoeEFF1BxlEgt14U88D5hHEriv1mw8arA8ZxZRWQA2pI1K68ofaO/rhaWAdgfrkUkwyjhCjemEl8vKgTxkUOSWD40ye3qftt8dNpt19b/nJfKXXLMFi1oVW9OL9CqWFudaYrf1DNnQWI+1mmGuZNblP2d0WcIuS0FF1MV4WejDAKYGNu3E9m/Ps5WKhlSqmCOzs0q4tnoB/c9MToXXGshSxXnN4+4FueOPj1b2X4M8CrMtw9pWsKznlkYGIWY6JDPNQaATJ/bEwmSL+xuSP2toNuheREhwK73leqTBvOYMZ2je8It68XB/0/4j8l9Qv3zyEGac5kgk1Nij80Dw8vGcVO9Nrh89jdDBvIk+8uYwMtV7DGLWlhRZmWjgkBiIyaqQ35xLDSmAw9bgGv0E0XlYvCkV/IimCB+JTfy96MwA0kmk/3lc6GEBY4OlwMxOedestGxiFRbY5TMRNK9MaWjDRwC66CwC7YB/hiQMzdv8DMBeuJZeLorBhPw5/n3OrTC6yt3IrMRFWD/lwAhOywhqLTNQmI7uL5Wd5wj89wbw+AX1S
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e82691-1c4c-47fa-5cf7-08dbf0f947b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 16:36:04.3653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5aOuBaNGRfJJA+P5IhG+onsEvJalMjkT66ZVxRgBBGQOZa4+3Oeea+4JZaYzJu0Lhx0UpXp7/PiQ0OQwUbOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7979

On Wed, Nov 29, 2023 at 09:21:40PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Nov 29, 2023 at 11:38:34AM +0000, Niklas Cassel wrote:
> > On Tue, Nov 28, 2023 at 06:41:51PM +0100, Niklas Cassel wrote:
> > > On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote=
:
> > > > The drivers for platforms requiring reference clock from the PCIe h=
ost for
> > > > initializing their PCIe EP core, make use of the 'core_init_notifie=
r'
> > > > feature exposed by the DWC common code. On these platforms, access =
to the
> > > > hw registers like DBI before completing the core initialization wil=
l result
> > > > in a whole system hang. But the current DWC EP driver tries to acce=
ss DBI
> > > > registers during dw_pcie_ep_init() without waiting for core initial=
ization
> > > > and it results in system hang on platforms making use of
> > > > 'core_init_notifier' such as Tegra194 and Qcom SM8450.
> > > >=20
> > > > To workaround this issue, users of the above mentioned platforms ha=
ve to
> > > > maintain the dependency with the PCIe host by booting the PCIe EP a=
fter
> > > > host boot. But this won't provide a good user experience, since PCI=
e EP is
> > > > _one_ of the features of those platforms and it doesn't make sense =
to
> > > > delay the whole platform booting due to the PCIe dependency.
> > > >=20
> > > > So to fix this issue, let's move all the DBI access during
> > > > dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_compl=
ete()
> > > > API that gets called only after core initialization on these platfo=
rms.
> > > > This makes sure that the DBI register accesses are skipped during
> > > > dw_pcie_ep_init() and accessed later once the core initialization h=
appens.
> > > >=20
> > > > For the rest of the platforms, DBI access happens as usual.
> > > >=20
> > > > Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.=
org>
> > > > ---
> > >=20
> > > Hello Mani,
> > >=20
> > > I tried this patch on top of a work in progress EP driver,
> > > which, similar to pcie-qcom-ep.c has a perst gpio as input,
> > > and a .core_init_notifier.
> > >=20
> > > What I noticed is the following every time I reboot the RC, I get:
> > >=20
> > > [  604.735115] debugfs: Directory 'a40000000.pcie_ep' with parent 'dm=
aengine' already present!
> > > [ 1000.713582] debugfs: Directory 'a40000000.pcie_ep' with parent 'dm=
aengine' already present!
> > > [ 1000.714355] debugfs: File 'mf' in directory '/' already present!
> > > [ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already pre=
sent!
> > > [ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already pre=
sent!
> > > [ 1000.716061] debugfs: Directory 'registers' with parent '/' already=
 present!
> > >=20
> > >=20
> > > Also:
> > >=20
> > > # ls -al /sys/class/dma/dma*/device | grep pcie
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma3chan0/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma3chan1/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma3chan2/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma3chan3/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma4chan0/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma4chan1/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma4chan2/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/d=
ma/dma4chan3/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/d=
ma/dma5chan0/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/d=
ma/dma5chan1/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/d=
ma/dma5chan2/device -> ../../../a40000000.pcie_ep
> > > lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/d=
ma/dma5chan3/device -> ../../../a40000000.pcie_ep
> > >=20
> > > Adds another dmaX entry for each reboot.
> > >=20
> > >=20
> > > I'm quite sure that you will see the same with pcie-qcom-ep.
> > >=20
> > > I think that either the DWC drivers using core_init (only tegra and q=
com)
> > > need to deinit the eDMA in their assert_perst() function, or this pat=
ch
> > > needs to deinit the eDMA before initializing it.
> > >=20
> > >=20
> > > A problem with the current code, if you do NOT have this patch, which=
 I assume
> > > is also problem on pcie-qcom-ep, is that since assert_perst() functio=
n performs
> > > a core reset, all the eDMA setting written in the dbi by the eDMA dri=
ver will be
> > > cleared, so a PERST assert + deassert by the RC will wipe the eDMA se=
ttings.
> > > Hopefully, this will no longer be a problem after this patch has been=
 merged.
> > >=20
> > >=20
> > > Kind regards,
> > > Niklas
> >=20
> > I'm sorry that I'm just looking at this patch now (it's v7 already).
> > But I did notice that the DWC code is inconsistent for drivers having
> > a .core_init_notifier and drivers not having a .core_init_notifier.
> >=20
> > When receiving a hot reset or link-down reset, the DWC core gets reset,
> > which means that most DBI settings get reset to their reset value.
> >=20
>=20
> I believe you are talking about the hardware here and not the DWC core dr=
iver.
>=20
> >=20
> > Both tegra and qcom-ep does have a start_link() that is basically a no-=
op.
>=20
> That's because of the fact that we cannot write to LTSSM registers before=
 perst
> deassert.
>=20
> > Instead, ep_init_complete() (and LTSSM enable) is called when PERST is
> > deasserted, so settings written by ep_init_complete() will always get s=
et
> > after PERST is asserted + deasserted.
> >=20
> > However, for a driver without a .core_init_notifier, a pci-epf-test unb=
ind
> > + bind, will currently NOT write the DBI settings written by
> > ep_init_complete() when starting the link the second time.
> >=20
> > If you unbind + bind pci-epf-test (which requires stopping and starting=
 the
> > link), I think that you should write all the DBI settings. Unbinding + =
binding
> > will allocate memory for all the BARs, write all the iATU settings etc.
> > It doesn't make sense that some DBI writes (those made by ep_init_compl=
ete())
> > are not redone.
> >=20
> > The problem is that if you do not have a .core_init_notifier,
> > ep_init_complete() (which does DBI writes) is only called by ep_init(),
> > and never ever again.
> >=20
>=20
> Hmm, right. I did not look close into non-core_init_notifier platforms be=
cause
> of the lack of hardware.
>=20
> >=20
> > Considering that .start_link() is a no-op for DWC drivers with a
> > .core_init_notifier (they instead call ep_init_complete() when perst is
> > deasserted), I think the most logical thing would be for .start_link() =
to
> > call ep_init_complete() (for drivers without a .core_init_notifier), th=
at way,
> > all DBI settings (and not just some) will be written on an unbind + bin=
d.
> >=20
> >=20
> > Something like this:
> >=20
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -465,6 +465,16 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
> >  {
> >         struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >         struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +       const struct pci_epc_features *epc_features;
> > +
> > +       if (ep->ops->get_features) {
> > +               epc_features =3D ep->ops->get_features(ep);
> > +               if (!epc_features->core_init_notifier) {
> > +                       ret =3D dw_pcie_ep_init_complete(ep);
> > +                       if (ret)
> > +                               return ret;
> > +               }
> > +       }
> > =20
> >         return dw_pcie_start_link(pci);
> >  }
> > @@ -729,7 +739,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >         struct device *dev =3D pci->dev;
> >         struct platform_device *pdev =3D to_platform_device(dev);
> >         struct device_node *np =3D dev->of_node;
> > -       const struct pci_epc_features *epc_features;
> >         struct dw_pcie_ep_func *ep_func;
> > =20
> >         INIT_LIST_HEAD(&ep->func_list);
> > @@ -817,16 +826,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >         if (ret)
> >                 goto err_free_epc_mem;
> > =20
> > -       if (ep->ops->get_features) {
> > -               epc_features =3D ep->ops->get_features(ep);
> > -               if (epc_features->core_init_notifier)
> > -                       return 0;
> > -       }
> > -
> > -       ret =3D dw_pcie_ep_init_complete(ep);
> > -       if (ret)
> > -               goto err_remove_edma;
> > -
> >         return 0;
> > =20
> >  err_remove_edma:
> >=20
> >=20
> > I could send a patch, but it would be conflicting with your patch.
> > And you also need to handle deiniting + initing the eDMA in a nice way,
> > but that seems to be a problem that also needs to be addressed with the
> > patch in $subject.
> >=20
> > What do you think?
> >=20
>=20
> Your proposed solution looks good to me. If you are OK, I can spin up a p=
atch on
> behalf of you (with your authorship ofc) and integrate it with this serie=
s.

Sounds good to me!

Since you will need to also fix the error paths (my suggestion didn't)),
I think that you deserve the authorship if you cook up a patch.

It would be nice to hear Vidya's opinion on my suggestion as well, since he
appears to be the one who added the .core_init_notifier in the first place.


Kind regards,
Niklas=

