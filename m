Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8631E6275BC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiKNGFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiKNGFa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:05:30 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7A165B1;
        Sun, 13 Nov 2022 22:05:27 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id v81so10483316oie.5;
        Sun, 13 Nov 2022 22:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfuXFLXZ8toOO1yh46f6+pAIOz30ZmQ3q3OmLgH8FIE=;
        b=FXcqhei94DMlce5NwOrYK6OhrOOU5LSx62sKS/kzrLNNeIkWyi3k1mt8UDWlv7JMQ2
         aTWLsyKev4gUMFSP6hRQQrmG1G3pYSHDvHez43zeWcrEjnkuy/VOm0UgAVpEXNlYGNj1
         qa4haUfIe2SZusr+VvV6rhG9SUeQivgnuoKLY7a0gYPMUgxgkAd7QuDQVuCOh6ZMa5m3
         b8itB2QvN0TtGIX9miCgl6KUeT2YQsJSpcjeCes0OVmBHxOqTNwtmt5bBIJEifce6RVg
         QclvH5ttVNnHjAlqw1U2HCHZ30rfX/7H+FBpUmODjUl8YdXfbt6rmzEdOJQlI4Wvauog
         mV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfuXFLXZ8toOO1yh46f6+pAIOz30ZmQ3q3OmLgH8FIE=;
        b=Hr3muFI7NChLOivEUTnNHaGIn+Du/iWIzvDaCr/Pq2psQmbcq8z5USundV923V7hox
         YzcExwiGQhoh9ig/mGMEXMeB/nwDfqNw/mPD+KCo+89TEy9PCHYNDhhfl9kGtjcSazpI
         Jqk42klzOI/yMGo1jkVNRbaAwxcx662FSTDpJWM7ViX+jzzsQwrpEUZ7XUanCqHJQOJp
         oACaPz2QPGejXyNAQ6ZYnunHuKmJxOGKxT8Z5iCE/yfGczmNopVCnnBtBFBHbROS+GPA
         DXi2KBsuOyP9UOR/rPXErdnW07HIwEGBk9zwoerkzOMKsI9SFcVDlOKV2/HmhKvi7oFO
         3kAQ==
X-Gm-Message-State: ANoB5pnsx8FQKcIV7p+9YpYG+WTGtbTUAHQIaiEi4jrot2F0LLWLQ7Mc
        KHR8Bgo6xYhVG9HPK9K0liReMfmef6L3QZ7IE9d045Gh
X-Google-Smtp-Source: AA0mqf5L3pkz2Rct5fpkAQCafsAb7FGYVrSoIVdjEQqNLyeBJlirC5uNzwOKtSmSSEJWJd3ANumshG5iUU/cqSPBNH0=
X-Received: by 2002:a54:440f:0:b0:35a:51fc:2134 with SMTP id
 k15-20020a54440f000000b0035a51fc2134mr5082331oiw.144.1668405927213; Sun, 13
 Nov 2022 22:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20221114012036.2870067-1-git@johnthomson.fastmail.com.au>
In-Reply-To: <20221114012036.2870067-1-git@johnthomson.fastmail.com.au>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 14 Nov 2022 07:05:16 +0100
Message-ID: <CAMhs-H-uKrn-OXX2POPr3ewXUx=h835yBSUcJWun7pC3dPj66w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: mt7621: add sentinel to quirks table
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

On Mon, Nov 14, 2022 at 2:20 AM John Thomson
<git@johnthomson.fastmail.com.au> wrote:
>
> With mt7621 soc_dev_attr fixed to register the soc as a device,
> kernel will experience an oops in soc_device_match_attr
>
> This quirk test was introduced in the staging driver in
> commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'"), and the staging driver was moved in
> commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
> controller driver") for the 5.16 kernel
>
> Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
> Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision using 'soc_device_attribute'")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
> v1 Link: https://lore.kernel.org/lkml/20221104205242.3440388-3-git@johnthomson.fastmail.com.au/#t
> v2: no newline in middle of Fixes tag
> ---
>  drivers/pci/controller/pcie-mt7621.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I am pretty sure I already gave my Acked-by in the previous version of
this patch. You should add tags when you submit new versiones. Anyway:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
