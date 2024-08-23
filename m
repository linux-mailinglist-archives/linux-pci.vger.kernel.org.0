Return-Path: <linux-pci+bounces-12095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7857295CD27
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAFF281845
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932CC184532;
	Fri, 23 Aug 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KFbJSSd+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5C183061;
	Fri, 23 Aug 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418423; cv=fail; b=u0C1omDaDa4CMSpBKip52DK0lSSCNTZLBHanjv7aMSMx42YIILTeLy7ZRFvw2nh5598oUbSvzJrtdQqBKwBwSA90gOcUc2SHiqgwR6NSWx9qnM7Zdti9oDuUaNMMcjESfmB84O7J+l2nrCkapnLW3TMOxmK1CPPYr6E9QNdPCG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418423; c=relaxed/simple;
	bh=+Ookx95eZ505GT9t0a3ITF2o8VuEEAktJPzyQ/IcGpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuW8CIXZKd6GjUU9YtC3amU+t6+9B9gcOAfwbmKY8NNo7imC0wKIJWBmYCH8Wa2AjnBNXgoIUCZ/ISe6dDinWQlM7SnqBVPbv0OYywkLrawPg8XOlK2KvXMYnauH2ZSDbz2kGShOK1ntkCOuaJH/QDhadXkOA0lywRsfVzDoibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KFbJSSd+; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N9vO8X024604;
	Fri, 23 Aug 2024 06:06:39 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 416r8g8hvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 06:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfjgxTttFUKGNbsxmEnPuUxyPltJopUafTX4zMbpJuqtMPaeuudczrqiO88zgJZSMx7NwTmY8WM+5XQqgx0VllCKgrfRseePNzZGH3859hC1y4qFfbWwJZ/OI8dsMoNl52P2rRMNxgp24mupB8R/PNwCF8ta7+U3ufP93D8iD67LNpOVpiAh1J5ft9IPowAXBI0xtJax0JzfUBG0+3TCTjldAIxnq/d1D7uANm3qTBOdorKNhP7qtYq9xUOovMN7dvth7Kf0WDV2G1uC8w5GHWdcpj6FDjxMyNEaZrgnw6qWcC+8cE98BJNr63Lp23QrnnheB1XbxhClwlR87ILa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/sdfl92a672r94KFvYac/zgOG1H9euu+spIg8LOgP8=;
 b=LFi9xyt635IrUugusFGPrz3/A732imBGBKSj3hIhgcF7bqP8ULerjZc1P7mdkRFKTrPjGkcE3AfJBNJVGIWDJqmyaQdKzyycFBjp710ENk/nilymVSm6sHpxShnj3sfJqgh6xIWxn3uxmcMzH3sDfj6OMUiT1XJJO8ot9kvOuQILcgzGUAyWmM42XSahWZ1oos7KqWsOIumJ6gqE+fFe6Wju7kvNkLZ7K4DdIhCU2bA8ajwT1p+BQTMPsy4/B7Wy1m9Tp9oWMLVg+3QwF8m+BvBJeqfLGTqtwm0hxBX5grnJu3sJcpLucA4YsOIjv0Fj4qBNZOjEDEmirhiJU+aJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/sdfl92a672r94KFvYac/zgOG1H9euu+spIg8LOgP8=;
 b=KFbJSSd+wM9OtuZh3iVqJHBP2g+NJ8xO+1GaQHofZjiPTeezEWWvbYd+HnYM+FZY1ZLOM9JMGl95ooZHcz+LCmU2Z3XKpJlhuwczudRZEmcnBYHCva7SrSPbr07ltSrauWHO7SZtZouc3Boi6wAU9TyzjWjRyjyFpS9bhwAc2g4=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by SJ0PR18MB4105.namprd18.prod.outlook.com (2603:10b6:a03:2c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:06:35 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 13:06:35 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Jonathan.Cameron@Huawei.com"
	<Jonathan.Cameron@Huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v2] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v2] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHa9V1HKzg8Mse8M0W9s210uffo1A==
Date: Fri, 23 Aug 2024 13:06:34 +0000
Message-ID:
 <PH0PR18MB4425E0F2E295B8EAEDCD942CD9882@PH0PR18MB4425.namprd18.prod.outlook.com>
