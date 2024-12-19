Return-Path: <linux-pci+bounces-18754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A939F7573
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 08:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E616189605A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913882185BF;
	Thu, 19 Dec 2024 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jom6CXv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE9218592
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593163; cv=fail; b=l65JeU4DWlaJlVfyOIr3cG+SxPTwoZ/Uyuij3jlcDQRuETjXQU2ybQU7P9NFy5esHCayipsDeXT8V8PGufkD7oP9YqUeYhCWk6k9ipPf0kp7wSA0QozExgGLLZz52GU7Jp3iicO9tkyPSJ0yakTppCa7pvza8nwC+p7s2zCo3kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593163; c=relaxed/simple;
	bh=L5LHMyuD3hG+eC2FbpLsWgBB+1TcX4E971fewWEg+jE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvWNJPfdBlfbhbKE6ljchzFsYJDIzw4mifU0ln5ULXEukc/zpgXXlxSX+VjDr57+Pux/lSb8BtlfZ2+kcnGOcrtxRnDbdr4JII7v2U7Os2569WqmBDG8D+0Fj1YGIvYBVJDYnf4hcqMbtYsJx29NFvnUFEVxP8gQZPPzShSlGUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jom6CXv3; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi0F5jzwCEjweK/CAFvOmyMYpKW2H5ZT6js6AiLdZWmaq4Udwze5ys1aCv4noTmMt7Pzs503vtz8Drqqsv/uQMy7t+TzJrQpCYESx5mej5qCo+S79JusjYBtv/CgaXRmjfLbmzXorA30o0CGaigq07OKFMri9AFjWVtkom+ZivIs+JdTsz5q42AGqJ9RA5Mpjo5ZQ08Y0pCIjIqnA2qv6QYS/AYn4Ppm4j2BZJTc5Cu3lAF/ZwXvTnI8taekv+fYzRr8Th7LV47KrCiFDaENNnXhjWeT61K88hYqfiq7hsa2cR9Xc/bFUbb9ixpkfyQOOkBvoRCpBrd4Rf1jrdsqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONONOvl2fwncB2iQbaOu+4OPWupOjfeRCSiD7rnD+qI=;
 b=cSR93i9quxozIWe15cip9xp2ikRpLsAvorLLpdQrmKno+Cr3li2xluLgXK0AG76gqmpY6PBHnYODbb9cjbGFQlwYv0WnQQ0R0GGOi9Tq0eGi/jTJksSFEibBAvIHfm0NdlWIXsTCs472H+Swc7uO0NzsFYY9XHWvKyQCrCNRciCD9WkRFdro7Iw+uqL0DO3B/iRJHdxAsgKTGT434LNmehW6vgwORQQ6LFJmpq9XN0ap6MvyFsXYEDs9gPJVb+6BGjLZmn4SN24TUmjusOVJbIBJTVA5uUaIg4W1gDrA/1gg0AmLp2vGhSxI4sOFPhgBBqpxkYr5UZRmEj4HYXI+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONONOvl2fwncB2iQbaOu+4OPWupOjfeRCSiD7rnD+qI=;
 b=Jom6CXv3XlZORkfCgEj0kbsOIkmahnxptfASq7Q9h3ozN8TsaBhnR5TnCyq3qoYdLEB0K+CKpqHo9DpLiWfP+VoNxe/L+0rILqhmiWEM4qGYvtYIOJoe/FIJXFXmztm5ViZkqjScKClL7Hh4PEFzxBhQyyx3H5HyOFW3lONJjZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Thu, 19 Dec
 2024 07:25:57 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 07:25:57 +0000
