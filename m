Return-Path: <linux-pci+bounces-2320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5A831CC2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D40CB25544
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009AC250E1;
	Thu, 18 Jan 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YUGtQgRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B101DA35;
	Thu, 18 Jan 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592833; cv=fail; b=q1irsJdcTTWa2Dk7haymFWthvD+CqX/SIZwc7oIX5w9vXRL7z2eVfgzMBrAIQ24A759ZmZchUTKEx1s6Hw8ajcisRMrjMzQ9bnAXUXBS9po9Aij8p2w6IbXBtGzSmM/vcl8k6hOYXoMQCYScGp2V7ue/Eu59em9BgLEZsOxKZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592833; c=relaxed/simple;
	bh=jdDGs8jvFkUrIWGg6XC2iVmxmCDUZKwEVgsyShCfIek=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=rWezaH2EFNpeEf14pPK8ufxnediZlpMq1Hu5+D+1dRTLYXkjkXQusKgLd1UKWr7gcVFwH6kldPGzqv05P/W/U9/y1ORju6/PHHHmolQfhWxx11FUKXHS96s0kgtLzvj3xdXtXjDeTCDsFgBsGG9B38LQs8l5IB/iHrEvlChzdYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YUGtQgRV; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tox14mk9F+lH+Sd5t29ZckXK6JOXr8ofP1sjxvrjYSW6Wjx7rLmoNHMxktRydz3NupOH90eJ8rUvReYa1jQljAugbMt2yeojEtFCdaFruvCsByd8JM4G5JB2zsDj6GgNUK5Xprlw7Lu4Zm50uiObsvbl6oN+PoGgyJlK3aymUBlegJDMqN+qH8gBT4/gI0FH/lXuVyngPfk8YbZasASY5QwMQAc8R6h7ua7WXhH5/ZCxzH8weOA9QLfMYwkZiC4Zh6zcVz4BaN1wDzL2pMg41ywMevkfOXLl+IegD0fi1L8hH1Dgpa2WhqkSwfwdkxBDUWhfUJKly5ZmxgzmI2LLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo1DOlTEJdAmQjn5+gbrxQj0wSMbhwS8FrM4bnyu6Ns=;
 b=eHDkV1IjcHBm76psXeDSX03lgYJOLvLbOaKxfAE6skoBfXFr+q6XPzAYgEZuD/GE53cYzlVR4PR/Z3eWoeIMHIDLjI+d3THXoVWQZinXNQprrnBwHHfRvQ043WzWAlhq5SLprSAxFTmS5kDyRTJ4LTgUDuxQ2A7AVjoAMTnoHSjreuWUspskv2m4+ldPxnHXHSfMFrO2MPbAlUGKQnvloZwBjBdSn5JJVW42fqhbpplkuEuYnJQLWn/KlMEl2J+bP1hxGTnuk7E7xDBr8j6XswvY1wAB5OCdbI+rqDv779tI2W01X5nLy+/UDBuRsAE77BY+SaQbus5/OqoxNsUZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo1DOlTEJdAmQjn5+gbrxQj0wSMbhwS8FrM4bnyu6Ns=;
 b=YUGtQgRV3FSGDNLrA1VWLaTEkPV/oMlSDEFi3Ykh+UKSPomUxpEWSj60Z8p22Eo+rogUdZmxWwUUmgbplS6+mRImHGxSyGmfPkRr/MmS6x4TaaaOEsJREqjRweCJv8mbrb1to8d4nhfAaOdTYiZqP2y84OJizgvGzt2DhnMey08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 15:47:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 15:47:09 +0000
