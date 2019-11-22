Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9B105DE5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 02:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKVBDD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 20:03:03 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:35723 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVBDD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 20:03:03 -0500
Received: by mail-qk1-f174.google.com with SMTP id i19so4887872qki.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 17:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLn+spXwD5Gur5nkjctsP5V0aZgN6H8nJlveJPJexlo=;
        b=aMUhw2CrkItSqKYJrbJfKMcVuXfBjIklX05uuUj1dxbx9rpA5JAwYhoqpHMx0TLp/k
         6sWxWJsXCcJKFsuLfycxGX3uWnGYzGCpiV2Nezwgc9C0456qvYfhHDSef8tg54+W7SO9
         uq+RsmnQ6CeijBsmzgeqBFqp0CV78sqVJUupKwyjUfykmJrV2R2OAZzFGzCFVMNBk09Y
         5dSr11ngR0KRAwV2Mr2GR6L9hj6BXEYSkQymqwIWKNq+Q5jO23rKBoyuKGo/7Etm2kka
         61YvHXHfdTH2Xmey66z2h5Kx7Md+xnW7Ehh6Cict3XMFGdykZ3FtbmTo91/6qcVlj3se
         wtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLn+spXwD5Gur5nkjctsP5V0aZgN6H8nJlveJPJexlo=;
        b=AE2cs3ZeKUtEJIMgiRkHAOagbQ6NjS7nicASJfvx59ntRcwwWZemLouLnl+R3ltjO0
         DnkemdnY0IzgNM3PJCU1UHZqmQdGwC9R2rp2A3W2U9dzzPAqhjW6KlEf/6tcPNnhhUej
         l4ooRx1nB6edUQKcN2mQ50ikOpywPuBSFFqZlHGR1CcOd7NnIQ1L/9958fwA//G/Yl25
         3TpcJRdb3/X/ChXubsutjjbkpctZ+jkcJHOTIvOoVSby8OsiAnoOooMaZU3RKAB6oXoY
         xtTMwWSqLo4WsM0tV6TqyRCoCTFI+S+TUQ/kFXP7SWJ91bQMaSiHaJcl7AVCfMARPewP
         WcSA==
X-Gm-Message-State: APjAAAWgzUe0zZmhEeZvjzr1Jy9+b44DSpUJ7mKTG22ALu7nxVK5ibac
        OdS8smIob15EqVYqgEM/JivQKPiSvfGyDgg1M1Y=
X-Google-Smtp-Source: APXvYqxj0pB2VzPDUIINmaf0t62qMlvXq7e1U8fuXFSBPl8wr8DoIIeKhzzijwbbovaeMmOjpWpDiqQWs4dHYEFET64=
X-Received: by 2002:a37:6c01:: with SMTP id h1mr818688qkc.484.1574384580750;
 Thu, 21 Nov 2019 17:03:00 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYp7kQdMKzX2RQW0tY2P4Um=CNJW93RPquBmYATRGrxwng@mail.gmail.com>
 <20191112022938.GA89741@google.com> <CAMdYzYrYHtiEXwiKxwWcKSV7Re6dG4zTvkKtZxvso+fLBRYbPQ@mail.gmail.com>
 <991e386e-4c4f-fcbd-89a1-1edd82f63ece@arm.com> <CAMdYzYri-yroFtvVXdNZH=sNOM7RP_PBHVnmbHuAKmGBZ0GifA@mail.gmail.com>
 <CAMdYzYrc-AJNpnqR6Xw9Np0wuUvS4-u+TCS2WEo78TfyEhCQKg@mail.gmail.com>
 <CAMdYzYow8SuXb_8ow433O_+Wezxb-U08WDUiLxcTKh+1_zBzkQ@mail.gmail.com>
 <CAMdYzYphu1vHEprfry52+vH9Hjp3ZddgY5hk4Xqk2b3v=DU80g@mail.gmail.com> <2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com>
In-Reply-To: <2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 21 Nov 2019 20:02:50 -0500
Message-ID: <CAMdYzYowLb-FRUxP_TC+4LFwYdvszq+mBvfXBiDTCqtbF0x5xg@mail.gmail.com>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 9:05 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
<snip>
>
> Not having too much time to follow up w/ upstream development, sorry.
> I attach a patch based on Linux-next for debugging, but I don't know if
> it could work as expected since I can't test it now. But at least it
> shows what the problems were.

Well it is certainly hideous, and does not compile cleanly (built-in
complains, module is broken), but it finished scanning all buses.
I'll do some more serious testing and get back to you with more results.
Thanks!
