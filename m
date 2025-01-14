Return-Path: <linux-pci+bounces-19732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787EA10A8D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCA17A3B3A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6E14AD38;
	Tue, 14 Jan 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPFcZjDE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DD14A4C1;
	Tue, 14 Jan 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867963; cv=fail; b=E7KG3+p/vm6Hso5QoiXBiZxn5hU3Gs4UwP04AY9VmS0BXqAsqleRPqjArVjIPmMsHlt5k+Q/i1g927n6lq/YHKjjjw3bxTlopS9Mdty9O2GMT5AY08ZsERBwVPDry22q+2yrrHOn1lxL7vMDUqGZypAjnVzjKc6m8IV4VADhdFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867963; c=relaxed/simple;
	bh=t1EWjZmxcSKF5TDVgRPBEbD10OjNgQZCrTUE59CxEEM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T0dPnM+dGJagVvroIaTlofb7FDOZn1sNUDWwhLBpwED1HeUVFUF/wQr4d7XBUUVqcOzuEnhthHvSKjlodl8jWIOrF49ASOOqw+Q1cfQ+B0h+EYGc3E2i89qiMjb0fgK0fVdkZA/hTZKSMDSX/3SFy+wWapDhenGyccIIwxkm8do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPFcZjDE; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2f/4rwARt4R0zJYMgwjexSYpa3wQiuoDgeaY7iupFLZ0yp/Qn7Dv77eI8Zo79PVwCNlcc4Gom7Bh6dmQDa3QdlzQQkt0RpNpLVKs9C5IrfQ+aR7z2DhbIclUp3x1H+Rca6pGIynmhttw4g17fSMaHqZN7/K53KNho+BARyFxmRCVqJUclYt2rc1XH9tjMimVCdtp3L1V9PtgC/YRimjU2Xj/4CYye9yGQS90SGEjDqPEum3XnStdSouuxzQLaFoZrK5P1pVZ6ao1knWaU7b7OctKSatZU6+Ng6DyVr9U61jxglE2J/trNZMTZMjcMVt+uGXRSex5oCDBjv/uAVsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVqBorSFBEiAv9/R1e4rzPArHJxRHBu5EkUvKDN5vjA=;
 b=Rn9OCUbPgF1ViEdu1H880iM48/rjaVFUEG5jvTDK7FaC+sjgxbTCi2GmsBm5B7bPxrNIiEDLaPcOfT9P/P4lPuDX8TE4ao8mX8i/YdICTFBj4IJ86Ha8acxJg/s9K0EnKxzToUDkgeui57l8kojh4Ac5tt3Iqs/ZRTaFmRDTON1ztaVb9CYizv2D6eZBFt4yvC/iZvFu3FyJz45dwhFpQqZGx+jq0LJFLcbOU7u5GHos8zUO0WFy6biaoTVi8a3S9EwsTE62eMkZcYW7Q27oNlToBs4SEBtsb/zR29zjt3J6+8qD9e2h32MALtHGIcFw2YXpwgAteJPK2KN/fd5S+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVqBorSFBEiAv9/R1e4rzPArHJxRHBu5EkUvKDN5vjA=;
 b=VPFcZjDE2xiEd733Bkks9uPc3vVGOnPusvFnwvvK/xPIKyy8Iv5823G32PIYMyaKgly7ySPztAkIHpw/i/r2eFTFMcsuNI300fGsB3ea5NpwBY6CuBvau2YM/oQ4QWcmhVuUetfajrQTDVNOb4V2HAIYQlybi/+SvJnI7oGXzUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 15:19:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 15:19:16 +0000
