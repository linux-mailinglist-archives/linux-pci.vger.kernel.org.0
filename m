Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE14E521E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 13:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiCWM0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWM0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 08:26:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDD78911;
        Wed, 23 Mar 2022 05:24:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so1607184edu.10;
        Wed, 23 Mar 2022 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybvrG+DLJ1GGeOkN+zfXeQEyQ3MmUm0ZRxfjfjGpyrY=;
        b=FAmlxEkHAFd+ALGKu53W5hj25A3S49r1Hr7/bpcKZb3KKmBvUU6xsYsUmaRD4QkA5o
         3dIVoweoCExrXTXBQOF075le9YdIUzGmLCCoRJoDTi7x67VrRTSJ5cfiAJSTNTF5KpOz
         6RODcauo+ROynoXNU2dq+1nmFW2vS7Kb8t+TgcPh+MIppCxH4YMbbo8zf7SoCSEbyLwN
         XOR2IoVDdNVuEV8L5geuM7yq0a4Kb4W4e9qRBmBYxqDuoiUNt4WBfkjcIKfpkzBrF9I3
         3uOPrz7V9RY/pGNtGi2jB7tXOBfOYBs90mwKZFKpTA/lmh5ht7VG701io5qUQ2SXHUbJ
         7dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybvrG+DLJ1GGeOkN+zfXeQEyQ3MmUm0ZRxfjfjGpyrY=;
        b=KTFKZnkktkPDNxN5q24fLcqXdwk9i8iMoAbJvgB2BhUUwzR6gSCH7iZ9udFcMADVon
         f5AWl+fNw/KI7ZH23VvKDmEreL+Mv4oET9qogOFMP+F1iEQErdoT+w6+GXbb5GNNqd+H
         nfi6RM76JwcRLRlPzweeIrrxcsD5odqNbTZmxhkmdU5RjAyeFsIBg37trRkoXOOZHY0u
         5nBhIJIWkydc+fdnSoMLnKgiUWF5QK4T2DVuKD1luaNTDBUnXQ/eXuZSzgpEdaULdlKR
         FEVNbher26CkmRh5rjhT+Tc07vqAcmZEer1nFjDn3XqSuv1BzQ+uRRYKiVQraJ3oFuMC
         c0aA==
X-Gm-Message-State: AOAM533ArkNe52yRo759bqZsBTMdqHTis47Lk0YGrDwLqCr5LWBlRK3E
        2gUoIfOg4pf5taJKEssSGVeMWWH9sM7zD3/Bc4ZFaNLy6zo=
X-Google-Smtp-Source: ABdhPJw/2bql1k3BpkA44GN4lwIJ2RIdWIt1wmNMHlPV/KuYdvAVhSZi6NmHzIZj8eGSaz3ISUhdob+RG7apGno2CzI=
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id
 l15-20020aa7c30f000000b0041902af4845mr31163617edq.296.1648038275404; Wed, 23
 Mar 2022 05:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfdoAbSTkO7eaor94pkmN0ttLXstc1DS_Sa7i45Dt5GAA@mail.gmail.com>
 <20220323111131.GA1272756@bhelgaas>
In-Reply-To: <20220323111131.GA1272756@bhelgaas>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Mar 2022 14:23:25 +0200
Message-ID: <CAHp75VcQV8dCxhtsRRiy-UYcVDjzn3mPe3Hx-f7JS8CTxrQKqw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Mar 23, 2022 at 1:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Mar 23, 2022 at 10:03:38AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 23, 2022 at 4:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Mar 21, 2022 at 01:34:46PM -0500, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
> > > > setting PCI_COMMAND_INTX_DISABLE,
> >
> > > > MSI doesn't work either.
> >
> > I think this is not correct.
>
> I'd like to make it correct.  What would make this better?

MSI with the quirk (not in this patch) is working and has been tested.
That said, the part that I commented on is confusing and states the
opposite. I would change the patch if you ask me how to improve it,

>  I was
> trying to say the same as your original commit log:
>
>   ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is
>   disabled.

I'm not a native speaker, maybe I was wrong in formulating that MSI
enabling needs a quirk.

-- 
With Best Regards,
Andy Shevchenko
