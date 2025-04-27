Return-Path: <linux-pci+bounces-26844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C22A9DEE3
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 05:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2053BD4A7
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ABD1FC109;
	Sun, 27 Apr 2025 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gKRZYIt1";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hx7xSBww"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14F79E1;
	Sun, 27 Apr 2025 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745726126; cv=fail; b=cNb4MCy/NzOaJznemgdxSLw+Sa0OQN0ARy0pWWKnh5N2lLiezJK17H50si6Q6eMF3+68WN5OcgsSl4DZ0EzT8M6M8Vl3yX5faomX+hQrgOZsjjZd4nzywMPAs6yDO55QXodt2rQVeyd1qs2bOwbDJ8pCyf/jsZvz+plegDGVEuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745726126; c=relaxed/simple;
	bh=jpcLaiClwSuxkOAXl+gBFKayucoBo99VolJl16oedno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVZ1RSCg9i2KP+C1EMCh7T/CsUe/Dfz17+A9kCWO6LPTrCzZOYdBIdPqrdx6fXduXWu9p/9yAVWKmsY62TmgQR18lBmUfYhIj5zJnEtBZNZRAHLF/YwDRz7V/qmLodSk9L6T7IbiOizf+OAack+1xXz49uj2ocrnCKFBan+Q6rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=gKRZYIt1; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=hx7xSBww; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53QMVJQN026718;
	Sat, 26 Apr 2025 20:55:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=jpcLaiClwSuxkOAXl+gBFKayucoBo99VolJl16oedno=; b=gKRZYIt1aH94
	DYAdC4R0NFA4Org3vxF6lEi+GY4D9RNfB5XUqomjiOkyD3mEgKZtqOSo++dhqb1+
	QxRBj2OV7shft492yV0F6thomi339siobA4V7R8Z5IB9okPqI+VKzeqEq+vX5FO4
	FEfvTl7XuJPB2lSVX/r8nDIXcKSq6AefHQXvk9mxFH2l0QWYG/wgJ+o4+Atlt9Nr
	RQUl5eVtY4Se7oeIufkg73nsam5CMCiRWMrZYq18L7a5R3aDSdQhV7Q9L9sQoyxJ
	03xndYtFpo3iZJH9ZOHYF6ohuYLZUNKL/db5oyfNEDCpX24YP/HiyDXYofs7EE4X
	8YyaQiydtQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 468v1whsaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Apr 2025 20:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnl1BeFJx393JBB/MuG++HH8GgJn/W1SlgolLL7Ubi8qC9z0wdzGHt4qNxboza24niAwQauf1F2uZdDX+9Kf8L7gq2oUnaHmods4UaCSdig+FktpGmJzFTFSm9loeroqPJX/EYP86H15oA+aFHly2fPVL9/xGP4miMWdGnjFIiH9vvxiiLgYOyFsgWfk7MW3NAXv4tYXG0LSvkFiswuHVKyJdwdDIGSjNKg+Oh/APbHR5WA8x7OodCd6en8dN/3q1c/2hkk25rtiiXLU4N+B9xAqHqAglTjqxwiiNOdq3zaHTTcUyjAgcvsQBnaoqNA+8RP1JX/83bqzMDZazEr5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpcLaiClwSuxkOAXl+gBFKayucoBo99VolJl16oedno=;
 b=C/4k/lOmQC+vScSY+/qpqKTQ8cHFFV+YIWlVMku3kKKG5txUrDTBPpFEOQ8gViAHAzx1vLYhZ048+cxr4ZoRGxR88G7JtSOU79D4wa6hqOdzWCRgKf4AWTbYCikweZ0Wcz5tLfKD4Sj1jElw90ZM1CKP8rJZZqDl/R4X0aJL8V0SETOlhEGZW0U0imniAMY7QDBKVXfJwws7NaTd1qvWUfmEB3iZtFmHYydMgRXiRxKHBnBk47Wfcnc3iPmhDDPnh1M7KKp2i/wFvTrs2f2Fgi8JApuD06wsf04A1iCOIMzsYuv1ex02fcQvC/+Z/85l1JNHXX3XtsHO2eOShJI86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpcLaiClwSuxkOAXl+gBFKayucoBo99VolJl16oedno=;
 b=hx7xSBwwD2412PayW04oshue6OVJrCde/JvC8CDfl+prIJ3euyMmN2nspI0EWp5s7ffEWGxRRS1upthUwvujXN7ZZ/XD1vviv+YQAWtvXiVRY5Tsh+udluLdTYTVki35RnmUpJJ/e8Gc6ZsI1l5OgUTByvdBVd1mO1090cZpCVc=
