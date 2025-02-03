Return-Path: <linux-pci+bounces-20650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FCA25273
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 07:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49D03A4BBB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 06:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD11EE02F;
	Mon,  3 Feb 2025 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E6bJyhpG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D971D86C3;
	Mon,  3 Feb 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738563838; cv=fail; b=joYTo8a1NNRVbkQ3cUMSuR5X7R69mhhQ775xcgkvlVzJLl1evWHDMHKOELjb2au8pkMuGt8hLBEKBjITAVA+ZLZxoTy/cLCLRlJqYTk9E6qxSno6ss0LcYt7O2/erCtLiuD2MoF/vd9Z7eEsk9tJtE9JO/T3ItpfiN+R4LjO11M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738563838; c=relaxed/simple;
	bh=d9WU5uwBHZ17Xbc88aKG8KFv+o/+jErY9yTKP99PWlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yd06vtWeei4fYB0JuWmGuk9HLMNlgovS/lScAeIjeKknIj0+nXXEftyWieRAIaUbXhZNtIPnrpg2RnibBLGJ6n8jc85UZklTO8aEzcc1zM/EjHx8/hIfygS8fCgiACo+wjS+A34IujRYR0FBqrE/NOld91Ueqx/27r8v7/CnslE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E6bJyhpG; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuAbjey18R3Ess5JZLToAP9Ixg/R11oiFvE6kXagDnwQ2IueJfuq7qDjY+y64+hNpaakRK6MgYKokH1ICfqqAG5jo67iFRXkwlLXtzPGuRSY/U0CXCHBD0PwlyAWFmUUI5xYalMT7V7n1sw918RQm6+jUQlfuaFeUWWCwrMoDA9Pb07ODoFj9Yxy0Kp2veOAjXyGX5vXH0n57cgn2lCTALBgAaAXO8mwVe71KqaIVTYdRY77U7NQG6WnxF+XQi/2uXZSiU/BF5vHb6BSeuUA3+4XlgK2RyNsSMmOEnOIjJLBBdfDKOkMibKb64r7zuluTGMN+JNzmBToPCiSBkfvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFjcg6AqiayI8dfJDT0laaokSxEhnwsy5H0K9aoi2lM=;
 b=j4ei8jNUuKXWnbW8MhvbXv1rxq/CKH+2vXPGo/FkExhfuS3OWBx3wHK6QS4d3cCSXbkyNajF/ehp26yxThnFfjSeSCSJDtg0aT7afJ8DImoxneFBmUR4d6MKHBod1YSiybVxh3dImP2nobY63nnuqPiMF8jeicwu8OCLyS2SY5sG78GHzbQWoeU0VMHNvYhWkUo2KXfl5ERHkvJZmtPV7hK71/77nwdK6A43DhTLh0r/WvNwGZFFnt0TT7Ga0Yhx1qgs98ddrALXtEsel4G9CW8gLcq0tFLrfFzXvchQUJlLqTSEQM6NFPJdHtsr8irE4C1oYztiujktYONDOou9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFjcg6AqiayI8dfJDT0laaokSxEhnwsy5H0K9aoi2lM=;
 b=E6bJyhpGO0Tgro185Y1eUeROWqAY6hlEslZv8Elb6Gj46+tOt/HfV+qTg3miQEHY1M3hQA+go/cfp24kdx308D7bp2505hQH54lYM2MfKQuucqRLpSU8Of1MeIVXNAKB1CwGb1+JEcG2ySFb9QskLg0+aGPHknS+oPuSUNaO/Zk=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Mon, 3 Feb
 2025 06:23:52 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 06:23:52 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbckFGnEXox34FgUW7RyRWX+Tmz7M1I7Fg
Date: Mon, 3 Feb 2025 06:23:52 +0000
Message-ID:
 <SN7PR12MB7201E9D78AC6562F7A333D338BF52@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
 <20250129113029.64841-4-thippeswamy.havalige@amd.com>
