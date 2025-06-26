Return-Path: <linux-pci+bounces-30751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16900AE9D5B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FCA1C268F5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00458218ABA;
	Thu, 26 Jun 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="pb5CIETo"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915C214A6A
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940452; cv=fail; b=K3UhwTx2c/cdRQ6e9sFFL9SYvmHlnUkOw6Fll9MVMU7lYHpo6hbntjPyWrulFABvCwIFwCEnFehpr5K7yydFiXA7gGKxj/ms+xX08qd/sTsrwXDIlP8iNnJT3u+8CBAbqwSMSXrtdY5dFwQ3Lv36H4vJ2q65ecIjkK5EHfLfSRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940452; c=relaxed/simple;
	bh=+GzXSvfCVeMSoqMreW92fj8NjAlMu9pIlSx8nQZRIw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeGtpFDHNp87/WC1H86IQoVc6TJPpC7G7FNn/hCLvOOC98RmjbhfACfaQmXaohODOkfjQlCs0hQVr6sYG/NEWI7XEMbtU3yEv2RGYFL1cbWqAV6rs4GLUL3guNqC+pbqlUgPsIftCZ0KXNv4o2bP3BZbLfTyH90VpoEJoZLteVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=pb5CIETo; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/HPXWmfxSlMpYejMuSd4uzBUtknrbJ1tFbHldhK8Cvvi/jwOsNpp46OXPMrTZSU9CMohghxRWdmiebYQveK42pOQN9gK09NVO/RjpFjBf5kR15XrLppnIRIm5QVuxkG0AEW+Fz25WSIas3ij0Z33AWBwDZ29G+yBm+iShffiesOqXCJ6AOGkckAfJqQPDAly/5luEOr8SDvRTOJtgtrT6Po3n6vn9VDnjtIizixCFeLbP1PyGWAj9waY7grvOvjDkLB355fuKOYmNr7s1ak5s+ZGyUgqffh7XEFktO1O55XvUaAEErPKDh+jx5qoykVUAS3fakZtYSVWEHCDV2AhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmQpVO8NiFUtFqHkQV5wqyvigmg/eFXQcEwnAax6gr4=;
 b=ZgnXu2OJ6AVjs8ZRoanK6P2QYr9FsBITnlBMQ2INVRs8JwbPnGysJva9gDr0rQwDmapo2kOmzlhs2UE1+5m6mdMnZ69p152UkSnfmdKtcz5XZ5DlgFKwNlmwMC0QKXzcPUtaxgbIOpNscNf+rRt4W1XkTgfEMXwsU1w0MOhdiHCQs8HJpozimIGuizfj/KCvGWsGesYd04Go6Rwdv1bHuCr4AxnNONxLt7SPaIwz6EylGWNY7AO5tILdWMwONgewLyylydi1Oa/++v99+CKWHDVl9t6b6mbRrSGwJ1Tu0F66+jZxN8rZE9zxNfWYUVCwv6Ch0GOAUVszJoSJUIH5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmQpVO8NiFUtFqHkQV5wqyvigmg/eFXQcEwnAax6gr4=;
 b=pb5CIETo6o4AObpfJcMG6VVUfduhd9+iJtPHSYz9qjLJiJvdCxlo6Yg7bU6w1q5rmboJuQHzu4oMcSyeA2n6s1DiKFRw+Hx92qDqQUHL9UOdPuOMlxFJgjukwtTEAvbN9BJikvEUGYv5sT+htq/3wiQv4ams61mIYaFCUkchZiEtjQPHQhk1VZJRIasuNSfpd+wpZVqjx8Mn8dNztY4MBoIiVwLCBnCbaHZ3fH1NZzMaURYa0uGZ2MXGfSH4LrHVYKEw7Z0SlA36GoJrJL+zJKtaBy8TiXXgtc9023nF6Vo07Y14WJWwKVPJ8gZGHsqYPx6EqE2l9lKMUcPklUJ9Xw==
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com (2603:10a6:20b:4e8::10)
 by PA4PR07MB7437.eurprd07.prod.outlook.com (2603:10a6:102:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 12:20:48 +0000
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::ac1a:46d3:bbd7:ab11]) by AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::ac1a:46d3:bbd7:ab11%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 12:20:48 +0000
From: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
To: Lukas Wunner <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Thread-Topic: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Thread-Index: Advmgv6S7GDW7X3MS1+pFxVcKASISgAEAmmAAAAW13A=
Date: Thu, 26 Jun 2025 12:20:48 +0000
Message-ID:
 <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
