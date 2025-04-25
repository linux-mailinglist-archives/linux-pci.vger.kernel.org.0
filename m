Return-Path: <linux-pci+bounces-26719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78529A9BBEC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E749E9276C3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 00:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B67483;
	Fri, 25 Apr 2025 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4LQeiG3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D452914;
	Fri, 25 Apr 2025 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542169; cv=fail; b=kHPkxfitJbpiEVp7FMIF5Ph7hSuDzdUR0LS4xGZoZWIaCXs2qLBzCQoXuHiffwPbtPCXQ85NnRi9Mcii331452wSblrNSfLuMA8goGiW9Xkc9U+P0IHKhJ7/BxFQjj6kaGntP0KTawpRGEgrp/QyBPohigPz+zKZ0M9xgxE9m2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542169; c=relaxed/simple;
	bh=l1Qn97rHAcn7M2Jh3/n4GPAf3ih4EG7hKPvxT52MpfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bq3V1sgg/qAxSLs3YUTvsz5xZKK68Tt2l20NmGir5OL2UTPM3qRdtdn6VjKDI6WyQP03cmRgtv3OxxMBJc3T4Po121T7sFw2Y6mBR+QivwWlTCqtnuVtgFVfX0gr7eFtbjv36/j6g7Xj6oJKa6qfLxaBluFykBIZqZYVYLcdgLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N4LQeiG3; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0luDsu5xEFLqKp9vey7tprRPBIeLB6hBmMQJI/ewxWRenRo4cjodXekK6PA4lUcewLKoCjFudCoopm1grjYECiSpHwUytPPA5eBrhFguOdREV808P5IKQUdgxNp7qGD74Gk46BP1OiM+UG0fblI/jENI2zvW6wAB4/b7MKtRr3l9TPOSeryU+lR7G1XM2lD9ff1lj27wgew17lLPHg5gk7RaGtvAqSVFDl7dwnn/gry9nJ/HKkS+dW+jpxputD454Z1tPcIKy2t8A3pm72Kd/Q9XU03YfYxukPDJTUtQ5qeMMlcq2Mpukes5kn7SCcmj6tPNw9yVXoZ4N/TaCyN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SbWAYPTiE+MqDOHMr8g26Wj1wIKml5No4sEYAXhMcI=;
 b=XBZcFQ++AIg0Ow8CM0aH7qcF7hT9FtUgj/bMklk8rWv185YwhaO3J9PPysUp/OWxpy1AuAaJEsvL8k4N+f+37hQjAlpZ1AHnyI2n5R1C5oUzz7jR41SrsH4z2J3jrnp8w3lwhqAE7MuaAfwlnI0iCmB4lkfZ4FzO0mhH3WakzDwyun6w8tC/R/sTOGPGlfRLWjgG1BxIZRF2MvbLq6CkbKtgc9klXTGpMqc2rPi+fl0vWNNaCl4Ktim8i0Hi0L2DYGaSkTUsIbsDFb0jCnTrukwfgGNK3RvM27e6ZK7VZfxLxJj2aFmCpCT+BF3I99jSadEEwcsUdT/h9qPUm69K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SbWAYPTiE+MqDOHMr8g26Wj1wIKml5No4sEYAXhMcI=;
 b=N4LQeiG3Ftw0mR1+CC+S9YG752qfihu02OCl5DvTeU77TXO93OoHMNw2Uv1wdsEiQ6Rgmz3y5paoCXDpNeu25MBnr/sm+0cq2kJ7bgsspmCKDlRjSXZERjYJTfmV73F6cNqcO8/MrHr7k1h2sRLc3WOebbriJAS6OD4OQ1zmWmL8rcFaIneg1InhEC/0zFzaYnJpejmhvjOvAp+2ERyMZz8uqsc6JlZ597SKZ5W/2DE2aq+PUAgR5lr0Yzce/IDwVXsSXNfEJvsejba5EiMEuQm2+m7ZyQLTbfC7meSi0s8/k/4YVZ+KMUruNelvOEDhjt+DOTGKhrZyHA6J/VhzgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 00:49:23 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%3]) with mapi id 15.20.8655.033; Fri, 25 Apr 2025
 00:49:23 +0000
