Return-Path: <linux-pci+bounces-24965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A3FA74F8B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F2E1893D1F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D41DDA0E;
	Fri, 28 Mar 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oEJkQKVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097C1DD0E7;
	Fri, 28 Mar 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183416; cv=fail; b=ldMVDm7WbgfFPpvwcFhePeDkZ7uGy7qN+Ze85fXcIF/UK+ypsInptCyslsmximOi5sEF+kE0ZL/a1J9VBsHGIe5C+OwurCxLH+YczVeWNaohtTmQkk3oUTjR6hkD4PTLG/69UYneE1VemoFJymMa7vIWPwyEZHy39PkLf1PlLaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183416; c=relaxed/simple;
	bh=IIvFCMubn2H89vnnzvfsOkFwcfMQ+ygmwpp1aMryEOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqF2YEfSmLacUNA5S0gz2GCQ9A9w00DJgH+IizwI5Z9HS028bYJWAmwdo0ieyPVhx04hcB4hXagMsZNOqWxmfP9qGVhbqNE+uAySmMrheCwJPDD9IcdobSKm9x4I1+80HliI8RZjH8hCz35Ijt73z14x3NSz7Z62Z7S5ma3fsBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oEJkQKVL; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tctPSoTf4MjOgf83geRjacm5EGrm69MB69P9k+VQmzIbjaPfSlcOmf2fow9cOeqZVM8SqLvi8Kb5EAjH1MhqIVR1x/Qoj0poZ//FCs6+fpsOKOzE1DhR/zAVOzUZFhFuRT1QE+7ZVxxIxwKTctp2KZLK1omNmP1JK3j4latilxu98xAIzsqghygWIaecaewvivOaRdlB76wnaKe2n+Bd/CKzKPDLFtdav34Mr79yHzQlktVciNYOPmTXgBokzsDEXqGNKiUG/vjvCi7gm/ClOLOjM26zz80alIhBODf8Y4bDTDWz76cHTp4ZmbmHrXgA6K+hEyEyRUu3EdOz3Tk+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vVDsiL9+LhKEFkTsIe2dfEs3NkEJMdolkcYT5Bln04=;
 b=KqGq/XnAbuz6JRrChQjbqRddv3pooHPXg4yW1b2KEGxnBFzqoBpEtEz7kvtc/j0SPBmubNffN1n2JH71NJWGme+1aylsX2B9TxsnNPxT3tP1qc2ZX1h/wVlH+uDw3U7Bwjgn//vGlBGmto9p5cEqUg+gF5kK2MSE9+q1drgILWE2xs9VCoSKZTTCXr+GV/vMhhHnRIf+aAcjx0ddkyZjqZP+vqxsF38153LE9VP3Amf9qK5y2Ph9KhSHqzJxq8U4G26HvQ6Okw8TwucBbd1zErJ4UHBJ/b7Ob2+NgY10gUo9ISyDWX9yrbcNsvEj9xN9Ls421VzF4dLibvax4+Px9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vVDsiL9+LhKEFkTsIe2dfEs3NkEJMdolkcYT5Bln04=;
 b=oEJkQKVL0To9+fwNjo+Qfpv2sfslIxtcY9dg5aHHOhqdMGLCwY/i6Oc0MvKYXs8xFBj7L3uVa3LLV9DFgeW4Td45/JwFagnOX8mHRQnUcP0ACzEHdHOvCQVOXWm9OMK3r+7NKMNCo+1UM/4koxeCweKLTuEzhOsjWbJpGp1jMf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.47; Fri, 28 Mar 2025 17:36:49 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:36:49 +0000
