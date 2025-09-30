Return-Path: <linux-pci+bounces-37294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B35BAE8DA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071221940969
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47897288C13;
	Tue, 30 Sep 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ew/tbFP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD06267F58;
	Tue, 30 Sep 2025 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264802; cv=fail; b=IvKoEw1R8Y5QQSjnnbuTATkTysYIeTHTrt5+F/wNXAsXeDUz9g3Jrt5qT05LklYbI8e25L6FTQBqntk6E8TNvFqN1in67foZlb+M6Bt7H/DnxogYeXFb722ASg8LcL3waCvZGDaAg6jEwsU8AhBl8CYn3kz1ZgfFfOx6kTbMX9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264802; c=relaxed/simple;
	bh=fTrTjuDm4abymF4MrLYzrfO5CZFR2oN9Jg/OqEXxR4M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KRg0RKVVZaduJoKOHMppTNgo0nacdgA1mHTAidBvqb0okeGLAdbd2rFpBw38CmE7fYWhboFJgzXwT6vkpWFp38JIeRXIJ4h+k1FwulXYMF9C5JQAhCdh2+zgxaXRp3yhI1xlNI1BQMmqXfNCB4rDNOKU2Fvt1JvE+vhTUeMNVlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ew/tbFP9; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE3zBZhqhEkA+FWwubYi8q9sVBZihuoU5jfxiCHsocsScQ39tXNJnZOwbP7ToMOzDPR7GwGvBe4wYniBaHt6U53lhZrk+vbOTT5ZWqzTNIBT9LCSAEdlD4HQFVEK14/AOkKlvQYemCk2gtw+cIOoPtNt/hlLgotYwGoy5Kenpu4lSbz0X1iqM6NZhU/mdRw+bHYAq2uiSJgKRdyqhTp83QkX34Su//xzp6Ba2BjorkF3gyLF8NI9FZ7sv0eZeMyB4n6LRwKfglFb37NTSvJhupi2fBkCyzz4bO+mM6DirgVVft5rvRMSZJC+VPiickGIr3LJ+jwJmDkksQ23BtqXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X6Q8oFfA4CimXwW6+KFNR9yPz57gi53b0t3guauzBQ=;
 b=wNintQrKyQe326Z1TGcnDeNaTvX/f5J0WeaFqZmSQaaBFAagQ7TJKKj0NlVGh4qg6yfSj1nqHI9LtldGlXukyl4CbasQUTHeRtAlcpyBLv4nL0glW3c5aVX5WMfe+ITchUq3YqVrlo9ytK2kAm5bAGb+a1d/gMMrXORcvnKEiOajkm/AFUWJyc037Oj2fjFrPVvprUoB+xUY0LcHnrp6fYvb/Ge5khZR2+b70xbj/VTSpO2/m5KpWqStQk3GLmBT+sduCld0n7CLFByJEi46NOvP3NIIyRUbTplASUL56klVb9bU01thXDikDnNvAujbWCIUOR10v9p91z9zSX4D9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X6Q8oFfA4CimXwW6+KFNR9yPz57gi53b0t3guauzBQ=;
 b=Ew/tbFP9CJ0C6VPWr4AmlA7nHKIUNhruP0SLoirl6nbSp5/FlLkW7GyPWpMkmYdLRFA5n9WtWgEHtsHigLszRNOSdij/PYCr/ExN92ySPrwMKKIlIFVtyUlwGCAHSdoDi/Mgbh2OKCUfz4SToRjvOfAh15N4Ra7vzqQT8Qg/F9NKowQyKJfPp8xJfbeDMm0YVrbMhQI2K+RVcaZqNJHn/kVLNpYE6f70Sola7ydIJP3LCxwF8hDbZnNllp0KtCdNjJV+M2OxpqzC5cgkNyz1jtJGSp54WU9M3mPI6uTRRsiS0ga2Nt0Zw0EcVfI3jNwju8h6tkoBYaqqig84i9dkIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 20:39:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:39:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 16:39:37 -0400
