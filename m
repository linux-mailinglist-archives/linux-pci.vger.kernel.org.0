Return-Path: <linux-pci+bounces-22986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208BA5047D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCC3A6409
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D7250BE1;
	Wed,  5 Mar 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Waxv3JY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3818A922;
	Wed,  5 Mar 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191655; cv=fail; b=liAqa4FhNyUAlwiFFSSRQST2Opnb2z3LgMjOn9s9+4JFsoBFwFsiFrYDUwReMMxn04jqW03fsqPUo3YvOQm17SWO+EjY52/BKQqt6bb16ND0LlnE4ZDpI9XqiyAZEo5PJTd5oP+XVIkWkqaIzfYupNLJMb1XjA5oR6y7+W5QBbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191655; c=relaxed/simple;
	bh=rMAwxY81r5cnoE5s4hqm3gUf7WOPOk2usevJ9Cbe3Fc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lRUIDtoOtjWII9MVEfj0TnpmMYDpzPb+ODQhifW6qB0x33XtSm3dWj0gv8k/qnf/Ox5AFUPE6A5ykHJ586oAsaLg6a8YxVbo+pne2YXL7p4JPYVWfcOHRQ+Nuem7u9rQbB9q3/8iPzBaz40uaRaWcF2JW/58DWn3OjVxyFHY7Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Waxv3JY6; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBuTN83YIA6kJDP4EkBZ1ZoWDoG8qjQ7d3gFSrTZogp0vnRjpae56+DaRTPvHC8l2ONZe7E2IfSMJmb3XY0TqZ2XCymCVCenVz0MMnBpJ+y2hnnakStgxijQCBNvvhHzw4Gu6KC3Id8E3MZ9sMsYoamsRcm/FNPurHUk3euk2xI8NakeMYh5kG3/zcWv3OR65L112ARV5hDwRprjCWBa74e1Duz8m7SSk3RcIUTTg2Kn6p1EgxG5xBoJndVm62VZzu8xdUklgJI5lQqOWeaAaeyPdXWvGfRcyCXNK6gdTgVME2pVrasnm9nUb6xx7VOOc9uqtId/KlQPG3VogHIKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfmWP206WT+CurGk+Y3Bm4wIo+djFMkIPFjf+mtIKy8=;
 b=MDfRgymIsXWDRtTVXaCO7Vtg7DW1KsJ4SHHLjr8+6gttvBkCJ9DDrb/YgrmdbWI/Ll5HkpHm9jWzUSJUKLp6X43i4b2VqouvC2aA2XM+/F5e1G9S/OS5Z2l1PBiC2qUDmhuPQvehFjAeTYcqRvsyTJN3GT+A+L9N1tdJGp2eBBgjfllpWE7UW5YRmqjHjl0Kbj4PQoKTjco8aJiDvV/XmAu47wYzlS3Rs1fF4ezQt/zYbB+1f2A9myHa70MSNaHg20AhiTG91SwpD3rdkrW4e8nOwFSzIdWiKXRCxGq/gU7wNYVbDhCKisxNJ4j3VvutZ9jAH5XNBci2+n4Ld21p/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfmWP206WT+CurGk+Y3Bm4wIo+djFMkIPFjf+mtIKy8=;
 b=Waxv3JY6d6rtH0wC0uu9eMplRRrpo6G4z78CI0TxrFivLQxgijfbidjpm1L7ot2jNWWdeW/+ArLGzoGHX+OUdA2aRlEnZ1VizcDDSGocY8VgXxF5Z/UJ0fZiZz8BKTuMM93t4484hxm18i/CN9iwfWyYV+muQf7Ti82eo8G68jWAl2hKHP/fwP1iuf74RR7QQo3MAIj6wqbxGb7at3lpNtOB2YH5bIt5uIgwjWSIjIC7HX3R3qZdugzATUQo4OQzn9/zSQj7708Tz/7e8ozgAH9DnCX1hX/NtqbYbWmn+Be8VRtHzpZn165JTM2jsx4fL5Jkj2EvQYxonkmYOMzdUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DUZPR04MB10039.eurprd04.prod.outlook.com (2603:10a6:10:4d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:20:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:20:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 05 Mar 2025 11:20:23 -0500
Subject: [PATCH PATCH RFC NOT TESTED 2/2] PCI: dra7xx: Use
 use_parent_dt_ranges and clean up dra7xx_pcie_cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-dra-v1-2-8dc6d9a0e1c0@nxp.com>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
In-Reply-To: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741191638; l=1775;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rMAwxY81r5cnoE5s4hqm3gUf7WOPOk2usevJ9Cbe3Fc=;
 b=mVYiylEvT4CiDbtNNM8GwKGYWGNrPDwNAn3/WiYpy2srJ6Hqy8dXA9gQf9b2+IpcGeLRk6DsH
 Qt26IZy+PLyBb9rrBngxXFG1rFGWs99tYuhKQXOelOxavGZ5Yzs4pZ1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DUZPR04MB10039:EE_
X-MS-Office365-Filtering-Correlation-Id: ef61f8d1-aa43-44da-a1ee-08dd5c01b1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R09vMWV1ellRM1k1UGVDZFNDL2djUEF2RGQ5RWZRd1dOV0tIc0Fucmk4bDVu?=
 =?utf-8?B?aHo1aG53NzEybHo3SXY4WnpCN0tYdmVSaXJ4WnErMTU1ZHNpVUc3ak9MV2lz?=
 =?utf-8?B?c1M4Q1JhR3NLRjRSUnRnc3dWY3RHN011T2NEdk1lVk9rbUloUE11bm1PNE90?=
 =?utf-8?B?ZzFUOUF3SlZrZGk2NE0xUUM5T3Qva0k0c1BVbC9vTjgyUDhEMVYrckhMQ092?=
 =?utf-8?B?aUdLSnk4SE1zWVJIaFFSNnp5Vmt2VWVIRGxHa3Z6VTNJcjh1Tnd5aXlZbXlZ?=
 =?utf-8?B?MTIyK1VUUVhDOTNlSldscmdFcE9uV1dHM0hxSzlEbWU3eHhiTGVGNkMyU2hZ?=
 =?utf-8?B?aWphcjhSZ2UrdzJuRGs5b0pTbmlBTmI2OEhZeUhCc0Y4dU5FZmg5S2dQN1c1?=
 =?utf-8?B?K0M4WG9HaXpiVy9LVTlnamhNNUgyV0VzTkQyYjc3enhvbUg0L2ZFQ3NFM1Rm?=
 =?utf-8?B?MkRGRUdsY1BMS0NYYmxmb0d0cnUzTHprSHA2SnB3NXpFN3R2UGduMkhPWE1X?=
 =?utf-8?B?S3dmYTM4WUFraStCc3JTWEVIU1BPYmtod2dhRkpGcUhkL3ZlNHR6Sjg5alN4?=
 =?utf-8?B?V2pwL0N3YTNhajdLVmh3aXY1QjhyL01MWk5VUWhiZ3lSczFvQnJTMGZXYnFw?=
 =?utf-8?B?Q2JCeFU0N1QzZHB0RVRYamlRem5xWXBYcEc1dHo0ekZzcWVHcUwycDdjSU80?=
 =?utf-8?B?M0xsaTdOOGhyODhXeENlOGNwM1l3aXVMTk5jb0xSeXBoZ05ENWVtNWhTU3pq?=
 =?utf-8?B?VE1hNHp2Q1ZQSXdzVloveVNRUkFSUHpURHA4NDZYVnFnUExENkViV29sMlY0?=
 =?utf-8?B?QnVvZDRiOFlnQk42K1doaWxPek9ydmxFdkRacUFYbDEvL08yOXdLYWp5L05i?=
 =?utf-8?B?L0xsUEJxR2NLa3c2dTFyYndTNDZQUnRIRWlQc2F3dnplMG9Ebng4Q2JaZW9w?=
 =?utf-8?B?MjhpVVdCaWFoVFFMWHg5RE8xOEVSYlNiYUtWeEhQOGkzVnhyWWV0Q3o5R0ZO?=
 =?utf-8?B?QmVUQk8xcExBZXVsTDcxTzZhN1ROMnpDR3o4S2M4Y3d4anJCUVlYV2FDaHRJ?=
 =?utf-8?B?czdWbFRtZmZFS3YydktpVFkrYWY2ZllrcGpPNW5tMXlZOXptZElibHpUdUdL?=
 =?utf-8?B?MmZGVGx1TXl6MW45SHR6TjFLN2hzSjJ1Um95cE9qRU9EazNTLzkyZ1Q1N0ZS?=
 =?utf-8?B?TXNSYnZzN2tWaG1XSHM3VDNrQnkyT3lmMEx2TmxrME5sdFduL2ZRMzRHOWVX?=
 =?utf-8?B?N01WckFwLzNOM2tmdnAzZUVFTGhPVWdQQjMwdEhvcklCQzFtdGY5T3lleURk?=
 =?utf-8?B?L3pYWnVIRUZONzNEYjZkRGRYUXRIZ1o5VWJpRjB4YmpBSUdoM2R4QktNYmNt?=
 =?utf-8?B?bHJGRTBuWUdGb1RwMnUwOW9JdW1SakFJODdYaFBEdFZ0RHQ1N0c4WWt5dWVS?=
 =?utf-8?B?aEk3YkdoaGsxR1Q5ajFlS1lsUSs3eENNRUoraGxaNVU5THo4VTEzeFdwcmI2?=
 =?utf-8?B?Z3ZyUXdtZk0wZHVDbGVqR3dlQ0tqRUZnV0ljUjJ6aWtlV2FMRUFiWmVQeXpR?=
 =?utf-8?B?QVdWNlpLTStKSk5DLy9vczJLVW5hSUdSd2JLeXM2RVRCWDJFZDY1ZXVkWkFm?=
 =?utf-8?B?MkhoaXNmNmY2UGkxTFpYKzJCQW03a1h3TFRDb1k5aTF2UXpWKzBJQzZsZFVH?=
 =?utf-8?B?aEhlZzlHTmc2Z1NtZ2IwUlFtblZWUU00aG9kWkdTTlhHT0F6VWVpSTZtMnFt?=
 =?utf-8?B?VERzV3l2K0l6cWJWN0NQaXNxdnF6b2dYU0RXMVRjTk4rQnNwRHB3SG92bzBs?=
 =?utf-8?B?QXRINTBvdC9rUHZzdEhvdXBMeVFMK2Y1ek9jbGxodFcrVnl3VnhVQWtJL2lz?=
 =?utf-8?B?S3dBaDVvUGhKcFZ5cUZpaThTQ0hqbkJDblFYeGVsTUw0RGUwcGNYd0QySkRy?=
 =?utf-8?B?b1l0OEZmVEhUV0Q2Tk03ZkZJQnhBYnBCZm9KVGJSRUQ2STRleTJzY25lamdq?=
 =?utf-8?B?cVkzcWdHeUlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXREYjlxa1c3VndDeWVIWTd6d0Z3QUtKNktRbzRTMGRlU0trZk8ySHJUZXZC?=
 =?utf-8?B?b21GYlJmOFBtMUdoeU9BSWdtbDYya2llU2V5eFQyODkrVk1sRkZXV3BSbzQy?=
 =?utf-8?B?RVg1SlVLWDRyQlRZakYyaVJKQkFJSGRxMXdING1EVXZ6MjF3TGlCVkNuTWth?=
 =?utf-8?B?UVk1bGFTTW9zQmgwdEFWeFRDTUlOMEprMXV5NjY4MmhXdkpVUnk2d0VBc00r?=
 =?utf-8?B?Skdhak94NlNsSlIvYUZ1dFF4cS9oK1IyNEhNZGJMWTZqakYzejVZOWtjU0Uv?=
 =?utf-8?B?alRWVnlEQ0xYVTF2dGZ4QTZMc1lXQjZDSDRXMjZyQ3VRRUZYQittZmFrTVdL?=
 =?utf-8?B?R2FiemU1NThpSHBnWFF4L2xOd00wZmJLSnlTck5ZTjJ3NGl5bnc1UFZJOEN6?=
 =?utf-8?B?ZnhBWHBBT3hkQldNRWRoQ1dCcm4yQVczN1NoblVxOUdJSGVJWDVIQ1c2dFUx?=
 =?utf-8?B?YjNVQXZHQzNIS0pZbnJQZ0tlVHl0UEVIaWVVRjF6czhmcEVuRlp2Qyt2b1NG?=
 =?utf-8?B?d3BNYWhraDk0cUdlUjM0cTNaUkdzblhmeEVpcGV4VXFXc2ZOZk9xbzQvSytt?=
 =?utf-8?B?RzlNVlg0L1RhVnpjY0JmV2E4d0tjdEY1K3JScFMxT1Z4S2s3UGhmb3lOVXJn?=
 =?utf-8?B?ODdOdHoxYjhzUkVlQjlGWWNET3g4RVV6NkYza0o4SGZwZytyVlV6YU1tMFFJ?=
 =?utf-8?B?aTlra3VkNEVZSndlMFd5MzVWUlR6V2FTWGdHOWtaOHhleDJQVXR6RjU0M21o?=
 =?utf-8?B?UERTVVQ4TWhTN3ZaWE5EdERRdndSZTFmTW9sb3QyY3BMSHFSTGhzWTdwMi9i?=
 =?utf-8?B?WFN5c1l5dkN2NUVPcXZEYzN3bDZVMEpsTHRKYWpuZTdxRUl3NDU0QmRnRjVL?=
 =?utf-8?B?aEhWOTdhd2RnY3BCc0FrR1RWazA3NGNUdjl6TVdWSFdBQkNpelVrQlF4RTB6?=
 =?utf-8?B?OUpyUHo4ekYyQWc4Wms1Z3ZJWEloMEU2anE1MW5pYmo0UTdpV0dIdlJHaFUz?=
 =?utf-8?B?d0o1OXVmUjJOU3V0YTl5TjVDLzBUQlFUemxpdlJodWN2eWFneXFRb0YvL0M4?=
 =?utf-8?B?YnNEOHVWMmd5NUNMVlFuTmtWUGVINVJITjd0SmtxbkhTVDVhNzNnMFY5RlpM?=
 =?utf-8?B?Uy9pS0JLZG9admNac1pvVU1OSVMzYkxZYmRNeklXdFpHQjlGVjlTWkdrNldy?=
 =?utf-8?B?KzBvTHRYY08rVWVjYWNya2pMWHdyT0RRSUI1R3EwM0ZWMkNCajhjaU1EK0Jt?=
 =?utf-8?B?M0k0R1NkSnYrdVRHdjBObzViNG5PRk1TNE1jeFFEbm5IRXU0VFRxMHgzaHVw?=
 =?utf-8?B?L0lPc1RjQjF3aTIvM3hBMUt5Wjl2eHpmM1dYU1VXaUFqNEtlMXo3enZJNjRJ?=
 =?utf-8?B?R0hWYUFHRktDUnExcVdOR1JiNnUyWTFXTW43ZFY2b1pUNUlCeFhxYTBrNUU3?=
 =?utf-8?B?MFBJWkVVdWZPemlkZGpPVk5qZ0RxbnM5dE50TFhYL21FWFg3VmE4cTFZZ3lT?=
 =?utf-8?B?NUxBcVpWT1l0b1k1VjY5WkpWK29Nc0RidXhiWFlyb01PSjMrN0ppVTBMMmFp?=
 =?utf-8?B?d0JmMWpQYlZ6UUIrMDhUSXlZaWZzVjBzK2VDaTlNb0loOC9rMWp6a05TaHEx?=
 =?utf-8?B?K0hRUlNnTVBPcUlTZFAwOGJPK3I4bWo5NXFIV0VuUVFEU2NSb3pnT08wVWQy?=
 =?utf-8?B?VU5CUjk5UUZZT2MvY1ZFRkFJbXhTYkV4SVl2dnc4VTNRNURmZ3Rjb1NSMVVr?=
 =?utf-8?B?RXNkVnFURHVGTThxQXVxdHJ1MWNyZ0ZuSk5vaGp6QjdjMm1qMWxhUnA1SGMz?=
 =?utf-8?B?WGNUcG9sa0JKODFTb1JqMTRMUUxoVUFWekRqRUlLZVdZNmV4cHZvQXplNzFo?=
 =?utf-8?B?c09LQU9GanVMbmNRTWptTUc2WEdPYWJtWWt3b01vSCtKWmcvY0s5WlNDKzlE?=
 =?utf-8?B?ZGpOblVoOTVMbUV1QWtTU2VOR2pPQWpCbklDNVRUVjR3QXR3VVoveEVJSzI1?=
 =?utf-8?B?YlV1RlVSV3BLS2ZzS0NVTG5OWEUyc1A0UERxdGk1SXhJVHNlM2lrMmNKSkMz?=
 =?utf-8?B?QThBdDUwMHNKVG51bGVtMGdFRi9TRWRUeDQrTjBWMUNzdDFSVTBGOHdRaDll?=
 =?utf-8?Q?KLe2vey2JFou0+RxoJWx0sy26?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef61f8d1-aa43-44da-a1ee-08dd5c01b1cb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:20:50.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gH5tiyH7DaLstIFzNUip/La2io+Zq2hpND7SyrQ7dXHpO+sgd2AqbijUZs09wVhaDG9iBEJ1hLWYq0QOyNK0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10039

Remove dra7xx_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
address translation. Set use_parent_dt_ranges to allow the DWC core driver to
fetch address translation from the device tree

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 33d6bf460ffe5..d6e0bf67a07b3 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -72,7 +72,6 @@
 
 #define	PCIECTRL_DRA7XX_CONF_PHY_CS			0x010C
 #define	LINK_UP						BIT(16)
-#define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
 #define	PCIECTRL_TI_CONF_INTX_ASSERT			0x0124
 #define	PCIECTRL_TI_CONF_INTX_DEASSERT			0x0128
@@ -113,11 +112,6 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
-static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
-{
-	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;
-}
-
 static int dra7xx_pcie_link_up(struct dw_pcie *pci)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
@@ -514,7 +508,6 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
 	.start_link = dra7xx_pcie_establish_link,
 	.stop_link = dra7xx_pcie_stop_link,
 	.link_up = dra7xx_pcie_link_up,
@@ -712,6 +705,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
+	pci->use_parent_dt_ranges = true;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)

-- 
2.34.1