Message-ID: <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
Date: Thu, 19 Dec 2024 18:25:51 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0182.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e21d47-a7e0-4327-ec29-08dd1ffe618c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUY0SVAya3dFMnIxU0xrL2JHQjQzSlU5TFNQcHpoaG90RHJRZ0VWb0NpanY1?=
 =?utf-8?B?eFp6Sm5iY2JtQm9ha3U4ZVZYaVg0ZXUzWnc4V3lub1hmeGNyOFdBelFqQnZh?=
 =?utf-8?B?bEIvRjdLU1BhbTZpeGdoQUdFb3ZlTmpydTFxS1ZJWGQ2UitFd2J6c2FRSENw?=
 =?utf-8?B?Y0hLQW5OWnJTTEZCVHVGTW9HQVlUdURDZklCcTRQcXVIcm11VjYvM0QrUGky?=
 =?utf-8?B?TGtRSll0ZEJoR3JWVGFxTXR2c0pXM2tkTytjVktoVFcxdTRmN2NQUk05TjZo?=
 =?utf-8?B?N213cmJFTTNCUDVXY3Y5TWFnR05vemNDcjgvUzQ2R2thZEpMMGRKTWl5K2Nm?=
 =?utf-8?B?ZEQ1MkpyVjhhYlp3RHYwL09XanAxcW94RVlpenNmYmVNRVA5VnZpditSRWIr?=
 =?utf-8?B?MTViU3RyNFBNbGZpOUptNlh4eSttQWZXbVlQTDFkemljWHNjeEhuQ085cmVN?=
 =?utf-8?B?alRYZ052Q2I0QmYxQ3ozSWt2ajNCMFJhZ0NOb3Y2RGdNN3VFUVRRazQrTmNH?=
 =?utf-8?B?M2h4QWxhRnFwbmdFTGZwd0d2NVR1bysxK3FKSHRqQXNsRGE5Mko0Q29SSktm?=
 =?utf-8?B?dXo0R3BoL1huQXR6dmIwbUp5UythTWRCcnNRWlY5M1lEN2QrQStYZDB1WmZs?=
 =?utf-8?B?a2xwTmpDa2FVVW9aUHJSc2lwRTJBOUVRMUo2bksxRzUzei9oZ2RKSHBqUzJ4?=
 =?utf-8?B?RCt1b3BGMWl1UEMyMGpRd0JDRXhMVEtFSUtqSXVyUC83V0Q5ZzNyN3ZnejBx?=
 =?utf-8?B?RVFjNmpwYkpxakkzYnBoVkZyL2hEb2FiaFZPQ015bHF3TVNZQzEySEhnL0Vl?=
 =?utf-8?B?ZFpTSHRXVkRibmdlc1hjYzFMZWJlTk1ETWYwc3k4VzZVVHM1YXd3eWZkK25y?=
 =?utf-8?B?MzFFeFRqdG92VGJiaFpuVVVkd2NyNC92b0l5R3dOcmFMWkpPY1VKc2diRkZ3?=
 =?utf-8?B?N2JaSlRrZTVvTG5ueXM4SWZlYkNYSmpJWGczS1g3ZUltNmp1RDl4QXQ0UWlj?=
 =?utf-8?B?NThrWkNXUE8wbGpUZUYzT3lueitWa3lIUWladzViek5XQyt5VlI0dW5rblVF?=
 =?utf-8?B?Vm5GN2ZIQlJxOXVYL1dhY3d1eE1hb3NxSjg2aFp4Si9zWVZVR1F2K29BTHFN?=
 =?utf-8?B?c294RHpWeHplSFJQa3RhOFhPd1kxczFlSzJNRDltN1pmQnZwLzJKR05PM2h6?=
 =?utf-8?B?VVB5SzgrM3NkRmI0ejkvN3RTK05ZK0FpSEtnL2V3MG5hYWlNdGczTm1MRVJs?=
 =?utf-8?B?cEdlR05WS2ZIQnpDNXIyVjRGTnRjYUF3QzJ4WHQ5aS83NzRQSFM3S1F0UFE3?=
 =?utf-8?B?bnJtY0ZhU0JKZHhoUnE0ZndCL0ZCMzJUSTFMbDV5UzljSWx6QTE5aGJEc2RY?=
 =?utf-8?B?UGpoem1JTklLRnZlZXZNSzZYVlZXbGw4dlYwL2I3WXgyZzFMQURMbmdRV2xm?=
 =?utf-8?B?bjN4TW00Y3FlTmFVb0w5MWd0Nlp3cUttUnlJVUF2WXNtdlpIVlVsTU5CTXU0?=
 =?utf-8?B?MnhiNFljSzNtL0o1UUtVWXdXeHRBc0ZwcWtZOU1uVFl4THVkS2ZSZjltMzFE?=
 =?utf-8?B?bVBFbC9mc3Z4WmtTTEhvb3N5QjYyWm9IKzU5SW5GT2pDRnZNNVdjZUhiRHI5?=
 =?utf-8?B?WlZCRVBvL2NtWlc3bkg2TkVsK1VGNVRZNXlEc2dXVzVVSlJkdlNFbnpzVjVT?=
 =?utf-8?B?eHFMYUJVSGNLQ21aRjZ1anFSblU0L3ZPc1ZQbll2Y2VHMk9NYUI0eTFFNW43?=
 =?utf-8?B?MmdWYjNQVmNadnlaSXpISG1YbUU1V0pqbldOUHdkVlJjdW5yQ1pjQjU5a3RN?=
 =?utf-8?B?ZENiZzVkNlBYcFJFRGd1ekxMb255NzE1QWxvZEFZVms3R01QTENNeTEvS2xU?=
 =?utf-8?Q?noM6As/uQ4gqf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFoVWFEci9aN3JRckRTRzRaNHA5dkRmcTNXeWFWQXNSSDhYWE93Vm9NaXlI?=
 =?utf-8?B?cy9hWG1na3I4Y1QyWGh1VzRXenlCV1lhYSs0SGIvR0l0QUo5S0xvdVBCN3NB?=
 =?utf-8?B?emJGOGxLUE5lUGg0S2grcFpMOHZCRHNhdXI4SmJqaGcwbSt5ME5VbE9WbzJ0?=
 =?utf-8?B?Rmx2OVFKSFdEdENOczdkL2ZhVUtpSVdZaUppbzg5STEzQUZydHVWU2pyaWRT?=
 =?utf-8?B?cXlhRWN0SnZFbTg3R2hoaFdweURTK2FuRU9GNm5pRm5iOHRuOHNsSmZ0MDc0?=
 =?utf-8?B?aFJOWDFiQVZzdHNMbFRaQ0EwSnRZUTRwMStaQzNaT3ltdThuaG8rTXU2K1h2?=
 =?utf-8?B?dnVBRkovQkw1bE1URVYzeTZ2RUlkb05jMU8yVHQ1U2NSQWZYSDVXQk1oTWVi?=
 =?utf-8?B?RFVzYTcxSG5vNnpTWTNNT055c2ZMUndxajlJT3FUNmN4MjYvQjIwV2s3R05D?=
 =?utf-8?B?bk92RUZ1eFRmVmRhZjBFNFR0ZDdvL2hSVFJPbVBCejBYWmw1T2JWQkVwRzA3?=
 =?utf-8?B?LzlnaGIzNmhUNjU4eVUxRkRXRTFGOU5JczZoMjcrRVBmUXZSRlFVa0cyNndC?=
 =?utf-8?B?M1U1VjZtTXB1WGI2Ukl2ZXNBZnJ5OGRwbjlFVDVnOGIyREdVU1I0cytHSzZN?=
 =?utf-8?B?RUtISGluREdoN3FhT1pNc05sK2VwN1ZGRjF5WExFTUs3a1BIdERybklQb3Ju?=
 =?utf-8?B?REhpK0UxUXNnKzRTM2RhRllhTis1WG1pNVEyYytrUXh3Z3JTZGt4TmJ5aGJi?=
 =?utf-8?B?djI0dHhFSWx3S0tweVNYSnpqYzhvRC9ZNlNMRlViNWw0aDFtVkNjL3RqdU04?=
 =?utf-8?B?ZTc4OExjTmlBbmFFZXZKanlhZ09na2l3Q28wQnhEMTJmVzNSamZqMWNWTHB1?=
 =?utf-8?B?cmNTK1Y0Wk5oa2NSelFJaUkzbVRXb2QwczJJNGRrd1ZnVEtha3QzZUNkc2lS?=
 =?utf-8?B?dFJEK1p5NGh1dVdGWWVXZWpuL1BidFplb0E3RWhWY3VPQXZkMnFiNXZWUDVr?=
 =?utf-8?B?ZXE1c2U0NGVIV1Z6MW9yWjVyU0hMTm5xSkVpSnZRYi9UZ2JETUNLUlBNNjBw?=
 =?utf-8?B?ajFWcTIvT2lzemZQZkdZQzJ3V3MxeXA4cm5OV2RPV0N2OEtOd3dKU1BMSWNv?=
 =?utf-8?B?akpkZHJ4czFSaW94bW5qVVpseFZZV3JqdEZiRVl0RTdKUk1TNHQzT1VEOVVp?=
 =?utf-8?B?c1pJRWdIRElucXdXYlg4VHU5eUtLSkNrRmVybFUvR1RxUHNHaFdXbHJNbHRO?=
 =?utf-8?B?blRoRDIzR0VmcHh1V2dnWjN2RDl2ZzFuTVowWDJwZ2t0c01XNTk5K2ZlODl4?=
 =?utf-8?B?MzQwWC9rZzQ4N0t4MzZ2VHpOVWZTeHlUWmxJa2V0bEI4cFMrVFBaNDlEblZK?=
 =?utf-8?B?SHQ0aDdBamF4VjArK1l2ajltVmo0TFQ4ajduTnlRRDNCOXFJUFFUWHVXaG5y?=
 =?utf-8?B?ZlBtVENtVWhveHBkeWlrN3ZWY3Y2OEVyY0U0OGoxUzBNbExSNVRXTWdHMDlt?=
 =?utf-8?B?S1JYVmhHeEFKV2IyL2JVdmNqYmdlRSs5RS8vWFFBZ2VVQ1JjMnNsd2RJZ1NR?=
 =?utf-8?B?MERmVllNb2tmeGNXVlo3dzhWVWdSS3YwYXd1a1VIdWJvMkpyR0hBcUN0Y2lY?=
 =?utf-8?B?UXFQVmZWUzJodUwveldHY3pwSmJuQ1d5ZkxhTnhXYVlDSERUWlpSNGdUMVlv?=
 =?utf-8?B?UmdOQmx4RmN6dkRRbUhieWJROFBDZ2dxak4vUHNqaGNFckcrSmhHOXQ5SDNa?=
 =?utf-8?B?VmFxRzE2VHdWODVscTFGdUxUYkN6b1pPU1VUWUF4dWNmckFueS9XN2h5NDJy?=
 =?utf-8?B?cVhxQ3RRWllUMDNhRUt3UXloUmlvb1JIZUhZeFFWUkMvTW1kTEw4QmV3SjN4?=
 =?utf-8?B?Z1VmOXcrWmoxUzdaVjZiWUpjaE13NTBMSXNJMUpYT2Q4ZTJjNWJGODNlUWpQ?=
 =?utf-8?B?S1hYTFlzYTYyNzJJK0kzZnJtWjUzZnZMQy8xNHRhNzVlc1pKNkFka3h6MVlr?=
 =?utf-8?B?RDhMS3UvZGhGdERvZzA4WDlvV2pYTzl6dnFVNnY2ZGZQR2Z5Q294b2VVcGRE?=
 =?utf-8?B?L1c2L0lua21Da2ZJL1VxRVNPRXZUR09NOFB0L1hUVC81YU5TbW9sdW1vank3?=
 =?utf-8?Q?qryT8yciIipi3yHMhlTVi7g+U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e21d47-a7e0-4327-ec29-08dd1ffe618c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 07:25:57.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrJ/Gh913jDKJkbdtksjez0yuu7c6RkzqcbBudKhcbag8roqabyrkCTRHICp5zLNk5qEahpt3iXt04BzDzYe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850



