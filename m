Return-Path: <linux-pci+bounces-29352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F2CAD41AD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125CE189E0C7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857715C0;
	Tue, 10 Jun 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m06vVpGg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FC24679F;
	Tue, 10 Jun 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578886; cv=fail; b=lotMoic5CW2urISCkLeUP1uSVez9B2gqAj6/OQtsz7/j5csK9KpOpqwnBzUYInl5r4sZxQgDccvxtDLA2NLQwHgysn+vxSJgumY/4UdSOHj8n49vSqi0mohN9c5T6dJFBLBVBIVrRAYvjMK5DzRmWix2Sw6ft8WVNrvVVnThjLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578886; c=relaxed/simple;
	bh=lvVCNm50w2YjCfFBVmUCzO3MGYI/V0n6J5JLtSIz5Js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9jxTkzXTeFUksxFwiTtaDqxt9vADpfeu9CbVW8xXFnfaqgoa004PSwdmw8OEMoo3liwrKNTgvfgPUe2j+U5nmL4BiDBchYDcDnEwZOxuXb/6Tk09ibevYB3xnKmkNsmVPZCXn/WjSjAP7/h3a60IP+2sIJm+4STv8w5G/ex4F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m06vVpGg; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7Q4g97ajYg65/JJq6K1WHsge4iXG/bCxApJAxA0yfnePtnfgjW1D0QoxyIEETV9DN2oa0IjaBZYiv3pJIzkMEG8WOeBp+Zi0xs3NWwcbt7lnMv7WbUyBrjX06BXQ7mj/L0cAh9ehHW3yutTnph+wWZ8oVvOerTLcG5SjAy5jqtDNqx2zhAs9e1Qr+u9nokteHHSBmaJp2hfV6jFD+NSA6V+Is7VoZFvn/sSQ6VDcLFfWGOcVSt2S51q7bfoagHzpqCobI5Or3XL7QnC36Njj/HgahRlBp2uQXW9qxur3td6mDMa5PR4WJ2BdCbxYK0OxwRWh+dAopEU3mCFIM0RfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdwBx8CNKGLHJnZ91ER/AIsqZMuvUQNfYCCDybrdQ58=;
 b=k1KtciJmZBKtjj29K9vi0V9/41Oxffpz+WC3mshOOwV3PQ/sFotASaxbF3DPy+lLuSedw2W/R5qfYyI8BF8DzdZWaLzvIB2cTsl4HOvvpe2idYTUbpPYjXniKIOmOEJPkiwDfKe9aLHEFbn64s4yzd4YZ2uTM4pRVdFPh0QYTD1hqt0LQZ0KVCAG2YrDAqXq7nnJA1p/esuFD0exKu8JdSbdSZRPMPeIjgyKTW7JSTOmuyBD1BalslRVd1gYSz3HgOrGzCLnYEpeWcNmn4YHs2uD1OLXy0CN0qRDoAhELk6SPxMB28bkipkGqKUmBPEzajBHQW05IzNnICk1ErBlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdwBx8CNKGLHJnZ91ER/AIsqZMuvUQNfYCCDybrdQ58=;
 b=m06vVpGgJCxiUWaXT+sqFfTM4oIswHArwDs9d02nwbZgK9yfExYRXpInPymbfYf9+aCe25uEJcuJF1PHDB6lXpXwE72qwmjbG6g6XVmR7rJeu/Dq+vk96jxQPEo04QXJwfSjC05H7SyztW4PbEATd9crbfifvgHNlgBGTCZjqA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 18:08:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 18:08:02 +0000
