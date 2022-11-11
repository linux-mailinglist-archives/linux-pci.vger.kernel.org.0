Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D93625E3A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKKPVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKKPUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 10:20:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329E845D6;
        Fri, 11 Nov 2022 07:20:20 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e129so4633783pgc.9;
        Fri, 11 Nov 2022 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LcP2H7grsqOhDWc1kPXnn8Vqq+kt2chyg0TKAA6Cf+8=;
        b=haeKry4tyfwLPDg6LhjNWDpM9ibrP1Ny4oIqSgQ2jesvxpaVShZpH0YK0dE/2qk4HW
         HDI9dYx2vkHbL+vxdZ9kX7KG45nQyteYWf7ih/S7qDipt/io015129pDCNAvPShkXcSQ
         kh+eLT3yqDAHK6+m1pFeYsStZ170RmAzV4GqpziXi9wwpe9VOUbmR2FHhrLr4KrBhdOV
         sbwA4MchUNh+vqnw/TxZPa3WvtDorqQvaHhMK+ap4kLZJ2KeEgqITLJkDi8QMnd9bxoO
         xBiosOUJtDhUJ6PbdRRwis5W/1TCRpxGRQCJeQ28CyjMJHZnghl3AW8ilIvXW/eF2due
         FYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcP2H7grsqOhDWc1kPXnn8Vqq+kt2chyg0TKAA6Cf+8=;
        b=2+89b3GCCqy9dvJwRqjEBUFU1odCt2fKh9L9Lu3xMaF6iFCmK0r86cWz2CaSIDqNuW
         5sgUqjOBexkBc5SLdnnZf5GV1Dn6h54Y3ugQYfIF7fQaNAvHxuNP84ImYYKoSHHUQdxz
         QWA1E/a0GYnbmrJZobM8k+3BBP/DR5rv1cgN/IyEvjYDM3yKGT0dee25pgYlg5nQBuKy
         EW6SyyqbQWEhl5Z5X53lAzdMLx7DX96tiD07K4azkGCOLT5lZRPHhNoJafHzgoDlc+io
         +SHxImB7JfiQ86Rbu3LCUHy50teJDk/UkGLzSx7fv2wV8wO+RIbWHwNxj+nJACnNzJ/P
         48Ww==
X-Gm-Message-State: ANoB5pm21NDT0bFs1ct90pRiWYgtWc+9Mg4lLTubx2q9OQQ9Sl5qJTSL
        vvm8aNPcpwn52VrksCizcEE=
X-Google-Smtp-Source: AA0mqf5RoqIc5bSBbu0M5ZgiQ19m/Rg7FA5rDDGl6Mj8yWFwlwBHQzb1nNCnog6zpbr7oXbU2ND2hg==
X-Received: by 2002:a62:d0c3:0:b0:56b:94f5:400c with SMTP id p186-20020a62d0c3000000b0056b94f5400cmr3143731pfg.31.1668180019782;
        Fri, 11 Nov 2022 07:20:19 -0800 (PST)
Received: from ?IPv6:::1? ([2601:647:5e00:1473:a573:286d:8e6e:60ef])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090340d000b001784a45511asm1858212pld.79.2022.11.11.07.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:20:19 -0800 (PST)
Date:   Fri, 11 Nov 2022 07:20:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Shawn Guo <shawn.guo@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: histb: switch to using gpiod API
User-Agent: K-9 Mail for Android
In-Reply-To: <Y25juwnlU+ujvue9@lpieralisi>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com> <Y25juwnlU+ujvue9@lpieralisi>
Message-ID: <8C194ACD-6146-4DB1-A81F-7817E7D25FCE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

On November 11, 2022 7:01:15 AM PST, Lorenzo Pieralisi <lpieralisi@kernel=
=2Eorg> wrote:
>On Tue, Sep 06, 2022 at 01:43:00PM -0700, Dmitry Torokhov wrote:
>> This patch switches the driver away from legacy gpio/of_gpio API to
>> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
>> make private to gpiolib=2E
>>=20
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>
>Should I pick this up ? On patch (2/2) I am not sure we reached
>a consensus - please let me know=2E


Could you pick just this patch (1/2) for now - I owe Pali a respin on the =
other one, but as far as I remember there was no material disagreement on t=
he patches themselves, just a discussion how to change gpiod API to be more=
 expressive=2E

Thanks=2E

--=20
Dmitry
