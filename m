Return-Path: <linux-pci+bounces-7522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D48C6C21
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D978B217CE
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C4158DC1;
	Wed, 15 May 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdE9wxP2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FC158DA0;
	Wed, 15 May 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797703; cv=fail; b=u3U+2I6F/A+1e4VTT3r+dYg7PeT8T++keCShjca4y1tWDtr+fypSOUKtQYKuMPIlsKJkvOrjTEpU1m8C6HWr8BZg/ZHTaOGEenEqj7qk6YYGZ+iHQ4boBm5wrN7nC/Xyd+Z+izj7WNiJm+Lw7dOs4o6X1TvwT81If4w35D9PKD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797703; c=relaxed/simple;
	bh=pysV3N8x91W3W1F9tyHCGeXrsfvxvVl+uBXtviJSgHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esOn1LWg4F33vPUnEFBtutEcQtOWRdi46t7q9flSsm+X6+ZfMMAb5VHi2cqTxaCTYA4nGzWNZ9z2gIm/tTSDeFvZ6pw4Wt8MWTSxOWp46NJR23TfE/b04kkfrWU9W/avSCJV4MooLjjeYIjthGYZo3jPFz/ZKCjw8nKcycX5840=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdE9wxP2; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxE+XOKNQJ3kIoDGs7tFwhg4d3uRnVpC455WPUXgJhW7wHf0B/CtnD5ZWF/YBdzmq0g2lYewYG1AzOJrlqH1pkxfp3UTdbnqhMIrYnG8oTtAIEbaXgbDdi4se5Pe7nJheFiADzEX0eHGd02PFdlFHNGgQ9dm7THGfCwWwfZcIRab5kH1ZH8ETtH7zZ1PV/oGIRxw5g2pTzoCOPE5APeey1H4iaGGuQppguFEy5XEZ0O6CThdOlQS7T8N6Qlfo95gDZd0Du6/oiw4HN2jJ7QGNrTkrS31HODTuh2KBElgkkwXDTPx25hiv+TUB82TbVtMCZuCQM7JwZMtkLUnrarq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qmGePDoXF0g3n4jGx7cjZY7P6NO6GY+XpqzP56lelE=;
 b=LvsSpVj22F775Mx+UatyNBlOxsZTPkyGfkaokD7V1oljxiBwreI6EJGuwOZhFcE1R1cSKriWPPLm6wk/en6Y2NW3BLRn7ygeRh/blFJxypEBCCp1s2IwWkx+joxv3dRWji/mdYmxkVi8V4/WxDGKjQZmr3v/3tJyN/Img45x0IgZz6ghKu4Zlz6HQSHYiKcyLCieM3s3y7sBe2MVJQeY+Hr9b4ax2FV1lvTD9ehU2slzJy7BT+hNTO4ou3vBRCO113IYOqbXoJsisYqqW2iYt5bA8IoI0PqFjD+kTl1Uy1rvh9hVLuft1pxEsqwQwDYbxzHwsN3Frkv2mCn3Vukm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qmGePDoXF0g3n4jGx7cjZY7P6NO6GY+XpqzP56lelE=;
 b=tdE9wxP2tXGaVeGwazv+7t1PeLP70vI6AiyA1cX49gCKbqcrAkf+YynKDRLJ7INiuTl8t6SjahD8+xEGIRIvtUPv8JSztE2ebBWAL6bRp4mSftwDRaP64QxsgIlnMusgewoJo6rYlyGoHtzx9vmmCLSuDOW0sWibHEM5a1AySsovCrPZFsA5sYK9e6vKk7zt2ftX4vlgBGYJZ2bOFdK61whmVmshlTtalTxyi3h6paEoNqEEMJ1jGPEMFAE551STaC2c9JHJgho3V7ikwWSa0C5xE5wBFbY/2zm6jF+qrL7e+NxsZWvOWaFj+GCJmsvgfLZOkXa4qEN7epxDIkEp3w==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 18:28:15 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 18:28:15 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, "will@kernel.org"
	<will@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Thread-Topic: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Thread-Index: AQHamipvCg6xt/mF1keAxYVUTIlyxrGYtfKw
