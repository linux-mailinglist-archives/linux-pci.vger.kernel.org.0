Return-Path: <linux-pci+bounces-10036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044592C8C3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3783CB21AB0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC6F9CF;
	Wed, 10 Jul 2024 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LG74ioAM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qfoFaaE8"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC3376E6;
	Wed, 10 Jul 2024 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579985; cv=fail; b=ZATKOTa2Ue/Br47ZfNF15venR5JhI927nZ2ogRMKMo6Ms8Hv8MZLT6W65tCgsvBdVkxVS+NqbRu7H03N7WQkphY5n6KZG1ENuwHXSlrNTWz/ej9efb1fATKhjw8BeH4UoZDPRM58IPP/R5ZIjVC/8kk235Ur3bSAgRV6XnQTHr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579985; c=relaxed/simple;
	bh=WZZAZzvr8dIX5hbo4/mH/fowtfngvzB0kQTj9TnqwQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Onat2gvKy+t4yi6LMWjzO9/Wk7P4nO3DxGFyPuEPZ1odWwUpy5AELeWLOTgOwp1Mif/5OU0JecAGe/jf1CHJnlSk+AUWgyjkavz4F12Q2abY5Gmh3TcbMNhEag5HxP1EoXmF9ClnYz+B2iYFsWrEbT9KSXF8xGgnqZJLp2OAmBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LG74ioAM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qfoFaaE8; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720579984; x=1752115984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WZZAZzvr8dIX5hbo4/mH/fowtfngvzB0kQTj9TnqwQo=;
  b=LG74ioAMWca682T5AxxQ3LtoCHSKjggEat8Jx2rAjxerI/f2LOQIPopP
   yJsmaUNeyxLgBmlDC7gF5ZJiAaarrs7gLdKuikbx51nWxYMaxDvNBDmhE
   bRn3QHQ7kFuNFRwC8/HxW3tOaCzo3eXu4T9yy0MczH6H78uONUrQvNG2v
   a9qQhZly/t4DApsgnFrgq2ii56+l7CHss3mGaGonHDyucQKccu0OIe1jL
   czeSB3/12hE41yXlboT1AypOGV1p8xhsUEid3ODGkTm3dF2w+nzVfKWpa
   cZXpYTMmjm3n3322FLELdL2EFfYzApkjCSoLxoPnczUm+mXVUG2O+xlxB
   w==;
X-CSE-ConnectionGUID: MUKEYv6VQTKtrUFi8us3AA==
X-CSE-MsgGUID: nNC4JuctQYmu7BeAZ6ezMg==
X-IronPort-AV: E=Sophos;i="6.09,196,1716220800"; 
   d="scan'208";a="20486767"
Received: from mail-westcentralusazlp17010004.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.4])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 10:53:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/BLsLPz8dC6Dz6M396n8+X/ahQlDnsG3C2SlVFFhj2kbIw3nEklvHtdHzpmkqJQU8un3w8SbseJq1ITHlfGLoMQRJOUPjNzy7EMoEHfqZrQarGnhYhRdRwgDNBDdBJFLy42G8Fh0pQuz7l4H/gP+5Z7M/X8lbxsA7ff0KmHLLMt8DMSj2xnMBdC4lbDLlXGQn4Z+Bpmm3wEEVOilR5G1iO37vFGINI0ieUs0B/5c7OJbkvSogbxBGr0RVK5pDB9g+O40xSZ9Bc4BpjSjO+0LP6ps8dezOYCJJiTP1/4Ap/mNDJ4wVN1Jo6+aHag3XN0epmAB/2e9ITXlw8cNaWYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZZAZzvr8dIX5hbo4/mH/fowtfngvzB0kQTj9TnqwQo=;
 b=T0cwmr/aQSj7Eb3D4aJbZdIPZO3iDPyxP7Ly2LW3hwo/Fn3MxqaNUZq1fLdx4Tir0kQ8J5lBzwu5H8v5b4ISzsr0qk0aB5VY+rhpsgdZH7OXClD1yVDIIk5IjOuqdxcTxUtzuak1s+2TAfaAQ/mj/XufAAyktRFrfqDiqxLTG+H8Om0fzW8Ft61gxWTPNbyzi8r2Xb9u41vpZ3zDtufNyU+sQegcwRL3pADvcd3DbCK/nZM9X+QOWISImj+MihJt/kWxBdo3MxgdWYV8OxhTrP8wAdnoYA2p6XHZhnP8xOfMRJHWlQhDsXTs4rfpFpNzCspxwy8FJcwtDYFlTDJnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZZAZzvr8dIX5hbo4/mH/fowtfngvzB0kQTj9TnqwQo=;
 b=qfoFaaE8EDUOyij3DasS8xiasXU69SirMElWBscIoLeWPO7zKgv6naY2IS3BuVB3DGkBynBFER9dXXF5GUNTGi5z5Gmhl7LnbhfQkyH0P6cfgDXcKXHUD+mzbeH1DFpsu0HcoVT7joAQZPwctz5IcHXmp0J1N7qxBpTOdjiTjjw=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by BN8PR04MB6274.namprd04.prod.outlook.com (2603:10b6:408:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:52:59 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:52:59 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>
CC: "ebiggers@google.com" <ebiggers@google.com>, "sameo@rivosinc.com"
	<sameo@rivosinc.com>, "graf@amazon.com" <graf@amazon.com>,
	"jglisse@google.com" <jglisse@google.com>, "ming4.li@intel.com"
	<ming4.li@intel.com>, "gdhanuskodi@nvidia.com" <gdhanuskodi@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, "seanjc@google.com"
	<seanjc@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "david.e.box@intel.com"
	<david.e.box@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"dhaval.giani@amd.com" <dhaval.giani@amd.com>, "aik@amd.com" <aik@amd.com>,
	"pgonda@google.com" <pgonda@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 04/18] certs: Create blacklist keyring earlier
