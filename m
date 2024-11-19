Return-Path: <linux-pci+bounces-17098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A509D2F04
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587E21F238C3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E61D47DC;
	Tue, 19 Nov 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxGHMjg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526271D6DA3;
	Tue, 19 Nov 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045509; cv=fail; b=NploMD06MX5ihWnGFu2Hij4JkUdxCPGRNoux8ep+J4XNnHqcxlKSlGTaTiCxztLOfHAn+DUkydrgGwvTWjIpvnhYvf7amk4t4nyhTn9L44kc3zfM5rL604Cq8I2rurvO2m7Q1tVhts/TJqt5yZqxeKosllSE6gttMQUfhFQbKKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045509; c=relaxed/simple;
	bh=I1xS6x/bVgth6uCt4K17fnxBjFtfeZ9wcN/vlP80bSs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FReRVLzA4R7AgNV3nyltF81OOAeguUFkRArbCVCH3GyJUfIyq7BdL2WP2MfC3M4ZAyb2tCcyjmTSANqCFogbcJtb794FYCFFmBPhxo+DbYScn50h7E9UoOoAOWnzYBBTTTgieohMHVupmroof8vTAHWUvhC+HRVOPL1aGIS69Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FxGHMjg5; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhZiQcpeQzQs1p9cAthpkGgw4seZ01YkUNc/1ZTOFettsOmPI5sWlVPhVf+bSQ+/h8zSePRNVmtsvPjyU+U18bDaxl/FUoDAWKw7X8M1iMmfWd7V+9SbRYnvx0G0dAu3CQ0HNX8ABOEgFQ15NXmblhMgJW6+IvlqRDnm5KyZHGLzqK3ivyYrzY6+GGR21nAb0EyJ4vKyGEPl0aBpMe0rJqWrEPMITE8qE5JNV+M9acFTQPm1yigEMwn2f2uDV8spUczmREnJLQLHrl2zVz0RQqZNgnCV53PDK07DvBaLTB6k7kW58bcyl7sHJ31zvaNmRJRzZbuAHhJcHCtQPw4FFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayvkn6j5ctMor6f5EgGeTcwZhVoL9kYC9Om0+bxxxyY=;
 b=teuODFJ1GCYdO7Zp6yybrrpR5hUTCLM2KlcYY77sN3deLpOYZvb0TRpFobo9RWBvsUUQj3FQfc84KCLIW/qt0rUzZsK9AKPct/yw8wmRNEmjwXxUEG4yQRTJCoQcbWOBdvNwimM1TDDxqZwBGfLqoYuo510jIXfFTSbNtQp2N958T/hmXRZphHehDLdqHSIu81XiciSfbRTODatDfpVq/3dWrBEnd9Es0co1ghmx/xI/CDEc60WsuE54sqCdtn+pJVINtN7baI1qJEHqrQoMFk9VpSUgsKaKxtQ9GNyBQU3yDFYmj9RaU6o2GdM+IM27eUVOF2RO91v7VbV5j88Okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayvkn6j5ctMor6f5EgGeTcwZhVoL9kYC9Om0+bxxxyY=;
 b=FxGHMjg5kA/qrGfXCAKc1XNJ1yl867ATuns5FtCzzToORztWt0ugonCGpjPrjclGo/hdtirDTynhAf4eZK3sA8lFf2CwfdGPAI+aq3N9tJrFX0aHBbAAY17cP5i+KjpeMhHC0iRbfer7JzO0JOZUKuFPTkGcwkFBZHEC95rr8st8UcHwYvuvQ2T1DhfcJmuprtcO+iwX7sg25Zrnce2Ndbsf8uV/jvZnGOsgd3fTs8s+o/3O0UrwRoQyHqwiAK4H6GI0b2Gqpi2inwKGwv9z7TgnOmrSc5mxu3GXwtXZ1XD1vFDS2IylEJ6DhG6dz+WJ+AhKqyyiIy0UoFAR9UgO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:45:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:45:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:24 -0500