Message-ID: <77be6671-e4e8-4b17-bf72-74bde325671a@nvidia.com>
Date: Thu, 24 Apr 2025 17:49:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without PASID
 capability
To: Jason Gunthorpe <jgg@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
 <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
 <20250424123156.GO1648741@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250424123156.GO1648741@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a09be55-c88b-46d7-cc30-08dd83930551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S24xelg1UkFSVGxISkJGa2FGZGRUdkt6c0R5L2lUVW9FR1ZGQytRYmRYTEhr?=
 =?utf-8?B?bjdHRkNhZWlxYktMbHk2Yk51N3JCdmlrVEJNaStKT1RvcjJQdm9HeDYxQUNC?=
 =?utf-8?B?SG5yamhjUXRUQmRuNXZnamdYbVhrYUE2NWlPNldLTGo1MXNTQXY3NmNQNUxq?=
 =?utf-8?B?SkFmaXBYYWNCTUJYZVdOd0kyUWtWR3VLMzhlSGJqU3k1MldWdnFZakdwdFdz?=
 =?utf-8?B?K1QzWC82Qm5ubzl0dzRrN2pqRkE2ZFJXOURPMjNYSERNcktxNW9qR0tSMVk3?=
 =?utf-8?B?RS8rUys4a3BwcFpiellZb3k1REtBSFVlZG1GQmxURjQ0VGlkZEF2bVNaMWJv?=
 =?utf-8?B?SGovWDlJZkVWdzArTi9Sa0NoOG1KNVhzRE8rUldaWE50YzZWRWs1VjhNSXpQ?=
 =?utf-8?B?aWplNFlyK2VHYzZSL0FUS2R5cDYydzVqNkVISDhvcUduMS9ERmZQZ2UxakNl?=
 =?utf-8?B?Uk5RaXZTekR2dG1PbzBmV0hZOUo2QzVQeE9kazFMdTZYOWZUbjNaMUhIb3FT?=
 =?utf-8?B?cFZ6MWpVODNCSldTTVJmRkt1Zm9od1dyUms4Wjh6S2R1SlhsUDN6K1dDV3U3?=
 =?utf-8?B?aHp4SFFWSEcyR2E3NFRxV3JuQzFyaDlXVTVBQ2EzTlZvK29yaFBZRk5naWFP?=
 =?utf-8?B?WUY3Vk55d1hmNDEzWkJtUGZWbFdWZEhZc1hEdDBJRVR3TEpDRFRlVEJhRlRC?=
 =?utf-8?B?L3FrYjFVTzZqc2JJR1hLaC9aU1lXbkRlTDZ2UkYwbTV0ay92aXpPK3UwTnM2?=
 =?utf-8?B?UXdzbXNwTlFKTkh4QWZQS0ROY09xME1aOGs5WmhsVkhob3U1TU1aYmdZQUV0?=
 =?utf-8?B?eWEvNFZaeWt5NGVBak51TGlqTmtZQjF1VG1jYmtaYm1mdHVxeTIxTzk1TFl5?=
 =?utf-8?B?UUtRQ0tOQ0lrd2ZDUU1LR0JaeHpHSk9QV2xGdUhJZ3p2c2xKRzBFQnlWcHFG?=
 =?utf-8?B?WFN4V1U2a3NnNTRSWSs4MGJMRS82MmcvRXZmR01lSWUydGtQbVI5RUVNYjEy?=
 =?utf-8?B?VFpjSEpOMS9QZDlWUjNwNyszSHd2RFYwa2dLd0R2dWZ4U1JmU1NRUUJIM1po?=
 =?utf-8?B?MXFsTHkzKzd4blZ2d0IrK1dxNy9oTE8wM2NpWkFTUUtjR2dtcFk5WWRnb0pa?=
 =?utf-8?B?dk1qTDhzeHBrWlp6ejliUEUyZ1ltNjNjWTY1bWcvWFFuZmptUGtPWHpCM3B4?=
 =?utf-8?B?Wk1LWlh4VTJCUm14UXpBMmEyMU4xSXFBYUt5amFoR0dER3dMRmNzOWVSbUJS?=
 =?utf-8?B?blc0QzNNenNEc3hNeTkrSEIvWU1ZaFdGTW5iZ04zZzhyR0tkaFNKNHIwOTFB?=
 =?utf-8?B?VUM3ODcxS05zU3FhcTBtOWh1QithelRsL2YyZjhUSDhrWGRrdVpmd0xOL3Y4?=
 =?utf-8?B?aDlRSklvUFo0bG5OQlhhVWtoYW84TFR0SElSKzBWenN6ZUsrbUZTL1lvNm13?=
 =?utf-8?B?Y014bVBYeVI1KzFnVEdpaEdUKzFYYmhEYjQxamhpWTRsTmJHYjBsOGhHcW9V?=
 =?utf-8?B?bUNJYlJnVW1IaVdYTFc1UTRINm1XZFlCVFVpYkFpOXN1QjdBU0FIcndVWEM1?=
 =?utf-8?B?SnJQemxkQndUek1oVTdBUHdkSUdtYWpFSTNGMTUrSzBoclducy9VQWN0ZnI5?=
 =?utf-8?B?NFJaRjdzMTNDYzZYNVdzK3RnR0xTd1U1UzM0UW02L09hdlZaOGdnNUtVejJL?=
 =?utf-8?B?ZjNnMWsyMEF4TEZsVlhIU29OSlp2eDNoeWhNZEUxYXJxNHh2dU10WDd1NWt2?=
 =?utf-8?B?SWpaUlI1Tk5FTkIrU0o4RDZUWVk3dDdVRFBHOFRpdXpqekd1V3RqVjVTWEVC?=
 =?utf-8?B?dXJtTmJvT1lKUVBrcEpTSlF3VEtmLytGRVFKU3NrMnJWb0RVcjNrNkdTS2JS?=
 =?utf-8?B?V3Z0NHdMYk1CNmkwaXFveGt1TEJ3VzU2T241TGNiRVVQV3N6WERGaXpFUWZt?=
 =?utf-8?Q?79pOAjioer4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG9KSWMySUVMRUxtcTFqUmxkbVllRXZqekxYQzRncTNMS0VQVnFRWDNBRmtG?=
 =?utf-8?B?ckxrNjJSdGtlc3RwZURiMkNkV1dlMWpzMDNDa1pzMXdmSGcrbERzTEtMZmRu?=
 =?utf-8?B?b0lCZWhDRVBWSGJVZHFZb3J1Q2FYeHl2MVNpSUZOS25hWWwxTTFVSVFFTDJL?=
 =?utf-8?B?UDM4TGZjNFEvMGRFeGtobzQ4eW43ZVVYcy95MWgrUUZuRFZ1YnNRVjNGcHRx?=
 =?utf-8?B?aVQralB1aEtZUHN2NTIyV3MyNkI0bHBZTUZNbElJWTJFS3BKdzkrbmk5cEly?=
 =?utf-8?B?QU4wck4wTTFqU0RPVklRTWdiSlpZa0FtYXF1NmdWa2NoTUhveXNoZGw3a1hs?=
 =?utf-8?B?NERRVi9QZGJYZURhVFkwdGExQUh5Y3ovTm9RaUdlbk1SYU1BZWNBTmt4ejcy?=
 =?utf-8?B?SG5oRGN1U3pIRjlmUHcyelJRNGMzTzc3TW5BdnlBME1BU0ZReVVSbENIMFU5?=
 =?utf-8?B?WWRlSjh2U3hzRUxXekZMU0xSR2dsMnJydmRSWVcyZmUxVVhnVThSSU9aazRX?=
 =?utf-8?B?blJXMk5ubnNhaGZqbkFvemp0Nnc4RzhLTmZ6ZU91WkJCb0V6d3JRK1RFWWhB?=
 =?utf-8?B?T0RWZ08rSkkvaWxHbVhhTjRndjFhWU0xWGVLbmJCV2tmWDhZNUdjTi9zeHNv?=
 =?utf-8?B?QTZURGdNdThOMDJqamFpRFNkcG1USjhCNFBEeTFFL0dMcDl3K0VtUmdYWEdQ?=
 =?utf-8?B?ZGc4V09uUllQUlpmMlpnQnNsRFlLZ2Rra1ZaZWk5TDJ6WEdsVi9KUXFWMGhK?=
 =?utf-8?B?S3RBbU90Sm90TmFPWUh0ZU0xemJUV05rOUJ2MDNTNllpRjNmdHhSWlJzTkpr?=
 =?utf-8?B?c0hFZ3ZWaDN2YnpqdmpTSmxzNm4yWFpvZTV6STJGNG0reVJzd3gvdzhDUERX?=
 =?utf-8?B?b055bUhZdngvbjJBMzRBbUE2d0J2bktnOTRrNzZZRThjNlNLdi9EVnVDZXc0?=
 =?utf-8?B?NFU4SGdQZlVFd2tFQ2QvVjkvOGxzZFV4U0ppZWErNTBkUTQ2NTE2a0s1OC8w?=
 =?utf-8?B?Rmlkc3M4VUdHbVZDejgwNW5sRGwwOFpDKzZRTE90Q1dOKzFMeWFGRS9uRUxM?=
 =?utf-8?B?T2VHUXhFcXRBSkg0N21iZ3pvTE93VUk0eER4M1d2eUpIeGNRVlFrc21KTUlP?=
 =?utf-8?B?bUF3WStCaG5tSG9VNCsyUjFqaXJNSlpWYTRQTU4vaHJFSUNPZ1pBbk90NklP?=
 =?utf-8?B?NHdGVFFJUmxjbDd2Z3lIekhWREFiclNJaVM0bmJmMVduS2hDZEZreGlNRDJy?=
 =?utf-8?B?WlViOFh5R2FoK0dsbGg2MFJaVk5DbGdzT2ZEZG1kN2VxUy9BVUZLa2NwWDhW?=
 =?utf-8?B?RWQxMEJmVVNQLzRkT3VVZ0pZSkl0c3FFbU1QdCtZV1RDbFdlS0Qzb3FxRWVN?=
 =?utf-8?B?bWNSRW5YcFNXTVFlR1ppbjZNN0dvYWZDY2JITGtybU51azdYQ3ArblU0NzlO?=
 =?utf-8?B?aHJuK3pYb1JKUlFHbWxvUERFY1kyemJhbmEzK25zSDdIL29RSlZTb3RJajJo?=
 =?utf-8?B?VnRGYmNNbnBXQm1LU3pSSDE0c2hjQnN3M21RQmVqT0xjSy9qKzYvenRtOE5Y?=
 =?utf-8?B?RFBNMFhVSE9jbDR6ZUNMREcwaitwNndrbnJwRThJUWtNSkthcFczaGh3RU9y?=
 =?utf-8?B?TTlxRGk4RUtGRnduRXNRazBSTEpBOXVGZnV2U3h0M2xHUXhUVFIzMWFuQ3B1?=
 =?utf-8?B?NktFWjZuRWJyV3dUZzFnNmp5cksyNUs3NmlOc3RXVThtb3lvUFRZUjJjVXp0?=
 =?utf-8?B?WXV4eXFnV1Q5dldtbjJFNWdFQlFaM3gyT3VvR2VRVk5ueGJ3SVVLZXhzWGhG?=
 =?utf-8?B?UWJtSENJUm9nenhMVjBKbjloNzBwR2VnY1VkYjR6bkZkQ3FUcDg1b04xNkZZ?=
 =?utf-8?B?a1IwMHFpdHc4dml4SXlzVlZmSnhBbVBVeHhOcWx1aTlCMTZ3SjJhcnlqaGVh?=
 =?utf-8?B?d2tnbnFvUkRqQnVyRmlCR29wcURvOU1tNnZoMFdiWEc5aDFudlhDcFBHWmFw?=
 =?utf-8?B?NUxJWk8vTVFIcUVibm82cEkyOGd5M1gzYWpFRmtBSDcwdEdnUXlvVnBvNlUv?=
 =?utf-8?B?d1k2WEVCN01oZTFhOHRVdHFFNzVLazZoVWlYYk9yNEN6KzR5b1J0bG5nbjZI?=
 =?utf-8?Q?H7aZSWxgU1hPWtGdCRxC8qI8c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a09be55-c88b-46d7-cc30-08dd83930551
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 00:49:23.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuW6pecNP8PtLMCny+7syKPhUajPxXWCo32lC6MBvsiDr26Yyvs6ugHxRulj8qzoEuOnTGWePyJ9SD3deDYwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329



