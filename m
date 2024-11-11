Return-Path: <linux-pci+bounces-16410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D99C3709
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 04:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C231F21983
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DC2595;
	Mon, 11 Nov 2024 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ws7NDfTX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB7EEA6;
	Mon, 11 Nov 2024 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295764; cv=fail; b=j7hmZUeS8aQJzH7xcqelrJsIadClkbroH/vNoUzkUC+bTNu061Zs2svz0Z/c7lnylasXkPNXVH+rjTeZQahD+pGR8lu3RgbmAgNjY7O1Fv3K78T1kJnMfH+Xxp7UEn+3jLpMLd1YtpC/mGIvy9cNBzkHNsQbETKOriYyvW2pfEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295764; c=relaxed/simple;
	bh=kNWP1oVAozBly/8pZqgxQuKg+N+5FDBnNrSkLOX2SMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BO0mquQ3RO0kXz+qppTWOXh+HrCOii0CnZ840W3F1Qg6h2/s2eerJ1P4ECIcr9razoc3GrTFh7n7519OEytZj1/i0a85IsuOdJrRsW5ffhfSx/HTceNiSsFpIJS7xUbkVBwWhL2JSYX0KpmB/Vi7cW1MldB2JKgv6iElCU3zlMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ws7NDfTX; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFYxDeX5/MFhdKgfklZB0nVcqQYsN+6xUXCNY5ewVT42ms9ZrLsjkbzXlrxGCzXDhcPEC5Um9AWoJK878Vr1mAODLeSRrDdZzj8bUbrhuTS7vU7VT4enNm1qZcN+2/YLZ+T5GOBTLatjQ63mhxj8FBuYZfRJ8DqRncvp4c75sVGvBFRXZ8OfhXJ2iqyNblOoRprih0YsPnRz14h5MOE5OI47DTV6B/Pxrw76Eyvzvipv5YqipYijpSMuED5jukbDTkbVYB8lny8yzNWYtXStRGAahCDlIEN8Jz1JNJ8xoTUq1fyMxdBV37uVjhzb3+9nDwEEr8isXYRgDWrwH3mytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNWP1oVAozBly/8pZqgxQuKg+N+5FDBnNrSkLOX2SMI=;
 b=A08XtrrTqFg/0aEmvw2r1iOBn5gCfwlEGTgw6Jv7kNrfIt5/+UyioToZ5CbuVxliU2/jpkWZ/7A78OShDW+r7wEb+hMuRNK2tLD0E5lBiDoSTuaHUVEjcEqQoGlxGTeQEIrZlrKjRpgQ0WIJVGbTar789hhseTBCopBENHKNozRhjWAdHFXR9pEzhrukAI9TRQKEfEN2FPpw7a8GZznQwBef/jAuutrbHVTm90410e32Gbfl8facug4OOSQbBNze4zJzmxYNNY1Q1HVUz3ASASXomhnxqie5Dux2Q6VypLKo3rw6AUZeAhORz/n3Tbu3Xf/7jgCdEJp6JAEWCK0Qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNWP1oVAozBly/8pZqgxQuKg+N+5FDBnNrSkLOX2SMI=;
 b=Ws7NDfTXavlXRmVoXytwT1D2TEVMlEwdqMKuHgiZfijIAMwhw9Ydxm4aH7lGsc9CqWX8Px4Kk3UzdJ0xGFxGJhD8Ez5sTWZi+LVsDS9O3KIjMt7m/ESpx+91g3GGB8Xfi2cZyxIzob3rtRYujZsXhLQZVSdHVgf50K8PpEPhiusXLZwPQWcQiPLpO8jYjQL5ncdXBYZHuivQE3HuqB5+1lcp9DySg9an2Ow5eAKa4SLh+0pk3wYCrCbJcjd22tUS+SGbx4qLfMsq3ya4/jr0W7ZJzHBq4GuExBpBxFpJbcq4lwB1bQsPJNEgJDFS1HlysGIKaJZonXMdHCiwIMh4Ig==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 03:29:18 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 03:29:18 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, Frank Li
	<frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index: AQHbMO/ydVggfwMlw0SMjZ6nwDplE7KrqksAgADc9oCAAyCsAIABv/DA
