Return-Path: <linux-pci+bounces-16353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1489C25C1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379D5B21367
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76A1C1F21;
	Fri,  8 Nov 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5J5RoFi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D021C1F16;
	Fri,  8 Nov 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095035; cv=fail; b=Tqdb2RloVDKq+JrcDrUGqCecT//PTFafImNsblCirnNJkyQzjuLhjJQ5+QTojRbySkjVq4QVMTmzC690fZ+vRLyGV9bplgFT9jGM0aycvcAuhvnGXH2PvMTnB4mbV9GplsyxSVwH5hZ/63MabkicSh9kw+NhmnaT76OCJaXMI38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095035; c=relaxed/simple;
	bh=WztdJXCK+bOn8jeGvfQAh0AF4COBEh+c0a1xNE6MdUc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YjOlbrKIErVL5gv0nhz2ucdwqfTgV7XK+rzazBL3dCp0vWNy+zy4r+zYutD/N5f4ePF9BKmoQkMPxbSG7BwqqV5Iq7RqBT0L01sFKyHoWKQvMiTbAKLswr39thKt+EMozwRppF9bHnRM73kYSIpnSupxFc8og9ReBm7YGFmDYY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j5J5RoFi; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1lQs/34QqmHGoYvbZK/tIVd63FRX4AP5vZAaUNgaWu4jRcVdzWmYQCJPgQnULvJzve5dNdxGiFF2zqMeFw8tPigftbmrIDYEZ2VyoJsd4A14M0XbgDzzwxoqNrMsYkND7mwPiNqw5CDC0PGlBXAS9Ss8fEMf1Nz4ad01kQQPcMXEr4xV/4Y2o7aDjemWu6lmz8jz4BTG6SYRHwbSQm4qN71YActgMpAAbzZPz1mvKOzpsuceD+u3U7zgRs4b0MyL0R+qSJqV5puXH3Xeam5XhLBrpkbm55yFuj5UvKhrVSPPaaKro2sQDdOjSTtxrhDoRuLCzq6ZP/bjTEHl18cZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oan0nT460bnBSfdOKCXlsarwBLEOZ6HSByQIFZo5Sn4=;
 b=gVNoHuklKIZ8upS71l/vXyZR69j4OCFQrDnlTE3Do8BvkF3sLFj7gnpdI/UPwJKRDWiXzdHGr3JC3dlcX9bbkJfvVW8w/eQC8lopZCJe3SNMGdfzHUFRTy0kFT4ZzECkXqgiMXwiVebjrdB64inncbkpY6UezbTyrYVkcT8Qt9xbFw3vIkNUkAYpOuMqxlpZhxJjP/1YWzLkpyQPppa+miPe39dFzZzMXKAqaI1//cnsf+shtLh+Hd+8eBTxpI4AmK8v/YTGa/lZi0FGTtKCwauaOmor0hRzGF01NX7cr23SGCBfwGkVSzk1UG1m/ZO3eF+LdYhR1ggD41zMGqwOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oan0nT460bnBSfdOKCXlsarwBLEOZ6HSByQIFZo5Sn4=;
 b=j5J5RoFi/khEthsDtWlfpefI210zhUETGEerKIh55cavdS9OkZL8zIxr6rLsWm0ySpItPStK4u9MOWhypmhwLLTBVsHMqDTkpJl9dd1AZlp/LA+oQvlnNyI5F9iPSgAk77VJqDz6Rj9YlqKwaERpZx7WAxxfdsGtmpFnAr0pdg4kRta27U+RYEj7yjA0t30ix/cl/PucVR4VlGYrnkK1gDbK51WY0wBn4Ury9h3IPoyzVl2meSHLA4B59LSG4gpSBG0FCI7YQnbPos9azNKARKJMq3nhA5aCVmBTpDE2LtItNQPXEz9Vba8U32pGrUj62EwRWNUVqch6HKwdmEUhoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:43:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:43:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 14:43:28 -0500
