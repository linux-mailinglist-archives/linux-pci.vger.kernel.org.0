Return-Path: <linux-pci+bounces-9253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268E91726B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E9F1C20DCA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB716FF52;
	Tue, 25 Jun 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tqcGj39Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2A17CA05;
	Tue, 25 Jun 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346820; cv=fail; b=GuOSnIYt5pLDYXvhbgLlNwc8P0rfiIrxUAG5+mlr5bkrBPeSMsZlOr298vvZrYya4mx01D8WLSNWbjeuahbVTEgyT5paOq6I+4E4DFEvdAOZ0yw7i8H1l0QhbE/KEHdtejmMeesiXJIUqRJoqKLRmWZvXz+Ln2XaSadXyxVWmHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346820; c=relaxed/simple;
	bh=uJo/QqQXFSfMg9CoTYFkkPPuu5L/s3Y+CuQF86o6XwM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=rpy4KjZfXvIKqk4Wv8CHy49nrXohC6WEBeD80LCxjuUSRgqEa1r1hRi8p9DATWRPwcKqo+wSTCXofI5As4M8oA8OyP4i14RA6GBubb3sVGCnlsUPXr+Pt112+aWbwteImLOnEPpNo+hWswBy3tUs3kbVRXNVnQhKG2eUVJwYfms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tqcGj39Q; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/NftAJIsS4+QBMU2wOtka3VFlfbPR1pyF7/iJBt1jKX0tkSne9YqQgp/KlcosSfY0voHXaitCkTKsr7dX5+zNLzNuKlKMp3lrb9x+pnsh/2j/E1p5oOCE0aAPJkJ0k3jKp7AxvfKBY8KS1Ms/J9QpKUVTjPbKdrpH4BpBMOvm2o3w/anNUU4nlXe83VW/bGtlmmmnW7CNqqIAlHc+mAG7vGew8l6fa//sqIArzaj8YV/qCEJu5lEKP731b4ndLZUE0dnMeajZqPpRvBUShMNVC64h9JQM5//g6xTM7idvFqIY+UMjpOzN2756xU35BB++d0jRVeM8vrq/hLZ1c8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGjF5Wi2wbkBLdXiZQhwhSyHEPrxdC+OXJdxik9M6Cw=;
 b=RmAwc2RFuls69HvQa5+ehM2RDc3RVfc+Tr+1dhrNnLJp0YUsEkSDvOpDK3BcFdvlc2BUA3Yb4sJXjkV1bZtn5HoVvBMUuEW/KZl7s0FQDAVorrFGM3n4gZIz6PsKEVRJ3p9LAt3MzNPTe149nl5g4ILNrU605MMmr20z+JJcGdd1AJh0Q2oXzjWqIi1JuT+Y1ujBmtbwdNvNIwbY5F4LCbfKvJqB2HWZVeFzyOI1MHn0pna37fIh3Wsk8t+PZuK1JfBEb12yj+44L24tFat+x1xf02bq90kQIPAB33ipPLZEeB3lKYoh9z1PjFsq+jln997M4gTG7JdafE8uKim5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGjF5Wi2wbkBLdXiZQhwhSyHEPrxdC+OXJdxik9M6Cw=;
 b=tqcGj39Qu/PxBPXiIDnjEraAVQC9Z27TjAncTswni+rnp8WzlPuJSwHuk4yuFN3p2Bg+6nFwjW2Q5JuR9FOMojf0CWqn8pPzUoIW8z4r6GtDI5vm1EvnhXYBJyjWbhNEffs8xLaiflX97iyetK3fMZYPjuYcSTu1FsZIkoeqc3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 20:20:11 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:20:11 +0000
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
 Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240617231841.GA1232294@bhelgaas>
 <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com>
 <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com> <ZnKNJxJwdtWRphgX@wunner.de>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <73fd7b2d-9256-9eba-70be-d69ea336fd67@amd.com>
