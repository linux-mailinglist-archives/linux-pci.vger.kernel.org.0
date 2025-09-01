Return-Path: <linux-pci+bounces-35222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D431DB3D8DB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 07:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0D17AAC5A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18541FF7C8;
	Mon,  1 Sep 2025 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RzU1/bZ8";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="byaHC9Ji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D51BBBE5;
	Mon,  1 Sep 2025 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705011; cv=fail; b=lQALfH83KqND+8I1ziFHRmkb5144KmTNh+/ypt9ndDR82N+cNGZrUlxBNkkqVxmeCg90H/s3KTUb/WpLlhzCPQlyJyVdWNpHe0hq2Fg69MZi/jIfcNCFdazHaS9UrEBzCCeiPNjy2+Tthwy1nx+V3z217hlDLVpn53Ig4+Tpmzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705011; c=relaxed/simple;
	bh=7cbFVJPVkf1AZ3iUgFncEg9+TCpu4JtoDhQ4sXZqsI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGCSZbopae1XWd80ZVdo0fZjFN8KEJAQPQsKqLactUjkUSVPsb04an3C61spqZY88k6LTM69Ls5L5DOVhaqCtNwPjAG6io7An/2cIeUIfi8wIB6OBtGZnQpIG9EqL8z7lKhyiWzX4s8sfBM6QKWp9SDooTsJpNA1PFpSfCGXMUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=RzU1/bZ8; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=byaHC9Ji; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VLLNG9017325;
	Sun, 31 Aug 2025 21:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=7cbFVJPVkf1AZ3iUgFncEg9+TCpu4JtoDhQ4sXZqsI4=; b=RzU1/bZ8Rw90
	PiyLWYToJ0dZxgCKvgL78sbgYEHOt7Bhx7QKo3H4/xwRxDYOWlp2u/yyZW1c/KDu
	XK5ZmVYlFhUT8F/aaoUX65XYKZPhaddO/IfU0iVdKZlc39Ud7WqdkN2h+AKDBU63
	sh3dcppQUUEPLRqvhGyha31iSQa4/KIRjeU7/Wcx9xkwAdR/DqlksDiKJRSTSrzO
	7UEQhzI1LruQaqUryFyNyo2qXWZfvFUNiGRY//Ql5FiHCh7whY2cWr3g+EoqbYfl
	ZPUnImjMX6NNNwetAjQc5qZux7CYwL+W84x9EZjJauFtA+CoibzEMsZlWnIO1j0A
	RBpVs9UVaw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 48uvvx4bca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Aug 2025 21:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJesHc2EYCvEFRXuNfbEVALAiUbj1n8m7j846KFup+EvoxSA/F1xylMPtkMVgy45MVqfzFUiGIi/wtshjxSkRP1w3yIytHCvEJngPBZ237t7YAqBt6oFuZuEC3yp0VjfkORYDWScBElC1hXxzP9YAcimu8YJ7AkkJeaCk9iT7OvYPFJUiHue/AX9SZlawUe457NwFsKVbil8pUaFEvEEYkEwrpXhQEStp+xkHQ//SBrSuaG5/OEO06f67XQe7/W4bZG8Jskp9TZFjl6KBHJP/kI/iUzpw3KTBp8Nr/WQAZptmKyTQ7W0sW44RXVSFOQAloKYsQWPNwOOQMwvsyJ+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cbFVJPVkf1AZ3iUgFncEg9+TCpu4JtoDhQ4sXZqsI4=;
 b=RuFmz2i5/GRPOP9KvDyUmt243lGv/bcvo1MSNZTjz3yU7yPrqJpRIJLRHFAbnc4XTBX9LiNJFxSO3JvmaJqmXsUSkbGOaQ6NczVEM2as8G6MtkjXWdx33USfQ4mNhZhdYSU4l+YJprXXI1kDMy4sHrC3bJz08O4iPboPaBH0SWPQ0toHX17f9FzzLfl4HqeIMxGqiywwdID460frNHjHx7oeJl+nkhZuBoLZ7qYp0GvzAeqiiskjym0qYVFz29VWgObUK4XrZstqImycUp9TH6yQjvS/eCP2qsoa2hqzLQG5pcJ5Gni8IQbyqN32sUYLq5dSXk5v+txsFnVEq5fNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cbFVJPVkf1AZ3iUgFncEg9+TCpu4JtoDhQ4sXZqsI4=;
 b=byaHC9JisLnfFy5LtnEet62MJ1uTglqyD/E5QgyjYZNOmuM4UGZnpElwhZIbPSj7MB2hru1zwZZxO68TCI4+FP6F+EnGzkTvCHmNrzQS7JZStg1LQtQficnFnY9VqkyQg6gIPv9FrC3JtBUY1Z+xYL0RFlh/HaJiD7WKq+ClCQw=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH2PPF57569E98B.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::265) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 04:30:06 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05%8]) with mapi id 15.20.9073.010; Mon, 1 Sep 2025
 04:30:06 +0000
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
Subject: RE: [PATCH v8 06/15] PCI: cadence: Move PCIe RP common functions to a
 separate file