Subject: [PATCH v5 1/5] PCI: endpoint: Add pci_epc_get_fn() API for
 customizable filtering
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-ep-msi-v5-1-a14951c0d007@nxp.com>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
In-Reply-To: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731095022; l=3101;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WztdJXCK+bOn8jeGvfQAh0AF4COBEh+c0a1xNE6MdUc=;
 b=WzIrwA/pzq6FFZORMOHmhUyIAxZ/vFNUiz53+QK8oEmX6EA51zP1387OhPP6QBwimkhPeoaJT
 zFiTsNr8URlDDwYKP1gZMlrVSwKWIcfVnPlwpU1HMmAtL0rHmmF3Uzm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3dea47-3e97-4c6c-65a0-08dd002daaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2FzUTAwUTFicDV6dEhyUDl6RUdWblJGc09McFp5aVBmSWs5ZjMvWGpkR01D?=
 =?utf-8?B?TmRBelpqUlZIMHgzM0xNTm9yVVRGeHpNaFd4SVF1S1hBQitFQUFwanJ2Um1i?=
 =?utf-8?B?SlhHM25WMXBXNlc2OW11UFpzTW1YRW1zaVRxck1qSkl3d2dHT0kvRnJxKzFP?=
 =?utf-8?B?V0g1d214dzhOYnNKQnEybDUwQVNPbGRpZFBXc1dNdTAvWkFnVnVLQXowL1lG?=
 =?utf-8?B?ZTJwQjIwNVdIWFNDZVIxU0R6cDVCOXdhWGphdUFRS0dmK3dqTWpOWUNCamI0?=
 =?utf-8?B?SmtXK2ticVBNTFNJT1M3Z1RVa0NocU5ZZWhsd0Yyd2RkUTBqZThxQ3N5ZE1U?=
 =?utf-8?B?RE9rVzBmaVd5R0dNK3puL01xbVBiek15RlFPRHFqTS9VNjNjS0VYN1p3c1Rt?=
 =?utf-8?B?UzJxRWVJLzlybHM4Qk5lU1IvcTk2UmxHTjBjV1ZIcUxPOU5xdkRGMFV1aGNR?=
 =?utf-8?B?aUtreTVhYTVkZ29zV1c4ZGJDTXFRL3NhR0o5TG5LOE5rL2h3S3RRdWNQUjR3?=
 =?utf-8?B?U3d4ck4xSEtVV3IwR1FFWXYrVWdQdmZUbllpSk1ZdWN2RDJpMDA4MmJMSGZR?=
 =?utf-8?B?ZU8xUlVMZHhFcWhwbkJYbWhSUnAyeHJJbDZ5NXJwNllnMTZ3Q1Y5NDkyTVdu?=
 =?utf-8?B?bURTRkx4a3BIbzJ3R3VqckpPTHZCWjBGZzgrWWFMSUdUMlZibmMycXRZMit4?=
 =?utf-8?B?bW1CdUVUZlkza05UazRWcGdMUmNTWktmcmt0cDJTY1U1VXZrRC9MQ2dNOWRq?=
 =?utf-8?B?c1h3ZmxnZlRGYVh4Q0NoQXZ0TFBOd0psbDVjdEJ1dldCSzBNbHp0b2JvWHlq?=
 =?utf-8?B?cjVhVjZLRW1lN2hIRUhGdkRVd2RJOVBlb2JTNjlXRXVUbkdoZ0VuazJBVTBJ?=
 =?utf-8?B?MkdIZm9yTjViblZyR3NqT1A3d1J0c0N0UHNXTE5KZGZOMmFJejhoLy9nYmRq?=
 =?utf-8?B?SFR5VFoySU1uWk1YNWl0K2dSS1hjUDlEWTV5U0l6WjU1OWkvaUJqUFE2TzFK?=
 =?utf-8?B?QytIYy9ybnZIb2pZd2Y4eXBaWHU1dklHSVdlbFR4RkgwYk1sWmVzRDNZbzBX?=
 =?utf-8?B?WkFRZGdRd0VabkVsamRGdEU1M01XUlBwQTdjUjBIZXdlQy9WU2dwVDB2ekxl?=
 =?utf-8?B?VjR1QVRoMGsxWEd1eUg1aWF5U3ltdjNucitjOTNUQWVFSFhtV2VNQzc4dGll?=
 =?utf-8?B?YmhXMldlWFhDRVRnTHExQUpsdG9jallodnVOcU9SSGdSRXZyS0JoV25YREIz?=
 =?utf-8?B?WnpOSmFVZ3NzNlZ0cTZFL3c4MHFJN1lVZjhhY3lWblZKdnQvTlBXaUJTSnBh?=
 =?utf-8?B?RjJmb3psVnhxVmRPSjdpUFUvc0RscU5tWGpmLzQ5VWIyVjlQUVNFclJMdXEz?=
 =?utf-8?B?c0NDdmRhNTFUWUZrNFZaSFpaSEoxait3ZXFlYTJWV01yT1ppZDRzdUw3TWEv?=
 =?utf-8?B?cG5UZGJmQTJKTTNXZHRnYm5NWnVYV200Z1JoZDhjSzIyQ3dHYXBMUzVMUzRP?=
 =?utf-8?B?YnhoYUEwUjZWT1pWMEpHaER6cEdqdy9YbFBaOXdmQUE4VTJERnVKQituVm1E?=
 =?utf-8?B?b0JEN05zNHZaempJR3VJM0p3SFBCTDAvRXlBYXlXMUNqUStPRlh6RG9TVzlC?=
 =?utf-8?B?U1hTaUNrelM5ODhEenFCU1IvWFFNQmloT29jR3RGa3BVci9UZHp4RDRPRkhT?=
 =?utf-8?B?b2V0eFdqbDlqUFdBS002cDhlY2JjbkdIWEZ0ZTdxNkMzdldUTFcvajVhZjBU?=
 =?utf-8?B?bnUrd2Q4QUxhSG94c3Bza01rYkxpdkE3bEpPMWJ0bHZLN1BlcGRNTWpmM0lR?=
 =?utf-8?Q?ppvV0z+yIMorYpEeZ5uIj3Ip7r/NmX2RGC6VU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlZhbHlQamxFdzVWQ0R2ZXVTaGYxb3pIUHpZSklwL0xrU2VpYlNRMGxpdnBl?=
 =?utf-8?B?a1pzclFXOGYrV1hjWmdxYWFwWUU4K2IzWUNWZzRNUWYxUXlFbTJ4a0I2NlJO?=
 =?utf-8?B?UEgwQ3Z3Qkp6TWZKUmprbzMyWkdUamtyK3FuckNDN2lCMGtIUHJENGdJOTBJ?=
 =?utf-8?B?TXFjV0xLQ2FUbkRRSWhudmxJUTdiUVUvblNzcjJGMzNpTTRTcmRqN2lreHVO?=
 =?utf-8?B?dm5vMDhETU1abjgrcUVkZDhpMGEzVWVLWlFGc2laQ3J4ZzFucUJ0MDArVHZm?=
 =?utf-8?B?cTdqeGNoYklJWCtEcDZVMU84Z2RmS2VVNXBWMjg4eHNNQ0pLRDJQdDVUU1ly?=
 =?utf-8?B?MVpQSEdUTHlodUo2dmE1VXNRbGhsRXpQOS9GMHQ5OTZQNVQ5VWREYlZrWFg4?=
 =?utf-8?B?NVV5a3FLSFNJeFBUVStZUDBLZ3IxRXA2Z0hFQWptNEw2TWY3d1ZIcHVqRDFO?=
 =?utf-8?B?SzhEa1g2UW5abC8rY2NuQUtaTjI3OFNUTVl3ZThoaXRiQ1V2RVd3bVcvUGda?=
 =?utf-8?B?U1JkL1NYSWppOEF2aC9HR0tDNGhTa0ZTU3ZjWTFDckxTQTErcGpSUXhPazRq?=
 =?utf-8?B?Zk12c0RrKytOSktqY2pSbUpvLzJLN3NlcVNVVWppUGtLb05hMjBCOXUzT2pW?=
 =?utf-8?B?TXR4RHFlYVRKY3labXBzSWduY09uenh4eXdzZkZSSXJFWE53alNQcU1ISnZS?=
 =?utf-8?B?aFBzcTNpclFGQmNvME5INFM3RjlSaExQTTFRaTZNWXNrSS9KaHZKbUdpTGxW?=
 =?utf-8?B?Q3lyUU12cDlSa3VaTmlnZC91dDBlM25tYjlXZlpsandhZjh1NU04RUxtYUZ5?=
 =?utf-8?B?enJpTlhyMFRUQlRzN2dsdVEvU2pQQnUwRzE1aXQxbVRyS1RJN3YwTG9wTGlG?=
 =?utf-8?B?a3k0Z3p1Nm5lVk9pTWRIcktqVU92YVF4U1ZZN2lpZUlxd1BlYlg1Zy9MV2Zx?=
 =?utf-8?B?cWxQU1JHUXVEbnRqZFpwMk0xOGJiSjBCN1BOSzFCSjRqMStxN0RGakw3c25V?=
 =?utf-8?B?RGttQVk3ZVl0WGp3Uno2cWRvUHVISzBSVGtrNjhtT0QzdU1nc2svdWV6TDJV?=
 =?utf-8?B?R01NTE0rNzYwdkJwVXFENWZIc1hKeFVMbE81YXowQU4xOFBsVUxlS0FjSjFM?=
 =?utf-8?B?ektoRnIvZ3NVb1pNWUVXWWFYZmlKZ25aRUFrRTE5Q3VYbThPQlc0eTNUTXJq?=
 =?utf-8?B?ZXFkLzBrUmlZVjBQS0N6Ung2WVdQNHUxWTRNU1dYL0dHQVFaZ1ZXTExXWUth?=
 =?utf-8?B?clFmSWErVW9kaUZPZitEdHgzc29MWEU1WWFueWQ4aXJCdDlKNWl3clNzRXNn?=
 =?utf-8?B?V1liSVRKV0Y0WXNPc21SaDZ0RXdLK25vRThtMk1RMVBVbFQ2eW9LRXlKQjVW?=
 =?utf-8?B?UUV5cFZoZXRKakk3eXRoKy9NWTY2bldFUmhscnIzclVLYzJ0UVEzMytpUHcr?=
 =?utf-8?B?Rmd1V3lPOVJzcWlsRFYyaGpHb0Z2dXJucDFIZEhWUGpJdFJhL2lacVZSSnRF?=
 =?utf-8?B?M0kyUkl1d2J0b21EeWhlcEpWbklBZFpuSWFIK1VnVC9waWRCbmt1NU1qc0Vl?=
 =?utf-8?B?NThoKzZoQ3V1M3RIN21nUzBPa0RTSmVOTEh3UmpPMllZK1hjcHFJbUVuZVdj?=
 =?utf-8?B?eUJIa0l4VVVsQnROc25PeGl1bTlLb0Z0djltYlN1cWZTZGNIT2JkNGRyL2Rm?=
 =?utf-8?B?NEdBQ3psU2RrNkZadzgrV1Bpdmo0SHJZeGJUR0NxazBubmQ2U3hKY0pJcUVi?=
 =?utf-8?B?aDVSeXNGQjdCeGlFTGRkTm5ucjF3WWx5YnpNVmpUUWk3MXBFTVhleU9XdFdS?=
 =?utf-8?B?MDA5NHV1c2l4UnNLdHdrSFlEUURoNUU4MWF2c05nQis1SW9TdURXc1hzakVS?=
 =?utf-8?B?NkdxM3pNd3ZraE9rN1pRZ083QXF3L0pwTmVnSkNld2pNbk5lUlRpRnVPSGFM?=
 =?utf-8?B?RlVDRVNvRHcwTmhLNUY4MUhkR0pBTGpocjh6SlBLQXdRYmQ4ZU9yd3VtS2R5?=
 =?utf-8?B?ak1MOTB6em1wMnJNTlh6emRaSkowZ1BvY3JoUWsreGlKWHJKL0lBSTg5YXNS?=
 =?utf-8?B?QUs5Q0RMdFdZSkZhR3Y3ZTlIcXBKeFpzc0pMRGgwc3NjTjUxakJJN2c1RSt6?=
 =?utf-8?Q?lfY8pEW2GfvXvfD/cCn9O6dsP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3dea47-3e97-4c6c-65a0-08dd002daaba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:43:49.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BTpAVaYxm2sEosB8PeI2Lv7NtDyfSrRv//Ftm+Mioc/l5ovr/3akshbjmpk8OMiacRwf7/MGL+Kw2Xmv2TykQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669

