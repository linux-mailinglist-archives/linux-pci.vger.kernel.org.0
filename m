Return-Path: <linux-pci+bounces-4901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF288016A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6913E282E35
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3D080611;
	Tue, 19 Mar 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fsjWrBdP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AD657D2;
	Tue, 19 Mar 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864446; cv=fail; b=mldzodwl5y8SMOWktR74s00tvXTHu9NX22S6UlZ0phWaLeW8LzDec02uBbvTe3MC0LTvf5vRBOABB/LmMNBmiUg7/ltXB/H6Y8K/q7oUuQC4R+hovo/rTN6v2IiU0OBW97g5CNbQuFEQ1LrZ/s+nCgUiN9sfezVzM+WuwGfFxBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864446; c=relaxed/simple;
	bh=JJXqx52t4SOPohvMnQLx1kp/6SCXWc6KO44Qih5BpVc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sqmsOVuwf0OPrajuLwHmVPdKB+ruO4am32tUj5vPaXqBZ+l7SujdBCLZ+Id4v94KNQC6kR4WoYnobZ+JNn0Y7ZKU25Qy+ZQHWJ+ubKNlENKeRNjLOtCTIx7GwnzGpOrt2PUEh8SPu/+pRee9IIORPcS9EIsVG+GG+Z4pyW4Kt2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fsjWrBdP; arc=fail smtp.client-ip=40.107.15.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBVyIJ4zfycHNqu4jKNxjs6I4+c9EwTzfgutl8e7U0BniYKEPNtG68WG3S6CUhAhuHov5u/8f1Oy0ZTeQ6JkJB3crQAJdCsUaX6I1nNkxxlTSyc5nCh59EGakSX/q83/w6+uWQ4QtFQRLmHVuG/JGLKPQzOz0VvleBmPGXb9tJYft/ojE6B4e2g6jMIXjE/vVIwp2i/FnLF7KdID0KBCDv5HrJBN6SbYUQjHVJeTE6nRWdO/sxYI8DKpsTMlyiKMuZcPQ5WSsmBNEYIk4Y/KJO8mKZR12eEHPbNrjGwupRo5ZmNZUTzVPdyk3rc9ueLji5svSgXuTAqWJypNQkyjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qQZVZ5gYrJyv7FJDP/9J8gx3SfXbvVi+WtgFvAg8J4=;
 b=ejaCvVPSVdHBMzIyC/i4fp++7Lu0WMa7cwc55zgZPFzItJ7TRyQDaH9MXp/+OZI2H79BofjvX4McVMLzzCihsHIlWMxa7M6gY+dCGgiyBF8LMF3ucjOX865CsJx0B16EdgsJVjYo+TKtutXIzinSragBjFjZx9X7x7GWI/AyJhHKEdJQZOnGBU0GaYxyrNnz+HD869g3ID0HXN2eYaviczbdbVkG9cSD9Wy8aYG328hBJYIu6K2FappS9SzVeJTpSzk/39MtWsP+x0vzoqie/RewMZYaECMSFg9Yx1BK8SlYQTMCZS42oeyovDrAuhfO+nlxqDxKhxmVWRLzdCm0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qQZVZ5gYrJyv7FJDP/9J8gx3SfXbvVi+WtgFvAg8J4=;
 b=fsjWrBdP7DZhfdljPulmFWAh0XPcK9b3b0vBYq49FtaTvheb5gXNLqgNmbzbl/Yihw9FlKV7fAkJW9mw41sDBf6dpto6g0Bizx9gerpw7Kx90Gpygnuo61neWrvl0/ruaL3QsX5EfYa3QUiP8DnbAu6n5N4FYg6hqJQOaV3DLLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:07:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:07:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/5] PCI: dwc: Add common pme_turn_off message by using
 outbound iATU
