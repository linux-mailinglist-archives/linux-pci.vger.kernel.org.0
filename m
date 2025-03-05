Return-Path: <linux-pci+bounces-22984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD3A50478
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE10C18888CA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1F567D;
	Wed,  5 Mar 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6UwZhDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CD194A75;
	Wed,  5 Mar 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191648; cv=fail; b=nhccbaV2be151RIq+lnYjldZoW1w6RQnJyCt/eLAaWVuDzyVRs/fiyQ7mL+vfFLczm3VDa4LgdrKbK1U5ONOznFKCVmDvCSEjZNn3k689vc6nKWZeo7tNneylSlG4ki/EdoNO55HvO+5G+KftFHLODzQeVO8vROEMCgUXly+zgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191648; c=relaxed/simple;
	bh=38KyCeAlIC8VnfbmXyix/iigDhhwq0FMO8uc1i1rbOM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=euYelC0rOsdtfrUl+JU50ClTOmLBRQuVKZDGQtG8J4yT4kdih0Ki2jtuHXyn/5k266s6SG9/NGGI4zY+nKd4wW7Iq6KHM9W5ROzTcGaIparaQXzpd5YDKhDvJhIkdlzEWTBLQ00j7ohPY0i7gkPjfPT55NKF7gaKx5BeH8UimSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6UwZhDV; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXeylBdqN/nxIpRxZ0GC87fWDYb1eNrrH2JBmpk4vi61vJOD9PFGyiACjRF9P0ePBx3k/R1ekJKNk5GfLLVUA5HplPT8O1upphz1ZTKxAfaivgVQ54UZ/nmAtv4MyXjVNF3jEGq3OWdkBtjR6E8ktABEl4k7vXFEoG+3qrX8laU7I1KWGrllXNQ9fGfwdZA8X6d8sINedmbo0SZhphTWYDe5Hkm8iD9cdShpxofYwhKmWOkQuzp2CjZOPryVSM3n9ys/RAtK0fpDMjsqVGQxneQKK4u8dV/MLQIxvrXqsp6t+LsraMEXt4gQZ3ImZyBU2nqyMqX2r1wdgYbiu3x4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idpULqTqTPOJ0Ivo8OkR10LF7mhs6CNdw/ipnfiQflc=;
 b=mkfT3caagGSfI3y7rO+DmPtetLDR9/CtNfldXGpdFUZ+BaD1h0yoQADDCCCT4CC0lXvmmV7Jd/yAH/AQCiXZ6YjLPS7q4/nPYCY7dpEvYL8sP8kxNDz2ZtHDnI54DUPOSBZHg585i93+dLAFlOG5jHzdKCDCirqgPgjW5besH6ytuU7GsiEyBRbQb3A1Rpp8LeRIw9tSpBX6b8ioPyDIF3qdF9BoU6dw//tiVAlNrAaPWuhHpsj2P0MTxa2im9odd3LLRLol8YrRHSqXToPKx27eJSVBYvUM0rEJ5Fum+b3Rsb9q5v1W06WmxGy5d6AcD+8cERp8uHHBtgKfZ1LrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idpULqTqTPOJ0Ivo8OkR10LF7mhs6CNdw/ipnfiQflc=;
 b=a6UwZhDV4vFsjx08yji0wnp9/glEF09y8MA5ckjwhXo0cCLGYAVAu1wOAKHc1wbWD+JHHMPuMOekWrGW1Jnr+mZIF2WEv6FUQzRGhdyuxUPuojunvu9G7TlRAWFumiqQ8wsmIGO7M18ZGTo5DtNGI+MSgJCq+1eqtPSOuwczERMbQpQ9nDvC7pgO8/82pAeRseaW19ZqEZr8XO2zc/Q1Dade5+usJC7qBBQPROtYiqUik41xqsq63gwi4rJdlnK0BAhdGLV8nioLE7FrU3nDRb52tNHQUEdDmIhkZYryj/D9Ksm0CMFt2ppN7n0pqCDJSyM8S0N3Gek2dzwnMjUOIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DUZPR04MB10039.eurprd04.prod.outlook.com (2603:10a6:10:4d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:20:42 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:20:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RFC NOT TESTED 0/2] PCI: dra7xx: Try to clean up
 dra7xx_pcie_cpu_addr_fixup()