Received: from DS0PR07MB10492.namprd07.prod.outlook.com (2603:10b6:8:1d2::21)
 by BY5PR07MB7315.namprd07.prod.outlook.com (2603:10b6:a03:200::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 03:55:09 +0000
Received: from DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089]) by DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089%4]) with mapi id 15.20.8678.025; Sun, 27 Apr 2025
 03:55:09 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Hans Zhang
	<hans.zhang@cixtech.com>, Conor Dooley <conor@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Thread-Topic: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Thread-Index:
 AQHbtLTnbnpkizAVsUaczHiSHbV2I7Oy8fOAgAAASoCAALTRsIAA0cGAgAAMcACAAA2jAIACU1Sw
Date: Sun, 27 Apr 2025 03:55:09 +0000
Message-ID:
 <DS0PR07MB10492178596F396BC1A52BE2FA2862@DS0PR07MB10492.namprd07.prod.outlook.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
 <20250424-proposal-decrease-ba384a37efa6@spud>
 <CH2PPF4D26F8E1CB9CA518EE12AFDA8B047A2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250425-drained-flyover-4275720a1f5a@spud>
 <5334e87c-edf3-4dd9-a6d5-265cd279dbdc@cixtech.com>
 <b25406dc-affd-48f2-bccb-48ee01bdfcf1@kernel.org>
