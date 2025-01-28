Return-Path: <linux-pci+bounces-20508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09032A213EC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECA47A3AA5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A871E0B74;
	Tue, 28 Jan 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="msSS9SUz"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7E1F4290;
	Tue, 28 Jan 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102128; cv=fail; b=V49fsvFY0mXN+64eCktRaoo4DKIUd6qrwyx0cenYRxnSWXbQRle1U/RAXoCum0q1vb1XjiIIEf+RtOoz8QWlrcyIF45ENXN3mSgWfUZFxqdrz6DS/wUObojM6K3Xy3G+qQazt8Rf14T9NtnpS0sG0nhpxpHaqmv1U0LByOqH+1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102128; c=relaxed/simple;
	bh=ugQwsOgSZA1155syuYkmLaAvf8QM3mw8WwLdBYfCiCE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FJ6nZjvcIueXyMuG6VbdJyYupRar8kpMewjNMYULQn6SVOFUbYo0C4EzdPHpk+Cu71kdSZPpOf9oUPhYka1U6BIBoUUVmOiEutE1+K3L317gaAQrnhBmhq1uNgdnknemGoBmi4SdYH/GU8vGeLRcND5oL82C8CZuu6HWi4YyTN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=msSS9SUz; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALMsEQGhXm6dM/VVcsXGMM5u4tJvpY5/MfO4XONvKM2WmYlj3M+VGqySLhyX55lW1x/H6O1Z6btGUUe+2cK+bAF2j0Ngnw4UvyeIIuduR+y9MyiMduylB05sJS8O+C8rboI4Fy1ny5wCzusCgu1Knf6U2akDrdSOjithHbCvmo0JwYP3ZA1gjURMJ9ZQBaGz28JLOPTK+nrAJp4BYjA3JbNCVcVl9qx/7XT2/of0DaQxUcNmGWZ2fokOLHiL0ayU4eD9nhCK8nMrJvinIxVEPS9oVubqv5S9ecaj7EbMQ61VEEA0rQYd11p+x1duB9xS0UtjLONnQq71kfMUeXFa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR+2m4CQnHQSIMlrcvoieh13m5iawrwuvaQGxMLHjm4=;
 b=d8xxQIfxGI80DrCCwfrBw9hv2ehxkDOmwMT3X7SzcmYnhxPLPKhPQjAxdeC6Iq8aEBGV88dOvdPY8QvG8wnsmjhBGAUkWJycAxkiK7DItRtSnuOG43S1BiLcoZqxW3R2SdFWqFSIhCYaFmyuLRd7qL6Zt7tES3A9Q3OtQCzeg6i5pCPGG3Kg7xHa11uX5gFkP/QmOhqeC0f4kViChv4u279mcBGFiFVsT31CENk4GJ/Et2PeDpAZ0Le+hKteBr9iARCcxu1sElbtxMbyrfu4GfEteSI9EQj27EBLAbtc9KEL1GsE+strIKijYksshxiRbyykxuRcrlWcf0Ojgz74yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR+2m4CQnHQSIMlrcvoieh13m5iawrwuvaQGxMLHjm4=;
 b=msSS9SUzkde18Dge7be4mvOZ3yXw8jtJz39mz1UtfP8XpLmvPCkil714vUUJRcKjUYzR0dvMyYvOMuZ5UhZUQUeqCOZ1nfjZNeBuRVsBk9kXzxKIDPEXACHTBWHoXUJXTSy/N7brhh29iQMKLdIP7os34aoyRCbn1HW95Um4Bdq1G+MZGoX0zZSSgRkn5FMUkfIlXg+V3eAADqb2F5DLkdfM2scck6Pq/KzoO3NxclSKpvh5+/7wX7vuHZVn/pBVKOsPgAdNBNhruxICpYn21NANElKCO48LDVJJZ+f53ZMmO2HK+CMbe3uP7W0n1C31SBQUSNkeY4NxmUmq516ZfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:37 -0500
