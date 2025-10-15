Return-Path: <linux-pci+bounces-38238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C547BDF59A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6642C19C7ABD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E742FE570;
	Wed, 15 Oct 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oXSvks78"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9515302755;
	Wed, 15 Oct 2025 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542082; cv=fail; b=MYWMIh6g4a5PnufzTI4ieuhiOtt29MGTj+FJvpWYCUHiNGwpNoisbA09GULBnu1IZiGh65UPSjeYgYL0gYr/MY0X/oRD7ZPCz9b2Ouc5L7Y16z6lSehw35Rh5ytEtE1TJMcGrklZYzt1AVz2oNwHmAhkZboRVeJqmoUNeWOgF5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542082; c=relaxed/simple;
	bh=uuWJTyw995bIGlgoLpOyEfFcEHk+Dn9is5g61+XdMWc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UBGkkE2Dtn3B1+dzPDgtcz55JYXZgKxmhfpKa12tRG7Ub1M8W08UpB97QncMemvlcqJQsZlEDPHC/g/6nDnBmTx6m3IY+OJNO43LnTF6HwpsDrRsLGrJw0YZ2XBbx0/FEx2+MtYh8OOgCGpWOobSy7srCyGcaWuZthpIo4Gy7ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oXSvks78; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGy1lJAsSER3Wm1kWdTgZG9huwuB4Iq9VV0edoKGKDwE+jOCXXdKQgaLtXGMPrujB5Hz9CJryp3Qx2GDEnXnLA7Ib0m3/myxq/ugjUt8OP5cyVw9LaIX5+XMuFdrMhV8fDVzYqGIvaMx2RmZjx6bjUk/JTTyxGxpKY3OTC7v3oOr4e4wMjA6vBzAeFChfmKxHAf0N9ptbnSaiLdARcqVsH4bRI80RYKEXibNUkqYZQRsUOAE7/eZCpcKoF/9jj7pn5V2nlEVidrVzGqlzHgDvN7ji/T6+daIp+XQqWuFB7vFMA6J1KHwyiJ7YNdpOPZD4vbTjQIaqzPg2G56ELDmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzU9JICq+Qe7zYlVwBVK0h2pGRjAFccSsyhQbzao8Nw=;
 b=WxIW3cqsZZXagCH2qwc45K6gaKm0ckyMMBq+RQcc8Z7KiL4PzftLCoXtZCe9y9I9YUZmDFY4y9D7NvtFyvghJoLrze5oiX88Mm9yxi++Vf/1dvaNp72Iq4vZqLCPETn4W4NdPKylS7Iv2eyxP49Ek74fHP3kTAVhjGmUAUmgw1Ev5zae80MXOY1BrLL1YtuvmOKub4EbgQtLSnPTMsTk5xKIhCRpgIPzoJ61bIFb2bOH+4t3TfyCAWCuPNA0Cg3/s5Fy0taZVzc+tD/sryE4WXVvfov3i3Jj03kRh+LkH17fQ+8qK6FZdABWZlGD/u//NO/ODA0CL4rC9SB+HxYyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzU9JICq+Qe7zYlVwBVK0h2pGRjAFccSsyhQbzao8Nw=;
 b=oXSvks78jqXSiEhCpKGyA39vR7Rwz6TIDh+b0zncNnclFgpd3nKbTMvdsVHYC3oonxuQgesAeYpYj26SrtTunqNsVJQDBRnjNTIHD81+veFL8J0KgsNlEJyLDFoK48LSmy3V7MqvyFfIAROR7Y54E9TcfaL/jSqtBsR6h+Te/a/dDsZOIMT42vdSEx7Z5UJY9cmD5APDtntDWjWcqMXdr+IXrKH5VGFbTfSfmASDGptQ06GwyYjumowRwltxzO9UFzsFJ0dsGiWEA61RDEa1fuH2jtDQFuApe4osPAJpkoXWqNyAP4m1q7mIQYpCdWEgMhaDIU4bZvbUTUe9J0AV5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 15:27:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:27:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 11:27:30 -0400
