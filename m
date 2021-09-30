Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9941DFE7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 19:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbhI3RTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 13:19:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:23826 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351834AbhI3RTD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 13:19:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225283798"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225283798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 10:17:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="438120652"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.134.229]) ([10.252.134.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 10:17:19 -0700
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org> <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org> <YVXOc3IbcHsVXUxr@kroah.com>
 <20210930105852-mutt-send-email-mst@kernel.org> <YVXWIVZupeAzT6bO@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f4b5a269-843f-6911-24fe-ebffb2bd4f9e@linux.intel.com>
Date:   Thu, 30 Sep 2021 10:17:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVXWIVZupeAzT6bO@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>> The "it" that I referred to is the claim that no driver should be
>> touching hardware in their module init call. Andi seems to think
>> such drivers are worth working around with a special remap API.
> Andi is wrong.

While overall it's a small percentage of the total, there are still 
quite a few drivers that do touch hardware in init functions. Sometimes 
for good reasons -- they need to do some extra probing to discover 
something that is not enumerated -- sometimes just because it's very old 
legacy code that predates the modern driver model.

The legacy drivers could be fixed, but nobody really wants to touch them 
anymore and they're impossible to test.

The drivers that probe something that is not enumerated in a standard 
way have no choice, it cannot be implemented in a different way.

So instead we're using a "firewall" the prevents these drivers from 
doing bad things by not allowing ioremap access unless opted in, and 
also do some filtering on the IO ports The device filter is still the 
primary mechanism, the ioremap filtering is just belts and suspenders 
for those odd cases.

If you want we can send an exact list, we did some analysis using a 
patched smatch tool.

-Andi

