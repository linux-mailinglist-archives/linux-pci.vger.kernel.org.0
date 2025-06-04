Return-Path: <linux-pci+bounces-28981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF94ACE08A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 16:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC8161917
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E06529188F;
	Wed,  4 Jun 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DMZBH/W6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A6290BD2;
	Wed,  4 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047833; cv=fail; b=bZ4EtG44LhEi/Vv3hse4p4Qh3pyCzMWtFW8bivsOyLu+0f6n3MyuWcfQ3MqioqF92aJqBIGvp9BeoKU3uHi5qw2gQ+2oGj0VkQC64HTX0CLL/zGqOFTeDx1vwVRocfC660T6D6HSNSAXnicD5X/eOMAuJAFvQ2CYQWBonlFCfes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047833; c=relaxed/simple;
	bh=lvuaOO+iZH6WOvQiP1yG4LCKLhiuRbEh/clo+PYTBB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LcbR0doDiQiYmWZBjd/qOCJGWAE6AlF+5Hmo7n0u7H3VNKtxxBkNTRk0/KoKlZbUguINv/JmVkVAsrjvApKNk78HQsZak+RWScPhqAbC8P9I6VZT53IJO4Sc3ltC0FyRo8trIUuxpmuYDVS+U3V+N1hs6nFP+BX+/aq+a2TwECw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DMZBH/W6; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKMcuEZoATaYd+RgPLkeN03N4QgVOZHtFixGKwBNG2sr7rKwn+TjwYDwFJvVbEDU9CDVlsVUJfaukpeOB3hY0Yvy9kTyHQ4BUlRLflKGUFfnqHpf5uNOKk//7iGoKCfG+qXymPOQKFR9UAdFwG54AAOuKVq3c/2kDORH4YA00ObWHQL/k3z7MMnpXP+WeoGxSLQxlq1GBtM9Imi6NhcJlDH5TFva4ovWe1Xj+LjiRiVeD7dY7k7n6lbNiYa393y5BNL0mK5op21ofR5M44mE+SkG1Q6j2SI/RDWI1L20wQOs1LI8vpm7PqQ6WQjDRA8rMN4Jwbhq1Q8mCenjJCvUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvQGJvvrAPvz5NfioA5Y3YU5JcnB1ZdRKXBAW5zqQKQ=;
 b=fCfCJo22mmb34AXw8NldjqliCNrJu+RkJ8dKZXXzPSdltUBpTuDYAwJDVeP3tM+MWb9gG9hxbLnyqhDtxVCyZ31XFpl7s2WSFrYec57Nsb3AuyS+GQZ7Rw1wSOVL0A6smuLg+s8s9SFN3PKG68iac1HXGSv1Kb73xfJR8uMGxBhJVX6db5amfGxBHNdjw5+2VFYvDGS9CNwA/GahzXWWbVubJ0xNJxdjSATVFebFqf14BKTLatPd/5V8J4tGnH6M3bN/Z4cRXpk+QqaDAIOY8qSrWZPLETXdeGPRadHNVbQubr2t7wW47iYKwMiTHYGBusd7HdasVGy7kMswxVTdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvQGJvvrAPvz5NfioA5Y3YU5JcnB1ZdRKXBAW5zqQKQ=;
 b=DMZBH/W6rpxVn1OjhKfAj+0YoaKrlgKmu51vRLyJEkUOFpXXGZQqEUnbjm6w+VAKohaQzAfzuShEMaIxiJCXvuNgsL2qGXl5PO6jgTKycp4H8Ri9f15ceRzP6PfXLJfnBkvyfqRKbl8+L5yu1xVi7ikXimEacMC0JHpsq7Q2iU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Wed, 4 Jun 2025 14:37:09 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:37:09 +0000
