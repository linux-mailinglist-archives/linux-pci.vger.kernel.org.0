Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BC59F2FE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 07:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiHXFLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 01:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiHXFLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 01:11:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CF6BCC3
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 22:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgE2uEV7al/8bleLtIg4FE8rzm2fXkyWsMnolmwqH54rk/HbccewlyN0pVxnFQ/AjvH8ERRTW/XMvuL2N+HkTqATlj6x1w9LCQpdrrbRxLyNJhKLLYRJbFcIDiRFXfCDBIehVtkq+LV21yFuucLjaqOSOBKcVW4kgahdhmcvCCSml9w3FDlTyyaEzXmm7SnKD5N1NNVsZU1udlMSLsQLZ/XB4hgI9P6ZkjBfFg3f5+CmlO0cwn0YH8VSeJHdBF7xGwwrPXfts97QdBYZqaFnXi8IMCPJsOV4EoWYs5/ZMaX71AqEW76dfSSy+7mHWTBZd8VTmuAFDJ3j47U9NTo81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHjDuaBFysfkDccY0XCgCPOEuxqeT6RumdyTWMskxnM=;
 b=XGpqaeS39HvKJsuTN3e/rhEsqI7tO3JJBG9MuFCbQwri7rJzVKO99f+bMDd7WmUUUAe+NqLNOCg07CZ56XCqPF/vFCgp7iwa6hdjzU/Wn5vjEcBR/cx05ri4iIc2yYHR2/xEIZc3WtwfZQPQQX5GE8gVSMDJGEPmrKe1bg4FV+ELz2f8k4lM3fG/jGanNqhCQGrwMoIutdZ3KKoNgbt1Qu6mQrezVr8HSAYVWEZKWmYJdnGtbLyDkRL7RBMQBPNqS1D2b+HsNmLDaesvyStHGAhoAmCUfy8R695lnhKqauknme9SnE1ebVFJRFkfkjZe3fSGTxYa4ULVvd1ngVqEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHjDuaBFysfkDccY0XCgCPOEuxqeT6RumdyTWMskxnM=;
 b=e/5h0DvKsoC2LgOEbgdxksD6caJbVHgEePduc/mGNbvUYQ2W2dpBEjrEjt5mgi0uUOF30J8dGA6TVgCPyQTq8BMA9Q1d/HqZokThXZXzDWJLupoM+BUaCdEJW+wzFPOJOjVHZPuhdJAzlSHhIgHdebaaBwFMxGRMVJ2CLPWPDPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 05:11:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 05:11:03 +0000