In-Reply-To: <20250129113029.64841-4-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|MW4PR12MB7288:EE_
x-ms-office365-filtering-correlation-id: 21df5801-7097-49b3-4ee7-08dd441b5428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Vq8kkLWxpRoOC++t25MdDKKB0BIMIbQwmMogv8O8lsPOBwX2YU17wp60K+HM?=
 =?us-ascii?Q?TERZud7TxIsoDDcKpPT3VkUC4HSS0EFiWuapq7BIrAlo//GopWW79QY2lfB3?=
 =?us-ascii?Q?aMbrS1EWrwwtFsodjmeMbMpNMhObeM2mGH1MsbOiibA+NpEu0CUS/owzYgMJ?=
 =?us-ascii?Q?9TgSlCPJVD7yQIISs1kSn8+NgzIpxyBNdNQ8vtHQC14v5swvH2kbmTvovpaC?=
 =?us-ascii?Q?rTRuIhYMN9WHc5cf3nmTULddgz5rsIp+L7RU1I5OV8V6z8yJNvI3GBFj3G0Q?=
 =?us-ascii?Q?VI0yeTTFVOV58Xsrefkzh5h4FhVHzTEQoMbZ5z+9eWXFsNhp+NqeGc3uFUNF?=
 =?us-ascii?Q?jk4oi2JZRt1JnrZnHYEWaKLA+vum9OBgPdP06XF70FtRIeUPFC2ks6VTUE6X?=
 =?us-ascii?Q?PdulRjbx/K3ozHf2LSucMK0DgjdigmLeOLe6q41VJMQunHjAmDIFMTkFeZDr?=
 =?us-ascii?Q?jKsVfc1+QiQ+O9Po6LC3FDHFgshuwkHK5vLL3Ob0TsDRlPs4xxD7K/53960M?=
 =?us-ascii?Q?JkjavUkdRyyrhBioD8l4neyKT4nZ/dswS4C6RWWEGJIfmvD6uZp0qmpSyAo4?=
 =?us-ascii?Q?miJpUT6I0Nf31P7Mo97vMVWodpdAgoT7sl6Widurnfkq/vzjdDc9jsJLDoZT?=
 =?us-ascii?Q?yYauZb6BQgDT2SMhGsngoW8elODJjiq8zXCWoK6lPl/ETXngb0fJMB/I7GaQ?=
 =?us-ascii?Q?pjKEx7oELMdCUUKpSYTEwdex8sl13Ska29tADOteQXxzl4K8QyqSCN1U6gkp?=
 =?us-ascii?Q?xAcMmsEPGi0JyYLFW/TAzzgnnejKph/Alx9gUWTUPshjnCzzYzEsam6PtGcw?=
 =?us-ascii?Q?8/lO5VisK3esXnxP2ZxnM1K99DXw36iVjsZoKh3GguEZcfui62uQ/733vzsG?=
 =?us-ascii?Q?ecguplq68wkOSBvQiFLSaF28AScsNctjN0lKSdL50ziJQeQ5zC4cDMe5N8BA?=
 =?us-ascii?Q?ZHhHPjYlgGXZ3GbQsX1ZZG6geNjliliFmQuN5yOqjiu35ZlWB16vENGO2IW/?=
 =?us-ascii?Q?M4fJMYo/QxNwReBen5VUPwjp/PWImWdOG4E7p0KUiSOiOyQ5A/F8A+pbRnWb?=
 =?us-ascii?Q?LrIgMb2do9IgEYs5V3ajnlYD/FNWGbA1OHKgAaI3BIMzALjOyNhE8YhYz+Nw?=
 =?us-ascii?Q?3t7NuN4mDqjg1OE85cogFKmoJkSSOckvnK1Pfa3dayIMThmjkQRxq+JzoSEY?=
 =?us-ascii?Q?qKLN5IwjOJoUsIoiOfobKFKTp7w4XGdPPLn3hmgMuI8BYeH0xlTzbdbbjTuB?=
 =?us-ascii?Q?Zg07ScZjG0n45aFcl1v8gVICeq8xdwY5F11uG4lze1At8gLnT7AHA06Fpyvl?=
 =?us-ascii?Q?aZ5n5M8+HtLLNFBgeUTimSvcIiUorks+eNitQTyf3xL4hKFj9nL0UD48JZ8Z?=
 =?us-ascii?Q?m238EjI+tb/sbQ46k5XjtF2176JRJhR9J9Q+36DqZqu1elCwFVFm+HKYPuOl?=
 =?us-ascii?Q?/FzpJ7eYZkObN2pHzoRZfzvs4T0rYxSP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r7y8ixraOq5PsU9rxR2pxjPMsxoL8jtUcjEmeTVFGyc5OmDKMs9s6xn7YnNk?=
 =?us-ascii?Q?WkInAtte1yi4qyH5SCurzACFn0QO9mYbgMAj5oeTbwj8lB2O7Y+o3buVJv7t?=
 =?us-ascii?Q?6ZEbJztY/rSZOczZ7/r2r6mMepFXkJpMlhVggS2+P8uQXqBGWB1HuJFps0f5?=
 =?us-ascii?Q?8duPvYsklWq2/vE/dSjyokhpaTh16tkQnQVIObkflnq+4HcCBOW3aTB0givh?=
 =?us-ascii?Q?jYRpcc3Helcqx3UU/NFcxfFrVs4XIka8VriiPMKjKjSN2vbAUjTn21uXPQXg?=
 =?us-ascii?Q?0JO7zKjA5TiV5cywl45EGyz1AON2+geN3wtJ/mxalLPh8z8Fujwh/eVdMoqQ?=
 =?us-ascii?Q?lXN76x69PW0sLVQAn7sDSpvV7Zmsbe8uOpxacCipSUAV5Z5w1R7yVQqRDB9R?=
 =?us-ascii?Q?884bTcXNtBruxHVVjh3nGd0Y/LBevGp8np0OSm3GHhrlbnKJbSO+zm8HgtUO?=
 =?us-ascii?Q?0XOuR/g6LimH3ZxTUEkgXlGy3Z2qEa+oWxzzJFMqYkKf/v4db734wjfF6qlk?=
 =?us-ascii?Q?8aP6I79UQwam7fhhLLjzalhe9yzdIbll/tVaCsDZRvR2z2wZRlAn10KV8JeT?=
 =?us-ascii?Q?LsBGBhtt4PdYsCKbOS4jV8oxvXa+R1tNGRnMr9H46pZARJv9VaOJYGs0DjaN?=
 =?us-ascii?Q?qy+CToHpuyfcBS0e8AIm9MzkXXCDYvuNa+QmiA8KBDSDWgsxpltQTcF03B4w?=
 =?us-ascii?Q?ccvEOAJYp7bjFnXRTaaWCRH31Wgp3sN2Nvbs39TN5QNeN9fPpQeraVwrKbt/?=
 =?us-ascii?Q?15LWWeaJuahe1M6KjhFHvUTaQuYf64BlntWZV+7lFBBe2XYc8nCfQQPn6++T?=
 =?us-ascii?Q?UWdwOWnlnRBbl5iY0YyI/rx0BsRghccp1b2VEL8TKSQjt1xYE0z9XLzItj1T?=
 =?us-ascii?Q?SSSM/zVM3oYb2UUIXOOE3e7ZGII7f7KFps3PaynbcS3E9pGxsvVdRWnU490z?=
 =?us-ascii?Q?S3ZsMr0ZYx4eCqrpEwTEMEP+g77V5Co1+xc3gifpDKqLNXKqfsQ4mC6n+LqP?=
 =?us-ascii?Q?DqAnD6mYhLWVv3HF6HU9K3UIgcpRrqSl4w84Ol5cVGMeFyj4O7Ppu7/KZ7nB?=
 =?us-ascii?Q?YTRdHsMIfDCy6lGKdoxKwAvk4Ej2cRar6DLmNwpxZMzyzSHfP/iP4UOj5Oo+?=
 =?us-ascii?Q?vl+th9qq+6e5BgTsSYN9VW5JZERLn8nO3IFGNsmsg8Af4QlywixqC0D+KuWi?=
 =?us-ascii?Q?bS49Eq/jj/upwWE6zcBBcynSz5t3mnNbZqxmZEhM4cvWQGtazhVkXXbrkypO?=
 =?us-ascii?Q?nbPKNHuTQKMvP/6Yp1MZ33mkkaUlv+JFMW+jvqN48QDwli+k9yqV0OLchKj7?=
 =?us-ascii?Q?LZXb66fY1wF15/9kxVm5XYMpvOadoWrYD7vE6VQUT2iJ6+ejQCAflaVtZXEW?=
 =?us-ascii?Q?R6sqeFuRdCtosTz6jN9z0L2sjnn0TM7A/iIIUxvoeUXu0Orc7boWdUaMHuAn?=
 =?us-ascii?Q?hXTM5ikuqbqUZ46x2SCpcgY0/1tv8jtabow4Jmu3c2VABczn/VlacGKRuNwP?=
 =?us-ascii?Q?eXWkdNP72PUBL2ONo5owDfKCaYxRq1GXAxFduUkgCAYQ5YjMq8MO7bwxOieZ?=
 =?us-ascii?Q?n4/xBO8FFmGAN9i3MxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21df5801-7097-49b3-4ee7-08dd441b5428
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 06:23:52.2896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMR+grSrf4ZAXXJbQ96ixk+DsKKWz4VPf8hFX1vd2V2+vW3v2Y004+zS7lyHZ68S795SQOus1zmHctBLNwvnJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288

