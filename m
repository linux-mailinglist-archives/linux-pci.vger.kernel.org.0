Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98040263AF9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 04:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIJB6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 21:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbgIJB4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 21:56:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E3C061344;
        Wed,  9 Sep 2020 18:54:13 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x19so4434802oix.3;
        Wed, 09 Sep 2020 18:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkszcx2oS3yh2dLZNuR4YYgi6HQntQ/UA2yKdcWJtPU=;
        b=UdZoI6XO5budoEdmeGwkVbFPApjDDdFRSxrgGAmS2Nihx04DF+xGDDDUaeFPxenFja
         XsH7dBBUyxPAmaDgnrUllDqGRUekVOSdXN0N462Q6X82Q3EtRkzqQDCIYWkuY+c/tNHO
         e2zIrIR8cBe4S8XZhkhLTFmcYHfCTStkcmecg/27H0pMUfeY/8qXJQX4KvGXW8V6zzqq
         o7x3asZdi2qi3MAfuTu6r0OFjr1YYIafwkoZcabG94k/+AsBJAHWVKZN/TtQQJdcE7sk
         7czCI3QadcaOOG5OqbDnvgzH+tW2+zLNCDzbNikL2NnU57yNDJvFClc+g66pDxMxximW
         n/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkszcx2oS3yh2dLZNuR4YYgi6HQntQ/UA2yKdcWJtPU=;
        b=FHyqP9MD0CgMUaNxmtUVSTlaZttX4JuPr5ZWUkoJfjuhhLFefAFGi0ID5tzkmlpifq
         JyhB8plRwjJtltPg3dci7sQhRbdbWgAAuXs1z/Kkp9+W7HXC+BzeIngyDTvUoAuZ5FbL
         kzHKwCop2T2uTusiwlE7JWi3CSjo6f79uuCohFDToUHGOnS6kGE/ziA5U8P7Ou1hB6kB
         xYDYHc/jkziUx64POn7tZiYCUKRSbpMvbVT3tlX8m2nZ3NGyCJPYiY7dpF6gG8WaPLTU
         ByWV0tcPO9PVzpy2FV958mPzuBjn6tt2EhKUZGKbA6jXO2PSmS66BGRFczvBR9h4LEj4
         sO1Q==
X-Gm-Message-State: AOAM5319alFpPzq3hf/+5CdWD0plD6zkW8K8e1wQwNZCc5SDOVDwALS0
        nV27myEteHsSuW/QgvW5D+ODqZdMWGivL2TFGN0=
X-Google-Smtp-Source: ABdhPJxJ/InhtvdlElZSFPJ7xDTppgZhBOye7tLXZFEJJ2SdbwwMe+1rYpu/H0kdM0LZQ9IGilPVfahtWZkKvuSWD3c=
X-Received: by 2002:aca:aa84:: with SMTP id t126mr2469772oie.5.1599702853383;
 Wed, 09 Sep 2020 18:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200824052025.48362-1-benbjiang@tencent.com> <20200910012543.GA745909@bjorn-Precision-5520>
In-Reply-To: <20200910012543.GA745909@bjorn-Precision-5520>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 10 Sep 2020 09:54:02 +0800
Message-ID: <CAPJCdB=HzNJp36tjD0=-R-cs4+8=xhxAfmR-tZ2DkpcyiugH-g@mail.gmail.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in pci_read_config
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, 10 Sep 2020 at 09:25, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> > From: Jiang Biao <benbjiang@tencent.com>
> >
> > pci_read_config() could block several ms in kernel space, mainly
> > caused by the while loop to call pci_user_read_config_dword().
> > Singel pci_user_read_config_dword() loop could consume 130us+,
> >               |    pci_user_read_config_dword() {
> >               |      _raw_spin_lock_irq() {
> > ! 136.698 us  |        native_queued_spin_lock_slowpath();
> > ! 137.582 us  |      }
> >               |      pci_read() {
> >               |        raw_pci_read() {
> >               |          pci_conf1_read() {
> >   0.230 us    |            _raw_spin_lock_irqsave();
> >   0.035 us    |            _raw_spin_unlock_irqrestore();
> >   8.476 us    |          }
> >   8.790 us    |        }
> >   9.091 us    |      }
> > ! 147.263 us  |    }
> > and dozens of the loop could consume ms+.
> >
> > If we execute some lspci commands concurrently, ms+ scheduling
> > latency could be detected.
> >
> > Add scheduling chance in the loop to improve the latency.
>
> Thanks for the patch, this makes a lot of sense.
>
> Shouldn't we do the same in pci_write_config()?
Yes, IMHO, that could be helpful too.
I'll send v2 to include that. :)
Thanks a lot for your comment.

Regards,
Jiang
