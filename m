Return-Path: <linux-pci+bounces-35217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD5B3D846
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6940162AEA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 04:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FF1CEACB;
	Mon,  1 Sep 2025 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dozTYEnR";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tmwt0tY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81267F9D9;
	Mon,  1 Sep 2025 04:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756701078; cv=fail; b=odf0JhGZK+vSm6U0PDIUSyFknpeDUkOjp69+Xy0DTGUEqEx9HR0NMpl+8oD+Zt33KEz1BTJb1UvWfqGNwl8i0zLxyQTd5VjuZ/v9ogPCRvrGARqJeOlRwQ9NAClQY7RmIcdXKbvWl1a5oWZRK5VwZVWfCBUecGKcbKZftyV1bMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756701078; c=relaxed/simple;
	bh=3ERHdNf2HyJxKdU+QDldUgTcSKOM09EKwGZo86u+/aM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wvrst0VLvGlwob5XZIJHd7SMmPbyZg0iU50mqvpKQRFinXP6xhj0Inn6mQmddgjpF3sbIkAA7Co6WmmgX0DmL4I/dPsEbX7JrOD612LNlb3xITapC0c4/hQcApURxkpt6ou7Y10GnDhZFYYLqQE3gRncCEYD5Vhkct4gtz9thRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=dozTYEnR; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=tmwt0tY/; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VLKBNE015923;
	Sun, 31 Aug 2025 21:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=3ERHdNf2HyJxKdU+QDldUgTcSKOM09EKwGZo86u+/aM=; b=dozTYEnROD2b
	zQgYKJLO2altloKdx8fNR7IV8v6o8CB2vyTXRDpoMf7nzM7vSAteczAs03+ea7jd
	BxiAnqEff1Ud2zC1mWvXQZ9kNmyZeMFCMvQiqGYRH1c2AmpXx8sNquyo9N+cXZ3L
	vivG1ftItPqS/ZKtyCRUQ1Cr4ikKorZMIT/uVDaj6db2XLMjGDB6fj+d4joFkNPG
	rdyxWIsKByKe0Rp/pe6f2ITZ7Coq4jpLkHRZmMlyOdOWPSkLo7rlcW63MdUgU95H
	eMtb8V3E9PVZ5S3lN6gim1UpXDd2w6pIF7pN1op/029ECUTBxl/C2XpN5K/mrC5K
	haYf9zfJ/g==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 48uvvx4bg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Aug 2025 21:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSp+adHmRM/9PzlPT3QZQsUxbJ2mQ7Xl4qlZNi8qMgbYSUlgF2tT5oII6psYIWoDKrEbziuWwqTfubr4KLJOhF+RtE+AYI/L8XZGTd69iQFaRjt3tPHB1iu2wh54xG/VFWHbuWNJrUoM9TMkuu9GPrj/bY4S01Js0RgxpuImLDzELdYl68Rmy7ERfDnlDnx+o5YdUqLw0+7HAWWfaSz5pGLuTa522xJ5i4J7HqBgE85RYDvb3ZdrLB9Q8TGoMCU3i4RZfmHBJSUvNXIF5ttb2ncuc/eqUJhAPuOVEbuFk3i34vkae+vmHD56IAznJo1Hkwakgf0S7erd/n/EchoJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ERHdNf2HyJxKdU+QDldUgTcSKOM09EKwGZo86u+/aM=;
 b=oVZ4OUNelxxagiFvS3lCYo+SLXJIMHA3Gxkko+VxKYtfe1fWv1kEG+Ipwu4/7e5gChQ0PtWtguxr1FcpmktpAI65hFGz+rnr77HC1JxJjAos6UYiSsauuFMhHUx00/pkoDmpNEJWJlAlNqI6a5IWJYnOR90bdYhRXwIq0lGhW9JOF90te5qgyRpo7ZzBs7NsBO8vteQhBnJ/hUGhQtz/sIonId4DtAx0pldmqJQgZAsciaakO7CwICRRPOWTFwhia6XsUccqAGSZ2heAm6WjfgNRTRVb+41u8yjCe+CzbNTDVeh0T5LPNCJqO+erRfAzBAa0uCV1BatTIDiu4kOIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ERHdNf2HyJxKdU+QDldUgTcSKOM09EKwGZo86u+/aM=;
 b=tmwt0tY/4NINMUm+T6+jXZhAnAnClsXkVqdyT0YyVqx2ogdaTxPIzAazpJQdphVTTBk2LDs/kfgyj6RFKEitkswgJpotTPHDU0LVfjfZc29+U32N+wZtpXc3nU7JItqXEj/ERm74aMQKpjG8aBEFgUjq/Him2TtUJnOjDXliENg=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH2PPF57569E98B.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::265) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 04:30:59 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05%8]) with mapi id 15.20.9073.010; Mon, 1 Sep 2025
 04:30:59 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com"
	<peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com"
	<cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 07/15] PCI: cadence: Move PCIe controller common
 functions as a separate file