Thread-Topic: [PATCH v8 06/15] PCI: cadence: Move PCIe RP common functions to
 a separate file
Thread-Index: AQHcEQAlb5yJEoyUFkamcH8xJYiARLR7EfQAgAK98RA=
Date: Mon, 1 Sep 2025 04:30:06 +0000
Message-ID:
 <CH2PPF4D26F8E1CADA09A5DDC4B04C4BC68A207A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-7-hans.zhang@cixtech.com>
 <phxvk3wsr75btvhljdgakkoqz7lyza7x7sjut3kswwhutyhb7n@pihtlzszfb46>
In-Reply-To: <phxvk3wsr75btvhljdgakkoqz7lyza7x7sjut3kswwhutyhb7n@pihtlzszfb46>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH2PPF57569E98B:EE_
x-ms-office365-filtering-correlation-id: ea7184d3-e99a-4b26-5789-08dde9103a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFo0NWpweG1od1k4RTJlWkdOekw5SnpraTBhNkQyVE9qOFp5K2UyMlFDYjI2?=
 =?utf-8?B?UzI3bENrYkVhN21pZjZpWld6a3pIUjVJQWtSUkJTM1BrSEYrQThEdEJaUHIr?=
 =?utf-8?B?ZVVjOFhsL1FyTWxOTHJtQ0hFWkFiQS9nZGN4cFRvb3dHbTYyTDl4cXRCS3k4?=
 =?utf-8?B?MU43L3ZKWUdZMEIzcmxrMllLbHFnODVkajhmSEFSTVJPc084ZkFnNjJzbTVs?=
 =?utf-8?B?TDJrQW9UUjRqWVZJOFBQZlEyUDVmc2VqVUhJeUgyUGZmQ2hhVkJOS2c3R0Zq?=
 =?utf-8?B?TjRZZzJoVTZjV1c1UC82cHJ2ZlRGSTMxeHBKQ3ZuZmNqWVAwN1c3OWJqcjJo?=
 =?utf-8?B?c3lLZGs1WS9QRG9FbGFrT3NPM2x3OWptWHNuUWVDSzJFTTNHSzFaN2hqQysw?=
 =?utf-8?B?ZGZYaFhZbmRnVUl1OVNzZ1I3cDA0RlJ2aUpXRWdlZ3BZM25GNnQ3eFdVM2Fl?=
 =?utf-8?B?aHFTZGNYOWt4NE9ZcFBqM0dNc3ZIaFY0Q2R6dHlrR2JRODZyd0pvSi9sSkNN?=
 =?utf-8?B?aEM0VG5WVm5TU0w1VU5id0tQM0F4SUlFVFIyd1dya1AwRzJjRExKQ2tiNWtk?=
 =?utf-8?B?Zll6WUgzZnh6NkhlM09TbkYxMldwZkQxd2FEeDdDWE9TS1RMYTZ3VUpmS0xz?=
 =?utf-8?B?TWRLa3RsWXNJK1hTdmpXeGhzS3NmTnZ2dnZGVUNXaXRPWkg5bFcySHBvaEUz?=
 =?utf-8?B?TDRvRUtWOGNhbHVWMVgrNUxBeTRrVXN5d1pCbnJZUHJCdUFyOTM3M0JWK2hP?=
 =?utf-8?B?OWFXZ0xtYVY4YmlMdHFvQ1BPdERIZU1lcXF5TTVUaGUzU2VObVFVKzljRWQ0?=
 =?utf-8?B?a2Z3WTRndDlwZC9XdUMvUVVqWEIxRFExQ01IU3NsUUs3NWp4S2tHT0g0cTV4?=
 =?utf-8?B?Y1hmRklqYzkxRy80L3RNbjVDcGM5aEhtYldRUVltdHF2bTlxbU9hWWd2c2Nr?=
 =?utf-8?B?MnJhcWc3RWNWRjN3ZXIzQmFKWUFrME93MHNya29FcG83bU9pNWx0bUJadk1v?=
 =?utf-8?B?SVVmZE5QaWRnTm8yYktHbC90M3J1QWlmbk5oV2k4L0laUFB6dGl3cllheHRL?=
 =?utf-8?B?VTJkTFlkK2hjMzJ0Zzh4Z2xJT0ZMMGJTaWZBZ1ppbWxoTWNtaUVldmlCSncy?=
 =?utf-8?B?S2FzSmVrK091U213RDJkYVdTZEJrS0I5ZnNqSng1REpZZ0RXOW15T3BjMzJT?=
 =?utf-8?B?eGhvYlhSS1h4akNCSVVNd2NMYUlLQ1dDTW5wRVVjbWwyeFN1VWlRWDB2bDE1?=
 =?utf-8?B?TWdQNk5tZ0prcUQyUkw2MXFWenZzdFJ4YmlRTlRXRytYeXkydWhUQ0RZb2Zn?=
 =?utf-8?B?OEliNGpzamVVeVhvL1doSWtTRnBqMVkvcW12YVU3Tmt2UHRQTlIrbHZaVWlz?=
 =?utf-8?B?ZnViNnRqb0xuYVozLzk1eFh6TmdDb2dKdGZ0cWdTN3pXQW9yWWlCOFNCcnpp?=
 =?utf-8?B?aHpJaTlQZlJ4bUNlaUZCT1lKTUV2MW9jR2g3dzN6Um5Qc0o1dmNpbTVyd1RX?=
 =?utf-8?B?MTZkM1NxWTZOVTQ3UTBKTDEyVWRseWsxOElvM3BmeENPSzQwaHJJNDRqcm9a?=
 =?utf-8?B?KzdxSUN1ZXRIekw1YVRUR3hCMFdQWjV2ZUdMaHFpOTMwcEd6VHFDTktuYnlV?=
 =?utf-8?B?QUVUMGRKUWwvQm1tWE84bjNab0NYcHhBbUNlZHBONjlhS0hncFZvL2I4Ty9R?=
 =?utf-8?B?ZGdQN0ZCbFdQbElFaVNIdTh0TytsazEvK2lFYXZvSHFTdGhWZjJzTk5wUUNj?=
 =?utf-8?B?U3lFL0Nqb24xN3FOQmpRTWRodjltNEJWcDBaME5iRkFqeU1kQ1JvdnFsRkVj?=
 =?utf-8?B?ZUVvSW5rUWRLK2ZQRyt1ZGNQOGRLYTk0bVkvT1JLa0xLS3pZbFA4NVBZak5m?=
 =?utf-8?B?RytCNWpMejZ2MDJOanFvaElVTXRXYk5tazFMT1pneGc2RlR3SDUxKzR3dXdm?=
 =?utf-8?B?WE8zLzlWMGFac2dVUVl0NlJkNEFmSTgvOUNwZWs0SlJxN3JGVEp2SldRZXFQ?=
 =?utf-8?B?Ui9US1ZWa2V3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlRtOVB6RW55V2traGc3RWlxYjZjaENrUE05dmpOdURWdGFOVk9CNkdDL3VU?=
 =?utf-8?B?UjJlZHN3ejIvRmF1UlRzZVVCNlpNT3BEbE44ekVNZFZSbmorWHJObTczS1ZV?=
 =?utf-8?B?N0RwVW5yR2E3VUFTYTRDeStPQ20rdHRicnA3MXhiVFQyWnNtU1ZqWFZZUkpy?=
 =?utf-8?B?UTNxSlVzbWVrdnIzdDA1ekV1UWpRNkFIY29qYzdOM0tWY0hGbXVhQURaZW0y?=
 =?utf-8?B?aGE3Z1FFZGFWUGVYb041Q0pIc0hlWE1yYXBOeE1KNVRIRlRxRkFmWGRRaDY5?=
 =?utf-8?B?by9sRFdGR3daaEFyRnNoVW1BVFlXZXlLUjJ0bmRWS292OUFXeXpUY3MyTnZU?=
 =?utf-8?B?b1hiTEpiWnU5UVhmVXVyRCtlOGhVdnBURm5kZU1wdk4rbEsyU21SakxzU3hr?=
 =?utf-8?B?Tm50Mm5vZTVBTlh2Z2JPSzlyd2tYeWZpQ1QxYWVOZlVTRlVkMUNxb2d0SnBj?=
 =?utf-8?B?dFZtMlB1eEFCR1lja0xyZ29aR1U0b1lQWHRkb0ZFOGpTT3JPY1o4bTIveHVy?=
 =?utf-8?B?T0lkdWlxSk1sTEsrcGt2WkVCS2h5Nklxdnc0RlRnWlZBU2pldzV1WHdoQjk3?=
 =?utf-8?B?d2oyb0dqQUV1TC9hVHRhRUdyek9OZzZnWDZ4T1VwRlRWUUt1VWZrZ3ZZQVRn?=
 =?utf-8?B?U0xJdCt4QWtOSlR0QzlWRW56TjRqVFMyVzJ6dVBFWHlOUFRyY3prcGp3MHMy?=
 =?utf-8?B?Y2hYZitqSHdQWU9nWWxtLzVGS2lMTVY2R2lkM3lRQnhBZ21SdldHOVBtL2pD?=
 =?utf-8?B?VDZ3VlorTjU4VWtpYzRweS85YTgwaDU3YVZwMTRvKzZBbTVxNDhZNXRCTjJ2?=
 =?utf-8?B?SzJTSVBaWVRFbW9XWkJOYXprcGxaUEtudnovNTl3eEVyMmF1YWdrbVZLVW94?=
 =?utf-8?B?U0pKOUJ6Qi9qK2Q0aXA4KzZKVnYxWC9wdlJJZ2dYeVg3dkdmUi80UWdsWi85?=
 =?utf-8?B?WXl3c0pjbGcxQ2JaZVVLcEEvc1ZMWCt0VmNuQWRybDhOUkg3aTRUa1NPR2tv?=
 =?utf-8?B?OFVxSXNzOXMwNXYzaE1tWGg5MDBMcXVhWlZtc3A1cGpTY0J5ek9FTE5qYkNE?=
 =?utf-8?B?WmFxOG1qeEFFc2luWmpJdWtrdDF2bVQrd050dHlHeGN0N1MyeW1oeERuZ3A3?=
 =?utf-8?B?OGkzSkwwais4WmtQNWRNaVR3ekhhLzNDZHNPU0FqYUFSaVJvdmxkVWUyYTdx?=
 =?utf-8?B?Y0x0MVc2bHlBSlJDN0tQZjY4akhlcXBKazlNQ3pGMk1GOXJLZmhrdms3ZTNi?=
 =?utf-8?B?RWxCTTNWRTFPM1laWnM4Wkl0Y1ZtM0tTMDNyV2tXMmZ4ck9VT2YySEdSNUN1?=
 =?utf-8?B?cGJ2MUVteFVlZUlWSUhySjJvcStqYkNQNi9yYmZUcWVnd2dTRFpFUnhCTlQ0?=
 =?utf-8?B?clBCUDAwMDRRcHpsTkxMUi9xNjRycVRlRVlLQmtyME1KclhIMitVSlYyT2dq?=
 =?utf-8?B?Qk9rUXR4OThad0toY2Qzd0c3K29CcWZGaWxqTThYeC9tcVFzRkFNV3AzNElt?=
 =?utf-8?B?Ty9ZeGk0Sy9oRUZuQlJMQnNxbzA1TmV5MUJNQ056VWhHUE1HQVRjOUhBMHVB?=
 =?utf-8?B?RHdlVlowT2wySGZ6VWVqYXY3aVRoTXZ1ZzNESzhHcVh1VGNHbWtzL0tZZm5a?=
 =?utf-8?B?VVBaeDFWY1FoeW9Rc0lCY2hWNko5RDRoRGdRMjNUWERZam1NblNOdlNWQ2Jr?=
 =?utf-8?B?VmowckhSY2FsSUVvYzNKY1NMVDRVU1lNUmpTOFc3ZUptSTZiNHorOXd4WGxk?=
 =?utf-8?B?aTVUelh4d2x6MEdvSFRrbmJncS9GTVlCZkVuODhlRjhydHZvV1ZIdHE3L0Na?=
 =?utf-8?B?YmhVRnNsM1FhVm83NGc1dytlRVgyYWRkcVdibldqWm1YbkwxQXY2SWJ5eURw?=
 =?utf-8?B?ZHdMRGxtZzhad3RyUXhkRTdrNVl4YW1UUE9PQWdaTy9NTlMrcFVIVmhOYktB?=
 =?utf-8?B?V0FQRk1uTTV0amtQMzFGdGpvbE9aR3B2ZEJZMEIzMWV6cUhHandsSWJJYUtJ?=
 =?utf-8?B?bmtkUFhJbmdZN0FxdjBNalk3SDJ2dXhBMVVZRGpzSGhGVEd0NGZBelBqNmdl?=
 =?utf-8?B?QnU3akw1NjRXSlZEVTUycU02NUNqcC9OMGlwb1lobnprYy94S0lCa3pScVpq?=
 =?utf-8?Q?ZEjvE9RKUir7tyKzHdkw9tNLv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7184d3-e99a-4b26-5789-08dde9103a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 04:30:06.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+c3IuapoihpY21XBy0pY/tiygchTrXxUxMORpXo8nE5gSjBNPIwPbEte8Gi0Y0ikiGRILkkODZIImoFt1A7bNJ8AKFBzADpRwitkNUAxyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPF57569E98B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA2OSBTYWx0ZWRfX84u5FFdv97nk MGtGGA8oxFJsLNPRIV9GWE7Mp/6EhLNsrHYioS86YWBjXAguegvXl11R6R8CzBA0rQDypbYyjd3 /d9tSbwg8libjhT2d426e9QPU6fLaJGjFQs4Ix9Mkpbq7BSjwXkxbOLLJCOqggKdLBX0+SSdXNv
 5m4q4MaWZyBlq9nD34ozheTR6yD90REUg1Qm4/UECh6GpAwADFYY8/SlsBLTW6hHlZRajVEEo9v lIKE1NMMVhh1UiUfKDhsGtd8GnQDE3+xOqbgYYye6q/MAEH2ZaWN8hvwpTmEmbUWv3/Jwrzndzd aYySM2lf1mjnFKx5GXE+vmwhpx8q/z10oDuI9Lxk0QEjshCON6v0TEvmpkQRjMmFR9l2sLqBgtB HTgT8Nzv
