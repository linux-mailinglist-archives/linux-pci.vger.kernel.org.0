Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD39C2C3212
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 21:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgKXUnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 15:43:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:5506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgKXUnU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Nov 2020 15:43:20 -0500
IronPort-SDR: M9XTzsrghfZmF6FNZkcoJir8t6/LYHNoB4TGQdNgdGmyYQxLUfCaeSMrzTkj1z9S7MGfKIJbZu
 Rp2m1f4i837w==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172170999"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="172170999"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:43:19 -0800
IronPort-SDR: Z2zMjG0uxYkIUHYJVJi9zAoYP4omDnNsPpVF0kmXCtjPOpVE2gagmJr479teT1vYzxUlTyJo6y
 6Eb38EplXg1A==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="370486561"
Received: from rgdanner-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.218.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:43:19 -0800
Subject: Re: [PATCH v7 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, ashok.raj@intel.com,
        knsathya@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Sinan Kaya <okaya@kernel.org>, haifeng.zhao@intel.com,
        chris.newcomer@canonical.com
References: <6349d22f-cf49-bab4-ad0f-a928e65622af@canonical.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <beefa995-e56c-3e66-a2f8-2d6f97a82498@linux.intel.com>
Date:   Tue, 24 Nov 2020 12:43:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6349d22f-cf49-bab4-ad0f-a928e65622af@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Guilherme,

On 11/24/20 10:45 AM, Guilherme G. Piccoli wrote:
> Hi Kuppuswamy Sathyanarayanan (and all involved here), thanks for the
> patch! I'd like to ask what is the status of this patchset - I just
> "parachuted" in the issue, and by tracking the linux-pci ML, I found
> this V7 (and all previous versions since V2). Also, noticed that Jay's
> email might have gotten lost in translation (he's not CCed in latest
> versions of the patchset).
> 
> I was able to find even another interesting thread that might be
> related, Ethan's patchset. So, if any of the developers can clarify the
> current status of this patchset or if the functionality hereby proposed
> ended-up being implemented in another patch, I appreciate a lot.
Thanks for bringing this up. Its waiting for Bjorn's comments/approval.

Bjorn, any comments ? Some of our customers also looking for this issue
fix. Please let me know.
> 
> Thanks in advance! Below, some references to lore archives.
> Cheers,
> 
> 

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