Date: Tue, 25 Jun 2024 13:20:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <ZnKNJxJwdtWRphgX@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: be4406b4-e1d0-4527-aba5-08dc955436f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkVWL2svSmVWeEh2cE96MjRMdXZMZUo4SFhaM24zRGdmdHNKWVptN2FPTkpC?=
 =?utf-8?B?M0FhZGNzQ3pqbmVYa1pDUksvMGJ3Nzkwc0dVaUtnSkdBOFdvR1V3OXd1YlNZ?=
 =?utf-8?B?clJ6di8wYnZDUStibmR5MzRhZHFBS29lNkpYSkd3ejJsWW5OUW1hMjcwTmxj?=
 =?utf-8?B?VW84ZFlJS0FEdHVhOTVHN0RKVjV0c1lJUDdNTkV2NWl1OVFVV0d5aWxxd3Nn?=
 =?utf-8?B?Tkg1Sm5PdEpCc0JEL0duK0p1ZGQ5VmNQUWZzWnBCK0NzbExMSW5oSkpUc0J0?=
 =?utf-8?B?NDZaS0ZmemxIN1lwNndDSTJMV0h5WUp1OUJzREJzQStQK2d1T1F0QmdiSFI5?=
 =?utf-8?B?NThGRjJUQ0NsemFYaTNZNnFpMGEyVmpKOHhoSkxLT3ZZOTV2cGtXYkcvMUpu?=
 =?utf-8?B?OGVYY1B4Vk1JamE0VzdxV2ZFY1lnTXV2bVViMjR1akVPODNYd3RURHNjL1ox?=
 =?utf-8?B?b3FVTVhWazJpN0JZaDdodkJJaHk1N1I1ZmwvNXpsUzBtSHQ4cHpkSVEyRjgx?=
 =?utf-8?B?Z1l0WXBEdW5sZDdxWm1mMkRQeitJZ2lZeGV2bkltamNjRWxWKzRjU01uMEJZ?=
 =?utf-8?B?emJwbWpYYVhBZE1HYWZsQ01wdE0rY0QyY2k2bVRzV0lUYVNJYTM0ZTBCYWw4?=
 =?utf-8?B?N1pLeEZzbldCcXlqMkZkcVoxVE1tODBBY3Q0TXYyS1ZIY1lrUGNwdFZ6Mlhj?=
 =?utf-8?B?bUNvdDFabGhvMGk4bHlPazBaR3UvMGtDR0ZpOFFuUTY0UFJ6K3FQN3dCcnps?=
 =?utf-8?B?Q1pZZFB0ZEJ3VDF5VlErUFFRRWR4M3NxcjFlMzF3K3BGbGprVStmdkZnRmJp?=
 =?utf-8?B?RkR2Y2ZEcU5WZ0VoMGp4aG5EQkVZRmd5ZUlFZEFJQjB3bFdLbW1SMk12d015?=
 =?utf-8?B?cmx1V1lyZnpkcFc3QWF1QW1FcVZXcGp6cHoyTHFmQ1RlTkVPVEVacS93a3Q5?=
 =?utf-8?B?ZjJhRnZJc1p0SmV0aGVQNzhGVlpZWkdkaUc0ZEVObnVCUllvQ0I2Sno1bjN6?=
 =?utf-8?B?K2prTysyeEdOYzMwNjNGVVNONVQveE8yVlh4b1VkYWZFeXB4RnVrZVVqOWg1?=
 =?utf-8?B?OXk2TkdmN0NXYVJ0TExCM1dKRS9BOVFmY3g1bXZVSG5DbXh4L3dyVFkxNWFq?=
 =?utf-8?B?MmtNYW44cE94WnVqT3RFMFp5eFVaVTFXT1NPUHVML0x3UVNkTXVrRUttZkMx?=
 =?utf-8?B?WUZPWm5HVGh3ZXFQVzc3RU5zenJlOHFQVzdvYUNkZ3YxUkVRYjVMUnhWOTVp?=
 =?utf-8?B?REVkYXFoczV5MzlpMlo5TmRRU1VQeFo5bXdWNitnaTQyaVJSR0VIWWJlVjVT?=
 =?utf-8?B?Z3JBZjFhRWd4a3ZKMnM5QVB5VmhqVGRoSEwwbC9mUUFBaDVUcjV3UWdVU2dI?=
 =?utf-8?B?ZndLTWZGcVhZN1JuVlgwNzNvYTFXUzRaaFlVNmRaZGp5YUhEZkZQVlpVK0lZ?=
 =?utf-8?B?NE41SmtYR1ZxRDFNZ1dVL3EvK1VFdk4wZDJvYTF3VGVJMTVRTG5OU211Tm5D?=
 =?utf-8?B?eGNDVTVYWWU3OTFFTzRGeWVzb0k2WnRpS1pXS3MzNllHcitBMnVwZ093Rk16?=
 =?utf-8?B?dk5BTzZ2SlJVU255cityeStXYkg0cXB0cE14c0xUanBQYjEwQzJsR2RRLy96?=
 =?utf-8?B?MEpsMW1VbzFZb2kvMENOL0N0emNxT0xCL0NXU2hjeXNKd1ByK1B0anIvbE5T?=
 =?utf-8?B?cVpJMFdYYWhZNEJEbEJpY0JFdHpMTGhDOVh3RnN4ZDhGdEVtdjc3citoZzR5?=
 =?utf-8?Q?grALFeYTvcsWxUAdRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YldBVWJpSzNUUVlyVmZmOU1VV3dVRHl0Rk4rVFE3SkUraVFGaE9aVmhXS1Zj?=
 =?utf-8?B?YVJUTEs4WmljMWVLbWdHZUJsMEpWYzJ2VUJ4eUFVMkNXTDQzcHJpMVIzanIv?=
 =?utf-8?B?WTk2K3V5MjVLTTI0T1hqcnVDMTl5WlY3NkE3RjVVUHlwcTZEWlhPNGhjRXll?=
 =?utf-8?B?cFdkRTBMN0pDcGt0Zi9Jbzd6RnMwYldrejcxaGxldFdvNzI2OXgzNWd5Ty9X?=
 =?utf-8?B?Y2VsdElmdFZIQlYwTU9USFlTY1MwOHVaaEZBbVZEay9aaGdZNGpIMjBaOW9F?=
 =?utf-8?B?a01DWmRTaGZaZkNPeE9wYVJsbm4rSXRRU24zZ0RNNHNOS3RPVTVJQ2VHUFJW?=
 =?utf-8?B?OXRIVVRYaVB5eDhWY1UrWVA3USt1SWFLbVNVd3VPM0diM2t3ZnY0SWx1QjVL?=
 =?utf-8?B?MktvUEpDTEdkWXlPektIVllRQTZmMUhHZjJET1I2TTJUWDY3ZEMzR3lDaGFE?=
 =?utf-8?B?SmVxU0oyS2hocXhzUkxtcHJiWDRMa1p6MUQxcGtieTZsem95VmI0b1pVWnZK?=
 =?utf-8?B?bEp3enY3b1BpbFYzMGFvZkFWOEdJcUt4SzVPWDVNTjlyTFNHRDlyeFRUMHIy?=
 =?utf-8?B?ZURncEhpait6NHQydnExMTVlWllOZ2JzZEkrdUZJeUR6d2EyZkZYaFpsSEFh?=
 =?utf-8?B?eGFNekFrMFA5dHJja2hRcVJlekRleTlQV3dxMGtVMjM5NlBEWTRFL1dxUHJB?=
 =?utf-8?B?L3JLSWh2eHRyODB0RXpFajZESk5DUU94L3lkS1g0WThhcURBRkxFY0o3T2l3?=
 =?utf-8?B?aG5ibm1MVGVuOVlyQ014aGxsOW83Rk1SRStBNUNWOTBnWFlMckpYbFQ0RVIv?=
 =?utf-8?B?QnRNa1pqOTJSUkpXb21qelplWm9lWkpQREJSTFgzczdFdlhWaG5pUU55bVVt?=
 =?utf-8?B?MFVVQ3JqSzl3SFpGdHdJVFlqSWE0S0FreVRkMStyODBSTm1KQ3VHVktaSXNt?=
 =?utf-8?B?UVR6ZklBbXRXM1lsQVMrbTdzb1J5ZHUvdnNPQ2RMVkVFWDdHMkl4bktkTkY1?=
 =?utf-8?B?MVo2ZlFRWUh0K0RwaWs1ZEhJWThQdkk4SnFVS1owRGIwMWpGengvVi9kbnZa?=
 =?utf-8?B?QS84ZnhHR2ptOHFkUDBtZ1FpN0RtanJ6NStZRXIyaWs4SkJ2UG1EOFkyOE13?=
 =?utf-8?B?N2hic25acXR3aWdDQ1dVWnNMMDZ6RXNySm5Wa0xISS9pRUxNTjlOYlVSTjV2?=
 =?utf-8?B?aGJnWUJPSUZINlZOaVhCTmk0ckF0ajYrMVVEN3orc2ZNQWlZMWROdStaazFi?=
 =?utf-8?B?dmh0aHBZMHNYbTdyNzZpR0R3dXRKcmw5dDdnRGlnc2dqOFowdFJFalNLN2d1?=
 =?utf-8?B?eEtOeFVoVkFMU2xLdmt6UlpYYlNlaW1ZdmJFbkxUdEtmNVpxcDExYitQZWR2?=
 =?utf-8?B?Rm85czBYcHF5Z1VIcXFWNnI3Zys1UytrNSt3cEsvMWE0dGVPd3hRN0JNN1ls?=
 =?utf-8?B?RUxqRlZJNUFyYjk0SldtbmxYSUNaWXVSblJPUHMxQ2pJWHlPMVRvdXBmTXp3?=
 =?utf-8?B?MUFJb0R5MnVOajh5aXpvUnVKNzZ4cFc3ckp3N2d5UDhJaVY0Sm8rTmhpSGtY?=
 =?utf-8?B?TzRkNUxIdExXZkw2ZnFnMlJydnlKQnplc3p0RGFEN1F5UTBjK0MwOTdSNjEx?=
 =?utf-8?B?MzFRNHFYaFFMdHM4M1ZGOC9iMXh0Z2ZsUUdRa0JPQ3Q0bjdINTBSR2tNRzIy?=
 =?utf-8?B?RkgxdCt0UVB1OEhBYnhOUEgxYTh0d2w2OHRYQmZ6Mk9jTlhPYjJlQlU2MEw5?=
 =?utf-8?B?YlI4UWRiNkRqcVNCazlyL28yQTB5S3E5WkFWNEQ5M1dabGxoZ0VwNnAvdjBY?=
 =?utf-8?B?MnJGOXpyMFRCSFdYZm5tTHM2SENvUEVwZzZmenA5U3JQSU4yb2FZU1AwUW4r?=
 =?utf-8?B?ZmRiNUlHZ2lLeFJHTkV3RDlTbTlOSXF3WVFUY3A4R0dhdjdZZXlFdVNsRlF2?=
 =?utf-8?B?aXdLbVM4RXgzNFgwc3pVeEh2NmxwV0xBYVN5RHlpV2Q1OTlhcjRNS2FDSWd0?=
 =?utf-8?B?UU9lOFp6UzY1dHdzNWdHT1hjSHV3WFZMbmZPanB1Y0VVOHRaMloveDBUc2ZX?=
 =?utf-8?B?VHdPbDhKNDlFWkpncENqZmh6U0lqcStBMHBRaEhxaHB2ci9OQTlqcE9oTGZ6?=
 =?utf-8?B?VU1OR2NSMUV5aFYvOFg4Q25yQm9CZ2Q1RUFNTDhXOWgxcmUwaTBoVERGbGcv?=
 =?utf-8?Q?etmw1wzzP+GVqJCbpk0oqoccUMuxRp5qwruA0wpaKlbJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4406b4-e1d0-4527-aba5-08dc955436f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:20:11.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNAjlsCwXazxZBeOA7QFefqqJn4OIUuw5JGb22OuYjY5dQunZwmuauza/FDXwaZKdBlEaJZ3YZ0r2owsdIDQuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886