Thread-Topic: [PATCH v2 04/18] certs: Create blacklist keyring earlier
Thread-Index: AQHayyiiB/fCBC1bg0e03SXRDFE177HvUjkA
Date: Wed, 10 Jul 2024 02:52:59 +0000
Message-ID: <1ad36e160737794f0f81c386d816e57a7a4b5526.camel@wdc.com>
References: <cover.1719771133.git.lukas@wunner.de>
	 <8b8a58841c221a85b8e684438237b62d77c7dd69.1719771133.git.lukas@wunner.de>
In-Reply-To:
 <8b8a58841c221a85b8e684438237b62d77c7dd69.1719771133.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|BN8PR04MB6274:EE_
x-ms-office365-filtering-correlation-id: 50d51f1e-544d-4c4d-8b52-08dca08b685b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEtwcW1UUlNKem82WFMzMnJ6SnB3UWwrQVhXNG9GOEFvOWVUSjRmUXZYTS9P?=
 =?utf-8?B?WkF0N0NUOXBRNDR3R2NmanBrMU1qZGR3YVJ3SVRIOVZhTFpwTUpzOEVVdENK?=
 =?utf-8?B?cHBIaWlSR3JzSU5ubW5PbVZOV0RLY3VxbXkyZEFqblpIZHNTUHQ3czVqdWdJ?=
 =?utf-8?B?MW9USW5mV3JTaG95RjQvODNneTVPQkRaejByUjVKU3BQNzEyNmxPUDRtSmtY?=
 =?utf-8?B?MGFUUEphQ3gvSUxETG9oUzk3WlMvUmhvZ1Naa3ZlRW9Vd2doT3R1MTZncnFM?=
 =?utf-8?B?UXpMbzhVL2kyZGM1V01YcTUvRnNwMUVwc3cydnY0TWZyM0dabUkwRWdqb2tS?=
 =?utf-8?B?bWtLR21SUklVRzBuVE9OeVpIYzZ4S2MrazB6V2F6Y2NVbm9qSWswR25pNWYz?=
 =?utf-8?B?VmtodGJJTHJjTWJjZWJQSnMvVFRRVEJRbjhEMnRJU0l2NUR5bE9RTnJFRXIw?=
 =?utf-8?B?OEptbHNndTMxMEc4bitxNFZPZU13TXYydG92b1phaTBNazgyZGR1UlFWZVpS?=
 =?utf-8?B?YWlTemZLWmpNTUdoRnRaOXJTcXlJK1ZsTmVFZEowRjYxcFJTWEVJZ2kwTVUy?=
 =?utf-8?B?ck9rakRNRlF2Zi9hakppcWI5VkNreUt5LzBwcHByeW83VmF5SERzR1c1akdJ?=
 =?utf-8?B?aHBHZVNmd2phakZ0UmUxc28yYi93eDUrR1NnQk1JcmZ5OStpcHNGWURGRXcx?=
 =?utf-8?B?Z1Jva3RnQ2JBWUoxSXZjN3RCQWxpeWFwdWszKzVRdTQyVmdUWll2YjRocmNh?=
 =?utf-8?B?NzBHVUdRL05sUFh1bkZnYkxjcFZ1UjhtdFB5YktvWGkzbGJ4Ym9iL1NEc245?=
 =?utf-8?B?c0RHR2dNY1prdERPSkl4MHhkVCt0ZGpEeU04RU8zWk9RRjVDWWFCNVYxZXg2?=
 =?utf-8?B?akRoc1g0TzdmaFpEUmxaa25iZzdpMTdScjJrdmxhU0xCbVZLNm9jS0VRZ2xr?=
 =?utf-8?B?bTBUc3ljZ3Jac2drNzY2blI4cXljM0xPZGlWR0piOGROSDlMbzBNYlUxZUtZ?=
 =?utf-8?B?bE1OR0s0ZW9uQUdTUEs3dEt6c1RVL2ErY2RsWnVYRFhvZTRhMmVRbTR3blBq?=
 =?utf-8?B?WVV6b0Z3RDdkNEE1RXdrNm0rZXBQODhSM1VQYm9qS3p4R1hlcllkSnUwRTJX?=
 =?utf-8?B?eXJQcit3c25zRldieGg3elVTOExkL3hva2JzejhCRm1BY2owdDI0THhaYWxM?=
 =?utf-8?B?cHJ2QkNMMkd1SE5CMXIzaGZqMHFuekRWWWFEU2tiTkNRK3p0VFVVWkVUNkZ3?=
 =?utf-8?B?ZW5ERjkwN2xmRElyaE1GQ2xKTk9ULzA1RnRKWVRSZElWSmlFWmhTU0xGK2ls?=
 =?utf-8?B?R09XeEgxSnljVmQ0cU45N2t3emdzZmRhK3dnYUQvWXBvaXlJUDU5T2lPd0M3?=
 =?utf-8?B?TWtsZE42Wko3K003MFRUaExGUmFHSUZIRVBsSllJeFAxMmRqczYzMklxaVQ5?=
 =?utf-8?B?MGxkZlhFZEx3SVJzWlFqQ0RlUkdmZTNDOFphemJIY0c4NnFJU3o4cENZMUZW?=
 =?utf-8?B?dkNaMUZlRU9EbHh1dkxpTTNRdTkwY2FZSndQemZkSkkrVDlldUxMY3pJY0Iv?=
 =?utf-8?B?bGNLZnZoSTFTNCtvZ2wzcWg1c1YzV09CWWRISXBQb3h5TXozemR2azZENEhq?=
 =?utf-8?B?dDNnaERoMENCUUZ2T2NJcWVKOXZxRXR0VDZudWNHbHJDUEpaaXU3WUd1bElI?=
 =?utf-8?B?M00xTzlEVmxkTXRXNmpoQ2Y2YnVkK3RFZk9yVDJiMTFKa0RpQWZYSG5SZXI4?=
 =?utf-8?B?MjRQRDI2VWtYSUpUd2Z0TkE4b2ZaTGdFVXI4Z256TkJYdWp5dGN2T0g0cUli?=
 =?utf-8?B?aHVOdERsSnhoMEJYNDVRZjRDVmFkVjMwbWJHS2loK2JKWTU4QkZja0NXTGQ1?=
 =?utf-8?B?ck1wU2M3WEpFTlZuMGQzdGpockptSlhCcGxtLzZ3c1A5NFJyVXVWcXlQaXl6?=
 =?utf-8?Q?dDoGYhjlRqo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE5XT0lvWHpwRmxHWmxoeTZhdkh5a2N6S1FSRWIrdEFlSkJheU5uMFdsR0pl?=
 =?utf-8?B?WFNpb2cwY0t5MnJjNkV5RFhnc3psdXRDQStuamVpOHVHKyt6SFJGM1FaNTZC?=
 =?utf-8?B?dXNwYVRjV3dEbWR4eUxsVElUY0JxbFVtQmUxL1VsWmtPK1hEQ0IyWmxtN25h?=
 =?utf-8?B?aURhK0hpbU9NcDlPeDhzZHJhcTloNnJGeWY1SGRxTzlIdjN6cHJkc09pWmRq?=
 =?utf-8?B?MGVmTGV5eDBoc0w1Y1FMSnlJMURSNnVOZTNxMDUxb1REMVNtZzhrcWZndEg1?=
 =?utf-8?B?ZEdkei80Uy9FeU5zMWJOL2hRVEI5MGxWamhXQjNaMU1UbGplSHoyM3V3bmp1?=
 =?utf-8?B?MUdlUW8zdUt0WUFnNFo5V2UweVo1cmlNRXk5OGJDZldHK0tETzZad3puWWxU?=
 =?utf-8?B?T1FDd3NpcitodFpRRnd3MVBoSGo4b2dQaVdXKzFoNm42eXhRcEZTVGo5S28v?=
 =?utf-8?B?QXRCSWtQbXVlY0pQOUpnNS93L0VnYXkwenhnZkswYzdPTWJKSTJCRFVKQTVN?=
 =?utf-8?B?YVJNcXVxT0ZtWHA3UWcyZVFuN2J1aUlMemhwYkNRMXVEOENDN1dZdVdCL2ta?=
 =?utf-8?B?VkRVNmZFZm1SWTJwQWZ5L01BY2lvVnhpaENOTzVIZEorQlo5QkpNbEVCeFB5?=
 =?utf-8?B?dGRwcVY3RHFPOHQ5MmJmbUN5TFZ5NzExb3F1U2NiV2dlNUlxL2pjQnNRVFRv?=
 =?utf-8?B?ZGhiMnNWb1hmeTg1eDFRTEN0aXk1TCsyZ0tvL2NYRGYvd2hOUFhCc2FGUUJX?=
 =?utf-8?B?YTNuNk1TUytSSi9xc2c1TkY5cGdLM0hldUdua01IUnpRa3JzM2ZIdFZFOTQ3?=
 =?utf-8?B?aEcrMTdwRzhpZGt0c0VNUHNYL1gyREY1Z01lQkZpQy8rR2Noak94S2p2blFB?=
 =?utf-8?B?d0RQVGNxcGNMK0NQVVZ6amU0YnYxektnbWRXNVI0dFArRG43d2F2ajV2RHNK?=
 =?utf-8?B?aGhkWVdncGVKYjRGM2d2ejNhS1RtdnQwSlFEdmFZNGg4dXBrL0FleUt4VExS?=
 =?utf-8?B?U1lnVGs2VktpQ295Q0FDekh1R1NhVkd5UmFQdU9NUXZEbkNYZEhVS1lta0JP?=
 =?utf-8?B?cE9xaWtMNHMxb1dOeFpUZTAzcUxKNm90RUF2WlEyWE9KSUlKeWVXaHI2VFUx?=
 =?utf-8?B?bmRmSkhzR0g0SStnNGhISmVOZTYxcEVBaGNnYURicDRZYkRJVVlQS09TWG9M?=
 =?utf-8?B?ZlZOeFVoNEFmZjhYMWFkMDg2UEZIaFk4d2IybFNDdlFNUURuZFZkbGFLWGl1?=
 =?utf-8?B?cDhMakVFVHB1eVVDanVxTFp6WENuOFBudVdBQ0ZYUGhNeExwRlZSTUxzVElQ?=
 =?utf-8?B?MTJGdmdjMDBCKzFUUlkrRWJ2aTJ3NXdGMXBsMVJlRktSRHlqVWdGZ2kvZFNl?=
 =?utf-8?B?TTFxMTJnb1JlTmxCb2RVMHllWHRVZnpPWkxUUGdJeWZ5LzkrQmx2MkNYbWsz?=
 =?utf-8?B?TVBwaDBTWk9aOVhpTERpN2JUcXIveDVIVUh1Z0dkWUk1WGNvUjU3UjR0b3hM?=
 =?utf-8?B?amdnWUFPaEE0UkZxUHRWZTFHOVAvSCthZVUzanhxcTdsaU9lSytpN2xxWWxk?=
 =?utf-8?B?R01LLy9lRVZhOS9zejhHSU9LZXRGZlpFWVpuTUx1TXROL3pSQ29Ga2FNZnNR?=
 =?utf-8?B?cGE4dStYcnJ1U1JvVU1IUmpSK0NVNXloOWVFQ3h1M3RMeDliTXhJUFpWVENt?=
 =?utf-8?B?N0RYT1IwYkgrSHJXUEFjMlpxQzRHeEVvbzQwdHgycVpCRWdVZnEyMlFyckQv?=
 =?utf-8?B?NnZmS2xyMlNxR1BOKzNabFQvYTI0dGJhZUtuM1p4NDlhV2lqVUhVbmJSTWQ1?=
 =?utf-8?B?SFVxUEptY2J4ZC91bURuYmd6TFRtNjJ5a1VHdW5uZjVmblUzQ1hzaTZJemt0?=
 =?utf-8?B?NE0wVFVkTVozM1VyMm5tdmR6Q2hGZG5nRVFzU0pEM2tnMjZjbDBaMEpYUjJ4?=
 =?utf-8?B?SkQvTmR6Z3Z2b1M3RUhBZGwxWW9jZ0pOeHdOeVp0czhhK2dhd0hPZVZWOWZm?=
 =?utf-8?B?bHEvNU8rb280dG5NNEY0RGdWdWFQU1VCeWI3Ull1bjNtNDBrOXcwMTFjcjVa?=
 =?utf-8?B?RTd0MGRrL1l6OENRY1Nic1hFRHZZNFBTV003RkYyOVNsQm1UR3BqcFhSemVP?=
 =?utf-8?B?ZXliUitWNXlheXgrSDNvdUhpV1l3dDA3UzJQZEpKemYxcXpQNXg1YUtONUdE?=
 =?utf-8?B?YjdmRzZPOTc4RkN3WUZOeTI4YURZdU1UTzErL1dXR2w5dXdhMnV5a0xCN2NL?=
 =?utf-8?B?ZEpMaHkweVlJWXFaOXBFOFFHaW5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D15BC7E02B94C47B0947549C4AEE34B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SMG6uwyP30iiQ3D1dRvKosRvjtaWJKppvVybEmdQVLHYYuTappwe757g6vUBmUN5B0EfSr1caIhdAgEGFIu8+W+3BooXW78CvBuNLVDJJSRVN2gGweJlRwM2cQ1j+uvGGItc7fxS0IQthPsBvEWlKZO4gFwIOiSwbp/fKQiKuDC4eL2iae7h4IbOTghZa7zPwxZQNX7b7gtCLqsyRRrkAeR+VQ39J88N3H2l3lIUJj3PwbGzRrVkqCowupxgu0BNNWY965Ms6PZ7qhNfP1nFzaBfZpOKB9boToGa3X1CP2EEW7xuHd0uEkiRmvN3Ss5to7Asu9JMt7oui+bhv6g+vOWF7sc2CXr1W58vIKhpvaRHv382l8kIGAGSWAcvbW/yBnkNRWsErqTjIk57GHMX9AOubIobgKEAwukH+BuVuTvzqz4KEaIn+rR4qCqAK+rYw1ze2QHigP1uCZvTn1kvQYfmOzQd4Q8Bciui4d44YduswnfCG5XM70B07uoVjQc/18DvTtNRYNMi6+ZMqsIJ9Jd1+7oEU3uGe1Ldp1mEtbI86wb4S3a4l0SswVg0OOOgYfb6LFYWokhKQcOlcdNKLFSgFNshv+EIXo9DPwakgcJ1eALYiqfmHiiY4RnC+ODq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d51f1e-544d-4c4d-8b52-08dca08b685b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:52:59.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yD1985RjuzMKdZ930YA1WpyETYZXVElvognU0Gv3/ubg4Ba4tMU1Nv1Ks8jwJvua4qPQ+pksgDbzk7SAndBkWu57EhswJZyEtm4X+7/foIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6274

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDIxOjM5ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IFRoZSB1cGNvbWluZyBzdXBwb3J0IGZvciBQQ0kgZGV2aWNlIGF1dGhlbnRpY2F0aW9uIHdpdGgg
Q01BLVNQRE0NCj4gKFBDSWUgcjYuMiBzZWMgNi4zMSkgcmVxdWlyZXMgcGFyc2luZyBYLjUwOSBj
ZXJ0aWZpY2F0ZXMgdXBvbg0KPiBkZXZpY2UgZW51bWVyYXRpb24sIHdoaWNoIGhhcHBlbnMgaW4g
YSBzdWJzeXNfaW5pdGNhbGwoKS4NCj4gDQo+IFBhcnNpbmcgWC41MDkgY2VydGlmaWNhdGVzIGFj
Y2Vzc2VzIHRoZSBibGFja2xpc3Qga2V5cmluZzoNCj4geDUwOV9jZXJ0X3BhcnNlKCkNCj4gwqAg
eDUwOV9nZXRfc2lnX3BhcmFtcygpDQo+IMKgwqDCoCBpc19oYXNoX2JsYWNrbGlzdGVkKCkNCj4g
wqDCoMKgwqDCoCBrZXlyaW5nX3NlYXJjaCgpDQo+IA0KPiBTbyBmYXIgdGhlIGtleXJpbmcgaXMg
Y3JlYXRlZCBtdWNoIGxhdGVyIGluIGEgZGV2aWNlX2luaXRjYWxsKCkuwqANCj4gQXZvaWQNCj4g
YSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ugb24gYWNjZXNzIHRvIHRoZSBrZXlyaW5nIGJ5IGNy
ZWF0aW5nIGl0DQo+IG9uZQ0KPiBpbml0Y2FsbCBsZXZlbCBlYXJsaWVyIHRoYW4gUENJIGRldmlj
ZSBlbnVtZXJhdGlvbiwgaS5lLiBpbiBhbg0KPiBhcmNoX2luaXRjYWxsKCkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4NCj4gUmV2aWV3ZWQtYnk6
IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTog
V2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBjZXJ0cy9ibGFja2xpc3QuYyB8IDQgKystLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvY2VydHMvYmxhY2tsaXN0LmMgYi9jZXJ0cy9ibGFja2xpc3QuYw0KPiBp
bmRleCA2NzVkZDdhOGYwN2EuLjM0MTg1NDE1ZDQ1MSAxMDA2NDQNCj4gLS0tIGEvY2VydHMvYmxh
Y2tsaXN0LmMNCj4gKysrIGIvY2VydHMvYmxhY2tsaXN0LmMNCj4gQEAgLTMxMSw3ICszMTEsNyBA
QCBzdGF0aWMgaW50IHJlc3RyaWN0X2xpbmtfZm9yX2JsYWNrbGlzdChzdHJ1Y3Qga2V5DQo+ICpk
ZXN0X2tleXJpbmcsDQo+IMKgICogSW5pdGlhbGlzZSB0aGUgYmxhY2tsaXN0DQo+IMKgICoNCj4g
wqAgKiBUaGUgYmxhY2tsaXN0X2luaXQoKSBmdW5jdGlvbiBpcyByZWdpc3RlcmVkIGFzIGFuIGlu
aXRjYWxsIHZpYQ0KPiAtICogZGV2aWNlX2luaXRjYWxsKCkuwqAgQXMgYSByZXN1bHQgaWYgdGhl
IGJsYWNrbGlzdF9pbml0KCkgZnVuY3Rpb24NCj4gZmFpbHMgZm9yDQo+ICsgKiBhcmNoX2luaXRj
YWxsKCkuwqAgQXMgYSByZXN1bHQgaWYgdGhlIGJsYWNrbGlzdF9pbml0KCkgZnVuY3Rpb24NCj4g
ZmFpbHMgZm9yDQo+IMKgICogYW55IHJlYXNvbiB0aGUga2VybmVsIGNvbnRpbnVlcyB0byBleGVj
dXRlLsKgIFdoaWxlIGNsZWFubHkNCj4gcmV0dXJuaW5nIC1FTk9ERVYNCj4gwqAgKiBjb3VsZCBi
ZSBhY2NlcHRhYmxlIGZvciBzb21lIG5vbi1jcml0aWNhbCBrZXJuZWwgcGFydHMsIGlmIHRoZQ0K
PiBibGFja2xpc3QNCj4gwqAgKiBrZXlyaW5nIGZhaWxzIHRvIGxvYWQgaXQgZGVmZWF0cyB0aGUg
Y2VydGlmaWNhdGUva2V5IGJhc2VkIGRlbnkNCj4gbGlzdCBmb3INCj4gQEAgLTM1Niw3ICszNTYs
NyBAQCBzdGF0aWMgaW50IF9faW5pdCBibGFja2xpc3RfaW5pdCh2b2lkKQ0KPiDCoC8qDQo+IMKg
ICogTXVzdCBiZSBpbml0aWFsaXNlZCBiZWZvcmUgd2UgdHJ5IGFuZCBsb2FkIHRoZSBrZXlzIGlu
dG8gdGhlDQo+IGtleXJpbmcuDQo+IMKgICovDQo+IC1kZXZpY2VfaW5pdGNhbGwoYmxhY2tsaXN0
X2luaXQpOw0KPiArYXJjaF9pbml0Y2FsbChibGFja2xpc3RfaW5pdCk7DQo+IMKgDQo+IMKgI2lm
ZGVmIENPTkZJR19TWVNURU1fUkVWT0NBVElPTl9MSVNUDQo+IMKgLyoNCg0K