References:
 <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF04PxJ5WqIA7Je0@wunner.de>
In-Reply-To: <aF04PxJ5WqIA7Je0@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8508:EE_|PA4PR07MB7437:EE_
x-ms-office365-filtering-correlation-id: 82e3ecf9-72a6-4280-d469-08ddb4abe20b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7qdttLqbUqvVK6Em4xRvZLd424/C/TQQzQbz8NMR6Pfq2gbsDT/ns2PSBmfX?=
 =?us-ascii?Q?Qd4vRi0u73bg+C808ud8O5T4FjhzAWUjDeQ1CvSCXA9DG9Edp4lERJgGV9Vm?=
 =?us-ascii?Q?V5hbD4Gc4UadC08lXlySxGnPh5hHV/kwPseIVH4qqi8GJYm6l8oujTWFWF9N?=
 =?us-ascii?Q?G7NDiP+fuod6hgav+1awRdKfldFA+kTSn4nRrQXcx8+UDnStmZtpL0ceTcuX?=
 =?us-ascii?Q?dMDvAEtzKb8j8cv7jmMyCfR6C4Xe8uxoMsbNoFBR8rUsAsyGou5PMMxSGds6?=
 =?us-ascii?Q?1D0jFvteilOitkadH8uankWZT9lQ0UlEhjwfx6X9T/Eq27iyHe86eJV0XY2C?=
 =?us-ascii?Q?0hhSEjHkiuhYP1KOK8wreILB35sCbfg4JhfYiy4EchD7jyqGa+gsD8419ZIK?=
 =?us-ascii?Q?+9FBzmezDm4PAXSBguW1tlwA/tke0NSJ9MXCFiFtH8WWULXQhHG2Qk+/WSvU?=
 =?us-ascii?Q?IN+W28uyRyDTcW3nTYa5iPrHbHZLp2durUo3D34f+Xi47cHgAm/WFmn5vlBE?=
 =?us-ascii?Q?SD5V//0q0/PPATxfmuejZ3MyTH2v+kPEFD9O9D2V/Nw4dCixxJ0eyl7m1udg?=
 =?us-ascii?Q?m3tu7sALIJPVcejsQsd+F3HTEQ/In0sQx4A8uzL5hWEnEm4xmjjzklvLW12D?=
 =?us-ascii?Q?esOxSYMdFT8y69DXZtcsnp9Usg+As3nnAiQ8RMM0Yc8xdOV3zcdoG9Dfl2pH?=
 =?us-ascii?Q?r/HWG7HZ/zAyYduzVw6HFgVmv+QbFbDv8c5fJSaygmr7DN/UxuSbWmjANY6d?=
 =?us-ascii?Q?VYDLK/qMxu2/sD2fMJPvVIItAnYhIPpPBfXlDkgy/k4U+TGtu7IyPTsrdkae?=
 =?us-ascii?Q?hdQnsR9VFfvSDNnOv57DOYhg7z8zkKGL/wuQdrWtvIaSn6eWFvm5Mjz232li?=
 =?us-ascii?Q?SeSeA/lW1uNxZI60PPFotYJjUD4WnR0mQ8J4T7YFM/Aq92iok9xyWqym56DP?=
 =?us-ascii?Q?HeA29M10OsGHm0KK6XKU591IueUaJ8OqoS6nwdMzIe9n+E2pNAODp0guRYpZ?=
 =?us-ascii?Q?gg5mZtIGRE6YJ0KSg0apuPB/vG2KWArVzgApHdSnGI90JqRutCc6WwxiMOih?=
 =?us-ascii?Q?Y6gAkE8qkUNyNO1KIPoIAWMNg+5ngEx75X+MP16IIbVYGKH2b161ua6H26DR?=
 =?us-ascii?Q?VCQ55YqRZgrU7zSHalYJjqqPgNZ9FuY1m29dy1BC1F0+RHqcIMmHcb9xV0KD?=
 =?us-ascii?Q?9Cs2+TTQSmMH5bUAMzW4YMcqiV/K0GgLg5rhTfIFa7DVjVFHTnVqUoKHUsUo?=
 =?us-ascii?Q?JXToqJXNl7c1fbwTpodQX78eQQL9BWD2w5pbpLc4qA7UpM9g7D23vfWnFlUp?=
 =?us-ascii?Q?fiBl303Iul7Oywd3O2RQr9cOaO8YJeZyaBiN1kGDqAiCG+2/ktJ1EtB7rk01?=
 =?us-ascii?Q?wAP4L5e6kruziR5H4nGLToJK4rJhKoCMiSchzG52Wy9DvsNvTC5CkLjX94NQ?=
 =?us-ascii?Q?Rl9DggF1YsE+IrCvNAf4oRiyuf0IEwJ4b3tW/h4kWvn64/02U3YEdT/NF5lX?=
 =?us-ascii?Q?5cvn/u3WnZQeXqY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8508.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dbytifk1Yi8F4NcclGNRD3k5r5xS1ITHSU2TouNrIVB5QJgWQSbQxf7d2Blt?=
 =?us-ascii?Q?4JiZCF7xnN8IhRqKO4rftnWOBVqo5BFLbqzWliDE790EZg1nSrfE0s1EDFkX?=
 =?us-ascii?Q?+O7iCzj9kOC46gx/R8piyQga4e351QpwdgjEnu5TVaapKwmYAjrEsUVCniq4?=
 =?us-ascii?Q?9KrrFz3wwFMWO8W9Oz09InGdKvXAr4qdngg8WgTerlq1cpR/kVy0ecNF0i9B?=
 =?us-ascii?Q?ArIVdT4uSY8+f3GOU1b3t4FXAJokVqgWQP14cvW2qyng9YReVwyOWke2vCRY?=
 =?us-ascii?Q?gDQ7dk21jx6JvjYAi+Mp2DFNkVYN2Klhjq0DL0XW+uhWQsaQKj2t/MWM/Woj?=
 =?us-ascii?Q?m017n8FtQ3EAkQUqiF0gPwYpY/LKi+8NExmrLXYOu+WHnc7kkHlOE9BU6Eez?=
 =?us-ascii?Q?0AfGchSUW7xFf4mKKqGoibO1NRTDxinsEN56U9KrwMONxAqimaT3UXf5rHOg?=
 =?us-ascii?Q?3kiH6p3nrMuSvmQO9uhhosYtLc/Amw7Spw4W8/LKdyWOFQPHK8E2gluMb4cu?=
 =?us-ascii?Q?ucigPe5frbeqYK/zgsKegBQfSQfXY62yQWJcdXpSeUyBHlPPsv/VPlVoHCR4?=
 =?us-ascii?Q?5OiMtu9v4wGp823TKDFiYxMs/zL/mOg5q2GgbOl46NxrKYVwbylkScLQGD9N?=
 =?us-ascii?Q?a7jCLBpjFU7a3/vEw3CAr3MlGa6HBQuV8mTDQYUrk3Jry7jTw4/eGfZVwYNs?=
 =?us-ascii?Q?nDkDAoFp4XXP4TyaiPY25gM9hRoYlkob4HjHVfVcs0R2xi/0lBWM4ZIo3q75?=
 =?us-ascii?Q?RTGDsTgJTitTTf7ofMRXr4mREr22S7j1fTCWkC0J4mSLrcxP8qEZvPr+10ji?=
 =?us-ascii?Q?9EhphHSpl9ZLPH+dODz0N0PunzzN4eNJFvopUhvqQepqmJN/y+5j+4TUxvJE?=
 =?us-ascii?Q?kbO+V2A9jnwfndQ/a7RGrEb090dJWfFicpp/j8ucZidllGDkQaYydmKNNQ5i?=
 =?us-ascii?Q?9PwBjN1EsYynTXk1tjM+wHMYQ/1vJ+ZdR0EAO2eqFFapb1nEObz/MzEJiTpY?=
 =?us-ascii?Q?GzaQ+zn6hordA7R99VX0pLZpWQ8RyB3czxEzdCCoLHsK0e/SsnJ2JQYj6PiD?=
 =?us-ascii?Q?gjSsL9YHf006YcOxSkOZ1BifyxNBuMBPd6u8Znl4R181+y1lRG/11XWeOhV9?=
 =?us-ascii?Q?ghh9jSDCwxvK8MXFbcyjSPtOwOUgtssZ6RXIYjqdeIQsapY1vZ4XiZaidO0d?=
 =?us-ascii?Q?iEHuQW+ikM1nxd1HbcgFRKehocufK/jY+vYeA7EpNg7/KQBMs+VaVUIyJEig?=
 =?us-ascii?Q?ARWFpHJ1vpMJZSJDaRlXWVGB4KmoUSXRsKynEeKMISuY9ATO4X2kRVCN5pjv?=
 =?us-ascii?Q?cD/v4jjdOAsfC1sZcpgA7mNgpNA209GEt1n5uW0WXH/mPsYZfhGoijJKLkZj?=
 =?us-ascii?Q?aVRaqOO+iH6mYezqNdrVUsvgLg1BiAy5VAWZeAnKw2BjR8DPb2NyVrNswEC3?=
 =?us-ascii?Q?/m58jrspYCKL3dJO/cwVnuA/BI0WhNOtURMwkYRQMXGIdWMIvZOvrOgiiTtk?=
 =?us-ascii?Q?0CmG69u0/r7ikba2A/vvkQIc0YHc0RQvbRFjOlojUUuHij+clWwXKkVDLHa+?=
 =?us-ascii?Q?I+bqIguOQnBMpJVHtsPT3aq00xq6qiO3wYoHw9wM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8508.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e3ecf9-72a6-4280-d469-08ddb4abe20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 12:20:48.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ck3rgqBpPPrE9PRMq8s2OGoH7JrWdDtEQIgXFJ4gOQPcWEmW2MOyTP0bL9xgWq7Ev8ynh96jGBvHqDLXGVulmfFWzsk5gJxc2+wrge2ohuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7437