Thread-Topic: [PATCH v8 07/15] PCI: cadence: Move PCIe controller common
 functions as a separate file
Thread-Index: AQHcEQAl6EcACSm2qkWvc/mnN8VDn7R7HnqAgAKxvHA=
Date: Mon, 1 Sep 2025 04:30:59 +0000
Message-ID:
 <CH2PPF4D26F8E1C00BA70B94B327B46E794A207A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-8-hans.zhang@cixtech.com>
 <565vte4ktztuj2k7pipdtftbjzloldsascqhaklsfmxmqx22z3@jp3xmgrvc3kc>
In-Reply-To: <565vte4ktztuj2k7pipdtftbjzloldsascqhaklsfmxmqx22z3@jp3xmgrvc3kc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH2PPF57569E98B:EE_
x-ms-office365-filtering-correlation-id: 0a30cb50-9050-4636-c19b-08dde91059da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXhNVlQ5M1hOQU1rbWZYYm1BTzVueVV0OExUQzg4YW1ZMnNhSi9XcVc1Yitq?=
 =?utf-8?B?SGlyZ1ozd0JKVk9yNlhUWFFML2I4VGtQcTF5MlJYRFZZSE9Hbjdqd0JlUncr?=
 =?utf-8?B?S0plZ0JkeGJTeVk2cmp6b3R3VStnSUI0dHcwcW1Nb3pHeTl5SklQazEvNHJn?=
 =?utf-8?B?MW1Dd1hEL2dtQWszRk1uOVpFY096bjV4cWJqYVRseGxjTXBJZCsvMnJQa2ZB?=
 =?utf-8?B?aHhRenpBTmtXSEZiSkdLeThma3F1akhsWWhsOS9zdU44VDdvL2ZRWUtjRFBx?=
 =?utf-8?B?V00zRTVPSFF1MHNDczdabVc0Nm9rSlFxMGNaS1htekdZdzhJWHRMM3cyY3VV?=
 =?utf-8?B?b3hlSjlVV1ZHblNSaVRHVnlqc05Hd1NvM3JIemtGT3paOFZpNGFzYUd5WGNJ?=
 =?utf-8?B?TzF6aXNET0ZFSVJna2psRSttVDhJemtYZFpHem5GWmNSazRvcU0ycUZJR1hS?=
 =?utf-8?B?bFF5U1pZbThCamtLUGxIcnQvWnBDWTBKSkh0dTBGTlB2MzhaQXFCekdHMVl1?=
 =?utf-8?B?Wjd4Y1B5dzQ0ZVhSOGlkeTZNUjN0aTJGK2RzUTdTM1ZxZ1VtL2N6ZkxoYnMz?=
 =?utf-8?B?OUsvalFYeUdvdEl4Yys5VE9OcVdRWmxiaGdFQ3pMU1BUZWxaSGVNbXdGcWtx?=
 =?utf-8?B?U3N6cEs3Uk1pREUvbFN0TU1hb0lHRFhHZElvVjVINW1xcERFMk1PSURHbWRt?=
 =?utf-8?B?eUF6OGpkR0psUjhobU5JOTA5dFF3bEZlZ1hxZmJOZTJybGpIZW9YMlhhekUx?=
 =?utf-8?B?QXBCQTBXRGJweHZ1WFRscDQzeUFicUpyS2NMSTVzQ1hScUU3SEw4aVJQU1Jy?=
 =?utf-8?B?OGpYMnpsdGVlcEZKTkIvODBDeTNZQUh2NnpLTFJETUhuMDBYVU1NaDJYYlZw?=
 =?utf-8?B?cTB0RzZQQVVhR1ZlZ0ZFeXFiNTl5WG5tVDczdFVRUUVjSFVrQkFWRzdJekEx?=
 =?utf-8?B?MTJLdS9XS2cwdXNWY01WV1NUZExjSWJMN1hlR3psM0hFcDhta0p6MDBTZm9n?=
 =?utf-8?B?bmpEcEg4N3JhUG9ENGR6NEltcGVNaG1hbVM0aHc1cW93SW5CczJIQTAxKzIv?=
 =?utf-8?B?d2hld29GZXVIN0loT1ZTOEVaNWs0S3NsN2dlMWlsTkNrSDNkRUtpQ0RYT1lN?=
 =?utf-8?B?NVBkeW1MNnhzeWRiN0FKNVJ0MXg4Z00xTW5ibm1vR0pJUkhuM1g3NmRWUHJs?=
 =?utf-8?B?NjVFeEhQcDFPc2JnYVM2cmgyN0pUZ1d0TjVzbmg1N2ZwMXl0VlJ6YmNxWWFV?=
 =?utf-8?B?b0NZM2pYVGNTemVSZWlnSW81U1E3S2pPOXAvWHBJdWt4Y0k3SlBVenBUZytj?=
 =?utf-8?B?a3YxbSt1UC91T3JJbGx3aEhsd2NmS1NMNEEvNmNOc0xlRDNHMWhhSDltYkd3?=
 =?utf-8?B?UmhUemxoMm8vVklqdFRJb0lES2liL2NnVWdDRmFaWndIU2tyVnBZMFVEL1pP?=
 =?utf-8?B?bnljMDhtZlYxYVhqZVpKbExuemZod3dhTlpvRUFXakwwWFNMZFZuZGlYOXQw?=
 =?utf-8?B?YzI5Yk94bWZhaGlXZ2MyaE5YSmtRTU9aRGw4MHQyMERaMWZDWU8zM0tyaUg5?=
 =?utf-8?B?REpXd1ZCcGo0K09MZGxjdU83RExtVU4wK0xaRDBUbjNsa1YzdDcrRXZBaWE5?=
 =?utf-8?B?WEtqa2RPT3p6S0liVjJONnRwZnU5dHd5Uld6YjlXY0lqQVI2dW5IOVdyNWlN?=
 =?utf-8?B?L2Q0YnZKUmk0UzRxdmU5bzhjZGhCL25TT3JIZW5mOXpsMDdvcTZlSkpYVWlK?=
 =?utf-8?B?M1hJY09MeWhHaEF0Q2xpL1FucVpQbXNLc2VySzk4VG5IZjFwV1JlMHhTdndT?=
 =?utf-8?B?VTJ5V3V2dWlYbTkwRHBBOUI5ei94SHhENGNycUR1ZGZBdmlaWG5Zem1RQ1Z4?=
 =?utf-8?B?TG1qS2ZUY0ExTXNaVzVJam5wUzk1ak04RUdCb1FVbC9vRG9ZZzY2U2wyQ2ZU?=
 =?utf-8?B?Z0tMZG1FOVNmdzUvR0p4QnZ3WUVldWVnTVJ0WmVvWXdISlNpY2ducU02ZXcr?=
 =?utf-8?B?TUpteUxGMFBRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2FrUUVJSXcydy9FL1lpdFo5WWJRMys1RXE4Wncxd0ZJZGRXaHpOTkhXdWxr?=
 =?utf-8?B?MVhsRkZiSlNxVFJNMVVRd3BwOWVWSEhBaUJJMWNjdXF3ekExZVJsNVNsekJm?=
 =?utf-8?B?NG0zWHkwQk9pM0dCT1F0QVdjbjdyay9mY0Y2MDQ5U2FjTS9kWU04Qms4WDla?=
 =?utf-8?B?aExnT25MdURuNnZyUDZ0Y1Vwc3NJTW9GekVyZE1xODRxQjJ3bTZCclBSeFBp?=
 =?utf-8?B?Z3gxMEtGVk5JR1M5Q29PU01LOGNtVFNZaTh3Si9qWXg0VWpWMkZVQ2xKeVB2?=
 =?utf-8?B?cFYwTW5ybjFIcCtoOFlsUGJJN1R4NUVINnpTMlc5cE96WGV1b1pXZGYwb0g4?=
 =?utf-8?B?SGlENTc5WTF3WHg0TzhndlBIY2JpZ1ovaE9sNk1xeEtFdTA3TUQxdmM2U3cw?=
 =?utf-8?B?UkxOSUlPQTJzQ3libk94bGVRMEczejJoUkZ0b09ydy9yRTUxaHp5YjZJeTBT?=
 =?utf-8?B?am9lY29tYStDbFdxK1NXVHFrNXcra2F0OHV6M1VCekN0eGx6SC94ZTdFUFNl?=
 =?utf-8?B?NHMxRHRqR3VnU1lPaXlXc282YlkxaGhvcU1pVmZ2YVg1amYxMkp1MWNJNVFh?=
 =?utf-8?B?cHpQbSs3NkpIUkkxWjRSYzgwY1ROckc4M1RTbE0xRUhGeEMxMlJxeHlZLzZE?=
 =?utf-8?B?K0krdzdoaEtBdjRoUytobHJXMmtYQW5kUXUyRURCZ3FPTWRHMjJOWnlCTEQ2?=
 =?utf-8?B?emVBdU1mdWM5R1ZTcytoYXIwWEZXMDMveFB3OVJSZmRjMjVjWVhqR0dSU0pB?=
 =?utf-8?B?VnFGdUQ5Q3pZSGRkdC9jNm02SGxUT0ZBdGkwR2VTanBOSkFUbU4rRHUrbk9D?=
 =?utf-8?B?YytwUzU3dkk5NUR0WXFGS2dXVkJXR09VM2dhZzVuUllLbFRMSy9JbkdBdEVj?=
 =?utf-8?B?VVZMV3l1SFd0OFNOeDJsNGEzNUxQQkE1NnpZZmFVVi9QRkJuZHNGTmduU3FK?=
 =?utf-8?B?d3BJckczZDhhVUlCamNIOGdOeDhNditDQ2FIRVRSR00zZEhISFB4eHczOHVt?=
 =?utf-8?B?MkJzZzBDNDIwalAyRFlvK2lrcFpUYTFiWDBKZjY3SC9ra3p4QmNCNk9YU0dS?=
 =?utf-8?B?NzE0bUlZUFdVT1RxVmpZeVFOSE5jSkZ2ODQ1V0s3cXBPR0hIN01JeW5jOUJO?=
 =?utf-8?B?SVdIdlhaeFBOUTFpZXdoK0o3bEovUWwvUWVTNTBOSStJbmJUNUJDdUhaS25R?=
 =?utf-8?B?N0hHTDFGRGpuSHhQNDRhdFZzY0FwcHNDbk9TQ1hKV0dpL0h2VDFlc0F1NVV4?=
 =?utf-8?B?WXBsRFVaNmpMd0tBanh0Nll5ekFBaDFCWit1OXpTN3JUTXdrOUgwUWJhWktm?=
 =?utf-8?B?RFp6UXZxeW5DR3dxZk4xeFdKSG1UblVVRzF1aUYzbWxVS3EyZlh5T3lrb2Rt?=
 =?utf-8?B?ZUhGY2VoeTRBTEdWSjI4eXpnTVR0dXBaSUd4RUpZbTYwR0ZoM0M4MzVPamNu?=
 =?utf-8?B?SmFVTVBnQUYwSDZFZGJKUW5jaHkvdDFlejhFRS9wZndHRTAzMm5xMmxzOVhY?=
 =?utf-8?B?blBaYW9lWU5yQnJJUldudVNoTjV3cnJNOGFhWVJsYVZIUTZzMG1VUnh4bW9Z?=
 =?utf-8?B?RllqL1RLRzJrcnhYUkYxeTBaTTlQTXZ3ZHRBWjhwWllpUDBZM0ZnMjJnR0tp?=
 =?utf-8?B?K1R0b2VpbU9KbEtXaXNRUzkwZDVqNmg0bFlZeFI3VWZzSk5wanNzVng3Q2hU?=
 =?utf-8?B?QUIvTStDRXFncUt0dFFDMy9xVm8zZ3k0a0lrVm5QbFpvRlBJQnphSjVDS0RY?=
 =?utf-8?B?MW5DVks0bmJZdWdaN0xKSjhuQVdnT1YxZ0k5dE11eGJhalJCMWJPeWc2dnFH?=
 =?utf-8?B?TElpYkk4clRIMGZLQ01sNC9ocFF2Mk9wL1VENWdHSVN5VmNDc29iZC9PaFRZ?=
 =?utf-8?B?TnZvWmYzN3ROU1BwSkJKSWkxR3hndy91NjFIQk5UZ2xUVHdqR29kbWRoOUFB?=
 =?utf-8?B?UTRybkxDNUN1c3hCR0tkalplVFFOUnA4dUF3VDgxTEtnZ2tDa3YrNUliTVpE?=
 =?utf-8?B?ekg5MzlFcXF5dlFBQlc5M3BLR1ppbnFYTnRhbmNRa2d1SnZyMENZcW9PZTR6?=
 =?utf-8?B?ZkpXREExNHFZSUxOS05jQkxmMkE1SHhsaGZBaUhqbnhUOVlETWlMU2t0UWxw?=
 =?utf-8?Q?ritbFgbGYcnbW2IM+ZwGaEAm2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a30cb50-9050-4636-c19b-08dde91059da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 04:30:59.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBsDMEBn+PHcL2qVjjwaUl8aVIVD/dVeHuwiJnz2Aq2iB3u4zBmmk6iSA0zU7opc9wrcBxu8jRD7NYiezahR7rxfjFIYibh1Wf5zeodH2e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPF57569E98B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA2OSBTYWx0ZWRfX7wR4Q28goov/ 4zUi5hS33213YM/bkNgHj8n/l5yroyzFAH04wetuXWTmpdhn3p/ZQk1MYmcoRzxCOhq5qgbAxH0 LwyGBx5zPGY/PWDwDYMzu17pVeFL1DeC4RTBf1zYHe7UlNlogj5ba3YrE+Mt18J+VWfxHHnuyZw
 Qtea+eHl2AFHgapVa5pEC12cSy7FOYu9OV1Hc9vbNtmKmCyKAk/PKZmDtXeUu+86DQZCUkBFuQN 6rSrk5ocxo9RL1W7S68eiTHZCWpBiXxnUENX2UU7KQFailYHCvWT39e23WPu8wdGGUL5+H0WX9n tdusMmWZXWlj37fCVXXP5zce5qJP6ZAXpvGsQjywoHNzDNEouCcV5T9KT4XC3MT8VBkvy/Uwe9Z qKxBArdH
