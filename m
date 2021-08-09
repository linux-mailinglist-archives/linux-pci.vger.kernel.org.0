Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187773E4C7A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhHIS4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 14:56:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHIS4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 14:56:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628535393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO/dGC7/2zBF3jWQgAUjk/PLJ6l0svSy3Oj/4sUOHKw=;
        b=KCs3NOHY2utTiNmW6FlJhb38NQ6WjvmYVpRSDVwlTUNdUAKSE6rnflHY2RxJk8bIvfJMNM
        lCYb+OxqGPAy76Z21ivQLDkWcL61MUSwgsuKvhKc8OnRqZNFIaOoreZkLk8pWSu53e+d6a
        nrHAyf7t/Jvd7ObmhDU9ddgg/L0dCTB2ezAvowYQidbUivLPXcLz/REkWT+UQlXjRWgGQv
        ti6lWLuQEUdGvVt1irgaPytMqXjYIjaMNOKB4RWX8PVoqd9Q21/wB27G/wpxpip74V1MqE
        0MzLVWwL5EUGuQ80HUSID0P4vIRx6W8PhinU+qOfegQmW1mEHI0SyfrS2IFYVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628535393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO/dGC7/2zBF3jWQgAUjk/PLJ6l0svSy3Oj/4sUOHKw=;
        b=XqYpRWEwtWuPJr+5rOAj4VvKqQlEeEEqVOntY/PzebTwSeT/9hSM1EMc1XWcVtUKW48i13
        11gt33xe7t/8JrAw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch V2 18/19] PCI/MSI: Provide a new set of mask and unmask
 functions
In-Reply-To: <87r1f6bpt7.wl-maz@kernel.org>
References: <20210729215139.889204656@linutronix.de>
 <20210729222543.257079238@linutronix.de> <87r1f6bpt7.wl-maz@kernel.org>
Date:   Mon, 09 Aug 2021 20:56:32 +0200
Message-ID: <878s1atpjz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 06 2021 at 15:39, Marc Zyngier wrote:
> On Thu, 29 Jul 2021 22:51:57 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> +static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
>> +{
>> +	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>> +		return;
>> +
>> +	if (desc->msi_attrib.is_msix)
>> +		pci_msix_mask(desc);
>> +	else if (!desc->msi_attrib.maskbit)
>
> This negation is preventing one of my boxes from working correctly (no
> idea why the i350 driver refuses to use MSI-X and sticks to a single
> MSI, but hey, that's another story), as the device supports MSI
> masking, and we definitely don't try to mask/unmask in this case...
>
> Dropping the '!' here and on the unmask path fixes it for me.

Duh. I'm a moron. Of course this needs to check maskbit if it wants to
mask. Sigh.


