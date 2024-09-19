Return-Path: <linux-pci+bounces-13297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A422597CC17
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2810D1F22935
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E812E78;
	Thu, 19 Sep 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B99ejIov"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAA33D8;
	Thu, 19 Sep 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762476; cv=fail; b=UsuJPhdQ9eJTV9dYBWNZlJvBB048Gx/gVZrasE8dAgwQMYqycL9sncgbLIk6dFK9QXjzDzGsOHl8O4U9I1kUSqGIcxBOU9q7cPMSKJ/zXu1nnXJngx4W6XDMz3m+FN+5EhH4MF97P55G0YV5ouDyl+6PIWdJ7THSbhYKTo/Rb5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762476; c=relaxed/simple;
	bh=Omub45R3gqex5b9IGUJn85eztT1YZc3lcinnwNWxEaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZ8b+/+kI5MEfeR07FmEiMAv7SldUNOP6Y2PZZAWISHaVgQk8s7OIwTpiAS2nYGNUC6bpvCCxnLiiwFosgimTy6UX25FDR9knOi7t/hjbsvFPHwpPoyQNqM/LVBIvTvvkPZuu7qUoDcYTUeddRnoD1o+4rszCGrUoEG/g4+0Eto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B99ejIov; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxw7ukFpb1qLQQ++6UDcqWZk/KEux9Q9wuS6SHy6IXdnMc3dBDnZRCKpKd1dZz/F9n+rNG73VF7WjveqV0m4veHKv2F2XZLo3r+PVLGrZFFooCAf6aYl3I6brD0cR7tSmw4hjAgFEEzqeYMti9wqhIt2pZ1cUPKv2Lg+CwSzz9iaTomaB4BJoVBTa0eYsRvwDXzoQa/ymvTurNXTiEI1QBBeLTbHSOQXbzxSyoF+gTIWVvy6WxGc1mivQNgq7hTpeoaw0BUlCvT1iCgZdLYjoxfeJGSGcwBvgph1DHQq2O88f/wblKLU4mwwQE4aTfX1aNtfGGnVY69cQjGt1J+FjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVS09dW0VWqDgTO5boOT+98MGNQh6FaVgUfiy0SnyU8=;
 b=b94zg6Wr5jA70E9/ubB7UxvEHmUEAXxbXl9Oa51skbGu7ooPR/DoksWFS5r5lfeNR1/yHKoOCPRfFblTtoL51ba7MVFKfiD1xZDBPsB95aqJ4OOgqY0hURD88+vR1ygiy6AxOBPjajLx0JxTF7o1F2yAU/zkopSvLfByUfaxVhLomrPen6mAs0Cl+YSda34TXp/2lN7xYX4351FRfaJFo+veV0XrZwXXvJvclmeqtq7ywmYENMDjo7rQvlZnhG2CWLfu7f1rMzrwetxn+3Kx7cS/gUcFx7TlP0iJZtLb+Sqpa1ENimzNyCzlJ4JdQ9Q/gTg/rqWbusz/PjkDU7BKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVS09dW0VWqDgTO5boOT+98MGNQh6FaVgUfiy0SnyU8=;
 b=B99ejIovdZSPGXShFzeTMuboEfM5txtmcauia35rohtEka8Gqu7mqrp9wwskr2PuE5QG1ujNXebnMPE5m7pGe3LdwurlYEJXBoiSZ/Q1SVLSiqw3ek+aJ2Twc9FGSIvMy4OYsKAcxhaWU3ALL6S5DP78MwgiIZRvBdycs6Km33s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Thu, 19 Sep
 2024 16:14:30 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 16:14:30 +0000