Introduce the pci_epc_get_fn() API, allowing a custom filter callback
function to be passed. Reimplement pci_epc_get() using pci_epc_get_fn()
with a match name callback. Prepare the codebase for adding RC-to-EP
doorbell support.

Add DEFINE_FREE(pci_epc_put) to implement scope based auto cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- none
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++--
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f0071092550..14e6011df4b2c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -48,6 +48,11 @@ void pci_epc_put(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_put);
 
+static bool pci_epc_match_name(struct device *dev, void *name)
+{
+	return strcmp(dev_name(dev), name) == 0;
+}
+
 /**
  * pci_epc_get() - get the PCI endpoint controller
  * @epc_name: device name of the endpoint controller
@@ -56,6 +61,20 @@ EXPORT_SYMBOL_GPL(pci_epc_put);
  * endpoint controller
  */
 struct pci_epc *pci_epc_get(const char *epc_name)
+{
+	return pci_epc_get_fn(pci_epc_match_name, (void *)epc_name);
+}
+EXPORT_SYMBOL_GPL(pci_epc_get);
+
+/**
+ * pci_epc_get_fn() - get the PCI endpoint controller
+ * @fn: callback match filter function, return true when matched
+ * @param: parameter for callback function fn
+ *
+ * Invoke to get struct pci_epc * corresponding to the device name of the
+ * endpoint controller
+ */
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param)
 {
 	int ret = -EINVAL;
 	struct pci_epc *epc;
@@ -64,7 +83,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 
 	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
+		if (!fn(dev, param))
 			continue;
 
 		epc = to_pci_epc(dev);
@@ -82,7 +101,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	class_dev_iter_exit(&iter);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(pci_epc_get);
+EXPORT_SYMBOL_GPL(pci_epc_get_fn);
 
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 42ef06136bd1a..682808f4510be 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -266,7 +266,9 @@ pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 					 *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param);
 void pci_epc_put(struct pci_epc *epc);
+DEFINE_FREE(pci_epc_put, void *, if (!(_T)) pci_epc_put(_T))
 
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size);

-- 
2.34.1