Date: Mon, 11 Nov 2024 03:29:18 +0000
Message-ID:
 <DU2PR04MB8677ECC185DFF1E2B62B05858C582@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20241108002425.GA1631063@bhelgaas>
 <b5f56ec9-9b5f-5369-52ed-bcf0c8012dbb@quicinc.com>
In-Reply-To: <b5f56ec9-9b5f-5369-52ed-bcf0c8012dbb@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|DB9PR04MB9427:EE_
x-ms-office365-filtering-correlation-id: 7505751b-f346-423b-3379-08dd02010688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzhDNDZKMy9ab1FQQ2hwMGFwZlhuT2cvdm4vUTBFcFQ2NWozMmNDOG9oT2dY?=
 =?utf-8?B?UTJOZWg1aTlyUmg1T0hCMTdJSmxoU25tbXR5RDVjVVpEaTJkcktpV1FaUktH?=
 =?utf-8?B?K1k0eGIxUU5qZXBkZDFESFlhcHhtK3ZjV29oQzJaUWkxaGxkL2ZuQkxaK21w?=
 =?utf-8?B?RzRYcVpRbWpMM21YVmpJRVJXTEpna1QvcXlwTE1vRERVNndSeHF0cWk2R3FB?=
 =?utf-8?B?Zis0MzVHL0hCakdObENycWV4Zk9QYmVNaDQ3L0M2RVVxTnNuZmtubHF6aHJq?=
 =?utf-8?B?VHgzVVd4L2ZvN3ZydCtEWnRYQU9kRGNHT2pQdHdFZ2dVWnpGQUc1Z09FYUtW?=
 =?utf-8?B?c3NENHVLUVZmY2ZaczFKdGRtK0VtcmNYMktBWU9kT3ZqeUg1VjBvVytHUE1C?=
 =?utf-8?B?Mjd1bzJ6UG5EQkdCcnpYVERDKzJ5aFlFVXpZaGpCY1pvamxzTUsyckZlSUQw?=
 =?utf-8?B?QlMwMnJVblVhQXBkdzZSeXk4UndTMWVEakxEcjk3bUx3eVpKc1I3cmVRL2l1?=
 =?utf-8?B?U0VOVXAwSzRCS1N4anpMdUZyWk80bnFxTllHUVVieVdRL1l5QWNOVUlVaXBK?=
 =?utf-8?B?YksxZEs2cW14RDJ4a3haajdEcUlNRWxHTnI5c041QXpzOUxBb05sOUpYUEgz?=
 =?utf-8?B?WHFnTVM2WU1HS2s1RVlhakZQa0EwZjhyQlhGT3ZEWlI4TGhjajZDcFNYSXRv?=
 =?utf-8?B?U0d5VVFsbXFDR3UzZkJnTWdGZ1E3WGNMTVovSW5PN2FxYmpGYloxZ1dJb2hV?=
 =?utf-8?B?UjFPU3dXZitCVlZkZnZSakNtcEtVZCtyemFGdDVqY3YrOGFNeEQ2eUhCQ1lU?=
 =?utf-8?B?UDFicS93U0VCOFk5VDBqM3YyMGNwUTdtdm0yQjZTdW42WGM0dzZDNnAyQkx6?=
 =?utf-8?B?WVZwdUFadjFsYS9maDZFNFhxRTNFd3IyT2lQTU01eDRrdGYwU1lTbFBOMmti?=
 =?utf-8?B?VU1iTzUzQlRFbjI0UC8wNUlSWk9GTTIxdGlEYXpEWlc0QU5FRi9SUTU4cWwz?=
 =?utf-8?B?RERTNnlkTlZHdHhtNkx2aC92U3pSc2wyVG9zZTVnNlRlYVNyY2FKQVFuU1FC?=
 =?utf-8?B?OGZ2a3ZBSXEvbmIzdGJsclUrRG5yMG5WZm05UmVEcWRMZlNVWVRndHRPSloy?=
 =?utf-8?B?Z2Fzc0tSeHNKTitOdnh3b3FneUFVb1pSVXhBTzdHei81eVRSeUdvWFN4bTNO?=
 =?utf-8?B?L1FPcHJIcVZBMmFrdmQySDZpVzMxMm1XTDIwZjhYZ2dic2t6aG9XcXlaMTdj?=
 =?utf-8?B?RkdNN2xkK3YrNUd1amZtaTNYTk9FK000WkRuL3pCTW16TkRpZnBRUFdaUWhP?=
 =?utf-8?B?M0R3eC9pTDh2Ukd0MGY1bkNEd0dmd3Rod3dubjNFY1lyREpOd1hSTTBwSXBM?=
 =?utf-8?B?a0lwVEg0Y050OWp1WVNhaFlWeDNTSzlvSnp1YUtsYTFQaFZwbUprVHhNTzZ3?=
 =?utf-8?B?Q0JoWGM1K0tSc0JaM00yWmx3K1RJVXFOSlJzU1JwM1pkcG1lUXNvVzhGRHBE?=
 =?utf-8?B?WUZQcU02TWJVS3VQN3NidjJEMTdPWVhhWWY0bU5mNURUT2pPK1RZRnk5MStZ?=
 =?utf-8?B?TUVDRk9MUTgvdXhPYTBGWUZucW9lLzM3R2NLa2c3TnlUOElteTZ5bjVYaVU2?=
 =?utf-8?B?M2Y0dzBvcGNyNVVlZnVmRFpiMHlQOURaS3BZTHlZb3RJYmh0M0sxKzYwa0VS?=
 =?utf-8?B?Q2xxWjNZbUdrdHlsQ05iMmtXYUVwTmRmdFN3elNZV28wVExzWFJHb0paYVo5?=
 =?utf-8?B?cS9MM3V0SGFYU0kxeXJRZ0ZaKzBvaXFGYTFIa3d6bHRodzJHZEZOWVRlQk5L?=
 =?utf-8?Q?OJzJvkuKd9jTYlvmqEa/DadHmPhrIZedp/MOw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnVzSjk3aXpQa25vQjRIdFczTFc4NkxVM3RIa1IvejhBZkQrZUt1c1ZsYytZ?=
 =?utf-8?B?N1R1Z3ZmSWpuaElDR0wwWVQ2Rk1ZODFqbG9NanFYcEJ0VTZleElieGVtYXZw?=
 =?utf-8?B?cWNSV2xySWNYb2Rid1VHV0dGbklQWHpYMXJWYWUwcmtYR2M2SXNEL3dQWjhu?=
 =?utf-8?B?ZXE1bVJNMjhmWW1CeWppMDVHYWtVa0FGeDR3SVZJdWJOa3A1UldCNk5iU0Z5?=
 =?utf-8?B?KzJodTFlcCtaS1dZVDFxb2FNZXE2eWhQQ0xqREY5SDEyUENrSkx1SjVLOGhF?=
 =?utf-8?B?WDlFOWhlZjMySHVXZ25pbUJRMTZaSDczajBJNjhmdkExQ1N0UTE1MEF2MFFs?=
 =?utf-8?B?OVpDMWd3YW1xUFNaY1ZkMU1OWGxBa1ZmTkNHK2dWTUl3VWhQKzd6SDFMMC9v?=
 =?utf-8?B?dDMxdDhQS3dsdjM2ZHJjeUl2eGsrOFlqeFQ5dEp6VUFXRWY0RFdQSkNKODZl?=
 =?utf-8?B?a04xbDNXZ2dicjVRMCsvNEtlK2RYeS9yaTQwMTJYK0dXYlRSV0pBbnhoMmNZ?=
 =?utf-8?B?WjkvRFgvSkNKb2xhNTZFRVloakg2bnRJeDN3TE5ORnBlV0NOcmRkNWgzejE0?=
 =?utf-8?B?cXR3a2lBL2wxYUE3aXBqUCs3QmZSOTM5cStOL280T1h6a2lSbjVCL3RIdnJj?=
 =?utf-8?B?K2F4T0RnVVdtaVFrYjRjRWgwb09rVU1heUdSYjdZYTV3SCtXTUlRNkpWYkFx?=
 =?utf-8?B?WXVSZEhlMkRSWENENDBvYmVpUXBYQjdCOTBBUDhha3JuL2ZMZ3VoSXU2S3pK?=
 =?utf-8?B?MStSOVI3WHVkeTBUb0I5bDhLOFAzajVKNEMwZ085MVRtdWRyODU3bUQ3MXpZ?=
 =?utf-8?B?ajBRV0NrOHN2WWZmSFhTa0k0SGVpUVBNbUNOZmMxQzRiZWErSjVvbWtHSW5H?=
 =?utf-8?B?Vnd6dnJNSnI2dGVCcElzRXBUVjRTcStXaEthNk8vekthZGJoN2Z5WENKU0dC?=
 =?utf-8?B?NFdCS3hsNDFlN1VZbFQyUkQvR1RvSXpFb0FzVElPT3NabTFkT0JXc09Nc3k3?=
 =?utf-8?B?Rmo1VmREdzFKenRnVGc5eXUzK1VjR2J2MTN1azFVZEFJcEhVMUtNS2xYaTVT?=
 =?utf-8?B?dVhWbjVTb1BwbW4yckNabUp0enlCQ1ZZYUM5RFpDOXo4ZTNmdXhXT1l3MExW?=
 =?utf-8?B?SGxDV2ZNM0JtSy9EZUZaTURlSnEwT2c0aERnRFBhRzlIZFdqY1RIT3FuQU5M?=
 =?utf-8?B?cmNXbjlqQW1LMkZkVmJvWkh3V1VJdEtGZGRudDhleWhOSWN4cC83NjBNcVB3?=
 =?utf-8?B?Tnh5NG82MlRsbFdOdlZRdkhLTlF4Umtja0k2ZzNVUUdlVXhCQXhGQ2R6dFd1?=
 =?utf-8?B?NmprMXR5bTQ0WkRld3o4RWkzNFhCQXB1RTczaXZiSkViYzNPQW4yU3pqNDM0?=
 =?utf-8?B?djc0QzJrVjhiVjV2YzZhTmEwL09UZDZSSjNObXE4d1VSVkIvYjZRVHJDRmxK?=
 =?utf-8?B?elJsS080ZVN2RVJidzZ0UUJjL0I2TDNIb3N2elYrbnZsbXRzeXg3NnhlOXl3?=
 =?utf-8?B?N3Rnclc1NFZzVXA3NlE4NjF3ZXdOOEhvaVkyYm9JVWZaMFVCV2p1bWR3MitK?=
 =?utf-8?B?aWh3RmNvbG1KM2YzTHhidTgyTVhmazFvRmF2SncyM0FIZ2xiaVdCV1hkdTZp?=
 =?utf-8?B?VmxDZmJBNlBCMC92anQxUml5bEtwWVNRUGpOTW9NcEVpZkJWK2pYUTdEU3lS?=
 =?utf-8?B?MHRWLzBkbEZPSitSUFV2U2p6aHRXb3RIVE9qcTcrQmhnNXJoMURPR1VHSHZn?=
 =?utf-8?B?bUZRU0gvaTRScWV3elVpd2xieWJoWi9PRktyZHN4R2hpdDlya2FZaVNJc3J3?=
 =?utf-8?B?Y1ZieDJ5SVZjVndoMGhZRGJMREI0QUs0Qmh3cnBJRTc1ZUV5dkJ4eWRCbU9L?=
 =?utf-8?B?QjRBOER3aHJibEdMYzVyRDFnWUF1RUdaWFBkUDN4RldRTzRXZXdPTFdGYlkx?=
 =?utf-8?B?Uy9qV1c0UmpnS3MxZ1FtL2V5VkRXdWt6Mk9iY2E5bE9rNW5XNVZsMnV1VEtY?=
 =?utf-8?B?bExtU1FobkhkbUhsb25lVTE1SEkxWXdWNSs2OWo3ejJScTBiT0dmZ1JGZUdP?=
 =?utf-8?B?aktyOVJLaUhBTUs5REdsOG9IMldsWkd0a3JmZkw4dkszMjBWQWl2WkRwNHdN?=
 =?utf-8?Q?BCGoTfXQovJl5saATDpsgqinq?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7505751b-f346-423b-3379-08dd02010688
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 03:29:18.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TK6yBXvFeQq1L3XlGr0nF0HWFrTteAZ/I2uBMDoXvJnzb9lqXg3b0QF+Z5SG0mIIXAOF93LBOY+vtqWwYgEHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcmlzaG5hIENoYWl0YW55YSBD
aHVuZHJ1IDxxdWljX2tyaWNoYWlAcXVpY2luYy5jb20+DQo+IFNlbnQ6IDIwMjTlubQxMeaciDEw
5pelIDg6MTANCj4gVG86IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz47IE1hbml2
YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+
IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFp
bC5jb207DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dA
bGludXguY29tOw0KPiByb2JoQGtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
PjsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIFBDSTogZHdjOiBDbGVhbiB1cCBzb21lIHVubmVjZXNzYXJ5
IGNvZGVzIGluDQo+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpDQo+IA0KPiANCj4gDQo+IE9uIDEx
LzgvMjAyNCA1OjU0IEFNLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+IE9uIFRodSwgTm92IDA3
LCAyMDI0IGF0IDExOjEzOjM0QU0gKzAwMDAsIE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiB3cm90
ZToNCj4gPj4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDQ6NDQ6NTVQTSArMDgwMCwgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+ID4+PiBCZWZvcmUgc2VuZGluZyBQTUVfVFVSTl9PRkYsIGRvbid0IHRl
c3QgdGhlIExUU1NNIHN0YXQuIFNpbmNlIGl0J3MNCj4gPj4+IHNhZmUgdG8gc2VuZCBQTUVfVFVS
Tl9PRkYgbWVzc2FnZSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIGxpbmsgaXMNCj4gPj4+IHVw
IG9yIGRvd24uIFNvLCB0aGVyZSB3b3VsZCBiZSBubyBuZWVkIHRvIHRlc3QgdGhlIExUU1NNIHN0
YXQgYmVmb3JlDQo+ID4+PiBzZW5kaW5nIFBNRV9UVVJOX09GRiBtZXNzYWdlLg0KPiA+Pg0KPiA+
PiBXaGF0IGlzIHRoZSBpbmNlbnRpdmUgdG8gc2VuZCBQTUVfVHVybl9PZmYgd2hlbiBsaW5rIGlz
IG5vdCB1cD8NCj4gPg0KPiA+IFRoZXJlJ3Mgbm8gbmVlZCB0byBzZW5kIFBNRV9UdXJuX09mZiB3
aGVuIGxpbmsgaXMgbm90IHVwLg0KPiA+DQo+ID4gQnV0IGEgbGluay11cCBjaGVjayBpcyBpbmhl
cmVudGx5IHJhY3kgYmVjYXVzZSB0aGUgbGluayBtYXkgZ28gZG93bg0KPiA+IGJldHdlZW4gdGhl
IGNoZWNrIGFuZCB0aGUgUE1FX1R1cm5fT2ZmLiAgU2luY2UgaXQncyBpbXBvc3NpYmxlIGZvcg0K
PiA+IHNvZnR3YXJlIHRvIGd1YXJhbnRlZSB0aGUgbGluayBpcyB1cCwgdGhlIFJvb3QgUG9ydCBz
aG91bGQgYmUgYWJsZSB0bw0KPiA+IHRvbGVyYXRlIGF0dGVtcHRzIHRvIHNlbmQgUE1FX1R1cm5f
T2ZmIHdoZW4gdGhlIGxpbmsgaXMgZG93bi4NCj4gPg0KPiA+IFNvIElNTyB0aGVyZSdzIG5vIG5l
ZWQgdG8gY2hlY2sgd2hldGhlciB0aGUgbGluayBpcyB1cCwgYW5kIGNoZWNraW5nDQo+ID4gZ2l2
ZXMgdGhlIG1pc2xlYWRpbmcgaW1wcmVzc2lvbiB0aGF0ICJ3ZSBrbm93IHRoZSBsaW5rIGlzIHVw
IGFuZA0KPiA+IHRoZXJlZm9yZSBzZW5kaW5nIFBNRV9UdXJuX09mZiBpcyBzYWZlLiINCj4gPg0K
PiBIaSBCam9ybiwNCj4gDQo+IEkgYWdyZWUgdGhhdCBsaW5rLXVwIGNoZWNrIGlzIHJhY3kgYnV0
IG9uY2UgbGluayBpcyB1cCBhbmQgbGluayBoYXMgZ29uZSBkb3duDQo+IGR1ZSB0byBzb21lIHJl
YXNvbiB0aGUgbHRzc20gc3RhdGUgd2lsbCBub3QgbW92ZSBkZXRlY3QgcXVpZXQgb3IgZGV0ZWN0
IGFjdCwgaXQNCj4gd2lsbCBnbyB0byBwcmUgZGV0ZWN0IHF1aWV0IChpLmUgdmFsdWUgMGYgMHg1
KS4NCj4gd2UgY2FuIGFzc3VtZSBpZiB0aGUgbGluayBpcyB1cCBMVFNTTSBzdGF0ZSB3aWxsIGdy
ZWF0ZXIgdGhhbiBkZXRlY3QgYWN0IGV2ZW4gaWYNCj4gdGhlIGxpbmsgd2FzIGRvd24uDQo+IA0K
PiAtIEtyaXNobmEgQ2hhaXRhbnlhLg0KPiA+Pj4gUmVtb3ZlIHRoZSBMMiBwb2xsIHRvbywgYWZ0
ZXIgdGhlIFBNRV9UVVJOX09GRiBtZXNzYWdlIGlzIHNlbnQgb3V0Lg0KPiA+Pj4gQmVjYXVzZSB0
aGUgcmUtaW5pdGlhbGl6YXRpb24gd291bGQgYmUgZG9uZSBpbg0KPiA+Pj4gZHdfcGNpZV9yZXN1
bWVfbm9pcnEoKS4NCj4gPj4NCj4gPj4gQXMgS3Jpc2huYSBleHBsYWluZWQsIGhvc3QgbmVlZHMg
dG8gd2FpdCB1bnRpbCB0aGUgZW5kcG9pbnQgYWNrcyB0aGUNCj4gPj4gbWVzc2FnZSAoanVzdCB0
byBnaXZlIGl0IHNvbWUgdGltZSB0byBkbyBjbGVhbnVwcykuIFRoZW4gb25seSB0aGUNCj4gPj4g
aG9zdCBjYW4gaW5pdGlhdGUgRDNDb2xkLiBJdCBtYXR0ZXJzIHdoZW4gdGhlIGRldmljZSBzdXBw
b3J0cyBMMi4NCj4gPg0KPiA+IFRoZSBpbXBvcnRhbnQgdGhpbmcgaGVyZSBpcyB0byBiZSBjbGVh
ciBhYm91dCB0aGUgKnJlYXNvbiogdG8gcG9sbCBmb3INCj4gPiBMMiBhbmQgdGhlICpldmVudCog
dGhhdCBtdXN0IHdhaXQgZm9yIEwyLg0KPiA+DQo+ID4gSSBkb24ndCBoYXZlIGFueSBEZXNpZ25X
YXJlIHNwZWNzLCBidXQgd2hlbiBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KPiA+IHdhaXRzIGZv
ciBEV19QQ0lFX0xUU1NNX0wyX0lETEUsIEkgdGhpbmsgd2hhdCB3ZSdyZSBkb2luZyBpcyB3YWl0
aW5nDQo+ID4gZm9yIHRoZSBsaW5rIHRvIGJlIGluIHRoZSBMMi9MMyBSZWFkeSBwc2V1ZG8tc3Rh
dGUgKFBDSWUgcjYuMCwgc2VjDQo+ID4gNS4yLCBmaWcgNS0xKS4NCj4gPg0KPiA+IEwyIGFuZCBM
MyBhcmUgc3RhdGVzIHdoZXJlIG1haW4gcG93ZXIgdG8gdGhlIGRvd25zdHJlYW0gY29tcG9uZW50
IGlzDQo+ID4gb2ZmLCBpLmUuLCB0aGUgY29tcG9uZW50IGlzIGluIEQzY29sZCAocjYuMCwgc2Vj
IDUuMy4yKSwgc28gdGhlcmUgaXMNCj4gPiBubyBsaW5rIGluIHRob3NlIHN0YXRlcy4NCj4gPg0K
PiA+IFRoZSBQTUVfVHVybl9PZmYgaGFuZHNoYWtlIGlzIHBhcnQgb2YgdGhlIHByb2Nlc3MgdG8g
cHV0IHRoZQ0KPiA+IGRvd25zdHJlYW0gY29tcG9uZW50IGluIEQzY29sZC4gIEkgdGhpbmsgdGhl
IHJlYXNvbiBmb3IgdGhpcyBoYW5kc2hha2UNCj4gPiBpcyB0byBhbGxvdyBhbiBvcmRlcmx5IHNo
dXRkb3duIG9mIHRoYXQgY29tcG9uZW50IGJlZm9yZSBtYWluIHBvd2VyIGlzDQo+ID4gcmVtb3Zl
ZC4NCj4gPg0KPiA+IFdoZW4gdGhlIGRvd25zdHJlYW0gY29tcG9uZW50IHJlY2VpdmVzIFBNRV9U
dXJuX09mZiwgaXQgd2lsbCBzdG9wDQo+ID4gc2NoZWR1bGluZyBuZXcgVExQcywgYnV0IGl0IG1h
eSBhbHJlYWR5IGhhdmUgVExQcyBzY2hlZHVsZWQgYnV0IG5vdA0KPiA+IHlldCBzZW50LiAgSWYg
cG93ZXIgd2VyZSByZW1vdmVkIGltbWVkaWF0ZWx5LCB0aGV5IHdvdWxkIGJlIGxvc3QuICBNeQ0K
PiA+IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgbGluayB3aWxsIG5vdCBlbnRlciBMMi9MMyBS
ZWFkeSB1bnRpbCB0aGUNCj4gPiBjb21wb25lbnRzIG9uIGJvdGggZW5kcyBoYXZlIGNvbXBsZXRl
ZCB3aGF0ZXZlciBuZWVkcyB0byBiZSBkb25lIHdpdGgNCj4gPiB0aG9zZSBUTFBzLiAgKFRoaXMg
aXMgYmFzZWQgb24gdGhlIEwyL0wzIGRpc2N1c3Npb24gaW4gdGhlIE1pbmRzaGFyZQ0KPiA+IFBD
SWUgYm9vazsgSSBoYXZlbid0IGZvdW5kIGNsZWFyIHNwZWMgY2l0YXRpb25zIGZvciBhbGwgb2Yg
aXQuKQ0KPiA+DQo+ID4gSSB0aGluayB3YWl0aW5nIGZvciBMMi9MMyBSZWFkeSBpcyB0byBrZWVw
IHVzIGZyb20gdHVybmluZyBvZmYgbWFpbg0KPiA+IHBvd2VyIHdoZW4gdGhlIGNvbXBvbmVudHMg
YXJlIHN0aWxsIHRyeWluZyB0byBkaXNwb3NlIG9mIHRob3NlIFRMUHMuDQo+ID4NCj4gPiBTbyBJ
IHRoaW5rIGV2ZXJ5IGNvbnRyb2xsZXIgdGhhdCB0dXJucyBvZmYgbWFpbiBwb3dlciBuZWVkcyB0
byB3YWl0DQo+ID4gZm9yIEwyL0wzIFJlYWR5Lg0KPiA+DQo+ID4gVGhlcmUncyBhbHNvIGEgcmVx
dWlyZW1lbnQgdGhhdCBzb2Z0d2FyZSB3YWl0IGF0IGxlYXN0IDEwMCBucyBhZnRlcg0KPiA+IEwy
L0wzIFJlYWR5IGJlZm9yZSB0dXJuaW5nIG9mZiByZWZjbG9jayBhbmQgbWFpbiBwb3dlciAoc2Vj
DQo+ID4gNS4zLjMuMi4xKS4NClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KU28sIHRoZSBMMiBw
b2xsIGlzIGJldHRlciBrZXB0LCBzaW5jZSBQQ0llIHI2LjAsIHNlYyA1LjMuMy4yLjEgYWxzbyBy
ZWNvbW1lbmRzDQogMW1zIHRvIDEwbXMgdGltZW91dCB0byBjaGVjayBMMiByZWFkeSBvciBub3Qu
DQpUaGUgdjIgb2YgdGhpcyBwYXRjaCB3b3VsZCBvbmx5IHJlbW92ZSB0aGUgTFRTU00gc3RhdCBj
aGVjayB3aGVuIGlzc3VlDQogdGhlIFBNRV9UVVJOX09GRiBtZXNzYWdlIGlmIHRoZXJlIGFyZSBu
byBmdXJ0aGVyIGNvbW1lbnRzLg0KDQpUaGFua3MgYWdhaW4gZm9yIHRoaXMgZGlzY3Vzc2lvbiwg
aXQncyB2ZXJ5IGhlbHBmdWwuDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gPg0KPiA+
IEJqb3JuDQo+ID4NCg==

