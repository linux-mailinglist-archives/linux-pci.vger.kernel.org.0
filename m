Return-Path: <linux-pci+bounces-8998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08490F683
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 20:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DDC2874EA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CCE158853;
	Wed, 19 Jun 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tcGkKIwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AA1BF37;
	Wed, 19 Jun 2024 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823058; cv=fail; b=YY2r3bjbEX8XOIvxbWRmSwkIPS0oUD6T/hH9uwiwwe0bXKTvBMd7kCm1TKmvYBlhY+R+qIGRy3lGS31MTxLInFQPm+aT6gJc4VLuU4Cy6AQOxvJ9UkHNw9KJP5womVp+kOExcVrI/pALvBb4bUKL+xErOtDw/4O4EAw5BMSj+HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823058; c=relaxed/simple;
	bh=hs/nsceJD6i3PuIEbS3HcLULIhe+jwkjpoVTeJ7e5yA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2jR+QfwODFtcprmJ06IkQCkfzgJwBi9E141wyppfBv9mUJ4/U7Vsx/hHM/lngZ55bon89VKFknJx11tRwFl+ae1ebmA53nRpq1zucaE0OMQOfXtr18TuaOWdoLDcppz3yks5sZfX5bNDpo/Ojdis/G0pjneYakf4/hTUSpMkrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tcGkKIwe; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNTIvbnuTX6iJ7B40ozYLpCuwk8jPS3iYm8mo1T/1Fdl+3zVVILOI2fmsUGPktht7hK+YxFmKiVKn4Q3pej3APRn8UgyxWD8TS15Qp/WLVrnz2qChNCoZyJlcQ0N634kNQE3gnid8b/IwgMFfiFIu1GYzTDL8K78nAma/RPsJIVONFyS4dJt1wMJjhwdYI4RzJs3EJHdGHaHrMNS6ltvs4Cl5fPczggGZ3xUVsYRSf61iQJ4wAHjli2VoeASDdxjB69JbpNXmy64MibrMqR17IqU2R9uSQENKVax1qSVIZ2TQjxlJ8ldL+IZufcvPP29mKQuKORIPdKsnJBlFhuyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wjl2oemUkt/Py5rIxTRPACXbcqqMnCboKPvY3dHU72Q=;
 b=lHEuBx+7P0XiKEFT7UYZaghIEytS5+/kWEMPwWad/iIewfVK/2D5VtqvJ7Ha8ZajaBp+sjLRUE3N9u9x9zybx5Jq+7LcPz+Gr3vRc7D854wpRcuyggOckyO/h7cQygmJLnO54d3uI8a4rYmF4l5gmfUvuO8hySXXTl2cXvqKn+wACKvx15vb6Pi3jxAXY12u6wVDX+mtGGJiwyfjEhHAYOZVWk2fk0oINd9PsIc94rNt3kKm7+EH6x1CRkHrpkDC20RT40wo9k3dZJk0vKJ7PXvi/TPiLCA2AuRKqNWhFgUthku8+fvy0kKkgTFzVzS+6Y+FUfLqjs+hBj3TfJLoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wjl2oemUkt/Py5rIxTRPACXbcqqMnCboKPvY3dHU72Q=;
 b=tcGkKIwePS/crY5aFJw5ab5sJ5DV+A1YI203tetgRPuINKaEX540sRLHG5YFNGZak5COzVrVreFkbL69fGqbXu3OSIGwvMmTIIrzx9eKmbZbLA3qQvIMWx6zlgUSjxTicWzgY/XeoSBSi04vi48hzq5GgWhqw2TZObfsAO9b5+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Wed, 19 Jun
 2024 18:50:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 18:50:52 +0000
