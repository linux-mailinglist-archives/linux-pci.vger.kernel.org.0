Return-Path: <linux-pci+bounces-29277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D5AD2D77
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 07:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4B17A2E9E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 05:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA4219312;
	Tue, 10 Jun 2025 05:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PY450EEG"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A651F874F;
	Tue, 10 Jun 2025 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534369; cv=fail; b=GPoPl9fKeQySV+11RwvSuZg0L2jNmgk0IZEgs6jqaTW+mXeHS/riZUK+YAHPIvIQe9mTdxXd8lxnnZnuncyrfut+nOe5SEJdPlSzMHAOJqRZoQIhy+jahXr3IIAggk4kCJji6ZYZB7/Y48H7h9Hvon9Viq50+8hEZFX1G3hO1EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534369; c=relaxed/simple;
	bh=vu67YqjW2DlTSVxtjtLULwCpvrQY4wErLDvsoaK2oE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u9gk+G5w5684UZMKxfBunk3D6EOW6m7OJBWmfT5Jbwsel0mwDaF4Mw4zqjzjkHT+oyNt4HbBTj/En09dnJycjdTUN7UKOH/rn0LgH1TkrTpGx6pxjB/uMTDJBzhDwz8e904w4IBnzRSjzu2NoWyqH6bL/QZbAHTkHphNdITuiGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PY450EEG; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rttjJcxn9OOAOLEV2IIcpJ6dENogGOGoQhqM6IdRjCr/DY+qRtgKTiXq6mmlXttdLG2ergzoQPWPfS2n1gnJRhOPMi3h1NaZ8Iy3s2mTjoc9KMUr5/Ozl83BwRe23r4ci9mgWmLcuBnch9DF9F6qL+/kVbryiVTBiqjkFpZR5tC/1twrSBYcBvsIwOFmrF10acfEyjsBlQPwMmkjKwkasE8IMy7UEtHCnfF6AXMhGFg3qkl1A3Ez7shS3NzYGcBR9B89P9C6jP3kZApoaCNTAWt0Fg8ICTdK8JGqV7E5wVMNZGjKOkk0lV37K5S0ZrXj8ajk5W7hcVYH+/jmeQH3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu67YqjW2DlTSVxtjtLULwCpvrQY4wErLDvsoaK2oE4=;
 b=dHuXhmjjPN2/pC96nyO6AIzvPAeHEP9Bwei/uDpE/dy0CYj4POv75MvFmxXR9ZuSVgYgAP45E7dNOiEQBK76m4i4EkRB3vux4bAcVqr5PFxP85PpbRPdsIoqrE4Eaxvr/1xupZEZc4/OWldqdbSWnvNf9vWk/9rQGIxGgmARVEwstEM92LDjakiD4wMIkTHxjkmG98pFYmmdcscY1A37pZEyWQSJwckK5ZjTu208dxI62FycLIaJZQ45IbMIHT8w9vP4+tuCZc5ZfSwRB52DJiwVLtwm7mS/6hZLcXniQ9WQLfZeD4FOfvMXQmBJBpWGDkgPR6/hFfK32WofA4Mulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu67YqjW2DlTSVxtjtLULwCpvrQY4wErLDvsoaK2oE4=;
 b=PY450EEGMRdY9Oq9Z7xYdIuzbwDyL0pi8ABOP56MlIGrwKSeJZpmZ9MWgbiK14uBSqS9v/i0VvDiR8KsrhdtCrvoByTVyj6DhYPIuWRuw4mEbMY7cTqcp7nxuPqRuIHqRmHJcXky2XS6bSVPfaU2Yk945PmVaTyBBUL/PrpdEt9Q79caO5wZT9degAPufIwT731eAICYHgR00FUiA751+r4zxgGLf7AEBQ3Sa+fdIYSb5emrNi/7mh7rlNbV430gX+NZsP28GVdKJnOKXeCyujNVmGWaLKfVvgvbbpavd1xggyIQ0anjKsiYA4w8ZqZ5tblBl8P3ka5sUtRHmpvZfg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Tue, 10 Jun
 2025 05:46:03 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 05:46:03 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
 imx_pcie_deassert_core_reset()
Thread-Topic: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
 imx_pcie_deassert_core_reset()
