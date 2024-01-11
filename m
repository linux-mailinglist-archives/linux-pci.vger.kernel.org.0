Return-Path: <linux-pci+bounces-2055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B7D82AFE8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90261C230B3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6E18639;
	Thu, 11 Jan 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZ6MyRYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491015E8B;
	Thu, 11 Jan 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoRsa+tCI+3AHAhpw7qGxoqia2qwCC3oM3vEH/McDH7fBjP53XYnreyFK8MR97zy27y0jjUDd3KLoeFOKy3E0AE21KillLDem+5D1AzlS0kSxfCEyzqsea+mQsT6AGhQ8AYXNfNKRIUn2lC3LxWdm6xcM5p6ohfEyjezsstD9HsUK+doWlIuWxc8AOYXQN0uEcfL6F2HzWEBD03WAb4CKKHQRcpiubNAp7iK0sqAWfu20+GBgF0t4xE5MM1Z/OvpE8nSQaeJbiyM8yqEq9i+TL3Vr+MqlgWONigOfGryeECJwsAaSlYloaMuQb9XwJLxeMZbcUNHWfRJeinq9OAECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSOWsOFqIILzX0nocT1mgzJmUdRJJ/wc9NB2k1bDffI=;
 b=Fv716GUS0Y9ryzcCgbsysicOVc+QcW4xDiAQPA/WXdwzyECDCdLSt05+f51Yukgu+hyQJYvLecvcYdDYoRRAa9VlCBE3EKOz5WLcRrYpy2nE7j59URrwc6l6yLkfQH3Xvmlhjl3XOrAh8nq0CYrHrhs7eDwRpdXnkM4EqfrhMddCM43VuT/m4MKkHdYTBTaNEVHE1DEnFaiyNoVkGciBxrj9F7Wr7xQMrTNVA3p2548A5NeGOI6vs7uebeP0QuwqDgsPHD6pawCg4KHKhLQoK6pbof0OwKkc4zegiiTSyN/4Z/nn50lkYJ0rIsmJ5JifqjMOzm5PykZfwGKCO+bubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSOWsOFqIILzX0nocT1mgzJmUdRJJ/wc9NB2k1bDffI=;
 b=kZ6MyRYJwW9TdcsJLjdWYAQddBOPy1WGIYapS5s9ztK06jCFeOn8ZOEdnrLZMfzBrgSMsZqfFla4uRkvDqb8FqqBeVzWT38ERMSdJ26raKZfMcFRJ3aQHcVegloziWO6XvNiUzxL/QtNbVCtH78ZudHAVyNV/tV66o3/2v/xWqbgjNkt8TiEgf1euV78LSEaOpqZKyn3jl5etSLpSZ3/nyNrERQJbPhSmbtbsLGCxZ3ViYcx1zVx0uS1NBEochP6oLsnnEUXX8GmsTFEzAp5Nfdf1GghbDUv5Z9U2CdkvU0VZy0RHie8xj859ywMz2X6S+LV/C0r41HVjbchAX1oZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:45:04 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 13:45:04 +0000
