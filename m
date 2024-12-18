Return-Path: <linux-pci+bounces-18731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B2C9F7084
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52E77A39AF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F71FCCEF;
	Wed, 18 Dec 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qv4q/OUu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24851FCCEE;
	Wed, 18 Dec 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563361; cv=fail; b=aJ6LE+8S5OUM1Uw8kOR7PP6cD0tF+goubSkhLHNarlRh76LpphETn50B3CyjOmU618dvtpHDVdtKmcD/Zx7oOVXSiBNlfuKDIJ8FzAf23eawBrXDiKAB5DjzOi+9pjzc2wUcymi5Q/1PK4H7l67jtpUIlO76wcFdoyRSKcQU6UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563361; c=relaxed/simple;
	bh=mH/HfWSB72ELMEfQcYQ6cyfemrKZKDjtNGbdbaIdvQY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oyzb3Mwqp6dafOHl0VSXigdPuWpMW2ucZMazBJMVXywPbWSpcMhxTwgew3t6yOTMo1B7uMkTWFnvZFU6ZmrVt7TqX4Rjg2PkgLi5N5vqv65lNLNHR0ioT0RQJWfCW/+i8G3PpsBpQnmZkQwdcjIPMTG5DFLhZz0yhF5eT3zxgv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qv4q/OUu; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m02Bt6HKJucz5NSqWFUrMq+txOZxRCnMxbjB5VTz/rNguQcqVIhJiO714/RDpSfdnbXgnYnEIaJPbbYT7e9FxSkuqBxU2qrQsiM8GfFOl4obkPRT6KzzfIqqH/aznW8C3uecvv0gHuEw6pkB3khdgEVw435j3nEt5RHV6QdbLCdy/IQntViivit1hTiWkGNTCSMz0jMNCPOSss9rd9eZ8FdQ8TazKgTeQnBa0b0GQoijerAfC0hUS7CSmTmjfC1ox+5ZImoBIKmH9ska08iMrFMo5sAWq+lkIZ0lHAnR9ktQDWvNk5TDr4VToqxdutEor01Ih6yQGOp99C3+t731xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kimtkzi0tQgW2H+hE5yDJkVcjZYWfJxLal/759/AiPY=;
 b=hguFu45yDcR1mprgdW9yzTbQERw/Y+r3k5lzxMMGoW9ivCMHcVJaXbzLVWFPwKBppWqWyfI1K/VNEuGYHhqQk8/JEqZF9Cey8zanU9aQeAqSEw6EIOALyhmjayDdCaK8TmBCqGv64COL67BvNNNv/ix1VoA8qmVhaG8vsj/cfcU2nTQnAYfUcT0ngnse60WT36GyBwxC+OhONo6NKl9nWdBqebc6iwCPWDukY3PZ7J7+DYQTAHXouzcmtMc1N+MRr8Xmhtr67kVGbo1KVitWIbGWHggT5L380HJAP4nl4g+7pvSnuQAvGBozM0C3xyzDJIOnU+8WsHNVAD0y/Ntq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kimtkzi0tQgW2H+hE5yDJkVcjZYWfJxLal/759/AiPY=;
 b=Qv4q/OUutkuW8cqI69xv+IAhgjc3Kq7qGUNvARpFlS3kiRwa1wmwmhyd++xIIJ8TEXjoHHKNDASbWoOmVZs93suNOYPKFyw6Pvya/bp/9AU1PVglx6D43EtKkWqVbt4NIIIn1UFwAWigMrxB6i9G5OzgVlxdghWGo6lQj1y0LV058fHuDx+4kOmH6JOrLQpemnkp2EsaJLUUhEgXPsaUtYmTdub16LNj8N1ZfAMHDRzW8BHf/vHGVJI9EOjWuX2/HUTuiGL+2JOv2Z9G5GmHXZLN6C5x50SmO7fFZ1eTxLP9Y2tBqUFB5fGGooI8j5kcmTRkrFASUT68SJzj/qo3hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:38 -0500
