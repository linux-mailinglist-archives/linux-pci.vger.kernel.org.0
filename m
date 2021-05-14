Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA68380ACC
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhENN5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:57:39 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:38685 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhENN5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 09:57:35 -0400
Received: by mail-ej1-f47.google.com with SMTP id b25so44729171eju.5
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 06:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2NpaBz5AUmNMHvDParfvwCKc5gIDqK4bcKMIlvPsCVE=;
        b=mnpNNSKbRxRdBfQtL9nCEZh6mfSIqyfKdfHQIhdVTSqx4hiaFjq6e1UeT2Ih8HVo/q
         tZAMKMwNmL3eddgw4ZkxoVe9d8hZedsa71Aogm4Y5CcMyl50oDoN40YHbhAXdgo/mMg/
         UVxw6/up/mzIq0iwM823Xb7jwoKMyIo2uStSRlqnGKs/c19llwQb4Xiwt9A839vgA59I
         48/U6454QkZAh1s3bD79AvC076aZQI2qIo45CX7hv6vTqYFiFpLFnulstQLc14pX2pEN
         os6B+kBZ5PDzLQdhTKTAF9bcIjxmLPJIbt8sRYFb6UElPQSr13U+VafvU9GW5nGt9dYs
         7n+Q==
X-Gm-Message-State: AOAM53037fjOvZQlMzxbCiCV7vP/esN0tlOkgx+ufIXG2kccwSZJ0l1E
        yu6aH91/Baiv2JmZVR0Pup4=
X-Google-Smtp-Source: ABdhPJw3tXtViuYGlOcqrhsXafdmV3WA7+AKoBsk/+MSDHWX/nfVhRtx6XrAQRjOE3WHAc3xmFwvzg==
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr48017571ejc.308.1621000582848;
        Fri, 14 May 2021 06:56:22 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id ga28sm3627203ejc.20.2021.05.14.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:56:22 -0700 (PDT)
Date:   Fri, 14 May 2021 15:56:21 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving
 bridge
Message-ID: <20210514135621.GG9537@rocinante.localdomain>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
 <20210514080025.1828197-6-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-6-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Huacai,

[...]
> The ASpeed AST2500 hardward does not set the VGA Enable bit on its

It would be "hardware" in the above sentence.

> bridge control register, which causes vgaarb subsystem don't think the

Probably better to say "don't consider the" rather than use "think".

> VGA card behind the bridge as a valid boot vga device.

It would be "VGA" in the above sentence, to be consistent.

> So we provide a quirk to fix Xorg auto-detection.

A nit pick.  Technically it's "X.org", but I see that the canon in the
commit messages is to use "Xorg", so either would be valid.

> See similar bug:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/

A small nit pick.  Linking to https://lore.kernel.org/linux-pci/ is
often preferred.

[...]
> +	struct pci_dev *bridge;
> +	struct pci_bus *bus;
> +	struct pci_dev *vdevp = NULL;
> +	u16 config;
> +
> +	bus = pdev->bus;
> +	bridge = bus->self;

Preferred style would be:

  struct pci_bus *bus = pdev->bug;
  struct pci_dev *bridge = bus->self;

> +	/* Is VGA routed to us? */
> +	if (bridge && (pci_is_bridge(bridge))) {
> +		pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
> +
> +		/* Yes, this bridge is PCI bridge-to-bridge spec compliant,
> +		 *  just return!
> +		 */

Second line of the comment has some errand space.  Also, wording of this
comment could be improved a bit.

> +		if (config & PCI_BRIDGE_CTL_VGA)
> +			return;
> +
> +		dev_warn(&pdev->dev, "VGA bridge control is not enabled\n");
> +	}
> +
> +	/* Just return if the system already have a default device */

Missing period at the end of the sentence in the comment.  I am also not
sure this comment is useful, as the if-statement immediately below is
quite self-explanatory.

> +	if (vga_default_device())
> +		return;
> +
> +	/* No default vga device */

It would be "VGA" here, plus missing period at the end.

> +	while ((vdevp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, vdevp))) {
> +		if (vdevp->vendor != 0x1a03) {
> +			/* Have other vga devcie in the system, do nothing */

It would be "VGA" and "device" in the comment above, missing period at
the end.  I am also not sure if this comment is useful, given the log
line just below it.

> +			dev_info(&pdev->dev, "Another boot vga device: 0x%x:0x%x\n",

It would be "VGA" in the message above.  Also, using "Another" is a bit
vague.  What makes a VGA device "another" in this case?

> +	dev_info(&pdev->dev, "Boot vga device set as 0x%x:0x%x\n",
> +			pdev->vendor, pdev->device);

You need to align the second line in the above with the open bracket,
like in the log line above.

> +DECLARE_PCI_FIXUP_CLASS_FINAL(0x1a03, 0x2000, PCI_CLASS_DISPLAY_VGA, 8, aspeed_fixup_vgaarb);

You might need to wrap this line above, see:

  https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Krzysztof
