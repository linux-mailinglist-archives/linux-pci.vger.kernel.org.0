Return-Path: <linux-pci+bounces-996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4A813325
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 15:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613722815A9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F240257882;
	Thu, 14 Dec 2023 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l527Rsi2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h3Ijm8k7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1985
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702564270; x=1734100270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6/LC/ottco4MVSU3In3tlCQzTlWYwZJy7ezRQ11I8Wk=;
  b=l527Rsi26jBNFYD+4f4mwRz5H3pCR9TKuyQFsZFhnzn5ZhfqPr+aEqtF
   WzkgO05D3S2cK5BLoyBbm5jN4IxgRDOLxaauUzCtliEYNPVjsbgYlRG22
   XR549BWzAW2OXRXLUYLtgqJy4hXSYk0ahaeeLSncnbCygB4U3UyuUkfJX
   mbzHCwP4pSgoWf5WOHK8MFvRdJWdcP5s/SsJTANDTE0tyt9nDQ9dEkBFk
   IHYOjHr/6bPBm+/ZpP6DLcGdjJamgt2bWoCiDCc6+CGVNQGvmyr0t4hHQ
   iiyKSWVhPgGtgWomOIRJM65Li+DA4+zz9htjUgcEVDWKLjIbpCnqw+wro
   Q==;
