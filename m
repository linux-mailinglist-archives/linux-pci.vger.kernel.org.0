Return-Path: <linux-pci+bounces-25374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B84A7DFD8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AD5175976
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9115C158;
	Mon,  7 Apr 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qkAaQij3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21A1940A2;
	Mon,  7 Apr 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033390; cv=fail; b=G4qJh02anFQZq4cLWMwLwRz8OjajT16N5OcANBOn+8eOCZDvQ3ReGIfzvjsu8FLInYp7owHQuat6WJaa0G3poDyxhhBCIwQvg3otwF87C70DqjxH5yH421nAS2pjaGKg05nLqy/NMZijbv6dmQRi2YNlwfQHUxecyQJQiF75W1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033390; c=relaxed/simple;
	bh=v8/1RKDyhFOM8LMecZjll+wzDbR4RUTp+fsMSe73jkQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PmNYlJTMEZXAhZ0gG/SReMGw3jHUlWeJJ9x+Oy9NRMF1u6aPwv0TNsY7JAYMiC5KUmp8tPv9ET9a2oQj66ffvDbwOMuNjTt6pcaS9y0PsWWu8b3I8FgnjufsETgw15sSEVkxSPwYo9HC3M0zEU1m+Ez4LrAdD4OxqtgUcszOW94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qkAaQij3; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytnFpQtl++kuJv6CnkoKnUpURc9iv4N9i7HxD5YohdNB7PIaySqR9u87fJPJ74idHzkWCXSj3yYoFAZWxTLt+X1i/lDFW2J/pTegXLz7EIRa1aJDxCZ1K5KIS1tAsdh/W8Kv6KTSfSNp8jZbGq+zHc9iH38f2O1H6uoq+yHahPU0rivBe64yLI3PnUdrsO/zUN9wkCCPhh/HWPVNYleQ5rkDm4ATT7xB0fII5jK9G/h8uDyGtTPmjwQXMQb8saEtuCEIBs7g8WXUjTwRZr0dMNxnU/se6LeNNRURAWwtKN7AMOvefLpTWPZbfwTlqU5sxgtZgQkAQ9HX3GMpyhfpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA8rt18AYrC9dzL9yEsGsDyxSymnpT9WtYRdDlzlD4E=;
 b=qwfV0v3oSZEh3ldr0q6VfFIkVvM4yKbtkQrzaFMo0XtpsQwKHXVQKs9heI2A+6MFl92ywwHy55JI/wF6c68n8PabYJtyvnZw9b53Ea854/gfaiWteUtSsIZ5JqKlTKjTNxUSbfo9Xtcl61dCwfL3t9DxNtlenIx0mFJqcBJLhZsfJ87SrHfbQLEZoMJ1LiPlMJfzYrBgg+7GQ6nAFVcJLtER1jx5s1i16Ld3gbdmt6vojxJ5fXsCou3Re92oSfNXMnmkEQ1vgotjPi9XPl6IqruQClsq10QPr/Pho24TsCeXjitCEwffKV4l/AjXY4hO+OLbgyBim57jhiA/pm50mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA8rt18AYrC9dzL9yEsGsDyxSymnpT9WtYRdDlzlD4E=;
 b=qkAaQij3y8ShhdwoB1MUPyk9tI70/74pkrFIM8FZ4vhioNfA91mWkhWNSKYvbTJf1mEHAfBSmVr4S/R8TS7fenGxfIIbg862eFVg9Aca8Dk1sQzP1iCxYwj3p54rZ/RZJFrwgfxz9LXJDGgA5l/vMIC3HvpPKFYnMOWyvldr8Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.46; Mon, 7 Apr 2025 13:43:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 13:43:04 +0000
