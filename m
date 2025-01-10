Return-Path: <linux-pci+bounces-19639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2770A0993C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 19:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB217A1A75
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A11E25E3;
	Fri, 10 Jan 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nVHhHjkh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344E224D7;
	Fri, 10 Jan 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533219; cv=fail; b=aIWWlmfzyfNmmBKHRicxiq4EZ6qscgZemy35X3z79h9kk9r+qL0QAjqNYPEqP2lVXDhutZlWwIOBtbk1gDf/pjoWMLazRC95KBv50cM+p/G4a/lI2tvImQ/LctTwXc1B7MCFCwN1KXSgaGGWhAeKou3I+DE7gssIx3IH4lvjrAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533219; c=relaxed/simple;
	bh=toQhyUzf5ND7gJzY8XqJiCBgyYKYXegOXcSUhVl26n4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P98QUQE9btIhXLPFCv0XbmWHJCpXyhGVvOtn+uthno/MAVQweNPTzC8UQzxOzy9utwjeIxkmMWnNip6vpGON8KgKtl/qRcFbUOp7AKuQEwFdVkhifyASHvJdMV9EBcT8lWpOoJUDgBnAPUMGvdBy/2AxnHWhD8IoTdnEu/U6TP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nVHhHjkh; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N96LMy2Jp8KvDZarPGmpdi/Vq1SL0tkzBHPHRwg4i4rw0fr5EpWI9uREVqnuzT0BN/JqETxwy+b/Rv2dSvoSVsWF/uqS9sbKQAjtMxEv1Nbn4Pzshy17/Yhhmv+H945d4WC8NkQk1r0MAENNQTWvBZlZ8Zj7/5e7Ou+2E2lD/Onj1bC8szev9k7syfkEkL5HDDO2pgyUWZyN79oQ3qY22J29CgRjuCzC61ZkaJVUBsmHlcF+OYKZz+Bn1nhOvRJHcK796poDhxclLZgAGETsxatV/AH8FI5mS+9Zy9KYgAXDSYW2sX4JxFtepCWzU6n/UBftNcTqiUO5nCzWt/zl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvXaaGRMhzgTY+y+u/UQsYsBU30NgeVhqMMkeBbGC8Q=;
 b=SG9rhsikczvYb7MFvnSRuiYyheJw1XzP9OSmMA7S8vfk7PbWc+A7laz7Ffagxnix7K5PLlYZ5aWftRf89bXiTA0z7JmD/hMs7fzxCSi9kq6TnWiGjK+Ou16LNXwYPQiWsvt43oKrR6koulUbnJsxmfcOTGYFJwH8dmQ8dP74PAcFFpyhLi1NX6ITRc5UiJwqjYSI/HPMSgxslxT1bRQkWAZm1AElklHO8f6CpmXyKXKmVkeYKDoCDrw2pSdDw+Z21CPfuNLbXsiW20dhxMX0WarIuUe/YrhUWGRIjDW4ZD+bAFDMWnIKqQ+ggiXN3ABGgwzC4/23tSgHyLsdu31J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvXaaGRMhzgTY+y+u/UQsYsBU30NgeVhqMMkeBbGC8Q=;
 b=nVHhHjkhRCJdwOZ20u1pBuuVHiOXkAahB7lxGwC8Q2i4COZv3zk9HqhHlRv3y0rc7VmZ0wmYo9Sl/uyXbdStd7WUWd5vyLITvQirCznEL0Zupcm8e9nLURcgzXvjwwSDgP1dPc/leLC6X8MO+tmPvASkFnIoh7zncn2SMMtxlH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 18:20:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 18:20:13 +0000
