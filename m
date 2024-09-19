Return-Path: <linux-pci+bounces-13306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C653C97CF20
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EC8B23C51
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C77C1B3F38;
	Thu, 19 Sep 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hq+5r6xZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345121B3F27;
	Thu, 19 Sep 2024 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783463; cv=fail; b=Tf+OJbcy3nLdMr5/OXUyFq5yeE/ivZpDE1Ys6PWgpAA5ieBYxsuD6S/48yXmJEM9H39vtO0sB+spBxwmu+ihXMiFV0i+ZdOQ/XnQNQWi3BIl0hhcZ9qExq6xYpei3/9cUYHhgWiICwpWgJhf8kGycmZtWKjm5Ca5Hz6kDdeQHVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783463; c=relaxed/simple;
	bh=AJPStt4WswboRKarhA2+QgaL5U1YDLWo9KX39o8OVcI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YpuwMO1OGps/Yu2jxENvpGwbXjfEDjl3TTAgatc79d1hD+LcY0HLLYjDDD81wCxoiEv93mA14y9EiP0zvwhtuGxE7ZGgP+HhX/qqu6wCojtne4neY/2yMtf2ddMI/1dJxKHsLFK65aiMNI9JkSnTrIk7dpxFcgJFam7yTA+tUBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hq+5r6xZ; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh2z6hkAsHDjMjJyPML9691Xx7oJvqpYgb54PBBp6ZrIr/Baa/lU1SSzzx9SZ7MXyseXqYZZVnbStAwLMfnkp7KYIJrTxYF9tKZLg06PXGDfeN3HbA8VyhsTYdbg2qIPQ+w66yi7NE6SAF1E0HRYtqtcjuE5Y2+8LrYHOLJwiHo5X2Vg7NeWnsAogwWZyz+c6ngMoGPt6rwGHns3Yo3p/GyrfiWaM17gIBwNvXGUAXCHe9ItQp/X+NnCmr7wHjml55N1Nb3O6lQdgVoNlmg1IZnjJxYsssOAnczzMMeqqClHyDJHfkj+ZL29pfMB+3md42jFnHjt53OZNPSzU6bFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdkYMfy9kpiMcfKu4+dscn4KqVI80K4mSkMR/TqkLms=;
 b=Fm2+dNgowMbQ0C1Bj/M3g3sWAjIVNaOUcZ9RxLIrlN7nOSCN2PQKY9mg1lnPPi3JRNmRNRH8nCJIGLnJ0TUB40BRiMHyuvNtoXaKVNaILror0c9th4GZrtBOYFyoYVxdAC/htl4QXKV2vuGUt8YQ/NEJkqRRshP0Dmgg/urhhAmaiT7612y9/raoadEtxljr2P34/66d8XU9iYmq6UvI8JTHNzFZj676s3CsTLJ7QE+216ISTOxppqB+0le3xT5UMZeHEAy2AuByyoxZsRqwv1ju+kDFM9/nu9/7dVQ+xnjS43dQOY/tYzk8aA39cpBOLBWbaM7C7GdBiFs7PGYatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdkYMfy9kpiMcfKu4+dscn4KqVI80K4mSkMR/TqkLms=;
 b=Hq+5r6xZlW2YgjOejFEcslW67doT/g/QhO65/6o8PfrA7ENZ1oec3SpT1G+vVIWDq9dauPFsHqIhnEG3B1/a0r7l9l4lg/w/W8ssYilr+yKv9TrbnaQXj77UNUK9nhQDG+vF0v/wZkQEErfv+WLKpR5VwQFuaOIn3s6QXIereBRNlgZQQAB3htxMF1PgrgrCPkFtwzfSwEPcshQPzQa7yVyBEIqRuj0TfrU47OIw5FRBHUV5tDoizOO8nlD0tLNe80Ibi3Iu+HMxbjCRwkg+IBteGXjvbEeiYa2XAc6Nly8yUgYnwnAJ0GkLXfYhhOhfCHrHVqLKox/cDS8M5hTRsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:04:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:04:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:07 -0400