Hi Lukas,

The problem is that when this race occurs, the second NPU (PCI device) rema=
ins uninitialized in the kernel driver. And I don't think it's specific to =
the driver and device we are using, hence I am asking on this mailing list.

The driver keeps internal global array of initialized devices and their cou=
nt. The working sequence is this:
 - call pci_probe for 1st NPU, store it at index 0 in the array, increment =
count
 - call pci_probe for second NPU, store it at index 1, increment count

What happens in erroneous case:
 - call pci_probe, store it at index 0
 - call pci_probe, store it at index 0 !!
 - increment the counter in first pci probe

In this case, datapath on top of these ASICs does not work, because it expe=
cts the driver to initialize both ASICs.

I know this can be fixed in the driver by proper locking and we have contac=
ted the vendor. However, I think this can happen in any machine with 2 iden=
tical PCI devices, because as far as I know, existing PCI drivers usually d=
o not assume that probe function can be called from multiple threads.

Thanks,
Jozef

-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Thursday, June 26, 2025 2:09 PM
To: Jozef Matejcik (Nokia) <jozef.matejcik@nokia.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: pci_probe called concurrently in machine with 2 identical PCI =
devices causing race condition

[You don't often get email from lukas@wunner.de. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Thu, Jun 26, 2025 at 10:14:00AM +0000, Jozef Matejcik (Nokia) wrote:
> We have one specific problem related to Linux PCI subsystem.
>
> We have a device with 2 identical NPUs, so 2 identical PCI devices=20
> sharing the same 3rd party driver. Our problem is that _pci_probe of=20
> this driver is called concurrently from 2 kernel threads. It happens=20
> more frequently when kernel debug logs are enabled in GRUB, appr.
> every 20th or 30th reboot of the device.

So what exactly is the "problem"?  Does something not work?
Do you get errors or warnings?

> So the fix is specifically related to devices with multiple VFs.
> But does this take into account the setup with 2 separate, but=20
> otherwise identical PCI devices? Is it possible this can occur in any=20
> machine with 2 identical PCI devices?

Not unless probing of one PF creates another PF.

Thanks,

Lukas

