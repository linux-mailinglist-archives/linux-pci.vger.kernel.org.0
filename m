Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2844543CD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhKQJjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 04:39:15 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38878 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbhKQJjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 04:39:10 -0500
Received: by mail-wr1-f51.google.com with SMTP id u18so3361245wrg.5;
        Wed, 17 Nov 2021 01:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kBGfycOCHnUBw9FHHHBvzzppOadxPhLn2ZL/yc6QH0=;
        b=r1cKrZQrkUT7+GRIg7/CU+eonPKS7eLh5i8cBqxY2Y9JF9SJNvaxZIS8cTnfZ8VhQ0
         Rn8oM2szSTONmpz0t3dxisOIhqKX1zXWHdG3EW8WsMy6PSOWicQ8sRW9cqdATm24ZM+n
         943vJzsK9pm6g24IBSjpQoPVGUS3USz8Mv6ojo/WGYXhNAnFKPfD5aBWir4WNHohksWK
         sB87ydhr67tAkYsVjx0MJOZwTdcZLz3cttcJYPPJGnvsf4q0cxM/+DBVZY5rmZJoNKBf
         o25t0zo3yN1I48KAStafLve2n7rD2PYjOPLkaEToDZbi/5Pmrh33x3m/vZooo9e+J/C6
         sPWg==
X-Gm-Message-State: AOAM530X3XYJS7FGbPUN2yK+fqxti6FxGpuHPUfouY2O84DH86VaUTYu
        eXhK8ec2dD4gscslglKapsc=
X-Google-Smtp-Source: ABdhPJw36TMvkZq7QCpZG5ov95Fyz3VVuzSo72zu9pbcaZnJx63BSBi7kVEPUPjoqQXxQUX4jZflBQ==
X-Received: by 2002:adf:e848:: with SMTP id d8mr18345877wrn.3.1637141771414;
        Wed, 17 Nov 2021 01:36:11 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x4sm4757381wmi.3.2021.11.17.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:36:10 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:36:08 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Yuji Nakao <contact@yujinakao.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Message-ID: <YZTNCO4OBUrVkCuA@rocinante>
References: <87h7ccw9qc.fsf@yujinakao.com>
 <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
 <YZQ+GhRR+CPbQ5dX@rocinante>
 <8735nv880m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735nv880m.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

[...]
> > > I think that this problem is due to recent PCI subsystem changes which broke Mac
> > > support. The problem show up as the interrupts not being delivered, which in
> > > turn result in the kernel assuming that the drive is not working (see the
> > > timeout error messages in your dmesg output). Hence your boot drive detection
> > > fails and no rootfs to mount.
> > > 
> > > Adding linux-pci list.
> > > 
> > > 
> > > 
> > > > 
> > > > Regards.
> > > > 
> > > > [1] https://archlinux.org/packages/core/x86_64/linux/
> > > > [2] https://bugs.archlinux.org/task/72734
> > 
> > The error in the dmesg output (see [2] where the log file is attached)
> > looks similar to the problem reported a week or so ago, as per:
> > 
> >   https://lore.kernel.org/linux-pci/ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de/
> > 
> > The problematic commits where reverted by Bjorn and the Pull Request that
> > did it was accepted, as per:
> > 
> >   https://lore.kernel.org/linux-pci/20211111195040.GA1345641@bhelgaas/
> > 
> > Thus, this would made its way into 5.16-rc1, I suppose.  We might have to
> > back-port this to the stable and long-term kernels.
> > 
> > Yuji, could you, if you have some time to spare, try the 5.16-rc1 to see if
> > this have gotten better on your system?
> 
> I'm afraid you have the wrong end of the stick on this one.
> 
> The issue is reported on 5.15, and the issue you are pointing at was
> introduced during the 5.16 merge window. The problematic commit wasn't
> reverted, but instead fixed in 10a20b34d735 ("of/irq: Don't ignore
> interrupt-controller when interrupt-map failed").

Ahh.  My bad!  I missed the conclusion of the conversation involving the
Nemo board and the patch you proposed here:

  https://lore.kernel.org/linux-pci/87mtma8udh.wl-maz@kernel.org/

I then assumed that what Bjorn reverted in his Pull Request was the
solution to the reported problems.  Apologies for conflating the issues
here, and also thank you for all the details.

Are we still in need to back-port some of the fixes to the stable and LTS
kernels then?  I am just making sure that things will make it there, if
needed.

> The issue is instead very close to the one reported at [1], for which
> we have a very conservative workaround in 5.16-rc1 (commits
> 2226667a145d and f21082fb20db). Looking at the dmesg log provided by
> Yugi, you find the following nugget:
> 
> [    0.378564] pci 0000:00:0a.0: [10de:0d88] type 00 class 0x010601
> 
> Oh look, a NVIDIA AHCI controller, probably similar enough to the one
> discussed in the issue reported by Rui.

Good to know for the future reference that these can be problematic.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..cd88eddf614d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5857,3 +5857,4 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0d88, nvidia_ion_ahci_fixup);

Thank you!  I hope this will fix Yuji's issues.

	Krzysztof
