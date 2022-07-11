Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773DD570C86
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 23:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiGKVNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKVN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 17:13:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662E804AE;
        Mon, 11 Jul 2022 14:13:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p22so4867367qkj.4;
        Mon, 11 Jul 2022 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5YRuTB5MYa3nbG8lCPemrZYrkhyGUXIRY7YTJn3UJI=;
        b=KkEAKuvCwlihbCqH52qxZhTQfjrKb1t9ydLos5qqmCRFzfJM35qZdJaxnqOYfVKl5J
         jnwWRee3uoiDVHlenzYQzabO9t79JtPJdqyns6M4OO9zL8/zj9VC8gmPcQIYZQfDf1Vj
         meW5ioYcgJjiu3HYWluL2B2KUIF9cVS4sJqGXnMl+8N92XshkIYBpSLbF/saTtyyW1XC
         J23Gfm1lzun4nkgvj5Ywp9iN4bQpuPd9vdu5vbMXrPANCbIg9CsCs5fJ1VPd0H2WkaNq
         s62op9zmZaDy+LT2jITTXIdjEI1Yhdi8KLMAm3QUclydCEOJlggWykdw9Lv8q2JIRLZf
         SBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5YRuTB5MYa3nbG8lCPemrZYrkhyGUXIRY7YTJn3UJI=;
        b=jPvq4/UXo/OtGcv8TCbryusroWPYSi7XMfAHq+GcgK/loYmQeCOKgRXLqUfsAYaH+w
         jteXc8ozJpnUqN46HBC/GXQKZ/qD4Ha4EsDNOVFGiI4iEHj9+k+S4sTsAcFKQJ0ACNZI
         m55jm4qKKar3N1x3/gcyESgEukf47QScV5nquRjmOp1jjDqNhryoauuU6ap+qhC5miNs
         3WuUfdcisHQb2LlKGKQ4BttE8vZO+cPbo+i3938Jsi3MbRaSuUlzixsarLfjfJ32NDjD
         m8zI3RQWTpVdp1YNSGcoVowPmIMTSGABFpfuBWKQtOEv+7M1UAg4fTx5IU8Iz2BNNXpp
         G2GQ==
X-Gm-Message-State: AJIora8WUt5CWn3VX/821TbcISD7zaeL4mdDXihsYiG9jFWqMFGDMkcf
        hGctMmPeEbox0NN2MgElBJUl7VQrY8j0FitbP38s6ZfywA4=
X-Google-Smtp-Source: AGRyM1v6iC7cQ8Eaq8NUKqwSLK7fQXPg6pPLltynOQoFb7RtxNOP0mrSa5CNksyZpDPBfzZOCT0x3SN2QzrTkfcFUPc=
X-Received: by 2002:a05:620a:2996:b0:6af:2c34:423f with SMTP id
 r22-20020a05620a299600b006af2c34423fmr12774984qkp.679.1657574006935; Mon, 11
 Jul 2022 14:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <62c8d3e8.1c69fb81.26eee.0249@mx.google.com> <20220711192229.GA678639@bhelgaas>
In-Reply-To: <20220711192229.GA678639@bhelgaas>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 23:13:16 +0200
Message-ID: <CAOX2RU6VYpsML62zCaEhdu5YPEqy8u2DVXB=5hpok5MHmXk3fw@mail.gmail.com>
Subject: Re: [PATCH] PCI: qcom: Enable clocks only after PARF_PHY setup for
 rev 2.1.0
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, 11 Jul 2022 at 21:22, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Robert since I resolved a conflict in his patch, -cc stable]
>
> On Sat, Jul 09, 2022 at 03:03:34AM +0200, Christian Marangi wrote:
> > On Fri, Jul 08, 2022 at 06:01:55PM -0500, Bjorn Helgaas wrote:
> > > On Sat, Jul 09, 2022 at 12:27:43AM +0200, Christian Marangi wrote:
> > > > We currently enable clocks BEFORE we write to PARF_PHY_CTRL reg to
> > > > enable clocks and resets. This case the driver to never set to a ready
> > > > state with the error 'Phy link never came up'.
> > > >
> > > > This in fact is caused by the phy clock getting enabled before setting
> > > > the required bits in the PARF regs.
> > > >
> > > > A workaround for this was set but with this new discovery we can drop
> > > > the workaround and use a proper solution to the problem by just enabling
> > > > the clock only AFTER the PARF_PHY_CTRL bit is set.
> > > >
> > > > This correctly setup the pcie line and makes it usable even when a
> > > > bootloader leave the pcie line to a underfined state.
> > >
> > > Is "pcie" here a signal name?  Maybe this refers to the "PCIe link"?
> >
> > no i was referring to PCIe link. Fell free to fix it if it's not a
> > problem (or if you want i can just resend)
>
> I fixed it.
>
> > Think something went wrong in the rebase as the patch fixup is reverted.
> >
> > 11946f8b6e77a6794c111aafef7772e9967d9a54 is still wrong.
> >
> > clk_bulk_prepare_enable must be after
> > writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > so in the post init.
>
> My error, sorry.  I updated it, current head:
>
>   1a88605a3efd ("dt-bindings: PCI: qcom: Fix description typo")
>
> Robert, your patch that I updated is:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom-pending&id=cdb32283bcf202d0db512abb80794056d44e7e9f
>
> It would still be nice to get an ack from one of the maintainers for
> this.

Hi,
Thanks, everybody for working on sorting this out.
I understand, hopefully, somebody can take a look at it.

BTW, happy to see IPQ60xx support made it in as IPQ807x
can use it for Gen3.

Regards,
Robert
>
> Bjorn
