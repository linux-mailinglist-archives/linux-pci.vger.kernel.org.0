Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1295A73CE2B
	for <lists+linux-pci@lfdr.de>; Sun, 25 Jun 2023 05:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFYDPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 23:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFYDPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 23:15:09 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882CFE70;
        Sat, 24 Jun 2023 20:15:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-39ecf336d85so1906308b6e.2;
        Sat, 24 Jun 2023 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687662908; x=1690254908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oAhMdsrYTutnkriGc4ra1y92niQ2/QlklHYuzcoSdY=;
        b=O1QRclqLPvSt+lhIiKYcARiYee8xBqXg5Qu++fqQlUXpVtCIjM/958twYkBZVtZx/V
         5ekT8+TBOPxhPP0fvy/iQ2Y3kGtGl5T0ASwyT+IOxhfBSS6W3htMvFpLDZ3LuvajhUwV
         wzA1dtAOQcuL45qTPDoBG8q6FIyJbhvJf7dZD9RMrj21EnFQ45lrm8b5NDPuuQs5u7cS
         IHEHJVMR1IDTh1N6NoBXvZKbRiI52o1U1xZKe3i/nNqf2Gm715WLhN4D0LAuv+TWkP5v
         x7znJNK2U1w14UYmEKXwOugthA3TaIsNNY8urXmHLBCAJ/2oPYI9enlLtzeyqVZejI2x
         EdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687662908; x=1690254908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oAhMdsrYTutnkriGc4ra1y92niQ2/QlklHYuzcoSdY=;
        b=AvAfMLdANO+HGkT1VjT00py7ano/vLYtYtqVcxzp4NYo8Nsi32Guo2bqMi421zSCgq
         DIb4o9Pgpr47ABqtnBeg11FffnNarcUbsNTESLUOlwVJZyTdiXJAblVeAIDnDz3/jxBs
         uvBq/kKYx4z9tPpE2+JzpzOXGH9SgP7WiixrUcg27Uy+a2Ies5O1JwtUXbjqKFnr1Nwf
         6bzdblNaLy2aSwie1M3+2GeoP9FdtNyI1Tc0vV6QBE+lajoFSdTx1L8T/dW2WZU7M7uO
         EeidAMj4zms9zBWIHQpUuFUY8NUEJC2Mr4DA291+lT4rVMeTy/+httN8ylYM2pBikMV+
         qk6Q==
X-Gm-Message-State: AC+VfDyaskkIt/GstMZukAlryqQJDNxidILFuohPHI6xY02lU9CRPosa
        saaJtdj8ddk8hGrkkQXZcNxP/htrMha1o0KBpso=
X-Google-Smtp-Source: ACHHUZ6+PufHgUFy4AlpIldcbp8YfX4+2xhdOsvB3UduEQOL5HqVNoY1ije5yGhwvSnkj2i0xB6uTxQiLhhdAdG+SCE=
X-Received: by 2002:a05:6808:1441:b0:398:3152:fc35 with SMTP id
 x1-20020a056808144100b003983152fc35mr35413813oiv.38.1687662907716; Sat, 24
 Jun 2023 20:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230420094332.1507900-1-korantwork@gmail.com> <20230624163314.GD2636347@rocinante>
In-Reply-To: <20230624163314.GD2636347@rocinante>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Sun, 25 Jun 2023 11:14:59 +0800
Message-ID: <CAEm4hYUhRCBo=N9EKUaSbBWZafKk0WzzwDWYmJ4FykpQoeZe1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: vmd: Fix two issues in VMD reported by Smatch
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     dlemoal@kernel.org, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Christoph Hellwig <hch@infradead.org>
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

On Sun, Jun 25, 2023 at 12:33=E2=80=AFAM Krzysztof Wilczy=C5=84ski <kw@linu=
x.com> wrote:
>
> [1/1] PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()
>       https://git.kernel.org/pci/pci/c/0c0206dc4f5b
>
> >   PCI: vmd: Clean up one inconsistent indenting warn reported by Smatch
>
> Even though this is a very nice clean-up, I did not take this patch at th=
is
> time, as there has been a similar patch posted in the past, and Christoph
> Hellwig suggested, as part of his review, an alternative approach worth
> considering.
>
> Have a look at the following and let me know what you think:
>
>   https://patchwork.kernel.org/project/linux-pci/patch/20221115054847.778=
29-1-jiapeng.chong@linux.alibaba.com/

I think Christoph Hellwig's suggestion is indeed better.
So, should I submit a new patch to address this issue?

Thanks=EF=BD=9E
