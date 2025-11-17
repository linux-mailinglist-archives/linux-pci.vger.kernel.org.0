Return-Path: <linux-pci+bounces-41361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC56C6277C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 07:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA1BB4E042B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 06:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A62D6E59;
	Mon, 17 Nov 2025 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pfso8JL7"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A113A244;
	Mon, 17 Nov 2025 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763359540; cv=fail; b=cXILi1F93MCIz05VDXbYqcjlKP3LBhJa0O/YXbnUZ645Ze5szcWjPlzxgWgdUA1N+0TFMeo6gJDuxXproSWU4mYe7LRff7/JVMMdvrgiHzDRgzPvBsxT0GJQuifl9rTc+weYh+oiriGyCZs8Df3H2qeK43xmRIGvP4E3bZbSB7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763359540; c=relaxed/simple;
	bh=E9ZnQhG37GcZDzWD+zWF8Y+gkqOE6QIDU5laKIEQmU4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhcW0A/LQtI8MAzjP14mu3lrz/Ldb54ZIlVwwl7ZVoBrAanZ/G/oOHxn6lxDrALZUXHCJ+nAcsBD/dXlKz0Pbeu1g5mcyYorqTrlsPycNpDCJdm4L8pZEdLVww+eJv1BiqDG8dc0iH89J/PpYdXZrN4cnyzR76Zb+M8V9PIl/Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pfso8JL7; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnB5YeAKbV+Y0XOJoFdgSh5ki6K5BYSWiNavUQj/7HYaZis8MDzABIvd3LFpLlty8NRFJ5p/VVtkQ5OTcwxi+A5LqvEU98XYiGrdQYcKQ3KsD4s9UbWnuJuEAzCDDgTW1BAIcpRT+DL/UWcdpj+vHsggHJVL1RfqOpXW75H0swGZ2Z512wr58Si8Vt5OkmgVn32S0DpRRyv21YNPnZb42Tanb0vmK+vuzo7WOT+TRzmg2pB3Qxb96NxSY0s6NXaECHnnWtGIMCCmQZ1X4NLDUWOHUedCvwnIlaScuFHen+D/aIa4EP7cA5+hoKBjZHNoou94hqH4gohm/O1WZm8v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocuMZLpR7EXX4WsxIqLjbkvYJmAH8X+xQWSt5ktxEV0=;
 b=onfBaQdlGuzyCIMoYJr7qaEbBcAmpwiSxIgH54DCOFOfvkLnItMXljwB9bn1yb0yfJSIxKBmERNuz/Og5b+Jhd4DP4g7Xl7+5s6PMW2FgAwWOfmTWBOTpNDwHgpGSrHGOs5U0IonQFbOWT45KNk/LGBmGX34J1ZAwPYi1BSCaTTqWF+/sZW3ermjGLK/p8loAXQUpCxrftOROOhzlGlEmB/tWWLkJNl9Podq7OSmP6xbcJJ3xTvzDsp63DnjXlRZ2c/GjLh6Eo5gW+7XYmCm/cL8xQFYb5LEjwPnYfhNien8gAXpDf61Anu2TRjGnd+Abe3W3DJ9ppptujZIbNYPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocuMZLpR7EXX4WsxIqLjbkvYJmAH8X+xQWSt5ktxEV0=;
 b=pfso8JL7Jrlkd0GcBB8nJPsAZ3wkcbwIppKlAPwx7SonppCe7Bhvjo+unvr/jSfjq3oCmlI+bavrLOr6MF3QHY0caiAz9HvmYqpS/KgJj2SKQItSfvV04yN1hmok6ZBH+pcqx8/HCAS5uEnR+gqVipOJKtw+3CGy8VHFSyvefJw=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by IA4PR10MB8470.namprd10.prod.outlook.com (2603:10b6:208:55f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 06:05:35 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::66) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Mon,
 17 Nov 2025 06:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 06:05:33 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:05:26 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:05:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 00:05:26 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AH65MoE1980137;
	Mon, 17 Nov 2025 00:05:22 -0600
Message-ID: <7eaa4d917f7639913838abd4fd64ae8fe73a8cfc.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, Rob Herring <robh@kernel.org>, <bhelgaas@google.com>,
	"Chen Wang" <unicorn_wang@outlook.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Mon, 17 Nov 2025 11:35:39 +0530