Message-ID: <3d2aafbc-9655-4795-8faf-bd28511643da@amd.com>
Date: Fri, 28 Mar 2025 12:36:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250328170212.GA1508786@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250328170212.GA1508786@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0032.namprd05.prod.outlook.com
 (2603:10b6:803:40::45) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: a0099172-c316-4353-cc3f-08dd6e1f1e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXQyTW8vdmw2SG9QOW50c0ZIdU1QYVN1Q25UYy9kWkFHM1g0Y3d2YU8vQUx2?=
 =?utf-8?B?aEV1czhKM3lwUE1yeGNCYmJGQVhDYmw4MHlON3VxeHoyNlp5aFZwZGNCQzhE?=
 =?utf-8?B?cklUWldpSFlxKzE5ZVpPbm5ZN3N1eUkwMjJucGk4enBCdkNjVk5pQUQwdm5l?=
 =?utf-8?B?dkhtWVp5SlFjQnNOMGxmR29OWUhBbFJua3NnN2pKLzhHSWVOeUJIVHFiQUtJ?=
 =?utf-8?B?VXB4bU92N2RXSkdqcXZzNHdoWlc5d3hNMjlQWVJjOTRKQ3k0dDduVWRvcUFK?=
 =?utf-8?B?ZDF4aldQQnNXNnMwYmVEalQ2c0N1RGU4Y0xoTGtQY0htMFF4OEJoaU9uSFlM?=
 =?utf-8?B?cEdyemNDTVI2SHV0RGppZ0pBT3kvTWVEUXYrZHgyaGxLamZFd244Z2h6TzRj?=
 =?utf-8?B?aE1JTGtGOHNmckR2N2loeUlEdnFKYnEyN3lYd2wzYVQxK09ubURTVkI2bDRO?=
 =?utf-8?B?dGMwT01UY1dFUWEvdU5ia28rNXVkbE9McElYRWgxSG1mb1NaSzFrKzVOVFBY?=
 =?utf-8?B?RHI4d0xNNkZwR01KY0tjWVY1ejNuUk9jTWJ2Tzk1aWxQY0I0SlZrbk5GRXNK?=
 =?utf-8?B?aHN1RnRiMjVtSk5ob0RJaFdDeWlBd3dyT2Y1amlXMnhpRUN6RzdQWWNjVllD?=
 =?utf-8?B?OEVvWmF3WkNBSUU1WWxRbDZmNC9qaTd1Q3R5aVZYMkRXWkx0K2VZWmgxdlZx?=
 =?utf-8?B?ZTBGdlhldVBtamhzOGNmSlRLdGJqTTRsZy9qRllCaWsxNlZ1aGRSaVk2akRG?=
 =?utf-8?B?eDVteVVySHlQdTNQbnlVS2F4Qk5ReHV2OE1STkRQN2RzbElEaDZLcmo0emZQ?=
 =?utf-8?B?bHFBc21wTlcySDFweENvZUlPamZBSXNjYkdLL0pVc29sUGp6cU5ybzhCNDlj?=
 =?utf-8?B?V3A3RmV3QWhjTmdRUy8wdG0xOGlOcEhQRXNEWE8zQUdUb3hTbjYvSnhDNWo0?=
 =?utf-8?B?REphaGFXNXJ4QmhwYVNRMTc3TkhtOXBFU3NLbUpZQXQwYzltYjdKUzAzanUr?=
 =?utf-8?B?QlNCMDh1UU1hYmw0ZFJWN2E4aWFjam5WQlFHM05tbjllYWpxVGFsVUpCZjcx?=
 =?utf-8?B?cnRQQ0NwQ0p6MkJKdktTclo0Qyt3Y1NKL3EyWkJFb1NxVWg3a0dsVWpkZkVO?=
 =?utf-8?B?WHZQYnk4aU5KWTJqb1ZEL1lQQWxWeUVhMVY5Tjd3WFBlRGxoNzZqdlV5enUy?=
 =?utf-8?B?RThtUWdKaHJhWWw5WkJzK3ZrdXZicG1kVWtsWVRvaFh3L05WWEN2Ri9SSThj?=
 =?utf-8?B?ZGNQYUJjZUN1alFCWkVMdHdDMzdBZlZ3WWFMT3R2OEwzVnY3a1dpWCsrVG00?=
 =?utf-8?B?TGNLQXRwSFBhc3U0MEVrdlNvVG5tTkZQUnNuOE5wdlAxNGF2dENXV2RTZUJ3?=
 =?utf-8?B?TWVYcnd0VDNPYTNPVjBxWWlWMlUzcWpJd25ZMVlCSHJzY3BRdFZOQnZhNDY0?=
 =?utf-8?B?WkJidnFjME9FdDhQVS9adU5Ja3MycnBSeCtGNk9MSStnTnFDd2FFV1RFRW1U?=
 =?utf-8?B?Z0FUV2ZmUUJ3SjIvamVMd0xKQmJBUFoycWZlRnpML2JyNXdWM2wvS3lEZzQw?=
 =?utf-8?B?bWRSbUQzK1poZDM5dzBZVVcxTjRGTnRDVThYRXQwWWM0R0ZXcmh5bERUREdE?=
 =?utf-8?B?dGhCRkdnUTR4TTZsdDFEMGhMeHY3SzJRa3dCMVdacWlUeUxkYWhPMHVvOFQr?=
 =?utf-8?B?b05PdG9VRHlRRU1aK2ZJVmNpN2I2dzUvMnBxNFJzczRWbmhQZG1NN2R5dEVI?=
 =?utf-8?B?dHlDd2xnb1JFM0ZWZUpsdHpyR1NNY0xRLzNXbmdYallkZW43cW9VdjRsT3Zi?=
 =?utf-8?Q?Nmu3QJm2tONZa0/Uhq2nP6S9tOUHP1Yvv6bF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlhPYUhIK05rYng2U1liM3RsWXExNVdvSDVBWk9ONjBwdEswUjZIUitSTVN5?=
 =?utf-8?B?TkVOeHFna0ZxMmNjUEUvVFlGSjhKYnhPVGN0MWEwZGdmOTVnNzZ2aHZiL29s?=
 =?utf-8?B?TTB1ZTlEQkhITmFERW1BVDBoWDJBSG9EYjVqTk0vMGJZcjZXTUFob3FuVDhE?=
 =?utf-8?B?NnlydGFVOWdEbUZ2d3l1WXpKdkROZDJ3cWJ0SEZxaE50K0JQNisyWUtFL2g3?=
 =?utf-8?B?ZUx4V3dIVEhtN28rUjdrR2V0bWtCQmh6bVJBay9OSFZycjh0NDZmRGxRL1Ev?=
 =?utf-8?B?cmdESTA4eEluODZBOVRoTnVXZmhGUmZGSnkzaDVlaFUveHB3ZkNQVUpsMzl0?=
 =?utf-8?B?cE95K241dFI2alA2OWQwYUlmcUxvMFlRamtyQ3lzY0cvSlVoZEJUdGpYM3hF?=
 =?utf-8?B?QjF5R3dPMjAydGhPZEJaQmtsVFdLcmU2K3k0b2xheHVzZWZ5SWNOWkxLcjR4?=
 =?utf-8?B?SmJ5Q01ZUWJaMjIxUkI0Y3k1bkZ1MHV3djV6c3RMK2h0MFZyQlJ6Tml6T2du?=
 =?utf-8?B?S085emV3RFdmS1BLYUh2aTRPdTZrNmJqUmV4aGN4WjdCYW0rYVlVUStua0Rq?=
 =?utf-8?B?bjhBb24zQnEyVHBya0pkeUpVWExUQ3U4REdMZTM2ZE9odU8rZjRld0EwbEM0?=
 =?utf-8?B?UUM0dDZIbG5uemFPWXRQcWRBZGFzVitFODJObHVnZGJqVEFiZU50aVpmbElw?=
 =?utf-8?B?UUxKTEVzdit1VEwrbENZbVVkYUcrSmpWaVdNd2l5eXpFaHNaVFpWT0ZadUdx?=
 =?utf-8?B?WnBjbFZkTk1KeTBwbHVBL1NvTmpnLzFJeklHTTJ1dGtOcTIycUNFcEdZWVJO?=
 =?utf-8?B?QThBcWh6SWFrVUYraDRWeDNDUkRtRDAwc2RiQnVWYVJuTG04cm9VUVdvN1M4?=
 =?utf-8?B?Q1A3RW95WU1MQmZGV3VndzRaYnlTaXFOR3NaTkpxNUp5cUhSN2lRdzFtdC96?=
 =?utf-8?B?aWpFWHZDVS8vaG42RmtJbzBSeVRLRUJTRzBCc2QrbUdSbk1ubFJZNVZ0NEtQ?=
 =?utf-8?B?d3JETEFDWktWYXNuL2F0M3kxdEFsZHdGcnhxcU5KTkFIL2hmZmF6V21jUytj?=
 =?utf-8?B?WlZraXdJT0wvVEhKOTd0clhobjlpenhSMktrcTZKa1JybGozTnVxQ0R4aDRS?=
 =?utf-8?B?R3dkNTd2QVBmbzNKVXM3TENCSUJzZ0lBdFRrdC9jbHNCd1ROcGluS2E4cUwy?=
 =?utf-8?B?TnBDMFFLTklEK2N1ZkJLbXkrMFh5ZFRHVDY4cFp5R1YwMVlDbUlISmw5ODRZ?=
 =?utf-8?B?Z2pIMTd3N1A0Wjg5ajR0b2Zub01pdzFNQU02UlFLZlJVWG9zd0l3SHJwKytN?=
 =?utf-8?B?QzU5cHU4aTUxT28wTklrNWxzVVBYT1VTSXdOVkZ6OGphN0UyZHg2bWx2bVZn?=
 =?utf-8?B?ZU1GVk9lSmowKzZITzA2T3VKWW5LUGlIR2QzZ3ZyRm1DcXlmUkVuaGdYaGxt?=
 =?utf-8?B?N3pCcVZURys3dmt2bkNFYytBVUdHanEyWDdQWGlTbWxBakczSkZtM0pKbzR1?=
 =?utf-8?B?SVoybWJvakcvNzFJekRqUDlENUhFWkVFMlJrbkFlSytWSytDSytuSmNNRDhw?=
 =?utf-8?B?bHJTYU1sZHYzV3lRbHBTNCsrQlYyWk55T1Zya28wQXhzSEVrMEQ1RXlMdVMw?=
 =?utf-8?B?MGVWNHBYQzc1S2pPdkZabHJYSkplVXJwMCtGaStsbzNiT2FmT00wTWc4ZVlS?=
 =?utf-8?B?bmhqQlZLR1c0R3BqUURyeXFodldXRFNpK29CTWN2ekRYaTdNaFh5c0VaMHlX?=
 =?utf-8?B?djRZMjJrUW9CSDYvUk02M0c1KzJpVXgzZ3ljbStuNkpnWmFtZ0dua2NSR1hp?=
 =?utf-8?B?eGhqU0xIYmk5WksydW5lakFpZGF5UUNzeFpYNnU2NlQvUjRiY3FzNFRwLytT?=
 =?utf-8?B?VldQT3NYdjIvT0NpUFQvdHdVNnFqK2V3RHdFMDZjc0RJazVYQWpiaVRoUVd0?=
 =?utf-8?B?LzNSNTJBdThZdlQ4TEF2aU1FMW1FZVljNlIwekp0eUtieFVwK2IxOWp6MUVw?=
 =?utf-8?B?ZHl3RG0zSTFlc3NVNnYzRGNMOUU4UGduNXc3Rkp4ZGZUb2Rva0djNTBnTWRp?=
 =?utf-8?B?OGVOaWRFZFJiRnJQWHljTmozbXkyZG5hOXhsT0JpajZPZElnVlkrV1VjNTBB?=
 =?utf-8?Q?IbR0+R22brnPbRcmylX3g1MVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0099172-c316-4353-cc3f-08dd6e1f1e5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:36:49.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGF3t2cWqWtDjkgj9TloUU0vQYlrC8HMJjfVADb7QRY0qpmnFRLMU2nsFf+gua6ykGiYXavZsPRYSBcuS9P2rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671



