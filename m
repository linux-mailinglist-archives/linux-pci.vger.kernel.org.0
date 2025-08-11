Return-Path: <linux-pci+bounces-33702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47AB20123
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE70189E28E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1C245033;
	Mon, 11 Aug 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RnW5X6QO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27979212FB3;
	Mon, 11 Aug 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899343; cv=fail; b=BkQcf9M9IZ3LkakKgyil03HzzWKKXw9wesDIkiIA8N5W6QxY6hzKA7ZN0lIxNdoohwIpTCNfrmtY7jTdESIPnptUd9wK6Zvxwe8eRUTtm8rNgiCngNi3YseTo1S1BpyQB86Wrlfir8k/4GBS50Z8TP5OLqwwF/308SEmke2XKoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899343; c=relaxed/simple;
	bh=CvQcbGL8bnrK2vBhDElwHVmcZHOmmpcIBcDCojQ8MiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kfBxmRY1VsPjq21NP3Y0lG9/sDOSCHdaE2Em0PD+WtZreMyMvntnwA8Wve9nJ+I2fySl2QHOXHDccjcF46tWmyLyJnyvIWjT+QJMNEfffNUBNnYOF5PJ3Ahn6TXvuMPB9MjvwWfFyZC5LCAvUTlf3GZ9/Wr8NaeBjqQ8Y6SYEQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RnW5X6QO; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtNSxKczzoBfeYeEWhlkXlWxzUpBpKUS1MPeSX8AhtCilexvsyafh5zBPNJRFRlGQ9ooNKl5ChkDqjoyARdEFh1mg6iyrwnI4lw9b9Rg4zpIcY6szHXvrCt2NX1hMjJLqZEU8U+x4uqU8dLbFMjQfmYjbNmV2w3b84xKXq9fOp6okkL++q8B9ejNPhmbmiN3FFDPTdJcXnRzIFWkIcfufkaRxJpzFmrLsdbSVP5BzQxm/7OJUkxHI20KgAqCbksLXYc98WOjLstUzWLg6TslQP+kyCV+XBELo2TYOVRbAZmYOGrERk5os4MWaJiOr5dhvdVKWMHHc4qHyGXj9lCMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANbl49CR8NzSKomSriRdkG9Hu9IXqT12xxwxiKbbnOE=;
 b=qObbUUa4l9zL8Z+DG6dA8r+byefJXhhqFZvHMEa+CXP3unZAzs5TYJ5WREsOD2Ll+CGBbfnOataidMapbmcmmNPd+p3lLTeym3WDJHioAa5hkv3pqL1V6mlizi670Ds6oDRNQZzs1QlBJiOnYJTFSs7xGB9OOYVm/S08QVL8te10w+Sy/qvv5/5DQBody0U4f7DMlHuRwkX1CZE9XNpsrHIkCJ1/WKLw6IUYdfYleifZXEV2n8Zu5ipjbozQopeFp1oQo/16Z27egaN4VYhkKz+OKmY3V69fo7UTCJGp8vZqhsdMiBpvFVBZbYoef/Znyufr7zvVND0wPUe/Bc17sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANbl49CR8NzSKomSriRdkG9Hu9IXqT12xxwxiKbbnOE=;
 b=RnW5X6QOU/KZGpFD+koUFBb64oRh4ZcrWbBDFvJVzFsgQJ/zJHVHf6hnTLwZqUsIIja0wCJyRqgduNkm8kwqThCNR0rbuz3O9jk25IdM2xUeVYl+cJfcLaa92HTXss5LF8Lnj86f7dDB7A3oGoC6AK8RTgoDfvOi1H09Zek1PiUjt/LiqS0B4BmbDnJBgAtGGoQbVR8tWHGmJM+KAno4t5f2AU8X5Pdv3saaOrqK6HN1JXmx1GDw8+xY852smBEV/su6V1CCbk3n6MB9Io8kDz1XI0SukLfu9t/SDRTE2PlUn7RadB3cr0fiuczyTPRs4nRiVcnPDcfdxyhCZq+wIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 08:02:19 +0000
Received: from DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003]) by DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003%5]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 08:02:19 +0000
Message-ID: <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
Date: Mon, 11 Aug 2025 11:02:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, "Aneesh Kumar K.V (Arm)"
 <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
 lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
 Yilun Xu <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
 <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Arto Merilainen <amerilainen@nvidia.com>