Subject: [PATCH 7/9] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-7-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=2191;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AJPStt4WswboRKarhA2+QgaL5U1YDLWo9KX39o8OVcI=;
 b=loK9f2CH7KtQ6aDZA7wDfMhvP1co0M14BzW9AcFyLBvVK40/C7OSN6A5Ho1RFXfvaE9UvQKUp
 HTi9Fr6g1dpAC6TcSSAESQsw+DtBRqnOZxeARbuy4jJ7fX2YeGb/dLy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 80558c30-f353-4cc7-96a8-08dcd8f70218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3gyTyszTzZjQlFsM09FZ0c4Q2V2a1NDbG1HUmd5YnRpL3VwdVZaWTNjK1Bw?=
 =?utf-8?B?eDg1b3diVWZGTlFKdmE3dzBPSmpCK1hJYWMxUHNOT09EZ3pJRjVWVkpidUlW?=
 =?utf-8?B?dWw1b1E1RGdpamJyeFJaQVFjSG9LOStnRnhGU2U3aHhIN0ZVWWNPR1pHV20x?=
 =?utf-8?B?WEFiOGcwdDdtNE9aZG1RN1c4NU1DSmp4YzMrNkRCb2k1VmM3MVJLN2J2cFVq?=
 =?utf-8?B?c3k2cGcyOFdzdkgzYnBXRnl4cWVJTkNtSXRqbUcwejE5YUl6Vjk1NG45Yjg3?=
 =?utf-8?B?elpJM28vOEM0NkI5bEU4NmlGVFBNczhWMTZxWHBVV2JJVU8xS1hVbm5SUUs0?=
 =?utf-8?B?QlFrTUVrVmtvOWFSZjVBcTZYYVd5MzRlZjNmeEYzbkVLOFlNaDdmd3RBMEQ3?=
 =?utf-8?B?V2R1WDdidTBKUmZJZ3dUNE50bWlBakNxUTZsMzBDK09xdXN5VHFOYVplWHBK?=
 =?utf-8?B?bEdzdmIxTG5oeDI1NGJGRnhHcW1KbW1qZW43ZzFVZGkwWi9YMjhRSldvVm9K?=
 =?utf-8?B?MEU3OGMwMEp1a1pWVEFtREdxeFR3OXl5akY2U1pIWCs1VnFqUndBcnBVSGQ2?=
 =?utf-8?B?THJkSVhaQlYzTHYvdThybjQvZXplT3RqRWI1Zmx2Z0VwZEJ3bWh4VGlHOUND?=
 =?utf-8?B?eGNXOC9aL2JiSmUxOWw1aUVnSEtFZTRyVHozK0dDV3N5SDJKckVvQ1NmL1Vw?=
 =?utf-8?B?em8xek9UallDcENXUWREWHVZd0tta3k4SWFFNWlXYjRPVUlmODNaaFkzWjdK?=
 =?utf-8?B?K1JXMDJLQXM5elVCdDdVL2pRNkJPUUFTdzQvc1NqYnNJcndlQldNbkl0aTNG?=
 =?utf-8?B?N0xJbkVjNTdIY3ZxNlp4STFlQWZwT0UvN1czR0NCQVRiRmhwaVVock8vU0RO?=
 =?utf-8?B?TEtsSlpPcU1RVFliL3MxLzhmSTEzdXZFWndXYy8vSUZmcHRMK3cyMFBKQnNE?=
 =?utf-8?B?dHZxdEFOWmZDTUZKbldVcTVoTnR4aXE5ZElmUUs4V0p4OEx4WEE4Q3BTMGE1?=
 =?utf-8?B?dGRDd3JTSmMxSzcxTmVtUFhMMHhSbjZUdHpyZnFHQjRBU05mMHR2VmdNejFL?=
 =?utf-8?B?dmR2Q2ZMOFpiMkFlK0FIRjN3RG1KdVJBSkNSL200azhacEtKTkRlMXBuOTdm?=
 =?utf-8?B?bkcxb01kYnoxNUtubnZESXY0L1grbUFEU1VQdUFNMFVyKzlmYVFkR1FJam9O?=
 =?utf-8?B?b1E1NGVzNGJ2UjBqMUJMU1haWCt1ZmtaQys4amU3MDE4cWNLdDdVQXVFcGhG?=
 =?utf-8?B?RjFwOWtPWWhzakFhY043S3k0TWoweTd1MGlONk5MRHE3U2VxUU4xbmtvSWRa?=
 =?utf-8?B?TUVHMjZpR1o5WGlmbjhocWtqVzBkMXIwU1JTRWVGM3pneVhSdjU0dWpva3Ns?=
 =?utf-8?B?bkttVmxFWEVYdE4veU1UMGZyYnVCaW55VDlocTFLTUhYRjZYcS9Rd3ZTdlo4?=
 =?utf-8?B?S2psdUIxNUZHaUVNeDJJV2pIeGZ4cS9tNEZlSFl3TnlyRVArSWxDbUlHTHR0?=
 =?utf-8?B?L05NQW5VK3RYZmp2WG9PNVhyU0ZYOGt3SC83WG1ZTjJHMU91YkN5aUlva1ll?=
 =?utf-8?B?N25yNWhlZmxEaXRBQlJMRmg1N241R0JSRXR3b3RNazVBV2hoNkpwa2R0YWp0?=
 =?utf-8?B?ZzlHR0FuVnRzYnJMWUNxekRYQUNGZnlUNGRMTkxxSnQzNmVEVGVDNzExQWVM?=
 =?utf-8?B?SDJVbVJac3hGZGFhZ1ZPTjk0ay9NcTRDTnUzNGhpWHI4NGkyYzFpR3p3Skgz?=
 =?utf-8?B?UVR6K2owd29NVFR3ZU5xbUR5Q3NLTVowc2huN2FDeCtuZE9EN2ZKOERrUUIv?=
 =?utf-8?B?aEVFUjMvLzFXYkVNdm9OOTB3YTZHWHY2SGwyT3pkOWNiaWdBVjE0cDdoUk9h?=
 =?utf-8?B?aXlPRUhrU1NNYjVjVUtCWnd3dHNXdnQ0K0VvcVo2WSt2UXJZeisvNGxrbjd6?=
 =?utf-8?Q?mgOoo5PTiMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlIxS2xINkJBbWtyT0QyWFhTcFFVTG90eHFVek4wdkoyc1V4QlVsYkxMRzFR?=
 =?utf-8?B?cUZzRVNZbjJERTJCeFJjcUNzUmM2WWlnSWw0clNZb1k0eG5uQ2ZhczJqcWpm?=
 =?utf-8?B?cW5oRUZLS2JxK01pcE85dkFySGlaTFRHcnZ6K0ViRFpydkticUs0VmV1MmFy?=
 =?utf-8?B?OS96djRreVZXRC9HSXpYOE9CYWdpM2F3YzdrdXFGUW92RE52SmpReTJuOFN6?=
 =?utf-8?B?UE1ldFRJQWpjTHdMQWY1M1d4bXNTTEZGKzk4c0R1OG4yTzRCK2k5SEVoQllC?=
 =?utf-8?B?ZmRiOFg0eE41NUxldWRlZXVkWlBZUU1tN0lveW51YWJTOWJla3BJY25wMXZ3?=
 =?utf-8?B?WmpuVUY2b0FlejNVR213UkhWMmVvYnBBZDlLV3dEYWRMTzlJZC82YnRiRGpo?=
 =?utf-8?B?M3djczBWOXlyNndUVDMwVXBONDRVd3FDbWgzZUtDajFzVWY5NWtLbS92TXBo?=
 =?utf-8?B?S1V3THFuTkd3YkZ6L3YydWRnbmNIUnpzVk5JNEt1YURqWDV0eUxHOWRMeVda?=
 =?utf-8?B?ZDl2NG41NW1GOWFzaW5vNHUrQkZsMGtHQXNBeS9aYkhQcUczNUMwMSs0MDJv?=
 =?utf-8?B?QkZYbnhBVm9ZYldXY1VSZmp5UlRQMmVLMExBSkppSzBGaHVHMEMrRXlKRlp5?=
 =?utf-8?B?YnByK3ZSOVVSNWJ5TTF4cUY2d1pGcmFvcUlNNTNWNjgrSDc3elpoUnRtaElj?=
 =?utf-8?B?OXhTejRoZVZ4NlU0Tkhra0g3MXBkR1p1ZFRWRjJOaEgrTk5sby9NWDE5bDhL?=
 =?utf-8?B?TjZDMUZtTTBBa3l5S3pzZks4Y21UYkgvdXZIYkZhTGR2d2tpRkxJaGhxS3d6?=
 =?utf-8?B?ay8ydFdGaWtVZ0ZwNGFCVXJ6QWhidlFqUTllUnJtbWNGTy9qNjFRMUQ2dm9w?=
 =?utf-8?B?S3ZUY295TWxPamFzejc5di9nL1FrWkVqa2FqNWZGQS9Jb0tnODRxeXBkTFdJ?=
 =?utf-8?B?NjZxbUFxdE5QZnRTQ3pLUnZkZkhQMXV3d293OElYTEhsOFZ6VmhEd0dQNHpu?=
 =?utf-8?B?elZ6UzV3U2VJUUpzSk9xTzJQM0xlWm5ZTG05YStKekZ3Um9vaS9wcDAvKzdn?=
 =?utf-8?B?ZEZObllYRHZ6Ykt4Uml0bVExcXphdE5tY2pVTFV5azlDeGFsem5ZaG1XUW9L?=
 =?utf-8?B?SEZaZ0Y5YnRWR3dmNUdhSHc2TGpyU0FINlByZm1va1BKa3hDTFFoV0tDLzhV?=
 =?utf-8?B?VStFeU9kSVlHM3FZT3RkK0Zsa3VNdFhxOW42VVhnazhKVnBZeVdvQXBUc0J6?=
 =?utf-8?B?WUZmZnA3b1dwMENlSnQzZmZUVEtHdmFhTHlidG1hbnFZTlRBcm9lUjN1Qysz?=
 =?utf-8?B?bUwxay9ncnFwMDJCSlRyaHdoTWl3b0d4ZjIvZFpmZm5sK3NoZVRXcXI0d2pG?=
 =?utf-8?B?Qzh5Z1VPeERUOW5MdVA5b2N1by9DUGdFSnloYkowVWthbE5RTUFFYWFCZTVj?=
 =?utf-8?B?T01hUGNWa2Zza0VZRlhzc1lJSXNVSmlSWTU4SVN5V291M2NTbGJEWFNIR1My?=
 =?utf-8?B?a3dBako3bmc4bER2MmxudG1lRE1yR1MrN1AvaVBTTkpnQzBhbDlsVWVDaCtE?=
 =?utf-8?B?czVDRit3WXRTVGd3SVRMSUFDV0dsOG5sL0tWbjFZUFJRNjBZSEsydDhUSTAw?=
 =?utf-8?B?MEV6Uy8wajIwbi9FRjZabzg2ZG53VzFocGFoSUFIOFNqbDMzZnJoNW9hY3Zj?=
 =?utf-8?B?azdFZlhNKzUyUk1nWGpvM0drM1g4Mnl5VlBmSWYwYTdMaEEzWmpuL0FCRXNi?=
 =?utf-8?B?UFpENWRwUlpReEVsZFlaMzFnc0E1S2NIY2JQb1hWR2tpczNoODFwcGdoODIz?=
 =?utf-8?B?aDJKdThUWVJPclU3djhwK0wvSEpIM09CUlFlSk81T2JHNFhRbWRjRGtZdlkz?=
 =?utf-8?B?Ky9GWjJ4R2dmSzI2MmVsSjBKU3NhaExNVHYyRW5EV0RNbk1CWExxVjNNVEp5?=
 =?utf-8?B?ZkRVc2NKai91V0FJby9lckpJTjgvanI5MnEzQm16SERCNGJPTFVoanU3ZUF2?=
 =?utf-8?B?UXNOc3k0a2dPZ3ZTc1pBYkRFMFRENVkrVDdWOFhvQ2hlT3lNWWZjMzVzd0VC?=
 =?utf-8?B?ZGk5cVR0eXByN2JuOHl1b2lLSlZ1cWJtQmRZVWZocERSdzBYc3ltSGJybTBG?=
 =?utf-8?Q?Fz3WPeEE2O7nf1Ir5+UT2bz9Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80558c30-f353-4cc7-96a8-08dcd8f70218
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:04:18.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKTZQDVc/CQ7AbIeHAjR1l5ZQ5v/SCCivUh/Ch2Ae2Q0T68rwZ1DCrIFA/3fmovJ5oOaqV7KdF29/UpFkSwVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. Mark 'ranges'
property as required because CPU address is difference PCI address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..6f6eb1dfff40a 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -45,6 +46,9 @@ properties:
     items:
       - const: dma
 
+  ranges:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -74,6 +78,21 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: dbi
+      required:
+        - ranges
+
   - if:
       properties:
         compatible:
@@ -109,7 +128,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +145,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


