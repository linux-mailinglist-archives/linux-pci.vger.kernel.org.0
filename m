Return-Path: <linux-pci+bounces-24695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70AA70A55
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500BF1897D45
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CF1F3FC2;
	Tue, 25 Mar 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lJ8Cdhvs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF81F4160;
	Tue, 25 Mar 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930578; cv=fail; b=FfqTfsxQTF6Y7Wm7jWIw/0ae3hj5p6SsWlnmEUJqPrU/wPV2FSvFqxlzKsn6AlxhRWL0SVIN0uBDPJv8GyLD+xvYJoI9CPv4T1f7zc2E0HtaY8GusShfiwGYLnOue7lUZhZlqkAihPH6YcfZrCaYHJp8Uw++yR7ma8PKxVT4Q+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930578; c=relaxed/simple;
	bh=X/3oPkGBdGN2vAsBcfji7SFKvVVqYcJKKFptSqHH8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IpOlbx+yuj6ohI+Kop76DLBx//2R+NhlpkryM8FIsSOxfuImf/eSRHrduvHOB4V9v+56ITIuCnuObJrGdi+FtYH1Wdbzl6jSo1cr86T+SewtHhthuFyo8fnsItEE4LvM06Ljd20sA5Oyy1UdiCJLvWtwWr2hQyiHB8tLejN0ytw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lJ8Cdhvs; arc=fail smtp.client-ip=40.107.104.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM3JuobpJLk1PfR3uU8dXQhBJMbnZYi+ph7wdykKz1W1P/6pEdrSGVyCcwDtIDaBohHT1J0KJaFDfQdEMLN7RMU6W/NKH6Vs1FCAdWqBL98cLk8uisGaHY7Nmpi1bOyVgZ+INyp0a2jzzaz/Wh2Wbh9Frv0llyqsAPzR/FRRprAylpJlDFSQO4oEVvK+uIiY8s6/EKHhE1PxjX2mLag62CX1xyFfozXw+NCGFfMn0ouUrsb/7G7lRGQeX5O1YihSrRhxxeVInm6e4NOpeUaGRZhq+dfNOygm1MvXQ3maDfI4Uy49knrCzKQhhAV8asYDsbmKvM1LPnOoPLGG0CuJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqzpiXdE2Lko2EcIAlLoWa+qbGQoQGjdYD1W2pt4Gis=;
 b=Ax/ZBB3bC3hHVGMVgJER3BvP9AN+SS6rYElcGe4CG2hou1LX5kaCEMm+ztQdWaSS3g4aU0pblqG3yOIMz0in6wTfjPW11GSiwy9coGj2A2U2Qxxfpp4kDLKdTLGtA1f8nweA44xI6daoOkt10uEHakesQD0bZdRvNCVkQ1wn9u7NU0sOGTbzzEBHiWd8njGvgjONepAXbOGfn4a01ZWBeiQ1NFQGEZBypGW1MED2nJf8iF3kp4DfZRlcIWgrmCg4sHsxwVWErvvyojTvkJwjgxePrqiUTvgz9FrdBT/jjAH2NqtbYjU9u2exba8FGnE3GvM9STUe4kDiU0aZsR0vDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqzpiXdE2Lko2EcIAlLoWa+qbGQoQGjdYD1W2pt4Gis=;
 b=lJ8CdhvsB4FcNb7XFHO6IcN+4Bl+vo2V5OYJ5n7zwnZa9/MwFRUArmwIWwXjleNwIIr637GLu/I2v5Mj2OTch7t/5IRrN/Nqf/U7cgPinGIqnnCcutmnUlSFv9UK49qCKgyd5CeoadqImV8HxWSBauKL8umpcsbu8Pl6srWDrldq40zXyyBtHTKXuDYIw2Ov1/ZQ0OvT4hFRe5pL21O8lITaCoY/HcL+iQ6TB+Ne2dFH2n6KIHsw/TqNZm7NPBf+FxgHzdNsC0R2YuZ7IJC3SBV59voIX1jQ9I1lqfk66vgRpf9fr3G5m9TOhwwY8JM56fxZbpiO3RkqxstKA1FpaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:22:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:22:53 +0000