Message-ID: <7c2bc818-5c91-42d0-93e8-1f38e68935aa@amd.com>
Date: Mon, 7 Apr 2025 08:43:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-4-terry.bowman@amd.com>
 <67e6d5d7bf0dd_192c6294a7@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67e6d5d7bf0dd_192c6294a7@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0199.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d74f41-c7aa-49f5-de8d-08dd75da1ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGEwdG5OQ29NTHMvczZxSlRycFJYcjl0QUpVaGdocUJrRCtqc1hSWnBmUHFr?=
 =?utf-8?B?enFBNTV2TVdndUZ5aG85MlhiRlY5c2x2bXB3emxWTVdLUm9vQmsyQXZ4QzMy?=
 =?utf-8?B?bzhzalFKSVlMYnZmUFo4VzN6OHJEMWZmT1ZjamlDWUxNV01Lei81cFVKNTUy?=
 =?utf-8?B?L213c2V3TThnYVQwTXFPVmxXNnVSTkdrYkc4SFljbXcvK1g2R0JmYnM3UEcy?=
 =?utf-8?B?NXlDSlg4V1lGdHVNV2owOWlrSWt2RVN0MEk0bkRTb3ZKaFN6ZnVYcjlnUWgv?=
 =?utf-8?B?YmpyOVNVM3JXcU1rMHNWV2g3eG82NWpVVllVUmV2U1I2QkFIS3JwTEgwejFL?=
 =?utf-8?B?VFB4THAwTFpJeHEwcEZrQzB4ZzJFWFk4OXMveTljbEV1MmNueE5wVUt6RENX?=
 =?utf-8?B?OER5MHM2Z0FUSXF4UE9hamdLcHlQWENQQ0NPRmgxak1IR1pGaVNEenR1T1M2?=
 =?utf-8?B?ejFYNXY3UkEvcU9FVXVlQTNjcEJqTE9nM2ZpbVRkd2lBZHJuOE8vclNFSjNz?=
 =?utf-8?B?TlVNRElRbVZpNENKTUk1ZGFBbklEQlA5Q1QzdFhlQ1hxVVVEQ3RJbmtDbjRI?=
 =?utf-8?B?V1JtMFIxRytxMlQ1S3V0bXBMN25vbUd1OVBtK2tIODlHRUpuTFJJSzJianN5?=
 =?utf-8?B?TElYbXprdk1QRzcweTBXMkZsUDZoMjJFOUhEQmQwdUNHMlFocUc1TnFnUzVv?=
 =?utf-8?B?TkVPVkkwc1E1alJCWXB6QVEyaXF6ZERnYU83Z0tzQ2VtWUxzWkFXM0p1aSty?=
 =?utf-8?B?TGZhc3VvdWlCM3EyM0lEdGRzSmtpME5rTFFUSkUrZ1o1aUh5dTVxUDMrWTZ1?=
 =?utf-8?B?bWtpL2luQTl2Ui9Nc3BScjlobnRmMFh3MDI2cGw2Y0x5bkdVMHl2ai9KUmx3?=
 =?utf-8?B?Z0xpazRLa0krejFpMVVvNTJoK2poNXQrbzFNM3ZwSVhDelJlZkJqOFpYTkxG?=
 =?utf-8?B?dGRJdjVmRHpHb0d6ekU4c3hnbkZpVXRRQUJHb3hhMnlVWVJiTDEwcEtiRHRM?=
 =?utf-8?B?SW9BOENmL0pwa0R5cWZjUnk2OEdlM0R5THVMTVNuVHRDM0d3LzJDSHVWQmw2?=
 =?utf-8?B?aXNUNGFybmZRZjc1VGVIVm9iTFJGMzdUSTNNVDlzYWVTaFFpcEdxMGZ6QW01?=
 =?utf-8?B?eHBCRTltd1N1VXdUVWlGWHFqd3ZqbHFyQXhXemlXeC9ZWGZ3OU9EcDdmRlR4?=
 =?utf-8?B?Z0pOaUlZdWo5N2VZaTNxNW4yOWVKbVVaWVNvbGJseEs5M09TNk5sODNMYTlN?=
 =?utf-8?B?V0RyY2l4L3RwQi9ZWTY0aHJGckpySjdYU0drblQ0eFNhTnp0dWNqL09BSk9V?=
 =?utf-8?B?cVJFRnpGd20zMkhTdXNlRUlQNUFKRm9Wb1laRFBJVUMvTURqdWhVVW1kdFJZ?=
 =?utf-8?B?QXBJaUpYc2xZN1JWemV6OXBqUzZkY2MweFBObXU1ai9UYk4rb0NiRVRZTzh3?=
 =?utf-8?B?SlZqa1NEaUR4L0xFTlluVzIrK0dnNUpFc0pIQTVWK1FNOVErSFB6cmZ2NHFM?=
 =?utf-8?B?NXpHV1pHVHhUcEt5SXR4L25NSFhoQUJZbzRmMFVIMTYxWGpQcGVQc2ZvZnlX?=
 =?utf-8?B?TUdvMmpET1RPakVRbWg1c3cxSkYzU3ZQd0twaS93bGxQS0ZEdFNmZ2FmNzYx?=
 =?utf-8?B?aDVvajEzajRHWGt5aHlyNnJzekdqREJnR2xTY2ZvMml4TDhjNWVaZ2YrOTF1?=
 =?utf-8?B?eG5vTng0MXY4V2pNbnVoUWoyTGNFaFd4UFRKYW1xY1REQWVpMHlwWng4M2ha?=
 =?utf-8?B?ek5tN2tYeGhWMVVmSUhtRkVqcE1LKzZ2bWpZeWY0M1JkUnpxNWIvVmJzajJp?=
 =?utf-8?B?Nklaak1SaWNKeVlyaHRTRWYwUUxPWHljVGxoUEFkWkkvVGFSZHFGNHkrM2No?=
 =?utf-8?B?WTROM3ZWUU5ML1pEQ2JMRXZnQXM0REtsUVkrNHdsRW5RR3hRWXdoemZFUjZh?=
 =?utf-8?Q?XQaz8XMjwyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzA3Y3pXNlpGY0FBQlBvRjlVK2hvd2ZRWld1dlNtMjF2aUN1R2lTeVQwZGxt?=
 =?utf-8?B?OWluL2NZQi9nMUx6K1ZtblhJZVNrK3V1NUgyeUk2UnhDaFlwOGRtZnl0L25H?=
 =?utf-8?B?aEZJSEhlRmpFaTdicUx5aDNPNEw1L2Q1UUFrU25neVVlVllETEw3djZwNUwz?=
 =?utf-8?B?ei9EREkrQWI0dENXeUtxZFN6TWhJZUc4TkFZbkJTVDlKMzZNaUFYUFN3SkYr?=
 =?utf-8?B?S0hBbDJiTW5Ecng1TzdTYVNOdW93NE9Yajk3UWkwYlZtRGxPMml2NDlGY01t?=
 =?utf-8?B?UXdPMnRWTHJQUU9qUVdjWFVHSEdmZ0s1dzd1VVJNVUpiK3FkVGhYSnhORzdn?=
 =?utf-8?B?U081SWZYNGlvMndRWFFrbVJydU5YOXdKclRGS3FCOFRYWU0waHJqamFvMHRq?=
 =?utf-8?B?anpPK3BsbDI3ZjZLaHV2bFJ3WDZmY3ROamQ1djByZExpZlZRbnJVNjlTcTY3?=
 =?utf-8?B?RU4yclhSOUpyN0MvVEx0WUhRVHhzenVETWkreXBZVzVMY3hEQXZmV2J3N0U2?=
 =?utf-8?B?ZWVSb0xWSm1QQXIvOHFNVXdlQjY5eFFId1Zsa0trd016dnpkS0Y0OERGL1dm?=
 =?utf-8?B?aVA0WEdUd0NWd1dLUk5HU2F0cGFmR1B5T3JpMDdVK1o0d00vQTFWZjV2bjFW?=
 =?utf-8?B?L0IxS2pZeDhvaG53OU5rR3pyWnowWm5iRGlkczkrMjNsVkxDZEs3amFuaDUr?=
 =?utf-8?B?S3RoeDg2UHcwUVRuVVBkRjB1dGFyeVFHUXpmdklBZUZHY0RMQTVHRnp2VHNk?=
 =?utf-8?B?S1VOVEhHVmJXVnBRdFFSVEV4NXgrMzlEOWdiRHdQTjd5OVk1bDNGdEk4aWV3?=
 =?utf-8?B?NXY2T3hrYnB5TTk5Q1NxSGtZNmI1MmgvWmRwaUZrR3d6WEthN0RMUVdaV2x0?=
 =?utf-8?B?WDdxQldkVzJLV3JaeGZTZFpXR01pWlRWZWFKZW9raUVEaG5meElMdXJEdTJx?=
 =?utf-8?B?VnRtWFBPaHoyRnpUSzcvck8zclQ4UCs2Vi9rYk5Ka1d3K0VNUHNRVk5oN0Rq?=
 =?utf-8?B?YXliQ2hpbExxMUVRTDQrQStHMkFNSndJYks1RGZlc0V6YkRMSW4wdFJBR211?=
 =?utf-8?B?d1h6RVVSZHdNVURDbzVwS1RBU1RVTzMzTk8raUVTYU5EZnZTZlBTaFIwR0ky?=
 =?utf-8?B?ak9RR01Da2VvUkZFWE12dm1mK0VKbUg2aURnaXJDQ0o1MXlwL1JqS1VJdnQx?=
 =?utf-8?B?bkszdkRzTllId3dpUktxdk45VCtQQVpDTXovSnBZbHQ2UU1DWS9pZWVVbXI5?=
 =?utf-8?B?d2J6SS9iTi84R1kvWWh5Mm1xVFNSWU56aEQybUY2Z0xJYVlZZ05yNGhieEdF?=
 =?utf-8?B?UnBzV1dVUGlmNGxGQi9MTmNkWERxTzlUenB4aThNbldnVWlmSWpuTEJyak0x?=
 =?utf-8?B?ZG1NWXNXWXh0aVFjU21wWStYZXFHbVRlaFJ6dGtXVDUzZUFFbktkMEtHRXBx?=
 =?utf-8?B?UVRvZ3lxbUkyQzFZdWZNZCtXNlp4RDViNFVvQ2dCQVIxYms3aFZJejVwbVEw?=
 =?utf-8?B?M3J2N25BNjh1MEhRQ2d0RWhXbzU2UGF4cVhCUy9nTW5hbU1uZ1dJVXBSNVh1?=
 =?utf-8?B?TUhEY0hIUGg1Y0plamVEZ280cldMQTFVOEpmSXd1NWk5QUk3RDVlWEQvTk54?=
 =?utf-8?B?djZJc3Q2NW5henNkUm9kOXZFVzkreEtRYWxvaHR4M2lwZTNJREQrSytydzRW?=
 =?utf-8?B?ak1qZnVWU0VTRGIzR1VXQlhVNVU2Vmo3R2JNYUo5QllIcnJvUUFVVUxobmJF?=
 =?utf-8?B?UGpKbEEyZWlxUjdMckVCU0ZsZVh3YUI2RTNaNHhsYUhjQ055MTNCMUZqZGxC?=
 =?utf-8?B?a2dkOE52S1R2MHk3RkZsNFVzd0dYRy9QS21INVFZUjNhcmVIa1Y2WjcxZnhE?=
 =?utf-8?B?YXRWWmZBQ09GeStuS0tZcW5Pc0VmemNuNFBEWG40bTJQNkRtYm1ONUFBWGtD?=
 =?utf-8?B?VDRXeEEvbUdWalNWOEdrK3FxVitwL2R4MGtleGpUTUo1eWhUMFFoeXRIWU5o?=
 =?utf-8?B?UExjeXg3Vi9UN081NmxRdUE5TnFzZHhURm1JNFlDVHplaWFiWnZyLzI0VXZy?=
 =?utf-8?B?SitZOTltaFVYR0NzZHFZYnhvSTVSbGZ3Y2s5U1RGRUVuNEpXK3EyVVR4dDNV?=
 =?utf-8?Q?AYilFnyrEUDQ1rI0CftmFFtSK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d74f41-c7aa-49f5-de8d-08dd75da1ef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:43:04.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAqd8GxHd0FbgOmmLbdyPysXRirGz68aTdyRhV94BIS2kIaHYfpuykvIRTR3N9O8OkWDSpM+54nxaRGaO+/0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300