Message-ID: <5a04e554-9f18-43c0-8095-d3e0c83db76d@amd.com>
Date: Wed, 19 Jun 2024 13:50:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Verify devices transition from D3cold to D0
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Gary Li <Gary.Li@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
 <20240618131452.GC1532424@black.fi.intel.com>
 <9f465ec4-32b9-4cd8-89de-a57a99880360@amd.com>
 <20240619052927.GF1532424@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240619052927.GF1532424@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0202.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ca384b-0381-49e4-12b6-08dc9090be96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0pVK0pXUjd0enVMOUV0d0RRVHU2NFZrbXdBZVBlckNkNGxsdDREbEpNaExv?=
 =?utf-8?B?Ym0rVjBzVlBGSHZScHhYeGNSZXNkbklCWFNXb2duT1J3Y3dWbGo2UHBNTlNu?=
 =?utf-8?B?ZkJMSUFEenBidkNrQWhLL1ZURlhISjhhdnc0Z1ZYeEQ3eFcvc2JoY2FhbFdI?=
 =?utf-8?B?Q25Ld2tSKzdMR0lnK2ZrbVB4WVQwdmpVa3pnd01wSDVlZVUrTFBHbGNDYUNs?=
 =?utf-8?B?c2JJK05BbDZ5dHl4K1pFZnV4b2Q4dkFUNVUvRmQ2YjBoQWZiMWtjVXkyTnlG?=
 =?utf-8?B?K0g4SDcwK3lEdkRyMGp1Ri9Xdlh1TlJyNXlOQ2lyaXVtVXpSM1FUVFBvZFFX?=
 =?utf-8?B?aW1ad1BiRGQ0M0FmWk0vdUcydnYvZTdwMkdIamE5T0Y4cExvWWhGUkNpamgw?=
 =?utf-8?B?UEJ0N2lCaXRBei9tYmhHM3h4akNxUzVGc0xObnhUL0I4Y0IwZThtTjMyNFQ1?=
 =?utf-8?B?Wm0rb2hCdWhGZ1plQ3pCREtXcW8yN3BUR0ZNc05VUDdhbHNrUTRLOHRVRVY2?=
 =?utf-8?B?bGZtZ1FZaW9aTjBIZkxzNk1rckltMU02bE0rSVRzL1VEcDF1a0tJVUVWaCs3?=
 =?utf-8?B?emxtUSt3MlNJS2oySm1sN20rR1hUZTFwSHlRQ3ZEWkRVZjRCckkwazYwZTZD?=
 =?utf-8?B?SGdSRHUzUm8zWkI5RUdXZGExNTZmWFRtSU9MaVE2MDlkdEVaek50UE5qZ0JP?=
 =?utf-8?B?aGExTW5HNDR0V25yblBTWHBTajhqS2h3UDZleEdjU1dXZTFrRUQxeXRaSjh3?=
 =?utf-8?B?ZXJQVXk0d3FhbmxjWnQyVmlZRmx1SmthMVpQV0RYSFd1eGROeERPUTZDNDBV?=
 =?utf-8?B?ZFVjQUxhdWJqTzBGZGxnRWlIWHdzUWJwZ3NKNUVKQzcyS1dmUVpuVC9pdXhK?=
 =?utf-8?B?Y1hlYWZqWVBsbFdqSnNRZWFrSm1rS0l2Y2VDYlh3ZlJLM1pYQU5xTzlzbnBq?=
 =?utf-8?B?dWp5Q0Q2MWUxMUlHd0pIS0JTWFYyVCszVHB2UmR4MEJEbnVIY0M1TU03eGVW?=
 =?utf-8?B?Zjd4T1RuZkJzeEZmN2VaZ0Z5OTcwUmxBS1VoMGxaZzBTQW5ScmJrL3JCTzND?=
 =?utf-8?B?ZkNFbUF0YmxIQ2Z1bzZpYnZXQm9tMFNjRWRuejVOMkVFNnlPSERMbUtKK0FS?=
 =?utf-8?B?OFZsNDJ3T3NONm11NDZseU9tM0ZtRWlXeko5cjRCalA3aGFmKy9aaDE1RWxC?=
 =?utf-8?B?S29OZmkvYm16ZC9QRXdwT05NT2dwZHhXQ1JnbjRRNjA5Tkp6ZEpFMCtuOGpW?=
 =?utf-8?B?MXQvcnhyVStQWitaUmdrMUF4bGxrdkJuTXlyemthYmRES3IvWllDc3BOMUE5?=
 =?utf-8?B?K1V0bXBjWXRvUG02Ym1lL3FEMURNeGlrZlVFUHpOYU4ya1BzWkFtUEVtVlJ1?=
 =?utf-8?B?WDRZdWt1bURndU1XMWdOREQ1OEtnVVhOOFRHd1ZOK2N2ejhzRWpDaUVHNC9M?=
 =?utf-8?B?WGQvQ1FOODNMTEFvTFJLbWF4WnR0ZWlYc0FZdk1tdlNmVFVqby9mN0JkSEgz?=
 =?utf-8?B?bm00c3BjM2xKMjc0dHl0VzVHUnM2VDF2UDBEcEt1WjNqQ1U5SHhkOUdoTUEx?=
 =?utf-8?B?citaVEhtRmh4RE04UFFUQUw0L0swdDRNd2Q0VEZKWVdsL2ROZ3FBZWplTGx4?=
 =?utf-8?B?akxUVDJZVUFUY0l2UUJtdWJiTTZJUG55Z2hzR1hONEQ3b3Qzb0dkMWxTem55?=
 =?utf-8?B?Wk9UMW45MlYrSnl1OEQvbXFuV2xXUktCSlpkN3B4MW16eU45bE9uZnA0NnFq?=
 =?utf-8?Q?KC6AIQYK8mYXx2iFNmUco9IW6SynLxlghDXjzT5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHlnTis1WjUxb3NoQzl5WTBwSE91cFpNVlRlZkdRR21XRzZPUHNHamJKWGdN?=
 =?utf-8?B?cjdKRkF1Z1ZBWk5QR1ozam1aYXp2S05YdnhWT1hBSmlUdDR0bXZzNzluM05r?=
 =?utf-8?B?aTRjVHZRMm9hNmJ6TUxoOVFTQU93VE5wUUlqYlQxTmxOdEpscVlsa1hXRmFV?=
 =?utf-8?B?OVM4cXhlWjQremFUNnBQK05NVWtseGZ4anhUb0xUbUNpUDg3NHIwRHNNWmFs?=
 =?utf-8?B?VFpPeVJtTHdOQ0JQS2pnL0FPSVBuWktvZ2E4akxhWDNJMGtUbHdXVU1tVTN1?=
 =?utf-8?B?N1pPcklvWG1iYUJIUFd4YnUxYkpYdS9ROU1IeTZBaklKRTZTUUFqMjhoczY1?=
 =?utf-8?B?VnVRTjk0b1dqc051dFgyY1gwdS91YjlXTE5XaXNKNHppT0d0UEhyQm1YbDl2?=
 =?utf-8?B?MmtLeEs0NmlLeENPVTJvNDdoaXc3SnRpSGQxbVI3WDh1S0tOWlp6UWVLVDc3?=
 =?utf-8?B?d0JQQnFkcGtHSytFMGllMlRxRk50MnhiZXo5dFFyWjNuVFVpeDgyaXh1VFB6?=
 =?utf-8?B?SFpoQU9VYzlvbU1HemtBSDVxZCtNcnFBVFhQSDdiTE9NODc3NnpLeVI5YVIy?=
 =?utf-8?B?Zk5TT1Z4Wjl1QUVuQlI2ZDk2QlpQNUFMeGVUc1EvYlNleDEweDVGNCsrZUxL?=
 =?utf-8?B?bEFGb1lXQUxnNW9JMFlVTzNCZFk0ZXltZGlPV080amVaRzR5V0FOYTB4NWZU?=
 =?utf-8?B?bENoUW1hczd5dEFCUDlXdmg5SXhWNWlIcmdsTDdudUhFWVcrNDF5MVhtVVQ1?=
 =?utf-8?B?MkN2N3NOLzBVZ0dmbXlzMzNjb1FHL0Z6WTVSZjcxeWd5bzJTOWM5TEhsdUsz?=
 =?utf-8?B?RGFkOUpvbGUzNXhNQlBvWkQ2RENQMXFSSG5HOEhJM0o5Qmx6V1RIc1VsT2xV?=
 =?utf-8?B?dWdlRkZ2Q3RrOWNxai85NnJzZVROYzBSQ3NvV2JzYmNSWkdicnM5OU81MEIz?=
 =?utf-8?B?THA3dzZlYmZDRFk2YlFaTTNpbFFaaW9PSHVrYzkxeWN3Q3JBejgzaUp6Yi81?=
 =?utf-8?B?ME8wdkxiUnhMZkxYWGRJRnY3NUg3OFRlcHJFTU1VZjNCVTRGNjlvb2IvYlJN?=
 =?utf-8?B?eGUvWXBlSUszOVgvUVdKUDJVRW1Gcm9CSVJvWXF6cmgyY0hUeStFZTJXWE5w?=
 =?utf-8?B?Rmkrazc4RXF0UG9qM01VZzZ0NUYyTkU5UlFTZEpWM0FvcVdHaDdobGZDSEor?=
 =?utf-8?B?L284bTJlWWp0b29xelFvU2JZNm4yOTV0K2tzOG4wR2laaW9Cb3B1Y0RNY2xX?=
 =?utf-8?B?UFcxVUdQWkRDT3FYbGEwTm5CVzdlTldrT1dxeU0vQmNhZVR0MSt5QVliV0x1?=
 =?utf-8?B?aXlkS1gxVzlCVnRRbFN5aWUzZnZGYW5wWndpSitVY1NTVnB1b0VYeUltYlA5?=
 =?utf-8?B?dUREckF3bitEd0VONHVnQko4NzArQ2xhd1RrNWkxMXdEcTlJb3AwT0F1TCs4?=
 =?utf-8?B?YTBDWHEzUUo1U0czUmtHQXBlNzBVN0YzTjlkZklDcE41Q2FDem8rb053ZmMx?=
 =?utf-8?B?TktKQ3NmcGpZT21YcC9JcEZwNitkUmZMVkxYYlhJcGRuSzh4UWxjbnpmQ3FN?=
 =?utf-8?B?MUhzSnllYnhqaXVzNElkL2xpa2Fxb3dSM0xYK0Y4OE45TzViQmVFUDhlS1F4?=
 =?utf-8?B?UzdvdkR3TXJJWm9Jei9RVklSVjJsR3BPN1ZnUCtvR0VNWkQ3elFtenhUc1hQ?=
 =?utf-8?B?K0NQQnNuZ2FJS3JvdVZ0S1VrZHZBY2szYXhwb21CcUFsZ2x2ODhka2NTanU1?=
 =?utf-8?B?TWtURDM1WFZBb1I0V2VtY1lZMWgxRXNRM3lLLzBUV01adTFqWW8yTU1PTFc5?=
 =?utf-8?B?a2pEZ2QxaTltMmZmcStHcUN1eHYzQ0grbEplZnJVSlNzRUZjZ3lBM2p4SjNt?=
 =?utf-8?B?UjFBSU8zNS9WZXBBZFA3eG5ybm0vNUVpQSthYzNxYmMwTjAwQTBtMmhKU0tG?=
 =?utf-8?B?VlV1aVM3VWliU0QzdkE2c1hRTHlEdzdtcHR2Rmd0REJ5QjFnRHlDZDNzeDBT?=
 =?utf-8?B?djlvSzE3WUdYTWlnbUMyYUhhMHduMXdJa2FBUUUyZVhpQXVxbmg4YW10cWcr?=
 =?utf-8?B?RW16OUNZM3l0S1ZyazMrQTVpT1lpQ2VUNDBNMnY0S3NlVjdnWjlsZ01mYUlV?=
 =?utf-8?Q?ROrgJ8oDC+iJyuBFM661g6P1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca384b-0381-49e4-12b6-08dc9090be96
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 18:50:52.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luF2oqEq6y5oa3S5OewGGNlqsB44Uhw19svIEDOMEyk9QpJUHvoISWiJgZZs2qo80yqiRM+yS+wPXBcsJu/Rnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448

