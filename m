Return-Path: <linux-pci+bounces-21750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96781A3A197
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163A77A00F0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A026B2B2;
	Tue, 18 Feb 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gaeQLHh6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32B26AA94;
	Tue, 18 Feb 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893397; cv=fail; b=jzXPCuV0cnZvHUMcQ+XE+xLfAGvEbtg3Jkq70/rYszn7W3m5UCZ7kIK1W98zQPmYt4pDv4ZJvz8qHgUWuDCxkWd8u8wpSgTwJMGV0yZpWFiEJXcFKgjrkrFsXaZeQA5xodexlmf5rlzEI00BCMcjQiG+PAt0PIjii7XT3yexeeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893397; c=relaxed/simple;
	bh=qwik1f10GEVgxcZnnWAfdMs/xT4HchsCsUCvYR8CtEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lf1SOlHjjuzWIcE+FyS4QD09o24QQ3kPbJb8Mq8iO1R4cMzGAbQ1avv/q+fjajNWdQPHMuAITIx7+Pku7ZysrLKdKii4e3cAEUovSgd9qcy/iaUTW96cOjIbETk7n+26HShJcU0ietq3MI3c9LvbLKQnD4IHsWU/5a1L0Jom8FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gaeQLHh6; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQtfuU84LlO+ScVSeRBiwSIkYhwerkwJlE08WRASep0h8HObIlr+aoHbNl1RcLVXPNfWHIGSXw+HlxbM+2htBdjeeQg8UMQScG0uidygxTRF/+kg8wNRvIfAxdsHci3oV8P+CqsY4TqS1likqK/c2W3S/HAi19kqrDRB1dRJif/NYfuQmRVIB9CNYhkgU/VIA3j5WGBqwyPK0IH8xWvfEAQlzlmTa1hyLCMbtR4Vhihd7oyKKGx6vpA3Udv/ruGLguMOgdK1zhGDeQ1jtpjh0mTlQrcKoZMNwspHKBrQPCGmMpdllSVzDw4h2B7c6gyShMT2XRARTl001m2T8t/qEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEKCO0sN6tPlliOC/ntG18P8Kca+xW0z+i1rQ71uqVM=;
 b=nq2W5gLU4d3SQkDe5pyXd9ENmvnlL32/f5bXni9LbtWmBKOwzyAWG5H8ut5HgyCTs4dneyOIr11Q8D57vCGMh8jhA0mKtycOUu+bPZCy3UvpYVix2i312QotBoEGx4BySzyFL1sLL2yZHNJ8H+WFx9AmxvI54pcIN+iNpHP7iuTqQdCaXCckOHm98Qtgg5nkIucwCPhlL5h+uTNLxbW8/fG3KFlpwvWpipcirzXA1RsIiA+P6cXXbO8fvfr7+fk46kjJwocEP1uTMtuo4wDToWsaHZ1BW5IeJQuMTW0aqMSviyz6b0bxNVp+CqcpwG7mrFX5NQhwI5fGaquDRdEOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEKCO0sN6tPlliOC/ntG18P8Kca+xW0z+i1rQ71uqVM=;
 b=gaeQLHh6UdtSE49G8rTZSn+CMpvJGKm9DfpKslmReCqGhG3pVuRDC8YcuyP28KK6PVh8XY6/S5/4bekzVa1Ui0H6iaPLAEYnwZySL44VyML6cmKbsePc1bYiLM+38eFYtbJnhTm+2i7YmFVst73NQb5yPhxc1mW6u+oP71xSBlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 15:43:10 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Tue, 18 Feb 2025
 15:43:10 +0000
