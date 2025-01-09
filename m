Return-Path: <linux-pci+bounces-19585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBEAA06B38
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 03:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304593A74BB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 02:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908EE39AEB;
	Thu,  9 Jan 2025 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e09cKog4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF6136E
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390170; cv=fail; b=GENIwsdxYGEcyjxS1d0muFPRgwIpZZV14TH7EttMN7ahwdVY/7RwPzjacJMfk+9Ntps/RMDzmrZoeEd27x8/GE4GDMShquw6pqqdR/+/mhSz8BLDM3mReQ88+CKGG7SJxKDkHFLbH6Kr841TCrUjh/c9K6kNcHAPK9EDEHOJzTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390170; c=relaxed/simple;
	bh=XsGZGP/AMSlWBsLXtZqh6QJh+VMB6JyRhcAqhJAVxnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vqqa/ebDlIS+/fTj7jC0y6jWmXjm5o6j19A6x3+eW16TNGFuRj8fc4g/vAjuvIhiXdSa0s6RTunpsH2cpHlv4LeQS1KG1QuijeCaimvb7iB1/Bxiqryog/XpqlQ5Tj3XdoNMsQojXF5d9MoAGc2het2CV/wA15tOGPt5yjHN/Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e09cKog4; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f01NDXlOJO0aSGd24G3xfo0fsS3hbo4wyAKe6fO8q1mrYj0GNYruEM7pD/mNmCLHr4VNvtUrsd0AmGLH1jXQ1Tom/SxRAMEU2QLGZDsJ+Sud5GeeX2zdaaxB7P/FxX5s/Ap4ZDXw5AqmjPcYEOkACLWV7qYQUqb3zBkbGxkVhT6G4iQ5u/f/o9MjqzxhkgwuBqD8R/EQDG4BDwednYOwH2s0bVeSTo7yUJErq41sduWbH4Lx4FCOguZ4puv/eAyOCTF5Pgs4INLWgM/t0gBpgGWsJb8rVTJGSuw5OK22cL0SVAtsQIkY/qSC+06O9lKhXpdFRr/7LExk6dQC596nZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6B2G/wLjAnbB1kbEbJ6k3ugG6p6I3gdpsoDzP3BB9o=;
 b=pt7+GDU0S5LgqjLMrSBY9cMcpUWDOu021W3+mbnjM0BLpFEJ0QYOXUKXrGDSJWWbnb1L6UemZM2shsUFl5/n3cLj27lYu+G8IambOUCSgjCp+ADOXkNJWw1h2Ky5Ce6WaMmmwObnBFUH+Jj6zIfVlrLuA1zKM08VQTrSkZSyBO43f0r6sVBAgxD6JbWBKRnPJBkP5ExvfaIXnzs09nYW7es3Q3QX48rztTH5AVEyeTIsjohx8ApUNHsg3ln+UhoAvgxAKVnNJmPFLnnjK+Q2BqLvESz7vc7NkcYSPznJnJ41uQczO6Iy8ATe2dEVWcU6KLRgX/CfE+Hb/Hl+lmnRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6B2G/wLjAnbB1kbEbJ6k3ugG6p6I3gdpsoDzP3BB9o=;
 b=e09cKog4Al3pxSORUp9ZHRS4PZhPcszYA5LOQKaJKmom+tbYhAmmPFsowUwx7FGSeh4IV8EkUeCII0rMTW/06srhJIrS5r327yJPhgA5hh5IX/U+K04iOg7xv8rs0ylSpn9kEbbO41oH/Q58bhd+NeKemiEefMvCXqJ6dR/TttE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 02:36:05 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:36:05 +0000
