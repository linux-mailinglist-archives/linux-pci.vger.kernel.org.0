Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4E654D26
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 09:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiLWICg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 03:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiLWICU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 03:02:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37132BBC;
        Fri, 23 Dec 2022 00:02:15 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so4309513pjm.2;
        Fri, 23 Dec 2022 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8Ls5/kQVunWm/uNe5oSA/n8SDtFGQLttrFEz9WUHqE=;
        b=UnIP20Owvbq5rIM5Y6e7Y/Vq5IWPNGxKJ6ZFs5+elEOg+RUelSQgr8J7HfvHHAYfnV
         6JkG31C4YSMIjZkUCULq8BJGYgP2/gMmc3NQIkCIS4t7ley10zSkOlecrTYFPIgubIdZ
         Eksi+4Ic7eeaj2qY8rxIn3IN5ezFeHIlI73oUtNoQd1WI7CaJiW7R8t4vqYiLIWRuLwP
         TXxYW1N4CUhKwg4Y925ugcaUPPkHI+reaodRGr4wtg8VGWOGdGS8aF2AoOfUq56zQhAc
         wfWDwP+aqjMufscJHlza0S5HVbBtJps5SguIFAuNDZUcoKGF9+NPBrt2MVVd3BAZJl7j
         nwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8Ls5/kQVunWm/uNe5oSA/n8SDtFGQLttrFEz9WUHqE=;
        b=GYurQbLcjC8+2cMQKCi0yUZtx7aaT5g+r/8u+/FDhDfLfZQKq9riNds6P1/xLdVXbm
         Pnt9ynKqEigybnD0jK4iZorYiyhoBO5+L6oYZ6kD5sTAqUlS+H9us4wpoR4iA09VB2eQ
         cqGg/gArcE6YLHz3keLx9c5hIVIjxdE8mg5q4YBobQr1EVqN6IQ0gTLJSOmci1kdsDzR
         bSQiQDGk92e9FyZrOTDFoy8a4BYbgQ6Oz0RZI8rf7A+E/3bNZ7+33EWds30rCxYxa4JZ
         OYTO+aC6lRXnyDreJJs82wambgv9lVsaeweSRMf4TlfR226Res5MRaalg56VvlHNqu0r
         CL9Q==
X-Gm-Message-State: AFqh2komDrN6HxyrBIM/lWBWNiEOE25zTsR21yNWQ9Cp0NRjzDwTxl8H
        1wcDxcs/DegCz1WuXBV7ra1J0hOKq+hfSzD4Qk4=
X-Google-Smtp-Source: AMrXdXtJkBLCmWP2QQzYoUOSUOK/0gC+hRiSsrUJTLsZXEjBr6jKWnocHZpHYMgmFICLj9OGr0jRmC/i8ia9AgTlXBg=
X-Received: by 2002:a17:902:ba93:b0:188:ca57:8945 with SMTP id
 k19-20020a170902ba9300b00188ca578945mr414950pls.116.1671782534859; Fri, 23
 Dec 2022 00:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev> <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Fri, 23 Dec 2022 16:02:03 +0800
Message-ID: <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        nirmal.patel@linux.intel.com, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Keith Busch <kbusch@kernel.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 05:56=E5=86=99=E9=81=93=EF=BC=9A
>
> With 12 drives and only 6 CPUs, the bypass mode is going to get more irq
> context switching. Sounds like the non-bypass mode is aggregating and
> spreading interrupts across the cores better, but there's probably some
> cpu:drive count tipping point where performance favors the other way.

We found that tunning the interrupt aggregation can also bring the
drive performance back to normal.

> The fio jobs could also probably set their cpus_allowed differently to
> get better performance in the bypass mode.

We used the cpus_allowed in FIO to fix 12 dirves in 6 different CPU.

By the way, sorry for emailing twice, the last one had the format problem.
