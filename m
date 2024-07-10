Return-Path: <linux-pci+bounces-10035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F301892C8BD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A81C22222
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959F1803D;
	Wed, 10 Jul 2024 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EOCWiUcB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I4JauXJL"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCD17FD;
	Wed, 10 Jul 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579791; cv=fail; b=HC8/kxDIeMWUEAo5S+x2X3NJLqGaxIsnM8uI2QJHN2IpFt8S9oLTsB5A7iLWgbMC/8u74MivtqyoGVtDJKyEjOx2C3FmmQvO4msGdnfYLqNsT8X1xkEZBfW8uqpSaNnFdsmFngoFSSk6ZU8iHiNPntr/djNIGlCJgPcvNlnoUTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579791; c=relaxed/simple;
	bh=DIu7Ig9/DurUtYvqQMH4TtWCtOWMx23eVHVt0wzpDiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIiPOacxlG7m9Ac6+jlPc1+JiZvCaw89Auhgv6cmkOtAdZ4RXsm2qkD3xqKYqqw8gN6VG3rfxnGYyPcm96TdgShV/PddQ149fW+4YTNE3k9iDScHxnPHOTL4yy5ZhS7GC/+31OaajfalfgyXW8u0sDq85q/c3dZvn6zTRDenayM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EOCWiUcB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=I4JauXJL; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720579789; x=1752115789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DIu7Ig9/DurUtYvqQMH4TtWCtOWMx23eVHVt0wzpDiE=;
  b=EOCWiUcBaFTVxULOpI4y86eB0wRR9U9jTn5dmep8VX7pt+hIYcB4i/Ju
   zvZA0pQFGcGCj0luTNXCO9bou11Mn37bAtB3iG5QJ6br7mcLizXvOvwG8
   CIxGOR7eYMCy2GjVP54jkPWf0THOl7a8krNbP2iq8pb4sXdLXmbhAIyOw
   5ypnDMub90QsGABnHemztoLyX4nzO24PZ4JXX/opJT6tzEXZvZ70PR0S4
   ThfID8nXJMBBugRUpxPTF362M8MlAku+GqIECDcfZATzydkMizit9KitK
   bLBcgPjP1TMHfUbM3v9d/KdrIDAaAJ+0E7poHZzB0Xc1699GLCv4DZrst
   Q==;
X-CSE-ConnectionGUID: CROypvBNTt+84B0S6D5sLA==
X-CSE-MsgGUID: w2lc32QpTaWhmpPpdUDS7w==
X-IronPort-AV: E=Sophos;i="6.09,196,1716220800"; 
   d="scan'208";a="20486610"
