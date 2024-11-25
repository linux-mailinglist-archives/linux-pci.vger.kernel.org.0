Return-Path: <linux-pci+bounces-17273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB789D7D21
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 09:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B5A161DA4
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52AA18B475;
	Mon, 25 Nov 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/ZbAKcI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361B18B47C;
	Mon, 25 Nov 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524275; cv=fail; b=E9fM2WeZzNxl9AbNZ9Ev8nVoZa1p3e5g19VVu4KkpmdqxEe+1ylDoSPQbhPmQRbgtmt0GwST66Dbt6k7RHSfbuUxfWNgrR9eDD/aBGbawdGNv88K582cMYx9LC6qv8klfNYf5Z2lHTaG45l8aHCVtDgNGYkBWUs7It7RM/cTxHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524275; c=relaxed/simple;
	bh=jEEUsYmOzwafwBaN869cqFOYJnhaE8odgn+eNJNbfvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EANU/c9Dv32jxE9ZXzDDRkbBHgqXTLfNWoAQ5d/MbUxQxerBhUNBZKUnjusGyL4dheVXS2WnjvAmFFZU9KywUb0aJkOqt1pKqvOmT+TYFXBMb7z0rDmoK2euzzNoFSG8MIwkhFYb9d1LhJqteHtXzcaFxBJUhxzQ/0VYrH1UdFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F/ZbAKcI; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJpy5+FB0X7nkMypzNXOi7qW4rZ3ErhLivoyn6sVJSmdmz5mKlt588GZOQa9RG79wkXBWv6QzDAuxuLJlIWxqxtiFOlggkeYaroaLqM+v8cGoVaBDbe6n3hPGzs9LyeoXMLIKY3mU5OfxBNtgdTtrb16m5FbzoNnq4FkuNA5dkpsy2T9Ux7lfTnnHt0S2unFCKs1mcQbUYtjAb9NjDDO3V/86Cy2AxWgRnf02OumJyVs4Amu1yqH3kcVDu8N4h6OQOd3mfJi1jeAk3nfirvlChkbczZ4fkaA6jCYpb6Ke32BE3ZqllljLVZnFuDo2Bi3uTWmu02XAEOWj4RYO/R1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEEUsYmOzwafwBaN869cqFOYJnhaE8odgn+eNJNbfvs=;
 b=EwfizK+rWU8oVjqQWvtGk5JFsGL9g7Bvg0inqYKw+c4khCVJjvHlnWw5acC1RLban0k+iERscV1gBdtWquh5qhMKPQwu8peviibO3IjkH2/JqLZH0XTmqC/WR1atB41aThIswi7/63YHxB8CPm2oZtxITGlXKLFn3hcIH/GkpypKYIi4+IWBg6ldZP5o4leRgcVjZ1/YRTj5hPXQus5LL4R7zZWs96dlO6zER/PcsGLejpIpwKz0SahEcjspE4/JuN70VGlgpAn4nK0b9WjmzldsKMITR10zB1d4wlqjvigT2c4lZIdSGhCNgz+sSzB3pNiTQ6VB7mK7WsRSF8prXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEEUsYmOzwafwBaN869cqFOYJnhaE8odgn+eNJNbfvs=;
 b=F/ZbAKcIAwB04XGAyEl4yuGgyAonREoLWrjjqTTEFEnxDcy1uZ7G6liFLMn5gUt9ELYGdHR+4v6GnP4szriY4/ghuScFz8JZRM/caKOpmFGNWhf0WPFOt5UauA6hQQjBApl8uMZCLRHkuSxGEs/6HRZ1nuw0GhHVUiRSo5uVSED0oZDfofaBqLedztEWTuDs+E1NmOQUApTz82degFxgkB7L/w0RntMgH5JMb+Mc9TadzfUFPQ/d2otQtKsudaogrg7vqm5HexY8FQEaHXB/uuNbZszruTE8KkX4dZN5NF97go0eUdzdOXQ7Kobp64dmUsOjkWU9wN8kQJHJVOSpEw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 08:44:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 08:44:29 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Thread-Topic: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Thread-Index: AQHbLCs8n4h8H5Xxpk+Qlb1Qqkqp8LK4AkwAgALlt3CACLwDAIAELOoA
