Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16790286881
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgJGTph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgJGTph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 15:45:37 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A7C061755;
        Wed,  7 Oct 2020 12:45:36 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i5so3447566edr.5;
        Wed, 07 Oct 2020 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sX1bT/2OZTxhrLyrJFcwzL9j9+e4FMFs/gH/buYyWgg=;
        b=XVwPtcfIFhx9+HETMjdyxrHwUZkPShOnMZT9GmmTyIvWY9boa+q1M8RJk40R2VXUdj
         BwePEAMoRCZZcvqDGYOk3OPn7ILRr9Wfqj0lUgadXXoDSXJr2aCs11PIhwEAJQqViYkn
         fG5BnQcWumfPvb8WTh6/3oaTOBdfUs+XI/OrKDzUGq6OJo2CdUwoZOFYreindYNPFbxZ
         VCtfUJ0KVNWsUjVozACaOm2+HoTeHHS/0Hn7deT409gwnhl33ftAbQLx+RVglW0UAxXt
         E7lYzrLcI3jPvP6sK7xSJgliAWXn4S06JUy+HFU5rkmFrLkz80OtGxxOPKYzjMGtYFs9
         3Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sX1bT/2OZTxhrLyrJFcwzL9j9+e4FMFs/gH/buYyWgg=;
        b=JR6dzHVINOByvFHvgpFGphnFtjNohM7p+kox0HVK0JYVlsb7vgKjbQNN4c2PqSypuX
         C5b7Y7V54EQnA0sWNSHxQdYucLH6rsVFYsetJrB62nrcfo1OrW8UQHB4IgS38VmOxpWW
         JaUQ1o8sC3fk/JYB2lMs3Nzdq3n0CihsVu162c2ZVsMFmkWuvn2xriEgM/Z8BIEV8Ogq
         ZB7bxE8sZJoELDeArWKlj/ULQg9cKO3qBPELZqXsOk0zL26chNBdVA3OZK3A7BLgZRMr
         Ne60E8o9V88G+HLjhl4fEyK+G6261yJJuCZCVJDlywX/jAj6/tC7CDsFLgEZT9Snd3wE
         SQ6Q==
X-Gm-Message-State: AOAM531TiEjeI6eytDOFkImsg1tdaj88ENsN+g3hMHpdRJCIKNTBspbV
        xw546BqHnyJA4VpOoox+sIHYgq+bjS1Q6PKDNa8Kg5ET
X-Google-Smtp-Source: ABdhPJzun5TRYD6e0Yxbi+t1s1H3n+3HxwSEp1GkPGK+CulwldlRV2odxetus8T3WyLXbAbkKRKrk/4w8rrIWuRIqGQ=
X-Received: by 2002:a50:d94d:: with SMTP id u13mr5121485edj.365.1602099935423;
 Wed, 07 Oct 2020 12:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
 <20201004162908.3216898-2-martin.blumenstingl@googlemail.com> <CACRpkdbscEpV6oP7q1AcbCcR-XUBG2PnnapQ695xug63VQ830w@mail.gmail.com>
In-Reply-To: <CACRpkdbscEpV6oP7q1AcbCcR-XUBG2PnnapQ695xug63VQ830w@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 7 Oct 2020 21:45:23 +0200
Message-ID: <CAFBinCCNHXfit5FkkvgHSh4NdbunKBp3kw3okqTY6ohsK7zNzw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PCI: Add the IDs for Etron EJ168 and EJ188
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On Wed, Oct 7, 2020 at 11:14 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>
> > Add the vendor ID for Etron Technology, Inc. as well as the device IDs
> > for the two USB xHCI controllers EJ168 and EJ188.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> (...)
>
> >  #define PCI_VENDOR_ID_REDHAT           0x1b36
> >
> > +#define PCI_VENDOR_ID_ETRON            0x1b6f
> > +#define PCI_DEVICE_ID_ETRON_EJ168      0x7023
> > +#define PCI_DEVICE_ID_ETRON_EJ188      0x7052
>
> If you're defining that here, I think it should also be
> removed in
> drivers/usb/host/xhci-pci.c
> by including this file instead?
you are absolutely right - I missed that part
I will change this in v2 - thanks for pointing it out!


Best regards,
Martin