Subject: [PATCH v4 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-vntb_msi_doorbell-v4-1-ea2c94c6ff2e@nxp.com>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
In-Reply-To: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759264791; l=5111;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fTrTjuDm4abymF4MrLYzrfO5CZFR2oN9Jg/OqEXxR4M=;
 b=dNdZVBMITIh5IRk+peL1++jIUlIigvjxvAdR4QdvrsQGUWDxOGVS2xVrNEKoCGpl0mV3CIUBb
 pSmH0gUZBeMD5h9M+YCqwhZsrnpxWA5ymsyrLNPLQBM8u0rldU3Vu+c
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 744884d3-a856-4f08-1291-08de00618476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUFKd3p4ZGZEVk1Nbno1bCtqMTBGa2psRDlEUHBvdWtqS29VbUpUeDRXKzcv?=
 =?utf-8?B?YUI4WUk5VUMrRkM2aTBSd3p5eW9HZDFHUFgwRWNWb2lvMWhrdW52WFZMMFF0?=
 =?utf-8?B?VW9EQ1J5bG9uSkNNYnNueE55ZHJxNlp0emwzSkJ0QUZEWFcwZmJzQXh6MmhC?=
 =?utf-8?B?bFpmd01nMEMzMlVOOEhhOTlwYmVhbEdDb21QbHpNa2NtMHN5WUh4UklWZHZu?=
 =?utf-8?B?RU1id3ZEc3lOVFhVRGRralNIaWtZdXd3RXZuRWFlV21SZzcrZmZkb3ZkTFJN?=
 =?utf-8?B?Q24vWXVVYXJSbEplREtrM3B4SEozSnJpVHFtMWhUY2ZrYWRycWlMZjlyUTdE?=
 =?utf-8?B?VGFXVXlKaXVZQzE2ZVpTR3dhZlJmZFlFaFRpZ0xRM3EzTUROd0tQcTg4OExE?=
 =?utf-8?B?ZUl3T3V5YXJsZVNZUzVxZHlrc0ZOWTA5ZFBQMitWc3l3RGFpeWJvZ2kvcDB4?=
 =?utf-8?B?eDE1YUpub1pHK2w1SWovc09jeTlkTUF0VElndENjcFYvKzR1MGhwRmg4b2hk?=
 =?utf-8?B?dy9sWnFzT3EvTnI4dW9ZanlFS2JXM3l0cVZERm1FZGJmVTJJS1FsdWs1bWRZ?=
 =?utf-8?B?UWF4Z0VqOTBYRmZkOEdDNkg3T3RxTGhReFVvSmJQZzR6M2lseFU2N0VYUFlH?=
 =?utf-8?B?VVA3eWZYNlNyVW81cXpHZjlYQTB5cEdaUFd6dlhOV1Byc3N2dzVZV1ZZbzV5?=
 =?utf-8?B?S0orTG5jRTV2bHpoNG45Z0VFMEJBRHVXWDEyNGF0Zyt0QzBEOE5LVjBvUWtE?=
 =?utf-8?B?SnN0MXlyT2U5L3hDejNZRmxSQVNWRlZDTXJxWjVJQjJZU2trT2k5aHdxUm9l?=
 =?utf-8?B?MWQ0ZmxWVUZqUkNRR3kxeVh1b3V6MVV0SmJoY3JBUDMrZ2NpVlU0aWJSK3VN?=
 =?utf-8?B?VjR2Mnp6aEdyM1EzNHdsVnRDVERxMmRZNW5zcThlVVkybzBuNVd3NDdjUjh5?=
 =?utf-8?B?LzlFdGFiSjFWNmFud282dmJIRXB6U2FUNkFtajZJa3pxNDkvcjF1amdRdjNj?=
 =?utf-8?B?Sm8xSG14VXR0YnMzZCtVZzBPVDlJUXo3bm9RaXZjOWN0TnpVRk9RdGZkaGRB?=
 =?utf-8?B?STVwR0NOazU5aHdXMHRiWTN0aStOSmd2OTZib3JzVjB0MGVCZENPeC9zRFJW?=
 =?utf-8?B?bklxcFBpUVhZSHRGUFJrL1lOd2duRTN0eTExY2xtUWh3QlZsWDBLd0hSckpL?=
 =?utf-8?B?b0RQRHFtb05pOHp1NUNVc2Q5RjFJUXA3MEQydFUyNldweEIyaHZRVzJ0MDBl?=
 =?utf-8?B?Tzk4dSs0TFRmVWhxTTRlK2N2SjJ1V0lTMlpWdE1KL2lTN2lWa2lZazRkVmFY?=
 =?utf-8?B?QTlIZlpLYmZlK2NBeWcrZXp0Z2l1VVJLTFI5Zm5OaCtSeXR2SUFPZ3o0K1VV?=
 =?utf-8?B?eFBJYU9JOHRpM1Q0YW5sMGdpMHQySjBXQitrTUFwaDAxVmRVaGxUWVNHQlho?=
 =?utf-8?B?MGsrM2RHTndaN2E1MWV4TjFBYlY3NTNkUi9YTVFBaHZoSW4ya0lKNStaTFdU?=
 =?utf-8?B?ZkdqTnpEcFd6R09DQVgrajVwb3hGNEVHMmFhTmwzQ2VIczdvYWI4S05IVEJH?=
 =?utf-8?B?c25pUUVZMlFRZ0hsblhDZFVCYnFvRzNBKzNIZTRkOWdTdWswdUxkdlJ2NE1t?=
 =?utf-8?B?SzRSMnU3ZndNVUhSdGR2NU53Tm1WQlUveFl2STlyV0psTE1VdDFyTlRkb0E3?=
 =?utf-8?B?cHlmeXhMam9oL1p5YXpVdWVtNWZraTFSeTJuTWw3aHF2aCt4NnVSZURmMXFJ?=
 =?utf-8?B?bGhJYkZ2aHNNZm9hb1ZRbFNRUmI4ZTk5dndBWnQ3R1pyOVordHlwdHJWKzYw?=
 =?utf-8?B?TUtHaS9nbFVVNXpoQ2pEdXRsdVpMdW9WSnFqRGdNVU1aL3FNZjZ3ck5mNE1Q?=
 =?utf-8?B?R0duelFndHR1NkZQR1czOEtMengwT2JBbEVCQnRrZjh2dmZOY3lWQll1T0pS?=
 =?utf-8?B?cHpKYWxWdGhTNFFrMWcrSDh5MWQ2RTB5aTZodVNtZk1pcWtrWU1aZzNna2Ew?=
 =?utf-8?B?RzBUS0dxanAwZ1RHWmtucXJIWUgzVUE1aGtreTZLYWpKRDBod2lEY0tEbUw0?=
 =?utf-8?Q?yljYw5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG04U0dZTm5YRmh2RTNTRWY5ZE1hTWdSbndXSnJQUm1tU1FHWlRia1VWcFdH?=
 =?utf-8?B?c3VBQTV5Nm81RmNvTGFndWxEUUFHTTBTVkZRalJ1a1lsTkNGMllUMXdLakts?=
 =?utf-8?B?RkdEWE5VTlF5SmZCS20xLzNDTGErcTFxc1AvMlFIbHBZMlEvOG03amtZaHMw?=
 =?utf-8?B?aGVVWFFncjV5YjVERWhuZ2IwVXZPSUNaYWtPeHZmUERYcFNuL2N0aXRmb1hL?=
 =?utf-8?B?VEFneUhzeG1GSGhCVkp4eHpRdEhpdjBZZnBaTnVGbjFxREhoT085OERzakJz?=
 =?utf-8?B?anNWc0JhTEh2WWloUlRSelVKKzFyVk1YNVgwODRJcSsxQjA0OE12WTlUMFFR?=
 =?utf-8?B?YWlCWmN3d3ZvN2hJVjJRcTlQbHVNUnlzL1l2TVA0OForSHJqdllyQUhmRWdJ?=
 =?utf-8?B?OXFWRVE3ZmptMHcrTHYxYkRkNzdPUEN1VDBEYzQ0SkJqa05uNjk4MWlYckdN?=
 =?utf-8?B?a2orMlVYeStkaGVoR3lucEF4dmhvZ1VVVjYwTFVHQmhyMDZpdXVnNUVwajB4?=
 =?utf-8?B?QTFJcEZZWlorOThDbFZ0RzJaYW1EZ3YrR0IrWEZkSWxVMkxLeXNIeTJtL01q?=
 =?utf-8?B?dURZWGtXWFM1WlVtTGFoUjNTdmlUY3lWSmQyaTc5TFN5THgyOUxXcFlVM3dE?=
 =?utf-8?B?K3h6RWpZUGprVVJpOEFmNVlLSVdHTXdXSFF3aHhXTGhkUXNUQ2VwVmZ6eXVC?=
 =?utf-8?B?citvTjhJMC9zOWRCcnJSQW0vZEhxOWRQSm9tbFdIZEwvTUhUaGtoZnlZWENl?=
 =?utf-8?B?c2FqcWFhRml5ODlaeEoxWkJ2ZDdrSjV4eE1FZ3UrV3o5ck9GVElsMjdnOHJW?=
 =?utf-8?B?MDlUN29tQXNNY0tUVU9iTzZId2RJWVYrZVF5TFc1OHRVcFRPV21yRFlVVTlG?=
 =?utf-8?B?aEN5aTlDTnlpT1lyL1ZXNmlJY1ppVnRsOVNtS2QzK09BdXA0dHZUeUNGalpU?=
 =?utf-8?B?cVljQk9KbnByTm9FMkd4Sk1ORmF2R3hKWmt6d01iNlViKzFxTG1McUVJdndy?=
 =?utf-8?B?NWs3VVNoTXBlcExaaUppNjVNTHEzQ1VWRGViazRldDZlcitoM1RVdzYreHpD?=
 =?utf-8?B?cVhxekxtSGFCVW9ObzZkVWd4NXdLVGdvYjB5Vnk3QjB4L2VtS2N3RUpTeXFs?=
 =?utf-8?B?dWhRS1BFZEhHNytkYVM0TndFRHBuaiszN2tUQzJMVXdWbndQbEdvZ2ZlR0Na?=
 =?utf-8?B?enQyaWZSVU9XOXJ1dkVMVTJrUGZvWWZCc0FGa1hSbzVEOFNwV2lZZURMc2I2?=
 =?utf-8?B?QW1nUmtRdjJDcEJxYzF6UXlqMUJmdzRycTl5TVNDV2NBVTg5bzEyZkFhZGdG?=
 =?utf-8?B?bVoyUjZJTjBXenVlSS9QbzVnVlRibkJ4UmVOUWJMNTFjNklESTNoSEVMK2RS?=
 =?utf-8?B?MktIWk9DK1JpZUN1REVWV3ZycFFQVGhHZ2M1N1hnZGZ0WUVVMHBackVEeWh1?=
 =?utf-8?B?KzZuMnNrdG5POFBzSExVVkFWS28wMDZPcytoamorY2pydTZ6OTRGR0RJTzNV?=
 =?utf-8?B?YlZPdkZDVVdEaTA3MDBHRUtkL0IrdEZxdmVHaHcrQTZjT1hOQm9OYzJlMHRL?=
 =?utf-8?B?cHdUcDdhRmx3T3hrS2tJTWd3VzBBMDU3SUpRaEp6NnkveFIxc2EzeUlvU2R2?=
 =?utf-8?B?aEt6L1pud3kxQTJML1pjNC9pemFtRGhMWHhJRDdUV1R0NklOQ0lSQ3gweExD?=
 =?utf-8?B?dU1kaElnTk5KL29GaTBHeS9rVmxjd2NnZXBQRWhuc0trdzlqZCtlRHcrdnZt?=
 =?utf-8?B?N0grL0ZGSXFOVkIvT0p4elRBcXI2R2Yyb3YzUEltV09rYXJWR1BERXd1MjFI?=
 =?utf-8?B?aDJISk5EODBlNG8rNVpqUWJibWNvRUoyKzlHc0xsUDhrS1pNS3dmMDNSREVM?=
 =?utf-8?B?azNuMVJjYkxpWThLRFF0QTZnR0F1anpWZjdoQTF6K0k3dDJlWG12SEN5Mjkx?=
 =?utf-8?B?UG9oZ3ZJdERpYUQxbEpCRitPa29Bb2VlS3JMLzh5M1ZaaGo2SmliYVZ1Q2Fr?=
 =?utf-8?B?VmFucGFBd3ExQ2ZpSkhlRWdMdDFtR1prak1OMmVTQ0FHMDd4aHp2Q0VDSnFV?=
 =?utf-8?B?N241NlNwaGVOamlKYmw4L2FrQm54M211NjZMdWRuR08xQTF4eE42bXIvRmFz?=
 =?utf-8?Q?t58WSk5v61cp+4EHW6LdG/zrg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744884d3-a856-4f08-1291-08de00618476
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 20:39:57.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQIxdM2rNbFQnJ4lQl/mSg/xk4Lz8OwmTHwpeZLH5RHBLTJWeoA/NVidp8N7133ur9FpEipk1HokzYPwYgt2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
size and memory size. Prepare for adding support to set an MMIO address to
a specific BAR.

Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
confuse.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- use size_t *bar_size as in/out arugment.

change in v3
- change return value to int.
- use two pointers return bar size aligned and memory start address aligned
- update comments about why need memory align size. Actually iATU require
start address match aligned requirement. Since kernel return align to
size's address.
- use two varible aligned_bar_size and aligned_mem_size to avoid confuse
use 'size'.

change in v2
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 81 +++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d54e18872aefc07c655c94c104a347328ff7a432..db0420f601d81de426a3e805c7fc309de58d54b7 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 }
 EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
 
