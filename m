Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05C56327A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiGALZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 07:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiGALZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 07:25:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE498804B0
        for <linux-pci@vger.kernel.org>; Fri,  1 Jul 2022 04:25:45 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u9so3063271oiv.12
        for <linux-pci@vger.kernel.org>; Fri, 01 Jul 2022 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oc9fPb0L9zIV1NpDh8/6a/qWUDurLbzQWr6Nau5hQcU=;
        b=HJ+BISe//llOb/mXtH9LNBfVblBDN44SRvyGDZrSnmLh6eHWOoqQNmamqxxWOXNqcZ
         mv/bNmfSRqaJbGt7+iPdNutd/5qMmq8TarDrxR4Xd7JdbOMKQIudhG1jSiIp5BPmD001
         aPt3KVBzicwP/DHMW1sE4JGbf0TWFdp7MY3rAOXDqPTQacf5qzfiNdRSYakhC3qXDNLi
         GVsDvJHAH1msCOKG9mUM3caRT/A4Cpj9bCx0riEfmyDkcNmf7E5dlM/tflWDgvOx3cKT
         aD9Y8IyYD8JS2ZpE4StzCaVtWhW73gqLbamnBO54IIaBLoyxg9r/az17amtQf8LwNexC
         9ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oc9fPb0L9zIV1NpDh8/6a/qWUDurLbzQWr6Nau5hQcU=;
        b=HmprCex29dSduZj4rLYE4I3tOLm0uP7HLJ+utrnw8Gz5LcJmhNEnCRsODnRnXoTTlp
         BynpnuvpQe9ie9Om0cNuz1Th/aEdHGMaVRf9gr1iHnD7yDISPGmfa4kprt1E5pqT6Aap
         R+LWnysnST4t7UywNTVAxxJOBS6Q4CdgIECQtf2NVvLVpfqD2vruJcX/tn4Dwe+5wCH7
         UItsX4uFhxcvITObM3I2ji4UGdN9OJMuwxh0h5wQjRme8TJKrD6b9XMvHpex9JeIhMk9
         xViPTCECakVjB8TLxcxkgvj5/FLld2Yb5/f56Plt14dbNz/FfGfdrGML8qGNaUo2C8FD
         oMeA==
X-Gm-Message-State: AJIora+O/bXu1nz5ZSqsDp9gCHU5M9bO1dIH9Rfu+zJym57vFjgkjAeT
        0g0MKPgKjiVgQEc0nX51G+jsoJmeiQlRW+qa0rhu8g8Qoz0=
X-Google-Smtp-Source: AGRyM1vH+nQNxwbQHOFAstUZnhCOEXz1GkaPKSaei28AgYp5XNV3Cu6sb1V0rzXZJmwhYmpDRRWdi60cNG0YDm7f9FQ=
X-Received: by 2002:a54:4688:0:b0:325:9a36:ecfe with SMTP id
 k8-20020a544688000000b003259a36ecfemr8453690oic.96.1656674745160; Fri, 01 Jul
 2022 04:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220621233257.GA1342369@bhelgaas> <20220627231810.GA1790539@bhelgaas>
In-Reply-To: <20220627231810.GA1790539@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 1 Jul 2022 07:25:33 -0400
Message-ID: <CANCKTBtp+ar-s8NGH_iZz8GHH-smDzXuYrf-9AO44UDBCN3W_A@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 7:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 06:32:59PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 14, 2022 at 02:59:02PM -0400, Jim Quinlan wrote:
> > > ...
> >
> > > The original patchset was and is controversial, as it is basically a
> > > square peg that does not fit nicely into a round Linux hole. It took
> > > 11 versions of following reviewers' suggestions until it was
> > > accepted.  And now it has been reverted, I am wondering if it will
> > > ever be let in ag I also see that the ain or whether I should even try.
> >
> > The original patchset [1] may have been controversial, but that's not
> > the issue here.  The only thing we need to solve here is to post the
> > four patches I reverted with a tiny change to one of them to avoid the
> > regression.  I don't think that should be a problem.
>
> I'll be on vacation until July 7 or 8.  Just a heads-up so you know
> it's not that I'm ignoring anything you may post in the meantime.

Thanks Bjorn, hopefully I will send it today.  At least for me, it's
not so easy to get the latest Linux running
on an RPi w/o running into unrelated  issues.  :-)

Jim Quinlan
Broadcom STB
>
> Bjorn
>
> > [1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
