Return-Path: <linux-pci+bounces-19772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62182A112EB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5BD7A17CA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F532080DF;
	Tue, 14 Jan 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+yzEJM1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA01ADC72;
	Tue, 14 Jan 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889645; cv=fail; b=vFuJlE4cOVNtzMgQKv+O65QVWkGIfALTcTlTVpaGOh++TFtH+idAxX4qV2vY+D6tYWrqlYfQWrpKUAjD0UmqRjiHCLXsJT4sFookHPuNJHvAS5vjI/QSCb7JuomYZLMALKTSX02SPMvQLDQllyEEB6FvT07XzoMD5ysVYQZ0HlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889645; c=relaxed/simple;
	bh=6pp6lyAbzdDI+9Bv8iSHqlY4MGrYK13NRgGIqhg1jaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IEEFkvKJkBF0nd8jYyqZAF50llfFu7A7zfoSF75G4AJRe6r6wp9Uq5ESKVJ2uld6vFNMSM+368RM75w9aU+K5e5/Oh+vFcu8ziC6S0gFFmoeUqG4NwgQWum4nHb/uo0aO0YNRIXCm8/Tns9FLdLXXJyxcKY7W10i6FKFrEXJzFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l+yzEJM1; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMO/1s73DFMwLNdJG00s+/fSarfZJ/FEdBCNMC1x8YIk9frfpwQGs3tp+CnI3arnX9uyUFyZ/Svf2H9RDiF0Ir8SE3nBJYTfLnIF6P+TmhDWzk+0GKuyDlaXenUGW8Hl9WtkCqAtC68NZO9X9+h10TT6j2A/MAmt5p2wvbz0MT3Zo3KI5H/dByBol48FQyfIWfBBA/3R1S8e0AdrnLmuQvMgoZrh/CiYzNFJSWQ/314RBsFR7snqo1dsfFPrFBwvwjx2ZUfJ/3ikhEbxA4PGPGuwko5RqstObNv70o+1xOGJ97GWQ4oUvRR92i/ZTs3yZutCMGPOqJey7+Zbk3WGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ou3/hcGLKRzOz5lbFQkW5SIRXyiaN+gK2gl6c4qVK0=;
 b=IYPzahsXlbiJgio6MWvD0ypTMGyp0SsJewzFyHUAFyD3Y+Z2WeOgzS8HvqVvEeMqUbpcI5bMim/g6AXakDkNsMSNxq2ABvvMJUnVt9XkFJKM61m7auMD6JD3L7xSrcqkMs32PlVKUvBNvufJrDyYrHEKHQSLafkhAszcWUA0wzkmaBbUmyRN7BihLPt9v3UmU7CFnsm8o2wCT/iUlbiB+cXPyApcreAtNRIFIxSRfeoWu5fTsNPjHRIRJBP2bJ4Y1pZAo8wwcWmv1fXMy+FsZ5a1GK74Kmu8QNS0MY+8DOWb2xjkjCukaek25mtxfuDcoLACvslAFS6645btC+VHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ou3/hcGLKRzOz5lbFQkW5SIRXyiaN+gK2gl6c4qVK0=;
 b=l+yzEJM1sJnE0tlNo7NmeNS+8nuXYMM4GRZ6RmC+rfw/sTN4y9nW6CY/Yb5OkPOh/mrfDCQL5fkUFfNVrnRuWtinFOuIGksFfYU6Y1wiPpRIV+BxXOqr1gZQBz1No6zNXQxK0raQcVTjzjGBagKNbEZz0qcPxw9A1LOWycWuMW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 21:20:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 21:20:40 +0000
