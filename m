Return-Path: <linux-pci+bounces-17596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4179E2D46
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BA516572E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6F20A5DB;
	Tue,  3 Dec 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kHBZnV+k"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBF205E28;
	Tue,  3 Dec 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258251; cv=fail; b=JLR3sUO0rayG3g5LmWmEcj/dDSvmYZseWweA60M5ZPI0zhyric5dU4ylkKmHCJZucZznUnuUWFZ0nRbMuD9E/r8T0ty/8sxXyQr6LS/+Bjm6qP1P8Cerghw98mESOFMdHLa8avkkfzJBvYR4pWrYiYJ+j2rt2iYCTrmAqkLh1yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258251; c=relaxed/simple;
	bh=TLSUdRmp4K+Pa1tSim9uHX8V2yONts3GeTemgjKsAlk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KHKuTnvGVrKu2UACH3/2KZ/k3WwdPyKRUo0DDysax6Q3rY+N1lATHT/WsTurXuqZCqrexnX+ZdllDRif5XrvaZnl1gI+eKvXpJyfxFcsowHPIecAoGXGAXstiWGjavERLMzfkPmpGjb+6jIizOqwEGVKZVPB29rlaaKe9vYgfRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kHBZnV+k; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTBR2zM/WYLBYoQ0AxXjiDIqa/Nv9MjxSP+pAwn0l3lBvQtVcTWCzE87EN6F+5pZ7oAKxrARC2enQGsDKyDKFGWowPjHPff2t6uPLnt7fo8LBEBw42LfIbqzrWnMDdza2iggmr9KHAV4Mjmk5RjeTGdFSoo4YX/dPg0ekcv4gH1/7O6PtHQ4lEIwKgl9ri4MG7OrdxqW2REt+7mIk40AFk8SwjBAKplQ2jdO7OkWsJOmEP0QEtd/eQlCB9QvHNMW1mD3JNZNDNqqxOFbSXLQf0DtPn4J1GLE8NZnwQot7t3K8H5lok+bMHufUEJyfNj4EI3lmynrzCUQbEmbF2nQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeYMnHiz9JJVFA6A4TlHysF/6enoLKYcE6EAntXbX1k=;
 b=Ba5fCSQix67hBOHWWggRt1dFTJuXl1l2y6MIDzKpb+mLE66gfZNProHVj0EZUahlfT3nLevqbatbQuRl6j/y5cpyyiGSiQNwJgA5EeTOHYss8zUTs15s+1vHyB8BI1tWCpEf+u2MJVI9ZPQDCU5Phk7Ws/wLhLjrs639aT5PzGbsDDdqwYezf6tR9pe9F7eDZkMtlYSpRgSUwSNpAUhZBOwtPIf2lW0mYR3iGq7dI6nr715Ayq8QApzMYn0LAg+ChdJDQzFdpN+HLAFJCWpbT68iy9nof2rDlvjUX8tE7Ycz9f+x2Tuk0zzMlQMpJEYZcIa50uq+XEowJm/LqJRalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeYMnHiz9JJVFA6A4TlHysF/6enoLKYcE6EAntXbX1k=;
 b=kHBZnV+kxcexcNBrrku4DSUUz+dZhpiiZHLyLdLi2nJkzZ6Qr8s2zJV3dNBgg/Zb06M4o7fY/Dhtw1C/uFfNY7dL8D2VVAAsizcsuQ4annATAnC3bIyyLCuj780v0YG5vMPAbOoCCLoRcs229pIiTLKvBPzz1EDe/RnmMVFNh+xxRSRJn3BUt+dQDs6eZsRpIUvI3WDRnQeByex6V5M11ks2GuXYcEZqdKoNeSLu2fIo9btjPsf5L3UJEW37/Z/DMKuM4+nrJGyZUg7EfX8+R/6mc6w6H9JuzcGuGe5/kny326E3PTdE+IpaCFz+djtOXmaAd3af8fB7xbawYhhIJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:37:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 15:36:53 -0500
