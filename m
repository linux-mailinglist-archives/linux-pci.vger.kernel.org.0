Return-Path: <linux-pci+bounces-16858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F99CDC42
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3074EB21A0F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662611922FB;
	Fri, 15 Nov 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="THEvGDfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EA188012;
	Fri, 15 Nov 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665659; cv=fail; b=Sbk9DoRhdTgBD3VNKd6POZYe7sXu7YZnrcPfeZCHwNHIgPxcXdV1QCIq3pVLhJfoJzYa+IZPlrlK1VsHQgDNHqzVKDqFwm+ie1/DflsC57TYTfj8t4qjSb+YH7HIOHhLq/1yAr8KpEPaA8vlNYJu4EpSZ1CttWjIR5Wy2DucYxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665659; c=relaxed/simple;
	bh=oNm70xN2+qhgl3NibnNw6S6fNNRr/jKl+WeoRn4o8WI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kytt0XDHos8GF5Qj0qOooABXBdXZAXWnUIpKUhNUnDTgRtn3OOODCCwtW2BwDD8Zk1Lm0NSCPXq/iTC48CtLz1bI199J45aLHbi5GUbeiwDod0fR5glDHa39GFiE8Uu8tS2dfcMUet7y1MjgrhllT86UYwjOY1+ImI/HovOxXvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=THEvGDfQ; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCOtxtAl9eAeGHJV5iFWGQLM7Vx2qiSlpuo82COlb/AKr26GWMTfJijwa2I8jBniZD4bJ8WrBKbS/HfEevBkfFtO/ls8KbRWBcuPz99t0g78M5ptJJ/IekDDnTuW7dmNyMIWLgtTVzaO60TSveYtNnpTxnS6l5AOrNzaCOzyEXatwk9JoQSiabKAVmIyQjnX2/72NWwEzy5KlxcqE3wdrSeN6VEtufCK0emKOSn7ENyjXiGN9EKuiyHkqWfQKuxsG2EcdyLU7kXeoO4x/9ttp/buJGHokBn/QMITVCHW6lx2d2wuVVe95x4O4q5dkfX3bMvJrebc4rzAFWEko0I+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNm70xN2+qhgl3NibnNw6S6fNNRr/jKl+WeoRn4o8WI=;
 b=FOfd9G+cuhSADgAw7W4d3T/fXHNuhngb3Z1UxiuYIOAdHOLj5wLKE4fk+da99iOp3oAgqZeouLwFfnEEGNQ+f/9zmSv3ihoMkybx2rex6yooT6gKmgYPWsohACIh2i9wKvbbl4B87gOGGwsAETVdCqUgwC/eioE0HfTfWmtiDNS9vcwPiwlm0Oisyyg1b/KzzhSZsgBS1UukKROEN5rlmOIBgHb1r4HJc7HEZo0D5Hibaf3qMZR1JpbvoeoTiGM1CHWEVyIob8Ui14iY9bv6+Zz7vWX797tCh73IlXoWnZA+NuBS+z1aJyb/p8nGCn+tuUum2OEkvx6xt7UvUnIeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNm70xN2+qhgl3NibnNw6S6fNNRr/jKl+WeoRn4o8WI=;
 b=THEvGDfQ52GnVw6pOPviwEuJZvtatAwc60HMuoqrvVRN64Mj8ar81r9kCr6a9Lp+4pVtfc7SCFPfzN+oDM8UGA4dzvbh++giDMZlFgz/Lt3u65a4Haw4/SXtQNWGY4JrW9ioC4LpG5RYKawpDIBTLsO/BEaT/CDWT7KLpe9Hxr/Iy6yVdX6fYpmZ4mChVO730dXhfIm6/t9G9pvzT24GvTOIY3v+/b3lYzNWFb0X3m555z8TtOr5dwOHFFOc7SqAxDAkByFkM1kvsHP0hLbsU1EjG8a43v9P5frmWZneOjgNnVF2OEWFWcvn9LIVfLANCpgh22Zp+7xMy9COoWFHwg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9095.eurprd04.prod.outlook.com (2603:10a6:20b:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 10:14:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:14:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>, "open list:PCI DRIVER FOR
 GENERIC OF HOSTS" <linux-pci@vger.kernel.org>, "moderated list:PCI DRIVER FOR
 GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Thread-Topic: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Thread-Index: AQHbKRSCN/VpEf5rbEi+oy6xsbFNiLK3+qmAgAA/R7A=
Date: Fri, 15 Nov 2024 10:14:10 +0000
Message-ID:
 <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
In-Reply-To: <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB9095:EE_
x-ms-office365-filtering-correlation-id: 44e54452-f14d-4a49-1292-08dd055e3fa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S29adE9DS3VVUCtpTnpJME40bE9wNzJMTi9YV1B5SEVseFBqeFo0eFh6TFFw?=
 =?utf-8?B?bmk3ai9GQjB3L0ZtRWFmV2lJUUFxUnRPUVFuVno1cmhmZHRCUzcvaFFIampi?=
 =?utf-8?B?M3JQSGkvTWNTdTc0S0ZlVjRkcW9wZFQwUWw3dVVIblBRNG1VVWhxdHRNMVVn?=
 =?utf-8?B?eVJFRjBSR2FqYlJhbEg4UUttL0RGblVRRy9RTEwwM1pZV29Gbk5aRWw2ZHVS?=
 =?utf-8?B?R3NSTXgyazVPd1g3STlnWEJFcFZIclQ1VjA1aWxsY3NOWTNaSjUxUDNtZ3R4?=
 =?utf-8?B?OG1UMzBNaXZMWHBSQStxUUJ5dFRGaHg5OWJocmVXWTRyQmZoS3NNa3dNbjBi?=
 =?utf-8?B?SitBazhKS0ZSS09zKzdGcnI0djhBTlhwQ3hJZC9PRjlLakoxWDNTWXlCRC90?=
 =?utf-8?B?WmYvV0I4NnZINzd2QWZJYmpiTXFrU2twOHhSMTRMWEFLQjRVWkJhbms1TnVq?=
 =?utf-8?B?bm1UZUw0d05pbmhKeklQdWVzNlNBUDl4aU1zWUZTc0M1eHNRcFpSODdOeENn?=
 =?utf-8?B?RHl5Y0wvdXpFQklvYmE2WXhZVWNjU01mQW8xRHBBS1FmNWppanoxd2l3WGxq?=
 =?utf-8?B?TnZhMnNWZmowRlRlNUwrNENPcEI3eWlqbGsxNmZNc1Q2cVFUMlhwd0g3cFpO?=
 =?utf-8?B?TUhZdGdWOXlWMVk0RlVXMzZpTkZ2aHlLcXZsUUlKZmQ5c3czeGxTdVN4dSs5?=
 =?utf-8?B?TFJhdjNwYnZQVitCaG0xc1J4Y1pvVWM5R29OYm0rbFRGK3hta3R4MlBUajNJ?=
 =?utf-8?B?TDVtdkIvOVJyZDNhckIwOE03QnBTY1ZESFQwVStzZXNxUjZTQjVMN25lWHJv?=
 =?utf-8?B?Y1l1bk1WZElXbk90cUh1UjJ2OXREdGtSQ250SWFjOXFrRnBPdTNDQ3VHcm1F?=
 =?utf-8?B?a0RCb2dpZ0dGNm5qODFJbTdUMUVraFNVTWg4dy9YQ0dnTk9QZzlIZ2ZVdGtN?=
 =?utf-8?B?RGdZMnNiRWsrOHpmN3FJcDB2Snd5aW9WMGJmMWlVOGp2dXRKeHFUanhYTlBp?=
 =?utf-8?B?dW9XOVhDeHFxMFRzcjVFc0w3NjZkd0lIZFMzY2VmL2VuOWtIcnVSazhsRXpr?=
 =?utf-8?B?RjNUcndVSUdjZEQzYXF1NEJrNk1uYUxwSERrazhQb0Fpa0RLOU15MVBLd3pa?=
 =?utf-8?B?aDYwcHhsM1Z4dEszTE83UjltOWQ4akNnbzNMZ1hqOEZpREoyQmVnZFRqREsw?=
 =?utf-8?B?VW1Xalo2Y2NIU1Z1ZVg1c0wyaEp5YVdCckJhbVlxNW9YRlRsSC9vQUlpSmRS?=
 =?utf-8?B?WHVjVWNEM2NwUUdtNW1TVWV1UG5KT01nRVE4NnRLc25VUG5NNkVkU1o3TFVp?=
 =?utf-8?B?R2NXUHBjbTZYcEpUVm1BZHlFdnhtUS9HNnNXVVN0RHVPcXE2Mm9iZDVwTTZJ?=
 =?utf-8?B?SmQ3UG9ZQ0FiK2c0QXJWb1F1ZjlqaUJBTjFFdkVaR2krSmMzMDdXak8yYWt2?=
 =?utf-8?B?TnNoVDBTWWpOV0hyRERuSXFDbTF2Z3Zaa0xiaURJK3BHTlNLZ0lyMWNHcTFh?=
 =?utf-8?B?d2sralVXNWlGVGlkWFc2amk5OWhOem9abkM1RzE3RjlnS0RqN0czVVF0RlBk?=
 =?utf-8?B?RE1jN3Y3aUQ2cndkaGFlTDJlMEs1ekpwbUxZajdSaHpOQVM3TmgwYjBTeWJk?=
 =?utf-8?B?c3RudCtqYjFkNEw5aEtBM25IUlQwTlFYNDFzejF4UFF0OHBaUEIxYnd6MlRr?=
 =?utf-8?B?djRJV1d0cjhGTUJUV0xhSE1WQStQZ3hya2lGU21TaVlqNmljUWYweE9Lazc2?=
 =?utf-8?Q?qCgkko1NMmQwszl40UdhS3QVomjN472nGc7vNn0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0daUWxuNHh0M2ZaVXBCOCtjTzBsYkIrVlNHcU1GR3RhWjhVUkxpVFc5d2ZI?=
 =?utf-8?B?MlZtRnJLbmNXZHFBNGc1ZzlGd3N3ODlFMlU2NDV1b1hoZVRQTTlCRWdsMmFW?=
 =?utf-8?B?Sm9YZ1psZjRaQkU3dEFKZFp0blMvUzZad1pBTFoyTS9WeFNoU3BwSS9kS0lx?=
 =?utf-8?B?YXZTT2ZTMS9ZbXd5Z3JNOHRSZklPMkExRS92RUpGcDZuclhPSCtKNHFTWHlO?=
 =?utf-8?B?WDVBUDh6YUlMTmt0bkVYQXNDN2lhb0tnUXl4MGxWblpoZ3pCeTB2bU1VSHZZ?=
 =?utf-8?B?cGV4SWlGKzhrUXNPRjRRRWpwWG4yOG9SajNna3RSMWNCU25pcUNkMld4Q1FJ?=
 =?utf-8?B?UVJhZzZ1VXVQcVdDYXVJYmlGQlduYk5rUHA3eWJZNzNiSzBGaGtMcDdxVlRY?=
 =?utf-8?B?WnF3QUlTeVhVS0Z5WW83M2JBUUFOZy9IZUFjT1dOMldRVDc1QVV3bFp0ZW11?=
 =?utf-8?B?czZqN3hRNUxmTXhTc1owWThnM0V5dWllWjVLQ1BWQnBKc0hSWnRLa3hoUVRC?=
 =?utf-8?B?RXUwU3ZiMzlRRVZnWTJVQWlRdTV5ckdzWHJKcERGNG1wZzZXbDFVVjdZSnVK?=
 =?utf-8?B?ZE0vVDlXckpDVE82TnVORWNYazhLSnRUeGlPRGY5RmhBb3BEVmw1RjRtL3Fx?=
 =?utf-8?B?VmdVdlNRc213dzF5SS84WFZjdFovSTIxMGhIaHRUMkc4RmQ0UTl6ZnRVTUYw?=
 =?utf-8?B?OTV1VGhiUkllQVdTdVFiYlBlK2NTY1M2SlVDc0w5cCsyeEF1bEUvWFBweEpZ?=
 =?utf-8?B?Y2VGWTc3MStwNzNkUEhXNno1ZGI0TmlJdFdUeWJCRVlrb2RwRXdYNGtYUmxZ?=
 =?utf-8?B?bW9CS0VyMHl0QjBZYlAzek9TYUNxL1RiaGhwdGw4SHhJK0NQWXV4Q20yT3Zt?=
 =?utf-8?B?TTFJQnJ5UnF4NWF4RUttRGVwcEVPZWxMUUJOalpzMmNzcEdaV2hGWVErcGRZ?=
 =?utf-8?B?VXo0SjMvQjFHZVNiOVVxZE1wT1YvajRicWZaWHp0MHVYR0sya1NkclNrTW41?=
 =?utf-8?B?amVZRVRtUGNSQUgwL1pjZzNBMHFpUVhQMEtNcVhoN2xpdE9paEMrck5aL2ZV?=
 =?utf-8?B?KytSMUhIMkpYb1RVUUxTVmhseU1tMXZYQ2VYV3hsZlpwakJqUFBxc2lPY0pa?=
 =?utf-8?B?MmllSGMyK2xadXU4N1NZTldKYjBueVdtS09CRjZ2eUZnSExyMGhrZ2hxUTRp?=
 =?utf-8?B?YTRXS3YxTFRYNk16Q2lWdFdhdE9iL2xienluZUFoSFVPcC9uVHBya1ZmOGov?=
 =?utf-8?B?UDhtQjVTTmpML2JRcVFoV29GNk83Tk5OUmpQdGkyWUYwVm9tbTYzM1hGSnJ4?=
 =?utf-8?B?TVZ3QklvdFpUUnRUVmRWQmFYbzdHNVltSXBpOUliVnlodEN3OGFLM2V4c2cv?=
 =?utf-8?B?VnVQbFp4NWU4ZlNzUHE4K2tDdUFzeFJrVTAxMU5ucDdvYityUnNubmFIandz?=
 =?utf-8?B?bUJKMVhCaTZwMlhlYjJMYkZ3czVJWTlIQXZpYzFndDQwRVZTZVFZUkE2SXEw?=
 =?utf-8?B?QVZlcXBJa21nL3lTUG5DaXhDL0MrZzZWTmVEUFkvNmVXZjFMYVY1dkpkU29h?=
 =?utf-8?B?aW01M2RRNm1FMVMyTjJWUWVYOVphK2YvRkZ4cjVmZFUwWFlPbUlvWWx3OXdx?=
 =?utf-8?B?TWhtNUFXb2tkc2dmR2ZiYjJRRzJ3ak42Tk5EcGVEQUhITXQwYlVxT1pPS01k?=
 =?utf-8?B?ZTcwdE9vSDloRFlaVjF3RFA3SitpcVhvN0txbXdsOEZ4RkRPUEhMSzdHWE40?=
 =?utf-8?B?dHpJZHhLUStON1BJUEtrNzMyNFJsME1WVi9rdFB1SEljaEhwamFJSnVWTWdH?=
 =?utf-8?B?Tk5PcXlKS1pNbTh1T3NzYmFERXFpWUwzaGJ6azg5VEFkRE5aWnozWGtTVDdr?=
 =?utf-8?B?aTk4elBCVUEvWEU5cHhOWDBxM2ZidXBrY2VqMzJKMG92eVZPanBYT3VkMHh6?=
 =?utf-8?B?ZFVBRFQvMXdwcTFVL0NXZHZhQ0FnM3BXMEIyYjlLeDAxaTcwNVRCUm5WUDFi?=
 =?utf-8?B?aEtrS3J1TlJsMWlFWlhBcUwvYnZ5SkdONmMrQzhyeHR4NnJ2QmFadm9kR2lN?=
 =?utf-8?B?d21VVnhOeFVNUFdYQWUrcCs2MWhrTW9EN3Z5N1p1OVdIS004VlVPcVRlNDFJ?=
 =?utf-8?Q?idYA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e54452-f14d-4a49-1292-08dd055e3fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 10:14:10.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aptjrywGpCZheElR6+xm1k4FF5M8IFp8roECWGQKqbtmyPv1p4I220OsjhFDXSvuUB5EQWcrz/A7xO4ZKvth3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9095

SGkgTWFuaXZhbm5hbiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGNoZWNrIGJyaWRn
ZS0+YnVzIGluDQo+IHBjaV9ob3N0X2NvbW1vbl9yZW1vdmUNCj4gDQo+IE9uIE1vbiwgT2N0IDI4
LCAyMDI0IGF0IDA0OjQ2OjQzUE0gKzA4MDAsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gV2hlbiBQQ0kgbm9kZSB3
YXMgY3JlYXRlZCB1c2luZyBhbiBvdmVybGF5IGFuZCB0aGUgb3ZlcmxheSBpcw0KPiA+IHJldmVy
dGVkL2Rlc3Ryb3llZCwgdGhlICJsaW51eCxwY2ktZG9tYWluIiBwcm9wZXJ0eSBubyBsb25nZXIg
ZXhpc3RzLA0KPiA+IHNvIG9mX2dldF9wY2lfZG9tYWluX25yIHdpbGwgcmV0dXJuIGZhaWx1cmUu
IFRoZW4NCj4gPiBvZl9wY2lfYnVzX3JlbGVhc2VfZG9tYWluX25yIHdpbGwgYWN0dWFsbHkgdXNl
IHRoZSBkeW5hbWljIElEQSwNCj4gZXZlbg0KPiA+IGlmIHRoZSBJREEgd2FzIGFsbG9jYXRlZCBp
biBzdGF0aWMgSURBLiBTbyB0aGUgZmxvdyBpcyBhcyBiZWxvdzoNCj4gPiBBOiBvZl9jaGFuZ2Vz
ZXRfcmV2ZXJ0DQo+ID4gICAgIHBjaV9ob3N0X2NvbW1vbl9yZW1vdmUNCj4gPiAgICAgIHBjaV9i
dXNfcmVsZWFzZV9kb21haW5fbnINCj4gPiAgICAgICAgb2ZfcGNpX2J1c19yZWxlYXNlX2RvbWFp
bl9ucg0KPiA+ICAgICAgICAgIG9mX2dldF9wY2lfZG9tYWluX25yICAgICAgIyBmYWlscyBiZWNh
dXNlIG92ZXJsYXkgaXMgZ29uZQ0KPiA+ICAgICAgICAgIGlkYV9mcmVlKCZwY2lfZG9tYWluX25y
X2R5bmFtaWNfaWRhKQ0KPiA+DQo+ID4gV2l0aCBkcml2ZXIgY2FsbHMgcGNpX2hvc3RfY29tbW9u
X3JlbW92ZSBleHBsaWNpdHksIHRoZSBmbG93DQo+IGJlY29tZXM6DQo+ID4gQiBwY2lfaG9zdF9j
b21tb25fcmVtb3ZlDQo+ID4gICAgcGNpX2J1c19yZWxlYXNlX2RvbWFpbl9ucg0KPiA+ICAgICBv
Zl9wY2lfYnVzX3JlbGVhc2VfZG9tYWluX25yDQo+ID4gICAgICBvZl9nZXRfcGNpX2RvbWFpbl9u
ciAgICAgICMgc3VjY2VlZHMgaW4gdGhpcyBvcmRlcg0KPiA+ICAgICAgIGlkYV9mcmVlKCZwY2lf
ZG9tYWluX25yX3N0YXRpY19pZGEpDQo+ID4gQSBvZl9jaGFuZ2VzZXRfcmV2ZXJ0DQo+ID4gICAg
cGNpX2hvc3RfY29tbW9uX3JlbW92ZQ0KPiA+DQo+ID4gV2l0aCB1cGRhdGVkIGZsb3csIHRoZSBw
Y2lfaG9zdF9jb21tb25fcmVtb3ZlIHdpbGwgYmUgY2FsbGVkDQo+IHR3aWNlLCBzbw0KPiA+IG5l
ZWQgdG8gY2hlY2sgJ2JyaWRnZS0+YnVzJyB0byBhdm9pZCBhY2Nlc3NpbmcgaW52YWxpZCBwb2lu
dGVyLg0KPiA+DQo+ID4gRml4ZXM6IGMxNGY3Y2NjOWY1ZCAoIlBDSTogQXNzaWduIFBDSSBkb21h
aW4gSURzIGJ5IGlkYV9hbGxvYygpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4NCj4gDQo+IEkgd2VudCB0aHJvdWdoIHRoZSBwcmV2aW91cyBkaXNjdXNz
aW9uIFsxXSBhbmQgSSBjb3VsZG4ndCBzZWUgYW4NCj4gYWdyZWVtZW50IG9uIHRoZSBwb2ludCBy
YWlzZWQgYnkgQmpvcm4gb24gJ3JlbW92aW5nIHRoZSBob3N0IGJyaWRnZQ0KPiBiZWZvcmUgdGhl
IG92ZXJsYXknLg0KDQpUaGlzIHBhdGNoIGlzIGFuIGFncmVlbWVudCB0byBCam9ybidzIGlkZWEu
IA0KDQpJIGhhdmUgYWRkZWQgcGNpX2hvc3RfY29tbW9uX3JlbW92ZSB0byByZW1vdmUgaG9zdCBi
cmlkZ2UNCmJlZm9yZSByZW1vdmluZyBvdmVybGF5IGFzIEkgd3JvdGUgaW4gY29tbWl0IGxvZy4N
Cg0KQnV0IG9mX2NoYW5nZXNldF9yZXZlcnQgd2lsbCBzdGlsbCBydW5zIGludG8gcGNpX2hvc3Rf
DQpjb21tb25fcmVtb3ZlIHRvIHJlbW92ZSB0aGUgaG9zdCBicmlkZ2UgYWdhaW4uIFBlcg0KbXkg
dmlldywgdGhlIGRlc2lnbiBvZiBvZl9jaGFuZ2VzZXRfcmV2ZXJ0IHRvIHJlbW92ZQ0KdGhlIGRl
dmljZSB0cmVlIG5vZGUgd2lsbCB0cmlnZ2VyIGRldmljZSByZW1vdmUsIHNvIGV2ZW4NCnBjaV9o
b3N0X2NvbW1vbl9yZW1vdmUgd2FzIGV4cGxpY2l0bHkgdXNlZCBiZWZvcmUNCm9mX2NoYW5nZXNl
dF9yZXZlcnQuIFRoZSBmb2xsb3dpbmcgY2FsbCB0byBvZl9jaGFuZ2VzZXRfcmV2ZXJ0DQp3aWxs
IHN0aWxsIGNhbGwgcGNpX2hvc3RfY29tbW9uX3JlbW92ZS4NCg0KU28gSSBkaWQgdGhpcyBwYXRj
aCB0byBhZGQgYSBjaGVjayBvZiAnYnVzJyB0byBhdm9pZCByZW1vdmUgYWdhaW4uDQoNCj4gDQo+
IEkgZG8gdGhpbmsgdGhpcyBpcyBhIHZhbGlkIHBvaW50IGFuZCBpZiB5b3UgZG8gbm90IHRoaW5r
IHNvLCBwbGVhc2Ugc3RhdGUNCj4gdGhlIHJlYXNvbi4NCg0KSSBhZ3JlZSBCam9ybidzIHZpZXcs
IHRoaXMgcGF0Y2ggaXMgb3V0cHV0IG9mIGFncmVlbWVudCBhcyBJIHdyaXRlIGFib3ZlLg0KDQpU
aGFua3MsDQpQZW5nLg0KDQo+IA0KPiAtIE1hbmkNCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwOTEzMTE1NzM3LkdBNDI2NzM1QGJoZWxnYWFzLw0KPiANCj4g
PiAtLS0NCj4gPg0KPiA+IFYxOg0KPiA+ICBOb3Qgc3VyZSB0byBrZWVwIHRoZSBmaXhlcyBoZXJl
LiBJIGNvdWxkIGRyb3AgdGhlIEZpeGVzIHRhZyBpZiBpdCBpcw0KPiA+IGltcHJvcGVyLg0KPiA+
ICBUaGlzIGlzIHRvIHJldmlzaXQgdGhlIHBhdGNoIFsxXSB3aGljaCB3YXMgcmVqZWN0ZWQgbGFz
dCB5ZWFyLiBUaGlzDQo+ID4gbmV3IGZsb3cgaXMgdXNpbmcgdGhlIHN1Z2dlc3QgZmxvdyBmb2xs
b3dpbmcgQmpvcm4ncyBzdWdnZXN0aW9uLg0KPiA+ICBCdXQgb2ZfY2hhbmdlc2V0X3JldmVydCB3
aWxsIHN0aWxsIGludm9rZSBwbGFmb3JtX3JlbW92ZSBhbmQgdGhlbg0KPiA+IHBjaV9ob3N0X2Nv
bW1vbl9yZW1vdmUuIFNvIHdvcmtlZCBvdXQgdGhpcyBwYXRjaCB0b2dldGhlciB3aXRoIGENCj4g
cGF0Y2gNCj4gPiB0byBqYWlsaG91c2UgZHJpdmVyIGFzIGJlbG93Og0KPiA+ICBzdGF0aWMgdm9p
ZCBkZXN0cm95X3ZwY2lfb2Zfb3ZlcmxheSh2b2lkKSAgew0KPiA+ICsgICAgICAgc3RydWN0IGRl
dmljZV9ub2RlICp2cGNpX25vZGUgPSBOVUxMOw0KPiA+ICsNCj4gPiAgICAgICAgIGlmIChvdmVy
bGF5X2FwcGxpZWQpIHsNCj4gPiArI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVS
U0lPTig2LDYsMCkNCj4gPiArICAgICAgICAgICAgICAgdnBjaV9ub2RlID0gb2ZfZmluZF9ub2Rl
X2J5X3BhdGgoIi9wY2lAMCIpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAodnBjaV9ub2RlKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diA9DQo+IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUodnBjaV9ub2RlKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoIXBkZXYpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwcmludGsoIk5vdCBmb3VuZCBkZXZpY2UgZm9yIC9wY2lAMFxuIik7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwY2lfaG9zdF9jb21tb25fcmVtb3ZlKHBkZXYpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcGxhdGZvcm1fZGV2aWNlX3B1dChwZGV2KTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAg
ICAgb2Zfbm9kZV9wdXQodnBjaV9ub2RlKTsgI2VuZGlmDQo+ID4gKw0KPiA+ICAgICAgICAgICAg
ICAgICBvZl9jaGFuZ2VzZXRfcmV2ZXJ0KCZvdmVybGF5X2NoYW5nZXNldCk7DQo+ID4NCj4gPiAg
WzFdDQo+ID4NCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGDQo+IGxvcmUNCj4gPiAua2VybmVsLm9yZyUyRmxrbWwlMkYy
MDIzMDkwODIyNDg1OC5HQTMwNjk2MCU0MGJoZWxnYWFzJTINCj4gRlQlMkYlMjNtZDEyZQ0KPiA+
DQo+IDYwOTdkOTFhMDEyZWRlNzhjOTk3ZmM1YWJmNDYwMDI5YTU2OSZkYXRhPTA1JTdDMDIlN0Nw
ZW5nLg0KPiBmYW4lNDBueHAuY29tDQo+ID4gJTdDMDI1ZTIwOWNmOTI2NGM0MjQwZmEwOGRkMDUz
ZDkyMTElN0M2ODZlYTFkM2JjMmI0YzZmYQ0KPiA5MmNkOTljNWMzMDE2MzUNCj4gPiAlN0MwJTdD
MCU3QzYzODY3MjQ4NDE4OTA0NjU2NCU3Q1Vua25vd24lN0NUV0ZwYkdac2INCj4gM2Q4ZXlKRmJY
QjBlVTFoY0draQ0KPiA+DQo+IE9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFX
NHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsDQo+IGRVSWpveWZRDQo+ID4gJTNEJTNEJTdDMCU3QyU3
QyU3QyZzZGF0YT11Q281TU81ZkVxQ2pCendaOGhkbnNmM09SaA0KPiBTZWRockpXdk5PQ0NNTnZH
MCUNCj4gPiAzRCZyZXNlcnZlZD0wDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktaG9zdC1jb21tb24uYyB8IDYgKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2ktaG9zdC1jb21tb24uYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2ktaG9zdC1jb21tb24uYw0KPiA+IGluZGV4IGNmNWY1OWE3NDViMy4uNWE5YzI5ZmM1
N2NkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWhvc3QtY29t
bW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5j
DQo+ID4gQEAgLTg2LDggKzg2LDEwIEBAIHZvaWQgcGNpX2hvc3RfY29tbW9uX3JlbW92ZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJc3RydWN0IHBjaV9ob3N0X2JyaWRn
ZSAqYnJpZGdlID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4NCj4gPiAgCXBjaV9s
b2NrX3Jlc2Nhbl9yZW1vdmUoKTsNCj4gPiAtCXBjaV9zdG9wX3Jvb3RfYnVzKGJyaWRnZS0+YnVz
KTsNCj4gPiAtCXBjaV9yZW1vdmVfcm9vdF9idXMoYnJpZGdlLT5idXMpOw0KPiA+ICsJaWYgKGJy
aWRnZS0+YnVzKSB7DQo+ID4gKwkJcGNpX3N0b3Bfcm9vdF9idXMoYnJpZGdlLT5idXMpOw0KPiA+
ICsJCXBjaV9yZW1vdmVfcm9vdF9idXMoYnJpZGdlLT5idXMpOw0KPiA+ICsJfQ0KPiA+ICAJcGNp
X3VubG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwo
cGNpX2hvc3RfY29tbW9uX3JlbW92ZSk7DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gPg0KPiANCj4g
LS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCv
jQ0K

