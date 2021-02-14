Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6DA31B1D8
	for <lists+linux-pci@lfdr.de>; Sun, 14 Feb 2021 19:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBNSNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Feb 2021 13:13:00 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:45781 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhBNSM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2021 13:12:59 -0500
Received: by mail-lj1-f182.google.com with SMTP id c8so2938154ljd.12
        for <linux-pci@vger.kernel.org>; Sun, 14 Feb 2021 10:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKQP9PkvlkTFM5gTJ3JCCMep+JAVlAFdBFG8KguzX+M=;
        b=SUCQbriVe2MT0PZIoG6F1LdclW0WZpT2hd3WQ8RgkkSelSv5J259jORY6XFYwp5w3B
         v8m/i8J4mSuaEmyjhmbcUZ1APqiALH+fvEIAZYEpowEV2+QZ4aHkaw7W9i7hwNbfdT71
         Uka1ZHqaTRifOE7GMsykPKNrukcUzEkqnFHzckFIbbVsIraZtT2Dflb0PTb8TOgdVgs1
         JbpCyudQa8LuK0sGdRaODPPqJFAqnw3zMTzJYHlSrUOvpDbhNgehUo94a7b8S1NT8X6+
         JMY9S8lU+k/ZjD+twyCjuBLMDqxQDQkUaycaoBuF/azkIJ1lLQMFJGdtd1pYny0xGZiQ
         gDfA==
X-Gm-Message-State: AOAM5324+KzbdLKtu0xKkQav3pNy+GHJNAq91/emaoR7kHWk/oROt5GU
        YW6630t7uuxq6l2FZ0t7SuP5S7bjdlI=
X-Google-Smtp-Source: ABdhPJzK6cxaje0MRRTuSiwt1IEAVm9hHcL9g5coDAffTBDVM304gZYyBbKS9BjuDdDSndQqoEud4w==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr7591314ljn.506.1613326338018;
        Sun, 14 Feb 2021 10:12:18 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o11sm2501687lfu.157.2021.02.14.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 10:12:17 -0800 (PST)
Date:   Sun, 14 Feb 2021 19:12:16 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Message-ID: <YCloAA+od1WIo7o3@rocinante>
References: <20210214110637.24750-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210214110637.24750-1-minwoo.im.dev@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Minwoo,

Thank you for sending the patch over!

You might need to improve the subject a little - it should be brief but
still informative.

> __pci_set_mater() has debug log in there so that it would be better to
> take this function.  So take __pci_set_master() function rather than
> open coding it.  This patch didn't move __pci_set_master() to above to
> avoid churns.
[...]

It would be __pci_set_master() int he sentence above.  Also, perhaps
"use" would be better than "take".  Generally, this commit message might
need a little improvement to be more clear why are you do doing this.

[...]
> +static void __pci_set_master(struct pci_dev *dev, bool enable);
>  static void do_pci_disable_device(struct pci_dev *dev)
>  {
> -	u16 pci_command;
> -
> -	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> -	if (pci_command & PCI_COMMAND_MASTER) {
> -		pci_command &= ~PCI_COMMAND_MASTER;
> -		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> -	}
> +	__pci_set_master(dev, false);
>  
>  	pcibios_disable_device(dev);
>  }

You could use pci_clear_master(), which we export and that internally
calls __pci_set_master(), so there would be no need to add any forward
declarations or to move anything around in the file.

Having said that, there is a difference between do_pci_disable_device()
and how __pci_set_master() works - the latter sets the is_busmaster flag
accordingly on the given device whereas the former does not.  This might
be of some significance - not sure if we should or should not set this,
since the do_pci_disable_device() does not do that (perhaps it's on
purpose or due to some hisoric reasons).

Krzysztof
