Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61C435D0C2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhDLTGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 15:06:49 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:55073
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236839AbhDLTGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 15:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THCGG4z5Hv2dDZ4BrQ2JC+IRFaWimfaVrW4aIEGdPBl1+LMZYsrahj81C0ePgI59e22pHHyDdktK2Houwh6SR9+dJs/cZwngSfbeKpgHEIOnjlp4bxuLLyTQyiYhW3FyBaVIgloYZogp2kFRNcZmHjhjBUbwIIuWllJZ0iw0OC9UfaMonL2ZjYf3aIR0muBLkqdvisk6b7v1/6kWtyU69l28fZY9F2GwNxuSiqFIALfsFN+Y/fu/P41L0NFJbGZpfH6i+pQDUIsBhQ4Ljak5zcUppSWjwoO/DI9i+mIe2QQ5ILwE13+b6SW8xns4jU5H9DGp9DyWKaQxZbUX/hHrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsCsHVaLb8Lc3tX5ttjfVbe+p8TxXyI5VcwSxGS5hjg=;
 b=fEQQLoBaGqBc6xcxwbSFaMsuQtoCtrOuYxRnBkVvekAKjnQWtr8Go6cyyEyQIHdM8wcsw5Wn6TNeUNVirvNY3ZklO1oftIs/s+jG74arne4ksCG2APGD+5y8no/9+btIifqHejlTZCS75ZDY4AtopPzeaJ1UHb2jjpEcd3O36wKkiPzncZELajK+9eioY6VohaFj8vlVW6SkMl/V82ZQGaJigafFpopfJaFpX5tWzbzn1JJact80pNOzeKSDuOYN+GG9t6MtYOpYBGYxFu3jktBzwcnI2+cGfg9z+1gxqnCVr2PkHjoM2IOMIlXt5sHySVY5CTFh3n9JK5UoLcxXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsCsHVaLb8Lc3tX5ttjfVbe+p8TxXyI5VcwSxGS5hjg=;
 b=L33lqhe/p9b1236FfoUoBcjuuFBSFnULY4kfdQct2SUFLXjFXjES1NDJXiJpuw+jFJ1drdJ0VtRJs+345KsfuU8lyLCzryHg84A7Qq3Dedv/drYAeBIrm7ftDRn2kNCRU7rA7J/9Tf/8GBYDAIsbnQNlXx3rwCJrfDT97GLxnlvyfsg3f1E0pAXigSKlG0pQ7gVJkkpxbiFBXNfFzqEQed0jVjGoWg5qLZygjYzTwQe4j536OjVgoILdG+qAAdirRckLa51gCkCisBKp43GWVRBa2Xny4/+NkVrBMCNr380P3DpjF0ZVTE3kHSc0ihLuPco/1AnQZi8PlP77Gz8d/w==