In-Reply-To: <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
	 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
	 <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
	 <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA4PR10MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: e3dbc5cb-938e-44c0-262f-08de259f51de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|32650700017|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWVxbEhnNzdnTkNrd3hITXQwczQ5ZEdYby9SK2llaWxpOU1HZ3RBNUgwbVE5?=
 =?utf-8?B?Sk9oK2ZvSVNybm1QeXhSMHFJUDNLQ2VxdFBjTm1FY0dzZzRJYmRiMTVqUDhJ?=
 =?utf-8?B?RVgrRnJINVY2K3ppTDFnYWVXa0FSSS9wMHN6azVlUlR0T0pBZ21SWXhNZ1g3?=
 =?utf-8?B?MWxpcnc3T2p3UFRyRkg4QWQrYnlXZmZmY0VwK3F5UVpPTFk2QVBMOFdVMC9m?=
 =?utf-8?B?N3lmMjlSYzFVSXFIclNPTG1zZ0Z6ckVoQlZVT0cwcW1NVHp3aEJhOC9DeTIx?=
 =?utf-8?B?Nm84SjRvTU1QZmJYVEVmTU9FaS93NUlMbGZDbXV4aUNYTXcvUnZWRmU0N2hE?=
 =?utf-8?B?TDhOSmJpNHhTanA1WmFCTDhPODNUYWFXckNHUFNoc05XalM5N2lGbW83OWN4?=
 =?utf-8?B?eGJKWGVTczluTE5lc2tVM3lmWG5RcmZ2SThqbDVRVFBoQ3Vjd2FPNjluRVZt?=
 =?utf-8?B?MVd3S2F4cEtBelRrR3I0SXM5UzhBSy9EMHdMM3N4L2ZWYXBJdFBOVmRnSTVo?=
 =?utf-8?B?bHdmMzRBY2djMWtFY2swSFpiMm9jWkQ0NHJZNlhZVlhiR2FPZVl3RUJlbnpo?=
 =?utf-8?B?dytUWitPbTJ3enplY3B0SlRBaUdwYmdxV2R6VUlUSWpjOEpSTTl1cWo0N1V2?=
 =?utf-8?B?U1dzLzFGRmdGODRyNDRROGdNRzZZMWRzZU9za2VvNjZyN3F5SHVDcVpOb3FH?=
 =?utf-8?B?ZmxkRVJ6cld3d3FFYytQLy8rbWxMVG1PR1hzNGZSa00vYTRIeXZPaDJWc0RT?=
 =?utf-8?B?SHBmLzB5TmI0YUN2VHlVbGdVM2NmRkw3bUJ6Z2FDbjFVZHZoN0UyRVFZVUZ4?=
 =?utf-8?B?UGRUVnBvYXJuUytPVlZ0SC84SExFclN4MjZLVVFtVFNnc3VTa0xWYjVqR0hU?=
 =?utf-8?B?V3kzSjhqZ3hqcThlY2lKbjRmSldJdSthZmdobXBKRG5aTytocjBGUGlsbVBq?=
 =?utf-8?B?eUM4WHlwd25GUHBzd2RpQURPMGd3Y3NPRWtsbXBlc2NRbzhqOEhvaFR4OW1w?=
 =?utf-8?B?aytyN21FTDZSOFVNcFFUWVFJdG5kbnBXWStTYUFuNUpwY0wybTFod1QweThx?=
 =?utf-8?B?dGhmc2oxZjJlQnBEeTM4RFJha01kbFBFL2xaMlVOdEp1YlFhYTJ0MGJObEhR?=
 =?utf-8?B?b2JPWkZDd2w2ZVBqVURva0ZqVWNyRThKcHJXMEMraXFVQ2JFMUpJR3NQN285?=
 =?utf-8?B?TzJ0bUFlbmpRRnFOMFIraVNkaWhOb0xWWjFoMnV0am9iRk5VZzVUQU9Ub291?=
 =?utf-8?B?NDM3RDJSMkJGY3RKV0xHb3ZmamRodyt4NmNvMEpUdWdSd3E2eHBLbHoxVEJk?=
 =?utf-8?B?STA3aXh1cmdITFdRZGREMDZjREVRSFY3UUNXK2lHbGFkQWxodnUwMVcxUmZ6?=
 =?utf-8?B?NG1ZYlhlbkVXR0dpOHlkajZuV2RiL1REMm91MTZEaDl5K1FuUGcxQnhIOUFy?=
 =?utf-8?B?SGhGRXF5VDkybGhpbit6S2o4dCt6ZVZBaC9nQU9yVWJ3K1JoODFoaWdab0JX?=
 =?utf-8?B?ZmFpUVlpQS9ncjg2WFBJUXNRaFJyVk9uSGNvWkNrSXFtTEVPV2VOZ0hRd2JO?=
 =?utf-8?B?aS9hUy9pak9HUVlhMThDTkI4bkxNUkJGbFJJVlJydnh4T1g5RlROQzJrK3J0?=
 =?utf-8?B?SWpqKzdwOEUraG05czhwaC82WUdCMWc2bHVjcHFERG5BcUJjRkNuQWFKTkdV?=
 =?utf-8?B?aE52YjVlczBOZ1I4T3RneGlQNmdNbG9NMW8vbFlvREg2eWYwaEVpZ09ERUk0?=
 =?utf-8?B?TkROSUI3bU11SXdpeGJ3anVjQzJJTDVTSitEeXg0S0Q4cG55WmNJMjhmdllX?=
 =?utf-8?B?L0xPTE9QeG53L2JqcXlTcG0rZEFnUjJhM20xT0Z2QnJra2pYQnFwQnJHTmtD?=
 =?utf-8?B?TlNVM0RFQnRaZHFSZ2swS2xHam5qWno4MFovOUQ4WlJCazVhZGtpU0RySlhB?=
 =?utf-8?B?Nk9mdHNOSE1jMFdub0phYzNaVnN5SHhFUGFwemdsMHlMLzdSZWo0NFkwMUpl?=
 =?utf-8?B?N0J3SGN2QmFNMEhOV1JwZXZnMlkvNS9kMm0xbzJyUlB6dFovL29FR0VCTGV0?=
 =?utf-8?B?RDh6WTJheVgreHVRWEtYTVh0Y2VBelVRQWlWd1R0azRDMThxRDB1TVdHUk5K?=
 =?utf-8?Q?rtFw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(32650700017)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:05:33.5471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dbc5cb-938e-44c0-262f-08de259f51de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8470

