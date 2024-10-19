Return-Path: <linux-pci+bounces-14900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3329A4CB6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CAA1C217E6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42231DE899;
	Sat, 19 Oct 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GR0b06qe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB918CC0D;
	Sat, 19 Oct 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729331886; cv=fail; b=kGXqWKHd/rXAHy+a6RgWKAnbFrC+g2UMwcCLXsYJx1ZGgP9o7VoFVl8INheZDwzxyMTmllTTwUmiKghqgAbYnwKcZNb461APlbr2I6SCPlo8A+8a8haTqosN5syGSbJvNVpMa0aOpeg/GDUduF78HPBJAW4FoSAxcZcgBOSjfZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729331886; c=relaxed/simple;
	bh=D25z+zdDbljCxTg1zUngBj3Vge11mayb0+n92x0z0iA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myIrObDl46C2E4DWoS5cecuw/KQ8Z0lmYOknttAO1C/Ferc9TJNTvJ6FRVaq9SS2HyNmdkfrhyvA6zpkY58k545qvcjOGSqinGpMJ9L/aEBHiVSVpHJ4p9KZJBHn301Kgqc11Q1E6MWNyJAEHvyfvEmq64ygK4EXj9O7ZDkn5XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GR0b06qe; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B41/iy+YYvojAMdzoWD4ro1MelGgtwNJqTAnvkj/p8AvVRcnJESf/PNFcutj/Uc8CpvyXiWOIzk1FmvO4Rz4XmxZG/WUnsI5EJLrZFkGOUUzu4UGrle/0LhUY0tARb7Kvnq+3UYaieFh5aT3YkrAJpfJJmgCjznJMazy1sdlJS9rgS9Tl2E0CSiQOtJTpAbYCYHpoE+399TdiJsdpGYoYFOmLim665gfkUwYBrHpUGwFD0mR2xQOWgUvjrw/2XwWa6sH91IlgewoPy3eIIblpyAGp21Rt9HB83KDYy1cGovdUWstw8vjTfipDmubqmx1XBfO2oR5UGitCwhJrtZx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D25z+zdDbljCxTg1zUngBj3Vge11mayb0+n92x0z0iA=;
 b=fD2l/SqEGFgdc67PKAbhUdp2EZSeLzT++/DHVT1epj2pNngN/UK+QbHTJ6Aix2ozDW/le5ecCKV/1YQFfcks/Js9J4zS8G7b+UC2Gl/HFmEI2jFN+CweNfvI7FXpto1tpyl40QN29zpFWpBqLye4SACWj6fGWjLpKR2EM4mdtziN0kfyMQK1G3XobQy+d34dWgN8Dfws8ejwSlohohluMhkwS7OGxROoV3fAIVz1YP2tCyvZMDpnvVSK1HdC4vz6IBWYoGkq2ZwHX9/eEk/RvXbdAiJgZTNvlsvzBWBqeovPN0LJsdpLoASHJGjdvMT4Lcn+bOmxTDlxstxwqeZ4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D25z+zdDbljCxTg1zUngBj3Vge11mayb0+n92x0z0iA=;
 b=GR0b06qe8iC4wpBv07mInWUiy4L5pRLchFA78eSAA3l3xfGZT9/x0xQiebTpltPzoiZwHClPjT0aXI0/n9T8NoNbs1OQiY3hfcgfGGX0/Nh6O8JpQfvGeGsd4gpGOd65ERT7VXLpESNYjT+aEtDMlTCWf3F4RwkRymeaw8qMIoAxc/eMzf0jZnKhqNhdQIblFUeTrJC4SAEFnzKkqoNUXG9HX1ywLkQDZg2GMdpKcMqf+KWEmhEwZLShhmFzv2gFe4tr492SJUPe3k54dis801nj2rdr3cnC0LdFMwkPnVJTZ2UheGec0AImfkRbHhNCNulbqDRxEfv+DyAi4P1nVw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 09:58:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.016; Sat, 19 Oct 2024
 09:58:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Frank Li
	<frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index:
 AQHbIGrTTA2gJ/XR3Uu/G3eAF75QCLKLINqAgACVsjCAAF1VgIAADtvAgABBIACAAXXCwA==
Date: Sat, 19 Oct 2024 09:58:00 +0000
Message-ID:
 <PAXPR04MB8510E4FC9676CD4C133E607D88412@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <3657116.R56niFO833@steina-w>
 <PAXPR04MB8510B252A7EDE73B2E1F00BD88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <9407049.rMLUfLXkoz@steina-w>