Date: Tue, 19 Mar 2024 12:07:10 -0400
Message-Id: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC64+WUC/2XMTQ7CIBCG4asY1mJgCqV15T2MMcgMlkV/UkyjM
 b27tBvauPwm87xfFmkMFNn58GUjTSGGvktDHw/MNbZ7Eg+YNgMBSshC8KGlexufHBGwkkR1VZU
 sfQ8j+fBeS9db2k2Ir378rOFJLtf/xiS54KjhISyidsZduvdwcn3LlsIEWYGQWUFSpSmN0OCpt
 Gqviq2CrIqkvAfrtbECLO6V2ihZZKWSIrAOFRoLNWQ1z/MPRcq7JD4BAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710864436; l=3771;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JJXqx52t4SOPohvMnQLx1kp/6SCXWc6KO44Qih5BpVc=;
 b=8uWI/GZZl7hhPi4OnAU+pdv3eQw27dcAK6DV6LvVDie/fY6agWJPQBVtK+stV4l9sCFYfqmmg
 cOyAI39v3n0A8OI8tfR8e7nxnKr2AlHvWxUxuk3BmlE0yrLlIkU8bzB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 44714148-45c1-480f-4b78-08dc482ea7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	omnXsOMUqnP9KbQ3mlLEP/oneDxM/VoGF8pqRsOBW++VZXsn4AHRsdMldq386VHz4sMohwYkdg9sjonuqIMRsuUec/4tvoRUQoDhSOENqWsT+mOicHj8xwtkKqQyvHyiEFMRi6UfdkT4wpNiy65dCM0HqSCbtbUpmesHPO/1vN6vC8ZBpBm0K6mdXQmoU8d4LzZd8ZJYI3kMRBma1ByzgzlKhwUIQ6cQINTF/DfXQ7a7oa/H8/CPCkArQI5/2aPjKrgVj7sGftjbNh7aWgvd3qvSOoD2TSoU9c9nmAryexnRMQOrlQ8Yh5Co1yRP6AW/Oja9XQw8a/1EvBLTB9Yv+Wg8LzTRMQQz/lhHBJ2lhsxGBfNne0kiMSkNUTzp5z9SawsPUYjtDMg287vUDE4t4HBLo4DRxaZ5s31u/QDZUScFLPWflodismWA3i67RvuZyn/Q8CwvTsAXkSSCMzwgqMI9UoLJPKPWsjislEr2wWZOVcK7RYN6z5tktACfC69tHDeVq0tbWS+G6ns/BCw6OwpuPWJFVgvBkg3nQybA9Lj1egy+fv1r8Z+I2OTTgVmuyrR4Y3X439xORplQuZKb1dQRWp9WbyN+GXQ3P6PrKIgwaCXDZN/KuL52LUwDZSX/DS+dBo6pC9o4f3ll5bm5XLEx5HeYkQ9elQoHKJsFHjhtdwidRUM5TOe/Q0LFMl9u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZ6bFkvUWMrTk02N3c0b0cvM0Z2NmQ3SGFDVldZZkpWbktaUjNtQUdoNlM1?=
 =?utf-8?B?d1kwRVpwTmVQSE9ZSFVGTTdORTNBMFIwRG1HeWVzbGxLSmQ5MFdzYXpkMW1O?=
 =?utf-8?B?bDJzMnpJeUZ6UWpvYTdsWEd6MTN5dmdhSm4xdWRqZnZVVDdJWThOUlJBdGp1?=
 =?utf-8?B?d3p2S2VzSS9Vd01wd1A4ZmdOZmkxMHdPcCt0c3ByTmVudGdIRDFGQkJrKytQ?=
 =?utf-8?B?cXJFcGNoVnlzVXRqT3kxeVpCYWhLaTZxQXZGRGRqT3UzcWFNNmVONzRkN1RT?=
 =?utf-8?B?UzBvVlRlYVZqaVJCU1lqclFDaUZYWlJ5MW0rMXZ2S290d08yWSs5N1l1WXlM?=
 =?utf-8?B?blg1U3g4YTJQN0dnY2V0Yk40SWZpcGNtVUh1MUxqRzlUZS8xOWN0VTlsYlp4?=
 =?utf-8?B?aThKWnFpNngyUXA4STFJd1pGNUNWbk1rREk5WXkxWSt3RzZpYVl4Umh4WHlR?=
 =?utf-8?B?eE1mWnVwanVjeWJVMXVIRFhXd20ySm1KTlJrdi9TZmRTT3p1cnh4RzEvWnV4?=
 =?utf-8?B?bDdkTC9BYmlCMGFjVW1uQzVEOXM4L1JwNUowTzUwMFFTRXFSb3hlWk1qcnBJ?=
 =?utf-8?B?aVp4V2RRWU1vQzMzejhJNzQwd01ERjdTeS94MElkYndETWpqUDVNNmRxOVZs?=
 =?utf-8?B?RDIxeTB0SDhoaUlwc0svT3YwbklmekJzdGkzWWdPRVVMYXpLQW1jQnpuMFhQ?=
 =?utf-8?B?VzNvRUdTbnA0d1ZsemRlZzhNVTBBQkhUd1hHS2NVQm00Y2NOZjUxV0ZteG9I?=
 =?utf-8?B?a3RNaUhad3FGb2Y3OFNpbVYxUU1MV2gzUnFlOS9JR1VpMDQrMXVmeDNYSi9h?=
 =?utf-8?B?cmpkeHZObFBuL1MrT21zUFFCSXhFM3dUaVUwVkM3aGlIbUd5amJNSk9XUUdC?=
 =?utf-8?B?VHdlbHRVN3VxSHRlR2NRNTdDQ1NiMEdUUGNST05ldXZ4MzNnaGp6L3dVNlBU?=
 =?utf-8?B?cXZCdHFrVEpobkxVWDhpOW5BZ204OXlTMnp2WDIxNkM4eTFuMnhEd0lHSnht?=
 =?utf-8?B?d1ExaWpHTnNtbVN6S01WNFdJc1JNS3dtOWFNMGdKMFZuVkVFblRpOUg1Ukdj?=
 =?utf-8?B?RWZCZnNQRnNJL1hqQWlqdnFJTS9Cd3k5TUYybFhmeHdEU1RrczJRMCtrazFh?=
 =?utf-8?B?NVliTGRlODBVWjFRczVRZW9GUTBsZ0hpdjhWNmg2YVZQQndHN3BTQ0huckxL?=
 =?utf-8?B?ZmlZYS9ZbHY2N1FBOFFLTFh5SHBGWVptWktsZ1diVGMwSWxaSGJkZmpEWEJ0?=
 =?utf-8?B?RmxZOFRXeVo2Tm90dDlvZGJXc1AxR3YwbVQ2UnVQOHU4ZnRzRnFDZGJaSUlE?=
 =?utf-8?B?YVZoZGk1Z0VBdGZIdDJIRUd4cFViVjZHQWt4UTkvc0VOaWZFemxEclNLdjdF?=
 =?utf-8?B?dklkc0xCcVFIc01HVUJmaXpBeVhKd0JSLzlJdytRV0VEUjBxbmZzeVpzRzVL?=
 =?utf-8?B?alRYSGV2amw5ODErSUVlbnAvTnlJUXE1aFZIQXgxbUlMSHFYdFVyeGVIOEIr?=
 =?utf-8?B?TEtlWU1IeXJEbFhFYkthUklSdUttem16UytORk1yMldYMmxpbWp4N3ZBMEZq?=
 =?utf-8?B?bnB6bGo4NWt6Z2s0dXRBcEpXMWkzckg1NjBuelRtMUsrbjZaWFA1S0FzYjFG?=
 =?utf-8?B?aStTUlJnT3lXamc0Ty8wdGJ1WjdVUzZJdW9OUmJEYWtCSXVoa0RFckNTL1dW?=
 =?utf-8?B?TkRqS1VLaWpCYmtiQW9uZ3AyK2Eyd2FvWHdlV0docWRxYWZ0RTA0TFBYTnpE?=
 =?utf-8?B?RFpSeEN5ekp2Y2NGUFNid0xtdm5XUzBMWEJVdUxwSTgybkVtS0RoK29Gc2lX?=
 =?utf-8?B?ZWlGTjlhUGJEdk1TOWxKYlBiYmg3cGxVK3k1TitjNTcwOU9MWDNZd1l2YnlQ?=
 =?utf-8?B?clZTb0o5YVBUeEZ4R2laaE1oOENkdTkyY3AxanlvQzZ0MW85MU13T2x2c1pp?=
 =?utf-8?B?QUV2ZmE1SVc4K043RnpDZmVLMkk4MlVQVHZPeHNteCtRSlFQVWlYUlZjdkdy?=
 =?utf-8?B?ZjF6RTN2bm5YclRvbW9NWXdlREZaZWY4KzNaZGVwNmNaK1FMcTBPa05sRlQy?=
 =?utf-8?B?U21NSzZzUnVRVmV1d2pKenlTd3RmZEZ4Rit6ZEh4RXlLUkc0Skh5ZHh4Z2lG?=
 =?utf-8?Q?cSwUvdSKOFMSnugCuDN9Ujtya?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44714148-45c1-480f-4b78-08dc482ea7a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:07:19.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naI46od6/sUEIGaFpu7fr5J740eAq0wmxA8yuflUW2aoLu2+yT4MWiU8vvogV7uxT17Fr7rtt5OIAsA/Yifofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