Message-ID: <02b8cc7d-4514-42ae-b3af-e22f7e7b8351@amd.com>
Date: Fri, 10 Jan 2025 12:20:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Avoid putting some root ports into D3 on TUXEDO
 Sirius Gen1
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241220113618.779699-1-wse@tuxedocomputers.com>
 <959c10ce-9f84-4dd5-8506-9d094f0d6762@amd.com>
 <8b28076c-7273-429e-97a9-05a8c670f171@tuxedocomputers.com>
 <a769622e-9e5b-4ad8-9474-5c5f935270b2@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a769622e-9e5b-4ad8-9474-5c5f935270b2@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: f30c30fa-e5a0-4818-9922-08dd31a36d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M203R3pISGRGblJlQlM3cVNhUjdjcVZEUzhiV0gzQVRoRUpoVkdaMzJFQ0Jm?=
 =?utf-8?B?RFczVTZiU1kyanVkZXBUVTE1bFdOSU1WVUw2UXZhTVVnN21OSnVzRHBpWGVj?=
 =?utf-8?B?cmwvSnNGNHN0Rm43V2VReHNrU1VKajUydC9OQlhwdXJrbFdqRjVzMlBzQnZV?=
 =?utf-8?B?VzV3RFl3OUg3TFVlSkRBTG9rcU1PdE1tNjBNTHZVQzNZRDMrSTFBOXlXU2tu?=
 =?utf-8?B?Q1hFblFJbk55OEhVeGVaRG1vOFhLYUFRemdudElDK3FJT08rRGJicU05UkhY?=
 =?utf-8?B?K25hOHVtblFLTXZQckp4THJaOVUvL0JzQm44aks0MFMycVZwbjZsQit6Z2Fw?=
 =?utf-8?B?UzNxS3hYTmpGaGd0QUVHdEtERzV1cVlrMWpGYktxQXZ5VmdaZklqcFhHTTdq?=
 =?utf-8?B?UjBmZkpIZEpTbW85eWJZN20rOXFHcW5Mc25rdDI2bDcvZVNWUlR6cDBvNWN2?=
 =?utf-8?B?a1RWRWdiazVBMjdSR1FhWGdmM0hoYmlDdk5yU1lyd0dzMGdDUm5QcDdmU2xa?=
 =?utf-8?B?SG5ZMVc3NCtrZEJMbUVyY3NUc2lBbFN6aHRLUmtuWVJxTUZjMEZxS3lzL1ND?=
 =?utf-8?B?S1Q2VUdJVGpkTzdmZFprdWorYmtVOVNBbzhobVdFWWNjVTY0STdja2tSV0Np?=
 =?utf-8?B?eER6UzBlTGxQVHJKQlRkcUdZRDhldDIyRE92ZTMzNStZWGEwSkV0SlRZMFls?=
 =?utf-8?B?TEpiVzlrRlpIMmVNVmNZdktMWEJydk0zQU9KbitsLy9WU0RadGdLRDZSSVh3?=
 =?utf-8?B?VlZreE5RZnNLQ3AyWHJtRzIvenFFSnlMVTJsMy9TNXhXSEdkampZc1JiMUxH?=
 =?utf-8?B?TnRpWldYYzVrZUhvWXNVeERFWlBTL05LaHp3QmlHTFk5ZDdtYllIbUV4UTJp?=
 =?utf-8?B?cWtTdzhzYW9TZ1FHVlMzZ3BnQjNSaHhiRWtnMnNJVFBEQllXaDluSyswYkpj?=
 =?utf-8?B?cFZKNGVJRmFBMjhVOW9aVUhQY3J5N1JQY3phTHk2YWNaZ1VjRXlwRFNSRmt1?=
 =?utf-8?B?MDUrcnBmRjU5eUJVVFFLY1lTZTgrQWNpRXZHNGJKdERKQmdOUlRyc0JMRGdE?=
 =?utf-8?B?M1pKUHltZDhTRmIzZU5ZOUdkOFlISzVJODdicEtoS2NpSU01bkNQaWRvZFpv?=
 =?utf-8?B?Unp4MUZ5Z3lzbDY5ejJRTjNydDZzUVNIaEo4VFlhNXNLZmNxR0NlVldxVHJo?=
 =?utf-8?B?QkptaitCRHk4MXJlZ05xbWh1cjRiYStqcVlJRExRTjFuMklsSFJXclNhMjhG?=
 =?utf-8?B?d05TU3FxS092VlI2VS9hRzdWUnV0ZmYreXdvZWhhaVhON0ZQcVNEblZKbnJI?=
 =?utf-8?B?QkV5YjRyMlhONlp0Sk5QVW9LOVNFL1YwMDBSeWdHckJTSHFIZWVocTMyMWxa?=
 =?utf-8?B?Ni9IR1J1OTBKaUFEeFNmRFViSjBsZ1NoaWF3UGVRS2tiUlVUN1FxcjcwNWNI?=
 =?utf-8?B?NFlVZThsbi9yVG5BaU9qdll6dnpwRkM5VjBmZXdqS2tBdThXaW9JV041cDlx?=
 =?utf-8?B?b0NDR0doRlRWOURSclJ1SUJ5VjQ1d1V5TGsyYjNKdW14M2svZ3p0SjhIRThP?=
 =?utf-8?B?TEpYWnF5RWRsRUVZNEk4MXJ2dXkxVGtGdEVoRlZyUXF3Y2l1SzUzMVdaRUtx?=
 =?utf-8?B?cHBpNlljdkxFZ29FQlBmTnFBMnJvTXZ5WXA2UCszTmhlYXBEc2d4Ujl2a2hV?=
 =?utf-8?B?a2dPNi9DSlNmYU1DblZBUU1FeklXenNUQWo2Y3lmajk3U3Nuc1VtYTF3a1gw?=
 =?utf-8?B?VXVYQkRIUmxhNkNWbGErT0wybU93K3lZelMyWWVaMmFVcGh4Y091M2t5NDJR?=
 =?utf-8?B?K0pSU3JtanF6b1J0NUozMWJ5bUpxTFdMY1k3ckR4MGkxZ0ZDaEhESXNiQTBY?=
 =?utf-8?B?eE5MM3ZacDNjd2prQzhhd05LcnpjYlFELzNndEhHRXplY1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxCYkNIZHZ5YjI5ZWdHcm5tM2tGODdvUG00YThpRUgyQXplWlpWM0NCQjhj?=
 =?utf-8?B?aDk2LzFYYWZML3VqQTl5MTNwWWRPNjBHK0Z6d1I3UEYwTkZMSDd4MzFGSmYv?=
 =?utf-8?B?dmpBMDRYZ1dYVjZ1MTBQRUNuVlQrRXc4bEJhVVA1RzMyN21RUDNMMVB5QXBU?=
 =?utf-8?B?eWRDWnZjeVJUeGZXbjg1b3JMYXhwL0VNTytHVlpCbnNDWTRESXEvZXVHa2ti?=
 =?utf-8?B?ZmRrdTNYMm9GYU1vUkQzdW9CSW5VN21Tc2FOOXJxemd6QTQ4QllDRUYxaEsz?=
 =?utf-8?B?Ritha25Mbk55THhxU0UwZXF6MXJPVmlYNm5KUFYwS0xLbDl4b3U4b1oreWVF?=
 =?utf-8?B?eEp1NnNHNlVQUTZwSVZNSFlaZlQyOTN4OGJRSWxmOWVNVk1Damh3bEhBTjZO?=
 =?utf-8?B?SzFmSFlOd3crMzJmOUJaMGZWQ2tKTEg4VDAvSHB6UzBWSlNQL2JIU0xWeVFG?=
 =?utf-8?B?UWsxQ0F1V2pJUCtaTUVrK3lkMG8xQ01UUE5ubU1xYXkxVVZLY1hmVjlSVzVk?=
 =?utf-8?B?UTBxeVRXc0lXelhsV2hUbUcvczArQzgrTkhqT2lQMi9ESmRRZmRpZEYwMmsv?=
 =?utf-8?B?cjhWRm82blZtY291Y09ya1J3SXVERDJJMFNPWEVvUm9Wb29YMFRZYmdGeEg3?=
 =?utf-8?B?d2NTWG53Um9kQk1rZzVWeUtySWVhTFlpKzc0SnFqcWZiajJ3M0RIcnRVT0gx?=
 =?utf-8?B?R1pBdXhvRFcxQ3ZHU0FCVVl0bytzeG81b0FSSE1lNTY2WGkwNkUzWExuME1T?=
 =?utf-8?B?bFhxQWJMYzQ1Y1UwU1N2ZXhsTVdWTGV1aGVkTzRObUFGakx3ZzVzU3ZSK3Vz?=
 =?utf-8?B?bFBnS2ZTMUhGcURNTFB6RHNrN0MzQy9qZHp6U29HandEejZDaUVvZWkzZk5u?=
 =?utf-8?B?R2xBdkVVTTM3U0IzTGh3NTluWDljcmhRcmh0OVN1RjRBYjJITC9RUENBeExB?=
 =?utf-8?B?UER0VVFWam1XK2FQbTAyWTZvQ0tLZ0xBSVhWak9SK2V2ZURhOXdkTHpkMG5K?=
 =?utf-8?B?UGsrOFV6VEVXYjMycUZEWm93UDZZUEltYTA0amVTcGNremZ6NzF0aVE2VlB4?=
 =?utf-8?B?Wkh6Z0tLaTJsYms4WU5HZzZFSExiak5WWnlFMVkyRElpbGs2azNDbTl3ak1z?=
 =?utf-8?B?RnVwOUI4U2tUQVdKRGNCL3doM253RTZScGovTXdlNk1ORWtYWUhScElYMU5t?=
 =?utf-8?B?U3lzWXc0M2pqZXhFbFBiUSs2YkVwTnN0NzRoeUZpSlFkS2I5ZVR3N2NDcHZy?=
 =?utf-8?B?eG84ZWZEblhiRFdBVmtIS1pIVnJxK1dBSWpwR2hsc01uRzNBaVhCKzR4aEIy?=
 =?utf-8?B?eVZ1QndrNnI5TWdLVTdtL2ZFYzI3ck9iUVpZK0Z0a2duWTlKaGxWTS85dkJP?=
 =?utf-8?B?dW9NcU90T1crRm9KMzZEWklyU1lPVFVxek5uR3VqZEx1c0dSRkNZZWR4NUZt?=
 =?utf-8?B?LzFjU29UYXdpdzlMcEY2dWxRMmwwSnlXMWtwTU8vSkVqa2NyS3FJdUNpWFNk?=
 =?utf-8?B?enNPTnU2UE5HL0ZGWUhYZkJTcjkvQ1hlV1N3SGdWU0U1Z3JoNzc1VDZhQUgv?=
 =?utf-8?B?dnJCZWtGZCtrZ09BTitJR0NMZDhMR1owd0xqNDdidlAwM0tnaVZLVlJzMmtu?=
 =?utf-8?B?aW1SZ2ZmWHVtbHZZMS90MStZWHJDRDVJdWRkb0d3c2MrRGNYUVJCTEpOdEZt?=
 =?utf-8?B?eDkyN243N0pKMzF3UDhPUXQ5dkUrS3EyUDJtMWQwaHVpRlk2dVc4R2FmMzU5?=
 =?utf-8?B?eE1MU0R4ang5QzJRS1hhMHZXbmloL3dlN3MrUHBPSy9qU21HRjJSSFBCdDNX?=
 =?utf-8?B?VEJWV2hUSEFNNGZ4Z3d2UHQwUzlCZEkwbVNoL3FpTFFrK3NFUGJPYThTRjNC?=
 =?utf-8?B?R2l2amxES1IzNW9GWjlrV3NWcEVMbkxoc0RSWmRFSTdZeGRtTk5iYlpwKzc0?=
 =?utf-8?B?ZDhLaUZsek92S0hKZHFmNW5zbUo3VWNtbG1hd082dm12UXZGVnUydjNEazRy?=
 =?utf-8?B?cisrenVvSllFT0hQSktScVpPbGphdjB5RW5KdTMvL2ErbDJUUUJEN3NaU2Qv?=
 =?utf-8?B?ZGFEWnhsQndUazFwUVZsWWFTc00vRWpRZW8rblppQWZ6L2c2UEdtUXZtV21J?=
 =?utf-8?Q?qeW8D8AxPFSh7/34YHj24I+XP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30c30fa-e5a0-4818-9922-08dd31a36d34
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:20:13.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyAER1k/bJiFIRMxVrQ51Ih+ir4m98MLzMqGbDmUQnrsYxMciAUgDt5SFUBOtbjzwbGLZZt+UKzQAK+RKAwH1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

