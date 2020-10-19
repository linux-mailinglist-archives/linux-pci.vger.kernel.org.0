Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3C2927C9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgJSNAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgJSNAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 09:00:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE2C0613CE;
        Mon, 19 Oct 2020 06:00:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t15so10373705otk.0;
        Mon, 19 Oct 2020 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cymyCd5gi37rlWCj127ejDxfl3SFdVGt+7daiAA+8M=;
        b=rPEF+DNiMUWfzLdtOZ5Ur+BfiTWLQVcvI+X5jEFCXsQhM68/HvNbLZvzUIKbdcUAId
         7TcQSPREmdZQXQf9UXPbrdaNy+Q43EwC7apgHesdXNPAxw5Dvie6sA7YuoV3c0P7bFsD
         V16iWVGGhyOLN52oVpi3vBvO8y3juMza1Me1j9iQ66rPFZSv6JlXdM9NIA1l2AndXQBJ
         uUWVcopAMNMbVCN6yfrKUdCOM7Gi52tLRlcFOx0gjPBkE8PBpB/7aLe23hTwUQuGnmNV
         91Pdy41IzIaexzKtq4wXq36jUryYDg3XD0HymZ7hloGBFVlutzV5b57ugqwGkjF69pyL
         bcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cymyCd5gi37rlWCj127ejDxfl3SFdVGt+7daiAA+8M=;
        b=a9TmdSdXFq/eRmZxA6MMI/sKapuTThXshxVBCnelZBCplMzSBaUaugsDxd51C7tBVa
         uJzkPxVDd+QmJK0qyf5WB6IFKGV72AZNSughBazFOawmd0/nk0cHzjCvM9fiByc++HeQ
         Qetc8B3y3b0xFrI/fYdecwzz7V30DX8jp214H9dhyK179ntQoJ74y5FvKJcCtWtUyvhp
         c1Z3RyQW4aHI6tZnmeOCcMLtxaMop61jkJ76B5wBDINjkcxUmuwV4fsjncLBTx+yR8Es
         lRhSDKZO3hUdOCweRfTTBP2nmrxoL3T8ovRjgv1nlFvv6ocrFNrYHoLQkoTmeen1eLku
         4BFw==
X-Gm-Message-State: AOAM530ZQuSWJMAqMulraZ9BSAo1eH8txLXv3BcDiHArAj0gA9Cw5BRG
        VD64CD3eI8bbK4yLVqXtpZTNztGR8xVC7h4Y4JU=
X-Google-Smtp-Source: ABdhPJzjSWH9JW/j+crBHwvQjSp7BLNlgchS8tuosRBv2UR19CqZRRjs00K7J+7G4QBCbEbhynG+p6YhtQ9gih5V00U=
X-Received: by 2002:a05:6830:2434:: with SMTP id k20mr11264589ots.205.1603112429088;
 Mon, 19 Oct 2020 06:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201016055235.440159-1-allen.lkml@gmail.com> <20201016062027.GB569795@kroah.com>
In-Reply-To: <20201016062027.GB569795@kroah.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 19 Oct 2020 18:30:16 +0530
Message-ID: <CAOMdWSJDJ-uXpis1WbG3LnOG7bMiif5Q4Maafv_a=55Y_qypfQ@mail.gmail.com>
Subject: Re: [RFC] PCI: allow sysfs file owner to read the config space with CAP_SYS_RAWIO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, ast@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> >
> >  Access to pci config space is explictly checked with CAP_SYS_ADMIN
> > in order to read configuration space past the frist 64B.
> >
> >  Since the path is only for reading, could we use CAP_SYS_RAWIO?
>
> Why?  What needs this reduced capability?

Thanks for the review.

We need read access to /sys/bus/pci/devices/,  We need write access to config,
remove, rescan & enable files under the device directory for each PCIe
functions & the downstream PCIe port.

We need r/w access to sysfs to unbind and rebind the root complex.

>
> > This patch contains a simpler fix, I would love to hear from the
> > Maintainers on the approach.
> >
> >  The other approach that I considered was to introduce and API
> > which would check for multiple capabilities, something similar to
> > perfmon_capable()/bpf_capable(). But I could not find more users
> > for the API and hence dropped it.
> >
> >  The problem I am trying to solve is to avoid handing out
> > CAP_SYS_ADMIN for extended reads of the PCI config space.
>
> Who is reading this config space that doesn't have admin rights?  And
> what are they doing with it?
>
> One big problem is that some devices will crash if you do this wrong,
> which is why we restricted it to root.  Hopefully all of those devices
> are now gone, but I don't think you can count on it.
>
> The "guaranteed safe" fields in the config space are already exported by
> sysfs for all users to read, are they not sufficient?
>
> thanks,
>
> greg k-h



-- 
       - Allen
