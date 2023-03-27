Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8E6CA89E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 17:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjC0PI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjC0PI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 11:08:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0422D78
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679929706; x=1711465706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U9u3cv2MwsZlQKtq+eCeoXSkL4so6A/2nOpVDUubMMg=;
  b=Zp8zNetF+VfScgrGQQG1NmKB61dcpNNG4wyZ6q0tz5pV6KKWbL5mcK4o
   q4RagxW4aggmUFo2Vc+Tpcqxud9N8ZEmkSeWAVpsbDTeMJSRGrNpieGVs
   BXuhqyHrv/X5R7tfRmTCIXZ5EdwGGdT81ER1eq2RjtnCUdia3bVmOhEsT
   7C0q0mRA7I93sn6gWEayVyxMZCwZkgAfFKMHiOYdqKoUcLzWLaLsA7zz+
   c0o+eYmoww0CAfavXKD3eUAGhwKw3hZo0VC7y4qJP91HkdJp04NVtFtI2
   lpQLWCzEB91F5OtEta5Vv7Jb0jEOkUmxfV6IZk5fmLljnbmIDDDNXxhbu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337791307"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="337791307"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 08:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="772745683"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="772745683"
Received: from igraber-mobl1.amr.corp.intel.com (HELO [10.251.1.127]) ([10.251.1.127])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 08:08:22 -0700
Message-ID: <bbd58049-1131-3aa2-b8f0-2a7a3a98bc55@linux.intel.com>
Date:   Mon, 27 Mar 2023 08:08:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] PCI/PM: Wait longer after reset when active link
 reporting is supported
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>, shuo.tan@linux.alibaba.com
References: <20230321095031.65709-1-mika.westerberg@linux.intel.com>
 <20230322221624.GA2497123@bhelgaas> <20230326062207.GA14559@wunner.de>
 <20230327094250.GC33314@black.fi.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230327094250.GC33314@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/27/23 2:42 AM, Mika Westerberg wrote:
> Hi,
> 
> On Sun, Mar 26, 2023 at 08:22:07AM +0200, Lukas Wunner wrote:
>> [cc += Ashok, Sathya, Ravi Kishore, Sheng Bi, Stanislav, Yang Su, Shuo Tan]
>>
>> On Wed, Mar 22, 2023 at 05:16:24PM -0500, Bjorn Helgaas wrote:
>>> On Tue, Mar 21, 2023 at 11:50:31AM +0200, Mika Westerberg wrote:
>>>> The PCIe spec prescribes that a device may take up to 1 second to
>>>> recover from reset and this same delay is prescribed when coming out of
>>>> D3cold (as that involves reset too). The device may extend this 1 second
>>>> delay through Request Retry Status completions and we accommondate for
>>>> that in Linux with 60 second cap, only in reset code path, not in resume
>>>> code path.
>>>>
>>>> However, a device has surfaced, namely Intel Titan Ridge xHCI, which
>>>> requires longer delay also in the resume code path. For this reason make
>>>> the resume code path to use this same extended delay than with the reset
>>>> path but only after the link has come up (active link reporting is
>>>> supported) so that we do not wait longer time for devices that have
>>>> become permanently innaccessible during system sleep, e.g because they
>>>> have been removed.
>>>>
>>>> While there move the two constants from the pci.h header into pci.c as
>>>> these are not used outside of that file anymore.
>>>>
>>>> Reported-by: Chris Chiu <chris.chiu@canonical.com>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216728
>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>> Lukas just added the "timeout" parameter with ac91e6980563 ("PCI:
>>> Unify delay handling for reset and resume"), so I'm going to look for
>>> his ack for this.
>>
>> Acked-by: Lukas Wunner <lukas@wunner.de>
>>
>>
>>> After ac91e6980563, we called pci_bridge_wait_for_secondary_bus() with
>>> timeouts of either:
>>>
>>>   60s for reset (pci_bridge_secondary_bus_reset() or
>>>       dpc_reset_link()), or
>>>
>>>    1s for resume (pci_pm_resume_noirq() or pci_pm_runtime_resume() via
>>>       pci_pm_bridge_power_up_actions())
>>>
>>> If I'm reading this right, the main changes of this patch are:
>>>
>>>   - For slow links (<= 5 GT/s), we sleep 100ms, then previously waited
>>>     up to 1s (resume) or 60s (reset) for the device to be ready.  Now
>>>     we will wait a max of 1s for both resume and reset.
>>>
>>>   - For fast links (> 5 GT/s) we wait up to 100ms for the link to come
>>>     up and fail if it does not.  If the link did come up in 100ms, we
>>>     previously waited up to 1s (resume) or 60s (reset).  Now we will
>>>     wait up to 60s for both resume and reset.
>>>
>>> So this *reduces* the time we wait for slow links after reset, and
>>> *increases* the time for fast links after resume.  Right?
>>
>> Good point.  So now the wait duration hinges on the link speed
>> rather than reset versus resume.
>>
>> Before ac91e6980563 (which went into v6.3-rc1), the wait duration
>> after a Secondary Bus Reset and a DPC-induced Hot Reset was
>> essentially zero.  And the Ponte Vecchio cards which necessitated
>> ac91e6980563 are usually plugged into servers whose Root Ports
>> support link speeds > 5 GT/s.  So the risk of breaking anything
>> with this change seems small.
>>
>> The reason why Mika is waiting only 1 second in the <= 5 GT/s case
>> is that we don't check for the link to become active for these slower
>> link speeds.  That's because Link Active Reporting is only mandatory
>> if the port is hotplug-capable or supports link speeds > 5 GT/s.
>> Otherwise it's optional (PCIe r6.0.1 sec 7.5.3.6).
>>
>> It would be user-unfriendly to pause for 60 sec if the device does
>> not come back after reset or resume (e.g. because it was removed)
>> and the fact that the link is up is an indication that the device
>> is present, but may just need a little more time to respond to
>> Configuration Space Requests.
>>
>> We *could* afford the longer wait duration in the <= 5 GT/s case
>> as well by checking if Link Active Reporting is supported and further
>> checking if the link came up after the 100 ms delay prescribed by
>> PCIe r6.0 sec 6.6.1.  Should Link Active Reporting *not* be supported,
>> we'd have to retain the shorter wait duration limit of 1 sec.
>>
>> This optimization opportunity for the <= 5 GT/s case does not have
>> to be addressed in this patch.  It could be added later on if it
>> turns out that users do plug cards such as Ponte Vecchio into older
>> Gen1/Gen2 Downstream Ports.  (Unless Mika wants to perfect it right
>> now.)
>>
> 
> No problem doing that :) I guess you mean something like the diff below,
> so that we use active link reporting and the longer time also for any
> downstream port that supports supports it, regardless of the speed.
> 
> I can update the patch accordingly.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 36d4aaa8cea2..b507a26ffb9d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5027,7 +5027,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  	if (!pcie_downstream_port(dev))
>  		return 0;
>  
> -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> +	if (!dev->link_active_reporting &&
> +	    pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {

Do we still need speed check? It looks like we can take this path
if link active reporting is not supported.

>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
>  		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
