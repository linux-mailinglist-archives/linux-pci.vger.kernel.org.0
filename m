Return-Path: <linux-pci+bounces-38192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20722BDDF47
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED91C4E3631
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E931A548;
	Wed, 15 Oct 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fzHUIbSF";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="xVTxdlb1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FA3081D8;
	Wed, 15 Oct 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523823; cv=fail; b=V8TQ7mtmcA/kXHS32JGmoqkTuHq3VSH7InAIVPgOepGGG2ukjm1fyhaE5jqXDzFGSJBx/BkqRfLv0fSGlWeC+x7J12GB4787XqjUDl2vHgBq85tOPMGaZNCbyRxFsbS/zyFSvq60PpDhymYz/cc7zameJpdG8lt8ryEoTKF2pP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523823; c=relaxed/simple;
	bh=0OvS9T2sdV0oxx+hpbH/VhoxEtFVEbIV4nQW2vL+nfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1wmewjSbpvhKhoURFEh9wdSJD/iB86E+6gG+68MRAWm61hqf9UFlBeIKdw7m0IkHxcP4Ew70BKm6/wxJ5zQwoghPH92r7mar+srrISNekcyjUUAWme8ypPNVsH3qHrJcVWBc5RXXNl3qhWPk1VIqIDDC+xNqJGcltR5WUbVTGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=fzHUIbSF; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=xVTxdlb1; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59F9C81T1248045;
	Wed, 15 Oct 2025 03:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=0OvS9T2sdV0oxx+hpbH/VhoxEtFVEbIV4nQW2vL+n
	fU=; b=fzHUIbSFuHCv8GV3Er6SMgRbz+1yIcxDFGbrF72I+QJjm/leHwAR07k/h
	3Iyh16Lbeotae/oT6yUVAJpx59U2jzBGTW0VDVScBuSqg2GfKMWra+u7ofImPKSO
	a6Xn8T3yCLhXbXqJzIPhySS7GI2OLZw6jIXfJD9KzCrEFpXSfKegbeS1uE9zeXcL
	PibXfDVwItCy4DHwWKsig9Cp9/gajVwfHKlqa/W3N4H+b1iZrWHpvF8wzvzAHs2E
	pDuV2O5qcKJ6i1VqxnZ/fqN61nik2iDEgSWMxxO5c+DRC2uLWCi49c9R3+rPUwhN
	jq2mRtjz59p0pSUJLWkHPX0vyYJJw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021127.outbound.protection.outlook.com [40.93.194.127])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49sqb2tmkr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 03:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar6O86QgLS4OX8FHAMMjTpjSB/VFWvvR7HuNyTAAcLbxrPWLPzZuR1sgIWJCqyzpxGJjpRyPB0hnINbxZahi3+ZwIMpaiBnIrugF62whlR8rAyak6Yc4mNQyUJLOyCSQ7246pVudAWzhMOYF+b0KQNJ+7BpfiwA9KMUcfv76KD7EMI2A6zecVdiYYyEW3Fx9Eh/AZME5mG3rGvptx8jOQvKQoe4bb88/A4+hwrNmmcAaQbcNn2SG7DvF6cpZB/Sj0NRpLO+I3tHQsH+EUr9lOi48MOawdXMS7+txKmGEpIKaYmPI5abRc0HN0GrC+chWkHarTo/1vq61fMI+7UN3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OvS9T2sdV0oxx+hpbH/VhoxEtFVEbIV4nQW2vL+nfU=;
 b=JKOf03mY0TXdye3MotR1DWd6sWgha/H7kwoGwrXJMsIo4FtciCByssSEF/DRP1KysiLFhZAAfTmjvPeDy5lbliOT6GSRUiN3aub6U6kZc5NgtP53GQ0WSnbmBOGBakBmwZo6WZcmn/Mj699dh5A7YGKQlENBl+ELgbov0+OIJs+wHVFTePgQP0WZG1V8pTYAYRT1pq+PkrHWKcZAAbaf/EM8rNRvnWjmYhZ94Pw+eKZTmc2AwEKuufZwPHXf81bCtgJVzQjx45z7fHiy+wqQVWbTxPwlqdlS388SSfEYiabevchTQBkvoCZBjA+lpNWrc03Ybacxn2fIVIU1Rl+OFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OvS9T2sdV0oxx+hpbH/VhoxEtFVEbIV4nQW2vL+nfU=;
 b=xVTxdlb1TDPi3r3mkQIMWNFL83HVACIP1Z2y+KrE2kCfsmNa5lEEiGD8OeTuhYF3K78hycqJs5LPxDS6cBrYKwZkmx2mVHg+leY9i+xlYBf2EQtPf9zRXdqCzLxqoYXLuL/pj8JJKR1z5Auyk9qdfPDRzZDgh/CBRrUMDXvBt7QLDgnKcjfrldzIe/E0TZdIM0uyUvjbiX0QyO+3lDV8M2NGuR7++wfH2WdoWweLgPA+ySpjKuDz9NtYSI3my5og8Tm+3q2+eelVnVAtefFjDg4RrA4Pv2550+ix7i2fXyTjBkLdsvCyQ9mNITyXi46qkMOTm5GuvfCrVgzRIZQkfQ==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by MW4PR02MB10189.namprd02.prod.outlook.com (2603:10b6:303:22e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 10:23:20 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 10:23:20 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Thread-Topic: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Thread-Index: AQHcPG1tSNyf7ChLs0Krp+ls3jbtF7TCE1mAgADvNQA=
Date: Wed, 15 Oct 2025 10:23:20 +0000
Message-ID: <7C5EF578-B0CA-4FCB-86F7-470EDD27240D@nutanix.com>
References: <20251014200701.GA859701@bhelgaas>
In-Reply-To: <20251014200701.GA859701@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5016:EE_|MW4PR02MB10189:EE_
x-ms-office365-filtering-correlation-id: 64c3eaf1-e10b-4c6d-a5d6-08de0bd4dd5b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3l5OG9SUENxUEdFVjJmTUhUR0dETlN6dFRFYkowRUxpb3E1RzVjTDlJRHhs?=
 =?utf-8?B?ZmRadjlObmhoVGE4RGZBSzBTYWkxOUwwdjdvK1hySmxxNks0Y0VJelVXaTBJ?=
 =?utf-8?B?Qy9jVWNWbEFJOWplRkV3akN5dE1zT0Q1MlEyVCs2dFRLQXZ2NWthVjl0eG5o?=
 =?utf-8?B?UUx4eFUzMTJ4cWU4SmJwdDV5WW1nVFdlZjR5bUVyYXU2azFDd3pMckJ4LzIw?=
 =?utf-8?B?VGdaSU9teEZrT3FodkJrYk5yWXFPUGU5TzFIbHE5S0Jmd2lUR1ZOWFZzdmJw?=
 =?utf-8?B?M3ZVejhUcVR3eHBwaU9tSGU3ODdyUVM4YklxSThtWHhVcmgrbmFlNnFUR1Yy?=
 =?utf-8?B?bFdoTkpoRjRpdEpGMnNzMUJJRENxKzB4ZnE4RXVpcEJkeFVXN0xEbFU1c2l0?=
 =?utf-8?B?VHZ2eVVTRDQ2eHJRQXByZTMyaXkreGpzMTY0U1VLQWdjQWtqd3Z1REYySzVu?=
 =?utf-8?B?RnJmaWZNbk40MVk1NVJzempoRXdKUXBEbk15TmZvcmJZUWFRV01idFd0alo2?=
 =?utf-8?B?aDlxOGdzOEZzQXBheEpxVlBMSjI4bzB2czdlcmpqcGJwWFVNTkliWnYzalVW?=
 =?utf-8?B?VlZUaFBHakZqRE85RVR3Z3pPcUdHZWpjcFV6UzZrWm5yRDdyeWJtSWFuRlRU?=
 =?utf-8?B?TVR4NkJrYUthanQyYXdBKzdVOXNIQU1uR3NCQURlVG1YNWJlMUo1TklJdzZP?=
 =?utf-8?B?eVZLMzFBT3QzN3pNZ2Z4YTBSWmRZaEpCTXF4dUcxdE5wNmJEZFBWcVUrK0s2?=
 =?utf-8?B?MjRtZ0dwV24wWmhjODI2WFFLeEh4ck9JKzJHQzBCQW55T2xMQ05SWTU4RDBM?=
 =?utf-8?B?bTdvempFUXlRNnpBVEZSY3NzcUdGMk5Wd3N6N0pWbmovaEZuQTNOc3YvblNh?=
 =?utf-8?B?VklJbmhBQlFtNTQ4d1R6a3IrZ1U0S0NLYUNPdWV0WW1TUmlhbzdMdEJFOVVH?=
 =?utf-8?B?SUNHNHd4S3RlNHU2MUQ3enpDWVFCaTVVTWxsVDRBbjhXdy9hcE53Qm1kWTk0?=
 =?utf-8?B?K3dPdEVnSkRoaW93ZE9xZit0emllTHJFcm85Q1hsREc0a1ozTmg1c0xLN2Vo?=
 =?utf-8?B?d0QwRHIxMGNYSklQcjJxb0wxcmIveWVyVlgzdmxsV2RwdVRqdFl2NHRnWjMx?=
 =?utf-8?B?S1JLWFNFNm9EckNsanRRYlFXbVR3OGljaXI5WHgxK25EU3Z6QWl2UnQ4Qi8y?=
 =?utf-8?B?bldBS2dtY3FqS2ZQTUQxZ0taUWlvbmFnanpqMWFtc3VVck51Q0FKMkNjeHE5?=
 =?utf-8?B?SFBWK0pXWjVRNldhSDhuc2pvbnJjODVaNjlKYk5XRDBaVmpNaWZoWGs0M0Mr?=
 =?utf-8?B?NFJvYlFPcTNMYXBQUEM0a0VLUi9GeFBqMnBOZHI1NVdxUy9wTFhNYWFFOVFn?=
 =?utf-8?B?amRZL1ZKMG1YR2pId1JrUGlZN1NsS1JTaVVmY1F1WkI3WTg5WmdaS21kdi9Q?=
 =?utf-8?B?U3BTck9uZmZkekJHcU9IV0ZUeGMrZisyTVVuU1QvNGxNdTlYSDYyVUN6Vnhl?=
 =?utf-8?B?anRuVExCWlkxc2RhS3ByVHRBR1BUMWUyNkVlV3pzMEtBbVZDbEVRUkorNkMy?=
 =?utf-8?B?Q1FYSXBMWWZqOVNST2pmNmRka2psamRJR0tuTE83SmlPZVUwUi9NZ0NVRkw3?=
 =?utf-8?B?UExDTVBaTVM3bFhkVk85WFcvb21VZ1NodzJwOGNJcW5RV1JQNlVaRysva1My?=
 =?utf-8?B?TGptS3g3clFEVXFpWE9lanRSWmRTb2FiSG40Qko4cVZlRldWOHlsWHlrcytw?=
 =?utf-8?B?SUdDOWJpZ0x3K0hpOVpvREl1RmZwWGk4QUtzaVVIS1g5eFhwY1JFNXc0eS9u?=
 =?utf-8?B?L0xCbEV1VFhoM2t6TWxQRVAvM3hxcHNLT2sxczMrcm4zVklLYVBCaWxkQW43?=
 =?utf-8?B?Z2F5QjNsdFNEREVvWmUxMkxibmlheVR1OFBzczZZTEk2ZWtMTjVpM0R6b3BR?=
 =?utf-8?B?OUUxcksrYnhmczBUWjBtN3hCdklMM1kyNk1ZVXFlbTl2bVRxOTBMNVV4V3Yy?=
 =?utf-8?B?QzNsOWFpY21paHUzbW5WZUdhNWtlZ0syVkg3ZHNXdWZLOXBKM0s4RStKTCtJ?=
 =?utf-8?Q?XCxUkt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEFyd3dOb2dtY0c4ZWFkdVB3U0RlOXNMNjMxOC9naHNNM0MzNzdtMm92VHZ4?=
 =?utf-8?B?NGh3a2JKTmZRVmwrbXZzVmd4aC83bDJ6NmtlVUlaWHR6TG9qN0RDalkxeCtM?=
 =?utf-8?B?YmtLOHg5ZUZ1YkJ4OWFHaHp6RXlrVEt6ZjRGSGpmaXNtQXRBQmYzbzU3S3M0?=
 =?utf-8?B?dXhRQ3ZCeTlpNldkM1h0aUdPclBZWnBPUlRuMTFVMHFYRStPdVM2bEdSU3Ix?=
 =?utf-8?B?V3FTWitGNTZrUEJsdHhQUVlsUWtoOCtVZVJ0bk5xdXBzU3J5MEJrR05UYjBm?=
 =?utf-8?B?TmY5Q1Fncm95cHFlVGhzMFlwSUFaM2kvWGsvMkkvSHFTcHNSa28zcEFZOURx?=
 =?utf-8?B?TW5mR1N6VzcvdkFRTTgrMmZZc1pyVXJkNUxicjFGT1dvYnp4WFA4cElENGQz?=
 =?utf-8?B?VUdiV2phSzR3eGJaQmEwQUpOYXhuNllmSjBSeFE3UFV3R3AvNDkzSU9aVllF?=
 =?utf-8?B?amtpNG1Tb0Jnd2cvRTdTbmV6ZnlVOHM5RUFXR21qZ3lJbXZFSnAwWmh0QjF5?=
 =?utf-8?B?SnJmcWdYL3RJQmhEK0ZqZVdoYlQzcXcwRkM4NDJydTJGNnVRZzlZWnB3SkNa?=
 =?utf-8?B?dFMxRGtnNkd6ZmRwd0RqV0NlN2I0N2I1LzEwZnY5aU1sejhQeFRPREZZNGJh?=
 =?utf-8?B?VTJzbnpPQlNJZTJ5NXJOUWVyMFoxNU41ZWxkK3RKam9jWEI3VFpjeGZoTzMz?=
 =?utf-8?B?YXFvTWt0MmRYOEpZYzJMU0RGMkI4VFJKU2pTcHlFOExyYkRlbWtUWGtkblVK?=
 =?utf-8?B?emhPdVlaVXFpb3VHemxSdVJBM3EzYnhZN2VnNEJ3dmJRcHdNbFJXc05oOGlT?=
 =?utf-8?B?ZG0xOHYzbjg1VDFINmxsL2ZiRGxiMGs3R0NEQXA5eDMvNXZKbGkwUm1janJJ?=
 =?utf-8?B?b0wrUXQwbGFuYk0xUUJsZmZpNVczUEZLdzBSbGdILzEya09EU0lqYnpUenlK?=
 =?utf-8?B?VHlrU2hqN3lsaDl2STc1MUVFTmRiREdZQ1JiSlpkVTN1ZFBBT01MQ09FRXFF?=
 =?utf-8?B?dGVoMkRDbWNNbHJHM29XS0M3dGsrblJLbnB5RFFWbnpqUmxRVjcwMnF4U09w?=
 =?utf-8?B?QnNoeGM5MnNIU0NYNENMSXY3V0U3VVVxcUpUbUdoMFlWV3ptMHBWK2psdXhz?=
 =?utf-8?B?RzdxQXJoVWNXMFZoWmdmdnFlM2FvY0pnMDNlSk9qTTZJMnpoRDRSaUZTRjFY?=
 =?utf-8?B?RGM0QnR0cm5tWFNrajVGWlVnTWtJV21GVDhzYm9FOVYrdUpZWllQbFdFTjJS?=
 =?utf-8?B?cmdoKzBDUXlPUWpBbW1kRzAyZHBYZmcvYXFPRDJySGtZa2xPelhEMFEyYVR5?=
 =?utf-8?B?T21jU0hieHlML2prSlZaMVdnRHgyVEVOUUpPa0xEMGJrdVF2VlBYek1hOWRq?=
 =?utf-8?B?RDMvZ3J0WGlIMWplMGRjaG5TcWNzejNxakdvUTQ2bnpJQnRONGpWWnBRUldP?=
 =?utf-8?B?WU5vQUZlUnY0N3kvVlFLZjJHK1dxZ3lkQkRqT0lWSEoyMUh0aDV1elVWK21k?=
 =?utf-8?B?VUtpMTM3SFpsRDU3aFBmNFZiaE1mdXg4WFBiYWlrekFoeEFaQzJIVFhZditU?=
 =?utf-8?B?TUlYejJxQnBVOFdwSVIxR2JWcDZxK0M4SDZ4Sjh4OGFpSG80RTBoUUhFT0cz?=
 =?utf-8?B?elFVTnROQzRwSDBXTWYybCt4R3lmT2dYQWNyMkxFeTZaUy9VU2VVa09tMUJ5?=
 =?utf-8?B?OUxUYkNYYzZYdEh3Zy8yazJqZ0NEZnUxOHBmU0ZDWmphK2dSckRMa2pyWjBW?=
 =?utf-8?B?ZGp4YlNyd0I1WXFYelVYT2E0cEd6TGhSaHUzbkFqZ1VJWStwMUZiM0ppaDJV?=
 =?utf-8?B?SUFldXV3bzhoSzJOaXpDb1BVNGhjOTlBanZvWDlxaEZPMVAyWHBBRVJ4SVZS?=
 =?utf-8?B?bzFVMy9rY1hyMDZ0Mm1rMGVjbnA1VGxNSVd2cEJyR1hGSnRraXluN2dkYzVR?=
 =?utf-8?B?OWhtditJTWJnWTIycTVVK3VzNms1WTdJejlxM2RLdlNUK2Nwc2dJWU11MjF1?=
 =?utf-8?B?VmRPR3pTMkpaaUxyVjBkOHNjb0pOL0JUd29Wdis2cnlueExKUm1sV3l4UXND?=
 =?utf-8?B?bWlYcG41M3ZDWGx6bDhnbGVWVW4rc3R5UWZoZEJ3ZUZjbThvOGc3UnZkei9u?=
 =?utf-8?B?TkYyNWppVXlpWUhsc0lXU2NIT2Q2aUZDcDJyd09RWUpMVWo1YnBpYWxNUUt6?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC7EDDCF450F594AA02DA28F66001988@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3eaf1-e10b-4c6d-a5d6-08de0bd4dd5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 10:23:20.7684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNABtZAoX4TwF4K9bNt2X/GOS9EqHwGloDL7UqgxEfs/2Hu/9Gzt9qwxlApZBdbRdF/uY54DO7Rvg5xBiLFJ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB10189
X-Proofpoint-GUID: Kwcju47quQAsd0mUOrcR2rhNH2X6jB0W
X-Authority-Analysis: v=2.4 cv=R/8O2NRX c=1 sm=1 tr=0 ts=68ef761b cx=c_pps
 a=wuCIV2M2hcCPwYkL8T+rjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=n9C7zvL6i34vqU7YgwsA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Kwcju47quQAsd0mUOrcR2rhNH2X6jB0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA4MCBTYWx0ZWRfXykZe17zLlp2Q
 rsOrf2R6suP30spBiQ33u7z63LBfTLSOZ5M4P0mivWn8HyZlGzh1hofQ9n2oKqPebBho5Rv/f+5
 za5BhzbrrDZ05z9cGmMmyPb1J9pDQ/VVY2OB0RFyx2mLS2H06+rCW9QrRMualMUWr3P+juvewXe
 KBQFOYjF2T270lCaX68ku3/pvvccrGUWrRgPaACGC+T7pzKlv9XXwVzp9nX7qTbGakVH69PJOoy
 LCZWkWEXfyiVZXDDrvFcMw01Sb6NmGtiuQsOJWaFCESmwmUGj0oe/AU5FbjAtMszex1MP2paiOF
 ZzBiI/QY1Z5D2VuJWhZTsjnpnBODp30Aq+DhZYRP17KkZTGUc/+9h/H+duzlH2H7v+90iGBtL24
 plIG7g1YkfzOAfABcOT0zF/1nHdDpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

T24gMTQgT2N0IDIwMjUsIGF0IDIxOjA3LCBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4+IEluIHBhcnRpY3VsYXIgZm9yIHRoZSBQQ0kgZGV2aWNlcywgb25s
eQ0KPj4gaG90LXBsdWdnZWQgUENJZSBkZXZpY2VzL1ZGcyBzaG91bGQgYmUgYWZmZWN0ZWQgYXMg
dGhlIGRlZmF1bHQgdmFsdWUgb2YNCj4+IHBjaS9kcml2ZXJzX2F1dG9wcm9iZSByZW1haW5zIDEg
YW5kIGNhbiBvbmx5IGJlIGNsZWFyZWQgZnJvbSB1c2VybGFuZC4NCj4gDQo+IEknbSBub3Qgc3Vy
ZSB3aGF0IHRoaXMgbGFzdCBzZW50ZW5jZSBpcyB0ZWxsaW5nIHVzLiAgRG9lcw0KPiAicGNpL2Ry
aXZlcnNfYXV0b3Byb2JlIiByZWZlciB0byBzdHJ1Y3QgcGNpX3NyaW92LmRyaXZlcnNfYXV0b3By
b2JlPw0KPiBJZiBzbywgY2FuIHlvdSBlbGFib3JhdGUgb24gdGhlIGNvbm5lY3Rpb24gd2l0aCBz
dHJ1Y3QNCj4gc3Vic3lzX3ByaXZhdGUuZHJpdmVyc19hdXRvcHJvYmUsIHdoaWNoIHRoaXMgcGF0
Y2ggdGVzdHM/ICBJIGRvbid0IHNlZQ0KPiBhbnl0aGluZyBpbiB0aGlzIHBhdGNoIHJlbGF0ZWQg
dG8gcGNpX3NyaW92Lg0KDQpObyB0aGlzIHBhdGNoIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggcGNp
X3NyaW92LmRyaXZlcnNfYXV0b3Byb2JlLCB0aGlzIGlzDQpnZW5lcmljIGZvciBhbGwgKHBjaSkg
ZGV2aWNlcy4gcGNpL2RyaXZlcnNfYXV0b3Byb2JlIHJlZmVycyB0byB0aGUNCmRyaXZlcnNfYXV0
b3Byb2JlIHN5c2ZzIGF0dHJpYnV0ZSBvbiB0aGUgcGNpIGJ1cy4NCg0KVGhlIGxhc3Qgc2VudGVu
Y2UgaXMgc2F5aW5nIHRoYXQgdGhpcyBzZXR0aW5nIHNob3VsZCBvbmx5IGFmZmVjdCBob3QtcGx1
Z2dlZA0KZGV2aWNlcyBiZWNhdXNlIEkgdGhpbmsgdGhlcmUgaXMgbm8gd2F5IGZvciBwY2kvZHJp
dmVyc19hdXRvcHJvYmUgdG8gYmUgMCANCmZvciBjb2xkIHBsdWdnZWQgZGV2aWNlcz8gQnV0IHRo
aW5raW5nIG1vcmUgYWJvdXQgdGhpcywgSSBkb27igJl0IHRoaW5rIHRoaXMNCmFkZHMgbXVjaCB2
YWx1ZSB0byB0aGUgY29tbWl0IG1lc3NhZ2UgYmVjYXVzZSB0aGUgZHJpdmVyc19hdXRvcHJvYmUN
CmlzIG5vdCBpbnRlbmRlZCBmb3IgY29sZC1wbHVnZ2VkIGRldmljZXMgYW55d2F5LiBJ4oCZbGwg
cmVtb3ZlIGl0Lg0KDQo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGlzIHBhdGNoIGlzIGdlbmVy
aWMgd2l0aCByZXNwZWN0IHRvDQo+IGNvbnZlbnRpb25hbCBQQ0kgdnMgUENJZS4gIElmIHNvLCBJ
J2QgdXNlICJQQ0kiIGV2ZXJ5d2hlcmUgaW5zdGVhZCBvZg0KPiBhIG1peCBvZiBQQ0kgYW5kIFBD
SWUuDQoNClllcyB5b3UgYXJlIHJpZ2h0LCB0aGlzIGlzIGdlbmVyaWMuIEkgdXNlZCBQQ0llIHB1
cmVseSBiZWNhdXNlIG9mIHRoZQ0K4oCcaG90LXBsdWdnaW5n4oCdLCBidXQgaGFwcHkgdG8gdXNl
IFBDSSBldmVyeXdoZXJlLg0KDQo+IEFkZCAiKCkiIGFmdGVyIGZ1bmN0aW9uIG5hbWVzIHRvIG1h
a2UgdGhlbSBlYXNpbHkgcmVjb2duaXphYmxlIGFzDQo+IGZ1bmN0aW9ucy4NCj4gDQo+IHMvcmVz
cHNlY3QvcmVzcGVjdC8NCj4gcy9idXQgdGhpcyBzaG91bGQgYmUgdGhlL3doaWNoIGlzIHRoZS8g
ICMgbWF5YmU/IG5vdCBzdXJlIHdoYXQgeW91IGludGVuZA0KDQpPay4NCg0KQmVsb3cgaXMgYSBy
ZXBocmFzZWQgY29tbWl0IG1lc3NhZ2UgdG8gaW5jb3Jwb3JhdGUgdGhlIGZlZWRiYWNrLg0KDQpU
aGFua3MsDQpWaW5jZW50DQoNCi0tID44IC0tDQoNClN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJpdmVy
IGNvcmU6IENoZWNrIGRyaXZlcnNfYXV0b3Byb2JlIGZvciBhbGwgYWRkZWQgZGV2aWNlcw0KDQpX
aGVuIGEgZGV2aWNlIGlzIGhvdC1wbHVnZ2VkLCB0aGUgZHJpdmVyc19hdXRvcHJvYmUgc3lzZnMg
YXR0cmlidXRlIGlzDQpub3QgY2hlY2tlZCAoYXQgbGVhc3QgZm9yIFBDSSBkZXZpY2VzKS4gVGhp
cyBtZWFucyB0aGF0DQpkcml2ZXJzX2F1dG9wcm9iZSBpcyBub3Qgd29ya2luZyBhcyBpbnRlbmRl
ZCwgZS5nLiBob3QtcGx1Z2dlZCBQQ0kNCmRldmljZXMgd2lsbCBzdGlsbCBiZSBhdXRvcHJvYmVk
IGFuZCBib3VuZCB0byBkcml2ZXJzIGV2ZW4gd2l0aA0KZHJpdmVyc19hdXRvcHJvYmUgZGlzYWJs
ZWQuDQoNCk1ha2Ugc3VyZSBhbGwgZGV2aWNlcyBjaGVjayBkcml2ZXJzX2F1dG9wcm9iZSBieSBw
dXNoaW5nIHRoZQ0KZHJpdmVyc19hdXRvcHJvYmUgY2hlY2sgaW50byBkZXZpY2VfaW5pdGlhbF9w
cm9iZSgpLiBUaGlzIHdpbGwgb25seQ0KYWZmZWN0IGRldmljZXMgb24gdGhlIFBDSSBidXMgZm9y
IG5vdyBhcyBkZXZpY2VfaW5pdGlhbF9wcm9iZSgpIGlzIG9ubHkNCmNhbGxlZCBieSBwY2lfYnVz
X2FkZF9kZXZpY2UoKSBhbmQgYnVzX3Byb2JlX2RldmljZSgpLCBidXQNCmJ1c19wcm9iZV9kZXZp
Y2UoKSBhbHJlYWR5IGNoZWNrcyBmb3IgYXV0b3Byb2JlLCBzbyBjYWxsZXJzIG9mDQpidXNfcHJv
YmVfZGV2aWNlKCkgc2hvdWxkIG5vdCBvYnNlcnZlIGNoYW5nZXMgb24gYXV0b3Byb2JpbmcuDQoN
CkFueSBmdXR1cmUgY2FsbGVycyBvZiBkZXZpY2VfaW5pdGlhbF9wcm9iZSgpIHdpbGwgcmVzcGVj
dCB0aGUNCmRyaXZlcnNfYXV0b3Byb2JlIHN5c2ZzIGF0dHJpYnV0ZSwgd2hpY2ggaXMgdGhlIGlu
dGVuZGVkIHB1cnBvc2Ugb2YNCmRyaXZlcnNfYXV0b3Byb2JlLg0KDQpTaWduZWQtb2ZmLWJ5OiBW
aW5jZW50IExpdSA8dmluY2VudC5saXVAbnV0YW5peC5jb20+DQoNCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnLzIwMjUxMDAxMTUxNTA4LjE2ODQ1OTItMS12aW5jZW50LmxpdUBudXRhbml4
LmNvbQ0KDQoNCg==