Subject: [PATCH v8 6/7] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pci_fixup_addr-v8-6-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=1266;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=I1xS6x/bVgth6uCt4K17fnxBjFtfeZ9wcN/vlP80bSs=;
 b=tM6zs543BtrgjN+85Ni4hJ2pKwjs7eBwgMkk2DbgBE1oEAHzhCwHvhLAwLFVdTcqgDQe2qwb3
 8xYSXCRa+xuB9yGDIQJoUsUZiD4KiTkVuFOsSBOLJDW02QUIYO24EYF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed88dad-ec27-40a7-6370-08dd08d2aa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW9mcDYvQ3Z0UnFhM0NvVklVTEhXTVBBeEx4TW5taWJKdlFKdmZSL0twVTFP?=
 =?utf-8?B?SkhJeTBsd0NheEREa0NXYUdCMW9VR1Y5OTEvckxDUWVSQ1JMeFNDbXBJeU8v?=
 =?utf-8?B?WU5OdVIrZUdFb3VsNlN4aW1OaVhmTHc3eEhLL3o4anhBajdLQis1UmxoVzZn?=
 =?utf-8?B?UnJNeVptNm9uTHhQdW53emNrL0RSZVY2TEhsZzh4MFQxNHpIMlpqWWFYamU0?=
 =?utf-8?B?MDVxUnhtN3hkd0k5Z2pjZ1FkNWE5QTA2ak9yZmNKRjV1bzBzdGNtYWRFU2xa?=
 =?utf-8?B?OWdLUkhRNXIyNFEvdUF2QzRURG5Kck90QnlVNUMwK1ZrQ3lsWVNQNEVteC9l?=
 =?utf-8?B?NFlvYzh5ODFCVHZVNURKY0hoVVBsQXVHT2NRL092TytqZm5GZFY0WmlnOXlt?=
 =?utf-8?B?U0E0TjQxWVV0QnJ0N3ViS3Ivblk2Tm8vYWdOME5oKy9CMTRodit2eDh0QnVP?=
 =?utf-8?B?YmthZUVobTFISjMvS1ZjRGpVOWpyQ3pWdm1jdmozbG1sclFHUjZRbjZqL08y?=
 =?utf-8?B?UGEwcUZjTDhPN2VtUHlDWTdWZ1F1blloUEtXbkJzaC9DMTBabE1ONTJIQUdw?=
 =?utf-8?B?eWZTbm5XaTNlZGYzU3lLUjhLamVxK0FoSUNMbVJkeXdNVkUxTWd1RmFwcnVO?=
 =?utf-8?B?NU8xUVozS3NCVlpmUVhxUGNQaE81YlNQdk9qYkE5b0crdTdqWmU4S2Z3T3pp?=
 =?utf-8?B?d2liWnh0eDBLZ0FMOWxaUTVrc0s1TGtFbnNoOVVXZWtsK3Exc0VMOUpDVWwz?=
 =?utf-8?B?TDNpbjI1RU5zV1dXS2JjL3pqaVlaSUpXOWlidmlSZGNkR1NYYitkRjFwcE1G?=
 =?utf-8?B?VnNsYTViVzU0TnFmQkpIZGZEaWRmczl0VUVtRkxoTEd1QzhmTHEvaWU5WnpI?=
 =?utf-8?B?RzFCQUpnZ0ZhUG0vejM0YW5KTW5XL1k5QUpBVVkvaXlLN1ZIR2w1aXBOR05Z?=
 =?utf-8?B?TzJheGF1MHlQdG5GN0J4YkU1cW9od1Q1T0NicmJYemZxWGFUejY2T2pGZUtr?=
 =?utf-8?B?TGtLazlUZ1d5SXRxNHlyNXFBeit6ck5XdElkZmJ6cyt5dk5Wa216OHJzV0lV?=
 =?utf-8?B?RmhaWkZlNnpBa2I0MFRseWNVNG5QUldranJ4NVZlSGNiTnZjMFA3MDJnVUZw?=
 =?utf-8?B?V1F1L2dLeTZRcktWQ2J5V1lpdUlHdDV5LzRlczduN0xNaUJaK2dneXZBM0hl?=
 =?utf-8?B?V21BUndrakhVTDIrNEVLNFJhTXd4ZDNsNTNsckpZM05nNXRhM0lJTXVZR3pS?=
 =?utf-8?B?bU1KUVZrZnFGeWFDWlV1dVhIaWF0RzlVRjJIdmxjRFBSczQrWTlRN2VqdHVY?=
 =?utf-8?B?NWNiUzhjcEpFeURBdlVLclo5SXZua2ZJS1IreHMydEl1bnV5M2NuN3FxNnI5?=
 =?utf-8?B?K2dKMWVUSjErbUpoQS9TUisra0VqK295aldDNTRhc2pMTlMvaStqR1NNZTM4?=
 =?utf-8?B?SERJcTdGL0VHWS8wOWh1NWM5QWNwaStNNGlERlR1WExGbFlZSDVCK1E0Y1Zl?=
 =?utf-8?B?bVBUMmxic2ZTMkVWUWhPR3FyWExTVlF2dStVbGVzenpwVGZVWURUWkxoRzVw?=
 =?utf-8?B?ZWR3U1M5ZGV2NVBQSVAxa0JFSHVQeHQ2QVRIbVZsV2NiVTNIRlByYTNGQnNk?=
 =?utf-8?B?U09WcDVlMVpXNHVQWkNyc0FzR2NFeEw2U1J5aDNuUENNaEtGUGNqUWE1dTNM?=
 =?utf-8?B?azBNUytDaHlvTm5QdHR2NXlKZXYxQzA5RUNNS0RFMDMraGpSNGpmVmcxSDY3?=
 =?utf-8?B?dHY4MEhVZmtvWmt4ak1TamdPM0w5cnVMUkNKbmNIOVpOMG9SWnB4YkxZcmt6?=
 =?utf-8?B?N2VtUnEvd2U3ditoUGc1ODR1TVN4cTh6WUFYaG0rUkt3cXhmakl0N3d1RTVw?=
 =?utf-8?Q?w3GiZ3A4igvS2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGs3OVNHYWZpT0lvSm5yenhGWENleEU5cUlnRndDeVNxeFJJZWdTWFpuVU5I?=
 =?utf-8?B?T0M1SHV4bU1kRUlwVFd2QlpCM3prRU5FMThRU1dxbGdTRkFPNi95UkQ5anZJ?=
 =?utf-8?B?MTczK0NRTVZvY2JBRHBLWnVKb0hVL3liZlRFUTJxczArWk11SWlQUUQxUk43?=
 =?utf-8?B?cmJpV0hNTnlZb0lmc2E3ck0zZGs1Q2NoTW1OcHJyYVpLRXRNOENJUW9mcFNE?=
 =?utf-8?B?UDdVWEZnVXdKdUZ3cVhpbmNBbk1wUnIrUWRvQmlLekc4RkErdW9vL0xHc3pG?=
 =?utf-8?B?R2Foem1nQnJhdlpxU1lKNU4wcVQyMEM1cmkwT3BxRE80VW1aeDlkcnk3cWsw?=
 =?utf-8?B?RmRHajMyd0lYcUExQ1Q2YStmblJCQy9PYk5EVjIxUnpKM1lzY29lNGdNRWR5?=
 =?utf-8?B?QitKbXhTNmdaT1ZnM1hlcXFDVWVZd3lLY080MFhXVTBUQ1pmWnlQd2l4SmhB?=
 =?utf-8?B?WFk0ZUpVYzFyK2dTbnV5LzNrMnlRVmloRG5kS3U3LzFUamdmMXhlaC91NzVR?=
 =?utf-8?B?NmJyVlJ4aWJBUDJ6N1htM3VocFBGd1d6czIxUDM0VE14YmVpUExPaHVWUjlT?=
 =?utf-8?B?QlZoVG1iSXU1MGtSbTl3RGh0bVNLai9wWlk1RUFQTzdDa3FLY2NVdWd0QnlS?=
 =?utf-8?B?MFAxSUVDeFNFNUF4bHZLem1nenJPQTFkVkVtbjNaS1IxKy9HOHVpaCtycURL?=
 =?utf-8?B?NFMyMEIzWFZDUDN5S3l5d2tBYWRQcllOY054Sk9vSGwrN3BteUNrd0I2UnlH?=
 =?utf-8?B?MlBRTWh0d0lXdWY3M2FjWXF1WW01aGhMdEM2U1A5SmYxSFZVbzF3bU9aV3dJ?=
 =?utf-8?B?cDgycUFONFBLMm5OZHQyYVJIUDljaWFScFQvTHVMVUpOVmlsblI3ekwzSlVp?=
 =?utf-8?B?SW03b1FSVS9rVFFxeVhjc0VublJpbURkQW5FbHhtV01qZVVOVlhHUVU5MW5s?=
 =?utf-8?B?dG5VMkd5YlNqMWM3WU8zOVhmTDMxM2Z4MW4xUVdvd2FZcnR1VzVrRWVFQjRW?=
 =?utf-8?B?T3RTMkZqNzNzQ21jK0VNcUtqQWkzL0tZYkdiYzRWNEZMSzJwYTM5UmRpcURL?=
 =?utf-8?B?amlualJUc29Nc2RnQU53UU50UjNwa0JheFNQT1N2bWpYUW9IV0daZ2cvcUZu?=
 =?utf-8?B?N0IyQjlZeGlJTXhqQkFDQnRuM0RrR0h0QVB5bFdkYk9ER1o2VGlXRVo3YUZp?=
 =?utf-8?B?MVlVNUFqV2JIdkxYNEFYK0llTW80ajBrQ2pRVXNOMWM5b0JNNWs0V0Q1T0pR?=
 =?utf-8?B?aWxvbzIzK2o0WWNaL0Q4NlczT0IzNFN2L0hJNCtGelZhWUUxTG1saTFycytT?=
 =?utf-8?B?bzc0dlFqNjZKWHdvcjJhTlZ5VC9ET3h1bXJoZ2kxRDFFRWZvT2llQWdJam4y?=
 =?utf-8?B?YVI1WjU1Y2tyTlBDc0lYQVpJeGtEWnp0OC9wQjRNNyt1YVpNR1JHZjhzeWQ3?=
 =?utf-8?B?VHlyTmxuVFdRMHltTWxIbDRZSkI1d2ZlMGlTcDk5RDdzbzRXbVRSVU4zWUpX?=
 =?utf-8?B?WWwzUDQ4ZW1IWG9iMThXZGo5RTVGZUZrZ1RmUzZwSVc3Lzk1aUlDSkNWblB1?=
 =?utf-8?B?TlExYXFXb2l4cUNvMUZ2dnVDQUZucDQ1c0dOb3poQmFwalFmMVFjUXdCVnh6?=
 =?utf-8?B?dlBDNm1leEhReTZPN0cwM0lPZTVJR0FXc1FyRkRzS0hnYjJoMjU2elhCQ1BN?=
 =?utf-8?B?WWlvTDNXZzluaWhSNVh6dmRGRFJFcVZWOCtuT2lpalJwWlRRdFIxSUJmZ0dT?=
 =?utf-8?B?QUVSSEdycEgrTTE5UTVpRVBCNDhBdUQ2bjFwVERXVXlNVDRBVXNIaWF1bzZo?=
 =?utf-8?B?R3NFVXBINi9hQ2tuc2grK1haNzRQNkdZN0FBSkRDMGl1S3NGUXFWU1g0QWNU?=
 =?utf-8?B?TVNwVzBiUlBiSGttWEJEcHd0ZVlCU21Id0U5WE9xeVllWWRQRCtwdHh3dytL?=
 =?utf-8?B?NjlWT0RoR294ZGVraWRCV09iNVM0b0tDWHc4TnFQVmtsZVR6SnRBVk5LczVS?=
 =?utf-8?B?cDJ3NTNmSVhCUy9yUk53MXRWbWo2SjNabk0xR1NoZUwyN1Y5Um1LRHNMdWFN?=
 =?utf-8?B?YklEZ1d5STJuV3Frb1dqNktzQWE5ekpzcW1QSWFoL1dRelg0T3RVWmd5TmF3?=
 =?utf-8?Q?HY4niso+Rji2yI3dkrhJfOS72?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed88dad-ec27-40a7-6370-08dd08d2aa13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:45:04.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQh1LdT33bwMeG+oRapj3Qd7ecwb2EOYLWRnHTlSPHL2KKgLdpqix2VQRTfC8NUaWRRkye1ISzoc/uBz5B2ruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3->v8
- none
Change from v2->v3
- Add mani's review tag
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index cf033e672dbde..5303dfc3dbb41 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -960,7 +960,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


