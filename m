Return-Path: <linux-pci+bounces-19798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6CA115ED
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FDA188B7A4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02428F5;
	Wed, 15 Jan 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LI3t2dVo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F07801;
	Wed, 15 Jan 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899790; cv=fail; b=Ay/Vek9Ubr/2CtHkPdtWkRGbbwSrmhWNwnHaukbla7XYEdlCAALPWtg6zF/kMMuEW4GaBTOv3ovPvNNy1sjOaKLoNWJSjSAhP40DnCfR1msA914+nBfAIfcAIv7OiZFoqzZANr2EWF9AAPlE/s31+TSSAAgLw1HyIBuyoAFoZeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899790; c=relaxed/simple;
	bh=+K/jsmwG75SF9AD1tXeXYKTQkRlAtFyEkYDT2KFkwyU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6qTHTQhQT0EB/lZgpwgQkPX3wUF1nfsb7O2SiXrhfjEn1YOFmMKXyyqKx1WzRudqwoWpn/cGdQ+dw4hKUTHOG/21FX4qYrip6uuANNi9SkKFxDaC6MICpoGvj2VvB8F1zp7jvBH0sNOTyz8AWZocQnOHf2Ou+NYQ2Pxpx0fMHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LI3t2dVo; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQy+QbYh3Xdauifl/kK6HL1KHDkCmFMsxI3g1BPuXmVYdjoMWPqAK7IQUahj3aoPIqslFOEXlkPV1E404rDZxELb/za8rysGYCfFdLQ2j/57P6my1OTEySG/tV3xUIO1pRA2b2KAAm+d3XvICHSpe36Un6fv4bicWQccyKaW6oeckACg0jRvnls6Z1xJPJ/YB8zi6MKAHXxgMkNr24/gTVGm+WIbYMq9vr34syg39NM+7whzYV+IYlGKtUe0MVoJAYstVys9dMOVsk/Y1JEA+bnj7jio0i2FoFZW9fnTq0rDbAaqiR1l9Woz6HX5MM9Qc3ZlkybEaLMIDT8jRLBKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhpUmhQmueOq5r+M+sOyvigQSoPA12zp5IlLGyIop5U=;
 b=mcY7R1Lhe+UX4uUXqs/jsKzsYBoESbpJPj/P1AawPLUJ3qIpqBh7o4S+miRGQB6aAqjkiaI39XAXExcnjLFspUjt5HwbLSYQPY5BfbZAnLeIZ8qoqbosWhjKtcybMBMyEmwPKdF4NJB/hFGVVVSIKO2C2cM0/OdegPUcMMGZH8bTzVQ4d6nbmZtSz9nfzaIpOj8VVPlIXwUN+5fRawQS6uZFOQmXC1pdb8RFsUjq3IUye5YSgtrvYlntC2mPiRvnzRyFfq6hO/1aOzagi9UHg8oWZbEhawlDAXrKlyNeTIw9WmzbsRsRyoBERzA+K0Nvp9kkgU9mSbtTETpfqGJiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhpUmhQmueOq5r+M+sOyvigQSoPA12zp5IlLGyIop5U=;
 b=LI3t2dVobxJLvThQh4cgOUc6HHhCHsd+VYZWf4+UkXHoHsOe6XT5YuVJzG6xNU6ujMNhJ2CCjWEIdETJjvFx+Z6rsLIR38WMAYJUveujjq4hSraveVX+YLFo6lQyX+eNjT6l9zyt/cKzbKvALB+nAqeS3awxpVm8qlXmjMX5XUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Wed, 15 Jan 2025 00:09:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 00:09:46 +0000