On 1/10/2025 12:15, Werner Sembach wrote:
> 
> Am 10.01.25 um 18:15 schrieb Werner Sembach:
>>
>> Am 08.01.25 um 22:26 schrieb Mario Limonciello:
>>> On 12/20/2024 05:35, Werner Sembach wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") 
>>>> sets the
>>>> policy that all PCIe ports are allowed to use D3.  When the system is
>>>> suspended if the port is not power manageable by the platform and 
>>>> won't be
>>>> used for wakeup via a PME this sets up the policy for these ports to go
>>>> into D3hot.
>>>>
>>>> This policy generally makes sense from an OSPM perspective but it 
>>>> leads to
>>>> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
>>>> specific old BIOS. This manifests as a system hang.
>>>>
>>>> On the affected Device + BIOS combination, add a quirk for the root 
>>>> port of
>>>> the problematic controller to ensure that these root ports are not 
>>>> put into
>>>> D3hot at suspend.
>>>>
>>>> This patch is based on
>>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>>> mario.limonciello@amd.com/
>>>> but with the added condition both in the documentation and in the 
>>>> code to
>>>> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS 
>>>> and only
>>>> the affected root ports.
>>>>
>>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: stable@vger.kernel.org # 6.1+
>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> So I don't think this should have my S-o-b.  At most it should 
>>> Suggested-by: or Co-developed-by: since it was based on my original 
>>> patch.
>> kk
>>>
>>>> ---
>>>>   drivers/pci/quirks.c | 30 ++++++++++++++++++++++++++++++
>>>
>>> I think a better location for this is arch/x86/pci/fixup.c, similar 
>>> to how we have https://git.kernel.org/torvalds/c/7d08f21f8c630
>>>
>>> thoughts?
>>
>> Fine with me
>>
>> I will make a v5
> In fixup.c i don't have access to acpi_pci_power_manageable, but since 
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3); 
> matches to only one device anyways can i just skip it?

