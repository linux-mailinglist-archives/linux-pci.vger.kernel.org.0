Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413C18D4C5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfHNNcs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 09:32:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:10031 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfHNNcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 09:32:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 06:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="178157851"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2019 06:32:44 -0700
Subject: Re: Titan Ridge xHCI may stop to working after re-plugging the dock
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
References: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com>
 <1562759399.5312.6.camel@suse.com> <87pnm6sd10.fsf@linux.intel.com>
 <77580193-D67B-48B1-8528-03ED4E7E8D64@canonical.com>
 <87blxqs3fh.fsf@linux.intel.com>
 <749516DB-65B6-4D59-8C77-7883649D1F25@canonical.com>
 <8113f4a4-e96e-9b73-cd7a-1dbb800d68bb@linux.intel.com>
 <203745C2-85AF-4A37-8628-636632D14564@canonical.com>
 <78466959-E500-4AA0-8440-CBF80DBFE260@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <9f05b78d-7b28-1e8c-bdf9-22d0c148c719@linux.intel.com>
Date:   Wed, 14 Aug 2019 16:34:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <78466959-E500-4AA0-8440-CBF80DBFE260@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.8.2019 9.50, Kai-Heng Feng wrote:
> Hi Mathias,
> 
> at 21:24, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
>> at 22:45, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
> 
> [snipped]
> 
>> Yes, disabling runtime PM can workaround this issue.
> 
> What’s next step here? Is it a firmware bug?
> 

Can't say.
 From xhci driver point of view the 39:00.0 xHC controller isn't accessible after dock
is plugged back in. Looks like PCI side has issues getting the controller back to D3
after it was runtime suspended to D0 at dock unplug:

[  346.455568] pci_raw_set_power_state: 25 callbacks suppressed
[  346.455574] xhci_hcd 0000:39:00.0: Refused to change power state, currently in D3

As Mika suggested in the bug take a look at PCI side, especially the PCI status before
a failing dock replug.

-Mathias