Message-ID: <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
Date: Thu, 18 Jan 2024 09:47:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rajat Jain <rajatja@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de>
 <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240118060002.GV2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:5:330::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a3a58b-4503-4142-5596-08dc183cbb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sExFHtLyRo7xXaG/LJ1CwPKUYptPwkjl8FVuuzphILSkqPEjNbRpOc6swCCfpFEvXaPVGbuMwt0RQb/1YgWsAwWckvNawSGyITpPzjIcyZHoUvt4WqT+rMYYHS3io2QRl7Te3H+qXq/smBAJgKKXRKo/akWI59Rk/JhqXzBAd8EDEYhZplvD4mGoLHA4LBINNTBrYXr86LY/q+iOviyR2609WqfGYqv0JZbSThiSVNwj/UQiUvVIOUkfdNyFISwq3JE9NKlL0dJmHVJwgNcik4ubDPMrIdET90kh80/CrGovNjgPpIb25as1agkWq99I/fLTF8UL9hN/gRfupGs3KVaW3910GqUKDnA9c6UYzWd/mP6GfmjGYf/9cVL2L7bdrqxUsshu6TwgegDSZ1NwxpmkjqKGIHJOe1bZxPC+R9XRhM8CGeUqSOR36OmiPXjZw8Jtg9uVJzsBJGRUwvwnNkD7loeEGWJjlBEGwId1jJ16jt2Ta2QSp3O7fnBNYvkpjhWcjRK50VtkwDubsGMA8V12ZuC57wh7oQ6i1r5cZHStqI9TFPwGzkdUb/UT4XkGQ9VU9SPIvFaOX4odFOaGL8QZpQxXt38EZtK/ae+Tum9KlqFM23k/nky5ydv1N7eXcW/mDRWu5zy7YwIJX+9HxJ0tWkI5CNVbKMoK5h074ZSCB1Srw4o8ua4I8Z6k+mdb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(8936002)(2616005)(44832011)(26005)(66476007)(5660300002)(4744005)(2906002)(66946007)(54906003)(110136005)(36756003)(31696002)(86362001)(66556008)(6486002)(316002)(31686004)(6512007)(6506007)(8676002)(53546011)(478600001)(41300700001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFdoU2V6SUFPNndMUks2aG1zZmVSMGlHWVNCRFVnZ2hkSWsra0RaTlpYTkN3?=
 =?utf-8?B?REtUNWN5L1Qyc2tOd1Z1T0lQNzFSTFlSWnByR2NzTHhWZUZmb05rMzMxWi9t?=
 =?utf-8?B?NGJtYUJnKzlwWE9EVVBNdWNpRmRlTTRKM3BVQURialp2VktmVlN5WHNvb1Fy?=
 =?utf-8?B?Z2xremVkeVdpdVRxeTg5VzJuN0oySWRaMGRtc0dhK0dsT0pYbm9EdzJ5UFVt?=
 =?utf-8?B?eVN0Smh4cDBuMnlZQUNQOUlHbTdYOG9kaEM4MWlnbVUrcGhYL3NwZWZia1Bq?=
 =?utf-8?B?U1hqVnRGMHBLcVR0TGVEYStTanc1dUhQRTlJd0loMXovUEdKL0lzakwvQVVT?=
 =?utf-8?B?RUx6NUtpTWVaZ0d0VnFOaGNoaHdhWmFncGNXVERpYlNObkFOa25OeVBrZ1lo?=
 =?utf-8?B?Nzdvb2Q4U3pFV3BTZlpDbjdncjRsenZiSDliVnpub3BBa2dDUmpBRGFMcHlO?=
 =?utf-8?B?bEdPZ1ZTd2JxSkNRQ2hhSE9GVnAzdk80V1J3QnBFZmRTZVRDQnozSDBzYXlO?=
 =?utf-8?B?ampMa0paK1N2cTdHbEdZSkx6UENiQTBnMFFnemlSS3hMdTd6WExMTk1UTnZB?=
 =?utf-8?B?aE1iQXI4eGRpK2RmWUEvRzZjZzBCQXppU2szODlaTW91dVVFTVJkU1NDTkNE?=
 =?utf-8?B?OEkxMDN6L2JzcDhYZCtKUlJ2cFpsSkFCb3JTcWp4Zm5QdFBCeHV1Vzl6d2VI?=
 =?utf-8?B?bTVqOWJtYndJVzkwTFJPWUhkbkdIN053eEdBS0wvMktBeG1LT25NcUp3L1BF?=
 =?utf-8?B?SkM0MGx2OUIzVTVxSWlCd2dOQ2hEL1hJMlBTWWg1dmY4bVVPNUJlMkRtUGZ3?=
 =?utf-8?B?Q3JITUNSSGhYT0VxQWtXN3NkVzJwTUJuWEd0ZnNyN0RFZXJhQmt1R0dSY0h3?=
 =?utf-8?B?Z2ZGMVZLWGs5VTJlaGxEbm42Y2N3L2twUDV3VnpmdzYzQ1M3RGJ1ekxpQ29B?=
 =?utf-8?B?ZTF4dzZIMTJxeURGdTBrQnZ2Qk8wRzRkY005dGVpeUVQUEFvVXR2NXlacThQ?=
 =?utf-8?B?QnUxVlp1Y3RBd3RFVzM5L2RCS2VqamJ0eHIxd2kzL3BYRnpWM0Q3VzF4UG1W?=
 =?utf-8?B?cGhKUHdpc2VBRE1WZDlPUmNWQ04yRzNEeElaNVB4bzdBaktxMG40UmdKQ2Zz?=
 =?utf-8?B?U1BDVmp6NVhpcHJORENYU3lqM0lNRDhHcnRYcElMQ3gvZ3RoQWgvZld1eUJ0?=
 =?utf-8?B?Q3ZWV0xhbGtOQXBhbng2Qk9BOFZhZXQ2QjZDTTJIbHlqeG93Q1g4SEFac202?=
 =?utf-8?B?bktqNTNXcDhnOVlDSVVLb09rTlJHZnYzWUlqdTM5bnhheU54a3RnaWdTelFE?=
 =?utf-8?B?Wk1MdDVHWTVxd0hXaGQ4dkwvdEQrMGFlUk5YdE0vdkFaOUZLUnFGVnB0N1da?=
 =?utf-8?B?L2VzM3RYUUkrN1R2STdERUhReVNqMU81QVViN1UySVhoNVJua1k1aHQwdERI?=
 =?utf-8?B?aWNmdGxsbGVvejUzRm1WaHJDd2wrQ1R6KzVRSTUyWnVUNkVXQ2lUeVJGbU5T?=
 =?utf-8?B?SzFpZ3hYN2piVGdqU3NJeFlvQnN3RGl2QXFsY25RNkticTdmQ1VlNGFJUHRk?=
 =?utf-8?B?L0RSMHpIUVcyK2loRThoazdSMHVZblk0SWVMVWxOK29VbldWTFVkbHhjK0hr?=
 =?utf-8?B?STZZTGpiSC8xLzNZTS91Mjk3WTFva1gwdEY0YUFjKzkyMkM4cDd0SkhoOWNY?=
 =?utf-8?B?VEM1K2J1MUZhZnM4OXhSM2lUMjJ4WEZLK1c1NVgwK0xIN3paVUprcGQwNWhk?=
 =?utf-8?B?TVlBWnVOQ0NJTm5uMnBTTnp2VS9YMnZ2QnJqa0YwTnQ0SmxuQ21Ya0RReUYw?=
 =?utf-8?B?b3RnVE9kZlZMS3YzNDgyZFdrUmFxVDNYR0dlcFFVVWFmZjNUOUc2VVdXOW9P?=
 =?utf-8?B?d1JteUh3MkZoT2dsZzAzaWxhYWVFTDhteFdSU1VZdVVpMlJIZ1lZZVBPKzVR?=
 =?utf-8?B?RXJBNWhERWhudXM4ZFZXaldWWjlkQWJzWk5OQnZOSUxUVHpSUm45UlVvRVNh?=
 =?utf-8?B?Mzl3bmhMU3J4R1lyeHl3VE9rK1dzeEZUcXdUTlIycTBtMXYxTG1HZTFmaVdD?=
 =?utf-8?B?Tld1c2pVR3J0OGVSNmY1MENGcWxweTNhNWZxRTJOYm1FOGhXMFh4QVJJWVFk?=
 =?utf-8?Q?p7ijGOMXpvXPZO7DOF2UMZe0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a3a58b-4503-4142-5596-08dc183cbb25
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 15:47:09.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy/RXb1HdMcIfW2OhrXnjrv1us+p8PbM6kf5CAj5yHPw4eENic86dJLhIy25BhZRhODhOUVoDnwyETaBl1Xd0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509

On 1/18/2024 00:00, Mika Westerberg wrote:
>> Before my patch, you see that the JHL6540 controller is inaccurately
>> labeled “removable”:
>> $ udevadm info -a -p /sys/bus/pci/devices/0000:05:00.0 | grep -e
>> {removable} -e {device} -e {vendor} -e looking
>>    looking at device '/devices/pci0000:00/0000:00:1d.4/0000:05:00.0':
>>      ATTR{device}=="0x15d3"
>>      ATTR{removable}=="removable"
>>      ATTR{vendor}=="0x8086"
> 
> This is actually accurate. The Thunderbolt controller is itself
> hot-removable and that BTW happens to be hot-removed when fwupd applies
> firmware upgrades to the device.

Depending on the consumers of this removable attribute I wonder if we 
need to a new ATTR of "external" instead of overloading "removable".

