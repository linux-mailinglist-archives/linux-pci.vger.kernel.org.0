Return-Path: <linux-pci+bounces-17958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE339E9D75
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410D516131A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17941F0E26;
	Mon,  9 Dec 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RjNqUNt5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC001E9B3E;
	Mon,  9 Dec 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766541; cv=fail; b=GVcFh3MeLLRXV0DniOyJEJ2FW7x08ndftQCggvtFgXD+jXz6Mw9rzV6teS98u/NRaJWuZyS7juAB8wb6FKMK1cS4GRH9XVqKkglNJvxlhxmnobPx4FC/qBlNolwbjYcFFshbxFZMuFGCFmYBCKfRzLfvOTEfsVYF33B98d/K6DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766541; c=relaxed/simple;
	bh=ecsUMST1rqgl5nkhoe/wR/oiBwEmdq7KRl7zuhcNim8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iYRN895TtKqI78JRI9WjjUlYdXzNlTOuk/AySREVHQsauwevN4/CftZmqUnbjuDkyq7WmEY2n31gluxPlRp9rgSScirJ/NmY9VbUB93UjDmoxGiG2gOYxSDqzYpaMY27HSEwBy4AwyR7ZOIvj4dCe8uBsm0UNaCISGSJRK76OBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RjNqUNt5; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgWgeAjOv3Ot2XgiWyR63xYErmKvgwZHXYM9cu5uBcS3wLvrG+fGDQouoyKeiFQyQmlcZU5PjDrCg3yrddQSDIZGkRblwcCU2YoSSXGKX4nLjy8tI5FyNbxZVQmc4YBv8KSTzx2/FeWBO80BESv79i8CTlsZbVM65OM2Y+E0bxNrM4XDcq1MMrMrKlZM3GQNjtM3z8hNTcoNJu6t7nj5x2KLWHH2Rhu7Js6klUtEuOtygJqwGIQGc5LkpIGB2tMGk0NZDZCCjfFsm/B3xEh9vr9Dv7C2A4hYg01UtRKAuUeQXXBSHLcTyngQ/JZ2QQniSoCixp5MTmpFt7KRYVtbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86wpQXYBbhA0fUx6zsRkAJcExYphOAfZcp3Q386zG4s=;
 b=hUC89UKWnH6w/WOgerKUOR5mYTXFtaFe/OBmOYnAzOv/jiZS3bN2eDxbS6+HO+PT0s2nrUYSGaQ1qSDEnbLxhoTsoTxf9G8EqYTWdjxlGFBJ9v923Z4xnaTWQn95GxSf5zaUNdLZ8k+pa5DFZqIMikaMsS/OQiohmg8lCqOPLXtaUkVPilBZZYlIRtxRyBhSOQt28eSIuASDOcdh958eiEhVUdgFKdPbmZ6+gkktNlGQco4FdGtV9WXzrRwFGr9qH5okmlkhsrp5I7LMK7MWpdHH9PM/H+QVLRb3vmE8kNNO7hoyCQRA32qvXZCPnEpj9UA7TQTjUW21Xpl8UzCmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86wpQXYBbhA0fUx6zsRkAJcExYphOAfZcp3Q386zG4s=;
 b=RjNqUNt5Q0MrGRgCVaM2H6LWBKSitrHjBMiuF9yHp7v1Wy8G9eChb1Hot2lnB+0Vbv/SUBv18YhYu+mOl8FCgNdf2JiJmzyLDWA0u2FNeNwMkZ5TT7y+iOvcdsDbYvMRX3YAtQxZHMubpN4sMRa/4NkKp5thmD1n/8Z7KFHvHXDAtjVRD5AS4cSNu5Mlp+MEOkSHbmpdt/SvREb1c8WyccUQZl1D5883wkEtsMR2ttZxKN2ghkm3Jh9Mhq2D7wNZ+p8LMaf86aqR8hKTGqHWMFwyUONdchZsM5UPKdVawIa1JOfp8H5sgIEtILHey42NF2sxAqbeoEuxDrVADkqGnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:48:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:48:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:18 -0500
