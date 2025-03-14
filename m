Return-Path: <linux-pci+bounces-23759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC7A614BB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D0462037
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FD20127C;
	Fri, 14 Mar 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dsvvf2L0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49B1FF5E9;
	Fri, 14 Mar 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965693; cv=fail; b=Y1uYL1rddW/2J1h9FMWAD6Ttc2CKZ2uZVNnq5cD25HDzfAGtGtbEdZ8EeCpl2fhlhMpoBEFnX0kzbK6Zc0mIPA0YV56FAr9sPfO2DHTXgehEYvY7nYSYR7EgVnPo4La478nk2IfwxiUcVeBVsxg5FCjdui4n2XHvZAaKE2eekHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965693; c=relaxed/simple;
	bh=qyWr60b+ZQlP+HS0RRkqX5bzbrtasjnsMl5YaGDnBc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QZcLLjOoePItKYIGcGSra86XOLju0DYzy7k8PNa8smgkykdOM3GvRXnrVKq94oPo7R8/4/ZQnXPEcofkyW/lBdNhtenRrtXHUvRU2+k1oUgDAdozH69lkHLV4Dj1ngF5lLsKi7xSd2HPcK0Zncd189xvIcWJo74PDjSixxsiwwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dsvvf2L0; arc=fail smtp.client-ip=40.107.104.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQQSwGd8pZyavo5aXpviwFDKRt/Nt64HK0b/E8UTBsdQPIMIwYGBgqHKpCmSht/06ZzZUkOc1p6LUvFdFeONPMZoOYGaHxPxADxkgbOZC7UDkBBfNfSV4neyZ4FXBtA5LO8rlkexj+v4XXCc4AOS+k6tPjtAwSGAQxf3kcr+at3cacKkuH/Gqq8c29FPxVqon5kqSKuodn0QSlM2erP/Iu665e1QsqxghlGCph43P2YgZ53Y5Z+YQR8pmNHivJmvoDnMmfO3OxzD5DDBeKvHw+1wADAkOWeAseeQTsjfqSqDkc4+i+DxRsZITFUjY1HIpoSvDVgev+/c1dhgBHWMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WGgGvw6iyrbWzJ0QgoWSQYUGlUlN4FpjqhqNYngZl8=;
 b=otJAJ7F1aMF47ZF+3Om2O5jGZwYUzghqHxakmcl7gZsSnfCBA0PQEkiBIPkip/iq1+7gBINJu54m6rv5sDODyDQmMprHb7nRbHNfk9chQIKfI0/aOgp24S4DqWbtiaaqNW22Zi7eGbVvxPHAgTVv2tDibAWssANIIdpQwytKAQYBpfaIfW9enCOkktofZckjKXJCbDrvizueGj2EtrRHXqFZsCUMx46X4JMrahQGtL1WZt9Fe4/Rp19z5r98o7Ya756mnI7EOWLIRrCIdkeOclJmCGqlORnu4G7QUjE+yOWQG9/wOEfwXqqam1xAQlCUcLGcBHZCaLpS9bFZaPYdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WGgGvw6iyrbWzJ0QgoWSQYUGlUlN4FpjqhqNYngZl8=;
 b=Dsvvf2L0K4nlczdBd7V/dLa5wfT8FGANnkI++ujpDEN4+3SgqpMZg9Wra8LwFyE8GJTSAdn5tQOXiWXLG56446G6W/AFpjLJqqHfQ+KvxPXBwLaYjKWw9wpLqRFEYrS5+sKrcM6i+utVEPzT3A5cq5mnnPpe1fhiNAejkL82T9+sPp2f7ukpcoPCc/snD1tEnplHIK+hTV0SXGWhB+vtYillFNmsXpoya26dTDJT4pkDtLvt5T5/HOLr2iAvZvev4nBq8HlOLp/vdSlU/VZXsAv8mhXtypAA7k0JLLhZY0KutpWxnOoBiij88ahiMCUCWilJ18PKGnvYXu9sMDfcVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 15:21:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:21:28 +0000
