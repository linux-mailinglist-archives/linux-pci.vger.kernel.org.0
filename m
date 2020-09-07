Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A40F25F165
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 03:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgIGBO2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 6 Sep 2020 21:14:28 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35846 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgIGBO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 21:14:27 -0400
Received: by mail-ua1-f65.google.com with SMTP id l1so3724885uai.3;
        Sun, 06 Sep 2020 18:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Viqdpe1Ji9etl2U4+LZipTUiJpglH6OMFlDTbIisDLE=;
        b=G8wS6Q8KvN6EjbhFjbdKtccC2YqhmkJQu8OJ1rNa7avSmbi0y6YrrpQ3dIbEErEa1L
         fEZJTgEZzFn1uomtycVxG7qIaMBnz+qB+S/ZoBoXgrXnYtJWNrcJ9Jxt5rp1XekumyMC
         G444T+UUSLP4t+s2ZzBKdyXSeA8zLDYABqm4wDNBgcbm+XTMZBd2QAeHMrlFV33CjsW4
         hPSo6afr+ZyeOJS/TIvrNAX+bWsXwdDKh23Od/SUsrToLANj4CcNXHToGexMxup0pear
         DBXpSyKsSHr7Ia7KheX8NXh9D4Z/nV7EDyu4Q81Srubm3v80HrkfQQ9YZTbdNsmWjEX6
         dMXg==
X-Gm-Message-State: AOAM533IuKSBnMigL3yLnlZRdau/X7ycT+E18sUiYlj3mEqSk550wEp7
        U67/ogVkw2zxLj/Tc/ZUMjz1CzGzNuODf0jw1L4jGiH1LPv3CA==
X-Google-Smtp-Source: ABdhPJysiGTV/icfGXETe/Hk1AjcCj7KPP6bKtFmsYBN9FsZUODwKZ2y8l4J8W77oYZeh3KIhIrWwQzPDDywlIKjaAI=
X-Received: by 2002:a9f:300f:: with SMTP id h15mr10071717uab.47.1599441265834;
 Sun, 06 Sep 2020 18:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKb7UvhqZMcL3UNbK-6ZG9LJddCmoL0paYsRx6+5bVKDQpAjmQ@mail.gmail.com>
 <018101d684aa$088a33b0$199e9b10$@gmail.com>
In-Reply-To: <018101d684aa$088a33b0$199e9b10$@gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sun, 6 Sep 2020 21:14:14 -0400
Message-ID: <CAKb7UvjvBcErA=DFOMawUuGqjtc0WU8=Oyo1j4Q8Q0Di_-fd3Q@mail.gmail.com>
Subject: Re: Regression with "PCI: qcom: Add support for tx term offset for
 rev 2.1.0"
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 6, 2020 at 8:01 PM <ansuelsmth@gmail.com> wrote:
>
>
>
> > -----Messaggio originale-----
> > Da: Ilia Mirkin <imirkin@alum.mit.edu>
> > Inviato: lunedì 7 settembre 2020 00:59
> > A: Ansuel Smith <ansuelsmth@gmail.com>
> > Cc: linux-arm-msm@vger.kernel.org; Linux PCI <linux-pci@vger.kernel.org>
> > Oggetto: Regression with "PCI: qcom: Add support for tx term offset for rev
> > 2.1.0"
> >
> > Hi Ansuel,
> >
> > I'm on an ifc6410 (APQ8064), and the latest v5.9-rc's hang during PCIe
> > init. I just get:
> >
> > [    1.191861] qcom-pcie 1b500000.pci: host bridge /soc/pci@1b500000
> > ranges:
> > [    1.197756] qcom-pcie 1b500000.pci:       IO
> > 0x000fe00000..0x000fefffff -> 0x0000000000
> > [    1.205625] qcom-pcie 1b500000.pci:      MEM
> > 0x0008000000..0x000fdfffff -> 0x0008000000
> >
> > and then it hangs forever. On a working kernel, the next message is e.g.
> >
> > [    6.737388] qcom-pcie 1b500000.pci: Link up
> >
> > A bisect led to
> >
> > $ git bisect good
> > de3c4bf648975ea0b1d344d811e9b0748907b47c is the first bad commit
> > commit de3c4bf648975ea0b1d344d811e9b0748907b47c
> > Author: Ansuel Smith <ansuelsmth@gmail.com>
> > Date:   Mon Jun 15 23:06:04 2020 +0200
> >
> >     PCI: qcom: Add support for tx term offset for rev 2.1.0
> >
> >     Add tx term offset support to pcie qcom driver need in some revision of
> >     the ipq806x SoC. Ipq8064 needs tx term offset set to 7.
> >
> >     Link: https://lore.kernel.org/r/20200615210608.21469-9-
> > ansuelsmth@gmail.com
> >     Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> >     Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> >     Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> >     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >     Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> >     Cc: stable@vger.kernel.org # v4.5+
> >
> >  drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > And indeed reverting this commit on top of v5.9-rc3 gets back to a
> > working system. I have no idea what PHY_REFCLK_USE_PAD is, but it
> > seems like clearing it is messing things up for me. (As everything
> > else seems like it should be identical for me.)
> >
> > Let me know if you want me to test anything, or if the best path is to
> > just revert for now.
> >
> > Cheers,
> >
>
> Thanks for the report. Can you confirm that by only removing
> PHY_REFCLK_USE_PAD the problem is fixed? Wonder if it's better to
> just make a patch to restrict the padding to only ipq806x and backport that.
> (or revert and repush a better patch). What do you think?

Confirmed. The following patch makes it work for me (as expected):

https://lore.kernel.org/linux-arm-msm/20200907011238.3401-1-imirkin@alum.mit.edu/

Feel free to follow up with any feedback there.

Cheers,

  -ilia
