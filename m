Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3C4E492F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 23:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiCVWbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 18:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiCVWbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 18:31:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DD56217;
        Tue, 22 Mar 2022 15:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8894BB81DB0;
        Tue, 22 Mar 2022 22:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526BFC36AEB;
        Tue, 22 Mar 2022 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647988208;
        bh=1xp59LakivQr8qYhK93ow2Bhnx4gVovHXBGgoY2qJ2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a4RBZU1g9zzRr3Iw91QCNpYSAaLbsWBtlh4N09aVqMQ8tJ40vNLR6MX+cfVEVacaF
         Hx7Zn+0/1pO84ykEH1AI/MfNuK0KF/L4BuQUf2LMhsKnEAAVf7mLs1jYdLP9QNNO5a
         CdCSPsMZt8LE80+GG3N8AL3LltsXnA4CaM8p8no2WQBvIWySmphmfJyH4WqulLrgzI
         JWOtJP4Eh7evqgkxr/LvG8guyZ9hsGAu4YYrKH6RQ9S7W5i4nqfO93QyF6XB2sPRfE
         xKsENTBntN28N8VcgwX8bZ4iv1ZerAHHK0Vm8oB5fLR+Rp+tpnoI8ouIX2iZU5dmhI
         9WyBFC/ak6TpQ==
Received: by mail-yb1-f174.google.com with SMTP id y142so36206416ybe.11;
        Tue, 22 Mar 2022 15:30:08 -0700 (PDT)
X-Gm-Message-State: AOAM530qbUMB+pGF4uV9mBfgc09qEht+wYCJceS0qMUUAWy0K9FPkxmY
        ZQqmr2s4bDbTJHzHV2liEjQ9GPmGJSBmUVlUolc=
X-Google-Smtp-Source: ABdhPJzIxQ3m0CaoAJe6x6huzgJSxrdG4FvJVcMjmlD4RpEznP9MKKypVJ2tD0kxm0/2TDBXbRpijcxvN1nvfab4a5E=
X-Received: by 2002:a25:af8e:0:b0:622:c778:c0a2 with SMTP id
 g14-20020a25af8e000000b00622c778c0a2mr30433977ybh.50.1647988207369; Tue, 22
 Mar 2022 15:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220321104843.949645-1-maz@kernel.org> <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <87h77rxnyl.wl-maz@kernel.org> <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
In-Reply-To: <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Mar 2022 23:29:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJ_DNu8CKuPNkbt4NCSm5hjUbx7nj6BBS6e8jm+jQMrw@mail.gmail.com>
Message-ID: <CAMj1kXHJ_DNu8CKuPNkbt4NCSm5hjUbx7nj6BBS6e8jm+jQMrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        dann frazier <dann.frazier@canonical.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Mar 2022 at 19:04, Rob Herring <robh@kernel.org> wrote:
>
...
>
> Do the DT's in the kernel tree correspond to anything anyone is using?
> I ask because at some point someone will need to address all the
> warnings they have or we should drop the dts files if they aren't
> close to reality. The same thing applies to Seattle BTW.
>

I sent these a while ago to sync the Seattle kernel DT with the
version that is in the Tianocore tree, and is built into the open
version of the Seattle firmware

https://lore.kernel.org/all/20191203152306.7839-1-ardb@kernel.org/

I wouldn't mind dropping them entirely, btw.
