Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731AF41E312
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbhI3VOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 17:14:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:15201 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236609AbhI3VOg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 17:14:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225369510"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225369510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 14:12:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="438185535"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.134.229]) ([10.252.134.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 14:12:53 -0700
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
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
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
 <20210930115243-mutt-send-email-mst@kernel.org>
 <00156941-300d-a34a-772b-17f0a9aad885@linux.intel.com>
 <20210930204447.GA482974@rowland.harvard.edu>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <77aae23f-8c07-845b-90d7-389e1cd1ef5d@linux.intel.com>
Date:   Thu, 30 Sep 2021 14:12:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930204447.GA482974@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> If all you want to do is prevent someone from loading a bunch of
> drivers that you have identified as unhardened, why not just use a
> modprobe blacklist?

That wouldn't help for builtin drivers, we cannot control initcalls.

This LWN article has more details on the background.

https://lwn.net/Articles/865918/

-Andi


> Am I missing something?
>
> Alan Stern
