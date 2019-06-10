Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16B73B8CF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbfFJQAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 12:00:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39646 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfFJQAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 12:00:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so8696445wma.4;
        Mon, 10 Jun 2019 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhW3IQp2kxp2WT1udPSFigogxSZG4DD8hbZhEXJzbNM=;
        b=JttkhtuJpnp8/3mKYAP9FX6ZEhZDtPhV1qxLZqEoyxaqTClzBbTE8mNvx6McK0tsLD
         ZjzW+6RwjnPV9k7+OJFsAC4PfgauIkhX+nIaU52boLtE7gurMr9oRzg/XlDAAiuDXnZ4
         L3aWan/PNGTkGgZgN5G7NQOYuQUrGwq/Ug5vIXr3vY9XT8aeZ8hSADGHjESGHcU3C8Il
         0Jode0lCd1Tvd3acp/lvM5u0IiR15nHpL9jeaXuauJDnKNDoj3UQv0xZVwG41KgFEw6/
         /DPjfLDp0f4JqdyBSAgfh54iPoomChh5uwItMcuUIdtu0JdlN691uphnutTSx/3U0ZYW
         STcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhW3IQp2kxp2WT1udPSFigogxSZG4DD8hbZhEXJzbNM=;
        b=pxageWItzJrVbkJ0RrSKJiRA4/GA4vAr6/Xq6n+alb8QeMpMu1nRLrc8GL/JfTMF2T
         i23dmk/NR8L5zz/NfErWnTPuGOvtVWSWpDH8GkNvhl0IhdvZlf3xfIYjo0t2AHXXP974
         Qn0jcIHFDqJCK/BKW9rd5oAygQMhInKlEnldc4Ms4SS2Uv/4a1R6AsF/CgIXCAQ38Qb5
         iKb2bbv5F8GHxWgFXweyMjO44KRUmafMuaGwRbQ6PJrJ+W0u9H3Rsg0a7ZI+DnQdpgqD
         SQL6249dSfBKucY8DsIjPJaAIvfffU2Oy5Nqeo9y+kwkZ9Y8YlYNct2KhBr+M2eAVxz0
         RP5Q==
X-Gm-Message-State: APjAAAXdkvtylcwzvIHjpQEJRzjF1mpcJ+rKqgWCC851l/JLOOVR7GAD
        lf2QqJzr9Kc9NkqftPhjUEal26m9Jwk8IIpSWS8=
X-Google-Smtp-Source: APXvYqwP5gOmUVTPPKtavKrK8n/uGxVtTooANi2L7IbER7pYjep9UeDVtH2Tdsw9KlCt/brAB0JyQYC/SUM+Ayft/tI=
X-Received: by 2002:a1c:4484:: with SMTP id r126mr14508368wma.27.1560182441396;
 Mon, 10 Jun 2019 09:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com>
In-Reply-To: <20190610074456.2761-1-drake@endlessm.com>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Mon, 10 Jun 2019 10:00:30 -0600
Message-ID: <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Daniel Drake <drake@endlessm.com>
Cc:     bhelgaas@google.com, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 10, 2019 at 1:45 AM Daniel Drake <drake@endlessm.com> wrote:
> +       /* We don't support sharing MSI interrupts between these devices */
> +       nrdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

And this is a problem, isn't it? Since we don't have an option to open
the MSI implementation in RAID mode, your experience will be much
better to disable this mode when using Linux as per the current
recommendation rather than limping along with legacy IRQ.
