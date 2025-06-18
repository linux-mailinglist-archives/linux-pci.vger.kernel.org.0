Return-Path: <linux-pci+bounces-30057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DECADEE67
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B13C404624
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386D2E7186;
	Wed, 18 Jun 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="HV2QLe+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6042EA72E
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254671; cv=fail; b=RBf0vyWFwkvjKyr7qnmZD3uRJaMOdGw79YVhghS4i8Wj9/6rKUV9eh7x5pYJprwcclxPbOSyzoPd2eyvPJwNeEhiqjnU5Xu8ija48yYEXr7HucV30W1XqY0tofIhyFNo1FxUjr8EJ/bBaGrCyiozuR/0g1C5UXPEEo6E7G4ZCi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254671; c=relaxed/simple;
	bh=wOriKq5uibQHWoJfSGle880qsFYeSp1iW8kcSoWT9NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jShYqeZ2BebHv4qyLnI7p22CkljIJtsSPWczjhDgPHK9KiOyOnGO/nX2GBnT7Xz1jE7yt33OaUnDHwptN1dqkamI1PKR6OKsEMlNPZHm4riA+oZmrkQ03omUkClgqWzwvtfsA/cDLOe0TqhUI2+oCZx8smGzCKBTr8oFNWJx4po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=HV2QLe+t; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8K7YLUVjJqRGu+ndB6qJRGA4RPV2LvO3JDahqbk/SiPP7yDwN9yXV+lGUz0uB/J+ra+mW4SP67p5bwopx+PfFuYjF65x2QtfVigGzBzIqYGwLikBfA96jfAT3L+RuDx5UpGYKKOE2FYwg5YqN8mff73o9Bo6mP1DWu0xc8SkSY5IVt17eTYGjoOKhaMPfw6S8JuqvHiqVvDOITB9nVBEIq9onaYL9WodkDuYk4OzfscwZ20nq4azYYpoRyM2gUETWV1QJAJV3Z7ZJS1dqa6U8GFsOPPs5mVz97eGCT8PcmfFUG+eNSSCdTR09fRj19GI/nXjHIdsHa3bhILIDBLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOriKq5uibQHWoJfSGle880qsFYeSp1iW8kcSoWT9NQ=;
 b=GDtXQm3S6laGRJhVSFWRGU3hHna71uC6n9zAjIJt71xBBXlHadfuASOE1NbjYuyVAy1DrD4loNjGRR4JWDe9zQ2K5s175p/PMrbcM/ycWu230/LMfS9bNnuaUjiKh2iJOBXLcdaNu6Wh0JEenuTVHQpLVCye6iqFIxFcaBZ9MNooPBb02Sw4bysZqkPKuv7n/617qASh4ksugmYNPNVjVUQnZoIqQUnTKnVGIIm3OTni0WtNQFGWqoJVHb0hgcqjU77ufGobR+Jjx1rrt5aMu/X0DB301Hq7B3pI/aC4Lqkl1gfcjPlKW0IoRorMy+UHGytqjop2/oDuRpyaRu7MeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOriKq5uibQHWoJfSGle880qsFYeSp1iW8kcSoWT9NQ=;
 b=HV2QLe+tffGZSoMlkXuytUxCCTMsFkOveUx8IZ1G+9SPvWjXmi6cGh8bzmzSOYV/QZ1S6WE/EU6NvdpqtmgnYNo16Jw+gSgvN5DRZoFpdwzOI8tL4UHeGe4tPPfzYFXDMzaZ0xl9jrM3osli/KCIpxZUS7AIiPtjtozyNGLhLLU+IgBlUyxNmbIWOX0FQY8IAEYBxiqOgp7BhKSudDY72wiVCugQKtomrSBMhm568m/grudm1xbzfOx9eroaWXRkSVIQuucjiigi4efPMGAeScjFKMkNPnFQQd4+otCBoc3tCIjUt4jlPdBPBvfCc9HgKMUHn7bkdTGcUAQYaXVZeA==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by DU0PR07MB8995.eurprd07.prod.outlook.com (2603:10a6:10:40d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 13:51:04 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%6]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 13:51:04 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable windows.
