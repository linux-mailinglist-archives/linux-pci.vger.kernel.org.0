Return-Path: <linux-pci+bounces-17291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15D9D8CBC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F19D285FBB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8238DE1;
	Mon, 25 Nov 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fp1u52Qu"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF42F2D;
	Mon, 25 Nov 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562238; cv=fail; b=ZXV+tel2Y9gvwz5x7LvlhA3BVZwSmze9Y2SlXxAbTtJpq+aq5aqY/MuFR2bIeW6aGw/GzZCa1Xw997BjHZPLd9kQsW0uiZCBRFX9a6WpQc9dQNplmg7coUSe4f5iKOM1VuxBCk9zj4/BLPt3w0s9rYaNZwSV/V3hupQw+v77zrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562238; c=relaxed/simple;
	bh=cZnfox9LgGMDJBnzADg5ZGZH0uXlBemJpapApJhBrm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvkWJowsjwcapIRIMXq9mIWAXvbYDa+uRGF7eODBz2RoIuSB6wL3EVYUFFjMCTNyYSeTj0oSiophv3b7U4hqDuH3R44KcVn9p+Rd/vn+Z8GWz+Dwln16Wd0aa0Qy0OORgxHN9A2OBJzwRauEe1X6yDlF/xdSIjvSdFCiseuMSLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fp1u52Qu; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3rgrhSEbKOjc0qeF/OvfvRPG9VDY9lEZSO8Onc1jqWKiDkaPSHKlGkSuoDsasQ619pEoF8EB+pTvgg5Y9A0dep6+DQDw+W8HXzPfVppdlwO4g44giRCqZ8R54qqrSstEG7Ve8q7F8HzY0oFFb19PwLgjtkebwQqOCsusrni7zTtkefo4fsDdjz2bwgE2uVdf0AVTBX7BhHiwX9iTA7uhPU4YYIFuQIPx0PLp5+nW1ja2pjQ0bNmd6MpvpNOlZADxo91ycOFYfSAvCAQ6gFRtukJf99v+LNf2MJS4ZIu2Qriwc00Y5ZJ4JbwTTvyaGIuZKqVjvja08ireBrLe9yUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZnE3GHC+yGO52r86RESr/pLV7xAQJCFbj0lR0TFXcM=;
 b=yGT7NmSRVsLz3uOWoatiC8DCGkaE5OqMPPeeI/2fwDzr42pmEbHoIhFZNMQaPv5XEd/JLi5vU3i4+aTMNEezRrOyLyBLQpP1LXZ1e05AtRHAvra4Tl2T7FhHIXJk9xwFco98n0E0M6PjLKZRNh7tb4KI0iCz1leCDtaKapXaoVS37z3z7dSc2r6e5+puI6Xe9V7kPt3LqhMs95pf0IfhfJGRXyXei6hZFk7Gltk9ebOvwGPUYjdGGLmjvqU55jK5ZI1GFNfxJNOnhGUsyx4AJDfjmEcMzkeRK6wW4bJTxmPpZWDKg+MfjFZaT/xgDWVZa+ItPLahEqB6Rx8KXBNNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZnE3GHC+yGO52r86RESr/pLV7xAQJCFbj0lR0TFXcM=;
 b=fp1u52QuTRqi6n4knPbJ2RRGwasCmz+2aprO0aTDJcViI6I1JOORU5CSsXjyCGzzl5XeIRrv7wKtOnB4DdgpJ6qRlPHAUxrRVuIaroSC45xtRoeSaSxepXEHJ3KuP9rjy0azzcLeqS3Fh7JXsTEH90m/2dHhN9iu/UM/+c3wB6tNy4vScNbn8JNKukzpGyW7MjOuQRzyXkct0+Ud9fd6SDT2Is5oJ4x7SBbfR8EWBVMXdG4CqqZVu/PpD+zB+1Xn+HQ3IyDdiaya241mEoyayDE5HLY/XfPxS++garuJ5Yen5aqwNkx9ytztz3qA2dx5Jjz7R4iyRSSeCQNdlEPw6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 19:17:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:17:11 +0000
Date: Mon, 25 Nov 2024 14:17:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <Z0TNMIX4ehaB+mSn@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-4-6f1f68ffd1bb@nxp.com>
 <20241124075645.szue5nzm4gcjspxf@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241124075645.szue5nzm4gcjspxf@thinkpad>