Message-ID: <ac566e54-3b4e-4fd3-8290-35141410f574@amd.com>
Date: Tue, 14 Jan 2025 18:09:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-17-terry.bowman@amd.com>
 <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
 <e3df211d-b699-401f-ac00-1715f7a2d15f@amd.com>
 <6786f7301088a_1963352947c@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786f7301088a_1963352947c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:806:d0::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: f745705c-89cb-489d-bc93-08dd34f8eb30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFUxdjJMREJTVkRtUzJ0TnJuVzRVd0U1dlZiMnhrTC83Y1JHeVFrOWRSZmth?=
 =?utf-8?B?NU1TOGZ5YTB1VXpEOElyc04yOU4rMkxHTXVWbmRYaEQwWG9HUDYrTEovUitv?=
 =?utf-8?B?cWVseC9jZXpLN01KU3hwclBvb3NLcncwNDN5ckNKZGtWME1Ed3NUQSs1M1dq?=
 =?utf-8?B?MC9hUml0VEYrbms3TFZjSVdVN1Uydnk1dTBOK2hGb0dkZHhCelRIZDdjYUNu?=
 =?utf-8?B?VFBRcElqcmtRa3F6TERSQTExQkpNblFUU3FhYWZBcFFFdjUvWmZPbnh1aS83?=
 =?utf-8?B?Mmdzc2dpaTZ1cFBkbEJTbC9PTURSZHNRVXFLMTZjRDU1QnNEREtxK2xucWxx?=
 =?utf-8?B?dFFZZG9JZEprdkd1cEhwNE1mV0ZhYzdHeDE4dkQwSzVTbis0cVlwWHFESUlw?=
 =?utf-8?B?VjIwb0VHcTNSMnFnY0xoUFoxemFhZDMreTlIa0pBeWNia3VVNGNkc3VTNDBS?=
 =?utf-8?B?WXdRNXVyQmVTV0tvTkE3eVZDWGRpdDIwendMVzVmWlBjZW9VOWJQdzJJckdz?=
 =?utf-8?B?QTFMWkd2TEQyZDRhMHpvSGRjRUlzNi9IcHR2N2ZoMytpTWY0S3FhN1p0SmMz?=
 =?utf-8?B?OW5VWWhPN3ZCTmdHZGRmU093NXZPQ0YvMXpObUdxaCtSWmJBNEt1bURabnN0?=
 =?utf-8?B?cEZGdjBrNGxQdUpCcUJVampTN0ZreTJZYUNZRzdGZ3ZHbEZaNVZuK1BURS84?=
 =?utf-8?B?SzY0bWYwR1dtVnQ2V3dkZUI4T01peE5Cd2xRajIrMUhESE1kUjN1VjZ1b2Qv?=
 =?utf-8?B?T0d5bE9weDFUK2FscjFNbk1SNklGMWFWanpGZTBtSjArWk8xNGdlSHlDcmkz?=
 =?utf-8?B?dkp0VG9mQTBxZDJsck5DT1lOZkEyaW9SYnV4bjFVcS91WmFmVnRFOE1MY3kr?=
 =?utf-8?B?Zy9PeGRVcEphSjRHdCtxTXQvS3BsWW52TEwyYXNxRHBtcmo4aGMvMjNLdHM3?=
 =?utf-8?B?a3lwNTBPSWJrNjYzNDVKbUFhLzh4RzJDa21xNlF2ZDh1bSszblFwTTNTbVZR?=
 =?utf-8?B?dDlpZ2IwbkJkYXExdlc2L2tmR2gxZHc5RVhITUFtWDJ2NHdQalo4Ylg2K1BM?=
 =?utf-8?B?SjM4QVRDT29KaDd2dk9JVVIxUHVEVmFGdDR0cU9jdkZURVlsd0lOU0NmUFhi?=
 =?utf-8?B?bXY1ellSVFo4ODZsdTg3RVNUOExQZWtzMWZWV3NCR0VlK21HT2JIczM3OUJw?=
 =?utf-8?B?anpYSllwaklZV015bTJjTytjb3FhSnlHL1BGQ0xHdmFpV1MvY0RTeGlCYUtV?=
 =?utf-8?B?bUtqRHlHU0llSUNJRGl4OUd0UzlPSTIweUJMdXJqU1NhdWlwVW83NncxTlhH?=
 =?utf-8?B?MFdFSjBjNTdqRGV3K0E1UkFQNWgrMjFVSWlSbDNUcGlBcnJJdm8vNUcvcG5K?=
 =?utf-8?B?S3Y2Wi8xblZseEZTZ1ZsK1RhdnB3dDNoaVZRM3pmMHhUaEJiTTZtcEFzdDZG?=
 =?utf-8?B?WVBvdWdqZG1OZUFpZHRqQkFSenZUWkM0OEZIb3gweEc3NHpuRDlSbmk1RHFR?=
 =?utf-8?B?RGh0eFo4MXBmNkpvY096LzBhSlpCNnl3RVBOTGllUnVML29NdEhuMENSUTdS?=
 =?utf-8?B?eEE1b2lyRG5QcDR6RkFrOTZac1owbG01dTNITTBNbDBPb0liVHd6V0VQcFl5?=
 =?utf-8?B?bHA4ZjZNMXB4cHBjZVRCOFVXZnh1SDFzRWtrajRtZmhOSTVNdHRTSSt2Zzhm?=
 =?utf-8?B?eWhzd0NMTkJJS2V0dkdtTWt6L0VMNWMvVmtlSUNEVWJUbGVRRUdERTErVVZ4?=
 =?utf-8?B?enM2TEsrWXMzRExrYkdCbUZwUmVPT3ZwVzllYm1LN2lNdHhnaU1zMWpxUlpa?=
 =?utf-8?B?QzdHYjdBY3B5ZjF2TkhyL3dpdGpMNkdvRzluMk83TjFSNENWcGEyUTZxZzQr?=
 =?utf-8?B?L0ZmUHF5YUdtdjdaL0JoS1dnYTErSG9BZ0tmSzd1NUp1R0pGMzBBUjhUYkh6?=
 =?utf-8?Q?W5LcDcoQRZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9paDFzUVJJNEpuVk55NGxKbCtlc05EbEVJUWp3WTJVUlZxM3VsdnFnQXZw?=
 =?utf-8?B?bCsrMTMzRG81aEpnbGtoQ0pvVDd3WFV1Q1U0TThCVkduRzFsSFluVXZKZUxp?=
 =?utf-8?B?UmIzN1dmSko5Z0Erbk9ReTRxUHVwaGt5RnRPMDBFMnV4ODJiNW9UQjRZYVBO?=
 =?utf-8?B?T3cvUzlvUlRmMG9EM3ZleUJreDZ3NTJVMVI5RjJTcTgzTnhEbnErZHFhb2pz?=
 =?utf-8?B?NFdVZEhBL1o5bHlnbjZXak1OU3ozN0Y5cDZpVzIrVzl1MHFRcCt1N3gzbGty?=
 =?utf-8?B?RC9tNHZiZXgwenFIc0N2a29pdjlpY0FXU1YrZjNHb3NNdTJyQVhqZzZhelRX?=
 =?utf-8?B?NVRjYmluazZmcWZHRVl2NXVPMUp4dmpGWjZPOWNiSmk4MlVUWTJWczNkZHE0?=
 =?utf-8?B?VzlMNDl4cVdQeDBOeTdJUWcxR24wNDhlQVVoNUNZVjBIbS9BOGh0cGdtdTRy?=
 =?utf-8?B?ZExhYk0xbTRlYzVhTHRpb0RYVjlLY1E4bEJOVmlrL0tKYkE4L2U3MlZ4Q0c4?=
 =?utf-8?B?SDRHRGdjR0tqZmtRQ3BsRXZxcis0UzFtMndJbE5zTzlnM0ZHdHBxTFVhaFNK?=
 =?utf-8?B?eWkwdDlPb3Z5QWdVYURSRkFtUXZTbGZqUS91ejc2Ymh0MEI0VlE4N2kwU0t1?=
 =?utf-8?B?VEZKQmRDS0RvQ2htMmVnR0Q3OU9IS25qMkdvQm5rckVZcE8wVVA1bnJ0dXh6?=
 =?utf-8?B?TG9sQUM4SmU3SG8yR1N4cC9tbXBma0x1Vyt0MGs3Y3FzQlY5aHRYZ1k4ekV1?=
 =?utf-8?B?TEJMWDF5UTIvNTdaNXIxb2ROVXFac2NPQXVGbVpnb3ZlNnR2MlJSM2VzMjc5?=
 =?utf-8?B?UWhBeDJzdE9OVVEzMnZCbjBMSWZoZ3ptTDQxZGpsUjgyTDh2Si9iWWs0ZFZG?=
 =?utf-8?B?M0F6QitGM0JJTkFzUGtwQ0d3bDNta0grQ1V2WEJtUlg4bk44NisyQWY2cjla?=
 =?utf-8?B?ckJwOGJFV3ptSUZpSFNWZm4rZWFMZDdKUE83WUdOVFN5VW4vU2JkSmZmSUNM?=
 =?utf-8?B?czdEckttVHB3dDE1MHN1L2NRZXVuWDRUYVhObHkyenVnL1FENlVwMDZmdDZn?=
 =?utf-8?B?dGp0TzdKUG5GaWxuSXFqRE9jdXA3dlpZa210ZmVxWmxrc3ZLMGFGSSt5dllp?=
 =?utf-8?B?TVFxeHZGQmxwSkRWV3dwNkRyUVo0dnRyeXRRQVFmenQ2UnVleFo0VUVCZjZn?=
 =?utf-8?B?ZHlmcmZaZkx0NHQ1N1dsVEFta2hJajZ2bVZTNi9mZzVrbUUzY3Z3aFJUOE5Q?=
 =?utf-8?B?WS9raGxOUE54aktzRlN5a3JSalJkUzl3OEdVQ3Q1NDJIc21qSm1XODYyRFVn?=
 =?utf-8?B?eTUvL1EzMnRkZXlya2F2RE11UVFwZzNORnNIbWR0YW51b0xoa25SRi8zbVAx?=
 =?utf-8?B?c3NvTVFJVFZKR2hKaTVIcEtwcUc4czY0T016YlFOMUtCMG1Ram4vam90WUFp?=
 =?utf-8?B?MHhndDlMNFVjbTZLQ2Q3cTFyMzhFTGROTEh2UkFucWxoSVU3SXRJejAxNnV5?=
 =?utf-8?B?b1ZnS1UwT0M1clB5Rm53cWdXYm5QeHRBM09kVzRuRzdYS1Nyd2d2dXFYM1gw?=
 =?utf-8?B?UFRDRVZucmFjODYrYnJ5Rk5LMFJiK0h6WWJOcHUxSGhvbGJ6SFZDQkJNUTZi?=
 =?utf-8?B?bmIzK2dGVkZVeDAyVWVpUVUwdVU4UW0vWUpIUnRVL2lMN3Vqd3hWZjU0Q0ZM?=
 =?utf-8?B?dE8rRHJvQnM1WHBMZ1gweEJ5N3p2aGJjMGtLSFV3SFB2TDhaMXkralVzUXZB?=
 =?utf-8?B?b0VXMDl3QXNQTFArT1FXc2dFcjNxVGJPRjdoM09EQ2EyMlNQZHFDQWpIakwr?=
 =?utf-8?B?bVFKQ25xcXlQVXc5WHBoS3Z0R2dnRllSTGY2Sit3RHRiU24xa3NHSlFDVWRP?=
 =?utf-8?B?MjcwUk0vM1F1dk1KSWgwckE1dWxMd2hKRlM4SFc4OVpEVm4yTDVMM1hwVWI5?=
 =?utf-8?B?L2EwNFUxalUrRDZsSkE0VndObCt0UzRJNlVXQmh0ZnQxeGFPelN0ajVOcjZP?=
 =?utf-8?B?N1J5NlpsNzlaU3ZJTHZaMU5vMnZGK25BcDJoNTBsMnpFcm9SNXVKMCtqWVV3?=
 =?utf-8?B?UVg3L2ZzbDJqOW1JeUxoS2cxQjdXcG1neSs4dDJqamlFQnlGRWt0M1VLbFhO?=
 =?utf-8?Q?OHEjgW7cNo+CtG3k+jbwcYoTw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f745705c-89cb-489d-bc93-08dd34f8eb30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 00:09:46.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA8Tr4d2GXmR9++eLCp8SpddVu/Ji0RNfzQ9dapvYsKE5ckeep8BYJMIFDEAxKLoUgGaiTejOIXmCEZ6Szw5dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724