Subject: [PATCH v6 3/4] PCI: endpoint: Add API pci_epf_assign_bar_space()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-vntb_msi_doorbell-v6-3-9230298b1910@nxp.com>
References: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
In-Reply-To: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760542064; l=4979;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uuWJTyw995bIGlgoLpOyEfFcEHk+Dn9is5g61+XdMWc=;
 b=Q0r1iN6R3aiaxdFNu6l/cWqIfyUmmt0zqmRCiJeVaG3bhwVhEknFJLNQnKv7s6iRRhgvmCUpp
 RdbBNBHAHjKAM/xL7vlckUp7/ZIw8jCiQh8Ii8zXkj74KsVW1DCENRG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b02b86-141e-4c9a-74b7-08de0bff6b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RndmWGlSVk92VGs4cFhoWHg3c3BrWk4vVm96TStYblFXVGMybjA2QkJQbVJz?=
 =?utf-8?B?bS9qdFkxeTRwODlyY2htSFV2djQrVlhna3hybEhoTkhaMFUzNGtUQ2hiYTQv?=
 =?utf-8?B?SVhBSmVsL1ZTMTMySHZWLy9waGl3UFVrd20rbHpMcUNJa0xZaU9ueWw5ZFJJ?=
 =?utf-8?B?djNFUmsya1lodlBpcnZyOXFKdXVVY2FYSERWZDlIRnRQaU9IdVY3a3FZa3RN?=
 =?utf-8?B?YkNaQ01oQW5CM2JLS1VFd2hFa0NZZDc0REJTbUlQc0U0dHpRUWNzWS9ndW1z?=
 =?utf-8?B?cnNLOXFWbjNkbVZHcGpCVGovM1k5Z0YrZXBEdnlrVlg3WXlyc3FEMzNtWVlU?=
 =?utf-8?B?MW5ENW9jUEFoaEEvRzU4TDBRQU9kbWhneVY0VkxndUwrNzVkZ0FLMldYSnRa?=
 =?utf-8?B?Y1ptYXJmdXU4TEkxOGYzbk9mSnBRcHhMdWpwZzJ3TU1mdDJLVjlzTTkvc2Ft?=
 =?utf-8?B?cmlycEx2bkF5UWp2d2dkNk9NWVdENDdyTUNNSmhDY0JJWS9JYmhubUY2WXhB?=
 =?utf-8?B?V2pmdWtwbWhDL0t5YjZPSnlFY21hRURIR1JTTitCN0dyNVZoU3BpTUY2am9K?=
 =?utf-8?B?M0FBdXhJeDQ5WkFpTEYzeWZZaExJL2xaRHg2cGF1L3ZSTEVrR0JzZFJoRERY?=
 =?utf-8?B?dE11clpTZlozZTdiUlRHSFF3Yk1KaG53RTU3NkFlek13WjFCZzZjZFdkckNS?=
 =?utf-8?B?NXJRNnRkdE1tYWQ0VG9ORzlTT01KWXVsWU90SzZaYXM4YjE1VXA0R3UrZHpM?=
 =?utf-8?B?azloK0F4cGd0NjNiWEhKSU1QSUU5V1RIWW80KzZRdUU1Q0JPajJrUmJmOEJ6?=
 =?utf-8?B?WlVOcytPWk1lZGZxZktsWVN1MTd2QS9ZZXUwakRHSEF3emxkM3R0eCtNOVVN?=
 =?utf-8?B?ZFFmOHlXQTcxaS96WDZLSyt1aGVMdzVvUE9teU5Kd2Z5SVBhNk9VK3hmS2gv?=
 =?utf-8?B?b21KYmYvT3dmbXJaR0V4dGpKMUpsY2srdStydk1WaWVxblpZdHUzYTIrOFVz?=
 =?utf-8?B?VkxMRFFyaXppcFFIbWJmV1RXNnFLVVVNUm14Uk9GMGtsSWhGSHZEUm5CRGdz?=
 =?utf-8?B?cjMxTXRPL2hUbzk4b1lRUmpSTkRtMlRXSFdlcERTanRtYmJaTXVHUUx5azc2?=
 =?utf-8?B?ZXZYekZaWGFYSWdIRCtnNHN6TFpVdlY0bU9PUFN2UVpUMldvcExWMndRYkFZ?=
 =?utf-8?B?Y1ZCaHlKb0k3bm9NWDJyRTdXNGxNTGtzUHlIamtiTFd5aGZ5OWV4Tkt4YTNy?=
 =?utf-8?B?WDVpdEhFcmQ3RjVZc3RCc1RWNDJ4RVdybkdBZHpHWVh5UDhUMURob0p2Z2Nn?=
 =?utf-8?B?aDVpYTNkNVorc2RiRjZuQW5GRFkya0VzNitYRmMrZWgrYlhZdHp5YU16cGJB?=
 =?utf-8?B?OVRUazZFQ2RNeHgrcW12TGNJRFUyblhRQUhvMVhzTzNwZ1cxMHlXeFJFUGho?=
 =?utf-8?B?Wk84YU1zcWF3Q3B3OXFDb21nZVVvY3hoK2o1S1p1MmRvaTcycWIxNXdjWFpB?=
 =?utf-8?B?L0l0bTE3dWNlRDJaUWFpSk5DYi9uSU5SbndqQmpzamxNWHBKVWN6VnRMRzJX?=
 =?utf-8?B?c1p5WThvRDY5VGdYSnpFOWs2Q0VoZEN2eG83amhxMCtmWXpjQmxlNXE5NkYy?=
 =?utf-8?B?dFVrYlZDSmRXT1psc3NWbk02QjFpWFBNOHRXajBaQTk3dXdzTGZiNnVJWXN0?=
 =?utf-8?B?bjJZQXR6clV0dXIzZzBSUlNFM1dwUHlmTkkxaytHTzlWTXpyQnNuakFMbS9m?=
 =?utf-8?B?eExoTjVSTE5sYmVvc0t4bjd5MU4wRk15NkVrL245U3VTWHNKS3BSNHZiWUk5?=
 =?utf-8?B?QVpZMEcza21MUkM2R0hBcVZCRVQ2L0crL09hZU9BNVMwcHUwMG9xblVtSzRx?=
 =?utf-8?B?cmtGQ1ZaeFlxbTI0cUJtSDhONnZNVzdYRzFXNEtOOWJuWllwWENDU0ZrNFU0?=
 =?utf-8?B?NFZsVjgzTVE0ZjdzR1ZNQklhdTlsNjR2YTJwKzhJN29nNGo5dzJCRlZBNVY3?=
 =?utf-8?B?dUFXdm40T0VveVo3bDhwWWVlUHp0Z0ZPdm5zR0xSMEoyT25hSkh0dFZad2Yr?=
 =?utf-8?Q?zXdApS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG8xM3RCN3g1RW9NUlVQdDZSWWx1d2FBSjUxekJHTjczNXhGdjdiNTdNQUpw?=
 =?utf-8?B?cWZhUDY1SCtXbXlhekk3ZGJ1VHUvQmRud3lObUx6emJrek50MWRKbStzK09G?=
 =?utf-8?B?K3MycndQTnd0QVdUSUlTVTlMVEg4Nzl0Y0hPNVhmZndGVG15dmlDdHJJVi9G?=
 =?utf-8?B?YURLUE5zcnZYaU1GTWMvc2JoclJXUm0zaUJQMitRSmhCczZ5Uk9NQ1FvWU1q?=
 =?utf-8?B?clducXhSWUlZUFdFb2s4UEkyUlFWUVBtcmg0LzBTUWhNKzRZQURaM3VURzBU?=
 =?utf-8?B?UHlCaXM1S0xoZ3hQeE1HcEs1aWdDK2MyMHBWM1pJT2laVFl1TDEwN1gvQW53?=
 =?utf-8?B?aisvQzdvNUZOVkhlYVlTaXJBK2RhNHNpd1ZZQ3VXWFQydlFhdlo3dDVOdXF5?=
 =?utf-8?B?VEFJekpFcGtya09hMSs5SlZ5ekdEa2l0RjBncXhqajRhWXU2MVJpSlZMWTlX?=
 =?utf-8?B?NEErUU1qS2p6TzF3NHdVZzdCNkx1R1VqS0ZvRnVDak02dmE2Z21CYThQZ0Fx?=
 =?utf-8?B?aXE1Q2dPaWhXMUxxblNQWEFRcHVrbWlFQ0s4NkpJdkV4Ty9kR2VWUmFIZm9x?=
 =?utf-8?B?MHUrSDllZHh4Skg5bWluSzd1RjR1UGI1bGZHT3VYTWMvK0JwTjdWQXNxamhF?=
 =?utf-8?B?UG9SY3FxYXpKcXYvcHppcjlSeTdvT3dkVlhMU0NUb3VBZVFUdEtNcTYwd1la?=
 =?utf-8?B?ZW1ybGxJaFVmS2R5T0FhQlh6b2NtcE8yNlN6UjNiSkZscld1TjFnMzZPbm56?=
 =?utf-8?B?bVFsWGxwZ3c3U25vNFRxeHBMS1NqQWM5NkRMOVBSVzFJMmdac1JiT05rdlNE?=
 =?utf-8?B?SXRqeUp5RVFTWjh2OUZqUTBCeFMrcGdIbFp5VkJ4Y2I0ZnNERzZqME9GN2h5?=
 =?utf-8?B?ZllubHRPT01PVjlaQTZqK1ZvT3QyNFVqd3pncGF0dFZTRllldGYvWWUxWW9L?=
 =?utf-8?B?eVRrUWRyMzBublBieUxsbUlJR0dBVUs1M3dDMDIyUFRBNUNOa0JLelZBQlR2?=
 =?utf-8?B?OTdWekJCZEs1V2FoZjZJbEVwVXljaGtuQ0JiZUtKbmoxbFhDa1pIY1FZbzYz?=
 =?utf-8?B?YnR0bDBSdDRaMXVrU3oxZTlJbko3bm54UUtEanVBNjA5K1d6SEVoalVnWFJp?=
 =?utf-8?B?NEZYUGNkVVJ2ZjdqRUFubnFBQmdFdGh3RmE4TVpFMXNPaHhvcitITnFyY3NN?=
 =?utf-8?B?R3hOSi8wdENtdTJpQzQ0NTlrajNqTDkvQ1hacmZhdnFXakxieDBnZE5YanNG?=
 =?utf-8?B?MVBDc1BiMGR2MGVpeDdWTHEySDdPZWtPT245cmtEKzlGZndoeUtBajRXVnVx?=
 =?utf-8?B?T3VRd215ckVkZHdkRnhWOHRjZ0FVeDJOY2QydXA0WmxOcmhGNytsaDFndFEr?=
 =?utf-8?B?cldpT1ZUaTdnL0gvek9uVWlqckVLbnhMOUhOTmxLaFVaemRyZWVFSnZmczNy?=
 =?utf-8?B?WVBWYkJyK01KUzBsZElpUXRVamdOK3VGRUF5ZUNNdHk4TUtTem14QitldTR4?=
 =?utf-8?B?b0FsTDJ1b0l6SVJQaTJybXNjbFlZdUFNSGtFL2l2cExMVlNHdHh0T0FFMng3?=
 =?utf-8?B?YXY0U1NHczZ5dkhMQjkyblZ3QkI3QnJUSlB1R21XN1VEcEFzMkw4WnhiVjYy?=
 =?utf-8?B?Nm13NW50cDJzTWhKY0lzd3dKdTJ5TTFJbXdsdGlsWVlpSXVBNkJDTjRPWGRR?=
 =?utf-8?B?bitMZGtiYi9EMEtSL2kvVTQ1Z0F0elA0QjIyREROQjFGcHdmMjlHeDJPOS85?=
 =?utf-8?B?Z2kzK0FKN1dESUVOQm9YQzRVbysvRTdURWRaODI3RFAvOHVFNDZ4RFF6emxX?=
 =?utf-8?B?ZkpFVGJrWUVJUko4c1RTMW9aWStmYlhmb21MTURFZ0NvS3VhclY3T2tNSXRW?=
 =?utf-8?B?OUZIYkNmQVVFaEthWnF2T3NIcHNqN05vaHNlc2gxSzBUYWQ4OE9QNFVVaDJT?=
 =?utf-8?B?YjhBS2V3U1c5cTMzRUNQTjkrdWNqRjhIK2ZBVXV1a2N5OGFDdmU0Z05OOE52?=
 =?utf-8?B?Sjlza2NkR1pBL0tGMGI5L3BSblJUSGUyQ2FDM3kxaG4rRC9Mb2JZSS9FM3FQ?=
 =?utf-8?B?L0FaOWFDKzE2ZVJWT0xMY05aWWhpZ2tVbVFzeTFQYytTSUtvWXFJUUdvT2Rm?=
 =?utf-8?Q?X1UbMyo/sFfh7WgMhtQVYHgG3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b02b86-141e-4c9a-74b7-08de0bff6b35
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:27:57.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFXMwR0GoXgZcTcqeM89fSxr98AASV3FHOLiOpr5hVaGDFT/S0VBC93d2VJnnev2hS1zRuZMGEfd1uRMCDNAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993

