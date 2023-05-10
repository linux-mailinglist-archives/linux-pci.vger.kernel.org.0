Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B86FDCCE
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjEJLfz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbjEJLfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 07:35:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A476173D;
        Wed, 10 May 2023 04:35:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso28677235e9.1;
        Wed, 10 May 2023 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683718546; x=1686310546;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvApClf6Vwq7pYYq456swXVsLdXe4Yk/kHkfI1zIbf0=;
        b=A7JK7Aa8+cE+lTIOQPBBguTGx4LVhzygAywBRaxRWDXJpKHRJStUaUY0rPCDStOCSq
         GBOwjR+1YuWTe1dVqZQcobgsVkrlYymiSSrIgo+y0ASEPz75m0AzfCcw0fQzFPjjjYS7
         d6bzOGfAsvxNKXSfg0xZdsHy5GLoUdan879eDcH7YNC+L+C7ZB2Q+noqlVV1W1Pk56KR
         7bEuYPaKJmyf9WpoT0p220LaMblPNU6x98SZYeR65vem9VFLS+ZxqbhOETZtq+tXPA5r
         PVytCKL5HNhUazNOxTgiBgva7e24kHjSXwKigglEJI+dTeP4GBSTvCjnBOWyCxdAaAqP
         0bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683718546; x=1686310546;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvApClf6Vwq7pYYq456swXVsLdXe4Yk/kHkfI1zIbf0=;
        b=Q8Fi6pjE1JQgGsYixguCQow2hYw3XPspzSk/WbnLT3LihHNjuVT6HzvksKmiz0qYbb
         2Hc9DwaYfZehq5EgLQASNzsbaPk3SovUBwIjjIA2GRQBSPil3PvYQgbU3CppSLMxIUUa
         2HLn5hRHk3VrwUPkrRyg458kTLfhGbZTldeq4TCUyqTa998QnJRyhoEPtO9rsODz+egf
         3MOxW0t46z4lmsoox+os73uylfA8eKr/VQcavHPX3NmCnYTPxuNb2VWbLOsokVggWYve
         7K08BDyC81V/G5rfuo4vOJhGnU6bz8imQev0YuLX0ftaFr92Scrs3YMRvI0CcObDg1ca
         27og==
X-Gm-Message-State: AC+VfDzleigypY4qzTaWzLNdvxG7hNVvIaycZoW9DUZwZOSm9upXLNyc
        7tH/b2E1RRBbqzHrbQnGL9s=
X-Google-Smtp-Source: ACHHUZ7wo+6G+OTP/f1njXi4NgMQmaiEiKJ9+AcmhQdxQJiCG8NzXngE14HdSos3iGEqNEoox2RfcQ==
X-Received: by 2002:a05:600c:2298:b0:3f4:2bce:eeff with SMTP id 24-20020a05600c229800b003f42bceeeffmr3624831wmf.25.1683718545727;
        Wed, 10 May 2023 04:35:45 -0700 (PDT)
Received: from localhost ([146.70.133.78])
        by smtp.gmail.com with ESMTPSA id y10-20020a7bcd8a000000b003f16fc33fbesm22321946wmj.17.2023.05.10.04.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 04:35:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 10 May 2023 13:35:43 +0200
Message-Id: <CSIKESNNLX5D.4VDA3E6NBN3N@vincent-arch>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <robh@kernel.org>, <heiko@sntech.de>,
        <kw@linux.com>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>
X-Mailer: aerc 0.15.1
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
 <20230509211902.GA1270901@bhelgaas>
In-Reply-To: <20230509211902.GA1270901@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Hi Vincenzo,

Hi :)

> Thanks for raising this issue.  Let's see what we can do to address
> it.

Yeah, as I said in my cover letter, I am not happy with my solution,
but we should start somewhere to discuss it.

> > Add a configurable delay to the Rockchip PCIe driver to address
> > crashes that occur on some old devices, such as the Pine64 RockPro64.
> >=20
> > This issue is affecting the ARM community, but there is no
> > upstream solution for it yet.
>
> It sounds like this happens with several endpoints, right?  And I
> assume the endpoints work fine in other non-Rockchip systems?  If
> that's the case, my guess is the problem is with the Rockchip host
> controller and how it's initialized, not with the endpoints.


Yeah, the crash is only reproducible with the Rockchip system, or better,=
=20
the crash is reproducible only in some modern devices that use the old=20
Rockchip driver mentioned in this patch.

> The only delays and timeouts I see in the driver now are in
> rockchip_pcie_host_init_port(), where it waits for link training to
> complete.  I assume the link training did completely successfully
> since you don't mention either a gen1 or gen2 timeout (although the
> gen2 message is a dev_dbg() that normally wouldn't go to the console).
>
> I don't know that the spec contains a retrain timeout value.  Several
> other drivers use 1 second, while rockchip uses 500ms (for example,
> see LINK_RETRAIN_TIMEOUT and LINK_UP_TIMEOUT).
>
> I think we need to understand the issue better before adding a DT
> property and a module parameter.  Those are hard for users to deal
> with.  If we can figure out a value that works for everybody, it would
> be better to just hard-code it in the driver and use that all the
> time.

Yeah, I see, I see. This makes sense. Is there any path that I can follow i=
n=20
order to better understand what's going on at the hardware level? In other=
=20
words, how can I help to understand this issue better and provide a
unique solution for everybody?

Thanks for the nits in the patch, I will take a look with a fresh mind
later in the day.

Cheers!

Vincent.