X-ClientProxiedBy: PH7P220CA0115.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b784077-8046-4314-f98e-08dd0d85c365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTByT2tIUGphY1JiWmM4eVVPa2xtVUZNbi8xSzRYNVQ3VjcyTmRXTlVSaTk4?=
 =?utf-8?B?dm1veWhlTFF0TklHMjZzZTFsbVlCSkZ2VmtvT0lMQXdOV1A3NmJTZlI3M1RS?=
 =?utf-8?B?K0l3amdNVktEVWNXTHBtUjBzQ3pucDFxcU9jMmNQTlZlMHZqcFFiMnplNjRG?=
 =?utf-8?B?SUlVR2dkbVdMWXhmRnJkSUh1cldrcEUrNi9LT0JucnorRmlNM3ordmtWbC9q?=
 =?utf-8?B?b2x3NmE5M2k3UUhpWVdDYXUvb1NERGV2NlRiWE8xK0RKVFZ2a29iYU1mNUZx?=
 =?utf-8?B?d1p6UFFVKy9vdy9sOGhjRWUyQ2ZoR1JOTWJVZVl5UGVBZHZ2OEVVNUZ5bkJr?=
 =?utf-8?B?M0c5R2tUMVdyRzlBSk1LdWdSdXMvQVVDTTBvcm9sNUpjS25SR3cwNlUxOFM4?=
 =?utf-8?B?TjVnR1VOSTAzaEtpTC9ZN3FXVmdoTEU0S3MxNDMxNlMxSnJ0NzVxaVVQRWpL?=
 =?utf-8?B?cExtUXYwWW9XWk84OWQvUVYwd3ExK0pHMTJDTHdaUXNYazA1MDYraUdCVy81?=
 =?utf-8?B?REJDbW1lbVo2bU9JVDMyNXFWYmZrNEdIRFV6UWd2aTBtbWF0SDBpMUtvN0l3?=
 =?utf-8?B?c0xsOWtCbS9YU1p2Z0xPalI3cElqZHNZNGFLM2RYUmpuTmhOeU1oRzllZy8w?=
 =?utf-8?B?WW9zSlhuazViRE50dCtucmNITHN5UWxCdE5VejRBOXVoTTRQaEQwYWYya0ZR?=
 =?utf-8?B?K0Rnc3R2U1E2bmpIalU0dGprUCsraUxlYmNTTDZZR3dWQVRSOFlMV1ZWb0RK?=
 =?utf-8?B?OXhYSSs4dVV3M2c4VVNSMDA2cjVOOEwxdEhlUnRacGRhS3J0cW91anhMNDZ0?=
 =?utf-8?B?eGpwRjdYSS9kZWR0dE8wL1RkMWZYTzRaT1NMdVJMczhLbFo5SGF6MmVobEN4?=
 =?utf-8?B?L2p4S2J0bW04WEp2d240ZjhuSUxKNmN6QUxhc1VYZi9EdHpJTkZOejNYUzJo?=
 =?utf-8?B?RkJMWkNObW9ibDE2SmJDbnI3d2xBTVRkQWd0YUpoNnJlRTN2L3VseVlpazlr?=
 =?utf-8?B?NEpWOCttRERoYnZvc1I3WXNrVUFhcC8rYS9haDUxMlZUOG42Znk4cGpXSHI4?=
 =?utf-8?B?dld4TjQwVndmNXNJZHRvYko4MFRsSWtBZGdVc2ZRWitFMndhbkYvZkZzZ3kz?=
 =?utf-8?B?T0NsSDZvdy9UMU93S2hsVFNNQjVaODdOMExxME14ekE2bDZvL3BMTE9WeGox?=
 =?utf-8?B?djh4d0pHZXQ3bzBlaTQwb0VYVVlyQytsaFhDNW1OOExIb1lOV3VoNWl5V1Zm?=
 =?utf-8?B?NWs3TXM0VTZnWWt4cHlxNDFuNkdZVkV2dUxrSVhyMk5TY2tBY084TENxR0pi?=
 =?utf-8?B?Yy9kNTdwWnA4Yk1OYkNwbzFPYWMyMjh5UjhxMU8rRlQxOCs0WmtTSDU2UlU4?=
 =?utf-8?B?VlVOMzdDREo0QUhENG9WWDlGeWU0a2h3OGlPSUNhWS9XS09ESDYrRndDM3ht?=
 =?utf-8?B?N01wSTVuaGN1RGpuQjVoZ0dRQ2VLUkNJVXUyMVgwNTR5VzFBamRCbkJ4dkZ3?=
 =?utf-8?B?c0RWbGpiMS9GZDA5TmxqamJ2RXdEMmhBOFJ1SjE3WUtBNER1Mno1cTJrM0NN?=
 =?utf-8?B?b1lHTyt5VXpuWUdXTHJRR1J0ZjhnSXpaRWwxSWl1VjlmUU1HeDFGUC91ekxu?=
 =?utf-8?B?VzltWkVETnZ5SnorM2JITTI0TVNXV0NoY0d4bTFZV1lNVVJIZGtVYmlBYjdW?=
 =?utf-8?B?ejZXTTA1ZzdhQm5vUjZ2RjdBWlJPL1VhUWF2VTRoZERwbi94dCtsTmtDdjlR?=
 =?utf-8?B?cTdyRURBTXpQRFJwQ3dwTHV0Q0wza3BYdkJ1NVFYSGNwb2MwS3pZSlFubUtx?=
 =?utf-8?B?V1M3VGV3OFVuQ1ZQWWF6RHhHK01mVGJTUUJ1dHhHK1JNTkQwNWVDck5zM1Np?=
 =?utf-8?B?UlRoTUJ4TjJuRmRuRFF3bU05bEgzRmFEOWJYbURrbnQwblE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUtmVTRlZUFBU1YveWlEb1EyWWVQSHI0bVZGUkUwR09WT28rSTdlWjRuVExk?=
 =?utf-8?B?a3puenlFdVByaTNtblNnTDArRW9CbWp3RWFwVnVQQXUySUpZY3g4d3crbXhI?=
 =?utf-8?B?RHNWNDF4VTkyZ0xKSVQrQTFaVXdkNkdmQTVLNFhWUnY5TlVVWHUrYWxoaUNJ?=
 =?utf-8?B?RDg4cFlhSFNXdGVNbFdDWURMZkM3YXpmUUUxSmlJRDNGR0RQWmFpQWMySTlD?=
 =?utf-8?B?NjBFTzdTSkhJWTVsY2Ztb1ZTQUFidHBRdUFNU0VWbExtSXFKN0VJVTRDV3oy?=
 =?utf-8?B?UTQycXFWMjEvNGZORk5PNW9jTVkzdWowb0tSNzRrUHJWU2RXTE45RmRIaDAz?=
 =?utf-8?B?RVF1R1lXM0l2U0FGNTV4cm9mendreTlqc05sSk0waDFWRmpTRDhVQU9XeDEr?=
 =?utf-8?B?S2wyckhnL1ZHNk1ETTZWMnd1ZTNKeXFKTkhrb25mL0hYNVpHeU80Tk10ZTJS?=
 =?utf-8?B?cHVwRXBuVjVEaDJ5ZU5DZmRNQjJ0RkRHZ2Y5VzVJRGhMRVJUNEQ5aWt1Y0pW?=
 =?utf-8?B?NGxnSVhPWHJsT25SMTZzR3NxZlpVaEl0cVc1Nkg1a1JvMVpEWmhpaFRUMzQx?=
 =?utf-8?B?WEg0QWRjU29LTXVwT3JwLzloMFFucWEwRkx5b29KZHZlcHc3Q2xVLzA5a1Bx?=
 =?utf-8?B?K2k1SnZKd1FFZWszdzV0cFUwVGh0QmgxR2NaTHhsQjIrdWwzUUlvVnk1QUoz?=
 =?utf-8?B?WldLSXhKYks1UnZCVnp5dUhMc25QUnlnNDRTeGVzR0tlanNuZ2pqR2YzUk0y?=
 =?utf-8?B?OTc3aG5rQUtHWm9MV1RqbVV6eGZSeHUxaHBBSFF1V3dXeGhzV3BKZ3FFVGcz?=
 =?utf-8?B?YlEzeVNzRGVLUE4xUEwrNmFXeFE2SllKbTVkWnZHRlJ6czE0SzVwWVRQTHRz?=
 =?utf-8?B?Tm9FUFFqUzJ6Nm1XaXkxeEs0dmk0MHU0SFpVRDVjamlBbXVydDBuazRxWlQ3?=
 =?utf-8?B?Qld3Ky9NcFRUTTRIUGd4bGovWFg0clpCaEJOT0YxUmRGQUVycm5yMWJzQmc1?=
 =?utf-8?B?TzdnY2RYb0xxU2xvdERicjBnQUNZdjJmM25wQURIMmFsdytKaTc0c2J5MXNZ?=
 =?utf-8?B?bGVsTlZuS1FSRG1yVDhBMXQ0aDFCalkyVUpuQ1JaT3A4dlBTUHlUOWJJQW1N?=
 =?utf-8?B?aDNaRVNkM1NxVXl1Mm9aK2lEWm02SWdPdUZYZEFzMkRCeXUxR3Nab09LWHJB?=
 =?utf-8?B?Y3NwWHhTT0kvcVZLUEkvY1VTYkpuMTl4Ky9JMkVCWFZiRFdUSUdNSTBQTE5M?=
 =?utf-8?B?RTd5c0hUN3dhb3F0SE12QXFUTmhXYlVEVlZaV0l6WDQvUFliMzlaTHlBUVZi?=
 =?utf-8?B?S081bmFnNnNvWExqSjJIVEZ5dURTMjhxN3VFMG5BNFlCRjJrd0dsTzgwdkZa?=
 =?utf-8?B?WTBhZHBHbTh5cVFVMGpSeFEvcmZaTjhTeTZieDdveEdBb2FadWljVXlhK0hk?=
 =?utf-8?B?WXdTSHR0VHc4ZDg1OVlGVzBYR1ppNUhlRUMrSFhWRzBQT3pMZUVmdmZmcVdr?=
 =?utf-8?B?c0RDODI3WFNuQXZjaGg4NHNXSitvcFgwcjB6aVg3V3NqOGFKbzZDeDZRMnRK?=
 =?utf-8?B?UitnQ3p1cTNESFlmeVRwb2RCSy9YT0s0K3MvRW5MQjlVZVN2enVDN25oMnl5?=
 =?utf-8?B?MmZSQ2ZWL0dSRk9MZ0Z2NW01NFluQ0xBYkkyQTY3SkdlaEVwN0orOHBDQzYz?=
 =?utf-8?B?alhaMU13ZWk2RWZHR2VvUm5QZEx4cWN1UWRKcE9FQXdLalJSQlNhVVE4NlY5?=
 =?utf-8?B?L1lWMyt6WkUxbFlORE1tNHQwV1hxQzc4dlpvelVPVXlSbGlqSHRQR1dkdmhJ?=
 =?utf-8?B?WFdreUtTQjY0SS9CeGsvQVNEb3hoUm5hdUJMRUt3MkhEVXZiKzJWWGVXWEc4?=
 =?utf-8?B?eXJzcnduaEhYbmUwMzkxZ293UzNzUEZuSmV2Vk9PaFJ0Qmc5SEM5S3QxUVBQ?=
 =?utf-8?B?djg5U1dXRm8yOFVML0pDQXAxZ3NxajJYQk5lQlFqTUtDQndFbWprdmFOUTJW?=
 =?utf-8?B?cWdHV24zaXlzVGIwN2dVTEVWRmloWFFncHlBVmNzMVRjYmdkZmlPV0ViQm9P?=
 =?utf-8?B?ZUQvdW4zV3pUU1UvWGJXS1BCZDV6cDFyK3ZvRXJ5YjEwSWp6NWJiNVJ1ZDg5?=
 =?utf-8?Q?n1ks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b784077-8046-4314-f98e-08dd0d85c365
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:17:11.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szOj0FZJ8BWsJry14ITndc8rHs3Kqyvr+moaxXDCmuDWpxx/z6sNc6mQOoEmpClx1bzVN0jUEZ+fMbPu8nHbFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8487

