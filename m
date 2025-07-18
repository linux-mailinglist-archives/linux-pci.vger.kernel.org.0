Return-Path: <linux-pci+bounces-32575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF9B0AC38
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 00:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0745A7592
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C4221737;
	Fri, 18 Jul 2025 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IjOZ5ji9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77A2C18A;
	Fri, 18 Jul 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878423; cv=fail; b=h6jK2v2k9VVZStApFCLHKzOlOTYE4vAW08kw59svuocYLT4Qy3fDdvktr8z1BHSOVaQFkzrd051EkKYOUXig1xtxUpgGEsmjMwi9hXHnfleBCyhZNcBf7/qwQ3+yj7oPffLw4xSXfMUnRFo04k2k3wPfNV9PASn9/0mEKLMW0Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878423; c=relaxed/simple;
	bh=lPAcjEkXmIQ+EG8oSUpRn6ce/+9TBglxfW7gIi8d91s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tmC/mfVy2wcDIBxq3bnFikvI3WAGfhYT9kDxie4QI4nbXy/rydE2aS5tqPcNrCCQkAdHkHeN564bS3DVjoEjpXup9pywoCuNEanWQAgNidChlUfEKsLB9j2k1C6/I9huMBNu8sUda6Kt7jFW89XqJwX7wvrFhNmLY+XGTr1SP30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IjOZ5ji9; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY6G2FfQuBrSZyMh1ux+YU8WBz2Tppg5a913K7yx1gXpgQDHie8/lNp1Vq7NVy+6vEVjFq1fbOVJ8nAymbrOBkAjjtnjCShCTCvuCKKC8HEa8C1SGpU97aK72jIpO4uH2HamsMTE0ESmGLRcuxR1IKJgzYto/uGipyL0MxHh6a3yC+GmV+WoJBhrVK7O1Gy/epg5olA92vvxNa8ua5YL/82SQ2P66oXkPXJDT7Jm11VMxQhweiuhDW96lOVp3APj62VH77vkMIpGXADaOdB1jFp4zAEJtUn7EuBd/XgtbhoUSi2+Fj40iFCdtNHo1d/BwSKKCJKWCTDGIKUShMlJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1xMLRGUuMpE3I/dcUnE/isXU0tVSFfy77ls0fcsPWU=;
 b=JXp1B48aBevJIEeapCaa1pa9QBJOMBE2wNzaQiTGcEpGw7LTbJNkv7vYjt0EKyVCBAO7SLMP0kSKTnuJiC/KKQRuPM/WUQ2vbI2bbpz9muvZKLp4YgjxOFPjC2gPz112AeT8f86u3VKzSk/3iagPOu0kKX0nc5gmv6/LPKStTysZWs3DEh8B/6N9/x5Nv8xfMn6CUtlbVsBsWQA84PYjhk/SzkZy6+R7k+jlDAkmhn5c5LgTgL4Bv1A+ccDkMPo/JUTzmDdaklgRLhbcwQ3Crfp7TcS9mQl779a8u9LL465lxvJ3uaEnd6c0LHGJOZfSmDQK9gDyGHWOvCYbqJOEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1xMLRGUuMpE3I/dcUnE/isXU0tVSFfy77ls0fcsPWU=;
 b=IjOZ5ji94HbnC/XO6uRKCWrX54hQDnlCtJL6VGrSkicazYA6KoS+LhyrwfckqGCOXluOzsGZbNH7RsXEpyNnLMgTm9Or07BEdwMyFgSNm99NGrP1xEzEJQtMoCa2/6Y7qrGzhA1i0JWw9o+Pp2KqKme2X/qZuT5TWgSc7E/98I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 22:40:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 22:40:17 +0000
Message-ID: <5b8c3084-1953-4058-8d2a-6234fc959aa1@amd.com>
Date: Fri, 18 Jul 2025 17:40:13 -0500
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-10-terry.bowman@amd.com>
 <a5b917d5-126e-48a8-b9c3-91d7bb2466e4@intel.com>
 <164c69a6-fd73-4fc1-990d-37e920582d81@amd.com>
 <0d8f7d31-2356-4c9e-9f2e-4bd070edf1e4@intel.com>
