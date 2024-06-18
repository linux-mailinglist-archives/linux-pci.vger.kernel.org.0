Return-Path: <linux-pci+bounces-8925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392B90DA1B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538661C22034
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0E7D3E2;
	Tue, 18 Jun 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MnG1WBmu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1231CA80;
	Tue, 18 Jun 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729817; cv=fail; b=iyYF5fdG2EyGGLRjPbTpHzdOQ1wkV/iwi3JeC3ghQUKG2tQD+bN5EZV+d1EONwZizUZr7yP9GZmFxYUCMB1sykIYWSDMgnlWzz5xDXWw6E20OScn+6Bpp/WepIrTtbA4xeGRkcClWMLZMNUMzOEL0ZFIaeiK601s8kXvvhVCzOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729817; c=relaxed/simple;
	bh=w11Ghqck07dE7ISTofQE/z+yQ6Vfn8ZXlmzyp5ohVEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=emG8qnw3RzL3REqe1helQfrgE4cf/0yQYJui3rh7up4D4Lx0sCzwzMX9s7qFKINhdYFb6+By1rMUZf4avM1f81/EZ+rM7xPnyN0pCAJ0Vovq7hwPWkCdYqIvgfnZT/5eEqM/I0spiBHGe35MaHup+gZvJzVJHeU9gD4xNBA86aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MnG1WBmu; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YttMX9sZZVZXt8R1bTO9dYvSvUJIZyO+XqyfyEszCUXEwymNJUxbSy4gZVSXFvLX3m9MU9cPHCXP4EjhttVKg+I2aRfGaAJ+yTtkDNXvQ1NSXnMSWyHXb468A6+IQFGAX7Z0vk8G4U75hQuceBS+ek2I4dF8uLdF98vHeQcMv1ajYXCDJx2ehZKDqZ04xOHDawRZcbB9UKOZQH7EGVswbq4wKpSBioubW7z/UHvc5oHI0AsRT8naloJlt9NjruXX2dXaWca6vHVjTD90XJgNRPt8WoQ3bmEG7gr5ohwf/LkToBk6MiXYSVVyrnuevhgZxRHncnknUDCvd8IXPQVJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSaMGXwUdZ19lRlSfYl/79UjYbHETXsU6dICCUjiAZY=;
 b=DIPdDSBmBWYJ/jpgIpoF7GvL+DXKZUWJsxqkeJ4u9dI1QKbk27DHj4cUIhNahViHx1EJuvWaDy1RNpELw4FXFF2HFzbQ3WUVAHO8AhVnH9JTHIIZnqWq2z1XqY7WRDtYksYGEC7F975bvGtFEWVfCsT18Q0q8LVuMs1B17JUNMcL41yCZER2TvoVY6+nR5ATipNMEyXlHvV1eHt4BLywxvif2Yi7syXdFSqDcyICYMiM5NZlg4ufykUOJodV59h37Pxhgh0wMcOzERrY4j17UTavc9SZpSpglJoAzbcW1OaPondOoDn2If4bEL92M7vYl8Q1h+qI4ta69XYgW7m+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSaMGXwUdZ19lRlSfYl/79UjYbHETXsU6dICCUjiAZY=;
 b=MnG1WBmurbuiDBzaoBsoITb8fKKTWxOCjLNofnRs2QPuNwWu4Y0bCa3rFmsdXQs3ufHZhhJTyKbV5dmHT63OmcSppTgj9Ylpl1OuAS3Z4pqwjXOy5jXl4OALJjdOePyW/7VqqSrferZfsKUs1r5JR0cVOtZofE0STg0FRpgHnFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 16:56:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:56:53 +0000
