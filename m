Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A685834B345
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 01:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhC0AOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 20:14:32 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34704 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhC0AON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 20:14:13 -0400
Received: by mail-lf1-f41.google.com with SMTP id i26so10141651lfl.1;
        Fri, 26 Mar 2021 17:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SEcUk0EunwKzPM97F5uKAKJTsTQwxZ5rqKq25o2rWsk=;
        b=K3cXqbbbsMAxi/RhBEeziukGrjLj7pExUZgP9tDu9qsQjYZW2c7d6F6mBz7rSxSf45
         uFDvK19qCrozli+tpvMcM5Zz1MknVaIyPiNibLYZ2abPuxJhcsWSWRvKu3vyLFdSY+gd
         b7KkTggwtGr5SpFQoclPiFYwQtZuLXHCYuF0S0DnbRF2zA1IYwmjvN4Bf+gfYQ82Dltg
         QVifIrfo2i5vvs/RLdfgL/hKIflUoyJxVwbvYb7Ptpl0t0jYCmNCMwSGPSarxi0Lv0YN
         JJhaRG8AIuoMkEuAuvIjWU10j33OgH5XphZIdT41qfvYVtqjGku9VU/+vGkg3dnIwxvh
         ye5w==
X-Gm-Message-State: AOAM533QvoC1+6Ohuj331Lbiry7S9AB+FnUo4ZvUB2V/8pixe9+vAKY5
        Sozl9acLWzXgki1K5d0FiLY=
X-Google-Smtp-Source: ABdhPJwEVBAE3qKqw210nGGw3dr7TjeUGuqo7YWb7wiIf7rFqesRT4vsCS7XhGpR62hq2S4BArj0Ag==
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr9253215lfk.574.1616804051808;
        Fri, 26 Mar 2021 17:14:11 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm1020676lfe.243.2021.03.26.17.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 17:14:11 -0700 (PDT)
Date:   Sat, 27 Mar 2021 01:14:10 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disallow retraining link for Atheros QCA98xx chips
 on non-Gen1 PCIe bridges
Message-ID: <YF540gjh156QIirA@rocinante>
References: <20210326124326.21163-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326124326.21163-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

Thank you for sending the patch over!

[...]
> +static int pcie_change_tls_to_gen1(struct pci_dev *parent)

Just a nitpick, so feel free to ignore it.  I would just call the
variable "dev" as we pass a pointer to a particular device, but it does
not matter as much, so I am leaving this to you.

[...]
> +	if (ret == 0) {

You prefer this style over "if (!ret)"?  Just asking in the view of the
style that seem to be preferred in the code base at the moment.

> +		/* Verify that new value was really set */
> +		pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &reg16);
> +		if ((reg16 & PCI_EXP_LNKCTL2_TLS) != PCI_EXP_LNKCTL2_TLS_2_5GT)
> +			ret = -EINVAL;

I am wondering about this verification - did you have a case where the
device would not properly set its capability, or accept the write and do
nothing?

> +	if (ret != 0)

I think "if (ret)" would be fine to use here, unless you prefer being
more explicit.  See my question about style above.

>  static bool pcie_retrain_link(struct pcie_link_state *link)
>  {
>  	struct pci_dev *parent = link->pdev;
>  	unsigned long end_jiffies;
>  	u16 reg16;
> +	u32 reg32;
> +
> +		/* Check if link is capable of higher speed than 2.5 GT/s and needs quirk */
> +		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &reg32);
> +		if ((reg32 & PCI_EXP_LNKCAP_SLS) > PCI_EXP_LNKCAP_SLS_2_5GB) {

I wonder if moving this check to pcie_change_tls_to_gen1() would make
more sense?  It would then make this function a little cleaner.  What do
you think?

[...]
> +static void quirk_no_bus_reset_and_no_retrain_link(struct pci_dev *dev)
> +{
> +	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET | PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1;
> +}
[...]

I know that the style has been changed to allow 100 characters width and
that checkpatch.pl now also does not warn about line length, as per
commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
warning"), but I think Bjorn still prefers 80 characters, thus this line
above might have to be aligned.

Krzysztof
