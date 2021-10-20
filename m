Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E217434E61
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTO6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTO63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 10:58:29 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F3C06161C;
        Wed, 20 Oct 2021 07:56:15 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f4so7181523uad.4;
        Wed, 20 Oct 2021 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVRZfCbUcEWqq8bS7PaOVjbhTh/WMCv3Aoqx5RAxI1Y=;
        b=M3jZcojyY6KwbydrAH9WjnewEr0XFq3PdzkMUEsUbrFx8wTTQXqGLT5+Sec2jPy3AG
         hfumzblW+g6VWHX9JfOrVqa9RC5FGzhf9e1eCBzSw9wTccgog9GsS+iwwm9kpsRxXWLA
         alXC1g16Bh5LGu8GLxP4Qm3zXCb6UcwtoIcOPjbOcujtgx3+z3Z4euOFsOTaRKAAr92d
         ZzErZg9YruuNDYylZZ74fJyWY3jjwNCRojRreE/zm6npnzfFsRBGaxPxpeUWUOJbTxmo
         r4rq+9Na4it873j4LlwH8wPWhf9nzKrExExfZhfV3xqFedVVG7dUy5Ho/YiO3mcJyuyK
         +qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVRZfCbUcEWqq8bS7PaOVjbhTh/WMCv3Aoqx5RAxI1Y=;
        b=Uf+LGljQqrQcFeeRTqc3hPoweVuWqVssxQF1atR/BpNF1YBl0cc6UYMt58K+6uxX26
         YHsI1+eSubU4Fs9at4+bDxdgvfxbyNW+/CkmPNFzmDObkY3rMYESmZ4FwVrFtDGMEwUF
         PkmGjlzV0c1gDosAygNx6zjQeexy2+UxDi83atntZE3MpN40KFYE6+JvOnXZG/hKSSEm
         D+RtZic06VrbWMusZq+qWFwaFndribJu0UzZcqMOiroyKkU3XrgTH8unfLZrPHI00YwD
         57t7ndbtkfuDYfBClsrPQKFu3+Tbn0G/SmVvqTBHyMxXTWVOjUvsbzuaPjNQYF2NFc/W
         AAKQ==
X-Gm-Message-State: AOAM532Yyn/aPeLrY8gtlMCwikk0XpE7vd64zkA40upqfZEoTE/ELAyT
        zgpm3h624MH83NTwTJgShAkEOvIyoKJyy49oykc=
X-Google-Smtp-Source: ABdhPJy/0HLpH4lEXBGS1niveWyVKjjV+ypKgVhS4pvrspXd+LAcOALfGNoz8yvyLuDFEkbc7WSHTclIrYcmad0Hvdg=
X-Received: by 2002:a67:42c2:: with SMTP id p185mr641748vsa.41.1634741774522;
 Wed, 20 Oct 2021 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210922050035.18162-1-sergio.paracuellos@gmail.com> <163473978253.23166.3894301849923362863.b4-ty@arm.com>
In-Reply-To: <163473978253.23166.3894301849923362863.b4-ty@arm.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 20 Oct 2021 16:56:03 +0200
Message-ID: <CAMhs-H99H_Ojtdwyj3_9K6FdZfNgD42cHfjrVJ-+6_RiU4OG7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 20, 2021 at 4:23 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, 22 Sep 2021 07:00:32 +0200, Sergio Paracuellos wrote:
> > MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
> > Topology is as follows:
> >
> >
> >                           MT7621 PCIe HOST Topology
> >
> > [...]
>
> Applied to pci/mt7621, thanks!
>
> [1/3] dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
>       https://git.kernel.org/lpieralisi/pci/c/e5bc5605e7
> [2/3] PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
>       https://git.kernel.org/lpieralisi/pci/c/5797a2b2bc
> [3/3] MAINTAINERS: add myself as maintainer of the MT7621 PCI controller driver
>       https://git.kernel.org/lpieralisi/pci/c/eb1d7d438c
>
> Thanks,
> Lorenzo

Thanks, Lorenzo.

Best regards,
     Sergio Paracuellos
