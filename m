Return-Path: <linux-pci+bounces-6278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9AE8A599D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DA31F22CFB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718248248E;
	Mon, 15 Apr 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mk7KiGMn"
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021007.outbound.protection.outlook.com [52.101.128.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63E13A406;
	Mon, 15 Apr 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204933; cv=fail; b=XxieeS0efKxUZA6iwjagtQDxohYbX2aBtXxcbcF/dB5LlzCQUp5IbcPfI5y53xrqdRQNvi9Jj5exkhunUXmtQrf/o6appVZitWdJtl4pCeQrBjjF9v9bMZAzkOrl/h2kWh0B8h4EViPl0PlIvgFkG3j9GrPLakyAqizkUNaGJFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204933; c=relaxed/simple;
	bh=jHUdvvNs+Zql2D8HxNLWkmDxi1ZVL9zHRJ/tZyjVwtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YiXMkv1SKf+xZ4HuKBjr7MyUgk8SbxQ5m4fg4vutW9BO3fTrnby0ysTF95PXe/XBX/1mHQF/lTEgws/8Vq13MwD0LONerFbLv5edFQV71SciSM36VvMBuzs/gStZ9M8jGpuPH4mhgw0O/LqQHJMdKV6FTfOjJC51fiojnzHfBbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Mk7KiGMn; arc=fail smtp.client-ip=52.101.128.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6NCHq8qAQwd4V1I+NcTcru1puDTyCwv1KgXs+CBBhcDZ98G9HaVkg4Z6FyCdN/3GIZHyKSiVYFhtbTpGkgJ/zjs/bo1Arxo9YvszjP04L6HaSIbG5ky1GZvBidq/FQrJjCereVjVyCZCOKzmBEEZe1F65rTDIk3NTMOuVWpPmRDu8x2VZ1LXK8YLRyjpnUW182nhYJtYJO8ykzbv4zq+It2KEioVIG6HQOrI2KkpNDg+txAFHf8LFbrXLYX+seS4RuS1IGTtw1xBW8GgbxKTrpJ4hWzqCrgB+Gf4d0f5IcgQqYS1kvGRi+AE/vcYubFI7FyzA2qDRZqg3180i1Djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKlHCtro5eiV4RPpoW/fEKWPLIMgNtDUsPnQkL3ueeQ=;
 b=Dh4OYQbIBDPssYWW1Ue7/ny46iYnzwrbG4kgzWeoc1Woykkefqzpikcniz6HWWzXe7mm5dY65zsp7ILes1ZbgwsJb71kYeTTYP742uKlUkm2yY+jxM+yeWb0ZxnPVpMFtw/6EIlbIdjRLaU1VJelU57YY5ts75uOB95/4SMvrQo5E0zU8SLdA63FZuNe5wB3vG8B3b4sjowpzdqIFoc150Hp13jiRV5W1bYQ0wmU2OoX7jAJvlDh67I4cHV09AXdRgzHFT4EgvPrNSO0lipZC6KCh57DiZBhVgHewJ0KtJ8EvJCJ7HOk0ZiXgWNQeg+YqQ0pEXjWgdLLRXzUIRYp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKlHCtro5eiV4RPpoW/fEKWPLIMgNtDUsPnQkL3ueeQ=;
 b=Mk7KiGMnFIi1ddiPH/BKFl4AG9sdCI2FlOlYJUdWTln9XhurqBVuG2fX9N4W3kS3wfsSRB7MgPnG3ltFJF0KgI1sUV38gPMDiuJ+AQx23KLcgdB9uFrNPcs16t62mYR99IEzB5n/f6w8Yjk3T/wfh8Ls0rtR+E7lqzqj61UyGwQ=
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM (2603:1096:400:28d::11)
 by SEZP153MB0994.APCP153.PROD.OUTLOOK.COM (2603:1096:101:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.6; Mon, 15 Apr
 2024 18:15:24 +0000
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::46d0:1c9a:b530:b4c5]) by TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::46d0:1c9a:b530:b4c5%7]) with mapi id 15.20.7519.000; Mon, 15 Apr 2024
 18:15:24 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>
