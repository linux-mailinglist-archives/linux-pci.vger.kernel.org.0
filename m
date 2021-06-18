Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04963AC4E1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhFRHXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 03:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhFRHXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 03:23:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6871C061574;
        Fri, 18 Jun 2021 00:21:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id if15so3090018qvb.2;
        Fri, 18 Jun 2021 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AseZqmRRFSAWxlkl2H15IzgmyWSQsQrTGUE3obWRyrM=;
        b=MgJa/mVtq6XWZKn0imgyglg6ZDupmBYLsc6nqx+ZO1zknwhEReGKbW0bIN9kjCm914
         7E0WAR6WoiSOPVxaB4Sadr237fXQYjs9EIPdgHjw9yI7oCPSKi4s9wk8qO8viYfzO3j3
         oX+nQ93PDsxTTWGmQ+zEoHHEzIbrkCpmblgepC5prfbUg/gCfpWMcO/C4y9jHTrhS7J9
         aDBO2TOUCs0o7DhFQLYvBcSNaj7d6xtPRM96we9l/KZVn0ibRSkALFFBsZamfIFH6mcS
         yO9FBRCXYYW6AVbx1b8Fo3NeTpoSHj0kqJzDZ75OBnVurCO3pnFCMY6pcN+WXE9z1ab5
         BNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AseZqmRRFSAWxlkl2H15IzgmyWSQsQrTGUE3obWRyrM=;
        b=Ef+MtmPqPoSibr80Jz7KUYPznH43/IAULpfs66YOsPV95ENh9x9R45TxtICvXYKfbg
         TAZNL5eKxY7UcsIMH0cTjLSvQqZtv7JMVMi3ZhT29WNjJw/84pZKObr4vID1CyNRP+us
         eLJ3AxTp2FMApZzFQ5PkhSNAq65rvxW2MELMyrkagzX5MQoRW05vV7N6Kq8KwfoOanzY
         F8h/Dxto8t6FAe7hsQ5RjiT/bCHfdy6OO1jQOQE8cKH/dnbVf1zV0HgnuBu/IkWLzL75
         b6/mHP9TmjCkGlXx3FFp2wsqJMZTutobSQEe1xPztSCNEDPszd7UT+k76dghk4cTwuCM
         cAoA==
X-Gm-Message-State: AOAM533fmfuA9dvx0Tt6wV4MJcUE0ghXMGM+Wrc9ruirtwMlECP1gfGQ
        PTIoi2me11i15Fkf612qpoNxc6u3yEygs/ituAc=
X-Google-Smtp-Source: ABdhPJzI+iK7/41znGGgZl/dbRcTtghUb49l1y3drihvMzNc/ZojRa6nxa5QP29LX6atdU7DeSKN+KsCA9Lpx5XaGQY=
X-Received: by 2002:a0c:f982:: with SMTP id t2mr4206794qvn.28.1624000902896;
 Fri, 18 Jun 2021 00:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210618060446.7969-1-wesley.sheng@amd.com>
In-Reply-To: <20210618060446.7969-1-wesley.sheng@amd.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 18 Jun 2021 17:21:32 +1000
Message-ID: <CAOSf1CHaLCAsnB42Je+ynJ6xv-M8qmScbfOLSHVze7D4fEh66Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PCI: pci-error-recovery: rearrange the
 general sequence
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     linasvepstas@gmail.com, Russell Currey <ruscur@russell.cc>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wesleyshenggit@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 4:05 PM Wesley Sheng <wesley.sheng@amd.com> wrote:
>
> Reset_link() callback function was called before mmio_enabled() in
> pcie_do_recovery() function actually, so rearrange the general
> sequence betwen step 2 and step 3 accordingly.

I don't think this is true in all cases. If pcie_do_recovery() is
called with state==pci_channel_io_normal (i.e. non-fatal AER) the link
won't be reset. EEH (ppc PCI error recovery thing) also uses
.mmio_enabled() as described.
