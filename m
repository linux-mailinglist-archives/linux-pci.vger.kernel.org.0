Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5156191E51
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 02:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCYBAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 21:00:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:56575 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCYBAd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 21:00:33 -0400
IronPort-SDR: 5F/LUuo5f3F1jXFLv4wfFvSdd2SNYFYic2tvbw088/72N7L/iWE3shXKdg3KnkiKWGo35ZxD3S
 UBOvwE5lpJLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 18:00:32 -0700
IronPort-SDR: 10z++ObboiGRreXHC3jhskZ2nFNMkJi0JuPSu4Wk9RZgjCXbi3RKT+yPmMM9Bm6rF9cprQVSXW
 V54SZkuD9vww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="265368200"
Received: from hmendezc-mobl1.amr.corp.intel.com (HELO [10.254.108.97]) ([10.254.108.97])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2020 18:00:31 -0700
Subject: Re: [PATCH v18 10/11] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20200324213710.GA48671@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f71c989b-b8f8-3437-b086-a97c2aa1e2c5@linux.intel.com>
Date:   Tue, 24 Mar 2020 18:00:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324213710.GA48671@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/24/20 2:37 PM, Bjorn Helgaas wrote:
> This is really ugly.  What's the story on this firmware?  It sounds
> defective to me.
I think there is no defined standard for this. I have checked few
_DSM implementations. Some of them return default value and some
don't. But atleast in the test hardware I use, we need this check.

> 
> Or is everybody that uses _DSM supposed to check before evaluating it?
I think its safer to do this check.
> E.g.,
> 
>    if (!acpi_check_dsm(...))
>      return -EINVAL;
> 
>    obj = acpi_evaluate_dsm(...);
> 
> If everybody is supposed to do this, it seems like the check part
> should be moved into acpi_evaluate_dsm().

