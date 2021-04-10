Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237E435B014
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhDJTXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 15:23:34 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:44405 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhDJTXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 15:23:33 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1A9A51003D000;
        Sat, 10 Apr 2021 21:23:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DCAFB1E6B5; Sat, 10 Apr 2021 21:23:14 +0200 (CEST)
Date:   Sat, 10 Apr 2021 21:23:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Roy Spliet <nouveau@spliet.org>
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
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
Message-ID: <20210410192314.GB16240@wunner.de>
References: <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de>
 <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de>
 <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
 <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
 <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
 <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 10, 2021 at 04:51:27PM +0100, Roy Spliet wrote:
> Can I ask someone with more
> technical knowledge of snd_hda_intel and vgaswitcheroo to brainstorm about
> the possible challenges of nouveau taking matters into its own hand rather
> than keeping this PCI quirk around?

It sounds to me like the HDA is not powered if no cable is plugged in.
What is reponsible then for powering it up or down, firmware code on
the GPU or in the host's BIOS?

Ideally, we should try to find out how to control HDA power from the
operating system rather than trying to cooperate with whatever firmware
is doing.  If we have that capability, the OS should power the HDA up
and down as it sees fit.

Thanks,

Lukas
