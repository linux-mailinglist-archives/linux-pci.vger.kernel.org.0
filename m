Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7019D201A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 07:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfJJFkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 01:40:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33432 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfJJFkp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 01:40:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so2936824pgc.0;
        Wed, 09 Oct 2019 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fS3zhEs2E2HrZ3PHJX+bOppih8Vd+cHD1zJ+LmOQ0gU=;
        b=SEOhnRg6TMQTlLecTCBzAHS19lqshY915BrKmvEtHDm+98+lubpBO59C6vhBcA5rcF
         wHwioY7uZbURd7hlfm3ghfPpQvv0q8zDufXoOekV5oHDkQMbZ2D5Y6TRS4a2bbdZNXFv
         qHQVvSJvVvBA/gs76ePGS+BNszCyfb7iBmFl9MkG6exctb5ID35QWHpgqdSsO/dRsC2H
         xXfmLY1OriFIy6r+9Mt1rH6ytl0jY14sqVk1xGXZ0SLPqE3ay2+EiEQSZvo9PIq75o8t
         EmTijihzNo2bsQWtVb6rGXrKusBnAKpau6tmsKY0lzDFCbVv8N6tUD+1SqmY524+4mQO
         b6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fS3zhEs2E2HrZ3PHJX+bOppih8Vd+cHD1zJ+LmOQ0gU=;
        b=j6/Ht0eYx3WbmpvW4r3gmZQtunv5ksgPCwZVbtW8FH9z6bXhn+ePhvtlYd2COYcp8g
         WjERCkuWDwX0wPRc6s8p8K2edzPtCqRgSxK65+qTG0pomaaGq/HOHBcNgzsj+zz3Y2Tw
         7aB3mJGEgAigQow4MTnvCwE77FaZjkaCFBVVIdL2wDv/EqC14Oqw2KzoguR2V1l5Vpf6
         1+dw7dYM/BptMq0caJk0U/Dqzx63FcM2aYO49sRLA4tOZAn99iDWCT5zoUgG93entCty
         9t6CoCkeK9DKvvLXntOHU3ZwY3V9rjvG+2v+LhqPzXfKIxTe1St3FxXcXpZiXxkqjh6F
         dYLQ==
X-Gm-Message-State: APjAAAU2T7iJjYlx7J+9f55HyWjv4EQ5aJms8NBj11/qY7oRM4zOFpeH
        uZdVlokFeYJA7oBuE+EGSjR1xf3MVQ/ma+f7yik=
X-Google-Smtp-Source: APXvYqzXpiRvhdxxlU3FLptyt70sjJThUsp3AijDrhDIqRKG/k3omCJ41YQ+OQHUlNUlXrfhWffC42IU2xcr1VEc+dg=
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr9177676pjo.20.1570686042755;
 Wed, 09 Oct 2019 22:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
 <20191009200523.8436-3-stuart.w.hayes@gmail.com> <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
In-Reply-To: <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Oct 2019 08:40:29 +0300
Message-ID: <CAHp75VfNjnAxua6ESx1Vp=57O=pVM10P1UK8bGNQUk7FeY=Dmw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 8:37 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Oct 9, 2019 at 11:05 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:

> > +static void pcie_wait_for_presence(struct pci_dev *pdev)
> > +{
> > +       int timeout = 1250;

> > +       bool pds;

Also this is redundant. Just use the following outside the loop

 if (!retries)
   pc_info(...);

.

> > +       u16 slot_status;
> > +
> > +       while (true) {
> > +               pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> > +               pds = !!(slot_status & PCI_EXP_SLTSTA_PDS);
> > +               if (pds || timeout <= 0)
> > +                       break;
> > +               msleep(10);
> > +               timeout -= 10;
> > +       }
>
> Can we avoid infinite loops? They are hard to parse (in most cases,
> and especially when it's a timeout loop)
>
> unsigned int retries = 125; // 1250 ms
>
> do {
>  ...
> } while (--retries);
>
> > +
> > +       if (!pds)
> > +               pci_info(pdev, "Presence Detect state not set in 1250 msec\n");
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