Subject: [PATCH v9 4/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250128-pci_fixup_addr-v9-4-3c4bb506f665@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102099; l=8990;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ugQwsOgSZA1155syuYkmLaAvf8QM3mw8WwLdBYfCiCE=;
 b=u6HcIQblCH1F6kIy9TTvhw8EgsD0kHST1G4KRLjrEwjac8iNghQXBO9XP6eyopGXTg83IeNKE
 wwLHG01HlFgBEEwrPm0era1L/SQ0llFVVq074Nz5i7tTKwCnxxu+M9c
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
X-MS-Office365-Filtering-Correlation-Id: d9427fa6-894a-468d-553a-08dd3fe85455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDRsZzJXTFFDd2l6VWlFUnpCWXlNNUJHd25vaVR4T29pcTVjRm00NmxnbFcx?=
 =?utf-8?B?MytXRzJrakozc3dvTXhlL0tHOEthOEhTQ2lDNUhIZXFhQmh3RnpIRnJIejdN?=
 =?utf-8?B?REF3emNCWmozZmR1YktXUEdyRmdFNjNDajZiS25tdmFSbzloN2JCVytQajNh?=
 =?utf-8?B?aFJMOFBua3V6a2h3RDFRMnNsM2svMHZpVnBEeE5oKzVzVHJyNHRmYm53aWtz?=
 =?utf-8?B?eEpVSE95U2syZlJNdjVQelJ3cEtWTExkMk8rQlpZVDNpOG8vUzkzaHFpM1hj?=
 =?utf-8?B?QVR0RGlJeXAzYVREeHluTGU2ZmVCL2JBN2V4ZUJHbE5OQ1A5WnNSUVQ1WCtP?=
 =?utf-8?B?N09RWjZ1QnNvdndpZ0FvRWZzZGc3dzBEalRiaGFMMzdwY1N3Z3QraDU3UFRW?=
 =?utf-8?B?M04rYVlYT2pYNzNvQmM0Ui80d1AyUzNpNzJ0b2lNeTNoQU1JM0hIdXdtWXFC?=
 =?utf-8?B?Tjk1c0Rodjh2OXgrVU9oclhYbk04Z0VIcGRheFh0YVMrMGxGTStTcGwzbGEz?=
 =?utf-8?B?cVMyUTVvMlNqdSsrTUN5d0JnVmxUNlNsajR3a2kzNzBBbjFUdjJPbVZrbVMv?=
 =?utf-8?B?bzAweUcvQVREb09NaEZjaWZSK0xmcHZka05zdUk5bXZmOTVjRDBXVjNPUlR2?=
 =?utf-8?B?SHFjVC9qK1N6UkpKQ1p4K2YwL29hcnU2aUc2L3RBKzdXVjEwSVRxd1dpRTdU?=
 =?utf-8?B?b1NYbkdVSzFIWkxaR2I2TUUwa0hEZEpXS1NWbURzTlJOdVYvUGpTbDUzWTZ0?=
 =?utf-8?B?N3JmckoyZEttMEVvRmlGSWUzN3dDU21HWk43ZDE4WG9NOHpneUZmVVJudmN3?=
 =?utf-8?B?dm9SUmZGTDR4MnFISzI0cFUzZWJPWWlaU0x1VHZaNjVIVHhWdEVnN1RrZjIv?=
 =?utf-8?B?NGh1eW1mZzZERXdNNTNXZSttd3RJZW1jeWhhTWlONytoMW9tQVgrRHRBNTBC?=
 =?utf-8?B?QW90UitGdHJITVJwdlU4V2lOSDJLbk9XUU1DcllFeTdqRmx1cjJMWi95RGtP?=
 =?utf-8?B?YVhRZzB5dGRrb2RFWkVoa3VLUkozYjgwM2NiZVJheXUreDhFbmViVzZCbm5j?=
 =?utf-8?B?aEo2U2U1a0t3eXdkRUV2b05EOHcwdDhhN2VxeUp2bkZYUkloaFFheUpPL2hh?=
 =?utf-8?B?L2t0VGxLQkFCZEwwQjRVOVZybDJveXhkYmcyM2MxR1lpYVYxMHh0cEpFZGF5?=
 =?utf-8?B?dEN4ajg0MVZxZVZIaU9TMldZQVJmdWNrYmloSnUxeXFERmh1aU9CQWI3Y0Jl?=
 =?utf-8?B?SE0vV212azZvMmtaNGZvYm5wUDh1QVIzck8rVHd2UEhiOUhMYlBlNkwxTGFQ?=
 =?utf-8?B?MlAyY1U1VUx1RGFQbS8xTmtjc3hUSS9JNlYyTmZlbjdoVWFVRTMxcW5hQmpB?=
 =?utf-8?B?UVY3aG1hNVdqYjI2cTFMcTZ2aDlZL0xEbjYrSkxzeXFuKzRtMTlncm0xWkhM?=
 =?utf-8?B?ODVOVVlaU3A1djJDY09LNWxXYU5MQUIyclR1RWYvZWQxMVRmM1dueUo1Ujdr?=
 =?utf-8?B?M0ZTU0MvRWVjeUx3b1NBeEo5ZS9taERsb21NQjdSVGpKKytodjRMZEN3YjVQ?=
 =?utf-8?B?NXhabEdZQmRobVpPd0JydzV4cWRneUpBUktpU3ljWmNaRGVFZ0hHS0pJUHYw?=
 =?utf-8?B?Qk8wVWtGKytRRWRSYlhPSFA0Mm5RMTVoaGdrOUg3M09zWWVhaDFtQi83eFgr?=
 =?utf-8?B?RCszeVhLcDc0dXkycGR5RUFxclFHWjExSjk1N0dHbnBiQnhGVGQ5L2tLTDN3?=
 =?utf-8?B?YUZ1ZTZQMDFOelJETldPN25mM3JNcklNQkorbVNnNXFSSEhNc3AzZ0FBRlF0?=
 =?utf-8?B?cmZBaitZYzFxdXd0K055MzBHcEJnR3JiUjdNVmZLeUJjSTJJdWgxNDJuc2xQ?=
 =?utf-8?B?YUQ2c0VTeHZrMklVUHh1ZTI5S3VQdGNGSmZDWFY3cCtsT0JpdHRycjN1WGVh?=
 =?utf-8?B?TXJBV3B4a0dpazE3MUpuU2lXam1HaXlPdk5WNml1OFRVeUdyaEpxTmRqWnhN?=
 =?utf-8?B?czloVVo2TTJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDMxVUcrVGRVcURJYmxvQmt0Smh5SUp4MGhMQTlIaENFMXBVQ1NmQy90YkF5?=
 =?utf-8?B?NHMxaWplQXNEbnRVVUU3bW43ajhUbXBKQUEvUGNxRmNualpLYmZFVVpDcUhT?=
 =?utf-8?B?ODV2OW5yQUN5UlY5VjJCd0ZoZEVBM2FvZUVBWFl5dzhBOThRcVV5Z3lNMGYw?=
 =?utf-8?B?bHJud2JDZE5zZkpJTGtLWmg0RWdoTndxemtjZEcrb0xLVHk4UHN6aUZ3bVFP?=
 =?utf-8?B?dlN4VlFPaWN1aTU4cm9TcHZ1WDlyZnVDallrNEE4UG9NZmVsTFBZNi9WaWFK?=
 =?utf-8?B?U0hURDNFM1lPc1JyTUVNY0NIdFdabWZ3blhOZnVVek5YUjRrMHF5TCt0TzF0?=
 =?utf-8?B?ZFlGaWxkL0wycEdSVlcycWtSUWpTZWNBbWF3R2Q2VnhNN1Rpb0w0OEJlemR3?=
 =?utf-8?B?T2ZkaGlMNHFaTXhKQm5WNmdnei9vTms0TzJvTEFCL1FHZUpmU2NBUHdNQlhE?=
 =?utf-8?B?cFJEdll6Z0dPMno1NGs1bFE5K0QxalZ2eTlwekh6QjZMbk51RGwrNnhyTmhD?=
 =?utf-8?B?ajBYTXExbzRRcGdCUmYzKys4K2NINEJvVzc0bXdKU0VQYll1UU5LcDJjTGEx?=
 =?utf-8?B?WTl6d3pqL0t0OEx0TUlvQnBrcjJHZ0hQUkRTNjRRZUI1Qjl2WjVCOVRPaHB2?=
 =?utf-8?B?VC9sMlRLNGdUMXhZNkw0MHF2UDlPR3BvaE5LMDJqVlFtY2w4U1lBT3Rxa0Fa?=
 =?utf-8?B?VWZVQ3NiOUJPWFhvVjAvOEVqWGU3T2Z4S1pFWFlHV1lCYzlOazdISm9HWXor?=
 =?utf-8?B?dHNIZVA0NnVxNjFHOGVBdXpNRWZxU0tBbFgzMVR4VDRiZTloMlhabm5NQ0hu?=
 =?utf-8?B?TlhsVzFOeDZKVU1GUWNvYzNmSWtTSXN5YUd5WElNVkFwV0I4T05MZ1I5Yk9w?=
 =?utf-8?B?dEk4VjNLOHJDeitMSThtWXFjM29XbjYxSURGVElDcU9jMnc1Ym51M1FuWTFp?=
 =?utf-8?B?aVhTMVpUQyttNHZCZE5ibEdSSEw5aDBFTDl6QXI3amM1dmN4Y3doQncwcURW?=
 =?utf-8?B?U2l0OXR5clJmdTZCdmJ2UlJKcXpaMU5NRUdva2xFcjlzb2J5cUppeXVxNzdY?=
 =?utf-8?B?K2lRMDhzRHllQXJPS3I0MlJ3WUpISFpRbThWSnZOTEgwOXdpS3NTQVhrMGVa?=
 =?utf-8?B?Rlo4aUFlS3VFZlE2bHA4dUpCRlFyVGtZMFVQNTBpZUNmTncvM1lOOGpocFQ2?=
 =?utf-8?B?SkFweHp4ajNGY0dBY3RsN3NYOThYZDVHNlVOdnRRWXhIU1RxUk9ZT05Jek15?=
 =?utf-8?B?K1VnM3VXZW0rU1ZJbHJUbm5DZmF1RlF4UVJxR3VJbTVER3FhMmFITS9zcnBG?=
 =?utf-8?B?ZXRjdlZLQ1htU0cyVE9xZHhjYTIxcTJnQzFyMkxsY0orYmxKbTh5dmRXUzJy?=
 =?utf-8?B?NHdLY2M0WUM5a0Jab1RuaU9LU2JQZ3RnbmMzaGUvMGQ4UTVyOXQ2bU9wSmlD?=
 =?utf-8?B?eGpkWFA3NjJQdmU1elgwVnZmZFVPN201WENLV3gxc2dteWVJRHZqa0FtUjE2?=
 =?utf-8?B?ZU1uZ0QrbWNkTjVjNi9ZR0VIUjNoSkVQWnV3Rk5WZlYvWjRQRGtUNUZvRVlO?=
 =?utf-8?B?MHVITHhKZTBMQ0JFek02ZFNNV3oxSEJrNEtFbXErMFZyclFNaXJUaUVhNlE3?=
 =?utf-8?B?encrVFNpZEpoTG1ydW1DUTB3ekxjNStRNHEzejhzZmNQeXdWQkg1aVR2TlpH?=
 =?utf-8?B?SVB0SHVYVjVIQk9ES1lhaHpzL1MxVElFbDFYM1l6czhZa3I3YVZIQ1hRcE9H?=
 =?utf-8?B?eHJKeE8yWE92TUI2TGprUGJXcTlvU1FMZG1IV3pLcmV0WW4zQzNrTkx2UkNI?=
 =?utf-8?B?Ymo1SUcxelF0cUFhbkhzaW5JcGhCbkd5cXlsNFRGVm56M1lKdzAycG1tK3g1?=
 =?utf-8?B?WGdta0NBb2lBZXAzNVJWbHRiV1lsSE14TXdHSFo2dzk4ZmJqalJpbFNoRktY?=
 =?utf-8?B?U0cwUXMxTkdsS2FKNVBJUklXangrdzNLcnVJOGxianBmN2thbVlreE42cWxZ?=
 =?utf-8?B?Vm1uUzV5U2M3OGE5SzBLUzZSMWhxZzh3S0I2TGV4SEZmZFlCQlhCbU5ZanBs?=
 =?utf-8?B?bmlDVi9sd0I5SjdMYlVvTWpoem9yeTNKcHBhQXpjVDBJM0Z1bDExaFlVVE9r?=
 =?utf-8?Q?APk5Vv6w2i86elOY38ka7aVFj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9427fa6-894a-468d-553a-08dd3fe85455
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:43.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjuYLdUNBh8tHWD8P3DPwVWon3uCIs+IWi/2gQaunxG5lmm8o2zj9J+hKwACHmas9pbpPkSWHu64Fs12nyswgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

parent_bus_offset in resource_entry can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

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

Term Intermediate address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne from v8 to v9
- use resoure_entry parent_bus_offset to simple code logic
- add check for use_parent_dt_ranges and cpu_addr_fixup to make sure only
one set.

Change from v7 to v8
- Add dev_warning_once at dw_pcie_iatu_detect() to reminder
cpu_addr_fixup() user to correct their code
- use 'use_parent_dt_ranges' control enable use dt parent bus node ranges.
- rename dw_pcie_get_untranslate_addr to dw_pcie_get_parent_addr().
- of_property_read_reg() already have comments, so needn't add more.
- return actual err code from function

Change from v6 to v7
Add a resource_size_t parent_bus_addr local varible to fix 32bit build
error.
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/

Chagne from v5 to v6
-add comments for of_property_read_reg().

Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

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
 drivers/pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  9 ++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1206b26bff3f2..a0c8e6f66ec4d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -413,8 +413,10 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 		res->name = "msg";
 		res->flags = win->res->flags | IORESOURCE_BUSY;
 
-		if (!devm_request_resource(pci->dev, win->res, res))
+		if (!devm_request_resource(pci->dev, win->res, res)) {
 			pp->msg_res = res;
+			pp->msg_parent_bus_offset = win->parent_bus_offset;
+		}
 	}
 }
 