Message-ID: <8eb46b36-df73-4dec-b9cb-1606bb927f89@amd.com>
Date: Thu, 19 Sep 2024 11:14:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-12-wei.huang2@amd.com>
 <c7b9cafc-4d9d-f443-12b5-bf3d7b178d2c@amd.com>
 <6fb7e2cf-e26d-4af5-84e4-2c56c184a1df@amd.com>
 <b02f2e6e-5ad2-2e7b-86a5-644f44ecdb6d@amd.com>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <b02f2e6e-5ad2-2e7b-86a5-644f44ecdb6d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: df2cfee9-3f15-47e9-fde2-08dcd8c62436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE4xMEFrYVVNRDF6QzR6TVduN2hYMkp5bzF6ajliNHZkNTZreW9uYnY3QWxw?=
 =?utf-8?B?QlQxOGN3QkZNb1EvNlVuQVhGQ2ZVc25kR29NZjNQN2lxS2FxUXE2a25PQVRH?=
 =?utf-8?B?bzJOdE5oZ0JQdGprM2tYcFIwdllkVDVsYzJ1WkczMDlCdk5HczhYYUVUT3pD?=
 =?utf-8?B?Vi82S2s5Y1IydVVZZzlyQ3F3Y0tQUnBwUmZ1TXdrYWY4Z1hOSmhQVFVUQUp3?=
 =?utf-8?B?TEhOMVlobWR6QnlyMEpvQlYrTDkxeDE3Y3ZrSEIzWk1PMzFmWTNVYWYzQ1hW?=
 =?utf-8?B?eWkwcG8rc3dsQ2U2QnZPOS83N2hySSt4SHNQcHVnaEdBbE9sSzRuazdneHZB?=
 =?utf-8?B?WW4wNjRlbkp5WGJwKzFLbnlmZzJYVjNUbFVHWE1jRXhyVVQzSGdSUTNKUVdN?=
 =?utf-8?B?alhUSnJuTzdKVGtyUjQ4YmExZWlVbE94N2p6bGRYRVFoTU85bmtTU2cyd0VM?=
 =?utf-8?B?OFZmTnEycXNjM1VsRlhwWExqQnFxVjVoQWdraFJTdzJuNDI0MkxlVWJBa3g1?=
 =?utf-8?B?SjRVL0Y3MEFaVDYxb2dsLzhHd1k1RVdtUE4wTnF3WHhNcGtlZHJ1eFBveG9z?=
 =?utf-8?B?YkM2ak5EaGs4amhMYUtUTkdOWENydWlkcC9XemJPKzBYWXR6aXdlTGFSVCts?=
 =?utf-8?B?L0tsdjg5cVkzeFE5eWw0SHZKK1FLSEw3Wk5nem1ZMjFBYmI2ellUQlpLRmpv?=
 =?utf-8?B?ZkxTSWZQVnJDaGVuZ25vWXZiWWVhbzl4UTQvR0gxOHMyL0h5MHFwcnRIM2gz?=
 =?utf-8?B?dlFZNllMeTJkL2VXT1NxU1hWZGs4VkdNTTBRZDYydk1lNk4yQWFPamN4cE84?=
 =?utf-8?B?MHlLNDlZVnQyWk0zblZMSEZabGQyNWRQTnBaSi80ZUdjM3RXdmQ2VzJMd0JT?=
 =?utf-8?B?VXE4L2htNVB6UTZrNFFVSjBJR2NiSGorYzAvd0xFbVJaUGdBUFhKTi9TUjdR?=
 =?utf-8?B?RnlLN202U2hCK1I5TGl0K2UxUkljVFlRNWJBS2J2OGFEUUhmWnZaQWtsdzJ5?=
 =?utf-8?B?ZGE4SlRmMDgwYUtOWXJaaWZYNXRORytqd1JvY3NKaVFEZ1FaWlAzZjVWd0NN?=
 =?utf-8?B?cWtpVFlrZGE1UkdJR3QvUW9ab0g5VnZqK0hYakpNMitiVng3K2RveGhMV3VW?=
 =?utf-8?B?WGc1anJoNVQ0VnovLzVUT3pNMlc0UFpJWXZkbS9nQ3B0ZHltOWtweVpROHdn?=
 =?utf-8?B?dHFnUGFFL2s0Y1h0b00zRmw4eDJrN1loOFNQNzRXaEhKY0ZTKzB1TTNpbEtI?=
 =?utf-8?B?UEtSK01CVmpYTmhrZEo1VGlHNUZkYytGVmg0UjFPNzJaZm9PY3lucGt3eGho?=
 =?utf-8?B?RXNuRm40WUdyUVUvK0dzMXZ1VS92RnNWaUx6bVNiazZMb3diMk5OR1VMNjJl?=
 =?utf-8?B?TEhTK1ZRVUt0VDU4UDJhdjZYcjluanl3cTR3cERwV2FkVStYK090ckRTR0p1?=
 =?utf-8?B?eUVNVWs0ZVlZTHJRU0tmM3lIN3FTOUFjdm5NTktmM3NsWklEdy8waE1USVlN?=
 =?utf-8?B?bjE2RVBvWW0vZitvLy9xdUZZZTVPSXVvWU0rT3VNbWtmelNsZzkzL3A0YXJ4?=
 =?utf-8?B?MFAzVTlzWGI3ck5xVzAwWlJ4c3U4ZXpRLzg5Q1hETjZ0cHU0bnJybTlLbjJx?=
 =?utf-8?B?VUlVczFabTRGRTJZdXpBbFh0WGNLeml3VjBXanVUQ1RiQXdwN0R2ZHBxY0V5?=
 =?utf-8?B?NDBkVTNrK3hEWjBFL2JUVEcwSFRrZG5PWFcxRW5RUUY3RkdGZmNMQ0Q2ZHNz?=
 =?utf-8?B?K0ZaS09uSzZmNU81d3pYcERTQVZDemh0eDBjcVcySldsQkx2aDdBUzJJRm50?=
 =?utf-8?B?bG5rZmZzdWQ3NkMrU2l1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEdWNGZVbzBLTlc3VEluTmxHeDQxOGNQV3RzNm5UR3RHc1JLek1sL3hYaXRp?=
 =?utf-8?B?aS9WclFOTXpmMCtnSFBWdjA4OGtRa3lxVnlsMXBhSmlPbnVGRlJGU1M3Mmx6?=
 =?utf-8?B?aVpOa0dZVEhpT3QwNVFscm95Yk5CdzR0aVQ5V24zRkxNbGp3VkoyNEZ0WkNV?=
 =?utf-8?B?eHZGQWlzdVE1QjhYZFVKS0tlVUowMmZ0Wms2RitIeVdiUWQrZ0VwWnNJdXlJ?=
 =?utf-8?B?d1RwZHh5QkJWMVYydm9ldk9ST2FJaUFLYWcyRmV6bUxJTTRoT0tLWlFTc2Y1?=
 =?utf-8?B?QTh4QUlTRUphdFdjRGV2dm1iNFYyRm9XM2ZxaEJwV2lmWVBjaVVJZlNpbjhW?=
 =?utf-8?B?YW9iSlhraUVsMFhGdXE3RlBJMGxoZTk0Vml3VytiOXVzengxV0JsdmVCMy83?=
 =?utf-8?B?RnBpcUhvbGVxTGFXVVlsWFhIVVNLU2E4aVNFVEFnNEdnN2x0anBJckNibkxX?=
 =?utf-8?B?SFZkUWUvL2ZZSzA1cVVrWWthOXY0ZmRjL3BkaUtiQ0xmZmVUaWdyc1hyR2xl?=
 =?utf-8?B?bC9qb1hZZXpXRmp3L2ZMWEJlSTlraFpWK0YvYnZBei95UFpncWlLQ0Z5bE9E?=
 =?utf-8?B?aHZJc2haeXlCVy80TFJ5OEg0TzJScWI1WHhnM3lnV0tjTmRSaG14VjBQRUl0?=
 =?utf-8?B?alhlQnJhWE95Vmc4SlZCazVlcTJtTlkvMW5ORmR2d3BoRnVVcGhpSGtqdTNU?=
 =?utf-8?B?Mzc3UTdXTkZMWHdRcDBJOFpld0t2UUNXOG45bWZJTjA1bjJrS3FMRXBJZXNF?=
 =?utf-8?B?dndwdE5pUVRhcXJSc1lGRGowZy93ckdscE4yZ2VnbS9RdjNSR0R4UUE4UGU0?=
 =?utf-8?B?UnZoWVF6c0h6ZE44WHRleUN4ZVBvcFVTUkFyM2dEVGhYa2N1d0V3YTduVHRq?=
 =?utf-8?B?WmNtK1dBRHZackNaZG5kTC9DZ1RWRktYRzBNN0JSOGdlTmRaRHRpVFBmSXcz?=
 =?utf-8?B?a2EzWDBqUVJ5ak04bStxVXZ6cTJ1YmllNUhtVGFhc0dXem9FT2lQTEMvR3Ix?=
 =?utf-8?B?Mk1GQWxRaGdPRUJIM3FtR0hUa1FNRkV0Q0pYZDBidlhYZWJBNzRHUmYrRVU0?=
 =?utf-8?B?UitEay9kc0gxZWtQQTVTVXFzUzlTVFEvRGdRUVdrYjA5VXJUNno0aTJGTS9T?=
 =?utf-8?B?RThXQnBmcERQdEdIa1drWnRiQ0hoOTdZRUdwWG9zZEswZElxMEY5U1pnd21n?=
 =?utf-8?B?cUVycmdrYWtwdUhkb2thZk9XV1N2Tkpxa1ladldsVCs4T09ISGVYOUNBYkpG?=
 =?utf-8?B?LzVSMW1VVVVsVDhiS0E1YXNjdkZLQkwxcU4zSElrUHh6UzJlTXhQZzB3SjNC?=
 =?utf-8?B?YjdWeENEcHl6U2RqWDNpejFaNVBCZHlPZ1l2eXhkNGlIU2Q1dllLMkdUTWg2?=
 =?utf-8?B?R2kyS0pIMTl3OEgxUk15QUE2dzFYSkVJY2tEVUJKZlRvYTN2MnNNWE4vRzNk?=
 =?utf-8?B?dVhxZzFxSWovL0RVbWkrZDJPN0kwaUpjSVE3WlpOTDdIbXpBK2VQTTVKd0xR?=
 =?utf-8?B?TEhDVCtCdUdYVVB6Ti9Td2s3aXlPT2J5eU9sN092ZkxkOXFuNnl4U1NZOWp2?=
 =?utf-8?B?RzZ3VExqYW5OcHBxWU5JTkxPMC83VDlWQVFFT0VTdHJ5SzFaUmtSR0VwempH?=
 =?utf-8?B?QXhVL0gyQTBrTVVrYlptQTVNSWJUK29zc2R6R3JSZWRwaHo5TEhoVnUvaGdv?=
 =?utf-8?B?dnk1REM4VWxQTEJHYnBNNjBHaGVIS3FPanRibXRXSEJMRUVWQnBXWDFDV00w?=
 =?utf-8?B?dWFGTnB1QmNXeTV6TEJDY3EveG0wbThPM2Nwa0FkOGNHRUc1NHFWaTF0NWYz?=
 =?utf-8?B?b0UxaTlKbXdERVFrdlRuQUxUblVtSWljS05QaXlVWHBYcGpoOUx5eko0NENm?=
 =?utf-8?B?Z2dlMnNIcFh4KzZSMzAzcG9ZT1ZDMEJna1c3blJKaFBZdmoyT0ZwcHM2cUJ1?=
 =?utf-8?B?ZHcvOU5oVTB6dEtvTHhxTkxjZmxRWHpuQ2Y0YjhCMzhtRzNrakJLTmIzSThD?=
 =?utf-8?B?d1dWMzUyMUtkbStNOWMxUHpOR1JyQWJzY3B3ZE1ZbDdscDVxakM0Ry9kY2xi?=
 =?utf-8?B?N2lvSEdSOEY2UnVXK0d0NERKRDZuT2U4QTJ6VzErZUJFTkZHdU1MSVBmN001?=
 =?utf-8?Q?ZgHc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2cfee9-3f15-47e9-fde2-08dcd8c62436
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:14:30.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfIaBxulyFK5XejQpW3onm9ZvdUHWMI5jCa1gb1HcBbEpQRxZdE0LXCDEvmo6Ra1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438