Received: from DM5PR15CA0030.namprd15.prod.outlook.com (2603:10b6:4:4b::16) by
 MN2PR12MB3406.namprd12.prod.outlook.com (2603:10b6:208:c9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Mon, 12 Apr 2021 19:06:29 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::a5) by DM5PR15CA0030.outlook.office365.com
 (2603:10b6:4:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Mon, 12 Apr 2021 19:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 19:06:29 +0000
Received: from treble.plattner.fun (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 19:06:28 +0000
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Roy Spliet <nouveau@spliet.org>, Lukas Wunner <lukas@wunner.de>
CC:     Karol Herbst <kherbst@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>
References: <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de>
 <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
 <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
 <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
 <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org>
 <20210410192314.GB16240@wunner.de>
 <bddba2ca-15d5-7fd3-5b64-f4ba7e179ec0@spliet.org>
From:   Aaron Plattner <aplattner@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <81b2a8c7-5b0b-b8fa-fbed-f164128de7a3@nvidia.com>
Date:   Mon, 12 Apr 2021 12:06:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <bddba2ca-15d5-7fd3-5b64-f4ba7e179ec0@spliet.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c0cace-b1c5-4466-7c69-08d8fde613fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3406:
X-Microsoft-Antispam-PRVS: <MN2PR12MB340650AA121698337DB672EDCD709@MN2PR12MB3406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWsJoa3VvrtGILD9VnaEynscIvaXaSJnJNz3S0103wTsOS8RyaJrlFIsamJJDzqYK9wLl5ZCqyC43rudutLT+aWvxJXhamkc9/I1Dt87KIAdQKPshOgdOkOsjMjTG025PEa+OiR9j2n6AVCvVatzGGZZEQGdYF2YsvdwbDzzInucYyCwCprCbOUKG2+dS4tUIrDb7kl2daN55wqhfk5fznyEBdtvF0mjxiHndT4D4Wuz+v8u2vVxscsxFbdgseF/MsaOVjJhtD/QIh5iRBu78c4/3XduPqUlbt1s7ecKflUQScEtCQcDTsYjQoijahyAWhDLcUkWjIO6fYcpjI9d8ZAyEx1lzZIDFcggHxrtovglpmK1grXJSHapPKObmxZLNd+3kJWCg8NXplr+JzBGshr7l/kLT+L84PxiqJyMxWfrKJewWszcoRHzKJQ1rIFtwssVu//heMumqHOcdDbxtxbEfu40oKm1SrUMi2fosiec+6Qa6Wv9IW1j96YMO7WXtF1zXeENffgQvlmMhj4A5UkBsqWm4PZRmu/lArT4CDyXdl/63Zk97Ay5ke/SAqhy6/BrCxCeN5zDSyoWQHtIXmo8ChLHEwT1iTLicn4NYI14FRjupcBY/SOtpbrdgUK8D3MPRn3PmzNvSNonXa3bNNDwBbjPrLt2GrQnEnSYLrVwvLEduL4EWIn5FWlbEZZddR3xHiO8SojYVztF1vMT16+TgdIvLiEzaTEb4jnaqhw7klHYKn98DxGz33iid4W4suwxpKR8EUkwaLSk9hW6dQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(36840700001)(31686004)(110136005)(16526019)(8676002)(86362001)(70206006)(316002)(478600001)(7636003)(186003)(8936002)(2906002)(82310400003)(36906005)(966005)(82740400003)(53546011)(36756003)(7416002)(83380400001)(26005)(336012)(54906003)(47076005)(2616005)(31696002)(5660300002)(70586007)(4326008)(356005)(36860700001)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 19:06:29.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c0cace-b1c5-4466-7c69-08d8fde613fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3406
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/10/21 1:48 PM, Roy Spliet wrote:
> Op 10-04-2021 om 20:23 schreef Lukas Wunner:
>> On Sat, Apr 10, 2021 at 04:51:27PM +0100, Roy Spliet wrote:
>>> Can I ask someone with more
>>> technical knowledge of snd_hda_intel and vgaswitcheroo to brainstorm 
>>> about
>>> the possible challenges of nouveau taking matters into its own hand 
>>> rather
>>> than keeping this PCI quirk around?
>>
>> It sounds to me like the HDA is not powered if no cable is plugged in.
>> What is reponsible then for powering it up or down, firmware code on
>> the GPU or in the host's BIOS?
> 
> Sometimes the BIOS, but definitely unconditionally the PCI quirk code: 
> https://github.com/torvalds/linux/blob/master/drivers/pci/quirks.c#L5289
> 
> (CC Aaron Plattner)

My basic understanding is that the audio function stops responding 
whenever the graphics function is powered off. So the requirement here 
is that the audio driver can't try to talk to the audio function while 
the graphics function is asleep, and must trigger a graphics function 
wakeup before trying to communicate with the audio function. I think 
there are also requirements about the audio function needing to be awake 
when the graphics driver is updating the ELD, but I'm not sure.

This is harder on Windows because the audio driver lives in its own 
little world doing its own thing but on Linux we can do better.

>> Ideally, we should try to find out how to control HDA power from the
>> operating system rather than trying to cooperate with whatever firmware
>> is doing.  If we have that capability, the OS should power the HDA up
>> and down as it sees fit.

After system boot, I don't think there's any firmware involved, but I'm 
not super familiar with the low-level details and it's possible the 
situation changed since I last looked at it.

I think the problem with having nouveau write this quirk is that the 
kernel will need to re-probe the PCI device to notice that it has 
suddenly become a multi-function device with an audio function, and 
hotplug the audio driver. I originally looked into trying to do that but 
it was tricky because the PCI subsystem didn't really have a mechanism 
for a single-function device to become a multi-function device on the 
fly and it seemed easier to enable it early on during bus enumeration. 
That way the kernel sees both functions all the time without anything 
else having to be special about this configuration.

-- Aaron

>> Thanks,
>>
>> Lukas
