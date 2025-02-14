Return-Path: <linux-pci+bounces-21427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA89A35831
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1087D18873EC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3D21CA06;
	Fri, 14 Feb 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="JNqSnyJj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DE21ADD1
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519406; cv=fail; b=lxvdSBu80RX3QttfoPuJdLmCsl4CcOzZFpqLbYIQlySeZSzGbj9i+68mVNhcVTUol75l7sa4x236amccAcFgTzIEpwXBke1CyDqGyTtUSv6QS0ELhRy2o3a4muMeoZdV602seMkEzB0GpPBUtq4ntrzVJ5KMv1XjFkXUOt2DuUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519406; c=relaxed/simple;
	bh=PxFyXSFPEEwji2Osex82H5XkzL7PC+1L5VM6NW7eBlg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fED7yau/dwe2nFp0cA4UEZTSjify0QZwTvHiAWwqC/VJQ691UE6qmvrbCZVb/wMFeH1by8gxrS0wmvUlLysi5HWNltCaFceadJuIZLI0hIZAyrrPkU10TSwiBPPUQvCID4F9QOYhO9iKKBnqWK/zzQp9q2ZHSfYDshUj14DLrpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=JNqSnyJj; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E3LiuY015422
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 07:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM202306; bh=PxFyXSFPEEwji2Osex82H
	5XkzL7PC+1L5VM6NW7eBlg=; b=JNqSnyJjBNTAr0LC6Fg3xM+QTDGjEb5nfHvHz
	5dR4iBTKMyPKY45uxnngFT8G9lJVs9AVLPlKQOtcy3f8mAdWfzd9cy432yeP60nL
	FbIjAAflafPk8hdprTWgTN7WcRu6SXU5IwKwTAZiDxpVtwxQT95Bdsw2I+Xii5hE
	e7kjHvVBdRuUPhHA/1+R4u0zj5bazjl2xldr+hbf9G7sh7Q5amF/l+J8sPBRMzZW
	gmhaKZkHZ/Lhi7v9R66zpwcGvkWhGAQrFshW+ZbDNn35iKZASr85Aux/Dn9YzAHE
	88BT16CGhr8dqQzVh81sm97NB9iWMzPQhKW9I1pTwJjz2QI/g==
Received: from hk2pr02cu002.outbound.protection.outlook.com (mail-eastasiaazlp17010005.outbound.protection.outlook.com [40.93.128.5])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 44r7aab1b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 07:49:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjPGKpq+yXclLzKKnf0RL2PIYNh4v+JuRMRqX3VPMtdoJGWZtiDPO711tbEhnb0880XvutXgkA7mE8wogHSIZlA6eJdsJxI6XCYcOaRJoYHx3rG4STmg/wJ9bcTgJQveM+gLbU2MEGMzihIZ0lIa888fCzatcFWH4kTnLbZE1fCgE5yUhKY9GNZEPctoOjCBSiZf2kVTt1opdH87fdoRqpypnG52e7GurHkwNT2o94AkuHE/JMAkGMhpFgNU3gtV2RXgHv+lKMwj1srQtcl+6DqM87md8ew0WIj3v4p8YiAHdBljuW87JQv6f3ZhNykxYFhTKCqexg/yEV75uriUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxFyXSFPEEwji2Osex82H5XkzL7PC+1L5VM6NW7eBlg=;
 b=YeFD64wCTr9hgQ4OrcVKf+yavxvmLmxk0PkV/UtpebX2NNbrLNaklbJ1JzEPh4LCcXA/oqQEK2xNw+JMr+TS8JhzdeQpjSE4DYz2QghAM+1LgqbnKkHePU97pOZDk1wxfL9O9KMybwGc68ZxPqQwXuT+YPQXuwNafJb2neAObKdk9wB9YChBq8BY7i6OFR3u+RtQszaiif9wBzmwjtK/0FG1doThqmB76wKKioj+LVJfRKQmqr77tvBMcime+lzScMNhnIJYcxxqGyZUCS/JdiZTgJ6/g3pyonDEMoQgm34o28+tW2IjULB3W9aGl1iK0IbIdcDbYHTCohC+RSaUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by OSQPR03MB8624.apcprd03.prod.outlook.com (2603:1096:604:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 07:49:55 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::c273:e221:2cbf:81a0]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::c273:e221:2cbf:81a0%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 07:49:55 +0000
From: =?gb2312?B?WGlhb2NodW4gWEMxNyBMaSB8IMDu0KG0uiBYYXZpZXI=?=
	<lixc17@lenovo.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: subscribe linux-pci your-email@example.com
