Return-Path: <linux-pci+bounces-6677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAA8B2A15
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE851C221CA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9D37143;
	Thu, 25 Apr 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1VM7/sqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814114D70C;
	Thu, 25 Apr 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078175; cv=fail; b=qkOYJVssn04J92GANSjGU+CvyrGvLx8dZo3GvGTqhbiFD5XoQOjr6VqoYuRjhHg0Gzn9Mrh/aftTEizESgtdRsGFsUC+yg7JthFpDFERbJWISQljNP6uMg89rtoafDiiHpdsddFWhcsjo1SEs8VI0E4ULBTpyP57EwiGy+bF3jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078175; c=relaxed/simple;
	bh=gSwI8HFvQF/j1qsV7aAHQWIMaHK/BtMk4P4WTIoG+gQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=VRN/W76rTGpD8pa5bA29qCngixZZaUQfghIBUrESh6p3An/V9OsxqhF4GK0/ZnXuyuCQs13KIBhQQUue8vV3lBDofIZq3+A/sGiL8HtT1igRMP5NAPxTXbBroBrA7TNYXMnwibkNomPPN2SitZylRAq85jg/OuYHR4ekPqzNpUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1VM7/sqI; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIs6oG1dT4yhYhe7+9xp27oNOFUAyD+rbPKHjn0p+R9DeNDlOytLsuEn429obj6kQhgQYi31kLePcGXhjvrQVkOrRNQkjSPIiWd9wPMU08A8uyYe0G5YoBxPWuRK7Kr3z/cgRLaGXnvTi6TJvAPPiU+HUiBdRUoLZdOn5An/L+pgFdIoSOg6L3RoXS1fzJ4txlYONBEdJfAdcRdrqxviFZ5n3e8t7wBj8L3p3cqZmp0rIF32jxE6r8toeyG7scDlZCjRmlxPCEB7Nsk1CduI/OPyRmkS9DBOmDxw774CJh2XrNyQ/QduM+nXglGUAKy38e7dhOWMbtZ6W+N2msGXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BMQUje9dF9FZbMYuGDnvSgxxY5WxcxOb9CwQH64fqA=;
 b=LnLQvwPhsPHCXfT1Xw2m52lO8MDub4vU/6pBC5cr5J/3pwghOxITmKxfTElImZczUG7PlQFeM+xTYgHDm+GkcVhoEt17EIBnP8V9ZR2znOtZRdJBZIzy8PjqBolo8WOp7A+RtVhfdkMkLDG6GWj6dMB4zp017fsR/fNkTYXx1zBZBnMofUjHQYY+ftzzCTWNR6oF8RnBDkHpEJYT6xJ/TZkyQtSceuGkCzokng1wXzCIfCD7crSjnReXa2fn0miPD7y6mO0mOWDUOS9mGTfe9JMleH4e7kFf4RyBWMO2Jr15+l1n6CeqvoBJ+idz41/t6ysCojRNHNM5wENTwR8R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BMQUje9dF9FZbMYuGDnvSgxxY5WxcxOb9CwQH64fqA=;
 b=1VM7/sqIVlKO2P+8NTj7XPhSCv59QAf+kwk2stCvUDr1toRmkW37zBqYsSBJb7vGokn1GMvT0zteQISJHVcH9s9ICxp5EsgHRmVJTB1TMqksinFFRjtS3etTR8FP0+HfsYIvXotTmyOTwDCNbeTB9KBRHvnGVgfzum73sn96cdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:49:30 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 20:49:29 +0000
Subject: Re: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
 Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, pradeepvineshreddy.kodamati@amd.com
References: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
 <2f6e5a44-e64d-4801-96ff-c99cf034ebdf@linux.intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <a9ce9d8d-6ebd-3526-f806-5e9812eae762@amd.com>
