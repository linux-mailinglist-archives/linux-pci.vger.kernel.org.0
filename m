Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9826B3742
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 08:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCJHWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 02:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCJHWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 02:22:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA30FEF14
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 23:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIi/YbotPge9gS+7WBMdJe/y2aLe+imRXnWcqIizZ0afVhRP7JA0zK96/K4AtB7lhUZcbaFXr9mBqVaOuBG1MHz4I9k2Z9J56WIusUxOuthdsQ09n/73XIVb/fmKl8fsgXMtVYRT1kymTA0vani0/ZKKZyFjTot3a/ZUa0cKeszwQ5MvCumf5kx1AaChNwxdnRpjoOadur8JEXYsPstyzs2EgngkTP+g1P4zeonOnIFUTJd0LXDSm9gb3y4UVME1FtBxbCMf8DwalmCkp0tU42gw62mUPD7i0lvBBTAuQg6HPoIYV6cIUgc0YyEVCDJnc9uUEfp5/ze09Q/pOYFD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkJ+NqNbKfvmkRgQiWmbJTUax9q4zUpBUQXPTo1aiEQ=;
 b=OFIVOj4Tll1lrCjPRTv9kifP8Xp2ZgP3knrTA7wXtAV9dw0Xtjf8C3YjRsBjLxCmJGF0DRIEpCG3Cfxr8NbL0iY6Joou1et+YiAm23yAiOWpFdi7QmAe4xu7yGAEJsy/dj3lZllRW7FqJV63pSwfo/zXqKjxaNwysTl6pUY3SQLoVaeu6OYduGvNvUWFNCr3QmqnCvsUa5qIVSbve36tvjkmmb9l3Z82u6Vo+OeQ1hWRFji0kuXpKU9Xm1pP/TJR03yggCe4jH37WcVZR2TKy2WXx2LTqsRCWQT2PqFsCK5niF3f2k8dOJLydTqwS9UFaSP7gLsEpjpUYvQIKpDBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkJ+NqNbKfvmkRgQiWmbJTUax9q4zUpBUQXPTo1aiEQ=;
 b=a6r5/xW7fCBUh3ykPvHVmaWY0v7mVwWil32uhPFhTzi0fIbu5Sapsh8RTGxVCGBnogCjcMv/0tLUu++REYHcMDoIzG6sRy92roZPfr32SciRcssSlQn4i0Gf1CCfUcvU13a1YfZrcFjLTNR4EeJxHCXUyP8f1c5mhn6IIDL3aG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 07:22:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::3ac0:104f:8959:a7fc]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::3ac0:104f:8959:a7fc%6]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 07:22:30 +0000
