Return-Path: <linux-pci+bounces-14002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111989957ED
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B831C21D5A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 19:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386B215004;
	Tue,  8 Oct 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DmahCHvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48262141D3;
	Tue,  8 Oct 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417284; cv=fail; b=u5VQsDLzBJiHTIFBiYMzLWEggtWIXrvi0Ez8mJtvBomjhQvMmGaUvhVFNZAUkaClOfTt3hYSGcQ+2NWqeHLSxeymLSmPGaC9bob+htIgSlV6fMHSEC8RyJ/hyCXktkOvdTF/D7rkQIOHP09u5qjlwIv3Pre//bWDkpJ9+2Ne/U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417284; c=relaxed/simple;
	bh=0L3qEl/+gpp3mZUPcyNe82/HxmZU/2VbLozR9pKpTKU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NVmCjx0gdMO9yLv8knpOJGARp+wkkz0NxuyJBM4EvCiEVWYphT0qDIdLRUFUoNfoA0ZpUz0mkfho5nr9eR3nVmDEx5AOOs8TRKdMLLS7UON3Bx+MMtZeAxvA1MvB/K95bCmM74xEuncTNpNqgvjLyxQ+jHUnjwSRYtAQucxDd+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DmahCHvh; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF1fy1nC/nB8sVE/JSLHi3VG8sqR1fRPNRsbIDKKNPKnu8s98sgaunToCdLbMPmDu+cv335hHfOXse3Y/T7RutwAOFIUc8hn9nSy80sj8TqxOMEQypmaP2TiUbuCDRDJwgnxLmKyDf/ZCBY2FEBu03ITsWexVtM4kCxOtxoFwJmHKpF2hFutYBqCQ0Q1rNprjCz3XQvRZd5P2T2/FdOKkzTjHPaIO7eQURaarhHQPsxRJ95hIQ2Ys0d5r8HaG7ieLN75ciZWKGq2VlnQlTMSnQBmTH9j9GN/wARraygSHOARnNCucC/T0SRQa50fdPUCEsto0vaX1jKbpipSLL+c8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xjmrzgXUr8SnuZoLtkR/dSps1HgUaXdt6njq7Rjbfk=;
 b=Ffw0a3Rk8zzbct/F8/KbAAcdTeJb7L9OhUmHuwxPxie3l4dJSxNqteA9voHNIQj9wOzJymBlZmR8QqVo8Q+k24Ik8UHaiONXQvTTTBfk1eiO6Iex6TKFjkezfor4IuKSXqJAYVGF/Jhh7Yp4n0sfL2wvVzezK8Glsw+3wsXnCXTH2+lx8/PUwfYMzRcE/5lRELGTTM0HiP9dRyc8CH/0AV3L1KxuWAgoFfLGXTWN6R9pQDaj6sStdxVgoPPQ9wWBKcDEu0ty4Soum1nCg+kSwkZPDEYzLokFYzEpeeyN+sOG/7Z07djPOAINMoewXjXdJs+m/+ReRzy0m7buic0xSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xjmrzgXUr8SnuZoLtkR/dSps1HgUaXdt6njq7Rjbfk=;
 b=DmahCHvhgtb+V5Vz5hArhx0iOoSSdzT8z9cNxin07q0cX38bDCPIun3DkpkT19qMEsUYjlLpO7tPWWlAy4btQeKfT0M3EISAyZcIKmPxAWwJQoOhL1JuGtDa+g78IGk42pjL6Mr/SjP/Khp0A38cJhlW5NoxCYY3xDA3QY1LqMWhZKawMhuA2RITTQfon448mV0zQz67+5B6NtskTlzTfKdtGJ0BGgJcfhNnq+cWMbCzpCtTF+ojWHCoHVBclYPS87GW53kcAL6Uy5VID5mkvsIyLqOoFLhmtsi2/8D5zcm38GdNIkdwWkSyGtkyvWfn6pGgW+rZd1B8sdBOvWnamg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10577.eurprd04.prod.outlook.com (2603:10a6:102:493::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 19:54:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 19:54:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 08 Oct 2024 15:53:59 -0400
Subject: [PATCH v4 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-pci_fixup_addr-v4-2-25e5200657bc@nxp.com>
References: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
In-Reply-To: <20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728417259; l=6492;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0L3qEl/+gpp3mZUPcyNe82/HxmZU/2VbLozR9pKpTKU=;
 b=+c0mkhqtxDyYANK7fl7oYdK3Me3oM0gAyo894gvHfYjTl8GLgpijvOtaIRqiycPXA/sOpVG75
 9GurMMaIJn9BMlBknOqG382vuZLJmj5KStQv/+V37il1wpVVXv80ZA2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c889615-f9d1-49d9-75f6-08dce7d307f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzlRU1p5cGxHcTRZK0QxWVVWazlvRVBiK1BNN21GL051cGpNNG1pOXdxN1NY?=
 =?utf-8?B?UFU4ekhHSjJ6TnhpRkFXaDlIUDYyUitKbWc4R0NKV25WVG9UbGduMFZ5ajUx?=
 =?utf-8?B?VWM1NTA3UUpKVjVFZ0krNEhCcWxFejRtQTlQSEFDbjhrNDZyd24xSHJYRk13?=
 =?utf-8?B?U3F6MnJzbjI3N2tuNGNQdFA2S3JGcmtONkdhZUkzQy9zMjVzNlF0NWtHVE1V?=
 =?utf-8?B?VU1jeUFiQWZxbEdFVXVmQlc3V2hEaEhsTHIrNDJhOUZIQ0srVnd1cE8xdGd6?=
 =?utf-8?B?anRrZk5yVmdWa3ArcFRyMXJTekljV1l5NjduN3NueUJwUUJScVM1NG5MQXNj?=
 =?utf-8?B?U1kxYklnUVEwT1JrQlUzR0RMclh6N0VSdVFCOUpQRkRwOE1mZGxpZERjMGhY?=
 =?utf-8?B?QUN1WkNva053YS9DL3FJSzRlbHk3L2NUZ0dHRXVha28xUU5WVC9QZGJtSnBH?=
 =?utf-8?B?UnJka0k4VUhFUWRUTVNvWUpScERUWWc2WG55UmxMNEFSUUlyNENwRUFTdmJM?=
 =?utf-8?B?SW9pdFMraFpqeGV4ZmdDZTlXOHlITnNWRlllTThxQnZBNVVhczNQNTdYdFJm?=
 =?utf-8?B?OGlLUTZFQ2dTakVuT0tSR2RZTmUxajhmelVBR0laMG9aNlB6U21EZGJmWHJt?=
 =?utf-8?B?T1o1eXZNSzJ0R29DQjBQd2drazJsaURBaGlMNDY1SVIxMUdzK2xIRzFzcWow?=
 =?utf-8?B?T1U5OWtXcURPNHA4aWJpSzZsTE5KSmEvemtFUXVFellkdFlEMDdUejdsbVNu?=
 =?utf-8?B?cnJyVys2SlRTc3V1RFV5dFltZkRvUDVwRVQxalBoM2p4L1JTcDZlQ0t1SHE1?=
 =?utf-8?B?M3lRWldBQ3pzZGZSZW9qVW5oWjlkb2pOSjJXRzhtSFA4bnRscFlib2ZkVHFF?=
 =?utf-8?B?amZWMGN4elF6WlVJbG1lMUNnVlN3bFNaTDNYNy9uYXFoSlRWSTRndytxK2Fu?=
 =?utf-8?B?SFJGQklRQytwSVA3TXJ2M0I4OGZ2UUdxcjUyS0QvRWhKTHo0bFhRTDZvVXQ3?=
 =?utf-8?B?Z0ZkZWlNYlFNNWQ3aG9rYms1dlZQZ0JjQjFMeEFRUVZLbWlrS09ManJ0YkUx?=
 =?utf-8?B?eUF1Q3pYZkN4cm12Uzl4NjhPSjJ4S3JaZlRjaXA3MmZ1am0vT1AwMDltMitF?=
 =?utf-8?B?VzZodmRrblkzeExjOXJraFJmR2p4b29jd0xtbmJpTjFnaFBTa0lzREpjZys0?=
 =?utf-8?B?Q2dGcnZOdm44MkY5N2MzTE9MWjBKUDVHWHFJMmNlTlpOQ3BpSnJVOVFLWnFz?=
 =?utf-8?B?ckxLNnpKQmlZWXRoMUJvRjZ3cXluNWxxeW80QW5xYmNGZGFWV3dNQkZTejk1?=
 =?utf-8?B?NUlpQUFObXlsNHczcG5yOTU0ZGU0NDNzaTE5d3RVUU1LZis4QkNqbGYwSFNL?=
 =?utf-8?B?RnNzSHhOeUFXY2xqcVVCbnRRQ05zWXRXeDhoUm54ZGNscEtOVEZSRm1yNjlm?=
 =?utf-8?B?eUtPRytOckJOalFnRFRKOHY4bFRiMnFpdDdFc3JmOHdTcFB6NmxaeUVmRVd3?=
 =?utf-8?B?M0xKeVZvUTNOMUl1NUxOZnRld1VOZENEZXBNcEtTUmtXZmZrQkh1bTVQRXAz?=
 =?utf-8?B?K0ZvQ0VhbEY3NEdOZDlNUDdSUWZjWjhnTytvSHkvTW1uVjZPd0o2UTZQN0s0?=
 =?utf-8?B?S3RnWFRRRWZUZmJwdjY2RzFYSjBDTStqWVpGdVNlUkFLdDlJMlFrMyswZEtN?=
 =?utf-8?B?ZTB2WUVRdWVBc3BoOUNxdldmcU5jWjhtTkdseXYweUw0dmVIRGpCVFUxR2Jh?=
 =?utf-8?B?cHU2Y1YvR0M0YUVrcTVRdGUrL3VHaWVrV2F3ZTVEVmo5b3k5bmlJK01FQ2ZX?=
 =?utf-8?Q?TriFrPD9xETHl5Isz2g7t7vMuHqecfBLM+4Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0ZLTXIyNmFxT0dPVkgwTG9qS3NxaG9HTTJkWWJ3eGxSTFNZd1JTb0tLM0Qr?=
 =?utf-8?B?WjNCL2oyUzl0M2pSL1RQcnVySnhVTkRQaU9HN1I0d0RBZHhBODlwTllNUTgr?=
 =?utf-8?B?WVlxOXRuelhOekdKVVhHcmFzRy9BSlNjNUwreDFIN0NXMXVSb3d3SkVZcUpi?=
 =?utf-8?B?TFAvWGJaN2pRdGJWUnJmZERubWxuemJmaVVWd01LSjZjU0s5alZmVlJQZXF3?=
 =?utf-8?B?YXlBWFNkNzcxZWEvais1Rmh4cno4a0FkK2dtTnJyUXRlWXlud1RYWWllbXZ3?=
 =?utf-8?B?MXo5d0gvSlFuSytQUi8xeDdlbXJ5R0dvdHpIWHZEZHZuTHVSK0lwY3UzUEZN?=
 =?utf-8?B?azBsZWJJaWFMRjVNQi9KWVZmdlhMUzl1c1dTWmZrNWtGc2dmNDdjcmwzcmdP?=
 =?utf-8?B?UWJSNUxmR3loeXBpems1bEcvRFFldGtVaHphZWJTeFFlbWFyb3lPc2c1OHQ0?=
 =?utf-8?B?bVRsRUo3NFRPUDR5NTU5dDBJekx5Q2dlM3BWaE5yd29yK29jUW1GZUcxUGtE?=
 =?utf-8?B?bmZ3U21WajA2Vkozc2FQVDg3c3FoQjkwUEUvazFXc1lhdGlZdEFxcFV5bHhk?=
 =?utf-8?B?SE9CL1NCZERFUkRBVUkvVkFEZWQrN3htOWVNT3VISUVDMUZMaGkrRXMvaHdx?=
 =?utf-8?B?MCtUVjB3ZVNEcEp1cG9OUmwvdmZJNjk5MHY1RTlkUWVZYndhWWFYaWdycTJk?=
 =?utf-8?B?TXppY2h6UGlzc2JyNWUyYmVJS052N2V3dUhSNE1EeC9RUU9xSkxlNk40UXhw?=
 =?utf-8?B?UWRRR1E5cXU0WUxhSzB2ZFcvOG1lVXZSNkR3TXpMeHE3YXQ2ck1tK0tUL1N3?=
 =?utf-8?B?dU03OWFtQU53dHBBQ1F2VHNMejIvaFpUVEJWQU5vRVFET2tkVDR1NytaTjBq?=
 =?utf-8?B?V3M5MGVGK2xETWFyUWJ1ZE9NenE1ZmxUem04djRJd3lWdjc2NkJXcTdhcjl3?=
 =?utf-8?B?TzBlREMzc05OV3RucGJmR3Z6Rnl1OWJnOG1ybzUycXczQ2Q3bmFtTU90NGN3?=
 =?utf-8?B?U2hoZDRqamJNcXRORnhuY0dtemsxa2JYcU1teFh1TG9Yd01KZjR5T1lxektZ?=
 =?utf-8?B?cmJtelRxVXR3aXVWeGRpQ1NhK2hydmowZnlWeXcraVkySU04WDlmKzdEbVJu?=
 =?utf-8?B?L2xZZHhCSFlKN2YwVE1uM1JrYXVkSkRUMDhibGdST3MxZVIzWlZTcVpOWHRq?=
 =?utf-8?B?cHhMTjhGa1N2YzR6NXJaVVlPbFdFbnB3bG1BU3BkcGZKdlZvdzdlV1hjeG5E?=
 =?utf-8?B?V0JaM0VSUjM5Q2FWMFdVVGx4NHNLNDF1bGhCNERjSGI1YUNKaTZLWEdKdE15?=
 =?utf-8?B?bkFteTBnZ3NDUHE1cEQrV0pCWmFOQm9qcW5rUExTQlMzZzBpcG81RHB1dDA4?=
 =?utf-8?B?b0VPK0ptR2JaUW80WGg4SGowT1ozUDZ2OW9OeGxIV1p3NXJod3JzWjlIYmlX?=
 =?utf-8?B?aDdZakpqMC8ranY0a04rVUVvOVR1U2F6aTRSL3l2WlFObDhwTGRxbk96WExY?=
 =?utf-8?B?NS9uOGprbk5uQkFWWm52bDM0eHY3b09hdWxPWllGNy93bitpb0JwbE82elBD?=
 =?utf-8?B?WTBydDZoQmNGMVhrVlQvajUyTHZJQ1lPZFlvdVZJUDRNUTlFSGFQb3VRTUI1?=
 =?utf-8?B?ZXFTNDc2Y21RU3FRTjBObjJQZDVlTWUxbll2TEtqbVpqVWxBL2pGWUZqWkVH?=
 =?utf-8?B?V1A2YjEwbDk5bDdFRkdSL1pBZDZVYmR3Unc3TzU0NFdzUE9nNGZvanhsTmZJ?=
 =?utf-8?B?WC81TTBPemhveEdDUUNLTUNLb3IvaFo3WXpEdTFORWtBeWh4V3RGOTQzVm5V?=
 =?utf-8?B?OUV0dXgwZEZjNzNFbTQzTFJ5R1AwSVRHL2JKSHRIbElBaXZHZjNzajBFZzlN?=
 =?utf-8?B?WG1uVWF4U0NmalBMYlRVK005Tko4NThrWHlSUmhBeFJVOXlpdExEbFNqOVJT?=
 =?utf-8?B?bE9uUjRDYmpqN3VGV21MeS9RbkxLYmhrOXUreHhCRWNQSnF5QnZOcGRTMGNN?=
 =?utf-8?B?aWh1ODZxVU1paXZBRjB6NWhuWWdRbUJTOEZKZ29Ec3kvUW5OQitGMWhsNndF?=
 =?utf-8?B?K1dkQTlNdUt3bHdoTytKVlc2Z0YwbHpVVCtyM1hvTitkKytITHFjWXFHZ0J4?=
 =?utf-8?Q?EE5M7OX0u3Q4NEbQ0n40b3XTk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c889615-f9d1-49d9-75f6-08dce7d307f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:54:34.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnHuMhiainRCtcHtCZtm8JgbC0hH2mKqjnASiKuwO0aDMoxR/ixYwllynxCi5IXocCAf+X1OsYaoG7MJ1/CKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10577

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
Change from v3 to v4
- none

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


