Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD00702B07
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjEOLEl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOLEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 07:04:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835C93;
        Mon, 15 May 2023 04:04:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96adcb66f37so441816166b.1;
        Mon, 15 May 2023 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684148677; x=1686740677;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lERUo+WLdZx4JBH1Pw+XtLzFG1CgqVYgHbVRbkTw/zc=;
        b=MpUkLvhNClhT0+vzP2Wf7eEd6ur5TUAoj+zZSAkek414G63FLBv4no2rTUVduz4l9o
         qkQRw2DEssURnU9zbv5bHx5vD+nvhTvl8ea3XSimE6AOLO4oY0qpexU4ZSZg8IZ5fJmc
         fNzTTXcbVeNjkFD7KRdDF47H50mlVHyyX7IsGC3ri3KKZjxHL7CkiYH6MVa4xiDdClQN
         exzTJ/0ON2HEwQxZ9/vz+uw40MScC4o/fRjspKeyp+5Tfxx75YbqBTrmPWNZkrz2/9GE
         eyTLzYpJNPOP1M5XMjvE+pUt5Les/zp/XhJ+h1XFmMEDxwJvlILT6ZOd+dQk1qdcI/PQ
         uRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684148677; x=1686740677;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lERUo+WLdZx4JBH1Pw+XtLzFG1CgqVYgHbVRbkTw/zc=;
        b=SMGNAp+SPRewDvseC7ir4fLCrRHu2XFZPFxbbqrRImP3cwqdr5TlOkafwYPYvNzP/O
         QEXPN4zXlEp1NxxhTM6abEGTeWZUKVEYEMM9QgingCx8uKf9/JrNvHTxreO5+DQWVBlX
         7G4cScbj9gxTzDsRgR8Pd/ykMhtLsuFvBPCBNBqK1ofyZ00r/EJieAd1ISmslvjkPfir
         5r+FFD4O5XK7nq4/TpVA0ZN3dW5mYRz3Vf/dkCtEbSgYs9NS1lp+mVB8qljENa5S0ogY
         ks2ziz+xR+c8bsvn7SXqtL140aoslrbXZDYftWDXGDv/QCNYhC9SJJ0zkJDAAov7xrX4
         oEKQ==
X-Gm-Message-State: AC+VfDwaDX/dYovvLv7xw7Q4RNeHUoTrDBNF+y+kIid2gzaDt3gw8e83
        NnONQLZC/dIsluxlmsH2r68=
X-Google-Smtp-Source: ACHHUZ6wMR84Ke6Bj7QUjIoHhVknpSvv7L8BQTIL2uFttHnpEnLdiTBzHPFK9FhK4YNbXf1M57YKrQ==
X-Received: by 2002:a17:907:7e97:b0:968:4ce9:677a with SMTP id qb23-20020a1709077e9700b009684ce9677amr24562615ejc.38.1684148677324;
        Mon, 15 May 2023 04:04:37 -0700 (PDT)
Received: from localhost ([146.70.133.78])
        by smtp.gmail.com with ESMTPSA id de9-20020a1709069bc900b0094e6a9c1d24sm9520105ejc.12.2023.05.15.04.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 04:04:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 May 2023 13:04:34 +0200
Message-Id: <CSMSVO8Z73NV.3MX3FRNO026T9@vincent-arch>
Cc:     <kw@linux.com>, <heiko@sntech.de>, <robh@kernel.org>,
        <linux-pci@vger.kernel.org>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Peter Geis" <pgwipeout@gmail.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
X-Mailer: aerc 0.15.1
References: <CSK8M39MQL2C.3S7JO031H0BA2@vincent-arch>
 <ZF7m1npzLZmawT8Y@bhelgaas>
 <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
In-Reply-To: <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> >
> > There *is* a way for a PCIe device to say "I need more time".  It does
> > this by responding to that Vendor ID config read with Request Retry
> > Status (RRS, aka CRS in older specs), which means "I'm not ready yet,
> > but I will be ready in the future."  Adding a delay would definitely
> > make a difference here, so my guess is this is what's happening.
> >
> > Most root complexes return ~0 data to the CPU when a config read
> > terminates with UR or RRS.  It sounds like rockchip does this for UR
> > but possibly not for RRS.
> >
> > There is a "RRS Software Visibility" feature, which is supposed to
> > turn the RRS into a special value (Vendor ID =3D=3D 0x0001), but per [1=
],
> > rockchip doesn't support it (lspci calls it "CRSVisible").
> >
> > But the CPU load instruction corresponding to the config read has to
> > complete by reading *something* or else be aborted.  It sounds like
> > it's aborted in this case.  I don't know the arm64 details, but if we
> > could catch that abort and determine that it was an RRS and not a UR,
> > maybe we could fabricate the magic RRS 0x0001 value.
> >
> > imx6q_pcie_abort_handler() does something like that, although I think
> > it's for arm32, not arm64.  But obviously we already catch the abort
> > enough to dump the register state and panic, so maybe there's a way to
> > extend that?
>
> Perhaps a hook mechanism that allows drivers to register with the
> serror handler and offer to handle specific errors before the generic
> code causes the system panic?

This sounds to me a good general solution that also help to handle=20
future HW like this one.

So this is a Concept Ack for me.

Cheers!

Vincent.