References:
 <PH0PR18MB442535D2828B701CD84A3994D98E2@PH0PR18MB4425.namprd18.prod.outlook.com>
 <20240823052251.1087505-1-sthotton@marvell.com>
 <a4a8a1f9-3b9c-7827-3e98-44009d8d440d@linux.intel.com>
In-Reply-To: <a4a8a1f9-3b9c-7827-3e98-44009d8d440d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|SJ0PR18MB4105:EE_
x-ms-office365-filtering-correlation-id: d1fdeaf4-5e2c-476c-4d7d-08dcc3746a77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CHZBr5WGIpo258FXlWeaVPfGZDOoNEvaoR7KcTTMwaDGYtjEMJytmOoHvB?=
 =?iso-8859-1?Q?WZzhPBR2P68DK9nDUfXwmsor820cQMhyl6s1zmTxbKCN+t6HWTJo3qMaqk?=
 =?iso-8859-1?Q?g0Dk+vEYKBeI0oxBt1/CNw52HPKaM8Ho91EXXSkqQk6s7VNc+s759u713/?=
 =?iso-8859-1?Q?8R0MO5pZPKUQuVu+6+ntheeoNhz8hD7EGHwyuGa1VSnx1rksNSQNROA49l?=
 =?iso-8859-1?Q?2Rxfq85AGnqE4iMlpVme/HRPy7caFEXbkPlcV9aL6nZUUp0a+vc6hNXcvf?=
 =?iso-8859-1?Q?1H8ERUNJJttUSd6IvjAPCAXXCdIjNOwDBeFVecPqGd90KEJ/A01bK9utRI?=
 =?iso-8859-1?Q?28MqxpOnUToJzEZy3GC1FCNTg0csI3Hc49qNJfDHvK+ruYFjOCc8Z2gURE?=
 =?iso-8859-1?Q?e8Qqz1HThrdpjOn1LSsjy91sfYRvN8eB24dA2GZcTaWLidZ1PmNkt43XVW?=
 =?iso-8859-1?Q?EQZWHfGjDW/QSwOuFa+BmpR9p1WMDDXMksZhs3FOlDi1g6k3zip0RT28Qo?=
 =?iso-8859-1?Q?Q3zN3pH7k4t1zsmv0UeLtq26g8P49wsGUmqIGvpu2ARZDRjGMYghIwNSwR?=
 =?iso-8859-1?Q?u07e5v6VMqKG6EtRDV+58oPZRb2orgJ5PBiwMDSrw0Ie5y22h99bV7S3Hl?=
 =?iso-8859-1?Q?9BMfbCUcH1UcddiOzgmRukApBrKdE/yos2Uvl6+dw0KW6z769LAolgUPJo?=
 =?iso-8859-1?Q?S6sRMi9eYkD8gtqZ+KTlfwyTydQN2tHPwsrUSLdWodpUi8Vb8aQYU7eeNg?=
 =?iso-8859-1?Q?e5kbvrwhRlDHDIxvA01UmTstd4gf43BXjVa1V0yndD4CdDzUfumhDgmYKS?=
 =?iso-8859-1?Q?WSBNyeLIke2BxqG+1w2KzBgP23gyUjWlF26f3g4LdtVaMX5ItJKidCVrG1?=
 =?iso-8859-1?Q?5+ZW8WxZEjcbe+ofot68YyyEHhiRlccUtT1E2UbyRU6dxKccO1rcq7iL7d?=
 =?iso-8859-1?Q?FsOUgusf1aRlk6Wv/4ZSNPl//11E8b8NQyMCxpn2yVXNHRGtATCAgmrAqy?=
 =?iso-8859-1?Q?5jdAhJXVfaVPbAvpeZ948R0dtTZ4PKg+zn3yhnIB5K48opkMUeJHLhi+Xc?=
 =?iso-8859-1?Q?jA/78zzcdVAJbj8qBonR0LsoCoqBRbYQ2bYSlo+KoZTjxABsbmKzGpBWZY?=
 =?iso-8859-1?Q?MhtyCLGxAPSz8h9zeByb1WJlOWDETKWqjviZ8euShqxyx8VTmsaTXYgCbb?=
 =?iso-8859-1?Q?Kqec7nCgkiglAgJ2MKKoDzDMktoOIVFsqtV9LHI8nYcVlY2Ox2Q2FmRXus?=
 =?iso-8859-1?Q?5KimogLyRekLWVXTsdOw5nOmh8xwEn5n67ypWrvlLRazqPkzYcRQ363jLo?=
 =?iso-8859-1?Q?LeVgRzDkERuxI5zvTkUIA4Y6Z3PoJghFcR34q9V//o8gdhjGBmgna1B1RY?=
 =?iso-8859-1?Q?Q/le2LZlCHzdVp7OetS0zOzpRyS04r6IPpUKFiMnxEzrEiN2cxIDOnhfY5?=
 =?iso-8859-1?Q?DlBuN4B+RQ5iO5Sh+DaOYGss5aCg3ZfnCIEqwA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3gebflY9w74XIoSj7qeVsapIL6MATaiG3Ttbu80/gNjYWCol1l6GNQT0fR?=
 =?iso-8859-1?Q?7KWwmSFXvfBAPBL2zW3umJiPK1lH7PAyqxaNyv1Fn++H81kCXOzgC8V/bV?=
 =?iso-8859-1?Q?Waon5dYh5R5uoSAYlGE7p6aMdsP4jjpMJ/CCXGt/XIiXFqcOg73bdAq9Ck?=
 =?iso-8859-1?Q?jjyuyz02AQ12V3WteGMEA2x7cruEKL0PvpiJzIlo+7yCegGi1M1y1sYuaC?=
 =?iso-8859-1?Q?0UGgD0srAAtBQOpCwimX1Eg7HcTrA9O99jYUNkTRjo6EvqsMdiWqG7uc4r?=
 =?iso-8859-1?Q?CyS06gVBgXlqwxbbLx2ijk8snsRsJ5xUPTNw4Fyh7My1Z0gZq+OHcyU7gh?=
 =?iso-8859-1?Q?gdt0wtyqSnosw7F/qin8qAP72wjMD5vqEZPOuFDujiXaojsR1FihJwFTZD?=
 =?iso-8859-1?Q?mNNaOWW/FGCaEgTk/2DHraIfIqVU0cxoNs8ef6mTU8ZjIWp1u21xOULwp9?=
 =?iso-8859-1?Q?pc0jGeaC5Rc/35oogDjE9Qy8duOjX0KDUvGpTUKMWYADf6udp+sTPuqraG?=
 =?iso-8859-1?Q?pSSxW1ckByZ5z9zOooiE/Wfa+fEoMJbpQlKThJGTWVlQ52tHwxBdlOjlHX?=
 =?iso-8859-1?Q?MO1nLtDZQj5TVUC8xNaWL0qjhfkza2NsovBTLNyAef36GCOks0/7haalr7?=
 =?iso-8859-1?Q?2VXSkB1DWyxA376i7ZzdZuh+aOgKUFYVCaNw+rQF4YXT/sLQDoaTdB2bQq?=
 =?iso-8859-1?Q?XeniMYQ5xky9u0ysr6/LXDxDgSJ00sg/mv6M4Js1xiCG6Emo0kA8+LHBmd?=
 =?iso-8859-1?Q?Jv2MqsJLBaKuLdFh6yxIaXuK2MYcL1TO6drMVjUCE3roznRuXKwxVhXvfd?=
 =?iso-8859-1?Q?2pVmNQQhm5Z8wUz3CslPMx1EFilqbjGhzh/fDd5KnhPA8POhHAMt3V5Ku8?=
 =?iso-8859-1?Q?JUIlecKRuK7+7RN2BhrpPixmlJ5OCzmM7vwkJ4vjrmCS0PVpX7pcHuFUKQ?=
 =?iso-8859-1?Q?QUzbgv7dEzBUUlwdqyWM0yZSWsB5tqLzbfKYzQ82zjBeuqV4hE3obJW/aF?=
 =?iso-8859-1?Q?rj6BzyL2ddjfrSpUKzO3lQbVVuuad+HNWiB9LTEyrPdMYzBPLM4ddFmnNv?=
 =?iso-8859-1?Q?zHjCEllcqsysH1DjmDpLx04crGjXN427pzTYIERrAF2O4j33pw5JURyJ9e?=
 =?iso-8859-1?Q?x0wdMUiEL0s88c/cNHzSv+7NDkm6A3RyRDoOpbS+TUIOMhjFL9ZazMCdlm?=
 =?iso-8859-1?Q?Tz9sMjG6QbokJFrCyi7ZKxsejXngn07uEMOrUq47CO6zmrq22QbqYH9HDx?=
 =?iso-8859-1?Q?/2Fl9/YwiGlO0DI5xdlY3UvpstMW69JTs7IUKVPUa9c1KP+PK8kqvduzi3?=
 =?iso-8859-1?Q?wMJ/h67ciSwG5pRJ08mriz1gw1Gg7KTRWy0d9x12diKHbQXqCEZJQSjT4q?=
 =?iso-8859-1?Q?3gJUFXzMS7VW2xTccp0hkWVewQPm1wMcH4q3Plxrkpf7mkeXPxhLqE9/Jj?=
 =?iso-8859-1?Q?y/O0H/4Xe3fDxk1wYA2QXHiOj/oxzPm3yPdfV2GhF+Tad3Ljae8wEPwq8K?=
 =?iso-8859-1?Q?XIeplddaiGznbF2Mmsb3m+1a5j0Tqe0oyWWytMT8n9mitmTepAkSbNaaOC?=
 =?iso-8859-1?Q?wna4xcjN7+luawrmndbijI3uRtC/E6a1MyxZB5FejJ4zDLz+oxyu4mbFW0?=
 =?iso-8859-1?Q?8/aF2Cvk0lzppGQbOcPvqyEr0QdC08wT2y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fdeaf4-5e2c-476c-4d7d-08dcc3746a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 13:06:34.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2h0mJoTd6iGlNoTm6rp9p3XnNTE9eCJgIhxSoPpdqlBE/KTyn4/1vIBKa6J+9xkLF5sNUpJOA2gGRV5LzP92ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4105
