Return-Path: <linux-pci+bounces-34266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26CB2BC69
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F7E1BC177F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C81DEFD2;
	Tue, 19 Aug 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nbfVJ1cF"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9F217F23;
	Tue, 19 Aug 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594070; cv=fail; b=M2d+YPCs00mhRFaqMfCk7sBRG0ABzSRJBMTi4YhIq7fDjVEOxcPUYNWvqSnjaS8JXYgXfL1b3hkWiWVGLZVfdi8tpBj4gLsk7K8LHSkWtWyJdI0t5QTAinxowg1JLrGgejwHfCI/C4GeEp5bhrB1FknQcPPn0SER1IZArmRNVCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594070; c=relaxed/simple;
	bh=NfKX19XgQwuLDDNhmEiv5LcIUJCWoRltLyPO+4kJ/gk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qteNVEq4eWGjGbPzYKvHg9stbDbZYaiMKh2fH8kjDs7RmHnlFPY/gH6qeVU+VTbK9F0jf/tcOv0SYG8xLUbm/7+04pGSrvGAHIgdVJfR9PSrNLq91d9rZx9Wl9i7D3pmvg8AdkoQ0B+15DwUUvqGqpy43NM12a/SOn0GCOk9WeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nbfVJ1cF; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiJBzaxNm/C+y5+6J1ZIKCJjUtBpmAb7ywr5qA77T0t/7ZnFGIvKxFZRL9sHy2i3R7xyDqaP1LVwqlPz9frIFmigwhYU9uVy06Sl5D5fbqXa6xTqZNf+mn3vOg5MNLmrjj3oIKh9+ScaqDgXljHNKRmbPl+ME84aovkWyPDviqeNnGNUwrq42PAq2g/MzR4h4Hvq84Z6dxWI1X6YCKAkCmqXUaBL0d2PYE4hG1yTU0+xzuYu6RVELC7KvZ00xXwXTzIIekueTc+3OZAhFuz1y7S4aVsPnRFqsxW0SWqOTm+7LJIhouaKhosb3+I7Ry6JJIcHf6s9M0PFqzQPk2Y9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfKX19XgQwuLDDNhmEiv5LcIUJCWoRltLyPO+4kJ/gk=;
 b=WeHtwHcJ3WYWBEu+SRWSFHoPQap6DIjN1FTBpWyB7hCp8fDESxAVacINU6jaH+YwIT+0dH5G7nXUQDmBwJt7WtgujA1M6bvAYFd1OzvK6JLjJTIYvLTKl6zjpun5MxD1ruMtM6h3YmNYdy942dUsZEi8fUraM25nbhaV985+jBAMgz+736/DZW87SHyFHWHZLSjCRnhEoeKvHDgOVJDv/LwJOWBrQcpTJt7Lk1Of05ukY5nw0ljsmW26ZHKmNka7+Lu5gOsH0LCaGfaISNFr3kD2yWGGG7TVrGE6AZhyyTg3WpvSCw9EOdy0ZHDzKRVpVhPm28eujhq6Mj+8LzN26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfKX19XgQwuLDDNhmEiv5LcIUJCWoRltLyPO+4kJ/gk=;
 b=nbfVJ1cFv9uyIYksVS85xYfSTfnUsXVo26frXDPEJy9kYZcqzTaSNUawn9RiIVWxB3OulbNK8b/x7YryPgkCOh5oL87ooLsQyZabF/coEyCtMhhTKjUTXZ4esN3p5LYY7PQoTs7y8b7JfrDjw45buqB+DAaU1cPG7xWxILu3GHzaWKe23PQwhZoItQdm7GtZ6kPPc5v/gjY0Toz0y9Pp6ZcMWsM2Q5xpPDRh1v+u+OQQZcUyMKwtQIkZ13J0KCYgNS+pPZoBNoRUY5HSY8smm3XKu60uhGF2mZOcvRokbnzElQumb9Xsl6lj0Cmh4VVtacEY1zLwaJ5TTc5zo8BDyA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB9306.eurprd04.prod.outlook.com (2603:10a6:10:36e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 09:01:04 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 09:01:04 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: PCI: dwc: Add vaux regulator
Thread-Topic: [PATCH v4 1/2] dt-bindings: PCI: dwc: Add vaux regulator
Thread-Index: AQHcENlGC/FzSnPusU+BkeqdGoXKOrRpqZoAgAADiIA=
Date: Tue, 19 Aug 2025 09:01:04 +0000
Message-ID:
 <AS8PR04MB8833DF96022E981E2766B9768C30A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
 <20250819071630.1813134-2-hongxing.zhu@nxp.com>
 <qnbwtgsl23we56tzdt2bih644uqrojwssa7d73a3s7hpsfc3v2@4653fhoitmpz>
In-Reply-To: <qnbwtgsl23we56tzdt2bih644uqrojwssa7d73a3s7hpsfc3v2@4653fhoitmpz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DB9PR04MB9306:EE_
x-ms-office365-filtering-correlation-id: f1607af0-f43c-4614-d063-08dddefeed83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sm1nTHhaYWhoaFNvdHR0L1MvWjAxakM3dTU4Ulk0TkVzZCtHR2FabEZ4N052?=
 =?utf-8?B?Uk44K1JnZ0NaYXpmbis0dFk5RUZJd3JuSnBBTklNRXpnMStNMGhabVZKM0J4?=
 =?utf-8?B?WHgrNThUNjVBL2FudFZMclcvUWdTbWJZTnp5T0xkUDFOWVNweDBJTnVuRXZo?=
 =?utf-8?B?ZDVSaTNzZXpvR1RwZ283c0lKMGRaOENHOS9MTytoWVFwZVVYeU80ZWx5Z3ho?=
 =?utf-8?B?QzZYWWV4UFpqWEo3TE0vTlVXVjZ4dHpXZFN6WHVOd1RNL0E2dzRnVi91akhH?=
 =?utf-8?B?akhnT0VPMEFFT00ralMwYnFUN0F6L05udEdTa2RGNlVkUFEvR0t3QmRCRW5m?=
 =?utf-8?B?VEVrV3d4NFVzQ2Nzc2pzdmZJTDNXTnBiUmNnSFB6K0ovOFY0bU5XOUlkaWNv?=
 =?utf-8?B?eXJhRTlydmhnVE1pYWVJRDVqdTB3V09UNmtXWTlHeW5lNXFLb2xwUGtYS2Iy?=
 =?utf-8?B?Q2RSZko4M1RIZDdzZ2hpODZhNzUxOVgraVB5RmFjOW9RaTBFZ3g0dXUxMkkz?=
 =?utf-8?B?RHBzNFVPQkM4M29wcE1kd0VjeTR1SzB2WkhQd3RzNVNJVGE5VlFES1ZRU2FE?=
 =?utf-8?B?KzRBSFJ5elZzYU1PY042bldTZDROSTZGYm9nY2M5cGVEaE8xd1R0cVhvVDUz?=
 =?utf-8?B?UVRBcTdvMDdlTXhHOGNUU0V2azY2TG02OW9xcnRCRTJieTNhTzVkajNYUmZa?=
 =?utf-8?B?RlA5QWE3QjBzeUNMUUVtdm5qSEpIY0xtQ3RJUGU1eW5ySkZ5eXJ5WkhVZk9u?=
 =?utf-8?B?ZXYvNDhPODJ4dHU3VnNLNWxEUldYdERLY25hNVI3QkhVWFNUbTdHeWhibGVK?=
 =?utf-8?B?QVBGZFVhdXFtM2VCb1IvUzkrcnNYenQ2T3cweXZqaExPYjgvNDVua2Fkcm81?=
 =?utf-8?B?cnB1SjkxL001RDRTd25rVlk4Szh2VGhkQXJZcFIzdG1SV2t6SDVKWFZOcjNi?=
 =?utf-8?B?SlZqNWxHUXZiRW9pdGxSNi85R3o0Wk1nSGVRZGZLVGNDNVNGdUZiN29scTFB?=
 =?utf-8?B?NWIrYmw4dzRJcDVaby9aMmZXaVMwWVNzUldhcFhydUtWZHZ3WTRTb0pBSTdp?=
 =?utf-8?B?TUVHQ0pyc0JSYkkzcUxaQlI5SllyRmpWK3pFNWJpTjdOblIvbUV1anp5WEFy?=
 =?utf-8?B?a0s3c0RNK1pQV0hDSjcxMEJvZWs0dFNJZnNnbjlNUzdCVFUzc3hINlpHVEcw?=
 =?utf-8?B?V3V1MFdNUmIzbS9BUVViNTk0MkR0T08zdjRnZHZ1aHFWTzUyVnVFZDh5a2dC?=
 =?utf-8?B?SVVBVkpjb2hwZWY0cHVEamY2WnlpbGhFL05vd0ZGeENvRlV3NUJEek9BYkZU?=
 =?utf-8?B?bFFFOWt5RVZYUlh0M2tJYnR6dVZrbVp3ZVdXQ0ZZeUhwQzZ3QStHZ0QyNU5R?=
 =?utf-8?B?UlpSSnZ4eG9YQ2NrUXpOYS9xbENXYWhuNW5GQ3RmMjZLTEdCUnptMmhRcm9T?=
 =?utf-8?B?M2FyM0VXY0F1dzRVQ0FUWVRibjlJOTkyT3BYcFF1ekhQUlk5Sk1RcG03TDB6?=
 =?utf-8?B?QkVsSjlXS283TlFoUjlWelNUUWhvUEM3bldIem42bEFBTjBSaXh4ZUhmc1Fz?=
 =?utf-8?B?QlJIK2pYL1F5c1FZeksyRW1KcHBDTkpPWXJTU2xVRnA4SGJTczd4ZHhQMGR5?=
 =?utf-8?B?V2F3cnZSc1ZLUE1PRUJyNjJUWjVaU3pTMGx3bk9UWGpyd3EwUCtEbmhESHdp?=
 =?utf-8?B?c3ZjaURtTlh5bHdPZDQ0VDZpb2Y4ZU14RlBxY3o4TndHWWh2Y3dxTml2WDln?=
 =?utf-8?B?NFBEaVVRY3BUS0c1c0RHRGdmaStma3orL3YxOXNHM0g5cEo0N3k3ZCs5ZnVl?=
 =?utf-8?B?YjRJS0xUUXNqMGxZVW9CMnRiVEVYN3FVM2wzaEFEY0UrcUJXcE9zODBSeXFn?=
 =?utf-8?B?ZU5ZWDJQb0laeURPaTVEeTZieTcyMnZwcUxmdE1OdmV1L1RQQnVtVEFHT3VV?=
 =?utf-8?B?RzFjdUxaejI3Q3o0TzE5N25TSzg0bFgrNlVlVVdabWtpRXJtd2VmZEkyb3FD?=
 =?utf-8?B?L21VWE9NQXVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDc4WCtHZFFLZUVxeHVESlk4Q1pZUnZvUGF6RjExazhjL29IQllsOFNIN2di?=
 =?utf-8?B?UVRLYnhXMUZiNU1tU014NU01dkdBbG12RjBvS29TdDJ1d001SURrVlJzWmhj?=
 =?utf-8?B?N29BRGVTcGRuNnl3Q1lRa1l1ai9vUEdIdjdLUG9HL0JldjNSVENzWEx1L0JW?=
 =?utf-8?B?bVFwTCsrbFN5cmlIR2UyZ1hPamN6azZvSEtESXhNdjhvNzVHcjlOY3dIMDJC?=
 =?utf-8?B?bDhsaEJNd1hyZGh3dm9zL0xlSy8rdmk2ajRWQmhON3NQanJrNVhkd016RmdE?=
 =?utf-8?B?SjcxVHI0V1lPTHJaL0hzaHFlclc5NFgvUnRNVmRUTUtuVk53Q2RUM25LSGlF?=
 =?utf-8?B?K0hEWWVvMXB5VklSeUE1ZkM0TU9kK0lhQUx1Wno3SEhVWkNFbkNHbmtpWWgz?=
 =?utf-8?B?cUVkenhzeWN0ODZtS1hqUEpsd3hBN3ljdTYrcmpjbFp5WmRVbHpOdi9lUjJN?=
 =?utf-8?B?Z2RnS2M4UmxJL2dyNmtCeG54N25iUEcxdUNrQ09DSzFRdGRZR3lFb0dEdFJL?=
 =?utf-8?B?VEhGN1pxdVVnYThtM3VrSkJ1aElGcjNUNHc1TDhyRURRZFd4eG9CdTZMbFFi?=
 =?utf-8?B?TFRibkNiODJrTExQdWhLS2Q5R0pPSTRZQ0RRdFdtSUI1NS9kcTFSeTJEVU9w?=
 =?utf-8?B?cG50cnJBVlYyekdZOHJNc0FzTUliYkJxNGFvQllkVHhPQTVQSnNPK1Y0S3ZT?=
 =?utf-8?B?UGRWSXJ6MVlsaDk3SGhLd3EwWDZhVzl0NFgrckZac213ZDJQL2tZUlJ2UWwx?=
 =?utf-8?B?MUtFZXAyZmgrOVV4M0FLQ3gyeVBhYWpUR1ZYaHV5OVc4SWlRb241dUNCVjBx?=
 =?utf-8?B?N3A5NU15djVkVis5WTVPVVFxT2FTQmpmTWhNZWxFbDlwdDJPeUYyRlpGblVQ?=
 =?utf-8?B?Q3ZnanltOVFIOXZJWGtaU2VxK241SVNSTWlRdXVvU2tsa3JITkNUSkJMNito?=
 =?utf-8?B?VlUwYWZsYlgzWGhUNmZFQmhNREdYMTBzK2JrZEtlalFUVG1zU011blYwbm9z?=
 =?utf-8?B?cWlpRWlPRUl3N3VhdkIrVFFwN3JmZFlWYmMxTy9UcGZDWVg1bzZ5Rnhwak9p?=
 =?utf-8?B?OFFBUEdVRGdyZTFCV2VHN1R0czBJVkRYTEN5L1NxRURwOVBuc2pPdDFLblJo?=
 =?utf-8?B?dkc2cjVidDAvTFFPUnhtQzFxd2pCU0NSd3FNTHBuYlU1SkFGNUQ2VVlvbG4v?=
 =?utf-8?B?eVhIMnNtUXNjODAxNlBCRzRkOXJXbDEzaytQc1BBR05NeXo4WHg0R245eG1M?=
 =?utf-8?B?VUp1VGxFdytqZ0pHdm1oQlUzTGlwVlc1YklGMXNlbFp4UHozT3BUWG5udXp3?=
 =?utf-8?B?Z3FWT3BONU5tL3QrUWVSWGJpOW1mRG45NmRvZ0xNd0c5TnhxNkJwT2p1aFRr?=
 =?utf-8?B?aDVHOCsvWVRRUE5INHIvelJJSlk2QS9EeVVSay9DL2xmSEVsMkFKQ2d3TENu?=
 =?utf-8?B?SkFuSVYzdnJxV0JVTVpRMm1jb3NzVnA0M3l4N011OWowMVgycUNXK3N4dFZp?=
 =?utf-8?B?NHB2SUkzVmNCUXBQbHViSWJpWWJDcUdaWkRLdkJFZ2l4d2FabGtnTzRGbENX?=
 =?utf-8?B?aVZmSGplRzJUMThwNHhtTE5TaXNrM28wQjBKVkFPaUhRTmhVR3RXL2R1ZDZw?=
 =?utf-8?B?Vmh1TVMvRUxIVVdVWlhOek9rakdRV2FBTlB5N2dpU2t1Q1kxelpvc1J6V25H?=
 =?utf-8?B?WG8vd2d5MmJ6dU1QRXdRNGw3VXY5RXdKazJ1clhFOFFXczVCQzhqNFQyb0FR?=
 =?utf-8?B?QjMwSzdZOW5HTmxYcWtoSXBnbExTc3BuM1ozekVLKzN2d3Y5UHlHb0NYSTRv?=
 =?utf-8?B?Y0s2eXdvRlhFUGhjSmdkTzh4WHdOWWVsOHVudUpvdWxmNmdCOU5wUmVDZVR6?=
 =?utf-8?B?VFBIWEtFd3d6R1NpQVNVNWtpRk5LQ0QyenIzYjR5cUw3eW9vMzVucVIvMFJr?=
 =?utf-8?B?QksvY20zTS9yT0V1ajEyYVQrRGg5UE1aTjhRdDkzT3dvQjZpQjNpaTF6V0J2?=
 =?utf-8?B?WGtBQXpnTENQK3Zna04waXJmcGRNQ2FhQTNwVlpCWlo4ZTg4dUJ1QlVVTGtX?=
 =?utf-8?B?L2pNL0t2aE00K0RvWHp3WUh0UlFYa29vVnhBdGdPY0lIazZoOU42WHhZTllH?=
 =?utf-8?Q?PKqc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1607af0-f43c-4614-d063-08dddefeed83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 09:01:04.4289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrtSZ5cGeGOfe1rUz7g06qEqspNT7YDmMfCbZa/HRLp3WOab3Vl7weiEGokNoeeo0GZoYadzHkRyCAW8f52jbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9306

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDjmnIgxOeaXpSAxNjo0Ng0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBr
ZXJuZWwub3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGty
emsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIGR0LWJpbmRp
bmdzOiBQQ0k6IGR3YzogQWRkIHZhdXggcmVndWxhdG9yDQo+IA0KPiBPbiBUdWUsIEF1ZyAxOSwg
MjAyNSBhdCAwMzoxNjoyOVBNIEdNVCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gUmVmZXIgdG8g
UENJZSBDRU0gcjYuMCwgc2VjIDIuMyBXQUtFIyBTaWduYWwsIFdBS0UjIHNpZ25hbCBpcyBvbmx5
DQo+ID4gYXNzZXJ0ZWQgYnkgdGhlIEFkZC1pbiBDYXJkIHdoZW4gYWxsIGl0cyBmdW5jdGlvbnMg
YXJlIGluIEQzQ29sZCBzdGF0ZQ0KPiA+IGFuZCBhdCBsZWFzdCBvbmUgb2YgaXRzIGZ1bmN0aW9u
cyBpcyBlbmFibGVkIGZvciB3YWtldXAgZ2VuZXJhdGlvbi4NCj4gPg0KPiA+IFRoZSAzLjNWIGF1
eGlsaWFyeSBwb3dlciAoKzMuM1ZhdXgpIG11c3QgYmUgcHJlc2VudCBhbmQgdXNlZCBmb3INCj4g
PiB3YWtldXAgcHJvY2Vzcy4gU2luY2UgdGhlIG1haW4gcG93ZXIgc3VwcGx5IHdvdWxkIGJlIGdh
dGVkIG9mZiB0byBsZXQNCj4gPiBBZGQtaW4gQ2FyZCB0byBiZSBpbiBEM0NvbGQsIGFkZCB0aGUg
dmF1eCBhbmQga2VlcCBpdCBlbmFibGVkIHRvIHBvd2VyDQo+ID4gdXAgV0FLRSMgY2lyY3VpdCBm
b3IgdGhlIGVudGlyZSBQQ0llIGNvbnRyb2xsZXIgbGlmZWN5Y2xlIHdoZW4gV0FLRSMgaXMNCj4g
c3VwcG9ydGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
c25wcyxkdy1wY2llLWNvbW1vbi55YW1sICAgICAgICB8IDYNCj4gKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLWNvbW1vbi55
YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3NucHMsZHct
cGNpZS1jb21tb24ueWFtbA0KPiA+IGluZGV4IDM0NTk0OTcyZDhkYmUuLjUyODNmNTEzODg1ODQg
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9z
bnBzLGR3LXBjaWUtY29tbW9uLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL3NucHMsZHctcGNpZS1jb21tb24ueWFtbA0KPiA+IEBAIC0yNjIsNiAr
MjYyLDEyIEBAIHByb3BlcnRpZXM6DQo+ID4NCj4gPiAgICBkbWEtY29oZXJlbnQ6IHRydWUNCj4g
Pg0KPiA+ICsgIHZhdXgtc3VwcGx5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IFNob3VsZCBzcGVj
aWZ5IHRoZSByZWd1bGF0b3IgaW4gY2hhcmdlIG9mIHBvd2VyIHNvdXJjZQ0KPiA+ICsgICAgICBv
ZiB0aGUgV0FLRSMgZ2VuZXJhdGlvbiBvbiB0aGUgUENJZSBjb25uZWN0b3IuIFdoZW4gdGhlIFdB
S0UjDQo+IGlzDQo+ID4gKyAgICAgIGVuYWJsZWQsIHRoaXMgcmVndWFsb3Igd291bGQgYmUgYWx3
YXlzIG9uIGFuZCB1c2VkIHRvIHBvd2VyIHVwDQo+ID4gKyAgICAgIFdBS0UjIGNpcmN1aXQuDQo+
IA0KPiAzLjNWYXV4IHN1cHBseSBpcyBhbHJlYWR5IGRvY3VtZW50ZWQgaW4gdGhlIGR0c2NoZW1h
Og0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZnaXRodWIuDQo+IGNvbSUyRmRldmljZXRyZWUtb3JnJTJGZHQtc2NoZW1h
JTJGYmxvYiUyRm1haW4lMkZkdHNjaGVtYSUyRnNjaGUNCj4gbWFzJTJGcGNpJTJGcGNpLWJ1cy1j
b21tb24ueWFtbCUyM0wxNzkmZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcueg0KPiBodSU0MG54cC5j
b20lN0MwMTBmYjExOGMxMzg0ZGZhMmIxYTA4ZGRkZWZjZDBmZiU3QzY4NmVhMWQzYmMyYjRjDQo+
IDZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTExODk5NjAwMDkwODMwJTdDVW5rbm93
biU3Q1QNCj4gV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVN
REF3TUNJc0lsQWlPaUpYYQ0KPiBXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0Ql
M0QlN0MwJTdDJTdDJTdDJnNkYXRhPSUyQmgNCj4gQ2dyd2ZIRkdZMkQ1JTJCOGRTNFhSbDRob1FX
RzBKcFVtRzVCWmhSeVclMkI4JTNEJnJlc2VydmVkPTANCj4gDQo+IFNvIHlvdSBzaG91bGQgdXNl
IHRoYXQgaW5zdGVhZC4NCk9rYXksIGdvdCB0aGF0LCB0aGFua3MuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N
4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

