Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFD88BDD
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHJPQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 11:16:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38042 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJPQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Aug 2019 11:16:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so144161179oth.5;
        Sat, 10 Aug 2019 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xghbNPnABIn3IsnFfs8INVPgZBhjMcp5cyTaz7Y7CY=;
        b=GQHnk6Y1/WpEGjLizA/9lEth/P9rZzhMhCbWfrtvpztugcBDGfO6BFCBH1RfMWJDQU
         cIXaWyw/tzK7o8jfM4pZSohgjWmrPqB8P46nnvLukeAi+DTvIRgaJC+jVbR+JtBuC2J3
         ghAvWSw+E7DJ1mYQzz4pn4VoTdESWFlPwOw51Mw6t98KvTOj7GUSrS2WZNh7UCU6Ye+1
         c0dud1kHubFnvoQT/ZL15XKRs9vViliMhUAZkviGJM/IdcTE34168sqaAv4ITnEfqSkc
         4Tj/kijP/MxM0RBY7u7ng3QXJBdUXcdwqsfgS6Vde0nsYYqyyxoCOIwxEsR89L6FA78L
         tL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xghbNPnABIn3IsnFfs8INVPgZBhjMcp5cyTaz7Y7CY=;
        b=NzU0bCHEhxMvmJSeQK+BuAk8tymXb/I5+icyqq2wq28YYzHOwoEZdiojVZgwxqNaq2
         e6VsEf13YEhYTS1onOzoMSr4fEpXftWY1Quue9aUoBp9d7Uy130jwlrUKVa8mx8FsmOL
         SAw3K0LtnsRxydydQVeNq0sOe3qaJpx0kXwmcklpNCxnUOb7pC2LjqI/YyPVzSP1/Bqo
         mct0/ydiKQXBnOytSOHfPXCl0b+D4dTONnwex96ojsg2vJI6wfOZ1Kln43eSa8s4i0PN
         n9d3ATzRVz77hcOkPmTzkNEOfNvq4P2TYbJbP4jkpKa1kFymb8tHrfxdlXHN68LmJbyg
         apPQ==
X-Gm-Message-State: APjAAAXMOPjUPHmdW9wR0tBLEBoKtmaKE7CuTH3EPNJt9uNJscxSNcc8
        EKIPMB4WjSwvN9tZfWiHXZapcmsWFt0NAkpilIA=
X-Google-Smtp-Source: APXvYqyUxQ8Jnl1txgA2LO/XXluKgQETVSBhlQunQ9J1bpkIh5ywpBDnH1Mr7qCNwg5m9gYlhmSB8uDP3jiNK633Y4Q=
X-Received: by 2002:a6b:ee0f:: with SMTP id i15mr15836713ioh.91.1565450202993;
 Sat, 10 Aug 2019 08:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <bug-201517-193951@https.bugzilla.kernel.org/> <CABhMZUVhM3PU5BUu=k-KfR5injzFM4VoABKtN8HxXW2HiPStQQ@mail.gmail.com>
In-Reply-To: <CABhMZUVhM3PU5BUu=k-KfR5injzFM4VoABKtN8HxXW2HiPStQQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 10 Aug 2019 20:16:31 +0500
Message-ID: <CABXGCsPa7a72=Bhx43qcbuPf5kYq3+607fGdF2hzWU457-wDGQ@mail.gmail.com>
Subject: Re: [Bug 201517] New: pcieport 0000:00:03.1: AER: Corrected error
 received: 0000:00:00.0
To:     bjorn@helgaas.com
Cc:     Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        emteeelp@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Dec 2018 at 04:36, Bjorn Helgaas <bjorn.helgaas@gmail.com> wrote:
>
> [Forwarding this to linux-pci since nobody really monitors the bugzilla]
>
> Possibly the same issue reported here:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=109691
>   https://bugzilla.kernel.org/show_bug.cgi?id=111601
>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1588428/
>   https://lore.kernel.org/linux-pci/20160215171423.GA12641@localhost/
>
> I had a theory about the problem (see the lore.kernel link above), but
> that was before a lot of AER rework, and I haven't checked the code
> since then.


Thanks for the response.
I have tested the system several months with the kernel command line
"pci=noaer". And the error "pcieport 0000:00:03.1: AER: Corrected
error received: 0000:00:00.0" not happened all testing time.
Which is your theory about this issue?

--
Best Regards,
Mike Gavrilov.
