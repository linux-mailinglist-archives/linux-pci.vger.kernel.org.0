Return-Path: <linux-pci+bounces-983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1B6812C60
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525DB28268C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFC35F13;
	Thu, 14 Dec 2023 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LQMu7Xa6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A9muKhxX"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F591
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702547950; x=1734083950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DtH/s0cuUaJAEFHtqKZm0KSiarOCemfUJPFCVmZ615A=;
  b=LQMu7Xa6RyFWzRd7SGqtHA3UjPd382+Es4uEiS97y7RBP7p0gEVxZ3mW
   dMP9OG1EHSTvMLhJ74//BytTnaOeB0CYki1VkPmX2Msfs8pfRN9JLG5EA
   sWDp6jcuUc+k6wt1OgdhjuK2b3YplHomE51EhKhcsvVw2UnBa0S5PlD/E
   YQmcK6e8kqK3pTFF9D4GMYgbtUp1Woo0Sh9f70ie6NjJyp+IO/RRIi2Gm
   /vOX5faUO+CdWrXtkvYH8NRtVTqlJUFoe4DWP0uatoLdUHzmXaAXcrVBc
   0Ul/RGnSIgmOL/iRe2gQaSxZYmNCOZZD9ZIFE3aiq+LHJBb9cuwc8gvpK
   Q==;
