Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FE43C4D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 10:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhJ0IQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 04:16:16 -0400
Received: from office.oderland.com ([91.201.60.5]:54356 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhJ0IQH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 04:16:07 -0400
Received: from [193.180.18.161] (port=56998 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mfe44-0082c3-35; Wed, 27 Oct 2021 10:13:40 +0200
Message-ID: <4af6ccf5-1e52-be65-0acc-cbc53b724dfe@oderland.se>
Date:   Wed, 27 Oct 2021 10:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [PATCH v2] PCI/MSI: Re-add checks for skip masking MSI-X on Xen
 PV
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Jason Andryuk <jandryuk@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20211019202906.GA2397931@bhelgaas>
 <5f050b30-fa1c-8387-0d6b-a667851b34b0@oderland.se>
 <877de7dfl2.wl-maz@kernel.org>
 <CAKf6xpt=ZYGyJXMwM7ccOWkx71R0O-QeLjkBF-LtdDcbSnzHsA@mail.gmail.com>
 <3434cb2d-4060-7969-d4c4-089c68190527@oderland.se>
 <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <CAKf6xpvZ8fxuBY4BZ51UZzF92zDUcvfav9_pOT7F3w-Bc8YkwA@mail.gmail.com>
 <c4d27d67-1027-e72b-c5bf-5546c5b0e2e9@oderland.se>
 <ee23eafce1993ba7da8fdf4c03cedbcb3362ef1d.camel@infradead.org>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <ee23eafce1993ba7da8fdf4c03cedbcb3362ef1d.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/27/21 08:24, David Woodhouse wrote:
> On Mon, 2021-10-25 at 21:21 +0200, Josef Johansson wrote:
>> +       if (!(pci_msi_ignore_mask || entry->msi_attrib.is_virtual))
> Is it just me, or is that a lot easier to read if you write it as the
> tautologically-identical (!pci_msi_ignore_mask && !entry->…is_virtual)?
Sure, the less parentheses the better.
>
>> @@ -546,7 +548,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>>                 return -ENOMEM;
>>         /* All MSIs are unmasked by default; mask them all *
>> -       pci_msi_mask(entry, msi_multi_mask(entry))
>> +       if (!pci_msi_ignore_mask)
>> +               pci_msi_mask(entry, msi_multi_mask(entry));
>>
>>         list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
>
> Hm, I thought that older kernels *did* do this part (or at least the
> later ones in pci_msi*_hutdown). I was watching it when I did the Xen
> hosting implementation I mentioned before; even a hack to unmask them
> all when the VM was started, wasn't working because the guest would
> *mask* all MSI-X, just never unmask them again.
When you're saying *did* here, do you mean that they mask even though
pci_msi_ignore_mask = 0?

As I was looking through pre Thomas' changes and post, it seems that we
did indeed
check for pci_msi_ignore_mask in msi_capability_init.
>
> I wonder if we should rename 'pci_msi_ignore_mask' to something with
> Xen in its name because Xen is the only user of this abomination (which
> fundamentally seems to require that the virtual hardware use MSI
> entries even while they're masked, so hopefully nobody else would
> *ever* do such a thing), and the required behaviour is very Xen-
> specific.
Second that, i.e. pci_msi_masked_by_xen.