On 6/12/24 09:24, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in config-space, and programming the keys into the link layer
> via the IDE_KM (key management) protocol. These helpers enable the
> former, and are in support of TSM coordinated IDE_KM. When / if native
> IDE establishment arrives it will share this same config-space
> provisioning flow, but for now IDE_KM, in any form, is saved for a
> follow-on change.
> 
> With the TSM implementations of SEV-TIO and TDX Connect in mind this
> abstracts small differences in those implementations. For example, TDX
> Connect handles Root Port registers updates while SEV-TIO expects System
> Software to update the Root Port registers. This is the rationale for
> the PCI_IDE_SETUP_ROOT_PORT flag.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM manages allocation of stream-ids, this is why the stream_id is
> passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_probe()
>    Gather stream settings (devid and address filters)
> pci_ide_stream_setup()
>    Program the stream settings into the endpoint, and optionally Root Port)
> pci_ide_enable_stream()
>    Run the stream after IDE_KM
> 
> In support of system administrators auditing where platform IDE stream
> resources are being spent, the allocated stream is reflected as a
> symlink from the host-bridge to the endpoint.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
>   drivers/pci/ide.c                                  |  192 ++++++++++++++++++++
>   drivers/pci/pci.h                                  |    4
>   drivers/pci/probe.c                                |    1
>   include/linux/pci-ide.h                            |   33 +++
>   include/linux/pci.h                                |    4
>   6 files changed, 262 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>   create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> new file mode 100644
> index 000000000000..15dafb46b176
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -0,0 +1,28 @@
> +What:		/sys/devices/pciDDDDD:BB
> +		/sys/devices/.../pciDDDDD:BB
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		A PCI host bridge device parents a PCI bus device topology. PCI
> +		controllers may also parent host bridges. The DDDDD:BB format
> +		convey the PCI domain number and the bus number for root ports
> +		of the host bridge.
> +
> +What:		pciDDDDD:BB/firmware_node
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) Symlink to the platform firmware device object "companion"
> +		of the host bridge. For example, an ACPI device with an _HID of
> +		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
> +
> +What:		pciDDDDD:BB/streamN:DDDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host-bridge has established a secure connection,
> +		typically PCIe IDE, between a host-bridge an endpoint, this
> +		symlink appears. The primary function is to account how many
> +		streams can be returned to the available secure streams pool by
> +		invoking the tsm/disconnect flow. The link points to the
> +		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index a0c09d9e0b75..c37f35f0d2c0 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,9 @@
>   
>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>   #include <linux/pci.h>
> +#include <linux/sysfs.h>
> +#include <linux/pci-ide.h>
> +#include <linux/bitfield.h>
>   #include "pci.h"
>   
>   static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> @@ -71,3 +74,192 @@ void pci_ide_init(struct pci_dev *pdev)
>   	pdev->sel_ide_cap = sel_ide_cap;
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
> +
> +void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
> +{
> +	hb->ide_stream_res =
> +		DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
> +}
> +
> +/*
> + * Retrieve stream association parameters for devid (RID) and resources
> + * (device address ranges)
> + */
> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int num_vf = pci_num_vf(pdev);
> +
> +	*ide = (struct pci_ide) { .stream_id = -1 };
> +
> +	if (pdev->fm_enabled)
> +		ide->domain = pci_domain_nr(pdev->bus);
> +	ide->devid_start = pci_dev_id(pdev);
> +
> +	/* for SR-IOV case, cover all VFs */
> +	if (num_vf)
> +		ide->devid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +					   pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		ide->devid_end = ide->devid_start;
> +
> +	/* TODO: address association probing... */
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_probe);
> +
> +static void __pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	for (int i = ide->nr_mem - 1; i >= 0; i--) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> +	}
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +}
> +
> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +	u32 val;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	for (int i = 0; i < ide->nr_mem; i++) {


This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss 
especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,



> +		val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
> +		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
> +				 lower_32_bits(ide->mem[i].start) >>
> +					 PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
> +		      FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
> +				 lower_32_bits(ide->mem[i].end) >>
> +					 PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
> +
> +		val = upper_32_bits(ide->mem[i].end);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
> +
> +		val = upper_32_bits(ide->mem[i].start);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
> +	}
> +}
> +
> +/*
> + * Establish IDE stream parameters in @pdev and, optionally, its root port
> + */
> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> +			 enum pci_ide_flags flags)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	int mem = 0, rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> +			ide->stream_id);
> +		return -EBUSY;
> +	}
> +
> +	ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
> +			      dev_name(&pdev->dev));
> +	if (!ide->name) {
> +		rc = -ENOMEM;
> +		goto err_name;
> +	}
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
> +	if (rc)
> +		goto err_link;
> +
> +	for (mem = 0; mem < ide->nr_mem; mem++)
> +		if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
> +				      range_len(&ide->mem[mem]), ide->name,
> +				      0)) {
> +			pci_err(pdev,
> +				"Setup fail: stream%d: address association conflict [%#llx-%#llx]\n",
> +				ide->stream_id, ide->mem[mem].start,
> +				ide->mem[mem].end);
> +
> +			rc = -EBUSY;
> +			goto err;
> +		}
> +
> +	__pci_ide_stream_setup(pdev, ide);
> +	if (flags & PCI_IDE_SETUP_ROOT_PORT)
> +		__pci_ide_stream_setup(rp, ide);
> +
> +	return 0;
> +err:
> +	for (; mem >= 0; mem--)
> +		__release_region(&hb->ide_stream_res, ide->mem[mem].start,
> +				 range_len(&ide->mem[mem]));
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +err_link:
> +	kfree(ide->name);
> +err_name:
> +	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +	u32 val;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_enable_stream);
> +
> +void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	int pos;
> +
> +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> +			     pdev->nr_ide_mem);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_disable_stream);
> +
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
> +			     enum pci_ide_flags flags)
> +{
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +	__pci_ide_stream_teardown(pdev, ide);
> +	if (flags & PCI_IDE_SETUP_ROOT_PORT)
> +		__pci_ide_stream_teardown(rp, ide);
> +
> +	for (int i = ide->nr_mem - 1; i >= 0; i--)
> +		__release_region(&hb->ide_stream_res, ide->mem[i].start,
> +				 range_len(&ide->mem[i]));
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +	clear_bit_unlock(ide->stream_id, hb->ide_stream_ids);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6565eb72ded2..b267fabfd542 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -465,8 +465,12 @@ static inline void pci_npem_remove(struct pci_dev *dev) { }
>   
>   #ifdef CONFIG_PCI_IDE
>   void pci_ide_init(struct pci_dev *dev);
> +void pci_init_host_bridge_ide(struct pci_host_bridge *bridge);
>   #else
>   static inline void pci_ide_init(struct pci_dev *dev) { }
> +static inline void pci_init_host_bridge_ide(struct pci_host_bridge *bridge)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_PCI_TSM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6c1fe6354d26..667faa18ced2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -608,6 +608,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>   	bridge->native_dpc = 1;
>   	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>   	bridge->native_cxl_error = 1;
> +	pci_init_host_bridge_ide(bridge);
>   
>   	device_initialize(&bridge->dev);
>   }
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..24e08a413645
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +#include <linux/range.h>
> +
> +struct pci_ide {
> +	int domain;
> +	u16 devid_start;
> +	u16 devid_end;
> +	int stream_id;
> +	const char *name;
> +	int nr_mem;
> +	struct range mem[16];
> +};
> +
> +void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide);
> +
> +enum pci_ide_flags {
> +	PCI_IDE_SETUP_ROOT_PORT = BIT(0),
> +};
> +
> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> +			 enum pci_ide_flags flags);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide,
> +			     enum pci_ide_flags flags);
> +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_disable_stream(struct pci_dev *pdev, struct pci_ide *ide);
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 10d035395a43..5d9fc498bc70 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -601,6 +601,10 @@ struct pci_host_bridge {
>   	int		domain_nr;
>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
> +	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
> +	struct resource ide_stream_res; /* track ide stream address association */
> +#endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);
> 

-- 
Alexey