Add pci_epf_assign_bar_space() to allow setting any physical address as
inbound memory space, such as an MSI message base address.

Since PCI BAR size must be a power of two, the input MMIO range
[inbound_addr, inbound_addr + size) is mapped by finding n such that
[base, base + 2^n) covers the range. The base address is also required
to be aligned to 2^n.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- use bar_addr in head file to align function define

change in v4
- use size for bar size.

chagne in v3.
- update function name to pci_epf_assign_bar_space()
- s/allocated/assigned/
- add check when align down input address to memory align require, may not
bar's size can't cover required ragion.

change in v2
- add new API pci_epf_set_inbound_space()
- fix bits 8 * size_of(dma_addr_t);
---
 drivers/pci/endpoint/pci-epf-core.c | 80 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 38c4fd06e9693ceaa0c86f67090faa6e390425e1..1c64d69556e6c7c4841ef8a60866515a1f68333b 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -347,6 +347,86 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
+/**
+ * pci_epf_assign_bar_space() - Assign PCI EPF BAR space
+ * @epf: the EPF device to whom allocate the memory
+ * @size: the size of the memory that has to be assigned
+ * @bar: the BAR number corresponding to the assigned register space
+ * @epc_features: the features provided by the EPC specific to this EPF
+ * @type: Identifies if the assignment is for primary EPC or secondary EPC
+ * @bar_addr: Address to be assigned for the @bar
+ *
+ * Invoke to assigned memory for the PCI EPF register space.
+ * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
+ * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
+ */
+int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
+			     enum pci_barno bar,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_epc_interface_type type,
+			     dma_addr_t bar_addr)
+{
+	size_t bar_size, aligned_mem_size;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc;
+	dma_addr_t limit;
+	int pos;
+
+	if (!size)
+		return -EINVAL;
+
+	limit = bar_addr + size - 1;
+
+	/*
+	 *  Bits:		15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
+	 *  bar_addr:		U  U  U  U  U  U  0 X X X X X X X X X
+	 *  limit:		U  U  U  U  U  U  1 X X X X X X X X X
+	 *
+	 *  U means address bits have not change in Range [bar_addr, limit]
+	 *  X means bit 0 or 1.
+	 *
+	 *  bar_addr^limit	0  0  0  0  0  0  1 X X X X X X X X X
+	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
+	 *  [bar_Addr, limit] range.
+	 */
+	for (pos = 8 * sizeof(dma_addr_t) - 1; pos > 0; pos--)
+		if ((limit ^ bar_addr) & BIT_ULL(pos))
+			break;
+
+	if (pos == 8 * sizeof(dma_addr_t) - 1)
+		return -EINVAL;
+
+	bar_size = BIT_ULL(pos + 1);
+	if (pci_epf_get_bar_required_size(epf, &bar_size, &aligned_mem_size,
+					  bar, epc_features, type))
+		return -ENOMEM;
+
+	if (type == PRIMARY_INTERFACE) {
+		epc = epf->epc;
+		epf_bar = epf->bar;
+	} else {
+		epc = epf->sec_epc;
+		epf_bar = epf->sec_epc_bar;
+	}
+
+	epf_bar[bar].phys_addr = ALIGN_DOWN(bar_addr, aligned_mem_size);
+
+	if (epf_bar[bar].phys_addr + bar_size < limit)
+		return -ENOMEM;
+
+	epf_bar[bar].addr = NULL;
+	epf_bar[bar].size = bar_size;
+	epf_bar[bar].mem_size = aligned_mem_size;
+	epf_bar[bar].barno = bar;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_assign_bar_space);
+
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group, *tmp;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 4022dd080e20f2959f3a5faf4cfe054ddb5856a7..48f68c4dcfa5e2e3bb97963c6b0f47effe87f53b 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -242,6 +242,12 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 
+int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
+			     enum pci_barno bar,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_epc_interface_type type,
+			     dma_addr_t bar_addr);
+
 int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
 			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);

-- 
2.34.1