Date: Tue, 25 Mar 2025 15:22:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 05/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
Message-ID: <Z+MChacLT8iehI5p@lizhi-Precision-Tower-5810>
References: <j3qw4zmopulpn3iqq5wsjt6dbs4z3micoeoxkw3354txkx22ml@67ip5sfo6wwd>
 <20250324182827.GA1257218@bhelgaas>
 <5hkzuqptaor4v5fc7ljxb36zdipeg67lsjfkcah5fkxfyyjt6e@oknqdtbwjitj>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5hkzuqptaor4v5fc7ljxb36zdipeg67lsjfkcah5fkxfyyjt6e@oknqdtbwjitj>
X-ClientProxiedBy: PH8PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: eee305d4-f8c5-4748-3a50-08dd6bd270aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJ4REhQWVl4MTc1KzA1STQ1ZTRqZzVwNVNBem9PZWFNUVIwNFg5aXZXZmFx?=
 =?utf-8?B?UEt4Q25ETWNYQUZCVUpORkFZQ3lyb1h6MUhsenFqeGRJd1NKSWwwdWNFODhw?=
 =?utf-8?B?WHhheEFUOUhMUkJIa3dSLzRDMU5TclRpNldMWjJaNGRHQ1l5MGUwZE5Cdlc0?=
 =?utf-8?B?TUhtNzJHNmxtaXdadWw2MFJEMG5jcXVnSlEwYWhpY2J2UmlqU1FkQ0RPV3VB?=
 =?utf-8?B?S0c2bXJBTGVJMFdVMXZOTCtZUlJaZUhSbjZkb3V0b2dzMzNQeVRZWUlyK0I4?=
 =?utf-8?B?OHlKbHJZbUQyU0w1bE9ZdFBacXQ0b0k3eWNKT1BoSmVlTytvREc2bzBtdFFB?=
 =?utf-8?B?OVBWSHQ3d3JMcWcxV1JTQWEzTDhPN0VpZVQxWW1PVmNUWDI4RU1seGhidG9B?=
 =?utf-8?B?NnIwQmM2RGNXYnVxUGI5VFFET0pJS1RkNi9mK2E3a2NRdG5WQVhUcGtDNkxj?=
 =?utf-8?B?eXd4Q25NRWh5Y2hyQS80VHYveFAxakc0V0M2OVpVd0xEVW1kMEZKa1VGaEQ5?=
 =?utf-8?B?MVJVbnY0NXhGRXU1WVppejAyOXlXNHdheUJqeDlZL1pCazY4ZytSUTRnV0Zm?=
 =?utf-8?B?dm5aOW5vUGFqaHF0Vm5ocUVld2VxdU4yWVJ0aUdFQlJ2TEFYeTJFaHd4WU4r?=
 =?utf-8?B?YjRvY1V3dVcxMjNOeEJIb0hJUU5NVjlzWUNIMG0zMjFtckVFTE5rYzkzOHQr?=
 =?utf-8?B?S2JQR0JSckhyRytXK3JjdS9XRmh6RGcrR0pKSmxzNCtCbFZ6VG1zNWFaVTEv?=
 =?utf-8?B?bUpFNk1wMlN1bmduVGQvTmpIKzl0T29Ecm1EZDFTTUxBc0RmZXZrUE9OT2N2?=
 =?utf-8?B?NDdRSWZrTlpDQVB6VDRQeHpnUTVNTC9KYWlZc1ZSU0s5NXpwQno3ZEI5c0JD?=
 =?utf-8?B?WkNCZVJlMWJKRWUrM3lrTnR1MTMrdmd0V1Z1Z25HZlJ5S2E5RWlJMCtKVyth?=
 =?utf-8?B?RHE1S0dCdkVRWnN6N21KMWJQRWh2QU1jUERGZDhaakFJd1F1VCtzMklYSmpQ?=
 =?utf-8?B?Mzg1bDVkVWJOVU1Cbi9IM3hJbGY5L3hkS2VCcE03ckNRODI3aE1helh5R1dn?=
 =?utf-8?B?bUhWZWZzTGIzVTVCVkxkTWEvRlNTbGJBbEhqcFd3SElESi9xUEZzQktzbmxj?=
 =?utf-8?B?RGFqbGxBYkxGUTJqMTVsWENoeFk0N3BpbjhuRzdCOXRUT0hGRXh0cHk0ZzRr?=
 =?utf-8?B?RVZMZkxxTmlHWnB5KzRFdHlUOXk1UTY5N1o1TGgyVWJsRkJzMmlvNkxqVVF1?=
 =?utf-8?B?YVFCdzQxMWlPTFNnSnFmMXI2N0g5SGJGK0pwaGQ2QkxtWWk5cnNIcEs2WC9w?=
 =?utf-8?B?ekFmZE4vUnoreWxydU51ZkRlOHZNV215MUk5V1VRSE80WlVRYUJNcEdYbmhh?=
 =?utf-8?B?K0dCWHJYc283MmgvOWtSMDBGZDFaNlZKbTJVSVFJdmhaZXV0ZDczSWVvSGhm?=
 =?utf-8?B?RnU4NWZqMkQvUmxtYVhGNDJwSWVxZWtkVFloTnRRWUtINWVHOVhESlZlYnI2?=
 =?utf-8?B?OFduU1RNSDJxdTE5NnlXd01QZFRqWW5taEUzWDZmZXBoOGVqbE9INk84WXVO?=
 =?utf-8?B?SE1pdXY0WkpBQ0tid1NWWTVwWnFKVWg0RHRTOE5ZQmJ4d2ZxR3Faai83MFZy?=
 =?utf-8?B?NW9oOWhxcTFXM3ZIUC9lMmR1RVo1dy91eitmM2ZpSEZEcVExNFVNei8vY3oy?=
 =?utf-8?B?NndHQWl6UW1NU1N0elJyd2tFeVlGOWRkTi83UjZoTVIrTHBNemthb2wzM0NI?=
 =?utf-8?B?MytDeTc2TjUrVHgyMkgvQ3hWcXlwSXpoTGc1R0FabkpmNEpNY0c5MHV0d2RB?=
 =?utf-8?B?Nk82ZGEzNlUvYkFFVUtjM2FYRG1Ua3Z2aHFUTGd6ZzAxNXB6RGIwK3VjeUEr?=
 =?utf-8?B?ZEhodTREOHR6QWJPKzZlWWFqbE0xL0Q5YVRzc2I1enA3YTA1RUYyR2tvbTFj?=
 =?utf-8?Q?t74CDYyw0q0b4XVY8oGd0/M09dGHwrOu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdReUFGS3g4NWNQcm1iL2NLd08rYS9LMWd6RUNWcUd1K2l0YUNyRlV1RElC?=
 =?utf-8?B?cURCNjBRbzhUTFRDeU1XUEk0QUl2QzJzRTJ2TGF5TnBYRFEyMVV0VlZLbklv?=
 =?utf-8?B?Q1VXSmc3bEtieTZ0MnhhblVkbUpRbVlIQmQ0SEI5ejcvTytoQ1ZpM3FmV0FZ?=
 =?utf-8?B?bU1iejN0SWJlVXJNdHZrNWJTQnQ3eTFqTWpWY0NLTmdmTEVkZUF2SUYrb3lX?=
 =?utf-8?B?c1lvaTdGczd0RE9YcVF4RWZRZ20wRFFjZnJHbXJ0anJHYU16MzNzVUV6cVlW?=
 =?utf-8?B?K3lLR2tFMVpHZ1NZVHZCNTNxaG1pK1ZjZkRMbDBCNDYvY1J2UlkyUGRYcGRr?=
 =?utf-8?B?blZmaGtZQStaM2pKRG9sc0ZFK0hxakxMSEpSd2pzNXMrRVVDUW1xdVp2UDRz?=
 =?utf-8?B?TldSNytoN2gxbTFLL0tTRGYyMzV4RzNnOEs4bitSeVlHSk5qYnBWa0NBUHVG?=
 =?utf-8?B?MVlaWG1TNFdxR0JoQnhOZ2dQTCsyRHQ2VXUvdzhJbU5TcFkza0F4K1VKbUpa?=
 =?utf-8?B?WVl4aVl4SjIvYy85QUpOeTh6dXN2UlpHbEN0MjJNdzMyZFhnOGZFeHE1TldP?=
 =?utf-8?B?c0Uzb1dJK1JCWm0vSy9uSGdCVFR0eW1PeFZlWjEwQ3V0dEg3Q2JSa2ZIeHNV?=
 =?utf-8?B?ck5aajlLQWhMWGU5OGFLb0lOQlAxVDMvc2VoM29mNzA2NUkxL1FRNytEQlpO?=
 =?utf-8?B?dnZoL1I3cFdQTTlsMVljMkJzM3NvUzJONE55aWpjSm9PNXR1a3I3TXdiRVgz?=
 =?utf-8?B?ZDZhcWhPYnFQN2xsSUNWVTQ5SEZmRjQ1T2Voc3ZseHlFYWs0NFVVcm03U0Rv?=
 =?utf-8?B?ZXkzYkEzTG12L0ZLUHN5azY5NFh6UzAxWjdIZTVrNThyQlcrYnlub0grbkZw?=
 =?utf-8?B?MmNZYStDNGdHN05Fb2MzQ2hhSFlUQlpQL2NUNWdZWE5xYlNUVlhtWEpubUh6?=
 =?utf-8?B?Wnh5dEhOcnE1cVp3RTB6WmhIRTVTc1g0RjgxODVJWCtKRllNQmxsaUxQMWFw?=
 =?utf-8?B?MTdSMWkxRzBTTTFUeFpTV3htdXZNTHMyY3E5ZldXSXVWOXAwYjRyVDVzY2tl?=
 =?utf-8?B?czFNNGREWjQ0TXF1WEZ4Sk5KSUgzK2FmZk4rQjJIQ3JiRVQvREhkM0dIL09l?=
 =?utf-8?B?S2htQ0xRYk9yOHdMMThrWWp1TzRjVllNcWpNb3UwTkdzb1hTZkU3SWs2cmIy?=
 =?utf-8?B?MUdGSTdUY1A4bXdFT1dTWFo1VVBuWDhBKzM1VXk1RkpQVmUyaDBqUUk2b2I3?=
 =?utf-8?B?NStIWDQ0YndoZTRtNTR5QzRBQk13a1JRcWNSTnorRU1MdWR5V2V0Rk1zUk54?=
 =?utf-8?B?VndzTzIzaVZSTWVLWVk1ckhqOEpPbVF0MUV4SnR1UlFoQk1tcjhOenY3cDRv?=
 =?utf-8?B?RWJCd1RaN0VrRWxDVm5kMC8xWjJrZ2hPSVVYQUQ2V0dxSkp2NnQzQVV0a2tM?=
 =?utf-8?B?MHNDL1hHZGg4eU85ZmJXeUdPcng1eWJ0OXp0UlF6SFA1Y1YweUxPcUtVRnBq?=
 =?utf-8?B?cUUzVENlVStPOTVUQ3Z3STdYWjRibEp6cXVjMlh6KzBZV1VMLy9uRkNSZjR6?=
 =?utf-8?B?NDl1djYyOEZDMVNXM2k0cFpBY2JoZ2lUaW9JRGVLNDVjT1Z0YU1WdUE5bmF4?=
 =?utf-8?B?QVljanlPN0RkczNTVmplcDRqUThuemZZelFFTHEvdUJBMk1aVEJhaEM2SlRO?=
 =?utf-8?B?NkNDZTdCSFp5dy8xL1RuOUh5UDNWSW1OZWVkQ2xTTEg5cTlwSExYRlZpOEJO?=
 =?utf-8?B?a2FnTkl0VXdjV21zWEJIRklnaExZdnl0dnRkemlWbThFSVNNWFdkdjBiMGd2?=
 =?utf-8?B?V1hxY0lteEt0UGRrekpUZ1hWbURIQXQwUmJ6dFJUQjBpQnMyQ1RlakRNMFJh?=
 =?utf-8?B?akNQOW1sUXdNYUF3N1Jwb2hoZ0UrV2Z4SHFnTGxsWUJqSzF3YzlJMS9DRDJj?=
 =?utf-8?B?MUFFYUhoTGFkcDQyL0dlOVVOOGc1VlVSdW1uV2Jsa2FFVS9ZR2hpdXNIaTU0?=
 =?utf-8?B?ckJ4ZzR1WHRtb3hMQ1BvTUl5T0ozb0xqY2lkYXpmR0ltNnRieE10MDRiNk9u?=
 =?utf-8?B?UU1QTVFLWEtMNjBJTVJvVm9HeHlXSzZyK1Z1aHYzRWhVUGVMWlRXZGdpaGxZ?=
 =?utf-8?Q?qYJg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee305d4-f8c5-4748-3a50-08dd6bd270aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:22:53.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NGLA0wL2vzGrJ0I4LBZrsGEugHtUQkOudGLh8qwS0FABwWrzRSETAYhto84LCW2ZU03asvaS+i80gyAizpEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

