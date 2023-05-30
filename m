Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B1715847
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjE3IVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjE3IVb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 04:21:31 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0659BE;
        Tue, 30 May 2023 01:21:29 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-55586f22ab7so2594443eaf.2;
        Tue, 30 May 2023 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685434889; x=1688026889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFbV56mg6Q55NdGwwdOG9BX33ZimndK6LI0LO9roZc=;
        b=MuR7+cuL0G0CoFLKb0VXhDL65PL/4j+U47R3t73ppIx4SHvrw0H7ZG+xvPscbhp9ez
         q9Ofg4ReNMKkTWXz+Aa8uLtSJJSYmqhzc7aJ9KX5Vbf9vmnZPiL/id1wEPeWI8ovLBjJ
         +Wojt58ZBt4gvhgfnfk3cHwYlyP0QBLS4Tht2y9ACgH+gh6AOziAc/xiUTaRpWS0YIa+
         bRyicQNU2cU76Whp5vdgKz0u6JSH6SEpSxwZHaX9hVaDaVIPCIGMCedjxlOB265dPIut
         fb247453Kl2mi8T4tjwBaUo3jo7rYoKGN0hssCqNUjyzRTHGvHwSMZUX4Z9GAb1vyVwR
         aCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434889; x=1688026889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoFbV56mg6Q55NdGwwdOG9BX33ZimndK6LI0LO9roZc=;
        b=RB4hibgAP+07iwo8k91Jn3xRGNAJOdHdryxZKpaIKJhyXrRHSLAivRg3XeA5srp1s8
         K1Et6sNtDQjEsuwx8csQku2lTilj/fKlmtxC7svu5wn76s3y4Hm8fJP+XqYDqu58Nlb5
         1MOVREIScY7zpRO6ajSBPS9abf6xIa8Hi/j3PYZBzLkQmA0sKdtXm0uZ2sxrVquqKTrK
         HYt7cKOPhBfPUxU6jHpKO6PBfvW5L/NQh5J5qzbb0KAzoDqwBuOWB/YxRTVDg/rMF1rv
         aRHQPEQvsaaZ5YM4z0qjkR8DYw6jG568PyPl5iKol9lFe4sL3DID1rQ9oFiYNK47w30C
         W5vQ==
X-Gm-Message-State: AC+VfDyPqnZOQ4YGRHl2yenuTd6wqesRRwWA10lv5pFE/mMQY25Ehh02
        tHGFOQW5+KommuBTVvGyLqlgm+pgc5uAa2bwzL4=
X-Google-Smtp-Source: ACHHUZ6ofFn3is8D65zPcrksWtiIffohoJmAaDU4/V3zZOzhrBQ0r8RxVKjddmzo4f5H7xb270edOUD6IG3aC1GQiII=
X-Received: by 2002:a4a:4fd2:0:b0:555:51a9:5bff with SMTP id
 c201-20020a4a4fd2000000b0055551a95bffmr711688oob.8.1685434888861; Tue, 30 May
 2023 01:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230427055032.85015-1-rath@ibv-augsburg.de>
In-Reply-To: <20230427055032.85015-1-rath@ibv-augsburg.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 30 May 2023 10:21:17 +0200
Message-ID: <CAH9NwWdPL8NAr+MGD7Ca-KWyW7Oy9amN63_zUSwFwT=dcFvMJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Cadence PCIe PHY latency for PTM
To:     Dominic Rath <rath@ibv-augsburg.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com, bhelgaas@google.com, lpieralisi@kernel.org,
        nm@ti.com, vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dominic

Am Do., 27. Apr. 2023 um 07:50 Uhr schrieb Dominic Rath <rath@ibv-augsburg.de>:
>
> Hello Everyone,
>
> this series adds PHY latency properties to the Cadence PCIe
> driver to improve PTM accuracy, and configures the necessary
> values for TI's AM64x processors.
>
> These latencies are implementation specific and need to be
> configured in the PCIe IP core's registers to allow the
> PCIe controller to exactly determine the RX/TX timestamps for
> PCIe PTM messages.
>
> TI doesn't document these values in the datasheet or reference
> manual as of now, but provided the necessary data via TI's E2E
> forums (see PATCH 3/3).
>
> Changes from v1 to v2:
>    - move latency property to PHY instead of PCIe controller
>    - drop vendor prefix from property name
>    - rephrase commit message regarding optional properties
>    - emit an info message instead of a warning in case
>      an optional property is missing
>
> Best Regards,
>

Hope you send out a v3 soon.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