Date: Fri, 14 Mar 2025 11:21:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 06/11] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <Z9RJbyoFdkiYHXu9@lizhi-Precision-Tower-5810>
References: <20250313-pci_fixup_addr-v11-6-01d2313502ab@nxp.com>
 <20250313220450.GA755590@bhelgaas>
 <Z9NikZqmmnkt/GQm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9NikZqmmnkt/GQm@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: cd60f724-9e13-4943-c3e0-08dd630be429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0xMTlZpOC92TlJVaFFVbFNCRXMzaVNmUEorWjIvWHNrckJUTTNCdGYxeEov?=
 =?utf-8?B?aHVrQWNwVWdZR1l3K2U3QXpWZGRIUjdxYjRJWkU2SHRGQlU2WG5hcm4wa0lR?=
 =?utf-8?B?UUlyNjcyUVdrU0w3UUkzZjBjNFgyOTdtN3lPV0paaW5lZ053T2Q2NjRGNnJQ?=
 =?utf-8?B?VlBNdDhZTm9rUWlsc1ZZM3Y2S2xVc3NwSm0wTWtXbUs0MzJYcGN5SmdBMjBy?=
 =?utf-8?B?dTl5amZqVEg4QWhseEVyQzdqSk02NTVUZDVSV1pRenFYRjhteTUva0FuV3l1?=
 =?utf-8?B?M0s5dUZMYlYrVVlublU4YkpidEVkSUlpU3dnNkJvdmFJUXZCZGg4eHVKc1hn?=
 =?utf-8?B?MlBKZlYrVFVLTVIvZEtmWWgrNUN0djB5YzE3ZGhNLzRrZnA1czNRQUVZdWFR?=
 =?utf-8?B?bmJ2dG1uNjFVU3BhZVg2ak9sRUIrcWFqd0I5MUVtNTJySnpQdU5QMnVjTDkr?=
 =?utf-8?B?TkI1eGQwMWtxcFY4QU5WYldkc0loeE5CNWY0WXVGY2NtK1pYaHVOQVhxRHhV?=
 =?utf-8?B?V3RsUlpPR1FIeGkvYzhKR1VJaGtCdGIyZENqNVVBK1ZFb25qb1AwVjdqNi95?=
 =?utf-8?B?R0VFdkphVGgrNkJ2MzdXQXRMM1RsWUdCQ1BaZU1temJqWG9CNjFZczE4aW8x?=
 =?utf-8?B?WVYyZ2gwVzhRSkZzNExUekIvb3lONXVCTVZycHVGU285U0NabEpXMUdOcDcr?=
 =?utf-8?B?c3Q3MXJnK1pOOU1lSU9ab3Rjb1RyR1VRVGZ1UlFoMExYUXI3RXBSeXM2NGlI?=
 =?utf-8?B?WFFuM01zQW01bWVsVUZQMVpMOWdTNTJCQkxKNkF5SzA2TnVtQnFna2ZrRVpB?=
 =?utf-8?B?QUxGM2U2SFA1UmRYTk1rSWt6dHcrUlV1em85U285ZW8rbXI1cytBTzhGTjU2?=
 =?utf-8?B?OVh3Z2VRQXNqVHN0M0lsWG4zTndjWTdDQjRuQXlvNWwrTkc2Y3NmS09mZmFN?=
 =?utf-8?B?RjVTSngrenpXRE1RZEkrUVhEeUdEamx0cEowa1dFTjQwcmswNzZkS3pxSzFX?=
 =?utf-8?B?YWx2OUZpeTE4KzgxOU56aU9FWDdzK3FNVDNBZUFLR1BLWElLUTVVKzc2TDhE?=
 =?utf-8?B?MFRDMFh4VXV3MmM0VDJCWER1ei94ai9xWVhtdmhqRlkvWStIMkFJMXJlZkMx?=
 =?utf-8?B?TmZmYzEyNHhSaCt2dVljd3AvcnR0TGZsbGs2Z3JxeGpvMFBYb0UwalF6eFY0?=
 =?utf-8?B?VmtyR0ZCSXQ2VGpWZjMvQ3JUckREcXBsbUlFeG9QK1RMeWtyWlAxTk5aM2Ri?=
 =?utf-8?B?RFNsMWJpQUVrNnBoOUlsVk4xUlM1K0V0TGhVZDZJTG9nNXlwREhFMHVPUUhL?=
 =?utf-8?B?ZzFDdWM1VDVDdlA3eGFpWklpcEFlajRnaWcvMDJnTTI0dnZJUXFucWJOZ3F4?=
 =?utf-8?B?ZGZiSGFYU3V6TVlxbXhqc2FrTDBLYy9lWmREVlNHM3BTb2R0VDgyS253TUNq?=
 =?utf-8?B?R2R1T3p0QXY5MlBUS0I2Wkk5VzQvbHVXQTBua0NRclYwQ2pGM01UWTA4a0Ev?=
 =?utf-8?B?UnlyMzhmc2VpdW45dWgrT3NIdVFGNHh3Rk5IeHAxOXN1WVpPWndac21SMWph?=
 =?utf-8?B?cjNPOUk2WWNwWG9aTE11Y082UHk4SCs2VDc4MWRIVU9OTXZyeGsvRFBHQnNr?=
 =?utf-8?B?NFIyV1BIY1JEUVFjNng1SjU0bkhGNVREK04vQnU4WUY3bWZEVG5qd3NjRjE2?=
 =?utf-8?B?QzAvU29rTHdubTlKR21aNlEyUTluemdNYVVQQWZFUkQwemxQa05ad05WVHVa?=
 =?utf-8?B?d3Z1ZDlFVTFZQnhzajlSNU9vVmZJdFJmdlpvdkJrUi9yTG50UFlNQU9TUWtD?=
 =?utf-8?B?Q3c3Q0tBQWZNMTNVNTZ5YWxPNk9lOFJWbnp6dmcybWUwVHozUzdiL1dXVXEx?=
 =?utf-8?B?QU1KY00yU2hCN2ZjSkYrZURGaVlDSGVxZTFJdi9zTit2TWtIckx4WC9IOFRj?=
 =?utf-8?B?cnpGNzFwM2MyeEV3OHdBcGRZMzR2OW4zUVJTQklMZ3dBbnNId2pYeFVFYisy?=
 =?utf-8?B?WHlBMkhJSjN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtSVU9zdkpvYjRnWFFqckRSRHVvSXNVODZTUUpZUHpJSVkwSUx5YzBCSERB?=
 =?utf-8?B?bVVpNVVQa2R2bVN5NHRlRnBkTE1wamxSK2E0a2M3dWtNVll2YS8yOHNaYndu?=
 =?utf-8?B?NjhsbHAzS1lOb0gyZGpCb2s4YzEzSGRTS1lha3FIR29nSGhBSzczU2JEd0ty?=
 =?utf-8?B?blJyQ013YVZpWW9tMCtIdGJSNHFEWllzWGFhK0wrM1FaSG55RDJ2aURyR1ZE?=
 =?utf-8?B?TlZkM3RHV2QvazhnclBCeXR0TXRyakk4OGUxelp1bXhWOVl4aE1HVStyTnBl?=
 =?utf-8?B?cVUwdHBjN1dZU0dLVzRpRnRNbUFtRG9oQ09ETHBHdTRwNnFWRGZnQmNHYndZ?=
 =?utf-8?B?NFZDOWgrZHptTFlXUUFHNTVHalZJRXh6N1FIbUgvSytUTG1WM1ZoWVc1bjR0?=
 =?utf-8?B?YmlDVS9Ja1B1bHVvcDdHVkJaUy9BZmVDQjZ6NytrQVhpRXg2UDk1RVRjTUth?=
 =?utf-8?B?S0w4bzdoZUJWUEJXOWpTV0JjNzQ5cFUxQWNCa0pDbytnVmJtTWg2TThCV0N5?=
 =?utf-8?B?SnB1OTUwTEpWZ053Q3JLWFlTWllScExVYmdZZnJzVVFsZXIxbkhGWkp5YVVF?=
 =?utf-8?B?QjBDWHUyZTlJNjZ0TDVkNnBVem56MUwvYzk1Z0NXcHAvSElVMlE0VFdOdzNN?=
 =?utf-8?B?VWtXcHZxS0hzQWl1VzRqbHpjWXU4R2c2WmtGM0p1TlkrQitLbjhsekZkL0tO?=
 =?utf-8?B?M0thVVpKNUF5SDRXa1plRHpMNjBoQ2hzTTJmWFNMc0ovd2xEdklqRHVvYnpi?=
 =?utf-8?B?S0xhNmg0OWhQdWpDMkFvb2Z6QmhMYlVUL1U2MFVKUSs5R08zbzJ5NENZRDJq?=
 =?utf-8?B?RElXZEl0VGpWNTJOTzkwajlMTUQrTkRxMUgzMjVZQXgzUm1Id1hYNEdNTHB5?=
 =?utf-8?B?b242aS9WQVNqNUU5dXZnbHhjYUNsWGNZRmRKWURHSHdzcndQbTVvZVEvZWpH?=
 =?utf-8?B?TFVndTNXU0MwQytydVFOa0ErSENRZjdpcVpvRzk4YjFxNE5SbEN4WjQySTQ2?=
 =?utf-8?B?OHl0T0llSDJUbDQxdGU2OVdDSEE5RVlwOXNHRFNrUytBV0NyeUgybjRKWk5N?=
 =?utf-8?B?eS84RE5yVE94SnU4ZWdIMXhPeGlsR0ZORlhtWlF2a2hxeG43bCtqT0wyWk9M?=
 =?utf-8?B?bUFCYzRza1J4bkJKT0RUbExuRlU2dTZYYTdkQno1MFZRc1dKZlloRTdrMTF0?=
 =?utf-8?B?ZEt3SGpRME5zTlRqekludE9saVJMM3MzeE5uL0ZueGxHYlZJNTVEMW90Rmda?=
 =?utf-8?B?MC9qTklnelJrOEt1RCswMFJhUXBwWE9maEpNZ0dCM21WT1A5djV1cDI0WFl1?=
 =?utf-8?B?NXF5eWdwOUpTMDZrSWwyTkFTSGFEWGNsT2FBaVJmYkREeTRIWmxuZkVpenZ4?=
 =?utf-8?B?S2w0QU1YNUp3ZWFXeTVJdm1IQWVIUjQ0NUwzTEhmTldvZTZwWm1IM1k3ZU45?=
 =?utf-8?B?YjFqOFZZQ2tqVXR1N1FOUFUveW1nQTVwZlcrOE9lejFEWUtxL1lQNkN1aVdY?=
 =?utf-8?B?UFJKZ2dXbGIzMDV4WldhaTgwYjdSaDhhMGczWlhZcVdabDlSYkxhenRTMVMz?=
 =?utf-8?B?RnZOdVJhZTNiQnBlaTdHWThvVXptVHUyTzJvcEsrdkF4N012M1BZRHdsbEVN?=
 =?utf-8?B?aE5oRFhtdUpGdDZ6WGNUVXdKTUkvS3I0VHJvVUtUSXhLZ3BOemdndzBhaDAz?=
 =?utf-8?B?UzEyRFp5SzZSc0RLbjFvS3JTa21EZ2tTbXdxbU9IeStuZUYzTjVKZEhONlNl?=
 =?utf-8?B?YUJOU3BteGoxUWR5NldRd1BBSkxKUnJFcUJzaEhaMDNhMEZFU21Ubm9mdWZz?=
 =?utf-8?B?OWZOV2ZVd25ZNTc4VitlS2hvN0szWnVhYlZ3MUVKSnBvUkpvL2F6cTNNa0tF?=
 =?utf-8?B?bGxnNUxqaDRYNjg4QXRJY1o4WnhYTWk1eGY0bGFrcklXRndrYm44L3lJY2Jo?=
 =?utf-8?B?RGRDS3A0Wlc3ZlMvM0xRaTgxYzVnQ1FQU3VOeGhsWWZpQkhxWEE4NU82akFM?=
 =?utf-8?B?bmh3NGlENGprTGhlS3NqZHcrbUVWbTFxU2p5TUxXNUR1b2xiVFNCeFBSVHdH?=
 =?utf-8?B?d0xWWE9MRjdMYTNOcWxEU3FRNnB6UUF5am5zVmRuOVdhWUNmblloQ1FHM2Nn?=
 =?utf-8?Q?zLNV9ZCsi8fMhJ5wf02rjOAzW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd60f724-9e13-4943-c3e0-08dd630be429
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:21:28.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwBqhN375+aX7Kl1jFxkf1E+L7rEPXrqia1d88/GueLWepM5BlOzoSgqgSPEe61KDjJIgFmqdu+WJ+VCV7X9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730

