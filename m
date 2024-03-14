Return-Path: <linux-pci+bounces-4795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EE87B5DA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 01:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96859B20D4F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A407FD;
	Thu, 14 Mar 2024 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="coEC55YX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E98610B;
	Thu, 14 Mar 2024 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376811; cv=fail; b=Vo2kdJIEIfP3yHr7pPdwzifKobr0uLSYZ5ve74VHyW+s9tMzXltAnZ5STUqon2oCFwbUM/Gyo6fYCNLxld8FcJrO/rNjCT0YBaxhhhCFAmgXOwoqEIg0Vi6HMd4jNtczlgOU0Uwuu4h2oiVOOJpHJLeB88NAqhOITP8mlokKSxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376811; c=relaxed/simple;
	bh=vDLPxVqPZBPx2qxBl1soDULN643nsPxvKnLqXh3I+MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XdPe+fkgRdiDLlUi/k/DawIapG8XOE15/AoR4W5asFTOKjUfWeN342WKCboV1jR5XR/7LdzCQLZG4mggtONTxF0ggTFqlY/obb8ubp5Pt7TExUXLTJGUqllNpblIi9hpJHOOhN45e4bNlzWlt/Q8KOKBO8GzrFLK2QJgiAPblaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=coEC55YX; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpf13wA8ZnRWryfpeMTfltsl2wgMeEDBQbEw8XuKpWuu6wl5gEyw+0vxQs+8ifzhF9SdJQT7h/lr/ei9kLj1gYITR1r4WjE7+nc90hS+eexGT9A0IrbgbL+bMLk+wBAPd7qWwzwHnnOWW/auUzux/liKWq2MPWWrLc1Lu08rVHb1BTZODpsrgSEe5WhX2tKCqHjQpNrWmVrao1o/nrUF6EYpJ3XEajml8nkkiTqU+r4jy22C9wQbdqFLQorFun0JK8dHTQcmbTV1ff8u0Ab8EOuKHFpyoIuv4R7plqC5gfwEO4NUWO4WdRmzRd5fCUPxtb2WfkTs8u1V1ATZ87oKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfdcH1X30HSvlKSl1gBYI/Oe4SaKJAVvjQR4tJa3RfY=;
 b=QFbGlZnOsBAcak0NIxIlsNrMe3oCsGbIRpx486jXHZqHD+2kdoqToPZgMvAvRjwCMqaofflDxd9wQY1WUoro/b5Whzs/p6HfodoXk4Zb9egC11JF6QDnusCgIhTDdKAD4F3rrwDhSg9FPeiQR1Ed+x/aqYjFIZYL95ogBJaGyyvX2Vs5HTTZVHjg/esPogZ3ptgVelTjI4A5V+nnmNc5TCXkKxUqHR+ySwGBVXEuKUI9CsUk4zr/cd18wDVJZFQWK07kh52lx/yM9XbL+nSbDQo4/roGFSBeFQB68gw5YVB4abHcSCytJP0Mf3ienGMzpGrnJ6OXh0L+yW1w7uID9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfdcH1X30HSvlKSl1gBYI/Oe4SaKJAVvjQR4tJa3RfY=;
 b=coEC55YXA+jYmXlfM7LsoY7zSCVKFwLdY7vnscdKkIy6/C7shBjHS7QP52SHDkEZcxEldShWDEORIW/FX7lotisPRgTgpjJCDaRFrXXmLDv9/u9zI9DhY+n1zvtI41x9cs0LqfVOmL3FT5GcCKqvX3acl1mNx8MPYk+MSi9BvVKjCGYXK+Xopzca7PKvFK8IeAwCrQA4Hf6kCIfQXwJA0847bCgPn9y9gVA6GtZ+cKvIv6LYQbbqRYA+8F/ak5v4EOl1Y1qbc9+syAgrWp/G2ziK7wRt4duhfpx5g/poCpxB17jg3d3ycU1uxqCOvbdeW0nJ/8xgMSX+UOnLV9bkMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 00:40:05 +0000