Date: Thu, 25 Apr 2024 13:49:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <2f6e5a44-e64d-4801-96ff-c99cf034ebdf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df003d5-55e8-4e7a-a835-08dc65693397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzBtdVhFNnRHOVM1ZE5CYzE4Rlc5MDdZdWwwSVJILzd1Y2VJZHhKNnVJZHlB?=
 =?utf-8?B?OC9oMnZFY1FKTkNBN1ZnanJPdDhmWnJjQTg2ZDB3Y1VXSDlad0dFc00yZ2Qv?=
 =?utf-8?B?UDgvQ3hsZXpaNEhrbFl1YU5FTGRHZTZnOGxEZktMUUVkTjdCTVVKck1lYU5P?=
 =?utf-8?B?Wmo4ancxRTV6QWpBNW5JbXF2UU9xTVFGVmJkRXZJK2NKRkN5MnlQdFU3NGJl?=
 =?utf-8?B?M2hNSXRkVTdZWGxLR0Jnd2pFeHRXa0dNdXN2eHMrZEhJQ1RkVmNEN01KM2JO?=
 =?utf-8?B?UWJtNkVObGk1enlkYXVuQ3laWCtvMzhPV0ZndXo1bXVBVHd0Wkg0UDh3bVht?=
 =?utf-8?B?UHRmeTVKT1N0d216VG9GRjFFcTZoSllZM2szWTVOeDF2QW0vYlFBWEwzT1pX?=
 =?utf-8?B?WFh0WVBpSDkweW82UGVHdkpNZHpYc0Q2aEFLV0lYL2RVemhXUStMZDdhUWFO?=
 =?utf-8?B?eVBnNVRlSEhmaGtCWW1DY2RNd1Fra0tQUVhHL1hua09sRHhzME9IOWQvTDBJ?=
 =?utf-8?B?b0NjNVhGekpSYWRnYjJvUkYwNkVRN0tqOFVKL2l1TU9zUjRvRlNRS0RQRzZS?=
 =?utf-8?B?WWZDcjhWKzlUR1hCTzd2RUVtalZiWkQrMmUrNDBON2U4ZU9WVmpnNmdtZFZS?=
 =?utf-8?B?MVpwQkVnM2VtWXhxM3BSd0d3ZW9EaEJGT0tOZmlKNjMrSExYVUJManpCWU5z?=
 =?utf-8?B?THBXSkNCOU55OGJEZEtpa0lBbnhQdFQ4YU5ERHdWN0ZvOWhUUHQzVzJEc09n?=
 =?utf-8?B?MDhRSzhLUkJKdGIxa0hnalA1bWg0bzJLOGozL1NYSWtJZWxhYzR1eFh1MlUr?=
 =?utf-8?B?QmgzbUZSVHJRdnRKRXVkZFpWL1JzY1BZWVI4NUdjRnNBWlV6Z3Jwb25udjdU?=
 =?utf-8?B?SVlOQjlxM3QyR1oxR0hWeDQ1RXdLd2lTUjFIYkgwWUIzcGxhK3JyTjZWdkRL?=
 =?utf-8?B?YkJYRzZWUHo2RHpMbDFic0xGTlhDTFVqRzFKM3psWlNTdDZPZitIWU5xMmVC?=
 =?utf-8?B?bEhGdzRmK0Y3WUphL3p6TzBQcVQ0WmlZYmt0RklaRjlTUDk2eEVFelhFUEtz?=
 =?utf-8?B?bUQ1QW9xalpEanF3Q2srUkRFT04rdzN1bHN2eUlwOGw5eW1JMm1TM1pYazZt?=
 =?utf-8?B?cEhoQ2UrR3d4VlMrMmZZeEdoZW1IeVc1elI1c0plWUp3Tmo0YjNCSzQxR2g1?=
 =?utf-8?B?NmZrbWtMdmZubjM4U0RYRU85S28zVkI5RjZhQjBIQXNPaFU3blBaNVdQTXIv?=
 =?utf-8?B?WDQwZUR5eEI2cks4YnkvdkZNUEpzc2JlVnRraVNrK00rVkllQ3ZlY3h3ZGs0?=
 =?utf-8?B?bXNWMTVVeHgzaHhZalA3eTdJZTBFV0JlOTdrVjkvZkI5cFpsSzV0TFhNUzdS?=
 =?utf-8?B?MjRSZHlucEwzTTBybG4wU3JqQ0Z0VUk1NXJrcVg1NUFPMEI3ZnhHUHdSZlBY?=
 =?utf-8?B?RCs3djk4Ylp1QzVPcGVFZjdPRk5mNDhCc3A1b3pVOGQ4NVcrY0NHKzk1K3dR?=
 =?utf-8?B?TWV6b2plOTNuVlc0clkzcThnMmJ2Y2gwbXFiRUxoOWx5MlFqZC9kS0pETHVm?=
 =?utf-8?B?Z29ZWktNWEpFb05ka2hqK0N4aldncmFzbXFMT0tDNmxlVnNHajVLVUpHbC9E?=
 =?utf-8?Q?SuGc1h9zsm8HVWq/brLx/H41QQQc9NvZgXp2PERKVjz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0hrUjA4VWNvc1NvNzFyT015VS9VY0hJWFpkZlBraGFYWG5zRk5uNFNlSVdh?=
 =?utf-8?B?bDIxMmJzb2JGSk9tanJFZFZTcy9HVHozY2pUUk9JSjZVeGxTeFJkMnVJSFB1?=
 =?utf-8?B?aU9EeFVjS253cmU5ZU52Mnh2b1JaRFNSKzc0dDhydVAxanczZDdta3JvMFF0?=
 =?utf-8?B?SlVwdEZQS29FZ3FyK3FZR1RtSG83Vm5JSHVwelJuVGNHSjAwZHFJbFBNeGsz?=
 =?utf-8?B?M0lWOXhZemxTV3BkVGp2M1piS3c2amUwUlZSRE56dmVaMitGcllzdXp2eTBZ?=
 =?utf-8?B?bjFKWDM3QWtiVkZ6d2xaMUVDdHFJQ2hINm9oaTMxTzBjaVliNzB6ajRQOEdr?=
 =?utf-8?B?bFdVY2FkakNXTHZtYWpqYXJLb0JKNG1rVktVeUphQlZvTkhlWHh5K2JzT1NE?=
 =?utf-8?B?YVJOdkxQM2g5S2NCYjlTK0xNaDhLOEFJRDVHbDV3UWRvaFpocHAyMTJBVVdp?=
 =?utf-8?B?YXpsQkVqMDlRNzJaSi9QM1FOZjhjT3g0SEptVVBBclZBbHVIbUV1emdHdEJn?=
 =?utf-8?B?RGl6ZEhiWnlvRUlFcHVZQ0ZvNWZRbVh2STl3NGw0a1VxTmZsV2ZGVW5MNllq?=
 =?utf-8?B?OFU3d0tGVEROTDM2SDdpUHFJRER3YnJFQTNGNWxjdFhZNGJ5M3dDZlFCSDlq?=
 =?utf-8?B?QXVEU2o4bFFraFBnZ0lvVEdEVEdyaEF5QlIwSk5OQUk5R1BTd0lKd1V3d0p0?=
 =?utf-8?B?NG5PV1BvMVFPUlJPZ1pnaS8zZEJkWUU1MFBGVXFhOU1uQ0Y0bTJIZ2krTVFU?=
 =?utf-8?B?RGg2ckwrZHlpYWwxamVYc2hjQ3pHTDJSZmpjcUVqNFVyTm0zWDhiUHI1dE5y?=
 =?utf-8?B?US9oSDNxQWRaVUVhdEQ5RmI3c1dYQ241Rnl1OEJWbklnbmlpSHEvRUs3eERY?=
 =?utf-8?B?OTRsUzBQallMQkhHSGxSUkw1cEpiYzZiNGpZang0enc3M2FYTEMxN2l5aS9J?=
 =?utf-8?B?ZVZXN3o3UnJIa0tpaVViWFBLOUN5MktZQmhwOE83dzltWFEyZi9rK3psa3NC?=
 =?utf-8?B?V2Q1NllOajJETkQyaHRTY2ZEbG51bWVZaEhMbHZJRm1RS1l5Tkg5UGs2RTly?=
 =?utf-8?B?em5jWk91UnBBWmo4M3RIS3JCNW1kcDBoRXFxeVFDK1Z5dnpCUGY3bG56bWRt?=
 =?utf-8?B?VGhuNzliaVZvWGp4SlJ6SCtNSzAwT2NxNXRET3B5eWwwZzNsR0tuWER5cC9M?=
 =?utf-8?B?REtkWmJ4elRGR2llWmJSSWUxZXJKMTVkMGRkdHQ5dkExYXJ5aDlnZGc5b1A5?=
 =?utf-8?B?WTB4UUd4SmZLYk5JbWtFaTlDN0hRQVFOTmR3WHVpMjZ5dEN3VE5VbDZyT09X?=
 =?utf-8?B?VVhZVzE1cnlDN3VzMURlV0x4ZVV1MjExbjZYa3UyR3R6cHVOdEo4WUF6WnNi?=
 =?utf-8?B?TDgvdmpVdkN2SFI3WkZzKzRnZm4zWm1sK0VKbkw2aDc5OGhhbldaVXdldkY3?=
 =?utf-8?B?WWVCNitaR1d2Qy9RUjViNDVkTG9IQU1ZR2pKOWorYUZsSEV5dGZDVm5rcE1i?=
 =?utf-8?B?SUt5Rk1qTTlMdGpxNGhPN3A5RmlpQVE5eVZOcW10WHJrSWVqend6cU1LOW9F?=
 =?utf-8?B?ZmF5cHNadXpQUktvWGhNSTBrQ1l5dG5weFJYMzRTS29DMGpyRDV0ZmVMUVgz?=
 =?utf-8?B?N3FLU2dlTWRubW4waTRDOUwvSUpic3RudmxKK2JiVFdJdGt2SHcrR2czQkwz?=
 =?utf-8?B?RnBtRWhVbmY1SzlDTVVBSkZEYWpnNmJTSUtOakZ2K21YSmFnTjMzVjF4M1Fq?=
 =?utf-8?B?SllCSW5iSmU3M3BxRUcvWS9jRUhkdzU1TUN6REhMUkxnNTIrMHVMUGQ3Uzl5?=
 =?utf-8?B?bkhXU01ST1ZvbWFwaE9PWGJIYVRnSVMydWMzZUlWOVN6N2FBcW1iVGpwV3FM?=
 =?utf-8?B?N1YvQ05nVzk5UTUvdzI4NllaY2tjMkxMejUvN1VCNkdySTM0QmtDcVJmRkRk?=
 =?utf-8?B?MEcrS1RGREhMTXJBMHA0ZVRoRkMxU0g3c2hxQUpteG9hcnBpNGlETWZncHBK?=
 =?utf-8?B?Q3NOOWdZMlIvMi9LY01CeitUV1E5RGVMKzlaUlNPQ0s4ZnQxMDNMUVlJTmFP?=
 =?utf-8?B?SDFKS0NDWStObk9XKzZCREFwNTBNcS82eURoRDM0Tk5Qbzg4ZW9Mc2dBeWFH?=
 =?utf-8?Q?78JIODStRaopQ5kYBC7V8ZMYq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df003d5-55e8-4e7a-a835-08dc65693397
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:49:29.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOUU0a6I4fkOTjTj7V3XN3bq5w4HCTqDP0CVjAMbaLh6V4ax3ZZozZckgHCA6LvUBza5jUmAQgt8DIYw5r9mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

