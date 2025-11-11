Return-Path: <linux-pci+bounces-40922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE4C4EC5B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9F4188A5E9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099202FD7B4;
	Tue, 11 Nov 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MYsrHGLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9F311C3F
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874510; cv=fail; b=YauVrzA7roA2/r72bWMvhnb/cgbTVXwRUanCJis6zdzRxwMobnLmhb+2As4fdGgc/N6HAo9jKGdoW56h6qDT/zrm+CbFmZQbx+L8cAnnhvA2P0k8UTGR/aXmTFXJoiNi6RpJC8f+wtZaGisvMritChsQDf0fXvOGPEd6i1E8myE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874510; c=relaxed/simple;
	bh=T1pIMTxFksU3+Knju2bYxmXvkf6AqoNr5SOPJZouEQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANcpOMiTXQGE/9JNvICMBLy5+le8JMAkSnnFNGWhkuvTKuNRrM8p2DaYWJAKgevfYANcyxCN/VoGfxwB1hWg/GgUAXTiVq6KR+XLbENGLW1Jixngx/KI0DuiKriP2PxTCjCx+GcgFgZv55PsDlScGFlLfGhh/cOthVrtT0Vpvnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MYsrHGLx; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ+9g/j3z9NpyMIxQuym6mLdQUccLxZsk15d6zt6SY5HwPIw56lNl2QlfHzqyn8JWQE4+oEzKnJE7S551SWrgXhAPYvXXUanAMAPgZqVFhuux0l+wjx7JTN5JEhI5kVkSQbKTXYQOlvtVeqoFEuSy26hRpJOLNVhidWzStrmNQObnsugkLJBKc6HnI4BCw/a7lFyIp9W30iHZoioXrzBzlqcl0oEKyB6nzCcaC5vXmqbxD11MS8pKboYReKsnD8VRK0GRS4ko7dT/WQOr5dwOhCVQr6ZSk3CHvHhyKmkG27TGKnBLJAylRvgFimW3S8HswnRaSkidHBoInCOiPCNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1pIMTxFksU3+Knju2bYxmXvkf6AqoNr5SOPJZouEQM=;
 b=M0T+us08yhCZUm/zbN6mWMd4w3JEV85vMIyTAgBsvWcESa9QRSepdNZ3gkodYyebjrYiLgyktJhdD63Bp7JUJFK/DZNPx7nfccgZaU1NRp16GzFBtAaS+tMW777SMDyW06/50o0FtcIFfIq4a/fflXJRY2iDYwDeq5AhXDXBpeegOa5TaNlZ/AGFXvsOO5F+VXpQ9l/LFx/V+VwNYgMNZB6g7xMI2QCIchClCtTxIrLFVz4ElA5QNdNgar8ojSpC0KB1z/4nADgJpkD2InoDHUCRn4t6PJ2HqCZUMEWmQWYegZ/21Eg3LfK7XmoQebfAdLr0Gpxz3QS05VFcniObRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1pIMTxFksU3+Knju2bYxmXvkf6AqoNr5SOPJZouEQM=;
 b=MYsrHGLxl3Mq8pEFtjFX7IZAnEFsr1kjmlpm0r7Iwg1dpvceqBE+QRWDyqMPxY6Cs4ifrJy0jtwGI09dH4xNwFrmFcQilhuXaJm965Go0OY2nFpGg+p+L16zeiPfEoiiHTvMeW2k3EqYEv/WQOiTT7QqT8gt2BB25zFq1ZHLTRZWDW6ZpfCOifheMmcHOWhwaREjghXpNrfK3UA5pHVBS2fPoHuulayLQiG6pTJeHdpCC8JmwN520isaiCWJdes3n8F02niindIvgR1tu4DcLq9udBuidWh11DXX4ADDY47QP4rZoVY9JsqZayOIPibe+Q52b4CxLdwbfPJ1ti5Ftw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by SN7PR03MB7154.namprd03.prod.outlook.com (2603:10b6:806:321::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:21:39 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 15:21:39 +0000
Message-ID: <7236b092-5b5d-4300-985a-4604572886b2@altera.com>
Date: Tue, 11 Nov 2025 20:51:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pcie-altera: Set MPS to MPSS on Agilex 7 Root Ports
To: Niklas Cassel <cassel@kernel.org>
Cc: joyce.ooi@intel.com, linux-pci@vger.kernel.org,
 subhransu.sekhar.prusty@altera.com,
 krishna.kumar.simmadhari.ramadass@altera.com, nanditha.jayarajan@altera.com,
 Hans Zhang <18255117159@163.com>
References: <20251110170045.16106-1-mahesh.vaidya@altera.com>
 <aRJFzI-VCqDeEqTN@ryzen>
Content-Language: en-US
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
In-Reply-To: <aRJFzI-VCqDeEqTN@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|SN7PR03MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e79c12-a61d-4ec6-69bb-08de2136025a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0NKWmxGdldtOTBtSUNxbmpMWFMxcU0yc2xCZ2YycW5WY3pMLzZ5K09lN1JG?=
 =?utf-8?B?SERWdW5VVmExN1pCWlBkY3lYaUJaQ0VzM0lrS3k1cHhDMkxYaHJmNWI5N21P?=
 =?utf-8?B?K1pLVDhuM2Rxc2VWdUN6OHJiS2E0Y0Y2SGlHczFiUWgvaTBnQVF6NE40NG5p?=
 =?utf-8?B?NTRqK0ZGbHZDeSs2YVdUWmRSWmg5SkxxT1ViU1R6NzlCS0lqS3BjV0NZaU9n?=
 =?utf-8?B?Y21XdURkdEo3L0xrVG1yK2RJOFlGMFdBYU9WbDdpUEhzSmNXMHh4bHZPRG9E?=
 =?utf-8?B?ZXVSZ0dwM2xKbE1paExrdFFjNTc4WDNjMTZrOWR4QUJtaWJabTJhS2t1V3do?=
 =?utf-8?B?VWtDbjFlN1lHRkFxd2c3TXJMTWJCTHUrbHpIZWtNRE9KNkZHR3QwaUNGMVJ1?=
 =?utf-8?B?aFZoWUNQWktTVWZxc1Zsa2RRaHYzalRNQW5SQUxaSVRSRWNPbDBRenVVOFdl?=
 =?utf-8?B?NysyenpQYSt1ZjZ4WVV1eEUwbGMweTNHMDZyKzZoK1JIc2VtdGpzei9uZjZN?=
 =?utf-8?B?cHdLcm42VEVWazVMcnhac0VLNmVUcXBqRlhuQ1lOS1pJbk1PZDNRd0RjZkkw?=
 =?utf-8?B?eTVneDdvMmRTd2RYTG8vdmVaZ0hFM25xaXZER3NKc0JHR2FmWG9tV2IzSzdl?=
 =?utf-8?B?b3RSVUxqTnhqbVUrbXdSRlZ6YTB5eHpxV3JRNTU5ZjhDSkdoYWlQc2RiSUFV?=
 =?utf-8?B?WFdlV2ZEeTVxUDBlZU5UaUZnb1h6UGMwMmR6Mi9FYjRWSE9EamQ5WlBGaDRw?=
 =?utf-8?B?dE54cDRUZjBGN3F5b2phVDJWeTNVeXpFTDl0cStNZytTa3Q3T0g1bHB2NlVs?=
 =?utf-8?B?cUMwRmZMSkR6UjBETlM4WVRsUHNNSEptREV1MlFPZWVnSnJ2bEFBQVJQZm9n?=
 =?utf-8?B?TzdtSjlQeTJncFk1TE10bE5tNzdNcm1veGw1c01uNmVIUW95WWllWUU5N3Fi?=
 =?utf-8?B?Uy9xWDZiQmpWcEloK3RqakdkQmw3eDYxNUI5Y1VIeFhDeWpkaDdUbGFjcU5v?=
 =?utf-8?B?VXMrclVzaGE5NkhTUzZvWW10OWZicWFaaHRUdE53SVlOQXAxMUtZVVdaUm9N?=
 =?utf-8?B?OFBOcmd5MjdaNkwxc2tDR0JoNUNyTWJYcFVaRjh0aWNVaEI4U3daNmxqV29U?=
 =?utf-8?B?M0FIRGc3TXZwKzl2SHB0VmEzbWtUSU5qUmZzYk1OaG5ZSTFRUnNiOXBKSUEz?=
 =?utf-8?B?aUFka3pMZC83N3ZpM0FKUWR3TVkyd2M4c0VSNEkrUE0yMytMQjNOOU9Jdkph?=
 =?utf-8?B?d0dLWHVaRENVMDVvKzBOV3NyamF3ZjcwV0s2NzdNMlZHUnlTWm56dU1RR2J5?=
 =?utf-8?B?a01YV0k1eUdILzNvUDhDb2FQcUhyV1BSbXgyUmVXdFVOcVdVNnNUQ3FqTHhD?=
 =?utf-8?B?YkVUNHptVGFadVh0WWZLMVRsYmRxR2R5TnNHQTlwRDNmQm4yWWVNWENGMHcx?=
 =?utf-8?B?SEd0MlJBelFWWTVLQ0podkx0dUFBVTRDOGpKcUpVL2ZBQmxHb29Ia2VjSkZp?=
 =?utf-8?B?M1FOU21xSmIxNjZNVm0xK2VobmYydjRoK2QvNHdRL2Q5RFRNWXBKcDJ6YWtw?=
 =?utf-8?B?MDN5MU96UUdRM1F4N3N6aXhhRy9aeWliTDlVV0d2SStrOERiQ1crM0lXSUdo?=
 =?utf-8?B?M0dMck1IMmwyK0FwQU5wUkRuRHZVQU1ma0xQRGpQOHNYWEp3aU0wUkErbFJh?=
 =?utf-8?B?RmdxSzdOd2V4Y0RXOEkrQXNFVTRrOFJNdGRybUdqVmVxNlJLRzdQS0wzNER3?=
 =?utf-8?B?ZDYrUE1lTVA2U1Zvd2poY1Y3UmNzbm9iekpUQm1oQ1FrRFNzWVdTcy9CNHNR?=
 =?utf-8?B?eS9PTUlGVnZOSURZMzMrcUErdFd0ZGttcEoraFVHU0hxYmtuakRNVmRxWmZz?=
 =?utf-8?B?dmpKYzRQSEpUSU1wRlNxanBmeFRMUFZZQy9KRnpMVXNLOUpIMDQ4ZnhQQVox?=
 =?utf-8?B?M0pkKytJeW9DdUR3bUdJYUx0Q0xJbEwyRTB3NDVmWTFEUmJqSTA2d3FLLzk0?=
 =?utf-8?B?TEY2NW04WC9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVQwN1J0aklRRXQrMUVrUUtCSkhrdkZ0bGxQWStUZ1BvQk5adXQ2VG5pdWh4?=
 =?utf-8?B?UmZWdG5ITXUyYTVZMVduQ1F4R0Nra0xkNmZqaVhiNnUvL1BLbGFqajg0b3dI?=
 =?utf-8?B?UloxTU1kREFBQXE5RkQ0SXZheUtuVlp1ai9ja01GaE84SDBncy8zMHV1SnJh?=
 =?utf-8?B?bkE0bWVaRnlxb1dKZGJjOStDcnJwQ0lXK2tKUGREU1o5c0RpU00wUlluUENs?=
 =?utf-8?B?bkdpeFNZb2VDV3YzQjNYQUx0TTVWS3h5WVc5V0lHOVQ2NFF2RHB1Q2NIdTV2?=
 =?utf-8?B?bVArcERiT0tjWWFXR2FPRVpIU3JjU1ZLdnh6eTlzdFdPMlRYbk94Sk9hK2x0?=
 =?utf-8?B?Y0lna3loaDl3a3hoUXFuZHJhTXk3TVc3emF5NENBTVFOMXpVRzQ3WkFNeDY0?=
 =?utf-8?B?cjBxV1l4QVBRdGhNNjczK0J1eisvTWxWd1ZTa0xRKzdtRzF6MkozODdXK0FI?=
 =?utf-8?B?UWdONUZoQk1CYTQxWDNUZHc4bEdyT1JRTDMzbVptMkp6SW1KVFBOZlAxSUZX?=
 =?utf-8?B?S3k5Ykw1MGZOM2hmeG50UUNjOE5UVDg1RW5BVVBSOVVHenJIOHlBdVNKOWtE?=
 =?utf-8?B?NVdNM0VJSVh4aDVwNDhkK3phaTEzcTRnSndJcGJNWE9pN2lydGZmQVNvZnor?=
 =?utf-8?B?R0ZUdTVVYlFkT3JWRjVsTG9XRnFUVXNxZXFEVG1xUXFLVUo2cFNWZzlrY21X?=
 =?utf-8?B?NlFvK09iNTRjOXRKRVdxa2FPZk5lQWdZMkhSdDBqcDZUaHhqSVJrTktBK2pB?=
 =?utf-8?B?SVlOYnYwb3pkZ05Vak1JcDlGUUVrMUxscFIrWTFOSU83SHgzOE1nRURPL05j?=
 =?utf-8?B?VE1Demh2dmUyM3Zmd2lPcEhIOXQxblVtblFlVVpxOWF4Q0hud0F3OG14Z0pl?=
 =?utf-8?B?b1UvSVQ5YysvOUUxUHBMZlRqQ3UwUGlTejdFZVZHSGpmNlBqeHRET1VEUjNp?=
 =?utf-8?B?MGg4dFR0Q2orVmZTQ09TakQvTTFwSXVoWkdHQWxGbHU4RnhqalFXNGpWc3VD?=
 =?utf-8?B?bzlQcVVpdXNNLzlqNzJQU05Qei9Nc2F0TEJHaUNicnJMdFhjSmFockNYV3lI?=
 =?utf-8?B?dlpXc3NkelltekdyTGg2TmdRcy8zMFhEZjU3cVhmNENmR1NPdUpyKzByS1Na?=
 =?utf-8?B?WGFvVGk5ZWdLV0Y0MkhETlNmOU1TcGxvSk5lSjBueGtkSGoxL2loUEZCby9K?=
 =?utf-8?B?RnZVUTRhbW9rbXhZKzhsYmREK095KzN3N1cvRi9WOFE3dzZOVTZPNmptT1Mw?=
 =?utf-8?B?NlhHSFJpdlJqT1FoVlU2c2c2RjRYSmx5bm9lVC9EOGNqR3lnK29LTVcvUE9S?=
 =?utf-8?B?ZkZqM1U5VXRDUENpbnUrTHI5OTI5V05FSFZ5d3hJcTVuVDFrMUlOeUpBWDZV?=
 =?utf-8?B?M2xqUHA4NlMyRmNPTVRMM1ZKOFA3MFJuVi9iU3Zjb0l4SlJwTkZlYmticHJa?=
 =?utf-8?B?akp3Tk10M2tyOUJHZGt0OEJqZm9VcDdmc1laek1qenA4RmZNbVpIeTRGYXlB?=
 =?utf-8?B?bVoycUJIVzFleTkzQU9Fdm52QkFLLzVZYUh5QmJTNUVBSWY1NldENXJNeTRw?=
 =?utf-8?B?SnM5SmtDZnZLK0ppU3JsTENzVlpod1QvU2hZUnVmUC9EZjlqRWUrMkFYWC9N?=
 =?utf-8?B?UHd6dnA4YUpVSXJzTWw1M1BrY3hyNnVwSllJVjNGZXpSNXMvR2VNS2pEd1pZ?=
 =?utf-8?B?U0lseGl5cHpuZEFyb29XbDdxMmFZL2FKSXU2YVhJUXBQVHlhb05wdWtLWEhV?=
 =?utf-8?B?bVBtNkZHM0hZZUVaN0szVG9lZm5KVFl0VmhuelpJRUN0dzhHd0dGaWdKQW9G?=
 =?utf-8?B?dTA5bUdDOVhGYW9PaGo0TVU1NjcvV1RrN2V0Z2NSaHMycXNJa0MwRmE2VVl3?=
 =?utf-8?B?T1dkNW5QbkxpWldEc0NJcXdBdVlHM3JhblBIZDNwb3FMbzZET3hicVE5cWZH?=
 =?utf-8?B?eGk3bXVndVJLekd2ZGdZWTlFMFQ5N0FvSFZvV0lwNElSSjFaajdPQlVtYUJW?=
 =?utf-8?B?amZRMHBwK3NaWWVHNTh5M1d5bDExVkFYWFNRak5KYjVZanl6TjFKTWJDYnNH?=
 =?utf-8?B?RXlwTm5SY28vUVgzUEsvdUREYnFwTGFnVDI2SzhlZ284WDlod1kxeVBZQXp5?=
 =?utf-8?B?MW9Bd0hNNG95MC9Sczg0Ni9mSE4zOFhJck9MV1RVNEM0RGYwS2hINVNPSC85?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e79c12-a61d-4ec6-69bb-08de2136025a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:21:38.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mSzrvz0Z6hg/Lp09l8Vby5knXfD5kjhNtuoiPqrzONOpkTwwpuDwipAJ839Y6VHhtqLdLMg3kHv22Zt750W7yUhFBumqv129ixAWUh6rQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7154


On 11-11-2025 01:36, Niklas Cassel wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hello Mahesh,
>
> On Mon, Nov 10, 2025 at 09:00:45AM -0800, Mahesh Vaidya wrote:
>> The Altera Agilex 7 Root Port (RP) defaults its Device Control
>> (DEVCTL) register's MPS setting to 128 bytes upon power-on.
>> When the kernel's PCIe core enumerates the bus (using the default
>> PCIE_BUS_DEFAULT policy), it observes this 128-byte current setting
>> and limits all downstream Endpoints to 128 bytes.
>> This occurs even if both the RP and the Endpoint support a higher MPSS
>> (e.g., 256 or 512 bytes), resulting in sub-optimal DMA performance.
>>
>> This patch fixes the issue by reading the RP's actual MPSS from its
>> Device Capability (DEVCAP) register and writing this value into the
>> DEVCTL register, overriding the 128-byte default value.
>> As this fix is called in driver's probe function before the PCI bus
>> is scanned, it ensures that when the kernel's PCI core enumerates the
>> downstream port, it reads the correct, maximum-supported MPS from the
>> RP's DEVCTL and can negotiate the optimal MPS for the Endpoint.
> Could you please review and test this series from Hans:
> https://lore.kernel.org/linux-pci/20251104165125.174168-1-18255117159@163.com/
>
> It tries to address the exact same problem that you are describing here.
Thanks, Niklas, for bringing this patch series to my attention.
I tested it on my hardware, and it resolves the issue for me.

Tested-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
>
>
> Kind regards,
> Niklas