Message-ID: <6c96e52c-bb4c-4281-2422-ea056f4956fd@amd.com>
Date:   Fri, 10 Mar 2023 12:52:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
References: <20230309182514.GA1152206@bhelgaas>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230309182514.GA1152206@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 49756ad0-3745-4140-5f68-08db21383572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ruo8yQcmKJDZ5r+axVi4Mk7ZSanvSDe1/QUYuGgyQ1mjvuUGuF0WDxwDQmbUhgRMhupkCK4ov3/EHZamzlwSsr1jDBDNI1w/n9K05hqFjH4/uDc1Gj5YNLN24O5Dt+4xaVF5nEVw6OnRwUYXZQL9RJe6RXzrsZtcrQi5u8nNgtuHS19nCXAY5Dtu50jfshWj0JXcpxWNRH2uoydVW35E5Is4dLHc6tNKucRTRt21TfrC+1wj0eqiY7ZKdzTtjD/B3+ZhQnNV4myZ+gypE5H0usd3B7pQ1+I0BItRGF4dlVi3yVER+MNIV/Rq2MPsJQYCLfRHquJpFUR+ZT/zxVl+0mK/IwdcYmk4nBg3yub6lk9Hzm46yLcfZzkM7KCkv1x81+4PUGN574yvS64fFtYQuJFnXPxWCcJvgEeLdduZ5GlAPZ8kehFCpakQaBefAXTkWXlLcwqxxCAxSh+hnqnV1tps2c83PXu3mxpy4s/bA+jQ+bYYLpDWATLzgYg4Uo439/sXvp7rCf7fk9eNGo5j1Nh7nW3YXsHRptRDDZ//nYPRFmQnHOQKFegaGZzPdhpekJzTBmCowJeNwhjy7WFtP7ng+9jUaIGYPKNl8smtqzBzuVOBOv8L0c+obS0gmfuy/PVbeMD3xO4xru0rX2u74TXbWe/IDV7d7tztMQGLdjpuFkNAkAk1ZjHi/ZPSM/6JtV6YPsh78I85KhPwrvBPDkrQlWVlGeqUlA2nu+YDFtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(8936002)(478600001)(54906003)(6666004)(53546011)(6512007)(6506007)(26005)(186003)(6486002)(31696002)(38100700002)(966005)(2616005)(36756003)(83380400001)(5660300002)(2906002)(6916009)(4326008)(8676002)(41300700001)(31686004)(66946007)(316002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNON29pWGd0V3JNQitMZWhSNGVMS0VaT3dtNXl5dXdqbHh2bWlzc0I4d096?=
 =?utf-8?B?cUtYbjJpNm0vTXhlcnhZQ0MvT3pDYjZGY0ptMDVXdHZ4andVN29GMVZWMFFE?=
 =?utf-8?B?SlhzR2lRVUxWcjFlQi9SSzBjTWplSzhSaUpONHlYeENLNUx2UUNPTzhrL290?=
 =?utf-8?B?c0JYZjZTTkhsNVB3NW5CWi9QTXd1R0Y3c2UvLzFIejNCKzVuU1NZZVFYb2V0?=
 =?utf-8?B?c3VNZGdkMG5qTXM0SFNTWHJNTHJyWTZ3UW15ODl3S3JsQktSeUl3KzB5dUhN?=
 =?utf-8?B?ZXNuR1BCYTNySVl5M2JhaDF0T2NtSDRoVEJPaGtKR0xLTUpQNTd4SG55Wm42?=
 =?utf-8?B?dXB5cXpjQjdTM0s1SGk4QWpvRXNNWEJSZU5vSlNpbDVFNzZqWFVWT0k3UUgv?=
 =?utf-8?B?OHozSXlxUDZBY2RzYmtYVHBiNGUxcGFKMHFFUGFNM3lsVVhoamNwWEhNeC8y?=
 =?utf-8?B?eUJsNGxqWG1jS2phM0l3dXNmNGRpTTBncmtYZkFlVlZrWitYQm9mbTVvSjk4?=
 =?utf-8?B?WmYweUJ1aDlYZnBvTUw5Q2VWZXVZL2dRT215THVpS3VlNHI2ZXBuZ3A3K3Bo?=
 =?utf-8?B?b1gwODM2ZFdod24wY0NXUm1CbzBvd1NSbUFEaEJ6TksrYUJ1Q1kva1I4UjE5?=
 =?utf-8?B?ZGI2N1BUcUEybFJHT2VtbjNaU1BjWFNLVmJJcEJ4RnhWL09sZDZ0c2FFNVMv?=
 =?utf-8?B?dnU2MlNza1hIS2ZMeDR4OCtFdmswR1o5TVlmb2o5K2FNRGJqc0JubW9JRGRa?=
 =?utf-8?B?eWFuL21SeXY5OXRJdnFKZ1hjTW1wZ1Z2M2pYVVhHRGoyelNOU0dBQ2c1Mlkr?=
 =?utf-8?B?MGcrYS9JSHdrN1lnemEvRmRxZzd6UHR4dDVFUnBTYW5RV2I1TW9RSmNoT0Vv?=
 =?utf-8?B?djJwMGQ0Tk5pNEpQeDZuaFJTSUk5c2llSHlTWjluOWFldGxwVkFiZHBlY3pk?=
 =?utf-8?B?V05CSVQyaFp2MDdhOGxnUnRybnJkUGxDS2pCYWUySTBCKy9oTEZZdVJtUWFr?=
 =?utf-8?B?MVdQdEtNVlIwakQ1SWp6UEttWCtZd0hmR0NuMzZwdUNlZUloUHYvSVB5OXU1?=
 =?utf-8?B?RmlZOGRWRzBIa2E0dmNzNENqN2pnRURhaVcrZld6MFk2THd3YWNIUjJPWWFW?=
 =?utf-8?B?b1N1aG82RHhNK1M3Q3lRZTYwWkJqQUJZbDZCQlFSakJyV0FVNXY3WnRwbjBo?=
 =?utf-8?B?RVIyVmJ6cUdzRVdydS9LZkVJL2F0S2xJdlVUOXJBQjhDVXBQUVVNQ1BOOVVw?=
 =?utf-8?B?bkFFdGpRbzhYRjdac25mems4K3ZQSmdNYVNqWVJnMG9JZ01WaEMxWlU1dmpY?=
 =?utf-8?B?NmhuZmhNRHNDaWdSZkFOZ3VmUU10ak94Tm15M1lrVTFWaGlhWldZdktYdk5R?=
 =?utf-8?B?b1daVmo5Uk1HNTlXRWVQbnJmclNoaTFVMEZzUWJNREdTYjJCQUF5RWRPS1JF?=
 =?utf-8?B?N25LaDQrc2Y4ZmZOdGNYbjBJWnpGbk1yZGE3S0tiSU1kMmxiTW9YR3RUME9l?=
 =?utf-8?B?ZWMvaXR1MVhoRythZDc0dFBMSFVocUNsdjJtMDE4WFE3d0x0d1ZLMGZPT01V?=
 =?utf-8?B?bmMwdnRJMHRtU0VlSzM2WDNjZWtCSWJ6OGlDaEVDL3piZy9HVWIyMXl5T3Nt?=
 =?utf-8?B?NktJRzgwKzhBcnlvL29kcVBMK05IU0hxcmtjOHRocEhGOTlHMHorNy8xZ0NH?=
 =?utf-8?B?RTF4cXZOV1hHck1LVmxNVmZ6S1ZKam54ZGJOLytpSzdMODVvNjZQL0Z0WFhu?=
 =?utf-8?B?dEhFUlhvc0pDYnhQbDZZNFVXOCtQSSs1TjJGK1cxdHNOeDFnRTc3bFpQV05p?=
 =?utf-8?B?VG5Hbk96QVgvN2xQbTVGV3hTbFF0bWFqNDNjUDV2Y1RxQ1FhVXhjNk5CdW9I?=
 =?utf-8?B?RVdtUmhSWDdDUGJvSHJNeVdGTVBTM3dRSS9mUzFYbUl5QVc0dnlwdDhlUlhB?=
 =?utf-8?B?WXovNkNyYzZEVWdBRDc1czhEdHpTNGptUHBUTVlLYzJFcTVWRmZieWU0cElI?=
 =?utf-8?B?bFZHd2dkNzdmQ2w2MFZrcG9EZ1JxT3Nxd0Q0V1NYb3c0QXhCdU0rYUtYR3lh?=
 =?utf-8?B?VnlJM1YwUm43V296Q2hNZUtnRlQraXo3UWVQbzFiTC90c0RydlJDbFMrNEx6?=
 =?utf-8?Q?Z4lOGziMqwDscORZRORjghJGF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49756ad0-3745-4140-5f68-08db21383572
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 07:22:30.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++3RX2K0qbgFJEIC/jOWH1aBIRQYEDj7J3nbHbpw42BTK+0UhFBvPfhkKEJF9CFlkodYG4P7lhXP0eMu8+wtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/9/2023 11:55 PM, Bjorn Helgaas wrote:
> On Thu, Mar 09, 2023 at 01:04:17PM +0530, Basavaraj Natikar wrote:
>> On 3/9/2023 4:34 AM, Limonciello, Mario wrote:
>>>> -----Original Message-----
>>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>>> Sent: Wednesday, March 8, 2023 16:44
>>>> To: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
>>>> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; Limonciello, Mario
>>>> <Mario.Limonciello@amd.com>; thomas@glanzmann.de
>>>> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>>>>
>>>> Let's mention the vendor and device name in the subject to make the
>>>> log more useful.
>> Sure will change subject as below.
>> Add quirk on AMD 0x15b8 device to clear MSI-X enable bit
> "0x15b8" is not really useful in a subject line.  Use a name
> meaningful to users, like something "lspci" reports (I don't see
> "1002:15b8" in https://pci-ids.ucw.cz/read/PC/1002; it would be nice
> to add it) or at least something like "USB controller".   You can look
> at the history of drivers/pci/quirks.c to see examples.

