Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59E44EF3C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhKLW10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 17:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhKLW10 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 17:27:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE4060698;
        Fri, 12 Nov 2021 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636755874;
        bh=GhiB9LBULf1zzu4IPDLyIVCpbPIJfv9XB+BrQ+LQCro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sa5Q56eWquI//iC2dXBi/O89s44QfCwOJwpFisqc1imOTdAjAC5dnpfoBayUndLFd
         zBc0/W+1PCHDS4spGbo/qMg80J8fwNs2NuBUv+2IMLvxHn/y1Gv6GxOXGLU3TSZbEz
         XNYFGtlmldenYo8N8siMq7TxpMuUKm0vyKliaRz+DUx4zi7E/OW+0K3WGnGlluSzkZ
         UiahWzUN2aCgI5u37n2aSG2bBhhQpHgwzPgQljDAAvd6cKyJZLVrr9dd204M+dIunV
         3Jzz63yJ7KUol3f1T3SyOEdJAeZwe6/wkXQd7Grr7Fmt0Yzl5v8spTqhoS4JgpACHF
         Y/o1qOydalcPg==
Date:   Fri, 12 Nov 2021 16:24:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     nicolarevelant44@gmail.com
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 214995] New: Sof audio didn't recognize Intel Smart Sound
 (SST) speakers, microphone and headphone jack
Message-ID: <20211112222432.GA1423380@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-214995-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 09:11:45AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214995
> 
>             Bug ID: 214995
>            Summary: Sof audio didn't recognize Intel Smart Sound (SST)
>                     speakers, microphone and headphone jack
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.11.0-40-generic
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: nicolarevelant44@gmail.com
>         Regression: No
> 
> Created attachment 299549
>   --> https://bugzilla.kernel.org/attachment.cgi?id=299549&action=edit
> The output of dmesg and lspci -v
> 
> I have a Huawei Matebook D15 notebook with Intel Smart Sound Technology as
> sound card. SST includes speakers, microphone and headphone jack so none of the
> 3 work. Bluetooth and USB headphones work. I have already tried to change
> "options snd_intel_dspcfg dsp_driver" and reload alsa (alsa reload) for each
> value but nothing (only small changes in dmesg).
> The first lines of dmesg_dump.txt are errors because of the 'alsa reload'
> command. The log is verbose because I add some options from this web page:
> https://thesofproject.github.io/latest/getting_started/intel_debug/suggestions.html
> 
> My sound card is listed in PCI so the last lines of dmesg_dump.txt are the
> output of the 'lspci -v' command
> 
> aplay -l shows only 3 HDMI outputs with sof-hda-dsp

Hi Nicola,

Thanks very much for the report and sorry for the problem.

It's possible there's a power management issue, e.g., reads to the
00:1f.3 device are timing out because the device is in D3cold, but I
can't tell from the part of the dmesg log you attached.  In that case,
reads will generally return ~0 (0xffffffff), but it looks like some
reads *do* return valid data, e.g.,

  sof-audio-pci 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
  sof-audio-pci 0000:00:1f.3: found ML capability at 0xc00

I don't see an obvious PCI core connection here, so I cc'd the SOF
maintainers in case they have any insight.

  - It looks like you're running v5.11.0.  Can you reproduce the same
    problem on a current kernel, e.g., v5.15?  It's possible the
    problem has been fixed since v5.11.

  - Did this ever work?  In other words, is this a regression?  If so,
    what's the newest kernel you know of that *did* work?  In the
    worst case, we could bisect to identify a change that broke it.

  - It might be useful if you could attach the complete dmesg log and
    output of "sudo lspci -vv" to the bugzilla.

Bjorn