On 9/18/24 12:31, Alejandro Lucero Palau wrote:
> 
> On 9/16/24 19:55, Wei Huang wrote:
>>
>>
>> On 9/11/24 10:37 AM, Alejandro Lucero Palau wrote:
>>>
...
>>>
>>> I understand just one cpu from the mask has to be used, but I wonder if
>>> some check should be done for ensuring the mask is not mad.
>>>
>>> This is control path and the related queue is going to be restarted, so
>>> maybe a sanity check for ensuring all the cpus in the mask are from the
>>> same CCX complex?
>>
>> I don't think this is always true and we shouldn't warn when this
>> happens. There is only one ST can be supported, so the driver need to
>> make a good judgement on which ST to be used. But no matter what, ST
>> is just a hint - it shouldn't cause any correctness issues in HW, even
>> when it is not the optimal target CPU. So warning is unnecessary.
>>
> 
> 1) You can use a "mad" mask for avoiding a specific interrupt to disturb
> a specific execution is those cores not part of the mask. But I argue
> the ST hint should not be set then.
> 
> 
> 2) Someone, maybe an automatic script, could try to get the best
> performance possible, and a "mad" mask could preclude such outcome
> inadvertently.
> 

For this case, you can use the following command:

echo cpu_id > /proc/irq/nnn/smp_affinity_list

where nnn is the MSI IRQ number associated witht the device. This forces
IRQ to be associated with only one specific CPU.

> 
> I agree a warning could not be a good idea because 1, but I would say
> adding some way of traceability here could be interesting. A tracepoint
> or a new ST field for last hint set for that interrupt/queue.

We do have two pci_dbg() in tph.c. You can see the logs with proper
kernel print level. The logs show GET/SET ST values in what PCIe device,
which ST table, and at which index.

> 
> 
>>>
>>> That would be an iteration checking the tag is the same one for all of
>>> them. If not, at least a warning stating the tag/CCX/cpu used.
>>>

