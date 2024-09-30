Return-Path: <linux-pci+bounces-13661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FAF98AC4F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DD81F242A7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B23199248;
	Mon, 30 Sep 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggRUIkzW"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8E199E8D;
	Mon, 30 Sep 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721930; cv=fail; b=J3wW8tqoIYZ/g/uqFikeat2KonWBCHdsDoSVrPht3R+oRRQv4+2279DWRvdXuK5tGmawsSvIQgK24jL4ltO8/SDOJaA8v8soR+Cf0UXP/7dJe9DYprqecE9VLagQaeEVAS1Q4aiL3LEFo56GMOCJdGeEEOqUaGtruqoNg4I/gmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721930; c=relaxed/simple;
	bh=hI15LqP3AkTCXzkB5QbZfHvwe/ApYrNlpYXxxSVfXtM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IQt+e8pNdYmsl+ndprRdZm9CSNMqOwrCvw8kdcP1i+R4pDQ/GB2Vh4OEQqJYtIpkVRKbrVw5BzwXK1mjWjOhrPjNx2VAKhHiPFKXV6pbEAlq8QNR+xB3qEqb+T9/StpGOhTFQAV2e0IgXBLRD2f3gK2MwN6vpdJvd6WAyMdyQO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ggRUIkzW; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGxBA9/MAo6sA3G9b3TtXHXXrCSF7VXXh28fnBqPkwsGf7iKzz2zSaGL+QoUMw6l/mvtvsGDGTiJmZlw1dR0jM1WRAdvU7iuz2Bi3rtot+bLxmAuRBEmJcVjOfkKkWYHlIX3Oiuv9fWZXDOi42TYd5dSTrOW7xGSY0hsEBENBPr7Hvqq2vyx/SBapCvobfCzjbTj6vZ/9Az/6mr/NXDEDyOdlx2y5cBUbbhF5Qm5s4LCmUrKeSFgFZmg82GRwcsI+lWysHcJLKIJqckvUjb93tvIqo+yh2vN6VmWHuCu83y9B3bei7yugWexCxHpaZ5hnZDhNXFPaXmpp6JUi0g7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9waaWlkQ/3u3rRCj848z/MRqONKDyAao24e0lG78Okw=;
 b=uaEBOs5y+D8YhdmQAVCFI+5iPaZUWRbsTuaiQAVi5wI6ZeRa++HOsNAzScGLhK5GGNy/BBBzE3xcm2ngdVQu+2p6eNPz+GAeHZ39LrnSiQLtrb4wKqyIDk42szEBfQxX3DpCvYNBE/7mMtAYt0IKjfNEuJIbFX8RCzFGZf3RvWdoZPbIUUNFPcSCjEDQSZRadV5ew7sUbvmXzG/65NonDYSXho56BCVxWD64qZGmMPqaDZYtRehYKjnwgUWqQUDS5/EI+idfTdBcfH224P2xP025nMf/4GYSHU4rWQvGIMfXy3cFav+WiUhWDQFFbtvHRP2TF/K0bTfPcs8rqlzE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9waaWlkQ/3u3rRCj848z/MRqONKDyAao24e0lG78Okw=;
 b=ggRUIkzWlhtOYyFcVAyuaH5C70mtRy0IZXy7ThyAH49O52fujf4wxL+gDg8TR7PmU0TQQfYU/FJIWyvxxkb3XJhHo7sUguI7v+98KfcBnJWceTNofdDdnYcyi6PIpwE05niUScnZWdFleQNnyygskkgqNmH79HqpOqIdD1LXarBabhXX1lK6RBWLOJiDM4F+sNwyVGexEm9iY4k10P7O2cuE1MXBx/tnQeUFTaU4cBuPSGJHIxt/SBEPJyoejcpjGL0Ceh2n20gmPmIpEs/6Y2Bf2cZtALbKbavFGzEaULgQrKUMWOD5Lz63kXhVuNfQP8kl2jkbZRX45Z+0s+RIPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 18:45:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 18:45:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 30 Sep 2024 14:44:54 -0400
