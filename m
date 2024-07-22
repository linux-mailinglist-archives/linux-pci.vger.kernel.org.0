Return-Path: <linux-pci+bounces-10602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF59390E8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7B1F21DC2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150716DC18;
	Mon, 22 Jul 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pTzyj++W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAFD16C6B8;
	Mon, 22 Jul 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659483; cv=fail; b=PcgauL83P4k1PwOAa3n4OQyaNAqnvYavFwSBw8N1caXzTZ8yW7u+7hIZgqCmMuVcwZivuqsj7utLmcZ4ipZvr0Ko2pAJ5zogJoGXIawn+TbX89sW8xkBfWW5wkcbZDy1jRdAtIhV+4kj/+hn+eYy/5J6U12u8fbwyVy9exMkSdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659483; c=relaxed/simple;
	bh=2AaWthoV1+DvqkjVlF0Ejhy8eSd+vnFJNS0S/cADwm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGD0I/cyjEmo2J7nX7XRSMCbryLSZcSm9flH5DE/dPQ0Ya9RZ9mCk/9FwG87Jm9k1I0P6jcvS9lLZqbUJMxJ0PIMbV5YdJQ8pIDsH0v+G9LjAD2vr9RDpu6F7KDLq/0EQPahGhVaqUnnPbOkFp4ajvVKUl76CxMl9A1CDL/PGEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pTzyj++W; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neQB/FMAcc+y8Fk16lOLLUo3SAAk4WiOgwhu7zroXN0XTomSRlMkQ5z4P3kDxWtJpIdeaoUeohvmqKeJNd+GvkRStCIA8sTthwhv85oCuZSMG5OefBrqSDHS5wNwCn3OMba012rWsvd4fLxbjqegejFRc1tK7zEKw8fAr77VduyFYVOnpQ3X/WMHeKbpsSFIWem+0XbXfUdHM2FRViUz5U6B1dOoYdDSoXjkZ/zUpD4cMlemkfcvMx49dMPXhDs3TVA7epVhotoZYfq0l4Xlbc62v+TolhI8RxSmwrawafmPFU7S1mNGiQFnw56u3ZrNz1iz2HEQao6JhZKS51SP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGKDmGtf4vL4RUPvX0vsFvvSLKUoJ5W0nPY+kwLilgE=;
 b=O58Hn2nnUa8SYTYZEB2u05tPZQulQIxLOitseEc3BjD21iYw8mQdRr+fH2ng9nMYKIwSM/etzOhZKoeFKmd1r92Q97srFT2sphbfdOLvvG/nZXsNz2e26xcNWLt9R5SpoPq0eGkh7Da3BC7gIKzvssWUcQSSHaCYTtNqziiEKXhZKp/QurqFi8EouPwmTlWTbdpOX6NiH6IUv/7BdKDtqDlaVLKNV+8Fm9ig7SP3zb6hcJSZQrMb4yUh7oUTEd/0vmyyIxAVYC7Ufk5/uAZ4HNdwmNJ/lWSDdwTWmUnrvRrJwooy3IPegNDgEu4Vliwsl+KMAXOih4Z9wtbBHrnAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGKDmGtf4vL4RUPvX0vsFvvSLKUoJ5W0nPY+kwLilgE=;
 b=pTzyj++WSW64//XjH+uUl1rMzbiS3r0vHf+xYzALkxNV1dT3EZ5Nw2/DsTyAQljmfB5I64Kl2cFzgvq4xO3Vt8waF9daMZ+HUUY0B0xOB1d+KcvKMU+HJLUR8QUbLOvwczS93LF3baYraFFbBWXUEpWZMLZeKWLUZWAyhJ8oHQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 14:44:35 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:44:35 +0000
