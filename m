Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F332658556
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiL1Rmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 12:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiL1Rmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 12:42:53 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A917E39;
        Wed, 28 Dec 2022 09:42:51 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so39841136ejc.4;
        Wed, 28 Dec 2022 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5v418/RqvkpNZ++w5B98+hFT1RmkV5yOmXv1CrbY9U8=;
        b=lRHQnzhxxZ8ABapPOPdXLPWuQgv9jCoGxjNR43SjwGKChyISKEhqODYyEfJkvsr9Lf
         xb+rrVNbd3qNBfY5t1xuE8ctffqPyn1zNvx+5P7EUq/PJheDu9/k+FGEwW2QHeiG7RUV
         IBfvs1l6fqn8skthjB05O4mbz23gm5Sj+cwfgN4wZsSQCW1VO5rdxQAWvSLOQNZp16DB
         LKXCecvQtk7QCyC9K1G0Ig9UFUJAk3X1kjBdKdxiy9Uk9SVCQK+IS3HAtbclOWbltbqr
         LTg9eV6fpNuOxVe5TmKrDU/gapZLOKBMbd8q1x2sQnYKknApC5VglYnKSxkTRjM5HcoR
         zOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v418/RqvkpNZ++w5B98+hFT1RmkV5yOmXv1CrbY9U8=;
        b=b/6L4kklp9kj0QENsccO3Zmc8LTyOJ2KHStRhNxhtOQM/PKdU8qC2EPPzxvTnyxNNB
         zb2w8ZGa342mO8o2IKp7tHJ7/IthSfjPKMrmosB4OYd7m86SDICs2WFs29CH1SBqQOLj
         lbv7AdErCO16L23l2v0jyoaBtWTbtuC7SnPneXIvOfG7PKhhCJ4M8D0zgn39Dkjz32WJ
         2mh7vc9kPoDBVVqQysoeq/6wlQo35JJcJjos24onPvLJlFqNZCfxTsI8qKIA+gbjxELz
         7wVWbbahZjzMOd5TOWLg1Uhasw+HJxiTkN0u5R4iFHXW7DQLM3qncSv3cOBbgiL43k3q
         lv8A==
X-Gm-Message-State: AFqh2kpSBfnHjDc0UF1bKzyvj+YKI57/33gj6aZX0cL9GJfNgh/PEpRo
        EhgvJstLn4kFLu2Sc3GiKXpHY9DRJi7OtHs7+7tfmbyolt9TcA==
X-Google-Smtp-Source: AMrXdXsfpHFwHTtXDtk6Zi3pxiU7Z1Y0D1JUO7lDa6kc5k8/ip5ln3heDNzWDpQiDfzJJOxP2acBQSP24HIiCV7oPTU=
X-Received: by 2002:a17:906:4f12:b0:77f:9082:73c7 with SMTP id
 t18-20020a1709064f1200b0077f908273c7mr1395724eju.517.1672249369642; Wed, 28
 Dec 2022 09:42:49 -0800 (PST)
MIME-Version: 1.0
References: <bug-216859-41252@https.bugzilla.kernel.org/> <20221228120248.GA508080@bhelgaas>
In-Reply-To: <20221228120248.GA508080@bhelgaas>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Wed, 28 Dec 2022 18:42:38 +0100
Message-ID: <CAOkhzLXr_+oydSFVm+LdwzCU+qZ_A=m4dcV+r=Uf-OjQnNdJqA@mail.gmail.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc linux-pci, linux-kernel]
>
> On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216859
>
> >            Summary: PCI bridge to bus boot hang at enumeration
> >     Kernel Version: 6.1-rc1
> > ...
>
> > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > see attachments.
> >
> > The enumeration works fine with Kernel 6.0 and below.
> >
> > Same problem still exists with v6.1. and v6.2.-rc1
>
> Thank you very much for your report, Zeno!
>
> v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> when it hangs?

I will try this after Januar 7th 2023.

> How did you conclude that the hang is related to a PCI bridge?  I see
> recent PCI messages in the photo, but it looks like the last message
> is from NFS, so I'm wondering if I'm missing some context.  The v6.0
> dmesg shows several other ntfs, fuse, JFS, etc messages before more
> PCI-related things.  Anyway, the "initcall_debug" might help us narrow
> it down a bit.

I did not really conclude that. I just saw "PCI" as one of the last
messages being outputted before the boot process stopped.

Best
Zeno
