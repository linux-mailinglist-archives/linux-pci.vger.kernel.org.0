Return-Path: <linux-pci+bounces-34267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0CDB2BC6A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBCD1BC1E65
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFC23E34C;
	Tue, 19 Aug 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QYLPr9Ce"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821626D4EF;
	Tue, 19 Aug 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594081; cv=fail; b=CFASwcBl4LJ1lBY33Ymb/eE3jlfLtGRk6MYIq9r91YWdq8wfhlSSqxytVfMUlBGcftOqVcrmBk2Y7p817qj3p56AHHsFGTXo77pt0Xbcby7EacOcu45ngqxokelfqWH3wMaAR70dWWn4XSeix4rY+8+2mDz9/9bDoHh6QQ87GXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594081; c=relaxed/simple;
	bh=U8wvkN2w6rhB4mbF0wUZXg4efaxjECR4XYoIVN89dX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvjeJacttQj2C4KN5pmgAKaFafPRmISiREzC9JGuIaw2c91bJ/moaxojTEAczaN3VgB5HaQTqQJtuXGLa7I7Frf/7vtVUYeU/OxrKVSY2Xn8grOtFjQtsmEBUu5FcHyGM9HKD6g8Vh7NB8jvbuYvmcwcDJ/+ZhCulqFpl7ae0rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QYLPr9Ce; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/80GOORDOSDBnmeHASz2tJ/68fo6QKvEC+N7chP6N/50uFlzqaHNcEh3FL1ZNkDJ0E4Ecw7A9CVyvfRRRrCKZ9CTgEzVOIUlQojeh5LbPkVrCA+9beSblKfVbr35eOG0w0aY4ird85JYuPRjYPMo+dMr3ChWAaAUmRsLmVitNWz4cgyItCTBqLl2pouFItv1zpsJ/DalBsOUjTFKNX82xzDTeALWvYsOJ0YUd6GVcLtwndSwB0zEFCR5XSi3NyJHsGcdIUxsbYuMWJ1oCKSiVLDhVGX9NHX2V0sRYYqS6HKzucOpzkSNkPhZ7xJgnB8mWpexr6WoKt1+CWPsXbAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8wvkN2w6rhB4mbF0wUZXg4efaxjECR4XYoIVN89dX4=;
 b=aYWzuQ758a8qyBHX2WlmE14vXX0wIu3p7l/x2HgCavoHKOGY7qACRucSA3OEnH5v9TXTS3rA638sv8VrIg1N7npvvidvSCHOLl6tDSYkKxUAJysjQIiSc1vYBjQucvtlpOqF0M8Ocs9h0eABVjMQxcOnDT/Di05IJcsLylAlmi/vu4dB0my9bSCeWiQaPnW6WvHJ7CgKyYIoBLRsXWRx9RjFuqzt9kjx7VxOVyqQadzyaYBIAT5Q9ZJ2wBgB8Kht8v9/dW4ohftrYb6VJui+OWxYHzF/treFs7XOJiHgr2Rm3dU2W4UpXRkiv783UkzfVaquU5hCHg1NqO+GHvvS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8wvkN2w6rhB4mbF0wUZXg4efaxjECR4XYoIVN89dX4=;
 b=QYLPr9Ce8SMSAt1f8Okqp1R3ziPlMjcCtPVoS5mcAC1IucpR4ZV0RxrnQQexIXhq02fmQwktaSQWWFKsQnn9uMk1IBZPaTG7xS+S766FG+6/Xg80CCHfNnguJDforDQv2aYynHl/tkWzXT13aMoWr/1CB0qeUoYAtdfAMg8pSlf509Fq/nKoEc9EJbX2yV7e/SxlUkfNbRVmaLPbBqcYNMptzrcOTLt65ac3jjuBzhRA78f1/VQQAQSqzbbP6d9F0VkRwGoPNKemUus0g4KtaOaRAls3iqAU9oBOABjOwK64rasgw2CyUDYL2kK27NFg77mfpVH2piSTmbIfWryFXg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 09:01:17 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 09:01:17 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch it
