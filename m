Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57F6D3DE3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 09:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDCHNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 03:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDCHNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 03:13:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38C527A;
        Mon,  3 Apr 2023 00:13:06 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id k14-20020a9d700e000000b0069faa923e7eso15095985otj.10;
        Mon, 03 Apr 2023 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680505985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMcetHB9pKaKjInDp3NitSfpRNsMYptGuZlPIeoW4f8=;
        b=U0ff180486/xeXNhJphbGwtfS6hZz5jep8XMcCYs5K9mCo06lWbhYGkgCanfpzfXBv
         13VYZGu/qgH0AOATH5si+BkXZlOBNFqB0+AoQ+zoAEkXq3gIsSjDhQpkNlJzGrIXApFr
         stbMeBqXlyewqJFHPVeR7F8fjl1FTKSQttu3mSUG6w7vT2GPrIs5dFjtHZnXjoH10G01
         Fh7lNT2153v1FNTxlwAnONCYOK57oiN17hmrGuUs+s/piBH2BHpvpQm2vDH3Qf6xHRwJ
         F+ET5ksAUswrsSIWkQU96cjbKDEjp8Dnv4SrXlrDcFDnxKz37cCYm0T/IUiEWWaYMlOP
         9cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680505985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMcetHB9pKaKjInDp3NitSfpRNsMYptGuZlPIeoW4f8=;
        b=lwqhHOVmj/4Z804jvV52ENvFgaak4/0UKGM8b+R8UN6AqYn0Tt9h0V2DF2lYHqu9pw
         sGlNnf8L5L1sVRSy3twMSHhVs+08vf8ZTrPiaRBvHp/pPQHap9iHnR5mibFjHTu/ZIa9
         MNi37RchyUfzK5Hqx/ltw9A2bXIxazYyxlChIyCI2NxRll15wu6A4w6BefGGGuwBy98W
         9pM8HWLf9XoqayzxfiyJxu6UiO760lNgG9e518mtrjzoMVz/JNDOgjCzJQ8GKRur+cIG
         XUTbZZbtmdlZShxd4hdTRvS/vfJPbEWSQAOnxvZXYMJFay/UnUPRluMXS3fi3ZGzOB0U
         5ecw==
X-Gm-Message-State: AO0yUKW1ueJRa6IfpcdL4JAnh7bmMqVTzAsl8dWWhVUqtKfNrWyjt5qd
        xGgu6zuEgfwGxd6xK3iNZeOj8t3RutlXcD1XAo4=
X-Google-Smtp-Source: AK7set9Z4atpGQ9Kueh0VT32eavgpOiqvMFER0Up82yH5croxGA4rfWlDf/WSwdQ6qw4jEi1aUAM1UuKL7OZ8lMeFL4=
X-Received: by 2002:a05:6830:2:b0:69e:24a7:e042 with SMTP id
 c2-20020a056830000200b0069e24a7e042mr10954719otp.3.1680505985269; Mon, 03 Apr
 2023 00:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <202303231145121987818@zte.com.cn> <22081108-565d-4608-97f7-6e40ca3df2b6@kili.mountain>
 <CAMhs-H9m=ZGREMo_upE3M48sQb-WpU3j2_b2xLyO2mDkezxC9g@mail.gmail.com> <4cfaa4eb-24ff-4129-b549-bd5a66352e9b@kili.mountain>
In-Reply-To: <4cfaa4eb-24ff-4129-b549-bd5a66352e9b@kili.mountain>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 3 Apr 2023 09:12:53 +0200
Message-ID: <CAMhs-H_TFe4brv2wrZgMGqB60SEsqCieExHXa5vyuugHatz1yA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, ye.xingchen@zte.com.cn, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 3, 2023 at 8:11=E2=80=AFAM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> On Mon, Apr 03, 2023 at 07:05:56AM +0200, Sergio Paracuellos wrote:
> > On Mon, Apr 3, 2023 at 6:41=E2=80=AFAM Dan Carpenter <error27@gmail.com=
> wrote:
> > >
> > > Hi,
> > >
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zt=
e-com-cn/PCI-mt7621-Use-dev_err_probe/20230323-114623
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git n=
ext
> > > patch link:    https://lore.kernel.org/r/202303231145121987818%40zte.=
com.cn
> >
> > So, I already replied to this proposed patch clearly saying that this
> > makes the rest of the code unreachable, so it is a clear NAK.
> > Why is this applied to the intel-lab-lkp tree? Just to be able to test
> > the changes?
> >
>
> These emails are automatically generated by kbuild-bot.  I don't know
> how kbuild-bot internals work.  I just review some of the Smatch related
> warnings and hit forward or ignore them.
>
> Normally, I don't look at the context outside of the email but to be
> honest, I was curious enough about this one that I looked it up on the
> list.  I knew it was NAKed but I set the email anyway hoping that maybe
> people would see the extra Smatch warning and be encouraged to run
> Smatch on their code in the future to avoid potential embarrassment.

I see :). Thanks for the explanation, Dan.

Best regards,
    Sergio Paracuellos
>
> regards,
> dan carpenter
>
>