X-Authority-Analysis: v=2.4 cv=W6w4VQWk c=1 sm=1 tr=0 ts=68b52150 cx=c_pps a=jwBwXe7jPVY/Pk8tSagW2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=ZpDfllaKoKi9YKmXq7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WhbX5A4oYntX7RGQaHP-V71O107b2DRW
X-Proofpoint-ORIG-GUID: WhbX5A4oYntX7RGQaHP-V71O107b2DRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300069

Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9NYWtlZmlsZQ0K
PmIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL01ha2VmaWxlDQo+PiBpbmRleCA4MGMx
YzRiZTdlODAuLmU0NWY3MjM4OGJiYiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvY2FkZW5jZS9NYWtlZmlsZQ0KPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9j
YWRlbmNlL01ha2VmaWxlDQo+PiBAQCAtMSw2ICsxLDYgQEANCj4+ICAjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+PiAgb2JqLSQoQ09ORklHX1BDSUVfQ0FERU5DRSkgKz0gcGNp
ZS1jYWRlbmNlLm8NCj4+IC1vYmotJChDT05GSUdfUENJRV9DQURFTkNFX0hPU1QpICs9IHBjaWUt
Y2FkZW5jZS1ob3N0Lm8NCj4+ICtvYmotJChDT05GSUdfUENJRV9DQURFTkNFX0hPU1QpICs9IHBj
aWUtY2FkZW5jZS1ob3N0LWNvbW1vbi5vDQo+cGNpZS1jYWRlbmNlLWhvc3Qubw0KPj4gIG9iai0k
KENPTkZJR19QQ0lFX0NBREVOQ0VfRVApICs9IHBjaWUtY2FkZW5jZS1lcC1jb21tb24ubyBwY2ll
LQ0KPmNhZGVuY2UtZXAubw0KPj4gIG9iai0kKENPTkZJR19QQ0lFX0NBREVOQ0VfUExBVCkgKz0g
cGNpZS1jYWRlbmNlLXBsYXQubw0KPj4gIG9iai0kKENPTkZJR19QQ0lfSjcyMUUpICs9IHBjaS1q
NzIxZS5vDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3Bj
aWUtY2FkZW5jZS1ob3N0LWNvbW1vbi5jDQo+Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVu
Y2UvcGNpZS1jYWRlbmNlLWhvc3QtY29tbW9uLmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
PiBpbmRleCAwMDAwMDAwMDAwMDAuLmQzNGY4YzdjNDlmMA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1ob3N0LWNv
bW1vbi5jDQo+PiBAQCAtMCwwICsxLDE3OSBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+PiArLy8gQ29weXJpZ2h0IChjKSAyMDE3IENhZGVuY2UNCj4+ICsvLyBD
YWRlbmNlIFBDSWUgaG9zdCBjb250cm9sbGVyIGRyaXZlci4NCj4NCj5UaGlzIHNob3VsZCBiZSBj
aGFuZ2VkIHRvICdDYWRlbmNlIFBDSWUgaG9zdCBjb250cm9sbGVyIGxpYnJhcnknLiBGb3INCj5j
b21wbGV0ZW5lc3MsIHlvdSBzaG91bGQgYWRkIHRoZSAnQXV0aG9yJyB0YWcgYWxzby4NCj4NCj4t
IE1hbmkNCj4NCj4tLQ0KSGkgTWFuaSwNCldpbGwgY2hhbmdlIHRoZSBmaWxlIGNvbW1lbnRzIGFu
ZCBBdXRob3IgdGFnIGFzIHBlciB5b3VyIHJlY29tbWVuZGF0aW9uDQoNCi1NYW5pa2FuZGFuDQoN
Cj7grq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

