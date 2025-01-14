Return-Path: <linux-pci+bounces-19796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750AA115A2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57D93A33A8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA22139D2;
	Tue, 14 Jan 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Lh7agmV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190614883C;
	Tue, 14 Jan 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898611; cv=fail; b=H8C5X9tGbOOj06p1EZDuWEzQp7BwQMSzypqgjfDvVmyPsLTh4SRUSnC6fqoKED3Km+RD04QGhbYLJNoxcvv00rb+SMygIOpX9ysIl/id8RSui4BKGApfh14pnPJwJh2cKjoCWgreeTecn8jI5yI9d/A5WkPDMQwVTiXvl/QyXYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898611; c=relaxed/simple;
	bh=SdIGZuWGBtP9X5+/eQohrCCprYCTM9huZBX13O0gARc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ChbIYzIXh9mAsUGblSH5gyDxFPnihvXQaD/e2JONxRMP7bmN9fD2Iatd9tjsbbdLE3VsOeqARy3/VzRvNzmzouvskMB6r621tBt1k90YPlcffvII76ymXM8P4o+pQI4Jk9Bk48qPYStha4Exa8hBkuw+waBpJRRiwzoudpGLP8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Lh7agmV; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB47KA9QZ2iSsmPysODMFzQWVV0ddIFd4kuR8a5wOoaJ9QIRFb+6T59w5Zw7vIB7oNMim4nyJPXHx4/u4ocbudFf/h6SxJFfvtoV3H49ap1qHJXWh+QYmDCOsSyRxa4wuwEaktG06E/Bw+3etHLR82scAsxgQEvBxGff44lj3BCJof9lJZ432vS8nFow2UIURflR26bbEQexa5ktb27NsqZlHYjTiQqqEhsABa6pzwuRdIYxgtt4sE5t3MH8a08zNT0EbtrPX+q06Ki5s0rVuA5zgxHq9Nr/iuibW7dktje12Zv4bqME3HUwVHzqnnriAHlwjhCvdZBHf/yZ5Jhw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KXdofSJw7WaE/bgfpeWohG03m8E0hNgrHASW96TszU=;
 b=EQUwje9MaVEncsGRkP4ztN3fWVM4MegqzZsSex8GqxrVj5ifoZ+WW4bNX6JjcLFzkf+1UhFYeFOAi0DvAosYLA4wljONRQxOtJ8oFvxBamKQyZjsdGG2EO/jVrEKXiuB9Boayk/Dr0waaaos6u4hnvOB1WPppQHpz9GRtuMPQdJqSCnbWFEx0Miuo1FxnjXZsi//R431uXZ8kg8//s0nNDPhwPkX3SB3LqnEwMl3G815kjFg6MQ+6AIO5cgxqJRUtUOzrPVcK0cJ3rtiuIHXepSiGjIXvN9a+5zJ8uT6SvQOPmH8pCQKSfyRrIABMjtPvVSg2q6KcveuufVloRMeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KXdofSJw7WaE/bgfpeWohG03m8E0hNgrHASW96TszU=;
 b=5Lh7agmVzFoRQb2r5Jvxxh3BWIssrUgSkFT+ejRGSSqxespIbWdOKLrnRFwaW1v3riG9S5DKSZ33lzA7UEhMx+CKgBT4jjllXdHHqIVSe81hkvZQH3iSvnbHzFECHQXGCd90ShtnllTc3zo/ayU0+mXBch0S3R885CCAbI3UyAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 23:50:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 23:50:06 +0000