Date: Mon, 25 Nov 2024 08:44:29 +0000
Message-ID:
 <AS8PR04MB86761B96527A40BB0055AD598C2E2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
 <20241115070932.vt4cqshyjtks2hq4@thinkpad>
 <AS8PR04MB867625A97A43FE5352FC0E768C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241122164714.aj4dzv32zixdj7pq@thinkpad>
In-Reply-To: <20241122164714.aj4dzv32zixdj7pq@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU0PR04MB9636:EE_
x-ms-office365-filtering-correlation-id: 483130b5-769c-4913-1151-08dd0d2d6047
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWN3L2RkQVVaM25MQkUxMFZnS0lFOVZOSWRsUmVOeHViZlpqSU5URDRFM3VT?=
 =?utf-8?B?ZXlCdGZzT3dPVlZyUWM2M0pydURYNnA2enhURmdPa3VHSHVsZUpkRTNrK1FW?=
 =?utf-8?B?UStUR1Y5aHEyOVZ3RFVJQVUyQmI3UXdrbTJZTGZXUER6RFRqNXVWY3FhWGRk?=
 =?utf-8?B?K0hHZUhiamtyWlJsMkFjOWlwQ1dRaWRsZVVzVFhETUdLc0lZdXFSWGI2TjNm?=
 =?utf-8?B?VnkyR3BiQ0g1ZTlzc0JjWE1IbUxyejJrRDRFMEdPK3pXZXgySEtqdlZSb0Fh?=
 =?utf-8?B?MDhzZGRGODhiRzQxQ0Vsa3pIK0VKQ0RRVk5MVkF3ZGg2RHhEbHdzQ2hUREVv?=
 =?utf-8?B?bTlCRGpGWGdMOEJRSFhuQjZJSy9iQUJnZ0sxZzBuRGxvei9pbFp0d2ZKbCta?=
 =?utf-8?B?UnR4b295S0xkRGZGSFU0MUtFUkxUUXJQaTBPc3dNWVVTa3JuTXBPRzRBVm81?=
 =?utf-8?B?MUp0OHRHZy9Sdk5GQkZ6QjZHL1pUNWhTb05VUWVzOWlyTGFFN2RGMWtHcXUx?=
 =?utf-8?B?QmlNRFRlNERQMVg0WVFKV1U0cyt4bTRPZGNuK2pWNlN6WjJSNE5lVEVvNGl3?=
 =?utf-8?B?OWIySlFnWm15S0V5THpvQUx4bkxPbm5iZlVJeEYzZWkvbC9rREYrTEpjUFNC?=
 =?utf-8?B?eXJrazczWDdtYXRlNGRTZkYvMGwvTnplMG82dGhKNUJQYlp6djNML1lpeVl1?=
 =?utf-8?B?cjlzZ3ZnSnJ1ZXAxOFNEb01MVjgrdlI1UHJ1WnVMUTlDdi9Ua1VsVWFKZG9h?=
 =?utf-8?B?cGx1WFZ3cHZsYWlPTXFRNzZMR1gyRnhsdGk5ektJaHh5QzRWaml5T3pwVzVD?=
 =?utf-8?B?YzRZV2sya3ZIQUlIWUpCRVVicE1RSzVQVkFpclRybEF3eG53WFpJRjYwVmpK?=
 =?utf-8?B?WUpaVjRhTEpid0gxYmlEVzA1Sm5XRk9EcUFQc3RsSTlNN29Pd1gvc2pYdWpw?=
 =?utf-8?B?OSs3YlZUbUZ1aU5FNWYrbm8wUytMNTF6YkdjM0xnb3FNSmE0OHNsNUljdzFh?=
 =?utf-8?B?SDJhUitReC9IYWFLSG03RGwrS1ZYZUJEekgvM0dRdE9oUFBXM29pK21iT1hw?=
 =?utf-8?B?NzduVUczWldvSWdreWJNSXVaMEV5VlhqeXQrUW1yRHlpaTV6c2MzNVlYcDVG?=
 =?utf-8?B?NHhzWWlSSGNta2o2em9DbDU5VzZCTmVSaEpQeWJJZkJFampLd0xldWVlL25q?=
 =?utf-8?B?Snh6RFQ3VEgxUUJBTGFLVTNTdTk1MStvVlR2Vlh0bGFBaTlNNDNyRENjb3ZP?=
 =?utf-8?B?akhkWm5jTkZFRU42UUlCKytoM1N6NFpOT0lwdjY0bHVrWnE4bURBWWZzaHdT?=
 =?utf-8?B?OERITkNPbnhObHoyanR0bGZ0YURhdS9YZHBuZE1KVVZ0anlnRGpRUUFid3lG?=
 =?utf-8?B?SUlpVEdSd2Q1enVtY1RES3lZR2x2M3N2c2FzSlJ6Vld2SkNEN21aaUZLRmdD?=
 =?utf-8?B?Yk40d09ZQ0tWLzFlQndvUkJaK1JVeGVvemxnNldOd0U4ZGpZZkFVL0R5YVRs?=
 =?utf-8?B?eWxnUHZEM1plem9aOVhIVkcyWHkvcnhOeVRVRVhHY1BVOFQyTTlJeXp5K3hQ?=
 =?utf-8?B?MHQza0RNOHJ4ZFJNVTNxN1Zrb0hDU0M0MWZHYmJrVU1yMVVKeDNtTWtVV1Zh?=
 =?utf-8?B?MVFrNTN2R1k0VWhOVkN3Yjh1aFpJbUR1ak95N0wyL0l5Qmo0Z2hDUGp0d242?=
 =?utf-8?B?ZHg5V1Q4OEdqSldua1VTYU0zV2NMbk1YaGNCcXN6R3hZMjE2MFQwOVVjTndP?=
 =?utf-8?B?S1JTTjlQUWRlT05JR2tSS3pEMGcwWTRhMURYNWtJYWVXNEJtYWFXWVZlTVQ2?=
 =?utf-8?B?Y2V4b1BQbllUTStMODZ3OWs4ZUI3cjdoK0xkbGhxSC80L1dEU2hsejBmN1BE?=
 =?utf-8?B?NG1GQWx0aEpldlNjM0toYTR1VXByc09jMHVGVEhPWm9aaXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlA3b1YvaFlERzBoQSthVEpZMWRuSEFSdmJicmhYV3JXZER4VWd6WGw0TTZC?=
 =?utf-8?B?ZkNiS1lIYWxmQzBGT0U3YVpSSWZpN2lTUUdoMlZUdXU2dGNaZDkySlFpaUE5?=
 =?utf-8?B?UHJ4RGFTRmtWVFhySkJ1QWVrQitobWVpSU1CT2p4VWwva3ZZWmJhdmQ5S0Zq?=
 =?utf-8?B?Y1lHcUV2MDQ0blRnMnM4YTlRUk95QnJoZWxaUzkvYWsxR3ExK2wyelRZSThk?=
 =?utf-8?B?bndkbVpVczBYVHhHemtraWFGaFNpYnRBZkhNR2M5RmhCQXV0WGhDZVlNdTZC?=
 =?utf-8?B?TjBMelpQTzRTeTgycmJ0T3Q0K3hac1d3MW9GQldlOER1dFhmc0h6eVIwN3Qy?=
 =?utf-8?B?Ym9SZ1lYV0piM1poQ0NJSnhqd2NOOTUwc25ZSE1FemlOY3dCRjNVTlhJeUE1?=
 =?utf-8?B?YmVLRXZJWEd1NUNsbTZXTU1YS3BZT0tOVzZZRHJ0Rnkrb2w5N0tJWU1QWWFw?=
 =?utf-8?B?TUt0dFZyT0hIUDdTTEx4b0s0a1NocjNKc2VmV0pVbzlUbTg4Wk1JSHdzTTVS?=
 =?utf-8?B?eUh0WWl1U2kyOWxjMmd4ZVJMbnZJWDh3MFpodERZVFYvbjFTREpkQjVmRHlW?=
 =?utf-8?B?QmcxT1FTbGdHYTlvZlBjMTF6Sm1LbFhUWHBXdFRaYWYycHlHdFZzT0g1SjhT?=
 =?utf-8?B?QnJ5WlJFUXNTT2UyYVpUSHZmUUpHcDBiT3h1Y0wxQ2YwUzZHMXY0akdURDBV?=
 =?utf-8?B?aTNkMTNQWVcvdHNSWHNEUmxlL3p1Rld2aWxYd29Xb2IvMnN5VDdCOEs2a2hp?=
 =?utf-8?B?Y2dOcnJtbmJEL3AvRmhZazNnVUp1ZjVxd1hNcHg4MEx2WlZFd0xGckppcEpt?=
 =?utf-8?B?L05maDI3RGJLWXpNWWVsTHk3TVJsTFpabGRLcGFCc0FmMUxGTXlzZUUxNytG?=
 =?utf-8?B?RUR1VUhMRUdwU1JjcXFUakc4NjRsbnVKSURuaDZadjBiZ2xhSmpIeHNMbTRo?=
 =?utf-8?B?Q2FoN08wemJTQVozSDNRQ29QaWNhRkxtUks0TUxyTmRkR0MyTmpsSDhSQnRt?=
 =?utf-8?B?KzVBOGtyTWloazQ4ZVc0ZVl3VUtYYWM4WERCY1pteExyYjd3T3hWOFN4S3U5?=
 =?utf-8?B?cWE4OEdaa3dsZEd1cjZaTlAzN0RZa2RvRnJIMkxaL21ZNVBoYVhNYng4ZWFI?=
 =?utf-8?B?VGFhWlRick1Rb1dLZkJjVkFTTXdFUWZ0V1grcVlQSXZBOVlEN0p1QTcxV0xr?=
 =?utf-8?B?OWlNQkNtRElzcTl2cU1kdTRkbjJBK1Yrb3V3cEUxMTlSNEl3QXVSSEtwVzNH?=
 =?utf-8?B?OG9lWmhmTVdCbEtLYXBFamdNQ1RHWXEybzVCVWxqR1VMSUtJQTAxeVBVWkRk?=
 =?utf-8?B?ZERlQWdqNEhQT3NEYy9rNjBaajRveCt1ekhCaVZTMU9HTGhqR2lEcTJFMlcx?=
 =?utf-8?B?MzlSdzM1cWJXVFl6ZExvbWdBQnM0Qk1Ga2RhODdwYzZZL3VIdGpSSUR1dlBu?=
 =?utf-8?B?ZWYxUHZ0elJhQlp0d3hsNEY4QTMzMkJmL1llWHNuSThXeUljaWJrWnVyOW5X?=
 =?utf-8?B?N01iajlWbXNuMW5hM0hGRGJsY0ZycHM3dDY0OExVcmMxK25uMVRLSmptbmdJ?=
 =?utf-8?B?NVA4bE5wNkdOS2J0UXVPK0xqeVlZZVcvM1RwS05NS0tFNDl1aWJETU1MczJl?=
 =?utf-8?B?OWlvQ0xlUmtRZFEzR3NYbWZGQWwvUUlrYkRiT3Mwc04vTmRIR0hzeXFBMU1Y?=
 =?utf-8?B?NWlRTW1mY1hKeFBDdXdsVFA5OS9rSmdFRHcxTzEyalBsTXB6ZjVub0E4Ym05?=
 =?utf-8?B?QzRjUkNYbHFYOGVYYW9heWptU3ZjRVprbVEvZjVJUVkvV2R5T0hDaFJFTmhY?=
 =?utf-8?B?TDhZR0lES2VwZm41dGFUb3VxcjdmTzhaMnRxWVFVUHU2endNY0NEWW8vNkpH?=
 =?utf-8?B?eG9CVDd0MEpWTXQ3RDk1YzZPcEQ4bDZCNTdzL2dSTHJscEg5cUpsVWZGcFF2?=
 =?utf-8?B?REhMS2pyM2wrRXB0Y1k0RUExV2N6b1IwR0RuVGpRUjRtaUZtd0F4SHYzTTJR?=
 =?utf-8?B?clhEV2JpVTU2dExIRWZxZDZNRE9FU0x1eFlIOGR1NlA3bDZJVDR6UDRnUjF0?=
 =?utf-8?B?SEZpcFU4VGJ2NExFbytZTzc4aXgvVkN6UTc1aS9qVUJJMFcrUDBlTVd1THM5?=
 =?utf-8?Q?J0mAHycMkLK0iJ5KyIJCndYAE?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483130b5-769c-4913-1151-08dd0d2d6047
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 08:44:29.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ofSTAQbArqmkgeqAKHhwwLgOuuDG32HPA0sG4r5rOg2fetLM2J6MT79nmTRui+6nNnp7rVSRq7qs9NW7YVFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgyM+aXpSAwOjQ3DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJh
bGlzaUBrZXJuZWwub3JnOw0KPiBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytk
dEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+
IGZlc3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsga2VybmVsQHBlbmd1dHJv
bml4LmRlOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDgvMTBdIFBD
STogaW14NjogVXNlIGR3YyBjb21tb24gc3VzcGVuZCByZXN1bWUNCj4gbWV0aG9kDQo+IA0KPiBP
biBNb24sIE5vdiAxOCwgMjAyNCBhdCAwMzowMDo0NEFNICswMDAwLCBIb25neGluZyBaaHUgd3Jv
dGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ID4gLXN0YXRpYyB2b2lkIGlteF9wY2llX3BtX3R1
cm5vZmYoc3RydWN0IGlteF9wY2llICppbXhfcGNpZSkgLXsNCj4gPiA+ID4gLQlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSBpbXhfcGNpZS0+cGNpLT5kZXY7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQkvKiBT
b21lIHZhcmlhbnRzIGhhdmUgYSB0dXJub2ZmIHJlc2V0IGluIERUICovDQo+ID4gPiA+IC0JaWYg
KGlteF9wY2llLT50dXJub2ZmX3Jlc2V0KSB7DQo+ID4gPiA+IC0JCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KGlteF9wY2llLT50dXJub2ZmX3Jlc2V0KTsNCj4gPiA+ID4gLQkJcmVzZXRfY29udHJvbF9k
ZWFzc2VydChpbXhfcGNpZS0+dHVybm9mZl9yZXNldCk7DQo+ID4gPg0KPiA+ID4gV2hlcmUgdGhl
c2UgYXJlIGhhbmRsZWQgaW4gaW14X3BjaWVfcG1lX3R1cm5fb2ZmKCk/IElmIHlvdSByZW1vdmVk
DQo+ID4gPiB0aGVtIGludGVudGlvbmFsbHkgZm9yIGEgcmVhc29uLCBpdCBzaG91bGQgYmUgbWVu
dGlvbmVkIGluIGNvbW1pdA0KPiBtZXNzYWdlLg0KPiA+ID4NCj4gPiBIb3cgYWJvdXQgYWRkIHRo
ZSBmb2xsb3dpbmcgZGVzY3JpcHRpb25zIGludG8gY29tbWl0IG1lc3NhZ2U/DQo+ID4gU1JDIGlu
dGVyZmFjZSBpcyB1c2VkIHRvIGRvIHRoZSBQTUVfVFVSTl9PRkYgb3BlcmF0aW9ucyBiZWZvcmUu
IEl0J3MNCj4gPiBub3QgdmVyeQ0KPiANCj4gV2hhdCBpcyBTUkM/DQpTUkMgaXMgU3lzdGVtIFJl
c2V0IENvbnRyb2wuDQo+IA0KPiA+ICBzdWl0YWJsZS4gTm93IERXQyBjb21tb24gZHJpdmVyIGNh
biBkbyB0aGUgUE1FX1RVUk5fT0ZGIGtpY2sgb2ZmLg0KPiA+IFN3aXRjaCB0byAgdGhpcyBjb21t
b24gbWV0aG9kcywgYW5kIHJlbW92ZSB0aGUgdXNlbGVzcyB0dXJub2ZmX3Jlc2V0DQo+IG1hbmlw
dWxhdGUgY29kZXMuDQo+ID4NCj4gDQo+IEhtbSwgc28gJ3R1cm5vZmZfcmVzZXQnIGlzIHVzZWQg
dG8gc2VuZCBQTUVfVHVybl9PZmYgbXNnPw0KWWVzLCBpdCBpcy4NCj4gDQo+IElmIHNvLCB0aGVu
IHlvdSBuZWVkIHRvIHNheSBpbiBzdWNoIGEgd2F5IHRoYXQgdGhlIHJlYWRlciBzaG91bGQgdW5k
ZXJzdGFuZA0KPiAndHVybm9mZl9yZXNldCcgd2FzIHVzZWQgdG8gc2VuZCBQTUVfVHVybl9PZmYg
YW5kIHNpbmNlIHRoZSBEV0MNCj4gaW1wbGVtZW50YXRpb24gaXMgdXNlZCwgaXQgaXMgbm90IG5l
ZWRlZCBub3cuDQpPa2F5LiBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4g
DQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCu
pOCuvuCumuCuv+CuteCuruCvjQ0K