X-CSE-ConnectionGUID: F6E2OforS1eNU6GjnmtD9w==
X-CSE-MsgGUID: ZSd3bDCVTEicTnj6e18uNA==
X-IronPort-AV: E=Sophos;i="6.04,275,1695657600"; 
   d="scan'208";a="4979671"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2023 17:59:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI7MBVIfK10DxKX4DcSAVRN+PKmVbSZ75/UUlvUzpLwm8GHQpjjny3RBAdvq5ExQFPseRTpZwgkfeV/9ha8OrKrX+cDNMkqMANKFJD/kzYGTv5kJHl+89U3cT/39b5AYszaEaVqSQNNUV8DF/qE9YvIThKPgeRC7YywMyOxGlFXMCDd97wc281bcnZFuWg1WK4XlBkhVVcjiTB7jp1yOmnXnhi5jppMWOc43KBvDdvedKdk3RXVT8cXZka+ou0grasDHTFevNSTYtPkjUCq+LSxtVHP5wRDZddIIRer72DvjYU+6XHwmq4YU9zomV8FoYF4v0ISu8et3bFWSo9uiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab258MfcnOfrV4xNPifcX6MvrOqLgnXu7lcfzjWxwA4=;
 b=H6lP7QBIStVnMt8AJtvEXcDDGMaX26n3sjrF8vRyUBuYGfceu9ri9Wrz9VKeLWTpjoerxdhIIJI6BkmEGURIbTF0AUCuMrqoVTju/NjQfV5NPTk2pwv/gd2RKVPd9jlm1XHrI74ThT7+Vz3TzHD3GXeXoaNljVn8NpsCrDhHogxmQu265IsN1X34KyO4/vk/aSr6Yn9FaajQm8ix/fs8w0auphf+x57pBhuFO8uRrQEO/vkPsN2KrfYsKiKbaOjRXMEa1UtgCyWjz/Wmda2Ob+KtikcS7T5co5qZtfAflppklXsmR4Drh/jVvRP9m3cDkaXVWqn8qi/60WoyjafxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab258MfcnOfrV4xNPifcX6MvrOqLgnXu7lcfzjWxwA4=;
 b=A9muKhxXm1bkNO9c7U83NVep2U2/ZzlX2h/oxc7iX03v7HzFs9fzLWzajfpfvoOLLSc6GxIzOd2LopwE0aYFN7AT1GLN+otVvFgnXQcwBQZm8yAfkoraeuQJAG8fpf0Izud+YXuSZ+fYoAJ8M0jx33BXeyZcwfklpX4ko4AIFo8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA2PR04MB7737.namprd04.prod.outlook.com (2603:10b6:806:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 09:59:07 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 09:59:07 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Niklas Cassel
	<nks@flawful.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Thread-Topic: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Thread-Index: AQHaIf4kudBIhbseTk2Bjk5ALRJekbCopFwA
Date: Thu, 14 Dec 2023 09:59:07 +0000
Message-ID: <ZXrR6n7MQIpAaVPx@x1-carbon>
References: <20231128132231.2221614-1-nks@flawful.org>
In-Reply-To: <20231128132231.2221614-1-nks@flawful.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA2PR04MB7737:EE_
x-ms-office365-filtering-correlation-id: c32436cf-6454-47bb-7d11-08dbfc8b4fb9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YBDyqYf/tykBU/OK+eDfp53+8S+XtnqLeLWZY/Y8PmsG71ViaLEqlxaksUreIKnauZvSBC0/Fkr+UOpWlBwc+qbEajiic0OCGl3I0RdpX6vVTQPcGqQ4TJ506M5pOUm8yURHQGcIPNuNqrWYsO1o66MlrsGUWdprsXwE7yo9rusTCnTlKQhWyjL8ibWJO30Q/HB12sHRodgxTtaHAwGebb+DCUN7l6cmZJZCOe9RbGnM+aDpUunterjSvnPISREu/q/rnCFS/cpDKTcdKXFBEc+YWoSc6J6qEFBoQQo+LkzREzEfL7ORwbbtITZ8e7kDHRMzya5CqJ5IYIGOR4+A4gPGmZf+vkVzAsSUThdzU2EgVuEAOey6PghKnh9t5b8aa+lM+zjznflBVJurdXAGF9QTgr0HajcpfgbXdAVWZnqmoklAzeFJL2zZIIzoJeEOPKGRV4Sfcya+snYLch4cMVOVNcnTLHVduANLXcIvdPIxuX+ReMychTtIHNuaTS6qo2vdopkLkeD8VL9Ew24/ErBWCM0XSBg3D2kVS9ZOJl2Hrvn+7WeBa056nWx0L0tkvOlhCEOOEL3l8KCHHJVBDmCDBKh75/rkJp/eO6WqzBjYxxheMt7vwAvs/IJ0eddR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(33716001)(86362001)(122000001)(38100700002)(6916009)(316002)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(26005)(83380400001)(5660300002)(4326008)(8676002)(8936002)(71200400001)(6512007)(6506007)(9686003)(478600001)(6486002)(41300700001)(7416002)(2906002)(38070700009)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?6A8PtZurco1uGpAW1/d18qLb5N26YSVPKjxznEdHE8Ca/SCxfN2EF0f+w7?=
 =?iso-8859-2?Q?/EtnH9vZzjPzKjbLk8cCmJsl9RsESLGefQnfz1775FeD3CYDp0iTdETqDL?=
 =?iso-8859-2?Q?Uj0mfFQ73HKlyQGa17zqKNctKMdv1tf7twhj5SaWVO/pmfeLjbHJe2TpRX?=
 =?iso-8859-2?Q?aWilZpnQlIl/I0o1synI0K/tYbhAZ68gRvYU/qPkrRr0CL01TMLdUJPlkM?=
 =?iso-8859-2?Q?j21flC4eLwCEg7IoaYIoj5WGC48sJRKFq4EDNWEFzvtwNAjqBK1Ojn+BJv?=
 =?iso-8859-2?Q?n9BGYyT2StDTPFBPXbRDtcm6ygVycoZDI0r34zsQafHRNttjQ/4L4z2U58?=
 =?iso-8859-2?Q?bASVbpCV+Lu5LL8Ou2YXmwP04ouVNLDzyGeQixMurPBPkn/02AVmOvMvci?=
 =?iso-8859-2?Q?ChlTPP0rq1EMRJ/jl9lhEeKRxl3tU3brA+ZAr/Majt5p2u1JbUns0PySWB?=
 =?iso-8859-2?Q?hkGLHiv32MxcJs2BqDH2iyNXCfDey60lQBAEqVVSYqApJHNVis6SXpMu6j?=
 =?iso-8859-2?Q?a6DIxSlerIRdtlLAQMEhbNuNtzpfAVdMnFxlh4QPj5R7wi9ZGbrdx/xsDb?=
 =?iso-8859-2?Q?X0Cw0CDhPNbuq5+Dm4uX4q32oKayjvZ5xSkcx9XW8RAyAFWOiEiHpt18pB?=
 =?iso-8859-2?Q?ddfMM2FDDJLxAQU5YOapR+hlCKW/Zs3u4Ptn+AmMwEqpkpHO5xaenh/chE?=
 =?iso-8859-2?Q?K/0XCIAap3ZOXkDLs6yUzqCEZkkdXeGqZGhFFmhmB29lI7/bypvIR65231?=
 =?iso-8859-2?Q?8LfZvSQrda/UZ5cG9KbG61XGF2NfIEA7WGMiT54NLsqDmc6Ue29VdbzM7K?=
 =?iso-8859-2?Q?S/3aifTqFbTOLGB33MQgaSrV8IkHJQ+bcGzxUdLJ8Zm0LFb7FtzzB8tDdG?=
 =?iso-8859-2?Q?d4pLLDIUqC45oOHPGjlEF/7fxnZjxAajuskrxn64NQmZg/bOTdw8esCPv2?=
 =?iso-8859-2?Q?P58jSOxgPOYO/q7UVft/1DjPJ2ZERh6eAcniarb8Dk8ucGznQEp7ntB+r0?=
 =?iso-8859-2?Q?vFLlFnCER6czOz1ftniYoQa3m1KdieoLt9E+e7qDNcdLlvA7OLErOee2QZ?=
 =?iso-8859-2?Q?CTheIbIAze5VvlZPDgML6hX2RyoL8YJYKFLfrHYjg5vLR1J3EpA1bUFxBB?=
 =?iso-8859-2?Q?vKHn5zHeQgHgYfN3sTtO5EHULY6rmOZAnCdvAONqCQYHRit1gCFR68pmPD?=
 =?iso-8859-2?Q?RtyLuzkRsTvbzRIrZhKNOfrBAJnyBCHBty7E8LpRmYHiucnm8wZysLp6/S?=
 =?iso-8859-2?Q?9KMmcRVrrQIsYpANsR5GM3g9wZCdvvGMEmPOsRoHcAgPUwHTknHd2vpci3?=
 =?iso-8859-2?Q?6+s0ZDcApdhw8PS7GS+NbAhPwVD53FJwaCouiZxF9Cc5KfkJdMS2zweC0I?=
 =?iso-8859-2?Q?mLPRIyuzTufn/QZYevrqgnRftvhaTlcrqPZwTwcv7JvNyS1pGusyaEr/wu?=
 =?iso-8859-2?Q?F0GI81i7Hz0Mt6AwfSjSziMeDPBE3hhAb5H8zpn0dcomh6Y8ToyfHuo7es?=
 =?iso-8859-2?Q?zhgrRSklV72+N/GZHoK3uAxlFBHFUGHzFjFfsXTFPabtEVsEiwKosfZL1d?=
 =?iso-8859-2?Q?PzzFeokmsLedBA5HwQ6jOploHOknNcwXgPeNENYQc+5aZC1la8xC2PDBNS?=
 =?iso-8859-2?Q?Vvfo1u26sOqvbn8gCwHVviyuLyLOuSYQaITCv8NakVPdjglfo1OiOKRQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <BA8645BB1247F240AC594309DDFFEA7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cu3j4XfSqXm89dr8RRj6ETKfW7gUz1CmQ1wQG1EDkzYIZ4ccCtTnZjiCMfb5E9UlEIYfa6z8KZjSblcO/n7pDDhmkyg3rHXw1CXPhFzDQEsCufGX9i8AEN3QbcPaU2F+bA2aQrZ1iQDapOSgmZCdVq7BiuSWrTOMyH0mCkqnmdS88ijAbCiuZnUqcAz6hfH4pgHWcWdRQjZwTEuia20hdJKgFim7Q9roxOtZ6ChYjXx4zqsxrr7uhadxiVaOHU/69p7Oe5kJP2+Q3PbsQz2XeHGuH4yLT51cB9GdZ/kFvNc1qo00j8jvOtvLicLLPSPjUJUkQPvMV5H3Iuc/lA9BBH8Mzapf7RihTJOsT6tN3qdKfbLyiCvpCutun1Q/ZnMygYfjVflOCjPbSOgWDEmLCRAiOI9sIZ/E5pj0TMOWLdrLD3aRlI/yrdXqh0oAvQJNdsaP0x/hIpSKH9YHuhWw8fwTYVmFlXOXQapFJHzw9vfsCIRhIE9iRdK0aXqJvvp1K9GaTCObPV0pu2QabOCLvq43Udyb8pUoACOw8NHI8rhrp68pDUIh05z3keTHV+c5byUU0PWgjNmQxndq/7rfrjlk3sUqXYy0PLr6uF7xoVHJwF78hRuf1xhFJqix8rxg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32436cf-6454-47bb-7d11-08dbfc8b4fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 09:59:07.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/7ILrLi2hEZDyzTkpCB+OUEy4JlQ0dSTepSQCMr6ygCiooVFeJl0mlLzK9/kExUcSZORTL7XEcXQQr2MoONCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7737

On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> support iATUs which require a specific alignment.
>=20
> However, this support cannot have been properly tested.
>=20
> The whole point is for the iATU to map an address that is aligned,
> using dw_pcie_ep_map_addr(), and then let the writel() write to
> ep->msi_mem + aligned_offset.
>=20
> Thus, modify the address that is mapped such that it is aligned.
> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> dw_pcie_ep_raise_msi_irq().
>=20
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get co=
rrect MSI-X table address")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes since v1:
> -Clarified commit message.
> -Add a working email for Kishon to CC.
>=20
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..bc94d7f39535 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  	}
> =20
>  	aligned_offset =3D msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr &=3D ~aligned_offset;
>  	ret =3D dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr=
,
>  				  epc->mem->window.page_size);
>  	if (ret)

Gentle ping...


Kind regards,
Niklas=