CC: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Thread-Topic: [EXTERNAL] Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Thread-Index: AQHaaln0LoL5M9udFkyInQrJU6JCMbEgANSAgEnr8sA=
Date: Mon, 15 Apr 2024 18:15:24 +0000
Message-ID:
 <TYZP153MB0796837C6C017FFA20E94C5CBE092@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
References:
 <20240227171458.GA16664@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240228152222.GA272403@bhelgaas> <20240228172255.GA3579062@rocinante>
In-Reply-To: <20240228172255.GA3579062@rocinante>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3be92694-a260-4380-a5b2-d04b33afaed0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-15T18:14:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZP153MB0796:EE_|SEZP153MB0994:EE_
x-ms-office365-filtering-correlation-id: 5a910d68-c769-475b-8859-08dc5d78052e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?2XmF+g97+CGevLrCb1DVM1Qcb0McGNTeq+YV6qswziFFlM0xnTC1xx4bsN?=
 =?iso-8859-2?Q?dwDflmWt451KZ3UNl99+y43AYdDLfRiHvbM/rk7Du0opTerk6LoVKUXDLF?=
 =?iso-8859-2?Q?qqzJZSyb4YU3srLxU5SiogW77s1UO4vLNAzI4qbhYlObawQMu7HzlsvFAl?=
 =?iso-8859-2?Q?ZfDjCggJah7JYGNsrnQ6Kyf1hEJPa0yibLNjfVyySjGBVbhhIhth4jfdKB?=
 =?iso-8859-2?Q?F3/Nclj3qfqu36TKKFroCA+n1oefWdtlpWy0gOlqz1NOyaq0oTGr92FbDF?=
 =?iso-8859-2?Q?XvjIL47Aj5jrU6+mE4yKTWlDOfxDT5lZyMOyp52BHnkr38rQVzFUPnVR/5?=
 =?iso-8859-2?Q?Pv4JQHdYszV+ACMR4DONV75+HLFVxhdyel6NnDKFjqAp9+5IRnYnWlXawl?=
 =?iso-8859-2?Q?f7E8nOm1LRB4OCQD9eD+gbchDcR82Np0iav3R0iyFyakqM6D6OYM1vssaX?=
 =?iso-8859-2?Q?/rAs58CoKcd8v6iuKC8Aocx/VhUsOMl+o3Unz5zSmxDMPVvDgZwfs+nvxB?=
 =?iso-8859-2?Q?Ob+Yipb1GxDXL5CNhH00uVnKDwKCSMUS0RrenzC7wM2dZ8XLhC2+bdErwk?=
 =?iso-8859-2?Q?gLfUKW6g6B0hGvFOUeYP8Q7Bmn94bfKeiFeA+jqFJoj6g1Gt6HyiX4QJJ4?=
 =?iso-8859-2?Q?zCpdBNSz5Exoh4os1tPoSekd42HXmPLokyIH8A9eiyzDMHsg0kwv24YvPN?=
 =?iso-8859-2?Q?Z+w8+FWY7mYxatbMk793goIu1lVi7Z4bg1qhhfE+uW4bajL20ccP0yG6Yo?=
 =?iso-8859-2?Q?Yq62uC5YWOBavocxbe1KUwADQ3Y29yjbMHgptDRyyqbxzEJxC9axrBAIry?=
 =?iso-8859-2?Q?rNtW6iUDbsfK8WiIYxqcLRVbYRvSI8J4ULmc6QbwF6QW21bgWInVpBCiqZ?=
 =?iso-8859-2?Q?RUuPgiiqJ9nqTCK4sS5CtYexTQxlzEZhMPu+goj5xP3JR+OO7snOhEnKWX?=
 =?iso-8859-2?Q?Ngjv7DvK6WBCjMhrkGOqriqcko4TpXHgjlHIa7C3FQlp9rce/+nsTAtla+?=
 =?iso-8859-2?Q?iAatFl05yHfwhFCpHO8/r761bu2mfs+tQnMj3P5zj1wozfAfCmLYnjYmzo?=
 =?iso-8859-2?Q?ZTJhZLkqlshC5CkXzUYteI5J5dKYYya4+iuHwv+HslkfQSDgtyhxr6HXFT?=
 =?iso-8859-2?Q?S/MSy/rfU4W9geU/AEcHC9PuXEG1UTJ088OodmU1LSGrTDT4noBeftaMAS?=
 =?iso-8859-2?Q?7vICzTPDc6YMyFGABAGbq9S+AN13IqD4kZOthG5ondUkdKFHnHe7NWAFvk?=
 =?iso-8859-2?Q?aG8e7J5+TJ8HmfJpNLAX2o9D+YIroaIK3nRANuQyBnbumzjKEiOdp/rPch?=
 =?iso-8859-2?Q?UwFBEY2ON4KDDUvJ8mmTg83lFQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0796.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?xjQ4Ebi461jpFFudoGMz1i2Hgm6OC98PDpDyo8hs5uNKeLNJ3dM2kKi0iB?=
 =?iso-8859-2?Q?lWx6ZqvQ2/weX3NhdGCSIKaAIQn/0kO7sTGLbFT2MtV63kJbkjQXKCSgTR?=
 =?iso-8859-2?Q?Mqke0TYsUuWTQaYowzWs2k7w0F7oH/PpJOE0jCztoaV4PJS9wpUS0b33Gf?=
 =?iso-8859-2?Q?CmNxiIChxqwEbIi50jjAYr0XxjUK0lg9ISgXYbuPzhZL9MD4M8lW98bwyo?=
 =?iso-8859-2?Q?81SfOYAT8379QSq0PIQxLQ7z/A4X77B41JA3rcBaimkvYh6ThEjBzTMe58?=
 =?iso-8859-2?Q?N24EOc+W6puC/iK5ulv+lwiAZn7b5RBS70zHdtbzE6NTW4v3rJEpOFzSPl?=
 =?iso-8859-2?Q?uEYRP48+tjGZYJX+XszxUkldKFxpCbfSm4VW5cWVhP5e1OvaL12vbAYVcb?=
 =?iso-8859-2?Q?1z3S8KDB7jBLYXjmIqdBMMPH4jpypmgt4JXrwfaYiEojrQcGmfwx3GijV2?=
 =?iso-8859-2?Q?B7OrKgR0/GpGB5P+EuHNzQdx8/2r+VBg59w9hRavZkFA7qoYBBfbnb7ZYR?=
 =?iso-8859-2?Q?p86pFRFivuW64LCyLfMMynWX3AwX7qtXt85VMgkqDBYVV0F22i0PHLctf2?=
 =?iso-8859-2?Q?OvEeZMN2DUw2vIVXYD82s4hGK0TL/fj53W0AzD5K/4aSjIa2ErvNiTU7tR?=
 =?iso-8859-2?Q?8SZt4p/ROGISpG6le+MVxbrwReuCD7q8+BHwHiozKZA8RZEV2nnc3IBHId?=
 =?iso-8859-2?Q?NuqGemuNfynge1BxRIdLTlePYoS867GX6I1oo1WUYhulWfNpgHlRVttCUL?=
 =?iso-8859-2?Q?6Zu91LzqTTna6+dzDTEhdah1QQOZ74yKBHdn8GCS9+3+bGQEKvrG5akirt?=
 =?iso-8859-2?Q?njrI6x4m/6ucs+4Xvib+EN5E6oNPsAkpvidWbNCzx2GLEniemNnRtTELvt?=
 =?iso-8859-2?Q?c4FyzxgJNehFd+EHvMIJcUMozVoyeUwOBVK/4RQg4nOwnj36abxNxmFBu9?=
 =?iso-8859-2?Q?alyTDNNzK1LjrsfIzhFAHbXEd55FqlqTjAUQsQKkKTOfo2JME5k/5ExTLn?=
 =?iso-8859-2?Q?mnAo1uu2tEMHR2Tpow8Et1Ai1Eh99Eabepy1N91/NNSEJU54/r4cDzug+H?=
 =?iso-8859-2?Q?+wTv8owTMIhpuEAuv2zhjucDohkq3Yyu+0DPqXrtZ8e+1fISz8fYRQtHf1?=
 =?iso-8859-2?Q?oIU9WQctmkXplnFwyG5RznYInwWFZB9I3+cCI2mu0MEJks2ymjijoRCUoF?=
 =?iso-8859-2?Q?pRyC/x6F69TQFRKpOMoEUtXYkY0cImw56ynkeo+xGJ0rAupksJqJm8TD0r?=
 =?iso-8859-2?Q?6ifOcLCq5bOcumc3iieSgJ/IN4vjZtrnIgjKf6x6xduw6lWq2RFXgpKt0K?=
 =?iso-8859-2?Q?b/291LXtMsSh61p/u++5qjC7/pGco5rWAy2SL3V3SdTB9i/jFxJ99htEXd?=
 =?iso-8859-2?Q?DalV1fT+ZKW43Agn8YpNUNS+F6ZQxj073rrQQsrm/hlfXiCKM3AsCwdt+5?=
 =?iso-8859-2?Q?iqXQVKMToQcUisja96d73eFKit4wQdMNeERLu0tJ5qpVavZjGKRlYJMzmQ?=
 =?iso-8859-2?Q?upY8mHeypLJrrQEDvBdwPzw27eaJ+jlwT5kn8G7g9XKXBNqASgJWdgviti?=
 =?iso-8859-2?Q?k5aiE74pR9tXdtA5r1WP68f9XIDSeuY3n6Z1Jb72mkr8ERcVAa2Pqi6gHw?=
 =?iso-8859-2?Q?45ln84ZmZsaqZQCOCed9SqkhhMbAgunYGR?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a910d68-c769-475b-8859-08dc5d78052e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 18:15:24.3960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+5815MwBFWE1JU86LQRJZsSsj8cKW/p8+vnK4NDCGrBP6Ja4jFTkv5Lmarj4usMjsfs+DwPVfD3hcLkaZ0W6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0994



> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> Sent: Wednesday, February 28, 2024 10:53 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; alexander.stein@ew.tq-group.com; Dexuan Cui
> <decui@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
>=20
> [You don't often get email from kwilczynski@kernel.org. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hello,
>=20
> Sorry for late reply.
>=20
> [...]
> > > > > Krzysztof has done a ton of work to convert these files to
> > > > > static attributes, where the device model prevents most of these
> races:
> > > > >
> > > > >   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label=
" to
> static attributes")
> > > > >   d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > > > >   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
> > > > >   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
> > > > >   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static
> > > > > attribute")
> > > > >
> > > > > and he even posted a series to do the same for the resource files=
:
> > > > >
> > > > >
> > > > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Flore.kernel.org%2Flinux-pci%2F20210910202623.2293708-1-
> kw%40li
> > > > >
> nux.com%2F&data=3D05%7C02%7Cssengar%40microsoft.com%7C99b036f685e
> 4
> > > > >
> 448ddb5408dc3881e998%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0
> %
> > > > >
> 7C638447377886194494%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDA
> > > > >
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sda
> > > > >
> ta=3DTsOJsR8CQGaOrJVnw0BPm0QGL%2FAUQ0GCTuzgrN8FX%2BQ%3D&reserve
> d=3D0
> > > > >
> > > > > I can't remember why we didn't apply that at the time, and it no
> > > > > longer applies cleanly, but I think that's the direction we shoul=
d go.
> > > >
> > > > Thanks for you review.
> > > >
> > > > Please inform me if there's existing feedback explaining why this
> > > > series hasn't been merged yet. I am willing to further improve it
> > > > if necessary.
> > >
> > > Let us know your opinion so that we can move ahead in fixing this
> > > long pending bug.
>=20
> I really thought you were asking me about your patch.  So, I didn't reply
> since Bjorn added his review.
>=20
> > There's no feedback on the mailing list (I checked the link above), so
> > the way forward is to update the series so it applies cleanly again
> > and post it as a v3.
>=20
> Start with a review, if you have some time.  Perhaps we can make it bette=
r
> before sending another revision.
>=20
> There are two areas which this series decided not to tackle initially:
>=20
>   - Support for the Alpha platform
>   - Support for legacy PCI platforms
>=20
> Feel free to have a look at the above.  Perhaps you will have some ideas =
on
> how to best convert both of these to use static attributes, so that we co=
uld
> convert everything at the same time.
>=20
> > There's no need to wait for Krzysztof to refresh it, and if you have
> > time to do it, it would be very welcomed!  The best base would be
> > v6.8-rc1.
>=20
> That I can do, perhaps this coming weekend.  Or even sooner when I find
> some time this week.
>=20
>         Krzysztof

Krzysztof,
Are you still planning to send the revised version for it ?