Message-ID: <643a772e-b9af-4353-8dcb-1ac15877e3ef@amd.com>
Date: Tue, 14 Jan 2025 15:20:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <20250114114621.00007c08@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114114621.00007c08@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:806:28::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: da6b7fe3-449f-4a6c-29d1-08dd34e14be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEkvdXRuK0FpVWFSd3dQOVArL1lCOEpUa1BqQzB4ZHVCL0tQc1NHMVJvejRa?=
 =?utf-8?B?cDVKdDlpQWpBWUM3bmk0eThSUm42dHpzTS9VMVNYTmdYZmdVZjZaYXpQVHNa?=
 =?utf-8?B?UkU0NitjdS9qYVBmQUVRcFcvUG5CSnRRa1BWblNIUmxkY0F3a0psbjJ4dVBs?=
 =?utf-8?B?LzYrTEtZUTJNc3p3RHBWZ0RVdHFUNkQvWTRFOUlJMDhnZnlXUUk5YW9kalVS?=
 =?utf-8?B?OXdobUROWnd5NU9rQllBeFMyb0tEWFdPT1hDRHdYa1FsU05ZQVFUeUdOWG1o?=
 =?utf-8?B?MHJYTUR4SHBmcVVCWFVYTjJPcjlKZHNNRXR1WEM1QXFXSk93N0c4TEgxZVFs?=
 =?utf-8?B?ajQ0ZHZWN1hNVXBqVmJ6MXY4aHZ2cFJxa2RtK2ZGbU0yeFFIMTlzUGF0VWpn?=
 =?utf-8?B?QUIyUWZ2d2h1Tms3ck9jMWZjRll2LzRWakN2bDZRMDF1dDBjSWdVTXFIbWJ1?=
 =?utf-8?B?VjVubkpJNlJ5QlE1Tm5hTEk3Y3Q5Um5LR2ptdnhDRjllNllCTVlOWFVjN1Aw?=
 =?utf-8?B?VFNVazgrN1lEQkpYbExzS0xPT05ZVjI3TVRzWXprZjE0N1M3R0Y5TWt3N25R?=
 =?utf-8?B?UkcwYktkWmlybEhVU3Z6bkhTemZlVVBmMk8vUXdHWjhWNWU0WnNINTNRbzU5?=
 =?utf-8?B?WU1VQWQ0QU9zZzdEZ2lhdi9TMlh0enVDaVBkMnQ2a05OYytqR2hOUlBmNDBV?=
 =?utf-8?B?bHNPenZXaVY5RHBCenBjSVhKQWVvR1FxUlhIaEluN2FyQk15M3FqeStJSHBD?=
 =?utf-8?B?YmlrTmhoR2FIOWh4WEs4V3B6czdqVnZtVGlLdnRBdWR5aEVPQWhlVmRjdkxD?=
 =?utf-8?B?U0RjbzdPVksxWitOVU80SEdicncxKzlmRTJxWEJ3M2VLeFBVbG55MEl4ZjFi?=
 =?utf-8?B?TC9ZY0haMCs4a1B5R1pSR0lYVXhIZTVaK2JvNG9QeWN5UC9YeU8rMmFrc0Fj?=
 =?utf-8?B?L3BHWlN4RVlEakNwYWI1MVlDSDFNSmZvMGNkQ25tR0RQV1E5eWZCRk9FSUIy?=
 =?utf-8?B?akZhSG5kbmFjdG1ZcHBzU0txVmVYRk4rL2F5RGhzTVBzUTBNZVFSMkdMZG1K?=
 =?utf-8?B?UUt5L243eDM2cHpTdkFpV1ZaYXk5bjFrLzRXZlJQT1EySkpHbC8rTTVLbHVB?=
 =?utf-8?B?UmhKM1l6OENwM2dJKzVZeWdsbWVXMTByS2FuWlhnRkE5OXBmdjhORU5TSjR2?=
 =?utf-8?B?d1lvQWtYQUxveG0vNGt3eVh1U3R4ME1pNFdmYks2bGdqeTRBTUc1dzlxNVRD?=
 =?utf-8?B?SloySDY0Um5BNHNmRTMyb09JWEF6b01qS3IwMjdQMC90Ylk4Y0RZTS92SjBY?=
 =?utf-8?B?SHdVSHRvMmhkUDgyZDR6a1A1a0pzTngwaGl2UmVTdEx6cGVXYjhzME9DZGQx?=
 =?utf-8?B?OXFSRHU5dWRXQmNob3Ayd0VzbnZZamxUWGRkR2d5Y2o2V2ZmMzF3dzFFYzVu?=
 =?utf-8?B?b2xvQzJQejFDWU9RT3dOaGV2bHAvdTJTSEN5bDFsdzN4eG8wUDF6QkQvOGo2?=
 =?utf-8?B?WWlrWEJEOHJ0N0dIUXByOTBhalBCeWtZQlR3dGgzSUZlYWxrWTIzYmtmWmY4?=
 =?utf-8?B?bEk4Ri9UZ1czeVQzUGdrVUUwWENVakRoV211TWdxLzR5L1dLRllkU29RelYw?=
 =?utf-8?B?T3ZSYTBkVFRoQ3ZlNVpWcHJTK1c0SWZOajFUbFZReFdCVlg2MzNtOTFrQkM1?=
 =?utf-8?B?Y3NQanNibVJBQ0tEcVlxTW9VZU12RDZPeHV1SjI0d3ZKZmFDRlpiUHZIekh2?=
 =?utf-8?B?QzFYZlN1RHFlWFluVFJub29yKzVheXlncUdMYzdXY2dUSnROYTJyTnozMXlx?=
 =?utf-8?B?ay82ZUw4WUhTQ29pZ0Z2R0gwYVZWTzVEQ0lEbzJnakZHekR4RzgrRFVRSytO?=
 =?utf-8?Q?8pZnws/mBsefR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXp3YW1IQWVsREhuZnkwRHVMdjlxOUZrMmVtTUFUMmZvVUNENGRrSnlubURv?=
 =?utf-8?B?RkIyaVlXRkFqQWdIS0VvRWc3MXhNR1AvS2pkNDVQWUhFZDZLZ1lXNVc3dWg4?=
 =?utf-8?B?SXhYZ29USW5STnZ4YjN0aHY2ZS9Yelg0elNTVlAyUlpNa3I0RUJqNGN2L3ZB?=
 =?utf-8?B?V1hsVEhHT25tVktBMXd5RTc3TUxBWXV3M09rYWJyeVRzV0hsZnpGdFlBbTlK?=
 =?utf-8?B?REdFdE5YTGxmMkZNQnFnSlhSSjdabkJsOWRpZkV6dXNnNHpYL1plalJ2Mm1X?=
 =?utf-8?B?V2FBU3hPd3F1OTBFNTRBeTFaVklyMk43Mjg4TWtBc1dxSmsrS0VsdFFtRlZI?=
 =?utf-8?B?bGJwV3JnNDJSOEZlTHZPenVyUFhEM2UyZkc2WThDQVpIRWMvSU1kbTlNMVNR?=
 =?utf-8?B?WWpaZFhwYlJuZzc4VGdYNElMVFB0aXBOSmc1K1V5N0JJWlRYdjFkeFdmY2Vj?=
 =?utf-8?B?YXpwRDk2dkJaWEV3RUVKSUdrNjIxekR1MGpVSTFuYnMvUU1GRDZVb2E1T2dm?=
 =?utf-8?B?bnRkaWpnaW9DM1Q4bTEzbExOaUFRMzdiTkVqYXVFZzQzMkVjR2VMS0lsVmp0?=
 =?utf-8?B?Q09kMGwwbzR0alZxeEMvZ3ZtSHFVODQzSUJPaE5lZUJGWkRzMjVXb05KS1g2?=
 =?utf-8?B?NUhCTi9DMFNPbkppYVg0dlRtNmZlOXYveW9keUVBNTdFUnVGVE9pZFZ3MEk4?=
 =?utf-8?B?NE1YODJLQStKdDNEcFc3c3ZmMXp2UmxJZkF2ekVydUVXWE9OaEJuRHRJeWZT?=
 =?utf-8?B?SzY4NGVVQnNVV1A4Sm14eW5rUkhmRkxRdDY0L2I2dnc5WjhYWHlPMjk5L3E5?=
 =?utf-8?B?dDgzWGdKZXgyWkttbUFNbE9ZYzQ0RHNIOFc0bllJNjJiK0VLRkh0dS9tSEZu?=
 =?utf-8?B?MXFBZXpPTXNjc2xId1poLzY4Tm1wSXhQeUxBQ0FPRndYTWVtaWtrTFk4clZX?=
 =?utf-8?B?TURid2QydFgxdFFDKzlEa1hVbkN4YXJpdHd1dkUyMTBScnZJWUxSWlYxM1px?=
 =?utf-8?B?Qi91ZGQ4ejhmNHc4R0VmZjI2NVJHTWFuMkhJbXdsUU9JVzBpQjBKYjJsWXhK?=
 =?utf-8?B?SE83TVE4TGpnT1QydytwWklNcDdpZ0xGY1hLcEt2ak55ZEpVRi9SdGx3MURL?=
 =?utf-8?B?cDJNTWFEU2c3Qzg0OE1yUUlXRWRvWDBZcElRRzhjejFOZjhmWjBTQXVnbThU?=
 =?utf-8?B?WGtFMXBmM2duWk42eC9SV1Nxb210Y1Z5UlQyZXZUVlM2TVNCaTF1dzhpNkIx?=
 =?utf-8?B?ZHlocTFCcE1aM2NIcHJXYWc0TksvS2RBdW9RMUJqQjZ2OVhCY0hJaFhZY1dD?=
 =?utf-8?B?eENwTjhBOEZDQ2xuTzlpeW9xL2EvbjY1WmdrWTd6dzRNRDkxNUVSQXRQRHBl?=
 =?utf-8?B?dGJ1OEpMd3RUT1I0VFVxQ1E4eG5WQ3N2YlljQ1Y5d3lubGN0K1ZJOFoyMEZ2?=
 =?utf-8?B?NDM4Q1JRN1JXd3h5T2tYVDRzU1ltMDZ0cFRkSlpxRitBeHZPS3gzMjZENFBW?=
 =?utf-8?B?T2ZyYXlGeDFWZ29tRGhCbFVEdGIwSENGdnFJTmYrVXc1MDV1RklHYWhGZytw?=
 =?utf-8?B?QVpqbElBaHQvcWt0aGs1VlRKUVVwa3haWlhKeHpXdzBzUjlycWsyL2N3Y3pC?=
 =?utf-8?B?bi9BWHRiOEl5RCs3b2xIUXYyRXphT2pDTEtUNUJ1c2pOby9sQzN6bllJenBO?=
 =?utf-8?B?aUF3cFNjN3ZBRk05RGRQRHpvRkxGdk01d3FFTWNNVHFKQTFVTlFoMUtJN0ww?=
 =?utf-8?B?cjNsQ1NSbWVnODV5cEUwLytneHp0ZmF0cjFkWDVnbUVYNm9qWmhOWGJQTlVL?=
 =?utf-8?B?bGxDUXlmV1A0S0ZTeUJJdEFaVWdyTmVBQmF4WnlhVnpLRS9aMzliWkJEZVU2?=
 =?utf-8?B?SGNxaUlta3FmRWlCQTBmZnE1Um1HZVFHYmNCT08zOVZyQW9PbkJVSXpDS0hP?=
 =?utf-8?B?eGRKMVIrcFFmbTFOc0VCMWFrOGVZWnZPQlFmaW5jWVdnZHkvUnVCWWpVcE1x?=
 =?utf-8?B?RWcxdTlCMm1CalhxdWl3TGlUWEFLZDBWYUVwRGZ3SWZMQVltMnUvMFYxYWhM?=
 =?utf-8?B?MmJteTZ1MkxYYjlaTmtZMDVsZkFuWVp5K2liRjF4QmhsWHlqcmRZRjNlSHZE?=
 =?utf-8?Q?d5ntsXH/4eIya3nBug3D3C7JF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6b7fe3-449f-4a6c-29d1-08dd34e14be3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:20:40.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oow7TwLPt06uRMkTOjLoLH8H9CCtUa9NkIKVSPLDzoQ3JmxXoAhE3I8ogqFt5nrQl8jal0PIRIqfuxBrUdxLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320