Hi,

On 4/24/2024 8:10 PM, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/23/24 8:33 PM, Smita Koralahalli wrote:
>> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove event.
>>
>> The hot-remove event could result in target link speed reduction if LBMS
>> is set, due to a delay in Presence Detect State Change (PDSC) happening
>> after a Data Link Layer State Change event (DLLSC).
> 
> What is the actual impact? Since this happens during hot-remove,
> and there is no device, the link retrain will fail, right?

That's right. Link retrain fails resulting in reduced link speeds. It 
shouldn't attempt link retrain in the first place if there is no device.

> 
>>
>> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
>> PDSC can sometimes be too late and the slot could have already been
>> powered down just by a DLLSC event. And the delayed PDSC could falsely be
>> interpreted as an interrupt raised to turn the slot on. This false process
>> of powering the slot on, without a link forces the kernel to retrain the
>> link if LBMS is set, to a lower speed to restablish the link thereby
>> bringing down the link speeds [2].
>>
>> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
>> be set for an unconnected link and if set, it serves the purpose of
> 
> I did not find this detail in the spec. Can you copy paste the lines
> in the spec that mentions the case where it cannot set in an
> unconnected link? All I see are the cases where it can be set.

This is the only line in the Spec: "Link Bandwidth Management Status - 
This bit is Set by hardware to indicate that either of the following has 
occurred without the Port transitioning through DL_Down status".