X-Proofpoint-GUID: qbczg2SuBUL03BqQvakNBJPoCjK8kk-6
X-Proofpoint-ORIG-GUID: qbczg2SuBUL03BqQvakNBJPoCjK8kk-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01


>> This patch introduces a PCI hotplug controller driver for the OCTEON
>> PCIe device, a multi-function PCIe device where the first function acts
>> as a hotplug controller. It is equipped with MSI-x interrupts to notify
>> the host of hotplug events from the OCTEON firmware.
>>
>> The driver facilitates the hotplugging of non-controller functions
>> within the same device. During probe, non-controller functions are
>> removed and registered as PCI hotplug slots. The slots are added back
>> only upon request from the device firmware. The driver also allows the
>> enabling and disabling of the slots via sysfs slot entries, provided by
>> the PCI hotplug framework.
>>
>> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>> Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
>> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>> ---
>>
>> This patch introduces a PCI hotplug controller driver for OCTEON PCIe ho=
tplug
>> controller. The OCTEON PCIe device is a multi-function device where the =
first
>> function acts as a PCI hotplug controller.
>>
>>               +--------------------------------+
>>               |           Root Port            |
>>               +--------------------------------+
>>                               |
>>                              PCIe
>>                               |
>> +---------------------------------------------------------------+
>> |              OCTEON PCIe Multifunction Device                 |
>> +---------------------------------------------------------------+
>>             |                    |              |            |
>>             |                    |              |            |
>> +---------------------+  +----------------+  +-----+  +----------------+
>> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
>> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
>> +---------------------+  +----------------+  +-----+  +----------------+
>>             |
>>             |
>> +-------------------------+
>> |   Controller Firmware   |
>> +-------------------------+
>>
>> The hotplug controller driver facilitates the hotplugging of non-control=
ler
>> functions in the same device. During the probe of the driver, the non-
>controller
>> function are removed and registered as PCI hotplug slots. They are added
>back
>> only upon request from the device firmware. The driver also allows the u=
ser
>to
>> enable/disable the functions using sysfs slot entries provided by PCI ho=
tplug
>> framework.
>>
>> This solution adopts a hardware + software approach for several reasons:
>>
>> 1. To reduce hardware implementation cost. Supporting complete hotplug
>>    capability within the card would require a PCI switch implemented wit=
hin.
>>
>> 2. In the multi-function device, non-controller functions can act as emu=
lated
>>    devices. The firmware can dynamically enable or disable them at runti=
me.
>>
>> 3. Not all root ports support PCI hotplug. This approach provides greate=
r
>>    flexibility and compatibility across different hardware configuration=
s.
>>
>> The hotplug controller function is lightweight and is equipped with MSI-=
x
>> interrupts to notify the host about hotplug events. Upon receiving an
>> interrupt, the hotplug register is read, and the required function is en=
abled
>> or disabled.
>>
>> This driver will be beneficial for managing PCI hotplug events on the OC=
TEON
>> PCIe device without requiring complex hardware solutions.
>>
>> Changes in v2:
>> - Added missing include files.
>> - Used dev_err_probe() for error handling.
>> - Used guard() for mutex locking.
>> - Splited cleanup actions and added per-slot cleanup action.
>> - Fixed coding style issues.
>> - Added co-developed-by tag.
>>
>>  MAINTAINERS                    |   6 +
>>  drivers/pci/hotplug/Kconfig    |  10 +
>>  drivers/pci/hotplug/Makefile   |   1 +
>>  drivers/pci/hotplug/octep_hp.c | 412
>+++++++++++++++++++++++++++++++++
>>  4 files changed, 429 insertions(+)
>>  create mode 100644 drivers/pci/hotplug/octep_hp.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 42decde38320..7b5a618eed1c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>>  R:	vattunuru@marvell.com
>>  F:	drivers/vdpa/octeon_ep/
>>
>> +MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>> +R:	Shijith Thotton <sthotton@marvell.com>
>> +R:	Vamsi Attunuru <vattunuru@marvell.com>
>> +S:	Supported
>> +F:	drivers/pci/hotplug/octep_hp.c
>> +
>>  MATROX FRAMEBUFFER DRIVER
>>  L:	linux-fbdev@vger.kernel.org
>>  S:	Orphan
>> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>> index 1472aef0fb81..2e38fd25f7ef 100644
>> --- a/drivers/pci/hotplug/Kconfig
>> +++ b/drivers/pci/hotplug/Kconfig
>> @@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>>
>>  	  When in doubt, say Y.
>>
>> +config HOTPLUG_PCI_OCTEONEP
>> +	bool "OCTEON PCI device Hotplug controller driver"
>> +	depends on HOTPLUG_PCI
>> +	help
>> +	  Say Y here if you have an OCTEON PCIe device with a hotplug
>> +	  controller. This driver enables the non-controller functions of the
>> +	  device to be registered as hotplug slots.
>> +
>> +	  When in doubt, say N.
>> +
>>  endif # HOTPLUG_PCI
>> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>> index 240c99517d5e..40aaf31fe338 100644
>> --- a/drivers/pci/hotplug/Makefile
>> +++ b/drivers/pci/hotplug/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>rpaphp.o
>>  obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
>>  obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
>>  obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>> +obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>>
>>  # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>>
>> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_=
hp.c
>> new file mode 100644
>> index 000000000000..3ac90ffff564
>> --- /dev/null
>> +++ b/drivers/pci/hotplug/octep_hp.c
>> @@ -0,0 +1,412 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (C) 2024 Marvell. */
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/container_of.h>
>> +#include <linux/delay.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci_hotplug.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>> +#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>> +#define OCTEP_HP_DRV_NAME "octep_hp"
>> +
>> +/*
>> + * Type of MSI-X interrupts.
>> + * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are
>used to
>> + * generate the vector and offset for an interrupt type.
>> + */
>> +enum octep_hp_intr_type {
>> +	OCTEP_HP_INTR_INVALID =3D -1,
>> +	OCTEP_HP_INTR_ENA,
>> +	OCTEP_HP_INTR_DIS,
>
>Making these numbers explicit (since they cannot be just any numbers) fell
>through cracks.
>

The functionality of the code is good since the enum values are automatical=
ly
sequential. The values we need for the interrupt types are OCTEP_HP_INTR_EN=
A as
0 and OCTEP_HP_INTR_DIS as 1. I will include the explicit assignments in v3=
.

Thanks,
Shijith

