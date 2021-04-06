Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF65355A4B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346940AbhDFR1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbhDFR1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:27:11 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665CDC06174A;
        Tue,  6 Apr 2021 10:27:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v25so15904599oic.5;
        Tue, 06 Apr 2021 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aibtX65fRbYclFPJuZJmwbNxAQjzGOE2myqGS3WunLw=;
        b=Vft4FkSEKfY2Z/qa0/JsrQjiV/YE+4yDEO1Y+jiyV3QFtb/o9z9DILB2JWjOcHMOxg
         m2VJTdFThlPydPR2J3pNIHJu8W8/BHOi3hdZjcvq0yCjLqSDWQkTtoNSmfbA2BDdrE72
         T7UEREB3gwPtPc7k4ukjgIuuxlrKBpLyxD0Um0GSomZ5ia7cbO6Jj6Nb7gLc2dGL18YL
         CuNSYot4qj+NuxBmDis7Dk/gj70XJyH+Nfd0hbd8dmEgcRj3fDzhaiQSOjJF3gnQ1tpv
         GJTJEUfGodIMLkBoC/bRKEXAeHevz3BA5Pmcr0VMElTjBGkbHiM/U5YuYAPclmbAs6h5
         GLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aibtX65fRbYclFPJuZJmwbNxAQjzGOE2myqGS3WunLw=;
        b=mm0TVsWQz3AwkL3hZ07H9rfco+AjbjxQjT1QGFZVa5F2uogsO1Wg4E1IgcTn1xG1Db
         qa7El+CRLJWFX108K2sbCiY/Qm4qdhVQtwXcFtv5TAVaR86yT6xfiora9F7KEC2rUJ7a
         Cf+H/eKZlzr651hdz5vxpY5JlXXqb/Ii4z6Gun0UoU6noHVArIW9oK72+j2XzrSfN5gw
         cvvcgky0vRSHB4aXNYGbF5iml7DwtbLWUwYQCaDvpF4Ri0/ODTq4GujyjTO71gCR7pfo
         umAxaDw5ijQ3Osv0iTqPptLul+tdKKR9Dx9zDHY51L7EX/FYzjMn80qO2oL+dKKcss60
         3pwQ==
X-Gm-Message-State: AOAM531Pogg54YzzmtVct3kp+aar5AdwTjkTkK9I2zBRUosZZbY19VlQ
        A5IlfWJZx6ijCNOOegJP6gKkN9ucJmURfk811Ow=
X-Google-Smtp-Source: ABdhPJxzlmwLkzM2a1BhjNvUHf4fud8hfZLp5Pb3qDfM6ZswIQ0AQFgakOSrKLr6XR7eX0WHAMCXCC1Q3cApaePjWyM=
X-Received: by 2002:aca:35d4:: with SMTP id c203mr4177990oia.10.1617730022896;
 Tue, 06 Apr 2021 10:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210401212148.47033-1-jim2101024@gmail.com> <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
In-Reply-To: <20210406164708.GM6443@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 6 Apr 2021 13:26:51 -0400
Message-ID: <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 01, 2021 at 05:21:42PM -0400, Jim Quinlan wrote:
> > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > allows optional regulators to be attached and controlled by the PCIe RC
> > driver.  That being said, this driver searches in the DT subnode (the EP
> > node, eg pci@0,0) for the regulator property.
>
> > The use of a regulator property in the pcie EP subnode such as
> > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > file at
> >
> > https://github.com/devicetree-org/dt-schema/pull/54
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index f90557f6deb8..f2caa5b3b281 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -64,6 +64,9 @@ properties:
> >
> >    aspm-no-l0s: true
> >
> > +  vpcie12v-supply: true
> > +  vpcie3v3-supply: true
> > +
>
> No great problem with having these in the controller node (assming it
> accurately describes the hardware) but I do think we ought to also be
> able to describe these per slot.

Hi Mark,
Can you explain what you think that would look like in the DT?
Thanks,
Jim Quinlan
Broadcom STB