Subject: [PATCH v9 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-ep-msi-v9-4-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
In-Reply-To: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=7859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TLSUdRmp4K+Pa1tSim9uHX8V2yONts3GeTemgjKsAlk=;
 b=fGJEtd0+B/foHLN/kaRCLNRuEb09muUN2U21JQ2RerUDLlgi7xhumj5uX8/NHnlGz8zNKDQqk
 qsH9pBQGMKVBkSo5AjLO1f2NRcgcfn3x3fomPOurttl8+eoQP4Kx7Qn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8f2714-f677-4fbe-21ff-08dd13da4c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGhuQVExUWRZK1lXN0tZV2dLTFRsZHVhb0JyZHByTlZoRGVQQ0lpeVB4b2F1?=
 =?utf-8?B?K3pDM1o5SUx3TE9leGdEMTByQlpCdVlYcXprTGhVQ3R2ZENraTZEVWo1QXZZ?=
 =?utf-8?B?TDgvdURLdjNVTmozM01SY3hVYmtsOGx3cU9NczVVRUpkeENnbHdHbFJMZERE?=
 =?utf-8?B?cFBFaVduc1piOWR5enVHVk1qTmdDS21sNGd3bzJ1SE02Si9VV0hnY2VVZjZO?=
 =?utf-8?B?WkREVmN1L1MxazlkV0NvTFN0K3QrdXJPRTg2d0E4L01wZmRqUW9PZE9FN0Rp?=
 =?utf-8?B?aWlGOWcrempCbjg4bWhjMDhyUU1hUUZUYThhY1NrSmUxVjgxcXRIU2p2b0x6?=
 =?utf-8?B?cEhVQ3RXSUNRUFVNQ0dZTkRXZDd0c29NS2xnU0tKcldnUXo4S29rTkVuVjU3?=
 =?utf-8?B?OE95RnhWcnZCSGlTUEFKbE9Sb0ZrVmlmdUkxVWNqd2V2QXE4VzRyUUE2S1Fs?=
 =?utf-8?B?SFdjN1JWMmk4d2R2c1FtUk01cmdGbGMrdndhTXhDUWJmWGlPaFZkRXovTjB5?=
 =?utf-8?B?QnFnajVPeVkxRDhxYTdOdkQvUmhSYXREVG1laHhnQzFsMUVZaG53a0QzOVg5?=
 =?utf-8?B?eFE2OEhrWmlBbzlISDVzak9iczhORmo3cmoyYkl3TFV1MHowZzk4c3FrZ2o1?=
 =?utf-8?B?Zlh1TVF5cWE2QXcwTVpJR1hNc1JyaUgyMnpNVTc4SU41Nk16YzNMWFZhbzhH?=
 =?utf-8?B?Qkg1TGU5OGtrUVhNUFdKTnhzUlgwZmVkV25sTERubHRCeDVab3gvMjl5dVlU?=
 =?utf-8?B?dGpDY3ZvUUV4WktwcW9LMHFJNjJTMFFUNWJON2Y3TmY4bityemtxUWNybGRK?=
 =?utf-8?B?bXVsS2RCTTdFb1R3cVYyR2FWWC9POEMvSDBhRnR4R1Y1NlpPNndqeGs2Wk1z?=
 =?utf-8?B?WWR2MTJKYVl3VnpwWlViK08wVlk4Ukp0cHpCK0R3M3ZmamxxTHNJaC9uWmgy?=
 =?utf-8?B?aVkrTU1DOE02SHp5OTlZT3dQTlpzemJjaTZ2d3p5VFBtdlA3emFIV2dLTlRX?=
 =?utf-8?B?Umljc1NYTk9ZY1lMZ2ZLQUdxVmVIc1p5Zml0MEk0NmhWVWF5czRPRW9weG02?=
 =?utf-8?B?em9XUzZEaTBxbzVGZjgvS1U5ek4wU2VkK0Z4d0J5Q0lSd0pkQ0pLQzZGR3Z5?=
 =?utf-8?B?MzNxRDJKNERtV0dnZDcvN2VaWDZlUE54RHpXTGk5ZkNlempqWk1lZDJSM1Jv?=
 =?utf-8?B?ZVora3FCT2JuWE1EZVJEQjhXV3dUakpITFJZRVY3U0txU20xRWsvaXN3SFNp?=
 =?utf-8?B?Z09SZi8vOUtDdWhra25hMDMzV2pBbXQ0ZElxRVFiVGFXR1YwQTJxaVc0K3Va?=
 =?utf-8?B?Y0oyM0tyZ3FSTnZ0amlYcnNnUEdUUXF6L1BqaE42UmpLSHJlQzVtdlpqZVV5?=
 =?utf-8?B?VE51VGRVck9HdTZEdzlIckM3MVRMWEc5V2lKNkhGN21zVjVRTU1ESzRtOGlF?=
 =?utf-8?B?czlabWxKMzRVRmVBSjJOa1JSb3p4RjRvK0ZUQmpnV29ScERYdTZxVlg1S2Fs?=
 =?utf-8?B?T3kwbFlxK1BlMjVoRlFsa1hSVElOTWI5bXZlNnE2ZVlvb0Zub0d1QWY3eEdq?=
 =?utf-8?B?dVNScW90d053MEV0bmovMFVPdzg2MzJNSHJ2bkRwOFJFN05ZWW1ZY1hZTzFI?=
 =?utf-8?B?cGFPQlNCT1dNaEVTMENvM0JKR2xjeGpsUFNoQjVjNnhBd2ZqMWFLbDlOT2RV?=
 =?utf-8?B?NmxwRGVVRkdlWTBDbzZXTncvM3hjRCtDUlMxZzJXMEVjVHNMT0pWY0Q4UUZO?=
 =?utf-8?B?REM0M1RtVXpaQU96NEJTYTdYRisvVWdtUnovcTh6NTZrMkgxWDFrd1Vlb1dm?=
 =?utf-8?B?YWd0d3ZaMUpSRGlTSmtJOTNsL1ppMEJXSXFTZWF0aEEzY1R0ZHc1ck5YOXZi?=
 =?utf-8?B?RFhESnVFQk9GRloxc1p3UE1uL1lmQ1kvOFkwc1pzWVNIUUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alFoNjF3d1ZUQkpPRFNmMllubjdYVHNSc1JOYUlIMm1yazI1MWYxZXhNSmYw?=
 =?utf-8?B?SjduVzQ1dlhLS2k1blIydmFCckpNUVJwTnFGUldrWEF0UWtOTXI2VFRwSGlE?=
 =?utf-8?B?T2NYMDFIR1NreWdhU2RiTHV2eDgxbjZjaFBCdFB3eHEwNHVJZ05rMjdlTU55?=
 =?utf-8?B?bTlvcFNlcTZEeEY2RkFVT3lia0dzakRYL3doZGVSay9LT0dBdnFYS0hJSnY2?=
 =?utf-8?B?UWtYanBaMWJUdU9HbXZhdEtEYmVQSnZqRVVaMERRVldZMnZQZHdWWTVJVWp1?=
 =?utf-8?B?cVd1d1VOLzVlRmJ2L01GWHRPNFNkWmNRTTBKSmRTL0tBZXB4Tm4yWERrWURk?=
 =?utf-8?B?NVFMMmdvMzRpZFZZRUZLSW0za1FTQlBYVklPWGhZZzJHZEVGSUs1cGQ5M1pv?=
 =?utf-8?B?UmVkaHU3OTIvU2VkRzFHdW0ydTVjR2JxK0JXT2Z4SXJrcEw0MDB0cW1tN1ZB?=
 =?utf-8?B?STRBTy92aUtnZzJ3QUZQTDhLZmlVQldVS2NuWUVnSUcvQlI0VEhPYWxDc0pR?=
 =?utf-8?B?WEZyRDdwazE0ZGNSV2FKTVJxakFJcitZZlBOR1NZLy9TS3RKdk5VNEpWdkRj?=
 =?utf-8?B?dG9ob0pVUXlHb3VNbUgzMUZxZHArSC80Y0hqZG9MYURKQ05XYTJPSTZLZ1JT?=
 =?utf-8?B?YWlBSlNtdVNQc1AzRnBPMHVvOXFXVW1wZVZ0VnA0eE9RZjU4TnRFbkd3ajR1?=
 =?utf-8?B?ek5JaUlyZGd1NzBYdGJSb1FPT3FCSWRqV1R4SHQ4U29yWU5UUEdFL2lrYUdi?=
 =?utf-8?B?Rm9MVW9pbFJ2YWU2OFFSUE5KM1h4V2YzeG5yRmQzWGhlK3hCNi8vU3BvbElr?=
 =?utf-8?B?WFRzMzlRSkhUR1U2eHRDemUvSXVQa0NRM05BR1ExblZnNHp1VTdyVldDaWY1?=
 =?utf-8?B?NWM4TlUzekJSZDcyUzRkcWNGc2M3RG5NQXFlRFZmcnZ2cjdsV0N2eitiYmhn?=
 =?utf-8?B?RVlGcUFQaFdqRGVSbExuR1NpQis3SlNsQ09xN3FQdVdFMXhoMXZFMVZxV0Rt?=
 =?utf-8?B?QXRaSHJGRTMzNlFzeEh2TGhnbjRSRENHSjU1MUhJNzBUanNOaGh6M3N3clhX?=
 =?utf-8?B?V2ROU3BrSXRoLzdCSFd0Q3UrcTByNEZMbi9ITmdkOTRCWElGUm9TVmJTMU9J?=
 =?utf-8?B?WlRkNTU5SlZrcVZnYXFNMmhuM2FDeUprR1NuWjlwVTZUTXU2Nm9mcFI1M09S?=
 =?utf-8?B?TjRqL3NGcWkwbEtqZFcrZXc5SWhYMmxYSXc1OXk1aUJvU3dDVnczU0Vldnhr?=
 =?utf-8?B?bXlQVjhCRE1BMWxzNkVkTmFoT3hjSzIrMElWMGpGbmsveEJQYm93dFcxSVMx?=
 =?utf-8?B?OVZZcU9ueGM5Z0w5d1NlTGtFSXVRdUF1NFFpc0RWOE1mOXlhUlBrd0t5Zmlx?=
 =?utf-8?B?N0dJeVhsazNuaTlpQU56Ty90Mi9hQXN5MDhMY1NNRVY2cmdpTkRkSGRicnRr?=
 =?utf-8?B?RDlaZW03aVpCOS9QTzE2T3hZcWp6S1p4M1h4RzFRaVhRS0lyRDFBZVVnc3Yr?=
 =?utf-8?B?c2gxdWdzRkJjUlJBclNDRGVpV1N0SVVvMThDRjRPMlkybGllb1JBb251Uk5i?=
 =?utf-8?B?U21xUnQzTWVsTlpMekFKbk8vYmtNT3NzR2wvd21rRjRDSXdtNnpjbnVqVkJx?=
 =?utf-8?B?OXF1RytwNTVxRjBzMFAyNU5ma2t1ZGpuT1QxTjg3K2tWSWFIOTFLZ1lyTXRX?=
 =?utf-8?B?WXJhNmpFS2Z5dmdzMW1jeTMzSWI2dHZwRXhnNnZPa1pUakRrWDhsaE5pYi93?=
 =?utf-8?B?VWtKc2ZxbzFlcE1TRUdVdnNRblVaaUxuWkZDYUd4Vytoc2tZZmRNWnhlQ01C?=
 =?utf-8?B?NXJ4QTdlWndYVk5laGM0K2l4OGkyWU1rVHJrMnZ2aVp3WmpHc3gvcFg2WGVV?=
 =?utf-8?B?UFcrL2QxOU9Sdk9leGt5a3JEYXpaQlhyVy9VRlZOVFB2eS9YbW5pWitCek1t?=
 =?utf-8?B?ZUxTMW5FTzZVRkFhZzdrWnZ5bmFRTVR5RTNvS1hJN0pXYzViN01OaEVVZFRi?=
 =?utf-8?B?Szk2NHdpV2l2YmRHT0ZsUDZnVFZ1Zjh4Vm42L0dDTXFpTmpVckQweDhDbFlZ?=
 =?utf-8?B?WmU1eWtjai9NWHJxRVg0RTZXdWdhSmZzUzhvUzhibU1UWVFVclJNREdtOHRo?=
 =?utf-8?Q?Zl3Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8f2714-f677-4fbe-21ff-08dd13da4c64
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:26.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f33mPSi5zC6V1uCJqBUqHf5IvGN35Qf3K/5vpz5mjETmVJfgyHd8x7JCZlE2TQ5wACic9oQ4f4sPG+8Y1G4jyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..a0a0e86a081cb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -642,6 +654,117 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = NO_BAR;
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_bar db_bar = {};
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_data = msg->data;
+	reg->doorbell_bar = bar;
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +811,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -934,6 +1065,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


