Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F574A38B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFSEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGFSEb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 14:04:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762DA199F
        for <linux-pci@vger.kernel.org>; Thu,  6 Jul 2023 11:04:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bacf685150cso1080483276.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Jul 2023 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688666669; x=1691258669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03zWiNhc9KZR5mojhUw0OzSctNW+ygol8R6PJI8fFSA=;
        b=LPWrPnWBjnVZuB8ZKEDFEFAgd7NSY/Xg9NV0TC7+p7q9g+rn38PDdoN7zeor36BAXq
         RGLkzu9NalkerfqTje8drzJjdLWo73gcapkFCuyfPW/gV8z+jytqPCwsfTB3lwL4cK7G
         HCPHGopuwww0WaDqr7N7NJj57fdP2igJt9url2wmIUB8/HobU8CYOoIm4q8Z2ya2MJwZ
         6SjI/3v16m2VflK4CQrt0YinzL7D3FWMQBmvH849chZtrZ9AkqEqnlUIAhGSoXhNyZo4
         cL9nebS1uZ99eTEX3hBc1LMCKb5MVRmPW6nuacHb75u0kWT7OooFM7BCuR6tmJjwibNZ
         7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666669; x=1691258669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03zWiNhc9KZR5mojhUw0OzSctNW+ygol8R6PJI8fFSA=;
        b=lLgh8dudyjCZMS7RRCEuURmN1/cxZ1aQE1zj85NPVz7I/UNQv8KpS+Peg0w3AkjUGn
         q49ro3k5y4GK0timpsbBCYPDkYvEfCqw0dTlXqvALHf/TrIervv13jAKLL72YPa1ODsn
         XBg+Q9t0FzIjrnfN7XPDv9YEteaTwAPJCAnJq+4amA7lzDtIya9iDhEsQFTpsYe6HZkS
         J3vDj7XS5FR8F7RtecQhMQlXWV1qPNLTaYVbLrRATbJ7QMcFoAvO1h4sjgoMTnUSADsD
         buc1YnmoOB5qXfeLsy4E3+h1cpyEoozAWTKKBVjwdY+w+YD86ZczSn2XT6xCizGeF5Zc
         k/9g==
X-Gm-Message-State: ABy/qLaqbwDV23upf0zn8rPQQ+UGM0LTxoQD9LHdu4rjwbcUDahCfl6w
        tkbXApXkg7RIj1qCeQ7OR8s7gELdmzjGilsq6Z2RBg==
X-Google-Smtp-Source: APBJJlEDnLFb8GjPXbPTzAh6YLjvoLoSbHPMcSzc7vgkUeFYmxn8dGyrtRBzBWOd8r8yQvlH53H1Oujxft0ruwTyl30=
X-Received: by 2002:a25:b499:0:b0:c4c:fee5:428 with SMTP id
 o25-20020a25b499000000b00c4cfee50428mr2052442ybj.24.1688666669701; Thu, 06
 Jul 2023 11:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230706092047.18599-1-frank.li@vivo.com> <20230706092047.18599-3-frank.li@vivo.com>
In-Reply-To: <20230706092047.18599-3-frank.li@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Jul 2023 20:04:18 +0200
Message-ID: <CACRpkdaixG5bOpXLjveLz98w3DEEYCGr6HTz98EGopZD=02nig@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: v3-semi: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 6, 2023 at 11:21=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Looks correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