Thread-Index: AQHbP9jwKL/mPeFjWkuIr6TbMYW/mrP3zVeAgAPAlqCAAS5SAIAALxZg
Date: Tue, 10 Jun 2025 05:46:03 +0000
Message-ID:
 <AS8PR04MB86765B513C5CEBAC9E26AAE68C6AA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20241126075702.4099164-6-hongxing.zhu@nxp.com>
 <CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com>
 <AS8PR04MB8676C1206066A3215DB5F3B78C6BA@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU0rO0tJyon6HGYTZHu5oii5vH-dPpnSH7RQj43+nE1KDQ@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU0rO0tJyon6HGYTZHu5oii5vH-dPpnSH7RQj43+nE1KDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GVXPR04MB9949:EE_
x-ms-office365-filtering-correlation-id: aad1ae2d-7d4c-4413-4e05-08dda7e21613
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cExLOGdMVEVNWVMxYklCd2N3MHoxcjdVYzJQa2w0TklVTVpqS3FrdE11dGhY?=
 =?utf-8?B?QWF2YjZCdXc5UTdPaURPb0F1bkRjSWhIbHZLcWdOZWx1aXo5VUlCUkVSd0F5?=
 =?utf-8?B?eWdsSFVTNmowY0dXT0xmTXo3TW51R2lrUStJTCt4bGxmRHVLUjVPaHF1M3Av?=
 =?utf-8?B?aFVHOHZNVDlXbWthK0ZsbCtTdnZCL2hDLy9GNysrWXVTYlNkMGJUdzRWN1V3?=
 =?utf-8?B?TzRUbFdydXgrM1Mrd0pGM1ROTDhNY0pUcE9XbHVkemhoNi9nMERFdFBKVXFH?=
 =?utf-8?B?UTJ5KzZEbEc2RXpqQ3J5ZXpFK1NlbDg0NFBGWGVwanJWZGNscVh3WXI0UUEv?=
 =?utf-8?B?Nis4NDYyc0NuWUZ5OWxtMjZ4OVFGS3ZBeUZKc0Noa1UxMWdyaEJ6UVo1c3oy?=
 =?utf-8?B?WkRZYU0xclRnZ1l5c1JvRThjVXJINFNDRCs4K2hVd282eEU0OTd0R1NVRUJo?=
 =?utf-8?B?RUtPRng0K0VoaWE2S1FRL2g5ZWQ0L2lqMzBCY3NJL1pYZHRyalVsMmVTQU5O?=
 =?utf-8?B?WWdGV3BoWmlhVW91VnowREpxT291Z2V1bEFnbWR6QUtIeHM4WTd6ZHlxMkxM?=
 =?utf-8?B?VE92N1I5bnIwRTVURVFaTDZBVGZRV2VHdFcrZWZzMkdoSXB0T0tkQTVsOFYy?=
 =?utf-8?B?ZUVxbGUxbHk4WnZPZEdReElVM0lvOHZXa2habm05ZUFFYnhvYTdFa0FwU2cz?=
 =?utf-8?B?dVJFK1J5Rkw2VklKV3dxZU1ZaTJzbXdVSnIzWTRTMWRxaHhhenlUOGk4Rkcx?=
 =?utf-8?B?bWI5c0tOS2Q2amx1NU5CL2ZCZE9tTzdaTTQzVTh5VFBHeEd1eUJJMGlVQ05i?=
 =?utf-8?B?d00rU1pFMnFlamkvZmNLLzk0T0FQaTN0Qm9KeG9iTzBYWFM2Q2RzeWtzTzQ0?=
 =?utf-8?B?dGRMbnJWNEtEcjA0aVpUcEZsdWRqTHo0MnhBS1d1cEJieVJuMWtaVUc5Z1Fl?=
 =?utf-8?B?dXBud0lESzlsd0IrcnBKNWFWeUs5aThpb2lKekFaVWUwaTZWY24vSWoyQUZD?=
 =?utf-8?B?aW8xYVU3WHJPZ0pCdzlVdG03NU81TmYvTG9LWVlxUmlQTU94Z1NOZndmRVRs?=
 =?utf-8?B?MTFGem9ZdGVmeUU5VFhFS3Z2NGxyYk5jVG41eXRCRHVvNCtRUFp0N1Mvbkc2?=
 =?utf-8?B?U3pFWU1FSzNsTlNDcEcwOERNT0JhSTZsTk5PektEa3JsaXVTY0J1cENmdW51?=
 =?utf-8?B?QUQ3WXRoZk5CTXM1UHlZTitPSjlCSHAyKzRDNktlTzA0SUp2Y2h2YWNrMEJm?=
 =?utf-8?B?aCtpcXdqWi94Vmd2cUJzS0VlSVJCeHA3UFNTL0FKeExNVWZ0WjJrQlorYjU0?=
 =?utf-8?B?TlV2dS9lbHphcHVHQjJKQVRyZ0NEWjRQQnFXc1o4ZnV1eHE0ZXQxaGpMbzcy?=
 =?utf-8?B?WEdoQS91SjlxYy9TNEdxek00Y2lTUnFhVlFJZTJCMDJFcSt5RVlwSnpKNTk0?=
 =?utf-8?B?cHc2Mk9OcHhaM1VJaEN4elVmSDBGUHMrT2ZkR3RHOE4yMzBraitjdFRiclpi?=
 =?utf-8?B?Q0o4Umo3Kzc5dmpsM1VUR0dxS21lUHZnQ1VyeDdweEFyZ1R6M1VZNCtoUzRI?=
 =?utf-8?B?WlF1dTRmNlpYS2lENmkvL05ZY214S0QvMnRJWUx6bzhEZDhDZmp0TGZtdlVG?=
 =?utf-8?B?YktiLzdLRDNvOHpnWGVScmVyaDZCZy9UYVR5andyZGNwSXBJd2pkZDR6RG5v?=
 =?utf-8?B?YzdHcTRUeWRlQUluZ0N2N2tJb2FIL0U2RW1wazVQc2E2YW9Ma0RTaGRhOEJ5?=
 =?utf-8?B?Y3ZFYUNOTjRUdlI3UkJtYk1BSFBWaDN6QlNrL0g4MHhFazRsZG5aV0t2UWNG?=
 =?utf-8?B?S2dOUTMxZDBPZjJFOVJ4dlBEcG5ONEFXSk5QdTg5YWpISzZwZ0dGZTVRWWdY?=
 =?utf-8?B?Vzg0a3NMd0oxOTB4NWNpQTRodTZERGNSckhaUlBsTmlRL00yMXhITWFhbWhV?=
 =?utf-8?Q?AEIRekdNUlA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEFQQXl1cWpEVmRNTG5kc2N6WnlJN1dFNDgrTUplOXNHZk9VNnJsYWRpL1RL?=
 =?utf-8?B?NkJ3TkVhZitKTzBkS0pDMWt3OE1IMlhDQTc3QjIyL2dmekxjSmE4Nk1vN0VD?=
 =?utf-8?B?MTBrQjl6Q1hyUS9xT3kxemlJclJZejhHUStueklBWmcxMkxJTEdCSDJLQjNi?=
 =?utf-8?B?R1AzQjM3UkJWZmpDckZGZXNUdG5oYlNsaWFtRkpxS1NVc2hGSGJSMlRDWkF0?=
 =?utf-8?B?T1pObzVHTlI1SHZBaVhoU0dLZTFpS1Z6bXVGRkJMdDRkNnd1QUR1dFZFbGVh?=
 =?utf-8?B?RVJKSHhBcTcwLzJuVEF0bWRuRHQyU25UTDlQWUpkRTl6YmxCU1pvTStQUXVu?=
 =?utf-8?B?WTR2TndIZk9tSWhJditObVJYQmNzaDJXdDAyV2JJU21Xd1JSdTM5YmpDVGxx?=
 =?utf-8?B?MnVDL3owMlB5QlpyUmk3STJNdXFiWTdRL2xpUE8wTVFYa1RQMHZkSGZWb3FE?=
 =?utf-8?B?OFhYMEFNc2JkY0RGUkQ5WFVaeUZaMkd3U1JZUUhNdmhGdStVVzlIb1BSMkJ4?=
 =?utf-8?B?RWdwU3NiZ1BPZHUzM242SmFTQ0s4TFdNUjV6SG01Mk9TQXZpcThWWlFBTVdV?=
 =?utf-8?B?cWFIR0tqQU44YWFNZkJaUHhyQzFZSHltcTZGQ0FQU2Q0WTFmVk13Q1FrNnpm?=
 =?utf-8?B?RGZFTXFMdS9vRVg2b3d5b3QxZFprRWlpb3hKRzUvWFU2TFVTNUl6bE14K0hV?=
 =?utf-8?B?S2kwd1VTNW0yRHRjOVc5bjRyYkErVjBHS3dEd3BtTXR1cmJBdXJlRHBMVnRE?=
 =?utf-8?B?YmpBV1pjTk9Hc2N4RCtZK1BNQTAxdzVyL0tBVmdIUFdnL2ZZdGpESCsyZUZY?=
 =?utf-8?B?QjJzTVhrVGZUWnVTTUdKd2o5SjNqU0p4M3dsNTh0UEN4cmQxMThGdnVzWXV0?=
 =?utf-8?B?ZkJwTUlwSVZJSjV2dkFrekZZaEE0WVhkaDEvZFIwdEN5bkhUeGRCaEd2REZS?=
 =?utf-8?B?S2YwV1cyQm9SOXFSeTJKbTV3dkw5ZGZnVGQ5cEk5S3EyNFA0NWVxeXBseHNw?=
 =?utf-8?B?elpKWmw5RFpIaTZCd05McGtsSkpUK3hONjF4VzhIWVhza2MzK1ZjcnBzMDRx?=
 =?utf-8?B?eFZPSXhjTzFHWTJEV0FBdDI1RWpQd2g2YjZzNkd1SVNVWEVJVmlqN0E2a3ho?=
 =?utf-8?B?S1JtTUYweHdJN0FwVFYwSnI5YmkwYzE3ZTFEUXcyd1VyZkw3TURHbk8wbWhU?=
 =?utf-8?B?QlJ6dHkxb3JSZ1UxbnplZ2ZJbXNLQkJ4RmZSU1JYU1J5azZyT3BmM0xqckd6?=
 =?utf-8?B?dkg1NkZXVmpvSFhXSXV3d2RhLzMzRUI3clNsTnlVVjNiSyt6eml4UlZicnBz?=
 =?utf-8?B?Zkc1L3ZOU0NrQlVrdjRORFhkaGsxdTRZajhVMXZJblFqaWs1TllrRGp4OXN6?=
 =?utf-8?B?WUFRTjJUZ093TFVMM3Z0ajFMZ3h2WUxVaUIyZ25LdndFUHhhK1cvZnNWWmRH?=
 =?utf-8?B?bWJQOHJaMmVDdi80bktncXl6VWtZWnVZYUJpQXJSdVlXblprRVppMUl6Yml6?=
 =?utf-8?B?UktJektYK2ZvS3NZYVBsdzB0TFE2WFFVVGdMYjBEZDgwaVRDTHlHUi82MXMy?=
 =?utf-8?B?SEdpNk5jRnZvYUoyVldvWFZ2d0xPc3NLMUNrcUh6dHdXZzluRXBNSjQrKy9R?=
 =?utf-8?B?Z2U2U3FnWjI0OG5nVHNVSWpOTmNOK3VHaFl0RGk5TlJKRTdoTStqVU5pNi8w?=
 =?utf-8?B?VnZkb0pNY1h3K3hVQUY5d21DOVdMVklHc05mQlF1UE1RTFVVSnd2enRGNDVu?=
 =?utf-8?B?TFdaa1VWdDRuM1YySzJjL0p2Q0VPMm1RM0o1VlorTlZ3SGpQanpUT013RnVs?=
 =?utf-8?B?MTdEeEM4QkJUdTg4ckdBMzZFVTZvUktsSzJJS0ZkcnFiYTlDZVE0UmpiYVhm?=
 =?utf-8?B?ZzI5LzgrS2psZEJTOC9WSGo3TjJGQmp3cnpobXdrQkR5Q0Z6cjJFbGxtZlAx?=
 =?utf-8?B?bTdFZlZ5U0JnY0orVzZRemppN21ya2V6Y1d2MlFlQ0JYL2JIS0xrQTd0a3oz?=
 =?utf-8?B?aEx4cGovaGU4cjJEdXlyRC9sUVZNSUVVSHRzcGNLVEg2YzBqMm92QU43UGxi?=
 =?utf-8?B?elJwdGdBcjRZbUNUaGlxZHNGOEpjZUxseFprRFBnbzd6WEphV2JJOEF6Rm16?=
 =?utf-8?Q?tmbkpofhw20hSP+Txn9B10fRc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aad1ae2d-7d4c-4413-4e05-08dda7e21613
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 05:46:03.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOulknbyQgH46/N55XqYcIJ5UEuSYSQF/j88liYy6s3O2iYpxVT1wHlgoTUyro+HEmxOfsQSoe9FUDWXbCW0YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjXlubQ25pyIMTDml6UgODoyNA0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dA
bGludXguY29tOyBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwu
b3JnOw0KPiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgcy5oYXVlckBwZW5n
dXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NyAwNS8xMF0gUENJOiBpbXg2OiBEZWFzc2VydCBhcHBzX3Jlc2V0IGluDQo+IGlteF9wY2ll
X2RlYXNzZXJ0X2NvcmVfcmVzZXQoKQ0KPg0KPiBPbiBNb24sIEp1biA5LCAyMDI1IGF0IDE6MDPi
gK9BTSBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFRpbSBIYXJ2ZXkg
PHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjXlubQ25pyIN+aXpSA1OjA0
DQo+ID4gPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IENj
OiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+ID4gPiBtYW5pdmFubmFuLnNhZGhh
c2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiA+ID4ga3J6aytkdEBrZXJuZWwu
b3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBGcmFuaw0KPiA+
ID4ga3J6aytMaQ0KPiA+ID4gPGZyYW5rLmxpQG54cC5jb20+OyBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBpbXhAbGlzdHMubGludXguZGV2OyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NyAwNS8xMF0gUENJOiBpbXg2OiBEZWFzc2VydCBhcHBzX3Jlc2V0IGluDQo+
ID4gPiBpbXhfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkNCj4gPiA+DQo+ID4gPiBPbiBUdWUs
IE5vdiAyNiwgMjAyNCBhdCAxMjowM+KAr0FNIFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBTaW5jZSB0aGUgYXBwc19yZXNl
dCBpcyBhc3NlcnRlZCBpbiBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpLA0KPiA+ID4gPiBp
dCBzaG91bGQgYmUgZGVhc3NlcnRlZCBpbiBpbXhfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCku
DQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiA5YjNmZTY3OTZkN2MgKCJQQ0k6IGlteDY6IEFkZCBj
b2RlIHRvIHN1cHBvcnQgaS5NWDdEIikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogTWFuaXZhbm5h
biBTYWRoYXNpdmFtDQo+ID4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+
ID4gPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMSAr
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+ID4NCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IGlu
ZGV4IDM1Mzg0NDA2MDFhNy4uNDEzZGIxODJjZTlmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gQEAgLTc3Niw2ICs3NzYsNyBA
QCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gPiA+ID4g
aW14X3BjaWUgKmlteF9wY2llKSAgc3RhdGljIGludA0KPiA+ID4gPiBpbXhfcGNpZV9kZWFzc2Vy
dF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiA+ID4gPiBpbXhfcGNpZSAqaW14X3BjaWUpICB7DQo+ID4g
PiA+ICAgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChpbXhfcGNpZS0+cGNpZXBoeV9yZXNl
dCk7DQo+ID4gPiA+ICsgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChpbXhfcGNpZS0+YXBw
c19yZXNldCk7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgaWYgKGlteF9wY2llLT5kcnZkYXRh
LT5jb3JlX3Jlc2V0KQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgaW14X3BjaWUtPmRydmRhdGEt
PmNvcmVfcmVzZXQoaW14X3BjaWUsIGZhbHNlKTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zNy4x
DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSGkgUmljaGFyZCwNCj4gPiA+DQo+ID4g
PiBJJ3ZlIGZvdW5kIHRoYXQgdGhpcyBwYXRjaCBjYXVzZXMgYSByZWdyZXNzaW9uIG9uIGkuTVg4
TU0gYW5kDQo+ID4gPiBpLk1YOE1QIGJvYXJkcyB3aXRoIGhvdHBsdWcgY2FwYWJsZSBicmlkZ2Vz
Og0KPiA+ID4gaS5NWDhNTStQSTdDOVgyRzQwNEVWICh0aGlzIHN3aXRjaCBkb2VzIG5vdCBzdXBw
b3J0IGhvdHBsdWcpIC0gbm8NCj4gPiA+IGlzc3VlcyBpLk1YOE1NK1BJN0M5WDJHNjA4R1AgKGhv
dHBsdWcpIC0gZmFpbHMgdG8gcmVsaWFibHkgZW51bWVyYXRlDQo+ID4gPiBkb3duc3RyZWFtIGRl
dmljZXMgYWJvdXQgODAlIG9mIHRoZSB0aW1lIF5eXiB3aGVuIHRoaXMgb2NjdXJzDQo+ID4gPiBQ
Q0lfUFJJTUFSWV9CVVMgKDB4MTgpIGZvciB0aGUgcm9vdCBjb21wbGV4DQo+ID4gPiAwMDAwOjAw
OjAwLjAgcmVhZHMgMHgwMDAwMDAwMCBpbnN0ZWFkIG9mIDB4MDBmZjAxMDANCj4gPiA+IChQQ0lf
U0VDT05EQVJZX0JVUyBpcyAwIGluc3RlYWQgb2YgMSBhbmQgUENJX1NVQkJPUkRJTkFURV9CVVMg
aXMgMA0KPiA+ID4gaW5zdGVhZCBvZiAweGZmKSBpLk1YOE1QK1BJN0M5WDJHNjA4R1AgKGhvdHBs
dWcpIC0gaGFuZ3MgYXQNCj4gPiA+IGlteF9wY2llX2x0c3NtX2VuYWJsZSBkZWFzc2VydCBhcHBz
X3Jlc2V0DQo+ID4gPg0KPiA+ID4gSW4gYm90aCBjYXNlcyBoZXJlIHJldmVydGluZyBlZjYxYzdk
OGQwMzIgKCJQQ0k6IGlteDY6IERlYXNzZXJ0DQo+ID4gPiBhcHBzX3Jlc2V0IGluIGlteF9wY2ll
X2RlYXNzZXJ0X2NvcmVfcmVzZXQoKSIpIHJlc29sdmVzIHRoaXMuDQo+ID4gPg0KPiA+IFtSaWNo
YXJkIFpodV0gSSdtIGFmcmFpZCB0aGF0IHRoZSBsdHNzbV9lbiBiaXQgYXNzZXJ0IHRvIDFiJzEg
aW4NCj4gPiAgaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpIGlzIG5vdCBjb3JyZWN0IGlu
IHlvdXIgdXNlIGNhc2UuDQo+ID4NCj4NCj4gSGkgUmljaGFyZCwNCj4NCj4gVGhhbmtzIGZvciB5
b3VyIHF1aWNrIHJlc3BvbnNlLiBEbyB5b3UgbWVhbiBub3QgY29ycmVjdCBmb3IgbmV3ZXIgSVAg
Y29yZSBpbg0KPiBpLk1YOE1NL2kuTVg4TVAgb3IgaW4gdGhlIGNhc2Ugb2YgYSBicmlkZ2U/DQpb
UmljaGFyZCBaaHVdIFdoYXQncyBJIG1lYW4gaXMgdGhhdCB0aGUgbHRzc21fZW4gc2hvdWxkIGJl
IGFzc2VydGVkIGluDQogaW14X3BjaWVfc3Rhcl9saW5rKCkuDQo+DQo+ID4gQWN0dWFsbHksIHRo
ZSBhcHBzX3Jlc2V0IGlzbid0IGEgcmVhbCByZXNldC4gSXQncyB0aGUgbHRzc21fZW4gYml0Lg0K
PiA+IEZyb20gdGhpcyBwZXJzcGVjdGl2ZSB2aWV3LCBJdCdzIGluYXBwcm9wcmlhdGUgdG8gdG9n
Z2xlIHRoZSBsdHNzbV9lbg0KPiA+IGJpdCBpbg0KPiA+ICBpbXhfcGNpZV9hc3NlcnQvZGVhc3Nl
cnRfY29yZV9yZXNldCgpIGZ1bmN0aW9ucy4NCj4gPiBJIGNvbnNpZGVyIHRvIG1vdmUgdGhlIGFw
cHNfcmVzZXQgb3V0IG9mIF9yZXNldF8gZnVuY3Rpb25zLg0KPiA+IENhbiB5b3UgaGVscCB0byB0
ZXN0IHRoZSBmb2xsb3dpbmcgY2hhbmdlcyBpbiB5b3UgdXNlLWNhc2U/DQo+ID4NCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC03NzYsNyArNzc2LDYgQEAg
c3RhdGljIGludCBpbXg3ZF9wY2llX2NvcmVfcmVzZXQoc3RydWN0IGlteF9wY2llDQo+ID4gKmlt
eF9wY2llLCBib29sIGFzc2VydCkgIHN0YXRpYyB2b2lkIGlteF9wY2llX2Fzc2VydF9jb3JlX3Jl
c2V0KHN0cnVjdA0KPiA+IGlteF9wY2llICppbXhfcGNpZSkgIHsNCj4gPiAgICAgICAgIHJlc2V0
X2NvbnRyb2xfYXNzZXJ0KGlteF9wY2llLT5wY2llcGh5X3Jlc2V0KTsNCj4gPiAtICAgICAgIHJl
c2V0X2NvbnRyb2xfYXNzZXJ0KGlteF9wY2llLT5hcHBzX3Jlc2V0KTsNCj4gPg0KPiA+ICAgICAg
ICAgaWYgKGlteF9wY2llLT5kcnZkYXRhLT5jb3JlX3Jlc2V0KQ0KPiA+ICAgICAgICAgICAgICAg
ICBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y29yZV9yZXNldChpbXhfcGNpZSwgdHJ1ZSk7IEBADQo+ID4g
LTc4OCw3ICs3ODcsNiBAQCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldChz
dHJ1Y3QNCj4gPiBpbXhfcGNpZSAqaW14X3BjaWUpICBzdGF0aWMgaW50IGlteF9wY2llX2RlYXNz
ZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gaW14X3BjaWUgKmlteF9wY2llKSAgew0KPiA+ICAg
ICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChpbXhfcGNpZS0+cGNpZXBoeV9yZXNldCk7DQo+
ID4gLSAgICAgICByZXNldF9jb250cm9sX2RlYXNzZXJ0KGlteF9wY2llLT5hcHBzX3Jlc2V0KTsN
Cj4gPg0KPiA+ICAgICAgICAgaWYgKGlteF9wY2llLT5kcnZkYXRhLT5jb3JlX3Jlc2V0KQ0KPiA+
ICAgICAgICAgICAgICAgICBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y29yZV9yZXNldChpbXhfcGNpZSwg
ZmFsc2UpOyBAQA0KPiA+IC0xMTc2LDYgKzExNzQsOSBAQCBzdGF0aWMgaW50IGlteF9wY2llX2hv
c3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4g
PiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyogTWFrZSBzdXJlIHRoYXQgUENJZSBMVFNT
TSBpcyBjbGVhcmVkICovDQo+ID4gKyAgICAgICBpbXhfcGNpZV9sdHNzbV9kaXNhYmxlKGRldik7
DQo+ID4gKw0KPiA+ICAgICAgICAgcmV0ID0gaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChp
bXhfcGNpZSk7DQo+ID4gICAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICAgICAgICAgICAgICAg
ICBkZXZfZXJyKGRldiwgInBjaWUgZGVhc3NlcnQgY29yZSByZXNldCBmYWlsZWQ6ICVkXG4iLA0K
PiA+IHJldCk7DQo+ID4NCj4NCj4gWWVzIHRoaXMgcmVzb2x2ZXMgdGhlIHJlZ3Jlc3Npb24gb2Yg
ZmFpbGluZyB0byByZWxpYWJseSBlbnVtZXJhdGUgZG93bnN0cmVhbQ0KPiBkZXZpY2VzLiBJIHRo
aW5rIHRoYXQgc2hvdWxkIGJlIHN1Ym1pdHRlZCB3aXRoIGEgZml4ZXMgdGFnLg0KW1JpY2hhcmQg
Wmh1XSBUaGFua3MuIFRoYXQncyByaWdodC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkDQo+DQo+
IFRoZSBpLk1YOE1QK1BJN0M5WDJHNjA4R1Agc3dpdGNoIGhhbmdpbmcgaXNzdWUgd2FzIGhhcmR3
YXJlIHJlbGF0ZWQuLi4NCj4gaSB3YXMgc2FkbHkgdGVzdGluZyBvbiBhbiBvbGQgYm9hcmQgd2l0
aCBhIGRlZmVjdC4gSSBkaWQgcHJldmlvdXNseSBoYXZlIGEgaGFuZw0KPiBpc3N1ZSB0aGVyZSBk
aXNjdXNzZWQgcHJldmlvdXNseSBoZXJlIFsxXSBidXQgaXQgd2FzIHJlc29sdmVkIHdpdGggY29t
bWl0DQo+IDljMDNlMzBlM2FkZSAoIlBDSTogaW14NjogU2tpcCBsaW5rIHVwIHdvcmthcm91bmQg
Zm9yIG5ld2VyIHBsYXRmb3JtcyIpLg0KPg0KPiBIb3cgbXVjaCB0ZXN0aW5nIGlzIGRvbmUgd2l0
aCBpLk1YOE17TSxQfSBib2FyZCB3aXRoIGEgc3dpdGNoPyBJIGZlZWwgbGlrZQ0KPiBJJ20gdGhl
IG9ubHkgb25lIHdpdGggdGhlc2UgU29DJ3MgYW5kIGEgc3dpdGNoIGFuZCBJIG5lZWQgdG8gZ2V0
IGJldHRlciBhdA0KPiBtb25pdG9yaW5nIHBhdGNoZXMgdG8gdGhlIElNWDYgUENJIGNvbnRyb2xs
ZXIgZHJpdmVyIGFuZCB0ZXN0aW5nIHRoZXNlDQo+IHNjZW5hcmlvcy4NCj4NCj4gQmVzdCBSZWdh
cmRzLA0KPg0KPiBUaW0NCj4gWzFdDQo+IGh0dHBzOi8vd3d3LnMvDQo+IHBpbmljcy5uZXQlMkZs
aXN0cyUyRmxpbnV4LXBjaSUyRm1zZzE0Mjc2NC5odG1sJmRhdGE9MDUlN0MwMiU3Q2hvbmcNCj4g
eGluZy56aHUlNDBueHAuY29tJTdDMmZkNjQ3NDFlOTZlNDdlZmM3MTIwOGRkYTdiNTIyZjYlN0M2
ODZlYTFkDQo+IDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODg1MTExODYw
MTM5MTE5MSU3Q1Vuaw0KPiBub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlk
V1VzSWxZaU9pSXdMakF1TURBd00NCj4gQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJD
SXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3Qw0KPiAmc2RhdGE9MDFsZk5BJTJCZlg4ZGdC
U3RRNlE3UWhjc0FVOGdWV0QwSTRrSmpKNlNuTGNrJTNEJnJlc2VydmUNCj4gZD0wDQo+DQo+DQo+
DQo+DQo+ID4gPiBJIG5vdGljZSB0aGUgc2VxdWVuY2Ugb2YgZXZlbnRzIGhlcmUgaXM6DQo+ID4g
PiBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldCBhc3NlcnRzIGFwcHNfcmVzZXQgKGRpc2FibGVz
IExUU1NNKQ0KPiA+ID4gaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCBkZWFzc2VydHMgYXBw
c19yZXNldCAoZW5hYmxlcyBMVFNTTSkNCj4gPiA+IGlteF9wY2llX2x0c3NtX2VuYWJsZSBkZWFz
c2VydHMgYXBwc19yZXNldCAoZW5hYmxlcyBMVFNTTTsgdGhpcyBpcw0KPiA+ID4gd2hlcmUgaXQg
aGFuZ3Mgb24gaW14OG1wKQ0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIHBlcmhhcHMgc29tZSBpc3N1
ZSB3aXRoIGRlLWFzc2VydGluZyB0aGlzIChlbmFibGluZyBMVFNTTSkNCj4gPiA+IHdoZW4gaXQn
cyBhbHJlYWR5IGluIHRoaXMgc3RhdGU/DQo+ID4gW1JpY2hhcmQgWmh1XVRoZSBhcHBzX3Jlc2V0
IGlzIHVwZGF0ZWQgYnkgc3JjIGRyaXZlciBieQ0KPiByZWdtYXBfdXBkYXRlX2JpdHMoKS4NCj4g
PiBJIGNhbid0IGZpbmQgdGhlIGV4Y2VwdGlvbnMgdG8gdXBkYXRlIG9uZSBiaXQsIGFscmVhZHkg
aGFzIHRoZSBhY2NvcmRpbmcNCj4gdmFsdWUuDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMNCj4gPiBS
aWNoYXJkIFpodQ0KPiA+ID4NCj4gPiA+IEluIHRoZSBjYXNlIHdoZXJlIGRvd25zdHJlYW0gZGV2
aWNlcyBkbyBub3QgZW51bWVyYXRlIHNvbWUNCj4gPiA+IGludmVzdGlnYXRpb24gcG9pbnRzIHRv
IHRoZW0gbm90IGJlaW5nIGhhcHB5IHRoYXQgdGhlIGxpbmsgZHJvcHMgc28NCj4gPiA+IHBlcmhh
cHMgZGVhc3NlcnRpbmcgYXBwc19yZXNldCB3aGVuIGl0cyBhbHJlYWR5IGFzc2VydGVkIGRyb3Bz
IHRoZSBsaW5rDQo+IGFuZCByZXN0YXJ0cyBpdD8NCj4gPiA+DQo+ID4gPiBCZXN0IFJlZ2FyZHMs
DQo+ID4gPg0KPiA+ID4gVGltDQo=