Message-ID: <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>
Date: Tue, 14 Jan 2025 09:19:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-4-terry.bowman@amd.com>
 <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb82b1b-acb1-4bd6-33ad-08dd34aecf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enB6M1M1ZXo4U0pITjVaYWV2U2h4dTdBVlo0ZW9GNEM2cnh6bmUyMFgrTUdp?=
 =?utf-8?B?ZHpwOXBCVVZhTkR1cG80TVRRNDZCNGg0Q1l1QjJXZ1ZYcTdKTng0Rk9LNXZX?=
 =?utf-8?B?SG5oUnFKY1V4ZEhVaDBFZEVsQTI5MnFEajAwL29iTURSamhLWDlOMW55dVkr?=
 =?utf-8?B?WUhpMmFLdEE3WXF1dTNYaExFTnloTklaTVBnSUJPd1pWRW9RTTAwZkVCYU03?=
 =?utf-8?B?TEo3SnFUK3F2RUhkcEd5NE9JV2dVKzlnaUcwUkRELzFxeU9leU9FNHBqL3pY?=
 =?utf-8?B?RWFZOGhZejQ2Z05Vek1uUitnWVlmOGwxbHZLb0Q1OFhwT04rWmx0Y0hkcEZ2?=
 =?utf-8?B?VHdIb0dkSGhTdHdSdW0xdkZyTjRzSWFVVFN0UG44Q1BPZGVYOCtzQTg5L25O?=
 =?utf-8?B?RDFlbGUyZmlmdXlXZTJVVlhYTEUzWW5adTlQOG1Pa09GMGRXZ2drUVJ1dE1G?=
 =?utf-8?B?QzhUQWlac2lDbUc0UUgybDhxMVg4aHhKZTV4TU9RUE8rR2NYRDVyUHI3L3lU?=
 =?utf-8?B?QWtxTTNkY0JPclZPdDY5MVlIeWdaM2NBa0Vnam42bzZXNjlUaVV6KzQ4SVFQ?=
 =?utf-8?B?dytCRlFLSkpTdm5EeWVaeVVGMmNOMXEzWnY0NkxmeVdOT3VmakprMDhUOXpu?=
 =?utf-8?B?ekdHcDY4REN5aWoyUjNyUlRxN0lvSmlweFYwUXNXVW1DZ2lUQzNQamRtUFBq?=
 =?utf-8?B?ajZUT1VaRlpkYmtWNzJ6bW9pT3Y1U25QQ1BCa2laVnZPY0IrTk51MURqZEdT?=
 =?utf-8?B?NkZtRWVNejg4RWx1cE5BYzlWM2hxRUtma0Qvc3dvcGw1MDNVL3VtZDB0Zm9q?=
 =?utf-8?B?SWh5bUpoOXkvL081RlVnL0Y3TjdjYjI3UE43eHowU2hqWm54YWJPWmlERWVS?=
 =?utf-8?B?QU5VSEZNVDNmSDlnSzh3Ync0T1dlM3IrUThVOHQyOTRCNDRvL2NTOVJzUjdP?=
 =?utf-8?B?WjdvZE1NR1dvMzVTZUpSbmsvQXorcnB3UzdNKzVHNlRabXlFcVFjRXBLWklH?=
 =?utf-8?B?SExrdWVVbXNvWWFGSDhRTWlZYUJhL1p2N1BnYllIMGQzd0pJZEtJUTFNRGt6?=
 =?utf-8?B?YmFrWnpoajJnNXlhVmRXRVBSWjNEcTRhQ0pRTGxKMGM3WkMxWFFZWmV5Yzkw?=
 =?utf-8?B?Y08yNWNwWmUreVNHc0VNTHpTSnI4NXZMM3Fwa0FlOC9scWRwSUlySGdFQ2d0?=
 =?utf-8?B?dWRia3doaEJQc0JPNW8yeUxscjlyMlBMdTNtaW0rczVpTmxoQnN0SWsxc25R?=
 =?utf-8?B?T0ZhVXV6QjVXSXUrUkY0OWVTdHovWHdNOHNzbWI4TFc1TXBpOUtSblZuaDBD?=
 =?utf-8?B?T0Z4TjlUQW9Va0xZK3RTTDdPUEg3bS8ycDBPcWgrd1JnNVAwMXRhTk1pME1w?=
 =?utf-8?B?aktocXQ0MHVqRWZHUCs3S3oxM25OK2VyUWRkUEo0YndQd3dQTW9tM2JybUZD?=
 =?utf-8?B?UTlQc1VIUHJGVjRsNlVldW1aZmUwSGpJTzhWUlppU2FGclNjdWFncWJRMWEr?=
 =?utf-8?B?WHZLWUhVcVN4MmNZSUx4ZTMvbXlyd0laWjVYdFdOS0tZdlAxSkNocncyQklk?=
 =?utf-8?B?VEI3akZZUCtqY2lIRDEzdTgzQTZWZ1Z6U3BzWFBaZGxZOFdFZk9WemRYQldQ?=
 =?utf-8?B?V011c1VZNlVLbEtGN0FHaEd2b2xHakZmNmo0c3NyZ29FQWlSQkt4S0VBQ1Ju?=
 =?utf-8?B?UCtoanU1V1ZLY2dKYlozRmhMSU1vVEdyRGhyekN2eXNJUmdUWjF1d2VrdDd6?=
 =?utf-8?B?K3F2NEJpdDlBRXR2TndXeTJWMCtSK3pQTFZrU28raXI4cU43UGNIVjE5TjVE?=
 =?utf-8?B?dTZNQTFpWm8wRVplRUpxQnRQUU9EWmtXNW5LbWc5c3Y5a0g0djVnMVpSbjhW?=
 =?utf-8?B?NE50dmZxVkhJOEhjbHpzbWZpOEd6dWZkdHk2NzJqQ2YzRCtzQjdhQmNOQXhB?=
 =?utf-8?Q?gFT3EBx1glU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmFNVlhCZDMzbUlFZTVmODE2THZZYTd1YXQ2VTVYRTZ5NUd5dGU1NENaY0pl?=
 =?utf-8?B?RjRpK2ZtUmE5NDdOMzVOSFZmWXl0SzM2cnlFRG5JZy8vYWo4alhJV2VUc0lh?=
 =?utf-8?B?Y002Z0dWNUdaMUsvNnBkSFJ1WER3R2cyaW5kWWtxc3pJcDgvZG56OU1iSTU0?=
 =?utf-8?B?dHhaa1BOSW04bkhxTG5IcW42TzNZRVhaMkkvQ2h1Z3ZWa1ZFR2VmdnNqZE5X?=
 =?utf-8?B?OGMzVWFiR2d4QWgwR29OMDB5dktHejZ4VDlDU1AzVUd6Tm9TM0hvOUt3Yjh4?=
 =?utf-8?B?cTlJQ2h5elNzYmFyZHJGVVFVdG5vajVVZVYzN3ZaT2oxUXJQa2NmNktud0Mx?=
 =?utf-8?B?Smt3KzlsS3ZTQ0FmeW5lS2EvKzFCclRXcG1HYXI1c01md3E3eDJzdmEvUmpi?=
 =?utf-8?B?cm84K3BkZkJnT2E2cG9kWVlIZU9hSnJPdVlJZWNRRmgvd3lSa3ZIbHhIcjFB?=
 =?utf-8?B?M0xyOS9qU2w1VUlDVDJENDdNN1V4L0xqeXFONzFCYUhaK0hsTTZmYm9nc3Fv?=
 =?utf-8?B?cXlaTFh5ZVRRWFk0Tm1aNUoyZElVa3JUSGVxclFEVFgrRXVuR0pWeDh0K3JH?=
 =?utf-8?B?ZVRiMkg0eWwzSG9YY3Y3YXI0MkNKSkxuYk9KbWpUSkE5cDZSVXZpWWZUeFRz?=
 =?utf-8?B?eVVSYmFobEozdGV4YWRoTjdnU3hoOFVFcWpXejQ1WGc3T3BvQnhwbzVoMDBi?=
 =?utf-8?B?LzQwTVNJQURPMTY2amNpMnBnVDEza3Y3YlA1Zmg5VGtEd0pEUlJmUW5tNEh6?=
 =?utf-8?B?eW9Rdnc3bDZUSHVzdUZqREY0ZHpMUlVUbFhBMEQ3ajFSbktFYkw2SmtKZHl5?=
 =?utf-8?B?UE5lSmdGczNHcTZlZ2FiajFkbmw2WWlNYnRMRlRoWkgrdlFBOXJ2eWJNT0ZZ?=
 =?utf-8?B?Y1l2Qkwzam10LzRSRnkreG12bnNrSkxjdVBkM0h3a21LM2JxckhVcVplT3Zo?=
 =?utf-8?B?eUhJRVlqRW5FbHc1MngrbFdrVFpIbTNPcUI3eDhvVjA5N0RxNVhkb0JackRx?=
 =?utf-8?B?akN0RG1Wdjd6WCtaU2NPM2plM2tuM0hPR2VRL2RiMzhmWlBkVEFVcU83aG5I?=
 =?utf-8?B?L25oeFhhdnRidGtVSE1IUUlmYVdsREpZRkh1ZElpS1BVdEVHTVdjUzBrOERn?=
 =?utf-8?B?RWxSTUk0b0RucXNEUzR1NnA4QU9iWGY5bkkzQWVIalpKUnhqT1R6ZGtIL2Qr?=
 =?utf-8?B?c0VmTWplWmg5N0V1ZUh3NVZucWxpQVhoSE5ObVZwL2duSjRJeG5TZjlWa2s2?=
 =?utf-8?B?SUErMXNQVWtvNm4vTmNCaCtWQzBUc3RWcEpaNWJ6OUJBK2xUZW8zaGJmbTZk?=
 =?utf-8?B?SG56TU1GTFpoMC9XWmM5N1pDRE9UeXp0ZmoxWjZYSUpuTm40YjJTSUdZZ1pj?=
 =?utf-8?B?b2VTTHZhamZFbWtLcFF2ZDdjcmREc3RSdXNxTkFrSEp2TEZSaFVDRlFrZVJZ?=
 =?utf-8?B?dThxY29QUFA5bWNYNTV3azgzUUxBQ045UzRNbDJEamZtTHJLbXFTTXY2Mm9O?=
 =?utf-8?B?OWxseUhOSFkzQWV1dzZtNVp4OVkwOEtBd0JGcWs0QSs3T3hTb2JMMHhDWFhN?=
 =?utf-8?B?bUYxZVJGQ2hoMnFBRTdsVU5lRnFjU0Vyb01nWStvanpHdVhVam1pLytqUFhP?=
 =?utf-8?B?cTNqbDkrMXM3Qm4wWU5LaC84cW9lZ2xEVzVZOWxKOUVMdDNwemVmb0RwM3hw?=
 =?utf-8?B?c0VvVUw1dmtRK2Q0TjVhWk5yVmJhelFFYXVMVGJBNlRDTzNoV0trd2ovUVZa?=
 =?utf-8?B?c2x5dkdPbW83TjZUbXIxMWIyd1RVTlMzVnpsMEdIcndZSVhQYzhjM2pheGg0?=
 =?utf-8?B?Rzl1cDYrZlNMWGdBNjl6RDlmZE8xVkg5QzlZbi9ycWlJMnZHSXh5TGJJcVpR?=
 =?utf-8?B?enNCdTVEekdURmM5Ymg0REtreUVGUE5xZGNESTBvK0FzZEdmOHNlblozVUdE?=
 =?utf-8?B?UmZJMHlKSkhmTFJlUWxYdW5GVEJzWU5VUHByQWZObFlremU2OTFuOXVSN2cr?=
 =?utf-8?B?MHR4Z0VGMDdMMWhDSGh0V0syRzJQbHJMdWQ5R05FdFlqeG4rS1dzVjZRY3Fq?=
 =?utf-8?B?eTZPT24yVXF5Z3B0c3V0V2hPaUsyMlVYLzVaM0FyemNOVVlsUFg0TTB5UE1Q?=
 =?utf-8?Q?1pdF3YVD/nQNBOs5ly+gId4gl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb82b1b-acb1-4bd6-33ad-08dd34aecf62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:19:16.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFBmU4K6Bc4fZddxw88ydxyV2+KEi1FyJi5eKVdK62cILhtJjypi1dxdqRIgGzB/FJEj/trAr8stIaGR3Jl+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823