In-Reply-To: <9407049.rMLUfLXkoz@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8887:EE_
x-ms-office365-filtering-correlation-id: 21b4ce5c-6a36-48ef-62f6-08dcf0248425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE1HS01OVStXbS9jaEMxZjNlSzV3dDhLaDM4T0lhWjBMMVJXNmZVTGh0dkdq?=
 =?utf-8?B?eGdhSUpVaHRMc2NRK1M3R2tIQ1F3LzM1VFUxcEtuR3RVQkh5MXlyVlB4cE13?=
 =?utf-8?B?ZlJiV3dJcjc3ZnhFdjc2WUtzUXFYR1NPZHZvTUJkREpkUE4yUXRlNmo2bTBC?=
 =?utf-8?B?V3ZSVW9UT0d2cSt6Q1dvb0lQRnNFdmhWOVZpdVRheSswTUpxdVhOemQ5VTlh?=
 =?utf-8?B?NDhCK2dFZWRQVm93cnpDMVp4YmpUeVQ3MHNUWC9ielkwZTBRYUpSUVVGTWc4?=
 =?utf-8?B?eTdoTnN2amRjVlcybUE3UW4zVnVnb0Ntb25sQ2xGVjRvY2p4TmMxM1FXVW5t?=
 =?utf-8?B?aVpXTXQzTW4ycFJGNDRLRmZ5UVBjZDREQ2ErYm9kUWJyRGh5WW1NMDAveTF2?=
 =?utf-8?B?Y21pNWFYQzZOR2lGQU85bFptamw3azh4ZmhrVGhLSXhSTWYzeWpSZ3p5bFNy?=
 =?utf-8?B?aDJYa2xGTWtWTENRK3VBbjZPYWNhVmNCNTh0MWFwSmdlWi9GWSsrSzJjakxa?=
 =?utf-8?B?ZHJ1WHo4VGhxekJ2VFI1Mm1BWGFsWlBnUWlQdkprcnlNbHdmUlkybnRBK0tt?=
 =?utf-8?B?c2tVRTF6Q0JzNzNsNXZPRnBqcWgrczNlTmcrQ0dRNmIxMnJrQ2pZS0ExSHVO?=
 =?utf-8?B?N0t2TnRvS2ppcHNUNms5ZzgrWG53d2FXSEZQVHlQb2wwM3FpNjdyRXhmR1ZN?=
 =?utf-8?B?WmRqR3luTHdMMkVWZlBGUWZvR3lEUVllL081UVV5R1RFVERmUXpzc1NiQ2RT?=
 =?utf-8?B?N1VyNElRaWJvNWdqSTJXN1NoMEpSZGV2ZTRsWjUvdVZ3V0xuMk9jZ3JkTlNO?=
 =?utf-8?B?WXl3Zjg4dEVTRHF3N0lDQVVjdWdnR3g3RFNUZGtkaytRWVd5M2V1THF1UkpD?=
 =?utf-8?B?WVFTbENrcUpQRUNCeVJkYzJ6RWNtZy9hVDZGTkR2a2tobEpyeWtNdGNvY2dI?=
 =?utf-8?B?Tk5aa01hNGhVZ1g1eVlMUm9iM0JDTVBBVlQ2alpVakhZTk8zRFRYV0ZDbE9O?=
 =?utf-8?B?UDQwUHVpUTdvN3RnK2taOGJHcEl6MzVoUlE5aDBGL0dpUzdvd1FQcGpFRkUw?=
 =?utf-8?B?ODNORzRFa1JlTzJVaWdpMUZGdnVJcUd2dFAyWlhhZ3lEdXZrS2hoN1VWL21L?=
 =?utf-8?B?UFB3dTNJZndWR1d4RnZvK0JOVmZzVkQyUG5QUkpPMEtDTzRTWnVtSVoveGE5?=
 =?utf-8?B?SFVQaTVUTDRwRlY5SkF2RFlzcEw0TU5EaThRdk5zSEsvTnpiREh5b3pLenJN?=
 =?utf-8?B?UXozMmJtWHlGUGdBNDh1SFphUFFlb1FkeTRuVmZ3WVZIOFc4djlYZ2liclFP?=
 =?utf-8?B?M1ZYU0tMRWhlY1ZHSUZpY1NJYzhsVEs2NmZlMi9yWEtPTGlzNDhNMllhU0ZE?=
 =?utf-8?B?U2xwQnJuZ1BYajZES2tFOFNuYm9kTGFHRWVhYVJVR0ZYeDBsaVRXSXlXVFQy?=
 =?utf-8?B?cHZONld4UUF4RlJiZElJcFVuVW84Y2Y2K1d1OUV1bFArckx2OUNNMnZLU1JG?=
 =?utf-8?B?amVlc2tRSHNiQjFCRGVvSTczSmRlVWFsZU41M1VZR3kyVStEaDZ4dnJDd1lu?=
 =?utf-8?B?ZC9jZDVTSHFPNnh5T0RjZGdFRUdrSWZ2Q2IzMzc3RDVQWTR5blRLSU5tUURM?=
 =?utf-8?B?UHdyOVNoUmg0MGNFRjAyQUQxQnNuODI3OWt1VjdiemlNWTQySzlVVXdOVmtZ?=
 =?utf-8?B?c2pRYmV6M3VvVFRBY3hwbUJRNjdxVHVVTjY2MEl2czUraWZiL2pENVhJckk0?=
 =?utf-8?B?VTFMVGxld3owQzYxcm5rQlNIc0h2Z1owKzA2bjRBUEg2SGZOL1c4MzV6dHdO?=
 =?utf-8?Q?/9Ff5HR+f039xXq1pI8fC71Gg2raMmJyYtLHM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWtVWVBtZHFBZFpkbThVcFIzQXlqdDZXOS9YM2dINmRxbG9VRzdFYm1GNC9k?=
 =?utf-8?B?NnlXVDAzdm5rSXZMQTdEUjRpdFVtR2ZGY3RkdXV1Z1V3b3JxUitZaFpCcFZS?=
 =?utf-8?B?d1REOFk2STNTN1FXSDM3LzRzSFFmaW9pQTVWS0xVZHgzbEdGL2lJVVVUUlJ0?=
 =?utf-8?B?aENSU2xOM0M0RDN2QmNobENqdFpadzRnQi96N0piY29jcXo0d1hINFZwbVRt?=
 =?utf-8?B?NGR4UlpoN0pxbEFMR0VuaVV1QjV2cXNtYlJubjVBMUFUaVJQSkFDdXdRZExs?=
 =?utf-8?B?Q3NFbFluS2xQZ1hUNzAzTUpyZ1BCdkJtSENNMkx5UUNhOURFSjhwTzdPbFhv?=
 =?utf-8?B?VWgzVjNTN2lucFBLdGpnQmRFbnZMOVN0MGdWM0JhdTMxbTJETHFMZnN5SFFK?=
 =?utf-8?B?ZGt3cXpiM3FwSlM1Q2xZZWNQR0pQZmU0Tm1EWEI4ZTZKM3c1QXZNYndpN0hY?=
 =?utf-8?B?V3luSGt3U21XODlPbXlvR0FtUVhmS2hwbjJrRTJkbGl3NUFzZFovMnNERmdz?=
 =?utf-8?B?WFZUS2xJN3poUDNSSEZPZFo4dm5reDRnUjFVNXJqU3NWSFFMRzVWZzlmVitZ?=
 =?utf-8?B?ZTZ5b0M3N0dFOE8xcmp6RTFxTUQwSlZ3SFBxQjg3SHhMekNkdkJ2VDMrOTJS?=
 =?utf-8?B?WWdaZC9kdURUOXdybmpaaUZsTVh5K0Z6d09aNks4U0JTNDJJYklEaTJTY3N4?=
 =?utf-8?B?TDBvWnVEZCtNVnMvTG9yVm5NRGFOUkZ0dUttMENjM21aWlNiMWtjcWNJUlRo?=
 =?utf-8?B?dy9Hd1AweVFaTUIxc09nT2NLSzdDMHVVVVZBS0dGUjlRL2FyZFFENVIwbXp3?=
 =?utf-8?B?QjVCL1lmaERwSzBHeW84Rm5NbTRvTlBLVEdhL2tOMk5OcjFvY09NOGFzU2VF?=
 =?utf-8?B?aHZMc3V3UktnSGlZQStWOGZSakJDcjFPRHFHTnd6aTE0MVdvU0VOZ29kbnNI?=
 =?utf-8?B?Y1ZQUG9zaVlKa0J5TnU1WFJ1UnplUzJKSGdpTkZ4ZjlpYTBJMnV4QTc2VHpo?=
 =?utf-8?B?cWZUUkp1UXdQVmFSTDMwTzBlaHd3bTI1RFRkUjlvSEtMTld2THhHZytqRndN?=
 =?utf-8?B?QVh2Y0lzdzFRVFMrWHFma2VXL0Z1U2o1ODVTTXFXQjdoemFwZG9BQml4cEht?=
 =?utf-8?B?eVNURDFuTjc5d1B0TlpmRGc0dVY5RHAwanh4TVkyV3hDQ2szQ1pUM1J2dkJX?=
 =?utf-8?B?REJndkxLN2x4ZEJ2V3g2V2xiRXdxR25HK2tLZFZ0ZDlCM3VxQlZCZzhxZXg5?=
 =?utf-8?B?ZklvdDYyYXMwcm5zeG9SVmZXQ2I2T01RTlJ0cHRNR1ZPdFBhWXJqNkl0Q05i?=
 =?utf-8?B?ZzRndGpaSnZoc1ZIZWdsZjRLbjhOOTlZTWo3UVF0MzRJdEVIRnIvTVRrTE5Q?=
 =?utf-8?B?RDVCZE13R3UwUk5hNmlmcTd6WGRFbjFncGJ0SU5WSzhBU3NpZkp5eTBpSUtR?=
 =?utf-8?B?WkdzVTVBeGdVRm1PYmJaZ3licXh6TWI5SGFvQVlZS3RkZCs5Y1dpVlQxWGVE?=
 =?utf-8?B?d1VWd3lyeHBWMERvc0JFUUF1YmtBbzhsVExrYnV3Zzh3OFNqc25xYzlqN1hm?=
 =?utf-8?B?WTNTYXlrUThhRTJUVnZDNEtJUmVGYkZYMENCNW52TXY1T3R2N2NnTGd0ZzV5?=
 =?utf-8?B?S2RUSk43QVJIYmtuWkxHeXBqR05vc0gvQU5iU2k3QWJvV212YmMzdmNZVDBv?=
 =?utf-8?B?bXE2RndGd094bVRrdU9mZG9BZXh4cVpPeUI0bzF2NmhxVFQ3aTRoa0Jlazlt?=
 =?utf-8?B?RFZTOGoxSkdPbjJlZVY0a3VzbzdoVEQvcWlsS3F6Q3k0QnM3U0JkVTd4aUJF?=
 =?utf-8?B?L3NnOEpaTFBVY3B3UXlDRU1nS0xDQ1lrOVVFUmZyTHdUcFBXanR5cUptczV2?=
 =?utf-8?B?Rlp1TGVBRWJLaVE4ME5Ud2Fvd3R4ejVYd1U5cDVra2NXQTJHbE9CZ2pYSEZK?=
 =?utf-8?B?SFRiM1NyWTlmcGJEZEp1eGtZUW9SMXNEZk1zdVl4Q3IxRzMwd0hWSTVJSEd6?=
 =?utf-8?B?Z0h4bDZVTk45dU1BajZxcHg2a1AxUVEwV253cTlxUWpEVXU4MnZXV0FTL3du?=
 =?utf-8?B?WU50d0Q3a29VUCs3SDk1aEVtUXVKbWxHcExQQjVmODB5cXpDV3Nwc3UwdDBs?=
 =?utf-8?Q?LCOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b4ce5c-6a36-48ef-62f6-08dcf0248425
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 09:58:00.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWf4yrI2plM5NaUmuusEC/pCkzCeLq7QAczNZCfiaqjeQ8dFSaBnMQ4oD3rN3z0pa7w3T3cgpQuuMYIUkqWAAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887

