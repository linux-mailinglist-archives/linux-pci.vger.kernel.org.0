Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12401390208
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhEYNWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 09:22:09 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:44998 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhEYNWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 09:22:09 -0400
Received: by mail-ej1-f50.google.com with SMTP id lz27so47288497ejb.11;
        Tue, 25 May 2021 06:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0m3RCAXahdUBRecbZdgKCTWuOHPg5vuE0WA5DSFNEuc=;
        b=oElrAF+IsJ6+8vqxWH2pp7cP8yfSoH0g+JCXd+wBPDyG3QaNr0fTgP6uCtpAGp/jAz
         BAgSemkLDZQUtezSEvOYvezFp0HpJO0VCbhrV9DcMiXgZPGT04Gi1PJazVL3Ax+K5+vG
         F2xEe4JwcrtI7rKjLpCb+KjzznAc+XxVIdrMrvTRA+4xA+IozhSDKO69wbv9PnMDJpP3
         qFwBewpUsV6nOCDANPr/Jowm2SHxA3spyy+ZzfLtMEMPuK5KkvCRyoGhVv/+5+tV6kzs
         qeX2YgFvTRr/LS5ZrrrFKumTdMgwwG2XdXc/9LpG8F5bo2VBjxLnppte+hMrnaktPmbQ
         T4zA==
X-Gm-Message-State: AOAM530GQ89BtHACi+9wG6/pmVn7TmGGFy6Vg+QZNgEFrSP4zsgAReX+
        mHqR8JSkRUhAwpIgZtmG7snGCdcuEr6LJw==
X-Google-Smtp-Source: ABdhPJx5aVn41DNMK5gv9dunAXVDJ/Xo7i7sbPDWRgE/jgacGLLtKQpJvClJGUHIRUYo16+aqq8kug==
X-Received: by 2002:a17:906:2b8c:: with SMTP id m12mr25091741ejg.358.1621948837922;
        Tue, 25 May 2021 06:20:37 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s21sm10759721edy.23.2021.05.25.06.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:20:37 -0700 (PDT)
Date:   Tue, 25 May 2021 15:20:35 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Lambert Wang <lambert.q.wang@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
Message-ID: <20210525132035.GA66609@rocinante.localdomain>
References: <20210525125925.112306-1-lambert.q.wang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210525125925.112306-1-lambert.q.wang@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lambert,

Thank you for sending the patch over!

To match the style of other patches you'd need to capitalise "PCI" in
the subject, see the following for some examples:

 $ git log --oneline drivers/pci/pci.c 

Also, it might be worth mentioning in the subject that this is a new API
that will be added.

> Device drivers use this API to proactively check if the device
> is alive or not. It is helpful for some PCI devices to detect
> surprise removal and do recovery when Hotplug function is disabled.
> 
> Note: Device in power states larger than D0 is also treated not alive
> by this function.
[...]

Question to you: do you have any particular users of this new API in
mind?  Or is this solving some problem you've seen and/or reported via
the kernel Bugzilla?

> +/**
> + * pci_dev_is_alive - check the pci device is alive or not
> + * @pdev: the PCI device

That would be "PCI" in the function brief above.  Also, try to be
consistent and capitalise everything plus add missing periods, see the
following for an example on how to write kernel-doc:

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

> + * Device drivers use this API to proactively check if the device
> + * is alive or not. It is helpful for some PCI devices to detect
> + * surprise removal and do recovery when Hotplug function is disabled.

As per my question above - what users of this new API do you have in
mind?  Are they any other patches pending adding users of this API?

> + * Note: Device in power state larger than D0 is also treated not alive
> + * by this function.
> + *
> + * Returns true if the device is alive.
> + */
> +bool pci_dev_is_alive(struct pci_dev *pdev)
> +{
> +	u16 vendor;
> +
> +	pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
> +
> +	return vendor == pdev->vendor;
> +}
> +EXPORT_SYMBOL(pci_dev_is_alive);

Why not use the EXPORT_SYMBOL_GPL()?

	Krzysztof