Date: Wed, 15 May 2024 18:28:15 +0000
Message-ID:
 <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
In-Reply-To: <20240429113938.192706-2-jean-philippe@linaro.org>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6674:EE_|SJ2PR12MB8112:EE_
x-ms-office365-filtering-correlation-id: 650ff3f6-540d-4277-2884-08dc750cc913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009|921011;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W9OZKK6ivWEKBioCWayBwAUuKE/egcX3SBpDCuMkH6nH5P7tBhQ0OSOMZ2TD?=
 =?us-ascii?Q?ovjXQW8+04QBcIdQAX2n3RxPTdjsBHm4LoYuJxqtXkyInzW7t1oWmGpv5Et7?=
 =?us-ascii?Q?rMPPRHo5U9brV5/zV9Py7xRnz2h3rT4OCn3h9m6e5YhGUYBeiZNw5SSPwDTn?=
 =?us-ascii?Q?zrxjJzLqcQ4U5QMCMjb+/UdaHmvKQ3yT8BJmUnNZ/OrYq8LZ4Hp3bGb1lSCS?=
 =?us-ascii?Q?Gx/8eZv9dtChh27vJO8TGRierXcbkvqiJ+uGmo8ndj/cmnIoNfR8D9sVhWO3?=
 =?us-ascii?Q?fjUTvDkTSLEcbeSHPOnHILCX7+EyoDO2GASCG/DEUao2QXt28yVMNy2dA8AX?=
 =?us-ascii?Q?hFn1vD+sO0EJEKl7kLloB0+i335Rm09oIt3h9f59hYpQYySERUlz1BqVSj4m?=
 =?us-ascii?Q?wHKWxCbKa9guRaXjNZibPnFkcqzYYKIPIDug9JORlSZrFGwOONGjyt4J7I7M?=
 =?us-ascii?Q?tgHUH7lQoKKarIbG/XX6aEQV9wgnNFYxHswJPKng50Eo0n1vV/n/fpFeHEH0?=
 =?us-ascii?Q?AvFsL6sGSd/s+cajOomdBpDMZqGCh3LO1el02BeC/BT2godQ9BiWo6M79xNy?=
 =?us-ascii?Q?lueZnYaQ9GF6BrspIrKubtDT1b+d5VCbSIIt/0gPH/3sawL0qfPI7DmHUG6N?=
 =?us-ascii?Q?kSymKOy89XV1Sh6MuVgiGDcIGMt8cjlsDuV0WaUMtcFzxhqyE19Tw0s42ejz?=
 =?us-ascii?Q?jHX+pGDjmd9EJcXSAqKXAFFNq7kPkgQsfRfcTMZkcWMwbCFYgPqxch37fRtZ?=
 =?us-ascii?Q?K8MBgFB3e7zFIbUkGYvezVb9cehkh1SMgvYviUqDet6G41TN9K2Dr4rp/y81?=
 =?us-ascii?Q?Ht45dZG39WOCIV3NCTYHjDjlMNee8YAkPjC0+efImMhJYG5fkW70qbCqdKXY?=
 =?us-ascii?Q?asRLQ9V3JdKekH6qAbtVqTIzHcMXWHxYaWQC/S6xuUMdq5Yi3G0IvmaG5TSu?=
 =?us-ascii?Q?j9WhIo5OPwjXa4CPpzT3M1o1LLP1UiB+rO9AuC0MQZ5XiPi3pA/AqbtTn5S7?=
 =?us-ascii?Q?3U+XstOz7eKcSdV31tERM7tRHSG38jacJJs9IxMYp/XWyabQWYV+wSrxskfz?=
 =?us-ascii?Q?vhNEFANrfciqxxAEi+p1AljsC4kLWhAdr+OyRGOTFa9UE4jeGcx0mC9+AbEi?=
 =?us-ascii?Q?KKUvaz1MAzCZ9hxIeJiFpaZ9MpxvXio9z2JcZDRp9cIexohn32eu4tpM0LT8?=
 =?us-ascii?Q?ZWGcWB8fwFMBS4zacML+HiM5+ZlLBWXIkK7hcsOYqVeW8PaRdysoNtELASaD?=
 =?us-ascii?Q?WarwsitZTIAmnHYAeisEs5dj4uT9ERjPEeucFRiyTBpaTG2B15x0NkQZZd9X?=
 =?us-ascii?Q?06zdfpsNJ8uOY4B2iZIMk89m361mxhZwtR1CuPVxFlL+yDlELVPja4SmPANN?=
 =?us-ascii?Q?+l+D2oY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zmkjZR2G450anMcLdUE44+ua0uj1EN/TZrgz3ZLYF1D8vujyYFJLDkCKg8ZY?=
 =?us-ascii?Q?cEaxN2mrOjHnjPVwdfgnR8uuPyxivOfUySM4V9Au1Em9D2U18myiebUBBEjI?=
 =?us-ascii?Q?SQUsRW0yFXLgZIznm5ZEaxVPGR1FKWjn9ud2kK3Ny1iUBuIxGI5PTpgUTyrh?=
 =?us-ascii?Q?/5H6pzc8icUbO1qzlfjWRy5uF4L9HcyNuHOJpEIFD9Y8sJMJ1I3numxP/oe9?=
 =?us-ascii?Q?Ixk42UoczMvEiJFGZNO/7aonL8HOxoamApboW64X5ei9i9vJAudWR9l5KK2l?=
 =?us-ascii?Q?bUtbdAZBEqolp0eiz4MmnPdo9UBaE332INKQ2KfBtBe2AnTpNM+JwAQFQPlG?=
 =?us-ascii?Q?JonI4VhNSLotUP5kywMxjCVwRCXo+UKTc+BtbDIBu5HnkFi5BX3H/qGAupnT?=
 =?us-ascii?Q?YI2U/hSOsBCd0PI8BHqhd2QHUqrWuZiXjLDC2pF3cVK8GwsL+3ejWN1jGo0/?=
 =?us-ascii?Q?zRMwNNSBW+5JjTJ4Tq9Nr1aM5m9zttsL893iKKPWWZOTyNESFK9Y7HjgtYKl?=
 =?us-ascii?Q?V35aRdi9zNqEdKZ++ENaZ1Q0y9H2853aLxLr4Cf8ORFN92Si7BFbl74aDf+P?=
 =?us-ascii?Q?VgJBQFe1FVyQVVBN/9o9lLMWTorySSjKseojGtGqi1MmkiNKBOIfkrrraQLi?=
 =?us-ascii?Q?diQpcOaxmhvfVcoSr+2TM1xQEd3Nv3+nZ/OVN8gExc/VVLWCbimZQ7YeD24p?=
 =?us-ascii?Q?lnFibhsfyjCUIPLd2bv1a8msEuDklj+151PeRuRx8TSBCAtUV6/iBhc5kEYb?=
 =?us-ascii?Q?QlX9rDgWuABp+GJCbnTjYDwg+5267Fsr0TDYtXAT1UY6H6EQLGivnPsWfocg?=
 =?us-ascii?Q?2od1Wkil3/jMRsKiBlMEyJxd4be3j9EFSRT8AAf5OOYlz3opRFuG9lBFCMGi?=
 =?us-ascii?Q?H4axvAMhg+LYr9gntaLhR3BJjCAGBv3bJOIyIrSanVvzExxHE8dWKxt1Gndy?=
 =?us-ascii?Q?OGposeSBkUgc/kCGnJQrRSvMuFRi3wYGG+ICaGwOklE5i1c4Y3iwak5Mt4ck?=
 =?us-ascii?Q?oer1E7G/J1hcXdyLH17QgcT0wkD1CPa8fuqiFSvZhvvWWd8QXso8H3US40R2?=
 =?us-ascii?Q?j/Cu2fDJ8eqxIHlEx4qplghS4lX23Hgt92PXEfiJXu5NcaBB4KUGrqkpn1Sy?=
 =?us-ascii?Q?EbONp3IemWsI3Udvt3/zpPAMa4m++zq+vO/t5LUu7iLOfzxUb+nL8avR8u3C?=
 =?us-ascii?Q?4gom8rCgpWxXRASrq9aLIuOyVdsXIVD6q2K9s1PaDMUH/oYdAXTjRaJmXOe7?=
 =?us-ascii?Q?VIeHNS4MlsVoxLLdr2QriVYjKE+hUCG5zYaXbu/5dpHWBU6tdjC8C35nz5EB?=
 =?us-ascii?Q?ZClxRxn4uxWRkFgqXbfSkNLX/gFhVKVV8Kgx5hKyRtJJYH5h/5ehOsyZrbJV?=
 =?us-ascii?Q?k/8EgjHXyjEl2PRva6nXP8/RLzu4QngdQq6RBFFmmPnyvA57Ulp8HL7gLHK7?=
 =?us-ascii?Q?EiYkSjjISu9AO2OVZcu6H/oKqVblsmObSbYdsIPkvwYtj7RotcaD/gWsI2es?=
 =?us-ascii?Q?BLhXMo86wZQUr+mz9Pl88OvALRaJLWvP5lCND3wvtTwaex4+JwdNynLYxSV5?=
 =?us-ascii?Q?48xaKqLU7MpzTBc6Cxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650ff3f6-540d-4277-2884-08dc750cc913
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 18:28:15.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnoCfIF1C7jW5hXjWuhtYKfXfXR+E/6AF8Sf0uBx8pBTusQRMbifTG/xMPbwxrKxpFbqXiBn/3OYSbiEybPlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112