PiA+ID4gSXMgdGhlcmUgYWxyZWFkeSB0aGUgRFQgcGFydCBzb21ld2hlcmU/IERvIHlvdSBtaW5k
IHNoYXJpbmcgaXQ/DQo+ID4gPg0KPiA+IEkgd2lsbCBwcmVwYXJlIHRoZSBEVCBwYXRjaCB3aGVu
IHRoaXMgc2VyaWVzIGlzIGFwcGxpZWQuIEJlbG93IGlzIG15DQo+ID4gbG9jYWwgcGF0Y2ggb2Yg
aW14OTUuZHRzaS4gRllJLg0KPiA+ID4gW3NuaXBdDQo+IA0KPiBUaGFua3MgZm9yIHByb3ZpZGlu
ZyB0aGUgRFQgcGF0Y2guIFdpdGggdGhpcyBJIHdhcyBhYmxlIHRvIGdldCBldGhlcm5ldCBydW5u
aW5nDQo+IG9uIG15IGkuTVg5NSBiYXNlZCBib2FyZC4NCj4gUGxlYXNlIGtlZXAgbWUgb24gQ0Mg
aWYgeW91IHNlbmQgRFQgcGF0Y2guIFRoYW5rcy4NCj4gDQoNCk9rYXksIEkgd2lsbC4NCg0K