On Thu, Mar 13, 2025 at 06:56:17PM -0400, Frank Li wrote:
> On Thu, Mar 13, 2025 at 05:04:50PM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 13, 2025 at 11:38:42AM -0400, Frank Li wrote:
> > > The 'ranges' property at PCI controller parent bus can indicate address
> > > translation information. Most system's bus fabric use 1:1 map between input
> > > and output address. but some hardware like i.MX8QXP doesn't use 1:1 map.
> >
> > I think you've used reg["addr_space"] to get the offset for Endpoints
> > forever.
>
> Yes, it still need ranges informaiton at parent bus.
>
> 	bus@000
> 	{
> 		ranges = <...>; [1] /* still need this */
> 		pcie {
> 			ranges = <...>;[2]
> 		};
> 		pcie-ep {};
> 	}
>
> >
> > I just noticed that through v9, you used 'ranges' to get the offset
> > for the Root Complex (with "Add parent_bus_offset to resource_entry"),
> > and I think v10 switched to use reg["config"] instead.
> >
> > I think I originally proposed the idea of "Add parent_bus_offset to
> > resource_entry" patch, but I think it turned out to be kind of an ugly
> > approach.
> >
> > Anyway, IIUC this v11 patch actually uses reg["config"] to compute the
> > offset, not 'ranges', so we should probably update the subject and
> > commit log to reflect that, and maybe remove the now-unused bits of
> > the devicetree example.
>
> We use reg["config"] to detect offset, but still need parent dts's ranges.
> There are two ranges, one is at parent pci bus [1], the other is under
> 'pci bus' [2].