Is it just a header problem?  Maybe you can just add the header?

I think if you want to drop it that should be ok, but as it's a problem 
in your BIOS (specifically) and only matching your platform combo I 
would suggest renaming the function and struct to quirk_tuxeo_rp_d3 and 
quirk_tuxedo_rp_d3_dmi_table.

>>
>>>
>>>>   1 file changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 76f4df75b08a1..d2f45c3e24c0a 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>
>>>> @@ -3908,6 +3908,36 @@ static void 
>>>> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>>                      quirk_apple_poweroff_thunderbolt);
>>>> +
>>>> +/*
>>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into 
>>>> D3hot
>>>> + * may cause problems when the system attempts wake up from s2idle.
>>>> + *
>>>> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this 
>>>> manifests as
>>>> + * a system hang.
>>>> + */
>>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>>> +    {
>>>> +        .matches = {
>>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>>> +            DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
>>>> +            DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
>>>> +        },
>>>> +    },
>>>> +    {}
>>>> +};
>>>> +
>>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>>> +{
>>>> +    struct pci_dev *root_pdev;
>>>> +
>>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table)) {
>>>> +        root_pdev = pcie_find_root_port(pdev);
>>>> +        if (root_pdev && !acpi_pci_power_manageable(root_pdev))
>>>> +            root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>>> +    }
>>>> +}
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3);
>>>>   #endif
>>>>     /*
>>>