Subject: [PATCH v13 3/9] irqchip/gic-v3-its: Add helper function
 its_pmsi_prepare_devid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-3-646e2192dc24@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=2002;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mH/HfWSB72ELMEfQcYQ6cyfemrKZKDjtNGbdbaIdvQY=;
 b=eNl/J8BE9Qsa2PmKzqDaaOiXIGwP1SfQYeNr8M/BU/MKJno+0cBLI1ItCfZwl5sepybqrdD+4
 1YTX89sSZheAgmKru98XpDEQ+sdJ/UIoZzjFPMJ2MaFMPVpGO9TtiQI
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
X-MS-Office365-Filtering-Correlation-Id: d19b22af-ee4d-4ccd-b705-08dd1fb8feca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGRrUXFmV0UwRmZtKzVzR3ozM1llQjRRYW95bEtkaUdLS05UZ3JZYVZLMXlm?=
 =?utf-8?B?M0dVaVhmQVV2c0c5WDUzUXpVN1J5MTlxN1lxbURTREdWTFcwTmw0bDhwVFE0?=
 =?utf-8?B?YW9zTFlJZmZVano1UHhYNUZjSWIvWVBTcDhaMUdsam5scHJNdFFnRFJmL2Y2?=
 =?utf-8?B?VmhxSGEwc083SkZ6bWgxT0FNRENVZGl4Tk5HYjg4dC9OV0NaSjl1Rk5PUlJF?=
 =?utf-8?B?ZmZIOFJsVVZlSGZmaExuaThTQUtDNkhoazlhelhDSlZvN0RGRW1uRE5zTExW?=
 =?utf-8?B?TU5YVUQwSDM4N3V0em5EQUZLSXYvZGRIYTRPNHlUZkorMmpLVWI5T3p2MDd1?=
 =?utf-8?B?RWN6WnFrTjk1bUFVQ2hhMEFTdnMyY3V3N1V5VUlSWHpJVjNaSVZZMHlUeGlk?=
 =?utf-8?B?MGZVYnZPSUpYUEVabkhzckg5MDJqVDFJVjlNeXNaTFg2N2dMWHllaThBVm01?=
 =?utf-8?B?aWxFRTNKYm5ndGFJdkYyK0U1TXJ3MmZiYzNnWFVKZEV6YUR5L2NHbkdDT0tp?=
 =?utf-8?B?Z1BZWjJVZEg0b0lVNy96Mjh2R3NiZ3JaYzFjRjFJMjhrODRTQmV6dCtXcHA5?=
 =?utf-8?B?NXBkakRsV0RGRVBhOW9uRGxBd1FGSmRFSkQ3R1NHbWtOZGtGNmhxR21QQng0?=
 =?utf-8?B?VnFEVWs3Y1JNTTdJdVdod0RJb1RWeFJvTGp1MTRka3ludGNGYW9laWtKOGE1?=
 =?utf-8?B?WFdjZ0luKzdQOWtDemRleml6andoZmVkdU1EdllOK0FXMzh4TGJsOENmVng2?=
 =?utf-8?B?YXJxQUpBQ2xsM1dDMHM5MWFYSEZNL3NENlRzRlhoTGFtUXkzSERLK1Erb3A5?=
 =?utf-8?B?ZVcxZDBIa0U3a2h4eDd3WlhMN3lrTkNlYVZaRjc4MUV5U25xeUFqSWtRd2Rl?=
 =?utf-8?B?RnBYREdDQlV2VGZXVURhOGpwSk1CZ1JkN3NqYXl6T1JvUXRKZm1mYmVxWU1V?=
 =?utf-8?B?Y095U2g4aVh4Q2JheDRLY0NZZGpUalJmb250THEvRmdERnR4WWhVMnJCQ3Fr?=
 =?utf-8?B?bk5ZKzUxS21nTS9TbTJJS25tNUZFc21xZ2dTOWVjaVRVU0JITTdxQ1dkZEln?=
 =?utf-8?B?T3V6dndLZmErK0VWK25TR1l5RmhQMlRSaGZsZi9FRnRtNTJ2ZlcvdTNDVkp3?=
 =?utf-8?B?aHR2SkZpeWtnZnMvMVFmQUl1V24xQ0NkcFZiNHZJZXBVRCs4QXhvZ0RGSlJJ?=
 =?utf-8?B?WUhiaWtjTTZBSTFDSGNqZjNvRWh1amxoMGZwYmF6Qy9wR0MrNno3R3JGVktE?=
 =?utf-8?B?RnNkdkxCQ25zODEzQStqbnFFMVZYL1FPbjNIWWxuTFZEZllLc3BnT01hdGwr?=
 =?utf-8?B?WGVzazRvWmNOejlidDF2ZU9kWkJnayt5MzFWYWx1cWE2cWM2Yjdsc2pjUGd3?=
 =?utf-8?B?UzZvb2NYNjdlcTd3eFlLZnVib1Arbi9oQ0FUS1NXZENFRWlyYkxoMzdTVTRp?=
 =?utf-8?B?NFpQL1ZvRCtOMGtkdnNPSDlPMnduODVLaU4xSklReitocDdudXBCQW1MQTZx?=
 =?utf-8?B?cGhkakkwMmxTYzJmTGRlaXdNY1BTbHBUQ0ZqOEFqYTVVWDVDK3ZOWVY2N1Zx?=
 =?utf-8?B?WkY5MXJ3ZVhESXhCTUwyRFdNSEt4Z2o2VC9uMjBIMXBEQ3BpdWlwd1ZsT2Zz?=
 =?utf-8?B?MkFURFNOZXdFVzlkdFpzazZmMFpqeGxJTWVBbnFwZmx5dE9EKzltTG1iRlE1?=
 =?utf-8?B?L1E5V0Y1cyszN3BnclFSc0R5dGQyWnQyUnJnVUNjenlvckVVd1hmVEtxYXF0?=
 =?utf-8?B?UHg5OFM5V1ZJTkxWdTAzVVJRL2dacWo3ZnRUZHd4Q1RjMUhjREpOallQVTdv?=
 =?utf-8?B?S3pjMkFBTWdxTm1RQURhWmZBQnVkT0hWUDQ0Y1NXV21wY2NGYk9QY2FKVE5D?=
 =?utf-8?B?ajVHV29kQnZnQUkwUit4YUlFeCs2UElWODFPaUhaRmhPTFlneTVPdTVic2px?=
 =?utf-8?B?aTdLcXlaRTRWOC95bmk2ckUwbUIxck9WTlZvTHZTNmdWSGZQMS8zSjRUWHR3?=
 =?utf-8?B?WkV4MWJwYmFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2lZTktHTVJMSTcyTHpzNnM3ZVZjVzF0SGRRV3lHRWdNVGl0UTV6L0VwT0xo?=
 =?utf-8?B?MCtESUhDY2FGTnB3Mkx4UzN6Wm9ORjRPbUdXOTI0eFlJL0p4b09JRGtwYWJQ?=
 =?utf-8?B?Tk1DZ0V6MTM4MkxwVjlnSW5BUVplOU41ZHNaU1h1Q2VhQ1ZINE5PaWZUdjQ2?=
 =?utf-8?B?Z1RBdVpWby94SEdWNU5WU0pydnNBMDhja3BTMzM3NzFrNXEwcFgvV2dEajg2?=
 =?utf-8?B?aythY2t1aXFpTHBjd3RGbE9vQzhCVGxMeTF6SE84S2ttZDJRV0pwZmhmNUZH?=
 =?utf-8?B?Y1UwSGdDajBBVWIyaHVvdmFuaDc0V1JhWWNpb05lemYyck5TY3NFVGkvY1RY?=
 =?utf-8?B?Y3VLNjVDRGZVSEl4bTZHN0F1UHpJckErSDhpck1NMHd5U2V2TFB4QkxuV3VV?=
 =?utf-8?B?Y09XTko1YWpLdVlYY28yblJ1dHRQd3VqdnhlS1hKQjZ5eVdmblZBdVdGYkR4?=
 =?utf-8?B?YWxmbGVQQTdQL0V6eUR1alFMR1h0NEMwSVpHSURvMGYrSE4vdUJZanJwdVpD?=
 =?utf-8?B?SER4TXVwVmZybGVWenZYMEluUTBRbDBLbkI2cmJ5NlJab0VySGQvZ0VyV0JC?=
 =?utf-8?B?QllHTzBzNFVSc0IxZmFHWEFYTzFQMUF2WkE0R053eXJmTDB0VXdkbWdnUFZm?=
 =?utf-8?B?SmN4QUlTNlgwWVY2allHT280MXhNdlNGQW43c3RTemg2YXY1b2ZGczlUQU9V?=
 =?utf-8?B?TFNpSFVmZW1MSmZZbDRCVjlyTWRZNUpUNklOc3BvcndwTktiRnMxenZuT3Zx?=
 =?utf-8?B?dFhlZUI1UWY5eVd0QU03Mm8rY25LeUJ0OUVaMXdNdmpEK29OTnd3MTZIZnlu?=
 =?utf-8?B?U3M5cWZQVkZKMUVmTndhRnk4OS95TXdvdk9Jam83bFlMaS8rRFJaWVFlOGZu?=
 =?utf-8?B?Zm9oY244Sm9DV2tDSjQ4Q2hKTFdGVHVRMFFPbXd2dkl5dzRMdkg5eExvaHFM?=
 =?utf-8?B?T2FDQ2tTT0pKbUVqblZHK2YzN0QyaWxCMWczTy93SGhScElKQlFXNERwL1dN?=
 =?utf-8?B?b2ppak9pZEZqRzVyenZqdVhBR081WEFXZkZ6V1lmdVg3SGdjTzluZ1ZnbHp3?=
 =?utf-8?B?U2ZWNVdaU21xYUdib2xVQk1EaGE4UzVqRk5VV2RCRTBmbjc1cXE1OHBoMUF5?=
 =?utf-8?B?OEdMVWVlNDQxdVBXWlRlSjNlNTFRVEVNZTRHaVAxZC92ZHBIN1ZabHdiUEZ1?=
 =?utf-8?B?SzE1V2tTU2NrYWg3ak1BUzhKNEFxZUs4aUN0YUtzbWpwQnlxSTFZODFGOTQ4?=
 =?utf-8?B?LzVFVzUyaHZ2Vk1meVJwOGEva2IxZFRLcHpDSnh0cStXbkdKaVNBU3hoRE1R?=
 =?utf-8?B?dC9wTFl4QWxQYy9KaVNjc0xjVVRXZkVOVXF6cXlNUWpmWk9tUzBQbGVndG9x?=
 =?utf-8?B?bmx0M0dvV2YxQk5HRU1USVVuN1ljd3FlZDFuNVMxT2E3eFJndjFmUjMrelQ2?=
 =?utf-8?B?c0N5QUhkNU9KcGs2a0VmTmFtS241OEFzQUdpM01uWGxwUGNoREZnS3NVdjZZ?=
 =?utf-8?B?UXRndnVzVmlWYUdMTVEwYjlTODhFSnlvMkFEMVFFbDliWktlN3A0ZnJWOVVx?=
 =?utf-8?B?OHg0RlBld0UwZzZyN2ZwUHBFdHpXSG5PckMwV3dmd3U1a2Y1allqMlZsTldU?=
 =?utf-8?B?ODhXb0FEK2JkT21Xa2RXcEEvbzlPSXVRRkJBSFAzdlBNNzVNTCtiU2lRWlZN?=
 =?utf-8?B?Q2R0dGRIMW1VQmpKNnJFOTBoNWc4RFFZUUp6RURVWEVZVS92WFBhMFltSUJ1?=
 =?utf-8?B?NDlxOW9kbmZnRlVpMjE0eGJPZWxwVWQrSkdsLzM1WlpkSC9RYmZmUzZucnc2?=
 =?utf-8?B?MkljdXQxUVlBQ2xPYjZ0Q203aFJjQlZvMnB2WjZmYnRJRklOK29uMVV3dWpU?=
 =?utf-8?B?R2V0RkVMdk5Razd1ekkxUjlqM0wzR1IwdTFxNUoxa08rQlU1a2tMMXp5b0Fs?=
 =?utf-8?B?RkowaGRUeTZxM2F2RGpUNTBrTlE4S01wdWdDQSs3akx2M1drR0Q0TjRkY3J2?=
 =?utf-8?B?KzF1QW1HL2xDQi9KQk5mVlU0ZWxwL3R4UUZVNE1yeHEzQnV6ODlZQWNYYUdP?=
 =?utf-8?B?NVRUZGkrNkhhbXRxcFo4blRmWEU4WmtrMmZ3bThtR2FOdStVQ09QQzBOaHJR?=
 =?utf-8?Q?EACr/K0EDotlB/iPyr7o+f3H/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19b22af-ee4d-4ccd-b705-08dd1fb8feca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:16.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2jJZPCe/OO7WB+dhZTT8jrvnkQozxZ5YV+J8/MYC9xX/HesApvUaL5wEmEvINhTY5b57oMgOLIV3ERnuVbMIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add helper function its_pmsi_prepare_devid() to pave road to support new
DOMAIN_BUS_DEVICE_PCI_EP_MSI. No function change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v12 to v13
- new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 30 ++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 75aa0d4bd1346..b2a4b67545b82 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -132,19 +132,10 @@ int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 	return -1;
 }
 
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
+static int its_pmsi_prepare_devid(struct irq_domain *domain, struct device *dev,
+				  int nvec, msi_alloc_info_t *info, u32 dev_id)
 {
 	struct msi_domain_info *msi_info;
-	u32 dev_id;
-	int ret;
-
-	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
-	else
-		ret = iort_pmsi_get_dev_id(dev, &dev_id);
-	if (ret)
-		return ret;
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = dev_id;
@@ -165,6 +156,23 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 					  dev, nvec, info);
 }
 
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	u32 dev_id;
+	int ret;
+
+	if (dev->of_node)
+		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
+	else
+		ret = iort_pmsi_get_dev_id(dev, &dev_id);
+
+	if (ret)
+		return ret;
+
+	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
+}
+
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {

-- 
2.34.1