On 3/28/2025 12:01 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt details with CXL driver. The notification is required for
>> the CXL drivers to then handle CXL RAS errors.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work. The cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement the registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
>> now. The CXL specific handling will be added in future patch.
> This part of the message is no longer valid.

Yes, I'll remove that.

>> Introduce 'struct cxl_prot_err_info'. This structure caches CXL error
>                     cxl_prot_error_info
>
>> details used in completing error handling. This avoid duplicating some
>> function calls and allows the error to be treated generically when
>> possible.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c | 54 +++++++++++++++++++++++++++++++++++++++++-
>>  drivers/cxl/cxlpci.h   |  3 +++
>>  drivers/pci/pcie/aer.c | 39 ++++++++++++++++++++++++++++++
>>  include/linux/aer.h    | 37 +++++++++++++++++++++++++++++
>>  4 files changed, 132 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 485a831695c7..ecb60a5962de 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/aer.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>> +#include <cxlpci.h>
>>  #include "trace.h"
>>  
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> @@ -107,13 +108,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>> +			     struct cxl_prot_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	if (!pdev || !err_info) {
>> +		pr_warn_once("Error: parameter is NULL");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
>> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +		return -ENODEV;
>> +	}
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	*err_info = (struct cxl_prot_error_info){ 0 };
>> +	err_info->ras_base = cxlds->regs.ras;
>> +	err_info->severity = severity;
>> +	err_info->pdev = pdev;
>> +	err_info->dev = dev;
> How are pdev and dev guaranteed to be valid after the put_device() and
> pci_dev_put() free functions are called on return?
>
>> +
>> +	return 0;
>> +}
>> +
>> +struct work_struct cxl_prot_err_work;
> Why is this not declared with DECLARE_WORK()?
>
> Without that I don't know what cancel_work_sync() will do with this in the
> !CONFIG_PCIEAER_CXL case.
>
> Ah... ok looks like that comes in 5/16.  :-/
>
> I got side tracked looking at the rest of the series after I found this
> change in 5/16.
>
> I'll send these questions out but I'm thinking Bjorn is correct that
> passing cxlds or something might work better than stashing pdev/dev.  But
> even then I'm not sure about the object lifetimes.
>
> Ira