Message-ID: <7345c2d2-5446-49a6-9ceb-0f1b9ee4ec18@nvidia.com>
Date: Thu, 11 Jan 2024 19:14:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, treding@nvidia.com,
 jonathanh@nvidia.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vsethi@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
 <20230731195930.GA13000@wunner.de>
 <f7324ca4-2c57-459c-a9e8-aac09ba65e87@nvidia.com>
 <20240108141901.GA17779@wunner.de>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240108141901.GA17779@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::34) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|SA0PR12MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5bfb75-1626-4268-46ee-08dc12ab8392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x5dvdjn39/CyieT1t/VrvpBt4q+OoEbz5G8knZ/3yHzcMwjzjWz8T05AFUUc10kQT3HAQh/NJnXdVMAEqstD/fiMeoTmuMs0dGNcqBwcg6lAFoUZcC8fD/ZgO9xdMAkTCR9DAGE5JIiAE+408USmpOxIqqohSV9wBRFknlEyxa+SlL+0sl6DUlTRQRs/eTCpu8WYNlNW/8GCY9i8l3UimK78UtqQfrSg+HiyOdCFh3LBeGfP2/M4vBUTp0X6P5W2ch58y3Lekxj1Drqy1T6TbJ0yvd5qFwctvnbXL+0nLHunO82wJCBoDqQC4mFX9biAme//IIC8FwJ7IFZyWz+fmdXG8gDA860OIgnvYpaVQO8EujFqGZy5+qOLsYAZfv1J/BcvcdxfSysFVLrRnP7xgLaDlGrlk7fnv1OU3DNbI4vyggqakllxiVMkrC/4vuKAZ7EfVkcPE+6seYQnEK6Tk84JNLk0ua68SK069maDNurjfCmqICKr/ZHkDWxPJtboV7z7NHm0vuyAO4DCEpRQUv13y2fR3ntJlT7vK+ug3rneKPNlqb+puE1rOjszp9K4huUVY9I8RWxILR+7vo79VOFbaFIOqkbxn1F43JUUED+aYSvdCac0sHGx9B8CwHxG4Pdu8ZKOXSr+slTDMH3Pg0MVUacNaEQR/TlvAYbW1ac5sOIL+myC3gO0Bj5qCxKp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(83380400001)(6512007)(53546011)(6666004)(2616005)(4326008)(6506007)(5660300002)(31696002)(41300700001)(6486002)(2906002)(478600001)(66556008)(66946007)(6916009)(8936002)(8676002)(316002)(66476007)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjdMeDJMZkhJSXN5cjdscTFDNEM3UUdZanBBSmRFYjkvQ3NTREc2VW83dk5t?=
 =?utf-8?B?RW9OWjBjODd6ZzY4b1NoN1h5WFdzNitUM25naEsrSkJxTndmVUNyQVBNakpG?=
 =?utf-8?B?TnlVdWsyOGZqbURlczZDVEhXalpxaXNRZnVZY0tUNjhWbGpBV2REa2I2dWVO?=
 =?utf-8?B?VzFXTXh3OUxMbjdMV1dQaDcwaG12YkUzT3RPWjUxZFVVUG9FbEtWREJwOWxQ?=
 =?utf-8?B?VHUxL0R6c1UxNC9OZTIvMU42TklZeUlXcTdSQ2lGa3J1MzNvUjFwRDdGR3dl?=
 =?utf-8?B?aGIrUFl6WkZTektUQ0RkaHJJcndCMS9EUW8ydnlKTXFTNDArNzc2bElHblJp?=
 =?utf-8?B?R3lzYzRwb0ptaU1MNFJObWlSMHR0SWhya2Vaa0N2eUV5V3ZRRmRnUzR6YmV3?=
 =?utf-8?B?aHA5MEo4ZEd1MHBpalhvTnpNTlBJL0RWVmJmaVVPZlRRMnlrY3gvUmdNUUpY?=
 =?utf-8?B?WUdiTGZ4VXljZ05JUmoxVS9PNWhvaUczTUVSbGsvKzVoYjJVcjNwL2k4UXky?=
 =?utf-8?B?aGFBQlB5Z1ZXWjU3TlNhWkMrR250TkxJSlMyaGdkaGF4ZHZ0TVNod25LTGZD?=
 =?utf-8?B?MVI2Y1RkT3pFZ3VISG9QdG0wcW1sZWVzcklSd28wQjBVait2dUtnQkk4c3Rz?=
 =?utf-8?B?bXBENzg4OXNKNVdiRkpkdEd2aGlWUlV5L1c5YWFDazBmclAvZExNUE1xckp6?=
 =?utf-8?B?VXlxNjQza2RtcVkwcFlCbmZ0RUZOWk1Pb0ZydGxpVjFvQ3hqUmJBVHdaTHhZ?=
 =?utf-8?B?WjBtMzQ3QW9jLzQ2ZGRuTk93VWZyMHZBOFFlMmdhMUVmY3FYdENvWERUMDdD?=
 =?utf-8?B?dXdoT01sOHo2LzdLQmV2T3Z0Z3VaZkdjYkFQTk8vWklhc3dhUmZTakhpSGlX?=
 =?utf-8?B?OVFoRnVLRWFMYUpVekR2dVRYckhZMnJWWVVaTCtCdzFtV3MrYUp0REVES2R0?=
 =?utf-8?B?aENEMHQxOE1xSk5zRXo2Tk5ycU8wTWYvZ3pvRFJHSmw3NElYQk84R0h6cEQ0?=
 =?utf-8?B?bG85QnFNSnhlMjVWcTNpYkRoaG90d3JJVXF1N1J0a0d0Mk9TMmRLWExIT0Rp?=
 =?utf-8?B?c2RWdTRmWU5UWUNlSFVMYWY3K1ljZXAvZ01MTWsxSmIrTGZ2a3VjeVJqVTRa?=
 =?utf-8?B?N0x5em1tRXkwdlJuY2hFYWU0SXZKYnpQSHZWcHZYOUdnMGNrVWg4TW5ROTMx?=
 =?utf-8?B?TUJac1d6SndEWHBSK3dGd3NQYno5UUNxeHZTcFlPcjVpSVBuamNXVS95bEpI?=
 =?utf-8?B?MGFyc0lKZjZETEI5dUZHSC9XYmd0ZCt3bEc1U0tpa01mdlFYek1YeWFkcU9v?=
 =?utf-8?B?NTd6clUxaTBiaFhRbklzczY2MStFQi9sSllRSHJzdjQ2WXJvN0xGUlNFdlJO?=
 =?utf-8?B?QjZucmNKQi9obTVlSHZ0K3B4QVEvWm9DZFlGdUs1WkcrWnIzV2hnWTdqWDMw?=
 =?utf-8?B?Ynowb2RoUFFZN3ZUQTlzWnJCUXVTSW1qZU5VKzU2dERtZFBxcmJ0Lys4ZkRL?=
 =?utf-8?B?Z0pTRmE3SkljRllWZmZFbjhpWEY0c21wUjRaZldYVU5hbDVxZlRleFdhREJh?=
 =?utf-8?B?ajBza1cwck9oVGVONDZDQ2x4NGU1V2thVzlBWFMyR2dsckVJZHNLWnVzTERX?=
 =?utf-8?B?V3cvWmRpTzRkSDNnajNIQ2lFN0RvenVpR0wrMU1kdkE2WWY0azE0RUtaY0lV?=
 =?utf-8?B?Y0NMU2tKNWQ4UER3Zyt1SjlMdERudlBRUlNkVVYvSDQ2VHp5YUR4ZG9rVjBO?=
 =?utf-8?B?WjFXNXRwUVhmU0xUY2k3RlJkUTlaNjQxTlZIYVRTV1RkN3hYT04yc0ppTkdQ?=
 =?utf-8?B?YnFWcmtzaEZ6NXNTdmUyczFoQTFrb1RrUXpiOGxJMC8xMkUzOVYyTHVNYmxT?=
 =?utf-8?B?V0VkcCs1SU1QYWdWUlFjdzc5c3dVOEttZE45R3hMendNaEFGOTkvZjhVYXR6?=
 =?utf-8?B?WmU5Y2xHQXR5cm9zNEZRSldtYUpZZlJRbWVFZmVEN0srcXhZM3lZOW5IZ3hi?=
 =?utf-8?B?RFNvSE8ySTJzN0JGdmgyc01GNUNHWUZkRDhVRFA4eTMvdk5yVUVMaytkcm1s?=
 =?utf-8?B?SnlQZUhJS2hFOUVsZDlXUmVpdU03WlVxQU1jdk5TdzFMRStGNGVPdkQ3NHJN?=
 =?utf-8?Q?XuryX1vdTlA1cnZuBcf6Ek2Ye?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5bfb75-1626-4268-46ee-08dc12ab8392
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:45:03.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR+xawGAqBtiWpdQYKAzauZJgJ77TOWZdMqD6e905EzDG3RqKbruJ2TQ7Kvn73HfOsd8oB967H5UGLaicmiAjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591



