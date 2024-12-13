Return-Path: <linux-pci+bounces-18363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9269F083B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B70A281AF2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61B1B3932;
	Fri, 13 Dec 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EnB5xVxn"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537611B21A6
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082940; cv=fail; b=omwaNpvQBbvP35YyXluV2517qBjBjUnJ6K4RZpDGKRbVL2L4hqhOdARduVenKMpLDXbjA6nvyfn/3WL25ZhEJXcEutenmP34TuqAhI3JxnDUSK7IuxYcWLZ6I6u7WNObtdcA14hnDN93SDytNKq/CqInuUe7/7V5x6NoBiuTgzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082940; c=relaxed/simple;
	bh=Sdr/Mda88p+wBX5hha8z/26vmuRatIqfxkkJ46wycS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMy2WtXvpsf0VC/24x8DWdjt/tIWzDzTf24qJRR4ps2o9RYnMcb1DwIDNNQCAKMj2eRiYBioQXG4Ya544mJPe56fdQUlbnQCwRzH53pSlHlJmVhPKDTn/y4w3fDMyFATHlFDJMNrozlL9ZEFwS31IYNnvcirg6CrVnlHCDEcKGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EnB5xVxn; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1734082939; x=1765618939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sdr/Mda88p+wBX5hha8z/26vmuRatIqfxkkJ46wycS8=;
  b=EnB5xVxnvQjNHCr94lerfg/EPO+z1PxfGtgWrJjia6zjo1fo2ctN2ig/
   WDFMuPCNmYnqo48gpS9fN9ZY2PL3ksWut1oH/e2DsT+eJYFrjcHW2ijfn
   t36tVrAE67HYgbjaQsvS7NtnUsMyUuqS1BhrPe3k+nvev18PkefzrZXSi
   J4rhBGHwulH5ULf816BpngkNBf1x1FS49VuQCCgSRP1RAAEfzXZMWtHN+
   lQJu8hfNEqC1WpU4w88sMzjpE0G320OxpI84RTcE+JoUlkAotGsgwOLy1
   sJQEi0dn+iqcq8H6qi01t1DRQ9zEGHTg/ZGmX9UL61TWQDpRF9zBPYXTQ
   w==;
