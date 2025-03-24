Return-Path: <linux-pci+bounces-24491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6433A6D569
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F76188F98B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431DB19E98A;
	Mon, 24 Mar 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hk8ymeDE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C471662E9;
	Mon, 24 Mar 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802487; cv=fail; b=ZSVxCJ6UCOh7cLvE3Tl05PPz1Baae1OkMFlZYmXLeU7KeEJ0VSMORwOcAiaW596t05oQX75YaCxVB+m9asT/YUjVbGjJd/mnRXTLnawBncsfI6q8IgXbYJ6wb4nodPWY4uHbe7L7clADB8tk+JlnZqV8xyCP646Q2C5tLS/8mDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802487; c=relaxed/simple;
	bh=KBFJv/GoY2d7Yeu3nUdI1wEBbGrbsaFFm1Ax+JeLbuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWQi46mO9ZY80pnx5QGdmyL5vOIUii1k/FZZk28ylsWmcRYJZTtMUUwmlvxqUhGuC+fA3s8hus7zR3Lls3ZEXkFp/PPh+mU4Z/CnJYdBAQ4CNu7MQjvZM22KNbFjM3iCWt73pENVAMzbZcqHFqAQEj1kyRs8p5p1cEp1yziMqGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hk8ymeDE; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6jpDSSKGBf5NlGcmr+K6dn0UjdyAFkv73QBXfV9PcZtVB68Opz9jreUPyd+LIZr1BxykZz8FzQanS4UOD2GMYAGWN4JWj9EXeZ1HBRg7jEfYRIB23PaUgov8MkW5vHw0l4tNZGcS86gY0kTkB66tgBGtru+GqvGHiuL5iKhRJgVhV2Ymt1uZnkV4RUsEVrpMpNf2mI5O8zLDkrx+b4wqbsNctumNC6ywNM2vrpoLYzCIPhvY6syhZbGnhFcjH4OYiISdbkH7SJi14UlsNG9JTPohM2w7zPz84qyxgJKdIUOlp5CME/lmprKV5iXNE3E6BSSPjB49iqBmnAi6P3QoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBFJv/GoY2d7Yeu3nUdI1wEBbGrbsaFFm1Ax+JeLbuc=;
 b=raDioiRqXQGSex+KXgTD8NWPEqq4nTC0BjZyR6rIrvcj7jqnETt1Ghc627rbWzyHtI75zuVovswJaKld1IFQzXKRr7/Ds5EuRv8TJrw55q8EMpndqc7Sy4ie/EC0SyAm9QquCFISl5WIZGbsnC+y23pqj85z9gmINSzECEae7UboPUe24X9lQx3Y9oijg0+Hqm6MOP/U1cLWCjdJa3aSx0xx4QtOp3SDJpTdoBgoARMhsdYHafgrzXtXUzLFka3IDf2O93YVzE7iEKGV2GBBeOA0cUPh6oFyFQrlw2FsVUsRMtWd+D/YuiyKbZUr9Y7QKzBTCG4aOK2Zj9AEkOqNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBFJv/GoY2d7Yeu3nUdI1wEBbGrbsaFFm1Ax+JeLbuc=;
 b=Hk8ymeDEQQY4D6t1PrY9eMy9oP8H+pjoTTChqbmGMdFs6WmCJDtUA1NHQgaS9yIFjb0JULiZQyWWBTDyBTCJsVK84ot2oLWiXgdXCt+RMaMiNHd5Onhxlw5Zhw8OaTKIAafqkX46KOKvANOV0pPpNGvrtvILjlq3+jlvsB70qr2Ggy5856qOIX6MLqY/rh9TpQbY2PWptJg8kPJ9IIMxu43tCmBFBDZs6VMGGyabpLHQIyAjlhh2W0p4kmNnUk0ztnhM7rLJB+w5xvR8Oo7gs4D61JYwCU3knFcEc3dzFdnhuyCJhSKEAjEYQ61b22ff92VLuEzdxry3bwq2vJW0Fw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8141.eurprd04.prod.outlook.com (2603:10a6:102:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:48:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:48:02 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/5] PCI: imx6: Start link directly when workaround is
 not required
