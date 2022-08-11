Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAF858F83D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiHKHUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiHKHT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 03:19:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7391D1B
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 00:19:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mk9so12717394qvb.11
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h2MoL03lBkdgEsIuQqutH8cxN+Yd4x7ZcsieCTffkXk=;
        b=OKKZBZtblln4astqy2YHb8FA49/KSI+mVt5AUXvViSuIkTNMR/R0wTKefOo7e8T61s
         TuTufJbFxMz8giToczOxES3Sqf2WTprj97bAf2j/JxawDqlIrjsRUC627ViaZew1Aiqg
         1AIGyRw81ixA9eX2X864CQzz2gyWU1qKqjvgjsPXIb0jPij+Xc7skUotKs+tHZpYrUe1
         hqVwT5oIBc9MHh6Tge9Rkfvo2pAawU3TxAgUQ1UDCpMQkjbfjhI4ggKld15GK9nrPl1o
         /m9W5K55vs+0Q5A+eR7TlPMgcnhDy83fjOkrBTPc+c/pNImKRzv2j/aSEuEfjK3WFH3+
         wiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h2MoL03lBkdgEsIuQqutH8cxN+Yd4x7ZcsieCTffkXk=;
        b=hzoNf+IU3zOAoI7VYUo3P6vMZqEYX7A9G051ALvIhzUMUC1RprfXkCgB/K6xvUKqin
         RioXM6MGZ9wsPL/4n1pMoxDqCjkpVDFpf+P0m330kERKrvA18GvtIqV8Cf6nj+y2a6n2
         93PKvElP0opTCY+OmVc0lBQArZPyqU64WmcNVpZmUWh0C9fKaBfqoyozZTxQp9SvjaaU
         TpP7Tgjkwpmr63roh2kENM9P/CDp+m7OdNYYsm7TfEpwv3Zegq7dOZwBveKlc5BkOOhP
         j7fFD0ohOpr5TPwxFKTWaDM9/Q30BzluI6c3ptFkxVr7YxVpW0xR8jW/menyiwqIUeTp
         UZfg==
X-Gm-Message-State: ACgBeo1UjTVfzLk4XgpueQZXmfcCZH40B0gPk0cF1+U35nwrgLBxGm8i
        f5qBz35DcuXE+TjlWbD0TiFQvc9ZA19voh3Vj40eTdczrNA=
X-Google-Smtp-Source: AA6agR7tQbBprz1To2uSkdhWrz3WsFgRTMHSY6HM/0OxOG18+HdvoQfeg+d30I0zQs0eJ1f9oKBzNzItoo8IGe7ytfY=
X-Received: by 2002:ad4:5bed:0:b0:476:dbbe:f167 with SMTP id
 k13-20020ad45bed000000b00476dbbef167mr27343541qvc.100.1660202398215; Thu, 11
 Aug 2022 00:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220806085301.25142-1-ruscur@russell.cc> <87lervcn9o.fsf@mpe.ellerman.id.au>
In-Reply-To: <87lervcn9o.fsf@mpe.ellerman.id.au>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 11 Aug 2022 17:19:47 +1000
Message-ID: <CAOSf1CHtmSPSbW-KiL7svks2sXO4KEx9hZteHJjRvvfqcb6YoQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as EEH maintainer
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Russell Currey <ruscur@russell.cc>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 11, 2022 at 4:22 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Russell Currey <ruscur@russell.cc> writes:
> > I haven't touched EEH in a long time I don't have much knowledge of the
> > subsystem at this point either, so it's misleading to have me as a
> > maintainer.
>
> Thank you for your service.
>
> > I remain grateful to Oliver for picking up my slack over the years.
>
> Ack.
>
> But I wonder if he is still happy being listed as the only maintainer.
> Given the status is "Supported" that means "Someone is actually paid to
> look after this" - and I suspect Oracle are probably not paying him to
> do that?

I'm still happy to field questions and/or give reviews occasionally if
needed, but yeah I don't have the time, hardware, or inclination to do
any actual maintenance. IIRC Mahesh was supposed to take over
supporting EEH after I left IBM. If he's still around he should
probably be listed as a maintainer.
