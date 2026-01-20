Return-Path: <linux-pci+bounces-45277-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJn6FnGnb2ndEgAAu9opvQ
	(envelope-from <linux-pci+bounces-45277-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:04:01 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CBF47053
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35F298C73E0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC12D7DC1;
	Tue, 20 Jan 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="doxpColj"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470682D1907;
	Tue, 20 Jan 2026 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922171; cv=fail; b=i5PQT7V5qpgZtFofH3fdycB0rtw/l5XVNvcOOu9PjLjgKqNGnARK/a++PMxcLmhsfAcdB7sPm6FBvaBMVgne2LcwD0HvX/T3Lc5UC1i8b3ankKA6IQyTvgXwrNNjwLNOCxJhrfgXrj9dDkgHjSgW/SqmEWUrpMVL+cEMwDTxP2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922171; c=relaxed/simple;
	bh=BIpl7AdCWh3tlSpzmUUoJ1Txdn5JMUVYCXZm6Zc2S1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Usj/BCU0KEJLmkH7BXhs+bKSLJNhScUENsbwlh5LKOOIGBK5SOpbnZZJVTH1cOhOG/uiogaTG6/UUZ2JiRSNmW3GNA9BPjSNeegQdLcrq7vS4qAn8hLBqtVl8GBCVXBjl/p1+96x2YX7e9XnhLhKhRrCvCBaX0wh4Cr4WhRaupw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=doxpColj; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWeO00gHoriM0KsAYecOcOeDVgZCA24jnS89cEtceDR8+Yk2VBW/5bByFdcHZiZtIB9KrqPBMCuXxQ+GjpXspRBYLsesVLKzAfDkFilpz2h9wQE3s1w27ZkyteGgCx9AE2Cp2LsdU6TjoYEe1bRdQINQjnxf+M5P5JdlLgC6MfNQkX54UE+4fJBTfCxlfEw6vsy7pSCmfydLenk+rsYTtpht6vmOtno+uPjaFTNNdms5tMdo5nylQ0uXLl6m6GYUTtkzNzd1TPbHvL0x5MO6zoeduASM5bhstZnHHI3XS/4RWYKc6eEAh4PI9TqNPTHD695oOkRWocE2URp4rtgDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMx8D8tnVBVboytFUGfykZcuB+YSz59BdzQKd3MQSMo=;
 b=NthsjWhhpQu3/vDHUJ7PCdS2ktrZpbzY+SJjgfbBVwlFbZAaCpbjdH1Su+63msVE3b8tdzHGgUl0YJS2yLZ+6fX0HWjf09tI3FUvc/pRVYnDOYFoCMRyKxhAzx2Bqx0ptfIyEZ3RSS+jhEXtkZN5AU01WOt2bR+IkSSRX3uO2WT56It/UjGJrAd5yDAcWX07LBp7wPRg1cKe2jgQ6SEVjzUvkEFcdiZ/IbAgnUhdykGi9/m5wKial8u5T9BYyv7mW47G+jDQkvczYPo62nmJO6m0Z0cccFJ3SLPq94i85ranKQIbA1HD1X7QwoRV6VmaqZ8WZSUGAWKIDCiaPvYyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMx8D8tnVBVboytFUGfykZcuB+YSz59BdzQKd3MQSMo=;
 b=doxpColjh70fiGdq6fyiP3S41ZB9O3o/VyKPMRhbUGbMSqsy5cjGqZY1K4ncm2LT5p4L/ijuvDUz0l2PmHC/1U0DOzGqIMPV11TGsPR6VluVgcQIFZR4EKimfkJ3ilAeu6JwytmTl0sHPnQ9p3TAXMjQ5SdCzMWipv7RD5rLvnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:16:06 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 15:16:06 +0000
Message-ID: <fe7cc68a-ae45-4acf-84c2-1a80921ffd4b@amd.com>
Date: Tue, 20 Jan 2026 09:15:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <696ee66c85a1_34d2a10020@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <696ee66c85a1_34d2a10020@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::28) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e579bf9-0111-4ab2-012a-08de5836d534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjRmMGVCYWQrUm9ERjNOeVoxRGtKdlhvMUs2S0d6VWN0U3R5Q0I1Z29CQ1p1?=
 =?utf-8?B?RE8wb1NyTkw4RTlnR3pvVk5nUCswQ0lCajQ0OXp1SCtlNXZ6SUpZQnhPeEVu?=
 =?utf-8?B?YUJxYVJNTnZEQ2NXcVF5b2JpdTNkRnRXTWRHdHk4TGNxbUdzencyazBRWXds?=
 =?utf-8?B?Q253bTNDZm9jc0UwVmUxdWxBemlkbkpDaHV0WWZSZFlyYXVaKzhZR1FTR2RM?=
 =?utf-8?B?UklJa2JBZEdFSThRWnR6a09vaC9jdDlEQ1YrRFJQWWIwK2NUc0hIUTdod016?=
 =?utf-8?B?MXlMQU4zaWFsMk5TZUNlWnRjemdvdDVVVTRrOW0vRHhrWlg4a2krVmRwYVZa?=
 =?utf-8?B?QmxBOHpoYWtaNE1sUStnSE5zb21mcHJvc21MQVpJMmc3WmtEc1pBaE5DM2FC?=
 =?utf-8?B?REVrQWJ1RXNKMGc3aHVucWJDLzROaW85bkFTZTVJSDhoek50YkZ6ZDJnU3ZW?=
 =?utf-8?B?cENiVjlMdW41RmU0NmZJZzgwN2VTRWw4TzZ4VzVrUGRqVWxNam1XR1l4Tita?=
 =?utf-8?B?Q3NLN252S2wxdmYrRW5lYk52dFdCNFZXTVMrYW5TcEFnN3VKbVRtOHJQeVB2?=
 =?utf-8?B?LzBhOVlEbEhmd0IwUEoyMVBHdHFqRlZ5aTBBeGtaeDExa1NWQzUvd0o5VWFz?=
 =?utf-8?B?Rkl2MjNWOGxYSU9HcHhSdG9UZ1R0UlQ2VncwTGVzR0xWR3IyNlJzZEYxNnZz?=
 =?utf-8?B?cGlEbnJJc2FvV3UwOGw5MGtBZlNZK3AzMHFGTTVod1FpRTFvSDZjQTRrUnZY?=
 =?utf-8?B?Y1JHd0Y1NnVkNGRQNjhvOStCaGlZU0hwQW5uZktLdjhGR3QwdHh1QnJ0Tkk5?=
 =?utf-8?B?QmowVC9mbDZFOUtodys0NGJaTi80eFFnMmdCaXhHZTRZaXlhdzd3cGIxbS91?=
 =?utf-8?B?TUNLR05Ka3U5QnkxRERWNmFEaUhabythR0tvWFpqYUw0dXRGNWVrTkdPaytP?=
 =?utf-8?B?aTlyOUczR2xxQU9HVkIvbnc4RkVhdVpNZ0tUR1FvZkR1UElVajVjVlNJeGUz?=
 =?utf-8?B?RHZhczdXc1l6SjEvOEVreE5QNkgxNmFZdkx4VGJQNXFRbURjSkt4bjZaZ0Rp?=
 =?utf-8?B?eFVZRUw1NkJEdXNId1M4THJPWE1jMm9NdnZUSlJSeWlTQXdLZTNsTVhUQTlt?=
 =?utf-8?B?WUk2dzA4UlhGR2x5SmRzR1lwaTFnK3phUTJJY2FwTWN0Ym1EU3ZQR2VBZm1K?=
 =?utf-8?B?RFZBNXRFcEYySlF4M05xcmdzcGZTeUcyeDJtTlhSeFh2OXh6aVlkSUNSaGJ3?=
 =?utf-8?B?NjQvcm5oUHBSdnBLUVZPZU9Yc1NuS1hUUUZRYkp1czQ3TmRPUTBRZ0RNbnBq?=
 =?utf-8?B?a2lGRVVkME5HYVRJUURuM2ZjTUFDT3ZhL3V3Y2ZLK2pzY0huMTV3UytYSmNy?=
 =?utf-8?B?bmIyT0J0TUIzNnZCc2UvY0ZORUc2UU9Pd3VseGp6TDI3RnJiOWZNclpyUFor?=
 =?utf-8?B?eGt6QVEwekdvMnBiRGhHZTVYVFd4ZUc3MDl3KzlqcnVLQlR6bEt0TDdhM0cw?=
 =?utf-8?B?cTVaeitmanRpYUh6R0RRK2doR25KVFl0ODZ3T0Vta1M5aXlEWHg4MGFoRFdO?=
 =?utf-8?B?SmtnOG1nQXBYNnVjdUFvS0Q1MlJNdERyR2s3R2tMUThNc1F6QUVGTXAyQUI3?=
 =?utf-8?B?RFltdUFLa3ZHWHJuaC9PS0lYQXMvdDZSL3VmUDltdVBFbEZpRjZJbXU0aG13?=
 =?utf-8?B?VS9telg4UzVhRVFWREJUOW5CZWtBZWNwN1VLWmZrYWRHK3owdGJObC9LOEw3?=
 =?utf-8?B?cFVxUllzdmF4NkorbUJMSUYrYW5aZHI4U082Mmt0YW44TmtsZTUxeFhkaDQz?=
 =?utf-8?B?bkRDZWY0ZFVlNUpkbjFLSStEUUVlUzgvbEQxWU5ZK05PUWU4RUtwNzY1c1Zh?=
 =?utf-8?B?TjVSTC9TTFA0NE9uUWZLWU80RWpjcEVTVGNWUUt0QVZYU2tjWUMwaXJhMERZ?=
 =?utf-8?B?UjRCbVQxSVhYbmJDckxPM1BYelZZZFJGQXJzSnZoT1VDU0ZuS3lBUWtoQlVF?=
 =?utf-8?B?eHdVemtET3B4Zmt6WWtpakpaTnNhNFlNRlAyd0h5Ymg3NTVKMklqK3l1Wndu?=
 =?utf-8?B?blY4RnZXaldPdEVUTG12dkdGM3VuTGgrSVZwMUowQ05BZnFnRGx6VnBmZlZn?=
 =?utf-8?B?TkxZV1BCb3JPMlhVYVFxcEJJeDFobE5IVlhoZjZBUkdLNEpXbjBNMWIzZW1i?=
 =?utf-8?Q?zX0LuD7jAOoxS+XO2IcbnyE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1FjRDZjZFBUMTJmSFV4YWZMYXl4R3BOL2xqNndCSHQ1T2pYOXcxb0hvZjl1?=
 =?utf-8?B?b0l4MENRb3ZuK3c2SVBzM0RZSHY3QnBadER0NFY3MUM0OGtwQXZJWXFLeEtS?=
 =?utf-8?B?VGhSWWxMMExSQjN4TFpxRGhwR3FiV3pQU1Z6RTVxeDJUQncyU0EwV0xBRmFx?=
 =?utf-8?B?Ukd5MEYrMy9XQ0RaZ3ZxSWxsQ2lQMTZNSVVXQTZsTkdCVElBVTYvSjJOMndv?=
 =?utf-8?B?dVZ5MTNXakozMG5OVXNrbHNZNFN4SkQwZ2gvUDA0eHkvb0sxNkQzbGp4R0sx?=
 =?utf-8?B?T0ZUanRWbEJ5YmNzRytUTEhWcUdHWTVLOFRrMWxaN0p5NGJhL1k4d25JZGlp?=
 =?utf-8?B?eC9Na2dJQ1EvUWNNZUJLemErbXEzbFJ6cWc2NExsS0VDYStITG5ad0xSS25F?=
 =?utf-8?B?QmQwdGt2dlFuTmd1dEMxS29XenlLTzNzY3RWUDliS1UvR29VMkZldm93ZERB?=
 =?utf-8?B?eWpsYVM1emVWTHYzc0wxdUFLVjVJYk8rTXVFeXE2b0tUSUwxejh1eEFFeFdP?=
 =?utf-8?B?K2hxbHNwbUpmQmpqV1RuamltZ3dNT0hxRFQ5Z09IejFQaTNjUVRTS25Cbjht?=
 =?utf-8?B?K0tEd3JSb2pKbkF1TmF3THM4UzQvRThXU01FY1BsWTdNZk55QzFOczQzTE1G?=
 =?utf-8?B?KzlsMHpUU25sb3BwRGQrSTkvYlh0Ni9YWG0wcjQ4UVlFdDNaOEtBRzIyVTdI?=
 =?utf-8?B?anJTNVFtR2NYVnQ2L3JDMnA4UE5xMXg4a0twL2lUek0xVWpEbnpSMGRUWnQ3?=
 =?utf-8?B?bzlSK3AvRk5FMTVWSFVOaEltbEVIYitqWHZUbEs5ZjI2dlo4a2V3VTBCaDcz?=
 =?utf-8?B?aXhEUFFwQ1VCRXoraDI4Uy9JYWR0eUVCc0Z5bFpwZXAwTG10TU1ZNWVEcUZn?=
 =?utf-8?B?djhlNllML0NoQ3Rsbk1yRlE4cm5PNTdoYldpN2UyZFBTa3I4QjVuenc3ZDUz?=
 =?utf-8?B?QkVETXNxa1NIZ2I4ZDB1S291NEtQMTBBdEFGS21aZmcrQkwyU2NVU293cTQz?=
 =?utf-8?B?b3A5bGNPUDYxUHlURWI2WmhKQVpPTHFsRkxqMUthbUFEWlU3TkNHQWovUzFp?=
 =?utf-8?B?djNoMnNPZGhNVjd2aElibk8yVUpQajZPUVBOek9kaW1kaUtNeTZ0TE5xSHJj?=
 =?utf-8?B?djdGSlBOOUNlWk5UYXUrZXdZVEtUY2ZoZFVyMVhnSStnYmhqZkVZOWhOOG11?=
 =?utf-8?B?L2hmNVZtbFNLNlkvaDU0Ti9zb1l3UTdSYmxYcS9sbTVoaHdMM0JSRUNrbWhS?=
 =?utf-8?B?OTNaQWNoY0lDeWdZQTNubkgyenpyNDk3REN0TW82eEtZMTRNQjNlL2JyNFlK?=
 =?utf-8?B?K2FiMG5sc25nWjhwNjUwSFRLYjRNQ2dxMFZlTXlsMHdJNHBEb005RGZTZDcy?=
 =?utf-8?B?alU0Y1BnOWMrdzBTYUhsdGNVWFF4WEtrQ1hWVmprd2dLVVNSRmVaN3ozYWNk?=
 =?utf-8?B?eXhKWlgwdmQyNTdTOEU2cUFxU0hGWkFWbU9CamsxVFdpeGJUVHo0dGcxd1o3?=
 =?utf-8?B?YThNOENkY0kvaXUxUWNZL1RPeGxYd3E5TFNnT2h6aTNVU1d1R3o3QkYxMkta?=
 =?utf-8?B?T0Fia1Y5V1ZSR2RKd0hHUW9tU3RVYk91aS9PWFMxQy94VXBXeTRyR2UrTGU2?=
 =?utf-8?B?L2ZBamhEcUdKRlROUjU2dnVpUHdGVTdHcGg0SjY5S2tVa2ttQjhxQzdhN01o?=
 =?utf-8?B?cUJkRXpHNXcrUjZtNStuZFdHanlZVHEwMEpGUm55K3J2UG5DWks0MndHOHow?=
 =?utf-8?B?NnlZV0xWazZ0Y3ViWHQya3BHcm51QVYvMXprUVM5UXJ1Vi9tcnhRMHhKTXli?=
 =?utf-8?B?a0h0Y0lpQzJtV2JwY2MzK2paZFpTeFIvYVFET2V3cW5YbjRVb3REMitCL2Fv?=
 =?utf-8?B?OXpNYnR1VlJyMkhyMExiam93b3NDTVRsdXRwMjZZQ2FuMmdpKzJncFQrU3d2?=
 =?utf-8?B?QVpIUlBIVy9ta2EzRTlLaEZoY2VSQkdISDRFSWgrM3FkVjVCbE1UcVJpNmxW?=
 =?utf-8?B?K1lPVE1qby96cTd4TG1sNGRoQ2ZUcDVGOWRQRVhsSjZXVXRyUFk1aWowMFZz?=
 =?utf-8?B?dDZWNm5tdTRQRVNNRmxCcmE5K0IxbDlQeHVZVFpBVmppU3R4NUc4S1VpTnp6?=
 =?utf-8?B?L3lkcGcvT1JOR1VCVk10Y3B2ZWdDSTVBOXhaYU02SDF4WFBxaUVwb0l6ZmxP?=
 =?utf-8?B?Z1o2cm1SSmJWZk1LMFZrVUxOSFZMZ2Rtb0kyY2grNlRTZDJNcEppVHNXL2I4?=
 =?utf-8?B?N3RVcUllNTROaHA2bzB2NEVmdWVBMkZvMEZLZGtWeVlHeDVyc1ovYzhNcFB2?=
 =?utf-8?Q?mlhfB8PkPOiyW5k7ru?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e579bf9-0111-4ab2-012a-08de5836d534
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:16:06.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jQOmVZH2cPPP0+LxZs0osNe0ZXK7YXpozJunnUtTP2J3gyNqfICnXJV5oRzWjTwE1G+97J1OQFunMaz9QTMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-45277-lists,linux-pci=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terry.bowman@amd.com,linux-pci@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B9CBF47053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/19/2026 8:20 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> The AER driver includes significant logic for handling CXL protocol errors.
>> The AER driver will be updated in the future to separate the AER and CXL
>> logic.
>>
>> Rename the is_internal_error() function to is_aer_internal_error() as it
>> gives a more precise indication of the purpose. Make is_aer_internal_error()
>> non-static to allow for other PCI drivers to access.
> 
> Not even sure this rename is needed given that it is private to
> drivers/pci/pcie/ and the sharing is only for cxl_{rch,vh}.c, not for
> "other PCI drivers". Consistent with the idea that internal errors are
> not going to become a first-class citizen let us keep this a CXL-only
> consideration.
> 
> I'll update the changelog to drop the "other PCI drivers" comment.

The name choice was addressed by Bjorn here:

https://lore.kernel.org/linux-cxl/20251208180624.GA3300935@bhelgaas/ 

Terry