On 4/24/25 05:31, Jason Gunthorpe wrote:
> On Thu, Apr 24, 2025 at 12:08:56PM +0530, Vasant Hegde wrote:
> 
>>> What the iommu driver should do when set_dev_pasid is called for a non-
>>> PASID device?
> 
> That's a good point, maybe the core code should filter that out based
> on max_pasids? I think we do run into trouble here because the drivers
> are allocating PASID table space based on max_pasids so the non-pasid
> device should fail to add the pasid. Tushar, you should have hit this
> in your testing???

When we have multi-device group with PASID device and non-PASID devices,
set_dev_pasid doesn't fail in my testing for non-PASID devices.

Here is the example topology and bit more detail:

0008:00:00.0 root_port
  └─0008:01:00.0 upstream_port
     ├─0008:02:00.0 downstream_port
     │  └─0008:03:00.0 endpoint (NIC DMA-PF)
     └─0008:02:03.0 downstream_port
        └─0008:04:00.0 upstream_port
           └─0008:05:00.0 downstream_port
              └─0008:06:00.0 endpoint (GPU)


In the above topology, we setup ACS flags on DSP 0008:02:03.0 and 0008:02:00.0 
to achieve desired p2p configuration for GPU and DMA-PF.
Apparently, this creates multi-device group with GPU being only device with 
PASID support in that group. In this case, set_dev_pasid() ops invoked for each 
device within the group with pasid=1 and doesn't fail.