Received: from mail-westusazlp17012037.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.37])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 10:49:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAeulm4WHxS1T9mGq+sea6jqXItMM7zztne415nSjF8NLUNe2QupBJo6OU1+UJ/cpQj/6qfyIR4G6OnrmZkmtdhpMWAbwmpBT47mVuV+mUPxweetF9FH7jPbYyKmwHkXBnK1Vtl88JzWis8t9svwuEIvsYIGnFd/02IpCiaasAgmTKD0rFtVbEpnB1BOaivsLdhJfi4udzfu+ytH6qp4QWjt4OklsZOv+4LkE9HsbJq14UjbxIy/XMqFAareKZbKeGj2N52aUgpPN9HjbLIx9MhlIuTCkIppvFPf92m+25bxbWSTIA23tyQ4uHKtU0fQiPQHzhHW1dXEWwnp8Iq4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIu7Ig9/DurUtYvqQMH4TtWCtOWMx23eVHVt0wzpDiE=;
 b=Eq/9V9DKwdB6lmlKM/fJ1DeNsxrrRCtuSThQdQpmEZIF9NWmeQ9nivfphfhOwb8Y7smY23x9yWAKVCOIRfmUWlEpl7Z0SnUffh4SvSDNkRkrXrYADtwLd3niBbYNT/YgiUNRuEanidtkRMrHguBWfJPezdYws2me3tDC1ZkA7B3Q9i5Yt+CHXeyRQRMCh8T96stBpvL2BV6+hIzO9cn60Rp/UOsUFn4/LyFuTdCdPD7NFKRi9k62WWJZNTVwoyx5wLcgD0e+jm/thth7KJugUeJ4kyEDEh9fKr5aej5N8VKJAWGOpwyk+v2VBnuploI5Q4Mwq5sTx9mxN/JBeiTvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIu7Ig9/DurUtYvqQMH4TtWCtOWMx23eVHVt0wzpDiE=;
 b=I4JauXJLi5bL8w82/bdmF1KegG312rvrP2WO4S+xviXCAHISz24ZQI6i/yBwhjlNtDwcfboIx/C5KlALkhyCbpNiQiKJ3IaBP83DP9JHwo0TxY4fAaqyLnXvTKv/y1DVTjcMLELXBwSYtAIsnONfQxfCHjkM+YWspG6Q1in13yQ=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by BN8PR04MB6274.namprd04.prod.outlook.com (2603:10b6:408:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:49:44 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:49:44 +0000
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
Subject: Re: [PATCH v2 03/18] X.509: Move certificate length retrieval into
 new helper
Thread-Topic: [PATCH v2 03/18] X.509: Move certificate length retrieval into
 new helper
Thread-Index: AQHayyh0q27be4RtKE2BN7CB7ODyTrHvUVGA
Date: Wed, 10 Jul 2024 02:49:44 +0000
Message-ID: <596454bb53def80a3b84f8e37a09973ecce531d9.camel@wdc.com>
References: <cover.1719771133.git.lukas@wunner.de>
	 <cf34e283103de55b07fcddcbe39b60ea32b6d891.1719771133.git.lukas@wunner.de>
In-Reply-To:
 <cf34e283103de55b07fcddcbe39b60ea32b6d891.1719771133.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|BN8PR04MB6274:EE_
x-ms-office365-filtering-correlation-id: 91cb117d-1d8c-458b-69bd-08dca08af45e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWsvWS80MlBkK3N4YTBxRnZiN2xrdXJkeTg4L3FKNGJqM0NxNGZOa0JWQlg2?=
 =?utf-8?B?K3dqK3paRVJhSlBmN2FmMGRjQ2xjdDYzTDU4Qm9hMEJYN2xtK3VULy9IN3B3?=
 =?utf-8?B?V3RHTW0zd0VWSHNEbE5EUDVYajhPRGx6bTBHT3h1d2ZGQUJlRldaMXJFQVlH?=
 =?utf-8?B?L2o3SW9ZSnNUTHY0eDRVaFZ2OTdHRnpTQzdCaWpkdTk5SWVjTzZXbStvRTY3?=
 =?utf-8?B?ZU9SOHZUL0Z3Yyt5THdyeDNZU2ZKR25XS1Z1OUFqTXV3YUhhOTNVSE9RZ2V0?=
 =?utf-8?B?UXo2cXQ1dkJyaW9lRm9ZaWpBTnZLVTdMdkVkUmgvUmNTbEZXNFFHTmxwNHhQ?=
 =?utf-8?B?WFc4UlFwQWlEVko1MmVxN1ZpamlDZzF3aHZSc1hVZXNjWkE0MFJoR1FacU9T?=
 =?utf-8?B?enJuWFdHNWFCRWNPemxDbXVJT0NLRDNXeUN6SlBEcnA3bXN6RFVid2FMLzJx?=
 =?utf-8?B?cW90UEJRRGtSMTB0ankwSUNsUGZoS01pUUpUWG9zUXIyNXhXOEMvTzJCN1hD?=
 =?utf-8?B?SjBBdlI3UkFUL3ZTMm8xSzZ2LzkzS0JQYkV5YmlNYm9ScjF0UVFNVStXczV5?=
 =?utf-8?B?UGFzSU1FM1JlYm9xMkdrOUZ3V0dGV2ExN0FtSm1MZGtGV2FoMFdhNlo1UCtT?=
 =?utf-8?B?Y1Q0Z0dLWm1NWWEzbFplTjE4ZTM4ZFJMZG5FSG43bTBvbWltQU4wb3lCMkU0?=
 =?utf-8?B?di9tQlR3WTV4TnJuRkFJelpkb1psSXRWYXFEbkhPaDU2RS81WXVMcnJPcGoz?=
 =?utf-8?B?dndWUWhnOVVLK2gzOHZJT1JRQm5JMlJWdjRlOEpZVkZ5ZDJpbndFNFZRSkIv?=
 =?utf-8?B?NXRpYngrbUg4UUVMUE1KR0ljTFpUYmptTlplbmI1RU15SEg1OVB5TG5kTWFu?=
 =?utf-8?B?dExtRTE1Tkp2VW14UmY3c05zSkcwRDdmeEM4WGhBSHg1UExnY0FyUEdSVisw?=
 =?utf-8?B?ZzlmSXZYdGI2MWdjWEJmdnNNd0QxOFRSYXFLc29WL3l0WWhwYzNPdG9JYUdP?=
 =?utf-8?B?YXh5aXNneUdSRUthMzZENEh5aG1uSGlUc29TeXBjTTFKcUdZOGZTUS9qTHR1?=
 =?utf-8?B?ZlkzRWpyTDNPUE52U09DMU1VRXpldG1ZK2I3ZVhnRlI5bmNwSWE0S2NRajB3?=
 =?utf-8?B?V0F0Y1RTWk55Lyt2cGt3dzNHZWRYeXBMQkFuOTVudnNlRmFMb0lKeUNuRHBz?=
 =?utf-8?B?QlZjK2tQVktoVE9zcEhIaWFSTElFZm5DV1F5RVRHUXhzcFM0QUduN204OURo?=
 =?utf-8?B?SmJBTHNqREFQQkI0YzJMajk1S1BERzJ2WVBhOVBHcGdQLzhld2tzSXVIM2p2?=
 =?utf-8?B?WnBlOW9uc1l0NEpWTmh6ZzFHdCtuSmhYZWVjNHNsUWUwUkF1WTJac3R6VzRh?=
 =?utf-8?B?Um94T3NVNVJCa0NCelFUdG5vaU9laWp4Z3p0eEg3QUlRUm5JVmlxV3FrcmJr?=
 =?utf-8?B?WHB3L01sd3pwT3JDYk1CS3ZKSXRDRTdQZnRLSk1jTkhQTm1zWDVFUG5ubzht?=
 =?utf-8?B?c3UrWExvZ1N3cGFFdEkzbE1xTGJiSHRFNTc5Zi9qbnE0SWdHMVpKdmwybnY5?=
 =?utf-8?B?UDd5RWRFWGdZQXVSZEMxa2EvdU9WTmlBZG1IMUUzT0NrTlh3RnE1MjhJVVVH?=
 =?utf-8?B?QThFVUhMZldLUkREbCtiWlhxZTBlTmR1M1hxR0xNbFdLMEl3SVdxcWhhVS9N?=
 =?utf-8?B?elI0aEl2dmc3NTdjQytIYTZQTk9ObGtwSkszS1FtaDVDbW5ydm1KTVQxOENE?=
 =?utf-8?B?L1EweVhWclhsYkM1MmNkZXJra3ptYXJ3cXZBVElGRC9ubXpTSEtqYnhQcXgy?=
 =?utf-8?B?M1BMbXlYTElRd3JEcFJsQTNzRUx2UjJEWVI5MFkwR1RDSnU0V3JhSTFjRUZU?=
 =?utf-8?Q?z0AexIoyFgtwN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjlneVBJL2JuU3RrdUQ5T0JTOWl4c3VVcGo5MUd0alExUktmeGtDaTBYSVZJ?=
 =?utf-8?B?OXFlWEk5QzNBVXp3VDc1WERYUXdGb2pXQ25TK2NMMitwOGIwU1JvcVRqNnd2?=
 =?utf-8?B?VnlGVkZZOW9BWHVFcEpVZUZzYUw3d0ZmTjlLS0JDeG9zQnU2MUMveDZBZWNx?=
 =?utf-8?B?SXBGUm0zaVByRU95bnFTbndXYnNKeWNMWkxrRFB6bW9Pekd6RzBUYUpmRy92?=
 =?utf-8?B?MmxHQUx1YkZuM2k1NGV2aGc4ZSsrV0FjQ2FWWnRGVk9pRnlsbzJzYk1wVjVq?=
 =?utf-8?B?UUpsUmZNR3F4TmFOOExFY2x3eTdneHh6ZGhWWDFIZkJUblp5M0MwVlFhU1Bv?=
 =?utf-8?B?dEhtU1pZL3lxWjMwWlQwUGk5TEg2L1o0a25aMmUwby9wNXBNZndEdXVzbXNl?=
 =?utf-8?B?VWpTMTFhL2lidzhIRktGM1R0N25NTmZ4VmxjRkxJNGIydGJVdDNBT0l0aEIx?=
 =?utf-8?B?cXlKcVQxVHkyUVkyTEFMVFAzb09DcHNoQzdHWUdQNElvQlFFVTU0UXF5TTdD?=
 =?utf-8?B?VzNJWkg0bXJtbG9YU085RitjVlRWVlFvL3JFRlNsTEd4eW84c0FUY2paK0lk?=
 =?utf-8?B?S2lLOVhPREFkMFZqaVVIYk9uTGUwd1prRjUzcUVyYXdHNXAvdUdjOEkvTFhE?=
 =?utf-8?B?NXUxdG8xVVZ1ZFhMZVBIZEFiWHo3em0rcDNUYUtrTGFKUHlISjZGdW4xK3pk?=
 =?utf-8?B?RUZJU3UxajRMZXNnWDc2VEZWN1B3U3RNYnBEQmQ5QXB4SjJUK3ltaUNLTjJr?=
 =?utf-8?B?R3FMSGNBeG1iRkpyRmpHNGpKdzh5TUZESkFkZUdBZ0p0NmEwSnh5b2VTb2pY?=
 =?utf-8?B?L0IzTjZMVkh3cWh5VkxBRmQ4VUI2cTFzRGZLMkJWOHlQbHk2d3pHY1hYZExy?=
 =?utf-8?B?MWhKRHdKMzV0ZHlWWmZaT1hRemxtQlRUQlYwcjJCaHlPWWJLQi9nelExdTBN?=
 =?utf-8?B?ZmF5TUtKVGYzb3BvbndLV0VaVThQMHZ4U3NpSjJMcEpyU3RsaU5ZdDI2S1Nr?=
 =?utf-8?B?VWY2b1pBSTk5L0pFVkUxcTlCcnpyUTYrMFVEc0dydUx4UEd2eUdYZk0zOGdn?=
 =?utf-8?B?YmxFdnRWNUJodk9RL1FpYWxwbG96S1hMUXZlQllPUmF1SzdXNVNtR3g2NE16?=
 =?utf-8?B?WWQxM3JET3NtbWkxdmdxR2pGMnZaT0tlQUR4MW53c1dpUlF4VW82bWRwaTha?=
 =?utf-8?B?WXBCbi9mTnJMM1VQdmpDV2ZlVGY0VmVHZmdndmhTYUtVdW1vTTl0OC9wamVz?=
 =?utf-8?B?WGRCMFVON1RjN1VPbzI2OThhQXc0ZzdReFF6OEpXa1VCdDBuc0lFT0hkdnNn?=
 =?utf-8?B?aWt2T2R5RldIK01rRE55SmlEdEkyaEE2Z2Q4bWRucWpQMGc0K1l5Y2F2R3FB?=
 =?utf-8?B?MkcyR2lWenNXTmVaVy9oTWZVd1A1M1oycVBCc1Z1TThIVHYzUlpsSXFLSzVE?=
 =?utf-8?B?c0s3NUJFTjRweUE4L0RwMExrNzJDbno2MllFK0VsSDNwMjBpd1h2SEQ4KzlM?=
 =?utf-8?B?UDBHS3hYcUJGQUxJQWRRK0xyYVNPQWg0R3BPT3VnVnZ3Y1B1Zk54NXpHOWFV?=
 =?utf-8?B?aldWU2I0OXo4MHpZTVljWlc0N2lOMytld0JqYWJ2Yy90NGtVamJ1TzE4QURl?=
 =?utf-8?B?NExZUUhqQkIrNlhLTUVJS1VnZGptZEpnakNKRXBmWGZaZlNZL0VYZXJyLzd1?=
 =?utf-8?B?a1NSQjBrcDIvS04veDl4NkJDR05lS01Fa2JTUHBJa3ZONVpBdU8rWGlUU0xv?=
 =?utf-8?B?V3F6ZDhUOGRuWE9VcHZLM25LUlRsOE9MZkVydFhBaHo3cmlzTm9QTFI3Qmpo?=
 =?utf-8?B?REs3UWo1U3ZSOHRVZThRaU5ZYTZ1OFVIMEJJZWJ0WGlDSlI4Vnhpb2RHTW5M?=
 =?utf-8?B?UmFYT05VRGhFM0hxTUtyNGRDUzlMeFlSQk5rQzM0b1c0SS9qK0x6Z29HclRt?=
 =?utf-8?B?SCtjL1dtNk1JbEFJemdqRHQxQzY5bVRmUk9lbkk3UUg3bnBLQXhzQXg5VmNy?=
 =?utf-8?B?VUs2eml0ZTRacXNZTFN4ZXlxdS9kM3pRMGFIcnl6cHlnV2xQeDViMjI1RGhQ?=
 =?utf-8?B?R2c0NXdaelhVdURnRmZTNC9EdTZRNG5iVWowcmxiTER4bTJnVFQxZ0RhNk9p?=
 =?utf-8?B?Rm9ZVVhnQ3NVNXBlcFIwekhCY2V1QU0rdnVFK1doMTEyQzdXVS82R2pUMUxP?=
 =?utf-8?B?eWtWRFAwdmRvSGJHeDE0MkIwdUNMVHdjK3MyLzVmVVV1MDdzejNsY0w5MHVh?=
 =?utf-8?B?QkgxejJCaHNZaEMwMnNoVTNIR1BnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F754948AF4221A4A8BF593A7F90D730A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6PNL+4BvuT9aEyP/AEaqxw0PD04kn9yHvtHxL72k0W6A6RdgYh7bGI31YFzSs497CgyVqd0YbCYL8dKDdqtgRKyQs6lWbNXuqdSmeNiIJLTm59jmc3+v4Aki8tWTmtToCm10+k3WshWpZIgpQfyydEXsIvX8fyS1YTueWpa3OoxleJoM09/Kf9q6mwKPgDqSghbI8/bUv3YqwQVQc0cEIt0YRXuYajvIVeyaiQ4NaOlOyej7Yx1Tej1mByLT/6E1fxo9V3RotoU3OF0+lYX0z6Sm9apX23a8dAoLfdLK/BbhTEU5qYHWJJJmJNyTgrWF0DOPpxoRbPOwZOWB1HpbFMsT2vksTe2w57XT3wr2tJe8a1aBKtG+fFL28Flpp1TaeT8lR2eH0w4iU+cDHzBzJJZNhFu7ALz33703YxDh/cCdfTFNwOCtyIW+8N31rC2V6DnYsZyKZPtVFqah0M4hAzeos84XerFObPrOZZG4hEAtTAeTknWONAs3qUv+SAnD9ia8NMtRl7e5rPlv7rebV9sm3JguHHH3rK12ZJPxsWeUgswT9TtSBi75bO8RPY5lUskVbtgRTCij36aadi49cj4jUQepv8wFzfDVqd4ZRKXfef5WT8CJbQsyKRRZHxyT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cb117d-1d8c-458b-69bd-08dca08af45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:49:44.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pn/5Po6etbXzm0Ic0Y0x9CUgmoTkAfa8unHu8vs6u4K897Nbuqbf9H8BYxFj6wysS/KSy8w8AD0MVHZQAf8c2ntJ2UmpqNaKAAMylbpGM2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6274

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDIxOjM4ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IFRoZSB1cGNvbWluZyBpbi1rZXJuZWwgU1BETSBsaWJyYXJ5IChTZWN1cml0eSBQcm90b2NvbCBh
bmQgRGF0YQ0KPiBNb2RlbCwNCj4gaHR0cHM6Ly93d3cuZG10Zi5vcmcvZHNwL0RTUDAyNzQpIG5l
ZWRzIHRvIHJldHJpZXZlIHRoZSBsZW5ndGggZnJvbQ0KPiBBU04uMSBERVItZW5jb2RlZCBYLjUw
OSBjZXJ0aWZpY2F0ZXMuDQo+IA0KPiBTdWNoIGNvZGUgYWxyZWFkeSBleGlzdHMgaW4geDUwOV9s
b2FkX2NlcnRpZmljYXRlX2xpc3QoKSwgc28gbW92ZSBpdA0KPiBpbnRvIGEgbmV3IGhlbHBlciBm
b3IgcmV1c2UgYnkgU1BETS4NCj4gDQo+IEV4cG9ydCB0aGUgaGVscGVyIHNvIHRoYXQgU1BETSBj
YW4gYmUgdHJpc3RhdGUuwqAgKFNvbWUgdXBjb21pbmcgdXNlcnMNCj4gb2YNCj4gdGhlIFNQRE0g
bGlicmF5IG1heSBiZSBtb2R1bGFyLCBzdWNoIGFzIFNDU0kgYW5kIEFUQS4pDQo+IA0KPiBObyBm
dW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzIFd1
bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KPiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKg
Y3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2xvYWRlci5jIHwgMzggKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0NCj4gLS0NCj4gwqBpbmNsdWRlL2tleXMvYXN5bW1ldHJpYy10eXBlLmjCoMKg
wqDCoMKgwqAgfMKgIDIgKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NyeXB0by9hc3ltbWV0cmljX2tl
eXMveDUwOV9sb2FkZXIuYw0KPiBiL2NyeXB0by9hc3ltbWV0cmljX2tleXMveDUwOV9sb2FkZXIu
Yw0KPiBpbmRleCBhNDE3NDEzMjY5OTguLjI1ZmYwMjdmYWQxZCAxMDA2NDQNCj4gLS0tIGEvY3J5
cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2xvYWRlci5jDQo+ICsrKyBiL2NyeXB0by9hc3ltbWV0
cmljX2tleXMveDUwOV9sb2FkZXIuYw0KPiBAQCAtNCwyOCArNCw0MiBAQA0KPiDCoCNpbmNsdWRl
IDxsaW51eC9rZXkuaD4NCj4gwqAjaW5jbHVkZSA8a2V5cy9hc3ltbWV0cmljLXR5cGUuaD4NCj4g
wqANCj4gK3NzaXplX3QgeDUwOV9nZXRfY2VydGlmaWNhdGVfbGVuZ3RoKGNvbnN0IHU4ICpwLCB1
bnNpZ25lZCBsb25nDQo+IGJ1ZmxlbikNCj4gK3sNCj4gKwlzc2l6ZV90IHBsZW47DQo+ICsNCj4g
KwkvKiBFYWNoIGNlcnQgYmVnaW5zIHdpdGggYW4gQVNOLjEgU0VRVUVOQ0UgdGFnIGFuZCBtdXN0
IGJlDQo+IG1vcmUNCj4gKwkgKiB0aGFuIDI1NiBieXRlcyBpbiBzaXplLg0KPiArCSAqLw0KPiAr
CWlmIChidWZsZW4gPCA0KQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCWlmIChwWzBd
ICE9IDB4MzAgJiYNCj4gKwnCoMKgwqAgcFsxXSAhPSAweDgyKQ0KPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gKw0KPiArCXBsZW4gPSAocFsyXSA8PCA4KSB8IHBbM107DQo+ICsJcGxlbiArPSA0Ow0K
PiArCWlmIChwbGVuID4gYnVmbGVuKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCXJl
dHVybiBwbGVuOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwoeDUwOV9nZXRfY2VydGlmaWNh
dGVfbGVuZ3RoKTsNCj4gKw0KPiDCoGludCB4NTA5X2xvYWRfY2VydGlmaWNhdGVfbGlzdChjb25z
dCB1OCBjZXJ0X2xpc3RbXSwNCj4gwqAJCQnCoMKgwqDCoMKgwqAgY29uc3QgdW5zaWduZWQgbG9u
ZyBsaXN0X3NpemUsDQo+IMKgCQkJwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBrZXkgKmtleXJp
bmcpDQo+IMKgew0KPiDCoAlrZXlfcmVmX3Qga2V5Ow0KPiDCoAljb25zdCB1OCAqcCwgKmVuZDsN
Cj4gLQlzaXplX3QgcGxlbjsNCj4gKwlzc2l6ZV90IHBsZW47DQo+IMKgDQo+IMKgCXAgPSBjZXJ0
X2xpc3Q7DQo+IMKgCWVuZCA9IHAgKyBsaXN0X3NpemU7DQo+IMKgCXdoaWxlIChwIDwgZW5kKSB7
DQo+IC0JCS8qIEVhY2ggY2VydCBiZWdpbnMgd2l0aCBhbiBBU04uMSBTRVFVRU5DRSB0YWcgYW5k
DQo+IG11c3QgYmUgbW9yZQ0KPiAtCQkgKiB0aGFuIDI1NiBieXRlcyBpbiBzaXplLg0KPiAtCQkg
Ki8NCj4gLQkJaWYgKGVuZCAtIHAgPCA0KQ0KPiAtCQkJZ290byBkb2RneV9jZXJ0Ow0KPiAtCQlp
ZiAocFswXSAhPSAweDMwICYmDQo+IC0JCcKgwqDCoCBwWzFdICE9IDB4ODIpDQo+IC0JCQlnb3Rv
IGRvZGd5X2NlcnQ7DQo+IC0JCXBsZW4gPSAocFsyXSA8PCA4KSB8IHBbM107DQo+IC0JCXBsZW4g
Kz0gNDsNCj4gLQkJaWYgKHBsZW4gPiBlbmQgLSBwKQ0KPiArCQlwbGVuID0geDUwOV9nZXRfY2Vy
dGlmaWNhdGVfbGVuZ3RoKHAsIGVuZCAtIHApOw0KPiArCQlpZiAocGxlbiA8IDApDQo+IMKgCQkJ
Z290byBkb2RneV9jZXJ0Ow0KPiDCoA0KPiDCoAkJa2V5ID0ga2V5X2NyZWF0ZV9vcl91cGRhdGUo
bWFrZV9rZXlfcmVmKGtleXJpbmcsIDEpLA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9rZXlzL2Fz
eW1tZXRyaWMtdHlwZS5oDQo+IGIvaW5jbHVkZS9rZXlzL2FzeW1tZXRyaWMtdHlwZS5oDQo+IGlu
ZGV4IDY5YTEzZTFlNWIyZS4uZTJhZjA3ZmVjM2M2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2tl
eXMvYXN5bW1ldHJpYy10eXBlLmgNCj4gKysrIGIvaW5jbHVkZS9rZXlzL2FzeW1tZXRyaWMtdHlw
ZS5oDQo+IEBAIC04NCw2ICs4NCw4IEBAIGV4dGVybiBzdHJ1Y3Qga2V5ICpmaW5kX2FzeW1tZXRy
aWNfa2V5KHN0cnVjdCBrZXkNCj4gKmtleXJpbmcsDQo+IMKgCQkJCcKgwqDCoMKgwqDCoCBjb25z
dCBzdHJ1Y3QNCj4gYXN5bW1ldHJpY19rZXlfaWQgKmlkXzIsDQo+IMKgCQkJCcKgwqDCoMKgwqDC
oCBib29sIHBhcnRpYWwpOw0KPiDCoA0KPiArc3NpemVfdCB4NTA5X2dldF9jZXJ0aWZpY2F0ZV9s
ZW5ndGgoY29uc3QgdTggKnAsIHVuc2lnbmVkIGxvbmcNCj4gYnVmbGVuKTsNCj4gKw0KPiDCoGlu
dCB4NTA5X2xvYWRfY2VydGlmaWNhdGVfbGlzdChjb25zdCB1OCBjZXJ0X2xpc3RbXSwgY29uc3Qg
dW5zaWduZWQNCj4gbG9uZyBsaXN0X3NpemUsDQo+IMKgCQkJwqDCoMKgwqDCoMKgIGNvbnN0IHN0
cnVjdCBrZXkgKmtleXJpbmcpOw0KPiDCoA0KDQo=