@@ -427,6 +429,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -448,6 +451,26 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (IS_ERR(pp->va_cfg0_base))
 		return PTR_ERR(pp->va_cfg0_base);
 
+	if (pci->use_parent_dt_ranges) {
+		if (pci->ops->cpu_addr_fixup) {
+			dev_err(dev, "Use parent bus DT ranges, cpu_addr_fixup() must be removed\n");
+			return -EINVAL;
+		}
+
+		index = of_property_match_string(np, "reg-names", "config");
+		if (index < 0)
+			return -EINVAL;
+
+		 /*
+		  * Retrieve the parent bus address of PCI config space.
+		  * If the parent bus ranges in the device tree provide
+		  * the correct address conversion information, set
+		  * 'use_parent_dt_ranges' to true, The
+		  * 'cpu_addr_fixup()' can be eliminated.
+		  */
+		of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+	}
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
@@ -460,6 +483,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_size = resource_size(win->res);
 		pp->io_bus_addr = win->res->start - win->offset;
 		pp->io_base = pci_pio_to_address(win->res->start);
+		/* In case ranges in pci node provide wrong information */
+		if (pci->use_parent_dt_ranges)
+			pp->io_base -= win->parent_bus_offset;
 	}
 
 	/* Set default bus ops */
@@ -739,6 +765,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		/* In case ranges in pci node provide wrong information */
+		if (pci->use_parent_dt_ranges)
+			atu.parent_bus_addr -= entry->parent_bus_offset;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
@@ -902,7 +932,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.parent_bus_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start - pci->pp.msg_parent_bus_offset;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d0a5f75effcc..909b14986660c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -841,6 +841,15 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 	pci->region_align = 1 << fls(min);
 	pci->region_limit = (max << 32) | (SZ_4G - 1);
 
+	if (pci->ops && pci->ops->cpu_addr_fixup) {
+		/*
+		 * If the parent 'ranges' property in DT correctly describes
+		 * the address translation, cpu_addr_fixup() callback is not
+		 * needed.
+		 */
+		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
+	}
+
 	dev_info(pci->dev, "iATU: unroll %s, %u ob, %u ib, align %uK, limit %lluG\n",
 		 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
 		 pci->num_ob_windows, pci->num_ib_windows,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ac23604c829f4..483911ab9e629 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -380,6 +380,7 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	resource_size_t		msg_parent_bus_offset;
 	bool			use_linkup_irq;
 };
 
@@ -465,6 +466,13 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * This flag indicates that the vendor driver uses devicetree 'ranges'
+	 * property to allow iATU to use the Intermediate Address (IA) for
+	 * outbound mapping. Using this flag also avoids the usage of
+	 * 'cpu_addr_fixup' callback implementation in the driver.
+	 */
+	bool			use_parent_dt_ranges;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


