Return-Path: <linux-pci+bounces-15487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44859B3A03
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011CE1C21720
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369B1E0DE1;
	Mon, 28 Oct 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUxrZEDO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44E1E0DBE;
	Mon, 28 Oct 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142391; cv=fail; b=ajpNreGv2LKOGm9DSstRPE74uKA4IYESsNA+X8clrumE+yiA0blA5m3YOvJFYW63aXbC6YRhqDnmQb72QSN0qEhMZzmX5F8yHbIriF956+7wUnqmh+5ABBpoqoAw01mBxN4o7lXBAbNu4acKouOgzyN3cE5KtUvbCijo4p1Nah8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142391; c=relaxed/simple;
	bh=Z1ygha9+xD7FlYOYS9zQvq9PhEUCSi65GmFlWznej58=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RDnXiDhdYDsJUBl4mBG++wH6JOvYYeRnq9Ml2XFEl+5dNaINNRC1NTGHYfDG6ZYPHFoTa22FmmzNOuG3LpYFSDqX3kop+7/J+e6rxtvsWDcNgEZJQuNa/Cc73u3j7idzZZ3Li+KHKb1MAh9xcQ+MK8X64CK9CqzrPRDLDScJqkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUxrZEDO; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=av9e+Kc2JrWaLyEWhPZYlXWiqCa6euMp5DW0RrxwtoxYDIzGF4pooHtlvgV4E8h/Bld2rDdQAOY0pcj58U6FJx8LisFkSxViziaQnkgqHP97YX8n3X5Y1z9MvDe/jFfiC9/RYx3IZqvBx7rAC3gJ45rC5wVaYFSY0vHK42+A+a9IY9o8hJShIC+qihaCAziLkkWrmBwhIrzwbaWOXcthaWQ6tclspvvaLXl2FnW1P/QjcADE1YaqlSvoARlxChH4yWMJ3bsF0K7//sOd8eog/FqRi8jY8H+840fnYz6pJYsXa90lcj1wJRZjDpWKmI1AbOG5L1kd+/tyC18iByXE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQeePKxiG6VD8uGDrodNnYj3a8VmNmBfPCLUrcwxvY0=;
 b=TlGh6s1La7ck1FxUs+0t9xuG7eQweL3/JTD75lHfhl1nzHVQeqYUT+dZuGKHHOhg8tKQ8EXghKlDEIMFlTsoG/e+TkWljTpD5LZIcKfSwanSEeJUG+pTG4/6a/RnoMVacEMg0o32dvmwmQxX8eN35r5UWR6A1nPdsl1t+nJnoGj+o4BDFVSKjr2LAgNWgntYQxa1Kl6+7MF9IH31gZiIIFr+ens+2RQIsLxZRqKc+oLezOcxOYVrSKrVQLLdmBKxvfmoq+BXzlkLDLni55i/h3sjOPmc3mkcE0qf3X1Cjexl6tgD0Jp9Ehp72nC/wlohX2yKpXeCkxlJ3x/Al8B7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQeePKxiG6VD8uGDrodNnYj3a8VmNmBfPCLUrcwxvY0=;
 b=HUxrZEDOhFypuVm7mu2ROiFs6IU2Xlsyt6imA9EMl3RXgR9r0vYWm0Ld03zEcLhkqlxACn2gNTgGb+VsT4cTiK+nmDcIl+JQwr0a1PCQ9WPkjVo47C50F8hEHq+rMslGVTaOim+xyswYDW7dbemp7mmzNoxHi+1NsiZ5mvnC3lUCFbOAvL/k/eLH7NUX19/ENEgK+MzKEnP2ipZALr1BiCCRv4ZRO0eVCzWSXDbcWYMWecLs2tnXfvqEZmfi4p24WnjFVO5Yhkg165SygSg80Y2uFrX0fCVshk/1W0DQhP1Zcj4UquIoYR80PbT9sjCP1HR33dJECMREeXJKv32RoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:05:58 -0400
