Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220BB7191AB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 06:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFAETW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 00:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFAETU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 00:19:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CC123;
        Wed, 31 May 2023 21:19:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f7377c86aso44465566b.1;
        Wed, 31 May 2023 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685593157; x=1688185157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuhgxPXicpi9bptXsF+r9ZkKydiyiuwfFbVWLA6m4U8=;
        b=iEO11g7ZIdIY3ags8hV0W4asSjRwTLTe2835JA9S4LrFS89FWTZCnZ8Z/RzHxYmTYO
         zKuy9u6GTcRFjnrIz88CVavzdM5pY9/ourVw8SZdOrioCGmb9V6Id1beACXgSrnhuCG2
         H/bR27HrFvf12JTzCmFUgfkSJD2IlIZueJQC4gis8AYSmxuC9PdgQ62PkYwXdTi5Kd/H
         tsCPnOKhuOVJeJ1ZpziDSIW3Uv8BkyhZiZCbOwRhAJ1mCuNl5jBYq0XQSCupv65Q/5te
         EoKgOobhj7mE8vS0ywmZ1IrrJVjHUGwtixvPbDDBHiImyFr+h087dtUNYIDYMKXtuzCp
         DI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685593157; x=1688185157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuhgxPXicpi9bptXsF+r9ZkKydiyiuwfFbVWLA6m4U8=;
        b=XlQcxr9Y2XmnNz1LsOIRzODRocsi+oxAVpatv8z/msPbGyI7jGuWY7gONUQ5kRqIkA
         nNlVyuXifbtCnVthgKoSedaFt+gpzbV5jKzYnDDfptfXsktNqnCiRzdHNN09PuX4jG5q
         zQLmDLcS0hLYd9p25eSYAjwmDm70iaVlMdW9TaMNXBzkBskc93lWgDbCwwEO/ZqqRh6r
         c08L+SeNxJ3m5UQiT+GNF6wwWHIeLoYkc4+8oJuJP+9/rQz2jTfbbnvSi3Si8NBLwrme
         dLvvSV21KcHlV9FovrS3zUfCosZsWWMfMjfDhppzgJQzjpCD0Q+gvZEsZhQjiolW+m72
         CtmA==
X-Gm-Message-State: AC+VfDxFN8AaIzH16MOnWDTPNlQCDuN4dncl9vH7GIxGtepe0cgUPrs/
        22U64fD/fn3KNlspaflE7mDh3+F1eg29GnbUSRo=
X-Google-Smtp-Source: ACHHUZ73fa6Q0MXdWs1vW7wajfB8wzVAAd1UQPUi8QjdruZqa0vetFOff995iwrUE3N/d08WyKbjr7KSsxQoSVSAUMY=
X-Received: by 2002:a17:907:86a9:b0:961:a67:28d with SMTP id
 qa41-20020a17090786a900b009610a67028dmr7893146ejc.22.1685593156524; Wed, 31
 May 2023 21:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093623.3698134-1-chenhuacai@loongson.cn>
 <ZG4rZYBKaWrsctuH@bhelgaas> <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <20230528165738.GF2814@thinkpad> <CAAhV-H5u0ibghgwbfJT1V_oWUWi0rie0NHWTSkpCVat3_ARvKw@mail.gmail.com>
 <20230529053919.GB2856@thinkpad> <CAAhV-H6EPkGJchA4pg=zctmmt=9LboaFqKhFgQxZKNxJxQVT7g@mail.gmail.com>
 <ZHeceyZ9eUC27WcE@ziepe.ca>
In-Reply-To: <ZHeceyZ9eUC27WcE@ziepe.ca>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 1 Jun 2023 12:19:04 +0800
Message-ID: <CAAhV-H64NWn0gk6Y0gAHe+YUUuALPySgKPC1WR5faWihV_s5rQ@mail.gmail.com>
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Juxin Gao <gaojuxin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jason,

On Thu, Jun 1, 2023 at 3:14=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, May 29, 2023 at 02:52:29PM +0800, Huacai Chen wrote:
>
> > > But IMO what you are proposing seems like usecase driven and may not =
work all
> > > the time due to architecture limitation. This again proves that the e=
xisting
> > > solution is sufficient enough.
>
> > Yes, it's a usecase driven solution, so I provide a cmdline parameter
> > to let the user decide.
>
> The NIC drivers should be consuming interrupts based on the number of
> queues they are using, and that is something you can control from the
> command line, eg ethtool IIRC. Usually it defaults to the number of
> CPUs.
>
> Basically, you want to enable the user to configure the system with a
> user specified reduced number of NIC queues, and we already have way
> to do that.
Yes, ethtool is a possible way, thank you very much.

Huacai
>
> Jason