Thread-Topic: [PATCH v1 1/5] PCI: imx6: Start link directly when workaround is
 not required
Thread-Index: AQHbnIZmcCHNppqAfU6HvpDpWwmr9LOB570g
Date: Mon, 24 Mar 2025 07:48:02 +0000
Message-ID:
 <AS8PR04MB8676437B8097EE171631E6EB8CA42@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
 <20250324062647.1891896-2-hongxing.zhu@nxp.com>
In-Reply-To: <20250324062647.1891896-2-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB8141:EE_
x-ms-office365-filtering-correlation-id: 446f4a13-0d36-43b2-05d6-08dd6aa83459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?UmhkVEp0cFI3Vy9DNGR6eUthd1Q3aytvc1pXMUxnWlhlODM1cm1qN3ZaZmJE?=
 =?gb2312?B?YkV2Yyt0bmErRHNoMWNhTWNNREVOWERUYzUrejFEYlYyelJOWGpibDNMWTlN?=
 =?gb2312?B?eUVaYmhkUURURWhHbHFlYW5oY3lLNHlkWmRRS3ZCRW1QY0E3OGI4YnJaTHR5?=
 =?gb2312?B?QkE2MmRqT092NUxXMzNJU0VmNytFLzNSYk0wc0dkTE1kNWhoNnBWMkZTNW43?=
 =?gb2312?B?bjBHVytCc05CWG5hTE80cDcyOWZJSmtaTlYwWVVVSENPbjZHY00vNHNTandX?=
 =?gb2312?B?b1l4U0hFdDZNa1I4K0dFSTFjeFJPVUk0VmZoRk90aVlKRzVUaGo4dGZmRUhI?=
 =?gb2312?B?RTJyelFxNnB1SzhOMVRWdEwzL1JBRGxKcG01VWd6R25NaldudjJHMzEyR08y?=
 =?gb2312?B?akYvUnY0R1grUm4xL1B0U1kzWnZ0dGRQOUJFR09wUUo3Tmh0T3JPUHoweDlm?=
 =?gb2312?B?YlBmSzEwWDJOWmVzbHBpRTVJakp0S2NCSUJ4VC9GYlNocTN3Sk5tWmVkVmJN?=
 =?gb2312?B?ZGF4a2NQcXNCSms3WjM2dWdrYm1wOVhEQlk3bGw2RHRWR1o3MWY0QW5pWFg2?=
 =?gb2312?B?akhsZ0JoNmppbURKL0xMdmNpSWttdERQYjN5bGRSS3lSSHJiMkYzUnpJTk1P?=
 =?gb2312?B?MCt3aHpkdUFkR2xrc2ptNmpFWjJqWTBCRDczZkZCQmhyYmdnbGFvRjR2bXFm?=
 =?gb2312?B?aENJV3AvNjh6WjNzU29oYVRzQmxSVmFpUkVLZDhWbm44TDRsNkJXRUtsWVEv?=
 =?gb2312?B?d3Zud0o0dUhSMUlhWmZJNnJPTnpxSEo4M2NGRFNLYUhTK2VFR0RFWFpYcUpm?=
 =?gb2312?B?Rk03aEhKMHJuUW1WY2ZHZzZ3RHFNSU0xUjU0TklRZCtXY0Y2cGVoSENLQjY3?=
 =?gb2312?B?TDBOOUhFSjVHQm82OUxDTjRkV1NQUlQvR0hSYmM0ajN4ZHBRckVpWGdYUlFM?=
 =?gb2312?B?VGtsbFlKUjNiVlc4WUlURVFWNmsrclR4aTdEUVNxb0JBdnh5bjZPNFVOU2No?=
 =?gb2312?B?WGx0cHRmc3ZkU2QwdFRGRVduWXlVcFpNU0RqditqZlNpdE1zeCtUNU1EazdY?=
 =?gb2312?B?dzlEVnZMMDJ2ZHNxbXJxckUwVEtiakhmOVRnbDB4NFR4bWJPNlhjdWlJSWY4?=
 =?gb2312?B?UHhKdGpKR1BxZzZvcXVYVVR1T2NZbEJsdS9SK0FKWFVPaGhIN1p3SzhSSkFt?=
 =?gb2312?B?Q1NtUWp5N3pWQmJsRUlENnd4dzIxWGRyc2k1WEVRMW5uN0ZGaEIvREtLZmNn?=
 =?gb2312?B?eFQ1SUVLbXNla3ZycWF2cSt0TktUZTNpemRlMWdhLzZCNGZ6M1FDQm9nR29K?=
 =?gb2312?B?MUkzakt0NW9SOTllaEtDa2VRVmt6Wmk1OEtNWVpweFp6TTJGN0Y5VFZmUGcx?=
 =?gb2312?B?by9XNEZOL016ZkNrb1UwM3owaUZkYU1OVWxuYzlwQjBXZ2ZPZEpSWmFWOVYx?=
 =?gb2312?B?M3BreWFwZEgvSlhKNk9LWkI2RUpXMm45Z0RJWjlPVTNvZytKQmZqTDRubE9v?=
 =?gb2312?B?NFRIbm1hVWJtUjNxdFdLTjZtV0hXczdKVHdiU0tGUitqQWsyZG1zYkx3VzBQ?=
 =?gb2312?B?TWx2T3J2UzgyQlMvbWMyWlJMQTdqOVRjK2NlOHRoYnBJWW9HWWl4Y2VSVDFL?=
 =?gb2312?B?a2x6VDB6ZXpKZU1VMnFPQ0tJczNCckNyRmFYY2lUb04yUGJvR0ZGcFdFMktj?=
 =?gb2312?B?NmYrcTM5cEVOaFhxa0FZRTNqVGVNMGVUYzFMTE1ER2hJYlRacllWeE5EK3Jp?=
 =?gb2312?B?eTNINVlJaW9ERkExQ1hnTkpZTVBSbmlMQXJqM1dEZDhEK0R5dk9sTHRGcmRs?=
 =?gb2312?B?V1A0OUFXTVJ6YVplRmluY2dHeXdUWXBobFliZzhlV0oxTHh1ajBFeDRpWHM1?=
 =?gb2312?B?d2s4S2RHNFFlbkF2d2wxaWdYRmxHbmkyNE5uTDVkdWQ4dTN0YWlIaTVYWnkx?=
 =?gb2312?B?a3YyVm5XckNERVpSM3VERE9Pc1d3K2NlbDN1c3pqVm1qSmVDM0dVdHpoU091?=
 =?gb2312?Q?I72DC89WSlCKdf1653596lBSxc2Pog=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?elhKTm1UWUZhb1hQTFR6RWJsWVVCc2tHQUVtczIxQnc4SEZIZlBocVpaKy9J?=
 =?gb2312?B?cFZrWkZqV292NjN3cVRhUTJxbTJKQ1dlVWdnNkxJRUtZMXVLMG5TemV2OGc3?=
 =?gb2312?B?RU0zb2R6Q0o0SU9sdTIvZlpvMGJGRnlDUlVFTGZwWVU2aURGRCtpSmJ6RGRz?=
 =?gb2312?B?aGUvMzRncGlYQUVHbUErd2pPbEllZWJDLzJrd0xxMWRUMFRLUjBHOFBHc0Vr?=
 =?gb2312?B?ZGJ6aVRuc1kySSt4SDBOaEhvUUJEbnJtL2VESE1pZmE5TjI0S3Y2TkgxTWtL?=
 =?gb2312?B?em5KbDc1M1VYOXpOZjI3dkhDZW9HaDNKUTBJek5YcXFSakh1NGdTd3kyeUNa?=
 =?gb2312?B?V3RqMnUxSkxNY3lFZFU2elhUdEl5aUo0RzUzVVErVGU5cXhRLzF1QVozaERu?=
 =?gb2312?B?Zzkwb3FQSDNMRUQ5cnVGYWNja21PdHdIbjZ1Vzgxdy8vOVlla0FKVnZyZTB6?=
 =?gb2312?B?RS9IUlB3Y0J2REFGZEtXOE96K29RWXpmWGc4Qk1aWUtKQlYxVUN3YllpaVJx?=
 =?gb2312?B?VHo1ajZpc3NOQ3o4S1kwNkp6d0p0ZHo2c3ZtMWNsTmJrWU5vQXlzSnVsajRR?=
 =?gb2312?B?aFhQWkNBdGVqZWlVSlRDV3RkZGk3L1FraFJHTmVGMzdwSjZXSG54SHpDSStP?=
 =?gb2312?B?bXU2RW1WeGhrZTM4Sk1ZNWxqZWJLeElPbk9hTVJXVEw1VlAyWndxSjZWeEVs?=
 =?gb2312?B?M1piYU1RenJDMHJnSnU3bmFKNzdUQWNraVo4anhBTUl3T3FXVWEzcys5UVo5?=
 =?gb2312?B?b0pURjhmbm1qeDZmOXlSbWpxMGZVRDdZQjBrTzN6WkhabUhSVXU2Zy9iMDgw?=
 =?gb2312?B?QjI5NlZiMlFVcXM0TmNPV01EdWxENFRJS3FIaXNzSE5qUFFhV1FHV2VzM3B5?=
 =?gb2312?B?SzRnRUpsWXQ0TGVJcGw4Y051NGh3eEdGZys1WWRZbHhCWFdkNXRIM2hzUVRs?=
 =?gb2312?B?WXFUSjBpL05ZZi9VZFZKSlpPajBBbXQ2NWd1OEZ4VjY3UEc4YkY3USt1bGhP?=
 =?gb2312?B?U2tIa0dzSmMzaElCQ2Y1Y1dKNnFaS0VVaHBNd1ZOZFZ6MHBZSzg3TzRXN3BU?=
 =?gb2312?B?d3ZBWHNhVnc4ZkxjWGxtR2lwMi9uSFVmU25tYWt3NXdZdkNJd05NbFpTaFgv?=
 =?gb2312?B?NnB1VXVoRW9CU0RXcTIrS1BnU2NaWHNGcFk1cndwcFNhRDU4b1lGWU5RRWNO?=
 =?gb2312?B?Y3JvQS9yZk1PNnNYME9xR1M3bDY0TXBKeUZTd1AxdnZRU1ZZN0k2NjZ1MGpj?=
 =?gb2312?B?c2RyWWFwRCtzMVFoVVoxVDIzYzZmWGRIaDVyNTlGUEpOWVVrRTRKNWN6SkJ3?=
 =?gb2312?B?MTlDZ3laNytLM0h2NU5nZkNBQXVKT0xnYkF6U0ZwRjNUZFZNVFlFQnk5dWZX?=
 =?gb2312?B?dW8xSC9nNUZteWlZdEFCRzYxbHV5eE95Nlg1dWRBanFJNzJKOHBPNW5wb0pT?=
 =?gb2312?B?QUkxQ2NScEd4ZysvaEtqbFJYR0JNUEpYZC9lajY2WmZja2xNYVdOWkdrK2hO?=
 =?gb2312?B?eGdxWS95TWNWWDRxTHRHZ0xyZmRESC8yVkdxQ1F3ZVdiL0RJWVNzazI5YVpK?=
 =?gb2312?B?K2lQMzVRNk43clVseE1JQjg3UGQ2aVRDS2RsZ1Z5MVFMNHpCYURodHNKVEYw?=
 =?gb2312?B?YXdCdmJYc05nTUJVbmVjUlZVajNYcW9KaE8vRFVZNkF3QmxTTm54TnYxOTk3?=
 =?gb2312?B?NnNhOW5BSnpqemJqbyt4TnNzU3h6OERPTlUra1JUSHdNaDdBc08rMVRBbmlD?=
 =?gb2312?B?QzE1ZTk0eUs5YVYyanBpcDV5WVNnRXg3VEI2ZENydVc3WWRWcWVVSlE1VmdT?=
 =?gb2312?B?akJYUTdJRlQwYjU0blZpM2N0U0hLVDN3YWlGRGZvMFRFSVdqekVNb3BPcUhj?=
 =?gb2312?B?cll2a1M4VFdrbkoySVpsN0hWdzBPc1BIdjJpeWlubmxwZW0rSjR4T2NzQVFj?=
 =?gb2312?B?K3VCUzVBV1pyK2lDVGNGRkxoMGc0QlhiK1hCN0QzSVhobzNvQndkdlZTTUVr?=
 =?gb2312?B?RXJzdFZvaTVQV1pPcmpkUXZmQlp0YmY4RUx2YTEvRVdFQmo2MnhTM1EvUG91?=
 =?gb2312?B?N1paZ0duNmh2OGJsNmg5WHl1cEdiR3M2WEszYXNHMml1R3RXMWMyM1JwVkVj?=
 =?gb2312?Q?ha0jDkaBorjiJiTVV0R+RTMfI?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446f4a13-0d36-43b2-05d6-08dd6aa83459
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 07:48:02.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gp01U14Ug08kl5Ts1cTjJlqNx6QNp+t82qV1Xs+yUlyjSEiYeH5+glHS6iz6mPATZNosqFYxMmCby9wSxutC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8141

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhvbmd4aW5nIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+IFNlbnQ6IDIwMjXE6jPUwjI0yNUgMTQ6MjcNCj4gVG86IEZy
YW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5s
aW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEhvbmd4aW5nIFpodQ0KPiA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MSAxLzVdIFBDSTogaW14
NjogU3RhcnQgbGluayBkaXJlY3RseSB3aGVuIHdvcmthcm91bmQgaXMgbm90DQo+IHJlcXVpcmVk
DQo+IA0KPiBUaGUgY3VycmVudCBsaW5rIHNldHVwIHByb2NlZHVyZSBpcyBtb3JlIGxpa2Ugb25l
IHdvcmthcm91bmQgdG8gZGV0ZWN0IHRoZQ0KPiBkZXZpY2UgYmVoaW5kIFBDSWUgc3dpdGNoZXMg
b24gc29tZSBpLk1YNiBwbGF0Zm9ybXMuDQo+IA0KPiBUbyBkZXNjcmliZSBtb3JlIGFjY3VyYXRl
bHksIGNoYW5nZSB0aGUgZmxhZyBuYW1lIGZyb20NCj4gSU1YX1BDSUVfRkxBR19JTVhfU1BFRURf
Q0hBTkdFIHRvDQo+IElNWF9QQ0lFX0ZMQUdfU1BFRURfQ0hBTkdFX1dPUktBUk9VTkQuDQo+IA0K
PiBUaGVuLCBzdGFydCBQQ0llIGxpbmsgZGlyZWN0bHkgd2hlbiB0aGlzIGZsYWcgaXMgbm90IHNl
dCBvbiBpLk1YNyBvciBsYXRlcg0KPiBwYWx0Zm9ybXMgdG8gc2ltcGxlIGFuZCBzcGVlZCB1cCBs
aW5rIHRyYWluaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMgfCAzNCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBpbmRleCBjMWY3OTA0ZTM2MDAuLmFhNWMzZjIzNTk5
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC05MSw3
ICs5MSw3IEBAIGVudW0gaW14X3BjaWVfdmFyaWFudHMgeyAgfTsNCj4gDQo+ICAjZGVmaW5lIElN
WF9QQ0lFX0ZMQUdfSU1YX1BIWQkJCUJJVCgwKQ0KPiAtI2RlZmluZSBJTVhfUENJRV9GTEFHX0lN
WF9TUEVFRF9DSEFOR0UJCUJJVCgxKQ0KPiArI2RlZmluZSBJTVhfUENJRV9GTEFHX1NQRUVEX0NI
QU5HRV9XT1JEQVJPVU5ECUJJVCgxKQ0KV09SREFST1VORC9zL1dPUktBUk9VTkQNClNvcnJ5IHRv
IGZpbmQgdGhpcyB0eXBvIGVycm9yIGFmdGVyIHBhdGNoLXNldCBpcyBpc3N1ZWQuDQpXb3VsZCBj
b3JyZWN0IHRoZW0gYWxsIGluIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJk
IFpodQ0KPiAgI2RlZmluZSBJTVhfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQJCUJJVCgyKQ0K
PiAgI2RlZmluZSBJTVhfUENJRV9GTEFHX0hBU19QSFlEUlYJCUJJVCgzKQ0KPiAgI2RlZmluZSBJ
TVhfUENJRV9GTEFHX0hBU19BUFBfUkVTRVQJCUJJVCg0KQ0KPiBAQCAtODYwLDYgKzg2MCwxMiBA
QCBzdGF0aWMgaW50IGlteF9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4g
IAl1MzIgdG1wOw0KPiAgCWludCByZXQ7DQo+IA0KPiArCWlmICghKGlteF9wY2llLT5kcnZkYXRh
LT5mbGFncyAmDQo+ICsJICAgIElNWF9QQ0lFX0ZMQUdfU1BFRURfQ0hBTkdFX1dPUkRBUk9VTkQp
KSB7DQo+ICsJCWlteF9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiArCQlyZXR1cm4gMDsNCj4g
Kwl9DQo+ICsNCj4gIAkvKg0KPiAgCSAqIEZvcmNlIEdlbjEgb3BlcmF0aW9uIHdoZW4gc3RhcnRp
bmcgdGhlIGxpbmsuICBJbiBjYXNlIHRoZSBsaW5rIGlzDQo+ICAJICogc3RhcnRlZCBpbiBHZW4y
IG1vZGUsIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkgdGhlIGRldmljZXMgb24gdGhlIEBADQo+IC04
OTYsMjIgKzkwMiwxMCBAQCBzdGF0aWMgaW50IGlteF9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3
X3BjaWUgKnBjaSkNCj4gIAkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9MSU5LX1dJRFRI
X1NQRUVEX0NPTlRST0wsDQo+IHRtcCk7DQo+ICAJCWR3X3BjaWVfZGJpX3JvX3dyX2RpcyhwY2kp
Ow0KPiANCj4gLQkJaWYgKGlteF9wY2llLT5kcnZkYXRhLT5mbGFncyAmDQo+IC0JCSAgICBJTVhf
UENJRV9GTEFHX0lNWF9TUEVFRF9DSEFOR0UpIHsNCj4gLQ0KPiAtCQkJLyoNCj4gLQkJCSAqIE9u
IGkuTVg3LCBESVJFQ1RfU1BFRURfQ0hBTkdFIGJlaGF2ZXMgZGlmZmVyZW50bHkNCj4gLQkJCSAq
IGZyb20gaS5NWDYgZmFtaWx5IHdoZW4gbm8gbGluayBzcGVlZCB0cmFuc2l0aW9uDQo+IC0JCQkg
KiBvY2N1cnMgYW5kIHdlIGdvIEdlbjEgLT4geWVwLCBHZW4xLiBUaGUgZGlmZmVyZW5jZQ0KPiAt
CQkJICogaXMgdGhhdCwgaW4gc3VjaCBjYXNlLCBpdCB3aWxsIG5vdCBiZSBjbGVhcmVkIGJ5IEhX
DQo+IC0JCQkgKiB3aGljaCB3aWxsIGNhdXNlIHRoZSBmb2xsb3dpbmcgY29kZSB0byByZXBvcnQg
ZmFsc2UNCj4gLQkJCSAqIGZhaWx1cmUuDQo+IC0JCQkgKi8NCj4gLQkJCXJldCA9IGlteF9wY2ll
X3dhaXRfZm9yX3NwZWVkX2NoYW5nZShpbXhfcGNpZSk7DQo+IC0JCQlpZiAocmV0KSB7DQo+IC0J
CQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gYnJpbmcgbGluayB1cCFcbiIpOw0KPiAtCQkJCWdv
dG8gZXJyX3Jlc2V0X3BoeTsNCj4gLQkJCX0NCj4gKwkJcmV0ID0gaW14X3BjaWVfd2FpdF9mb3Jf
c3BlZWRfY2hhbmdlKGlteF9wY2llKTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZGV2X2Vycihk
ZXYsICJGYWlsZWQgdG8gYnJpbmcgbGluayB1cCFcbiIpOw0KPiArCQkJZ290byBlcnJfcmVzZXRf
cGh5Ow0KPiAgCQl9DQo+IA0KPiAgCQkvKiBNYWtlIHN1cmUgbGluayB0cmFpbmluZyBpcyBmaW5p
c2hlZCBhcyB3ZWxsISAqLyBAQCAtMTY2NSw3DQo+ICsxNjU5LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gIAlbSU1YNlFdID0gew0KPiAg
CQkudmFyaWFudCA9IElNWDZRLA0KPiAgCQkuZmxhZ3MgPSBJTVhfUENJRV9GTEFHX0lNWF9QSFkg
fA0KPiAtCQkJIElNWF9QQ0lFX0ZMQUdfSU1YX1NQRUVEX0NIQU5HRSB8DQo+ICsJCQkgSU1YX1BD
SUVfRkxBR19TUEVFRF9DSEFOR0VfV09SREFST1VORCB8DQo+ICAJCQkgSU1YX1BDSUVfRkxBR19C
Uk9LRU5fU1VTUEVORCB8DQo+ICAJCQkgSU1YX1BDSUVfRkxBR19TVVBQT1JUU19TVVNQRU5ELA0K
PiAgCQkuZGJpX2xlbmd0aCA9IDB4MjAwLA0KPiBAQCAtMTY4MSw3ICsxNjc1LDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gIAlbSU1YNlNY
XSA9IHsNCj4gIAkJLnZhcmlhbnQgPSBJTVg2U1gsDQo+ICAJCS5mbGFncyA9IElNWF9QQ0lFX0ZM
QUdfSU1YX1BIWSB8DQo+IC0JCQkgSU1YX1BDSUVfRkxBR19JTVhfU1BFRURfQ0hBTkdFIHwNCj4g
KwkJCSBJTVhfUENJRV9GTEFHX1NQRUVEX0NIQU5HRV9XT1JEQVJPVU5EIHwNCj4gIAkJCSBJTVhf
UENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ICAJCS5ncHIgPSAiZnNsLGlteDZxLWlvbXV4
Yy1ncHIiLA0KPiAgCQkubHRzc21fb2ZmID0gSU9NVVhDX0dQUjEyLA0KPiBAQCAtMTY5Niw3ICsx
NjkwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9
IHsNCj4gIAlbSU1YNlFQXSA9IHsNCj4gIAkJLnZhcmlhbnQgPSBJTVg2UVAsDQo+ICAJCS5mbGFn
cyA9IElNWF9QQ0lFX0ZMQUdfSU1YX1BIWSB8DQo+IC0JCQkgSU1YX1BDSUVfRkxBR19JTVhfU1BF
RURfQ0hBTkdFIHwNCj4gKwkJCSBJTVhfUENJRV9GTEFHX1NQRUVEX0NIQU5HRV9XT1JEQVJPVU5E
IHwNCj4gIAkJCSBJTVhfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ICAJCS5kYmlfbGVu
Z3RoID0gMHgyMDAsDQo+ICAJCS5ncHIgPSAiZnNsLGlteDZxLWlvbXV4Yy1ncHIiLA0KPiAtLQ0K
PiAyLjM3LjENCg0K