On 6/19/2024 00:29, Mika Westerberg wrote:
> On Tue, Jun 18, 2024 at 11:56:50AM -0500, Mario Limonciello wrote:
>> On 6/18/2024 08:14, Mika Westerberg wrote:
>>> Hi Mario,
>>>
>>> On Thu, Jun 13, 2024 at 12:42:00AM -0500, Mario Limonciello wrote:
>>>> Gary has reported that when a dock is plugged into a system at the same
>>>> time the autosuspend delay has tripped that the USB4 stack malfunctions.
>>>>
>>>> Messages show up like this:
>>>>
>>>> ```
>>>> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
>>>> ```
>>>>
>>>> Furthermore the USB4 router is non-functional at this point.
>>>
>>> Once the USB4 domain starts the sleep transition, it cannot be
>>> interrupted by anything so it always should go through full sleep
>>> transition and only then back from sleep.
>>>
>>>> Those messages happen because the device is still in D3cold at the time
>>>> that the PCI core handed control back to the USB4 connection manager
>>>> (thunderbolt).
>>>
>>> This is weird. Yes we should be getting the wake from the hotplug but
>>> that should happen only after the domain is fully in sleep (D3cold). The
>>> BIOS ACPI code is supposed to deal with this.
>>
>> Is that from from experience or do you mean there is a spec behavior?
>>
>> IE I'm wondering if we have different "expectations" from different
>> company's hardware designers.
> 
> The spec and the CM guide "imply" this behaviour as far as I can tell,
> so that the "sleep event" is done completely once started. I guess this
> can be interpreted differently too because it is not explicitly said
> there.
> 
> Can you ask AMD HW folks if this is their interpretation too? Basically
> when we get "Sleep Ready" bit set for all the routers in the domain and
> turn off power (send PERST) there cannot be wake events until that is
> fully completed.
> 
> There is typically a timeout mechanism in the BIOS side (part of the
> power off method) that waits for the PCIe links to enter L2 before it
> triggers PERST. We have seen an issue on our side that if this L2
> transition is not completed in time a wake event triggered but that was
> a BIOS issue.

Sure thing.  I'll discuss it with them and get back with the results.

> 
>>>> The issue is that it takes time for a device to enter D3cold and do a
>>>> conventional reset, and then more time for it to exit D3cold.
>>>>
>>>> This appears not to be a new problem; previously there were very similar
>>>> reports from Ryzen XHCI controllers.  Quirks were added for those.
>>>> Furthermore; adding extra logging it's apparent that other PCI devices
>>>> in the system can take more than 10ms to recover from D3cold as well.
>>>
>>> They can take anything up to 100ms after the link has trained.
>>
>> Right; so currently there is nothing checking they really made it back to D0
>> after calling pci_power_up().  I feel like we've "mostly" gotten lucky.
> 
> We do have pci_bridge_wait_for_secondary_bus() there but I guess that's
> not called for integrated PCIe endpoints such as xHCI and the USB4 Host
> Interface. They too enter D3cold once power is turned off so I agree we
> might have gotten lucky here with the D3hot 10ms delay.

Yup; exactly.  I think when Gary found this he was seeing other 
integrated devices not being ready in time too, but IIRC there wasn't 
functional impact from them like there is on XHCI and USB4.