Hi all,

Sorry for the delay here. Took some time to find a system to run 
experiments. Comments inline.

On 6/19/2024 12:47 AM, Lukas Wunner wrote:
> On Tue, Jun 18, 2024 at 02:23:21PM -0700, Smita Koralahalli wrote:
>> On 6/18/2024 11:51 AM, Smita Koralahalli wrote:
>>>>>> But IIUC LBMS is set by hardware but never cleared by hardware, so if
>>>>>> we remove a device and power off the slot, it doesn't seem like LBMS
>>>>>> could be telling us anything useful (what could we do in response to
>>>>>> LBMS when the slot is empty?), so it makes sense to me to clear it.
>>>>>>
>>>>>> It seems like pciehp_unconfigure_device() does sort of PCI core and
>>>>>> driver-related things and possibly could be something shared by all
>>>>>> hotplug drivers, while remove_board() does things more specific to the
>>>>>> hotplug model (pciehp, shpchp, etc).
>>>>>>
>>>>>>  From that perspective, clearing LBMS might fit better in
>>>>>> remove_board(). In that case, I wonder whether it should be done
>>>>>> after turning off slot power? This patch clears is *before* turning
>>>>>> off the power, so I wonder if hardware could possibly set it again
>>>>>> before the poweroff?
>>
>> While clearing LBMS in remove_board() here:
>>
>> if (POWER_CTRL(ctrl)) {
>> 	pciehp_power_off_slot(ctrl);
>> +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> 				   PCI_EXP_LNKSTA_LBMS);
>>
>> 	/*
>> 	 * After turning power off, we must wait for at least 1 second
>> 	 * before taking any action that relies on power having been
>> 	 * removed from the slot/adapter.
>> 	 */
>> 	msleep(1000);
>>
>> 	/* Ignore link or presence changes caused by power off */
>> 	atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
>> 		   &ctrl->pending_events);
>> }
>>
>> This can happen too right? I.e Just after the slot poweroff and before LBMS
>> clearing the PDC/PDSC could be fired. Then
>> pciehp_handle_presence_or_link_change() would hit case "OFF_STATE" and
>> proceed with pciehp_enable_slot() ....pcie_failed_link_retrain() and
>> ultimately link speed drops..
>>
>> So, I added clearing just before turning off the slot.. Let me know if I'm
>> thinking it right.

