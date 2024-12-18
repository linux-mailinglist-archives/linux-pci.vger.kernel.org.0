Return-Path: <linux-pci+bounces-18730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E49F7082
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD97C7A39BD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38B17A586;
	Wed, 18 Dec 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d9tYeYXh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859E1FD78C;
	Wed, 18 Dec 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563356; cv=fail; b=kNnELR3jD6Jtc+KLPdmM5MuIFBsHZZ+N/0MaTErraZS3/LzoV+tY/uwrWo8cGMX5ID30wzfzpHGkmCtALYUGcBvqkDDmFNPCfTuaQ9qymm2h6+Bbh3gko3fL1rZZSbq3mYzKnjhOU7yhj+au7BNFWsfe0JkFMiWD3rlBtH8BdkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563356; c=relaxed/simple;
	bh=8xX2O9aY64VFlNrJ4JMgzHNkAgqXMerbLBmBZNQGjz4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SaMn/w4PRe8URe05Xs/1kDqhwqsiEklvuQnaEih2lq+pfeuzInGkrYE81Ni0AW7WnREmJGauVZLONcwNghTJJoWT6Yr3oDE01PsphQujg1WrW6uYDKzdF2taJygFDNPyaZ3MWoO331mt848EszAYIJAjQYJS6535J1geTEs/aQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d9tYeYXh; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2odVTGpHsQGT4I57ySQgdqfrpU9ngIbQQcUOg3Gbr9/QorDlBQUEWmeXu3nausyWKWKNi0WkWghSLEBw7rWV4r61LOdR/1/amnzOqfOk2M/Pp+lLirzhDIct8ludNuUOCCaFJgumI4yeKi4fwQuLTXW+B/pMLfrUEpZ87Xlv6zv7+B3wg+4iS0XD3yIr5sJsK4KLazhOf1P2SCCVO5bOHh0mWyPRy6mIFmR1ZGzDiV93hgHwdZK1ftBvt0JoDP5Z5f/z+bTSqHv4EONy0ioqVYo2L+VXn28zznDhAL1V2PYxmPEJaD+42N4024aBzBc8swVrekmRGmSFNZ8eZT2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpwCdcZnpLhPQg1A7kmXJAjEvFPbhbqVp3GHX678bwU=;
 b=qPAM/ZpXQNEGFjxANvgBO632EEWldEWzZ9D8wSRL0LuVrzIDEKGmPi9Is407hKpqR1ORBgeBup6LfHQy0cx82/AoC4GBEkY0Pp8iNHOmtIa0bzqim16vbbe5uY1qautQ4gH2qEZoPJAVeMFYwbsZQtsKeN0/Fh+O/sG464c+jZ6R4JEn/Cx7PJMc7yAyBJYsW758j743xqcM0wrHQhIc55PPxdOAIgrRZvScgagLC1G9RNGLhZKSefjAtYSLC+JFosMNTQZaB7Bj7R9kJOjJLIiKpLmJ5VSg0ERxnorog4/ZrEdFW9c+gaZ+PFyJB5kl/SzSQYr1NKfmmvzxxxoJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpwCdcZnpLhPQg1A7kmXJAjEvFPbhbqVp3GHX678bwU=;
 b=d9tYeYXh38HYN6LSwAabCbAAh8zSjgbD/xDUIn9LVbQNxvSWHFkXUsoMBm5AxI3/2Zb8jCefJzsuBB1pAv2NoL5U4XmS0seawniikuJMIIxW0yQfZZUwGin1R2uxBFktrggP3ffcPSF6BEnf0/xNTBop4qjoXumAdY3qTC9b0aXU/gUUXcv0vlZtv+8sF/DbdL+BaIsnGgWwycNKpoRnK0hV7yfg9g82Q6IUPg+bWM1twBuiriTVA4ErVO2/Ez1I8/MsUCyFj3cRJK6gRUhg4qN+kAs3Hm3FVLuhP/Nk2UHbB1sNvtFVf3cX4X+9noZZNzXK2V/ZmX5qPrW8B4nKlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:37 -0500
