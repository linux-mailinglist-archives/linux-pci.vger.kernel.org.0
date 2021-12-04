Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA52C46836F
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384374AbhLDJEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 04:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbhLDJEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 04:04:32 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0DC061751;
        Sat,  4 Dec 2021 01:01:06 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id s1so3394859vks.9;
        Sat, 04 Dec 2021 01:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgkXK4fzPp8AURP0vpQC+y8wZbCa2aBdXDsi6gZTVEk=;
        b=Xe6rTxvlXQLPige+SFQNHduMJJ2Tey+oTWTNx1h/kAl04ekfeuI2htcVESF9/ll0c4
         V8RPNM41gknCyY4G/WjGnFitkXvMODSyDnY4cd8wS3j22OBVP763K6BP645yynOKJIVF
         piz90pbN84eB1g1mELB3qSnd3BnglPrENCfe7EJeYjkJowcTiQ6BGTKDygtsfuEhqNp3
         54fsFGM+03S1w7uiBlC5EkSjpM4ofa/v6yrqUWgyNzcJw1YVvetPPOwq5aevvyYtWWB/
         FOPk3HrlhtTxfefguHITUr+ALPaskQ5WUR5UrNWofQ/9yhv3QgbNzYS392xSaEW/DDzT
         65mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgkXK4fzPp8AURP0vpQC+y8wZbCa2aBdXDsi6gZTVEk=;
        b=QyqNQV8ym91BHegRkTzJN8ebNSfuaUvCwoV/HNYrp/DHJJ9rz0Z44GKMib3Z8aNtg0
         BhpNaN8gl0DwYgFDNoTrau2eK0tGHfzwsQZEtz+fTdMn7KafZlzWhXZ9hvtslZKFaWvT
         jZEQ8fd+tVUypuqDlgigldBVDfqDltZU55HN1QNsluO1jgb6XVREeCq8mu/BqzluRWM0
         tC5zYylJRF8rxUsCNoX3Rk+Hkcwv1iHmscESCsr7VuUAUqy4jun6e3CBes4d0Xb/51QM
         YuXRuPXjvE5PjPmLIwj0fRrHJFiuyIPbXLLtTARI1ff960X2iJMGFKveCbjUa5fbmH/H
         7HHA==
X-Gm-Message-State: AOAM530OghMhlwcqJIbW0zdtQ6XRi5+FNgxMT+k3unfZMZ1yr0GAWR7y
        aduFgwGHPv52LOV4Q8Wa+fKxYoUOCO95zcwSLuM=
X-Google-Smtp-Source: ABdhPJynKjuz8/DslXEf7RBM3BMvCzkle4Q2GbIckxgZSyxOBJ9oEsmwBL7tCWyn6AbTc9M2TIdMynGaQEKY4MhEqKo=
X-Received: by 2002:a05:6122:98d:: with SMTP id g13mr28579156vkd.15.1638608466080;
 Sat, 04 Dec 2021 01:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20211201213402.22802-1-sergio.paracuellos@gmail.com> <20211203182307.GA3013031@bhelgaas>
In-Reply-To: <20211203182307.GA3013031@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 4 Dec 2021 10:00:55 +0100
Message-ID: <CAMhs-H9J73dRD9HB5OocSGRQ5NWf-StSaTU10C0uHopSSpe2Sg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Kconfig: Convert driver into 'bool'
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 3, 2021 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> s/PCI: mt7621: Kconfig:/PCI: mt7621:/
>
> in subject.  You can run "git log --oneline
> drivers/pci/controller/Kconfig" to learn the convention.

Will take it into account from now, thanks.

Sent: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.paracuellos@gmail.com/T/#u

Best regards,
    Sergio Paracuellos
>
> On Wed, Dec 01, 2021 at 10:34:02PM +0100, Sergio Paracuellos wrote:
> > Driver is not ready yet to be compiled as a module since it depends on some
> > MIPS not exported symbols. We have the following current problems:
> > ...
