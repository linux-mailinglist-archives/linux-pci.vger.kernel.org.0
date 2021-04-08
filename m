Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF9358986
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhDHQUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 12:20:31 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41580 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 12:20:30 -0400
Received: by mail-ot1-f49.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so2824302otq.8;
        Thu, 08 Apr 2021 09:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FKQCy9mHVcIx4jvHTvGbM4mIzIxWpaBAJhioAHr5gKo=;
        b=jbBJxxchdkUWHboWgSu7qRPh9GhYxz405cFyejIzLjI7HoVekrRUwwheMwaKqFUyrQ
         mYeEDcDyLbMYM9ams1fV7mg0gtCkkHIZBFnvfL7sDOEGgzikQmNG1BGDolwc5KomSagS
         a2NMWm+4TIRJcQ0fFb/gkMfyZ1Um9hi05NFAVIFeO/cRwRmpzmjb8Id6CdveuyqW9A13
         Fz3rzJFxcuViFjBULhR8aXZNwUJ7c5Lr217Z7isMaeZEaz2GKlXyjtZPZHJGye0/D2Gi
         uz6QsNvLAFT0mVTF4tz1WyZHEGd/ILSlfq1W8/WU6fLdaBA6OKApuFXy1msC4FCY9Sls
         uQ/A==
X-Gm-Message-State: AOAM531PMqkb8iPwNINwPeoEJBGSQE3yGRyZ+xqomoB13sigAvgFXJUU
        mBIiYBRDRmUhp8FWlW7p3Q==
X-Google-Smtp-Source: ABdhPJyazfhgeCNMMJuWdCCjpOP9wOvUKcWMvObpNRssw198EqpTMe/uJHgbk73ctYTJ50zqvVR1gQ==
X-Received: by 2002:a9d:6f02:: with SMTP id n2mr1215732otq.268.1617898818735;
        Thu, 08 Apr 2021 09:20:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m19sm5444036oop.6.2021.04.08.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:20:17 -0700 (PDT)
Received: (nullmailer pid 1581488 invoked by uid 1000);
        Thu, 08 Apr 2021 16:20:16 -0000
Date:   Thu, 8 Apr 2021 11:20:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210408162016.GA1556444@robh.at.kernel.org>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
 <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 02:25:49PM -0400, Jim Quinlan wrote:
> On Tue, Apr 6, 2021 at 1:32 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Apr 06, 2021 at 01:26:51PM -0400, Jim Quinlan wrote:
> > > On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > > > No great problem with having these in the controller node (assming it
> > > > accurately describes the hardware) but I do think we ought to also be
> > > > able to describe these per slot.

PCIe is effectively point to point, so there's only 1 slot unless 
there's a PCIe switch in the middle. If that's the case, then it's all 
more complicated.

> > > Can you explain what you think that would look like in the DT?
> >
> > I *think* that's just some properties on the nodes for the endpoints,
> > note that the driver could just ignore them for now.  Not sure where or
> > if we document any extensions but child nodes are in section 4 of the
> > v2.1 PCI bus binding.
> 
> Hi Mark,
> 
> I'm a little confused -- here is how I remember the chronology of the
> "DT bindings" commit reviews, please correct me if I'm wrong:
> 
> o JimQ submitted a pullreq for using voltage regulators in the same
> style as the existing "rockport" PCIe driver.
> o After some deliberation, RobH preferred that the voltage regulators
> should go into the PCIe subnode device's DT node.

IIRC, that's because you said there isn't a standard slot.

> o JimQ put the voltage regulators in the subnode device's DT node.
> o MarkB didn't like the fact that the code did a global search for the
> regulator since it could not provide the owning struct device* handle.
> o RobH relented, and said that if it is just two specific and standard
> voltage regulators, perhaps they can go in the parent DT node after
> all.
> o JimQ put the regulators back in the PCIe node.
> o MarkB now wants the regulators to go back into the child node again?
> 
> Folks, please advise.
> 
> Regards,
> Jim Quinlan
> Broadcom STB