In-Reply-To: <b25406dc-affd-48f2-bccb-48ee01bdfcf1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR07MB10492:EE_|BY5PR07MB7315:EE_
x-ms-office365-filtering-correlation-id: 80f394ac-ce38-4ef7-60e7-08dd853f4dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWVvNnJPbE50WE9sb0VCVStidXRHM0JrT0t4YmMvUW9PblhMKzRxUUtoOHFw?=
 =?utf-8?B?MkVabXBqR295ekJMbkxKY2Z0NHVQSFVKM0pzeDdqaGZWS2Frc3JkTW5CTWw0?=
 =?utf-8?B?ZXFteFlOQStYQ05pR0M4NXNIY1ZJK240NGlaeDR3NGM1b05JSEpvdVA3UDNm?=
 =?utf-8?B?R1ZPYStrRkNud0I2ZG1nL2tqeXNFWWpQckRqY3BKRFM2eE9rK2lMOC8rRUtV?=
 =?utf-8?B?ZVZlZE9hWnk2SjFyRC8zSGZ5MDFoQ3F5V1JQak80bi9DRXZ2Y0RLOW9ubXBQ?=
 =?utf-8?B?RUZ5YjJ3ZDFQS0NjbFBlWkdVc1c3T2pGd1BLaW55cmtGTlZ6QTI5SEFQWDJp?=
 =?utf-8?B?MCtGK1RMcWNWZmpqbEhKeDREcTNxMHlWWVphTkUyT3JYcHBrc091aXZjR1BY?=
 =?utf-8?B?ai9FeVNjd1loUXpjSyswcW95cW9IenRIT0hsbmpueWlDMGJOcXQ1YzRkcWNX?=
 =?utf-8?B?dTVoZ2QxWU40MlJxN2d0eld6ZUdPZFN3WGpTM1JpRGhBTkhLd01RVE5xV2ZY?=
 =?utf-8?B?bGhlZ21MdW5QeEVVeXdLYmxNcHkrblFjbUFoazBXVDh3L0t0bG1QN2NTaisx?=
 =?utf-8?B?bEZiZ2llMk1XcWYvRHJ2aDJyY3BYdVc3MnFSejZ5Ti9jY2FENFpVWFFocnZ4?=
 =?utf-8?B?b0FOZlNFQUNnbXlqM3hGWE80RktqcUxaNXpvN1Y0V2UvL1VBbnJYeGxZaDRw?=
 =?utf-8?B?bGk5dmE2eEluUTFoRHZXK1FQNVBoTVNZMHJnWnhTYW1iZlo4Z3ZPTGRJVGpy?=
 =?utf-8?B?ZmxOVytKSHNEWUpSL3BvR3AzMFJVZVgzb2d6TTN4MHc2QnFoNTl3WVBvZmNH?=
 =?utf-8?B?NVpscUF5bG9wNmRUOUw1RVRpVlFvb01BOXdURGlVcmpFbjZpZmM2Sm5yZWN0?=
 =?utf-8?B?czErT3lUTDN4cjd1MnRWYUhRS1lTUlVwYnRSNkR5eU1GSUJkWFpTcUovQmZG?=
 =?utf-8?B?cTlLK1NsZU9zVmViMTZlb2RwR1hySEhXT2dMSGVLbkx6Yndzb2xLNGluVzJT?=
 =?utf-8?B?dFAydTNiN1dBM2pjYmh2VEErK0RyandWbE9SaEpFN0VKdEVHcVcrOGxEV1Fa?=
 =?utf-8?B?QlNuTWNoVG43ckVHQlRUTTNNYUdicTR3RkdOZGd6WXVid1BlYjYySEY0QzZZ?=
 =?utf-8?B?aTRoc2dTUE5sMlF6dTBpWDRmTCsvTmRheURaRFFrd3UxVlpYWTRzMzV6SG9X?=
 =?utf-8?B?RFlIWWRrZkRORHlCS1RNSmlMTUVjSmVUWWRuVktXekpqT3dMOFZ3OXBzb3hP?=
 =?utf-8?B?anRHeGxYdGRZL0dGTnl3c1hnZ2V6KzN0OVA4YmtSYU5KMitqZnJ5ZEc1YThP?=
 =?utf-8?B?VG1ZKzRlRmpuaWxrNnhEcXRwb0JCaU41eVo1NTVJMDZtYjVwNnVvM3VxM2tw?=
 =?utf-8?B?dHEzUitueUt6MFNUWGIwL0NadFM2ZjliSjdScFZLVk9aMXRqeWh2eWZycy9S?=
 =?utf-8?B?emNrU0ZxeHhKYXlpV0NZVm1ibHp3dUFTTHI4QnVqWC9ULyt4aUV6NXpkWGps?=
 =?utf-8?B?NVYrZWI2Zmt3SnNJK2M1Q1dTemM1dWIyditQTHNMeFJmRTJ4c1JINGJzaitr?=
 =?utf-8?B?bXcvQjhpeWpjYU05MGlCdUFFNTdlSndySDIrL2Jxb3N0ejdndHdUYTJHUW5x?=
 =?utf-8?B?QXJUa3EvUUxBOWdCSE1waWhLbHNCdjRJTVlVY1N0Wlo0VWVKMHkvMlkrSHhv?=
 =?utf-8?B?SjR0anVrL1BEZFF4N1M1YS9RWkFsV25wN2JZajhJaytFc2QxSUZoOERCeXVJ?=
 =?utf-8?B?R3pXQzNHMzVNaDhxVHN5YUJDU0VnaGtzcFRsTTNDcnRRSE84eWZYSG4zOWdN?=
 =?utf-8?B?R2JwVStwa21KS2llYkduZmlZNDFEODZRQ1d1OWhjZVBnSnJzQ2NKS0VCL1pS?=
 =?utf-8?B?YzdRMkZtME56cVpHUEpqUTVWeHFhUVR4M2RPZUpZQzQ3THphWWJGbG5ma0Jp?=
 =?utf-8?Q?am7ORXgQaHg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR07MB10492.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDNqZkxRckJaRVNQdGJnUHlNQUEzdnJrbTBxM010ZzdVZXYvbGFGVjZzMTVp?=
 =?utf-8?B?WTUrN0NmejRXQ3NMQlNKZGI4aEI3OTVpY3V4MWZqSHNCalpDcUVGQlIzdjdK?=
 =?utf-8?B?U1NsM3BhaDk1K3Fua0V3cHREOUl1bE9SUFBkNDh2ckpaRHc2aWNrQlBxZWVn?=
 =?utf-8?B?cXhLRHRiSmJuejB5M3QxQTRNUFUraU9PY21pVkUxNjZqczY3a2JFdWpIMm9y?=
 =?utf-8?B?UDVlMktGTlBEaC90eksrQmxCS3BLVEwxN0p0clp3M0lmYWpMSzJ3anh0WEhn?=
 =?utf-8?B?UXVzNG5ZWENvUnZ6bXlFcmw5bXFXdnhRUkdhZVJhYTAwc3RyU0tUUUt0YUcy?=
 =?utf-8?B?L2FnRkxOOEx3SnNPQmpKRDJndUg0N1VvMTIySVRORjlGb0grT2toMHJRNDZU?=
 =?utf-8?B?ZDlSZzFBZGFsU3VHK3hRNDF5SGRLelhqTE5tT2dibi9vTHBjbVJBYjZwTjJJ?=
 =?utf-8?B?UnVzbHZvNHduTkhGNVloSE1ESUpScmZCVXhHK1JIWEZJbjhnbGRKRmZZam9H?=
 =?utf-8?B?UUY3TDlXbFdEMnZhaEYxeTRwSXVCU2luMk1Xd1NPVXRPOXRiUUhJWWd2WG1j?=
 =?utf-8?B?WStSeTdydE8vamkyTFM0d0lEYXdNbnJLR1RxWm1oOFpZL1NWcHRWUXN0bDJN?=
 =?utf-8?B?NndiV2dFOTNzOEdRSnkxeWEzODIrVkM5NGwwV09GUDdBa1Z1ZXNuRHdqb05G?=
 =?utf-8?B?T1ExZ0ZQcEFqdVZvcFl0Yzdvc2V3ZklvVWZwNEQ2b2p3bzZGaXNDRlpXWCtz?=
 =?utf-8?B?aUxsdnBZU04wTlVsSndsT1Y2QWIyNnpmcjJxaDh3NDNIRVJ4Z2RYMC9DMGQr?=
 =?utf-8?B?dU1KSTJ5eVdxTEdnNldOaW1FWUhvV0VhUWdUWFJ3VTBodGE4aWRHM0JTalhI?=
 =?utf-8?B?bDNRa055YXE0TVpvMnRMYmhCSTB6d2JtUkFEYVcydC8vUmZQTDdkOCtkRldw?=
 =?utf-8?B?M1VkQ1BJWWdJV3R3Q1pUZUZvTkVPWENSbmJOSkc0ZFhUMmRFUVF6UFQ1endU?=
 =?utf-8?B?WkM2MVZDL0pTWGUxb3JVY1BTeXFKYjNuVDhKYkNtdG9wRWtZZlBGR3RMb3Uy?=
 =?utf-8?B?UnN0dmxKVko1Unk5L1lmNVJjZFJKTWxBU0hTUnJueEtEdmpsZzRrVU5vdVlt?=
 =?utf-8?B?dHhmSzNKRHhnVVRDYUZnak0vdmxYelF5a0pNQUl6eGordjZkdnA0cjJEOEEz?=
 =?utf-8?B?dzd0c3JOQWZCNjRoQUk3bVBvN1BWd0IvTWVhaXF2cERPSUJZclREQ3Zhb0VE?=
 =?utf-8?B?MWNjMythTmRhY0dUNnB4WWRFR01McXlaUnJoc1FCSzZndTg3MHR5b2hhS1Rt?=
 =?utf-8?B?STgyVlBjWFN6M2xUTVVMQzRRZ2JEZXVkTnQvWi80VGtjR2xmZEgvVEZqMERk?=
 =?utf-8?B?THErVE4zaEpRbll0VnJhZ3VyVXM4R1F6dGRhVXRqTVAvam0yaWJ6NVdVTlhj?=
 =?utf-8?B?Q2pCTWttVGtibDNIbHdWOHErZ1RpcTA3cm5PcGd1YTE0U2JoU3hZZXVlajNL?=
 =?utf-8?B?SU9xbTJhc3h6MWdHZU5DcFdBZHk4OHVRa05zVWg4TjlqdnFVUy9jN3lCVDBO?=
 =?utf-8?B?ZjZzSHc5OG5OMDhpUzFPNEZiNW9BT2NGRnJwZDAydzN3eHprNmVBUjFCYVZr?=
 =?utf-8?B?ZjFiTFpDRWVmTm16ZmF4by9YTEo2VVdoTUwvbytRZTB1Y2U2bkdna29rTERj?=
 =?utf-8?B?TW53NEV3dDlOdml1emlkd1JrRENPZ3E5QU1MUFdjdGt2T1BxcWRsRTRjN3VE?=
 =?utf-8?B?Wk1QZlpITTNwMjZvNVFYeUI4VTl3NmorZlgrdnNjYlNibkpMRy82OHBEWnhS?=
 =?utf-8?B?NGpuNFlVSFgrK2d4KzNjOHlTZFRPNGp4M3JqbENVQ3JDbTBJbVFPMktlaTdN?=
 =?utf-8?B?OVVQbG5PdVAxcmxhWlg4dTBhblRab1VUY25KSXBRVWhLaG1JNlFCSWdaTTZp?=
 =?utf-8?B?V09TWHFFZ3hTTTI1V1A4bnFSMkx4aVpzVlVDeXNKMkl6bm5JN1Y1QUhTL3JQ?=
 =?utf-8?B?L2dUUEtpVUp0VnZtRVpkSlYyZGZVYTI4aFdTMkY3eVNyTDZKZTdkUEhzZ3RI?=
 =?utf-8?B?MjlDeldMSy9XeFBhRDM5QzMrbGljbDhpVHpzMVNDR1hmZGN4MExkN1hCeDdy?=
 =?utf-8?Q?zRSmQhDaPoCsaqXYy/OCa+aav?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR07MB10492.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f394ac-ce38-4ef7-60e7-08dd853f4dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 03:55:09.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmvuZKfkZvLRm4akOsjMhqaBCLuPl4CvxUrvfLLLKwWilBsp0qcIFtR9jOuIua9pWkUNmwBGRz8y794Qy6/gBwFEPPhKMXeyjiUtMBgqppE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7315