X-CSE-ConnectionGUID: AuTMnXBIQguQxO9nVsWMHw==
X-CSE-MsgGUID: VhCr5z4fREuH17/KHrXZFA==
X-IronPort-AV: E=Sophos;i="6.04,275,1695657600"; 
   d="scan'208";a="4997746"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2023 22:31:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0OLjR2PuitsjS70MKnoPcJxv3aStQVI9f78BRimK6bg/tLp2f1AkSx7+DE1aSXeROoDWLH/Pt8Z0AuakRl68bc1gra7avvY+S2P/uxlx1nkJhO66gCA6OgGqh1OSzZqR3gEtMbmo44lME/Q6CRXR551eM6za5cIjI0ztgVQx/oRrBBsAnDqPwsL1WfOu1J1XCtKpKen9oj0sxHUCMLr1GoJR23x5dkd/cGOBxPUblgCIT0jdzptJkL9ih5jtmKhBG0qE0EzymOGsXJeogYfhHjp9HzhNzxELUDhN4PnvMyuzdqIwMSyCWr+a6umD0V6aNInAzlpIJ4aDBXgX/I4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avu/HZIhIZ+rsdsMw4YMgDG5UTqLdD6NQjkE/LpCGCA=;
 b=Wo+C5gdTgiuhy5cFKDTqV+nYSPMMoMGn0+FpPTx2vlZzWZptfkBoRQODC9S1JDOLHtDWQeAykdTC/yfogMJ61UY+huAfpYNE+yDy/2HVwy1eR/RpmuDTCBcmvX2NWTcMKs4JBM8IGSmofqJxMpBY+WOhobU7NWh9Xxia/fafR8cGx2nzn36mEv7H83FyUO2Pld0guhgOxssNDiHWUTlHaMIuyDU3x5i5jAZvgbojQMe6zTol/0olnnW1dLvwRJSpXDFuf7IClVsFcC+Nkc9t2vctjRzmoYvbP+PZDwhMrkhwxDdftOX0o8nKFvmWNDalm9s0/kuJIDTsGR3G0rPMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avu/HZIhIZ+rsdsMw4YMgDG5UTqLdD6NQjkE/LpCGCA=;
 b=h3Ijm8k7QmprosjBi0SSuoxrwYvp58ePG8UNRgjvR0Q2zZEMOZBWvZRk7WTMWtXv20X6Qa+5nlJTGf3UKxy6p8nVHy5rmGMPglZ1BAl/4dI9H9hrWndZlqXYoGEJXdcaoqUnnoX4EMEJTnE4Fu5yGGrLLY6yg+um5aH35E2E9K4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7215.namprd04.prod.outlook.com (2603:10b6:a03:293::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 14:31:04 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 14:31:04 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Vidya Sagar <vidyas@nvidia.com>
CC: "helgaas@kernel.org" <helgaas@kernel.org>, "kishon@ti.com"
	<kishon@ti.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"kw@linux.com" <kw@linux.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lznuaa@gmail.com" <lznuaa@gmail.com>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com"
	<allenbh@gmail.com>, "linux-ntb@googlegroups.com"
	<linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar() update
 inbound map address
Thread-Topic: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar()
 update inbound map address
Thread-Index: AQHaLpoq6KpaLC8u+Emi7PiHDdomgw==
Date: Thu, 14 Dec 2023 14:31:04 +0000
Message-ID: <ZXsRp+Lzg3x/nhk3@x1-carbon>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com>
In-Reply-To: <20220222162355.32369-2-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7215:EE_
x-ms-office365-filtering-correlation-id: ad1f58c2-135e-44c1-a9b5-08dbfcb14d84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7gPSh0f9UKpSTWmUPF0716fJUB1Uhqwsq6pCaSgfPEvBIBfMSzTziqDRH+NZ1drIIUkR9v0MHt2Gf1UquB0Fc6DLZlkzwu2UDU2BJ+okLProjSXa7ONNvO+QcVtCCZTN/ZVX1pUr7VzmmQ/sTJUuMg7lebVOersYZmxsfsrLVtA8zjL0sHkTjZu7/+XQAMvLUcCpL8cDtSKyFYAhyl6GFxn8FH1gOXoNcOV6AON14Vkc4RztErRGRzA91adBTHnpUjOeYfXrfIZMEV6//AvOIY7tXx1BLIQOP2yYnPIe74bqv1NeG2880H5ncxcoLU5GPdODi0bOll6qmgAiGAFqQY2SLjmKDXvUpwItwlbonWq/emIBu2p8Vi90DDApI5pIdFvNN//bCDRqdEiaA91e7DY4Yx4PItFHQXJitzBMY4PuzJ4Xc0aoG8sYRM6Fy/MBwPBZ9CCHyqFF3kRf8lqigHr+eUg/tXvcmcO4vMUYzmG6t5yWNf+47TH5XaWOUzOdBLdW9vyUmXXvR3W1MXBKSoDX94F8xI604lBqMypW0n3wy2S7z9bCyZtc8M0fZw6x6QPuh494D8g8ux+5kbZlgUAnmivuscBtaMzxGvNkKGbwiZY/piB/3urvVsz9IF7y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(110136005)(66556008)(64756008)(66446008)(91956017)(54906003)(66476007)(76116006)(316002)(8676002)(8936002)(4326008)(83380400001)(66946007)(6506007)(6486002)(478600001)(71200400001)(26005)(6512007)(9686003)(7416002)(5660300002)(15650500001)(2906002)(33716001)(41300700001)(38070700009)(82960400001)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TF5dCroOOCDIWQp66eJNiCXGeeRq7U4PRkzZgZgxB8+qlyJ8b7ervQRDhon3?=
 =?us-ascii?Q?NxWm42DORUZ8Yf5h7YhRZTEM/xSrH3KQQJxCPugM4l07na/DIVv/7YqkDLQ9?=
 =?us-ascii?Q?OOW6sBCRf9A3IZr9J6objD/fvzB4qA/odmN1p15QzF+8HWP5EY/t7H+x637L?=
 =?us-ascii?Q?2viWj8Ws0Zc9Hdv1O12HidNXDKrH/OTzXDpOteSk0v9h9yZM6uNpyz7gMgAe?=
 =?us-ascii?Q?Qab6NVq5dDGhOH4lz9y89ndevNa8jvcOZKCljZXRWemgK60QUfjkdrFIe6nr?=
 =?us-ascii?Q?pjVyYdrgOXLHqkOYdBlS+WGOw4N838pwLYj5Rp2RYnhEmeEDf/JjJ+jIZt2H?=
 =?us-ascii?Q?I1z9kkLFyh3UuUm7n+bT1sPaKFTCfot7XmC+guAzxgutTPvYRdQAbujupt37?=
 =?us-ascii?Q?KBsFGpc/j5vVyvdbPsyPz4Iw+OKhwvOB9nsc3kkzVsrcUZKSD3wVpCBRc9tg?=
 =?us-ascii?Q?lfo17z9V/sAX/d+VVxRmPmQymXvHlcH6xHu6/t74Znn/KAgN+OVYyEoSByRL?=
 =?us-ascii?Q?qeocjn/Dci+0d5obKIcPxpdFF3BYCpY4Vlansou+N4ZL5byYXIKjmzwF9lTz?=
 =?us-ascii?Q?rMmMDDygYxh+CqV9NUVlrNwP9MyBy/bbHfrj1zVAUo74tcurD3bpkkQtr5Yv?=
 =?us-ascii?Q?0oFUZCz4GUz4xNNBF3QCNGPkNeeeb2zKRU6tcqxpEhLoWLcQLYxXTmSFJwyt?=
 =?us-ascii?Q?Eyn4YWdRO4atKu2orRL1epP2VCCs9xpJhaUMRxTYaemaycPET+5/MfW3CkeR?=
 =?us-ascii?Q?mEZLKLUDu3l2YV0eyEkQlFY6UPfxFCf/3hcRQalFWQL0VSdvFzRgbFJtfrEE?=
 =?us-ascii?Q?1lig6OK/EGIclF21iGD+AkmZ5pb4W+lakQVrWYc0Kg1rvFkokqdRDrWBx5h6?=
 =?us-ascii?Q?NnCHz1O8yRi6tj17KAYSezzRQChYMM7A+czjdBfzLPptpWnhz/qbViCkVYPx?=
 =?us-ascii?Q?eMaVNddG6OG3sYXUwrNjcRUtpDc/EMl9xeHjHhdhJb986JG+BrbZa13RYMQT?=
 =?us-ascii?Q?rsbodcSLrQ1gOw1qC+zcPXRq7TpkHB7c866deGZz8V7fttlRpRFaO0Wbxrw6?=
 =?us-ascii?Q?jbVbp0kjnPAlOoInbHzMCDF7YXxw4t97hQgXtLMzBOtDRh88E4GzL4gd7ELI?=
 =?us-ascii?Q?UDr4WmcPKsJkuykgKU3AqXrMF+Gk7pFtFXtipOMxADenpNIokEGtJinNTuix?=
 =?us-ascii?Q?otF6mYDIx8K3N9c1FlHLIHxYLdmH1SEvaDwTXrnqLVGnDaxSEIw+luf8QYoW?=
 =?us-ascii?Q?YPrj2MBlyIHlIcZjx6xrZq2etn2AbVAnfuSA+SeTxFpruldgym8G6mPhjnaV?=
 =?us-ascii?Q?fAiwOQGsxFkoQvqmZyxvtkJlmWBsUDvDo33+okenPIyHd5tOEqRRYPOTyvHW?=
 =?us-ascii?Q?kqxpdQUOOzzBeyL4pohGLdeYjUKmreKuBmGWIKSZDltC1CxpXtJtMRr1ocpZ?=
 =?us-ascii?Q?/YE1i6gNooazUeSsKa41OFqPEVPjG34w/5XsmxebEtNQx2poe9dtjJUcxUhh?=
 =?us-ascii?Q?wm+Z6Q3966xpP1PIXYToiMN/g0oJs/cjtVcsg5uHrlvm+yEDdV9qt4kIGBYS?=
 =?us-ascii?Q?xciFsu53274MDN314p9c5kWuf0q5OUzzAiZ2DqnGusKrErEuAVMMkPOMu5jO?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <947C8A43255EA8488535CDDD9231B988@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HPpSqx9iF7f6M0qDnxIEW/PohRCpxsZ5piGs1CBEzcV9ikTPTMKgERLbnhxsnQ3ihYL5qernjD6OU9v9ycPs711dks2unnwkB0mPOqHF0qupwujVAujHIYxwg5Lz6CTUr4hRfOhwRbHfhP43XtWORCh4jmPBArBdFg0bdkBq7XpuL8lBoCqwCUh9Fh3gMu2xAM90FBJfcM/cF3RVK6gZO/tAhY9I9OZ9MNQ2g+vYCGQb5IfQjQphmWkyd5lAJ9nXPfFZnrZ2AS/vcRtR6jNAnmgn8UMlQdCub53kLCR+7VhLRiwzrfdA/SlAlmdtmZOHriRA3K4myWrmINHfQ9C1HK5Ygww8fyKDivfDEz8+gd6z2oJKt+Q8MW7kTMZs7r5N+uFQh4/S5PD7lnb2MxjG9K7Tknnwz0f6PtSkGo8DMluIeaPIQpazHdV/YR/bxcHMArUkVJC7CB95td//+3dHEq9dcwhn8bsAtCI5zWgEqkXbGsKKjwKeNcKZ+fD2TytIz42HRpiE/nzugXWMn/UbqDaLODbTibxgE+OTT9xUA7AmAO9/M8uE6eOGC5dJh8sfgvAO3cyJaJNxBhJpAuevO+pkVERcjmDKf1A16KCiYt2D6KhL5BjhsErSN3Yrp4cC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f58c2-135e-44c1-a9b5-08dbfcb14d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 14:31:04.2629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYj4aHbNEktYhqw+8oPhMnhva49tAaVkUVBt/LHsVjv7r9e+vXGmLNaudR25MdaqTHxN1bdsgtVLegIyn4jjpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7215

Hello Frank,

On Tue, Feb 22, 2022 at 10:23:52AM -0600, Frank Li wrote:
> ntb_mw_set_trans() will set memory map window after endpoint function
> driver bind. The inbound map address need be updated dynamically when
> using NTB by PCIe Root Port and PCIe Endpoint connection.
>=20
> Checking if iatu already assigned to the BAR, if yes, using assigned iatu
> number to update inbound address map and skip set BAR's register.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Change from V1:
>  - improve commit message
>=20
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 998b698f40858..cad5d9ea7cc6c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep =
*ep, u8 func_no,
>  	u32 free_win;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> =20
> -	free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows=
);