On 1/8/2024 7:49 PM, Lukas Wunner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jan 04, 2024 at 08:01:06PM +0530, Vidya Sagar wrote:
>> On 8/1/2023 1:29 AM, Lukas Wunner wrote:
>>> As an alternative to disabling ACS, have you explored masking ACS
>>> Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
>>> unmasking them after assignment of a bus number?
>>
>> I explored this option and it seemed to work as expected. But, the issue
>> is that this works only if the AER registers are owned by the OS. If the
>> AER registers are owned by the firmware (i.e. Firmware-First approach of
>> handling the errors), OS is not supposed to access the AER registers and
>> there is no indication from the OS to the firmware as to when the
>> enumeration is completed and time is apt to unmask the ACSViolation
>> errors in the AER's Uncorrectable Error Mask register.
>> Any thoughts on accommodating the Firmware-First approach also?
> 
> Are you actually using firmware-controlled AER or is it a theoretical
> question?
Yes. We indeed have a system with Firmware-Controlled AER.

> 
> PCI Firmware Spec r3.3 sec 4.6.12 talks about a _DSM to disable DPC
> on surprise-hotplug-capable ports.  Maybe that would be an option?
It looks like this _DSM is totally dependent on the port having SFI
capability implemented and unfortunately our system doesn't have
SFI implemented.

> 
> BTW what happens if the system resumes from sleep and a device in
> a hotplug-capable port doesn't have a bus number configured yet
> (because it's been powered off and is now in D0uninitialized state)?
Theoretically the answer seems to be yes, but, since the platform we
have is a server platform, there is no support for sleep and resume on
this platform and hence can't really confirm this behavior though.

> Could the ACS Violations then occur as well?  Do we have to mask
> ACS Violations *generally* on Root Ports and Downstream Ports when
> going to system sleep and unmask them after setting a bus number
> in the attached device on resume?  And I suppose that would not
> only be necessary for hotplug ports?
Again, how to do that in a system where AER is not handled natively in
the OS? AFAIU, there is no mechanism for the OS to inform about the time
it updates the bus number.

> 
> Thanks,
> 
> Lukas

