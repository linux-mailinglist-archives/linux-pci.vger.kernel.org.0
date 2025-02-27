Return-Path: <linux-pci+bounces-22524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F3A47586
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 06:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE723B06CB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517922ACF3;
	Thu, 27 Feb 2025 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wcK+Nh1X"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353E21CFFB;
	Thu, 27 Feb 2025 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635582; cv=fail; b=BV7nk4fnFKGIukDTzXsyMRseWkLnhiJqDv6/1vDpAci1LpnKGeY8N+SLN7GwtnoW5BnAx99gmLF3NmISedTpJoIaCx28iXT1LkXS0aCMPSexXUnjl1ogh5vBVvEfUGV5ZlHs3rW0Cedipwqa/c+or3/jxxm3BY0Nox/ASv0paSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635582; c=relaxed/simple;
	bh=91BMmwS7JXCkrjOb+6G5ZCjIwlPwa+TeUISAt0bzeqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AN3ym8i+pqaEMMsYb2uLw4qulkwTsErFu6b6qSkmN9w08qHlXF5UdlJCFUfVbBuvhfnlSctXd6U9EH6ZMyHe0ZbQgHavCdyCDusVVTENOYFr1lS5owN+kxQG0gmlmFTF3M4P1Vpcl6v+0pkWiudjrV+FA40z7DZDOpxV3cevUYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wcK+Nh1X; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvjTIuOUCGhaUcoOLzLRviP7uh5FPyEcXQDHH7H5DOaOprFhYqG9xLwK8KYMWMkICXSddkquFmHRGmPAGf8YVx2vKloY/2EebATPFkN19dvq05S0A6OUQ22LqSlVCNIox+otIr/Pyhxn6bhs5o5eG+a+qYN2SQ+su7WYM8iWXyHQR1jcYtKg+PQ7mIs1W1vwYUZgqKY7L5crLH4KuCD7RQmoPLI+d360c0kwaxmpFUZDCAgKPvNeM2LY9Nu7vJAAUOzOzMJYFrt6Bj8IHZEeKOJ0cAyUPN0vOCP77eWjTmSAtOxz9rYERRauf5Inth1AqDxTYm9BdorN5ETQ1Zm36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IHL3sGAo93Ke454pK8c0Frc/G3xE9E0ToRAJatJP3c=;
 b=kfnt+O0ZJcTJbG/I59+cqDbE4lbkm+z5TkdYHVru7Bh85suDHdoVGh5tSMCf34xJEMKSAJ/BKunLoN8NterXrYoWcnQus/BDerJiqWilvmVVd6CAWwWIk2cAJSqrRXCcIj6GHvvDBY9kPgHBDFK+2I6vHC1h2zYo1p0fKRpyGzW2rkAcHyAqC+8Wxjw2dGsnxN8CipIjHZfT8YxS7VJpAnRCFn+wpzbqymspLy4zhyCa1hytZZMzaJR50G6RnP/GMEW6LtbhvYamgbhyOe1gu0UgoDorspeLOBD2vWN0xryT6WxwcFS2FjU8JTSZTFd5eGBFLmNHl/Q4LCgwF+uG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IHL3sGAo93Ke454pK8c0Frc/G3xE9E0ToRAJatJP3c=;
 b=wcK+Nh1X1ZDOLdIeH1mLteZozl4EiuJUmfb0a0U44B5D/eOh/BduCxJfT5dDP1AB48efh8zHeejmcS2R/MVjIhw2Wxxetx9vvM9kQcrlC/V0HfXzB37iGQIWy1IB+/X3kSjYkxBu8NmCiPWRMozIxh5rLZ2KkYXqDkT2xg7YnJw=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 05:52:58 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Thu, 27 Feb 2025
 05:52:58 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error path
 of probe.
Thread-Topic: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error
 path of probe.
Thread-Index: AQHbhtPisuw1fWm8k0ij7RwCnpLSZbNaqd5A
Date: Thu, 27 Feb 2025 05:52:58 +0000
Message-ID:
 <SN7PR12MB720174213D8DD5FF5F5E20708BCD2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
 <20250224155025.782179-2-thippeswamy.havalige@amd.com>
