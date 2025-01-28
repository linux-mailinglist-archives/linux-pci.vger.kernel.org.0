Return-Path: <linux-pci+bounces-20505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B140A213E3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E32A168287
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E381E0DED;
	Tue, 28 Jan 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6I8xtfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21601DE4E0;
	Tue, 28 Jan 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102112; cv=fail; b=O3yC7ugIGVPu+YZTdp/JkkPyFIRP0Pe2Y1hwdPpQ26aIi9NT0IA3244ieaqoRNuaN1dMnPSVbh1lNSJUjmUk6nd3ZYAmVeYZZsjTOLGJs8DU+WxxWgb+yKJlFCVG0/+iEXt7BqWrHA3XD9Q5OWVRExVIEbXh/D2C8dnmkC9ZHN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102112; c=relaxed/simple;
	bh=s6o84+rwYoULnhQEXwAB8qc9+uDgyGOz45L78dOCBOM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IozwjuPK2mlt7wPWihFGlwZNSXli4U9uA1qKszDjP2bXQQWxuoIvPGl11JJvkfTjncrzaGWiLpYbtgs05e6/DawSlvVKZr8JkX5x6iwsfiGmjK4fSnvhC/IfXH/7Wg1z8oX08SrIHrp39Hdshc7VmPBk1uBDb1H3XQUdTcTs2PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S6I8xtfZ; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfeU3gITMyOoKeO+wLMKaWX6k2/4LHuJsyWMfTMKZd/fzT/K6LRh9hmAj1fyQtFMoyB2uXY+nWQMBBKCz56wUhCAdHqfrG3/u+ZEqhPwE6ni/C8iHyTOHfvytssa6KhxeT0wE/i0wL/N6rlwyAkkBVioWdF4oWvYiLl5XdUlWWrisqOJ3fivzfh0NeF1yg//fB3hoZUfzxH7ldfTunY/OYU6GmaT66n7zvbpo8fw3Wkg9+hj9YvYxgQ/1v3TCzZNsGsCm8O/DTOw6ArPlQUHPlc3Bh8BeI2KPlapXnRjYkhbjxljAqupED2I+WFn+ThJG1qQhYWgZjkrvRqF79BYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgA/tH8fOJAo5SkcG52zN2NzIf4+m2UNmjV5YfqCDw4=;
 b=TYVB4ZM8nr5y8yb2VT07AzhDzmnw/bkBmL6CI3bH7NkfxgaGox8cUeViFdiyvwmYPDjTO7n3TcRACFzrU3ROo8buSZiMo3P2uuGZArZMfqtW7VJAeCbcsW3HPAA7smgJgPWfybEyoajGJaIxMM/BqzcHQav+CurlstZ4ZWkeSaxo/Z61f3hZ2VtEmHEtySkV2tyEllcXgz1AH2mSHIT/WFRz4B4zaG2o+NctKDRu8Wzvnwt3CwCoRp+xHuos8ze266ZhyFhFH0tWdQZz7CeTGY8H/TATzu2YccZe4MJnN7SxeZ/6vbZxoAHT181avBLfruy/6Vi8Z24+5b/I4laJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgA/tH8fOJAo5SkcG52zN2NzIf4+m2UNmjV5YfqCDw4=;
 b=S6I8xtfZY6xYAM6puDegM6ytwaF4KxS4IhHtTAZgeidD3dwFF+koPQHj2kDzMu6cvTp7qSXqxLb6Hc1HPaOxGipJkbUSqgknuZ/78iG0ZKK7H7pe5WiSO80wmgBMtomvMWvujcQMV+Ymz/MrfJsOj9g8LHSzQdBNKvouSEwPhvkNHrdEVlJHHF5s3S7S11d9ECaxx2zfCSnYVgeV58ZcXmvp0sQHMQxSCpdGvpO4ITaLSE+LDqpgOqFYGKav624HUHpFpOoOZ4Zt1bcuQNTohqt2dJBAVknv2Tt10wLe+CA4w1ukWL5uGCZmo334qleFyYJOGhNfFt7cHM+THCk9xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:34 -0500
Subject: [PATCH v9 1/7] PCI: dwc: Use resource start as iomap() input in
 dw_pcie_pme_turn_off()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pci_fixup_addr-v9-1-3c4bb506f665@nxp.com>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