Thread-Topic: Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable windows.
Thread-Index: AduRobXJsAHUjsNzR1qfymrMhkfNeBJVpIWAAVfW0vA=
Date: Wed, 18 Jun 2025 13:51:04 +0000
Message-ID:
 <PA4PR07MB8838742931C0CAE52B808C92FD72A@PA4PR07MB8838.eurprd07.prod.outlook.com>
References:
 <PA4PR07MB8838163AF4B32E0BF74BDFD3FDD62@PA4PR07MB8838.eurprd07.prod.outlook.com>
 <obwqe4etp2cccwsnwiucgqptgcxkufjg3ryy5pdpgqrtzpets4@4nrtnghxgubf>
In-Reply-To: <obwqe4etp2cccwsnwiucgqptgcxkufjg3ryy5pdpgqrtzpets4@4nrtnghxgubf>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|DU0PR07MB8995:EE_
x-ms-office365-filtering-correlation-id: 0cdea506-2242-4e28-e516-08ddae6f2b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWx0ZWl3QzQ3YS85WFFxNXBYaU9uMW4xWUhFUC92OUFXL0x6WUEzZ2ZEM2Ez?=
 =?utf-8?B?a0Faa3J2SjlQWVpVMUh5K0UrOEVKekEwKzhtMjVKRmhhcDZoSDVjNjhyZTkw?=
 =?utf-8?B?RXBYRThtZ3dNTnhDUG00bTRMWnY1ZlRpMEhPWUhld0RXd3lpUWpRQVBqNWNJ?=
 =?utf-8?B?OThsaSthNHhDb2I0ZlA0cXNGNlJ2cFhqTzd4SkZFUWg4bE05WDllSU5iK3U5?=
 =?utf-8?B?MitnODR4K0xCaXVjOW96TUpBTG5waEJIUWhWWGF2K2k0b1VteW1Lem5BdlQ2?=
 =?utf-8?B?U3BLTjJ1bmZKM1lkbjB5Vk01aGpXS0FOWjI2bERPWE1CRS82aFk5Z0tUaGZR?=
 =?utf-8?B?Z0o5TWkzVksyZmJlSm5sWmthakQ2TkN1ZEZVY2grOHZmSFlHVHF3U3pGWFZ5?=
 =?utf-8?B?R2dXT3Z5cjBQWlBwRm1wRi9FZkxxNWoxRU9pQ01HeWFpb2wvQVZQbms2V2Vu?=
 =?utf-8?B?M1BmMVVVVklUQnlRenF2L25DTy83bWk5T2FCVU1xY3oyL0ZlNmJrdnJsNCty?=
 =?utf-8?B?V1NNVXB5N1RXS2dUV3MrQzFBOStQQlVGQ2pVYlpTb21BcDNYRlZ0a3E0T2o3?=
 =?utf-8?B?allKUW1NQmd4Nm1vUkI5YkNNSktYZW9Rd1Q4R0lzaTBLNW1aZ1hieTBaTFZh?=
 =?utf-8?B?T014YlE2bExiSi9VWkora1dhVlVtWUpsUy9CWkg5TzNVd2w5RTNsWVVXVmo0?=
 =?utf-8?B?QXZVYnp5QWxFSlU5QkpheGxIeFBNZjZySVdvZVRNaTFDL2VMMFRrVmFldDVV?=
 =?utf-8?B?VGxCcmdIOGVQRko0TFBBamRYSFBscEROd1NySUF1OUY3TUo0U1VTcmlwV2t2?=
 =?utf-8?B?OCtyL3NIeElwTkU0eC9ydVgreDVoQUlkdFBDMGMydVlwYVFGTDd2OFRpdHBT?=
 =?utf-8?B?MHVTUCsrZC9Ea3IyOVFVNFJKUHVMSXdZdENuc3Y4T1NSaFpSVFdWRlkyMFpz?=
 =?utf-8?B?Y3hCb3h5QUEvSUlyNVE5NkZlckxnVHh2S0RVdGhUZ1F0OUdrcnhnWEhTd2o4?=
 =?utf-8?B?Y2FHcHVTdDdsRVBYWHU3dG1Kcm9BTmVYZk14czZIUlRrbDdWQnNpZTRGVXJz?=
 =?utf-8?B?aXhya0I1YXZpcVRXYTQ3Tm1CTXFjSFJpSWpKMjIyKy9KYVBhcHJnaDBsMWpa?=
 =?utf-8?B?QkVqbkNnYm1tcVFvZGEwTC9ZVnR4T3BwVkhhZThZY2NjV2E1REF1KzJkN2tQ?=
 =?utf-8?B?Z1ppV1JOclQzYXIzbzg5ejBoQnI2bG80N2p0b1c4SHhmNnZud2xOMVdIN2VS?=
 =?utf-8?B?R3dUa0Y2T01PVlg3MmtYOW1QR25hM2ZaUllLQUV0ZVI1STZTZkdTMG0vVXBZ?=
 =?utf-8?B?SDNOOTFMVG5MU2hvbU1maWNHMVpOMmVSdjAzM0g1dGluYm5yNS9mV1NIcUFY?=
 =?utf-8?B?YzZKd3RyS1FpYWhvT2t6NzlYWEVrVDUrOUx6UlNFeTRJTUg3MmNFclFMNWEw?=
 =?utf-8?B?ci9uQlNjYmNucHFhVzFtQnNOZVprUFRWV1k0MkJheGk4aWZtYm9hc05ROENp?=
 =?utf-8?B?Y0tJRUNJUXU4WkhNem5kRWw1SkF6V3U1SHl2M09KOTg1RzdSenhOb1JST0ZF?=
 =?utf-8?B?b3R3U0U0YmRUdTkzK292L09DWTRoc2pSNGFja0NZbEZCTG9nVDBBRyswNUNm?=
 =?utf-8?B?bzJ3RVFMS1hPZ2hoM2dqU0prT1JNSXBCTkRMTWtldEMxeTNZMDNzejgvWEtw?=
 =?utf-8?B?TXJuR1hoQ0sxR3hLcDUzakd0UkQ5WXNvRmMrR2pLdjBaaFphNHlaWHltTTdJ?=
 =?utf-8?B?d252U0pFQ1NIZFRkQW1NOW9JVkFDUWlJOUx2UXIxUzhyTkxHcXYvVE16SkI1?=
 =?utf-8?B?S0x3RU1zUlBiNWRnVXdLc3VKL0Rjd3h6NWw3NWNOZTM2emdhRS9MS2ZZWDkv?=
 =?utf-8?B?Zm9pWFd1RURvVFExdWJwOGlwR3hRRk9sK0pGK1FvN2JYRG1YaDMzL0loUUZM?=
 =?utf-8?B?clU4S0JmU3FkZEpIN00yaDhhZnpqVy9qUGhNNmFsdFovVnl3bDhrdnByd3NF?=
 =?utf-8?Q?/TxLymDVaBXWom8wCI+QUO6DSzYVBQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emdYajg0bnRkRnppVVFuMWtSYlFOMkxrdVU2d1FGOGVSemJzZWp2QXREMWEw?=
 =?utf-8?B?cldQNEx2MFdtdXF0dk4wMXZPTXNaV3V0bGxpNkFJNHhlWFBlaXpnREQxamJK?=
 =?utf-8?B?ODRlSitlSUo5STlSZnRPamVpVGZvVEw1WTVaY3BvWE1RYlhybVhLZDRxeFdU?=
 =?utf-8?B?L2E2dHB2bStFY3VlemR1aFk4VkFlVVlzaWUxSk1kb0lRV0c3NjhNek90QTJi?=
 =?utf-8?B?c0RuVGU3Ymo0NVVqS3l6RnJJekNRVjJubTNUalNISVhTZjUvbjNKUnhaSE12?=
 =?utf-8?B?cnV6czJXZk1VaWFiN0x4SXhZcjhWc3BVS3NIMldWU3JJVDZoSVhlRVpyV0pu?=
 =?utf-8?B?MGJwd0tEZHo0S3N5WW1EMzdnZUVOMmc2TEYwQ2hMT2NrSGFyWDBlSExqdFc4?=
 =?utf-8?B?UUc3cDB5Tm5yWGs5YWpwUGNvc01KSDZEelFRbTVzRHZwaTZPd2RRK0J1ekRw?=
 =?utf-8?B?c2UxcS9vMVZ0U1gwcHdkQWtSRVFLWjV6OE00K1RPb1gwVHdML0F0NmFUUEIv?=
 =?utf-8?B?ZWM0ZGRoZzhZYTZVc2swV0ZqeVZLdFNBWE1sQUJwOG1GU2hOcEdFZVdYV1I5?=
 =?utf-8?B?Mkk0cmkxeHpwOHMzV1NBbzc5ZFRwbFVENEJ1ZXJjeVhxdjhTZlMvVjJ0Rks4?=
 =?utf-8?B?V0lqUlJXM3drQ3hEVk41bzgwNGUyVWtXZU5iYmxhL1grNGZPT3pqTFNwc0xs?=
 =?utf-8?B?VndRNnd4MGJJL1ZZOTJoOUVNNFpablo4bXBNT1ZCYmhTUjJud1MrNlo0RGhl?=
 =?utf-8?B?SlRpMzZVa1JkakNobjRsSUNyYVhKK0ZlbGRTRjBtV1pHMXNDYWE2bWN1SUMw?=
 =?utf-8?B?V1E0bjBpQmcyd21FdTlXMUdkOFFYYmN2dlZiNEMwR1FZVGxTSHY2ckl4ZUJx?=
 =?utf-8?B?TUpUaEliQ2g1M1JnOVJUckNUUVRzQXlZUU9qWTJGUjA2Y1pCNGloa0FWdG9H?=
 =?utf-8?B?Vyt3QTU3NmE3Z3hjYW4zbE1ZZGhIQ0hETTBwMzlhcEY4SzhQVmZqNk9oRnc5?=
 =?utf-8?B?cnBqZ1ZFYkRjQnR1TUV2R0FBQisweEh3MVIybkYrdGF6UnNWN2xXbnFDWWxl?=
 =?utf-8?B?NmJKL2dRcmM4c010ZEljWmxIN1U5VWlCREpiOHN0NEx0NlBiNTA1UndRU1d4?=
 =?utf-8?B?MmlWaEZ3aEI4NCswcTlzVXpwaUNJVVFleEcyUUNablhvUDBSYzB4V29lTFJ6?=
 =?utf-8?B?TFlnUURQeEdjVlVtM1pKQktXTzlwcjdkY1hHVGhPVUJUNDljckROQ3F3WGJV?=
 =?utf-8?B?anRBTnBlekdSM294emd3MUhlbURVVk1TR0tmWUtsR05BMmNPR09tWFNnTXhD?=
 =?utf-8?B?TmluY2dheGxVU0loVy8ramhxSG5WbUlOa0hpT2FGb094RHJjd3NsTktLbTU0?=
 =?utf-8?B?em1ja1JXTlRrYkJuQ1ZiZEZvV09NWng5VXM3Um5IeithVWN4My9CQnhJeTA1?=
 =?utf-8?B?Sm9SaVpJT29Sc1NjYlJLVmYyRjRxdVlJMmd4UUNJUVZVWTBuQnY4VStESVNa?=
 =?utf-8?B?eXE3bmpMWTNNU0ZuNTYyelpyc2ZXWHl6eDBieDZsVFY4YjFvYVk1VlZabTNO?=
 =?utf-8?B?LzdGai9scnR3dWRELytOb1Y2K2JkL01RYnk0VFU2cTJaRWZ3VnlPa2ZIY2d1?=
 =?utf-8?B?d1dwTndKRUdsb1JBdVJKQXRFNHFuOWZUeGpBNlVCMjN1MFQ1QUFwZ3VJUUc4?=
 =?utf-8?B?RUdtTXNTUnF2RWdBYzArSFEwUm0veFZ0QnA5TWVWaVVQSTNsdTFnSkFaaU91?=
 =?utf-8?B?VklnTUJUOVlWRW1JMmtsQ0x5aEZKcS8wOFR2clBwWjc4K1JndUVodTN3Vm0w?=
 =?utf-8?B?RHl4cFZVV1NLZ0h0NEY5V1FpWDdmZW1PZkhOSWpSK3FQSC90cWFyQ1huSEFN?=
 =?utf-8?B?OHFWZWFnRC9aYnBnWWxMRi9kK0R5UVQvKzlBV2FqaFVybkhOdTR2TVBtbmdy?=
 =?utf-8?B?dDJSZW1yNEpyV0xwdldMNURSRDRiVUN3NklGRTZoMUlweGlnOW4wR2JVbE9m?=
 =?utf-8?B?Q04zdXpuMmJab2o1dFYvWllKVGdRM1d0SzFHdU1EVmRRR2k3SjBEZkhIb3hi?=
 =?utf-8?B?MHQ2b3RXU1JWeU9RUTVpZVNzMzIwa0UvTEVrdkpyb3h3R1lSN0RWYlZvbmtn?=
 =?utf-8?Q?1lcc1buOEgg9vy+9NrQavOJ44?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8838.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdea506-2242-4e28-e516-08ddae6f2b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 13:51:04.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OozUis5+JTR2Td+gBMOAbvhlLT7pE5fT+gdBy6NY60mMIVoTj4b4o04ysFAdy570lny4jSH7t2HoyfDyOOLx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8995