Date: Wed, 05 Mar 2025 11:20:21 -0500
Message-Id: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZ5yGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNT3ZSiRN1E87TURMNkA2PTpBQloMqCotS0zAqwKdFKAY4hzh4KQW7
 OCn7+IQohrsEhri5KsbW1AI1gyXdrAAAA
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741191638; l=788;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=38KyCeAlIC8VnfbmXyix/iigDhhwq0FMO8uc1i1rbOM=;
 b=s1UkfJWGa0vGu1NcDAh3mwIMZKJJr6lqtZRT27TiY14eLnh1/B7c/YmX3e0SuCQlu7ah69zlE
 /6qQnQGpbCuDlVJ4ogv8rI0iCT4dsL98JBJPaHMFYxUVFqVTF+8zmdG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DUZPR04MB10039:EE_
X-MS-Office365-Filtering-Correlation-Id: e0237a48-4543-4404-7a38-08dd5c01acd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFRzTldsZjBVK1AvakgzSnA1M0NvOE5EM2xLVmdxUmFXaW5UczdOcG1mS2ND?=
 =?utf-8?B?UTRJTUllTXVEbEYyMTZDSEV3VmErZmRaK3RKUG1FYkJpNzhqVXQ2RjErTTJh?=
 =?utf-8?B?NTY1aXBHcFMvRXJYZXJ0MnFta2xwbzZYUEFsNmRLaTVhSzdQdnFzRUphSVlO?=
 =?utf-8?B?NWNsNmZGeEtiSkdEdHhTdnRNN0ZReHo1UmFoblMvYjNKRkVvdEZNazRza2ZR?=
 =?utf-8?B?Z3hnTnZJbEZwUFRjYkFWZFlBVlZ4OENWWWFyejFQR21tbGFzN0k1MFFiL0Nw?=
 =?utf-8?B?cEduRldtL3UvekhGODFOOXVScnhPQjNDWHZVaE1xUW1xSmJnck9DS1hRSlBJ?=
 =?utf-8?B?cnVSQkM0dGpOMkZjNzdiZVdlVy85S21BbkFjWkJ5R3FSTTJEejl2ampCekRK?=
 =?utf-8?B?Y2htaGNLVXNUSDhWRkxGOFBpU1dkQkRmWVd1bDlxZlN3aFFDQmtNWjc4SWxG?=
 =?utf-8?B?QU1FVFB2UGt5U0JNYlk5NEMrajZjRkczK2p4ejBsQ1IzM1dnNTFuVkw0K3Zm?=
 =?utf-8?B?Unl5NjhZcVM1YWJRSlJPWnBMc2hWYmc3Y25DSWFWNVNLcDBLNEU2N2R6K1M5?=
 =?utf-8?B?MEFKckF2UmxkMDBva0pJcEYvMWVxVHo4SFVETUNxT0pJUEFKVVNkQng5Sjla?=
 =?utf-8?B?aDNmY1h2VURNM3dQNERrMmJ0RVRwRjAxV3BpNWs4cmNrbmdxNGU1dDJROFRX?=
 =?utf-8?B?WldwQjJxNXBRdElzd0g4SVVxOFN4K283REN2WkYwN2Q4RXlXSTB5aG94R2ZY?=
 =?utf-8?B?NUFTM2YwYk50U0RtSjhrTk5rRVREbmN1NExKUDhJZ1ZQd1lQeGhlUzFUMGht?=
 =?utf-8?B?QjJ4aGtWaldEdk1LMnVLVU11VmgzOXpyblNtRTNkVm9oSDdKRkcyMTFzYUNB?=
 =?utf-8?B?MTg3TDBKM3ZBZDBMNEhrbUIzUGtMK0NSZ0ZMTWZ5WTZUN1N6N3RiOXYrb0h3?=
 =?utf-8?B?c3BUdEczTUFUNHhacGg4bGNpNU1hSmdrOElPb2F3S0czOEVxRmxhZHV2WWN2?=
 =?utf-8?B?bDVFVk1QbXhHUDJ0WDZ2eG83OWZzamtIL3VnNTRtenVobkd4RnQrM3l6WG1U?=
 =?utf-8?B?R1dubENFVmZCRlJXZ1ltWUhzR3VlS3VBelUySUNveHFmaUpicXNiMWRWRmM2?=
 =?utf-8?B?UE5wTU5oZUVnc1N4cHNFYVR3VG44VVFiM3I4T0hzdDVSRUQ0UWJjRjZIYU1z?=
 =?utf-8?B?Y2xnTVZ0cUdjTFVJY2UzYlZ6TU4yVHVHTVlmVHV2bDNLODkwanBEbCsxTVd1?=
 =?utf-8?B?eEY0VWhialJYUWRuaVpVU2djUjc4VkNHZG43YVQ0TVA4MStEQk9MYUF5QnVs?=
 =?utf-8?B?b0RGenFzekd5QUdNUGJ4cXAxQTg1NGhPSElhOWtXdml4UnVIY3NkcXpXNFRG?=
 =?utf-8?B?cFRUSHMxekl5TWZlQW5nSXVGZDVDMEMrNG9hdkRDSmhrV29lL01Vb1lONXhi?=
 =?utf-8?B?bDVQZlhRZ0xaZ21PRHlEM1o1L0wvZ0QrcDFaVGxJZS9JRXNBSXZwRjZQQTZk?=
 =?utf-8?B?eGtlaFR0emRKZ0VhWU1rZWI3Vnd5STU0djQ0Y2NHSkJ2UDExeDNjbmVsaUhV?=
 =?utf-8?B?eWcxZ0ZIaVB2VTBWT0VGNkpvazBDRVFGVjVQNlFhR1BsQ3lmclVEZVdMMEVn?=
 =?utf-8?B?d041eEtOWHVWSlMyc3JCdFlURUlJNjVOZDByUktEQ2FuY01nR3NObEhBalhu?=
 =?utf-8?B?OTRIajlnZnFMM0FxejRQWWRmZ29FYjg3NGFHcG1BQkpvencyUVRTckc4Q2FS?=
 =?utf-8?B?aTVJUzJ2VWpJUWJpVlJIMlJBRk8wVDhXa09QdEFZZDI1bnNEakNqSXZTMEJj?=
 =?utf-8?B?NlB1NHU3eGVpNWtqWkxnU0dXYnkxMkt1ajJOVDM1TnlJaTlNSUVxWCtzOEtN?=
 =?utf-8?B?d2pjc21Cb1gyTnhOb1AzZlBWTWIzQnE4OG85VWxHREVjak83d3pSalIxV08v?=
 =?utf-8?B?bGordy9DSTY0aFg2cXF3U3F2WlpaY3hsRWgxUWJRNngyTXR4b0FkNVdrNkk5?=
 =?utf-8?B?US9sYlNiTEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21mNFdmNldPRExLbzROL0ZVR0g4a3RIckZuZmxBS0NFclJlQTIyVFhENEtM?=
 =?utf-8?B?bnNGalFUcmVJYnVKT1JXKzl4VUk5VURJOTZueUZ3QWFVMTg4YU9jeTFCcXRM?=
 =?utf-8?B?dmE3Z0lHaWEvYkV5U2tiaDF0YTNDK1VES2ZFclllYmt4WDUxTmVzMExCZVRo?=
 =?utf-8?B?RFd5cHJGVGlEZ3dzdnFuekE3L2hIem81SjdyMzUzcHkyWnJvanNCaVhXMCtq?=
 =?utf-8?B?aGZUN1NTTzFNN2R5dDNtQkt0KzFPZmxTYU1rNnBLWlo4SmZ2VG1VOVpxWDc4?=
 =?utf-8?B?OWRDTlF5Z0cxYS9XWGtxZXoxRUs3RTNsSHc1bTlqTzB0NnZGQkd6ZWNrWXI5?=
 =?utf-8?B?YXhpNnZHZGVteVNZa2tZWjZiS3Q3M2x2YVUvNSs1TkllazdUZlZjbk5rVjY5?=
 =?utf-8?B?akVwR2NJdkp5S2QrVnRXeS94QWVSWE1jSDk5a01uWlpIRXpjODFKdFNGT25h?=
 =?utf-8?B?VnBha1JrdGZWczVEWXlwTGpUSHJ1SE1JeVJYMVhoanl0eEZSSmhsYzJXV3BB?=
 =?utf-8?B?KzFJTUN5eC9ZKzkrYUNCRk9yNmM4K0VMZnZjWDVtTGg2ZExRY3A4Y2M1cG1G?=
 =?utf-8?B?VXZrbWgwK0tkeXFUVXNvVnVKeFlWaTN5ZHRwS2xDZlQxd2pLcUVTemxET0pG?=
 =?utf-8?B?QytSZUcySXowTThoY3BNNDUzNXRGek9YaGdlbHo3b29ZaDdjak9iRWdTcGlm?=
 =?utf-8?B?K1NRcFFYSDVNakhFS0dyR3BHekRodXlYaUsvaTFON2sxYktjS3ZIdGl3aE5h?=
 =?utf-8?B?aWJwU29WcnpDeTllTk9oMVlGLzk1K08wM0tGZmxaSXpjQ092SGUwRFNzSXlv?=
 =?utf-8?B?MDZiTjVvdTZhWXd4cnIzVmVHaTNIclVKbDIvckUyRTVxN1hVSDg1NUtsZG05?=
 =?utf-8?B?dnlQWDlZUGIxU2JiOFB4UldZYlhWQldaSjhVaGQ5Mys0TlpJNlEwMkdKNWZ2?=
 =?utf-8?B?dTdWTVY0cllPRnVzNDhyZE5jWUwrRFJuRitjUkxsTTE1d2QreDI5MGVGYmor?=
 =?utf-8?B?d1JpUnBlSjdmU1hYOU1JTlRQWk16WVpiZWxVV1BLbDYya09TRk1oRmo0Sm0x?=
 =?utf-8?B?ZEpZalFuWmcrNVlzRzhiK2Y2Q1AxRHc1ejVjM0FtdnNiZTEybnJGUWhDQ2NW?=
 =?utf-8?B?enFLQ1BRclpwakJwR3hBS0EvRlBTeE82aVlkQkFKZDc3TkwzMlVheEl0UE0r?=
 =?utf-8?B?bVFxZS9nRklQRTFxbjBNZUZwSk0vSzBNdlQxRWdSeGVkS2FqaE5hOFFOQzRJ?=
 =?utf-8?B?UVhqZzlLKytWQXR3WnRFVlozMDVhSXgycG1KNGNkRWRqN3hid2hKRkFFdlJF?=
 =?utf-8?B?MWJZU2VFa3gxUVlCbWpMaHhmTWNoZnJWRDUrUFkzejJFRUZwVjVvcTdYbEpR?=
 =?utf-8?B?ZGxUWWVuWW93UE9hbFlKR2RHQk5kUEJiTWc5M2VySnZmSEtOWUlxN2dTVGwy?=
 =?utf-8?B?ZnpKRnh0UHNtenRpT2dHK25JeE91V213YjZKejRpdVc2NlNXZUpjSUc1dDRn?=
 =?utf-8?B?M25Ec1RDUEdWTmxWRU5RU3MvMHdDc09RT1g2bG5GcFhWVEthNU5XY2hSZGVK?=
 =?utf-8?B?blpyL3U4bmE4OXJkZkFLcnBZOGR6ZndobU1sMlRzdGNuQitaUVM0OEJRVzRP?=
 =?utf-8?B?dUN1aUtOaVFMNlY4MlozQllHT3BHZFBXTS93YzE0bmczcGhyWHZ6VkZJWEJx?=
 =?utf-8?B?Rmk1T2c2RDVKUG1iek8wRnFESlJXNkJmT3B4MURLL05kYVNPd2w5YVk3ZVhJ?=
 =?utf-8?B?R0gwTXR0d0VtY25SVEtHTXhMSWY0ekZ5WnRBSlFYMGl0MUFjK0JXVmU4WGdH?=
 =?utf-8?B?dWRiRXZydkVjang1QnozSk9qSk5ESkRNUVZPQXR2aVFjV2E0bkhYaXk2ZGFZ?=
 =?utf-8?B?SngxcU5BRXFlSGVsQkF3R1FETkYzaVo4NEhobnBJWkVUUGl0OUVQNElFd0tj?=
 =?utf-8?B?RlB1akZ1eUt2OWNWWUxNY1JUaHRSMXVjOFRqM2ZPOEdkVFQyczZCL2hmNWxm?=
 =?utf-8?B?WWkwNEVhb0tkOFNONy81MEhDQnByeFkyUWN5QUQrMmhxb2hTRDRMRFBpVTJR?=
 =?utf-8?B?TXVVWWtCbEczbDV1TFBkL2dnMUJrSThkN214SjR4bk0vK09idHlBTm1xc0Zh?=
 =?utf-8?Q?/ZTH5lCVzDHK/XodRkKYR9qDX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0237a48-4543-4404-7a38-08dd5c01acd6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:20:42.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwpL/z63BqSQCaHy1HCAx53DDZg/4au1GNVFuBvDBjNXap75+G0ZjfqvI5cwdWsV9dOXCViWZrW3+6YcWvf2KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10039

This patches basic on
https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/

I have not hardware to test.

Look for driver owner, who help test this and start move forward to remove
cpu_addr_fixup() work.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      ARM: dts: ti: dra7: Correct ranges for PCIe and parent bus nodes
      PCI: dra7xx: Use use_parent_dt_ranges and clean up dra7xx_pcie_cpu_addr_fixup()

 arch/arm/boot/dts/ti/omap/dra7.dtsi     | 18 +++++++++---------
 drivers/pci/controller/dwc/pci-dra7xx.c |  8 +-------
 2 files changed, 10 insertions(+), 16 deletions(-)
---
base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
change-id: 20250305-dra-a7fea1c035bd

Best regards,
---
Frank Li <Frank.Li@nxp.com>


