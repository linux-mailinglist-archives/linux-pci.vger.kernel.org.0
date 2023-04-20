Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D026E9703
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjDTO2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 20 Apr 2023 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDTO2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 10:28:01 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37618271C;
        Thu, 20 Apr 2023 07:28:00 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54fc337a650so44554077b3.4;
        Thu, 20 Apr 2023 07:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000879; x=1684592879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SOFY2R5CmNUgUkHciJCCV1KTLZWvAaY7EL+I77EmoM=;
        b=JT7fOY2C23I3g/cAFyNec6XoolyZmaa2ALUWtd7R0lht5Wrmkbql/pX3ufUl9rPGKP
         jHpPA286rrpu85PsMfu5wp5qj6eJfYcUttcLz5J04+S88mSPPi3f4Q8KAQkuACzgWmM/
         SNGeaoxALiRaw6ZDzpNgiayL3XUyB2Uh0NNZ2Siuz+6Khkscj2H+RSNc1m9xNEAMlNfx
         QeM+8tw2ErymTDHT0E9QpfozJtMqoL+zogU5UYHwl4V9vV9Yy76ptnZleanSr4Y9BRx/
         lkyWnz6gIGVuoWWQ1dwvKBQPU2MIb4mfmJehloUzjjNyN2sNxbYUlEF9zlG4EwcU6xmC
         KUcQ==
X-Gm-Message-State: AAQBX9eDWjdgULtP+jkqdxRdZO1U7ce/J4ji4ZCIPMCTcVaEUV6qwQfj
        iFP9fzXpw7c8aegz2xnkdozFsi83PD2Xhb49
X-Google-Smtp-Source: AKy350Y8ZchLVd0i6hFpZc2HFV9lP9PXFi5hUgf/Qewj8oT+wJdlkYiiI+ZFqZlfeog5f+bkd5WyKg==
X-Received: by 2002:a0d:d753:0:b0:552:b9ad:f2e4 with SMTP id z80-20020a0dd753000000b00552b9adf2e4mr977861ywd.51.1682000879208;
        Thu, 20 Apr 2023 07:27:59 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id i66-20020a0df845000000b0054601bc6ce2sm359010ywf.118.2023.04.20.07.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 07:27:58 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-54f6a796bd0so43105857b3.12;
        Thu, 20 Apr 2023 07:27:58 -0700 (PDT)
X-Received: by 2002:a0d:d406:0:b0:555:d281:173 with SMTP id
 w6-20020a0dd406000000b00555d2810173mr962594ywd.47.1682000878519; Thu, 20 Apr
 2023 07:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230323091644.91981-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230323091644.91981-1-yang.lee@linux.alibaba.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 16:27:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_jNor3mEw595OBK1B4UUBM-=iKAGBZZLM0M88atMo9A@mail.gmail.com>
Message-ID: <CAMuHMdW_jNor3mEw595OBK1B4UUBM-=iKAGBZZLM0M88atMo9A@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: rcar-gen2: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 23, 2023 at 10:24 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
