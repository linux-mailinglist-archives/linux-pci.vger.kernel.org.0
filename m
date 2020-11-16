Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB62B4402
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 13:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgKPMuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 07:50:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKPMuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 07:50:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605531033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MZk8f05zzIV7Ttfy5YcrIRRf3Ks113ilZvj4y+g/U4=;
        b=aEs2krwqPJ5mncHAdF1YpE/lMEDDjlcz7iqKbOyZpZsY/f5uD7btQ7ZtbVF1m0VUrxBBYY
        /NmlpfD+lDAWr+jFZ1LI7D+baDhdxVQYvEThXbsaw0u/P505555eqUTPPkOmmgPEJC5c41
        hLHY497BOs49EMjQsmeEa/TCmd/8IgbWp0mAIFg1I0rwBLiidqd2yawOVHTIIGblKki72P
        uU7yHmaWFxb0GAzley08IBzxvR/UQqBaH0/M1weOTpxoKKMOnxYc6MfMQ07DTDY7/IjEcW
        ajRYjH/sV8IyM6VR94qsA5AiV0NGIQc6GriZQmwK8Dm/89rxobYk6y6lztU2Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605531033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MZk8f05zzIV7Ttfy5YcrIRRf3Ks113ilZvj4y+g/U4=;
        b=2/MsSG7CjQLYFTCWmCzdOxzaBv33PtlagCdIBlyEhwQgyKbUIZyEh4xZmT0oEgioFkXStT
        5cqgyGxf6iGQBnDQ==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de> <87k0uqmwn4.fsf@nanos.tec.linutronix.de> <87d00imlop.fsf@nanos.tec.linutronix.de> <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
Date:   Mon, 16 Nov 2020 13:50:32 +0100
Message-ID: <87lff1zcrr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Geert,

On Mon, Nov 16 2020 at 10:47, Geert Uytterhoeven wrote:
> On Thu, Nov 12, 2020 at 8:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The recent changes to store the MSI irqdomain pointer in struct device
>> missed that Intel DMAR does not register virtual function devices.  Due to
>> that a VF device gets the plain PCI-MSI domain assigned and then issues
>> compat MSI messages which get caught by the interrupt remapping unit.
>>
>> Cure that by inheriting the irq domain from the physical function
>> device.
>>
>> That's a temporary workaround. The correct fix is to inherit the irq domain
>> from the bus, but that's a larger effort which needs quite some other
>> changes to the way how x86 manages PCI and MSI domains.
>>
>> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>>         dmar_iommu_notify_scope_dev(info);
>>  }
>>
>> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
>> +{
>> +       dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
>
> If CONFIG_PCI_ATS is not set:
>
>     error: 'struct pci_dev' has no member named 'physfn'
>

thanks for pointing that out. Yet moar ifdeffery, oh well...

Thanks,

        tglx

