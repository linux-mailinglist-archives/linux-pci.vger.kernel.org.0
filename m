Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D709B386CC0
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 00:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhEQWG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhEQWG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 18:06:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156CC061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 15:05:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z13so11042833lft.1
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0EnX96LwxQySMD7I4X6fO6Rjc5x34+gOGsRYBFgDTog=;
        b=qK4wqp1m3BeMYs8JRjpUe+jYFuWN1Ex03txiYUevSXortgsFyi5QTGOhWKZmYXPWBK
         UyajBCIqb9pg0cEN4P2vBJODU1HLkfL7MMT5r6OHY3xSpgEVz4usMhWkrZCjKpsIXf10
         zFkrX3RUDbN9DCDx8vOKvEyyL+aSaNa+z0v+ShnkIPeAO7G+XouF6HEZ7HQsOJY0zAhZ
         2b64tAjqpBWKw6j7H9C4UrY3y3D9ah1wM/swQn+hicno+e5howWuYm9PbpyqDErPZnAv
         RVEi/RCPdD+QY7kxKOTUmzOJAeizYg6lOIQsnShC2qCtkc1+84Y+y6TnxoCQXQ/CZsU6
         ydxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EnX96LwxQySMD7I4X6fO6Rjc5x34+gOGsRYBFgDTog=;
        b=oUa/0iVpapDMAvr90Qzv/xJrgLazNiWgezzVTKOpKShjp+gQsT41DvYaxSLiYFJ/zL
         JICQdLQDr0jkavVwb/cFzWUzexirwVGypsCih4VrkGJ6JWtuZShJ86Azy5hQmhLgOAyv
         hxUdpWH8SNt1xq140JPErsUIcc/tGy9x6xNwsjQJkWgQwxwqLDKMMpSQYednWQXIMM5z
         VF3P0Ul9jAbA40jSiQkvzHrwstbtUahAJ/XY3tmeH0VwaV+81ic45/jFfdcPnVF06AoP
         tH+kXD5qZH2ZCvSplPQY+Q0EiW8GQI6lMjDxoUyRACtCuW94CieIOk92hHsXecSrL3Kv
         Cnow==
X-Gm-Message-State: AOAM531buM+nRSwq+ILTCCHL8WGLOmVnIxPVuMMd+Opf2uRiOzvKXkPx
        WT3AvO4NYgPT7QNNJvh6UhXnkjJeiM+fdK6BtOgIJGvIXAU=
X-Google-Smtp-Source: ABdhPJzl7dXCM37hLA/3mkPPX/iWZAFk9lbQyOoe5Ys2y8odDTzF7712gF3wvnQrQLLs8jNqPWEDff17PPpBHSaVjfc=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr1359070lfl.291.1621289109448;
 Mon, 17 May 2021 15:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210516190014.25664-1-rdunlap@infradead.org> <CACRpkdbcN4d2sdCDjqqW7txDm7--_B2MX10CDA6z8FOq4mQ7=g@mail.gmail.com>
 <20210517103435.GA179901@rocinante.localdomain> <2a5204be-7761-2d0b-e1a6-af5b6d4fdb0d@infradead.org>
In-Reply-To: <2a5204be-7761-2d0b-e1a6-af5b6d4fdb0d@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 00:04:58 +0200
Message-ID: <CACRpkdYdFLrt0Mtb+KxQPZKebuMMr7bq6_J7SR=Z9DJxVemu3w@mail.gmail.com>
Subject: Re: [PATCH] PCI: ftpci100: rename macro name collision
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 6:16 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> On 5/17/21 3:34 AM, Krzysztof Wilczy=C5=84ski wrote:
> > Hi Randy and Linus,
> >
> > [...]
> >>> PCI_IOSIZE is defined in mach-loongson64/spaces.h, so change the name
> >>> of this macro in pci-ftpci100.c.
> > [...]
> >> Though I suspect the real solution is to prefix all macros with FTPCI_=
*?
>
> I'm willing to go that far.

Go for it.

> > Having said that, I actually wonder if some of these constants and
> > macros are would be something we already have declared (people tend to
> > often solve the same problems)and could be reused, as per:
(...)
> If you would like to take that and run with it, please go ahead.

I will look into it on top of your syntactic fix.

Yours,
Linus Walleij