On Sun, Nov 24, 2024 at 01:26:45PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Nov 16, 2024 at 09:40:44AM -0500, Frank Li wrote:
> > Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
> > along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
>
> I don't see 'doorbell_done' defined anywhere.
>
> > doorbell address space.
> >
> > Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
> > callback handler by writing doorbell_data to the mapped doorbell_bar's
> > address space.
> >
> > Set doorbell_done in the doorbell callback to indicate completion.
> >
>
> Same here.
>
> > To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
>
> 'avoid breaking compatibility between host and endpoint,...'
>
> > and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
> > to map one bar's inbound address to MSI space. the command
> > COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.
> >
> > 	 	Host side new driver	Host side old driver
> >
> > EP: new driver      S				F
> > EP: old driver      F				F
>
> So the last case of old EP and host drivers will fail?

doorbell test will fail if old EP.

>
> >
> > S: If EP side support MSI, 'pcitest -B' return success.
> >    If EP side doesn't support MSI, the same to 'F'.
> >
> > F: 'pcitest -B' return failure, other case as usual.
> >
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v7 to v8
> > - rename to pci_epf_align_inbound_addr_lo_hi()
> >
> > Change from v6 to v7
> > - use help function pci_epf_align_addr_lo_hi()
> >
> > Change from v5 to v6
> > - rename doorbell_addr to doorbell_offset
> >
> > Chagne from v4 to v5
> > - Add doorbell free at unbind function.
> > - Move msi irq handler to here to more complex user case, such as differece
> > doorbell can use difference handler function.
> > - Add Niklas's code to handle fixed bar's case. If need add your signed-off
> > tag or co-developer tag, please let me know.
> >
> > change from v3 to v4
> > - remove revid requirement
> > - Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > - call pci_epc_set_bar() to map inbound address to MSI space only at
> > COMMAND_ENABLE_DOORBELL.
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index ef6677f34116e..410b2f4bb7ce7 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -11,12 +11,14 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/msi.h>
> >  #include <linux/slab.h>
> >  #include <linux/pci_ids.h>
> >  #include <linux/random.h>
> >
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> > +#include <linux/pci-ep-msi.h>
> >  #include <linux/pci_regs.h>
> >
> >  #define IRQ_TYPE_INTX			0
> > @@ -29,6 +31,8 @@
> >  #define COMMAND_READ			BIT(3)
> >  #define COMMAND_WRITE			BIT(4)
> >  #define COMMAND_COPY			BIT(5)
> > +#define COMMAND_ENABLE_DOORBELL		BIT(6)
> > +#define COMMAND_DISABLE_DOORBELL	BIT(7)
> >
> >  #define STATUS_READ_SUCCESS		BIT(0)
> >  #define STATUS_READ_FAIL		BIT(1)
> > @@ -39,6 +43,11 @@
> >  #define STATUS_IRQ_RAISED		BIT(6)
> >  #define STATUS_SRC_ADDR_INVALID		BIT(7)
> >  #define STATUS_DST_ADDR_INVALID		BIT(8)
> > +#define STATUS_DOORBELL_SUCCESS		BIT(9)
> > +#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
> > +#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
> > +#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
> > +#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
> >
> >  #define FLAG_USE_DMA			BIT(0)
> >
> > @@ -74,6 +83,9 @@ struct pci_epf_test_reg {
> >  	u32	irq_type;
> >  	u32	irq_number;
> >  	u32	flags;
> > +	u32	doorbell_bar;
> > +	u32	doorbell_offset;
> > +	u32	doorbell_data;
> >  } __packed;
> >
> >  static struct pci_epf_header test_header = {
> > @@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> >  	}
> >  }
> >
> > +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> > +{
> > +	enum pci_barno bar = reg->doorbell_bar;
> > +	struct pci_epf *epf = epf_test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct pci_epf_bar db_bar;
>
> db_bar = {};
>
> > +	struct msi_msg *msg;
> > +	size_t offset;
> > +	int ret;
> > +
> > +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
>
> What is the need of BAR check here and below? pci_epf_alloc_doorbell() should've
> allocated proper BAR already.

Not check it at call pci_epf_alloc_doorbell() because it optional feature.
It return failure when it actually use it.

>
> > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > +		return;
> > +	}
> > +
> > +	msg = &epf->db_msg[0].msg;
> > +	ret = pci_epf_align_inbound_addr_lo_hi(epf, bar, msg->address_lo, msg->address_hi,
> > +					       &db_bar.phys_addr, &offset);
> > +
> > +	if (ret) {
> > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > +		return;
> > +	}
> > +
> > +	reg->doorbell_offset = offset;
> > +
> > +	db_bar.barno = bar;
> > +	db_bar.size = epf->bar[bar].size;
> > +	db_bar.flags = epf->bar[bar].flags;
> > +	db_bar.addr = NULL;
>
> Not needed if you initialize above.
>
> > +
> > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
> > +	if (!ret)
> > +		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> > +	else
> > +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> > +}
> > +
>
> [...]
>
> >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> >  	.epc_init = pci_epf_test_epc_init,
> >  	.epc_deinit = pci_epf_test_epc_deinit,
> > @@ -921,12 +1010,34 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = pci_epf_alloc_doorbell(epf, 1);
> > +	if (!ret) {
> > +		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +		struct msi_msg *msg = &epf->db_msg[0].msg;
> > +		enum pci_barno bar;
> > +
> > +		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
>
> NO_BAR check?

This is optional feature, It should check when use it.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