I have mostly written down the inferences for the statement. And part of 
the inferences I have even picked up from Bjorn's statements in the 
below link: (probably all of them :))

https://lore.kernel.org/all/alpine.DEB.2.21.2306080224280.36323@angie.orcam.me.uk/

Repasting..

"...LBMS cannot be set for an unconnected link, because the bit is only 
allowed to be set for an event observed that has happened with a port 
reporting no DL_Down status at any time throughout the event, which can 
only happen with the physical layer up, which of course cannot happen 
for an unconnected link....
....
..IOW the LBMS bit serves the purpose of indicating that there is 
actually a device down an inactive link ...."

> 
>> indicating that there is actually a device down an inactive link.
>> However, hardware could have already set LBMS when the device was
>> connected to the port i.e when the state was DL_Up or DL_Active. Some
> 
> Isn't LBMS only set during DL_Down transition ? Why would it be
> set during DL_Up?

The statement in Spec is very confusing :/ LBMS could only be set when 
the state is not DL_Down. But it could already be set before the port 
enters DL_Down.

Tried my attempt to collect some points here:
https://lore.kernel.org/linux-pci/4852519a-c941-aa0c-2912-f6383c708ade@amd.com/

Hoping I'm on the right track!

Thanks
Smita

> 
>> hardwares would have even attempted retrain going into recovery mode,
>> just before transitioning to DL_Down.
>>
>> Thus the set LBMS is never cleared and might force software to cause link
>> speed drops when there is no link [2].
>>
>> Dmesg before:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>> 	pcieport 0000:20:01.1: retraining failed
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> Dmesg after:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
>>      https://members.pcisig.com/wg/PCI-SIG/document/20590
>> [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> 1. Should be based on top of fixes for link retrain status in
>> pcie_wait_for_link_delay()
>> https://patchwork.kernel.org/project/linux-pci/list/?series=824858
>> https://lore.kernel.org/linux-pci/53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com/
>>
>> Without the fixes patch output would be:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>> 	pcieport 0000:20:01.1: retraining failed
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No device found.
>>
>> 2. I initially attempted to wait for both events PDSC and DLLSC to happen
>> and then turn on the slot.
>> Similar to: https://lore.kernel.org/lkml/20190205210701.25387-1-mr.nuke.me@gmail.com/
>> but before turning on the slot.
>>
>> Something like:
>> -		ctrl->state = POWERON_STATE;
>> -		mutex_unlock(&ctrl->state_lock);
>> -		if (present)
>> +		if (present && link_active) {
>> +			ctrl->state = POWERON_STATE;
>> +			mutex_unlock(&ctrl->state_lock);
>> 			ctrl_info(ctrl, "Slot(%s): Card present\n",
>> 				  slot_name(ctrl));
>> -		if (link_active)
>> 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>> 				  slot_name(ctrl));
>> -		ctrl->request_result = pciehp_enable_slot(ctrl);
>> -		break;
>> +			ctrl->request_result = pciehp_enable_slot(ctrl);
>> +			break;
>> +		}
>> +		else {
>> +			mutex_unlock(&ctrl->state_lock);
>> +			break;
>> +		}
>>
>> This would also avoid printing the lines below on a remove event.
>> pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> I understand this would likely be not applicable in places where broken
>> devices hardwire PDS to zero and PDSC would never happen. But I'm open to
>> making changes if this is more applicable. Because, SW cannot directly
>> track the interference of HW in attempting link retrain and setting LBMS.
>>
>> 3. I tried introducing delay similar to pcie_wait_for_presence() but I
>> was not successful in picking the right numbers. Hence hit with the same
>> link speed drop.
>>
>> 4. For some reason I was unable to clear LBMS with:
>> 	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> 				   PCI_EXP_LNKSTA_LBMS);
>> ---
>>   drivers/pci/hotplug/pciehp_pci.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>> index ad12515a4a12..9155fdfd1d37 100644
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -92,7 +92,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   {
>>   	struct pci_dev *dev, *temp;
>>   	struct pci_bus *parent = ctrl->pcie->port->subordinate;
>> -	u16 command;
>> +	u16 command, lnksta;
>>   
>>   	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>>   		 __func__, pci_domain_nr(parent), parent->number);
>> @@ -134,4 +134,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   	}
>>   
>>   	pci_unlock_rescan_remove();
>> +
>> +	/* Clear LBMS on removal */
>> +	pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA, &lnksta);
>> +	if (lnksta & PCI_EXP_LNKSTA_LBMS)
>> +		pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> +					   PCI_EXP_LNKSTA_LBMS);
>>   }
> 

