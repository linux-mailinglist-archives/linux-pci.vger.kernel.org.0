Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B66B13CA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 22:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCHVZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 16:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHVZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 16:25:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E00F25E12;
        Wed,  8 Mar 2023 13:25:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ay14so67517211edb.11;
        Wed, 08 Mar 2023 13:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678310709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEQQ5y1rU+jovQ+RQSf9fz570XBj+oRwE2jbrv64UoU=;
        b=fABAaGcHA/JuPb3YorxwiN0BG3dM5Jrc4WdT1Gn7VVAIfLK3U7vLy2EJ2Xp4Sm17ht
         29Ifww1kkszG+k5IqQjNXr/Mh5ersO6r3HKPR8x/3nSdp5b7MEn1Oh9LxJdNgSgUt7Fl
         00uwgKmEnn6RZ8oNQrbBdUzNMagOg5I6IRSSCvMEIjN4ZKVAthF8L086oMxrZSu8o/6R
         tWkU4thGaBUQh3WI3aioiNUlcoSyrAnqsfM7+jKYyfdDBBnjG8Q5NklbJTXNuRjZ3wZP
         gf4+bqoKx3Q67FM331Ro0JSoBkcv0c8KBOp69zIl1rcqAYGGsyyVaDC6OWz4sHljtaM8
         Zeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678310709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEQQ5y1rU+jovQ+RQSf9fz570XBj+oRwE2jbrv64UoU=;
        b=xLhSHS8oi36SoxzrZEbmZ0UQwvaITGminH3ZGgVLP/nvtytj4xx9ghuz30PwHj3c6B
         1Y1+TKlbvoSJsZrvbiJRUFG3kU0F/3eCNlEK2U1kbcuOklapa4Fn0SAHZqMEAZTt4YrQ
         WB8i9+sDIiPUsDOobPBFV0SlcwtJRO+R2UWUiWR5iKeV0B4+r673MljbQUrk0z06vqN7
         vVJ5SYMxKwTaxT4AMthJqqGHEofmGgspu91AehrFAytVt5bUbcoyv6jfqUKNXWM0C/W/
         t2RZczG1RCIZPbrrD+IUjJbFQ15tg8vkKJ0rC4xPf8UF1ZZatkXYaajsJVtuGp6DUdQk
         37Rw==
X-Gm-Message-State: AO0yUKWS+LWRC1J6fmM3kT5t31/y2zN6XQCmI92K2HYQV+rdhvFaykUW
        YgjDWGJZDDuwB7PUwAgA7Md80i3cFu5YzNt5ZOU=
X-Google-Smtp-Source: AK7set9EbJ+kG0WoXhSVXEi4hP8885ePLJPbBRoToqjisvKkiPtNHvmh0Nsh0/o4zHrybOasiIZDvzc3QK81g6iwFc8=
X-Received: by 2002:a17:906:ce38:b0:8b1:30da:b585 with SMTP id
 sd24-20020a170906ce3800b008b130dab585mr10042710ejb.6.1678310708691; Wed, 08
 Mar 2023 13:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v4-2-34e623dbf789@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v4-2-34e623dbf789@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 8 Mar 2023 22:24:57 +0100
Message-ID: <CAFBinCAiS_1nJyPb1+disehZSJTe=ES72pDTeKxazUdpzX+VAw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt
 to dt-schema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 8, 2023 at 2:27=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Convert the Amlogic Meson6 eFuse bindings to dt-schema.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