e.g.

  ...
  ..
  .
  pcieport 0008:02:03.0: debug: __iommu_set_group_pasid():  pasid=1 
dev->iommu->max_pasids=0 iommu_group 30
  pcieport 0008:02:03.0: debug: __iommu_set_group_pasid():  ret 0
  pcieport 0008:04:00.0: debug: __iommu_set_group_pasid():  pasid=1 
dev->iommu->max_pasids=0 iommu_group 30
  pcieport 0008:04:00.0: debug: __iommu_set_group_pasid():  ret 0
  pcieport 0008:05:00.0: debug: __iommu_set_group_pasid():  pasid=1 
dev->iommu->max_pasids=0 iommu_group 30
  pcieport 0008:05:00.0: debug: __iommu_set_group_pasid():  ret 0
  nvidia 0008:06:00.0: debug: __iommu_set_group_pasid():  pasid=1 
dev->iommu->max_pasids=1048576 iommu_group 30
  nvidia 0008:06:00.0: debug: __iommu_set_group_pasid():  ret 0


IMO this outcome is expected. Quoting a text from commit
https://github.com/torvalds/linux/commit/16603704559c7a68718059c4f75287886c01b20f


"If multiple devices share a single group, it's fine as long the fabric
always routes every TLP marked with a PASID to the host bridge and only
the host bridge. For example, ACS achieves this universally and has been
checked when pci_enable_pasid() is called. As we can't reliably tell the
source apart in a group, all the devices in a group have to be considered
as the same source, and mapped to the same PASID table."