DQo+IFRoZXJlIHNob3VsZCBiZSBubyAnU3ViamVjdCcgcHJlZml4Lg0KDQo+IEFsc28sIHRoZSBz
dWJqZWN0IGlzIG5vdCBhY2N1cmF0ZS4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgY2hlY2sgdGhhdCBp
cyBzdXBwb3NlZCB0bw0KPiBjaGVjayB0aGUgUENJIGFkZHJlc3MgcmFuZ2Ugb2YgdGhlIG5vbi1w
cmVmZXRjaGFibGUgcmVnaW9uIHRvIGJlIHdpdGhpbiAzMmJpdA0KPiBib3VuZGFyeSwgYnV0IGl0
IHdhcyBjaGVja2luZyB0aGUgc2l6ZS4NCkknbGwgcmVtb3ZlIHRoZSBwcmVmaXggYW5kIHVwZGF0
ZSB0aGUgc3ViamVjdC4NCg0KPiAndG8gYXZvaWQgd2FybmluZ3MgZm9yIDQgR2lCIHdpbmRvd3Mn
IGRvZXNuJ3QgcmVhbGx5IG1hdHRlciBoZXJlLCB0aG91Z2ggdGhhdA0KPiB3YXMgeW91ciBpbnRl
bnRpb24gb2YgcGF0Y2ggdjEuDQpJJ2xsIHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24uDQoNCj4gSSB0
aGluayBhIGZpeGVzIHRhZyBwb2ludGluZyB0byBjb21taXQsIGZlZGU4NTI2Y2M0OCBpcyBhbHNv
IG5lZWRlZC4NCkknbGwgYWRkIHRoZSBmaXhlcyB0YWcuDQoNCj4gWW91IHNob3VsZCBpbmNsdWRl
IHRoZSBjaGFuZ2Vsb2cgZm9yIHYyLT52MSBoZXJlLg0KSSB3aWxsIGFkZCBhIGNoYW5nZWxvZy4N
Cg0KVGhhbmtzIGZvciByZXZpZXdpbmchIEkgd2lsbCBzZW5kIG91dCBhIG5ldyB2ZXJzaW9uIG9m
IHRoZSBjaGFuZ2VzZXQuDQoNCktpbmQgcmVnYXJkcw0KDQpXYW5uZXMNCg==