In-Reply-To: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
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
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102098; l=1066;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=s6o84+rwYoULnhQEXwAB8qc9+uDgyGOz45L78dOCBOM=;
 b=0juyvV0ugVTYVd4moa9DBOmNe6YnK84+XUZleSDZWXJ8lCvCy4mVNmcb1WHfg44XwHDUyOz1a
 TpkjvkpR/bIDk8UkKWCn3tcp7gcYvufZKWTzBWmbATDQWZ63Z7eEZPt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: b3159dfc-f08c-454a-8979-08dd3fe84bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzFBYlhpT0lWWGVhb2N3SUEwU3B0RnZaNjg1WnlsaXVnSHpHUkRWT2NDdWRk?=
 =?utf-8?B?VzJwYVFGTXoyblVDMU40UWNqOE81cHVIYUVtWWhWUkpSbU94WGhmdXoybXlT?=
 =?utf-8?B?VjZ0VExkVVQvWmtHQ3Vqb0pjVG4xaUxaRnNWYzJ1dm1ZU0dkNDZXRXVQV0J6?=
 =?utf-8?B?QmF0Vk1qOWNsVDRYdHV3akRoeC9OT3NxeDNWUjZvd0tkSDlablZUY0o1Y3ll?=
 =?utf-8?B?Qjl3N1NHdmt1VnB0VEJEVDltU3piekJwb0l2QWRrOEtlVzlIQkpNangybnRW?=
 =?utf-8?B?UU5QMUVQKzBiLytVVHc5V2xxU1VVMHNPS09DY2xPYXl0dDAvUjN3aFBSdndD?=
 =?utf-8?B?cnlnYlJYTXpMM1FpeGhKSGhCOHArVWRDS1FUY2JhUVlEMkFreFViTFdNRmlR?=
 =?utf-8?B?Z2MrdElib09VS2pvUEVKT0dBZVlkOUF0cHJaVjhOa0JyTDBHbDFNT0R2L0Z1?=
 =?utf-8?B?Ni9lbEVBeE9wQ3FZVzhrcGxqWXRFR1hveEFiajM5UDkxTncwM2N6RlhWM2xC?=
 =?utf-8?B?OWI0SzdJbHp3ejNpSUdZNldrYTdrYjdFUTArdWkzK243bUdoU2p4aDJndXhR?=
 =?utf-8?B?WmtsTWU3cjd6UUlpYWRreUxoakRDZUgvNDNqNFJCQXppUGpXWWFXMkcvN041?=
 =?utf-8?B?NXplUE1manJIVkhHRVMxUERBbGlla3YxeWFzNGJoQjArZ05nNlAvK1FBVGNN?=
 =?utf-8?B?UTBDQXlqa29IVERSa0ppME9qbFVqdU5VbzFOSFNCU2k5Z1V1Zml4UzJ6SmNU?=
 =?utf-8?B?M2d1YU10NDFHd28zbmR4SkdHVktoSm96dTBicGdERnAzbjdJQU4vbDRlZDd0?=
 =?utf-8?B?cDBrYUlQMUFSZmIzWmJJWmVUZEZqVjNuVmsrRFY3UEwrNVdqQ0tkQThiZVl6?=
 =?utf-8?B?TmR2WFN3azMyRHNHbXhiaDRuamFSZXZTZTlsYkdrNmJQa2pMYUtNU2hyWER2?=
 =?utf-8?B?VXdKY3Z0eit2R0pqdnRWM0N2bU5ndndWd2pGdnI4QXRJWk8vQzZOb2lNdzUz?=
 =?utf-8?B?V0p2YkUxSUdQOUNXbGl5aHVXb2NSWm5QVVU5ZENDakZTbDltTEJwZEt6UU1X?=
 =?utf-8?B?MUFNamUvS0Q4SXAweSt1RUsrZjk4bjFXN2dYR3NLY2xwaVQ3bUpuTGNFempU?=
 =?utf-8?B?K3J5ZkVoQWw2TENwbDZCazZGVGpwOGZxaVBHNUhsaitYY0o2citrNUVtRWlD?=
 =?utf-8?B?QUsrWXBLbmFTQkhmc01DOEFUa0h1dE9LVmE4U2lxcUZDc2lkSWhJdlEzdTk4?=
 =?utf-8?B?TjRadWt0YmZWakRjY1lHNDY2UlQxS3I5dHBuUUgvd0w0VHJFbkFyWVd3dVlq?=
 =?utf-8?B?S08rWTFWZDNoUEZuQXF5cEhnbkRQbXpHZ1BkQVJvRXVGS0ZJT3YyMHExZWI0?=
 =?utf-8?B?Ykgxd0l4eUZwQnN2amt6dDVoS0YvWXdBSFZYYjBnek5ZVFVxR3NDRUdVTWJ2?=
 =?utf-8?B?QjZETnJmYWVsR1BnVzFuMHZVOU1hTDdpUU8rY0w3bXdBYjA4S3ZZK0VZLys5?=
 =?utf-8?B?MTBxRU8zTmZ4NVdnU3JhZXM0YUtuejRVcSs4UWUwVmkwRzF5dHllOGsxb0gv?=
 =?utf-8?B?R01udUZwYysvbGx3K0VuYjd4a3ZnVUx5UGZMRDZybGFxUWV5TlcyZEc2NENk?=
 =?utf-8?B?eWR1empybmpVcmQybkUxMzhZbjJ5WWZQMnNaemlhMG5vdkNvaVJUYU5lbEZP?=
 =?utf-8?B?V2R2RlZpMWZWWFlFRE9JbWUvSmVOTlJGOFZZN0NxMDNSUjFIUzdoSFhaT2RB?=
 =?utf-8?B?UTdrWW1yWkNub3VXb0M1bzJJL2xzVGJGQ093MEZqcWtKOHR2SEpId2ZucmEv?=
 =?utf-8?B?MkNGYlNlVGZrbUZvWTFXK2ZIczhPem1FbGJJSlRxajlkUzdIalpMQWtUVjdF?=
 =?utf-8?B?MjFUbzFYQVd1TThoUHo4Z1I5amNzZGRCWlNjQmNabTkxZkNHNU9Hd1FNejZv?=
 =?utf-8?B?Z2tyZU1oMFArOGxTNHVab1NQTmRqMVd2TnBFa0Y5ZzJmUW05L1hQbyt6UUtF?=
 =?utf-8?B?NXdEQ0U2ckZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anR6Wi91clJteEJycUNwUmcvcEpPUXY4NGxCSmJJV2w1VHN6ZGI4bFJ6VklK?=
 =?utf-8?B?OEtDb3E2eFBia0VyNTJMZUllanhzM1I2ckRPeDZqaHg0SUpodnNGSmdjQXRk?=
 =?utf-8?B?UmJBZ2lVVE5WYWZ3bmRnVG5STjR0cUhreU51ZGRYMHJsZjI5YzRKVjljV2tV?=
 =?utf-8?B?UVZBb0J6MEhQTll0akhYWllwSXhBN09tckgyRHQ1NW5malFVVWJodkxvZDVD?=
 =?utf-8?B?QTZNdE1iVEh0MkIvL2hLMGF1WGQ5WWpXS3JMSFVVNDFUakxBR0NFbW5oa1Ez?=
 =?utf-8?B?eC9wSllGdkVXWmUyU3lPLzdkZlhHOTkxb0g3U3lkK1BzazQyQ0pKbG9Kd1pQ?=
 =?utf-8?B?ZlZsU0dxK0IzdnRWSzdHYlptVHFRZURYK3cyRCt1ZVJONmpEdncwMVBEUm1K?=
 =?utf-8?B?VzdPUHJKQVQwM2IydVRkejRPVitUVHVVbGdKQnpkTjhOWGZ6T0pPcEkwcDR3?=
 =?utf-8?B?cGRWMVhxRC92UUVNeUQ5TFh6a3lEVEFYbjhqN0sxMmRQdWQ1QnRiZU01VWd3?=
 =?utf-8?B?QzZmbWQ5SStrTlFqblpSY2xkWmd6azBKeUhVbHpXQ05sbmg1N0dGOXdwSDN3?=
 =?utf-8?B?VW4zL1d4ZWFyb2ZmZFBocmlHdVZZUmxrTWtoVFNTNTdnbDNQczJwYUQybjFr?=
 =?utf-8?B?dkhJMlB4KzRjTUVFTERiTUxzdnRjZUw5ZDZoKzRPd3lJUm41QzdPZFVFNUQv?=
 =?utf-8?B?NzU1OEgrTFdVaE5meEZybmNucXl6dHM4L3RuU2I0eHkrRGl2d0tOTGNRK3g3?=
 =?utf-8?B?SXluaW84dHBNcDBRS0l6ZnRiaExtUjVkZkxCNCtaZVhIaHJqcm8zS1lYUUJJ?=
 =?utf-8?B?cGY2Y2dQcGJTRVF0eDVFV0ozcDg1eUpuTmZ0Vzc3SlZzK3dvS1dJbWY5cExk?=
 =?utf-8?B?amNxR2FBbnY2ZTR0bEc5SHUwbFBZWXhXclkzRzcwRkNMYm9FMkp1RjlwN1Fm?=
 =?utf-8?B?RHc4TUhzSDNyNFV6T3B6aC9MOWNCSGdydVZGVkdKNS9uMlRuMTYrRnFQRThU?=
 =?utf-8?B?eG1NanliZ3BPSHdJWW5ES3NrTTNQdDU2MUdYM2wwZXErS0psbEg0bHZOWjFE?=
 =?utf-8?B?M29LK3IzdXBDVDYzbTBjSEtiMDJFOVZQbkh2cFMxTU5hY3A2Y1VyTUJ5OEFG?=
 =?utf-8?B?MDRkL1hhV2ErNTd0TERBQThRWDZramVQYWRndEFmVVdtMnIrSWU3L1orUENs?=
 =?utf-8?B?WkdNNk5jSzRHMDRmMmp2RnBYTm9EV1NJRjd2SmU2QmlxbElZWG1aUFlnNTdS?=
 =?utf-8?B?VjI5Zzd6UDUrNFdRTGdXMWhFWGZobFQ2T0t1VGNIOXB5clh4b2JUTFpOTE82?=
 =?utf-8?B?aVFzYVJrb3BDeTlDMDBSY2xYRzVrZmQ4OEFRODgzdXJ2cmhSa0l1a2h1N1NR?=
 =?utf-8?B?UVQwTURRUjByN29jQnhIemFqQi92MUM4Znd6aG81dllHeXh5K0ZqMStqQW9R?=
 =?utf-8?B?RzZYbGd4TEQxTExhd1NzUGZkRjdHUEt5Q2VDZXU5VHVzUmdoYkpCU25XMGhI?=
 =?utf-8?B?b1RmL3ZBOWgwVGowU0daVzhwb2tPeUkrK3dCbG1PR2dlb2k5L0VMOU1LUTFl?=
 =?utf-8?B?RE5UKzcrcHR2U1FXdzdkbG4zUGNGL3hTdm5Pc1ZpNlJNcGJBQmpGZVNrelVj?=
 =?utf-8?B?MDR0MGFmeTFXeGh2MUJJOTNpOE1JZmJmaGpYTStONm5NQ1BFaEVxTjVGWXYx?=
 =?utf-8?B?LzNhN1FvTzVhV21hQjhIWmN5VFVuSXkrZmJPaXNlbTVtbEUzQStGMTdEdHk3?=
 =?utf-8?B?OW9aTjg1MWEwYlRqSWkwSGZhbEh3K3FzMlNEc2ppbW9HbVBTeXRQZFJMT24y?=
 =?utf-8?B?cXRKa0JpSkdDQzY2dE5WUGRhU0o4Z1Q3QVhCZ1Z6K2xzRTZjaVZ4MUNQU0Jr?=
 =?utf-8?B?TmhpN2lzMnBoVXJBNW9GU010a25YZFBaZU13dFYwVGhCU043SEtrZEdtejJF?=
 =?utf-8?B?Y2dtdjNEWnF6Umo5SmtFcW1Wc0VtcFJNZUx6a1VTU3JBRHlGdjFXVzFtWklt?=
 =?utf-8?B?L1hmVjFyZ0hUVjJCek16TTVaN01Jdk9XeHlwZWNraXlXQkNETVRZL2NZN0VI?=
 =?utf-8?B?TDkrL2ZIZDI2QnRwbDh5TXMyTFlyRDdKQXc0SW1HWHJNVHdyeDQ0RStQdXVY?=
 =?utf-8?Q?ojG2hYQkntADjGLuaxSD75t3f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3159dfc-f08c-454a-8979-08dd3fe84bc4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:29.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY6LnzTuURr56fCa2eDkcKim4hGtxgBWOmFvhsuAsNTQwQ2F8tHaj3/kv1FpV6pN3FdoUKmesL5oMfpcX/cNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

Pass resource start as the input argument to iomap() instead of
atu.cpu_address in dw_pcie_pme_turn_off(). While atu.cpu_address happens to
be the same here, it actually represents the parent bus address before ATU,
which may not always align with the CPU address. Using resource start
ensures correctness and clarity.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7b..ae3fd2a5dbf85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -908,7 +908,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	mem = ioremap(atu.cpu_addr, pci->region_align);
+	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
 	if (!mem)
 		return -ENOMEM;
 

-- 
2.34.1