Message-ID: <9f465ec4-32b9-4cd8-89de-a57a99880360@amd.com>
Date: Tue, 18 Jun 2024 11:56:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Verify devices transition from D3cold to D0
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
 <20240618131452.GC1532424@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240618131452.GC1532424@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: efa687b2-2ef4-4d12-0ddf-08dc8fb7a75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVFPbWF4NDc0cEF6YWd1WTBCK2hLUmluZ2paVmZaY2JiM2RNd01QWG1xcXp3?=
 =?utf-8?B?NDJRVVZkNGJ0VU1Ld1VPNFE2dUFhUTNINEdlVFNqemZybEU2bVRFNVVsYkh6?=
 =?utf-8?B?UVF2S1JUcHgwSFN3M3daWG15OSs0YUZpd3dNYWRyRVBvRkRvOE13VTlyYjRU?=
 =?utf-8?B?eFVjM0s3VWZCVWZodzk4L1pQSnZNYml0MURncjBEUG1aWW52Rm0rNEkrRDhS?=
 =?utf-8?B?bnFqa0taUzlXNWRycWhvdDNENXVRVEN2SDA3RjVPV2NiTFJQelM5alBBaXpz?=
 =?utf-8?B?bWhQTk1MKzdydk1QWGJjQWcyWkVYZjRKaDZZU2VlN0pnQjRNSDJIK3RqRnJv?=
 =?utf-8?B?VldmUXFmRWpBS0JkY1NEZ0MwY094T2YxUVJqYktZeEJDWU5PT25pUktCSmJq?=
 =?utf-8?B?SlorTU40SzQ1WXRZUGp2akMyUkg4TXFIL2hMQ1dud0U4Tk9aZUVmR0lxM2ND?=
 =?utf-8?B?bEF3WGQvYnJZVEFGTEtNM2YzZ0FWUWxWWlcrUStsSGdDTFVGZW13OHd2Rkdw?=
 =?utf-8?B?SW1odEZZaURnQWlySmxBbG4rVVFaenA3SXhGNWNtRTVKK2Zkd2Y2SGxWTGxp?=
 =?utf-8?B?MW4zenhCSnVSck5mWWhCdWdSejk0S3c3UlN6MWttYnpjMWFwa2FybEkxUEVt?=
 =?utf-8?B?ckx0ZDJDMGpSM1VBTWl0NlkvTzY4QUEzcDZ4VFV2REdCR2Rmb2oxRjF2SnJT?=
 =?utf-8?B?ZWlMS3RzeEdUeEQ0QmpqTmZXZ3A2UzJqSFVlMnFUNUxDeHV3VVk4aFBUSVgr?=
 =?utf-8?B?L1ZJZ0NUMUd6dDRzMEg1WEJheEU5L1F6bEZUaHNYTWhsSmdKbUNXNHBIdjRH?=
 =?utf-8?B?dlV0OU15NmFMUDUvM2gxYkVFQ3llNHJKWFRJOGNGY2o4QTYwckYvc1NDTUJo?=
 =?utf-8?B?NTViN2ZQQ0NXQThLMGtpZERrNGM2VVNwZ1V6blg5M2ZVQmVHWWx1TjZIV2w4?=
 =?utf-8?B?RTM1eXBlUThFblRzaUxqUkFhaW4wZW95bkdGYUhFRjRseGNPZm91THNzcEFn?=
 =?utf-8?B?SVVuVHhSWGpqUEhlUFBMU0YwZitJdDVJTC9mN2hYSHlXbElHeFlFNGJwL2lz?=
 =?utf-8?B?NHd4c2VjaGZvMTNmOUU2YWpNN0s2Qldxc3kwWUhUczBDSzVPM2tPQ01XNjZr?=
 =?utf-8?B?VTVwaHQ2Z21NY1Y0VTJndTdYUlRZS1REcmJySXRCMFdOdWJaSHk3M2ZocjN4?=
 =?utf-8?B?aGUrRFRvaE9KTXo2QzFOcGYvQ3FjVHJRY3Uva085ZDNzWVBud0ZtbXAwZDlL?=
 =?utf-8?B?YzVXcWpkYXBmV2swTEEzYUhTQUxsdEJseHltWWhzcHVWUTJmSkNzQnFVRGlY?=
 =?utf-8?B?U053QXA1Z1lmVUh0Y3hTR2xyNDFnazN3Y1lwNzZLNHZEaHRlakRPeHl6alZw?=
 =?utf-8?B?b1RieGxkMElsTXBOMGZvMnNMcnJvSWxXRmpLV2phWTNuVU9STi9SR2x3NEZP?=
 =?utf-8?B?YmRnRDRsOG9vSm1zWDAxR2Q1M3BZcE9rYXM1Sld6VmNmSTFzejdEc0tHM0pR?=
 =?utf-8?B?eURlVUhPeUNZYldYWmxWbDQ1MXM5MlpvUWxjK2lFRjRhdCt3Qjc2bTlIUWNV?=
 =?utf-8?B?UWRrbnFnYmw0R2hyTHZ5WlBNT1VqQUw0YlhYYkt3bS83LzdDQ2FwV2VUTTY3?=
 =?utf-8?B?Y0I4K2ZJUEo4Wlh4Q2dQcDBCZUxsR3pCYmJnN2pEb0tyNlNqMXhDSXl6c0Ft?=
 =?utf-8?B?N3hFV1A4WHNlSjRaTUhCY2tvT0FsR0ZybC81bXF6T2VSWnV5Mk9VNm9vWjM4?=
 =?utf-8?Q?oJyIP6A3ZRcT48hujk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVcyN1dUcW51ZUp0MmpobUlBaHlMTElHQ0xFS1A4TzJLTURCenV1VFBsVWRZ?=
 =?utf-8?B?cUFxc0wwTlhwUkZVb0tSblJ1SlgyL2hrN3U1Z2RvMTE4V3UvQWoxY1ZLTGFs?=
 =?utf-8?B?UVU1MDZ4QkJST3lCYSsrNDgyQnd2bC9ENEJpbVlIZjVMTlRpejR4SkVIVVNS?=
 =?utf-8?B?V2xTYXZaUXRLaVZSVmVXM2V4Y2pZNzNpVDBra290NFFBQ1dtOVNCV1gyeVRE?=
 =?utf-8?B?Sy9nRDZPQ0pBYnlhZWpkR3lpUWd1WGUvWmMwSHNiT0lEaDlpVGJ1eXdNVnhW?=
 =?utf-8?B?NVVyZWQ3YUIyQnhzd2g0b0kvUjdPWUVZQ0FMSlhNaTNtOU5UeEZ3NVU1NXZV?=
 =?utf-8?B?RzhCbjlVRmR1Q2VHY014SklQYjlUWUNQL1h6dUh6SzNNdUQzUDBCdkJydXRx?=
 =?utf-8?B?cmxSaE9MSGM2a1BjVno2RUx5SThJemdWM3lVMk1McXd3UU00SndxVjkvdFM5?=
 =?utf-8?B?YzJ0MTZIa3kwdytuTUhocFdMZlcxNGVBbjY0b2s5eXlWekVKQkpNbGp3UjhR?=
 =?utf-8?B?ZTV3K3JKWXhYaEFJNTlvUktNMHhlaHV0TjVUT2ZBVTJsbFl6RFQ5Mno5elZl?=
 =?utf-8?B?S0FiY2drT2crWXFISTU4MEVpWWdkdER4c3JQVFJCTkZWMjhDVitIUjl4MWE2?=
 =?utf-8?B?NzloY0dQZjZBMi9WWVNockZSQzRoOGZWZ1NLODR2eHg4ZEtQN0JYRnhmckRF?=
 =?utf-8?B?THJFa0NERlg3WlRpRDdSTStBQzlGam93ZVVzWXB0cXIxNDZGVHNRRTZpMzRP?=
 =?utf-8?B?aTlLZTdvMUZkSlRDQWVwWENXU2EwOUNtU2g4ME9RL01PejE3bTcvb2RGdkNU?=
 =?utf-8?B?eTNURWVLVFhGMXBQU2JVTnIyS0ZxTk5waU4vS1BWTU1ONWpNZUxuNWx3MTg0?=
 =?utf-8?B?WTBseThHWStPM28zT0x5dTJZT0tFdXhjbUdGK1pEcDJ0QW4rNXd4SGp6M1lY?=
 =?utf-8?B?dmxaK2FhRnZCbTFBTi9DM2NPbERSb0t6YThMaWFmQWphTURBUGdCM1FPZlRC?=
 =?utf-8?B?R1dlQU50OWljMUx5aElFNjlwQzNRWjIrSHRzempXaEJuQy8rTE9NTk5vSzZB?=
 =?utf-8?B?WlR6SWl1RUF3bUl0TFJGajNLQVl0bXdOekFyMHpLZmo4OFovSG5BNGhkU1Br?=
 =?utf-8?B?OW5lb0ZBMG14ZWljRWhGZXZ2UkZQUVZhd0dNT1cvR0pkbUhheTJveXdZZm9N?=
 =?utf-8?B?L3FPZ1c2ekJsaWhUUnU3akp4Q2N2T3BWSSsrZWdyc1EreWtCcWlIeWdtMDNS?=
 =?utf-8?B?aGxNdVZyNXRtQkxsaW9tWmtrTVFTTTFLN2E4S2ZyeTk2ZzVPN2FwaUxhMkhw?=
 =?utf-8?B?UTU2UUY3WDlpSHVIZW1uOFJlOThwRURFb3diTHNpTkMybHJaTDBwYngrUDdh?=
 =?utf-8?B?SlZxUjMxQ3B0dXIvVW1RYVJNVjVub0tNV1FjaTFDbmF1Vy94eWZKM3FDTkpD?=
 =?utf-8?B?dGVLWjBmTHppL3dUQUJmeVAzUDRWa3lyeHVPQ0JGdkZrMDVlS0lnRncvWVpH?=
 =?utf-8?B?K0NaTlh4SXdvclkyRVNlWkZLYzBEdTQ3UEhkZG9xOVdwT2FBMGh0aVl0Tnlq?=
 =?utf-8?B?SmJsOUcxV3EweXB4dnVZMWptZkkzWnV5dTgzd20vVGVZWmVpSVhzQ2cwMFZS?=
 =?utf-8?B?YVVVaEtZbzJHZ0FWMDE3TnJWeTdXQ3BYdE5NeHBzZ0d5ZStVeFNVMjM0eTlW?=
 =?utf-8?B?RGVJL2VaTDI5WUtTY29qN0JkS2hPMFRFU0hQbHVpUkR2cHEweWN3dExPdVRH?=
 =?utf-8?B?WDFIOFRGTmVNMDdoOWx3cnhSSnZUQmNZa3lhYUx1RExJdGxpSHdKYXBhOThO?=
 =?utf-8?B?a2RmWVVWRlIvRFlhZ3lTSVp6WmJwbWVPaDFhOHdrTzd4c3N3dDh4NWdZUTJy?=
 =?utf-8?B?a2pGS2cyWXhWN3pnOTRHZjNBdmlCUklpSnlReDAxbEJNVEgwR08reHRsTWlC?=
 =?utf-8?B?SVRGcGNxaFlwVlVjRWEvdVFhaVZVZGd4UFp1aDRtbGttOTFvMGJwTG52SVBH?=
 =?utf-8?B?T2dNc2FHWnU2VzdyUHBwK2g4bWlHelBVWFZQR0pOMVI1aUxnbGFkRlpHWXZI?=
 =?utf-8?B?MExxVjdSSGwrbGpNZ2ZIQ2hxZ0ZvQitleSthTnlxY3NhQzUxQ0V3MlZZeUt4?=
 =?utf-8?Q?4DEYYl12FpblQa+y5QtVVD1VG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa687b2-2ef4-4d12-0ddf-08dc8fb7a75b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 16:56:53.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wpVySZM1B1e4FUszj2UX9mJ8MGSe4fv/o9oBUwUvv7eWLFuD2Q+bUz9Zc2GiG/qmsybKr0CS1jwPxSblSKdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