-Tushar


> 
> We also have a problem setting up the default domain - it won't
> compute IOMMU_HWPT_ALLOC_PASID properly across the group. If the
> no-pasid device probes first then PASID will be broken on the group.
> 
> Tushar isn't hitting this because ARM always uses a PASID compatible
> domain today, but it will not work on AMD.
> 
> That's a huge pain to deal with :\
> 
>> Per device max_pasids check should cover that right?
> 
> The driver shouldn't be doing this though, if the driver is told to
> make a pasid then it should make a pasid.. The driver can fail
> attaching a pasid to a device that is over the device's max_pasid.
> 
>> FYI. One example of such device is some of the AMD GPUs which has
>> both VGA and audio in same group. while VGA supports PASID, audio is
>> not. This used to work fine when we had AMD IOMMU PASID specific
>> driver. GPUs stopped using PASIDs in upstream kernel. So I didn't
>> look into this part in details.
> 
> Uhhh.. That sounds like a worse problem, the only way you should end
> up with same group is if the ACS flags are missing on the GPU so Linux
> assumes the VGA and audio can loopback to each other internally.
> 
> That should completely block PASID support on the GPU side due the
> wrong routing. We can't have a hole in the PASID address space where
> the audio BAR is.
> 
> I suppose the HW doesn't actually behave this way but since it doesn't
> have the right ACS flags the SW doesn't know? Guessing..
> 
> Jason