Beside, luckly dwc use reg["config"] to indicate config space. but dt also
define ranges [2] under pcie node, which can also include 'config's space.

cadence also use reg["cfg"] to do that.
res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");

I am not sure why both choose use reg[] instead of [2]ranges under
pcie node. But the result make our situation simpler.

Frank

>
> Although use reg["config"], but still need ranges [1]. And information at
> ranges [2] also need be correct.
>
> The whole devicetree example also validate to help write address translate
> informaiton.
>
> >
> > I do worry a little bit about the assumption that the offset of
> > reg["config"] is the same as the offset of the other pieces.  The main
> > place we use the offset on RCs is for the ATU, and isn't the ATU in
> > the MemSpace area at 0x8000_0000 below?
>
> No, "Bus fabric" only decode input address from "0x7000_0000..UPLIMIT".
> Then output address to 0x8000_0000..UPLIMIT. So below 0x8000_0000 never
> happen.
>
> >
> > It's great that in this case the 0x7ff0_0000 to 0x8ff0_0000 "config"
> > offset is the same as the 0x7000_0000 to 0x8000_0000 MemSpace offset,
> > but I don't know that this is guaranteed for all designs.
>
> So far, it is the same for use dwc chips. If we meet difference, we can
> add later.
>
> reg["config"] only simplied our implement base on the offset is the same.
> But whole concept is unchanged.
>
> Frank
>
> >
> > v9:
> >   [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
> >     https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com
> >   [PATCH v9 5/7] PCI: dwc: ep: Add parent_bus_addr for outbound window
> >     https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-5-3c4bb506f665@nxp.com
> >
> > v10:
> >   [PATCH v10 05/10] PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
> >     https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-5-409dafc950d1@nxp.com
> >   [PATCH v10 06/10] PCI: dwc: ep: Add parent_bus_addr for outbound window
> >     https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-6-409dafc950d1@nxp.com
> >
> > > See below diagram:
> > >
> > >             ┌─────────┐                    ┌────────────┐
> > >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> > >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> > >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> > >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> > >             │      │  │             │   │  │            │   PCI Addr
> > > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> > >             │         │             │      │            │    0
> > > 0x7000_0000─┼────────►├─────────┐   │      │            │
> > >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> > >              BUS Fabric         │          │            │    0
> > >                                 │          │            │
> > >                                 └──────────► MemSpace  ─┼────────────►
> > >                         IA: 0x8000_0000    │            │  0x8000_0000
> > >                                            └────────────┘
> > >
> > > bus@5f000000 {
> > > 	compatible = "simple-bus";
> > > 	#address-cells = <1>;
> > > 	#size-cells = <1>;
> > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > >
> > > 	pcie@5f010000 {
> > > 		compatible = "fsl,imx8q-pcie";
> > > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > > 		reg-names = "dbi", "config";
> > > 		#address-cells = <3>;
> > > 		#size-cells = <2>;
> > > 		device_type = "pci";
> > > 		bus-range = <0x00 0xff>;
> > > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > > 	...
> > > 	};
> > > };
> > >
> > > Term Intermediate address (IA) here means the address just before PCIe
> > > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > > be removed.
> > >
> > > Use reg-name "config" to detect parent_bus_addr_offset. Suppose the offset
> > > is the same for all kinds of address translation.
> > >
> > > Just set parent_bus_offset, but doesn't use it, so no functional change
> > > intended yet.
> >
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -474,6 +474,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  		pp->io_base = pci_pio_to_address(win->res->start);
> > >  	}
> > >
> > > +	/*
> > > +	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
> > > +	 * so have to call dw_pcie_init_parent_bus_offset() after init
> > > +	 * pp->io_base.
> > > +	 */
> > > +	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	/* Set default bus ops */
> > >  	bridge->ops = &dw_pcie_ops;
> > >  	bridge->child_ops = &dw_child_pcie_ops;
> > >
> > > --
> > > 2.34.1
> > >

