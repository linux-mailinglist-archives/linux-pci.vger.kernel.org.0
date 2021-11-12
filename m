Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C6744EB5E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhKLQdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 11:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235392AbhKLQdG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 11:33:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF06661029;
        Fri, 12 Nov 2021 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636734615;
        bh=b0FOru2XfB1nXALMQLkGI6q71luVIxAkEEY64MK9EFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VOau2OKgp1CJdCcWIqD7pcuVidqeNBegA5FxTJWFDzk1K/otEGinWjlHRt3FIcqjF
         3BIGdW+FLuVEVnTI7FwZB2ZNNqrnYefujGX9od0bUFlcoOLhz4LT40GLbGBTlqDB/9
         VRTY9cHxUliAm0QzHIxTuNvALstN96xM4v7m73KR3TakW+U6qRH+iDS2w6x628ixFg
         6HMWS/0Tf3uIswwcuMFFEp7kOcPfMzY6QBWnksjRb7jD/J/UIWZSqfy88qgIstL1w4
         N836YArxQG6VJZoKzhWkDBJZUFWyjtq1BMl0GhiClki3nkev9S602nNXg0wG3UO2mv
         DODp1lwdc56OQ==
Received: by mail-ed1-f45.google.com with SMTP id v11so39980199edc.9;
        Fri, 12 Nov 2021 08:30:15 -0800 (PST)
X-Gm-Message-State: AOAM533jLVqwHnlItTw/g39dQRvB9c3TXADgeWrE5cN5FOEKMcgeav7R
        9M0Ax4W6YFqCxQ+ZH7kQxI2RSHQdppv7b73zPg==
X-Google-Smtp-Source: ABdhPJyXSxuMZZ13TI8XuNmqYuGj565BmTODpiO094jjCB7GeNqYT+HGjYXm0FV5flZaZeRW1j6byZbpv7wMCqbHGKk=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr21179096ejc.147.1636734614244;
 Fri, 12 Nov 2021 08:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20211031150706.27873-1-kabel@kernel.org> <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20211112153208.s4nuckz7js4fipce@pali>
In-Reply-To: <20211112153208.s4nuckz7js4fipce@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Nov 2021 10:30:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
Message-ID: <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add 'slot-power-limit-milliwatt'
 PCIe port property
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 9:32 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 12 November 2021 09:25:20 Rob Herring wrote:
> > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Beh=C3=BAn wrote:
> > > +   If present, this property specifies slot power limit in milliwatt=
s. Host
> > > +   drivers can parse this property and use it for programming Root P=
ort or host
> > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit me=
ssages
> > > +   through the Root Port or host bridge when transitioning PCIe link=
 from a
> > > +   non-DL_Up Status to a DL_Up Status.
> >
> > If your slots are behind a switch, then doesn't this apply to any bridg=
e
> > port?
>
> The main issue here is that pci.txt (and also scheme on github) is
> mixing host bridge and root ports into one node. This new property
> should be defined at the same place where is supports-clkreq or
> reset-gpios, as it belongs to them.

Unfortunately that ship has already sailed. So we can split things up,
but we still have to allow for the existing cases. I'm happy to take
changes splitting up pci-bus.yaml to 2 or 3 schemas (host bridge,
root-port, and PCI(e)-PCI(e) bridge?).

> And you are right, that this new property should be defined only for
> root ports and downstream ports of switch.
