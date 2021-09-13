Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E235409E03
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbhIMURL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbhIMURL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:17:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED80C061574
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 13:15:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g1so12145164lfj.12
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoWCjgCD64bkl6Rl+nektnSUWvwg8toSzdX9vNtNqOY=;
        b=NWtyu5HjELRthReuCBEZBKC/XHkat6LXkh/bLYeAtKdT1tGGvRmEk7O77/dovde6RT
         GiOmCwq924I5k7N6IaTYQ+IWhTxOdZjoeyfHUhXEiow+Lclsw+ETyhT80y6QtI72EuLx
         m4/CbCLJMTxQ6V85ClhpmTzWBEyzSAB+V0hNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoWCjgCD64bkl6Rl+nektnSUWvwg8toSzdX9vNtNqOY=;
        b=pJCbc53XD7GPXmJ0bhjvdWZom11I6EtsI/xe7FMjhhk+sEb2aAzIUERsn77UyCEY4i
         fHp0jPMq2rBZnK/hl75dqSIdYRrwnh0wMn37bVhwb3gF/pY1B0GMQOEJFLlJEkbjB4Di
         EHXbMIv0lyTDZbTQfpwcx1wsBAkRFQ4DDG+M5GMzKlhs6ONgZRXuPdXR1rQBSi2Dhts9
         isnCrnE9a5gjotblFh7KSgIDayu1fko0ySVWY5VFRVeIq2GTI86gSl8O4F47FocH/2ne
         OeZsjDAsE/yEBKHW697oyX4Yl7ULz/Q+hGkG2DTcW9LEl8uhPH7Ji01UVyU0cLMKgM6w
         VvMA==
X-Gm-Message-State: AOAM533wyziYgIouOKI/SRml7bWBOla5rBo3blAekGgoAjvTKRml7Dae
        OkNtuXzTp9eir/4fiLb+h2pLZE3l1atOM1kyAoQ=
X-Google-Smtp-Source: ABdhPJzv1x52md6lNJU4p4oxjcL8tDGLDccGrX/hfr4movgXOZYFoh6fKc3bBgfixeFpIPnXGfQW/g==
X-Received: by 2002:a05:6512:951:: with SMTP id u17mr9668222lft.636.1631564152921;
        Mon, 13 Sep 2021 13:15:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q20sm6880lji.21.2021.09.13.13.15.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:15:52 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s3so19437243ljp.11
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 13:15:52 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr12255814ljv.249.1631564151997;
 Mon, 13 Sep 2021 13:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk> <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com> <18e101d9-f94c-1122-1436-dc3069429710@gmail.com>
In-Reply-To: <18e101d9-f94c-1122-1436-dc3069429710@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 13:15:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUTGWz9GL8Y126rkvTK-aGHoe8a3R3t70boJDUAH_n4g@mail.gmail.com>
Message-ID: <CAHk-=wiUTGWz9GL8Y126rkvTK-aGHoe8a3R3t70boJDUAH_n4g@mail.gmail.com>
Subject: Re: Linux 5.15-rc1
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 1:11 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> No. The timeout is not the issue, otherwise you would see the message
> "VPD access failed.."  over and over again.

Ahh, I did check that that error did exist, but you're right, it's not
there all the time.

> The issue here seems to be
> that this call in PCI config space access to adress
> vpd->cap + PCI_VPD_ADDR stalls.

Ok. Regardless, we shouldn't do this since the boot code shouldn't
need any of the VPD information.

        Linus
