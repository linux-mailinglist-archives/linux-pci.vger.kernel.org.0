Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19B3682BEB
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 12:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAaLyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 06:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAaLyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 06:54:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0FEE061
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 03:54:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k4so35353773eje.1
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 03:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKg7XiD4UOn+1J/0DrqwoWOq8jkJXhH0v7qpHVG9Z1Y=;
        b=moYKAEv+Ji3CNRn47vCXAm3WA7xBPtc4xctddV5pC4BgAxIPYC6plbzIlsazOnHg5w
         EhGuHCjXpyhxR5Z1hbpfK+O3wmzhaGVd8KoX8DW4n8kbRm3G/kuVyQ0yEZ0w47EFqRD+
         wt+ZtVXurzAjRt0IR5/7NrcHUAYkfodZqYM0MYvFCEoEf/rclfeDH+keNmztdXU56Z4L
         4ggDFGtay3PcQVvaLAdkBtH5qYcsj9pSTIhuCi033qMLCrxFnSDSJET4SUzDoOdwqw24
         Ev2Dapmb8AWWchRCoK2QqiRN6DI+T+B4UnlJui88V125RFnfOvuFXhK+/eVmWVxOSXCi
         210g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKg7XiD4UOn+1J/0DrqwoWOq8jkJXhH0v7qpHVG9Z1Y=;
        b=YO6SYIwa5OtQg21Jsxsq44al0GX0AEoH8d8HhxsQRlQm+rpy5iVIKAeLKDt/vEy6Ee
         epJscYHElcv7Ca6UPrve3FePPhCf6lUxtDAZH8Ma+mVDJx8cixCH2PgLCWaYNx23gZps
         Rs2wGzsWfCidBxBb61FT2dPFVllEPN1KQjRQT4RsGBVzqJcPktsA4JXT7LSXOnNKyENl
         LEYbx2fqPBlgFAXLCH9jvR9KxHE5jzZU4two2MFshVXyDqJjfvmVx/Ryw7V5cJWy1fTo
         L7IS4CRpN8cu9KwPxJ4tj35F4CphLTP/+VXSOoHYe98K3OagRNkg7rEqSyhf1XFVmZ5G
         yKAg==
X-Gm-Message-State: AO0yUKVYJnfsvp2X4aiaP0gP2gAv6mjhW2IL/OPj0GMFEuuHfFfrU9b+
        3mLTvn7E6qOh2Ca2QWCXVjX5ZsM8bDqdv29y4Bg=
X-Google-Smtp-Source: AK7set//eDvGBPK2SkOIqWLPtE7DvngU8vTGcIuRXVF/o88uHXjYwIQ9HodSQJd3PRnXXAE6kJyE4tHqZ028WxlKACM=
X-Received: by 2002:a17:906:944e:b0:887:ce5c:af67 with SMTP id
 z14-20020a170906944e00b00887ce5caf67mr2253314ejx.297.1675166082152; Tue, 31
 Jan 2023 03:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20230106095143.3158998-2-chenhuacai@loongson.cn> <20230131001601.GA1718721@bhelgaas>
In-Reply-To: <20230131001601.GA1718721@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 31 Jan 2023 19:54:31 +0800
Message-ID: <CAAhV-H6L3V8M4igCWBH=PzuDcoH0KreWkfqHexQwB2v+2TSi=A@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        HougeLangley <hougelangley1987@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        WANG Xuerui <kernel@xen0n.name>
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

Hi, Bjorn,

On Tue, Jan 31, 2023 at 8:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 05:51:42PM +0800, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > will actually set a big value in its driver. So the only possible way
> > is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> > flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> >
> > However, according to PCIe Spec, it is legal for an OS to program any
> > value for MRRS, and it is also legal for an endpoint to generate a Read
> > Request with any size up to its MRRS. As the hardware engineers say, the
> > root cause here is LS7A doesn't break up large read requests. In detail,
> > LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> > request with a size that's "too big" ("too big" means larger than the
> > PCIe ports can handle, which means 256 for some ports and 4096 for the
> > others, and of course this is a problem in the LS7A's hardware design).
>
> Can you take a look at
> https://bugzilla.kernel.org/show_bug.cgi?id=216884 ?
>
> That claims to be a regression between v6.1 and v6.2-rc2, and WANG
> Xuerui says this patch is the fix (though AFAICT the submitter has not
> verified this yet).  If so, we should reference that bug here and try
> to get this in v6.2.
Yes, this patch can fix that issue. But I don't think this is a
regression, vanila 6.1 kernel also has this problem, maybe the
reporter uses a patched 6.1 kernel.

Huacai
>
> See below.
>
> > -             if (pci_match_id(bridge_devids, bridge)) {
> > -                     if (pcie_get_readrq(dev) > 256) {
> > -                             pci_info(dev, "limiting MRRS to 256\n");
> > -                             pcie_set_readrq(dev, 256);
> > -                     }
> > -                     break;
> > -             }
>
> > +     if (bridge->no_inc_mrrs) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
>
> I think the message about limiting MRRS was useful and we should keep
> it.
>
> Bjorn
