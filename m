Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810DA35B07C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDJUsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 16:48:36 -0400
Received: from mupuf.org ([167.71.42.210]:41458 "EHLO mupuf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhDJUsf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Apr 2021 16:48:35 -0400
Received: from [IPv6:2a01:4b00:86b9:100:9ede:1593:85ef:7eda] (unknown [IPv6:2a01:4b00:86b9:100:9ede:1593:85ef:7eda])
        by Neelix.spliet.org (Postfix) with ESMTPSA id 03CC4F20011;
        Sat, 10 Apr 2021 21:48:15 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 Neelix.spliet.org 03CC4F20011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliet.org;
        s=default; t=1618087696;
        bh=G/KMHNxJ10tQbDe69nA++juz4fZynQZtQ/TmQnU8gZU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rtcv1a0XHMirOX80HxcGaWbLsoJRj6qdJd3vWIhMsW3jREz5OLGRbkylBUe31GukR
         KfHjxMcHhGdDpL4mBMubQ+bys/OMe0DzF4R6g6BgrfpZktq2tA/AFgr1s8EkUvOXgO
         11vjcgkRFBdspV765d/qjjBXIc5u//qW2yTaT+yI=
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, Alex Deucher <alexander.deucher@amd.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Aaron Plattner <aplattner@nvidia.com>
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
From:   Roy Spliet <nouveau@spliet.org>
Message-ID: <bddba2ca-15d5-7fd3-5b64-f4ba7e179ec0@spliet.org>
Date:   Sat, 10 Apr 2021 21:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210410192314.GB16240@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on Neelix
X-Virus-Scanned: clamav-milter 0.103.2 at Neelix
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Op 10-04-2021 om 20:23 schreef Lukas Wunner:
> On Sat, Apr 10, 2021 at 04:51:27PM +0100, Roy Spliet wrote:
>> Can I ask someone with more
>> technical knowledge of snd_hda_intel and vgaswitcheroo to brainstorm about
>> the possible challenges of nouveau taking matters into its own hand rather
>> than keeping this PCI quirk around?
> 
> It sounds to me like the HDA is not powered if no cable is plugged in.
> What is reponsible then for powering it up or down, firmware code on
> the GPU or in the host's BIOS?

Sometimes the BIOS, but definitely unconditionally the PCI quirk code: 
https://github.com/torvalds/linux/blob/master/drivers/pci/quirks.c#L5289

(CC Aaron Plattner)

> 
> Ideally, we should try to find out how to control HDA power from the
> operating system rather than trying to cooperate with whatever firmware
> is doing.  If we have that capability, the OS should power the HDA up
> and down as it sees fit.
> 
> Thanks,
> 
> Lukas
> 