Hi mani,

Please is there update on this patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Wednesday, January 29, 2025 5:00 PM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
>=20
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
>=20
> The Versal2 devices include MDB Module. The integrated block for MDB alon=
g
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-Gb/s operation per lane.
>=20
> Bridge supports error and legacy interrupts and are handled using platfor=
m
> specific interrupt line in Versal2.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> changes in v2:
> -------------
> - Update Gen5 speed in the patch description.
> - Modify Kconfig file.
> - Update string _leg_ to intx.
> - Get platform structure through automic variables.
> - Remove _rp_ in function.
> Changes in v3:
> --------------
> -None.
> Changes in v4:
> --------------
> -None.
> Changes in v5:
> --------------
> -None.
> Changes in v6:
> --------------
> - Remove pdev automatic variable.
> - Update register name to slcr.
> - Fix whitespace.
> - remove Spurious extra line.
> - Update Legacy to INTx.
> - Add space before (SLCR).
> - Update menuconfig description.
> Changes in v7:
> --------------
> - None.
> Changes in v8:
> --------------
> - Remove inline keyword.
> - Fix indentations.
> - Add AMD MDB prefix to interrupt names.
> - Remove Kernel doc.
> - Fix return types.
> - Modify dev_warn to dev_warn_once.
> - Add Intx handler & callbacks.
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 476 ++++++++++++++++++++++
>  3 files changed, 488 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index b6d6778b0698..61d119646749 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -27,6 +27,17 @@ config PCIE_AL
>  	  required only for DT-based platforms. ACPI platforms with the
>  	  Annapurna Labs PCIe controller don't need to enable this.
>=20
> +config PCIE_AMD_MDB
> +	bool "AMD MDB Versal2 PCIe Host controller"
> +	depends on OF || COMPILE_TEST
> +	depends on PCI && PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want to enable PCIe controller support on AMD
> +	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
> DesignWare
> +	  IP and therefore the driver re-uses the Designware core functions to
> +	  implement the driver.
> +
>  config PCI_MESON
>  	tristate "Amlogic Meson PCIe controller"
>  	default m if ARCH_MESON
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile
> index a8308d9ea986..ae27eda6ec5e 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) +=3D pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) +=3D pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o
> +obj-$(CONFIG_PCIE_AMD_MDB) +=3D pcie-amd-mdb.o
>  obj-$(CONFIG_PCIE_BT1) +=3D pcie-bt1.o
>  obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-
> amd-mdb.c
> new file mode 100644
> index 000000000000..94b83fa649ae
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for AMD MDB PCIe Bridge
> + *
> + * Copyright (C) 2024-2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> +#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
> +#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> +
> +#define AMD_MDB_PCIE_IDRN_SHIFT			16
> +
> +/* Interrupt registers definitions */
> +#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
> +#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
> +#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
> +#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
> +#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22
> +#define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
> +#define AMD_MDB_PCIE_INTR_PME_TO_ACK_RCVD	25
> +#define AMD_MDB_PCIE_INTR_MISC_CORRECTABLE	26
> +#define AMD_MDB_PCIE_INTR_NONFATAL		27
> +#define AMD_MDB_PCIE_INTR_FATAL			28
> +
> +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> +	(						\
> +		IMR(CMPL_TIMEOUT)	|		\
> +		IMR(INTA_ASSERT)	|		\
> +		IMR(INTB_ASSERT)	|		\
> +		IMR(INTC_ASSERT)	|		\
> +		IMR(INTD_ASSERT)	|		\
> +		IMR(PM_PME_RCVD)	|		\
> +		IMR(PME_TO_ACK_RCVD)	|		\
> +		IMR(MISC_CORRECTABLE)	|		\
> +		IMR(NONFATAL)		|		\
> +		IMR(FATAL)				\
> +	)
> +
> +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> +
> +/**
> + * struct amd_mdb_pcie - PCIe port information
> + * @pci: DesignWare PCIe controller structure
> + * @slcr: MDB System Level Control and Status Register (SLCR) Base
> + * @intx_domain: INTx IRQ domain pointer
> + * @mdb_domain: MDB IRQ domain pointer
> + */
> +struct amd_mdb_pcie {
> +	struct dw_pcie			pci;
> +	void __iomem			*slcr;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*mdb_domain;
> +	int				intx_irq;
> +};
> +
> +static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops =3D {
> +};
> +
> +static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg)
> +{
> +	return readl_relaxed(pcie->slcr + reg);
> +}
> +
> +static inline void pcie_write(struct amd_mdb_pcie *pcie,
> +			      u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->slcr + reg);
> +}
> +
> +static void amd_mdb_mask_intx_irq(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *port =3D &pci->pp;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask =3D BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *port =3D &pci->pp;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask =3D BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	pcie_write(pcie, (val | mask), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip amd_mdb_intx_irq_chip =3D {
> +	.name		=3D "AMD MDB INTx",
> +	.irq_mask	=3D amd_mdb_mask_intx_irq,
> +	.irq_unmask	=3D amd_mdb_unmask_intx_irq,
> +};
> +
> +/**
> + * amd_mdb_pcie_intx_map - Set the handler for the INTx and mark IRQ
> + * as valid
> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int amd_mdb_pcie_intx_map(struct irq_domain *domain,
> +				 unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &amd_mdb_intx_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops amd_intx_domain_ops =3D {
> +	.map =3D amd_mdb_pcie_intx_map,
> +};
> +
> +static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +{
> +	int val;
> +
> +	/* Disable all TLP Interrupts */
> +	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_ENABLE_MISC) &
> +		   ~AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_ENABLE_MISC);
> +
> +	/* Clear pending TLP interrupts */
> +	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC) &
> +		   AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	/* Enable all TLP Interrupts */
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_ENABLE_MISC);
> +	pcie_write(pcie, (val | AMD_MDB_PCIE_IMR_ALL_MASK),
> +		   AMD_MDB_TLP_IR_ENABLE_MISC);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t amd_mdb_pcie_event_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie =3D args;
> +	unsigned long val;
> +	int i;
> +
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val &=3D ~pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(pcie->mdb_domain, i);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> +
> +static const struct {
> +	const char	*sym;
> +	const char	*str;
> +} intr_cause[32] =3D {
> +	_IC(CMPL_TIMEOUT,	"completion timeout"),
> +	_IC(PM_PME_RCVD,	"PM_PME message received"),
> +	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> +	_IC(MISC_CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +};
> +
> +static void amd_mdb_mask_event_irq(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *port =3D &pci->pp;
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val &=3D ~BIT(d->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void amd_mdb_unmask_event_irq(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *port =3D &pci->pp;
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val |=3D BIT(d->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip amd_mdb_event_irq_chip =3D {
> +	.name		=3D "AMD MDB RC-Event",
> +	.irq_mask	=3D amd_mdb_mask_event_irq,
> +	.irq_unmask	=3D amd_mdb_unmask_event_irq,
> +};
> +
> +static int amd_mdb_pcie_event_map(struct irq_domain *domain,
> +				  unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &amd_mdb_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops =3D {
> +	.map =3D amd_mdb_pcie_event_map,
> +};
> +
> +static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
> +{
> +	if (pcie->intx_domain) {
> +		irq_domain_remove(pcie->intx_domain);
> +		pcie->intx_domain =3D NULL;
> +	}
> +
> +	if (pcie->mdb_domain) {
> +		irq_domain_remove(pcie->mdb_domain);
> +		pcie->mdb_domain =3D NULL;
> +	}
> +}
> +
> +/**
> + * amd_mdb_pcie_init_irq_domains - Initialize IRQ domain
> + * @pcie: PCIe port information
> + * @pdev: platform device
> + * Return: '0' on success and error value on failure
> + */
> +static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
> +					 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node =3D of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -ENODATA;
> +	}
> +
> +	pcie->mdb_domain =3D irq_domain_add_linear(pcie_intc_node, 32,
> +						 &event_domain_ops, pcie);
> +	if (!pcie->mdb_domain) {
> +		dev_err(dev, "Failed to add mdb_domain\n");
> +		goto out;
> +	}
> +
> +	irq_domain_update_bus_token(pcie->mdb_domain,
> DOMAIN_BUS_NEXUS);
> +
> +	pcie->intx_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
> +						  &amd_intx_domain_ops, pcie);
> +	if (!pcie->intx_domain) {
> +		dev_err(dev, "Failed to add intx_domain\n");
> +		goto mdb_out;
> +	}
> +
> +	of_node_put(pcie_intc_node);
> +	irq_domain_update_bus_token(pcie->intx_domain, DOMAIN_BUS_WIRED);
> +
> +	raw_spin_lock_init(&pp->lock);
> +
> +	return 0;
> +mdb_out:
> +	amd_mdb_pcie_free_irq_domains(pcie);
> +out:
> +	of_node_put(pcie_intc_node);
> +
> +	return -ENOMEM;
> +}
> +
> +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie =3D args;
> +	unsigned long val;
> +	int i;
> +
> +	val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> +
> +	for_each_set_bit(i, &val, 4)
> +		generic_handle_domain_irq(pcie->intx_domain, i);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie =3D args;
> +	struct device *dev;
> +	struct irq_data *d;
> +
> +	dev =3D pcie->pci.dev;
> +
> +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
> +	if (intr_cause[d->hwirq].str)
> +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +	else
> +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
> +			     struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct device *dev =3D &pdev->dev;
> +	int i, irq, err;
> +
> +	pp->irq =3D platform_get_irq(pdev, 0);
> +	if (pp->irq < 0)
> +		return pp->irq;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		if (!intr_cause[i].str)
> +			continue;
> +		irq =3D irq_create_mapping(pcie->mdb_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map mdb domain interrupt\n");
> +			return -ENOMEM;
> +		}
> +		err =3D devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       intr_cause[i].sym, pcie);
> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}
> +
> +	pcie->intx_irq =3D irq_create_mapping(pcie->mdb_domain,
> +					    AMD_MDB_PCIE_INTR_INTA_ASSERT);
> +	if (!pcie->intx_irq) {
> +		dev_err(dev, "Failed to map INTx interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Plug the INTx handler */
> +	err =3D devm_request_irq(dev, pcie->intx_irq,
> +			       dw_pcie_rp_intx_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, NULL, pcie);
> +	if (err) {
> +		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
> +		return err;
> +	}
> +
> +	/* Plug the main event handler */
> +	err =3D devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "amd_mdb
> pcie_irq", pcie);
> +	if (err) {
> +		dev_err(dev, "Failed to request event IRQ %d\n", pp->irq);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> +				 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	pcie->slcr =3D devm_platform_ioremap_resource_byname(pdev, "slcr");
> +	if (IS_ERR(pcie->slcr))
> +		return PTR_ERR(pcie->slcr);
> +
> +	ret =3D amd_mdb_pcie_init_irq_domains(pcie, pdev);
> +	if (ret)
> +		return ret;
> +
> +	amd_mdb_pcie_init_port(pcie);
> +
> +	ret =3D amd_mdb_setup_irq(pcie, pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up interrupts\n");
> +		goto out;
> +	}
> +
> +	pp->ops =3D &amd_mdb_pcie_host_ops;
> +
> +	ret =3D dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	amd_mdb_pcie_free_irq_domains(pcie);
> +	return ret;
> +}
> +
> +static int amd_mdb_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct amd_mdb_pcie *pcie;
> +	struct dw_pcie *pci;
> +
> +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci =3D &pcie->pci;
> +	pci->dev =3D dev;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	return amd_mdb_add_pcie_port(pcie, pdev);
> +}
> +
> +static const struct of_device_id amd_mdb_pcie_of_match[] =3D {
> +	{
> +		.compatible =3D "amd,versal2-mdb-host",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver amd_mdb_pcie_driver =3D {
> +	.driver =3D {
> +		.name	=3D "amd-mdb-pcie",
> +		.of_match_table =3D amd_mdb_pcie_of_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe =3D amd_mdb_pcie_probe,
> +};
> +builtin_platform_driver(amd_mdb_pcie_driver);
> --
> 2.44.1