Message-ID: <aad4372e-d73b-47f9-9736-31dc1e6e03b0@amd.com>
Date: Tue, 10 Jun 2025 13:07:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Lukas Wunner <lukas@wunner.de>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 rrichter@amd.com, peterz@infradead.org,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com> <aEexYj8uImRt0kr9@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aEexYj8uImRt0kr9@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:806:121::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2e24f6-fdf4-4ca6-892e-08dda849bd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHN0M25wdklBdHVLYTJ6M1F1ajVuYlZYSG40UXNHWFNMaW1tV3M1MWdyOXUy?=
 =?utf-8?B?SXdVWlRHWW42N2gzTURIWW8wMDM5Z2JycGxKWkRzdHhnUExtM25mOXpja29L?=
 =?utf-8?B?UUs0SSsvZWFXMHlRRFpYYXZLQlpISEo4MjdHVGNtTnBOUnU1WXBEeTRzSGFJ?=
 =?utf-8?B?SG1uQTNMckVnVmptaU1EM2twVituc2w5MjJkamV6SmpJVjMyQkdmTDlKNEV6?=
 =?utf-8?B?ejBidzM0dERBQWl5S0svRE5iWVNtbkFTRmg2QU1XSEpHUXIzem1BNG5Wbyt4?=
 =?utf-8?B?TlpsV0VGSVgzQ2VYRmtJZFRhK2owalg4VkpzWTFvVUxBcUc1Mk9Td294V2FW?=
 =?utf-8?B?TjVmNU1FeStSSDN1OFA5NEoyaGw0OU5TTGNiQytScG1YKzA4VG9iOUVKbHNl?=
 =?utf-8?B?KzNMYlNnbFluY3VmS3BDWjJHSHFEb3I0WlBBdWJMZ2VacmVUOXNYS3ZhTTRn?=
 =?utf-8?B?N2ZUOUJESFZ4Uktqamo4Z0RGS0pJaDhuMFJWRXg5akVGWW1tU1lFTzJoYmdl?=
 =?utf-8?B?TUFUM0Y3V2NMbnN1VDhkdDJhRWl3YTBjSG5Cd0JLOUtXTC9mcEhLK2JHbXFM?=
 =?utf-8?B?K2NEU2padnJlRlA5VXI4SGdhTXlYdXkrMzFHU0NPT3NTMG1xTFQ2Y3dha29o?=
 =?utf-8?B?VVF5QWdFV0cvQkJxVVJPV1duVUlBUklEcnppbFk3YlBVVHZRK2U2c2c5SzZV?=
 =?utf-8?B?Ymh5VnFPVTFDZkwzcXFwNjVrNURqd2ovM1EvZldxMFFkK1BpTUFKWHBwTm9N?=
 =?utf-8?B?cGdOREtmWVUycGlXcGxZOVJHQ2VSd0FSUFBlM2kzRG1QelBGMjA1RjNNVDRi?=
 =?utf-8?B?OVU1czJxS0g5Z20xMnFscmljWlZLSURTa1NCeEU3Qy9ubkYzTTVvQ0o3U0Rx?=
 =?utf-8?B?SHVOZkJydEFNM09wMG5lZ0FrTlh6aXNFZkdRalZ1R3ZCelJScVFMdmNpRW5a?=
 =?utf-8?B?YXJ3Z3JORk1IWmFLS2tvS29QbmZaekY3Qzd2VlAxOHBNS2VsOXcvUldMVXZN?=
 =?utf-8?B?S0lyckt6Zklsa0xEUzhkemxJeUJPRVozOTlseEJQK041UXJKc1FxOHhSWkpC?=
 =?utf-8?B?N2xuRmxVTEFwRXhBTVdMNEVkZGRFME11OUNDR3pNL0JsVmxLa3dJbHBWUVZ3?=
 =?utf-8?B?UmdmY29GZmlKc2xWZUhnS0Nod2FmZTVhUzVLWWd1MS9vRDNQb3lZRTlDbzho?=
 =?utf-8?B?TUY5eW5FUjlZSlZ2MnpPZHVsRkpwZnhNRHJkdWdwZzBwZkROenVwNlNkV1Aw?=
 =?utf-8?B?a1RobVlGNzlLL3pSbnFQUEdoaHdYdms3azVPSXp0NlFWbmhwUzM2L3hFSUpS?=
 =?utf-8?B?ZlRyeGEyeFAyK3N3QXFVVy9Uc05TRFlCaGI3UDlsNVdLcUVscEJQTFhORllU?=
 =?utf-8?B?RlA1U3dWVUNvRitEc2lFWWhERmJFQXE3RWJOOHlnV3dzaVBSaXN6VWR2djFs?=
 =?utf-8?B?WmE3anRsSWQwQkw1M05LL2xDN0tTOXI4WThqYUQxbjRLaHNuVGJ1RVdPWUZx?=
 =?utf-8?B?U0FYMVhHZk1jSU1FOXNuREx3T0h4ZndOc3dHbVdweFdEUFF6aytWaUlMUW9l?=
 =?utf-8?B?OGVkSHBNSU1saVZpU2Rad3J3OTlJODdhbGxKSFkyOU9uekk3b08wQVYzMXVJ?=
 =?utf-8?B?ZmxnNkljN3dSVUExK1NYNWZ0YTg0TEtBeEk4bGVIYm1GeWtnMjhXTXk5OHRM?=
 =?utf-8?B?R2NkenFHRXZ5MHplSUdNbDlEd3NQOHZ6UUU3QXNrMGdvOGFaY25Tczdwa1lO?=
 =?utf-8?B?WUhNbHJlOGFYV0h6c2t3d3p0bFlsaHdhYmRUVE95UmRLdEZ2MzFXT3hMbEVE?=
 =?utf-8?B?Y0k3cHIyYlJoWWk4Mi80c25WdElvVDdBckxSajRQS3JiVHFUeWxpTWhSVy9T?=
 =?utf-8?B?SjN1MGxFQ2Nwek85d1BxSHByLytIRWN3N0xJRnNYaE5MT0ZtSUd2M3E3VEFw?=
 =?utf-8?Q?RXHykil7HYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2xCelROaDhPNnRNNlJTYXJEUlpDRENOQnpvNXY5Sjd2bUtOeXc0WU0rdHZu?=
 =?utf-8?B?c3lPNlR3NjUzV09nK1U2eWR1V0NkS0xFNVNPR0lDdkhmazFJSm5FL3I2VmZQ?=
 =?utf-8?B?ajN2RkF1emJGVE4wL01rcWpTRGtiK3ArK3k4RUFzWlVlbTkxV2xPUk9hdkRq?=
 =?utf-8?B?ZW5iczNRMysyd2NYcm5wOWpiVzQ0Z1hIeVJSTkVnN2JYTmVhMmV5anp0YVVx?=
 =?utf-8?B?V2psS2NUaHNBbURsNm85SXF5QzFPZFdFR0ovNnVYaGwrdVNiZmIyaSt6QU4r?=
 =?utf-8?B?WHRWMkFSZ0FNMWZVeVJPV1pTMVJXRGs0ZnE5cGVNa1hJUU1HS3laTnpobGdx?=
 =?utf-8?B?RVlEUnNScTJjbDJDWThoWDlSWENJWkc2NUlLUTMzTGMwRTFMbnA3SWozVElj?=
 =?utf-8?B?S0U3aUwySmJnQ2lBYVVjTWJneHAwOVkxQms2eDk2a2M4VUplWlZWR2hudk9M?=
 =?utf-8?B?R3pnd3d3T1pJbTF2dmJiUlFJanhHQWt5cTBXWTcwekx6NXB5alZucUpZRGpJ?=
 =?utf-8?B?NUY2MXRMWnZ5elZ5TmFJRG9KQmp5Y290ajZYb2VMYlY0dVhYTVNiSDQ5M2c5?=
 =?utf-8?B?RVY0T3NZclBIMjRVY2tTMFhDOERQM0JyU2t1R212K0NHemhmcy84MDZZTUZ3?=
 =?utf-8?B?QWx0dXpvNWZTV2xmNURVM1dQK1B0UXJEaU9LOWZCUzhpWmVsYmdtK1drc1Ux?=
 =?utf-8?B?MVZxcUlGWTFuSzZSZXpzRDNWcGNnZmxabnN5ekhWV05WazJLTkFiaXNNWVUr?=
 =?utf-8?B?L3BxeE52MkNLa2Y1Yi9sVDVOU2FnQkNNNkpXK3pOYWhKWHB2UnBJdlhWNkMv?=
 =?utf-8?B?bUxGMWZpN2YrdVZuMmFUR04wSkY5RnpEbS9FVTQwYmxoNXR6WmFFcEt2QnNB?=
 =?utf-8?B?ajNPM2xqdU50aGoybTVmTUtkSWNTbytGdFc3dWpPdW44aDhVNzI4YjZialdz?=
 =?utf-8?B?b1k2MkhKM3hCK1pOVGp6SE1rdGN3RFlMUGdpb3ZCdWVWbTIzaEozdUQxVmhH?=
 =?utf-8?B?TXAxK3BmU0o5UytLeGx4eUZOa0QybnBXVFYwWHArVi8wMjNHYTNKd2ErclJa?=
 =?utf-8?B?TGdDSXM3S2l0N2s2c3c3ZUhrZGJHOXRXMFJRVWEvaVR6bmdva1h5RE92OThP?=
 =?utf-8?B?bnJjTGc2eTV5dVpzVktVdm9icFQralRCNXZaZmFFVzEyeWZKOXFWSWJhcHpR?=
 =?utf-8?B?MzAvWDd6cjIwWTFDclRrZG5DU0IyTWlZbzdOWVR1NjVWSDBjSitiYlF5UFBF?=
 =?utf-8?B?NGpjYnhBakRTWVJEdGFTVjZWOTJ2c1FJMlR4bkY4Nk1FS1k5bUVOajBIejBD?=
 =?utf-8?B?VXRKU21XZERyQXQrUjZUckM1SDZnMXVjOWVTTDBNRFlyWkxVQWRCMXVkcEc0?=
 =?utf-8?B?Yml0emRoL0NDbFZyZUVST2Y5WUI2UW91WUFQQkVHREdTSlJCWmtrZlRkUlhR?=
 =?utf-8?B?M3BGN0oxcllGOXZMY3l6eDhhNklBNG5wVk5VT2NBOVNKSUh4dDRrT2dwTXU4?=
 =?utf-8?B?MXhPY3VsUXFERnpGUllJaGJCQVRnL0k4T3RWRUlQT2pYb2NNTmJUalJtdGZO?=
 =?utf-8?B?S2xiY2ozaHVQRkNFYUN4MkxZRDgyMTJaU2d5NFllTEROK1cxaWtacmIwcXVT?=
 =?utf-8?B?NEg1ZXplWmg1UW9nL2hrZlVzRytYb3dFbGV1eGhLS0FWMzFtTk9SdHUySjlv?=
 =?utf-8?B?N0gwclQxSDM0T2dRbnpXalRXM1VEajRSdjJKQnVxQ05zTEFpUHFoU2JNdC96?=
 =?utf-8?B?dStGZ0twaFgrd1hyVWVNZ3V1cSs3VGQ4bjFSRmlWdHE3NGlWVi9jTUg1anZr?=
 =?utf-8?B?ZWwzdkFGU2hiQ0NRaklKN282c1pNVEgwMjFMTlc4MElLc2FPdWNkd3JvRDdK?=
 =?utf-8?B?cEhkOXNFa1IxalU2VWFnZ2pQdHFnVU04M2dBSjh2cGR1bVhQb1M0VlFMeWg3?=
 =?utf-8?B?eFBCSXJuNXpMMEcxY1lQVTVUTnpvZ0wwV0x3NHlWZUFvSjZodHJEL2tTOEZy?=
 =?utf-8?B?cjhJaWl4a1F6RG9teTZ4a21RMFYyNUpNVU9DR21ITnFneFRFMitDbEpUVEYw?=
 =?utf-8?B?N1B4azJvd21ZaVNwYkVKWnpxTTJ6VEdKeXdFcDF0VngrRmUzdGVNV0tQVUR0?=
 =?utf-8?Q?H/idBpOCx3qYPeHcJcSCUU1pg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2e24f6-fdf4-4ca6-892e-08dda849bd71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:08:02.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyK3aAB9eiYLxtO1Yf3yXkcnP/sXU9s74Hp62NpPUTL4hWPJKKLfacsgnJ7UkaVh0C8JK0b2t+Jz9HviodHGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516



On 6/9/2025 11:15 PM, Lukas Wunner wrote:
> On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_prot_error_info *err_info = data;
>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.0, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return 0;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.0, 8.1.12.1).
>> +	 */
>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>> +		return 0;
>> +
>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
>> +		return 0;
> Is the point of the "!pdev->dev.driver" check to ascertain that
> pdev is bound to cxl_pci_driver?
>
> If so, you need to check "if (pdev->driver != &cxl_pci_driver)"
> directly (like cxl_handle_cper_event() does).
>
> That's because there are drivers which may bind to *any* PCI device,
> e.g. vfio_pci_driver.
>
> Thanks,
>
> Lukas

Good point. I'm adding this change. Thanks Lukas.

-Terry



