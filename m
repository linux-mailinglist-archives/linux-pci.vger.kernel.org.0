Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A641903A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhI0HxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 03:53:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhI0HxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 03:53:00 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfZDK-1n1tEv1fzs-00g4JS; Mon, 27 Sep 2021 09:51:21 +0200
Received: by mail-wr1-f53.google.com with SMTP id t18so49769278wrb.0;
        Mon, 27 Sep 2021 00:51:21 -0700 (PDT)
X-Gm-Message-State: AOAM530l04Rjsx/BaZDLXd0XT9Y22K4NJUKR8k/mnNrBMAYPfdoBK7sO
        OXSoMunVPAz7vuGjJwnyS+co0J0rbPpd2BY/Pg8=
X-Google-Smtp-Source: ABdhPJwNcwXck71rNE1/gI90KB/Jti/UtvWTFzI7YuAuJdYp1B3gd5+yHJu01In4gT34cm6LdQkR+GmwiEb9qD7ilRE=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr25539649wru.336.1632729081037;
 Mon, 27 Sep 2021 00:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Sep 2021 09:51:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+54S2=-=ch1+XWuNQRoOCDdQhtBhu3CKOdqcSNzu8YA@mail.gmail.com>
Message-ID: <CAK8P3a3+54S2=-=ch1+XWuNQRoOCDdQhtBhu3CKOdqcSNzu8YA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] MIPS: ralink: fix PCI IO resources
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LYouDishMlJCnIQQJXNc6KaWq6X8G7XFqlIVp4RJjMd9pwaX6nR
 cFwp/9DVcNEDHf4EoEb/yJLvkt7xztk9iLZ8F73281Vnfz8A1F5WCR0MLuo3dTrdBYskHDJ
 ohOygtqtSGSe7MgeMkZTs8el3Imrdwtu8yJivrTCzWYngs+d4VK3cy6ErHUck2IzK2bsvzp
 9VGRSipbyo3Vju0d19L/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OmPeOvdn9ds=:LrjXsidCjUirPVhV63x4c7
 z3RD1ILfreV8t5UdmzaVUuJ4h1cm8jBqgnDV4zwCvs0YKlfqjfeY08MoxUvcuVkiX5FUVEQuQ
 C+RGEpZTVI5TL04Z2mS8+XkclcXx1tJy2Nj59qtIm2WstgZsfhZ9V+74sjtFFOFi3syBFrTzi
 CHxNbzecx2Awm64LskOLk+v00bSVuY9Eszy8u/kIuCCzdP1Cnsfe2PNYLMsba5nKOp/3WxLCY
 IXMz6ntVCwxRjYR9A2nzVUv736SJCxcGiQk5TxzS/k69pt0YhCa2QrA9GT8p0E1+UuNu6qnxw
 thSxvru7Th0re5aIi12dGJo2gvfS3XYRHMHsE2ilGOAsbVEevPCVqYiMGTm90n+jlXywGNwMi
 fUfeLn6Mar/Lqd8kmkdBFXsSUHgJ625Ytj04Mm6qcC0EZXuxEPdhJIjgJJT6qhN/+Mgyih4eQ
 xPyk7L94yf/JjsK94y2gGmu2hb4l5Ivv4ma6c/jeZ7fhnGfe2g3v0D9HOTKO6Zi449U5Vd4W7
 MlK/c2ixD8IdQJUJY7ZZdyNakn+XxlgkhLS/awJ0QqhPozn59AOtNp+459kYFc0+uZSauAnbt
 GUra6nayRTRJml34/2HcqVd+U8CBlB2sPJ2hIhy+gbdR1LXZoHEeSM0Bv1Sf4PgVj1nc8+clS
 gqYQAJIFUGsfyCJV5XjmJzaEPpZ7VjJtU6g+c79qxj03+2OSrzJyDzWlMlt/TEk2PUfAmqYvu
 cSycNn2FviTRKtF+gbJ6oMar6/qK2yXLrL/qDSVco/t9QdBX8uRjIf/KM9k7+ZGmUK8b7i1CG
 SBioXnGfh6rUVjK5ei+G2MqBqcXmzO2XE/JKtfP/deT8f6nJk85Cg9Nj/hc/KaGgLoaRUY49c
 bFG33NgzDxOiNhzPeG+A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 25, 2021 at 10:33 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Patches related with reverts are from this merge cycle so they are only
> added to the staging git tree. So to have all stuff together I'd like to
> get everybody Ack's to get all of this series through staging tree if
> possible :).
>
> Thanks in advance for your time.

Looks all good to me now, just one general remark: Try to give a little more
time between respinning the entire series, otherwise you get the opposite
effect and reviewers start ignoring your emails after getting annoyed at the
number of emails. Once you are reasonably sure that no more comments are
coming in, or you have made substantial changes, it's time to resend the
series.

        Arnd
