Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2446231F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhK2VVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhK2VTx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 16:19:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8AC214FE5
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:37:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so16404992pju.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y57dLs12KYOjEguyKsDB0gIGYTL2paAzcRcVxaXn2oo=;
        b=r5u6OKTR8lVUXIMCr531D3Yg6CBADkWid6ozW3oE7IVursYcy0DG/mg2M2vodGrhQp
         UbUYSFequ4/C6m05MiqI35a7dg+YfcSlogIVtvUHAaOspZgPG1LK10Rum7tp8F9dxVI+
         4OXHkBU9tRrkraUTfRF0o+UYXh89DbDsi4VSF61Sh6VBU5xiFrTwkNI2lvoScGnTZlsc
         0viUW9enwY2dw8PyuCmKeDSl5f9WFRMiwtilYaZlYs+9UN7pay0nWoybJBiqw9fYPu3W
         iwRrlk/JF645UQSNr3iuR5cV11muM7gYOvL3E6l+plD8yPcm/EDA0TvsiFs49UIk3hvs
         j2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y57dLs12KYOjEguyKsDB0gIGYTL2paAzcRcVxaXn2oo=;
        b=wotWl2wlUvspY7+gBCnNpPZpFdupKJ5wa9CfA4JhcbyomqJ1SGOdqhaKIDpvcB4D69
         295epk4yJfj1TbsdXz+HjI53oY6AfVhr6aIAwvYhxTqIYeJX7678ueNYIi1PlTUAOEKw
         Nd5/FRhKYZhQ44xlPzI9EZHKTF8MJR2C+PFi6pTE+V0U2wcoxWutLQ4rVbZ9g6RcDGNX
         cP6SQeYumo8nofbovg0B5o0e4mxt3+gW+dU8GYztx9Hnc/9yLy3b2b2Fj404bJ42FEF5
         qXuNkkCD8An8v7sDnWJw6MP1nIKdpF+ZC7+zZSxYBYNAa+8W0WvQEXzK4ATi3WJk818N
         QTgw==
X-Gm-Message-State: AOAM532DLWnZkTJr5bQl/ZozMQGID3iKHWM76CDF0XcUidJPQCe3Srrc
        1vEnKQt7Cyqzu32H6+57c+KCqFmgP6jMdePonZKZIg==
X-Google-Smtp-Source: ABdhPJwsdoXDfCBVNW5BkZLN8ABu/S9KNhziapIOp8Po/ehEWog/GfaVWWX6dcv5+ONBYQh8g1jNRC8HJ2934pmI42E=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr62152271plt.89.1638214659265; Mon, 29
 Nov 2021 11:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com> <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
 <20211129183330.svptvcystceazgwc@intel.com> <CAPcyv4hPP8KYXD-6mrpHRpLYLqSQb22Lie2_m1Nc=Y5NqqfJgQ@mail.gmail.com>
 <20211129191146.vhiwkf5jsegil4aa@intel.com> <CAPcyv4gboiSXq1zCtmnP7oWzjaoMG=RL5sgmhFtXuxsTTPf3fA@mail.gmail.com>
 <20211129193156.wtm7p7cdpn7iedqa@intel.com>
In-Reply-To: <20211129193156.wtm7p7cdpn7iedqa@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 11:37:34 -0800
Message-ID: <CAPcyv4jT_5x7itJovgjRyfsRsjWqPghRYshxqvga=af8GJ6Nmw@mail.gmail.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 11:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> >
> > Right, there's no harm in the check, it just seems overly paranoid to
> > me if it was already checked once. Until a doorbell timeout happens
> > it's an extra MMIO cycle that can saved for a "what happened?" check
> > after a timeout.
>
> Well I suspect we're just rearranging the deck chairs on the Titanic now, but...

Not so much, just trying to get this driver in line with other error
handling designs.

> I see doorbell timeouts as disconnected from whether or not the mailbox
> interface is ready. If they were the same, we wouldn't need both bits and we
> could just wait extra long for the doorbell when probing.
>
> In other words, I expect if the interface goes unready, doorbell timeout will
> occur, but I don't think we should assume if doorbell timeout occurs, the
> interface is no longer ready. I don't purport to know why a doorbell timeout
> might occur while the interface remains available (likely a firmware bug, I
> presume).
>
> It does seem interesting to check if the interface is no longer ready on timeout
> though.

So I'm just modeling this off of NVME error handling where there is a
Controller Fatal Status bit that could be checked every transaction,
but instead the driver waits until a command timeout to collect if the
device went fatal / not-ready.