In-Reply-To: <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0665.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::16) To DM4PR12MB5391.namprd12.prod.outlook.com
 (2603:10b6:5:39a::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 415aa444-6852-4d5f-e511-08ddd8ad646f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjhyaUkzU0ZXS28yc3pkRzV0TElvOEVrTndLSGZ5SGxsWDVDQzFrcnd2QjEz?=
 =?utf-8?B?NG1pQktKNGI1enU5Q09MUGNTQWdQUzg0cHROcmZBNEdzN1E5ZmNVcGlobFdS?=
 =?utf-8?B?UUloMmUycHpsa0tSRFNNSTR2UTJOTEdBS0dDeHlrYk96ZlNEYklvcnZQeWs4?=
 =?utf-8?B?ekJTVEZwWVBnUGd0aG04T0J6dDJDYTZhUVlFZHRBRlJ4QmlEUldWemp0bUVp?=
 =?utf-8?B?Qllka2xMaTRnRytSOXkwckVTK2pUUEJkRGsvYWhqNWtrTWRETHRWd05uN2tW?=
 =?utf-8?B?bFhLVCtuMDd0YzJYeWJ0UmpLckhpTXdzV1Z0RDJQQVNSY1lRSzdlRklFS3Jq?=
 =?utf-8?B?K3FHc1JVUHlYWmtUdWRzaE9hbEtaQzBkbGNNZElZY0dlVFhTYVRhU04rdFBs?=
 =?utf-8?B?dVhHOTMrTkxjTUgrc2xYaFE1Z21pTlFaaG1oVWliQWJDMEFPMFpWdFd4WG9F?=
 =?utf-8?B?WHJ0OGdRSmJKc1dTeS94eGprRS9rWkp4YU40SG9Bc3lHTk5CQXV4aEd0WWxs?=
 =?utf-8?B?b0dDWlhSdHhraHkrZi93c0VMNGtaV0dicWJmWWNpOEtycmkvTVFhNmJUbnB6?=
 =?utf-8?B?SEZmTVFZSnFOdStuZS9jNVFHVjhSWE5zOHJYaENuMG5uV2NGZ2RlbFp6YmQ4?=
 =?utf-8?B?Y1lZNUVlWmQ4aWc1Q0FndEFtd3ZGYTJTSzl6TzlaWkQxTUpXRGhiQnM5N05H?=
 =?utf-8?B?bnlVQjdQd2RPcEhMa2gvbk83a3FSeUtPL204Wkh3bmthTGtSSjlXb2wwZUg2?=
 =?utf-8?B?L0hEeHg4QVlsd1kzQ2tOVlVFUloyVFBpZk4zK29lM1BTVUxiQTJqZzA4MnJW?=
 =?utf-8?B?a2xicHAxWGx3WW8wV2lzbzVVbzBubWZhOGhFUks3Nm1HajhEVzlsWDdIckxW?=
 =?utf-8?B?RUgrdjIyVzkyVUgrazFBZ29vYkdsYVpMUlE1eHBnSTBWckRMdzVPMTZtR3d3?=
 =?utf-8?B?RitRWjIwUWF1cmNqeUJhUlNJVm5OYnBSaG9UVVM5Y0RDM2I0aklOWU9yWUVn?=
 =?utf-8?B?b0VMbFo1akpLYmlERTRxL1pVVE5ZcmpFcUdtL1BtWURON2FhRVZGTmoyL1pp?=
 =?utf-8?B?eitGaGRPZEdLdmd0ak1QeU92ZGFCVjdTY3J1R041TlUzdGt6RTl0a1BIano2?=
 =?utf-8?B?ckowdFJBMEVjTVNzU1hTaVVJcE11ZGZNdkF5TXBwV0hhWk82TmIyNG9kS2dX?=
 =?utf-8?B?anE5UTFrLzNTT2ZTVGc0L2xDVzZMZW1POXlaRVk5OTFlNEZ0Q0JQWEl4Rmlt?=
 =?utf-8?B?OU5zbTZUL3JuOVMzYUF5SEtzcDYvTndJQ1dDVkxvdmtQU0dWNFV1alRDVlYr?=
 =?utf-8?B?WkhkRmhHQzVNME83N1c0L2ZjV3E4Y0ZJVEdTNElFVmZudDJqWG9CSGJKM2xO?=
 =?utf-8?B?NGVaSGRCS0RiZm1BVERoZkFiS280bWdVRW5CQmowRkRJM0RkUzN1Q2ZvZUFK?=
 =?utf-8?B?blRjYmJ6T3hwSmFsOElxYlpCZkxDU0JZcmREenhXRnZnM1ZNYlJsTko5VWxl?=
 =?utf-8?B?aXhxWGx5OTFUVURMUU03b2k4dXdEeGx6WFJtUDJnSlU5ZDRubDYyU3BZNU9E?=
 =?utf-8?B?NU84OVo2bmo4dVNtR3JNcFJwNGt6TWJyWjZ1NXFrY20zdkdadTJ1OTl6dTdH?=
 =?utf-8?B?YjFpMWVXaEp6Nkk0cGw1OXJDc1B5L09tWStibDRlUVJNQUExNmhuY3dNcnhR?=
 =?utf-8?B?U0VEcHZWVkt1ODBMYXY5M3pKZWFzb0VjT3JuSWk5SzRhR0lVZWtOcWtZcWpJ?=
 =?utf-8?B?QzcyQ1BSMDlxcVByYlR1aVU4WTVpY3dNYU4zbENGMkVFWVBvZ3VYOGliNmVa?=
 =?utf-8?B?T1BBYU4vVlJiMUpTcURRajZPR2NEWWE2NFV6cVVCWDJNU0dtQk1Qa2ZjeFNj?=
 =?utf-8?B?RnFtemRGSEh0K2Jtc0pZY2lRU1RsamFyOGtja3BOQjVxSlVlRm01YjBUZ0p2?=
 =?utf-8?Q?rJT23hfXRO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXNYT0NxU29vYkJiNUpEOG1Vb1FGTk05bnNCczRkZHRxZ3FyNFUzMWlHdlB2?=
 =?utf-8?B?dmxTaUNCcU45NDcwc1JGc0I0WWpzY2RvakRxc0h5RkpnaWRqTTY5VGNOMWo5?=
 =?utf-8?B?Q2lkbVBDd1dWSklMekhLMHBZRENVUGlnOHEvNm5KRHdqTENrY256dGkvZG1z?=
 =?utf-8?B?SVNIM2grOEJVaDgxSWRqaTM3NjVRQnhwRVJOU3A4WFY1TXIrNG1jNjZMaTFm?=
 =?utf-8?B?SS9iTFAwUWRScjA0RzZGSVNJbDVpdStQU1J3YXc1RFpaRzdlVjRVL3l5RWJ0?=
 =?utf-8?B?ZFJSWWNTUzIzbGFiaDBCeE1HZEhZUWVFU2hpVk1GYWE0MHkzbVEzQWJ2ZzNm?=
 =?utf-8?B?VjVpeUlxYmYxT0MycEREUWN4QnNsMHFJck9qRWFDbHdIeU9KdEY0a2JsZFRY?=
 =?utf-8?B?TElzVUI5a054aTRFMzNzRTJSRXBTd2RKSlo0cXNZKzNIQk00K29FclFnN1RG?=
 =?utf-8?B?aDNTYmFDaU5TN2VwRGducmk0TTFJOWpXMzFGaGw5SGdqYVMveEJ6VURob0wz?=
 =?utf-8?B?dm10VWxoYVFaTXdRMENFLys5SHdoSUJ3dmhVendmZTVZRmp2NDBjTDYwU3JF?=
 =?utf-8?B?eXpySjJDYmhWbFJLVWorSHp1bDI1OXJqUnlKOWlMazY5eWhUSmRKTUhTbkd3?=
 =?utf-8?B?alVnK0dweDdwcEI4bWd1RlFKaG9WV29FZGFpc3FJNWQ3MjNtKzk4UXdQTTlL?=
 =?utf-8?B?UmgxRWpQNlBjVUQ0QUhod1M2TWoxdFNCanEvNHV5dWExTWZ1SlVLOUJMREgy?=
 =?utf-8?B?eWFoTC9VdGZHTy9YMXZJZHBTU3pESnpCVGFkOEIzbnRGaGVQa01KRzRCOUly?=
 =?utf-8?B?NXNXbEZKT0NOSk1GcHNFa1dYbEV2N2tOYWpjcnVGUk96MFNSNDNmKzYxamo4?=
 =?utf-8?B?VnNCa1BvTi8zWVRRelkvbm5Wa0htcGRqaDNjR2tra3hocmtYcXFzcVoxblVG?=
 =?utf-8?B?MVN1cGNOT3VIeWpxTHd0bWpVaGtOTHE4TjQ3QVR2OVJYRFpqOFlHWmVCbjNk?=
 =?utf-8?B?eEpQODhoZk45Smh5azAxQkx3MDFmcGxwMXdrSFpoVzRBbHNIa0QrZUN6ekk3?=
 =?utf-8?B?OHlVdStJUElMU3E4Mk1vWTl0ZjdRUjI2NVVIY0tlSE1WaTlqbmxHN2NxQVdY?=
 =?utf-8?B?N2xvR0kxam5lNVF4NmI0WllJU3BuYk82SEJkaUpyUjZabkN3YjFWRFpVZlll?=
 =?utf-8?B?K1BKdS9iT2hGaDdUR0N3b2tkaHdSUHRlTFJkNWRudTRYbXB2QmZsaWtJZUFn?=
 =?utf-8?B?bGxlTDc3VGFzMU5WNTBtc1Npb1pHRWN4RHlBbUZTck9yQ2FDWkt3T2d5YmNC?=
 =?utf-8?B?WTVDOFhwU3IyNUVEZnEzTTZ5b0RHQ0pzanBFdmxXSTZ4YWwreFhwRWpBQnpa?=
 =?utf-8?B?eFBSK3RMMk1jWjdoTVIvdnNROGdsZnJHMnMxeUM0M2hlK1RzbVBtb01NT0ND?=
 =?utf-8?B?RWpJcDZlRFhlOGozYzNTZ3ByZFJITTJWU2ZKV1JQcEN0eXdhR0JLS2RYMDQ4?=
 =?utf-8?B?Mmk5VUxQNmN5Wms5c2UwblRBdUFuR0FIUFJyVFdHMGFydytpT0t6OXhKNGw4?=
 =?utf-8?B?aktHVDc5MFRUMDNzb2ROcHJXYlUwNmlmNVc3YWlhMGVvTnlYKy9XQkhza3cw?=
 =?utf-8?B?KzV6YThwTlp1Z0o1Zjh0c3JDRjQ2cDhxbXN6VHQvYm9oZEdnTlZLNEVRemNk?=
 =?utf-8?B?S2s1RGdvbXdUR3BQRjh5UEk2UHZBMUdlN2lZV3ZKS1FZQzJFR3pINWFURmpZ?=
 =?utf-8?B?N0h1RW5TQ2N0L2pseW9LSDVGNjgzQzJKaEo3Uit6YTl6UW15NUpJeDlIQzN1?=
 =?utf-8?B?RWFQZGlFL0lDM0dlemVId2M4Y3RFaVNQQnM2eEo3OC9BeHpJa3BXZGUyVlB1?=
 =?utf-8?B?ampndTZMc0lOQ0t1TXVpempZbTRuRTJDaklLZ0lRdWlBdVQ1VW5hMVc0MXJI?=
 =?utf-8?B?Ym1NazRFVHBoclJGcytrZk1LMGRUbG1yTUdsMVRra3F5MWlmZ1htMTQ0bWlx?=
 =?utf-8?B?U3RZQkVuekdDUnl4SnFET1huSTVhMXl2K3c4UDJaMVFwSUVXOG05Q2VIV1Nl?=
 =?utf-8?B?MFBhUlhTMmduRTYvdG4zN252aWhPa3Z6VzVEWG5iRjZ3N3pBMVYxOUZOWkxq?=
 =?utf-8?Q?ozI2BHKKk1/JriJN9QpBonFKg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415aa444-6852-4d5f-e511-08ddd8ad646f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:02:18.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUuOL2XOd1geDd3MJ1TiflFuw2Ydj1xlpfcZBrm1Gg68iPY8zaHdRDlSJqlJAtKrJm5PdhlutK9tNLCtAitJIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465

On 8.8.2025 20.26, dan.j.williams@intel.com wrote:
> Arto Merilainen wrote:
>> The first revision of this patch had address association register
>> programming but it has since been removed. Could you comment if there is
>> a reason for this change?
> 
> We chatted about it around this point in the original review thread [1].
> tl;dr SEV-TIO and TDX Connect did not see a strict need for it. However,
> the expectation was always to circle back and revive it if it turned out
> later to be required.

Thank you for the reference. I suppose it is ok to rely on the default 
streams on the first iteration, and add a follow-up patch in the ARM CCA 
device assignment support series in case it is the only architecture 
that depends on them.

> 
>> Some background: This might be problematic for ARM CCA. I recall seeing
>> a comment stating that the address association register programming can
>> be skipped on some architectures (e.g., apparently AMD uses a separate
>> table that contains the StreamID) but on ARM CCA the StreamID
>> association AFAIK happens through these registers.
> 
> Can you confirm and perhaps work with Aneesh to propose an incremental
> patch to add that support back? It might be something that we let the
> low level TSM driver control. Like an additional address association
> object that can be attached to 'struct pci_ide' by the low level TSM
> driver.

Aneesh, could you perhaps extend the IDE driver by adding the RP address 
association register programming in the next revision of the DA support 
series?

I think the EP side programming won't be relevant until we get to the 
P2P use-cases.

> 
> The messy part is sparse device MMIO layout vs limited association
> blocks and this is where SEV-TIO and TDX Connect have other mechanisms
> to do that stream-id association.

Despite the potential sparsity, I think there needs to be only three 
address association register blocks per SEL_IDE block: The routing is 
based on the type-1 configuration space header which defines only three 
ranges (32bit BAR, 64bit BAR, IO). When enabling IDE between an RP and 
an EP, the SEL_IDE address association registers in the RP can be 
programmed with the same ranges used in the type-1 header in the switch 
upstream from the EP.

That said, if the RP implements less than three address association 
registers per SEL_SID, this scheme won't work.

(I vaguely recall that the PCIe spec might forbid IORd/IOWr TLPs when 
selective IDE streams are used so the limit might in fact be two instead 
three...)

- R2