Message-ID: <612bf6f2-17a4-46fe-a5cd-ecb7023235ef@amd.com>
Date: Mon, 22 Jul 2024 09:44:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/10] PCIe TPH and cache direct injection support
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 Paul Luse <paul.e.luse@intel.com>, Jing Liu <jing2.liu@intel.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
 <ZptwfEGaI1NNQYZf@wunner.de>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <ZptwfEGaI1NNQYZf@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:806:d1::13) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: d11a035b-999a-454e-35cf-08dcaa5cce03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWc0VllnZ280cVZ4dXJDMmRwSmg5T2FEbGN3eExLbm5yR2R4eGY1K093ZzYx?=
 =?utf-8?B?czNHZ2pha0g3UkNzM3Vrc3k2WGk4N1V1Q3dJcW8yVmlybnNlSk1zTUF3REVK?=
 =?utf-8?B?N2c2NmlYU2dOSXd2NUpnMi9FS0k4Y05WbU95Yjd6MldQY3piSUlYY3AyRm40?=
 =?utf-8?B?RG0rVUpUVDQ1SkFzNlloUGpmMWt1ejNKeGNEaGJoZWdBUjdnYlNweWZ3TVhs?=
 =?utf-8?B?cWdBb0xPcGRwWGtTOEkvSEk1aXZpdzNpUXhmMXVYL3lQODNsNjU5ZmRCWXA2?=
 =?utf-8?B?QTFVUk4vWnVPbDZQTDlPUWh6cWtiUlpoMVI3dzB2ZDYzMUlGNVRYSXVIN2V1?=
 =?utf-8?B?akErYXBMRWZZVGVyOGVDZWZLSlliYXNWMDUvVHhnOC8zaEJXd0JKbTdyWVJZ?=
 =?utf-8?B?eUhRQWhJNTNBRlBiYnpMOFZ6d0ZFSlhkQWVIVG80Y25qYXprRlNMa0wwQW1C?=
 =?utf-8?B?UmhnRys5WUhvM2xvb3NFQjdpNnR1MEdRV0YxNnI0ZXFGL2lYK25DVkZwNHVS?=
 =?utf-8?B?enA3ZmJzZHdLU2taRFVkTDVDU3FQWFhuMS9pbHFzdzV4TXM3NklXbVg3RFZo?=
 =?utf-8?B?NjR3aTIxU05qMERrTS96OWxwWW40d0RHU1Q2VjJObHJLcFQrcFUzN212S05t?=
 =?utf-8?B?R0VlVy9uM05uTkFrYld5cnlmTzRLaThZYVRkY3lDbkRyQjhMZXFiTnZSeWJL?=
 =?utf-8?B?Ry84aDM5bW1xZ1piYlp6Y1R2c1pJZy9QamFETVdrdkdTOFp1d05lZTgxWTEw?=
 =?utf-8?B?b1EvOVpjWjRMQjN3YUcvMk5EVGxWVDMwVUJ1S3crYm1FeXl1anJGNWFRSVVP?=
 =?utf-8?B?ZnZ6NGpLQkRCOUhxVXQxd25jcjQ3TW8xcklUMTVpOVhCcHR4Szd2SUxydFBt?=
 =?utf-8?B?U3NqSVpYRzJ0M1J6U1d2VXo2SWtQWlIzV216RFdsVXVhK2thNDJSSXdlU1FZ?=
 =?utf-8?B?N0hXOGRvQ1ZkOHN1UmtaT1kzZDJhRlRMc0txbVNTTDBqNHliL2FYcnlYMGtj?=
 =?utf-8?B?WmRWMjZ4VTdKN1lwL2Zpb2hnTzdOUGpZWUtIaXJjMDhFUHNrSUFHVzdNN0NO?=
 =?utf-8?B?bE9OSmRpKytRbTBFRkV6dkZpNGJUYzlYU2ZPZm51anVWU1U2eUprb0NYdVZX?=
 =?utf-8?B?U1VNNnFEaXh6dk9QbFhLcXpuZXJMK3hhaHdYK2FIdm5kVkM2YkRWMnFyVUEx?=
 =?utf-8?B?NEtDdU1oYmhjbXZvbWw0NlhuYW5rcjYyaFdFRXZOS1dQWWJvM2pQNDU3VDZo?=
 =?utf-8?B?Q3BHMCs5ODNxUGNnZkd4cU91NkkyMTNuVFlQaE5uS1VUUm9QM0VJckE5R0Ro?=
 =?utf-8?B?VTJIVE1Qc3UveG1YVlNNSnFMb3drWXQ1NnVSMXZLWDVrQnFNSHI4eVJweUdr?=
 =?utf-8?B?bUV4eHRkbWpOODFQNi9ja0xtOWxQZGhSWTFLVGJ3VTg1aWpGb0hzeC80bDM4?=
 =?utf-8?B?cnVhNVUrV2MvN0FXS0N2RW5EbW11Y3RzTHBiazljNnpWKzk2S2h6YjIrTk1a?=
 =?utf-8?B?NEpNNXY5dE1aQkZtTk9qbE94bnlrZDVWYjBxWVFYOHZ2QTF2U3BUa0tKNzA3?=
 =?utf-8?B?WHROWFVsQ3kvYmpVWmRYR0hWUE82cS9mOXUvNkZiRmIycDdLQXRDLzhla0hk?=
 =?utf-8?B?WVptSkdyK0NiYzFReTVxWDNpeUJwK3lHTmJIM0ppTm05NUFLRGNUTG1WVG9S?=
 =?utf-8?B?L1IrMi9wdWpqN0YvTldNR0hLa01ZbGpZMXNrZUJsSlRaRDIrNkRHSVhDY2sx?=
 =?utf-8?Q?GYXng04JgTsPKkocHwVBvC6XbLwU6Z00T9d4j3a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3dpNmYwbFZ2d1YwdVlac2pRb1owUmhjU3g1S05NdkZTbWw3NTdXcjAybzh4?=
 =?utf-8?B?UHp0dEhMNEF0MXlTK0NIN3dHMVVxWVlITE5rRXFyVkV2TFg0Yy82YUplT2Q1?=
 =?utf-8?B?bG55NnUxTHlkb0tmL0w4dGR5OC85aGg1anFyb2xyTjFJODZ6d2dBcnREUy9J?=
 =?utf-8?B?cFpRQmxGNElTL1c5MjJjVFZaMzhiSWVUK3FKeldnd3dSbWNCWFRWTWZLRE5T?=
 =?utf-8?B?R2ZWRE50MTVlTlhhRU91ZFlpSHI2MUxLem9vSG1ud09mZjdrYkM3UGNhZDYw?=
 =?utf-8?B?aUZEM1lwS1Znd2FwS2tUYUp6TUhMc0czSG1jQjVOWnBMaGNmRVdraFF6eTV2?=
 =?utf-8?B?UzROZkRvSUt2c2daK0NGTEYxaDZaZzRuYXlLQnVJRnNqdVdKOUVPeC9kQVQy?=
 =?utf-8?B?Z005eWNPdzQzSHEyVHdBTzlCSEFwaDRZL1hzdGNTOEQyV2FIUklnSm5uZlFQ?=
 =?utf-8?B?SWM5YkYwWmhUd0VoVjdaUFZLRDlZTDFHMXlCN3p1R0wwM1o0clUxZ3p2WnYx?=
 =?utf-8?B?L0lqYjFpTi9aZmZlNGd4cFYvNWhsbXVlT2Yvbmg3aDNYdDQwaDJxaEFFNW1m?=
 =?utf-8?B?bHlvbXEwMmRuOGxvVnVmOFJpSzVGUGNic3ArMFFURkhpUlQ3S2dsK25nM28x?=
 =?utf-8?B?RXY0bXloM095T3hjQVFiNFRZMzlFMWtnZDYwS2M0eEphNS9nUURJZ0hMUys3?=
 =?utf-8?B?UGx4SmhyNUp4cFhJQnlNcHZrVVlLeUZlZG9aTEd1M3IyaXhEV0EzTVRCdzJZ?=
 =?utf-8?B?aURnMGJUOTF6dVIrek1iUnArb1ZkMVViY0xUS2xxVjh2b0ZMTSsyQTNsL3pj?=
 =?utf-8?B?NmlhNnZ0SkdPVEh2Wnp5K3FiZU5XclBBbHFQVnc3LzhhbkphaDJZbUxYRWdO?=
 =?utf-8?B?YTdETDRkNU9PbHJtd0EyWE94T2hwRlF6OTRVeXJ6QnhJVWljWFhCdktxVlVQ?=
 =?utf-8?B?TDBmak9MTHA2SWtLSU5vRGw0T1NOQWY4MEtoaWcrWGFhVE5qVmF1RTRwQzRo?=
 =?utf-8?B?UkJqUEFIU055OXJmSll1aElOMDN1MlNsdTZ0cWdCam5ZUUJUMjMySlo0Zno1?=
 =?utf-8?B?RjBaYlJieUxoTlAranlKZ043ZFdMRXU5MUkwZmw3OXJmTDFucm1EYVphVUs3?=
 =?utf-8?B?VUdobDVUOVVEK1NMUWYrcnhubis0cnhZc2g0a1pXWlF3eHdJcHROTjJZOExp?=
 =?utf-8?B?Uzk0SFU1WFVydndxRkxvYVdheFdOdklmTDZPK1BXK1FZR3JZMkhZUVlSUWZD?=
 =?utf-8?B?aXRGZlZuSHFoQUl2UGVFY3R2ek5nTGRWc0NFdXZCN1cxeDdWdHplVjhHZE5W?=
 =?utf-8?B?WmwrTVdDd3Urcys2RmpHMkRBbGR5MGxSQ3JQc1FGVVM3S0s5TW9WR01RZW02?=
 =?utf-8?B?cVdTeFY5R0hrYVJGaHA0aXA1VWZTVElQVHlOV2NETHNWQkE4Y2lucFlydEk5?=
 =?utf-8?B?NUxTVmN1L3ZWOGhrUDBVWHM5NFBEemRrSkx4S3lCT251NjdKRUdwanBlSnZI?=
 =?utf-8?B?WUdnNVVqSi9oL2FGVEVFUUdQNnFmNUphRjR0Qkt2dHNkNS9rdm9QSExRUXZp?=
 =?utf-8?B?eXFGdFFKcStiUXBZd2x6NWRzRUlSNGd2dStZaWNrc1ptWURnTjI0OEkzN3h0?=
 =?utf-8?B?eUFSc2tiT2RZUGh6NEdsbXRvdlhrZjl3d1hMS1ZoelA5SlBJTmZCWlErVDVC?=
 =?utf-8?B?SWhCZ1VoVlV3OEt4Z2lzdy9pbHpiZStISk1ETkZyVi9OR2hhY0h1ZHNQaGFi?=
 =?utf-8?B?SGo1c0J5NjRHWktUQ3RVL0d3ZkMzOFU0cVRzbVlHYjAwbTlxYTFiM1BUVFRL?=
 =?utf-8?B?UFI1cFZtQ0c2M3VxT3BhM1QxSy9EZlhlZjlnZW1BcWdtenR0V0pxem9OcDVo?=
 =?utf-8?B?NEk3VlY3bE16MTEvTGIwVnRvVUpWK2dYdFdhSmpNY1dYd0NoKzYwcFl3NERI?=
 =?utf-8?B?aElPWUhJcFRXdHZmSjByNE1xZzdVQ1RFK0tWd2xlR05qTVZiS09Td1EvSnlC?=
 =?utf-8?B?REZCY1d4bXpySnZpci9yeWw5ZElVaWFqRi9JSG5JUVgzdVVDVjk5dEtBVElK?=
 =?utf-8?B?SXUrcWR6cEZkMHpwM21Tejl1cFB1VmJQdmorSlhsS2tuU1ZFdG12YjBjQWl5?=
 =?utf-8?Q?MkCY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11a035b-999a-454e-35cf-08dcaa5cce03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:44:35.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRkF6vMsPH7vymFQS3ggjkqOCpe4sg3BPB6Cb6eZZQxnRnm271yTbEpxOXtkD2qQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251



