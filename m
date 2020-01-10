Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA0136CBE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 13:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgAJMKc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 07:10:32 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:39028 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgAJMKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 07:10:32 -0500
Received: by mail-pj1-f53.google.com with SMTP id m1so921600pjv.4
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2020 04:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1hfXg4LHfOQ4rsMFLoWXEIHtD836C3veIylGFjbfa4=;
        b=vOe/Yk5o2vo7tZMcqIiltuZE+E50lVk+UWVaf1xyoea8HFax+edXlikLNUBGt1uMKB
         ryulSeF1SWI/7jerFX08VtP91nhZYERHIQqT6V1ucA9PB5WM8mH87+hzrOJooIF7ZEaQ
         sPcv499KGNvZrJ7lJDk6gu/DqU0IkM+imfP7fdxnKnuLpaf2/uNlZmGa+bDcQZq/PvV4
         vJbVkHn2SL5GwSmJHEpl5XQkIyzQdReu2czhhJryM3rGwZ4h/svtQJnJm7ms2uUt4q9V
         HVCpxRxlctqQr1tCU8wLoOVSxd29EqiZOFspAeczBBcUfWaqBf5/Afr+iG3p2+mhxPoo
         vdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1hfXg4LHfOQ4rsMFLoWXEIHtD836C3veIylGFjbfa4=;
        b=L8NeNrspOxXIVeZqmU8AOJDIwpCbfGhFG5fpalKAeXAYiWMsApwiVyRqLp6nRMyA/5
         W/EtcMjxHTO0p0Z5Tbhnwl6FGVdwiOeMNjCM6GssN17ZW8YL0TNKbJ5HFq+tr1aAAUWq
         rGmDAEnRo/o/uR/uAwDxOpG5By6x0UhJf979PcwFVndu3wTVR/OCAMW/+HgQe7xDTHkc
         OT2IhwCEl0GF/gl8ZF59hhjhSu1/eQGGVwPfo4OevkDaHlcVxRH1dDXA1GDqz+ejADGn
         nncapfpsOcht2j7e/JsFM9LE+muhh2ehur3Q7b4zxZeIt2T9hAynX5R5ZHw56RbSSvWy
         RPmA==
X-Gm-Message-State: APjAAAXpeKoO0ICKKmOrm0ojXGHzyyXDYTdIdAIE073yiN01p7xSMN8T
        S11yy7AsbGoCHRRhE0OAihUq2V3XvpSfmyUcrBM=
X-Google-Smtp-Source: APXvYqx/I2yeAd77dxWaywzTwvgV//29iFUXikg85IX9G0+v53Geb7+3/cQxE6FcHtXOQ3AnDb4khT2FaJiExC+0FvA=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr4420378pjb.30.1578658231291;
 Fri, 10 Jan 2020 04:10:31 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YSQ.7.76.2001101712310.129933@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.2001101712310.129933@xnncv>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jan 2020 14:10:22 +0200
Message-ID: <CAHp75Ve4WhwqKft_7nMi5Ys9N4Fs98G1FgKxpKZ59e_UyCsKuw@mail.gmail.com>
Subject: Re: About pci_ioremap_bar null dereference
To:     P J P <ppandit@redhat.com>, linux-pci@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc'ed to Linux PCI ML in case somebody has better knowledge about.

On Fri, Jan 10, 2020 at 1:54 PM P J P <ppandit@redhat.com> wrote:
>
>    Hello Andy, Navid
>
>   -> https://git.kernel.org/linus/ea5ab2e422de0ef0fc476fe40f0829abe72684cd
>
> I was trying to understand this NULL dereference. IIUC, pci_ioremap_bar()
> returning NULL indicates insufficient memory OR if the pci device is
> configured to use I/O port address, instead of memory mapped region.
>
> I was wondering if(or how) it is reproducible for unprivileged user? Do you
> happen to have a reproducer for it?

It's very unlikely to see IRL such problem. Theoretically  it may
happen if the system in question has a LOT of devices connected to PCI
and suddenly there is no window for a resource left (usually 4k) under
PCI Root Bridge. Other than that I can't imagine what can go wrong.
Ah, of course the virtual space starvation is another possibility.


-- 
With Best Regards,
Andy Shevchenko