On Tue, Mar 25, 2025 at 11:59:14PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 24, 2025 at 01:28:27PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 24, 2025 at 10:48:23PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Mar 15, 2025 at 03:15:40PM -0500, Bjorn Helgaas wrote:
> > > > From: Frank Li <Frank.Li@nxp.com>
> > > >
> > > > Return the offset from CPU physical address to the parent bus address of
> > > > the specified element of the devicetree 'reg' property.
> >
> > > > +resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > > > +					  const char *reg_name,
> > > > +					  resource_size_t cpu_phy_addr)
> > > > +{
> > >
> > > s/cpu_phy_addr/cpu_phys_addr/g
> >
> > Fixed, thanks!
> >
> > > > +	struct device *dev = pci->dev;
> > > > +	struct device_node *np = dev->of_node;
> > > > +	int index;
> > > > +	u64 reg_addr;
> > > > +
> > > > +	/* Look up reg_name address on parent bus */
> > >
> > > 'parent bus' is not accurate as the below code checks for the 'reg_name' in
> > > current PCI controller node.
> >
> > We want the address of "reg_name" on the node's primary side.  We've
> > been calling that the "parent bus address", I guess because it's the
> > address on the "parent bus" of the node.
> >
>
> Yeah, 'parent bus address' sounds bogus to me. 'ranges' property is described
> as:
>
> 	ranges = <child_addr parent_addr child_size>
>
> Here, child_addr refers to the PCIe host controller's view of the address space
> and parent_addr refers to the CPU's view of the address space.
>
> So the register address described in the PCIe controller node is not a 'parent
> bus address'.


All should be parent bus address. See Rob's comments

https://lore.kernel.org/imx/20240927221831.GA135061-robh@kernel.org/


bus{
	ranges = <child_addr parent_addr child_size>
	pcie {

		All address here, will be translated by bus's ranges, which
use 1:1 map if out of ranges by default.

		from pcie node (children node of bus) view, the 'child_addr'
		is parent node (bus)'s output address.

	}
}


bus may not only one layer to CPU.

bus1 {
	ranges = <...>

	bus2 {
		ranges = <...>

		bus3 {
			ranges = <...>

			All address here is parent's node (bus3)'s bus address
			So, 'parent bus address' means the parent node's
			output bus address.
		};
	};
};

Frank

>
> > I'm not sure what the best term is for this.  Do you have a
> > suggestion?
> >
>
> We are just extracting the offset between translated (cpu_phy_addr) and
> untranslated (reg_addr) addresses of a specific register. Maybe the function
> should just return the 'untranslated address' and the caller should compute the
> offset to make it simple?
>
> > If "parent bus address" is the wrong term, maybe we need to rename
> > dw_pcie_parent_bus_offset() itself?
> >
>
> Yes!
>
> > Currently we pass in cpu_phys_addr, but this function doesn't need it
> > except for the debug code added later.  I would really rather have
> > something like this in the callers:
> >
> >   pci->parent_bus_offset = pp->cfg0_base -
> >       dw_pcie_parent_bus_addr(pci, "config");
> >
>
> I agree. This should become, dw_pcie_get_untranslated_addr().
>
> > because then the offset is computed sort of at the same level where
> > it's used, and a grep for "cfg0_base" would find both the set and the
> > use and they would be easy to match up.
> >
> > > > +	index = of_property_match_string(np, "reg-names", reg_name);
> > > > +
> > > > +	if (index < 0) {
> > > > +		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
> > >
> > > Both of these callers are checking for the existence of the
> > > 'reg_name' property before calling this API. So this check seems to
> > > be redundant (for now).
> >
> > True, but I don't see a way to enforce the caller checks.  I don't
> > like the idea of calling of_property_read_reg(np, index, ...) where we
> > have to look the caller to verify that "index" is valid.
> >
>
> Ok.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