X-Proofpoint-GUID: L1Z-MBED6Sr4uMnNUdH8q3AV_tc4Em4O
X-Authority-Analysis: v=2.4 cv=SJdCVPvH c=1 sm=1 tr=0 ts=680daaa0 cx=c_pps a=K1+iGLXgNHoxMcL4Lb8acQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=fYCADaaoBEINb0ixi1kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L1Z-MBED6Sr4uMnNUdH8q3AV_tc4Em4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDAyOCBTYWx0ZWRfXxo9Z8yqfKwzs iuRVSJDNzYFYUORQV6XyvFjVgm4Jkt9gzxyw2DG9BfcNsO9/64Q1k+DS/iyut8j2FmNBkrMDpSW eNZJH/lLJuAvPna2crXZaS5WI6JC2vNJpX44UuMO5OihYag5LCj/7JWhkV430xq5AyAWNBf+V92
 OAOJBfy1C06GP/rYRY0od5uucvB33Dm3ax5FvIuv9vuwNdKYLqj9MYxPdiHlv6s0bHJCvp1PqxT VotZn76chDORr1tfwLMrvrTkLgNf9gTVVxvNmZxeVf+0k7dAxXfa7hB66op8SxWCzieDxxYjfbz OtaEz/G/Ahx2dko95eMPW289GyqRtVAZ0B/OByOHbPQMe4QwGnV7/GgK8R2BUO75Ve31UXYsHcv
 qvCV/RWaIt2f/CZ4DwuCVusCVY8t/8EN21NvpA8UcS3krWjnxFEHJcGZjNhIyLnY0Am42bP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504270028

