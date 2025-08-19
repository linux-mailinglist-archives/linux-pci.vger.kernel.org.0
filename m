Return-Path: <linux-pci+bounces-34276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D291B2BE36
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF045A1BBA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBE311968;
	Tue, 19 Aug 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kFfJmn34"
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013024.outbound.protection.outlook.com [40.107.44.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A931CA7C;
	Tue, 19 Aug 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597243; cv=fail; b=YjJSLAGKxAbRxpaSNx8i6XJPUaZ6pqOInL6KQc+eUDKRrascclFID86yR9MES+8VpcmBJRrYlipYTPgCrPgBgd5iLIDaO3/TD8BZFQmgP77L1k26uYMm55WGcKHT2Bvb2EDDZfcpH7UE4CJdjWadvgS9vgO7ltY3DGoW973Abuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597243; c=relaxed/simple;
	bh=XEvLQFa9qxVomagvoeKfz4gJ4L6ocjaiNy6EFRmQ1DE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4HAHPdjkCav93FOZJrXsZnpZ1Qe8dBE8Gm3DlberYgUkUEMkCew8stJatYCN11Hn34R5Gaz+uArKMtekZbLN0UyW2E00ZPzBqpt9pnjIy/+OJ3cEjc/g1UpA++ogHr1bLfCbrSQ7ElANJP0Ns62jMYHA+Mhs7UUirz9xjO2ccM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kFfJmn34; arc=fail smtp.client-ip=40.107.44.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F28yp86vFkYErmT9N1Q8h2775ipNUdMHWDuZAk1sXO2Q+UkAAmw3wGRMZ1ntS4lGQM54QTcqhHCtt9onfwq4+oK4E1NIxo/34ffWyLBvqU5LK6B8siCfbB0v8+wbHaYxr8JAMVMXGUOYZ/MlI0/2y11irZLQsiy6+gigO7CeiyW817Ym6La8FaoBHrkpcJJtIkILKFRY/Q/FMa0qByge8WJlgRPy+yOqRT9QrS6ovGzQt6Q+g8fEKVoG385WjmmJKuI4BLDuawPrGsqzmn+7wZ7QrCUU9uCGe+NJnmthKZmY+z9WZ91bA2Lgyb8w/ORfIC/50dVEP98UCHF3vuNNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fAJmCEu8BTAOaxaezjphkTZAd/qZl2+yPxp6XdddpU=;
 b=e9xTOJCCUVec4i98iDaNCFz+2M3Eh6Vz8M51lEuEvaLe9LU9ozPW6Hiiv1eGhmlIYtIhQcZqEoRqvZOQrzEltFrAAl8gUQZnBsflhPvvH3URVHIbn9M0vEguWN7NC54NSGtQWLT8WZgvQiw6hDO0JeNGRX7uWBk9CqIRsmZQhes6SM6yNYCv6xjXivuT4pnnVDwI7femHZoUF/TCPd5sJzuH8A65wsZm09507+OxO8RSaRNga7j1SkOl0aik4m1mzUwbhufzzxjafDiNVPAIAjjo2mfJr4iqJrW/f0ZAXuVd385aderqeOiq6bGaGaKwlljdP3rILt4+kufuhXv5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fAJmCEu8BTAOaxaezjphkTZAd/qZl2+yPxp6XdddpU=;
 b=kFfJmn34RZVgirsX3sBi3v8ZWPaXZh8iqF3E+Z5uiQT3rJNvqVm7VDpIkt/Z7p1Cz51dIVTAsKUWkDj2aGPpmsiMHwUWayCcNBYJt/MsIn56FMSO8GVAfVTQwVteLWT9POPSkaoou3sX/eJ8JKojA06xU1jzfANMryX205yCCxmOU9cJtRTkpxqbOMkOQJJVtWHEpFdBtvxR050Z3ODHv7j8etYDS5tmbowiqJdpWw5EO1uY2e1/DGWqa5aDuPWvaQE3hhkkrTwW5VAxHGiLvyTzDLFXhKjrcxXdALHqqhg4wPAwjl5eljLoO0QVvcGXEpMFVvFTEgTp+JAeXICb1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Tue, 19 Aug
 2025 09:53:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:53:55 +0000
Message-ID: <214ac6a7-7c30-470c-8d47-cea7c837689e@vivo.com>
Date: Tue, 19 Aug 2025 17:53:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: keystone: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Hans Zhang <18255117159@163.com>, "Jiri Slaby (SUSE)"
 <jirislaby@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819085917.539798-1-rongqianfeng@vivo.com>
 <f5fb6c50-7576-4b75-bbed-7989f4718daf@ti.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <f5fb6c50-7576-4b75-bbed-7989f4718daf@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: a32ea3b1-f1c6-4667-edc3-08dddf064fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTBORnZMT24wY2NhVVlhUTFncDJCNVk5bzh5d3U2NGR1aUo2NUhON0QrNUFE?=
 =?utf-8?B?b25SWCtwaFJUVWZiWkFBbnk0N0d0S0QyeHA4dkc5cE9uN2E5cGNOUVdXclRs?=
 =?utf-8?B?NTBCRzNjWk56VktqUG9GSFlPZUtaZkVkU1ZBVkd2aHNRRzRBczlBR1pyUm9w?=
 =?utf-8?B?TnVTajl4RlZjWVp4RVc0c0dYVlZ6SzNId09qSkUyU2J0ZXRiQ2pGQis1VzNu?=
 =?utf-8?B?Zm5kTDFlOUF2ZlRWSE9qRWI1YnpBNFlLblhxcHNZOElNU0E4S1ErUHRVeERM?=
 =?utf-8?B?UXpLb1ZtZWtzQUFLN2lzOW9SRm03RCtVdlgybmRRSVEyQVhKb1FSMTZxRldI?=
 =?utf-8?B?R2phSTZGVE5sQ29VYmJZOGhhSDdjMGl2QXhGWitMYWxqSTJjbWo3QWptWCs2?=
 =?utf-8?B?NzYzWXRZMFdrSzdNcXVoSWROUFkyVW5DemRkWEoxUGl3ajR1dlA0MDZKNzZQ?=
 =?utf-8?B?M21JTXFscTN1NTZ1TkpYU0VPaC8vUEZ2d0lDTEdXWUFpM01KMVIwT1c3Rytt?=
 =?utf-8?B?TVA1MW05dThSL2FOK0tOUnAxak5XeEg0WG1LZG5JdDBtbmlpeDIxamxIZUhP?=
 =?utf-8?B?M2ZvRGU3TlhwOFlWd0ZkNnlVRVJuUStEeUpMZ3RrQ3k1ZW1zRHpiL0hmcUI3?=
 =?utf-8?B?cDBzTVo4M0kvUy95SmR3aHdKSDhVTWdVaHk5WHJYNkovOUFKK1ZiSjFNUDha?=
 =?utf-8?B?K2taNDIyaUhiVFVvMDA4OWp2TjlFU29TbDFrdjdPNk0vaUhBdlNyZ29kTC9a?=
 =?utf-8?B?cmdjQ1N6OXJ6SlRDSW9WMmIyLzRURTJtaDZrL1JWVTNiMnV6dFVocDljZzQ3?=
 =?utf-8?B?L3BpMjZ0QU0reTlydG5QNU5sbjdJQTZSOEEvYXVjL2ZBd25zOWxDTmpWMGtS?=
 =?utf-8?B?cCtzNkpXZkpUbVRRNVZuWDBBRXNKNDE5eS9rRU10c0wyWFVnbmtROVo1UENG?=
 =?utf-8?B?SGUyQWF6dWhsZmdHSG9paDJMejhQQzNtbzk5TTRkV2pyQlBUODF6dkFVeWtJ?=
 =?utf-8?B?akZDbDBJV0ZPRmJ2RGFDYjlPakZyTWp5dWxMUlVQNmpKYzhVN1p4TDZoaDFr?=
 =?utf-8?B?RjRTWC92VmtwaDlTcTQ3bG12TTlXWWtvTGgvcjVVRWUvQVFBU01wczNscEx1?=
 =?utf-8?B?R3l2VE90Q3RITFBYQTJyVlhabzdQZFVSbE9KcUhJOC82LzVyMUgrbC9QOVlF?=
 =?utf-8?B?L21LYXdnUE5lU0dSVjhIdm1GaWdoUzVlekFnYzEvVjNMREsyYzRlMWdXYkhF?=
 =?utf-8?B?NVpWWkhPSUtZNGxmVTdJZGhPY0VrNzVTUkhWS1FJTGRPTHFaRVJRam5LdFp2?=
 =?utf-8?B?NzNCT2kreWd5SXFjZEpnQUhZZ1k0M1YwYnFjMkE4TnBSb1NCRUt6S1Y0ditu?=
 =?utf-8?B?VDE3c2Z6Q1NrYnpwN0FUSU42N1BhbmNNZlRLZGxLeHE1NmdhelFnUW5ucFEy?=
 =?utf-8?B?Yjg3a1VFNXF3UFNEZWhwSG0yOURMRGxYanNxZWJjYnFLZVN4S0hhWnZDZ3M3?=
 =?utf-8?B?QmlGYkdVa0lJSGtKNUlVdEZYcVdSMVFNcU5Mb1FNT1FBM0N4eUIwRmh5bGEr?=
 =?utf-8?B?Qk9LeHJaU2gxVEwzNWZRd01FY0VyS3A1RXM2RURCMHBvR3RzUG85aWRLeWxX?=
 =?utf-8?B?TjF5dituUmVnS21tZGxUOERQWkdLSVpBYVJrTStwN1dLOTVYUDBRaUVDdjAr?=
 =?utf-8?B?S0JId2xyWVVlL1Y5M2lCQi9HTVY5SHltcXMyck9xdWlFbzhLdW5MeHZtTEhm?=
 =?utf-8?B?Q0ZuQWJ4Q2NoeXpyY3BCTnE2d0w1c0Z4S2hFSzFWeFJzNWF4d0VjMjl6S2Y2?=
 =?utf-8?Q?KhW0TRAHZ3IaJi3hglEh+YhzpIrq7Ci5o0RkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGhJQzErcVUvaUxMNTByd0crQVUwYTNlcTJMVU1IQmlJOUpySit4WExYMXNj?=
 =?utf-8?B?dW5JQ1NJQkJHdW9hS0dqbWdkU3lsS0l2MncyMVpKdFRHMHhXaC9BMjF4Nm51?=
 =?utf-8?B?eEdmZjJ5TG9QUzE5T3lIalpHK3lucXBjVFlMc3I1WjFLcXpRTVdvSTAzbmZB?=
 =?utf-8?B?SWc0SGdTUkkrQWZYaWU2TURjVStMVDVJaFE1enV3eDlFNGh2bXd5V2tJZG03?=
 =?utf-8?B?Sno4NHM1SzZVdkRabFNOVkdvRlltTHVtb2RpZWE1cEU4Zmw0UkgrRWk2U2xT?=
 =?utf-8?B?SFZNajNGRXYvQXBjMGR0WjltaXg3MVU0a0F2cDBOOHV3UktFdzdOWmpCRjYw?=
 =?utf-8?B?LzdpVmE4VHVOYXdKTEtiMmZZNnptbitNaUZLWU9OemYrN1ZhTEp6RGwwNy9U?=
 =?utf-8?B?NktsTnZzc3FYNWV4M3ZRMDVQM01HOVdBUzNCWnpmeEI1VWRvU3ZIUjg3Nk1J?=
 =?utf-8?B?aFdVVnZYazl3RjZyM1ovanY0R2poWU0vc2RzNncrcEFEdUk5SGxMa2k2VCtX?=
 =?utf-8?B?MW9xZG9ENUpOR29Qd2YyUXBmbzJGWllWMUVFYmpYb1VUVGVJUi9jaktVVjht?=
 =?utf-8?B?UmtYT05WQVRQU0pDd1FDUHgwTDRjalhkNGV3ZDF6djBFYmFCT1EzNTlmVGxS?=
 =?utf-8?B?VnJsOHZFdmZQWlRMU0hqcmlUZmlxSVdxQTQraXNKYVJwVkJxVG8yWWp4SHpq?=
 =?utf-8?B?Sm5leXFhOHlGVHcwWTM2ZXNmblM0UUVmSXBCNTZlcHcreHowek50d1JEeXV4?=
 =?utf-8?B?QzA3RGp2RGhsNFowMy9MNFd1ZWFUdVMzdGtaalNnbGdhbkxBOFJTMWhyOEEr?=
 =?utf-8?B?b01uWGZWejNVNWtEV1hKV1RYSEN0ZVJuMFREK0hRVys1M0MvbDdOQnJSVmNa?=
 =?utf-8?B?eGxja2lIRlRDbzhyRjFyM1RmbkxOWG9HZUlnbGlvZElsTy9qR3pWVHpGQXdD?=
 =?utf-8?B?SG4yL2NxdGRzdzY0QWJvMDRDWVU1TkthRERETWJEbXFVUWRmTEtFK2JWTjM5?=
 =?utf-8?B?RHNUa2NCSitXbVpyMC9mTWtWOThwZmJKTGJ1Z3drSFhIbGgzY3V5VUJiY0Jy?=
 =?utf-8?B?Uk82Wk14ODRKcHVpNlBDZEFzQSsrOEVJWHZOaW9RdWF6d3prbFA3RHFpd3Yx?=
 =?utf-8?B?SUM0cEVzdW5ua05UaXlHcHpXRTQxUEwvUVJhQWJjSW1HK0hQeGZQZE1yS2Nj?=
 =?utf-8?B?NmtqRW1KTEdaZ203cXlsbExLRlRwWmxNOWlTa2prN2NHRUNtL2EvUGFwcXdD?=
 =?utf-8?B?M0VQTUkxbkFFUlRzYmV4TFQvekordFZRZkJoSFY4Yk1NRDNKZldKR3lsRkM5?=
 =?utf-8?B?MytTSTBqU3hhL2gxVFZJNmtKZ1RLRHRodVhkeHV0VXJjQ0hXUkNKanpXQ2tl?=
 =?utf-8?B?N1VUK2ozRGhjaE5hWjB1SGlqSmJSRlVlZzlVRmtLc1E4bFNkRU5XSDk2alcz?=
 =?utf-8?B?OG4xZ0VvUzV0ZTRURG9GZThsWVpaeWF4OEJKWE9qZjB6Ry9lcjY5ZGxocDRQ?=
 =?utf-8?B?dkZ3VXBPUGVzVUVMWThMc0hZbXRma1R6dTdGWnpPbFdlR2NtREpybTFlODZJ?=
 =?utf-8?B?REpxemNBRkVIUGZkdkRjbVBJN3VXM1RVeUtKVDhsb1h0V1VhT1dKdEY4N0gz?=
 =?utf-8?B?T2kzM09sc2k0NUtWcCt5UE5scWVPTHVyWC9CUTVxUWVvWEx0NmhoT3FtbUVM?=
 =?utf-8?B?bGtLbGtHOTFPb29vWmpXaVlwRFk2eVpYYkxBbWdKdzM1Y3VQaU9GVVNPN3Z5?=
 =?utf-8?B?SlU4b2VwMjZDd0cxSHRGTGIwZXZPQVNCVHJYTWJiaHV4MkxKM2p0VVhOVGJI?=
 =?utf-8?B?WTlkNkFIY3NFR1V1SDAyQTRJRnFURXFncC8zTm9yNmdrcjlSUlZwZEY2MW9G?=
 =?utf-8?B?TkJkSXZGSE1BeWpKUUU1YlNLY2QrWWRpNEVaMUc3M2tGOFl4WERYRStkQXkr?=
 =?utf-8?B?WXJzRXJzUDJzRUovN2hPVHVVR3NzVGp1OVNxVTVHN2ZraEV4cTAvaUJ6dU55?=
 =?utf-8?B?V3hwNk9DVGw3eTJSZGRHcHpibmxYMXY3aENVYXhoWU5MWXlaQlZRaVkyS0VH?=
 =?utf-8?B?ek5OV3Ywd2tESW16b3hpSUtIMGdwZnpBay81bFplcEVUZWpLdzNPZVRWOWtD?=
 =?utf-8?Q?roLZYlOgHS37rw6skb9CBSEof?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32ea3b1-f1c6-4667-edc3-08dddf064fae
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:53:55.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tv7eWo0gY6/msYEeKpHCK+wsoTXfACZBJpYDJIeeqdKnorTFKOnKc28gEIR1Y7wk6KeuzFHFU8rtt+9IfKMjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793


在 2025/8/19 17:49, Siddharth Vadapalli 写道:
> On Tue, Aug 19, 2025 at 04:59:15PM +0800, Qianfeng Rong wrote:
>
> Hello,
>
>> Replace calls of devm_kzalloc() with devm_kcalloc() in ks_pcie_probe() for
>> safer memory allocation with built-in overflow protection.
> Please add more details by referring to:
> https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> and stating that multiplication could lead to an overflow and isn't safe
> when it is used to calculate the size of allocation.
OK， I will try to do this in the next version.
>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 7d7aede54ed3..3d10e1112131 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -1212,11 +1212,11 @@ static int ks_pcie_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		num_lanes = 1;
>>   
>> -	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
>> +	phy = devm_kcalloc(dev, num_lanes, sizeof(*phy), GFP_KERNEL);
>>   	if (!phy)
>>   		return -ENOMEM;
>>   
>> -	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
>> +	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
>>   	if (!link)
>>   		return -ENOMEM;
> Regards,
> Siddharth.

