Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64F6DFA58
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDLPh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDLPh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 11:37:26 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5039E5A;
        Wed, 12 Apr 2023 08:37:25 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1842eb46746so14150255fac.4;
        Wed, 12 Apr 2023 08:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313845; x=1683905845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llOnxsZAiiB0f9tN6mCyjX/UElSdZwin+EcDemVsw9M=;
        b=Q9g2hQ45nPx0iQeyveNW9CikFaQfWjld3w7Y6D/MOM8ozlDUmp/LzzDT0QrkCzWCvK
         wvJ7Pe5l1Q8fWRnvGbdKtplbzRKm7G3VFD+x9xwF0IzUkC1JGhcdP8RX9a1D6opoY7Bs
         Pzj6CTCarTQJZePNWTEo4GJiMQ1BNRhzrzWI9EWk8FeNUWuUL8RuBIumjJKF7fzv4mRA
         zPqHl1bJb+e4ujqCNGP7pl77FclMwTLo1KFfIskUfo3NSt3b7vP7f9AKM1A2NrPD3eMT
         xuNGgHgmLDXv4I3WJWbGZlTVAigwn/4OowHByjduac41WBTBEpLBdvqdpid1mQKehRHh
         WLqA==
X-Gm-Message-State: AAQBX9fPCJHvGXsk7AvMFCu2010Kdfa5ueQ1tQ/BX1rYxXGLm9FuEL/w
        FJ/1tl+LWaFg4OhvwbJlHw==
X-Google-Smtp-Source: AKy350ahNyL/XOwtOqpU6itFjuy/+csf8DSDPMkLE6oiwDHuae77ClE8SRdgGOfdUWr+EhovtDp2iA==
X-Received: by 2002:a05:6870:4687:b0:176:8702:207f with SMTP id a7-20020a056870468700b001768702207fmr1521978oap.24.1681313844822;
        Wed, 12 Apr 2023 08:37:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yo7-20020a05687c018700b001807f020a39sm6245985oab.12.2023.04.12.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:37:24 -0700 (PDT)
Received: (nullmailer pid 2478515 invoked by uid 1000);
        Wed, 12 Apr 2023 15:37:23 -0000
Date:   Wed, 12 Apr 2023 10:37:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Message-ID: <20230412153723.GA2473030-robh@kernel.org>
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-2-jim2101024@gmail.com>
 <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org>
 <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
 <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
 <CANCKTBtZt9QRkT4yAW5LsfHGf5TTL7tQ025H42+PPEi-=rWE8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCKTBtZt9QRkT4yAW5LsfHGf5TTL7tQ025H42+PPEi-=rWE8A@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 10:14:46AM -0400, Jim Quinlan wrote:
> On Wed, Apr 12, 2023 at 7:56 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 12/04/2023 13:49, Florian Fainelli wrote:
> > >
> > >
> > > On 4/12/2023 1:09 AM, Krzysztof Kozlowski wrote:
> > >> On 11/04/2023 18:59, Jim Quinlan wrote:
> > >>> Regarding "brcm,enable-l1ss":
> > >>>
> > >>>    The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > >>>    requires the driver probe() to deliberately place the HW one of three
> > >>>    CLKREQ# modes:
> > >>>
> > >>>    (a) CLKREQ# driven by the RC unconditionally
> > >>>    (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > >>>    (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > >>>
> > >>>    The HW+driver can tell the difference between downstream devices that
> > >>>    need (a) and (b), but does not know when to configure (c).  Further, the
> > >>>    HW may cause a CPU abort on boot if guesses wrong regarding the need for
> > >>>    (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
> > >>>    that (c) is desired.  Setting this property only makes sense when the
> > >>>    downstream device is L1SS-capable and the OS is configured to activate
> > >>>    this mode (e.g. policy==superpowersave).
> > >>>
> > >>>    This property is already present in the Raspian version of Linux, but the
> > >>>    upstream driver implementaion that will follow adds more details and
> > >>
> > >> typo, implementation
> > >>
> > >>>    discerns between (a) and (b).
> > >>>
> > >>> Regarding "brcm,completion-timeout-us"
> > >>>
> > >>>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
> > >>>    PCIe transaction completion abort timeout.  We've been asked to make this
> > >>>    configurable, so we are introducing "brcm,completion-timeout-us".
> > >>>
> > >>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > >>
> > >> What happened here? Where is the changelog?
> > >
> > > It is in the cover letter:
> > >
> > > https://lore.kernel.org/all/20230411165919.23955-1-jim2101024@gmail.com/
> > >
> > > but it does not look like the cover letter was copied to you or Rob.
> >
> > As you said, I did not get it.
> 
> Yes, sorry about that; I use a wrapper over the "cocci_cc" script and
> I need to modify one or both scripts to send the cover to the
> superset of recipients in the constituent commits.

Try out 'b4'. It's much easier.

In any case, I don't read cover letters. Changes to a patch belong with 
the patch.

Rob
