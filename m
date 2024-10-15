Return-Path: <linux-pci+bounces-14596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDBE99FAF6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A17E1F2295C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575111F818F;
	Tue, 15 Oct 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q5V1lNrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8D1C9EDB;
	Tue, 15 Oct 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030102; cv=fail; b=lO5a1zql6FEa1+hHorOusLfvq6m5N9zsUZ05FwYht0sc0eKWQvh7rz7bzxJ43yzaOZTw9s8UKvWLYK9TIxK/dhTfvamnWCYytdwXYAW2W694md0CxyNYse86wnYrWjfn2P87LFxFX7oibtnZBiCxlFc1CmdSv+2KMR+foRrOpOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030102; c=relaxed/simple;
	bh=OuA7849U5QN+fJd6KNFSJXtAX3g+s+58VR7NcMSn4OE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t+4PlHTvp4DORXS7K52s9PzU6afdF9mDlvcDpIaCixDZG7LLs18YivT9hRSVjYy4cz164uiXX12GXQ4N+I7mlGeVyJht9wPew5CYWrFeUz+o5a7of1TZ8hV6psfjz3Rl9YtOib7QV0RqFiX/5MNYHMZpeTPm/jRInUNGfe9RCkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q5V1lNrS; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+agtq6LJB2DLR2oa9SdP6zwIGr7ms7jhKfLlEF6xv/sdS97jYtYyOWTAxVMV+1zymPfsPE/klzzAO6ysIp8xoxWzZrUFvGfVx6nL85j6Odu+cHEs5W7qfqH1MCO/iaoefpYmvZ6UDugQHrpufKIW5GJ3+Sh7uY/dXhfhNPbDthy+qt3lKoGCytLf8K+Tqy9EetWNP4N+Q/8+pBlXoFdqIjmVSSFhjoA//+YXIAAVwNzB6GOQXRGNLT+IODqH13AzLCT/GUbXEPYO3jpwTSA7ZE/StBkfZef750JyiuEH7vxvzM5Jv/9Q6382MJDtCq9BoqR1R1i5ssf/MFWhSOluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixq2N5yHgGG9SsucChG7MqayQqlFRic7PqHLPs/ALyU=;
 b=HM3w8Hq/n9aX4+WKJfAS9ua7y2qucXbhthlCLWPtcj0RDfBj9dcyRaxQ36zNDcW0/KH6N4gswmOl1eL3R1TcCflCl412GuewjELAWrjopK2ivDTDs9giicmQEzgmcN1d+IUK0qm4YcAPqz0xJ8pc8dKS90SWVu3BOOd/W104nKjvinnvkDlz3F5w+sO/eyKnKMS1QywgbC1qx7pXyDo9j6dtb3PBXiZ75Av7TGnIbsc2v1LhAA5IFL40T+04sEBPdpY36eP1Vt+XkRjdbdgvGcVsHpsK8GDRP7DEIDR8+NIUYhZotoazksCIfdHKiR3pKAV1EQzvxKRjohma/q+6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixq2N5yHgGG9SsucChG7MqayQqlFRic7PqHLPs/ALyU=;
 b=Q5V1lNrSX4oNbEuHHoSU04km2Hl4uMGmlnc8c7gkKrVv9IpNRBXmoy6Iu3Vk5Y+5FixBu7qFdS/gKVkpMWicmuXgH21JjkglUTgBzvaYb44qwhAknEq7R+aop5+tX5KfUtMAAv4mmeh5o+VcNXjABp6XhlXbJTRWK3c9K8U4j1hX+rkx9fjdX+3iuPuf176MRkLPx4JwJuia2J9hgENfUbDURUKOOi/zyljmH1fv0ZPp4IK9+xclr77U/3eF5/OQ15sROiGxg0ENhE6Jn2sQcHzU0QkUgVG5JnocBkjz5bCAXambwGl6p5yVzIMLfch5KOLrosiM6VXNGJk/52BQkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:08:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:08:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 18:07:18 -0400
