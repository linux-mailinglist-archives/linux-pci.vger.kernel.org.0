Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D299E46B80
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFNVGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 17:06:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50823 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNVGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 17:06:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so3675429wmf.0;
        Fri, 14 Jun 2019 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPcSNIgx5TQB75AvaXiiiaws52GQdyZ66nZ+SXlArN8=;
        b=bRAaJbL1YbxY3k5TEWvOkl16ahhZ0lyOJSdpwOu8Ec0fzzC3nu0E3Fm9iHUEF5XPmS
         DS9VT1UZl1j25XQPXN7S4D7VK/ricinAXA5vKXoBcHx8goV6qHojvelivqzS/GIS52tC
         vNm+KtjOq3CkxvK2mS1GRLc6pg8CAgH4ou770rnsoTG4XmhQi0v0TVJgd0qu7lft6I0R
         NYnDhwzriORtPTvRAvOvMI0Ykw6MNfZxADi54BU4fW/NDb85v8F6EoTx7dMje8RpxUtN
         8rqIsEKnlDgYFsgM5lneITnz+EGhLzQLEs3uqGfi0NNOGHpCB7K7Z7KvappYqBWKHrhG
         KUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPcSNIgx5TQB75AvaXiiiaws52GQdyZ66nZ+SXlArN8=;
        b=UBF6D6fSJj+xg4Tlsvfs4Gtq1vQ8QT6cjJih1U2HsXRoRrR+4HveROGgsSDMBLseJY
         zy91kz3aFmhxa2CdCrtkYUZEIdZFiNt8JkNj8LFznThoitafBggAPmjGhL0E2cdrRd6m
         DR+IU/vcLtSJqu/ADqJbaENqyBFwQakAhfrTI7crZ0aVRZSEM11lrt/I8poivZB99jiO
         rdO87rTR05qi7JzIULnlI7vkijldrNKTuBZr6n9/+ctj8aYvaXM9SnlbX03Mj7jZZ8g8
         z9E0ICg/wgVlKqNKbaqMEeShCba2wJTRiZIc5/jJztkQx1F4z+N8fHBagJ8YpnokLjn6
         fNRg==
X-Gm-Message-State: APjAAAVt1ICsnhAyaaK2uplDb8jhf5uGOpgPcl7X0E+42tfp8O3P+ri4
        KF+eVuIcSQSI12zzEYFylIdMekdX9sGNJoxT4yQ=
X-Google-Smtp-Source: APXvYqw21c2Z9K0d6HZ6caycs44/rVWp72TRxRH2sy4lupkMiva0vgGmKu4Q+PHMd5s89bSXFyfyklP+4efUhSvzfj4=
X-Received: by 2002:a1c:4484:: with SMTP id r126mr9608340wma.27.1560546366802;
 Fri, 14 Jun 2019 14:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de> <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com> <20190614200557.GS13533@google.com>
In-Reply-To: <20190614200557.GS13533@google.com>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Fri, 14 Jun 2019 15:05:54 -0600
Message-ID: <CAOSXXT7eV4SBSkoKoOKAPaUQxczrD3rAvpz=12LTQenvRjCYRw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daniel Drake <drake@endlessm.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-ide@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 2:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Ugh.  Are you saying the installation instructions for Linux will say
> "change the BIOS setting to AHCI"?  That's an unpleasant user
> experience, especially if the installation fails if the user hasn't
> read the instructions.

:) That is essentially what the dmesg currently says when Linux
detects this, from drivers/ata/ahci.c:ahci_remap_check()

  "Switch your BIOS from RAID to AHCI mode to use them (remapped NVMe devices)"

Unpleasant yes, but what's the lesser of two evils? Recommend the
supported full featured mode, or try to support with degraded
capabilities?