Thread-Topic: subscribe linux-pci your-email@example.com
Thread-Index: Adt+tNtZUWTBKjuzSkuWW+U66N4Tbw==
Date: Fri, 14 Feb 2025 07:49:54 +0000
Message-ID:
 <SEYPR03MB6877CBDE566D3C998F17FA10BCFE2@SEYPR03MB6877.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6877:EE_|OSQPR03MB8624:EE_
x-ms-office365-filtering-correlation-id: 3c90180f-6298-4e39-b748-08dd4ccc2be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MzVta0RWM0dwRFlmQmtvT0RkUWUxVmM4YVFDVWFFc2lqck0zN1ZIR0tjL0Jh?=
 =?gb2312?B?ZFhVWjRZZ05OMDZFbVZ3VkNjdlUvT1FDYm1XNHlsdXBjTmZ5S2RScVZCQ3c0?=
 =?gb2312?B?UFZKL1lrRFIzbmUwWFV3aExqckd5cDJCNmZWOXNOZWtjQ3NxYjhFRVJTdVRz?=
 =?gb2312?B?TjJQdkN5cEx4Z2UwS3ZFT1VPN1hVR1RqSzZRS2tvL3lhMGgrY0NNZkxPNnBw?=
 =?gb2312?B?Ni9reDZub1QzQjlBOEl4QjlsN0poaXM3dUVlWlNOOHU1WGxMQmpiK3IrS2Q0?=
 =?gb2312?B?elE2NjdLY0JrNk5jOGZRUU91YnlOelNZVzBiMFBLckRzYlEvZm9XSVRQaU51?=
 =?gb2312?B?VW5Hay9nUDd0QlFlazdJU2p4b2c1VWgxL0JxM29HSHIvdmVHbFRIZlR0akdh?=
 =?gb2312?B?TnhyOGo4eHZDSjR4QUx0MlNiNzR4UFhzZmx0ZEhkVjBDVUU0QVBBWU5oNVhQ?=
 =?gb2312?B?dDdBWElHZ2dRQVF4L1lhZEtHYmNPdnJ5SktxMzNXMnhlVDU1RE1IUDE5TGZi?=
 =?gb2312?B?YXlLeVBvWnc1OHI2WXQ2K2QyeDN2cnJQQitRNHFWenhvcEdGenkzT1JXOXdt?=
 =?gb2312?B?ZFR4RkxaS3RaZEg4bHd5ZjNLamkxYlNMNkRPdEt4cE85SmIyTHFlS0ZqMDFF?=
 =?gb2312?B?cVM2anc5VS9pL0Q2Z0NGNkdKbEN6MmZtdTA5b1VDWDNjUnRlMWZILzFXdXB4?=
 =?gb2312?B?RkVOSTJtNnlmY28waEZYNXAyNlVUUG1iVzgrUkQ1RWlRU0lWaDdHR09KcUpx?=
 =?gb2312?B?ZGdYT2hhT1Q0RVZmVXFyb0tXVDVVb0hxRkpndlFjVUQxMC9iV2VTc1BkcGRR?=
 =?gb2312?B?aTkwczBtZlZrL2FQeGZMRzU5aWFLUUNRdVkzZHNtZHVqUTB1UlF1eE1qRUxp?=
 =?gb2312?B?S1B4elJtR09GbUZJUEZGV0dubUJVQ1g3by9GMmtrdlA5alBUMWlsNWpqaGFT?=
 =?gb2312?B?d1BYcTFEN2kvWE8vR3lZcmVYSWxhQUpEeFRsSzZKTVZmMFlRM3hSSWF1MnJC?=
 =?gb2312?B?Sit6Ykd2OU9RYVFRL3YzeFVSYjluOWJaMGxZMGp3cU9MU3h2ODVLOGdKUHBW?=
 =?gb2312?B?SGxqQ1JrTHRZMENRRU1TbnRGVWtBZHhzZlFtQ2N4T0FtU1pOcDYybEJkeGhI?=
 =?gb2312?B?WTdEbktLTEhXSW1DQzFQR0dSNjArT1U3Z1ZVaHdEWjd4RERnTVdzYmV0QzZL?=
 =?gb2312?B?aHJUQ0lIc2w2TXFReG1Fall6MExZakdjWmk2QTBFeFo2c1h2a2pyQzBjWVNx?=
 =?gb2312?B?L1lLMmt4QVpRd1BXaE5PLy9vV2NDektKMENPZjdVQnBhNGVxZkdpekJydjhQ?=
 =?gb2312?B?T0UyWWNMVXNHVGFacGgrT1NiUFp5YmNPbWwzbGJJRU9HeUFtV0RVUWRXT29F?=
 =?gb2312?B?MGc3SlBXZjVjY293c0NzZlc3TEN1ZjZIcktuaERrdnRvUmlmRWtiVFo4alhK?=
 =?gb2312?B?dWg2V0lsbnFjMDZzY3NKZ0RINTRBdHVBdjFINVlUOWpKblh2cm02VnJIclFB?=
 =?gb2312?B?bVhIY1JXMjBneXk0TUY3eGRpSk9wa0NKVFRpWmJ4ZFZEVzFETlphWWE4dnNo?=
 =?gb2312?B?S21yUEgvOVBOemVacEdCM1VPenlJR0l2RjRGd0FOc0VFTG01TU5sYjZKbnFF?=
 =?gb2312?B?UXNJZkFvR3BUWUtkRzJDOGZJMVM4ajJSNTBoYm9JanZVODBxWFRTSUtEQnlY?=
 =?gb2312?B?TFhlMHc0c3lrU0EzYlZJSVZ6Ymxnd0MrNWdvRkttZW5MU1Bqa3RVNE9La28v?=
 =?gb2312?B?dDBsT3g4M1FNYWo2MEg2WHlISk10TFBYNWxoeWtaZmxwUkFGTU56Vi8xbGZh?=
 =?gb2312?B?cDNOeW51eWdvTmQ0L2hFWTI0ZW84ZGJadXdhcGM4RmNzR1l0cndzSWFSZnpT?=
 =?gb2312?B?bTBlZVhhRkMxenRrU2VxN0xEcmlWZmd3WldnZmszRDZWU1JqcEMxdzRMNHFK?=
 =?gb2312?Q?vZ71Z5cjMBuInM13Y0CLaZQsIdZlv0Q7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?U2lmTGsxL3lscGZyYmNrZ0tlMmFkUTNFTDFwY0hNZElIaEpiVmRGY1ZPSjFo?=
 =?gb2312?B?VXdNWmZjVGJ0Y3NXWDRsSWZHWHptUDN5bU9HRitaSXgyZHRVY29SNFR1WUcw?=
 =?gb2312?B?QUxXMmszNmhDMWwxU0MxZWcrMS9jVnQxbU1OUWZhRnUyNU5zMHE0NVNDeEQw?=
 =?gb2312?B?NkU4S1BUZElkWDV2SFlQTkdQZEMzRHk4WDdzaXF2cnRuajZUbWRKV2tkdDhZ?=
 =?gb2312?B?b09RUkw3MjM1RkF2YVBVTTVvNWYyejY4ZHhzNXlFUExZZmhEWURrQWFmSG0z?=
 =?gb2312?B?dzVPWHRGMVNzekkxN2UveUxtQ2J0UjhlZTBFWWVaVDVsYjZiRXJNMHc4Tldl?=
 =?gb2312?B?YjlqM2pwc0pkR1VwZzhYbXREbk9vQi9lNzRxZEIvcFlDMVY1UTRHSkdxRWJE?=
 =?gb2312?B?VEFVUXNvZWhSOVV3YXRnVmJsdTBZbmQ5RVE0bnlpeVgwSVBsQ21zVm43SlBo?=
 =?gb2312?B?MnhGOWhGUERPNkptNGVCWS9wL3FCemM5WWVKbEJ4SC91TFlVZ0l1czBNS05F?=
 =?gb2312?B?Qjhtc2prSFNTeXRyRklTZ1dNVEREK0tuVm9pRGNvejFqWXhtaGpKSEVoUVU5?=
 =?gb2312?B?QlRqdndRVGNNUHp1RGthekVSWjRjTzZQYU1zejVaV1MrU2lWRjR3Q09vWHZo?=
 =?gb2312?B?bGpQUnlqVHFzQ2lVOWNXRC8xeHpQdm9lUWM0bDM4WmlkTTFQQis0bXJDSXZZ?=
 =?gb2312?B?dGpDYlkwZy81dDBZUGlCMVErVTQ5ZXIrNXc2eDhZRGJDbndhMjF2V3NOd2Q2?=
 =?gb2312?B?RE5peTR2bTVLTnR2U2FYbHhmeU9hUElxWkgzSDI1cjR3RFJLNGFOSDUwdjZ6?=
 =?gb2312?B?NFZETWQyd1lXNGFkRXo5Z3hRVTRCMExPUk5pam9GaDVkTUJiWlV5SXVZY1Fo?=
 =?gb2312?B?MGltVGlaVWkwak1rM3Q4SlJkMG5yaC85T0xJUFBTK3BHbGtUY3gzREZlYWdE?=
 =?gb2312?B?bnJRTWhSdGtMTzR2VHA3V2pZM016ZzVDMDdueXBvaW1iWDNZNWJYeXZJYUtV?=
 =?gb2312?B?NXd3UndTUE1NRFE1NXI2K2E0Zm1QSVZjVHpiaXlNRjQzSVd2Nyt1djZENnVl?=
 =?gb2312?B?TEc3cDBhRk54Q0RPNnE3VGpHV3RLb2xqWG1JS3krV1RIdUpRKzVkY3E4LzNp?=
 =?gb2312?B?SmJQZXhHTHRFZDFYQWF3UHRjMkNMY2M0aUQ5M1VxREI0S0RhQkIrNWdVcGth?=
 =?gb2312?B?NE56NjE4K3hZV0xPWVFQNHRQbCt1V1ErdDdSNTVuN0hUdkh2VUZ3Mmo5d2Fz?=
 =?gb2312?B?QXJiQ0NrWHY5RHlWamY2UjcwdmRsWkJRK2lCMUM1bVlRek1zY3BJUEViTHdU?=
 =?gb2312?B?M1pmNEZIR3ZWWlp2WFVNSUR1aVFOUEFhR1Vscm9rVkdtOGg2Tjhza1lpOXdH?=
 =?gb2312?B?a2dkUDRrek1NSEhKMDdxU1hGSkNsMHpIK0wzOU51QlVRS29uNFZza1BBMlgr?=
 =?gb2312?B?by9abW5SaElMVllvVnpzVXFRL0VUNHVrNHR2b1BVODgyYVBTeTlaWVdpT1JQ?=
 =?gb2312?B?OFZ2VXRiL2hDWHI1Ymh6WEYxczliUXBCa3dRNDd6citUUzBEV0x3R2E3eS9h?=
 =?gb2312?B?RGNQQ0J4eUpFam1hdkphSlFHVWx3SS82Q3dybmF0NFV3NWpVRUczbXcva01H?=
 =?gb2312?B?aE1PR2ZTUDdrWnh2RVFiZ1BmamVPYlBKM1F5S3A5V3RZS2NGVzhuZGFkWjVC?=
 =?gb2312?B?OHJiVHRoaGJKK3Q1YVJaR1c5RDIwU1N1cURMdUkvT2tuNEVGc1hLRENmTHhm?=
 =?gb2312?B?RlFWeXVVN1I5SVc2eUJBb09kazJ5Vk95dUNubmlqOVhkbDVrazYzb3EyNi81?=
 =?gb2312?B?ZWlyK0xoTUlTQlZXYUR5NFFEMjhSejZibEFjV2tpcytMSnJ6a2xXWjU2QzR1?=
 =?gb2312?B?NHVzOWdOUjU3WWdBc0ZGc3RjeXdvQmdVZ1ZEVTdoeTZSc2h6eTdiZUpsV1hx?=
 =?gb2312?B?ckVLa0ZVRXlCaU9LTXRBV21OdVc1djREVEI1OXhDSXFvam9VZ1dvQ2tqTzVT?=
 =?gb2312?B?WGE3S0F0R3k3MksxcUtORU04OHBDMmFBbUwvbnZnNWtSKzl0TW1LbFVpWDk1?=
 =?gb2312?B?Q2hWTUkycTRNU0RDV0pWQTd6QjU0c0xkWE4vOVlpTUprdEJmbjRpSXE5Rjlj?=
 =?gb2312?Q?uWbs=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c90180f-6298-4e39-b748-08dd4ccc2be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 07:49:54.9982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opCr60H1q3ljwHvXiNZUm4k9F5wU2khfRi/fHbYQKQ/yHT+ltAk0wFe018aazSQVtYuQejzOIV/8WKISJShNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8624
X-Proofpoint-ORIG-GUID: LR_rSVbf0Xpr8sELq5pPnGqVNr9DUJEK
X-Proofpoint-GUID: LR_rSVbf0Xpr8sELq5pPnGqVNr9DUJEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=316 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=-20 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140058

c3Vic2NyaWJlIGxpbnV4LXBjaSBsaXhjMTdAbGVub3ZvLmNvbQ0K