Content-Type: multipart/mixed; boundary="------------Wnps1geEkr9WnVZfc0BkdOcP"
Message-ID: <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
Date:   Wed, 24 Aug 2022 10:40:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     Tom Seewald <tseewald@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stefan Roese <sr@denx.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20220819190725.GA2499154@bhelgaas>
 <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
 <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a13c9d4c-0f10-4248-a71b-08da858f0a79
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6/xbm4mHBQl+aZWVUOV2j7AQL/JiTgijwlj489joG+2awJnxmGJlcNRuueVJ0FRpYFUaOmnZ2JOyhps5UhIiuOgiGZwNW30BSJpPSsnTcpK89Lu+JH5D4Y2+mjwrIrpXYYeWfpmKxl2aE5tt4OCrm+W3Uon/nDu8rvSRaE7Vae9/bwo/S6L/bNq04RDFGvGaEpYfvu8yYBbeUlt6x05rAOtMhZZd3tOHFBsuKKa+OfzGwXmcW7aTZ/2wQjzB3jFxv5fTi0943yi17kroxSK29RUhVmvymUyub6Qt62uyyXIb08/PNzLfW07xWrFWWxTIgektCyp31k/oUeAeNkrc5m09FQxNEZV2QcQ7vyhAmpEmh/l36uGEp1YTu2BuvM4f4VE4uFVKVZ2KYfwgfN9PSmEnvKPDyxl8SemcWg1zJ6+rmo/Rn2vu0NYfjAddP9mXTKsjrN3Ax9bVVbmeAjyZcvpV8MtdDT+yCMq/AxDIa70LQYxEcUcGA3Iw3WAPKfObPjN5bns18f7sEq/heitukoFI/5+uqzhrq5JQzt9uU9dqdh22uIrvPFOkx/IoKEOAXB9LrW+iuVrGQPO0Wq3gC9BYsPuHbOBCEvVuGjP8et4GSmUJzeT4zYOf/h3Qnd8IcsLyS0g/WTR7t8QuCfy86PeTqB+VQgusVzazN1htXQZdhranr0ZlIqxsMEYWaSNcnE/jsm1Qyo4I9PVTJWvB6PVxs28XsJWkmLf+HRFxqSKQTqj3SnzVXsZj9LYGOQ9o/r5/21a8smzCU5CIQ+XdAqEaYpzlc/v7jmrqC+rIaJDm4zQq//3w3eAVJgAmvuICqVoFoKRxa/rQWBTbM3cOqTBBq8XBOkpX2YS7WKdgdSEA/pCVhTXHbjteIazQ9EF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(54906003)(2906002)(966005)(45080400002)(66476007)(8676002)(478600001)(66556008)(6486002)(4326008)(66946007)(6916009)(235185007)(2616005)(33964004)(186003)(6512007)(26005)(21490400003)(6506007)(8936002)(5660300002)(86362001)(36756003)(53546011)(38100700002)(316002)(41300700001)(31686004)(6666004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzgvNG85TlNrU3VyNlRaSjd6UGZTM2NUSWR1T0lIeHg4YmxiZHFKTkpURmJt?=
 =?utf-8?B?aHV4WUNlZWxJeXlXd203Y05DV0RSMUk1MmpLMnhjZFBwcSt4YjZtMXdsOG54?=
 =?utf-8?B?blE3ZVNrbER1R1Q0WHl5SjN5bFlpNlo2TFQvZXRyKy9wN1FiZURDa3hIb29W?=
 =?utf-8?B?cHduK0ZZNDBCa0lMN3RTalUwdVB4Vms2RDMvYXdHU1NVdWlvZmIzeXkyL0ZG?=
 =?utf-8?B?VkEwMWEzQVVMQVFYaGdSZCtqT2FwM1JxRnVCMXpVcDN1S1VSalVyOFI3dDRh?=
 =?utf-8?B?bEJLOUNlYUl1TnkwRkwvY0JITk1wNHRFbkJPU0Z5NXFqWVdJYzZYckY4dHhH?=
 =?utf-8?B?OVp0Q0dLclQvbE9ENWVmQWE0dEFCZmRDRE5YRUl3NjdiTHJaV3ZtMXE0bTBo?=
 =?utf-8?B?ZVFnbllSTGNKZFRnU3lYWDlraGxUaTJ5QVFVSGdBeHJiRzNTdm9PQ29sQy9m?=
 =?utf-8?B?NzdMOVViWkZCU3RkcjBiTTMrMFhLMHV1dytQT29KMEZ1WSswa1dHY01DSkFs?=
 =?utf-8?B?NW95dWdMSUdodVFCUlJHNXRGRFpMRDlhSmtvRlFIVXRKZXRWR1c4M2JFNHp1?=
 =?utf-8?B?eWllWlY2OC9RV2pUUDBpekNJcVJHS3hCT21rOU1XdFJzclduZEp2V2wyRWpn?=
 =?utf-8?B?c09rcXRCYTBxQndOTklIaXBROGRWN0NhczV0VjVFVFprZXQyM0kzdUVYL0Fl?=
 =?utf-8?B?aFRFY2tLSEt0cGxMWWpPTlAwcW45ZjhiMGgvS0ExN3hMeFE0bzk3b0paYlA0?=
 =?utf-8?B?Q1B4SVZPMko0aTREZTM2S3VtQVV0K1IyYVIwYVp6NUh4dXRuOElML2l6ZG1a?=
 =?utf-8?B?dytsNGZWY1Q3UTV0dkJhSmhaMXRjZU14WDc4Lzc3V0QxaXd1Mm55R2gwWmQ3?=
 =?utf-8?B?azlNcDN1T2Z1MXc3WE54TXdySUJINStPZjNiYWFtYngvbDJRMFhEMjhBQnJ3?=
 =?utf-8?B?RHM3ejhZWExNckd3OTEwa1dNTW5vOUIveVRuZkRGUlozUUpxOUNmclcxaEx0?=
 =?utf-8?B?L2lmU3VzNVNKOVVCZmpNZnl1KzEvTDlMUWtyN0VXcy9Bck83RGFvL2dZbE9j?=
 =?utf-8?B?OXA2Si9jM3JCR2NtSmMrdXd6TnNHM2pGdXluWGRIOHVPUEx5TC8xd09iQkt6?=
 =?utf-8?B?bGFrSWR0MmM4dGNmTlM2T2UyK0w3T21TaDd0Mm1CRmRpSGdQMzR5eUxhbzh1?=
 =?utf-8?B?eEorQkVYU0dBbURUcnRIbTNKZDJQWDRxQnVVODZ3bXN6cU5SVWQ0dElnYXNW?=
 =?utf-8?B?Z3pjQUFiY0U0ZXRxVllZRFR2djlzNjdNUGo4bjNqeEJrZzBVRFBIMzVuZWha?=
 =?utf-8?B?Q21NWEc3a25YTTZwRERma1pLNWtZd0RzakJKQ2h2SENsd3E1L1FjN3VGWlRr?=
 =?utf-8?B?N0U3ejVSQkMyTjZMT045eWY2eHZuc01PbGRpVVlMVnE3bytZNThpY3BWYjZp?=
 =?utf-8?B?N3hLTXc4Zld1cWVVQW5GN2hkaEU1VXZFQWo2bldzSUptQ1VXeitRNC9KMFcr?=
 =?utf-8?B?a0FkWElOdm5uMnJqOHZlL1BWcFNkcW9WRlRTR29XUVBmZmtvaGJyODdjdXZv?=
 =?utf-8?B?ZDVmRlQwbXVUOHlBekVBdm9Xa0wwWEJuRlpMbTdlbWF5TFhJRG9RVCtnNXBF?=
 =?utf-8?B?cFVaZ3Y2QTdTVG5sZkF3MHV2cE5rTldHSE5JQitpakNETGJBc0lEWU51SXZW?=
 =?utf-8?B?V2RMcW01TW9BaThyWTBlR25OaFUyMW9Gb1daaHd3ZFNtN2kvTjRuUHhmYVhI?=
 =?utf-8?B?ejRLRTRlMHJqOWdTQ01XNG1wWHg5Y1ZiTU53cDBiOGhvWnVRUEJ3K2I5TS8y?=
 =?utf-8?B?YXhleEhsTjFkeSsvNm9Uc1prdjM4Q1kwWENTbVlWUGlZcWdFNHRsaE1YMWc3?=
 =?utf-8?B?V3NxeStUMFZUbDY3U0RhWUFCVzAxMjZ0MWQyRWFmWGtMQllDZHJyMm4yUUlu?=
 =?utf-8?B?amwramoxV2h3RzliN1dPbm1VRzAvSDRpKzhrdzdWREFod0E3d0Z0K2h0VitS?=
 =?utf-8?B?ZFpiSTB4NWJ5TTdyWlBDRktaM1BEU09lRDJhUm9KMkh3dTk5Y2NWQjV5cEVl?=
 =?utf-8?B?d0h4Vk96VnVYOXpmNUNrdUNvK1dJZ0lld0owMW40Z1VibDlHT3RyVC80MWJW?=
 =?utf-8?Q?tzUBAQAhGTAdNe15dKUBu8vs1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13c9d4c-0f10-4248-a71b-08da858f0a79
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 05:11:03.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LizQ1q7t1uA9sOpJ/FteMPn8o4UJsYkN3u/qmYwMYJG4k7FwNi7V3+KjfePYZjAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------Wnps1geEkr9WnVZfc0BkdOcP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/23/2022 10:34 PM, Tom Seewald wrote:
> On Sat, Aug 20, 2022 at 2:53 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>> Missed the remap part, the offset is here -
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.0-rc1%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Fnv.c%23L680&amp;data=05%7C01%7Clijo.lazar%40amd.com%7Cac6bd5bb5d4143ff9e5808da852982d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637968710652869475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=U5AkO7jfPGP2veXp%2FQkoLY92%2BHNOdMkwTwQCb0tRJPk%3D&amp;reserved=0
>>
>>
>> The trace is coming from *_flush_hdp.
>>
>> You may also check if *_remap_hdp_registers() is getting called. It is
>> done in nbio_vx_y files, most likely this one for your device -
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.0-rc1%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Fnbio_v2_3.c%23L68&amp;data=05%7C01%7Clijo.lazar%40amd.com%7Cac6bd5bb5d4143ff9e5808da852982d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637968710652869475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=N4ZbLJuRgddTqMdMo2vD5iJGMMmUJ1MPUVJwVIKThSU%3D&amp;reserved=0
>>
>> Thanks,
>> Lijo
> 
> Hi Lijo,
> 
> I would be happy to test any patches that you think would shed some
> light on this.
> 
Unfortunately, I don't have any NV platforms to test. Attached is an 
'untested-patch' based on your trace logs.