Subject: [PATCH v13 2/9] PCI: EP: Add helper function
 pci_epf_msi_domain_get_msi_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-2-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=2838;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8xX2O9aY64VFlNrJ4JMgzHNkAgqXMerbLBmBZNQGjz4=;
 b=4g3MAO978FVxgvHLb5QWKbUbMkZqfKtyTdfff+gf+cXJVSTis8LFOmkaEsaV7iJbi37aX4tUu
 bwAocx0Wl/pCT8ZyKH65Y7Mshm+6cJDZgx908faRugQGZ7F6i19R7V3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c48fefa-cc85-4491-8ae2-08dd1fb8fc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkcyQkJtQldiMUltUlBYMUJVN21Sc3VBMmJQM2QyMnN5a2QyNnBVVSt2amxz?=
 =?utf-8?B?V1ZwelBCMGxGVGpReHMrSjYxeTNudjltVlNXS2l1MzIrQ2d0ZUZ3NVg3N294?=
 =?utf-8?B?elRMNmJiM0tKVjNZblRTRWh3OWVJclR2QS9xenFudVhZVVpybWpuMTZBSFFV?=
 =?utf-8?B?Rk43NnhDUmUzdEMrYkI5QVBLTnBCdVFDbFVDeTU5RXBpVytCN3RKczBrSzNJ?=
 =?utf-8?B?TG0wYWM2eWNxQVZPV2dZcSs1eUxuNWNSSC9EdERxUERUcmtKc3hrbExPaThu?=
 =?utf-8?B?SUE3ZXhnK1JtemhCd1VDTGQ0NjNZWTFFYzZQRnp2eWxjc0hGU0hCUW9PSjBB?=
 =?utf-8?B?eVlSVm5uTmh1dnZoZllSVjkySUIrbEgrZ0MzMDlCSTVKUGFvZHgxN29GM29K?=
 =?utf-8?B?ai85SjZWQXJVclhNRzVZRzdiWU1lTWJaeFRDLzJmejhLaDBTTlJxb2V3S0ZU?=
 =?utf-8?B?N24yaWw2NlBmUm8rUzJuZUs3Z3YyM0Rwcm1MWWRYMENzOThDY0J5ZzNtV081?=
 =?utf-8?B?WDg4K3k5bS9ZamJhY3pObmJUNzNyanFFY0VIaURXR0ZIRHdaTFB1aE5HYUFu?=
 =?utf-8?B?bTFzYldicmsrWUYzVFduM0ZPTGg0SGRNMW1HNnJSTkJkRUNTbDVZbnh4Wk1D?=
 =?utf-8?B?S1ZUOWZVaGhBeGNCWkxoVG5VMXBEaVIzQkVweHl1M2lITHBKOWFpaUpucmU1?=
 =?utf-8?B?VEtlK0xSaWRFSTlTU1JOL21MUy81dXRwRWtNcTVSZGRVYWtiTlA3eVd2TjBC?=
 =?utf-8?B?Q0NrVlF6T3RjeVJIWHM1S09VcHd5RW0rUjZveE5ZUjdJQ0hOdktRU3BYc2h2?=
 =?utf-8?B?MVAyVU1ZS2RKbWFYT0dPT1JwK09GS2s1OFNsT296V2NZM08wQ0JWSlh4NGha?=
 =?utf-8?B?R0RONzRSdnlHQ0FPdnFVejNWVk5rTHd6R3RaTGpHMnlXOFY4aHF6dHFmNkpO?=
 =?utf-8?B?QkNSaG9mWEJHMHNaR2VaTXRVMWxNZ21MbG9JOThMQUpmdzhhQldNaEsyaDly?=
 =?utf-8?B?aWQ2SmZwODgzUTFUbXBOcThjZ0pWTlIrSVdrTk4xb0tzd0xOb1FaV0Rld0NW?=
 =?utf-8?B?KzI3Y1RPU0tCM2V3eGxkSjhXVXRiaVdpSXVKMEZ3eEJVMHlXU2hiYlFCeUxi?=
 =?utf-8?B?Vjg5MzBFcTJZeFpmYkNBaEc1R0k2cnhia1ZxbzRWUjhLem1MNjAwOTRqV0Vv?=
 =?utf-8?B?SGtsSU9PckFsb1hCaEdXU1lVRzVocjZQTGpobUNMMC95TVkwbUQxNGtSNEJN?=
 =?utf-8?B?Y0Q0QjV0QmNtc21seU55UXpGVjVHMkN4SXoyVHVXRncvRHdoQkFQUk9aQVZU?=
 =?utf-8?B?ajY4ME9ZQWJLWmU4Z2NuN09ocVpFZDQ5UXVjZ2NSZlAwN2JncXVvNjhnSURG?=
 =?utf-8?B?Z1RrR29nMzI3MTBuMmFVTTNNNXBtcTc5TEVZYXB2T1ZreUpFUjZpYjdhZ3Fa?=
 =?utf-8?B?SVU1eEJjVXpveGovOHU3b2pmdnBWUkZzcUF4NndVRHZVNEh1WUdoWDlhWVJx?=
 =?utf-8?B?ZW1XYlRGU0E3SnVHT3NGc1Q0N0tCZDAvdkJSSktkdHpjR2s3RGRLQlpJeVFs?=
 =?utf-8?B?ZmZzVUl1MXNTTXNkdFZlV0ZOd3czU1ZjaEFTd1R6aEhpRnBlVzJDSWN3dFNQ?=
 =?utf-8?B?aGppK1c1bVRjUG1KYW5IMWJJVC9DUEEwa1Z6WEFVNEhYT1E2OHVNc0RBL2g4?=
 =?utf-8?B?d0pMU3JaSWF2MHR5T1NMbFl4b1F2N21oRDh5aVlWNHI4MU5rNGlpRHA2WDlR?=
 =?utf-8?B?a01tL1JQRFY4MjBJUi9Hb3dxQmFmNzNpRTVvREJraTFxVStpNS9FY3pWRVdY?=
 =?utf-8?B?NDI4NG1TMi9kUGFvaWM0bGhBcEtnRk9QWkxwQm1NMEd3UG01a2phR3N0WEhy?=
 =?utf-8?B?R3pNYWNPc1V2TXA1RThIbU1jbEdCZmtsQm9uQkFXbVdxQXR6U0lxVUw5WUtE?=
 =?utf-8?B?WllDUFBFYjYxclRDNllsamZ1S2hRSy94Sk4vK3NObGEyVyt0dE9JSW0wWTc3?=
 =?utf-8?B?b3ppY0s3YUx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdMdXN3N29NcE4rTENkNGpJQUgzbUhvTWx4b2xMQUh3SmZDZWwrTVFaaVdI?=
 =?utf-8?B?SVlFZFRXRVpSdCtlSWRYQzloU2tqN0RsYnYwYjFmVEIwYlNkTTVxMmI1YzZM?=
 =?utf-8?B?MEo3YitWL1g2ZklVbSszZklKOFR2akd1K2tIcVh0QUt3MEFhM3lOOGYrQ2FP?=
 =?utf-8?B?RFlMY3FwR0ppRUtEZkhUZU9nWXVFT3BTODRYVy93TUtuTDYwMStueUgrcUtm?=
 =?utf-8?B?U0lIVlhZV1MzOHpmcVJFRHNGWWdiMFB3WURVZ0NBZjIvQnI1aGZVa0pBS0Y2?=
 =?utf-8?B?NmJjUk03WVhDTXhtZFNPYUh3SjBJdGVvV1p3bkI4bmZNNGgwS2YvZ1p5ajRj?=
 =?utf-8?B?UUFLK0w0ZlpxYTM3Ymx0cktIMTFncENIM2xqZWZMUzkrZG16dHFFSzRnUDMy?=
 =?utf-8?B?TkMzVmxnQlBURzhkdVdmNjR4WDl6VVIvUmRNNUNRbjNJYnJTWjJMRlc3NFpB?=
 =?utf-8?B?NDNLSVFvYzdka0dJT0RWZ0k3RWJXeFMydlhINWVtbFlFY2xTNk5HV25yUjBN?=
 =?utf-8?B?WUgxWThuQzVJajJtRmZCRG1Cb201U0F5WUt5TG1PalEvbkJsam1Cd0d5MTE0?=
 =?utf-8?B?KzA1ODJYcGlHOFhEbUs5ODZEdERXK2lNeFJabVFlNm4vZ0hDWjNZQlhyZ1Jq?=
 =?utf-8?B?aVVwR1FESitTSXo0TnRnMVNZdWVUL3BZSE9HSys0YUp5V0cwclhRU0FpeUJP?=
 =?utf-8?B?QW05Vi9wWm9uN0RhWHVTdkN2SEtzTEk1L0ZTUjFtaFUvRGJqRzNWSHJ5cFJz?=
 =?utf-8?B?TERzYU5aL1Y4TVorbjYwNmtRdnZVNy8yRXZlclBCWWVxdTE4LzVOWVErSHlh?=
 =?utf-8?B?VVpWUmlSOFR2Y05vdlBTckI3T20xYU5BR243TXhKUWpYVjRZOVlKcDJ0K3dS?=
 =?utf-8?B?SnJ1cVRnTGM2a2JXSkJtdEszaUQvaVVXbnp1OVFtSFVUVko2cFBENkxKZkhu?=
 =?utf-8?B?OFN1bW9XMG9EeWE0ZnVoMXdlZVV4OE8vQ2NqSm5OUmV0R1E1VTNhRXhKMFpQ?=
 =?utf-8?B?ODdDNXlaRXk5TUNwQktvWStmTUw1b0ppV213MFN6VXBRdERaaTgzU1ZtdXVm?=
 =?utf-8?B?LzlTZHFpS3ZRSEdvOUF0eXMyVUpMc28wQXVvWTkvT1ZSY2diUytqSEc4T3N1?=
 =?utf-8?B?YlZaaDZHanpQcXVuVk5DMUlRWVdaT2tPYVlHR0QxNHBLRGRNQ3YyaVV4RFJM?=
 =?utf-8?B?bmxkRTBRZVZ4SkJxR045MG1pM2hMSmtOSGZPZjhQZGZxdTE1TXUyMFZlSnpr?=
 =?utf-8?B?Y3F2Vk0yck4xQUZhaUNWNGlSNzlZN3h0aE0zd1gvY3hMZ3lka29XdVE0alhr?=
 =?utf-8?B?UVlzOHBobzg3TjV0bkwrTFFTMDc5cG9zMlBMbTRJLys0bUNNeG1xR3hCZFZT?=
 =?utf-8?B?MkF6aHU0SGc0ekRFRHQrei9YdlQwcHhHZXdNbnljS1BIbW9XelJYUFJvcEQ4?=
 =?utf-8?B?L05SSzJVL3U1QlM5ZkpSSGdkcjJoSDUwZFZsYlppNGpoQ1NXZUFFTVVENzFX?=
 =?utf-8?B?MkM1UXBOQnVLQWxUb2kvMFRBRHpKcW55RVhaemdGZENOemZLNFpUZi9KQTJu?=
 =?utf-8?B?M1h5WGJ6Y29LOUx4d1ZrYUZvaEtSN0I1dnZRbEZkUVFORDY1TXd1WTZJU3cr?=
 =?utf-8?B?R0kyMmJJaUJ0d28xcVUvTFY4SjZ5WCt6RU91cG9HZEp2WDFWR05FdjkwOFRo?=
 =?utf-8?B?TmhqTG82NGZLSkRHTkxmVXpma1R2Y0ZTNk5OYkdwUTVqVnlpVkVJZUFtSGRJ?=
 =?utf-8?B?eVV3N0xWVC9iUUhlZWNnL280Wkx2cjVodEpkQkJXcnB2NW5ZZFpuaHEzNFhm?=
 =?utf-8?B?Y2dCRHp1ZE96SlQ1bnZKeitOa3dwN3FzNC9qeHRDNlRXY1pwTWJUM1lEOUdB?=
 =?utf-8?B?bFlSWjZUZ0Ftb053dE5WOFJoRHIrcmREamhUTW1NQlRZSnBEeTNVaFR4aVhn?=
 =?utf-8?B?bDNqV3lQOWQxam9iZ1hlYXF3UUhCN0pocWcvcUVRdjBHMXptSEhxM3F3V1VL?=
 =?utf-8?B?VFdwZnU0dm1ESnl2QjUxMkVVQ2tDU0tHYUlseS9hMndFQ0xrZytHNjQvZVJq?=
 =?utf-8?B?QWNDREFyZFhiQXBMT3A1bXpQR0wrSU41S0dyWC8zZTRMbVQrOGtWRkNWTkRV?=
 =?utf-8?Q?ggAT+KqETJ3uH41e0ErlcDzBG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c48fefa-cc85-4491-8ae2-08dd1fb8fc28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:12.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnED7z48Ll3DzSbNKiGr1BANMMMDCpZNePQPpfhclIw/zRGCy6JDdFNkZTh7Wy/SNdtMXzI2JrBYdGdfbd7DXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add helper function pci_epf_msi_domain_get_msi_rid() to convert EP device
id to msi domain's request ID to pave the road to support RC-to-EP doorbell
with platform MSI controller.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v12 to v13
- new patch
---
 drivers/pci/endpoint/Makefile     |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 21 +++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..7aedc1cafbd14
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct pci_epc *epc = epf->epc;
+
+	if (!rid)
+		return -EINVAL;
+
+	/*
+	 * PCI Endpoint device ID can't full reuse PCI's BDF, BUS number is
+	 * Root Complex Bus number, which is no means for EP side. Move func_no
+	 * as low 3 bits to partially match PCI's BDF.
+	 */
+	*rid = of_msi_map_id(epc->dev.parent, NULL, (epf->func_no & 0x7) | (epf->vfunc_no << 3));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_msi_domain_get_msi_rid);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..75236867426a4
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+#ifdef CONFIG_PCI_ENDPOINT
+int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid);
+#else
+static inline int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* __PCI_EP_MSI__ */

-- 
2.34.1


