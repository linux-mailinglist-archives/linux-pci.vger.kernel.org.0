Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5057C8DC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiGUKYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiGUKYb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 06:24:31 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D433A2D;
        Thu, 21 Jul 2022 03:24:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r82so1380092oig.2;
        Thu, 21 Jul 2022 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Fka9jwLePc5YiuWeZtNK5hjaT9116Uqlu7bRQZ5p4A=;
        b=g6oC+VPZbzx7/RSne7j4MJXoc8J2/53hKOY3boJhDxw7Y7TB0oTWGrfzpt3oDchrt2
         tUvykhFimBoq35dsIuzLTUmzSOf23BAFPmvfNEldYD1p+7JyYV0YVEy8eEwiSNeCAChb
         I4bE2sApIwttSk+k6JEEqmQ6fD4rEUYoPbq2DdyMBeHbCu4D75ibqQp0QP+/TLOnebsW
         1k1ccFARLlr6TW0tiYrG7+zhIA87U/bkQXk8kZPv1+1TcjbtC4PT+gCo0xVmesqq/2MC
         a3UZqg9daz6nG+KE/UFalJHOOVtHNCTm6ukauEaYB7mmj70In/yJgRuEcR1lXchdkAYe
         EDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Fka9jwLePc5YiuWeZtNK5hjaT9116Uqlu7bRQZ5p4A=;
        b=TVQN6QFFhGy9S7JP/0ohs1N3K7ahwpgrK7Iur0YtveVfWaxTJFG42X+7234A0MyZzh
         gK5GEFGEKPvXtO3xJ36SJ0m5w8JQSBBgXxPq8PCs+l2cp5H/m4jZ227cQpNFxmIac9wO
         SrjRgjSH/TnSJ8q7cBjcgFZh2umjD8N6O2GVMEJcugFxrJPp+V0mRamHDbcEp+J/8MWg
         x58V9ghoY17iBcfF/zu5BpBoaVXx3Kh9pC3ZAgn+LJDm53+npwHskNpwA/WnY1Eprxba
         m0zWTJXs8k8ipTbGuyYfyvZPqXMmYVvMIAatQRJ2M4Bsx0ZcZeVHvrdurE3FNXEPpoyN
         kAYQ==
X-Gm-Message-State: AJIora+KiZlsJVguyJpO6nN3ng5fn6H7rHPXjHCFPyJYynmIV2YLUQzf
        9U0n+zGjLxW3KMRkCLqU3bnfyBV7oNwkAJGpQoWRTFd+D+Y=
X-Google-Smtp-Source: AGRyM1vokUUtFkbfIhasEIGhtcU202BAikU1mIKL0ZxcV4cZLJAZjMvcye39Bcp3IuX/TTwwNfAEx2IOSrkCCv011a4=
X-Received: by 2002:a05:6808:1484:b0:33a:7c5b:69b with SMTP id
 e4-20020a056808148400b0033a7c5b069bmr4268333oiw.45.1658399069588; Thu, 21 Jul
 2022 03:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8VuX6NrqyKQU1KS3DdTzZRQTdPK+nF0-eXXeQqhHyOypw@mail.gmail.com>
 <20220713181805.GA841376@bhelgaas>
In-Reply-To: <20220713181805.GA841376@bhelgaas>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Thu, 21 Jul 2022 15:54:17 +0530
Message-ID: <CAHP4M8X67WSLMqe2qQrbODrg5oSLvR5fP4JVN+zeQafHizrOXA@mail.gmail.com>
Subject: Re: No controller seen in /sys/kernel/config/pci_ep/controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Any pointers please?

Thanks and Regards,
Ajay

On Wed, Jul 13, 2022 at 11:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to Kishon, endpoint maintainer, +cc LKML]
>
> On Wed, Jul 13, 2022 at 12:53:06PM +0530, Ajay Garg wrote:
> > Hello everyone.
> >
> > The kernel has been built with :
> >
> > ###################################
> > CONFIG_PCI_ENDPOINT=y
> > CONFIG_PCI_ENDPOINT_CONFIGFS=y
> > CONFIG_PCI_EPF_TEST=y
> > CONFIG_PCI_ENDPOINT_TEST=y
> > ###################################
> >
> >
> > Thereafter, following are seen :
> >
> > ###################################
> > $ sudo mount none /sys/kernel/config/ -t configfs
> > mount: /sys/kernel/config: none already mounted or mount point busy.
> >
> > $ ls -lrth /sys/class/pci_epc/
> > total 0
> >
> > $ ls -lrth /sys/kernel/config
> > total 0
> > drwxr-xr-x 4 root root 0 Jul 13 10:58 pci_ep
> > drwxr-xr-x 2 root root 0 Jul 13 10:58 usb_gadget
> >
> > $ ls -lrth /sys/kernel/config/pci_ep/functions
> > total 0
> > drwxr-xr-x 2 root root 0 Jul 13 10:58 pci_epf_test
> >
> > $ ls -lrth /sys/kernel/config/pci_ep/controllers
> > total 0
> >
> > $
> > ###################################
> >
> > What is being missed?
> >
> > Side Queries : Is the controller that is expected to be listed, a
> > virtual-controller (like the one provided by CONFIG_USB_DUMMY_HCD in
> > case of USB)?
> >
> > Or there must be a real additional controller for pci-endpoint purpose?
> > If yes, then :
> >
> >               * I guess no listing is expected currently, as my machine has just
> >                 one controller (as pci-host).
> >
> >               * Is there a way to have an additional virtual pci-controller?
> >
> >
> > Thanks and Regards,
> > Ajay