Involve an new and common mathod to send pme_turn_off() message. Previously
pme_turn_off() implement by platform related special register to trigge    
it.                                                                        
                                                                           
But Yoshihiro give good idea by using iATU to send out message. Previously 
Yoshihiro provide patches to raise INTx message by dummy write to outbound 
iATU.                                                                      
                                                                           
Use similar mathod to send out pme_turn_off message.                       
                                                                           
Previous two patches is picked from Yoshihiro' big patch serialise.        
 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
 PCI: Add INTx Mechanism Messages macros                                   
                                                                           
PCI: Add PME_TURN_OFF message macro                                        
dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
to map PCI msg.                                                            
                                                                           
PCI: dwc: Add common pme_turn_off message method                           
Using common pme_turn_off() message if platform have not define their.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Default disable allocate TLP message memory windows. If driver need use
this feature, need set use_atu_msg = true before call dw_host_init().

- Link to v4: https://lore.kernel.org/r/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com

Changes in v4:
- Remove dt-binding patch. Needn't change any dts file and binding doc.
  Reserve a region at end of first IORESOURCE_MEM window by call
  request_resource(). So PCIe stack will not use this reserve region to any
PCIe devices.
  I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
will skip it as expection.

  Fixed a issue, forget set iATU index when sent PME_turn_off.

- Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com

Changes in v3:
- fix 'MSG"
- Add pcie spec ref in head file
- using function name dw_pci_pme_turn_off()
- Using PCIE_ prefix macro
- Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com

Changes in v2:
  - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
  - Add Bjorn review tag at  Add INTx Mechanism Messages macros
  - using PME_Turn_Off match PCIe spec
  - ref to pcie spec v6.1
  - using section number.

- Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com

---
Frank Li (2):
      PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
      PCI: dwc: Add common send PME_Turn_Off message method

Yoshihiro Shimoda (3):
      PCI: Add INTx Mechanism Messages macros
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support

 drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 146 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  22 +++-
 drivers/pci/pci.h                                 |  20 +++
 5 files changed, 199 insertions(+), 64 deletions(-)
---
base-commit: e08fc59eee9991afa467d406d684d46d543299a9
change-id: 20240130-pme_msg-dd2d81ee9886

Best regards,
---
Frank Li <Frank.Li@nxp.com>