Subject: [PATCH v3 5/6] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ep-msi-v3-5-cedc89a16c1a@nxp.com>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
In-Reply-To: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=5945;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OuA7849U5QN+fJd6KNFSJXtAX3g+s+58VR7NcMSn4OE=;
 b=JbkbUIvfNJmmZ7raOw1+A1Z4SuUrr/aGfwbaAuZ/xPbrKJdgX6iMQpL/iBlWXizVtcUl0k9OI
 0fQd4gtDHJdBBBbYWkyyODK2hc16aW8plmTNr8OFbzr2IslxI7WdapG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5d52a3-6ec6-48de-3ec8-08dced65df28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmZ2Y1UzM3ZHOUJ4Q1ptTUcxQTBHUWtlSTFtYmVEbTE3Q2xuQS9xZXpjZ0sw?=
 =?utf-8?B?bnFQV2NVWU5ZaU5md1Y1d3RQYkxhM2tjWG1SaXJuQis0Yjg2L1BIcE1rMGZZ?=
 =?utf-8?B?ckNIc3lTbk4zSzNOZnJwSFUvd2ZsZTVGU3ZZVHdCOElVNUFVTjRheEIxQVBk?=
 =?utf-8?B?UXNkRm5mcDJuN2hDUTN3NkUwUEpaM0V1c3NodFoybXRwcGF6Q2dvMkVLaERt?=
 =?utf-8?B?QjZFc2xjV0Noa2VmRG5sUHhickVFZEJycTNwUlN4YkZHM25ZT0JaRStSQ0dJ?=
 =?utf-8?B?QW5LbHJudlNqRVB2akhlVGJscFUwZnpLTXc0N0RaODVpaStyMy9IZ2llZTZI?=
 =?utf-8?B?ZFpNM2grOTI1VGtBNDZkejAwNE51bk1yU2lhbGprYkJDUVliU1dxbkVBMDdy?=
 =?utf-8?B?ZFBlMW1xY1ZXaEhUQ0RuaXhDVUkxTHF5MWtXUnhBL25mZ2t0Y1NnQXFQV3pl?=
 =?utf-8?B?NGRscVA5SGtTYXpqemY2QjRuVGthK29DY2ZhSGdaUEZMSXA3M1NiKzlSWHdr?=
 =?utf-8?B?UFFiQjB5eER3WDBOOEtmakpzeHV2WmphL2NzRWFVWHNnUDA1SVpjcjBKZkVW?=
 =?utf-8?B?YmJrKytrNjZTdEZlYmxGY25YbTBlMWhKOWZkWnhFREwvWklYYTAzM2ppQnlB?=
 =?utf-8?B?RHIzWG0rMktXYXl3V2dyeHcwOTA1M2hGQmRnY2lhTitvQjFQMEdpeGlra25B?=
 =?utf-8?B?UEZYOXdCZUZpTldjbmQxcG9kd3lOU1VGMWt2VVl3djN5L2oyVmtyVXUrdjNQ?=
 =?utf-8?B?SUtkNVhmSkU2dkErenNVeThoa0w1eWdOUjNmdFJkNVpBOC9yQWpQRjFKY25U?=
 =?utf-8?B?T2V4SzNrbHJjVW5XZnJRK245V2JOS01oUE5yV2h5VGdYazltMFpMbnVSVVF4?=
 =?utf-8?B?MXVNekdYV2E2TEUwdWVqUzh0RVphbUtKSjVVeVpZYlU5NnRTSTF4VXNQNGRk?=
 =?utf-8?B?MHlYK0QySnplallQb2tMOWFSVnBkUHY5Z2p4anBYWGNzd2MxTVNQK0ZxR0J3?=
 =?utf-8?B?aUVsNlhiak5rbHdPaUIwaTY0N0h6a0F6K3BxZ1NWQ0RzN2RSaU1DZTltdjJn?=
 =?utf-8?B?UHcyOVBITDNIT1RZRjJxRjNyMEc2dmdMenBDS2hTWjU0b25QM1NIdCswZmRv?=
 =?utf-8?B?SjljNU9QcjJVYUVlVTk0QVRLOHdOa1NuZnU0MSt0YTd0bEhuaHpWZ2FCUGJK?=
 =?utf-8?B?OVhBdEZKREJPNDFwYm5hVjNhWXlBdUJwVVRVeWF2eHlZdTRvY3lJanorYlNX?=
 =?utf-8?B?S2JUMEd6TTkvTFFzdjEwMjhXVFhUeWJ3dG9Vc2xFY0J5STVoNlczSDgzaVJD?=
 =?utf-8?B?TGR4QVpBTnFuRmNnUDJRTUlaT3diZlRaMUdpNjlwV1d1Qm5KUllMeVora2dV?=
 =?utf-8?B?SDdKdi8xakhRK2VBOWpMTUJlS3lPS0NrWTRaSTFJbE10VVdmVk9TUDIwU0pP?=
 =?utf-8?B?KzNGMG4wRUNWQjRqNDRVUWV2Nm1lV0dLWFl3b0RuZHoyMzVsN2lpQUZpQWpQ?=
 =?utf-8?B?MXNQdytXL2JTSDBHZ3FmSWFDQStSSWJWWThZT3NwQTQzVDBRNEZDL2RTTHI2?=
 =?utf-8?B?elNVUHpnbktzb3IwYzJnTS9HN3QvOFd5dmRNVTZzUGVXWVp2WjEwWEhhZ0VR?=
 =?utf-8?B?VlZaYkc4TWxsZWZwUWxIZFQ5L3AvRXlXcXNPazk5QkJxeThBUEhqNktnSk1T?=
 =?utf-8?B?U1RiQlRZUmxxMDZrKzdlNGp2RDBGdTJ5U2p5TVpCd0NSMGwwc2tid1hQdHBB?=
 =?utf-8?B?TC9BWjFTM1JpQTNYYnQ2WUFSK0hXeDZHQTlWNUxncXNzYkZMc3V2SURCdXcz?=
 =?utf-8?B?bEpTRytFcHFiVVpIVGUxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmtsZ2dHamxWRUNNY1RWSDl4NExqZHVnTjJENzN1WmdWQm9EYTRTVUhleWRj?=
 =?utf-8?B?R0xKMzNOeC9HZG4wNzQxVXphQi9rS2NyMXdrbkJ6c1FBTUVsVEtGWVNFNjVx?=
 =?utf-8?B?dGJYZll3VE9wdG04WjZPaEZ0K3pkUkJzclBocVlGWGFNbTVMWWl2amtRbWpy?=
 =?utf-8?B?ejZKK1VCT2t1aFcreFpOVDhYVkNFUDdrRk9xUjduOXIyOFVGMy9BcWl4Ym1x?=
 =?utf-8?B?R29YT3hTQS9ZaU5hM3NwRTV4UDZQRDdlTitOVFVSTGdZa3FYcnllcTdtL0JH?=
 =?utf-8?B?N2lXaUZqYTVCeFNJU0U3THpsbC9BWjVuZUdYb3R2KzZ4cW9XS0FIMloxeHh3?=
 =?utf-8?B?dnBlMzZuUWdsaThGUStPcUQxUEdBTzY2dUl3YWNCMjRuQnJaRllkZFoySkJo?=
 =?utf-8?B?UDVpOTZhK1U0SXJFdFhPNElnT1RDVTZoTDhBNjg2YjBOdWhiSm4wYzNjNGJK?=
 =?utf-8?B?Zk52RHlDSFd6ZHN4NVlRVk00TFNxbERxUzV5UVEzS0NUUXY0S2dPNzNUM1Yr?=
 =?utf-8?B?NzNFZkFPZGJ5S296UDJsNWtSMEp3VmVSSTZlcmZ0Q054ZlVScFdHbjhIdnNt?=
 =?utf-8?B?OHp0dW1uTWtveEpzL0JzeFkyVnR5YjFHNWNhZ2FUZTB0N2pTTlhxUW0ybm1M?=
 =?utf-8?B?OFpXTElOalVTNzVYbWZ0VFBFS1Y2eXFGNkdocERaUnFqNnlhZ0tVUlZrRjlW?=
 =?utf-8?B?YkdDS1dPMFNMc0JrVXJtMzY2UGpldjNYMko3WWRxajlTQVQ1RGFBdmc3UmJQ?=
 =?utf-8?B?cEtuMWRCWDU2bU9vcmwwQVgwSEZSZ3RlOXpFR1FGdEpadTZ3bW5mWlhVcXlj?=
 =?utf-8?B?V1FnRUJDRTZKdWNSRm9vaDk0Z0ZxYVg5Tk1PdFhwTmkva1c4eEVOL2dTYUg1?=
 =?utf-8?B?M1NWa1ptNjR1QWhmbUt5MnpCSU5ITzRDdGRwN3VSQkZwUm5ja2lhZGdibDZ6?=
 =?utf-8?B?ZDM3MGxqTElvSktPQUVNWEY2LzlxQWFuK0s3NU9yRE9EelQyQy9KSDNYOHBo?=
 =?utf-8?B?SzdvTUVTWGozbFJDWXMvZ1IzTXZkYkpnSDE2SGp5WjJiWU91MWZzVUxmdEIr?=
 =?utf-8?B?NUxBdFBYb1B3NVRsZEI1V0tza0VXYUM2UUxid0pmTlhqMjBIeVVGS3R4OCsw?=
 =?utf-8?B?Wk5rNjZqNmN6NG83bU5yRkF1c2RsN1JodTJTT3Z2RFdBUWtJTHlzRVU1ZktG?=
 =?utf-8?B?YTl1a1g2SzNhbzZsZnNOOUV5Y2gyeDBhY1k1Qk43MEk1UjZ2RVRkdHpjM01O?=
 =?utf-8?B?T1lmZGIycUFoUlNyZW83NEFnZmh3TW1IQitRTXRFUU1oNnZMWjZlMnJHYWxw?=
 =?utf-8?B?NzhOcXRqL0lUOUl0eEJPdXhTVlRkNStEODcwSHJ1djYvcmpMNnpoRWdxSXM5?=
 =?utf-8?B?Y25ic1JjcFZBcDNyQUdrUGxuMjVNRnFrQzVrK2hQR09hcXB5Q3V6NnN5RGJy?=
 =?utf-8?B?TisyeHltR1RTRTJwM3pWYlJCQkFjZnFjRlU1Qnl6cVhJa01Qc0Z3VVNhb0xX?=
 =?utf-8?B?eWhjbU1FUWFWN0QrckprY0kyQ0ZjWUhUTE1rbUd1OEFNcnU3QUE1UzVaYUZS?=
 =?utf-8?B?QTd0OGt6TFl2a2pzb2Irdk9HdFI5d1NiUWx0QUJETTJNM0FUaDhJd0pmNFBK?=
 =?utf-8?B?YlI3aVkrTVBVZXBkaTRHWFFUck8rTVZ4ZWtqVW9KdmIwMnl2SExBSDZpVk81?=
 =?utf-8?B?MzFjZnc4QnBYVDJGMTM1cEZ4dWIzM09qbkpDMkFERGIrWThLeWdyQTRRNWtt?=
 =?utf-8?B?Y0kvelZhM3cxSTlkTDhwTS9wRCtBYytoSzZZcEc2ek9FRE5KQVJaSFVzM2Qx?=
 =?utf-8?B?NjlJUDZYeTN6RjBCRG5GTDR0bnhNN2hhdXFncTVnZS8zKyt4RGtjV01hNGNh?=
 =?utf-8?B?RmtLc2xiUzU4alNBSG5abG5wUEI4TWlFSWxjSzZRbEI2U05yeldaMExicldm?=
 =?utf-8?B?TnhHcnpaeHlMemUyVDhtQWRUVXRNTno2TGZreERoVjE3b1NpV3dFdnZkNGlN?=
 =?utf-8?B?T1JqcUppVWVkQUxuOEZETkVId09YbVFkcmpnOEwyS3ozY1oyTEtYaDY5SU5y?=
 =?utf-8?B?Mnd5MUdIRm5oN2R4VXdLL0FVN044V0hVSTdiNzg3ZDY4Z01yL1Q1UTFOYUZr?=
 =?utf-8?Q?49xw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5d52a3-6ec6-48de-3ec8-08dced65df28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:08:17.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msbM90+ebZPYKQpHhFvXvvFiHlDHm6HDjPCZA9PSUeKkGxGbp58DvKoBto9eF7Fz2BWUmCWPUAqHYpw+JDWavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_ADDR and wait for endpoint