On 1/14/2025 5:46 AM, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 08:38:49 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Introduce correctable and uncorrectable CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Future patches will assign the error handlers and add trace logging.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 8275b3dc3589..411834f7efe0 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -776,6 +776,69 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +static int match_uport(struct device *dev, const void *data)
>> +{
>> +	struct device *uport_dev = (struct device *)data;
> It should be const and then no need to cast explicitly.
>

Ok

>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->uport_dev == uport_dev;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	struct cxl_port *port;
>> +
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +		void __iomem *ras_base;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
> Maybe some __free magic on port as then can just
> return dport ? dport->regs.ras : NULL;

Ok

>> +		ras_base = dport ? dport->regs.ras : NULL;
>> +		if (port)
>> +			put_device(&port->dev);
>> +		return ras_base;
>> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>
> or maybe just make it a switch statement?

I'll add the _free approach back.
>> +		struct device *port_dev;
>> +
>> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
>> +					   match_uport);
> Likewise on __free magic to automate the put.
>
>> +		if (!port_dev)
>> +			return NULL;
>> +
>> +		port = to_cxl_port(port_dev);
>> +		if (!port)
> why no put of the port_dev?
I overlooked. Thanks

Regards,
Terry
>> +			return NULL;
>> +
>> +		put_device(port_dev);
>> +		return port->uport_regs.ras;
>> +	}
>> +
>> +	return NULL;
>> +}