Thread-Topic: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch
 it
Thread-Index: AQHcENlKV6UtVO9wBUS6uH9QlvRd6LRpq2WAgAABK6A=
Date: Tue, 19 Aug 2025 09:01:17 +0000
Message-ID:
 <AS8PR04MB8833CEA0D45BD47C1FD7959C8C30A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
 <20250819071630.1813134-3-hongxing.zhu@nxp.com>
 <kvvluy56sdg6khv33cowseog4ujuebxzotlxm3hvm35slbenc5@rf3wttsd2niz>
In-Reply-To: <kvvluy56sdg6khv33cowseog4ujuebxzotlxm3hvm35slbenc5@rf3wttsd2niz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DBAPR04MB7462:EE_
x-ms-office365-filtering-correlation-id: c71c614d-61df-4396-14d6-08dddefef529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L29BRmdDV1NyMHJ5TEdFQ0RiZHRRQS9qdExjWHNGdHdtTlY1eVVseEw1RVZa?=
 =?utf-8?B?d1dGZStoeG9HSnR4NzEyMHR5WSs2NHVxdzlzSHV6TUg4Sk1NVjhLZ0Q5NGMv?=
 =?utf-8?B?RXpjcnJBQ2xHRE5senMzYUlxVTV5ZUFWQmZvSEdMREJTbVVXdU4rMGVEY3Jr?=
 =?utf-8?B?a1NXd3I3VWhCckxQOEtMS0ZLTjFLV1ptZzhtSHhSb1hCVExWMTlocEZjOFd5?=
 =?utf-8?B?ekhRa01SbWpyNEl0Uzk5QmduZ1JVWmJWbHlFQWQ1R3cvM2VERG40aHd1Tm95?=
 =?utf-8?B?TUNtYmxQam5uN0RPMlZ1QnlYRWJVVm8xS3hyRXNKQ21WME1lcWNjbFQ3NEF1?=
 =?utf-8?B?eGY3TEtSTFB1ZUtDLzU3eEVQYUgvMHJhYWVKdnNJYld2SXBFSXVXTEVLV0lC?=
 =?utf-8?B?Wnp1SWpFdjJEcSt4ZU95RDd1aVkwNTk5TWVxYTU3dXZnRUoyK3ZEYUVMMDlD?=
 =?utf-8?B?cXVyTDd6Q0tKYzlUWFBoRkoxMVE0UGlCeDlNYTZONUl3aDFwbHc0aWQ2TWlj?=
 =?utf-8?B?cEQzdTcrVENVNnEvNUlQY1pIY0NvbnJXc1orQ2JRUkFKbUNUT1RWQllzQlpt?=
 =?utf-8?B?d0RQQ3NySkkxZ3FXUVRiLzJuYVhOUUFiR243K2VpMXVFS1lFRHRiOFpydCtm?=
 =?utf-8?B?ZkZCNDhWbWtqKzR6SWxHQ2pRa09ueXcxYjh2WWVoVDJmUXRqMkVDd1hrMDNh?=
 =?utf-8?B?ZWtLY3JNL1JYOE52UTNhWU1WWVVTSnB4TmJ6cDJLcUovRFNuVitxWFBHR0VT?=
 =?utf-8?B?TTQ3dWg0RUE1a0dGTnMrZmxPSTdwVE5EenB4Nm1SZHpQaXBiZk1wUlFURmZW?=
 =?utf-8?B?Ny9sRUlZYnhhS2U2ajVhNzZVOG1kSEwrampnVUdaVmlCT0hjbWhPYWVGenpz?=
 =?utf-8?B?NmJWM2FGYkE2ZDNKajFCVkZKWEtvQlozSE5JOFZ2NHB1L3NGWm9uS1BJYlI2?=
 =?utf-8?B?bHZvQkM1Q1NaVnhJVFk2c3pGaU43S0lwU2UwVmh5N1hpc0toWEdBMGxWTGMw?=
 =?utf-8?B?a0lNNGdDYVV4d0dnbmRaR3owalErVVJnbFY2THNnaFJ5UnYwS1VNQ040VHBY?=
 =?utf-8?B?bHh3eFlreVd2bURlSE9qL1VaMW5GVk5XQTV1NnFwd2FjODB2YVNmQnlyeVdH?=
 =?utf-8?B?WXFDOXZMUGtaNUZrT3RaTFQrOFZleXlWMHVqTWM4cEpUM1JHNm9jNlI4K2F0?=
 =?utf-8?B?T2RCSnVNd3JJMDY1WG1BaE5DcmV2d21DQWFnYTJocCtKbWxkVWFqNnhiRU9r?=
 =?utf-8?B?clRxaDk1aVlwbWczcTlaeHFteHdhT1VuK1Y0Z2YrTndUR0gzcnhKcHhxQzZR?=
 =?utf-8?B?MFp0Y2Z6UWhGNmpGQTlNbWNCY20waERYUHZEMlEvd1lBdytrZHM5aXpNamRr?=
 =?utf-8?B?ODVVMCtQeDgrTFhuZnZGM0REaVVEWHV2S3o5NVdMdTFvR3VvTTUvS09RV3Ey?=
 =?utf-8?B?bzFXV0pGMjJSYnZrSlBqZFUydVRacFhmOTRsTnVEWXUzWlBoMmJIakQvWGda?=
 =?utf-8?B?dW43RjNITG5BVjNsbml2aEQ5dXBGVDJDZzFCK2pHRnNMLzQydjBFcnNaMVY0?=
 =?utf-8?B?TEdJM1FqdnJVOENDbXo5cHpZMU8yRmhBUXJOMElEaGpSNW5jQzJjU2lobnJo?=
 =?utf-8?B?UjEyT0FuMll2U2xXemJ2QmZLTXk2Nk85QXlqNndIS1JBdGR0WUpkOUhaUWUv?=
 =?utf-8?B?R1hteXoxMWxuN3pYOEovWDB3cTZvUHpYcEVncGptbHlXaWdQVGwrR3p1WnM2?=
 =?utf-8?B?UkdqMmVjWDB5cTZjY2IraU5IYnJORVlEN3hJdnRRelJ2aytWSXVSQmZRSkRU?=
 =?utf-8?B?SE5TTTRnRHpqNGZFdmVKb0pCY0VIYitVK1dzVDF1UlA1T3o3TjFSdjZWYWtk?=
 =?utf-8?B?eWJKdCtjNXNidCtUSGJtNndCa2IwQ2JJWDh6WklYM3lxMzE1M0xiaVRBQlIy?=
 =?utf-8?B?N2kxMDFCLzZ3THREQ1hXV3lKVG96R0JoTFBYNlczclVFSnhoa01qVU5IVENW?=
 =?utf-8?B?RHU5ZCtFU2J3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzhiK1JkbUxFemllL0tXT1BJSERXUlBxSzQ5ZGgrZkpDb0t1cmhVK0h2V05S?=
 =?utf-8?B?dG1aNEFIaFFOdXo3cmE0emdETEhldTBORFB5UExqUXkwYzh4YVRRc3FlR3o1?=
 =?utf-8?B?VDVQQ1N4aEY4T0tUYTlCZGs5blZ0OWZpNlFiQmUvQWhOeVErNUlYZzRHS2JZ?=
 =?utf-8?B?QXYvZXZzeWdwQmdVVzQ4bnNadmwxSkwxaWpTSS82c25PUm51QVNWMXRhRUsw?=
 =?utf-8?B?ODhlbWVjZ21Cbk1IWGcyMDF3UElhdmVTaVNJNXJnK0l1d0FJcWJBQmtjVHFt?=
 =?utf-8?B?RjcraGtzdGRJamNjc1QrVDRrRGtZTThkZmNyNkIyQk1neWpNaVJwYjRpOTZL?=
 =?utf-8?B?cUtlNnJnVzZvTDF3UlBreEE2anJSb0orRkRkandDcnAzUFNHWU41TTBrWHRw?=
 =?utf-8?B?cFhlOFJXa0JsQytuVU5lS2hwTlMrZVJDYWdDZzlWZCttVkYrMnBtQ0psYlYx?=
 =?utf-8?B?T1BuVVlMKzZPOThkdWx3NktIaTg1ZTRpYUlpMTRCQnVKTHBkcUtOam56NHJS?=
 =?utf-8?B?THh1WE5kTEptNFlNMHk1NHNwSi9Zam5WajVFbWt1dnF0VXFBQW15OVREcVZz?=
 =?utf-8?B?UFJJbG1MQUlpZGxNMVdtd0lDZGhneHgzQjZyOTlRUkRxUS9paC9TMW9zWW1y?=
 =?utf-8?B?OEVyWHJrU2h2VlNSeE95djRkTThOOGw4aE83WkFhN1hNTDNXeURsTzBVcWps?=
 =?utf-8?B?eDEyTWI0TGNXczVLbXloSXE5WGo2V3Y3VHVKN3Y0eVhNd1I1Y0JLSWduaHdC?=
 =?utf-8?B?VW16MzYwekVtVGxnNE93R1M2NVV5NnR5Kzg1ZmF2WGNxY0dMRjdPRUQwTU5s?=
 =?utf-8?B?RVM0bnd4MTlaMHorME11ek9uSUJBMjc4R0YrVXpDcU5vV0I4a25zV1lpYzhy?=
 =?utf-8?B?b0s5VkZNRG5nZXhLWHFPM0ZBMy9sUEJnNDVuZ2FxSFhRMngwUzdGVkw0VUZU?=
 =?utf-8?B?OWxuOHVlM09UaU13WFlPQlNybjVKSFNzaFE1MXVLWFdveU1tYmZhZCtnSkhE?=
 =?utf-8?B?QnI1b0crZGViU3JhN0R3WjRkcklMLytNbzQycmNYME44VE8zWUNhYk5pTzFL?=
 =?utf-8?B?bGdMbUpDVEZSZkhsSXpOQWdhcnZsNEY4bHRSNkMwMVdmbXkwN1BnYUhoSFp1?=
 =?utf-8?B?ZW5DTGliMndTNVo5VUJUQllYdzlTSzNwVjZpSnV0SSt0VmVlMGpMa2NUcGEy?=
 =?utf-8?B?MWVJUkF0dUxZTnNmVHo0eDQ0K0hTOUxOeFhWdWVxNG5MZ3V6RmZKbHhWTGF1?=
 =?utf-8?B?aGNFNCtmdGZJYkpIZ1FFRVVObHFCZitSL2dGUGRiT203Wk1iSlIvNWVpNkp5?=
 =?utf-8?B?UElWT2xCOXF0eXpqK0U4cTI3WGE2ZzhBREtvS1pvcWZqNC96MTNVeEtVRWs4?=
 =?utf-8?B?bHVOMnVsUkNRVUJ0bXo1ZjM0S3NTS3puRXF6cVhWVWZYQzEyc2VVSFZFdjVa?=
 =?utf-8?B?RWtyTC9yUk44eEl0WlVONzZtYkk1bDlVZUV1WWlORjdDNDA5d0JqL1VwZXN1?=
 =?utf-8?B?NEo3RlhYSUF1K05rb2JraTJhVDNqM2FSUk0zZjZ1TWRmMWU0Q2VaZ0dSOE5C?=
 =?utf-8?B?TG04a3JkVEd3M29oYm5UMEY2am0rRzYwRFo4Tnd0Qm5xS1VCejFpZ1FTZ2xx?=
 =?utf-8?B?bnIzVm1SWjhGYkZndDhtU0FNeGZWdmhIcitMdHdEdmgrVmVUOG1BdVdmS0dE?=
 =?utf-8?B?aE44cVpMTndORGJUd0hyZFpkWGw0WVlWWUVsRFZzQUl2S0VKa3UyTWxsemZZ?=
 =?utf-8?B?SkVxNG9qbkFmWWo3N1oybUhWTlUxTDhYUFFkYlB1Z2gwM0dlT0NpUGtmUmJ1?=
 =?utf-8?B?UGpaR2dsUjRsQ3hYTFZFRytoNUZZZDJ1NXMyNEdhWEYyM3dmVnJia0dNd2d5?=
 =?utf-8?B?SnNPRHFZYjRpYjZ4d0FxOVBicjhvUGUvSm0zbm80cTNxWnhwL09mT2RsTVhp?=
 =?utf-8?B?bmpNd3ZZVnRpaWZEZmRMMHlxRFFLaFN1MXhVQlF4UVo1UUYrQjhxNWZYMlN3?=
 =?utf-8?B?WGRGZVFyenpZT2taaVZxZHBRaEdHTXNPL3FDRmNEMExOOTlMdXNWZHV3RE9r?=
 =?utf-8?B?V3o4a2NVb0VkRDdUUm1PUTFkcXQzMkRuSXBzbjBNdmp5R2M3d3NPWGU3WTho?=
 =?utf-8?Q?ttaM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71c614d-61df-4396-14d6-08dddefef529
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 09:01:17.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+GXj62PMDQ8sKE6ROA/0V618KV4zNtDmmSElYbt54q+1Rson4xUXP0fadnkcIYlJlT+fYY3rVEfT7WQRXmsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7462

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDjmnIgxOeaXpSAxNjo1Mg0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBr
ZXJuZWwub3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGty
emsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzJdIFBDSTogaW14
NjogRW5hYmxlIHRoZSB2YXV4IHJlZ3VsYXRvciB3aGVuIGZldGNoDQo+IGl0DQo+IA0KPiBPbiBU
dWUsIEF1ZyAxOSwgMjAyNSBhdCAwMzoxNjozMFBNIEdNVCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+
ID4gRW5hYmxlIHRoZSB2YXV4IHJlZ3VsYXRvciBhdCBwcm9iZSB0aW1lIGFuZCBrZWVwIGl0IGVu
YWJsZWQgZm9yIHRoZQ0KPiA+IGVudGlyZSBQQ0llIGNvbnRyb2xsZXIgbGlmZWN5Y2xlLiBUaGlz
IGVuc3VyZXMgc3VwcG9ydCBmb3Igb3V0Ym91bmQNCj4gPiB3YWtlLXVwIG1lY2hhbmlzbSBzdWNo
IGFzIFdBS0UjIHNpZ25hbGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA1YTM4Y2ZhZjk4OWIxLi4xYzFkY2UyZDg3ZTQ0IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTE1
OSw2ICsxNTksNyBAQCBzdHJ1Y3QgaW14X3BjaWUgew0KPiA+ICAJdTMyCQkJdHhfZGVlbXBoX2dl
bjJfNmRiOw0KPiA+ICAJdTMyCQkJdHhfc3dpbmdfZnVsbDsNCj4gPiAgCXUzMgkJCXR4X3N3aW5n
X2xvdzsNCj4gPiArCXN0cnVjdCByZWd1bGF0b3IJKnZhdXg7DQo+ID4gIAlzdHJ1Y3QgcmVndWxh
dG9yCSp2cGNpZTsNCj4gPiAgCXN0cnVjdCByZWd1bGF0b3IJKnZwaDsNCj4gPiAgCXZvaWQgX19p
b21lbQkJKnBoeV9iYXNlOw0KPiA+IEBAIC0xNzM5LDYgKzE3NDAsMjAgQEAgc3RhdGljIGludCBp
bXhfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcGNp
LT5tYXhfbGlua19zcGVlZCA9IDE7DQo+ID4gIAlvZl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAi
ZnNsLG1heC1saW5rLXNwZWVkIiwNCj4gPiAmcGNpLT5tYXhfbGlua19zcGVlZCk7DQo+ID4NCj4g
PiArCS8qDQo+ID4gKwkgKiBSZWZlciB0byBQQ0llIENFTSByNi4wLCBzZWMgMi4zIFdBS0UjIFNp
Z25hbCwgV0FLRSMgc2lnbmFsIGlzIG9ubHkNCj4gPiArCSAqIGFzc2VydGVkIGJ5IHRoZSBBZGQt
aW4gQ2FyZCB3aGVuIGFsbCBpdHMgZnVuY3Rpb25zIGFyZSBpbiBEM0NvbGQNCj4gPiArCSAqIHN0
YXRlIGFuZCBhdCBsZWFzdCBvbmUgb2YgaXRzIGZ1bmN0aW9ucyBpcyBlbmFibGVkIGZvciB3YWtl
dXANCj4gPiArCSAqIGdlbmVyYXRpb24uIFRoZSAzLjNWIGF1eGlsaWFyeSBwb3dlciAoKzMuM1Zh
dXgpIG11c3QgYmUgcHJlc2VudCBhbmQNCj4gPiArCSAqIHVzZWQgZm9yIHdha2V1cCBwcm9jZXNz
LiBTaW5jZSB0aGUgbWFpbiBwb3dlciBzdXBwbHkgd291bGQgYmUNCj4gZ2F0ZWQNCj4gPiArCSAq
IG9mZiB0byBsZXQgQWRkLWluIENhcmQgdG8gYmUgaW4gRDNDb2xkLCBnZXQgdGhlIHZhdXggYW5k
IGtlZXAgaXQNCj4gPiArCSAqIGVuYWJsZWQgdG8gcG93ZXIgdXAgV0FLRSMgY2lyY3VpdCBmb3Ig
dGhlIGVudGlyZSBQQ0llIGNvbnRyb2xsZXINCj4gPiArCSAqIGxpZmVjeWNsZSB3aGVuIFdBS0Uj
IGlzIHN1cHBvcnRlZC4NCj4gPiArCSAqLw0KPiANCj4gVGhpcyBjb21tZW50IGltcGxpZXMgdGhh
dCB0aGUgcHJlc2VuY2Ugb2YgVmF1eCBpcyBkZXBlbmRlbnQgb24gV0FLRSMuDQo+IEJ1dCB0aGVy
ZSBpcyBubyBzdWNoIGNoZWNrIHByZXNlbnQgaW4gdGhlIGNvZGUuIE1heWJlIHlvdSBhcmUgcmVm
ZXJyaW5nIHRvDQo+IHRoZSBmYWN0IHRoYXQgdGhlIHBsYXRmb3JtIHdpbGwgb25seSBzdXBwbHkg
VmF1eCBpZiBpdCBpbnRlbmRzIHRvIHN1cHBvcnQNCj4gV0FLRSM/DQpZZXMsIGl0IGlzLiBUaGUg
VmF1eCBwb3dlciBzdXBwbHkgd291bGQgYmUgcHJlc2VudCBpZiB0aGUgV0FLRSMgaXMgc3VwcG9y
dGVkDQogYnkgdGhlIGJvYXJkLg0KPiANCj4gQnV0IEkgZ3Vlc3MgeW91IGNhbiBqdXN0IGRyb3Ag
dGhlIGNvbW1lbnQgYWx0b2dldGhlciBhbmQgbW92ZSBpdCB0byBwYXRjaA0KPiBkZXNjcmlwdGlv
bi4NCk9rYXkuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IC0gTWFuaQ0KPiAN
Cj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCu
ruCvjQ0K