Thank you Bjorn for the reference , "lscpi" output

03:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:15b8] (prog-if 30 [XHCI])
        Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:d601
..

will change subject as below then:

Add quirk on AMD USB Controller 15b8 to restore MSI-X enable bit
and change commit message accordingly

>> Yes correct, even though pci_restore_state restores all pci registers states
>> including MSI-X bits __pci_restore_msix_state after resume but internal AMD
>> controller's MSI_X enable bit is out of sync and AMD controller fails to maintain 
>> internal MSI-X enable bits.
> So the register value *change* is important, and you force a different
> value by writing something different at suspend-time so the value at
> restore-time will be different.  That's a little obscure since those
> points are far separated.
>
> Also it changes the behavior (masking MSI-X at suspend-time), which
> complicates the analysis since we have to verify that we don't need
> MSI-X after the quirk runs.  And the current quirk relies on the fact
> that PCI_MSIX_FLAGS_ENABLE is set, which again complicates the
> analysis (I guess if MSI-X is *not* enabled, you might not need the
> quirk at all?)
>
> Is there any way you could do the quirk at resume-time, e.g., if MSI-X
> is supposed to be enabled, first disable it and immediately re-enable
> it?

Yes agreed , I will change the quirk to apply in resume instead of
suspend which also resolves the issue as below i.e. restoring during
resume if MSI-X is enabled works.

static void quirk_restore_msix_en(struct pci_dev *dev)
{
        u16 ctrl;

        pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
        if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
                return;

        ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
        pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
        ctrl |= PCI_MSIX_FLAGS_ENABLE;
        pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
}
DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x15b8, quirk_restore_msix_en);

Thanks,
--
Basavaraj

