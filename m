Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D244C4CB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhKJQIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 11:08:10 -0500
Received: from office.oderland.com ([91.201.60.5]:39890 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhKJQIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 11:08:10 -0500
Received: from [193.180.18.161] (port=49720 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mkq6C-00DWE5-K1; Wed, 10 Nov 2021 17:05:20 +0100
Message-ID: <14006026-de76-41d6-f4dc-cdbdd5817dc7@oderland.se>
Date:   Wed, 10 Nov 2021 17:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [PATCH v2] PCI/MSI: Move non-mask check back into low level
 accessors
Content-Language: en-US
From:   Josef Johansson <josef@oderland.se>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jgross@suse.com,
        linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org, Jason Andryuk <jandryuk@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx>
 <87cznqg5k8.ffs@tglx> <d1cc20aa-5c5c-6c7b-2e5d-bc31362ad891@oderland.se>
 <89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se>
 <5b3d4653-0cdf-e098-0a4a-3c5c3ae3977b@oderland.se> <87k0ho6ctu.ffs@tglx>
 <87h7cs6cri.ffs@tglx> <87pmr92xek.ffs@tglx>
 <b003df90-0c85-a51c-0e8a-600a85912d85@oderland.se>
In-Reply-To: <b003df90-0c85-a51c-0e8a-600a85912d85@oderland.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/10/21 14:31, Josef Johansson wrote:
> On 11/9/21 15:53, Thomas Gleixner wrote:
>> On Thu, Nov 04 2021 at 00:27, Thomas Gleixner wrote:
>>>  
>>> -		if (!entry->msi_attrib.is_virtual) {
>>> +		if (!entry->msi_attrib.can_mask) {
>> Groan. I'm a moron. This obviously needs to be
>>
>> 		if (entry->msi_attrib.can_mask) {
> I will compile and check. Thanks for being thorough.
This worked as well.
>>>  			addr = pci_msix_desc_addr(entry);
>>>  			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>>  		}