Thanks,
Lijo
--------------Wnps1geEkr9WnVZfc0BkdOcP
Content-Type: text/plain; charset=UTF-8; name="remap_hdp.diff"
Content-Disposition: attachment; filename="remap_hdp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBkN2ViMjNi
OGQ2OTIuLjc0M2EzYWM5MDlhZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwpAQCAtMjM3Niw2ICsyMzc2LDE1IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rldmlj
ZV9pcF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQkJCURSTV9FUlJPUigiYW1k
Z3B1X3ZyYW1fc2NyYXRjaF9pbml0IGZhaWxlZCAlZFxuIiwgcik7CiAJCQkJZ290byBpbml0X2Zh
aWxlZDsKIAkJCX0KKworCQkJLyogcmVtYXAgSERQIHJlZ2lzdGVycyB0byBhIGhvbGUgaW4gbW1p
byBzcGFjZSwKKwkJCSAqIGZvciB0aGUgcHVycG9zZSBvZiBleHBvc2UgdGhvc2UgcmVnaXN0ZXJz
CisJCQkgKiB0byBwcm9jZXNzIHNwYWNlLiBUaGlzIGlzIG5lZWRlZCBmb3IgYW55IGVhcmx5IEhE
UAorCQkJICogZmx1c2ggb3BlcmF0aW9uCisJCQkgKi8KKwkJCWlmIChhZGV2LT5uYmlvLmZ1bmNz
LT5yZW1hcF9oZHBfcmVnaXN0ZXJzICYmICFhbWRncHVfc3Jpb3ZfdmYoYWRldikpCisJCQkJYWRl
di0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyhhZGV2KTsKKwogCQkJciA9IGFkZXYt
PmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+aHdfaW5pdCgodm9pZCAqKWFkZXYpOwogCQkJ
aWYgKHIpIHsKIAkJCQlEUk1fRVJST1IoImh3X2luaXQgJWQgZmFpbGVkICVkXG4iLCBpLCByKTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9udi5jCmluZGV4IGIzZmJhOGRlYTYzYy4uM2FjN2ZlZjc0Mjc3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L252LmMKQEAgLTEwMzIsMTIgKzEwMzIsNiBAQCBzdGF0aWMgaW50
IG52X2NvbW1vbl9od19pbml0KHZvaWQgKmhhbmRsZSkKIAludl9wcm9ncmFtX2FzcG0oYWRldik7
CiAJLyogc2V0dXAgbmJpbyByZWdpc3RlcnMgKi8KIAlhZGV2LT5uYmlvLmZ1bmNzLT5pbml0X3Jl
Z2lzdGVycyhhZGV2KTsKLQkvKiByZW1hcCBIRFAgcmVnaXN0ZXJzIHRvIGEgaG9sZSBpbiBtbWlv
IHNwYWNlLAotCSAqIGZvciB0aGUgcHVycG9zZSBvZiBleHBvc2UgdGhvc2UgcmVnaXN0ZXJzCi0J
ICogdG8gcHJvY2VzcyBzcGFjZQotCSAqLwotCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9o
ZHBfcmVnaXN0ZXJzICYmICFhbWRncHVfc3Jpb3ZfdmYoYWRldikpCi0JCWFkZXYtPm5iaW8uZnVu
Y3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMoYWRldik7CiAJLyogZW5hYmxlIHRoZSBkb29yYmVsbCBh
cGVydHVyZSAqLwogCW52X2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShhZGV2LCB0cnVlKTsKIApk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggZmRlNjE1NGYyMDA5Li5hMDQ4MWUzN2Q3
Y2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwpAQCAtMTI0MCwxMiArMTI0MCw2IEBA
IHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2h3X2luaXQodm9pZCAqaGFuZGxlKQogCXNvYzE1X3By
b2dyYW1fYXNwbShhZGV2KTsKIAkvKiBzZXR1cCBuYmlvIHJlZ2lzdGVycyAqLwogCWFkZXYtPm5i
aW8uZnVuY3MtPmluaXRfcmVnaXN0ZXJzKGFkZXYpOwotCS8qIHJlbWFwIEhEUCByZWdpc3RlcnMg
dG8gYSBob2xlIGluIG1taW8gc3BhY2UsCi0JICogZm9yIHRoZSBwdXJwb3NlIG9mIGV4cG9zZSB0
aG9zZSByZWdpc3RlcnMKLQkgKiB0byBwcm9jZXNzIHNwYWNlCi0JICovCi0JaWYgKGFkZXYtPm5i
aW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMgJiYgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkK
LQkJYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyhhZGV2KTsKIAogCS8qIGVu
YWJsZSB0aGUgZG9vcmJlbGwgYXBlcnR1cmUgKi8KIAlzb2MxNV9lbmFibGVfZG9vcmJlbGxfYXBl
cnR1cmUoYWRldiwgdHJ1ZSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MyMS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYwppbmRleCAxZmY3
ZmM3YmIzNDAuLjYwYTFjZjAzZmRkYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMjEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jCkBA
IC02NDMsMTIgKzY0Myw2IEBAIHN0YXRpYyBpbnQgc29jMjFfY29tbW9uX2h3X2luaXQodm9pZCAq
aGFuZGxlKQogCXNvYzIxX3Byb2dyYW1fYXNwbShhZGV2KTsKIAkvKiBzZXR1cCBuYmlvIHJlZ2lz
dGVycyAqLwogCWFkZXYtPm5iaW8uZnVuY3MtPmluaXRfcmVnaXN0ZXJzKGFkZXYpOwotCS8qIHJl
bWFwIEhEUCByZWdpc3RlcnMgdG8gYSBob2xlIGluIG1taW8gc3BhY2UsCi0JICogZm9yIHRoZSBw
dXJwb3NlIG9mIGV4cG9zZSB0aG9zZSByZWdpc3RlcnMKLQkgKiB0byBwcm9jZXNzIHNwYWNlCi0J
ICovCi0JaWYgKGFkZXYtPm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMpCi0JCWFkZXYt
Pm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMoYWRldik7CiAJLyogZW5hYmxlIHRoZSBk
b29yYmVsbCBhcGVydHVyZSAqLwogCXNvYzIxX2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShhZGV2
LCB0cnVlKTsKIAo=

--------------Wnps1geEkr9WnVZfc0BkdOcP--