Message-ID: <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
Date: Thu, 9 Jan 2025 13:35:58 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME2PR01CA0127.ausprd01.prod.outlook.com
 (2603:10c6:201:2e::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 732e671c-c9f6-488c-944e-08dd30565dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODhlZmpuUndTZHRuLzBhYUE0M1Axb1d3RzNBaENCK2wwUzRQZ3JWZWgrYlBH?=
 =?utf-8?B?emNrbHpTWklXV0xQbDFyb2JMWm5LUTJ2WnVXM1dFQXRnbDhoRGc3ZkZCbUgw?=
 =?utf-8?B?NTBGTzBVYmIveXZvKzBHclV1RXRIeWhlQ2ZxaEVLOUc5bitzc1Z0Wk5ZM1Jw?=
 =?utf-8?B?SElPb25rbkxlc0JnbGxOK1dHZmFHSEFrdExPSk52NHRhVGVWbGE1a2Vxbkdn?=
 =?utf-8?B?QU9OQ0s3MlluYlF3U3U5SzRlaThkVVA2VWhmcWlYeUs1YVIwZGRYK1dCSTVs?=
 =?utf-8?B?VVA5YnN5M3UvNEpLVVJQWHgvU0RNWDhSSzN5SUJBdm12dDRWWG0xU2txbFFS?=
 =?utf-8?B?T00xaVNhdkFuVHBDZmYrZkxNUlJGd3JKejNuTTJaR3hTTmlKT3BMUmlLQjdv?=
 =?utf-8?B?eFdPeFI5Q3FvTG42bElJYmkreEhERjhjVkgveHhTVXFwcXQvTzVhTjhWMDBZ?=
 =?utf-8?B?aXBpR3FBSUpzWklIc0NwYStSZDVyQlJyZ3FhYnRjeFhGNHVMYVBBSDh0eG5L?=
 =?utf-8?B?WXpGNlllRWczNktpd05DVzlzNTlrVm13K1Yxcm9VaThtM1lUS29UdTRROE5W?=
 =?utf-8?B?aFNvTlEvdUlVY0JtV29wekwrOHRHNkVlcnVzQVI0a2kreklDQ0lsdUMzeXRY?=
 =?utf-8?B?VGZpSVJUVTg3TWM2dC9WRXdOMDVOSWljeXNaVDhzUnJoaWhRNFJSM2lIeGIy?=
 =?utf-8?B?Y2ZZWWl4Q2Q3YWhMVGVaWlN2SHJzL0QzQlpJTm9zQnVFVU1haVNsaCt2cFI4?=
 =?utf-8?B?ZFFQT2pRS2w4cFFKQXZjWUpuRHlzN0hJWitCcE9MVDhmYklwTTFWMmJZd3Nn?=
 =?utf-8?B?VjVOUlVrTjh3aGtnSHhUSFpoZzFCN1hNT3BDSjNjQmE2UWhoNW9JSmpDbXFT?=
 =?utf-8?B?WHBKNXdnRGtIdll0emlnTERZUHJPNUtSckF1SlBKQ2VLa3liMWJSLzVoZDFy?=
 =?utf-8?B?L21yYjR1cXhuZGRORFFPdnhYOVFsKzkzNE9GUmtXWlFFeWQrNEhjQzIvL0NQ?=
 =?utf-8?B?RE5zZ3Q2clAzc2tGcHFpd2FTUkhnYWQreU1qdldCd2VvRnBiTTBadldRTnMz?=
 =?utf-8?B?OHA1cFlpNTVZMGozOEtJZnBIbVdlbUhOYkxmMlBka2FxZzdOSUdnMmd3RnAw?=
 =?utf-8?B?U1llOHNiaVZWU0xkWHo4YVRnUHVhdnFYSDIrOGV4ajUwM2JnWDhucmN1R1hp?=
 =?utf-8?B?QzBqZFcwZER0d3NuNks3bUVNb3hQUGRleXZjM3Q3ZjlVNGxnL29ERk9qV1RN?=
 =?utf-8?B?TDg4WXl0dER5alpPK0RJd1BJMlRRSG5XU3E0SVdBZWxLQm8wTGcralRlSjQv?=
 =?utf-8?B?b0lMTlVMN3piSDZ2ZkF1bEtZdDI4TzJrUnNVWkVpZDBNUnh4K0NJK0dNT0R1?=
 =?utf-8?B?YWRGb2N5cGY4SWZISmhKM1ZvaGJXY1NoMi83MVpLTlc2VzUxQ0tKNGYyYmNk?=
 =?utf-8?B?dk5pNW4rL1VYb3Y2bXJaelNDRVJnK3VHeTJ5MzNIaU14aWJxTXVLU1oycXFZ?=
 =?utf-8?B?aEVjcXlRQW41eW9wOUdpOGxGbld3YlhJM3NpbTFwZkhvSUF1S0VhODdSeGZr?=
 =?utf-8?B?RktURDhSMFF3cXBXRllQV2RQZEd3a1lzbkFoZFNjTm43dWg4SDhjekFBUjZO?=
 =?utf-8?B?Z3BtZmY3MzR1alhQN3ZzZEg0c2V2OEVEK2krQndIYWwrZzhGa0dSQ2lISURl?=
 =?utf-8?B?QTA1ZklVZkZkN2RLK0ZhTXc5U0FSZ1IvcVlCeGhEUS8zcmM2czV5cHFhQUJo?=
 =?utf-8?B?QWxQMHdSZ1hsMDFhZkpQQThEZTlXZitGNG12dWNpTVRxM1AvbHdkaTNaWVFX?=
 =?utf-8?B?MU5wUFpwalFVL0tCKzlHcUtWdHNMbkQ4Z3JIWGoveXVYRWJnU0F1S29lcXk0?=
 =?utf-8?Q?++HEfEaChgRUc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzh5bHZOaVg0Q1E3cDh5VU02OEcvT2F6YURhR2tBZFJqb25XMGltKy9PZGNu?=
 =?utf-8?B?VDVCMW9Iamp3dkRsY3ZRN3dNQlNlckhmUHhudTF4MEF3cFpWREt5OUJZeXcv?=
 =?utf-8?B?NTRKdVZBWnNRcHptb29BTm8vdDNubzRnRWNQYnQrbnVrelhpaVZJTnp5M0E0?=
 =?utf-8?B?Vyt5VHp4RmhiaFVDK1ZxR296UTdJUU4zZXEwbDNCa25OUmF2aFRHK05RaFpr?=
 =?utf-8?B?L2pybTBramVlSDhMQU9vcDE0b3ZJUDkxenFtdysvb2psM0NKcE1FakYyRkhy?=
 =?utf-8?B?T3M4QTN5cXR6cDYxdXBaU200U1k4ZWRjN1QvTWVKTHlqS1RlMU50YURkK3Jy?=
 =?utf-8?B?U2dsdFpCZGQzMHg4a0xYT0Z6cENMeng4R2xscUdnS1ZSS2hUcFQ0dzFxYXYz?=
 =?utf-8?B?cDdDRGkwSmdVTzhSM05HOENmMzJXYmp0ZUFyeHcvSXJhSEpObWpWNXlaYjYy?=
 =?utf-8?B?eGZPSWhQN095YUV1Y3o1RDVTVnFOVG1sZThXcU5oNDdRdHRtLzF0eFlUOWRp?=
 =?utf-8?B?UDJaaXV0SVlZWFpjZlFoeTBLRnlxbEdLNzVXU3owbWFzQXBsY2I4NlRtVjc5?=
 =?utf-8?B?d2FVOXhscitlT3R1YnNYT1dYQUFVa045emlrMVBEK0trM3lBYS95R09mbXV2?=
 =?utf-8?B?Zmp6ZStkclZFUWFKTys3Y1lacnpIbk9WRUZMRnBBMjVETlJsZ2pnWlFPOFBQ?=
 =?utf-8?B?U0F1aGZYdWJsSW1zcXBsYXp5R0U1RFpnUGdwZStUTVpENVVDYTdwOUVPRWRN?=
 =?utf-8?B?YTk4TFZkY2ZKRHNQSlc2S3lXaERPOG1JSFYwUm45aHhoTUJUaEVWNmQ1ZFFp?=
 =?utf-8?B?UkRHbXFYdjJBUzdmY3FZZEpaVlIwMDBnNTZhWjBhb0FKQ09PaW82RWJkK0t0?=
 =?utf-8?B?eEc1eFFFVUlRRVBZcStMZHBNbUJHSFNzdS9rVmtnc3dENVpvcyt0VXhNaGVk?=
 =?utf-8?B?L2YzUUxRZ2NUUnIwY0kwTnA2S0R4USsvcWxJelpmTmlidHRNdzhrUWh6akoy?=
 =?utf-8?B?ci9qUHgvTE1KWjh0WU9LSk5qdzdJL0NKUExrNW44R2ZHMmNyOTFmaWwxYXRx?=
 =?utf-8?B?UFpxaFhPY0JKVkpSVzJWY3BQTy8xUFlBdm0wRXhwK2lGdzczL3BxOUduZFVO?=
 =?utf-8?B?K1NhWHRwOFJ3blB2OEVGM3FqanBhOGZHKzlJUW41SFR3aFltbnZPdnRNZTdU?=
 =?utf-8?B?QVJkRWdHVzFGeEh2SzVZK0tBaHZncW1JRjZZNDdTZURIN2cxZ2ZpRFNBVklM?=
 =?utf-8?B?Ym5MMnphNnRoOC81bUxUMkxSZWlLMStBVjJOZ2E2N3NrUkNKb0Q5S0thMjIz?=
 =?utf-8?B?cGxHOVhPeE94Ym9DekJtUGwvc1hvUlFlZEVrQ3A1SThYOUMyUkkvaHBVN1JM?=
 =?utf-8?B?QWlyNFZGQ0pVYjRIT3RTNHg4QnJxQzZNZTJvUzRGWkx4OS9XM0lDWnBOeEJB?=
 =?utf-8?B?OXpWdlpHUm10WkJZUC9VRHBUazdXelhxazdybTdLR2krMHlqaTFiNzBlUVRz?=
 =?utf-8?B?QWZQTGdQanNiK2QyQ3Z0ZmVPckpYOHd3WkMranp3STg3YW1MVmlpWjRhd2Vj?=
 =?utf-8?B?cEI0NEplWEkvNlJ0U3NpZGU5V3V1ZWhUTnRFeENOMWNBV0gwcjNtSnpJRDF0?=
 =?utf-8?B?dFRIRUkvWE85MFBiR0N6eTkwWDNrY2xYbS8rQ05QdVNLYlJabVZhSHdybU5D?=
 =?utf-8?B?R1p5T08vaTl2c0ZSVGJoYVJ5TC84cjdSUUJ2d05sdjV0RmNXZnZ3ampIMEhP?=
 =?utf-8?B?RWNGbk0xbUlvZXZMVE4rR1N1bmlBR05rS0FFMGVrRTBqd1pRUDMycHZJVEVn?=
 =?utf-8?B?Z2VScmVtaG1La2xsRS8zYlJXZkdEMzhHR0lJSTFPMFUvcGpIMU84amIyMWFZ?=
 =?utf-8?B?aURlYXF4U1c3YnUzTVFQSnA0MHZqN3JVeTJKN2hLd3NhSnF0MHl3d2poK3hz?=
 =?utf-8?B?WkV2bTVmbGVLQ1IwTlMwZXRtaDJOUi94Um0zaG5hVWpiSDVhSER1K2lIMytX?=
 =?utf-8?B?ZWpVN2JrRFg1WmR6TWhEODJXWVY1dGMwcVdDYlNiMGplQ21CV3Z5SDlKQ2ox?=
 =?utf-8?B?MlJUNzN4SDRBeG5iZFcxeUl4LzJid1A5TytkV1ZWMGNNeHdHcE5vMzhmT2xl?=
 =?utf-8?Q?Usmtgq79TfGOBSFxBMzznqYdO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732e671c-c9f6-488c-944e-08dd30565dae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:36:05.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdQId/hG+OJD39UIhM91/FoRw3ia2mr4LwjpVDRnUVaf/nX5oi8W+Lcb6hNTil4uS4Qw6Joswk2H1B5++gFmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139



On 8/1/25 07:00, Xu Yilun wrote:
>>>> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct
>>>> pci_ide *ide)
>>>> +{
>>>> +    int pos;
>>>> +    u32 val;
>>>> +
>>>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>>>> +                 pdev->nr_ide_mem);
>>>> +
>>>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
>>>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
>>>> +
>>>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
>>>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
>>>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
>>>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>>>> +
>>>> +    for (int i = 0; i < ide->nr_mem; i++) {
>>>
>>>
>>> This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss
>>> especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,
> 
> Yes, but nr_ide_mem is limited HW resource and may easily smaller than
> device memory region number.

My rootport does not have any range (instead, it relies on C-bit in MMIO 
access to set T-bit). The device got just one (which is no use here as I 
understand).


> In this case, maybe we have to merge the
> memory regions into one big range.

>>>
>>>
>>>
>>>> +        val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
>>>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
>>>> +                 lower_32_bits(ide->mem[i].start) >>
>>>> +                     PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
>>>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
>>>> +                 lower_32_bits(ide->mem[i].end) >>
>>>> +                     PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
>>>> +
>>>> +        val = upper_32_bits(ide->mem[i].end);
>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
>>>> +
>>>> +        val = upper_32_bits(ide->mem[i].start);
>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * Establish IDE stream parameters in @pdev and, optionally, its
>>>> root port
>>>> + */
>>>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>>>> +             enum pci_ide_flags flags)
>>>> +{
>>>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>>>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>>>> +    int mem = 0, rc;
>>>> +
>>>> +    if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>>>> +        pci_err(pdev, "Setup fail: Invalid stream id: %d\n",
>>>> ide->stream_id);
>>>> +        return -ENXIO;
>>>> +    }
>>>> +
>>>> +    if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>>>> +        pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>>>> +            ide->stream_id);
>>>> +        return -EBUSY;
>>>> +    }
>>>> +
>>>> +    ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
>>>> +                  dev_name(&pdev->dev));
>>>> +    if (!ide->name) {
>>>> +        rc = -ENOMEM;
>>>> +        goto err_name;
>>>> +    }
>>>> +
>>>> +    rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
>>>> +    if (rc)
>>>> +        goto err_link;
>>>> +
>>>> +    for (mem = 0; mem < ide->nr_mem; mem++)
>>>> +        if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
>>>> +                      range_len(&ide->mem[mem]), ide->name,
>>>> +                      0)) {
>>>> +            pci_err(pdev,
>>>> +                "Setup fail: stream%d: address association conflict
>>>> [%#llx-%#llx]\n",
>>>> +                ide->stream_id, ide->mem[mem].start,
>>>> +                ide->mem[mem].end);
>>>> +
>>>> +            rc = -EBUSY;
>>>> +            goto err;
>>>> +        }
>>>> +
>>>> +    __pci_ide_stream_setup(pdev, ide);
>>>> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
>>>> +        __pci_ide_stream_setup(rp, ide);
>>
>> Oh, when we do this, the root port gets the same devid_start/end as the
>> device which is not correct, what should be there, the rootport bdfn? Need
> 
> "Indicates the lowest/highest value RID in the range
> associated with this Stream ID at the IDE *Partner* Port"
> 
> My understanding is that device should fill the RP bdfn, and the RP
> should fill the device bdfn for RID association registers. Same for Addr
> association registers.

Oh. Yeah, this sounds right. So most of the setup needs to be done on 
the root port and not on the device (which only needs to enable the 
stream), which is not what the patch does. Or I got it wrong? Thanks,

> 
> Thanks,
> Yilun
> 
>> to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a root
>> port. Thanks,
>>

-- 
Alexey


