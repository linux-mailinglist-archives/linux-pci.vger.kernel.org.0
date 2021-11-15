Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1184E4526B2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 03:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbhKPCKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 21:10:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:28673 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238127AbhKORyo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 12:54:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="294311134"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="294311134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 09:49:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="494113110"
Received: from asperbe-mobl.amr.corp.intel.com (HELO [10.255.91.105]) ([10.255.91.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 09:49:53 -0800
Subject: Re: [Bug 214995] New: Sof audio didn't recognize Intel Smart Sound
 (SST) speakers, microphone and headphone jack
To:     Bjorn Helgaas <helgaas@kernel.org>, nicolarevelant44@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, linux-pci@vger.kernel.org
References: <20211112222432.GA1423380@bhelgaas>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4cf00ae5-f3d7-ecb5-7dae-f8629becc0d2@linux.intel.com>
Date:   Mon, 15 Nov 2021 11:49:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211112222432.GA1423380@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/12/21 4:24 PM, Bjorn Helgaas wrote:
> On Fri, Nov 12, 2021 at 09:11:45AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=214995
>>
>>             Bug ID: 214995
>>            Summary: Sof audio didn't recognize Intel Smart Sound (SST)
>>                     speakers, microphone and headphone jack
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 5.11.0-40-generic
>>           Hardware: Intel
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: high
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: nicolarevelant44@gmail.com
>>         Regression: No
>>
>> Created attachment 299549
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=299549&action=edit
>> The output of dmesg and lspci -v
>>
>> I have a Huawei Matebook D15 notebook with Intel Smart Sound Technology as
>> sound card. SST includes speakers, microphone and headphone jack so none of the
>> 3 work. Bluetooth and USB headphones work. I have already tried to change
>> "options snd_intel_dspcfg dsp_driver" and reload alsa (alsa reload) for each
>> value but nothing (only small changes in dmesg).
>> The first lines of dmesg_dump.txt are errors because of the 'alsa reload'
>> command. The log is verbose because I add some options from this web page:
>> https://thesofproject.github.io/latest/getting_started/intel_debug/suggestions.html
>>
>> My sound card is listed in PCI so the last lines of dmesg_dump.txt are the
>> output of the 'lspci -v' command
>>
>> aplay -l shows only 3 HDMI outputs with sof-hda-dsp
> 
> Hi Nicola,
> 
> Thanks very much for the report and sorry for the problem.
> 
> It's possible there's a power management issue, e.g., reads to the
> 00:1f.3 device are timing out because the device is in D3cold, but I
> can't tell from the part of the dmesg log you attached.  In that case,
> reads will generally return ~0 (0xffffffff), but it looks like some
> reads *do* return valid data, e.g.,
> 
>   sof-audio-pci 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
>   sof-audio-pci 0000:00:1f.3: found ML capability at 0xc00
> 
> I don't see an obvious PCI core connection here, so I cc'd the SOF
> maintainers in case they have any insight.
> 
>   - It looks like you're running v5.11.0.  Can you reproduce the same
>     problem on a current kernel, e.g., v5.15?  It's possible the
>     problem has been fixed since v5.11.
> 
>   - Did this ever work?  In other words, is this a regression?  If so,
>     what's the newest kernel you know of that *did* work?  In the
>     worst case, we could bisect to identify a change that broke it.
> 
>   - It might be useful if you could attach the complete dmesg log and
>     output of "sudo lspci -vv" to the bugzilla.

That seems like a known issue already tracked at
https://github.com/thesofproject/linux/issues/3248

There's a set of devices based on the ES8316/36 I2S audio codec which
needs dedicated quirks. In the existing reports the Huawei Matebook D15
is listed as using that codec.

The latest experimental code we have is here:
https://github.com/thesofproject/linux/pull/3107/commits

If confirmed, can we track this on GitHub so that all results for this
sort of devices are collected in one place? Thanks!


