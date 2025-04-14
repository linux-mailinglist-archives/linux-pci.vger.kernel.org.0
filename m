Return-Path: <linux-pci+bounces-25778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB2A8762D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C5E3AD337
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE67DF5C;
	Mon, 14 Apr 2025 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A905BuvL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03632F32;
	Mon, 14 Apr 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600742; cv=fail; b=DAIIzS9mws2LguP3CP9W6/DzGqdMBDSrWqIyytJxgP1GUsDDK4h8wS4aBps2JLNmBGU6zQwUI0KnHwHG0wjLr6fr4cMyi3SnHbfyLFVwejW4Ow0cGhz+uUloyn6eYniRHjDwORGcuG+V0l7PeOJPtOLRCSLczGe5KvXIr2CoG30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600742; c=relaxed/simple;
	bh=XLt07EyMyyik77Mudy78X3XZcy+3NOfEVbSD8mTPCAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDKOt0Eqny4PcC856uiDkf+EJ8OCnS83pZL7VtSOOH3trQCcphDKXkJkxbnI2fBtdDMsivvYRkzlMZwNwYMsToe8r0G4gG7SEvXzYOUkZqR9WH1xUh8NO5WLCqEv6RMRxZdQqK9B+052WPP1TcRgJYOkyYWwn8jI3/5TdXWhyss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A905BuvL; arc=fail smtp.client-ip=40.107.105.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGfqHolDZYak782MRrOiXhW53UDRjprIPCrW4ns8j/L3USPb+HkjU9dhZ8FUlgIVnzv6Nhx1ajpllXBgOPLLpIJzMumwoAEi/0N2qCojjFGadmUBcz/XsqGI1iZunreSazYzQ6XiGs1ArCy1fgOlk5Ywmnd7TAN7h8sW5b+esVN2ZhPdukqZG0FD5rjTxZ9pY7Z7MtksVlM1KHJ3sgEX6703iNnpZ7TSZ/yjidWNyjLCWJIgz36OakIxg1CLorJggJcJEIcF7fq1pYB3SHTjQ/OhchZTEXHf7eUz1NhiBp9Dm8Nvf52bYcYytziMOvi3JvcE7HgKCe9+MpRTFLziRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLt07EyMyyik77Mudy78X3XZcy+3NOfEVbSD8mTPCAU=;
 b=IZA0bs+DYppJYfotapjoDIMsTuX7dTe9DvkV9lgjRXRwmfLSA0tKFQlEeDMBa0kHjaKimqV07fOntsKrmBw0KROvbVd8pwCUPC0mEewMrj/uOVwLgG1oHJTMQmD3yj8DJTbfvPgilUEVWHIIAEhPI7n6ox7dwfqia1epR/Byh438Ab/mJKbPF6HHU0EX7bPoeVceKtatyT6cR8ngZvga/ns5bAw1YcKIuhZZmPlX0cSIzsc1704b3lZqb9AYuKbXh6xKpwUgCGgXXcQY9aKP+ywWrozg8Bb89tWfL6uYzZUBZiDkpnsAJ72cVl7H/PuEwojzOulF775Znu5TlQMbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLt07EyMyyik77Mudy78X3XZcy+3NOfEVbSD8mTPCAU=;
 b=A905BuvLJm3KbEgi+7r4rukWLdtrzoqXubwUNy9bk5sKIXDUyscCL5USBk8SCAEpLm2aAKCEnk8jTdq1cB7l20TiRHxjjMwQIO+avsjl6x+ErolNS1ICOKVoqYleL51kQ4umSiQY497gKCqlRnxLfivPn/8lcvQoRYEApfzx1KQ5MU4uqTBA4rfN3WbuaS87oLEVf0q2R9Rp7oTBbBxzIOzZtCUUD5YV0mhCN3AbKuYu/Ks4auqRiE5I8Q1Bne0B4C5V81Hlvrd4F7bD/Kstsx5GN2jVGqpIEtdGKWGZrVJpHK3fMj59/HtZySsddfMdbOrHITzY7dt30yXdHxXNGA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DUZPR04MB9782.eurprd04.prod.outlook.com (2603:10a6:10:4b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 03:18:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 03:18:56 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Thread-Topic: [PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Thread-Index: AQHbqDJ4zzRQ6cNfcUGESF8V8EBzzrOhvjWAgAC5XBA=
Date: Mon, 14 Apr 2025 03:18:56 +0000
Message-ID:
 <AS8PR04MB8676883E80A61FF28FBB4C188CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-4-hongxing.zhu@nxp.com>
 <pnc2kgveacnox4kbdamggp6p7pjmuyan6lwucdgzyqg3u75uo7@bb6bnsy75e4x>
In-Reply-To: <pnc2kgveacnox4kbdamggp6p7pjmuyan6lwucdgzyqg3u75uo7@bb6bnsy75e4x>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DUZPR04MB9782:EE_
x-ms-office365-filtering-correlation-id: e4be2e6b-68a4-451b-9a7e-08dd7b031787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3RTdjlwT2ROTVZDUDd3cXl3dWFrYWRaMkUzQk0xeTdMbzViclEzNHJ0N3V4?=
 =?utf-8?B?NksvMndzaHZsb0w5VDZyNHFodFc4S0pCcmczMkhRcWdsUk9sY2daZnBnd0Jk?=
 =?utf-8?B?eFlIRFVzVnNoemxhZ0doRlZFZ2dUK3V2L0dRY1dFcHNYbzliMlpORlVIYWFy?=
 =?utf-8?B?c01Mczc1TTg5b2k0TyswUEdWeEkvdlFOak9Ob3pVT21xMGNvWVNsYk9zY0Q3?=
 =?utf-8?B?RVIvNXZpK0pHZzZxR2gxaEY5dkhOZHlhSXlKVUczU1JkMzJHWVRGSitFTGhZ?=
 =?utf-8?B?cGlYVjZjbm1KUXE3YWlxamtPZWNaY1RpL0VuSzFXMS85MG5vNk9QWVV3RXhQ?=
 =?utf-8?B?UlltTWVFUVRXeDFPZTg4WmgrYkhxTEY2L2pEcXdnZlNPY0FhZ3hvak12VXFK?=
 =?utf-8?B?ampYejdyU256NUhXdnhkMnFpcnhLdUFBTmkxb2s1Mi90WGF6YUpUOGdsbEo2?=
 =?utf-8?B?YktrbUt0VXZxUzh0T0N2NHd5R21TTTlLYmdMMGtUc3dRUlZUSUxyWlBIZUFM?=
 =?utf-8?B?S2dYb3c2NXlua280dDZmam01WGEzTmQ1WS9pTGVnanhHVXVHM2QrRExwbDRt?=
 =?utf-8?B?UC95MWM1dFY0bUVRT0hjUG5HU3lPbWwxbkVCN1N4UjcxTjFmOWpoVURmYjY4?=
 =?utf-8?B?VnhsNTIrYjBsK2V5UzVWMmNWWGVmSnlVMHNJZWRxT2psRjNFVFBPUW45Zzlm?=
 =?utf-8?B?WUk4OUQ1V1hsY3pVUFdEa3YxTm1XRTJXNkwxR0RWeGhBMDNuTkQ1SVhVNkFy?=
 =?utf-8?B?b0RMdlhLRU01YzdXTFNpYmZ2Z2xkZWpZdER3Z24xeStxTlJlNzZ3L1Fob1o4?=
 =?utf-8?B?ZDFmNS9jeWNKQ2x4M0xmeTFXYkxiSHE0Q2FpTFQxTm1ZOGkzRUpQMVRnZHFv?=
 =?utf-8?B?dWovS1h1SjV4dEp4V3VBYjIzYWoraUwyU0Q0SHZSY3FWa0dWZCtSK3RTdjB5?=
 =?utf-8?B?QUNweXZCK0k0S1pyaDlGRE93NWxCQy8zM1R1MnpacGR2Qi92bkQ0QUZIaTJ5?=
 =?utf-8?B?dTN0dExnWTBWR2J4Z2puWU1JUkNTdHZWQi81WGh5enlJZFpTb2ozV1NoU0Vo?=
 =?utf-8?B?L01KVlRxUE5XZnNHNnBRcGUyYjh3YVRreHFwbmxKNEhwZ2I2SXliMjFQNGJB?=
 =?utf-8?B?RWYrY2VoQzEraVpib1h3cmRld0VwSEZxMlVHYTFnaWVQWHJtZ3Jac3R3dHR2?=
 =?utf-8?B?cm01SUYyNFJZUExBV1Mwa2xnV09GT0owYTVhalBaZ0NRUnBjUzBmM3NVeEJv?=
 =?utf-8?B?TUFqNTFBWFM5dG1VUk1JdWVvRnRWY0phcjJiZ0lPQXdiN1pjUVgxZjJFd2tv?=
 =?utf-8?B?N0VxUnR3T0NGVGVMWXgyMEtzamV0Y2tpM0ZZemlFL3pmbFllSTZ2Uk0wSjNi?=
 =?utf-8?B?ckpWSlIwd2pSdjFJUTVyemtLRE91eHlDcWNyZFNWSTJwRmtxalN5WXhZZjBy?=
 =?utf-8?B?YUZuTCtMU2RrQnRaRlhEbGZua1hET0dMTlo5QmQ2UEl0WFk1SGkreWY0US9r?=
 =?utf-8?B?WGxPYmJkbEkyTk9OYU9EU28yT1pwcEhDcWhhTjcxeVBDZGF5blNOcVRReDVB?=
 =?utf-8?B?aG5tUjJoT2lOVWg4VHFNeUJZbE1FOUdBZk1pMGJReXBPMlFpZUYxbjBSSWcz?=
 =?utf-8?B?K253c3RxWDI3eUd0YXFlMXdZRmkzT2xiZmgxWlhjV0x3RzI0Mkh0clFSQVRC?=
 =?utf-8?B?WEt6QnVER0R3MTRPanZNdVIzTDI4ZitENGJMMUhlU2QvR25BS2liYjB6aE1Y?=
 =?utf-8?B?RTlFblNGdW02SStCSnRCRUEwajVkbmVXKy95QWliTFZsTUw5SU8zTEhZNGY2?=
 =?utf-8?B?eWdPRy9mTVEzZ3J4RjZXYkl1Z0p0VFBBdjdoeUVPdFk2akd4YmY2U3ZCRGd6?=
 =?utf-8?B?SGxxTDZSQm5CWDQ5Q0tZL3U5bXJBamhTSnd4MVNRanI3TDNDSUJxTDZwVmRI?=
 =?utf-8?B?UmFQNUxVZlRqMjFaZ1NZZm1jaEpzYkwwWm9UM1ZGSmlldnpqYmdLcGNtU0Yr?=
 =?utf-8?B?RmgrbHV0Qy93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUJ0elUvTis5NEVFcDJsbzBmcGkxY0JOV2JFODZlNFdiN3p2SGRFR3BibHFI?=
 =?utf-8?B?VGdndDFCY0R0N2g0bVJyS0orQ3BtQ1ByRTZCSDZJclMrWnRqclF1MW5lb2Fa?=
 =?utf-8?B?RHRyVU5PaWZUdWZFR3N3SUNZaUIzN1BnazN5RjNkZ2RFYkNtTUhjSEh1Qnd3?=
 =?utf-8?B?bExpMGJFMGdxNUxmckVLMEJxQU5ESEQ2NlVlMUpKY29wSlk3YjNwQVZIekNv?=
 =?utf-8?B?bDJTaE0yQWcySGQ3SzBQSHhDbU8ybjlIVmord3lrWjIvRVcxeTlyNXdYOUlw?=
 =?utf-8?B?UDVGOGNPL2s4N2ZBWDVGaFBXOEcrbVk0OVRIU1BzWE9wTnlhMnBiaXc0TU9u?=
 =?utf-8?B?ZFkwWEkyNEZyeTZGcXlkWDJxakRhYXFjTWh6VThERVB0SEdjck9BUGdWU3px?=
 =?utf-8?B?bWU1NENLNm5BenhVSkQwalgrd1ZTMEFudlRMU2RiUEhqVDcycCtHK1hGZG5X?=
 =?utf-8?B?Ry9hQVRkak04d3FWVFpkMkY4eU4xZ3hHUDYzclJEckFMRit2bHJzSFdPZnRF?=
 =?utf-8?B?TWQyT1h4K202ZnhyTjZxcTluVEVzSVViY3kxaUtuQVBjWmt5WTJqQTYveTR5?=
 =?utf-8?B?NEZ1L2tYdjV4OUZ6RFpNN3VENWZvSmdBaFRRdEcwQ0xVd0I3RC9yTW5PWXk2?=
 =?utf-8?B?UXo0UURLS2l4QkFNZFpSckh2bGpkSG5jZDZXUUthMUQwaVk1RGN3Tk5UY0gx?=
 =?utf-8?B?RHlPRUIwQTZqOWMrY3JkUHFPTGFPMHNDTmg5RmJCVkpLK2ZIdTlFSFNHMDVw?=
 =?utf-8?B?QnFoOG91WEFTOEVuRTdxMWMwRzNLdXhoVnExZ2Q4K3N1SzhRUWZ2dFpSb0ZO?=
 =?utf-8?B?WTZLNWVhV3lTLzR1ay83Z1UxSTJVL1d0c2U2UnBxYitEWDRrNnh5NUZzNWpj?=
 =?utf-8?B?ak9FYzQvMWJ0QjA0QkxGdXpGWWNta29rY1ZtdFU1clFoUFVTMHRrOU1IR3pq?=
 =?utf-8?B?UkJOanJ1bks4Y0hLQWgreC9uT2NIQjU5b2E1c2wyN1VDYlpYclpldVU4cHVP?=
 =?utf-8?B?Y2RDZGhzL2dBMTAxdW5YOE8xMktZTVh5Zy9tdDF1QjUwc2tpeVl4OGQwOS9w?=
 =?utf-8?B?Uk1wb204bVgxMkg3R21QTWJwdTgvRDU2aVoxVFhPc3NrLzAzWUs5cTF0ckZk?=
 =?utf-8?B?dmx4bURuSy9rblJrTXFxcXFaMG9HS29vUUN0V3NPTldVV2dKYXhPSlNsMkFy?=
 =?utf-8?B?RUhkNHlpMWFvc0xMY2h4V2Z2czhLMllDYjBpbmpzcnFpcXF5R0JMRVMwRm1y?=
 =?utf-8?B?UW9OenVmcXBwbzVZUnN6Zm1BVjJlQmI0enVSeDNSVW05Y3FFRUVSN0wrUFEw?=
 =?utf-8?B?N2Zyb0ZUbmxoMmJnWXpnUTJLSU4ydmt6MzVQNy9IRG54M2VtRVVSRjVYSTk3?=
 =?utf-8?B?VTZpZDhFLzl2YnAvNCtYOWdMZ3hkQlFMdGFDTStIaWdHZ2FHVUZUb1BlU0Nw?=
 =?utf-8?B?Zjh5SnJ2ekdjTWVHSUpEcFUwZDZrZE1FZUdzdEpkTEJQUUF2M0JIbmc4WFYr?=
 =?utf-8?B?RHAyQlJndlNMZUNrYW5tb2ZIcFRNRXcrcVJLSysraVk1VTZpRWRKb3pjdjZ1?=
 =?utf-8?B?WkI0aWViakVMOEtSNE9zdTV0U0N6NTZ4NlY3eFBwSitDbzVVTWRHdU5Wa000?=
 =?utf-8?B?MGMzNkd2OFlDK0dZWVZTY1hLSjZFTkRQZVVmWlZzMzVEV1VJQXRoSjRCU0dB?=
 =?utf-8?B?SWw5L01zb2h0R1FTT2V5ZmYvNzVjZVhESWZSM2FzYjFGenlnS25INnNmNGpk?=
 =?utf-8?B?aHFRdG5DSnF0UHFMaUZRWHBsSnhGck5SRFNUalloeDlkdjZua2FQZUdsNWY4?=
 =?utf-8?B?b0hSNzZUMGJhNzlDRXQyOGlhUWp4TzRnNGxKRTRkNjFZdEZNZndrTVA3eTcx?=
 =?utf-8?B?aU9jS01sT0twQmJhK3BQdHd3RDFjeTVpRFNUWExsazh0V0pnUmM5Q0w5aFpE?=
 =?utf-8?B?QmVsdTlER1IydXljQ0F0S0xobGZYbmJXMzJiYjRSV0pZL0tZU0YxYzhHUitH?=
 =?utf-8?B?ZXZRMHBST2J2aDZXSXFtWFNLM0ErbkM3N2xVdGVlcU5FUERjL3dUYzZvZzZq?=
 =?utf-8?B?Q0lCVUc1TmdOT2hPMEsxWmVnYU53Rms0aVI2K0FXc3RqcmF0UFRDMW9IZVM0?=
 =?utf-8?Q?gIGZozMND+tScrnEmOPwif0tw?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be2e6b-68a4-451b-9a7e-08dd7b031787
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:18:56.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/KeXMw9LNHiLHz7I4kYVFwkj58s7LFmF0VQofVBdRF0WwgNp94puQCfWYvRYBto0PEifXgKUL6Y9h9GjIKDLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9782

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDEz5pelIDIzOjE4DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Ow0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy83XSBQQ0k6IGlteDY6IFRvZ2ds
ZSB0aGUgY29sZCByZXNldCBmb3IgaS5NWDk1IFBDSWUNCj4gDQo+IE9uIFR1ZSwgQXByIDA4LCAy
MDI1IGF0IDEwOjU5OjI2QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCB0aGUg
Y29sZCByZXNldCB0b2dnbGUgZm9yIGkuTVg5NSBQQ0llIHRvIGFsaWduIFBIWSdzIHBvd2VyIHVw
IHNlcXVlbmN5Lg0KPiANCj4gUGxlYXNlIGF2b2lkIHNwZWxsaW5nIG1pc3Rha2VzIGluIHRoZSBj
b21taXQgbWVzc2FnZXMuDQo+IA0KT2theSwgd291bGQgYmUgcmVwbGFjZWQgYnkgdGhlIGZvbGxv
d2luZyBvbmUuDQpBZGQgYSBjb2xkIHJlc2V0IHRvZ2dsZSBmb3IgdGhlIGkuTVg5NSBQQ0llIHRv
IGFsaWduIHRoZSBQSFkncyBwb3dlci11cA0KIHNlcXVlbmNlLg0KDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IA0KPiBSZXZpZXdl
ZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGlu
YXJvLm9yZz4NCj4gDQpUaGFua3MuDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQNCg0KPiAtIE1hbmkN
Cj4gDQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNDINCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gaW5kZXggYzU4NzFjM2Q0MTk0Li43YzYwYjcxMjQ4MGEgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNzEsNiArNzEsOSBAQA0KPiA+
ICAjZGVmaW5lIElNWDk1X1NJRF9NQVNLCQkJCUdFTk1BU0soNSwgMCkNCj4gPiAgI2RlZmluZSBJ
TVg5NV9NQVhfTFVUCQkJCTMyDQo+ID4NCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lFX1JTVF9DVFJM
CQkJMHgzMDEwDQo+ID4gKyNkZWZpbmUgSU1YOTVfUENJRV9DT0xEX1JTVAkJCUJJVCgwKQ0KPiA+
ICsNCj4gPiAgI2RlZmluZSB0b19pbXhfcGNpZSh4KQlkZXZfZ2V0X2RydmRhdGEoKHgpLT5kZXYp
DQo+ID4NCj4gPiAgZW51bSBpbXhfcGNpZV92YXJpYW50cyB7DQo+ID4gQEAgLTc3Myw2ICs3NzYs
NDMgQEAgc3RhdGljIGludCBpbXg3ZF9wY2llX2NvcmVfcmVzZXQoc3RydWN0IGlteF9wY2llDQo+
ICppbXhfcGNpZSwgYm9vbCBhc3NlcnQpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyBpbnQgaW14OTVfcGNpZV9jb3JlX3Jlc2V0KHN0cnVjdCBpbXhfcGNpZSAqaW14
X3BjaWUsIGJvb2wNCj4gPiArYXNzZXJ0KSB7DQo+ID4gKwl1MzIgdmFsOw0KPiA+ICsNCj4gPiAr
CWlmIChhc3NlcnQpIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEZyb20gaS5NWDk1IFBDSWUgUEhZ
IHBlcnNwZWN0aXZlLCB0aGUgQ09MRCByZXNldCB0b2dnbGUNCj4gPiArCQkgKiBzaG91bGQgYmUg
Y29tcGxldGUgYWZ0ZXIgcG93ZXItdXAgYnkgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZS4NCj4gPiAr
CQkgKiAgICAgICAgICAgICAgICAgPiAxMHVzKGF0IHBvd2VyLXVwKQ0KPiA+ICsJCSAqICAgICAg
ICAgICAgICAgICA+IDEwbnMod2FybSByZXNldCkNCj4gPiArCQkgKiAgICAgICAgICAgICAgIHw8
LS0tLS0tLS0tLS0tPnwNCj4gPiArCQkgKiAgICAgICAgICAgICAgICBfX19fX19fX19fX19fXw0K
PiA+ICsJCSAqIHBoeV9yZXNldCBfX19fLyAgICAgICAgICAgICAgXF9fX19fX19fX19fX19fX18N
Cj4gPiArCQkgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19fX19fX19fX19f
DQo+ID4gKwkJICogcmVmX2Nsa19lbl9fX19fX19fX19fX19fX19fX19fX19fLw0KPiA+ICsJCSAq
IFRvZ2dsZSBDT0xEIHJlc2V0IGFsaWduZWQgd2l0aCB0aGlzIHNlcXVlbmNlIGZvciBpLk1YOTUg
UENJZS4NCj4gPiArCQkgKi8NCj4gPiArCQlyZWdtYXBfc2V0X2JpdHMoaW14X3BjaWUtPmlvbXV4
Y19ncHIsIElNWDk1X1BDSUVfUlNUX0NUUkwsDQo+ID4gKwkJCQlJTVg5NV9QQ0lFX0NPTERfUlNU
KTsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIE1ha2Ugc3VyZSB0aGUgd3JpdGUgdG8gSU1YOTVfUENJ
RV9SU1RfQ1RSTCBpcyBmbHVzaGVkIHRvIHRoZQ0KPiA+ICsJCSAqIGhhcmR3YXJlIGJ5IGRvaW5n
IGEgcmVhZC4gT3RoZXJ3aXNlLCB0aGVyZSBpcyBubyBndWFyYW50ZWUNCj4gPiArCQkgKiB0aGF0
IHRoZSB3cml0ZSBoYXMgcmVhY2hlZCB0aGUgaGFyZHdhcmUgYmVmb3JlIHVkZWxheSgpLg0KPiA+
ICsJCSAqLw0KPiA+ICsJCXJlZ21hcF9yZWFkX2J5cGFzc2VkKGlteF9wY2llLT5pb211eGNfZ3By
LA0KPiBJTVg5NV9QQ0lFX1JTVF9DVFJMLA0KPiA+ICsJCQkJICAgICAmdmFsKTsNCj4gPiArCQl1
ZGVsYXkoMTUpOw0KPiA+ICsJCXJlZ21hcF9jbGVhcl9iaXRzKGlteF9wY2llLT5pb211eGNfZ3By
LCBJTVg5NV9QQ0lFX1JTVF9DVFJMLA0KPiA+ICsJCQkJICBJTVg5NV9QQ0lFX0NPTERfUlNUKTsN
Cj4gPiArCQlyZWdtYXBfcmVhZF9ieXBhc3NlZChpbXhfcGNpZS0+aW9tdXhjX2dwciwNCj4gSU1Y
OTVfUENJRV9SU1RfQ1RSTCwNCj4gPiArCQkJCSAgICAgJnZhbCk7DQo+ID4gKwkJdWRlbGF5KDEw
KTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIHZvaWQgaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteF9wY2llICpp
bXhfcGNpZSkgIHsNCj4gPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGlteF9wY2llLT5wY2llcGh5
X3Jlc2V0KTsNCj4gPiBAQCAtMTczOSw2ICsxNzc5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
bXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gPiAgCQkubHRzc21fbWFzayA9IElNWDk1
X1BDSUVfTFRTU01fRU4sDQo+ID4gIAkJLm1vZGVfb2ZmWzBdICA9IElNWDk1X1BFMF9HRU5fQ1RS
TF8xLA0KPiA+ICAJCS5tb2RlX21hc2tbMF0gPSBJTVg5NV9QQ0lFX0RFVklDRV9UWVBFLA0KPiA+
ICsJCS5jb3JlX3Jlc2V0ID0gaW14OTVfcGNpZV9jb3JlX3Jlc2V0LA0KPiA+ICAJCS5pbml0X3Bo
eSA9IGlteDk1X3BjaWVfaW5pdF9waHksDQo+ID4gIAl9LA0KPiA+ICAJW0lNWDhNUV9FUF0gPSB7
DQo+ID4gQEAgLTE3OTIsNiArMTgzMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BjaWVf
ZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4gIAkJLm1vZGVfb2ZmWzBdICA9IElNWDk1X1BFMF9H
RU5fQ1RSTF8xLA0KPiA+ICAJCS5tb2RlX21hc2tbMF0gPSBJTVg5NV9QQ0lFX0RFVklDRV9UWVBF
LA0KPiA+ICAJCS5pbml0X3BoeSA9IGlteDk1X3BjaWVfaW5pdF9waHksDQo+ID4gKwkJLmNvcmVf
cmVzZXQgPSBpbXg5NV9wY2llX2NvcmVfcmVzZXQsDQo+ID4gIAkJLmVwY19mZWF0dXJlcyA9ICZp
bXg5NV9wY2llX2VwY19mZWF0dXJlcywNCj4gPiAgCQkubW9kZSA9IERXX1BDSUVfRVBfVFlQRSwN
Cj4gPiAgCX0sDQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/
4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

