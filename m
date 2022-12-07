Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF164513E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 02:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLGBbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 20:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLGBbQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 20:31:16 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB0652158;
        Tue,  6 Dec 2022 17:31:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so15688564plw.1;
        Tue, 06 Dec 2022 17:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7urdQE78p912qO0A7x+cXXIHloLKsW1NnErtpLTCgE=;
        b=PF8d6NSlKi9CbBejIf+IJfb6sGIV2inLi1UDQw0YGbamjjviRKOD3JWzJnDVQlpXLM
         +XF+oUZpjIUV3TJ6+WrZnarkThTgxf3wpqn6rf1kzZ1lmVQgI99WNByJ+hZMyrrtj3Ax
         OpMj9NyrxTrNiypIavUPCnzeYbqeuXV/T9MgUdDZMtFmhHqagqhJwSPFQUeABGoAqWiX
         JTsQIYMl3wxud32/MkncAmheSThngjdKGLc7V+NAawh6vrrzYy7jVF+7OOfP4Oqjm8C9
         j3hSfseiaY2BFVaSFTIi8w11Firj2Edev8kItXukE8NnU2gFPbytv6awkw1eLujE/Nqi
         XCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7urdQE78p912qO0A7x+cXXIHloLKsW1NnErtpLTCgE=;
        b=AMoiKQAJ8iKh6w17EZIg+XWAhkFqgvQA3V82JNQfANbzOXfNTKw87MQW1WjbIDulGU
         AMYd7VqwzCZnkgVBVN9aKtUVk1SKR0RpcPozBuNxBG0p4SdRodZnor14a/vsHE+v3kPw
         NWJ3i16aN8JfCcViA9iermXRI4gcGWqRcrdmSBGuINlIqGUXdWGcRxb6rAjLXJbN3M49
         EwteFYFN2diIUIaS5Z5pd5vDyNCtRWOKwgxUeVqq8ILSisYL/Ht8DF8CsZPF93oRW0M4
         D9lG3MXtGYt5x3Dm+QaHFSyduNK6zvnmIxoe/4AHkc3OODDtdQQ1AniC1pRC4ip7OZGZ
         YdgA==
X-Gm-Message-State: ANoB5pmKmg439EtRnqi6BcLND6ZgEqpL4UqdTtqJKaBseQhPtfRiJJcM
        j75QmhxYYiV4NHDxkPmAiQsXKa7h3JU=
X-Google-Smtp-Source: AA0mqf6muuuxbEIJAn0cAhL8ISoINjfzW0o2hKewGkvmHMwrtI+1P5hPiYKRmPvzM/rJEuIuw07Bmw==
X-Received: by 2002:a17:903:1246:b0:189:63f2:d584 with SMTP id u6-20020a170903124600b0018963f2d584mr58297572plh.156.1670376675391;
        Tue, 06 Dec 2022 17:31:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a61:38c7:d37a:7f43])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b00575448ab0e9sm12247461pff.123.2022.12.06.17.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:31:14 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:31:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <Y4/s3227WQyGQiOI@google.com>
References: <Y3KMEZFv6dpxA+Gv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3KMEZFv6dpxA+Gv@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 10:42:25AM -0800, Dmitry Torokhov wrote:
> Switch the driver to the generic version of gpiod API (and away from
> OF-specific variant), so that we can stop exporting
> devm_gpiod_get_from_of_node().
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2:
>  - collected reviewed-by/acked-by tags
>  - updated commit description to remove incorrect assumption of why
>    devm_gpiod_get_from_of_node() was used in the first place
> 
> This is the last user of devm_gpiod_get_from_of_node() in the mainline
> (next), it would be great to have it in so that we can remove the API in
> the next release cycle.
> 
> Thanks!

Gentle ping on this one... I'd really like to remove
[devm_]gpiod_get_from_of_node() API from 6.2.

Thanks.

-- 
Dmitry