Subject: [PATCH v6 4/7] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-pci_fixup_addr-v6-4-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=2455;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Z1ygha9+xD7FlYOYS9zQvq9PhEUCSi65GmFlWznej58=;
 b=3yp3+KMBu8iS9BIFCUUKquHWkCCIC92YBwOFNA3a2qFhTRSk6+IqYryloMK6W1SDbP64xj0I7
 6YW3oTyxAU8D7qNmJaahKNlaWRnHHnM6Za1QPBZDnv+KmuNK70AJjCb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d445dac-04b0-4180-36e5-08dcf7839f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGd2U1ZJQld3aWU2YnkrUHNtV2VhTlEwRmNsUld6NC9NRktJa3RncDJQeGJC?=
 =?utf-8?B?OWdhb2FXTXNOZzlOTnB6eFdGN1pCdkZnVitHcmpXY2lhcXpKaGpwZDIwN3Zu?=
 =?utf-8?B?ajYzVzVYZjlnY0ZzU29Sd3RRTG51MDVtTUlBSW5rYnpseERYQlA5bis4ZFJZ?=
 =?utf-8?B?RlNSeithNmg3NkFRZHJUNU50OStrbk5NZWM5RUhjb01LVlN5WTlDbEFOSkV4?=
 =?utf-8?B?ckV6U3JSaU9Fcm9qazlIVDF6Y2hpb1RTNkJCYTdKaEh1bnR2Znd1TWdrejc1?=
 =?utf-8?B?aGRBQllIZHFSQ29OdWo5U3Y2SlpaTDBUVVQ2S1h6aFhqbkRjQ1VQeThScWdy?=
 =?utf-8?B?WFUxY2JIclpiZkxkZGEwU3E1NUoycTJmQWhHMHhnbFBCM2hMSDJJYStESk50?=
 =?utf-8?B?T1dKcWY5dFZ2a2ZBaVhxd2NZYUF1KzFKOEYxMHdyemlpWHYvVjg4K0ZMMDNm?=
 =?utf-8?B?bXI0NnZWbkowb2tIazlLamwvYStkVEJ1WS9CajhDVi84VVU5TjBJalpNR2Y3?=
 =?utf-8?B?M3JFemh3Ylk5RDg2N09XQjk2SUZkc3RJWHhkRzJWdVdXb01raHBSdE4wVUR1?=
 =?utf-8?B?aDNhTFJjbGhPdVNabFVMNWJ6SXU0Q1RWeTNTNlJVc0g4ZllWMGlhV1dVdlRQ?=
 =?utf-8?B?dFFzZXlpRU1NZ3JPWG5Xbmd1VGZJK3FtQmJXZm1GM1p5NGRvMUEvaW1xYVdr?=
 =?utf-8?B?K0t4Q2ZjR1R1NlVmQ2dvakV6alMrOW5PVGF5WmlyY0l3TjRpMVBTeUk0d05T?=
 =?utf-8?B?WnltVUVFTXJRbzVkVXZMSVlsYlJIY1J3OXFyYjlic0JuNFFDMitvRVZCOXFu?=
 =?utf-8?B?d1hCclA5MXp2akxWUjFyRWVScndySGQ2YVBDY0RrNTNsdWdIMnBId0RldVNv?=
 =?utf-8?B?ZDZjL2dYTmFRZjUrK1IzS1BETU9mZVpTeGtOamhOOCs3dHJaR08zb2s1RG41?=
 =?utf-8?B?NDE0R1poaUlKSlZJYllvZllWZXI1cHZCQktVTHNOcGhLTzNTUTYvYWNEblUx?=
 =?utf-8?B?RytrZVUvNVdmSlRsSG1MRWRidEZMKzBhVEFQY0VuMmNJTzF5VGFETXl1ZVlj?=
 =?utf-8?B?VlIvU0VOaTRTamFRVVdRRmxwOXFOcHY5eXFTdnl5MVR1Ty9qWDhjTm96WDhE?=
 =?utf-8?B?cjlNS1lVa2EwcHV4WDRYdlk4Qy9LWUhOSklWYVUzd1llL1dHdkVzL3YxNTJZ?=
 =?utf-8?B?dm52dTNDckdyV1puazFtMHFqWWtiRk10THd4cjNpMjEwQ1dzM3haUlVYV1FK?=
 =?utf-8?B?c0JoM2RoK0JPNDBzUnE2S2FSeXBMV3dTM0lHOEJleXVjYlRIT01RS3B6cFF1?=
 =?utf-8?B?NmVhZzNOUEdoMzhoZlQwblpZWGtzeXErUDV0ZVN0QlBjMFJtanpCQmtrcHpF?=
 =?utf-8?B?NWN2WEFLcWRTWGRlOHdLeFhwaTF4b0J1QkFFa2lMM1Zhd1lNVTR4Nk5OZTZu?=
 =?utf-8?B?akV2ci8wQjFRbmZxWTZjN0VZa2FoVHc2enN1SGhiejlIU09hN3FxRVVIN0tP?=
 =?utf-8?B?Mk42NEZReG5WdG5DeGlldFdPbUxzRS82STR4UTR2MURmeUdRVG5qNnY1MUo2?=
 =?utf-8?B?RDd6RGZJaTlkbVZ3MldDMEI0V21UOWFUaTRMWURuRDhVcm4wZ0krMXozNFJX?=
 =?utf-8?B?M2NmcnhjUkEyblppWllpYzhIT0pIbndkdmZFS0I1VVpSbXdybzhuQmh3NUN0?=
 =?utf-8?B?bUN1MldkYlpLNkU5cm03ZzdxdDJSK3NDMTAzNGVvNndmeE5MenFNdkhpVWxu?=
 =?utf-8?B?djhRZzV2UzUzSEhyK3pKS283WmRWUEdkeU4yS3BidzFwWG5TMWxFZXA0R3lh?=
 =?utf-8?B?TnVaYkxpRXNqckxNSExNSkNuaUc2UTVDR3hPSnBCaEYxdUhWZlZ1TjRMNFp3?=
 =?utf-8?Q?DlgwS4mBUqdgt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUxuT2xzZW8xQmhzL1ppQ0ZrVlFqUDJJUTR0N1JYNC9jWmlVTytkOHpFM3pK?=
 =?utf-8?B?ejVjbTJmZ3NLVi85NjZqeDFOc0tiY0d1TzhKSGZFZWhkSElpOEpjdlhqNmhw?=
 =?utf-8?B?bktQVWlQRGM0SXdWWCt2ZDZkSGhSdEk2M0dJL2FNK0hTN3VGK1dYKzVCNzkw?=
 =?utf-8?B?V1d5U25yR2Q1WWVBRHhiWWRleFBqVTYxWG5LRGhHdzRLbHZYVE8vQzdoL3VX?=
 =?utf-8?B?MTMyYktpU3lIM3UzTDY4bUNoZFlrVXRTK3VSaDA5dy90RzRMaFRodkF1ZDlO?=
 =?utf-8?B?VUw4bjZOMmQ4dzRNbzJDT1ZtczhrQU9TMldsV0IxaFFaYnNCUnpWblFGSzFD?=
 =?utf-8?B?cHYvejAzcVRxQmM4TWpRTkZkbE1MRzRJelczOVh4V013RlVWNTA3NnN5ZUFy?=
 =?utf-8?B?OU9sTEQzZ05ISW9BTWhidGM2ZGtyblZLOVBvc0IzcHg4Tm5Qb3E2TTh0dW9y?=
 =?utf-8?B?ZlhxaEM4eStBMGZsekRubXFOc3VpZWlVU2pxU3ZHVTU2ZU9BYTNKRGt5Q0sy?=
 =?utf-8?B?WHoxaWdDb2I5Q1RyVk4vWkIwQ0hKNjJDRFNjMHp3TDF1V05PbzVXdUxsbkJr?=
 =?utf-8?B?c3BBeFZuY21ZS0NMMHhtZUs2MERzYmgvQUhyQ3hxVE53eWNEd3JlVktpQWhB?=
 =?utf-8?B?c0ZONjlQM3JVWVdBelI2blFzRmFFMXYxbFhTaDMzdU5UeGRhbXFyc0NDaktv?=
 =?utf-8?B?OUxhNzFhbHVkWGw3dktGbmxRVzJod3NTVEZyanVrRVplQ3QxRUNpdXAwZE5B?=
 =?utf-8?B?dUxIN21vaVBoT2dmZ1NtaTFuUGRsV3dqc1lVRmVlQVhMVEdlOUh0bnlHSlo3?=
 =?utf-8?B?aUVsU1N4VDh0SnpYOGJWMG85SkIyamxqcGdyeVptNVdtYXFjYzFWNmMrNmZN?=
 =?utf-8?B?RTU2Q2NXVndTalNRQUovY3FHSFdqTkRySUhHRXR5OUFKSmlRM0FVUU5oWnk3?=
 =?utf-8?B?NUZMVklXNVE0d21NYmM3cTh3c0FLZlBZZjhVZlljQzh2NVIrZ3F1a2txalFG?=
 =?utf-8?B?NURUU0ZGY0lvWDNVZWl3MHFXTmxJS3N2bGhkU2xSYlh4a2g0SWdtTXRZdmQ2?=
 =?utf-8?B?M3RmbXRJZ2hDd0FxTHZEK3RBWW5zeU9XNnptODdZaFlaTHo0M3pNWVpsa0dB?=
 =?utf-8?B?OU05VmE2MW1WSGppSWFUM29MOUtOb08wbm5SNVBNdzN4TlhSQmh6UmN1TVVE?=
 =?utf-8?B?NG9TNmc5ck5kOWtwUFBHa1lHVU44UjdMTWpwajNtMCt4SUxCcW1RczlCbGZn?=
 =?utf-8?B?SDU4UTZLcmdESHVjRzVid3FiRXl0OHNvRnhWQjgxd3I5djA4UWFWRHdBTkN6?=
 =?utf-8?B?SEdyaWF2MWJHbFJ3S1NoaWlLYzBBNnZtdUcrYktKMDlja2l6aEpnQkk0ampa?=
 =?utf-8?B?bUFrWTkyaC9YbVdzZlBWYWRYc0N5enE2UllYWXJKbWtpWkh4aHFoSWRkMG1o?=
 =?utf-8?B?a2VlMDV0eWZQVWhENytMTzdPY2NMNUhWS3FCbS94WkxTNDl3a3BmS2FDOFV6?=
 =?utf-8?B?enhmaGZOVllZdGpwdnI5bjRoTFBDdU45aVJ3c3Q3M2VPWG90aFhwNlh0dzk0?=
 =?utf-8?B?cWpzNzl4QWZKTEszdWdxODdlWGxUZ3ZCVlRnTkVlcTd3WVRKcngrNnpOMm9V?=
 =?utf-8?B?YzdBTVhuQ2tKTndWYS9oaXNYWm1KR0dtMG9tSXZLYTMwUjJmY2FSVzB2WWxN?=
 =?utf-8?B?TkZPcVNHd3ptUC9jSHFNNFRoVUtqZU90K0JyYkcvT21IYWo0RXR6S1E1ekFR?=
 =?utf-8?B?ak03OU80NndLSXlEZjJpT2xNNTgzcUViTWhhNVpsdU5JRmVtVGMyZ212Y0lU?=
 =?utf-8?B?VitOVjZhMzZESnJ3R052RjViaEtoQ3IwTi9HU1BnVnpRaDEwWm1lN0YyN1E2?=
 =?utf-8?B?WEIrNVpuNWhUNnJ4VHZLUXZtUVAvbk5DYnV1Wms1cnppZ09zVDN4aDZSSE9w?=
 =?utf-8?B?cVJlMnRMK01yTjFhYVdvZ0VUS1AyQ0U0RVF2cXp6bzJYVjQxcnJwaWVqZk1C?=
 =?utf-8?B?MXpnNWJ2dHd0WWJMZ1ljVmJEU0JxZHViV1I5YW9mSkUzRE9RdGpMRmNZSFRw?=
 =?utf-8?B?N0hkZ0ZiRlRmQUFzanEzOHYrQ2ZrdStxM09rM1d1VHdBYUMveTRMNGV0dmpt?=
 =?utf-8?Q?r1B77KOSnBfrizgpd8+3BCG88?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d445dac-04b0-4180-36e5-08dcf7839f15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:26.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFUPx1u1bdEFlK3NSpIk4+6fAbdpxzV+nlXtPgXt9FKbCi6bh8YPT5EVnI2OZgMWcDqe6HUMZO9EXfcUSZ9xSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v6
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..533905b3942a1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -81,7 +81,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1012,22 +1011,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1036,7 +1019,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1446,6 +1428,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1585,8 +1568,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
-		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},

-- 
2.34.1


