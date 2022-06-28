Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291055DCB8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiF1CxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbiF1CxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 22:53:06 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479BB20
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 19:53:05 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id j1so10726807vsj.12
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 19:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l76TzGjbR7Cmh3FBsRqF+2DRsoEJgjXh8VZwYtcIjEQ=;
        b=QaQY4edl5svtzkxMBhU0oiXgXX1LTN6R+0BGX5Bpj8SJaBqQMHAGe3Gd032JIauWNd
         9dnUUn9JJ3dWw7uiBXPMBvMdIUsVAdTK29wU/4muR1GJACsWruGnt02FnA+nZ9NJzob2
         k9CigYUS8YEsGEnyIaRG3Ovr06ZNRI5IfhtBpJVvekvQmhOX4mKdXQPD4yq1yuqA1Yc+
         RAlf61M5Gi78ayZ03yHtAGXaMt8M+cGvZ5r9rQZxl1GvX9IBvxq5Aq7L6JsTZeKu1KV9
         Gy+DXOvsIKkuI7OTz02KNfTEGQTN4UocWCLBUf/DOXV0rYwvZmQps5E7xgFKTDrxLjtJ
         6SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l76TzGjbR7Cmh3FBsRqF+2DRsoEJgjXh8VZwYtcIjEQ=;
        b=s8NE4fURyrhGbSMsXkGljnQ/niS7lia1sPMx8q4YRSKuenbsp8UzPpv+a7812v+uH8
         HnArlwnnfvOucwlxPeR15DhL5yui06WRGjbWGHtGBBQDfZ8Bguj9yLPoDwZ3h4LKBhz3
         qYinZ842r6ACf+8KwmtoeGzBS0dmh5Jmsp3+eZRg5bmAAuRIracLg2isZexOOhABifqT
         LcKzckYmmI+4kHA3eKXEEZgWoE7FFjj2IqaJIDXcPxvG29ik3rbjpNT1iFyBVw5Gm8Vn
         oCnGmsJqEThiuMejmydAPWb83Zk5v4B+hRxxHQKT79S12vZSf7XJ2D4hQICvgI/gm0B+
         /ZUw==
X-Gm-Message-State: AJIora+XYpG7wDSCZ4kUv4724zDcIjRkeYRBjJAqQraTCb1s8gAmyU19
        ZYZkP9j6dwoYnSOAcw3nRDx8+m/gqr20BETHgjg=
X-Google-Smtp-Source: AGRyM1tDHARbVTtPwPnZzXOFoKEgMa5hWqtKcyfKPpG3AYASfDPVloK/46zx1U2oF/6UvB6Ypo3lqlXMpul7nqCWdMs=
X-Received: by 2002:a67:6fc3:0:b0:356:18:32ba with SMTP id k186-20020a676fc3000000b00356001832bamr1012725vsc.43.1656384784985;
 Mon, 27 Jun 2022 19:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617074330.12605-2-chenhuacai@loongson.cn> <20220627215353.GA1781942@bhelgaas>
In-Reply-To: <20220627215353.GA1781942@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 28 Jun 2022 10:52:53 +0800
Message-ID: <CAAhV-H6tn0Mg_jafabYgpa5iSpG47fJQnrXzQbGVLftf4O85UA@mail.gmail.com>
Subject: Re: [PATCH V14 1/7] PCI/ACPI: Guard ARM64-specific mcfg_quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

Hi, Bjorn,

On Tue, Jun 28, 2022 at 5:53 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 17, 2022 at 03:43:24PM +0800, Huacai Chen wrote:
> > Guard ARM64-specific quirks with CONFIG_ARM64 to avoid build errors,
> > since mcfg_quirks will be shared by more than one architectures.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> pci_mcfg.o is only built when CONFIG_ACPI_MCFG=y.  Where's the patch
> that sets CONFIG_ACPI_MCFG=y for loongson?
>
> I see that "PCI: loongson: Add ACPI init support" adds the #ifdef
> CONFIG_LOONGARCH here, but AFAICS we still won't build it.
MCFG is enabled by the arch-dependent patch "LoongArch: Add PCI
controller support". That one was in the arch series for 5.19, but in
the 5.19 merge window the PCI series was still under review so it was
dropped. When this PCI series is good enough, that one will be added
to 5.20 from the arch tree, I think.

Huacai
>
> > ---
> >  drivers/acpi/pci_mcfg.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index 53cab975f612..63b98eae5e75 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -41,6 +41,8 @@ struct mcfg_fixup {
> >  static struct mcfg_fixup mcfg_quirks[] = {
> >  /*   { OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
> >
> > +#ifdef CONFIG_ARM64
> > +
> >  #define AL_ECAM(table_id, rev, seg, ops) \
> >       { "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
> >
> > @@ -169,6 +171,7 @@ static struct mcfg_fixup mcfg_quirks[] = {
> >       ALTRA_ECAM_QUIRK(1, 13),
> >       ALTRA_ECAM_QUIRK(1, 14),
> >       ALTRA_ECAM_QUIRK(1, 15),
> > +#endif /* ARM64 */
> >  };
> >
> >  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> > --
> > 2.27.0
> >