Message-ID: <1f719cfd-2c2b-4431-a370-290a865b0bf2@amd.com>
Date: Wed, 4 Jun 2025 09:37:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
 <aD_hQ7sKu-s7Yxiq@stanley.mountain>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aD_hQ7sKu-s7Yxiq@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0016.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: ff06af53-350b-410b-76eb-08dda3754907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEtwWFRrdFllTGp0TFFydnEvYmhrRWtZeE44eDhwQzUwK3BKSFc1VHgwdWY0?=
 =?utf-8?B?U2NzWE1mL1ZHZXJzVGFGNmcvVFJaSVlnMHVJWk5LYVBwbEIrblZ0OFdwRHZi?=
 =?utf-8?B?NGRvVEhkMVA3TFVPQ2l0TW5sdUo1MUZHTHhUOWVtNUZtUzUzSWdYS0JuSnBw?=
 =?utf-8?B?cUZqUmFSYm01cXJsM0JxRGFjRmtjcWdSenc4WHpzdld2Z2x1RGNjdytrd2N3?=
 =?utf-8?B?Y1Z4NDhDNld6NkovV0VDbVBIUlAyd2dOZEFUSnlJMHNIZW5mUWpoVjFqeW1K?=
 =?utf-8?B?YjNvaTBOclg1TnVjTzUzTkovNTBkWGtVUnVDbDcvOHlnSzJpM1N0WWY3QWMy?=
 =?utf-8?B?YitSR2prZU9DeVpyMndvb2EzTjl0RUt6cUc5dktOY011N2ZrcW40c3JrKzQ3?=
 =?utf-8?B?T0hrYm10SG9wa21haUJyaDBRZm90ZktMTDcrOVkrNHVIL3ozWEEzeW1yNGRz?=
 =?utf-8?B?bFlZbXFZMGlLM0Jhc1pGekxoYXhzSkZvWFpjVXdCYjdIdmhubjlJSTkxTnRs?=
 =?utf-8?B?YXNKMGgxVGlNelRuYmhIVWdHRWhSNGF5TDc5QkRWKzR6dEJRT0dWRXRKRmR6?=
 =?utf-8?B?b1JWSTVnZ1ZOZjhkTDhLbFZNRE1vZWQvUndFZTI5RDFhMXQxZk1BejVMUGFw?=
 =?utf-8?B?RE9WbktrSEdmVUx2VlFPS0locTkwbXY1MUQzQ1kwRFRrRUpVb0QrWGw3VWZE?=
 =?utf-8?B?SFJWOXB1Ungya0V1NUJoZ0xpTzhlZ3dwdEltTGNEaTNhS2FIaE1SVDdxYmlL?=
 =?utf-8?B?WU9HOTFXT1g5Sm8xK3ByYVBIUzFuMjA2WEY1bEs2d0lvV0E5bHUzMXVwUFBH?=
 =?utf-8?B?by9oMHhIN05IZlFxTnF3YkJuYmszOElQVHVSbjdPeGxxVUE4WnUwU3dEbEJL?=
 =?utf-8?B?NmdHQ0o0Y3FrNnlrZCswRlUzdS9LY0s3c01NSks5a2RUemdmbTFJVlJ1NnRx?=
 =?utf-8?B?eTVQTVlCOXhlRWlCTSt2NXlJRmxCZDc0UGYzdC9xaWF2SzVrOW1aK3JvNHMy?=
 =?utf-8?B?d2tscFlsVy9BUEZIUmYwT1RPdG05Z1lZb2YyR0RibEpReFluTGIxSEhwTXpE?=
 =?utf-8?B?YlRpZnlQOERsNTd2Qy9YVGtjdXpNRVRhWDUrbFc4MDVQZGd1SWJ5MTZEOFMy?=
 =?utf-8?B?ODZKT2wrYklyZWwvT3FzYmU1V0NaVjFXZUtNL3AwWmtWZHJyUS9LNjg4K0Fr?=
 =?utf-8?B?ZlEyM0VSbWRoVlpzcTJBZTU4S1JlY0tISjBXc0hkZDBTQlZFV1AzWEgwaGZ1?=
 =?utf-8?B?aVFXaHkzYTFzZU1pSHR4ZDBUNU44eFYzYUN4QlR2MU9wNjhkbG9VbVBSY1dL?=
 =?utf-8?B?aEdMVkpLdWRZeWw2K1QzUVE0Q1dBKzVXb2k5MTVXYitZaXk4KzNVUFVja2ww?=
 =?utf-8?B?MFdFcm8vcGlDUDllUk10YjVRaE15azNjNDJkbjBpeUlRbm9JWW5relcwSlk3?=
 =?utf-8?B?L0hpeW9kK3Q2RytQU0U2blQ0YzhuUnAvcmdEanRTVHdUUHhCMlFPZW8ycDIw?=
 =?utf-8?B?cEN6MmhBaG9UUWczd3YwL3Z0cTdZRzhnWGVMR0ROcGNReW5QQ2RsakVuZTRh?=
 =?utf-8?B?YlFLZGtRVGNYOVNBNEl4VmxCYi9RUVkrbEpsRFQ1RnhndkdQTzRBa1lQL1Nr?=
 =?utf-8?B?WVAyRFgyVCtsYUsrVk1Wb1NoN2REWkQxdnI0YU9SbnlqdzhlVWFxTTBBdmx1?=
 =?utf-8?B?dEM2QWJjeG1nR1pBTTB4OXpNZHJ2WHY3OUxORk12ZUg0SXBoclQ0TElpQTly?=
 =?utf-8?B?RHluREVTTE5Qak5OSURLMTNsaUZFZEJzZUFrQUF2N0wvWXpoZC9SZm1Ja3V6?=
 =?utf-8?B?eWZsYmdKakg4aUpqei9RckdyeFB0NUdCVWRFSng3TlQwS0phM2ZzMFhNMkNL?=
 =?utf-8?B?cXNPaGRTektEcHByR1U2UGVaNTFkdHdSWHZvdm9maEdzSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRWQWtqdkZ1a1lnZlh6Zk41ZGNvQjloR1FOeGZ6VDRQTGg3QWlGMytRVmhm?=
 =?utf-8?B?UkxrRlR4cTc4OFR3WlZWcXAvakVoUWpFaFNwZFJ4TTk5c1puMWxiRzlqeEJx?=
 =?utf-8?B?MklIVjBGL1p2cFMvQnNTbmFCK1RrcEVleDlBVmJsaFE2MWcvcWdRMDAyc1FC?=
 =?utf-8?B?L0FGVWVLQ1ZLR2NyUmhoSmxRRXkzbXdpOGFFRVUvYldWQ0RnbXBFK3JsaFp1?=
 =?utf-8?B?ZngrTjg2dnVENTR2ampoOWwxb1VBdHhwQzkraURBTksreEd0elFjTDJReFhj?=
 =?utf-8?B?bFlodXF0U040TVNFblliaFBoU0QzbnRHakFnb3hSSnRMcGxNenlBcTd2MlFn?=
 =?utf-8?B?UDVJZ3czY1pCQ1E5VitpZFhFcFFOTElIUHNGUms4N3haRmovMEFLV0lRZEgy?=
 =?utf-8?B?clpyQ2ZwWk0wTmNGeThqd2V0aWcvUTM5N2JtaGFpK1B2YmNrcnQ5cTNIL29E?=
 =?utf-8?B?U25aV3Y3WmlsSlZSUi9QWmJVMzJGSkRPT3RjT1VDN0lhZTNpTlV2enk2U0k2?=
 =?utf-8?B?SHBJMHZZTFAzZVpHSHZKQXlJM2R2T0ZBRE8wSGJPSzlBVlZMQnZWYXhSSUk0?=
 =?utf-8?B?ejdQNDZIY0V1OXJ0SW5qYkFBcEdEQjRITC83Mk5BVDVHamJSQXlKUUxUSWMx?=
 =?utf-8?B?ejIvMC9YUjNkZUVsckppQjJodHJmMUNqdVhEOW80MmlKMnUwY2gvdGtnUElq?=
 =?utf-8?B?UTJLclZ1K242SWN4T3UybU5tNVJKZU9OWXpvL3M2a0NrY0o4Y3ZwcFZnZFNw?=
 =?utf-8?B?U0lsWFVXMjJPdHJDZE9aeDZ2eFRxd3FaWU1lTGpnRmlFUFdCc2xHUVBRUDR2?=
 =?utf-8?B?cHNKZlR4cFVRYWhpdlRiaHdmVXBTUTlmTkFhdHpVTzdIdnlBTkZ0bEQ4dGpz?=
 =?utf-8?B?MFkzU0UzUXU5Nlc5ZXh3K2R2NE1Ubjl1amlkNHIvcVFTOTFjS0xVd3F2QVlG?=
 =?utf-8?B?WmdkTk9QdG9icERZUFF6WjZnVVFGUFhYQVQ3bHBwT2V0dWd2eGowYzFxMStL?=
 =?utf-8?B?OGg5aHBIRzZwOVY2SG04QXB6NUgrYzV3WDh3Ky9TRlVlV25zS08vSkc2Mm5P?=
 =?utf-8?B?QTliMHRPblFjSDJhU3lkbmg1NWhnc3lVOHhYMDBEUUE1RDdUTEtMdHlxZ1E5?=
 =?utf-8?B?WjRMbGROZXdGclJZOVBqdnAxWWU5c2szNTM1T0lYL1lXUGt2d3hNb2FyTDdB?=
 =?utf-8?B?K0Y4NlZLTjAzZzR2b0xScWI0VW0zSS9PaGpnUVlZUjlWK21LeTBkQ1VhK05M?=
 =?utf-8?B?Ui9TRjFMM285Tko3YzFnZC9XdGlaTXpDK2xUaVFWSVFGWmFBN0VCMzJwUmNP?=
 =?utf-8?B?TG55aHM5QUdHemFHUjBacmZQYi9FRXB6ZkE2NnRGNEZLRHp2d1FwQkNPdVJN?=
 =?utf-8?B?QkJJS1J2TkpoM3JORUJhTURLS3k4cmY3VVdUMXBGWkpPdmZOY2E5SVI4dFhV?=
 =?utf-8?B?bHRvMG92NkJOODlvK2J1cTJpUDBNVUluNGxQd2FzUGJvdW5ZOFU0VkMwZjVS?=
 =?utf-8?B?S3lvZG5SM2ZoeitSaXJNdFNDWEVSWnlyNnlvUUQrbDFJdThQdnAvTkgwakRk?=
 =?utf-8?B?QXRTTk5ySm5uVGNIVzlaZVdyOStYRldsdGJLTmsxaXppN0RoYy9EY1RzSkh5?=
 =?utf-8?B?WFJjdVFVMU42VHY3WnN6Z01TTW5UdWg0bE9RbkpncW42enRnTzY2UUdRdG9X?=
 =?utf-8?B?djNZSlVqL000RzB1M2FnZTJCcExMS3VtZDN5eVRFd085TnYxWU5DcG8wci8w?=
 =?utf-8?B?OTFlVGk5ZnVtWXZaYzZiVTdYWlFMc2ptSUNTMVNrbGRFQUJPOVFMWGRvMlBK?=
 =?utf-8?B?aVBteTViNDhWRlJ3RXRmdGtmVDZlR3JPZUpQcE1mejg4UFJTL1VGaVhYWkNS?=
 =?utf-8?B?Z0FnYms0b3c5UnRjNTdLY0srT2Zqek9DR3VOK3pBUDhQWWdpVTBJQ2phM1Aw?=
 =?utf-8?B?YlpCM04wbVFyS0JuMEhQblJaOVlwcUlKL1M4ZUlqZ3U5R2RKQmpTNFFteEJa?=
 =?utf-8?B?SlVyOWppdEdlNHBZbk5Ga2lFTFVMNEhqRkpwSGpCTUgrSzBJYkxQazNsMThS?=
 =?utf-8?B?aGVEa1FINzVjQ3piYmtwQXZXa29sSGhnTXJVZDRRdGlHQXJOVjdpRmVyaUdj?=
 =?utf-8?Q?w2t7i7PeWU9J6ikypotaZZLTW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff06af53-350b-410b-76eb-08dda3754907
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:37:09.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebe9EQW4QqqbI9t1tjBOYIH817O1N3VzSI2SfsM288RR0McIzTzevnOB1gCzZnVd3nyrCELdA59EYMDV/Bt1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695



On 6/4/2025 1:01 AM, Dan Carpenter wrote:
> On Tue, Jun 03, 2025 at 12:22:26PM -0500, Terry Bowman wrote:
>> +static struct work_struct cxl_prot_err_work;
>> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
>> +
>>  int cxl_ras_init(void)
>>  {
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	int rc;
>> +
>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	if (rc)
>> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);
> This shouldn't return rc;?

This was implemented to allow for native CXL handling initialization even if
FW-first (CPER) initialization fails. This can be changed to return rc.

Thanks for reviewing dan Carpenter.

-Terry

>
>> +
>> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
>> +	if (rc) {
>> +		pr_err("Failed to register native AER kfifo (%x)", rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>>  }
> regards,
> dan carpenter
>