On 3/28/2025 12:02 PM, Bjorn Helgaas wrote:
> What does this series apply to?  I default to the current -rc1
> (v6.14-rc1), but this doesn't apply there, and I don't have the
> base-commit: aae0594a7053c60b82621136257c8b648c67b512 mentioned in the
> cover letter.
>
> Sometimes things make more sense when I can see everything as applied.

This base commit is from cxl/next and can be found here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next

Terry

> On Thu, Mar 27, 2025 at 01:12:30PM -0500, Bowman, Terry wrote:
>> On 3/27/2025 12:08 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 26, 2025 at 08:47:04PM -0500, Terry Bowman wrote:
>>>> CXL error handling will soon be moved from the AER driver into the CXL
>>>> driver. This requires a notification mechanism for the AER driver to share
>>>> the AER interrupt details with CXL driver. The notification is required for
>>>> the CXL drivers to then handle CXL RAS errors.
>>>>
>>>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>>>> driver will be the sole kfifo producer adding work. The cxl_core will be
>>>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>>>
>>>> Add CXL work queue handler registration functions in the AER driver. Export
>>>> the functions allowing CXL driver to access. Implement the registration
>>>> functions for the CXL driver to assign or clear the work handler function.
>>>>
>>>> Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
>>>> now. The CXL specific handling will be added in future patch.
>>>>
>>>> Introduce 'struct cxl_prot_err_info'. This structure caches CXL error
>>>> details used in completing error handling. This avoid duplicating some
>>>> function calls and allows the error to be treated generically when
>>>> possible.
>>>> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>>>> +			     struct cxl_prot_error_info *err_info)
>>>> +{
>> ...
>>>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>>>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
>>>> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>>>> +		return -ENODEV;
>>> Similar.  A pci_warn_once() here seems like a debugging aid during
>>> development, not necessarily a production kind of thing.
>>>
>>> Thanks for printing the type.  I would use "%#x" to make it clear that
>>> it's hex.  There are about 1900 %X uses compared with 33K
>>> %x uses, but maybe you have a reason to capitalize it?
>> Got it "%x". Would you recommend the pci_warn_once() is removed?
> The dependency on pdev being an endpoint is not clear here, so I would
> just remove the check altogether or move it to the place that breaks
> if pdev is not an endpoint.
>
>>>> +#if defined(CONFIG_PCIEAER_CXL)
>>>> +int cxl_register_prot_err_work(struct work_struct *work,
>>>> +			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
>>>> +								struct cxl_prot_error_info*))
>>> Ditto.  Rewrap to fit in 80 columns, unindent this function
>>> pointer decl to make it fit.  Same below in aer.h.
>> Ok, got it. Without using typedefs, right ?
> A typedef would be fine with me.
>
>>>> +struct cxl_prot_error_info {
>>>> +	struct pci_dev *pdev;
>>>> +	struct device *dev;
>>>> +	void __iomem *ras_base;
>>>> +	int severity;
>>> What does the "prot" in "cxl_prot_error_info" refer to?
>> Protocol. As in CXL Protocol Error Information. I suppose it needs
>> to be renamed if it wasn't obvious.
> Unless there are CXL non-protocol errors that need to be
> distinguished, I would just omit "prot" altogether.
>
>>> There's basically no error info here other than "severity".
>> Correct. It's more accurately "CXL Protocol Error Context" but I didn't
>> want to re-use 'context' because 'context' is used for thread/process
>> statefulness. Also, I followed the existing CPER parallel work that uses
>> a similar kfifo etc. Thoughts on rename?
> What's the name of the corresponding CPER struct?
>
>>> I guess "dev" and "pdev" are separate devices (otherwise you would
>>> just use "&pdev->dev"), but I don't have any intuition about how they
>>> might be related, which is a little disconcerting.
>> "pdev" represents a PCIe device: RP, USP, DSP, or EP.  "dev" is the
>> same device as "pdev" but "dev" is found in CXL topology. "dev" is
>> discovered through ACPI/platform enumeration and interconnected with
>> other CXL "devs" using upstream and downstream links. Moving back
>> and forth between "pdev" and its CXL "dev" requires a search unique
>> to the device type and point beginning the search.
> It seems weird to me to have two device pointers here.  Seems like we
> should use a single pointer to identify the device, and if we need to
> get from PCI to CXL or vice versa, there should be a pointer somewhere
> so we don't have to search all the time.
>
>>> I would have thought that "ras_base" would be a property of "dev"
>>> (the CXL device) and wouldn't need to be separate.
>> "ras_base" is a common member of the CXL Port, CXL Downstream Port,
>> CXL Upstream Port, and CXL EP. If one wants the "ras_base" for a
>> given CXL "dev" then the "dev" must be converted to CXL Port,
>> Downstream Port, or Upstream Port.
> Passing around ras_base seems dodgy to me.  I think it's better to
> pass around a real entity like a pci_dev or cxl_port or cxl_dport or
> whatever.  Code that needs to deal with ras_base presumably should
> know about the internals of the device ras_base belongs to.
>
> Bjorn