Thanks, Jean for this series.
May I know the current status of it?
Although it was actively reviewed, I see that its current status is set to=
=20
'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/=
?series=3D848836&state=3D*
What is the plan to get this series accepted?

Thanks,
Vidya Sagar

> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, April 29, 2024 5:10 PM
> To: will@kernel.org; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org=
;
> bhelgaas@google.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> liviu.dudau@arm.com; sudeep.holla@arm.com; joro@8bytes.org
> Cc: robin.murphy@arm.com; Nicolin Chen <nicolinc@nvidia.com>; Ketan Patil
> <ketanp@nvidia.com>; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; iommu@lists.linux.dev; devicetree@vger.kernel=
.org;
> Jean-Philippe Brucker <jean-philippe@linaro.org>
> Subject: [PATCH 0/3] Enable PCIe ATS for devicetree boot
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Before enabling Address Translation Support (ATS) in endpoints, the OS ne=
eds to
> confirm that the Root Complex supports it. Obtain this information from t=
he
> firmware description since there is no architected method. ACPI provides =
a bit via
> IORT tables, so add the devicetree equivalent.
>=20
> It was discussed a while ago [1], but at the time only a software model s=
upported
> it. Respin it now that hardware is available [2].
>=20
> To test this with the Arm RevC model, enable ATS in the endpoint and note=
 that
> ATS is enabled. Address translation is transparent to the OS.
>=20
>         -C pci.pcie_rc.ahci0.endpoint.ats_supported=3D1
>=20
>     $ lspci -s 00:1f.0 -vv
>         Capabilities: [100 v1] Address Translation Service (ATS)
>                 ATSCap: Invalidate Queue Depth: 00
>                 ATSCtl: Enable+, Smallest Translation Unit: 00
>=20
>=20
> [1] https://lore.kernel.org/linux-iommu/20200213165049.508908-1-jean-
> philippe@linaro.org/
> [2] https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-
> Nvidia/
>=20
> Jean-Philippe Brucker (3):
>   dt-bindings: PCI: generic: Add ats-supported property
>   iommu/of: Support ats-supported device-tree property
>   arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
>=20
>  .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
>  drivers/iommu/of_iommu.c                                 | 9 +++++++++
>  arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
>  3 files changed, 16 insertions(+)
>=20
> --
> 2.44.0
>=20