Content-Language: en-US
In-Reply-To: <0d8f7d31-2356-4c9e-9f2e-4bd070edf1e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0009.namprd05.prod.outlook.com
 (2603:10b6:803:40::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbaf42d-39ee-4f34-b46b-08ddc64c1160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFVwZjEwVm1PUS95SjRQRkFwVVFjd0RlQWE0RXVBTXFPVGkrcTlONGNlNW50?=
 =?utf-8?B?QTNPU21kZmlyZGZrVkpmZlpxeU53VmZwc1ZzYmo5akYzUzZWTzZkejhkSmhk?=
 =?utf-8?B?Y3JkMkVnazZxcGVQek0zb0xqNjJhYVRQRGxvcmd6VjFLVG1vYjFPMHhvb3pn?=
 =?utf-8?B?VDNKd0poZ1hadVZyaG5VeG9nM2treUluejgzem90d1E5L1crL21EQWVzSGNU?=
 =?utf-8?B?SFh1T2d1VkIrRWNDMUpGMVZzd2pOcmJNSlhEaGdDdjR1UEZSeUJOVk15M0hJ?=
 =?utf-8?B?eUdITTJnd1I3azRNS1FaK25hTldnMHRCVkkzV2N1MHpKc2xOcENXMDRJTzdn?=
 =?utf-8?B?aUVxRFJtaWFERWtMNnFKODAyN1JwR3k0RDcxemFSeGFRTy8zeVpsM256YWtK?=
 =?utf-8?B?a0pyOWRZRHF4Yy91M1lDSjBKem9NOCtwd3l2dzlpWmpMMWpmcFA5UDRtWkM3?=
 =?utf-8?B?eWRoOFZ6RkNUSzA3VmJzazNHYmorY3ZNSEZGRmNOdkNSWEhOM0xqa2pKd2oy?=
 =?utf-8?B?eUF2QjIyaEJLSm5zZkUxT016ZGJrWmVHQi8xTEJkSjhwVEFwc2JRK0gzeElm?=
 =?utf-8?B?d2JqUmpXUGx0TndXTlAyTnk0dHJXTXY3aVZiSkpDbFFpbFJiKzRGTzMzckx1?=
 =?utf-8?B?eUdjaTFVcndpVEQwSmxXUUgxYzh4KzZxdmw5TndYY21IZHNKbEwxbW4wUCtM?=
 =?utf-8?B?WkJOSFRsckpLb2l1Rm5nblJDNkF2clFic1djczc4YVZIdkx5MHd1Nnl2cjZm?=
 =?utf-8?B?eStQQVN4QzRRaTVaZG9HUENyS29QVzJGS1c5WDZOeHRDQzdXWDdEWUZoNC9Q?=
 =?utf-8?B?aU1aeS9qM05KTUpFclNpRE5hcHdHSlpKWE9nNGN1U215b2MwZFJVK1hMak54?=
 =?utf-8?B?eStvVDZwek1WbU90MkFOSzZvL2w0UVcxamZWbnYzQVNzTGttN25QZWlDTnNr?=
 =?utf-8?B?WEVPeGRjNmRtU3ArcWh0N3F5cTAxY1RHRlZsZEJVTkZTQm5kVFNCc0FsZDd3?=
 =?utf-8?B?bWpYNWYzN3V3Q3hHdFVMOUxmU1BIWGZNdDlraTh3bkpYNmFGUFByMzB5Nys2?=
 =?utf-8?B?Z0xvTXZxT0ZNOEV6QW5XaEFQekYvSFdLNGV1aHlraFlXcSs5VjQ3cE1xRlNl?=
 =?utf-8?B?SWNQVk1LS05uSTFHWUtBcEx0REdqQVJRcit5d2ZQdkVyWngrZDh5VGQ3bzFw?=
 =?utf-8?B?d0dnTVpOc0ZteUcwQ3B6WHU2WFp5bWhhdzNqdFFZS21wOERzY1dEMi9heUZz?=
 =?utf-8?B?TTF4eE9HWjNldGJ4S3hXK3JiMFZxSVhNT2Rab0RVQzM0aWdLU1BwdXZ6OGx4?=
 =?utf-8?B?Y09hdHZLWVJBWm5zOFY0aUwzRWFhL08wampwTWEwbk4zWmU3eERTU3VmYWZo?=
 =?utf-8?B?ZTFMZkNDSHBXc0xDcmx2QVNHZWxmcExZOVFYQmZCMlNzdkRWMTFUWng0d2M4?=
 =?utf-8?B?Q1ZhNmhMRHFsdnk0Yk5JZXgzeS9XaTZHaU9qOHlIRGJTakFyVml4VTFFQVQw?=
 =?utf-8?B?VmRYOXEvdUYydEpmMklLVWtsTklJZlZuS3NoNUxINXpaM2pwVEpOYU5nSWwz?=
 =?utf-8?B?QjdqcWtHR0VmdElRa0YreU1lMGk0NnNpWXBGckYweStrd1FDR1RhbU03bUlT?=
 =?utf-8?B?Q0VNcW1McDVQT3dpQkZEYXQzaWlJdEY1QTJVZVcvcDlzS01YZ0xZMkkxaXN6?=
 =?utf-8?B?aGNNTXJEZXFnS0x4V0tzSEt0ckE2aEFJZlNsOHJJeXIyYTloVTFYbGNuaDBN?=
 =?utf-8?B?MHJQUGNqTTZqMEdCNVpJeGZtNjU2Y2h6NG04Qjd5ZitHZWtrYmZXd1pPYWpH?=
 =?utf-8?B?czUwRTJNNGQva0dsN1dQUTJnK3pjOENZNC9Wc0VBUmkrU2VhOGducWExR2Zt?=
 =?utf-8?B?Sjd6M1Eyd0dOczl4YlJSR3Z2TUxTQXhFUW5JdGx3aWxGNVFpbkxlR2NYaUth?=
 =?utf-8?B?NEY1YWUwWlFpSnJweDFxbnNIdmcwVjkrVWRBeC9Cd05ROFhmOUxCRzVJSjEy?=
 =?utf-8?B?WXgrSTFuWUVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHNiYkNRZzkrbHgvTlZrK2FMU2RvRFU4M1c1TGR0V2l5ZXdabmNmaU8zQmk1?=
 =?utf-8?B?a0dQVmtYbmQzckFSM2xoZ21ma2VQMUt5cjI2a21tQWVGL2crcnQvMGppVU15?=
 =?utf-8?B?amtDemw4SVVwS2hISno3bGluaXlsMFFGUUx0RWxzYTFreFBJM08vT0pkK045?=
 =?utf-8?B?Yk04eXdKSGJWRGxhQ1owWU44MTUvQzNPaFV4L09zTzA3Q1ZDVUJBN1NLYkxQ?=
 =?utf-8?B?dTRVNUZEN3A5d2xQQWEvMFJqQmRDWUhRajBiVnRxQTdsSk5rVkIxY2FmOHFP?=
 =?utf-8?B?VXlLRjdxcFhUTGliYmRXemFMdS92RUdwYTdvYitqUDZNaC9DOTBJQ3FKY0t6?=
 =?utf-8?B?bnFqMWd6ZWhqSjlIcVp5VzJPSUxRektzejJOeC93Vk1lSUdtR2drMyt6TlRG?=
 =?utf-8?B?S1JmcGhWNHVJVmw4RmdiMWxqNnB0NFZCWnc3OUxLeHA0SDhHSUlUL3VzY0lk?=
 =?utf-8?B?TkFkak5oNHpCVHhGaFFDL1ozL0NsQUFWdjlCWEs4MWltai9ZNGQxYzhTQWdw?=
 =?utf-8?B?ZDRMOWhiNUQvR3RiOTF5VzErWk14VUNRSzVoTlM2Z3Z6aXltTXhOWlh6R05p?=
 =?utf-8?B?bGJLYWNEekgvN1orYnQzOEdtdjRLT05nM00raGRTQm1XT09BMTNWRnFXSGtX?=
 =?utf-8?B?N2s0Zm5BV2xnVGs4MjY2bXA5TDVYeGE2OTQxNmNqRVBkL29SelNOZGZRM05n?=
 =?utf-8?B?UmFQdjM5eloxaHgvcHJiVUN0dloyc0JGNE1zb3JBSU84S3d3ek9KcmRYMnJL?=
 =?utf-8?B?ZnVTbmVCbHEwcW9rZWYzY3ZyYU9BMkQvaXZTdjV3cTN2dmVNR3JETzlSQ0dI?=
 =?utf-8?B?MkdsN0VTQWpTU1F6NWtJT0c1SkVyc09nbndtN0FNaEU1REl4MElvaEVQWUpy?=
 =?utf-8?B?a1RwSk5Gb2FQaEhEYTg4M1J3QmthWlFNQlg2c2NMNEhrZ2FQTC9xeWJLbzFq?=
 =?utf-8?B?WG1CSE96T08rMzVjaktxQ2p2dDFTM21ub0FmTThVYlR0QkVIMEI0OXYrYVJt?=
 =?utf-8?B?dUVRajBZd1QvS0R2OXROcUgvQ1FyRnBlSS8yVk5jcC9nRDJzOGNHS3RQVzdq?=
 =?utf-8?B?NFgyb3E1UXgvRm9rekc2L1lGdHlJL2FkWTMrWHF1RUFUbnY0WFZSRk1rejEw?=
 =?utf-8?B?NEc3REd0dUVHZnB3cnlRajkwZVUxaVVzdnovL1lHYjhpL1EzWUpXVmtEbUE1?=
 =?utf-8?B?V05yWGQrM2J3T05oaThvQTJidms0ZjRnUndGOVF5UG1aTUlTZWt0ZWZleHdm?=
 =?utf-8?B?MEwzVSt6RFdvNXF5Qy9wcG5SZllWRzZjY0lrRWd6UmtPVDg1QnpsSWRjbXFO?=
 =?utf-8?B?VTFrSmNRYlV2akhrNnFaOVRubXQxNnh2SzNzZW1pWThEQys2M0hSM1FOVFln?=
 =?utf-8?B?YTNnendMUGVPZFg3NE4yb2hDOUFHRkovWmtiNXQyb3JrSmdWdHZxT0FMVUYr?=
 =?utf-8?B?OExoemdMTHdrdW5BdFgwejdBcEtZakEyczVqaWxKT3hna2E2RUxNR0Z4T1hE?=
 =?utf-8?B?ejRTNHVQWkM2VzZJcFVHRExsanNhU1JCNEJZTTBpeFlVTHdyZWIyWm1wNU05?=
 =?utf-8?B?UXlWTm1RMjc4aXA2UEVTNG9yeUpNejNZNDlSamt5U3VsZXptcGdrZytmdlhR?=
 =?utf-8?B?RFZOdE51L0dTNEdlRnZkRjlpcmxOWTI0cTgyVER2ekJtblhKOHpoUUdSeE1Z?=
 =?utf-8?B?K2JuTnJEWFZRQ0dsa1JFSVJyNjE0eXoyOEx3R1o1UDNPaU1UMFJoUkp3WG00?=
 =?utf-8?B?dzJUR1hVMnYvL28rOTc0UmVSTmQ4MjJpaVEwbHRubThmcXFnRjNiV1p5enU2?=
 =?utf-8?B?amU4cnIwWXhqeTFvR2V1dk8zbk1uS05BU3JhSkROb1c5VW12aTI3L1NjMGQz?=
 =?utf-8?B?cGJFTWNUbkdyM1cyVGV0TjhHZWNUR2dyQ21FMEk3VkJWR1hTRkVNQVEyOFVY?=
 =?utf-8?B?UzVLNFJFb0QyZlVaSWNVaWNsS0VxOU5rdk8rMkdDNUQ3d3lDM2hPUHZjUHoz?=
 =?utf-8?B?SFVRUjViN2tjNjVTWGsrV0hDUEtOMnFkaG40bmVPTGUra2Z1ZkZhNURRRy9E?=
 =?utf-8?B?bEFWVXpmZkdwaVZPNEZUd3hUZXJrUFBqcWswVFF2dTM2aW0wVkMvWFZDQXN4?=
 =?utf-8?Q?p2vTWgswM6cF/z1tIcOVa1L5E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbaf42d-39ee-4f34-b46b-08ddc64c1160
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 22:40:16.9778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhc76tNQ/EqN1N/wTOaDtThmSHD5GLc1+BT4WK86r4ing2nop52mK5blt8YBXzDCGOXOA/8Z+ejeJ0sU0lmeyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

On 7/18/2025 5:01 PM, Dave Jiang wrote:
> 
> 
> On 7/18/25 2:55 PM, Bowman, Terry wrote:
>>
>>
>> On 7/18/2025 4:28 PM, Dave Jiang wrote:
>>>
>>> On 6/26/25 3:42 PM, Terry Bowman wrote:
>>>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>>>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>>>> mapping to enable RAS logging. This initialization is currently missing and
>>>> must be added for CXL RPs and DSPs.
>>>>
>>>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>>>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>>>
>>>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>>>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>>>> created and added to the EP port.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> ---
>>>>  drivers/cxl/cxl.h  |  2 ++
>>>>  drivers/cxl/mem.c  |  3 ++-
>>>>  drivers/cxl/port.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>  3 files changed, 61 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index c57c160f3e5e..d696d419bd5a 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -590,6 +590,7 @@ struct cxl_dax_region {
>>>>   * @parent_dport: dport that points to this port in the parent
>>>>   * @decoder_ida: allocator for decoder ids
>>>>   * @reg_map: component and ras register mapping parameters
>>>> + * @uport_regs: mapped component registers
>>>>   * @nr_dports: number of entries in @dports
>>>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>>>> @@ -610,6 +611,7 @@ struct cxl_port {
>>>>  	struct cxl_dport *parent_dport;
>>>>  	struct ida decoder_ida;
>>>>  	struct cxl_register_map reg_map;
>>>> +	struct cxl_component_regs uport_regs;
>>>>  	int nr_dports;
>>>>  	int hdm_end;
>>>>  	int commit_end;
>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>> index 6e6777b7bafb..d2155f45240d 100644
>>>> --- a/drivers/cxl/mem.c
>>>> +++ b/drivers/cxl/mem.c
>>>> @@ -166,7 +166,8 @@ static int cxl_mem_probe(struct device *dev)
>>>>  	else
>>>>  		endpoint_parent = &parent_port->dev;
>>>>  
>>>> -	cxl_dport_init_ras_reporting(dport, dev);
>>>> +	if (dport->rch)
>>>> +		cxl_dport_init_ras_reporting(dport, dev);
>>>>  
>>>>  	scoped_guard(device, endpoint_parent) {
>>>>  		if (!endpoint_parent->driver) {
>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>> index 021f35145c65..b52f82925891 100644
>>>> --- a/drivers/cxl/port.c
>>>> +++ b/drivers/cxl/port.c
>>>> @@ -111,6 +111,17 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>>>  }
>>>>  
>>>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>>> +					 struct device *host)
>>>> +{
>>>> +	struct cxl_register_map *map = &port->reg_map;
>>>> +
>>>> +	map->host = host;
>>>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>>>> +}
>>>> +
>>>>  /**
>>>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>>>   * @dport: the cxl_dport that needs to be initialized
>>>> @@ -119,7 +130,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>>  {
>>>>  	dport->reg_map.host = host;
>>>> -	cxl_dport_map_ras(dport);
>>>>  
>>>>  	if (dport->rch) {
>>>>  		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>>>> @@ -127,12 +137,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>>  		if (!host_bridge->native_aer)
>>>>  			return;
>>>>  
>>>> +		cxl_dport_map_ras(dport);
>>>>  		cxl_dport_map_rch_aer(dport);
>>>>  		cxl_disable_rch_root_ints(dport);
>>>> +		return;
>>>>  	}
>>>> +
>>>> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
>>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>> +		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
>>>> +
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>>  
>>>> +static void cxl_switch_port_init_ras(struct cxl_port *port)
>>>> +{
>>>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>>>> +		return;
>>>> +
>>>> +	/* May have upstream DSP or RP */
>>>> +	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {
>>>> +		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
>>>> +
>>>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>>>> +			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
>>>> +	}
>>>> +
>>>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>>>> +}
>>>> +
>>>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>>> Maybe rename 'port' to 'ep' to be explicit
>> Ok
>>>> +{
>>>> +	struct cxl_dport *dport;
>>> parent_dport would be clearer. I was thinking why does the endpoint have a dport for a second there.
>> Ok
>>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>>>> +		cxl_mem_find_port(cxlmd, &dport);
>>>> +
>>>> +	if (!dport || !dev_is_pci(dport->dport_dev)) {
>>>> +		dev_err(&port->dev, "CXL port topology not found\n");> +		return;
>>>> +	}
>>>> +
>>>> +	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
>>>> +}
>>>> +
>>>> +#else
>>>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
>>>> +static void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>>>  #endif /* CONFIG_PCIEAER_CXL */
>>> I cc'd you on the new patch to move all the AER stuff to core/pci_aer.c. That should take care of ifdef CONFIG_PCIEAER_CXL in pci.c and port.c.
>>>
>>> DJ
>>
>> Move to core/native_ras.c introduced in "Dequeue forwarded CXL error", right? I just want to be certain.
> 
> I just posted this [1] to clean up what's there. Do you prefer me to just rename the file to native_ras.c? Or maybe pci_ras.c?
> 
> [1]: https://lore.kernel.org/linux-cxl/20250718212452.2100663-1-dave.jiang@intel.com/
> 
> DJ
> 

Hi Dave,

I think leaving as you have it is fine. 

Would you like to see my v10 changes in core/native_ras.c stay as-is or move into pci_aer.c?

-Terry

>>
>> Regards,
>> Terry
>>
>>>>  >  static int cxl_switch_port_probe(struct cxl_port *port)
>>>> @@ -149,6 +201,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>>  
>>>>  	cxl_switch_parse_cdat(port);
>>>>  
>>>> +	cxl_switch_port_init_ras(port);
>>>> +
>>>>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>>>>  	if (!IS_ERR(cxlhdm))
>>>>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>>>> @@ -203,6 +257,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>>  	if (rc)
>>>>  		return rc;
>>>>  
>>>> +	cxl_endpoint_port_init_ras(port);
>>>> +
>>>>  	/*
>>>>  	 * Now that all endpoint decoders are successfully enumerated, try to
>>>>  	 * assemble regions from committed decoders
>>
> 