+static int
+pci_epf_get_bar_required_size(struct pci_epf *epf, size_t *bar_size,
+			      size_t *aligned_mem_size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type)
+{
+	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
+	size_t align = epc_features->align;
+	size_t size = *bar_size;
+
+	if (size < 128)
+		size = 128;
+
+	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
+	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
+		size = SZ_1M;
+
+	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
+		if (size > bar_fixed_size) {
+			dev_err(&epf->dev,
+				"requested BAR size is larger than fixed size\n");
+			return -ENOMEM;
+		}
+		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
+	}
+
+	*bar_size = size;
+
+	/*
+	 * The EPC's BAR start address must meet alignment requirements. In most
+	 * cases, the alignment will match the BAR size. However, differences
+	 * can occur—for example, when the fixed BAR size (e.g., 128 bytes) is
+	 * smaller than the required alignment (e.g., 4 KB).
+	 */
+	*aligned_mem_size = align ? ALIGN(size, align) : size;
+
+	return 0;
+}
+
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @epf: the EPF device from whom to free the memory
@@ -264,40 +307,16 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type)
 {
-	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
+	size_t aligned_mem_size;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
 	struct device *dev;
 	void *space;
 
-	if (size < 128)
-		size = 128;
-
-	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
-	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
-		size = SZ_1M;
-
-	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
-		if (size > bar_fixed_size) {
-			dev_err(&epf->dev,
-				"requested BAR size is larger than fixed size\n");
-			return NULL;
-		}
-		size = bar_fixed_size;
-	} else {
-		/* BAR size must be power of two */
-		size = roundup_pow_of_two(size);
-	}
-
-	/*
-	 * Allocate enough memory to accommodate the iATU alignment
-	 * requirement.  In most cases, this will be the same as .size but
-	 * it might be different if, for example, the fixed size of a BAR
-	 * is smaller than align.
-	 */
-	aligned_size = align ? ALIGN(size, align) : size;
+	if (pci_epf_get_bar_required_size(epf, &size, &aligned_mem_size, bar,
+					  epc_features, type))
+		return NULL;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -308,7 +327,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
+
+	space = dma_alloc_coherent(dev, aligned_mem_size,
+				   &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -317,7 +338,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
-	epf_bar[bar].aligned_size = aligned_size;
+	epf_bar[bar].aligned_size = aligned_mem_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;

-- 
2.34.1