X-Authority-Analysis: v=2.4 cv=W6w4VQWk c=1 sm=1 tr=0 ts=68b52185 cx=c_pps a=PLcI3SF5L27/RyFVs0pFTA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=uP1ucDPQAAAA:8 a=RYEcHNO0R2CImxULFCEA:9 a=QEXdDO2ut3YA:10 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22 a=9a9ggB8z3XFZH39hjkD6:22
X-Proofpoint-GUID: a11TOVC1ou3fy8eR1JcQLM9dxjDO1Crg
X-Proofpoint-ORIG-GUID: a11TOVC1ou3fy8eR1JcQLM9dxjDO1Crg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300069

PmZ1bmN0aW9ucyBhcyBhIHNlcGFyYXRlIGZpbGUNCj4NCj5FWFRFUk5BTCBNQUlMDQo+DQo+DQo+
T24gVHVlLCBBdWcgMTksIDIwMjUgYXQgMDc6NTI6MzFQTSBHTVQsIGhhbnMuemhhbmdAY2l4dGVj
aC5jb20gd3JvdGU6DQo+PiBGcm9tOiBNYW5pa2FuZGFuIEsgUGlsbGFpIDxtcGlsbGFpQGNhZGVu
Y2UuY29tPg0KPj4NCj4+IE1vdmUgdGhlIGZ1bmN0aW9ucyBmb3IgcGxhdGZvcm0gY29tbW9uIHRh
c2tzIHRvIGEgc2VwYXJhdGUgZmlsZS4gVGhlDQo+PiBjb21tb24gbGlicmFyeSBmdW5jdGlvbnMg
YW5kIGZ1bmN0aW9ucyBzcGVjaWZpYyB0byBwbGF0Zm9ybSBhcmUNCj4+IG5vdyBpbiBkaWZmZXJl
bnQgZmlsZXMuDQo+Pg0KPg0KPldoeSBkbyB3ZSBoYXZlIHRvbyBtYW55IGxpYnJhcnkgZmlsZXM/
IFdoYXQgaXMgdGhlIG5lZWQgdG8gc3BsaXQNCj5wY2llLWNhZGVuY2UtY29tbW9uLmMgd2hpY2gg
aXRzZWxmIGlzIGEgbGlicmFyeT8NCj4NCkhpIE1hbmksDQpJIHBsYW4gdG8gZHJvcCB0aGlzIHBh
dGNoIGFuZCB0aGF0IGFkZHJlc3MgYWxsIHlvdXIgY29tbWVudHMuDQoNCi0gTWFuaQ0KDQo+PiBT
aWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIEsgUGlsbGFpIDxtcGlsbGFpQGNhZGVuY2UuY29tPg0K
Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBIYW5zIFpoYW5nIDxoYW5zLnpoYW5nQGNpeHRlY2guY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogSGFucyBaaGFuZyA8aGFucy56aGFuZ0BjaXh0ZWNoLmNvbT4NCj4+
IC0tLQ0KPj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9NYWtlZmlsZSAgICAgICB8
ICAgMiArLQ0KPj4gIC4uLi9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWNvbW1vbi5j
ICB8IDE0MSArKysrKysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2Nh
ZGVuY2UvcGNpZS1jYWRlbmNlLmMgfCAxMjkgLS0tLS0tLS0tLS0tLS0tLQ0KPj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTQyIGluc2VydGlvbnMoKyksIDEzMCBkZWxldGlvbnMoLSkNCj4+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1j
b21tb24uYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVu
Y2UvTWFrZWZpbGUNCj5iL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9NYWtlZmlsZQ0K
Pj4gaW5kZXggZTQ1ZjcyMzg4YmJiLi5iMTA0NTYyZmI4NmEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvTWFrZWZpbGUNCj4+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvY2FkZW5jZS9NYWtlZmlsZQ0KPj4gQEAgLTEsNSArMSw1IEBADQo+PiAgIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gLW9iai0kKENPTkZJR19QQ0lFX0NB
REVOQ0UpICs9IHBjaWUtY2FkZW5jZS5vDQo+PiArb2JqLSQoQ09ORklHX1BDSUVfQ0FERU5DRSkg
Kz0gcGNpZS1jYWRlbmNlLWNvbW1vbi5vIHBjaWUtY2FkZW5jZS5vDQo+PiAgb2JqLSQoQ09ORklH
X1BDSUVfQ0FERU5DRV9IT1NUKSArPSBwY2llLWNhZGVuY2UtaG9zdC1jb21tb24ubyBwY2llLQ0K
PmNhZGVuY2UtaG9zdC5vDQo+PiAgb2JqLSQoQ09ORklHX1BDSUVfQ0FERU5DRV9FUCkgKz0gcGNp
ZS1jYWRlbmNlLWVwLWNvbW1vbi5vIHBjaWUtDQo+Y2FkZW5jZS1lcC5vDQo+PiAgb2JqLSQoQ09O
RklHX1BDSUVfQ0FERU5DRV9QTEFUKSArPSBwY2llLWNhZGVuY2UtcGxhdC5vDQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1jb21tb24u
Yw0KPmIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1jb21tb24u
Yw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZTE0ZDUz
ZDY0YmYxDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2NhZGVuY2UvcGNpZS1jYWRlbmNlLWNvbW1vbi5jDQo+PiBAQCAtMCwwICsxLDE0MSBAQA0KPj4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArLy8gQ29weXJpZ2h0IChj
KSAyMDE3IENhZGVuY2UNCj4+ICsvLyBDYWRlbmNlIFBDSWUgY29udHJvbGxlciBkcml2ZXIuDQo+
PiArLy8gQXV0aG9yOiBDeXJpbGxlIFBpdGNoZW4gPGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0
cm9ucy5jb20+DQo+DQo+V2UgdXNlIGJlbG93IHN0eWxlIGZvciBtdWx0aSBsaW5lIGNvbW1lbnRz
Og0KPg0KPgkvKg0KPgkgKg0KPgkgKi8NCj4NCj5TbyBldmVuIHRob3VnaCB0aGlzIHN0eWxlIGV4
aXN0ZWQsIHlvdSBzaG91bGQgY2hhbmdlIGl0IGluIGFsbCBuZXcgZmlsZXMuDQo+DQo+PiArDQo+
PiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0K
Pj4gKw0KPj4gKyNpbmNsdWRlICJwY2llLWNhZGVuY2UuaCINCj4+ICsNCj4+ICt2b2lkIGNkbnNf
cGNpZV9kaXNhYmxlX3BoeShzdHJ1Y3QgY2Ruc19wY2llICpwY2llKQ0KPj4gK3sNCj4+ICsJaW50
IGkgPSBwY2llLT5waHlfY291bnQ7DQo+PiArDQo+PiArCXdoaWxlIChpLS0pIHsNCj4+ICsJCXBo
eV9wb3dlcl9vZmYocGNpZS0+cGh5W2ldKTsNCj4+ICsJCXBoeV9leGl0KHBjaWUtPnBoeVtpXSk7
DQo+PiArCX0NCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoY2Ruc19wY2llX2Rpc2FibGVf
cGh5KTsNCj4+ICsNCj4+ICtpbnQgY2Ruc19wY2llX2VuYWJsZV9waHkoc3RydWN0IGNkbnNfcGNp
ZSAqcGNpZSkNCj4+ICt7DQo+PiArCWludCByZXQ7DQo+PiArCWludCBpOw0KPj4gKw0KPj4gKwlm
b3IgKGkgPSAwOyBpIDwgcGNpZS0+cGh5X2NvdW50OyBpKyspIHsNCj4+ICsJCXJldCA9IHBoeV9p
bml0KHBjaWUtPnBoeVtpXSk7DQo+PiArCQlpZiAocmV0IDwgMCkNCj4+ICsJCQlnb3RvIGVycl9w
aHk7DQo+PiArDQo+PiArCQlyZXQgPSBwaHlfcG93ZXJfb24ocGNpZS0+cGh5W2ldKTsNCj4+ICsJ
CWlmIChyZXQgPCAwKSB7DQo+PiArCQkJcGh5X2V4aXQocGNpZS0+cGh5W2ldKTsNCj4+ICsJCQln
b3RvIGVycl9waHk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiAr
DQo+PiArZXJyX3BoeToNCj4+ICsJd2hpbGUgKC0taSA+PSAwKSB7DQo+PiArCQlwaHlfcG93ZXJf
b2ZmKHBjaWUtPnBoeVtpXSk7DQo+PiArCQlwaHlfZXhpdChwY2llLT5waHlbaV0pOw0KPj4gKwl9
DQo+PiArDQo+PiArCXJldHVybiByZXQ7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGNk
bnNfcGNpZV9lbmFibGVfcGh5KTsNCj4+ICsNCj4+ICtpbnQgY2Ruc19wY2llX2luaXRfcGh5KHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGNkbnNfcGNpZSAqcGNpZSkNCj4+ICt7DQo+PiArCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+PiArCWludCBwaHlfY291bnQ7
DQo+PiArCXN0cnVjdCBwaHkgKipwaHk7DQo+PiArCXN0cnVjdCBkZXZpY2VfbGluayAqKmxpbms7
DQo+PiArCWludCBpOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKwljb25zdCBjaGFyICpuYW1lOw0KPj4g
Kw0KPj4gKwlwaHlfY291bnQgPSBvZl9wcm9wZXJ0eV9jb3VudF9zdHJpbmdzKG5wLCAicGh5LW5h
bWVzIik7DQo+PiArCWlmIChwaHlfY291bnQgPCAxKSB7DQo+PiArCQlkZXZfaW5mbyhkZXYsICJu
byBcInBoeS1uYW1lc1wiIHByb3BlcnR5IGZvdW5kOyBQSFkgd2lsbCBub3QNCj5iZSBpbml0aWFs
aXplZFxuIik7DQo+PiArCQlwY2llLT5waHlfY291bnQgPSAwOw0KPj4gKwkJcmV0dXJuIDA7DQo+
PiArCX0NCj4+ICsNCj4+ICsJcGh5ID0gZGV2bV9rY2FsbG9jKGRldiwgcGh5X2NvdW50LCBzaXpl
b2YoKnBoeSksIEdGUF9LRVJORUwpOw0KPj4gKwlpZiAoIXBoeSkNCj4+ICsJCXJldHVybiAtRU5P
TUVNOw0KPj4gKw0KPj4gKwlsaW5rID0gZGV2bV9rY2FsbG9jKGRldiwgcGh5X2NvdW50LCBzaXpl
b2YoKmxpbmspLCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYgKCFsaW5rKQ0KPj4gKwkJcmV0dXJuIC1F
Tk9NRU07DQo+PiArDQo+PiArCWZvciAoaSA9IDA7IGkgPCBwaHlfY291bnQ7IGkrKykgew0KPj4g
KwkJb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmdfaW5kZXgobnAsICJwaHktbmFtZXMiLCBpLCAmbmFt
ZSk7DQo+PiArCQlwaHlbaV0gPSBkZXZtX3BoeV9nZXQoZGV2LCBuYW1lKTsNCj4+ICsJCWlmIChJ
U19FUlIocGh5W2ldKSkgew0KPj4gKwkJCXJldCA9IFBUUl9FUlIocGh5W2ldKTsNCj4+ICsJCQln
b3RvIGVycl9waHk7DQo+PiArCQl9DQo+PiArCQlsaW5rW2ldID0gZGV2aWNlX2xpbmtfYWRkKGRl
diwgJnBoeVtpXS0+ZGV2LA0KPkRMX0ZMQUdfU1RBVEVMRVNTKTsNCj4+ICsJCWlmICghbGlua1tp
XSkgew0KPj4gKwkJCWRldm1fcGh5X3B1dChkZXYsIHBoeVtpXSk7DQo+PiArCQkJcmV0ID0gLUVJ
TlZBTDsNCj4+ICsJCQlnb3RvIGVycl9waHk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4+ICsJ
cGNpZS0+cGh5X2NvdW50ID0gcGh5X2NvdW50Ow0KPj4gKwlwY2llLT5waHkgPSBwaHk7DQo+PiAr
CXBjaWUtPmxpbmsgPSBsaW5rOw0KPj4gKw0KPj4gKwlyZXQgPSAgY2Ruc19wY2llX2VuYWJsZV9w
aHkocGNpZSk7DQo+DQo+RG91YmxlIHNwYWNlIGFmdGVyID0NCj4NCj4tIE1hbmkNCj4NCj4tLQ0K
PuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