d29yay4NCj4+Pj4+Pg0KPj4+Pj4+IFNhbWUgYXBwbGllcyB0byB0aGUgb3RoZXIgYmluZGluZyBw
YXRjaC4NCj4+Pj4+IEFkZGl0aW9uYWxseSwgc2luY2UgdGhpcyBJUCBpcyBsaWtlbHkgaW4gdXNl
IG9uIHlvdXIgc2t5MSBTb0MsIHdoeSBpcyBhDQo+Pj4+PiBzb2Mtc3BlY2lmaWMgY29tcGF0aWJs
ZSBmb3IgeW91ciBpbnRlZ3JhdGlvbiBub3QgbmVlZGVkPw0KPj4+Pj4NCj4+Pj4gVGhlIHNreTEg
U29DIHN1cHBvcnQgcGF0Y2hlcyB3aWxsIGJlIGRldmVsb3BlZCBhbmQgc3VibWl0dGVkIGJ5IHRo
ZQ0KPlNreTENCj4+Pj4gdGVhbSBzZXBhcmF0ZWx5Lg0KPj4+IFdoeT8gQ2l4dGVjaCBzZW50IHRo
aXMgcGF0Y2hzZXQsIHRoZXkgc2hvdWxkIHNlbmQgaXQgd2l0aCB0aGVpciB1c2VyLg0KPj4NCj4+
IEhpIENvbm9yLA0KPj4NCj4+IFBsZWFzZSBsb29rIGF0IHRoZSBjb21tdW5pY2F0aW9uIGhpc3Rv
cnkgb2YgdGhpcyB3ZWJzaXRlLg0KPj4NCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+cGNpL3BhdGNoL0NI
MlBQRjREMjZGOEUxQzFDQkQyQTg2NkM1OUFBNTVDRDdBQTJBMTJAQ0gyUFBGNEQyNkYNCj44RTFD
Lm5hbXByZDA3LnByb2Qub3V0bG9vay5jb20vX187ISFFSHNjbVMxeWdpVTFsQSFHaC0NCj5VZXlU
YmJyMlIzb2NXV2E0UVpITV9HWUJSWHdzN2E1emMzbFp2U3lfWFlWQ2tjZzhtbWVFYUFXUzR3RXZJ
DQo+U01WMnRHQ0V5bEUkDQo+DQo+QW5kIGluIHRoYXQgdGhyZWFkIEkgYXNrZWQgZm9yIFNvYyBz
cGVjaWZpYyBjb21wYXRpYmxlLiBNb3JlIHRoYW4gb25jZS4NCj5Db25vciBhc2tzIGFnYWluLg0K
Pg0KPkkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIGFuc3dlcnMgYXQgYWxsLg0KDQpUaGUgY3VycmVu
dCBzdXBwb3J0IGlzIGZvciB0aGUgSVAgZnJvbSBDYWRlbmNlLiAgVGhlcmUgY2FuIGJlIG11bHRp
cGxlIFNvQyBkZXZlbG9wZWQgYmFzZWQgb24gdGhpcyBJUCBhbmQgaXQgaXMgZm9yDQp0aGUgU29D
IGNvbXBhbmllcyB0byBidWlsZCBpbiBzdXBwb3J0IGFzIGFuZCB3aGVuIHRoZSBTb0Mgc3VwcG9y
dCBuZWVkcyB0byBiZSBhdmFpbGFibGUuDQoNClNpbmNlIHRoZSBDSVggU29DIGlzIGF2YWlsYWJs
ZSwgaXQgY2FuIGJlIHNlbmQgdG9nZXRoZXIgd2l0aCB0aGlzIHBhdGNoLiANCkhvd2V2ZXIsIEkg
ZG8gbm90IHVuZGVyc3RhbmQgdGhlIG5lZWQgZm9yICBjbHViYmluZyB0aGVzZSBpbiBhIHNpbmds
ZSBwYXRjaC4NCg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg==