Message-ID: <ca86563a-f75b-474d-8211-c7a86e5f5790@amd.com>
Date: Tue, 14 Jan 2025 17:49:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
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
 <20250107143852.3692571-10-terry.bowman@amd.com>
 <6786df12594c5_186d9b294ba@iweiny-mobl.notmuch>
 <73855ef4-7540-486f-9a4d-e73cfd286216@amd.com>
 <6786f5845635d_195f0e29413@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786f5845635d_195f0e29413@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:d3::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: c8646990-01e6-41b1-fd27-08dd34f620d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bExka2dkTHBkNzlZd0U5WU0vUWFlSlVhSHpvMTE2Mlo5ZlpUZmxna1RUcU5Q?=
 =?utf-8?B?b0RuS0R4dXdtazRqczJBUVFGZU1wRk5GRU80UjB3U3VDVmJqN2o0T0l2MHlv?=
 =?utf-8?B?Q3pZRndkVGp1L3dpTUt0bC9MN3VoM05qL0ZGYUdtSFVRelhNTnp6dHlXNVhM?=
 =?utf-8?B?cnBpMmFmczA0QWVMMTRPRjBha2RTTWl5VnRMdEVQd1VzdnVPY1FGbG1vdG9S?=
 =?utf-8?B?QUR4OHhNK283WXBURzNPNFR3a0wwcmZ1MHVXSWlYZjEyTm9ldnJ5MklMOEJD?=
 =?utf-8?B?OTdlSmNSQU1Xem5KUnpyeXlxRklKV0IxdHVkQlB4TkV0TU5xcEtQS04zeE04?=
 =?utf-8?B?ZmFXYTdYWWRpY2VYVVB0UDFDZEJOSnN3NTVFanRHQkoxUk1QN0szaC9weCtL?=
 =?utf-8?B?NkV1MHNwNlVpZk1TeXhVWTN4d0NFTHN2Mkw1WFdvdjVxS2VPMDF0N2lacDhh?=
 =?utf-8?B?VTJiTkRFSUxRQ3NGVUw5enF0LytZQkF0UnVVNS9wSlJHbmNQV2ZVN29BcUpn?=
 =?utf-8?B?VXpQN3U0NTY3SGVFb29vakRoZ3BESXc3QkIwVVhDdFdqYVRkcFFBU2x3NEg0?=
 =?utf-8?B?b1FxZDgwQTNhR1BnbkZLT2JOUmV4bW1aZDVNeWE2MmtTa09hR0NoNG85OVhM?=
 =?utf-8?B?QUhFQTdlV2JuMlB5d1lrODlzbVRxa1B5a2JXdFZTNS9hSXpwNndWbVBQT0Zr?=
 =?utf-8?B?SnpJWlFxayt0ejVtUEYvSkREOFBoS1V4WW5nY1ZXeUVBNkd0dEZHRGZMWk9I?=
 =?utf-8?B?YmRneStSekFJRzJ6OXJtaVljWWNBU3NqR3hnWG1FSUVNQnV4cEZCL3F6aTZV?=
 =?utf-8?B?dlc4ZHR4b1pTTEZoMHdtSm1LeW81ZTdlN3VHdFZHSWV3c1BXczJkdEtZdmZx?=
 =?utf-8?B?eGNxVUptN2RjOG94czI2UnpMYnRCdE9oSnprcGRIeHNwU0tzcXZCZjliSkZl?=
 =?utf-8?B?NXVJWFMyWEFZKzFMb2ZoQ3YxdnlVRDVGM0c4MDUrQWZVUUZvWVAzOTg5V3k4?=
 =?utf-8?B?NzM5b3BwdndKZ2NlUGErKzdQQUxmcUk2emhpZVE4Q0NXSWZmN3p5enRUVTZD?=
 =?utf-8?B?Q2xFSWY3aTNpSUc3aWx3NGgrWlJZbTZ4YmltaDV3azhLSm0vMDZZeFpKNW1Y?=
 =?utf-8?B?NzBHWExiQWtabklMTEdJNkg5QVZ3cUFhdEppd09kOTF4TUFDVTVDSVBvN0pY?=
 =?utf-8?B?bSt5NC9BaEVrNDFqZU9xbTNHczFVOEpoM2RvOUlkVit0YnQvazhkblFiaUVz?=
 =?utf-8?B?cXIwK2ZDUXFHZFRhUkUydHlwMG1DUEtycVlYVnVvSEx2OUUzajJ4M1lraEI4?=
 =?utf-8?B?Z1U2QVlsYTNFSUoyNnB4TnJ2UklFZklWdCtWV1Rub2ZiZW1iS0ZPVURHVVZS?=
 =?utf-8?B?MGJ4c2pHNnVoRC93aENlWmdxMFBEaUxCRVovaU5lUVN2WndMM3kwMUs2NUtD?=
 =?utf-8?B?eFdJSU1JaTBDOHlDdHBTYlpTUG1Ddk5VMXJZTWN2cHAvMmZaU3RHR2ROU1F5?=
 =?utf-8?B?UHNaMmt0REV6UHRXWnczTHBJY3F5Y3N0aXJQbnhRKzM5ajV3V3BMTGZreWlO?=
 =?utf-8?B?YmVQTVE3Qms5N3BsWWg3eXN5RGZIZ1UwK2ZGM2htY2IvTE1GNG8wZ0lnTWUz?=
 =?utf-8?B?aUVheEZJRFQrcjIwYzlWQ1ZmYkwyRzl4a2xRVFphc3o4UlF2cTcrT1p6SGZB?=
 =?utf-8?B?Q3k2TmM2OEJ0bzNGRk9YeEFGZHhhdWI1SXdkbVVqL3RZRFNmcDNoSlJUcEZp?=
 =?utf-8?B?RWgwSC9wWHFrRHN2K3FSQmdDaW5BSUs0eWhIZ0t6dHVHVDJXdDc2dGpha3Yx?=
 =?utf-8?B?aDhBZ0ZBQzJYMHFTMjVhb041NlJ6UTNIbkswT0haK3J4YXpYYzhLSlhpdmNm?=
 =?utf-8?B?UWpBYUQvWWJPK2dCYVJKUTAydHJocXpyZGEwMW8ydmlnbko1SndaQ1NxeElX?=
 =?utf-8?Q?YdADdGlqnzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTVVVlJPS20yZitJZC9RVUYxaHA2emhBNzVTSmFvTk9xM25hUTRWSUo1TnN3?=
 =?utf-8?B?aUpQaTZubVJ5S0J2eVYxL2d6SkVOQm93d2RiR3BOSHRaMGhueTRJcm9KUU4v?=
 =?utf-8?B?bkI4TVd3dHUvMGlIOFRYM1RMNHEzQVJodUtrTnNzZmRDMkNaV3RWZDFCL2l1?=
 =?utf-8?B?L05YRHlpQWZuMG5idmJWK0RnOVFZSmREUW1FU3N5Q1Vhclc1NUg4L2JDbW95?=
 =?utf-8?B?L1J3QXpWSXAySHhsUmZjVmFFYU1KUVczcnMyN0ZSTXFXZCs2K3BMME1HTndo?=
 =?utf-8?B?WUtLcEg2T0UrZDdiMWhkcWEycVJESk5ubTRIVktxeGRSUlp3cFNST2dpOXZj?=
 =?utf-8?B?TlRhbDBjTTd2Q0FscWt2bmJ1ejdyYWl3WDlhNGpUTXdWYlVEdlRpVHhnSUx5?=
 =?utf-8?B?b29yRTBNbHVyT1NBd3ZDMllZMU1sejc0VkYvUjJ1bXJWQ2o1VGFjcXozTkVN?=
 =?utf-8?B?bDB1RWVER293TmxRbkNDVWNOZlpHeFE4ZXBEU1EvcTNOVHVUUFlWRVpCYUo0?=
 =?utf-8?B?Y0NQRzhZRUtuRi9kTWJMU3JzdnI0MnN4bzA2K2tLbm1qcG5nR3UrdFN2akZk?=
 =?utf-8?B?QzlzbXZGOHkrYVYwbHoxZ045K0M1L2ZpUG0vdUdyUTE5aDFpZDRXOXhmM0U0?=
 =?utf-8?B?blhNOFlYWTdTT05BLzhDY1Z0QVNnYU5pYkNMMlBWcVJGVnlUUUxqc21oTy9D?=
 =?utf-8?B?TEJjeWlrd1BrOUFIZkl6SVFLamROZmFQVnJ6MUR1OGRmdDFjQXZVam5TY0RJ?=
 =?utf-8?B?SVFYQUxwN25GNXg4TDB4Y2R4eVhKRnJZaXpIaUZDQUlISlZ5NHQyTHdBQ0ZR?=
 =?utf-8?B?WlppZFFSSDhaOEFEdStqaVBmNWNDTUlDQXVaVERUNHlKUzJ1YUc2dDJ1dGhk?=
 =?utf-8?B?M0JONlZNdVlvV3VYaVhSRHg4YUI2MGFNeFl4ZmExNWZUbVpNNGh0RlBMdVBZ?=
 =?utf-8?B?K1dUQWFVeDhmSUoyY1RidXlRZWRqQlVlN1p4SXlCOWdpRldWQkZyTGhjanEw?=
 =?utf-8?B?blpyRHBwSnpneFJYSWxtZmNUREY2Rnd6dlR1cnFCU21VK1pCZk5xdDNVWW9J?=
 =?utf-8?B?MWNabnlJQmxGclBsbTFrZHg5L3JoS0pXSWo5Q3NhZWkyRjRTanFXMVY1TkY4?=
 =?utf-8?B?NytiMTNSNlZCaTljd01ZZ0F4V0JsWVZaV1ZDc1FKSmV4Um13ZCt6R3Z3ZmFW?=
 =?utf-8?B?Y29td202THYwSFg5UHVaQTFFRDFuZEw2YzltVGh2VVlRWG4zSWo5K2pKa0Nz?=
 =?utf-8?B?TUlkWlludExzV2dhWjIzTHpoSXFzb3Z4QWNoZXpadEM0b2dNZXpKSC9MTmdT?=
 =?utf-8?B?QzQ2MURFVjZlTFQ1ZS9NdGd4UVFTaUhkMDhjWS9kN3h5a0RZN2RBRklJMU1m?=
 =?utf-8?B?SVVFL1lqbVpoTHBISnphNVhqZVh5aW9RZExmSGtqM0Frd1VPVTEwUklTSkx3?=
 =?utf-8?B?RmE0TWJDTU1qaGMzQXcya0hmeFlyellRRTRvdFVSNDhxVXExUWR4VVBQK1hz?=
 =?utf-8?B?NG5uNUhwb2Zld3FkcU5QRHhLY09Ucms2M1VvTHZVRHNTUXB6RzFsNkU0OCs0?=
 =?utf-8?B?em1ldGpjdkwweUEwOXVKRjhkOW5kcGVIREFIZHFTemNqL1p6VGQrYklrQm8y?=
 =?utf-8?B?Rzg4TmNNK2dBbUNnQlM0MVVmaDVzNFRJR2RKWUV6RVZOTmduc2loRVhxNE56?=
 =?utf-8?B?RkFuSUE5d1N5L1FYUzBsVm5oTlQvcU5sSndiOGhGRXVLdFNDUnk2bmFnN3Bz?=
 =?utf-8?B?QnRmekpycTJUVE13cGJ5L25RS3V1ZFdZV1p5cFF0bXBPTzM1VWMxZ0QrVHo2?=
 =?utf-8?B?SmVGTy93YjBwY0ZjVUtoWDRXcXh1UHFoSy9ZRytoMzk0UW1YNXlyWUJmUnQ2?=
 =?utf-8?B?Skt1VjR5elB3V0JVdEhPYTEwcUtPYVF0d3AyREZGcXVBbUFQbkxLV2s2SVNw?=
 =?utf-8?B?TkhpS3JtNWJaT2duekF0R2pJWWpBZTZxWExydUJZdmpjM2N2QnVTUXFKT0F3?=
 =?utf-8?B?aUVsV0FQa3cvWS9JQnhkdHE2YTB4bDlERnprem0xL2NNcEthZHdDa3BTUmE1?=
 =?utf-8?B?UU9ZSUpKWlhXMjhXYjBJKzBGTjhoWE5MVWJuUzBkZHlYSThUREtiNG00d1Zy?=
 =?utf-8?Q?yPUfKxGJwu14W7b1ySGmY3Hs4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8646990-01e6-41b1-fd27-08dd34f620d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:49:47.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfaGNchUJ084Ksc9QsCSvKOt3Qlia7Q5DO+xjHrQqsDx4qqsyY8cSmzz83S8GCMTGjKbglTyN4JmgoT1puVi0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246




