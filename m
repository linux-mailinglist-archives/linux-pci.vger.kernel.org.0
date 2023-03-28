Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7EE6CB925
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjC1IQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1IQ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 04:16:26 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB5CE;
        Tue, 28 Mar 2023 01:16:24 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-17aceccdcf6so11909656fac.9;
        Tue, 28 Mar 2023 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679991383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87X9ZkFCz+nWjHFUU9neYnPepxiKhU+4s5IIENKefkE=;
        b=XqRXTLIDH+d8jGkWT+UamzN9mK9cyMS+sVeejaEs9FzwUhBVu+ha5MVBx6FUBUR5ho
         3+boQZBZnkYE6nuC8VKWyy8PEKObtEXRpzcZfmu699D1jpg8BBBjwljUvx7uLQymSeXT
         L4J/t5cawjoUMpSpSn0NtwVzTjrLMsKc932Hoa4wvEc0GTyQiGKbiechZjYMTa6qjgIS
         PHQ9jULwV20nqDPaO3PaZkXawiVm+N4IH3ZUvnCCVJdcMtdYmxGjw/1qeELSVmRMi3hg
         EmL3GJPdT2fR6LnE1sAusVO0XX6LQt6kQwlRnTMacyIr0H+/YiXNIK8U7/lZ4UVjamXU
         LmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679991383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87X9ZkFCz+nWjHFUU9neYnPepxiKhU+4s5IIENKefkE=;
        b=uWUI5BqnZwFOKV4KulFl+yAdkV+uVhEnJzV4ZcQSxdM1F56pN+KTmd2CEmhtCd/kka
         BB6TxsSreW+6IDU+WydSummUNZZk3vE7wkAdbghrSotcJPvlRT9Xb+sRBb3Uwesj3OY+
         0FSGLgM5+U9RIrT2NkVUY7bC/raoX7e9zLN+oIotUbUbu9fd31QNYw+f5sxVX4Gg1t3i
         SIbSTXiYmZGPZlTPLrC62nSFI9spUfOo8XubWyxov/BP1mPGAHaCDfkcr7NDhzZ6kV8x
         LY/7B4kt0bNeZSyGR92Co7bYjRK6hX+TMw2h6PvwICIx2O0mNOceCu+yFrsKfLAWnmxO
         aLOA==
X-Gm-Message-State: AAQBX9dnttftFnxAFtcUXomjUboqPA7YKJ2rT0OSEhjXG9yqVJmVGUQq
        opy2TA30v9COPa4G3h3Jsx8qqmrznbVcY4GdBfB2+kaG
X-Google-Smtp-Source: AKy350agJJy6E4uLTGCdxNgAVH3OycAPy3Npuh1oYI5LummV384k4rQJ8pcuav3gMk0R90u5lCioT+RKEUls8oTmGgU=
X-Received: by 2002:a05:6871:8a93:b0:17e:8a64:3dab with SMTP id
 tm19-20020a0568718a9300b0017e8a643dabmr4886341oab.0.1679991383532; Tue, 28
 Mar 2023 01:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230324073733.1596231-1-sergio.paracuellos@gmail.com> <167967244960.22956.2019560168018857203.b4-ty@kernel.org>
In-Reply-To: <167967244960.22956.2019560168018857203.b4-ty@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 28 Mar 2023 10:16:11 +0200
Message-ID: <CAMhs-H_MtWqQb_Vmi0=artXc3bRYZFzezjkiFu_Hb+Uo0KyXwA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Use dev_info for PCIe no card plugged on
 port trace
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        matthias.bgg@gmail.com, kw@linux.com, linux-kernel@vger.kernel.org
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

On Fri, Mar 24, 2023 at 4:41=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Fri, 24 Mar 2023 08:37:33 +0100, Sergio Paracuellos wrote:
> > When there is no card plugged on PCIe port a trace that says the port w=
ill
> > be disabled appears. This is expected behaviour but currently is using
> > 'dev_err' for doing that. Since this is not an error at all, change the
> > trace to use 'dev_info' instead.
> >
> >
>
> Applied to controller/mt7621, thanks!
>
> [1/1] PCI: mt7621: Use dev_info for PCIe no card plugged on port trace
>       https://git.kernel.org/pci/pci/c/50233e105a03
>
> Thanks,
> Lorenzo

Thanks, Lorenzo!

Best regards,
    Sergio Paracuellos