Message-ID: <109042a0-3c8c-4908-8efa-be07026cf9b9@amd.com>
Date: Tue, 18 Feb 2025 09:43:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
 <20250214151148.000033f4@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250214151148.000033f4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::11) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c03d6a4-3169-4447-de47-08dd5032f25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzZvR05BSys1eHdnZkFTTXM5NlRlNDJRNnd4TmdLUnpDNHBHRTRvTWJERkFo?=
 =?utf-8?B?Mys5R21YQlZsOGNpcCtaYVg1ZUVrRlB3NElBeGRhRUs1MkxPU1dNV3duOWtU?=
 =?utf-8?B?d1RRclk2VzA1Y2pJYUpkYkh5WE11QzZTLzdMdFhHYVcyMFhJQXFWNkw5V2hp?=
 =?utf-8?B?Tm1malZqTW9WRWtaQ2d5ek92Tm1OWUp4aS9Ub245dDByZmNuckR3Y0t1OHhV?=
 =?utf-8?B?M2tyQkxZZC9SUEFuZTdwcHcwZjBtRGNENnFNbjJHS2crUDNuMkhHZGMrQmlx?=
 =?utf-8?B?aEJUSlpoRUg1WEFjWGtCQ3U1T2xSZHByVXNLRWs4ZUlMS3B0Uy9pcXV3cyty?=
 =?utf-8?B?QUxKYUNkcmZWSXQ2ekxoT2p2bXh1ODY0YTlFa2pPdzdzL0UyaGl5bHJvKy9B?=
 =?utf-8?B?ZlhkR1R5MnpkNFJEQURmN1gwQlNNUmwzTm93Q0FiYllIZE1HY01IUnFPVFBP?=
 =?utf-8?B?N1BSbFpUMDhkRnNUdG5HV2NubElZNWRoSU5GQXEyQUJiTjU5eDFNa2NFTllR?=
 =?utf-8?B?MzhsRmhjSHU0aWR3N0djb3hZNWltQXBlcW84djBoMzRCV3dYSVNWMm9sVkRx?=
 =?utf-8?B?UUM0K0c1WWFxNkt6NzBvSmJMSW5lOGprbVNKNERwRW0ycjloTkI4eGtJbTI0?=
 =?utf-8?B?TjZxSE9KZytzYVQ1RGJ1blR1RzNwOG1TYTlCZXZHVXBITmxQQUtDUGlTNWIv?=
 =?utf-8?B?RG1tNGQzZHQ5V3A0ODJ4VUp1NVEyYlBpVWdEclk4MHY2Y1pzUytraDRRck5q?=
 =?utf-8?B?QkY0S3dxd2h1RjlYKzhWU093clhMUHRNQjJ1czcyeks0bUxDK1JJM1ZBb3V5?=
 =?utf-8?B?ZEFEYkdEYkkwRnFQNkROMFJyOHcvbGorMU9EZHJQSzk3ajd6QXNvcmRpSVRS?=
 =?utf-8?B?OFlSVWJMRCtuT0lSOEk5REdrS1k4Um43RStGTUVBZHhOL0hjTmdVaFBqT2Ns?=
 =?utf-8?B?UG9wb1Jic3ZMQU1oQTRNUjBpSkt0VXovV0F0UVNaQ053cnpTSXZRb2wrNmZl?=
 =?utf-8?B?aVpadStaOFIxVFd2VmtVd2htMENxSWk1bmxPbDNnNXgzRlVacU9tZmZYbFlU?=
 =?utf-8?B?c0NVajhOc25sK0xJSVJodjh5NndzL1FoOGpuMStQdCtHc0VzK2ZmT3U1enh2?=
 =?utf-8?B?RWJMU2VPL0lLTE5UejRzYVBCK1JwcXN0aUpadE1BMnZmcW5xQzdWb0p0Y29m?=
 =?utf-8?B?cTNqeTVROHVSakJlT054WFlFREdBMlpZN253blRBVk1nc2dEeEZHRTBKeGdT?=
 =?utf-8?B?bkQ5b2pFem5PZTNlNHFNc3lTb3pYVXFKQUNrai84WFRUR2xhaHpFdmdiM1h2?=
 =?utf-8?B?UnZBcVFuYzJ6QXFYUkpaMXdwK3FWUW10SXVkV1B1WElpcURtaFZ6R21salRF?=
 =?utf-8?B?dUNmd04vazYvc1R3YjJUdkJwNzdFSHV6eVpxSldTakhvS1RxWndCZlhucm1D?=
 =?utf-8?B?T2NZNjFxWnpianBOaEJhdWRCTFJ0SVBiMUVzT2tmR1o5RUxlRU5BRUd2VGs0?=
 =?utf-8?B?MENJeFhSc2Z0a2xHajc0UTF5dENzUnIxdEVxSjlCVm93Q0pqSlc0Vk1WSWN2?=
 =?utf-8?B?Q1lVTlJrdUtBaWc2elhIczM3cjhwRVdiVGEwc3J4Z2wrUDlkYXFpTEt5enpG?=
 =?utf-8?B?TVBRVlIySjJ5NGtCM09DZFFuY2J6WEVZeGNESW5WcDNXVE4xQythRmpEbWRs?=
 =?utf-8?B?L2ZJZlk3MktpUDk5c2tZMk5ERWswU3N5T0cvZGlvMjBWcG1MckkvencrRzZN?=
 =?utf-8?B?Z0lwQ3ByWHBZOXhITVdJVUVuSVM1eWtkSGhVNVpVeVpyaHk1d3JHdXlzeWl2?=
 =?utf-8?B?UzBlUWFnWkUzeUZSUTlkZ3pYK3VVY1dJSEtkUHEwSlVuZzVRVFpYYjhOKzIx?=
 =?utf-8?Q?Su2jegO3O2zVh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNFQkhrWjNKRkdPeFdtSmhsMU9CaXZlV0tUWUtrYnA4NVhJRlZ0dFVYRXJr?=
 =?utf-8?B?ZEdPWDkxd0FxMVFCZWtEa280Ly9wUmxZa1RQNGM5bDlJcXIzeFZKNWp2eGdF?=
 =?utf-8?B?UThONDJEby9nV1JsZVY4aUZ6ak9Ga2NMVFdzN0JIWWVQczlDN3IyRFdieVhj?=
 =?utf-8?B?V25YNlg3Vlp1QitkQ1dqQjNwOWtOckxqUWJ4SnI2TWNUOE9VTDJmTTloVytw?=
 =?utf-8?B?RDI5MlRPUS9TOE55enNNbklaTG5aMW15YUF5WUlxVWcrQUhidzJKa0w0SUg2?=
 =?utf-8?B?S1lrRG00OCtORXlVSDd3NGozeFdPamlueUxYeGRMZnBibXBXb0Y2N2YvT2lM?=
 =?utf-8?B?R1lTTTBJTUpPWXVVUEVXUkdtejlxdEcxbGpDMnhMRk5wUlZrLy80Zk85NHpC?=
 =?utf-8?B?ZFZpdFoxbENETEhHRXFLUWVWZ2paVGMvaWM4MTVHU1FteTlhMGZ1UkN4enlM?=
 =?utf-8?B?dWI2Mlgyd2k0aXo2cXF2aDBjWFZVd3pmSU42bDVqK1RYeTUxRXdYcFkyZ3hB?=
 =?utf-8?B?ckFETWo5MFNrdlpSUnFQVnlISGpDMmp4N0wyc0pIMENNbTJxbUtjNG00WjVF?=
 =?utf-8?B?ZkJKQ2ZKTDlJVGVLUmlEbFpsbXpEZ1ZsZy9kcEpKU0Y5MS9IcmdMTDgvQ1VM?=
 =?utf-8?B?R0dKMHdWWDBMSWNzSjUxWStJazMzdjhpS3FEc09OeFBQeE1kRWVHZmFXUXNp?=
 =?utf-8?B?K0tRUWN0UnNhbGNkcWlpZnVTNTM4SDlDZkpPckpYV1BlVS9DQkZZb252Z1ZE?=
 =?utf-8?B?Nk1NTG1VZDFDYkVGYTNaMGRaUnZwZ29aZGZiR0dMWFAwNzFEQWNqQW9FQ3Ey?=
 =?utf-8?B?RGx2V0RJaDRMaDByYUFCOHVIdm1HUGVVZE9kWmpQSWJvMUJhY2owU3RHelYv?=
 =?utf-8?B?OVJIajV1SDNUUUQrRUxpR3QvY2dTUGZTSmFxcDlyT3NLbTBRVWlUUTR3UUxw?=
 =?utf-8?B?TlVXcFVhVnRBakdYT1RSRzlhZUhyRnZqdG04a3VJSTdFK3l1UU9qUHNQS2Q4?=
 =?utf-8?B?QnU3MS9ZamZON2l0TkFZZU0rLzNkN1NRTTlKbUxvTFhqMjF0N1ZWTjdVdmMw?=
 =?utf-8?B?RU5jS3JMS1R3MU9oeDU0QUUvVWxTaHM4QmNoZUlqODQ4N1lHOVFyN0g1Mzlk?=
 =?utf-8?B?eUNIL2hEMWdKZWVUdDdmb09WbkNVNkVHQ3ZIeXBKMHBQa2dCc2JyaWNMTlVK?=
 =?utf-8?B?OEJlMFJaZHhGMUxSd3pZQUREQjIreVd4dFo0OFg5bk5nZkt5ZlN5L0dwak11?=
 =?utf-8?B?SE1qY295Vk5kcjhhWHF5anRjUUw1cDRJVllSb2VuT2FSMmdGaHBvRlhVV0Jv?=
 =?utf-8?B?dERIKy80WkFuQnBoY2QydDBoMk5adldZbHlhZTFrNjBGZEJVQllKUHRjNlRj?=
 =?utf-8?B?QlFkbWl4M2JwRVkraHdsUkJ6VEIxS0JGVkNJTFErbWFUaDE2RWx4UDhKYitH?=
 =?utf-8?B?OE1lS2tNOXBLeDlzaWNibDk0NE1WYUtrN2pxWnUrdUNjVUdMMHFRVW5Fd0VM?=
 =?utf-8?B?dHdnYm5lQ2cyNmNrS29Cd2VqYzdIR3BuaUpGVWE0NVBWbEFCZ1Z3aVpsSDBs?=
 =?utf-8?B?M0ZvZnBoSUVnS2grNThTZHRxL2Q2bXpKRy9kblVOeitLZ3ZBZHU1dW1hRVNv?=
 =?utf-8?B?OFUzMWdJNE5Jekl5R1FiVnhZL1RQUnBNWXFDY2tRNGpPRlpvbG1vUnY3Wjla?=
 =?utf-8?B?cUFDeWorcmR2TDBPWUptMC92ZkhsdFlac1dVb1BYc21WV0R3d04rdzVSeEhG?=
 =?utf-8?B?b0U2UUQ5OWJobTRyRVFkZTRtTXdobzVsUWJzTUpyTmwvYXR5QnR4V0czOVpE?=
 =?utf-8?B?L3hhNjRJSzV1QVZ5dmVlTHlWYjh1Uk9heS84Q01UV2FKK3hYRjcxRFRweUxV?=
 =?utf-8?B?NEh3VGVMMmJ4WC9iN2E0YjVHNDRza1pOY3Jkdm11Z2NlaDZJWTB0YUUvUXhB?=
 =?utf-8?B?TXhKaDRzd2xYcXY5YnY4T1d5dWFQYWkwc3A5dzU0aksvMWVpd3lXLzNTU3du?=
 =?utf-8?B?NTYxbjVjTUhaa3NxN3pra0oxTFg4cEltNlZDQVpGYmdRd29YV09HUCtsZGlz?=
 =?utf-8?B?TDNwZjlKS2xVZXk0aGNQUjlJR3lhR1ZvN0VxcTRZelIxMEo2aEdrZHpIQmhW?=
 =?utf-8?Q?EU1Su8O+P73g01bLDYovYlBu7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c03d6a4-3169-4447-de47-08dd5032f25b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:43:10.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DY2vDQRtrHNGIXguZ9h9SQYh9smwRqT05bi+Fhiyqf8+QMHoZb4Uu28MKONztRJeQlY7y7EoltyAmsxG8fKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706



