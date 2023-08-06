Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E7771728
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjHFWGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Aug 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFWGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Aug 2023 18:06:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFCC171E
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 15:06:36 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58653c9bed3so45600277b3.2
        for <linux-pci@vger.kernel.org>; Sun, 06 Aug 2023 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691359595; x=1691964395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUqMcmYurSaB1o0K6pRlX8P/dyeS0vbb/8Hy1i0+ygQ=;
        b=V3ziUFqHAKFFe9Kmwk7Kgqxf6KTTqJKYGgj2JMKeDnkmfgbXxAOHzX7ayEzj21ACsg
         JdZ14dRHLvXfyEVxClTGl9+3ZP/LlSUhfzYQuIdz6RPp/N13XCPGHS1WfeUBtFD0wRzL
         TFrnmYckWvu575OdJXegERlS+6lHspZYxrSFj9iNKeWD5zirNLzXOLEgqCvnBJReDDaB
         O6UfuwjhJZj/i8QVaXz7W/yBUAWOAtmz/BKIuU12qvUKMzpoDHsZ1Vl+/Rvkj8XU6M9E
         LGxZXj+ibJcnpAE3OGqfyoth3+D58zTCBYkeZBPxJq8av/PMHmidcnl2TULyFZCaKQp7
         Oweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691359595; x=1691964395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUqMcmYurSaB1o0K6pRlX8P/dyeS0vbb/8Hy1i0+ygQ=;
        b=Fw+l2qI2DkRLWW/04xhxmhUlMiMMdIxSZeMi4lv0LSL4mdEuzm/GxQhpdWME0pnh/j
         kc6xv1DiZMDzElcvBC35f0xzp8AemEtV8Plmz2H4IMt3S5yHI4OxxmHtQgihzUxnZvUy
         fWC0kXkmdyzSGbjmdDijkiyTa5+38CXv6xDS3wP04uKHJWeJIB1oIDJqy75pXvOQmg/k
         sN4r9EmIt3Fr0ZXrvFwFeIwxTR2gFR1aE76sc7eed5qzr2QnCBcRVJbr+KgOXtgm/Gr4
         +7B9AaLVQ+jbEaImu66hjrn+6IkI0yYfPnp01dGfBZlp48v1PgfX6pOXQHrHOnidciA4
         ObQg==
X-Gm-Message-State: AOJu0YxU2woE7eKUH6Kfp25ardKrB7c+G86DQy7W0VecXBAuBJDOjHpH
        d8joE75jQAAyyoYc8YYyM91zS/kWsPYYTrqZA/0=
X-Google-Smtp-Source: AGHT+IG9AmIzT9Zx2vrdVCG1+119YMu6/uF9dAwDKr4DXg30zUljMk7vCBJJvU9Xw9jYdNefXaW2lfgNIWdf/uMtxc8=
X-Received: by 2002:a0d:d8c3:0:b0:56d:9e2:7d9e with SMTP id
 a186-20020a0dd8c3000000b0056d09e27d9emr7776164ywe.21.1691359595300; Sun, 06
 Aug 2023 15:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk> <20230804170655.GA147757@bhelgaas>
 <ZM1VNv6QMCD+Clqr@shell.armlinux.org.uk>
In-Reply-To: <ZM1VNv6QMCD+Clqr@shell.armlinux.org.uk>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sun, 6 Aug 2023 23:06:24 +0100
Message-ID: <CAEzXK1qgfeGNt0f+dG98c0VsbTQaOuS2SZ97bs58gdnXwCMWTg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It also works for me. I have a home built Armada Duo motherboard that
I designed with two PCIe slots, and I have it working with an AMD GPU
card and the amdgpu driver on one slot and I also use a second PCIe
card for a TV/SAT tuner card or others like SATA controllers, or
Ethernet controller cards.

The video is in Portuguese, but illustrates the system working:
https://www.youtube.com/watch?v=3D98GuzKp1U6E

Kind Regards,
Lu=C3=ADs Mendes
