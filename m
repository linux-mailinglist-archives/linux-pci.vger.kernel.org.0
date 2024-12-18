Return-Path: <linux-pci+bounces-18737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91909F7090
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248E816BFD1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD761FF5FB;
	Wed, 18 Dec 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gn2r9Z1o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F831FF1DC;
	Wed, 18 Dec 2024 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563388; cv=fail; b=DE35Y2wY6OJfwsm9MGqIucAQx6C/ULPm22npV+bmTQRf+/Jyaz7wwtPPvviKEBt1BDJU6TVYHQRjLbTYWq47cF1YvDI6TpixnhNAhDV288i/dxiagtXRwApmkJB6kjqyeqO9S1e0Lvv95t9tZVVPEKrNHPnLzRniyjR3R4sVjFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563388; c=relaxed/simple;
	bh=XbEugLgmvGxvNIdnJ6oC4l02fBY7NXWQcWS+O1eGi8g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UZnBAjc/KK3CgkdLPcuEnjeqVv4LKAnVdZx9lOnb3DdJ/Ud9XlfAOpt41EAyCuetBlupR/81wxC09q7DBj/opNpxgze9RQZLd7JfewKnrgJxLMn1Bm946ACFvA6eDLh4Ksppot4W7za2aZv99RSmXlp+psFDellLcGg+JSQX71I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gn2r9Z1o; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEEfZP6YRt292ER38JoR5047gIIPdRqJ5n1c4EBk3Sk45m7r1HvuuCclqxBVVFERefV6gCsnAIz3QCGDilyjfUiFmuqPkCwqNlCkuuv0P8nsrin2onUYwd+bVNjRIxWnJtwaBBXzlOaR3MC5ChGospo149R1GQ98f0Iv6Wjk3pwxjmJ2kuMhlBhQUNASSzWq5euyO44AGjwWN+O1Dm2ghRSFtkCPyatH4hFtCMMQttlGXHj0b6HYx+nlIfj1m7K8UoYFfHJqNy6rIloiBozmhnsI5qzHgTJdve0QaYlscJuL5rmJMUlIbswNJ0QvMRQuD3Jsh/gIVFRkXU3E5wAJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mzp2Bo8HWoNWJlsXVMdq+48BQWLo31kyjde7J1Sd90=;
 b=l5nLquMZ/L1Sr2XFNClL5TT63TFHP9Ogjci/HEDxSk1ZFojw7b9ucgwdNJ/VBXVpB3gvq7ayVH7NBhmicE5MwxTHauHg0oPMxmG+4BvO8dt6pvoHSF3hyTRD+mYvK8P5zdrNOYNoxom7uMc58oQN5QvuNoTugvPDIT+xy+VzjZSEijbL1EkKH7HCbQwBE59q6nX3vAQuR1q/Wn/STz9DQbncItx1RT6f/i0ZLTEyHog/qoA+mipezYv8FLXybOVYzjNDpLqqw30J0lBVJho2ADMwYdo9UwbWjuocjgTIQ+CxQyNMSOhOtHQtP3Z9VJmYDxyNs+rwOxaffC2pDgaKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mzp2Bo8HWoNWJlsXVMdq+48BQWLo31kyjde7J1Sd90=;
 b=Gn2r9Z1oOrSYoSNtnMQ0F1kjE5JEHjPWcDaMp7Sw+WsMRLsZrWcmcCG+RM3vzgER4SLZelVqos0FZT4UD3k0aISdYKOFJ3a66cODnQ0j1UG5TMK2AMP7+wnjdoU16zUvBcFkO4ZhxRfLz7V6l3+eNZqF7g/aPMVhZM226OLOJlMbPFR+IKpRSsH8jZTtlhOEy1tKIb1rx6CCQjKwMeUbPGpAvluNlsBvuUBE8838fLv1s4WZlc19h46o+bhRGVKsI+ZFyVlZCoHMfMurE0mj9R7WeaHtWFimPO4N7XwYCMVK3ezoqFGha1QQbxwN45owweKBlTeezwy+SeVAA2oEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:44 -0500
