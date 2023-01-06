Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A906604AF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjAFQnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 11:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbjAFQnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 11:43:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906577CBE3;
        Fri,  6 Jan 2023 08:42:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so2984075ede.1;
        Fri, 06 Jan 2023 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiN0D2J3+n33EKJXHj2eJSeOJuV46ibVR+Pu8QRby/c=;
        b=X0iQvwlwbonClW8x8wFl4mrLjb3Q80EZDdKE1nruwZ9rpzTwnLxLVnW8fuWvTgGXt8
         SUa04Mb4uZ+5JcNyTLF7irHSUunZluLpxpTwAeG59JdHoCjbhyCUcJHlqsUsXYdtKXtY
         7DsiFILAaa3jy4621Ul/qpiBH5JftE6kU6NDkRWJ0yJtFs45qN3SxEa9KxstsXhLDeDX
         BkOqvbOlTtYVSktAKdK6MZRULfjsDaWkQ0RZwoQVoEgjq/aUlpRi8oZctEm71+YFdCZe
         qkpkDn70afthSSg5/hSsy1fKfc682pDCRAsjNrHeWZoG19S7Z/buRoSWTW5AuWtxJn9Q
         JR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiN0D2J3+n33EKJXHj2eJSeOJuV46ibVR+Pu8QRby/c=;
        b=7ZaKleuQ8G6W3L0Uq7Xb8RsQsbTg3PbjFqoGUql7YxAG4kjDLvMGBu7bvfjUHO/fj8
         Uu7bfWDUAKz1ywSN9AlF1o0Os2AKvHcdJQ0gxXF0c41Wg2BwKOOcbKcGqcs4PHvpvRvX
         8IyQeTxSJJbjM7YGRrhbTZNgOqsw8bNxWaFr2/A8TA85Xd665GgJssS73ZC5AVvnh1Df
         oGwg9sghve/lbLZTdCMUzhPCGUDKv5j0xizbBO1GgeaD8app2TyEaVFIf6M+i4abUOxi
         RnJM/vGwWV4fXKvRTV/+ZjTH2V7pvK7Uvqgs17wvXfjT1duygLUWaaMjIGYz/9XLyrlT
         j/qQ==
X-Gm-Message-State: AFqh2kqvxyLxIpYjpdb01JAT2tlZ7SWCKbOiGwgyksd8sptGwPdmNtRq
        PnQPVluKKgp+FiQd9syIxeLvyuewWaqPhfqoo5w=
X-Google-Smtp-Source: AMrXdXs014uw2ZoXuMBkSyIw3dJCJDWEW0sIPi5WSRgiH0ctOXC2g/CVUU0Iuj95o7opBERdqnSdKBtVDcQAedwf2UU=
X-Received: by 2002:aa7:d915:0:b0:493:2a50:5f23 with SMTP id
 a21-20020aa7d915000000b004932a505f23mr437812edr.235.1673023366000; Fri, 06
 Jan 2023 08:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20221228184234.GA530399@bhelgaas> <20221230185006.GA695815@bhelgaas>
In-Reply-To: <20221230185006.GA695815@bhelgaas>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Fri, 6 Jan 2023 17:42:33 +0100
Message-ID: <CAOkhzLW+1z58681zBV7LT=Lw=tcT9EgVPEbKx8YGsa+EJyxUSw@mail.gmail.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Moreira-Guedes <brunodout.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Bjorn

Happy New Year!

On Fri, Dec 30, 2022 at 7:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Bruno, to include you here as well as the bugzilla]
>
> On Wed, Dec 28, 2022 at 12:42:34PM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 28, 2022 at 06:42:38PM +0100, Zeno Davatz wrote:
> > > On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > >
> > > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > > >     Kernel Version: 6.1-rc1
> > > > > ...
> > > >
> > > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > > see attachments.
> > > > >
> > > > > The enumeration works fine with Kernel 6.0 and below.
> > > > >
> > > > > Same problem still exists with v6.1. and v6.2.-rc1
> > > >
> > > > Thank you very much for your report, Zeno!
> > > >
> > > > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > > > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > > > when it hangs?
> > >
> > > I will try this after Januar 7th 2023.

I updated the issue:

https://bugzilla.kernel.org/show_bug.cgi?id=216859

I booted with the option: "ignore_loglevel initcall_debug"

Best
Zeno
