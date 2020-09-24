Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F9276927
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgIXGlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgIXGlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 02:41:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C643C0613CE;
        Wed, 23 Sep 2020 23:41:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so2165608ioj.7;
        Wed, 23 Sep 2020 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc/zXBadEVOmIc4OHWI+QEDHr9bs5kygtZ+w9n+QyNA=;
        b=bt1H2ClYpG6wRBMl3caRAX4oc9cclKQ6XJRi8LQ5BQkrpCJxtex3tyrMwzGPAVaax6
         tRNaBZriP+Xkd4JTfFowUvkRuRV0vvU41uk+CXSIm7gcTxm5aG79V6Ap6fxA7Mehmn+X
         WJ69uyB0ZlPtvrGPuUAYcgQkrEjGFoAJWBPb8rtXq7xXicAkuVyee/N0YE1hVBMyiETD
         ldtFhrgTZ6OFkXJ98rEtgBcpscpLNRscXohkBRnn19V0iDJHisgA1ZyZ6CTVgIn7Bjtb
         70WO9FbMuw9f+alGIudE/2zj1ae8t7oBk4uF3xY3cvUJCL5pIpz0Si3KflORXaUakP+/
         6WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc/zXBadEVOmIc4OHWI+QEDHr9bs5kygtZ+w9n+QyNA=;
        b=mOCC4Zdj9IAkJzh3kaG72mt3AC3K0YJgQM/nrwqZx/THtwdHqkOtebkFUuvwSs3Qxn
         apM67mIR0P68zawW/Qr//xL7X/IO2NjmRIsFzorkRRPM3Pdwsy+6zjVqKe6N39UKByl7
         I5ZY4jN2vADe3YhT9XF7ZSS3o/fsawgEcowspHsgQavibcsYwTp4zj/gYwGUAW7JBOcV
         ZN/7J1xRrhg9gSKbFK8fmzdCGphoAfRTw+ghvdRCzPBhm9rU/UbQTFxAiRmemf+/lMZ1
         pWbgng31FAgO8IRPdiGm6a5vnvMOHsmtVjZD7EvQaytLKla8WzL038D0Ua4KWdvDXOis
         kPGg==
X-Gm-Message-State: AOAM533zXbX9oFdp1ECc+PtoFAGKRIjwt085z8WzOMKkgZ6xOwsXgBSH
        /xy8WAhCdt88Bvuh0ZSEdusHj6+BIBeZtJOPm7g=
X-Google-Smtp-Source: ABdhPJz9Z48rA7YNFkkLeQn2ItT1DskwJV6AnHnzPbQ2u5MHEkr6m8hq1mErYNocrznn0VblhKBV5Qgv1f8gkKFFKX0=
X-Received: by 2002:a02:ccca:: with SMTP id k10mr2538463jaq.111.1600929710016;
 Wed, 23 Sep 2020 23:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200924051343.16052.9571.stgit@localhost.localdomain>
In-Reply-To: <20200924051343.16052.9571.stgit@localhost.localdomain>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 24 Sep 2020 16:41:39 +1000
Message-ID: <CAOSf1CEv3v940FR_we70qCBME0qFXPizPT8EFbf3XyK2-fPDrw@mail.gmail.com>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel modules
To:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 3:15 PM Mamatha Inamdar
<mamatha4@linux.vnet.ibm.com> wrote:
>
> This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> (descriptions taken from Kconfig file)
>
> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> ---
>  drivers/pci/hotplug/rpadlpar_core.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index f979b70..bac65ed 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -478,3 +478,4 @@ static void __exit rpadlpar_io_exit(void)
>  module_init(rpadlpar_io_init);
>  module_exit(rpadlpar_io_exit);
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("RPA Dynamic Logical Partitioning driver for I/O slots");

RPA as a spec was superseded by PAPR in the early 2000s. Can we rename
this already?

The only potential problem I can see is scripts doing: modprobe
rpadlpar_io or similar

However, we should be able to fix that with a module alias.

Oliver