I guess I should have experimented before putting this comment out.

After talking to the HW/FW teams, I understood that, none of our CRBs 
support power controller for NVMe devices, which means the "Power 
Controller Present" in Slot_Cap is always false. That's what makes it a 
"surprise removal." If the OS was notified beforehand and there was a 
power controller attached, the OS would turn off the power with 
SLOT_CNTL. That's an "orderly" removal. So essentially, the entire block 
from "if (POWER_CTRL(ctrl))" will never be executed for surprise removal 
for us.

There could be board designs outside of us, with power controllers for 
the NVME devices, which I'm not aware of.
> 
> This was added by 3943af9d01e9 ("PCI: pciehp: Ignore Link State Changes
> after powering off a slot").  You can try reproducing it by writing "0"
> to the slot's "power" file in sysfs, but your hardware needs to support
> slot power.
> 
> Basically the idea is that after waiting for 1 sec, chances are very low
> that any DLLSC or PDSC events caused by removing slot power may still
> occur.

PDSC events occurring in our case aren't by removing slot power. It 
should/will always happen on a surprise removal along with DLLSC for us. 
But this PDSC is been delayed and happens after DLLSC is invoked and 
ctrl->state = OFF_STATE in pciehp_disable_slot(). So the PDSC is mistook 
to enable slot in pciehp_enable_slot() inside 
pciehp_handle_presence_or_link_change().
> 
> Arguably the same applies to LBMS changes, so I'd recommend to likewise
> clear stale LBMS after the msleep(1000).
> 
> pciehp_ctrl.c only contains the state machine and higher-level logic of
> the hotplug controller and all the actual register accesses are in helpers
> in pciehp_hpc.c.  So if you want to do it picture-perfectly, add a helper
> in pciehp_hpc.c to clear LBMS and call that from remove_board().
> 
> That all being said, I'm wondering how this plays together with Ilpo's
> bandwidth control driver?
> 
> https://lore.kernel.org/all/20240516093222.1684-1-ilpo.jarvinen@linux.intel.com/

I need to yet do a thorough reading of Ilpo's bandwidth control driver. 
Ilpo please correct me if I misspeak something as I don't have a 
thorough understanding.

Ilpo's bandwidth controller also checks for lbms count to be greater 
than zero to bring down link speeds if CONFIG_PCIE_BWCTRL is true. If 
false, it follows the default path to check LBMS bit in link status 
register. So if, CONFIG_PCIE_BWCTRL is disabled by default we continue 
to see link speed drops. Even, if BWCTRL is enabled, LBMS count is 
incremented to 1 in pcie_bwnotif_enable() so likely pcie_lbms_seen() 
might return true thereby bringing down speeds here as well if DLLLA is 
clear?

> 
> IIUC, the bandwidth control driver will be in charge of handling LBMS
> changes.  So clearing LBMS behind the bandwidth control driver's back
> might be problematic.  Ilpo?
> 
> Also, since you've confirmed that this issue is fallout from
> a89c82249c37 ("PCI: Work around PCIe link training failures"),
> I'm wondering if the logic introduced by that commit can be
> changed so that the quirk is applied more narrowly, i.e. *not*
> applied to unaffected hardware, such as AMD's hotplug ports.
> That would avoid the need to undo the effect of the quirk and
> work around the downtraining you're seeing.
> 
> Maciej, any ideas?

Yeah I'm okay to go down to that approach as well. Any ideas would be 
helpful here.

Thanks
Smita
> 
> Thanks,
> 
> Lukas
> 