On Fri, 2025-11-14 at 08:03 +0100, Arnd Bergmann wrote:
> On Fri, Nov 14, 2025, at 06:47, Siddharth Vadapalli wrote:
> > On Thu, 2025-11-13 at 11:13 +0100, Arnd Bergmann wrote:
> > > On Thu, Nov 13, 2025, at 10:27, Siddharth Vadapalli wrote:
>=20
> > Thank you for the suggestion. I think that the following Makefile chang=
es
> > will be sufficient and Kconfig doesn't need to be modified:
> >=20
> > diff --git a/drivers/pci/controller/cadence/Makefile
> > b/drivers/pci/controller/cadence/Makefile
> > index 5e23f8539ecc..1a97c9b249b8 100644
> > --- a/drivers/pci/controller/cadence/Makefile
> > +++ b/drivers/pci/controller/cadence/Makefile
> > @@ -4,4 +4,6 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) +=3D pcie-cadence-host.=
o
> >  obj-$(CONFIG_PCIE_CADENCE_EP) +=3D pcie-cadence-ep.o
> >  obj-$(CONFIG_PCIE_CADENCE_PLAT) +=3D pcie-cadence-plat.o
> >  obj-$(CONFIG_PCI_J721E) +=3D pci-j721e.o
> > +pci_j721e-y :=3D pci-j721e.o pcie-cadence.o
> >  obj-$(CONFIG_PCIE_SG2042_HOST) +=3D pcie-sg2042.o
> > +pci_sg2042_host-y :=3D pci-sg2042.o pcie-cadence.o
> >=20
> > If either of PCI_J721E or SG2042_HOST is selected as a built-in module,
> > then pcie-cadence-host.c, pcie-cadence-ep.c and pcie-cadence.c drivers =
will
> > be built-in. If both PCI_J721E and SG2042_HOST are selected as loadable
> > modules, only then the library drivers will be enabled as loadable modu=
les.
> >=20
> > Please let me know what you think.
>=20
> I don't think that the version above does what you want,
> this would build the pcie-cadence.o file into three separate
> modules and break in additional ways if a subset of them are
> built-in.
>=20
> I would still suggest combining pcie-cadence{,-ep,-host}.o into
> one module that is used by the other drivers, as that would address
> the build failure you are observing.
>=20
> An alternative would be to change the pcie-j721e.c file to only
> reference the host portion if host support is enabled for this
> driver.

While 'pcie-cadence.h' handles the case where 'PCIE_CADENCE_HOST' is not
defined:

#if IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)
...
void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
...
#else
...
static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
{
}
...
#endif

the issue occurs because PCIE_SG2042_HOST enables CONFIG_PCIE_CADENCE_HOST
but it is enabled as 'm'. As a result, the definition exists in pcie-
cadence-host.c that is built as a loadable module which is not accessible
by pci-j721e.c that is built-in.

I understand that the solution should be fixing the pci-j721e.c driver
rather than updating Kconfig or Makefile. Thank you for the feedback. I
will update the pci-j721e.c driver to handle the case that is triggering
the build error.

Regards,
Siddharth.

