Return-Path: <linux-pci+bounces-33438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904AB1B8B7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EED11707BF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E025293C45;
	Tue,  5 Aug 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TeJQp+tB"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC1292B52;
	Tue,  5 Aug 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412284; cv=fail; b=bsQ1XELUCZw1DAgpjTIHR/2LtXJY2VzQ7SJkDAnT0hcdvXF00/BNnGXtlkgWOcHDENSC2Am3zyegNyequ6/c3Sn7+RJmVAVMU9/v1Fe5awELEllPDsYnPbrYrBhLWA07huRbETh3iEI2LwvYl9XPtJqIhygTLUp/7QJMMRNsiAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412284; c=relaxed/simple;
	bh=zZ49hlunI80GkiisMjSZZ4aLp6dbTqxg8KYT9ApuMKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uh6057Uk77+IGEXHh0/LamM1QZHsH5utJ6V7S+hyI/sbF7S18jlLcLfG3EPxXZBNg+iVbxKUSiq1M8Wj+nBJsO488Mh9zWWkrmgC78gzvmDg7aMZ5MZwbn6hDDy7L79W9w8oINeeQHGnwcVbGnQjRlDSvn0MZzSK/uX5OHhttuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TeJQp+tB; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8dkE6KZUjtp1py8BqrFzoByDcOtnIGX4HQN31C5gn9JXqghArlfC/HDsUDmNYvskmyVmhOX9TXBS2qWN5JlW7C8F39bOBdG7RsLG/e2uFE9FMithQfsWmH78U3ma2nbZbfm7rdlNj8NK87N14EFb8P2f6YzyNxbS4eldkMx3mvhjp4Y6lL8nbvou68rbAv+lSvPC4dHTuu3YgNF2xfQlyHDxQyXWHs9FNL7wRpiW4Mlxb1h8uC5I9zdv+SMlAu4xkz1p+zGdu9ynLPe6qvAw8tlxWhBd/+apAlwTR6J7RIa/7jqpmV67GHeyhICAhmAjiSd7P5kSKv7Wth3yqWxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9b8Jjx9AKdlaRhtRJ2sXJYh70EDIf+RteQNhWv8XTg=;
 b=MkxNYPDUfXxTXmt2HldOpWyUOoeuKahKPWsSk3vFzTMTdQFPMkR9qXPjPlnnP+yLwE9J6lI/obRU104nyDPhZu96d8v+djz/0M2fIfFYiDZUdSCWA4NfB+LLg790XM/HuPKnsRw/X8cPiiAEuRA28bdOia9utH4QbO9lXNHxyYTz5E6jBQKWwzRs6sZajE2lSUCtDrtVx42oMhZ/5JIMTipjSO1msiTftbPuL9M1xC7KP+igNH61teZMX4HlUlWA4srC+b8IpjMdoEb3okrpF7hG1eRksdQkVYhny3zbaebNmd9z2ZgQ0x/4tQyM9LIKuZp9CP+zdTI7BRD6ou0lAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9b8Jjx9AKdlaRhtRJ2sXJYh70EDIf+RteQNhWv8XTg=;
 b=TeJQp+tBrGEGk6jYbviuO3p6hBmNgmzJt3myo8h91JxHAndNw6Rf0usNn7K8LUreLuyFUDU9PUGV2Nibc2HZnLFWdkzmWwIpl7rlxQ2FcIikVnVn6DLKWlft1Gq3JNrSzSigf4vHs9ZOkuSbQxrbhKL7WKYEz42b65sRlpAq1mbJYaIlD1GWsEY2EEDKg6WyZaRsamfVZx/HLR1paiFnzkgSc5fmPfswWagTsW+IBYP4RwcTEmra1BBLTksiU18CX2y39eENXB9ExUIKviefnaKmRuBb2KjyOpCaFy1OpXgd8i0N0z9vntYf+w4utC2dl/a0Rg3mqGxKL9jKxPKL9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6972.eurprd04.prod.outlook.com (2603:10a6:10:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 16:44:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 16:44:38 +0000
Date: Tue, 5 Aug 2025 12:44:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH v2 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Message-ID: <aJI07hBmKNrsGFv9@lizhi-Precision-Tower-5810>
References: <1754358421-12578-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1754358421-12578-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1754358421-12578-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3d1d37-757a-4ca2-6efa-08ddd43f5df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmFQbEdad2RaNnNORkxxaVBKSmRNSnVuTWErVEZDa04xQ2FWTFpyV1lOT3FS?=
 =?utf-8?B?bnZMdjE4WU9vS2tRWkdKT2hTZnhJbmhqSngzclphTjFkekpBYkdWd0lXcC9T?=
 =?utf-8?B?b3dzY05NRTFEdCtQK2w0ZENjL3A4a0tUeTJLQXpjdmt3blBGOGEzL2llZG4z?=
 =?utf-8?B?c0xlTjlMY0NQamZxY2ZtUzVuTFUrRkFLWXlvcHV6QnltTWxGTlI4YSt5a3Bh?=
 =?utf-8?B?TEpxaVVYUWdnRzVwSWVXbXh6NWk4RTZMVlpkMk5jSDBrWlYrekVoQ3NiL2tk?=
 =?utf-8?B?OHZhckl0M2VpUHJJV3RMWllveVB3TmZFNkNnaXZNbUtjUk1wYnd5LzFSb3Ux?=
 =?utf-8?B?dDJPZlBnRC9FWXZKV0liVjJOT0lkVUhVZ0U3ZllpUEdzbks0SXFaSjNkYlMy?=
 =?utf-8?B?UUlBb0JWcWNXK3ZPZklua2JxTnpXS252N00rWE1aUUpCbXZESC8zdURQdWxk?=
 =?utf-8?B?V1BPcEFBQ0c2NnJhVHpGayswUDVQTXNuREFGQ24wOHB0Z0ZvdmR3SGZUdEYv?=
 =?utf-8?B?YndPR1NpbHVVbmZhNTd6WWFzNVIrTU9wQ0kyUVBNbGxpWE9FN0hacFZ3K3Mz?=
 =?utf-8?B?dUdMd01ZcGg2bndvSGlzQk50UE0yYS9PRmVJSWRGWGwxTVM4aGRMWHhPSkNs?=
 =?utf-8?B?R2ttYk1KcjlLeGc1Szh0d3ViK1Q0M0t1TENUWTFTenJrWFVOdFBZakozZitQ?=
 =?utf-8?B?WFJhb1BacGp3cXZISWpzVmNiTjR4dkU4Y2FpZVM0N3dDa0dwUDczNURDazEv?=
 =?utf-8?B?S2U3dnc3MW9XZHdVK1JIcTFKaGJNRU13S3JjV3JXZ3VBUEQ3QlpSUEw2cUo4?=
 =?utf-8?B?Nlp2N1JVc2pCTWZDdDhJaUZRb2dqK0hjZWtxcC9qWE5Ud1ZlM3pQSVpCVHZG?=
 =?utf-8?B?c3F4ajNXWmtOTWU2RkR4cWtVU3ZpZGs4T1M4WGFRdTFSUDU3T2xUVVhGVkgz?=
 =?utf-8?B?Q3JGcS9EaGh6WDc4d0lxV283VE5sVnNnb3hJWGNudGhZVkpFSlN1cFhZcWJG?=
 =?utf-8?B?S1lvL0hOaEk3dGdPakRsVmtwTlFablM3OFJ4Z3hHRFpUZzJxcmdZd0NvTFdU?=
 =?utf-8?B?Q3lIL21ybnMxL0tOYkdib2pDdWExVEgzaGhLakYvM1c0ZUlGaDI1Zy94SWVH?=
 =?utf-8?B?ckpuVFpTSUUwOGxsaHQ4Y1ozWmR1cnEwY0dQYmxDRnJzT0NwYmVwN2llU0hL?=
 =?utf-8?B?QXdSSmpJeTV2bE1UMmZtRk1TN1VyYlEwaTJucUs4bFlTZXhreFlkUXdwVW5y?=
 =?utf-8?B?K2lXUnFIUnJTeHlpTkExVGNPcmNHMUo4ZG1DMzVnNWc2NDhadEpMWFZZMmlZ?=
 =?utf-8?B?WXJOZWx1TFNUOURYSWFiS2EzWlBiUW5PUVJuOGo3Tzlmb2JTS2czZmxQOUZr?=
 =?utf-8?B?V2JRSCtpK0o1ZlU3K2QwbGdYS053Z2tmTTVhOVducmZiY3NwNDZBb1RTSkpQ?=
 =?utf-8?B?T3E1OVFnRmtwYjlUeDhFVW5HZlBJMCt2a3djQ2Y5dTF0TUQxRDNaTmc3SWtq?=
 =?utf-8?B?eUVOTVFxNVBtRGpJd0JlSDhjSk1aUXlqRGExanl5aGF3VnFCYTNiS055emxn?=
 =?utf-8?B?Qll2QmIwR1JBWlVCZ0Y0SGNJb2lRQ3psWDZjeG9vV1lNVnJ2MXJseFlONXYy?=
 =?utf-8?B?aEhCaXpzUktPL3cybTRhSklzU3lWZlRrTitxbktzak9hdXp4QVQ0dG5sRzVD?=
 =?utf-8?B?QURrL2lXalE4Tk05d3ZudGRhL2x0b2ZoTXVyN24wNkxyWVFVVGhkbFdnV0Mz?=
 =?utf-8?B?M2FMdTFCa0NVWkovcS9zMEJyTDlwODJUL3VLM0Fhb05ISC94eTg1OVQvbVFS?=
 =?utf-8?B?YzEvL1ZVNXFITVhKNmpqdjBxSjJ3RzFjWUUrcGsvdmlLMXora1J3WWUvRnNy?=
 =?utf-8?B?NFE1UUdoVzltbXBTVFh3ckF0T3ZtUmxqRE1MRDl3aHFoSWRpbFlRUlZoY2F5?=
 =?utf-8?B?YytwQzdseHBkVWZZZDVkNXRPdzM2cnM0VnBHa0NYd1U1d3dwYTJQMjRGSCsr?=
 =?utf-8?B?RnZrOHh6OXBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXpUVFJSeS9KT2cxYkxWcFVjWHhzaVM4bG5CQzQ2b0lFRjdjYnZSQTdrWnAz?=
 =?utf-8?B?eTJLdkRtaVg2bExPR2psd1NWOEFnL0oyUStRUG5ZSktNOUJPd2JhM2xaa1BI?=
 =?utf-8?B?c0dSa2FQT2htakY3OHMxWEw1VlM5bklRUUc2VnBEMGk0MWlEbjdBSndvMzli?=
 =?utf-8?B?SkNZUHlGbDRPYS8xVHpEQkVCYmRIM3ZaTWF2Y2ZxNXNnZjF0NXozdjc3aXhx?=
 =?utf-8?B?UXU1dUhweG03QTl2UXBWQkw4Wk1tZkJhYTVGeDF4cUZiMWFBTDg2V1RGOUFz?=
 =?utf-8?B?SG5ha1dmSTNKRHJKVVVNL1UwVVhWOFQ5YjlVYy9CVS80Q2IzT3JIbVZPMHA3?=
 =?utf-8?B?TUpBMkFTdzREMWZvYXc1dWlKS3A3ZUlQSjlsT3p6Q0dBODRXRDloZm5YZGNK?=
 =?utf-8?B?U3VnVzQvUERRYUROSm03aklHV0U0UTc5OXJWWVhkaHUyS3FNKzlBUEYyYVJQ?=
 =?utf-8?B?dVd2RXM0N2ZOVlJuTk9uRzE3WVJHTlpORU1ZU0pzR2FZRkR5bGFrY0hVUVQr?=
 =?utf-8?B?Tk10UW1PaDhTREJZNFZkRmxsRWZCVG1PQjAwd3psV2ZBb0wwbzM2TlA3cVFh?=
 =?utf-8?B?SGpaTzB3VnZFSDRBajVPWE85dU1FWitKcmFleHlXMjV0TFljc2kxZWZMc1No?=
 =?utf-8?B?djY4WmJDVkczODNaakJTWk1RVFFsQWx5R1N4N2ZiWW05MDYvdEZ3VEZzamJm?=
 =?utf-8?B?S2prR2VaQTBqQjdkYko3ZHRzMXBZdlhWbGRUUUQ2NmtrbWpCVkRDYXRFdU1N?=
 =?utf-8?B?OFNkeCtjUEg0Mlp4WDYxQUh0MnZIL2k5dkJjOTkxYTdxUkJGZnNCbTNpNjZO?=
 =?utf-8?B?UjhuOUdUaEc0QzNtUnA1UUZwUDhSQ3d5TW1pYXY5R0VPcmtUd1pmSy9zSmlV?=
 =?utf-8?B?MzdoNDJmRjdteDdqamtXd2lxTzRTbHlKRnFGWFFWUkVZYXFmYVY5N0ZYakhH?=
 =?utf-8?B?ZC8ydWE3UTBUWExGanhFR1RHOXpiejJPTE01a2ZUQlhhQUlsdCtaZUplOTFQ?=
 =?utf-8?B?cXU1WnVSa3pRL0pLQm90NDMzQXgxTkdjQ3RUNzlyeWFvWk93WklKbGRNdnV6?=
 =?utf-8?B?K0xqY0V2VkFESjE3NnZ3a1d4a1Jnb3BGSDhPdmhZaTQ4YzJ5MXM2NEY5b05M?=
 =?utf-8?B?M2RYOGRITldwdG9qaExidm5GRXg3WXdiQ3N0R2prT3ZtclpNQmppTjgxZjlv?=
 =?utf-8?B?ZGhyVHJZOWRWQWlPU0hPMGJONEFaMEFRVzNrMlE5dUZqVys4K0QxeXNhL3Fu?=
 =?utf-8?B?WUhoaW96M3lxc3NPMWZzYUliOHR6dG50ZVQ0TzNaRkUwNEdpaVYxbmppREI1?=
 =?utf-8?B?V2o1ZXoyT0FiODY4ZE1vWDRtVkpXeTc5ZWs4cERTUklxUTNuUUN3WVI4WFlq?=
 =?utf-8?B?RzBJSDRQeUtpb24zSDdCUTc3Z2RRTE1BQkMwcUh6VzlmcXcvZVRhL1prK2Jt?=
 =?utf-8?B?Nm10V3dJaGJFSmFZWUh2SEprWVBLWHJ0c3Npc2dzd0t2Z3BNUTVOcm12OHlp?=
 =?utf-8?B?c3hLSi8zOXRwUjk2eTdGeVBsdTFyZGViUEdGRGFrcGNYOXFlNEVsUnFvZEwv?=
 =?utf-8?B?bFZuZ1JGb1ZvVDlRMTNwU0FuZW5tcVF0dmZhUjJWRUFGd2cyNnFlMU1oSjV4?=
 =?utf-8?B?bTlFNWtTWEFhNk12RDFpNjgrKzF5YklpQzkzekRXYy9VYWlLRHl2ZXhBT24r?=
 =?utf-8?B?K3prOTY1bTI2L20wSCtSVERvaUJIM0o5Sm82VlczaWpWNjd6cFR0dlhIYTQz?=
 =?utf-8?B?a0VwTkRQcTBFT1cxYWxCRSt6bWY2MExpWTl3T2JSdGx0VWtqUEhCSGdkbjRF?=
 =?utf-8?B?NkF6alc2SWJvcit5cFkwSFhENXNNTExrc0RFR0ZWUGlrN0N4ZE9hb25SblFB?=
 =?utf-8?B?cU1NbGY0UDl5V2xOMlhjUVovSS80bGhFUlRPUSs0Nk1sTEFCbnFqZ05ML2tE?=
 =?utf-8?B?V1Fua0ZQWjhwOVFyRXMvRHNmc2JvWFhvU0pHMzJUSDMxUkE4YmNLTjFQOGxL?=
 =?utf-8?B?cEgwTHU5UlV3K25hTU1NT3lJQnR0RWc3U0RvZlo1NDNIQWtxS2U2T3Q1MWU2?=
 =?utf-8?B?WUhSdGFkWnpTVHBJdTZTVk96Y0NMSXJKdXJIc1NvZ3BrSjQ2eVN0Slo2UHRL?=
 =?utf-8?Q?3R6M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3d1d37-757a-4ca2-6efa-08ddd43f5df3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:44:38.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crRPNGD18UuJye0/pWPDs4B9Jr6Kgs84xz4gPJA4T3wdTEJfPPxNLHmrYFWmR0EynPkfEvi7CKnKrdX4TKAj0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6972

On Tue, Aug 05, 2025 at 10:47:00AM +0900, Nobuhiro Iwamatsu wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> tmpv7708 trim address bit[31:30] in tmpv7708 before passing to the PCIe
> controller. Since only PCIe controller needs to convert the address range
> 0x40000000 - 0x80000000, add a bus definition, describe the ranges in it,
> and move the PCIe definition.
>
> Prepare for the removal of the driver’s cpu_addr_fixup().
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> v2:
>   Update commit message.
>   Fix range.
>   Set true to use_parent_dt_ranges in pcie-visconti.c.
>   move pcie under the dedicated sub-bus.
>
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi  | 75 +++++++++++++---------
>  drivers/pci/controller/dwc/pcie-visconti.c |  2 +
>  2 files changed, 47 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> index 39806f0ae5133..b754965a76ca6 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> @@ -478,37 +478,52 @@ pwm: pwm@241c0000 {
>  			status = "disabled";
>  		};
>
> -		pcie: pcie@28400000 {
> -			compatible = "toshiba,visconti-pcie";
> -			reg = <0x0 0x28400000 0x0 0x00400000>,
> -			      <0x0 0x70000000 0x0 0x10000000>,
> -			      <0x0 0x28050000 0x0 0x00010000>,
> -			      <0x0 0x24200000 0x0 0x00002000>,
> -			      <0x0 0x24162000 0x0 0x00001000>;
> -			reg-names = "dbi", "config", "ulreg", "smu", "mpu";
> -			device_type = "pci";
> -			bus-range = <0x00 0xff>;
> -			num-lanes = <2>;
> -			num-viewport = <8>;
> -
> -			#address-cells = <3>;
> +		pcie_bus: bus@24000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
>  			#size-cells = <2>;
> -			#interrupt-cells = <1>;
> -			ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000
> -				  0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
> -			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi", "intr";
> -			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map =
> -				<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> -				 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> -				 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> -				 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> -			max-link-speed = <2>;
> -			clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
> -			clock-names = "ref", "core", "aux";
> -			status = "disabled";
> +			ranges = /* register 1:1 map */
> +				 <0x0 0x24000000 0x0 0x24000000 0x0 0x0C000000>,
> +				 /*
> +				  * bus fabric mask address bit 30 and 31 to 0
> +				  * before send to PCIe controller.
> +				  *
> +				  * PCIe map address 0 to cpu's 0x40000000
> +				  */
> +				 <0x0 0x00000000 0x0 0x40000000 0x0 0x40000000>;
> +
> +			pcie: pcie@28400000 {
> +				compatible = "toshiba,visconti-pcie";
> +				reg = <0x0 0x28400000 0x0 0x00400000>,
> +				      <0x0 0x30000000 0x0 0x10000000>,
> +				      <0x0 0x28050000 0x0 0x00010000>,
> +				      <0x0 0x24200000 0x0 0x00002000>,
> +				      <0x0 0x24162000 0x0 0x00001000>;
> +				reg-names = "dbi", "config", "ulreg", "smu", "mpu";
> +				device_type = "pci";
> +				bus-range = <0x00 0xff>;
> +				num-lanes = <2>;
> +				num-viewport = <8>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				#interrupt-cells = <1>;
> +				ranges = <0x81000000 0 0x00000000 0 0x00000000 0 0x00010000
> +					  0x82000000 0 0x10000000 0 0x10000000 0 0x20000000>;
> +				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "msi", "intr";
> +				interrupt-map-mask = <0 0 0 7>;
> +				interrupt-map =
> +					<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
> +					 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> +				max-link-speed = <2>;
> +				clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
> +				clock-names = "ref", "core", "aux";
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> index cdeac6177143c..2a724ab587f78 100644
> --- a/drivers/pci/controller/dwc/pcie-visconti.c
> +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> @@ -310,6 +310,8 @@ static int visconti_pcie_probe(struct platform_device *pdev)
>
>  	platform_set_drvdata(pdev, pcie);
>
> +	pci->use_parent_dt_ranges = true;
> +

This change belong to PATCH 2. It still works with old driver after add
pci-bus in dts, just a warning will print.

Frank

>  	return visconti_add_pcie_port(pcie, pdev);
>  }
>
> --
> 2.49.0
>
>