The problem is cxlds only works for CXL EPs and doesn't scale for CXL Port devices.
Port devices are not associated with a cxlds.

We should consider adding a cached dereferenced status in 'struct err_info' as well. This was something I wanted to bring up  in the cover sheet for discussion.

Terry
>> +
>>  int cxl_ras_init(void)
>>  {
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	int rc;
>> +
>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	if (rc) {
>> +		pr_err("Failed to register CPER kfifo with AER driver");
>> +		return rc;
>> +	}
>> +
>> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work, cxl_create_prot_err_info);
>> +	if (rc) {
>> +		pr_err("Failed to register kfifo with AER driver");
>> +		return rc;
>> +	}
>> +
>> +	return rc;
>>  }
>>  
>>  void cxl_ras_exit(void)
>>  {
>>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_prot_err_work();
>> +	cancel_work_sync(&cxl_prot_err_work);
>>  }
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..92d72c0423ab 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>  #define __CXL_PCI_H__
>>  #include <linux/pci.h>
>>  #include "cxl.h"
>> +#include "linux/aer.h"
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> @@ -135,4 +136,6 @@ void read_cdat_data(struct cxl_port *port);
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>> +			     struct cxl_prot_error_info *err_info);
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 83f2069f111e..46123b70f496 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -110,6 +110,16 @@ struct aer_stats {
>>  static int pcie_aer_disable;
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +#define CXL_ERROR_SOURCES_MAX          128
>> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
>> +struct work_struct *cxl_prot_err_work;
>> +static int (*cxl_create_prot_err_info)(struct pci_dev*, int severity,
>> +				       struct cxl_prot_error_info*);
>> +#endif
>> +
>>  void pci_no_aer(void)
>>  {
>>  	pcie_aer_disable = 1;
>> @@ -1577,6 +1587,35 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>  }
>>  
>> +
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +int cxl_register_prot_err_work(struct work_struct *work,
>> +			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
>> +								struct cxl_prot_error_info*))
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = work;
>> +	cxl_create_prot_err_info = _cxl_create_prot_err_info;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
>> +
>> +int cxl_unregister_prot_err_work(void)
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = NULL;
>> +	cxl_create_prot_err_info = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
>> +
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
>> +{
>> +	return kfifo_get(&cxl_prot_err_fifo, wd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
>> +#endif
>> +
>>  static struct pcie_port_service_driver aerdriver = {
>>  	.name		= "aer",
>>  	.port_type	= PCIE_ANY_PORT,
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 947b63091902..761d6f5cd792 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>  
>>  #define AER_NONFATAL			0
>>  #define AER_FATAL			1
>> @@ -45,6 +46,24 @@ struct aer_capability_regs {
>>  	u16 uncor_err_source;
>>  };
>>  
>> +/**
>> + * struct cxl_prot_err_info - Error information used in CXL error handling
>> + * @pdev: PCI device with CXL error
>> + * @dev: CXL device with error. From CXL topology using ACPI/platform discovery
>> + * @ras_base: Mapped address of CXL RAS registers
>> + * @severity: CXL AER/RAS severity: AER_CORRECTABLE, AER_FATAL, AER_NONFATAL
>> + */
>> +struct cxl_prot_error_info {
>> +	struct pci_dev *pdev;
>> +	struct device *dev;
>> +	void __iomem *ras_base;
>> +	int severity;
>> +};
>> +
>> +struct cxl_prot_err_work_data {
>> +	struct cxl_prot_error_info err_info;
>> +};
>> +
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>> @@ -56,6 +75,24 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +int cxl_register_prot_err_work(struct work_struct *work,
>> +			       int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
>> +								 struct cxl_prot_error_info*));
>> +int cxl_unregister_prot_err_work(void);
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
>> +#else
>> +static inline int
>> +cxl_register_prot_err_work(struct work_struct *work,
>> +			   int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
>> +							     struct cxl_prot_error_info*))
>> +{
>> +	return 0;
>> +}
>> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
>> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);
>> -- 
>> 2.34.1
>>
>