On 6/18/2024 08:14, Mika Westerberg wrote:
> Hi Mario,
> 
> On Thu, Jun 13, 2024 at 12:42:00AM -0500, Mario Limonciello wrote:
>> Gary has reported that when a dock is plugged into a system at the same
>> time the autosuspend delay has tripped that the USB4 stack malfunctions.
>>
>> Messages show up like this:
>>
>> ```
>> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
>> ```
>>
>> Furthermore the USB4 router is non-functional at this point.
> 
> Once the USB4 domain starts the sleep transition, it cannot be
> interrupted by anything so it always should go through full sleep
> transition and only then back from sleep.
> 
>> Those messages happen because the device is still in D3cold at the time
>> that the PCI core handed control back to the USB4 connection manager
>> (thunderbolt).
> 
> This is weird. Yes we should be getting the wake from the hotplug but
> that should happen only after the domain is fully in sleep (D3cold). The
> BIOS ACPI code is supposed to deal with this.

Is that from from experience or do you mean there is a spec behavior?

IE I'm wondering if we have different "expectations" from different 
company's hardware designers.

> 
>> The issue is that it takes time for a device to enter D3cold and do a
>> conventional reset, and then more time for it to exit D3cold.
>>
>> This appears not to be a new problem; previously there were very similar
>> reports from Ryzen XHCI controllers.  Quirks were added for those.
>> Furthermore; adding extra logging it's apparent that other PCI devices
>> in the system can take more than 10ms to recover from D3cold as well.
> 
> They can take anything up to 100ms after the link has trained.

Right; so currently there is nothing checking they really made it back 
to D0 after calling pci_power_up().  I feel like we've "mostly" gotten 
lucky.

If you guys agree with this patch series direction this could 
potentially mean cleaning up more code that exists for random delays in 
the PCI core too.

