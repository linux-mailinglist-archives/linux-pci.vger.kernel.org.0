Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1D2BB5A1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 20:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgKTTdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 14:33:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:12079 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKTTdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 14:33:45 -0500
IronPort-SDR: udjQMAVt19rO1Tq9lNLsghmmZSwm7uUnUzwleajjCaLOEYXuP2tMb6AUUVLjvMB6ldsp/SDR7r
 bAh2H9uDxhnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158570705"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="158570705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 11:33:41 -0800
IronPort-SDR: WoO+Obmn5/ED39/fgvTEcyrPaElg84xz/tFCYOXkZd+sVDw8mAQdHmUnOtJ6tNMTTtBVZCuGcw
 Jm3eQ69RBFUA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="545559814"
Received: from jalynchx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.69.108])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 11:33:41 -0800
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot for
 hotplug.
To:     "Raj, Ashok" <ashok.raj@intel.com>, Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <20200925230138.29011-1-ashok.raj@intel.com>
 <20201119075120.GA542@wunner.de> <20201119220807.GB102444@otc-nc-03>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6fc4bb9e-d46b-062e-1731-69a165e6fb35@linux.intel.com>
Date:   Fri, 20 Nov 2020 11:33:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119220807.GB102444@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/19/20 2:08 PM, Raj, Ashok wrote:
>> If an Attention Button is present, the current behavior is to bring up
>> the hotplug slot as soon as presence or link is detected.  We don't wait
>> for a button press.  This is intended as a convience feature to bring up
>> slots as quickly as possible, but the behavior can be changed if the
>> button press and 5 second delay is preferred.
> No personal preference, I thought that is how the code in Linux was
> earlier.
>
> Looks like we still don't subscribe to PDC if ATTN is present? So you don't
> get an event until someone presses the button to process hotplug right?
>
> pciehp_hpc.c:pcie_enable_notification()
> {
> ....
>
>           * Always enable link events: thus link-up and link-down shall
>           * always be treated as hotplug and unplug respectively. Enable
>           * presence detect only if Attention Button is not present.
>           */
>          cmd = PCI_EXP_SLTCTL_DLLSCE;
>          if (ATTN_BUTTN(ctrl))
>                  cmd |= PCI_EXP_SLTCTL_ABPE;
>          else
>                  cmd |= PCI_EXP_SLTCTL_PDCE;
> ....
> }
>
>
> Looks like we still wait for button press to process. When you don't have a
> power control yes the DLLSC would kick in and we would process them. but if
> you have power control, you won't turn on until the button press?
>
Yes, as per current logic, if attention button is present, then we don't
subscribe to PDC event changes. we wait for button press  to turn on/off
the slot.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