In-Reply-To: <20250224155025.782179-2-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4ae47f3c-7b8b-460d-97e8-0d9dcd2f1283;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-27T05:52:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA0PR12MB4384:EE_
x-ms-office365-filtering-correlation-id: dd342e38-3fe9-4625-e51d-08dd56f2fd2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4f0iZ/FKzeG4756Wz2JEXy12e7ruXoBjPsOTmX8YqhVB2TpJOb+y2ZPyLCdv?=
 =?us-ascii?Q?vCywKTdqmtfTw6ka5CvmdL/3qkbhgo2TBqlFVZVGJNtWqGv+3+Q0tGNDQyNm?=
 =?us-ascii?Q?pdMnO+4q5F98JX1GyGICEX7mEUgcIa/fEQQkz4CMUINci04LW59qnb1Q37vT?=
 =?us-ascii?Q?0OuXb/3YDyLYS2bL5lLT3sDfV7ScL+3Yy2tG3agyCP0ypz4PdVkvRfoSugvW?=
 =?us-ascii?Q?qBiC50j+vK2cYCfKAC/OoEn1qCzvHDlNVV9oqHZvf94xJxyulYs6QCeaE/jQ?=
 =?us-ascii?Q?W3WIS7zp63ovSQGa0YchUlSFHDw/h1qb2tgQuUQHpUNK9KpkK/8xADLmypgg?=
 =?us-ascii?Q?2yGyqOL7PGs8loBouGvU+py6IC/bTCBpXmB+4Ihb349up/PjXQ+ARDGuqfuM?=
 =?us-ascii?Q?QJcLmeX/1ggcqNjUr/9xysE4mae2KmnujD5z1qCJy4UXOQ6/mxQk6k3JVljK?=
 =?us-ascii?Q?DoBYRvLnErQHYTji17xnHws/lv9+6kN9pmf9Rj1qb1xkSAoLnvcswtcgv8Vf?=
 =?us-ascii?Q?JDRfB6pSJS7MLGHz465ynaC9zEVI4cZynAHCH//YnrzTPVTiISeCttNzBoDb?=
 =?us-ascii?Q?bxaVGOwIkrtMdM5fVbndgpw5mpg9QBPX0xZuOC1TXXpFF1q7dh6+cEO2r3GL?=
 =?us-ascii?Q?mz26JwZcR89raWjuaPo4OQZuVD0IFWbEZUp0Pnze6QPTBWZoTAFRF5Hc+twm?=
 =?us-ascii?Q?lE0dFAchhLiXkLbYR6hkfO7hMYJg66roGCwmQU+m9Q5R0A1vTs6Wbbop1MXp?=
 =?us-ascii?Q?+Lzb4tIEahPlsRNdcsAfH1tvAw5+jZpwBTGYdzA1g3WxMoiBO44D8hAF7i/V?=
 =?us-ascii?Q?MRXXoajQ32c5krN4VKSGNT+8NxxSJQsTPk6P/Q9bdJaOAbjpxKQ38kogcX7e?=
 =?us-ascii?Q?4XGk4RtrL84hjAI4FFeQlABE0SER818xH1yD+Zq0k054PqrY6YI9+e8DihLG?=
 =?us-ascii?Q?kIDnY3Gs83OZ6STdDFEuOT1CHOaT/GKz1FFxqr5nDID+fcdRg+JNd3lZXmhC?=
 =?us-ascii?Q?Tn/QhgtpDgr0m6dUl6xZ5LePtBHWhbadU+Pix1lIbBsjPGU+xoRN9ivzQsPq?=
 =?us-ascii?Q?bgRpDGw60G6KC8HcJY02KIlFBh1k+yoWmchFYYWILPwLd+z/wRnJeLQGw5lP?=
 =?us-ascii?Q?th9v1g4RtsQK7at3wz1Y/e1S5ZqHo5MNOO7e4ZEeJ/SNDJ7K2iWV8blXBfby?=
 =?us-ascii?Q?Dq/xxGKOJjMgoy8hgGe9iswse/pLYosofREhYYfrPMq5iLT5BmOepg3uS6GO?=
 =?us-ascii?Q?8x1CIaXKbt+vMdDODA3Yj3C2Bll3YNmBPHS5z70+E2Hmrbo+9lw1c3p/IzbB?=
 =?us-ascii?Q?CQ98tb33yTFFsOqG91W4GE+hcXjNZ2TiR4eMK9/84V71lDusSP784GnfSe9R?=
 =?us-ascii?Q?VjMjMDCaWEDwOukacNW/zdWQWf5T5GDa3bkV5XKiY/K1Y55D65R7RiBVOkMs?=
 =?us-ascii?Q?yzTQCJKZjuccZYXXgj20giVFng0IVFJP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bC2FdbRa8GiOFK6uC1IzaU8LAWMja9csbY8mJMz3SA0c+vfTXdtqPQ2JBr5a?=
 =?us-ascii?Q?UhM4ye6ynozGM91GmaDJKa0yF8kdXphsdlpa+eCcMN7y6ju28EAkFjROWygF?=
 =?us-ascii?Q?9ggKy27DPxGdLkp6rsa4xB9CU3JZSD+FlVpH2+qOccyamj4DUsTOwm2Sh7Pa?=
 =?us-ascii?Q?yR2jtRQhvI32/WJ6PX+AUKsT6usZKd1oaz8g4b9sZMe54cTOB/+iKMquAu1D?=
 =?us-ascii?Q?AOAS0iAnYBYMfpaQxMgaOuwhUw6zTUxWmd3ke8lT6gzaOK0udqjOsM6IVwTM?=
 =?us-ascii?Q?9q8sjH1NoqE0EiEToqGrgJkK/PaUSFRtKjyLNge13/trlxw0Rx/UraGsOeN2?=
 =?us-ascii?Q?LwamfsNbm44b+dsYdh4NSrkH03drLXShFf46kSR69/X8WltWeI+Y9VyjNYcT?=
 =?us-ascii?Q?MWd/jZq0WhpU0q4YlqYSK8cAtUA1ynrfvEfC7VTkswlngjK9zL2wKKRyqsgW?=
 =?us-ascii?Q?WErBj91ozmPS2nrHip8F5C8Atk8hpeYfOSt3GDDuOGgwK9Swky2SQJXoVM36?=
 =?us-ascii?Q?g33Jdb+7PnMdAHbtqP/FVfTiTJKTO9Ht33rAvjd6EvzTmv97yvVxzMs1giaD?=
 =?us-ascii?Q?J2FK8xXlOdmBxXttfYzrSZnUG7tlgtkUBrULaOJ8JRiQFpdlnG89zOz7PpPU?=
 =?us-ascii?Q?TOp+wvNrSiJR4r4DSoSz1mTP871jfcNo5IcSQNz9WS3jk5Yx952WxZ9vF9Nv?=
 =?us-ascii?Q?955tvfrG+KoNKP5KzOaIaKHErrfp1PNUggDZUlPy4zxK1Bsio6xmjigGIrvU?=
 =?us-ascii?Q?1LSSxNUi5K+Wer1GiR/b6+KQiS5Ehc4n4sZ21bo7qdzGl6QL4RXcMN3icdyR?=
 =?us-ascii?Q?X+qLdcyeM63XyxdKrI8y604ps3+GRE+JbrCwsrj0PT7Wlt1cAV8/4N5D2cp9?=
 =?us-ascii?Q?9nr+IB/b/hrlpb5TjejiGxs3xRGFKjWiIWDHeSo9LfUrI/3+QNJ8a8Ql5Ddr?=
 =?us-ascii?Q?geadm+tnW0H0kFGzZyEoEFVvhEWGIVmGAiX4ZjTnMhsTiVJJAm/g54h6RdJ6?=
 =?us-ascii?Q?QY2nCNRzPz8OKweWA4cRP8e0OupMpK1sR6i7UXKAtM6vzPeaV8rboALjnH/F?=
 =?us-ascii?Q?B571Q1qvq72jWpHOyeaGzNWEkUbGBdmleVDeNYoMLnRvoXY6FpO1XjwloPgG?=
 =?us-ascii?Q?dtSO+O0N8rR4Cpt2P1Nmgpm2xqhBiSVA8MqbyFdVtja9NYAIAEW5Zpd9KZdL?=
 =?us-ascii?Q?eBN5gvf1COZZFqxa7Z0mgPGcJlsYTfu4o3MHOQLQzAYyZrhNQQHtFpSTWlGF?=
 =?us-ascii?Q?ekSjDvE2CGvM+YnpHCcuiSUsiuJYyR8wcFwI7BXMt59EhaRCs9341u61hAdK?=
 =?us-ascii?Q?m2HFPW4Mlz36SI/MsHk3BX8QgQrcFTJ1wIzfqB//NYXUglwsFKe2/jVONW5b?=
 =?us-ascii?Q?dXu0KjiFM+bYkKpE1ao4ZtfKLGQzBsg2jRFXDnjxcIJu3YkHeHJAwBn3/WWw?=
 =?us-ascii?Q?f+DR6K4pMXHOgAEY+b/9K2VutwupT5F+qCcMziJzfkUh8SQdgIU6+ON/nf/0?=
 =?us-ascii?Q?Z/ovKyWODTsbkvwa+1GN5SKZfDPvgLEnLtnSBosclfJANA4NjJkCz9IZHTH0?=
 =?us-ascii?Q?ypjoG+hIFMFYpoPS8qk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd342e38-3fe9-4625-e51d-08dd56f2fd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:52:58.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CdXDM6XtNKKkaM/TV9GoSTq0i/pDRNz1S8Tq9znfZAd672p+W9X2jnOppeTOiJCm3JvR3+wZnYsVK8jjb1ggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Manivannan/Bjorn,

Can you please provide update on this patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Monday, February 24, 2025 9:20 PM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error pat=
h of
> probe.
>
> The IRQ domain allocated for the PCIe controller is not freed if
> resource_list_first_type returns NULL, leading to a resource leak.
>
> This fix ensures properly cleaning up the allocated IRQ domain in the err=
or
> path.
>
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..660b12fc4631 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -583,8 +583,10 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
>               return err;
>
>       bus =3D resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> -     if (!bus)
> +     if (!bus) {
> +             xilinx_cpm_free_irq_domains(port);
>               return -ENODEV;
> +     }
>
>       port->variant =3D of_device_get_match_data(dev);
>
> --
> 2.43.0