Subject: [PATCH v11 5/7] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-ep-msi-v11-5-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
In-Reply-To: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=7892;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ecsUMST1rqgl5nkhoe/wR/oiBwEmdq7KRl7zuhcNim8=;
 b=uxujQ6ohRzq4QBUCI2MSdKbUWs+86awXR45sexW93IlWsrlBWguXOEuw2DYxoC2Uyt4kjkNb9
 dBYfD9YWLsLBpQqfN22jF0QmwCoqpNsAzTJ1vr1jLAB5yDOjJ1LMqkL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf06acc-f235-4701-cf32-08dd1879c0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBvNzVzQk1ZeEovR2s4alovQnVRWTQvTTlibjZtWW04M2pvNVpMREF4QzBL?=
 =?utf-8?B?RldidGtiTGJUbGVWeHpUeWNpbDBGaTQ4aVJxMG1zY2FGMzk4b3MvUklZbE52?=
 =?utf-8?B?WWhtMWNHRUhULys4bGVvUUMrZHNLVTIxNyt5UkE2bDA5dzk5cU02OG5YeGZj?=
 =?utf-8?B?NTdnc2Q0R1RlRHRQSjRWOU9qdXdRMDltK0E2UWU4QlA3ZEFDRVhuWUJGQjlo?=
 =?utf-8?B?b1JxTjFFdVlsTzFOU1A5ZlplSUhncm1WeDQvZGFWZkgyeWtVRUhqZ3hhVzlI?=
 =?utf-8?B?RkkzM3c2RThEMlNhNFlRVFhxN0RoUnhMcHFtQjF2eUpvemJuRmptR0FZRWdn?=
 =?utf-8?B?K3VVaWxsQ3ZZUXFRbXFYUEh0bkp2dUVZZTRJbjg5YTB5aEFJZEVGckNQNytF?=
 =?utf-8?B?Wml6eVlxYkoybCtISXkyYzhOT2ZlZTA2UU5TTU15d25KTTEvb3VWcFJnU3ZZ?=
 =?utf-8?B?bVVsS2FKVGFMeVp6YklYUEVJc1FEV1VrVnVwL1Z6eFFEbzZLUEZBUE9TQnl0?=
 =?utf-8?B?UDdlaEpWd0l4T2ZpeVpMMjhPRkEwTkFpVjU4Vlk4NFhUVGxTRVpLcW9lNFBs?=
 =?utf-8?B?V204aEpYQTdvcjVPa1VNUmRYcy92c0xObWlHTFRsUGR6UlY4d2RObzUyQk9N?=
 =?utf-8?B?cGtMV2ZSWks1NXRqRVNEQVJmcG5OVE5vWEdjOUwxUzFxQytWODh1alFOYjY5?=
 =?utf-8?B?bVBnM0NHNFdkYjBHSmpueXVUK0VpYWFLVTVoSWV2RFd1d3REVXVlQWFGWU9L?=
 =?utf-8?B?OVNrU3BFL2o3NVNPbmx5cDJYaERNdFNwZWRJbW9Td240V2FRNUJvT0dXWTdq?=
 =?utf-8?B?VW10QWlSdWxLVmlCVTB5REhEQkl5QmNTWFFyMWJTWGg2Q2lGS3YxdTgxSk5x?=
 =?utf-8?B?MEt1d1ZrY2g2Zmw5Z3huMnBxWUI2UEpTcythM2JSazVEWjAyazFVVUY5Z2RZ?=
 =?utf-8?B?MnduMWk2SGF6MnVwaVJVbVVFT2grRmRYZ0dmNXErS1FrOXZ2VEl2eHBzSlhF?=
 =?utf-8?B?ZlhDTVJFSC9lVDM4eW13YWhoa1hLRHEwMk9YS3g0eFdkTkJ2ZEhoLzJSeStN?=
 =?utf-8?B?RWxYdk9RU3FpN1lZd0RDSHdlc1luR0puUkwxYTFTOGUvcksvemZqUWk4SGt2?=
 =?utf-8?B?MGE0UzVXK3ZDYUxCaVhtWEtpeS9CaFdXYUY5a0t4WGF5QnBFVHNQMVNOUGFu?=
 =?utf-8?B?QW1kVnM1bjF5ZEpMcWlVZERQM2YzSGJJMXZqN1owSFRpcjRoWFNSR0FRMGp1?=
 =?utf-8?B?aXNKRWRZT2hiN1NlT0NJQUI4RVFCaDJpNlY4OC9aOWI2SUhxck9hRE1zWDVX?=
 =?utf-8?B?NS80ajZ2ZVcwYlV5d245bG1tWXljYkFEYVNLaDlzWTc1MGNsZ2ZzKzZuWmpl?=
 =?utf-8?B?cnBLWHZiTnBFUStiZFFGVkFZbmZYY2tPVjE3YkROeTVTNnQ2WUhSOVdveGVM?=
 =?utf-8?B?RWlEN2J6L1hPMXhaUGlnME5YT3gzd3ROSnZlUnlSZUVtNCtnRTljT3UvWnJz?=
 =?utf-8?B?Sk5DQzg1TXJib3U2MEhwNC9sdUxuMXMrdEcwalNuRUhEK1Zoc0FHOTBaUGYr?=
 =?utf-8?B?UXJTM0dkNitkYWRrNVFWdVNGR2NjMGI4bFVJcjgrVlF4L2U0Wk4rVkoyaklX?=
 =?utf-8?B?R1VLQ1lpVE8zYVIvUWNOcUxsT3hoYm1UQ08rbEF2QVgwUFhsNDIxL1FWY3ZM?=
 =?utf-8?B?NDFwdVBzOTE4YVVjSmxZRkV6cEJVVVRDcmZ1VXFLc2E3emxNNThmZVdmQWRT?=
 =?utf-8?B?NU5XNzEray9jcCtEb3pIQ1BWSjB6czREQlY3OUlDMUpYSUZrcWFTRUNSREFS?=
 =?utf-8?B?N21TZXBJMVh4cHRUQ3NqSUNGZjlBVHJtelJlaE9wODVsM3NGMXBIK1U1empW?=
 =?utf-8?B?TmQvZ2xhclF1MXpFemtBQkJlS3dzYTlzRWJna1cxemE3M1g5ODc3aVhlbHJs?=
 =?utf-8?Q?KxU3eeearec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzZDTWNEZzZuQnQ1Z0dSK29ENTYwWTFSRUZyNkZLS3IwdXBSSy9xaTVvTWRS?=
 =?utf-8?B?SzFDL2pSV3kwWDBHZzFGbXVSb3lPWUUwYUU0Z05SKzIxWlBNcVpJbDVVckRi?=
 =?utf-8?B?TG9PSWJ5SlQzaDRsUncrb3Awa05iUmxJL3pHeVRUVXRDeXFUR0x2cnFwNG11?=
 =?utf-8?B?WmZzWUN2MXZyRDBwOUlUaWNPajR1eW5sa3U4VEdRVm1McnNxb0Ixelp2RmFv?=
 =?utf-8?B?RU1tKzluY21mWlUxMWRwWkdjRkkzM1FlZFJ0NERPT0g4THh2Y2JWSStLdnRH?=
 =?utf-8?B?Y3YxWWF4ZlFLejJFR3BGcGthZExYVHlzTDF3QXpsay9XTnlUZ1BOZkhrSnJi?=
 =?utf-8?B?YjR4SzFZeTJmd3JZKzFjSi9iOHlmNE1OUEhmZjFBWURteXNqWUZmRTF0d250?=
 =?utf-8?B?RHZsMmpSdy9HbDRSdUdkUmZ1OGlBUDFycVVOVkxjR2VyOW9FcmNIbVMvbVJ3?=
 =?utf-8?B?UjNuanYrTCtMTUdYcUtZdDhINmlLVk5wRmtRaGVTU2M0bUxvZGJwUk5VR29L?=
 =?utf-8?B?UkNlelVMdDBodmlLblJWaHRMcmh5MGxBck1PMENPZFBBZFdTZktoSHduZThi?=
 =?utf-8?B?YmNrNDdXbWw1bG9qNDhXWnhuQlJ2ZmxNdy94L0NGVW1CRTRsNDhQQWxwOEZR?=
 =?utf-8?B?M2cxRm1oendXRzFFMzNib0V0UW1KU0dnM2dld1JLdWNOUnRPZzNrZU5aV0M5?=
 =?utf-8?B?YlIvSTRwZmpnMUlHTGJ1RXZudzVMNlAxc3BpNm1POE03Q2RsQTJPRE9MMjNU?=
 =?utf-8?B?ZUVrQjJNbERrU1E1cGcwTW1oWFRKMVh5OU1pb21KWTNTdnJ6OEJSOFhXOS9V?=
 =?utf-8?B?SzcxQ2RUbTdTU1hFRjd6Y1ZKaWprSlh0Wm1YcjB6VWVFUVZUb2VzRklJeHpV?=
 =?utf-8?B?ZktGcnZQR2RFVzk4cHRIS296QWtlcHZmZnpYdE96dzlpUTBtZlVmU3hWYVJR?=
 =?utf-8?B?bHR5UEdxQW9xMzBzZUlQMERSVXM4dGxzZGZYSkoyY2orWURKakNYU2Q5NEt4?=
 =?utf-8?B?SlNXc09EUXJLdEN4R3VOU29nMXJ4TE1YQzYwSk5NeGZ6RW9SUC9MRDRSNFBi?=
 =?utf-8?B?eGVmQ2ZzZUF6K1o5M1BsSG1MZFMrZDJ2aFRFVHB6WENSb3ZnR2VVdjBUNEJZ?=
 =?utf-8?B?aUxYRHdrd20rcUdZSVlYdm5HS2dDSnRKSXo2RmY0aDlQd01OMWs0N1UxVmlu?=
 =?utf-8?B?bUowOExxU09wbUZGYkRvcTRaU0ZScDVKemNSb01rdDZYZHk2Sy9hb2Zqb1ND?=
 =?utf-8?B?OGliMjJQT2xQRDdyK3o3ckNHVTVjNThhS0doUjZIUHQ0SlNQUmhhZVhjTld4?=
 =?utf-8?B?Y0VuK3M3R3FCdDdxaENJek9TcCtpWmdsaUxadHJFSEEwRnZhK2gwMWRyK0VQ?=
 =?utf-8?B?aFBxTWF5RkZFMG96bHJLZS9qNE9yM1BOTCtZcGpLaUo0VUpjK29hVHhhV1hZ?=
 =?utf-8?B?N3Azd09WV0JSa0ZIR2x6c2tGeTh0N2VLbk8xR0R6YVBUMVIrSUVXbStSVTkw?=
 =?utf-8?B?bERQcDdaRVhPemhNVStrYmxUcGxXRDZwUlpvT0plVWdKQ1ZOOWQvRzR4VktR?=
 =?utf-8?B?QzNzWm9VSml2R3BkUlhXSmVqSk5kM0czeUdXL1R6ZXVPYVUrQXg2OENDb0Vz?=
 =?utf-8?B?SDlvZ3N0UlBCRVpCLzZpNkQxaWYwVkdRRk8zZWwvUzVDaEhEa21TckpDbmw3?=
 =?utf-8?B?OHByMkpzNXdaRm1tenNzbTNuWnAwM1doSjZoUVhsYzZnYm1nN0hoZW5WYUww?=
 =?utf-8?B?UW00VURpSkcxZG5Da0JqRnJXcUhnQVVPYjdtK25pb3hRUGhQMnZJbTdOUFJ6?=
 =?utf-8?B?OVJpWU5DV3B2OFdCcHRiNEdvSlQvRTJFZVY1T09wZDd2a3M5SWEyTjl3U1Va?=
 =?utf-8?B?eDdQZFFqVVl0Q3lDQjhveFhzNXFxS1NXRjlMQWtRNmxUU1lUUmpBNHdwdWtY?=
 =?utf-8?B?ODVaaE1oOThBdjV2dlBDbXhxcUlGWERTK1BlV2o1Ump6dUhkNFNBRnVRWTBO?=
 =?utf-8?B?ZExlYVNsNTEwLzE4TkJqVE1zNThRUk1BZzQrTnFCRlhWcHRhRE1jVmpkVFRW?=
 =?utf-8?B?VzF1Sk9HK0tiZ0kwd0xtSUFKN1piVXdZKzlNMzR6dlJqckVsTUxvRDZhM3Ey?=
 =?utf-8?Q?A2F4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf06acc-f235-4701-cf32-08dd1879c0ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:48:56.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIyRwQeWlVF1/wk3/UoD11qonQ0g27U0CETDxq33nHybu6t68EZMEEX4q9rcLr/YGnxiaKK4TjC9I8U32A/Hyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

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
Change from v9 to v11
- none

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