feedback.

Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
keep the same behavior as before.

       EP side             RC with old driver      RC with new driver
PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
Other device ID             doorbell disabled*       doorbell disabled*

* Behavior remains unchanged.

Return failure if pcitest try to test doorbell bar.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/misc/pci_endpoint_test.c | 60 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 61 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..a2b68c613c782 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -53,6 +53,7 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,7 +68,12 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
+#define FLAG_SUPPORT_DOORBELL			BIT(1)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -75,6 +81,7 @@
 #define PCI_DEVICE_ID_TI_J721S2		0xb013
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 #define PCI_DEVICE_ID_IMX8			0x0808
+#define PCI_DEVICE_ID_IMX8_DB			0x080c
 
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
@@ -108,6 +115,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -124,12 +132,14 @@ struct pci_endpoint_test {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	const char *name;
+	bool support_db;
 };
 
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	int irq_type;
+	bool support_db;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -746,6 +756,39 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (!test->support_db)
+		return false;
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+	if (bar == NO_BAR)
+		return false;
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_SUCCESS)
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -762,6 +805,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
+		if (test->support_db &&
+		    bar == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR))
+			goto ret;
 		if (bar > BAR_5)
 			goto ret;
 		if (is_am654_pci_dev(pdev) && bar == BAR_0)
@@ -793,6 +839,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
@@ -839,6 +888,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
+		test->support_db = data->support_db;
 		irq_type = data->irq_type;
 	}
 
@@ -986,6 +1036,13 @@ static const struct pci_endpoint_test_data default_data = {
 	.irq_type = IRQ_TYPE_MSI,
 };
 
+static const struct pci_endpoint_test_data default_data_db = {
+	.test_reg_bar = BAR_0,
+	.alignment = SZ_4K,
+	.irq_type = IRQ_TYPE_MSI,
+	.support_db = true,
+};
+
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
@@ -1017,6 +1074,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8_DB),
+	  .driver_data = (kernel_ulong_t)&default_data_db,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..06d9f548b510e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+#define PCITEST_DOORBELL	_IO('P', 0x11)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 

-- 
2.34.1