On 7/20/24 03:08, Lukas Wunner wrote:
> [cc += Paul Luse, Jing Liu]
> 
> On Wed, Jul 17, 2024 at 03:55:01PM -0500, Wei Huang wrote:
>> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices to
>> provide optimization hints for requests that target memory space. These hints,
>> in a format called steering tag (ST), are provided in the requester's TLP
>> headers and allow the system hardware, including the Root Complex, to
>> optimize the utilization of platform resources for the requests.
> [...]
>> This series introduces generic TPH support in Linux, allowing STs to be
>> retrieved from ACPI _DSM (as defined by ACPI) and used by PCIe endpoint
>> drivers as needed. As a demonstration, it includes an example usage in the
>> Broadcom BNXT driver. When running on Broadcom NICs with the appropriate
>> firmware, Cache Injection shows substantial memory bandwidth savings and
>> better network bandwidth using real-world benchmarks. This solution is
>> vendor-neutral, as both TPH and ACPI _DSM are industry standards.
> 
> I think you need to add support for saving and restoring TPH registers,
> otherwise the changes you make to those registers may not survive
> reset recovery or system sleep.  Granted, system sleep may not be
> relevant for servers (which I assume you're targeting with your patches),
> but reset recovery very much is.
> 
> Paul Luse submitted a patch two years ago to save and restore
> TPH registers, perhaps you can include it in your patch set?

Thanks for pointing them out. I skimmed through Paul's patch and it is
straightforward to integrate.

Depending on Bjorn's preference, I can either integrate it into my
patchset with full credits to Paul and Jing, or Paul want to resubmit a
new version.

> 
> https://lore.kernel.org/all/20220712123641.2319-1-paul.e.luse@intel.com/
> 
> Bjorn left some comments on Paul's patch:
> 
> https://lore.kernel.org/all/20220912214516.GA538566@bhelgaas/
> 
> In particular, Bjorn asked for shared infrastructure to access
> TPH registers (which you're adding in your patch set) and spotted
> several nits (which should be easy to address).  So I think you may
> be able to integrate Paul's patch into your series without too much
> effort.

I read Bjorn's comments, lots of them have been addressed in my patchset
(e.g. move under /pci/pcie, support _DSM and dev->tph). So, as I said,
integration is doable.

> 
> However note that when writing to TPH registers through the API you're
> introducing, you also need to update the saved register state so that
> those changes aren't lost upon a subsequent reset recovery.
> 
> Thanks,
> 
> Lukas