X-CSE-ConnectionGUID: bgJBaJZwTwuj9HSR6H2k3g==
X-CSE-MsgGUID: CGHcRrpSSOGRtW0BXdvfRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="140064209"
X-IronPort-AV: E=Sophos;i="6.12,230,1728918000"; 
   d="scan'208";a="140064209"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 18:41:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpvMCW9y2AGaxX+VdqXaZn0oFL/BozwWu9SREvai7CRc/lBuigiKWjq6Sn7bTlj9xVA7JQc4rPdT88gjqE5atUgr5B0HzRTpWdlNMxKbG7VxzDwIO55T4aTrlinluC+KOb4tktRXgIHLHRu7bnQRBGPckTcU1x1G7aTdw7/QB1qBHXuSanb1wt5Um2obchSYfq6cJz71QccqVxu9dSJb036quOtOutOs/qeSsZBP7R8tzGqivhRUxq12Dy34brVJLsGzQutm9rfP3/SkcLfL8Y4JYKZC8PxUKLAb/epKPmprpbp8wyaLVcZQhdxzqc4Jptsw35cel8v4oezBSeL7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSM6PgHrYh0RGgGJH7U1uiOkTgMlPo11x3xRGdXJrV4=;
 b=wJX4kQZANtSZeiVznCqd9j6K/SfFxuyirjR7Qh8omMK933ShnWaUubn/rhkbEf1x45lK7LfrcVSRgWwasDMR1XDW4M4VRGJ5IGvHErmaJS5tpye0lmDCkv6czbODu2zsGpIB6wwhrF1ta1YMMJsRwrMPReh3QVGKNs87YaTXtJKzJPEoZoNy29GNrNCbJ3lkYkIL5z5maesFLWvhnfQ1JVZdTFsra12rI3b8kJnnaDJ1PxMIISAb0b3Jqxp0ManwWQhK6TT4yRrih1At57TPrMJ5Vn8dSUlgN460EZ28DRWaYFVNyp4h/wVAptX1ejafoXgWBu1RpEbDJgQq+B6tFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYWPR01MB7210.jpnprd01.prod.outlook.com (2603:1096:400:c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 09:41:03 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 09:41:03 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@huawei.com>
CC: "kw@linux.com" <kw@linux.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Thread-Topic: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Thread-Index: AQHbSrk6gqHOLc5m2EOlUHrscD022rLhUvMAgAD2PnCAAElmAIABWxow
Date: Fri, 13 Dec 2024 09:41:03 +0000
Message-ID:
 <OSAPR01MB71829A3B55E61A78E8CC10E0BA382@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
	<20241210040826.11402-3-kobayashi.da-06@fujitsu.com>
	<20241211174334.00002adc@huawei.com>
	<OSAPR01MB7182A97AD0B536DD214BCDEABA3F2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <20241212124736.00002d04@huawei.com>
In-Reply-To: <20241212124736.00002d04@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=edecf0f8-b404-48f6-9c90-282d770cac05;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-12-13T09:39:59Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYWPR01MB7210:EE_
x-ms-office365-filtering-correlation-id: 814e86aa-a485-4339-933d-08dd1b5a42c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OExGclpyZGtCTDZaV0dJZm1FeTFxMXlYR3M2bjNtaWdPQ05vWnNWdUVO?=
 =?iso-2022-jp?B?WmZmUUlUdHRhc0QxbXFWYUx3dkZabzdRTUo1UHRTQ0NCWFFKQlZzR3lD?=
 =?iso-2022-jp?B?WDBaUVpLYXg2Z01ReldaRlBoOHNqNWgvbVNqMW9DMEZKOXdwS3Q5dFla?=
 =?iso-2022-jp?B?SUR5ZlY0bHJ1MGN0NEZTTXBPTnZ3RXJoNXJSKzVWMU5SK3BSNFJFYnhs?=
 =?iso-2022-jp?B?czFSNFlHZlpCQ09TbnJBVXZSWi8ySDZtMFpiUnNoU3ZJY0NiU2NSNWVs?=
 =?iso-2022-jp?B?STgya25nZVREN2pidnFOZ0NIbzRGZE9PSFR4em42SlNZWUZRcWhMSUhP?=
 =?iso-2022-jp?B?QzVXOStmRml3ckI5bzA2L3NyVG1mVG9nTHJ3a0xaR1lFbkVYTDIxQWhv?=
 =?iso-2022-jp?B?YVNvekh6WXFrSk9mMEYzMzUyMVp0Ym1GUExDcHNNYTUvRStEUDEwNjZ2?=
 =?iso-2022-jp?B?UzNLank1SWVlVzBJc2R0YzR6T3lnL2phV0s5QnFoeUx6Z3VoK0pKdGZL?=
 =?iso-2022-jp?B?VWswWHdMQ1A2Q1Y2bktndjN1ZDZLSlBwL3FqYnVobjNUTlpLdkNRbHpN?=
 =?iso-2022-jp?B?SFlyeTFOMG1VVWRsMnpCc2ZRMmdOQmxRM016SVpLbk12RTlwKzY5WDAr?=
 =?iso-2022-jp?B?a1UwRVlUampmZ20wTFN6dmRUSnYydDJ5SDN5aVlpYnN1YXUwVGdabmRq?=
 =?iso-2022-jp?B?YjNEU3o0QmhwenRIRm1tSnowb1MzTnZzMmpiTkdLZlNFZTRJeHpJcnZk?=
 =?iso-2022-jp?B?Y0ljVSsrb1oxaFlVM3FwOHp6S05WWmtoNFlUc2lUdkFERnJHWUNjQlVx?=
 =?iso-2022-jp?B?d3VDL2NvbU5hTTVwVXVnK3F4L09Gc1F3UU5BU0Vyc2plS29LdFFkSnkw?=
 =?iso-2022-jp?B?UExPOE9tNThKdVkvalhEUGl0OUtVQnk1eFBwTGNlWmRLNHZJRmlqZ0Rr?=
 =?iso-2022-jp?B?RWk2c0ZHaW5UdmdtZCs0WmRpK3gyeFY2MkNZRUM5NFBrUTRQNHZ4QjNw?=
 =?iso-2022-jp?B?WmlQYmFDT05hS1ppTUdnakcvWThoaEI5cTVyOTYrSWVadWcwL2VyQUFT?=
 =?iso-2022-jp?B?d1UvOE1FL09ZUjBXZENIb1hZSFFhQzZsc2gxakkzRER2d2lKT3RsUFlS?=
 =?iso-2022-jp?B?K2xYS3lCVm01cDArRWZQMTZ0ZjJDZkdYL3AwK2I3UXJaSzB1anpKK2di?=
 =?iso-2022-jp?B?eEQ3bFQ4c2ZVSVJFR1dwdDh2cVVVNnd4cHY4RGxPUVhwc0FnbmZRRm5P?=
 =?iso-2022-jp?B?RWNsZGdxVkhuM3lhTXdMVEppZHFiL1NoUTZVc2o1K0hFMW1kbnZlbkt6?=
 =?iso-2022-jp?B?ckhGZWR4Z3VjOFJiajM5OTBZK0VQcHc1eVVEUklyTWFFN3VLZDk2b2lE?=
 =?iso-2022-jp?B?a1J4OTBIUFd3dkZBNFpIVE9WTGJ4NEpxemFtSW9zcG9ibEJpbjNpUkFp?=
 =?iso-2022-jp?B?TDJtanhoRFJ5SHdocVBxeGdrU2FoQTZ1MHJBUGQ3eVNJd2VEZTRYQTNa?=
 =?iso-2022-jp?B?ZmYxbXpsN0RzV0QxMytxeXpwVkNXVkMvN2wyYTcvZ1JyamROQjRQcExN?=
 =?iso-2022-jp?B?L0xEaUJzR2k0RlZBT2xsYXQ1MWVURmppOXhwbEY4U2syTThSZHFKZ3d2?=
 =?iso-2022-jp?B?N2ZjVkdPc1dCbCt1UzFUdnEwdm83VmExdWNTOXVpc2IyWVZXdWN6MzND?=
 =?iso-2022-jp?B?ZUhIMDNNM0diZXEzb08rZEtxWVdoR2pEaitOekpkUmlLM3ZDSDY5VjNp?=
 =?iso-2022-jp?B?dUZQMDB4SUZnZTZ6RDF0dHlRWklLd1RjUTVsOThnb2xRbXN2RS9PMGlN?=
 =?iso-2022-jp?B?YkRwNmVkMnR4ZXB0NDlXWVdINFU0cVMzZTQ5NEVTK3lKeHhhN01zMnhr?=
 =?iso-2022-jp?B?UndHZCswSHlYMElBQ3A2S3pXYXZTckNuTTdKUStuUHlpR1NBeTZlRmlC?=
 =?iso-2022-jp?B?WFdLdVpEeGVRUi9keDhJRkF0UGhDVTJLQjhubE5MTlAvZ2djYjFNOGRp?=
 =?iso-2022-jp?B?MXlZTDJ2UklTWjlvakJnY1FzNWtPR2E3bGFTdmo3Q05OMTcwaUNYNjA5?=
 =?iso-2022-jp?B?RTRqZ3V4UGtxdk9iNTNHbFUrNlVna0FOdk5XODdjOEtVbkVBNTA4T3ZE?=
 =?iso-2022-jp?B?UUg=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MytwTWh5ZXErM1djYUVObVROdEZNTWdqRHZTcld1ZnhBN1huN0NuRFNs?=
 =?iso-2022-jp?B?TFFNcXR3SFp1V0Z1YSs0aXJ5aGJoTWwrTWFPWkNrK0U2MkJ1bDBLbzc3?=
 =?iso-2022-jp?B?ZVhKTWpNYVQ1Y3pQU1FzOUVYaEt6T25SaXNDOEh3a3ZOdHJxK3JuUHov?=
 =?iso-2022-jp?B?dnM1R0Y1K2diTm9ZeTNkRHJaRk4xU092MTFoMndhYlNmLzg0R0RXZWRy?=
 =?iso-2022-jp?B?T051NThPMWNaSjFoZ0Q1RDhrWHpUUzZzVkJabExhU3hjb0RiRFh6UHN0?=
 =?iso-2022-jp?B?d3VTUnJwTU4xR2s5em5rTVRYczNJZGpVYUxBNTVnVXk3a0Y1ZXV1TTBi?=
 =?iso-2022-jp?B?RmhSbnhWdmtrMnIrZ0Q5Z1VJcVI2SHExWWFuMlZEZGx2MFMyK3dKY0RV?=
 =?iso-2022-jp?B?ZkZJUXVxMEJOU2dqejI2aXZXYXc2U3BuMEVUUnVDejdrcE8weEVFWXhG?=
 =?iso-2022-jp?B?VjIxaDFmMUY1cDRPdllidGQxd25qazdSQWt4MExzMkY2OTdTeWpxTmVz?=
 =?iso-2022-jp?B?SnZpeVN6dTBEWEtvVENkZy9GOXFPdUhhTUJvdlVHMm9IUFFmKzhvNzRP?=
 =?iso-2022-jp?B?bWJuZHdFMTF4aW5YOFpEbEp1YVFNZmNIL0d1Y1Z5V2VUREJvMHQxc3BP?=
 =?iso-2022-jp?B?R3RoYjAwa2lKMjVrdUNIbDNvZHhXSGxOai8vaEtUTzhKQU9Rdmt5a09I?=
 =?iso-2022-jp?B?bUxyOUpQM0htQW50Y04zaGIxSlBSS0IwNFZiRmY5cHQwWkxUaXduSi9k?=
 =?iso-2022-jp?B?OHh3RFNpTGd1aTk4UitmS0E2enkrZW9NZU1JVXdwZjB5VStualYxbkFY?=
 =?iso-2022-jp?B?RnJLVnp1OStPR2ZTckZEelNvYm42ZUd2MWs5c2RkMW0wY2o0QSt0a3hU?=
 =?iso-2022-jp?B?c2FId1VRTll0VFJCTDlIS3Q2RXRxV0VYOWJlZTZTbXJXM3Z5YTAwb3RO?=
 =?iso-2022-jp?B?ZGxRTDVNZjJ0cVNCWnl6WTUxTDQ2VXA2M2xMRVRaY01qUk00aUVrTXhS?=
 =?iso-2022-jp?B?ZGIyTmVmS2tvbFZiVHlqSVlaRHN1cjRLU1N6Y0RCbTdRdWoyanU3RklO?=
 =?iso-2022-jp?B?RE5JeFdOZERJOW52VGhkaHUrVERBNlFMc1AyRmNSbUFQL1JrY2JrdVAr?=
 =?iso-2022-jp?B?UFdmSjdkSnRWTnRRYXBSdTZnR1l4YXk1TTg0VkxHdW9IT2Vtb01rNERn?=
 =?iso-2022-jp?B?N3dyQVBDMDNUdlQ2a25uMzZVejF5aEVkM09vbWdVbGFHQStKSzRvR1ZI?=
 =?iso-2022-jp?B?SExlWVdiN0NtVGFvWHFHK2E2K1BjVkhUR0xpNWh3VXMrSlBIQW5rT1E3?=
 =?iso-2022-jp?B?Q2syTVMreThTbFZlTkZBcm52QlZlMm1WQnVKaXd3cWFRWm90ZHFoU0My?=
 =?iso-2022-jp?B?Y3hQRlpzZGt6T2J4dlVlQUJQZEhlQ2NwZm55MVRtd0pPYTlmL2pDUFYr?=
 =?iso-2022-jp?B?ZFRJMWdqbi90SWRxUC9BT3Q5SktyaVY5NEJtNVAvMGVGYnR0cVhrTElu?=
 =?iso-2022-jp?B?emdkckhOdFNISlQ1L3pxSmQ5akpTbVllQWg0akhOaFRjbjgxenpuREhG?=
 =?iso-2022-jp?B?dFE3T0JJNG81ZW9NY2c1LzcrTDl3TlRpWnJoaS9ZV2g3dG1QKzNTTzlK?=
 =?iso-2022-jp?B?RkNybWJpdEZGWHBKMXcvRHIvSFY3YXFVVlF0ZlVLSitKYitiM2h3UThK?=
 =?iso-2022-jp?B?NWYyMDhLOStOdTlrbGtXaEZPcHQxY2NCU2hoYndSY2UrdVgvSFZWTFQx?=
 =?iso-2022-jp?B?U0hxTTBqTk9wWU8rVUVUNFd5NFJLQWhySU0zb2xaYmRpMXRhb3dMaTdj?=
 =?iso-2022-jp?B?eTlYNDdTTjJBc1NCc1M3NHhZZHpqQVNRUnl6d1liU3NoWVQyNEpBSFdm?=
 =?iso-2022-jp?B?Q1JoeXZqRS9keDY2M3pUZlZHRllHbklOYXEzaWQwVzZvcDhvT0NJQzc2?=
 =?iso-2022-jp?B?ZXZzaE5FNWhZODA5UWFlVHNFYWlzeVQ4OTUwdjh1UGlpZVVjUi9xT2tq?=
 =?iso-2022-jp?B?Z0FsTUFQUlZ3K0lyR3FFamV6N1dXNmR2TVNCVkx3TTZVM2FacUxzalBI?=
 =?iso-2022-jp?B?RzRyb05JZ2JzR2R1dlJnaTNONUUzQUVRSTRiREtnQmZFVG1OTDQrdk1H?=
 =?iso-2022-jp?B?NmNSd2Zpb3ZhOUNXbktjT1lDcmJYYkI5LzR0a3Z4L2IvMmNvOUExclV5?=
 =?iso-2022-jp?B?YmtwLzFSZFhIL0c0d0ZXbjRDclhWV05YSUczZnBzTGtUUXZ6ZHFxdXJa?=
 =?iso-2022-jp?B?UlRDaUZ3eWM4TnhBMUQySlBZYnB2c2p6SEZGZHAvREUvam9oNVFpaFJh?=
 =?iso-2022-jp?B?MFp2YS9GRUc1QlY2azNOZHhGNnRsOWsvTVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SeHmvOgOoAAFokkJgrNGXWmJu/Vm1DA/x6BqgTz5kqdwXQplEhYJHMULkfodjD9LKVtd0bpaXHcu7bJ1BQlDxgELsN49EqCWrKX3Z7Onc9FHbt9SQmPa7UEkK4WlRxGSV1UaRr1RuM/6S6mfoKbzu5+xMC4otiefQ97VDLKO67GSNHmV6Yzez3dRwa3UPmXyJ4yUqvJOyOAR/HxMAT1D1t+OKPd3uQ8UZnn+dG2PmXs1JixoQrNLKS0DTIWcWnKnHLxn2CxkWxM6FIDMQocmbvwdNMB6NHPHwaoR/uJiD64BDmFiJKu293cWkGs4WlLTXb0Q/ZfNPOete2TqXsNIOG8BK6f9FYPJt83b4+fBoclwshPwlXtEgxb564NTkzZRLlcU6tA9iympgGR6sVzY1faCJsl7ABenCA4HMSuSgq1j5yrE2/RFicYpJrga2Y3R0xYCLTA+6k/eAWFAGdF1mTlFu1fA61IiCRgp4cUcW0JvZ/tvs+0iPgdzxfT2TrlkJ681a9WZml1gxhFHLv7IDDkaldFzQdK7W0izwN73fDAa4z5+8C8J/fjZ8U0rjIOPDPY3RN072zVhLHd8/MAEBYFPLd2Yvo3yVANWspnc36rlQTz5jhoCaBaE/ZiGp3Vl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814e86aa-a485-4339-933d-08dd1b5a42c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 09:41:03.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNlB0Bj1Te7lSRmsf/BSkbuAR9roT24PkZ5vlL8dcVBKYoDjXP0+2WXqFYsg3bQc0Ugl4ABvLD3fp5+VoGyr70/EFOI/kN6Zhljur7jtjmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7210

Thank you for your detailed feedback and suggestions. Based on your comment=
s,
I have a few thoughts and questions to ensure we move forward effectively.

Jonathan Cameron wrote:
> On Thu, 12 Dec 2024 09:08:54 +0000
> "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com> wrote:
>=20
> > Jonathan Cameron wrote:
> > > On Tue, 10 Dec 2024 13:08:21 +0900
> > > "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

... snip ...
> > Regarding your proposed file structure:
> >
> > budget0_power
> > budget0_pm_state
> > ...
> > budget1_power
> > budget1_pm_state
> > ...
> > budget2_xxx
> > ...
> >
> > Is this the correct format?
>=20
> Yes. That is what I had mind.
>=20

Thanks, I see.

> >
> > In my understanding, implementing this would require 256 attributes
> > corresponding to the DataSelectRegister, which seems overly redundant.
> > Additionally, I was concerned about the mechanism of changing the
> DataSelectRegister each time a file is read.
>=20
> I agree it is quite a large number of files, but there are larger sysfs i=
nterfaces so
> I'm not that concerned. Do you have any data on how many entries are typi=
cally
> used?
> We could use an is_visible() callback and register all 256, or we could d=
o
> dynamic allocation though that would require walking to find out what is =
there.
>=20
> The implementation should cache the current dataselectregister value and =
only
> write it if the value needs to change.  Sensible userspace software would=
 just
> read all the elements of each budgetX_* before moving on to the next one.
>=20

Unfortunately, I don't have specific data on the typical number of entries =
used.
However, I estimate that it would be within 10 at most.
Could you please provide examples of large sysfs interfaces and where they =
are
implemented? I would like to refer to them for implementation.
In pci-sysfs.c, there is an attribute called resourceX_resize, and I believ=
e its basic
concept could be useful. However, the PowerBudget implementation is more co=
mplex
because it involves multiple sysfs outputs for each index.
If there are more reference implementations, I could propose a more mature =
implementation.

> >
> > Therefore, I proposed this patch implementation, even though it might n=
ot be
> ideal.
> >
> > If you have a suitable implementation to achieve your proposed
> > structure, I would greatly appreciate it if you could share it.
> >
> > Upon further reflection, the issue of needing to change the
> > DataSelectRegister could potentially be avoided by initially retrieving=
 and
> storing the register values for all indices.
>=20
> Cacheing these is definitely an option to explore.  I'm not sure we would=
 want
> to pay that cost at boot, but if not we could do it on first touch.  The =
0 value is
> reserved anyway so if cached copy is 0, read it from the device and fill =
the
> cache.
> We would need to read some at boot to figure out which should be visible,=
 but
> that would be logN of max entries at worse, rather than all 256.  If ther=
e are only
> a few it would make sense to just read them all at boot.
>=20
Although the exact number of indices is uncertain, I believe it is sufficie=
ntly small.=20
Therefore, I plan to adopt a method where all values are read and cached at=
 boot time.=20
I intend to create an array in the struct pci_dev and initialize it in the =
probe function.
If there are any other suitable places or methods, please let me know.

> Annoying there isn't a count register for these!

I also feel that. Thank you.
>=20
> Jonathan
>=20
>=20
>=20
>=20
> >
> > Thank you for pointing out the coding style issue, I'll fix it in the n=
ext patch.
> >
> > > >
> > > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
... snip ...

