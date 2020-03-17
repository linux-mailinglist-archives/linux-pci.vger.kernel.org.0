Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CEC1878E8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 05:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgCQE6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 00:58:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43909 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQE6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 00:58:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id dc19so24771527edb.10;
        Mon, 16 Mar 2020 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSlwcCW1wByXeYUT3JQbxi77+0v1S3fgiBq0ZW8UzqQ=;
        b=Sse7C8BnQ3sSG2GAEC2SuJEhmdjyyN4QD0FABveGRUuZ/u9Fxt+BLEn16bb+UzvW+X
         KgtvmSv0hepHbqx6LErjMdQ34NGc4heGyQrUJIEHWDcux9GTg1B4QL+so0y2twZK48MJ
         WFTumXlUtIu/6lW7GdXmRJO1uL/34yTMyLOXHA2vEniUeuA2ETOr00UkgjVHw3jdFbKm
         ZwsTgM7xloAXSNTq00vxxy2RC32eEf6U/zSKy/HbC4lpaGFxFx3aPCA6myhqi08WPo/N
         E1njT+cRrT22hPbp/XkEuu5JoDXu8RfkdsO0L6nV27uaJg3RhCW0NO2BwmoL1vu9Kilf
         gFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSlwcCW1wByXeYUT3JQbxi77+0v1S3fgiBq0ZW8UzqQ=;
        b=S2VVIKRu1L9z8+oLYAE/Xc/nJAKXyJrcTuv/xrKKkOHIb+2i22t0JkW3tY4yYW7mZ8
         ek5w8EI+zbCiZ7zsRZB0cfLaKDliIsjxB4AbYjiw2e28QXMSkg/BClCHVfVZ2yMfy/Ia
         SHrSP+4F4AbyvosazFUu8+bdv56k+qVzw4jujHCdkyc5MjUgfqkRCob+s42cZvttj72g
         rzxnZRO3GV4jzWOMoQmVdig0hL2F/Pq4qPcxUHhlxwPQXOpsw+Un6dP6JXWxAt1R6aUW
         Orzvl8gHJs+DhDRoB2dITPPWlQY81humufEDEdN6AR+7qmhGICidk8qXgJFKvYOeAqiF
         SzgA==
X-Gm-Message-State: ANhLgQ30ftmBDmPE9Zhdfnm1UboJL3H5nDPPBGTbtiUF4MDSf2wUxUPC
        sGFwzdSDdN3vWMDBYFbp7uyRemFYRtEu/aO8OezjZVf5dI4=
X-Google-Smtp-Source: ADFU+vt3xCyO8o+4SlufylCOspqYBPK7LTUD83r1wLQ6XohuvLIKrpjIO4iG2+Rm4KaVUyun+Usuo4bIGx2BBlCaLFg=
X-Received: by 2002:a17:907:2165:: with SMTP id rl5mr2502320ejb.193.1584421096460;
 Mon, 16 Mar 2020 21:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200314194355.GA12510@mail.rc.ru>
In-Reply-To: <20200314194355.GA12510@mail.rc.ru>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 16 Mar 2020 21:58:04 -0700
Message-ID: <CAEdQ38ELWdKKPE1svWEUwnHBR+J2cFGO=zWTj3dS3D9JqxDHcg@mail.gmail.com>
Subject: Re: [PATCH] PCI: add support for root bus sizing
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 12:44 PM Ivan Kokshaysky
<ink@jurassic.park.msu.ru> wrote:
>
> In certain cases we should be able to enumerate IO and MEM ranges
> of all PCI devices installed in the system, and then set respective
> host bridge apertures basing on calculated size and alignment.
> Particularly when firmware is broken and fails to assign bridge
> windows properly, like on Alpha UP1500 platform.
>
> Actually, almost everything is already in place, and required
> changes are minimal:
>
> - add "size_windows" flag to struct pci_host_bridge: when set, it
>   instructs __pci_bus_size_bridges() to continue with the root bus;
> - in the __pci_bus_size_bridges() path: add checks for bus->self,
>   as it can legitimately be null for the root bus.

Works great. Thanks Ivan!

Tested-by: Matt Turner <mattst88@gmail.com>