On 1/14/2025 5:45 PM, Ira Weiny wrote:
> Bowman, Terry wrote:
>>
>>
>> On 1/14/2025 5:26 PM, Ira Weiny wrote:
>>> Terry Bowman wrote:
>>>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
>>>> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
>>>> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
>>>> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
>>>> inorder to notify the associated Root Port and OS.[1]
>>>>
>>>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>>>> to CXL namespace.
>>>>
>>>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>>>> because it is now an exported function.
>>> This seems wrong to me.  As of this patch CXL_PCI requires PCIEAER_CXL for
>>> the AER code to handle the errors which were just enabled.
>>>
>>> To keep PCIEAER_CXL optional pci_aer_unmask_internal_errors() should be
>>> stubbed out in aer.h if !CONFIG_PCIEAER_CXL.
>>>
>>> Ira
>> Bjorn (I believe in v1 or v2) directed me to remove
>> pci_aer_unmask_internal_errors() dependency on PCIEAER_CXL because it is
>> now exported. He wants the behavior for other users (and subsystems) to
>> be consistent with/without the PCIEAER_CXL setting.
>>
> I see...  If PCIEAER_CXL is not enabled why even set the cxl error
> handlers and enable these?
>
> I guess this is just adding some code which eventually calls
> handles_cxl_errors() which returns false in the !PCIEAER_CXL case?
>
> Ira
cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()assign the error handlers and are within #ifdef PCIEAER_CXL. I need to add the empty stubs to the
#else block. Correct. handles_cxl_errors() returns false in the !PCIEAER_CXL case. Terry
>> Regards,
>> Terry
>>
>>>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>>>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>>>
>>>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>  drivers/cxl/core/pci.c | 2 ++
>>>>  drivers/pci/pcie/aer.c | 5 +++--
>>>>  include/linux/aer.h    | 1 +
>>>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 9c162120f0fe..c62329cd9a87 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -895,6 +895,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>>>  
>>>>  	cxl_assign_port_error_handlers(pdev);
>>>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>>>> +	pci_aer_unmask_internal_errors(pdev);
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>>>>  
>>>> @@ -935,6 +936,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>>>  	}
>>>>  	cxl_assign_port_error_handlers(pdev);
>>>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>>>> +	pci_aer_unmask_internal_errors(pdev);
>>>>  	put_device(&port->dev);
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 68e957459008..e6aaa3bd84f0 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -950,7 +950,6 @@ static bool is_internal_error(struct aer_err_info *info)
>>>>  	return info->status & PCI_ERR_UNC_INTN;
>>>>  }
>>>>  
>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>>  /**
>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>   * @dev: pointer to the pcie_dev data structure
>>>> @@ -961,7 +960,7 @@ static bool is_internal_error(struct aer_err_info *info)
>>>>   * Note: AER must be enabled and supported by the device which must be
>>>>   * checked in advance, e.g. with pcie_aer_is_native().
>>>>   */
>>>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>>  {
>>>>  	int aer = dev->aer_cap;
>>>>  	u32 mask;
>>>> @@ -974,7 +973,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>>>  
>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>>>  {
>>>>  	/*
>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>> index 4b97f38f3fcf..093293f9f12b 100644
>>>> --- a/include/linux/aer.h
>>>> +++ b/include/linux/aer.h
>>>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>>  int cper_severity_to_aer(int cper_severity);
>>>>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>>>  		       int severity, struct aer_capability_regs *aer_regs);
>>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>>>  #endif //_AER_H_
>>>>  
>>>> -- 
>>>> 2.34.1
>>>>
>