Subject: [PATCH v3 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
In-Reply-To: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727721910; l=6460;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hI15LqP3AkTCXzkB5QbZfHvwe/ApYrNlpYXxxSVfXtM=;
 b=KYcComt04ELSSMbGyOZXCNf75nWPSNyzGdPwWCwZ3q8rWYUoCuxwJ0qBr4+QO+6EoIgJnBFZL
 KfAWCbHVX+/Bgl3O2KbRP3yATCqGqSvXvLEv8qjfEC14ZtvKUhcQVT0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: 33adeebd-4dc2-4e41-e1d1-08dce1800b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTJ2andNVkRrNGdlSkovZ0lIV0FMMW1mTFNYcjF0c205dHJvYWlPV3NHK0Zr?=
 =?utf-8?B?eExjczVHRW9Hem5GaWFmZDBnQzJ6cUFlbkcvMlRTcFVRLzFvT3VMYjVub1RG?=
 =?utf-8?B?WjVJZ01kS2xWOHFlUGZrMlZnSmJEWDBTdWJhLzZ0bDNLanNhd3RPREtEOENT?=
 =?utf-8?B?eG0yRWpMbWdSRURacWgvdXVvVHRCbTAxSkpFTUxxSndXNXVwS0ZmT2VveFVy?=
 =?utf-8?B?OGVaLzNBNEZMbStnb3E0YnZuaVZ5VkU3UHlYdHFnT0grZkNwSU95QWxjeTA0?=
 =?utf-8?B?NWdjU3UyVWZwcjNIWUVzdEtmaVBsNWR6Tjk3NVZPYkYwY21qTEZrcnc3UkZs?=
 =?utf-8?B?SWNoK0FzUGkwYkVXaGxNWkdHMWlzaEtzSUgrdEhPcDErRmF6NXdOWlBNeVJn?=
 =?utf-8?B?TDRSaFhBZ0NGTUlCTzYwdnVrQ1BySXBqQmUwUDZicTRkc1dORFBWbnkxcnI2?=
 =?utf-8?B?WXBmb0UyRTgrWDY2ajBNRXJGeVRkRHVLa1o5NjNib0FyMVhrckRQRnhtdUFq?=
 =?utf-8?B?d2FQQUZ4TUJzK2pDOUpiODBQdElOQlJSY1l2OWNqK0tTR3BnZjJvZ2dXWWRi?=
 =?utf-8?B?emU3NUVlMXJTZUNYTkh6ZzEzK0JuU201aDlaelpsREliNWRCWTlTaTdNNnI5?=
 =?utf-8?B?clpXM2JEczZQb2ZxWS83Z1o3Mi8yaWFmSldhbDN1RHA3YXY4c0ZaNHA5V3FU?=
 =?utf-8?B?dTRtU3U5VGh6eWhHQk44dTJkbnUxNytjTkRocGdmeE04OWdlOEYxRVpEbWNv?=
 =?utf-8?B?Zng2dVpVUkVlQ3Z4T2wyT0pjRmxFWTR2eWM5bEx0M0RrVFJkQ09LOTU1Z2FX?=
 =?utf-8?B?a1NvN0gxZWR3dzVCR3FFUGNxSmdtdkhGZHBFN0hzM0tZeDBnelJxN0xSSnhy?=
 =?utf-8?B?WGZodjc2WjlkNmVaazBBc1FaU0ZxM3p3MVUyZTIwSmtWRVNEYWhIOHZnT2E0?=
 =?utf-8?B?TDB0cEJuSVcySjdoRm1palNGSjZRYlZnYVk2UWQ5MzFhYkxWZ25VRGMwT24z?=
 =?utf-8?B?Z2NYWXc1RVhUR3lTdEwrOGUxaytSMC9XQ3NpU3YvNkwweGFtdlM4SzZ0WEc4?=
 =?utf-8?B?MlEvYnB3c2xTSVB0Mjc4N3A0WDhoUlUxeHljK2dGakwyTXN4Y1ZMQ2R6RTBO?=
 =?utf-8?B?K1RMeGgyczJTQTdhTEQrdjQ2LzJMd1VNbHZZdjNVRWtKUWxRREttOHhlK3RK?=
 =?utf-8?B?dzlUOEc0em5ZTklnSlBKWlVocTFaT2lpaTVHc2toSGdwQWFRS3NTZ3ZiS2pT?=
 =?utf-8?B?bU1HMnhkRDJ1V2thRnYyMDZhcTlXNjFPY25ZUVBhWWZyS1J3UXRPdTFHck53?=
 =?utf-8?B?bjNvSEJiblkzNEtudUJQaXpFWXQzYSs4dkpNZTFyMm50S1Nob3UxaEVFcjcw?=
 =?utf-8?B?ZkNsU0E2Uk1reEZZeSthalJ3bllTNVZ4N2I3Tkw2MHdzaEdoZnIvdko5Q0Q2?=
 =?utf-8?B?ZDZxcnptQ1hrQmQ1VVgrNTdyZTA1Rjc3RXN3T2tpaGxlUlh0dUdWT25CTGp2?=
 =?utf-8?B?djFOMk1xOG9MSy9pY0pyZjg0QzBzUk1hVW53Mk80OUN4OGQraHdMWkhNUGdG?=
 =?utf-8?B?emg1SGg4NHdIYjFGZWY0eWNmYlYzYW9KSW5lZDBleDZsSUEvZDRDRzFpOCtq?=
 =?utf-8?B?RFhlQm92bG5WU2tCRlgvYWwyeklWRTY5eWdscUJGV0t1d2FlTnBXMzhtRkov?=
 =?utf-8?B?Y0tnaDNNQTFudFYzTDAxTDk0a0xvdXREZFl3T3d4dGFoRk05aTFjcEdyeWpI?=
 =?utf-8?B?ZFdzUlRsQjN0SGFPMStuK3lSeWdDYldDUmdQRldTaFNvbXduOWxwd0lZYlJB?=
 =?utf-8?B?VkJkdjZYc2s1YS9OemtvTmVmUUlVMkw1Wk1XWWE4b25JMU1jQU1ObS9tZ3pn?=
 =?utf-8?B?c2orTTZkVkxpYWJhSkdBZ29Fb1dYTTNRRGo0Snh2eWw4L2duQWtPTHU3RTdC?=
 =?utf-8?Q?p66zLg3+jHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC9McTZTWDY5QlozNlJUZzY0b1lrZnlXUHloai9zZVJqY0U2S2tKVWZsUWYz?=
 =?utf-8?B?N0tJU0EwRXJtSStLK0FsV2FadEM5NzlYNUFFdFh1ZGc4dW9QcklWYzZoWS9M?=
 =?utf-8?B?L25IQXZ4WUZGc0UxcE03dUtKdis2RDIvNlIvVDJZdUVucEQvK25qTkZSQnFK?=
 =?utf-8?B?b0pEWURXMFRNNUpIKzBjZHdKay9xKzU0eVNMcExocVA3T1VzVE1jNnlWaFRv?=
 =?utf-8?B?c0M3Z2N0S2dBcG1vZjNsSkt3RmFOdUdjR21Wa3oxeTVucC8vczBjSGV3L3B0?=
 =?utf-8?B?WnNQNi8rNXR3TkJWbWdFclpNcFJrdTNUc0dWWDFXbEYxMlBGTnlwclBJMDI4?=
 =?utf-8?B?Wmg2WnFxbmc0bDgvQUk4Y1Q5L25wZGsyN25hMkxRaE1ud2RjSWwwRk53d0pu?=
 =?utf-8?B?OWNqWE1RY3FxbkR2TjIrRngzaUVCMVBvcWpsaGZEK3BLQkhCQ0ZRUXVyOFpS?=
 =?utf-8?B?MmRmWnVTUzZTS0FtQklrdmthZ1NPUi85eXh4Mk0yMkpMa2ZkMlpJNjliM3pt?=
 =?utf-8?B?WHVVVWpadE9aT3BBMEZxYWkydW5rNW1GQnhKNTMwbWZMdlFiZzN1Tk5wQTBJ?=
 =?utf-8?B?aGQ5OVBFL3RsSTBXM3k5TEQ0MmNiRDVBOFdnek9jcHc2WTI5S1Y1V01YMFlm?=
 =?utf-8?B?bVJvOXJyc0Y3ZGhXTDZjN3djMkIzaFZQV1o1UnlGdFNDaTRWZDBZQWFTVVZp?=
 =?utf-8?B?YnEyR1ovcFhjbTllS3BOSjBnTDd1NzMzUTIyWUVSUXJEdFg3WFNHTk1IQVM4?=
 =?utf-8?B?TUZOMkRteDNyK1JROFpwdlBrNUVZTDduZVZWWXo1N2F2dUg3NnMyZGEyKzZu?=
 =?utf-8?B?a1lURGY0eElvcWdmUmgvdkZKTi9ra3V4MHBZODdwMlozdFBEODZaNXZjbGhG?=
 =?utf-8?B?TUdDNVNRZFkxOWxodHhiRStjU1I0U2J5VjJvQXh6VXlhV0Q2Vk43K2ZDNlRU?=
 =?utf-8?B?enNlMEE5UDZBSzhhS1ExNnE3L3FYNGVHSmsvL1ByNWFNdExhbGZkeDRvekJ1?=
 =?utf-8?B?cnhCYzB3TnJoUkM1eFE4NlB1eTdoUW9nNE1aVmNham9YQjMyeXVtNktWZmN0?=
 =?utf-8?B?cjlJNnY5SmJNaUFwbWV3RUN1dlNJZlY1eE9SeVZzSkVTRDZKbWU5Q1l6ZUNz?=
 =?utf-8?B?Z21GaEh0OHBJUHkvYUxsNFVtbjZOME9pd0cvZEFuK1J1aU1CV3BqUEdhV0ZD?=
 =?utf-8?B?NjZSaXZqSC96YmRGbTkzcEZZWXc2a3o3dUxFRUF2SUtnOFUwQTJEMnFacHIy?=
 =?utf-8?B?SS9HTlFlL0haMWw5aGdsRVdpcWlBT2tyOTlRODJocWQrdlpxMmx3cWozNEFy?=
 =?utf-8?B?L3ZvZk1GTWs4cGZjczJNSTRrcno1WFIvVmh2SGlLV0lGVkJFdWtQTktPYmN2?=
 =?utf-8?B?MXlDcXVkR3lLQis5S1lYZDc1TmRzaVlld3ZaVDVNbS9PRm9sNHFZekUxZXEr?=
 =?utf-8?B?aklxY0JEZkpGRE4zdmZVSnNORGlHTEx4RG9NMks2WkV6eERuOXdrRXJEYWxI?=
 =?utf-8?B?b3U5dnA0aFdIVUFPd2grbGs5ZUNFNDgvY3JKWnQydFBrbGhlWUpFRzQ1MDJn?=
 =?utf-8?B?aTZQbzRuT05hcW1vMG1iUmlybCtkQ2JzZlcyZmV0dFkvYlNoOXM2Mjdvc3JT?=
 =?utf-8?B?WkJKZzlBSHQ5RHJRUmhHbFJqZ3NjNkFibFU0WmlvMFo2QzNRNUh6MkJzTU04?=
 =?utf-8?B?L1pXNnJYZTc1Uk5lc1lxOXRDY3BOelh5WkduL0pIVTZMZk1QYUd6MGNzaGk1?=
 =?utf-8?B?c3cwN1dsWU9PY2xRWlJkSGNLQm81TFd1Z2dNOEpTekdTWlJOZDgrY29GeWZv?=
 =?utf-8?B?eU5aSlBsQ2RDaDM3RWNqT05lUU01UDJFWCt0R1hTZFg3OXU1QVF5MGlnRElq?=
 =?utf-8?B?UTU3UEoraEYyYURXUWtJQ1QwcmIzQUptdnRvcFU2Z0lRL0Z5TE0zdXVwMHNy?=
 =?utf-8?B?RW1xTWFxMlVqRWRvK0twOFNGcVBzaW9yaVFLZTRCNHl0L1oxSklzNUhNN3ZH?=
 =?utf-8?B?SE5sRy9mSHZmbEx4bktLZURPMCt6eTE1ZWNMNHNIZXFmcU82MnNOM1lFeWhl?=
 =?utf-8?B?T2xXblQzSnBsTys3ZDhReUxLWmxYbERMNWdQbktPNXVybHpyT3AyU3E1RGtL?=
 =?utf-8?Q?QOyE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33adeebd-4dc2-4e41-e1d1-08dce1800b28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 18:45:24.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSdeKrzWxAYIywvxsABH3KK8fHVSM/bgbf3GEl7GGEZ1bdTsrD9K6E7DDGriMzfVx7vly0HsmMM/Ui+GTTibgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884

parent_bus_addr in struct of_range can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff0_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
		 <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term internal address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..823ff42c2e2c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
+					resource_size_t *i_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	if (!pci->using_dtbus_info) {
+		*i_addr = pci_addr;
+		return 0;
+	}
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.parent_bus_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		if (pci->using_dtbus_info) {
+			index = of_property_match_string(np, "reg-names", "config");
+			if (index < 0)
+				return -EINVAL;
+			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+		}
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
+		return -ENODEV;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
+			return -EINVAL;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c189781524fb8..e22d32b5a5f19 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -464,6 +464,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