On 1/13/2025 5:49 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices and CXL port
>> devices.
>>
>> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
>> presence. The CXL Flexbus DVSEC presence is used because it is required
>> for all the CXL PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
>>
>> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
>> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
>> CXL Extensions DVSEC for Ports is present.[1]
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>     Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> ---
>>  drivers/pci/pci.c             | 13 +++++++++++++
>>  drivers/pci/probe.c           | 10 ++++++++++
>>  include/linux/pci.h           |  4 ++++
>>  include/uapi/linux/pci_regs.h |  3 ++-
>>  4 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 661f98c6c63a..9319c62e3488 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5036,10 +5036,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>  
>>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>>  {
>> +	if (!pcie_is_cxl(dev))
>> +		return 0;
>> +
>>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>>  					 PCI_DVSEC_CXL_PORT);
>>  }
>>  
>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>> +{
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>> +		return false;
>> +
>> +	return cxl_port_dvsec(dev);
> Returning bool from a function which returns u16 is odd and I don't think
> it should be coded this way.  I don't think it is wrong right now but this
> really ought to code the pcie_is_cxl() here and leave cxl_port_dvsec()
> alone.  Calling cxl_port_dvsec(), checking for if the dvsec exists, and
> returning bool.

Hi Ira,

Thanks for reviewing. Is this what you are looking for here:

+bool pcie_is_cxl_port(struct pci_dev *dev)
+{
+	return (cxl_port_dvsec(dev) > 0);

>> +}
>> +
> [snip]
>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index e2e36f11205c..08350302b3e9 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -452,6 +452,7 @@ struct pci_dev {
>>  	unsigned int	is_hotplug_bridge:1;
>>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>>  	/*
>>  	 * Devices marked being untrusted are the ones that can potentially
>>  	 * execute DMA attacks and similar. They are typically connected
>> @@ -739,6 +740,9 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>  	return false;
>>  }
>>  
>> +#define pcie_is_cxl(dev) (dev->is_cxl)
> This should be an inline function which takes struct pci_dev * for type
> safety.
>
> Ira
Ok,

Thanks for reviewing the patches.

Regards,
Terry
> [snip]