find_first_zero_bit() can return 0, representing bit 0,
which is a perfectly valid return value.

> +	if (!ep->bar_to_atu[bar])

so this check is not correct.


For platforms that has a core_init_notifier, e.g. qcom and tegra,
what will happen is that, on first boot:

BAR0: iATU0
BAR1: iATU1
BAR2: iATU2
BAR3: iATU3
BAR4: iATU4
BAR5: iATU5

Rebooting the RC, will cause a perst assertion + deassertion,
after which:

BAR0: iATU6
BAR1: iATU1
BAR2: iATU2
BAR3: iATU3
BAR4: iATU4
BAR5: iATU5

This is obviously a bug, because you cannot use:

if (!ep->bar_to_atu[bar])

when 0 is a valid return value.

My proposed fix is:


@@ -172,16 +176,26 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *=
ep, u8 func_no, int type,
 {
        int ret;
        u32 free_win;
+       u32 saved_atu;
        struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
=20
-       if (!ep->bar_to_atu[bar])
+       saved_atu =3D ep->bar_to_atu[bar];
+       if (!saved_atu) {
                free_win =3D find_first_zero_bit(ep->ib_window_map, pci->nu=
m_ib_windows);
-       else
-               free_win =3D ep->bar_to_atu[bar];
-
-       if (free_win >=3D pci->num_ib_windows) {
-               dev_err(pci->dev, "No free inbound window\n");
-               return -EINVAL;
+               //pr_err("%s BAR: %d, found no ATU, using first free, index=
: %d\n", __func__, bar, free_win);
+               if (free_win >=3D pci->num_ib_windows) {
+                       dev_err(pci->dev, "No free inbound window\n");
+                       return -EINVAL;
+               }
+
+               /*
+                * In order for bar_to_atu[bar] =3D=3D 0 to equal no iATU, =
offset
+                * the saved value with 1.
+                */
+               saved_atu =3D free_win + 1;
+       } else {
+               free_win =3D saved_atu - 1;
+               //pr_err("%s BAR: %d, already has ATU, index: %d\n", __func=
__, bar, free_win);
        }
=20
        ret =3D dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
@@ -191,7 +205,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep=
, u8 func_no, int type,
                return ret;
        }
=20
-       ep->bar_to_atu[bar] =3D free_win;
+       ep->bar_to_atu[bar] =3D saved_atu;
        set_bit(free_win, ep->ib_window_map);
=20
        return 0;


>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> @@ -244,6 +249,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8=
 func_no, u8 vfunc_no,
>  	if (ret)
>  		return ret;
> =20
> +	if (ep->epf_bar[bar])
> +		return 0;
> +

However, here you ignore writing the settings if (ep->epf_bar[bar]),
again, this will not work for a platform with a core_init_notifier,
as they perform a full core reset using reset_control_assert(),
when perst is asserted + deasserted, so AFAICT, these settings will
get cleared for those platforms, so they will need to be re-written.


>  	dw_pcie_dbi_ro_wr_en(pci);
> =20
>  	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));


Kind regards,
Niklas=

