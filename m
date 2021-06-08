Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618039FB21
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFHPsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 11:48:08 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:56281 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFHPsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 11:48:07 -0400
Received: by mail-pj1-f46.google.com with SMTP id k7so12146927pjf.5;
        Tue, 08 Jun 2021 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ifGZQu8Jq7dV7AdN0OST01e7WbED4WWmcsSQXXwwdJo=;
        b=iCcjGp++KdStE/BfRHFT1cR1yFuAbMwr/okM2xIV7IkSlvuUNop57o1wd1b8O/dTPU
         m9AN85xQG4bM3xQpLVo600ucXAvCTOZeToHRJ6yqFcAPZdgatcIZSicT6z5bZ4gFXX1r
         5msaoNxLGGDp/KsGVYPH5TiYmGdlMFxP7OVIA/phbB6punWvhpEG+JiE753poBmN438g
         hOvaEYj1IwDhnR2QgEFNjnUN8QdNmtLnC4IXaDzyW5bmlk0m/L+ksifrSxCujP97i0IH
         QllQIGjrExf4bZebZBvvL0miOikkGPST71wKJx8PTJQ3eh5JD8LRQlZylzmM980u6oiN
         yq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifGZQu8Jq7dV7AdN0OST01e7WbED4WWmcsSQXXwwdJo=;
        b=LA7jgEmVgrJTnUG+0alRXgZqbUnky9h8mXO/+BdltpAwAKct692SOh0I2Y/GXsQBGb
         1Ev7cI5qxrgC9auF8DvUrtQlt9APeAAf6SrEmNdNhnN5gL/IiKYETt1uGbZizMESk27Y
         O/lw6VjoWHRJW5wg9JoDcC3hL8PNfNvm5RUj2gSXk9CRhCsWVjRJxo9TPjtVcutY2DD3
         l9n29V7MoyCqp68gDFUGDzUOX75DVUsTtXIJWKCmkAvxuURoPeFw2q0DHmGfESSowB/N
         jq2/YYPO9eMvPUVWzkIPey3jctpuxXHv7l8oeSJpuOT94BkHjX1DMJpgr1E+ld+lMhoM
         D3Uw==
X-Gm-Message-State: AOAM532doJxjerSDV/zVyZ8zHBmLbiIfDomSLYE7+tEhsSmis17VY0cq
        fOg8Y9siMqjYlMkzu73IU/E=
X-Google-Smtp-Source: ABdhPJyy+WOcoe5buu/VuBaY4Xly4VOcAVPszB8pBpdk2RQ9QkUcjNbGPQlbpn8bM7JyADfWbagZ6Q==
X-Received: by 2002:a17:90a:588f:: with SMTP id j15mr5297515pji.112.1623167098105;
        Tue, 08 Jun 2021 08:44:58 -0700 (PDT)
Received: from localhost ([103.200.106.115])
        by smtp.gmail.com with ESMTPSA id z134sm11179376pfc.209.2021.06.08.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:44:57 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:14:55 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 0/8] Expose and manage PCI device reset
Message-ID: <20210608154455.ho44n6dnd52ogzxj@archlinux>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <abcbaf1b-6b5f-bddc-eba1-e1e8e3ecf40e@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abcbaf1b-6b5f-bddc-eba1-e1e8e3ecf40e@metux.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/08 12:05PM, Enrico Weigelt, metux IT consult wrote:
> On 08.06.21 07:48, Amey Narkhede wrote:
>
> Hi,
>
> > PCI and PCIe devices may support a number of possible reset mechanisms
> > for example Function Level Reset (FLR) provided via Advanced Feature or
> > PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> > Currently the PCI subsystem creates a policy prioritizing these reset methods
> > which provides neither visibility nor control to userspace.
>
> Since I've got a current use case for that - could you perhaps tell more
> about the whole pci device reset mechanisms ?
>
> In my case I've got a board that wires reset lines to the soc's gpios.
> Not sure how exactly to qualify this, but I guess it would count as a
> bus wide reset.
>
> Now the big question for me is how to implement that in a board specific
> platform driver (which already does setup of gpios and other attached
> devices), so we can reset the card in slot X in a generic way.
>
> Any help highly appreciated.
>
>
> --mtx
>
In case of bus reset(pci_reset_secondary_bus()), it uses bridge control
register to assert reset on bus so I think it should out of the box but
not 100% sure about it.

Thanks,
Amey
