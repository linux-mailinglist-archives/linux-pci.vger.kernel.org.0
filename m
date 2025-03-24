Return-Path: <linux-pci+bounces-24477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A688DA6D392
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 05:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A651894030
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827A17C98;
	Mon, 24 Mar 2025 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QjNeLFAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFF23A9;
	Mon, 24 Mar 2025 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742791162; cv=fail; b=C+ZPwS/5DIJ3AUZ0sBtJVtLwVQIW88FVhYmsoy5cWEjUpEm+krlxllrAmMzRo7G29U+4QD8TclKdGZqHY78d06w8EmHB5+9WAAK+GIqWKJG8XR++f/Goqvs2t2XWX37w28T5EqkdFhTN5eeNhtcn6SnBDFghMGU/41sq+bKxZpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742791162; c=relaxed/simple;
	bh=RsQRG511sCClcyuvYVZwjFWj6eQyA0WLLxm5tDP09Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rINLj/zVWuQAkFZrWlGpR0vIV7Hph73jctY1xiKrFT6xdRx9paskgMRhFmh4ZtzHbnTy7VsGGhotrZOJGTfhSdTHaY0ZtHxkilIWj/zIyF769MntS+6I3w841+RSCKjPRmdjjaSIWvHNn8a9ALiplMdxWrQkb6ap/eSBfvDRmkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QjNeLFAa; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO3gSAa7pS2T2EQ7LNak8WsQRfqKlq+vvdyRlFm7OVHoCZGrPiTv5g29HLgk83lf+2i771uqiGzme/fjC0cfRgsdLbj9pBg8E/A33S6oCaJEJHWtRjAEvhPNBOEMqE4OFXLQmV7ldprs+N4l7gpCqwuYFiheHNmzaG34xKP54rjwToGRkSA8r4G+QbXkzn5wfULOQ9SVPBJMgKoInxM/YijBiD79G1xUkjjbGz2ZHrDMjfsGCns+UaoaC/zHRt85zZkxBbAKUXh+hFRNtRqId16Q9qFW2IHUurPFEYJEu4UwPae/mmYZp2w3po21LO9vpNN/qnTsuWl6ObAudC98KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQSI7cgVz9D2YpLW0/YzqnHOZ+osngT5+JuU3qcOq90=;
 b=lFq7tceVa+syYqO9SSs6luNxWecQ2upXB/wWo3JRa27sYlTvlJkAlDT+FacFcM2L4V8Mz6n3uDFtIyj7f+Bv23Zo1ZOZsyuXvoMi0uqWi0/v8UCCYPEyBUUyh0bnZD/8rVy7OUKiGMqhIkvxpwGBPDG9TDJYGJgWfv2RW3zoFN7m/5hhfb/yFiuL+adGs4mhT9oWm3Gal2tFglgRBL3N3kW1zNm92OB/u6DwL7pLUlOxEjv1m82IxyzmIPOU1Com05PX9b4/qCU8HERvyg5xBQrHYLnTiwpW4bE1qqPRzxjfs1j0LNYA7qbuoTn6DdQ/c4Pj1srs0nNZP32dahbMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQSI7cgVz9D2YpLW0/YzqnHOZ+osngT5+JuU3qcOq90=;
 b=QjNeLFAay8pEOYjW6ZGwK+cX5sAGi59NkLdKfK9DvDWqWbpwxEF8cS/SK12lEudIOuYVmILXevl7CqqO7jRhXZtmIfOa8D7uPmV2vR+hC70vrIy6M1FSrM13PvilnKUmVAq3r1hwr26h9zD3twn7wgNNF+f0yToUPWIGY7dKvdE=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 04:39:14 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 04:39:14 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH] PCI: xilinx-cpm: Add cpm5_csr register mapping for
 CPM5_HOST1 variant
Thread-Topic: [PATCH] PCI: xilinx-cpm: Add cpm5_csr register mapping for
 CPM5_HOST1 variant
Thread-Index: AQHblzn6K4uoE7dESU+9Ri50kCv+tbOAtgGAgAEIfnA=
Date: Mon, 24 Mar 2025 04:39:13 +0000
Message-ID:
 <SN7PR12MB720191752A36AD0C90E296528BA42@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250317124136.1317723-1-thippeswamy.havalige@amd.com>
 <20250323125101.GI1902347@rocinante>
