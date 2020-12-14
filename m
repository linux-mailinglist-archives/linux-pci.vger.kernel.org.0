Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3902D9A8E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgLNPGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 10:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgLNPGS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 10:06:18 -0500
X-Gm-Message-State: AOAM5327pdXoz4s46y8m1NxI2O5s+8yXAdLteMeCrv2j6Gu0L5SqxmPw
        Z/GDkV1l3FBvYt5OUvrshubycddbNvslMKL2Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607958336;
        bh=a1F4GYIz8WZZheoIQJa26d8oTs+duE0aM/uetIhYZ3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nJDW3YMkWpCLZQ9363A1qxsa2gPUy13vYabHYSVqZq0sNRV9rMk49jEXkyuKDbFs0
         lMvKN/qte5f/E6OObP8Epx0wRvPqfXNbnVZqArhxIWAhumXeRKJyliDj9zFXJfCYxv
         fHr544lluW3ilsGXc+fdY66O6UBdxYF9V0ZHVN7n3++e39FN1tGpErEsUMfEdZe+Jj
         z77GiMnHGH2bD37yLW34xAdC27MsO9k3OLChFMV7OOk5O24kK/2wRJAFsdfZghsjVB
         HaI+vR2hfwG+lTMtFXcqw32tFEN2ME+Lws2RvgdejLK6Mhp3K5F1/NRcFmebfgXqFR
         XIiQ8EQ0aGpgQ==
X-Google-Smtp-Source: ABdhPJz5RHNLQ+OW0J3APptaHpR5PcCXJxM9D0gpTwMuJq0MgiNOFJlcd064NOmzvzNFSS0YXuU1pYjLXv0fIa5YQsg=
X-Received: by 2002:a05:6402:352:: with SMTP id r18mr24358985edw.373.1607958334944;
 Mon, 14 Dec 2020 07:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20201211144236.3825-1-nadeem@cadence.com> <20201211144236.3825-2-nadeem@cadence.com>
 <CAL_JsqLTz2k03gzrjDqi2d1NHQV+3pXxg6OqwcJ17CmfGYMf-A@mail.gmail.com>
 <SN2PR07MB2557145EE4C4E9C50A16CF64D8C90@SN2PR07MB2557.namprd07.prod.outlook.com>
 <912c1efa-6c25-9e5d-5094-6c9dd8e3755d@ti.com>
In-Reply-To: <912c1efa-6c25-9e5d-5094-6c9dd8e3755d@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Dec 2020 09:05:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEmb4N6AKWpJmh9mGkE3QWsgABUqcH4Zvb5CiSMe_Zvg@mail.gmail.com>
Message-ID: <CAL_JsqLEmb4N6AKWpJmh9mGkE3QWsgABUqcH4Zvb5CiSMe_Zvg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around Gen2
 training defect.
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 13, 2020 at 10:21 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Nadeem,
>
> On 12/12/20 12:37 pm, Athani Nadeem Ladkhan wrote:
> > Hi Rob / Kishon,
> >
> >> -----Original Message-----
> >> From: Rob Herring <robh@kernel.org>
> >> Sent: Friday, December 11, 2020 10:32 PM
> >> To: Athani Nadeem Ladkhan <nadeem@cadence.com>
> >> Cc: Tom Joseph <tjoseph@cadence.com>; Lorenzo Pieralisi
> >> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; PCI
> >> <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.org; Kishon Vijay
> >> Abraham I <kishon@ti.com>; devicetree@vger.kernel.org; Milind Parab
> >> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> >> <sjakhade@cadence.com>; Parshuram Raju Thombare
> >> <pthombar@cadence.com>
> >> Subject: Re: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around
> >> Gen2 training defect.
> >>
> >> EXTERNAL MAIL
> >>
> >>
> >> On Fri, Dec 11, 2020 at 9:03 AM Nadeem Athani <nadeem@cadence.com>
> >> wrote:
> >>>
> >>> Cadence controller will not initiate autonomous speed change if
> >>> strapped as Gen2. The Retrain Link bit is set as quirk to enable this speed
> >> change.
> >>> Adding a quirk flag based on a new compatible string.
> >>>
> >>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 4
> >>> +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >>> b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >>> index 293b8ec318bc..204d78f9efe3 100644
> >>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >>> @@ -15,7 +15,9 @@ allOf:
> >>>
> >>>  properties:
> >>>    compatible:
> >>> -    const: cdns,cdns-pcie-host
> >>> +    enum:
> >>> +        - cdns,cdns-pcie-host
> >>> +        - cdns,cdns-pcie-host-quirk-retrain
> >>
> >> So, we'll just keep adding quirk strings on to the compatible? I don't think so.
> >> Compatible strings should map to a specific implementation/platform and
> >> quirks can then be implied from them. This is the only way we can implement
> >> quirks in the OS without firmware
> >> (DT) changes.
> > Ok, I will change the compatible string to " ti,j721e-pcie-host" in place of  " cdns,cdns-pcie-host-quirk-retrain" .
> > @Kishon Vijay Abraham I: Is this fine? Or will you suggest an appropriate name?
>
> IMHO it should be something like "cdns,cdns-pcie-host-vX", since the
> quirk itself is not specific to TI platform rather Cadence IP version.

That's fine if Cadence has a need for it, but for TI platforms use the
TI compatible string. ECOs on version X IP without changing X is not
uncommon.

Rob
