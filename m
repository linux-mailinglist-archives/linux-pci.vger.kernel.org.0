Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B239259F
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 05:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhE0DyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 23:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhE0DyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 23:54:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA524C061574;
        Wed, 26 May 2021 20:52:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb17so5771686ejc.8;
        Wed, 26 May 2021 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BspH1HZcZITcxF0rmbgmhpFuqnFljD02VxCFnbohkfI=;
        b=vY1zXogmOP0GIzyh/iHbgLk/GxpMTSu+9llO/2m960FTS8sqW3bj713Mhd7P2a1bPU
         BxMufd7w4LdnLm9i00eMCb23g4j74KDyGIm0wc7ueJghhhNOYCmsMyPCT+Zd/0tsAL1j
         vSbfu6CxS4sMTEU4rBuefmNE7rIFSiDYDrPbemk8T4FWzuNoKRDVGozUaLaCPGl9v0SG
         k9atr42HXSgWVGxncZ7Mv2rMk152UvBxgJKeV0uTofuvBKXcabeWf8jO+ltP9qx48QjH
         UBqtbArSbSQDpN1cpjsitr2bIJmIIeDt7pLQ4M9I5Z73dfErXCXurCIMWTbnrz8q1WNS
         sS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BspH1HZcZITcxF0rmbgmhpFuqnFljD02VxCFnbohkfI=;
        b=A3pTFynxScBt6ngEPyDdYuPhKwYoBBU2sTp3QeN+gm7Ig596MrX8D3ydvKYGq8ZnYq
         rPusdHgpsQL7NC4GrepKF5ubWJqv2Lr3ScUZOM8unbOy01GDR5nMqz9hxPJPG/bBhOmo
         eXo3SCin6tCzQokBd1WekoPAwjRwL5ilAWz/FypTtGy/5uM6OYoq9IQDXmOADMmL+TGN
         SX+ZyhqWlXlHH227s/qN0BG62uuRtCcnRwL+JcVwtah0a/i+Um094QS9zN8gMb6ccxQc
         /18l3XOS0pTUp2aw1zMEulXUoOvDPN9L+cB/ItWHb9vCdgXhyoXHE4cUyrSB7u6FBfB6
         OmnA==
X-Gm-Message-State: AOAM530Lw7c50cG4Y92KwVPT9QvJjcpSbvZ6uHuOK03ZvvJslbBRIl9l
        yZRvv980qOFUPD3szMDU0PLt75xvC62AyKniTr0=
X-Google-Smtp-Source: ABdhPJzmavZLEvwaFRAllGRc7d81w9sfgMiF8hYavyCuCd2nlJI0HCiYwD0IsiV6LPy/zGQE2bx/WPQm1FPnVON71sY=
X-Received: by 2002:a17:906:4714:: with SMTP id y20mr1659206ejq.235.1622087561499;
 Wed, 26 May 2021 20:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210525125925.112306-1-lambert.q.wang@gmail.com>
 <20210525132035.GA66609@rocinante.localdomain> <CAATamay8WTiJnB=5OLYdFTqVUcRF9LarN6_1Eej3QUgFzWRnkA@mail.gmail.com>
 <20210526181810.GA13052@wunner.de>
In-Reply-To: <20210526181810.GA13052@wunner.de>
From:   Lambert Wang <lambert.q.wang@gmail.com>
Date:   Thu, 27 May 2021 11:52:30 +0800
Message-ID: <CAATamazbYRnTJuPKVt_ypu_PVPXN407dSmo1EyExXHH0aHeyaQ@mail.gmail.com>
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Krzysztof Wilczy??ski" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 2:18 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 26, 2021 at 02:12:38PM +0800, Lambert Wang wrote:
> > The user is our new PCI driver under development for WWAN devices .
> > Surprise removal could happen under multiple circumstances.
> > e.g. Exception, Link Failure, etc.
> >
> > We wanted this API to detect surprise removal or check device recovery
> > when AER and Hotplug are disabled.
>
> You may want to take a look at pci_dev_is_disconnected().
>
> Be aware of its limitations, which Bjorn has already pointed out
> and which are discussed in more detail under the following link
> in the "Surprise removal" section:
>
> https://lwn.net/Articles/767885/
>

Thanks for the suggestion and the article. Currently I prefer
pci_device_is_present() for my scenario.

e.g. pci_dev_is_disconnected() seems to use a cached value. If the
driver wants to check the device's absence
after it *senses* something abnormal, pci_device_is_present() is more suitable.

> Thanks,
>
> Lukas