On 2/14/2025 9:11 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 13:24:33 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
>> apply to CXL devices. Recovery can not be used for CXL devices because of
>> potential corruption on what can be system memory. Also, current PCIe UCE
>> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
>> does not begin at the RP/DSP but begins at the first downstream device.
>> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
>> CXL recovery is needed because of the different handling requirements
>>
>> Add a new function, cxl_do_recovery() using the following.
>>
>> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
>> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
>> will begin iteration at the RP or DSP rather than beginning at the
> Hi Terry,
>
> Trivial nitpick but you wrap point is shrinking wrt to the previous paragraph.
> Just looks odd rather than actually mattering :)

I'll take more notice of this in the next revision. Thanks for the feedback.



>> first downstream device.
>>
>> pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
>> needs further investigation. This will be left for future improvement
>> to make the CXL and PCI handling paths more common.
>>
>> Add cxl_report_error_detected() as an analog to report_error_detected().
>> It will call pci_driver::cxl_err_handlers for each iterated downstream
>> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
>> indicating if there was a UCE error detected during handling.
>>
>> cxl_do_recovery() uses the status from cxl_report_error_detected() to
>> determine how to proceed. Non-fatal CXL UCE errors will be treated as
>> fatal. If a UCE was present during handling then cxl_do_recovery()
>> will kernel panic.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> One trivial suggestion inline.  Probably something for another day!
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan.
>> ---
>>  drivers/pci/pci.h      |  3 +++
>>  drivers/pci/pcie/aer.c |  4 +++
>>  drivers/pci/pcie/err.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h    |  3 +++
>>  4 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 01e51db8d285..deb193b387af 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -722,6 +722,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  		pci_channel_state_t state,
>>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>>  
>> +/* CXL error reporting and handling */
>> +void cxl_do_recovery(struct pci_dev *dev);
>> +
>>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>>  int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>>  
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 34ec0958afff..ee38db08d005 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1012,6 +1012,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  			err_handler->error_detected(dev, pci_channel_io_normal);
>>  		else if (info->severity == AER_FATAL)
>>  			err_handler->error_detected(dev, pci_channel_io_frozen);
>> +
>> +		cxl_do_recovery(dev);
>>  	}
>>  out:
>>  	device_unlock(&dev->dev);
>> @@ -1041,6 +1043,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>>  
>>  		pcie_clear_device_status(dev);
>> +	} else {
>> +		cxl_do_recovery(dev);
>>  	}
>>  }
>>  
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 31090770fffc..05f2d1ef4c36 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -24,6 +24,9 @@
>>  static pci_ers_result_t merge_result(enum pci_ers_result orig,
>>  				  enum pci_ers_result new)
>>  {
>> +	if (new == PCI_ERS_RESULT_PANIC)
>> +		return PCI_ERS_RESULT_PANIC;
>> +
>>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>>  
>> @@ -276,3 +279,58 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  
>>  	return status;
>>  }
>> +
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	if (cb(bridge, userdata))
>> +		return;
>> +
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +}
>> +
>> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
>> +{
>> +	const struct cxl_error_handlers *cxl_err_handler;
>> +	pci_ers_result_t vote, *result = data;
>> +	struct pci_driver *pdrv;
>> +
>> +	device_lock(&dev->dev);
> Could use
> 	guard(device)(&dev->dev);
>
>> +	pdrv = dev->driver;
>> +	if (!pdrv || !pdrv->cxl_err_handler ||
>> +	    !pdrv->cxl_err_handler->error_detected)
>> +		goto out;
> allowing you to return here.
>
> Same approach would simplify the rch code as well.

Yes, I'll change to use a guard() here. I'll have to use the CXL device (not the PCI
device) as Dan pointed out. Also, this will be moved out of AER driver and into CXL core.

Regards,
Terry

>> +
>> +	cxl_err_handler = pdrv->cxl_err_handler;
>> +	vote = cxl_err_handler->error_detected(dev);
>> +	*result = merge_result(*result, vote);
>> +out:
>> +	device_unlock(&dev->dev);
>> +	return 0;
>> +}
>> +
>> +void cxl_do_recovery(struct pci_dev *dev)
>> +{
>> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +
>> +	cxl_walk_bridge(dev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (host->native_aer || pcie_ports_native) {
>> +		pcie_clear_device_status(dev);
>> +		pci_aer_clear_nonfatal_status(dev);
>> +		pci_aer_clear_fatal_status(dev);
>> +	}
>> +
>> +	pci_info(dev, "CXL uncorrectable error.\n");
>> +}
>