Received: from SJ0PR12MB6686.namprd12.prod.outlook.com
 ([fe80::e929:4846:1a92:c42]) by SJ0PR12MB6686.namprd12.prod.outlook.com
 ([fe80::e929:4846:1a92:c42%4]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 00:40:05 +0000
Message-ID: <d93a3f29-b260-4910-aaf5-d734e6242223@nvidia.com>
Date: Thu, 14 Mar 2024 06:09:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI: Clear errors logged in Secondary Status Register
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240122230026.GA290856@bhelgaas>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240122230026.GA290856@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To SJ0PR12MB6686.namprd12.prod.outlook.com
 (2603:10b6:a03:479::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6686:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: afeec0b5-7619-4ab4-7804-08dc43bf4ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3pXYNI2jlXvJRZh98GTIrbVbkUZnATYJPjxv7V/3kpGhoC+HspxiKkdlcpSpSqXDJrvqqtfKjKfyTkfQyiW5tzt1bj7MSCYEDpiiyLqYMurXmG7UUt5gX+VUKIa3J938/1tkpW5YBd3Bdq3j+HD/ERSHKUwdi4SF/m3iUnKnQ5xupbYY3gAhrwbUFPo3McQL6ZXhWtzjCVx/MkAwhuYUAP1vAnbhGGCG5Prn8Y2rm9wSwXa4vvWZoiNQdhKC9HcYiMm3cr2P5OkaB/8WTRNyMbEwav3C7xxQcxlDOkbGWkciSq/zmSVtGSDUdawrNxiv2ghxc6MDYmQEeyKxStXztrGbVuddcnG2uBlcGnklmjIM700oNAHin4hknV6PCqIzuSTxusz6STNgpyt9m4B+m9S5W3ifRugeKZTzy6ivJuGC44ns2zZ9sNB39zBjFZYF6kOve3yPHbwgxYFVg+3keb0WNYRW3NOz5l76cBXOU5qIOEloCVgz0bGQjIIF/pnOwLro2yWXBr0EXHustyWaqxdOoRjlPghs5ThTnL/DXpSV8vGDgL3xs/XEKhmKURkAOTdvW0JOyjQJryIcJxJb9N5E8/MGiMaLvthc8Ze2NaxUYCV1yd3bWbl26zpNfgB7BDEEHvkZDKHrWvGCRJKmc8P2a/MHE8x0rGnusv0VQt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6686.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVhHTXY5em00U2wxVWVERHIyalFxdFlXY1RnbUVhekVUTUhiVlI0LzFGbU9I?=
 =?utf-8?B?SUR4VTlPYnIrVlJLTzhNZ2loOCtNQWhvMzlyNHF5Z1JDRVJ2bDVrelA1ZFpa?=
 =?utf-8?B?S0FtV3k4QTg3eUtrNWR2RlY0dlE2YnlCVVhpK2ZoU0xQL0RHUVZ6L25qc0Rq?=
 =?utf-8?B?Ym8wbGpza0o3eElhalQ2QWVRMEtmb1FraC9nWXlTdWV2cnFjL1J1R0JnaFds?=
 =?utf-8?B?UWZHZ0RnTkYvUE1PTXZ0WVhNU3Q2cU1sNFpZVWJXUTZIL2dJdVRzZ0QwL1dD?=
 =?utf-8?B?M0hyZldNQVV5RVRmODFwSlYvLzNOcVlTVjRZTGZlV0lpZU9waER1NVpFa0hl?=
 =?utf-8?B?RHFId3haS2ZteG9pQWYvL0FhNlgwWUYrNUVNQ2hQTDkwaVpUVWZEb3B3VDJB?=
 =?utf-8?B?aDlXQW9WMUFWMERkT2IwdE95dUtvemEycHBvT05WRE1LamwrTnNCODlCcURh?=
 =?utf-8?B?Q0pOSElNL1k3M0J4ZGZ4Z3FlMzJ3OVZ5eVFCUFdKK3YrTFA4ZzJtaVN4UzBW?=
 =?utf-8?B?WnRwNmtVNVVvK080MWtFUml3c3ZRc0NIMG9tV0RablNzZUx6NFNkTlBwVXNL?=
 =?utf-8?B?QlhmalVVd2huUmR1ZGJodnNVM0RGVkRYalFSVHVOVWVkQmNya3dOUlNJWS8x?=
 =?utf-8?B?U3dwNGQza3BITlliMHVMUkFPUzE4enRWd3dVMElrU2l3UHV6VzVXNU40WkZu?=
 =?utf-8?B?b3NMeDlCK2NKN1o0VklOemJ6amdxS2k2MHArUWl0SEM1QzJzeURCTCtHbmJB?=
 =?utf-8?B?VnRydmdySGhCeDk3S0IxOTFBaGNoMzNxNUxEODRJSWM5QUNwR1BhbUR2YzMr?=
 =?utf-8?B?OEhzaFR2VDh1T0pPcnFEa0F6MWZwMDluZFhvWlhYUTdramRKY0laYmQreVB2?=
 =?utf-8?B?SEJYQm42YkxUSW5OSmUwZkRYbkF3a3VadE8wSC9ueVpuNkIvSjVLYW1YUThk?=
 =?utf-8?B?a09TNmRqUmNnbG9RalRGM1dydlJBQ0kxdlpWQ29LV2RVU3pLNTZoc3lERUxn?=
 =?utf-8?B?ZGpJN2hlRndBQkpvMjQvbEZyNkhUdU4xWXo0S2cyaUhtY0NRWWZJQ2c1b2dH?=
 =?utf-8?B?RzFnME9pd093T29Yb0VlK09MK1h4WFFZUHZhQ25ETGFZWHFyTi95eUZQcDJw?=
 =?utf-8?B?SXR1bVhoS0x0aUkxU2xNM0RVYUNZMzFJNi9vTExyc1NBeVEvYko2QXRweXlX?=
 =?utf-8?B?T1lvTDlhT3pqNUZiOEU1TDJ2NURiUkltUnZJQUllKzJMZTNFenpLaDcwdk5n?=
 =?utf-8?B?eEgrczhnbWRZdmZIOWNkOG01RjVHVmVXNXFWYncrSVA1ZWNWSS93UWZNY0Fm?=
 =?utf-8?B?d2ZlUWs3RFB2R2JKMVRBODNHRGhKUmw0S0RWbldOcUVkWk05SDhjT2lTeGh4?=
 =?utf-8?B?OGxrV2tBa3V1Y0hLeG9vUlJOUXZIYVp6SURtMG00WVg2MzdPZjZpOXltS3VW?=
 =?utf-8?B?ZExlZllrT1YydU4vaGNDYUh4NDRBaXRIQzJMVHVGSnYwaE1iQk84WU5LVXRv?=
 =?utf-8?B?d2hOVWhBdWRacE5xRmtWU2ZoaXpLZ0FhNG1ESHEzTkZBTDdrUFkxUGs3VUx4?=
 =?utf-8?B?QkhjSWRYNjMyZmpYZ2Q4ZFhyTkMwa2UzVnl2VjhMU1N5Q3EwUW15Z1RLRnhK?=
 =?utf-8?B?TkRKVEEzNm1iQ3RTZU5SZFJGelhLWktoOXBWSUg2NGtYdTVibWhMbmpZWVR1?=
 =?utf-8?B?cHZCYnpab3hwQnJHdmx5U1RURDdyUzhuZ3NsZEhLcmdtVzd3cEswRG5jL2NQ?=
 =?utf-8?B?ei9xanZhb0szMjJ5K2wxR2dMSzVGSkNSV2VJU3pneDNCQnlZT00rVi83VTNB?=
 =?utf-8?B?VWV0azA2YVZKY1dFOFNRM1NGeVIzNXM3TXFkU3Vjais5QjdPNldaR3BReVlv?=
 =?utf-8?B?V0FpWE93TDU3TWQ2NFVYV2pxMDB6WVh1TDhJcWkwb2pTeDNUUEVzL3lRaGVu?=
 =?utf-8?B?R0dWb3ZuM0RYSTFLWWxZUjhIV3haeHpselhYUjIraGgvZ1BGQzY1SnZIUEtr?=
 =?utf-8?B?NGZCUy85c09lOUtoSm5BbUJ0SkhJbDAxVml5c21OYlNPVGd0cWs4MWdPSVd6?=
 =?utf-8?B?UTN6bXo0YnVvNExYZmlJOXY5R3dDTEl1Z2Q5TnRRYUVtREVqTlVtUFhxZE9o?=
 =?utf-8?Q?6NHhOXGak57oqsNs3BFtARsfw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afeec0b5-7619-4ab4-7804-08dc43bf4ab1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6686.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:40:05.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emgudeJNm9yuR6ykX9tqf7x6ifD7Uo3hV82QTD4trhjMMeP8ErkY9bfLdJ9XsxcS6p2zUVaiF4e4ip5Bkk0rUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883



On 23-01-2024 04:30, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jan 16, 2024 at 08:02:58PM +0530, Vidya Sagar wrote:
>> The enumeration process leaves the 'Received Master Abort' bit set in
>> the Secondary Status Register of the downstream port in the following
>> scenarios.
>>
>> (1) The device connected to the downstream port has ARI capability
>>      and that makes the kernel set the 'ARI Forwarding Enable' bit in
>>      the Device Control 2 Register of the downstream port. This
>>      effectively makes the downstream port forward the configuration
>>      requests targeting the devices downstream of it, even though they
>>      don't exist in reality. It causes the downstream devices return
>>      completions with UR set in the status in turn causing 'Received
>>      Master Abort' bit set.
>>
>>      In contrast, if the downstream device doesn't have ARI capability,
>>      the 'ARI Forwarding Enable' bit in the downstream port is not set
>>      and any configuration requests targeting the downstream devices
>>      that don't exist are terminated (section 6.13 of PCI Express Base
>>      6.0 spec) in the downstream port itself resulting in no change of
>>      the 'Received Master Abort' bit.
>>
>> (2) A PCIe switch is connected to the downstream port and when the
>>      enumeration flow tries to explore the presence of devices that
>>      don't really exist downstream of the switch, the downstream
>>      port receives the completions with UR set causing the 'Received
>>      Master Abort' bit set.
> Are these the only possible ways this error is logged?  I expected
> them to be logged when we enumerate below a Root Port that has nothing
> attached, for example.
In this case, there won't be any TLP sent downstream. I talked about 
this scenario in the
second paragraph of point (1) above.
> Does clearing them in pci_scan_bridge_extend() cover all ways this
> error might be logged during enumeration?  I can't remember whether
> all enumeration goes through this path.
So far in my testing, clearing it in pci_scan_bridge_extend() covers all 
the cases.

>> Clear 'Received Master Abort' bit to keep the bridge device in a clean
>> state post enumeration.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Changed commit message based on Bjorn's feedback
>>
>>   drivers/pci/probe.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 795534589b98..640d2871b061 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>        }
>>
>>   out:
>> +     /* Clear errors in the Secondary Status Register */
>> +     pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
>> +
>>        pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>>
>>        pm_runtime_put(&dev->dev);
>> --
>> 2.25.1
>>