On 1/14/2025 5:38 PM, Ira Weiny wrote:
> Bowman, Terry wrote:
>>
>>
>> On 1/14/2025 4:02 PM, Ira Weiny wrote:
>>> Terry Bowman wrote:
>>>> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
>>>>
>>>> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
>>>> pointer to the CXL Upstream Port's mapped RAS registers.
>>>>
>>>> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
>>>> register mapping. This is similar to the existing
>>>> cxl_dport_init_ras_reporting() but for USP devices.
>>>>
>>>> The USP may have multiple downstream endpoints. Before mapping AER
>>>> registers check if the registers are already mapped.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> ---
>>>>  drivers/cxl/core/pci.c | 15 +++++++++++++++
>>>>  drivers/cxl/cxl.h      |  4 ++++
>>>>  drivers/cxl/mem.c      |  8 ++++++++
>>>>  3 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 1af2d0a14f5d..97e6a15bea88 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>>>  }
>>>>  
>>>> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>>> +{
>>>> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
>>>> +	if (port->uport_regs.ras)
>>>> +		return;
>>>> +
>>>> +	port->reg_map.host = &port->dev;
>>>> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
>>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>>>> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
>>>> +		return;
>>> Why return here?  Actually I think 8/16 had the same issue now that I see
>>> this.
>>>
>>> Other than that:
>>>
>>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>>
>>> [snip]
>> If RAS registers fail mapping then exit to avoid CXL Port error handler initialization.
>> The CXL Port error handlers rely on RAS registers for logging and without mapped RAS
>> registers the error handlers will return immediately.
> Sorry I was not clear and I should not have clipped the text so much.  You
> return in a block which is at the end of the function:
>
>
> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> +{
> +       /* uport may have more than 1 downstream EP. Check if already mapped. */
> +       if (port->uport_regs.ras)
> +               return;
> +
> +       port->reg_map.host = &port->dev;
> +       if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> +                                  BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +               dev_err(&port->dev, "Failed to map RAS capability.\n");
> +               return;
> +       }
> +}
>
> So no need for this specific statement?
>
> Ira

I wrote it this way to add the handler initialization (after the return) in later patch
without a diff removal. But, your correct, I can remove the 'return' statement in this patch
and add in later patch without cluttering the diff.

Thanks. I'll make the change.

Regards,
Terry