Subject: [PATCH v13 9/9] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-9-646e2192dc24@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563339; l=1851;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XbEugLgmvGxvNIdnJ6oC4l02fBY7NXWQcWS+O1eGi8g=;
 b=81AcSMGeFlxfUHquQMk7Fg7MeC1faazKrYD5j8kpN0H3MYmxZsXa70fmnVx9A7kvHwfdm4OsW
 TMLtqgFVYcBB1vz7Y03kl4pAs7ZepKqfVBPN9zKKSsUyzcBBPR+sAua
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
X-MS-Office365-Filtering-Correlation-Id: d4ada4fa-9cb3-4f1a-b49a-08dd1fb90ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzBGQXBraWc1ZWRyam5vbXlHamFCWnF5ZW5kQURpbzdscTB0QVJVemlhek5o?=
 =?utf-8?B?UkJjcTFIUTMwOHpPTkhPVFlleFBCdnZ4MGQ2YVJNNU1BZS9RVHdzczRiRE9D?=
 =?utf-8?B?eXJid2pTUUt5V1E3Qk90WkJobFlzbk1ZUjRHRmFndmNWZjBaaCtONDVGV2Qz?=
 =?utf-8?B?THdOcGZ0N0xJaFh0ZURYRFFFL3NuMVFrZFRrZXIwdGtUSE8wVS82NUs2bVlz?=
 =?utf-8?B?a1lnaTJRNDQyeXh5VDYxOGlTT3FRMlZsN25wd2RtaHl6U1ErZDZZVHdwVm4r?=
 =?utf-8?B?eU1aYVFFN3JoNjNCZ1JMMmpidjZFQU5XLyt5SGJtdTRWbTdDbGh0bE1YclYr?=
 =?utf-8?B?TVlYVEhUd3pLM014amFhMTVsR01IRVFwMm5HRUFFWGluMFUydHlVVHBwdWdj?=
 =?utf-8?B?YnlDMzFaSGU5QVBIN1huZ0orbHd2eUdhNVUzb01CbEFtV05VL2Y2aDZoSVFZ?=
 =?utf-8?B?L3JudDhaOWVyZzZpbjJZRVVlQWtOZFQ2SkVud29WZHV4OC90NmU3d1V1UlZU?=
 =?utf-8?B?K2ZhKzlIKzQ5d0hvTCtqcU5EZG1qenRDa0ZtYnRiUFAycmNIOWRkekY4a1lW?=
 =?utf-8?B?R2JtSTBKK2ZtVFJSTktUeUY5TUtBcHRXa0t1NW5uM3FtdEl0TG1FMHF1cGQ4?=
 =?utf-8?B?M2hUakYyY1BWaWM4TklDNHlWMUk5MU4xblhiaWRoQTN5bFVWR1JEc2s2TFUr?=
 =?utf-8?B?NkFQQzhBSzY4L0gzZzNhTmk5eFhtUk82ZlFabXpuODYrb2hPSWZ6YUN1Sjd0?=
 =?utf-8?B?UytISnJBNEZmM0dHc2RuUWpzQ3AwaDMrMHYxekduZmFRbFZHc0p5MGlUWFZk?=
 =?utf-8?B?TkpQTndYUDM2MXBybm1IWThmd1liTG81M0NTSjlBNDVBSnBmanhNMEZzYkc3?=
 =?utf-8?B?a2s4TlhZWk0wYnBBZWdZWGxwSkhmRm9LTW5tZjhoZm5WUmE0ZzVxR01zSHRi?=
 =?utf-8?B?YWZBallhYXRTMi9LYVA0UDk0NHJoSllDb1pNQXJTQjZ4dlBlVU9tSHpJVzQ4?=
 =?utf-8?B?NWRZbW9LOG40eFAzcElFNGtRNUplTm1jQnV5cURvVjZTeE9CWnpRc1h6OXVJ?=
 =?utf-8?B?TFc3cjZDMjBvTzRzRHg2YW5lZVZnUzFaeldFUVJPdHRnQmFvN1J0SVB6Q3Jh?=
 =?utf-8?B?clJNa2kreVduQmxnUXRYa090NC9NRktmTUVPRUdLQnFRRjNSRkZ0VEhOUzFr?=
 =?utf-8?B?QTMzYUFjYUl3dXVTQkVpMVQ5V1pabkd0VldtQ1BjT3V4MG9uT1duQmpLQ0dL?=
 =?utf-8?B?TTdBVHc2QWMzQWdpWWhTYUdUR09SejVRYXBob1E4cG1uM2VFdVIrT3RqMFFw?=
 =?utf-8?B?T3pDaDcrSGdvVW9OdHJ5U1pXajBkZmRHVnl0QUVGaTU3cVNEL3pZOE1BMSt1?=
 =?utf-8?B?ZnlqZnhJUWVRMkFFZTdlSktqN0ZLV1phSThlWEtuR0JubkVMVExoY1JBamZt?=
 =?utf-8?B?ZE90UzhmVnpCczY5RjJBYmV4VHQ3aXdDTEJGZ1pkeFd0S3FvNEl1TkVqRlVM?=
 =?utf-8?B?K1pka3YzNndhc2l2WFlHZllZd0dNaXVQOVZrbHltU0R5WHZYNkNHZkphcmNJ?=
 =?utf-8?B?bWh3aE5YNUJEdjVvKzRUVE1XcGhMWmdCUWxxWVVLeG9BQVJ2NjFFdnU4MC9F?=
 =?utf-8?B?NEN2Y2t0d0JwSE1kaW9GN3NkUE85dGx1emgwWTkwekxqd1BseElWZGV0Sklz?=
 =?utf-8?B?M3NoZG1iQTJtVWlOb1Nyd1hhWHc0VWg3c2M4bldEVFhIRTB2YnpHTDI3ZmdW?=
 =?utf-8?B?MFd1ZTNOT3JqV1NObUtxMVhwNVN0dEFZWlh0L1pTYjVKRWR0Z2NGQ2tvUEdH?=
 =?utf-8?B?NEtYcFE0NDJsMFl1YWhzRmM4S2Y0VnFJV2x4UENrOWFlVk1adjIxNm9Geis1?=
 =?utf-8?B?L1pZcHdDVUs4UTZPM0d4WFhwd1ZyY2l3SW10TndxSGJ2QUlFN1ZtUDU2YUdv?=
 =?utf-8?B?akNFa2FseFQ5bmROYytWRktrYVhENTBZTmdRMnZUZzlRUHhxN1lDcnNIb2hP?=
 =?utf-8?B?N0dYQVdna3pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1EzbDhsV282R04wRlNTMFFNU0RsM0FFTVRsMmRkZjBXYjdNU2YrZ3NjbU9L?=
 =?utf-8?B?M0RyTy9ROWl1eVhXS0ZPeDJCK0NmSWd2NitDdzB6bUQrYkRpaUNaRVowV2Yz?=
 =?utf-8?B?OENmK3B1VnQ5eUNHV1B4MnB2S0FqTkE4RTZjYjh0R20vV2VLdHJVZjRnMGs1?=
 =?utf-8?B?Wm15UWRYOEtGVWJHVFJiWjRST2RES3FRY2ZmeUE1VGdHNmtUUUNwaS9jQVlH?=
 =?utf-8?B?WjQ4N29BamY0dWEveWNQMlJ2aUV3ZEErRHkraEpEbVhPczdBb1didkhJUHRn?=
 =?utf-8?B?YXNPclZYT2ZscFY3cTQrR08zWExVak0vclJXSUk5Ri9HT0pCK25UckduZVJv?=
 =?utf-8?B?RzVtY3UyT2xEUWttc2JpeS9NSldQbzZaWWUvY1VpV1cwVlJUZUhOZWpNdEpY?=
 =?utf-8?B?anlXcXZTRGF5bjlvTmRZMW9JMHN3Z2s4OHA3MmtISDJlRERLTEJpRFB2eWhq?=
 =?utf-8?B?dDhkYnY1eEI1cjB6bTNJYjIvbVBETlJVcVMwZ3JFam1xKzBDU2VkaEpxMWN5?=
 =?utf-8?B?NXJaSGNNWXNwMVNYbEJDWHFWZCtONjlxU0N0WVczTENaYktHeXovVnVXYVpG?=
 =?utf-8?B?alJFdENZL1VMQ1dGb1B2MUFZVUx0Zkh0dTRyTHE4aWlLa3oxMndsbmgrZEdn?=
 =?utf-8?B?dkVGVEMrdGFtYmJPVjk3N3pXeXlMd1RPN2U2Qnd4dXF3ZzJnRGhKNXNPbHZt?=
 =?utf-8?B?VWFKQU1EdG5hZTVzTVY5RVVCcHEzWWpSS2UzVkpTcmhsa0tQL243a2dLM3BV?=
 =?utf-8?B?Ym01RWhtTGJPZW1ZcEpTVGJ4c3JKeG81bEQxUmFWd2VFdVFHT2t2QVNCM2lv?=
 =?utf-8?B?b3JnWnBKcTBYYUE3dW9MR3J4R3JYYWxqNS96UzdFWkMxZ3pxbVR6UWpkdFhS?=
 =?utf-8?B?MXFWUEhQY0R6Z2c0TzBSc2dmOWJ3djUzaUtGclBRaVVWanNHeEhNelV2c1Fp?=
 =?utf-8?B?VFhwTVdvbjVRRVQrVEpIWWlJcFE3MVZZckNYRFlMcjhhTVJOZTVtWkpTbFY5?=
 =?utf-8?B?cmZ1K0lzdzlRbzJnNlViNElBdGE5SlVZdFlCK2NIYWFrS3R1VlZhWmp6TXhX?=
 =?utf-8?B?N0hxbkFEbE9XL2VqT0JiRDVUZnExOGhJMFJYam1RcHp4dENhcjZrVmdtT2t6?=
 =?utf-8?B?SHI0cjNCcUJ6MkhZdmR4MU1nNkF4cFh4Y3liaHBPVTZsRFE0d0cySE1LSk9w?=
 =?utf-8?B?bXFkYkRWZnVsS1hVUERLaXBDTTcxQXZBN014bEh3YkxLMTU3SU50d0s3dmxn?=
 =?utf-8?B?TzErallsWUcwSnQxOHRtZkZreWc1OWs1dU11emZlNmplMlk4M2VtdW91TkJn?=
 =?utf-8?B?Zk0wd2JHSE1Tb1ZJQzh5SnRoVFg2dWk5dWs4QUNwUW85eGY0Zm5nVWVBbzhM?=
 =?utf-8?B?OVo1ZDB4V1NGR1dJT091RVp0S0tOZ1l1Vklvd1duTkRVVHQwdDlQWjRBejlC?=
 =?utf-8?B?YVdOQ3lpUFNMWWVseG0yMFhYdVZSdEJDbVFtbXVCTmtlWWFidEVYSW1BN1ZX?=
 =?utf-8?B?Nkl2WUl3UC8ydmswb045V3h6L0N0b2xzcCtsVWJJOTkxNjRmUUM4aWFJaTFh?=
 =?utf-8?B?RW9GYkFhR2FzeXhIbGQya094TXI1ZXR5RWJURy83UGtoZE1OcUx5bWxHQ0ll?=
 =?utf-8?B?RTZMTjRaMlFNTEc4LzlQc0RIemRUR01Gd2pDV3BlblFSdmlPNHRWR1NRbzA1?=
 =?utf-8?B?SFpIZDR6STdlR0M3MDZXSkVQdFh5UXAwTDBUT1o0NEpWd1FPdW1CVnN6Z0sz?=
 =?utf-8?B?VE9pOHptTlVCb2hnMFZjTHNqbUR6bVRwRGJBQlVuRkxpSjJwamZVZDViTXFP?=
 =?utf-8?B?WDdrWmNmM2w1c2ZSalZZV0xJMHdTS2o3MEhCM2g5WlVHRTVzdnFWZ3hKaXF4?=
 =?utf-8?B?TGNnMTdTRDBGQVZyZ0E3NmVKTkFyaFZITVlNeUZjTExla29NVEFwbTcraVVj?=
 =?utf-8?B?Y0dRa2RCbmwzdURLL25oQnJ1K0VNMS9YSmJlN0p2Nm1ld3c3RTdNSzN0OUhv?=
 =?utf-8?B?TE9hdUNXd1BtZGw1M1ArbmZaZUZiZjhTL2JETW1LamlCMnJHKy9uSlVhdzBu?=
 =?utf-8?B?RVA2V3hFUWYzTTB5TmxwdDVNMitraUZHd1EydGRqekxKU25sMHR3NzhzWEIr?=
 =?utf-8?Q?Zh9s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ada4fa-9cb3-4f1a-b49a-08dd1fb90ea2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:43.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJZTYQL2gyBaNYzeAj9nov/0qtEXJP8j+V9zwTdOc1zQOdmEDJAv6xcBHu/5kAwV4XwIGyqmf0UGDY2L01JSnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v13
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 7b530d838d408..fcff0224a3381 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


