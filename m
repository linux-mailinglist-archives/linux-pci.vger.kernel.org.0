Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC71D1B4E94
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDVUub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 16:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUub (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 16:50:31 -0400
Received: from localhost (mobile-166-175-187-227.mycingular.net [166.175.187.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ADD42077D;
        Wed, 22 Apr 2020 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587588630;
        bh=ba/VpW1rfJQ6IqlivIHGTiQZUhWmQAKxSxz45LgtBl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Hv7dVKaLz4pLARkfibDJyiXpH/zPj46TRBQ0CYLhopEeCwYDhh7CKOmHAbFrU9cSa
         fuxjJZhqwNyQkkW/b+CrhuwJVV3nhknevRti99E0/Qn4WlFEqZjqG54EI3z/rgOTtf
         Y/6nKQyqkAVKDaqc6lOH+ObLzg//5AsyYKFu+mFM=
Date:   Wed, 22 Apr 2020 15:50:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Roy Spliet <nouveau@spliet.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: Unrecoverable AER error when resuming from RAM (hda regression
 in 5.7-rc2)
Message-ID: <20200422205028.GA223132@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587494585.7pihgq0z3i.none@localhost>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm]

On Tue, Apr 21, 2020 at 03:08:44PM -0400, Alex Xu (Hello71) wrote:
> With 5.7-rc2, after resuming from suspend to RAM, I get:
> 
> [   55.679382] pcieport 0000:00:03.1: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:00.0
> [   55.679405] pcieport 0000:00:03.1: AER: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   55.679410] pcieport 0000:00:03.1: AER:   device [1022:1453] error status/mask=00100000/04400000
> [   55.679414] pcieport 0000:00:03.1: AER:    [20] UnsupReq               (First)
> [   55.679417] pcieport 0000:00:03.1: AER:   TLP Header: 40000004 0a0000ff fffc0e80 00000000
> [   55.679423] amdgpu 0000:0a:00.0: AER: can't recover (no error_detected callback)
> [   55.679425] snd_hda_intel 0000:0a:00.1: AER: can't recover (no error_detected callback)
> [   55.679455] pcieport 0000:00:03.1: AER: device recovery failed

I'm not at all confident in my decoding skills, but I *think* the TLP
header decodes to:

  Fmt           010b         3 DW header with data (32-bit address)
  Type          00000b       MWr
  Length        0x4          4 DW = 16 bytes
  Requester ID  0x0a00       0a:00.0
  Byte enables  0xff
  Address       0xfffc0e80

which would mean the 0a:00.0 GPU did a 16-byte write to 0xfffc0e80,
and the 00:03.1 Root Port reported that as an Unsupported Request.
I don't know why that would be unless the address is invalid.

Maybe that's supposed to be an MSI address?  Maybe a complete dmesg or
/proc/iomem would have a clue?

I feel like this UR issue could be a PCI core issue or maybe some sort
of misuse of PCI power management, but I can't seem to get traction on
it.

> Then the display freezes and the system basically falls apart (can't 
> even sudo reboot -f, need to use magic sysrq).
> 
> I bisected this to "ALSA: hda: Skip controller resume if not needed". 
> Setting snd_hda_intel.power_save=0 resolves the issue.

FWIW, the complete citation is c4c8dd6ef807 ("ALSA: hda: Skip
controller resume if not needed"),
https://git.kernel.org/linus/c4c8dd6ef807, which first appeared in
v5.7-rc2.

> I am using an ASRock B450 Pro4 with Realtek HDA codec:
> 
> [    1.009400] snd_hda_intel 0000:0a:00.1: enabling device (0000 -> 0002)
> [    1.009425] snd_hda_intel 0000:0a:00.1: Force to non-snoop mode
> [    1.009653] snd_hda_intel 0000:0c:00.3: enabling device (0000 -> 0002)
> [    1.021452] snd_hda_codec_generic hdaudioC0D0: ignore pin 0x7, too many assigned pins
> [    1.021461] snd_hda_codec_generic hdaudioC0D0: ignore pin 0x9, too many assigned pins
> [    1.021471] snd_hda_codec_generic hdaudioC0D0: ignore pin 0xb, too many assigned pins
> [    1.021480] snd_hda_codec_generic hdaudioC0D0: ignore pin 0xd, too many assigned pins
> [    1.021482] snd_hda_codec_generic hdaudioC0D0: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
> [    1.021482] snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    1.021483] snd_hda_codec_generic hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    1.021484] snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
> [    1.021484] snd_hda_codec_generic hdaudioC0D0:    dig-out=0x3/0x5
> [    1.021485] snd_hda_codec_generic hdaudioC0D0:    inputs:
> [    1.046053] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC892: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [    1.046054] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    1.046055] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [    1.046055] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [    1.046056] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [    1.046057] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
> [    1.046058] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
> [    1.046058] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
> 
> I also have an ASUS RX 480 graphics card with HDMI audio output.