In-Reply-To: <20250323125101.GI1902347@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=87ec4e40-ff6c-47f2-a653-e2ab2b2e33b4;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-24T04:37:39Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB5938:EE_
x-ms-office365-filtering-correlation-id: 05e12d03-18a2-4606-c5a1-08dd6a8dd43d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?d8x7LOTFtB6AGszNMC1Wo9/+DxvLZPUW84Qp86CeCwHTsOGdlRSlXmWOB7?=
 =?iso-8859-2?Q?626Uk+SgFLnSvc91o9R/oaBGA6Iyipwm4tWgRpUeS+KxzQH7lHohjCRFjZ?=
 =?iso-8859-2?Q?vdtJsXP4Xvx4AMypf9NEvjRKp9g1T0q8KS58desj0feauV2TfVzzajT+kz?=
 =?iso-8859-2?Q?CFL9A4lkOKTBJCAtQga6jM72FyqTwjMk33kJU4F10xLxQmBA5IP4fFuNK3?=
 =?iso-8859-2?Q?ZOsK+bnfuTdama0ikWYUQliwv/MtozAJx1hqc0Bv+Z4xB0frYYJPfpmj6p?=
 =?iso-8859-2?Q?0x5UvsV23+OGRxt6DsoTbqbwZW1ce29I0EjkF/MHItts9Uo1dpOvrCCaJ7?=
 =?iso-8859-2?Q?Fd1L4Zf4u0Oeq0n8vkdw0WEvugj+Xslvy2vcl6g+p70+wT0kGh4UeYVCWu?=
 =?iso-8859-2?Q?Ig0f4lMAQDAxytOQuOGEwL/WU3DiuF5TqDRw13G7Y86O29/483GQmAt484?=
 =?iso-8859-2?Q?oL1mXBxv4YnUmLN1Wse5ImLluhf5zFp3ePqjcK7JCBZHiM8Yfga6DCVf0J?=
 =?iso-8859-2?Q?g0ApzsZefFeGLkn1cZVumzEpzusBZsiHEllot5CgVhLUvl5LmF32A1ara2?=
 =?iso-8859-2?Q?S18Xw94LIC5PXZQ/5RtQw33FbUMkdaPWxpy6ThYzgs72QvUaAVdZnAz/TB?=
 =?iso-8859-2?Q?qk1BBBr+DjPB3LsDi/RpJ8p0rhR488lKCC54TQbcqZdedqjTZwYZQJ+KmL?=
 =?iso-8859-2?Q?GWXRBiHDyw3UKbyfMP3V3k9PuyJyo4ftmaV4tyoXxRlSUi+k7GmYVcX5tx?=
 =?iso-8859-2?Q?6CB77H4ux/r9tjqhjLQvc034ksgI/DaUROJRdERnaTVQWADplQsbzwvDv3?=
 =?iso-8859-2?Q?+I7oijZtlUQVoKKhoagvhYuaFMzUHKd9TC3HVYtlwiA8RuHxaeNSsX/+9Q?=
 =?iso-8859-2?Q?Km83swVxCeoNJCsAhf9Q1GF9Z6bOoy2LwXzqJqURhD3U9svxoTOjWq4rNn?=
 =?iso-8859-2?Q?B1FSuFwa8C+cfQuy0XmIqVYbaLPdCbv3BJHiNUrDEDLrPgA6A91+qyaZ1a?=
 =?iso-8859-2?Q?e7RkZk4YNQTl1Gm82H/ZfW+3lZ7iyXsbdG0nWx0h7MmX5RgfxKoNMudL7/?=
 =?iso-8859-2?Q?8s8z+KShW7Cm9B47TJ4eLE3j227QCAjkL/KLvh+tod1+fDV8n4FX0G0+AO?=
 =?iso-8859-2?Q?pz7krTZQq9vmL+952mm8kZKEh7ftab6O6FNE2DzZdlU9/nVM+hc7c9RZnB?=
 =?iso-8859-2?Q?z7YXNWqxqnoA8EXZqg10e2dqQ3/SORLGOqzVuBX5ElsRg5M3yTMl7Ed3fd?=
 =?iso-8859-2?Q?nw/fTAFP0kH/mFhiewm1iDvangxC8W3kYyNPHp803jlzi2VhJ8m4O9N8Sz?=
 =?iso-8859-2?Q?pNGTi+W5C2Tc6d40Gc6KstoBxE5B0aUX8EF1jG+uNV57kNnmMDLGyURcBX?=
 =?iso-8859-2?Q?wJCs2PRUT8cVLBOUHrTvzWOL9k9gJhAB0lWCugKcyK1BklymUTy0zKn6xN?=
 =?iso-8859-2?Q?zn1zF5SivLdrAW45j02rTTxNZjmst733oxsz5gfXb6tjHnmPPCE1Rba/i5?=
 =?iso-8859-2?Q?Zuhu2l006QqHbbpZt7oVzJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?rxdSft8au1vqjoeXSM0qJA02ITCCAMYrZZK0NbfUlv6+mFM6D6HpiVjlJ4?=
 =?iso-8859-2?Q?muX4HJ7mlAISSQ+7kIm/kyIOmwa4lYUw9dmEQ3FSIVfusnwJbs5bDNB5kq?=
 =?iso-8859-2?Q?JIP/ovxcPG2lb9H7NzDbcEmBID5MdD5iPgBVTJCUIJNTkbke8+vpTVlWW0?=
 =?iso-8859-2?Q?AtiwaL2Hm7lT9ExGSt5Pb5uWrCehEmxNzOurrvTYZP3OqAt0FuXQMJSMR+?=
 =?iso-8859-2?Q?5795up3EuD2U1fri85I1y+PDyv1NfTj/3XD6m2SKVtTQVaeI5Fep2okaUz?=
 =?iso-8859-2?Q?TaMPRgLobohbvkGti+YVqs+SP84Vakp4HVrfaBd1y/tsI45QJK4D3YLh0S?=
 =?iso-8859-2?Q?wwhFRbFCzdZhZgWAyxPZMlq2SoxwWdkfeFRQ4+rkeYJtYGqru3q7WjJjS6?=
 =?iso-8859-2?Q?YIGvoC/6IAflUP0luHnpC97WbD9d+AfbLdTrJ0ghpNmcR+nrqsUOHrrCXi?=
 =?iso-8859-2?Q?rLG6U14UdTWzgjHTMVIbLdKQhub62oOnQIV24hVRoakDdJsxWo4vAXSEma?=
 =?iso-8859-2?Q?4s5J7HPyx80pDpHbTrJExQbE01SDcn9CkB50zA7hNklM/WqI9LZ2cTzYxT?=
 =?iso-8859-2?Q?+3YafDK1HSLvJQy/i1LMp1i6TghwqQ2LKuSrMktY+N/8/SNoWZx0PeHoAy?=
 =?iso-8859-2?Q?Z+F5KsRnhQHfe1FWFuCtNschJ8Yqu4HOogF8LdlFXSO1hOfJqariYeLZ2h?=
 =?iso-8859-2?Q?X0IY/nOcxnv0WdKxGMTlq31RyOJy3YHRwcfO7R6qeqxvn+h3CO0GEZmVez?=
 =?iso-8859-2?Q?UeJKtmrViPHeQikgAZOhpjgs5CwpgRxFejw7i8Qaa5mrxsGeJStsgtTABt?=
 =?iso-8859-2?Q?pOFf1nwOYR+Tng4vGKootxLqg9SSZDYzlislXTbLONbDV0XK7UVAmXq/Dz?=
 =?iso-8859-2?Q?ucDgJDrdsQyIkh+/Pcr6UzHJWvFWeiLA3Sny3K6PNKuoyt3zeu92OVkJ+x?=
 =?iso-8859-2?Q?99XMUhM8UPrnl7MxlgpqazYp/MXpvj529VBTqRlbFwtkbf+DDKhEG6WWQL?=
 =?iso-8859-2?Q?0eBUoSpItzCOPc3U59ZAh5eEzV/QVNem9wNaQ9V/mueaIO+5qBWf1pfn2g?=
 =?iso-8859-2?Q?bGPbSy4yE8V8xdS2Sqorlil3y9AjqqOxnTVFXwKhMOJ35hdKP3iw8EFzul?=
 =?iso-8859-2?Q?ul1t6Q74efYcIAjNTKJBgye2m0Vr23HpndQhzJp3f742YAKSFmUDHTfAXD?=
 =?iso-8859-2?Q?NQ0+cy1gDfH4lA6lA3PSMbWLSOzQkqvPv2k7VUEclf5Xq+kuXuLyTW2fRb?=
 =?iso-8859-2?Q?Vc65R1rhTn4GJsM6judgSo/I+1JlzpVfI1Cpv/3rFmg9HaO6/qB9nDwMlg?=
 =?iso-8859-2?Q?4lV99fYxbNvr5Sq5WOgNDWfp0J5x04yMMQR2RcCoUOyDQf+j2R2XRWq+tF?=
 =?iso-8859-2?Q?wBg8dG6g/FsHPpvEnTHulaz8lr9rKDQoekT5Vop9PncqzX1WFvT/Dtcn6q?=
 =?iso-8859-2?Q?Dt2vOfRMTrxR61Aw3NExZpT/x0qIpSv64bwegU3xiTqbD7QyY0G4cpu85O?=
 =?iso-8859-2?Q?Gg6r3RapuV8Dr16Sqohot8BEtIHDeEyNUoFDJAoWgI1iZMU9QPxELQ9u5+?=
 =?iso-8859-2?Q?W5UuHC0P4tMOUQVkqm1sx7Jdn9W8lFEjHAedWM1K3FUnIFzh6S7BlivWhN?=
 =?iso-8859-2?Q?fJsnHaYWYJPGs=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e12d03-18a2-4606-c5a1-08dd6a8dd43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 04:39:13.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeekOSZm4ZFvilLN54DGeppf/k5z7CNy+pQZQS/j5jQ8FhDKQH5LCWk8g11zlHG2La0xeFE0sRkXKxjKEI9nww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

[AMD Official Use Only - AMD Internal Distribution Only]

HI Krzysztof

> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Sunday, March 23, 2025 6:21 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH] PCI: xilinx-cpm: Add cpm5_csr register mapping for
> CPM5_HOST1 variant
>
> Hello,
>
> > This commit updates the CPM5 variant check to include CPM5_HOST1.
> > Previously, only CPM5 was considered when mapping the "cpm_csr"
> register.
>
> The subject says "cpm5_csr" but here we say "cpm_csr", I think it's only
> the latter?  Let me know, so I can update the branch correctly.  Maybe bo=
th
> things are correct.  I am just double-checking.
Yes, You're correct, cpm_csr is correct one and not cpm5_csr.

Thank you for correcting.

Regards,
Thippeswamy H
>
> Thank you!
>
>       Krzysztof

