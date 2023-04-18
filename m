Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDC6E6C2F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjDRSft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDRSfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 14:35:47 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D57A8A;
        Tue, 18 Apr 2023 11:35:39 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-18777914805so5423016fac.1;
        Tue, 18 Apr 2023 11:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842939; x=1684434939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlhqO9AxBER4HIpBC59Ob9+ScXyTg9RUgf/dYIiD+8Y=;
        b=SRLO6ldS5SRp9sR19/akVmV9YPU1g4pjctnkjHZ5Jbukum0iMk7ifWYAky9AbcPz5F
         OPl6KorK3BlmttDCg4Skyv2LJbDEAmkyRid4KtPgWCBlvxSTnvkFP8c5roXz+rV+2FGg
         irGfJXAq3lGBBypQQzb3o4sXXYQPgtW8F9RpLc5WeRrxFz9OXix6uGrMRYcLgY1YzMYe
         HnK11PUojjLBED5f00EVHBTnIymuFGg65TR4BID1oreVjEMABNvTaCKx+CF782HDZ/Yp
         YYAWizK60+UprnKIW8kP8V9WB17/exmm5MJGapTOAmWX0iA6rVbfQNg0UCBfROgm6GKL
         wbZg==
X-Gm-Message-State: AAQBX9fTTFJufRNtE50lM5jxCkNdSgXO5zZCLlNSKy9t/Qzy8+fWDdzP
        vSD6VXOhcx/MtVIfqv+Z9g==
X-Google-Smtp-Source: AKy350ajh+wJUffh8UxLGdDHl6vWMJtQQygdPag8NrHhfp+uVX045UKSF40LZDsSiMF1w+rVbFQNPA==
X-Received: by 2002:a05:6870:b620:b0:184:80bf:753f with SMTP id cm32-20020a056870b62000b0018480bf753fmr1790600oab.26.1681842938837;
        Tue, 18 Apr 2023 11:35:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id sc15-20020a056871220f00b00187fdd3e0d1sm1700958oab.54.2023.04.18.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:35:38 -0700 (PDT)
Received: (nullmailer pid 2097482 invoked by uid 1000);
        Tue, 18 Apr 2023 18:35:36 -0000
Date:   Tue, 18 Apr 2023 13:35:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Message-ID: <20230418183536.GA2087834-robh@kernel.org>
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-2-jim2101024@gmail.com>
 <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org>
 <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
 <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
 <CANCKTBtZt9QRkT4yAW5LsfHGf5TTL7tQ025H42+PPEi-=rWE8A@mail.gmail.com>
 <20230412153723.GA2473030-robh@kernel.org>
 <ac2245fd-52c8-3255-3e54-bd8daab1282d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2245fd-52c8-3255-3e54-bd8daab1282d@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 09:12:07AM -0700, Florian Fainelli wrote:
> On 4/12/23 08:37, Rob Herring wrote:
> > On Wed, Apr 12, 2023 at 10:14:46AM -0400, Jim Quinlan wrote:
> > > On Wed, Apr 12, 2023 at 7:56 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > 
> > > > On 12/04/2023 13:49, Florian Fainelli wrote:
> > > > > 
> > > > > 
> > > > > On 4/12/2023 1:09 AM, Krzysztof Kozlowski wrote:
> > > > > > On 11/04/2023 18:59, Jim Quinlan wrote:
> > > > > > > Regarding "brcm,enable-l1ss":
> > > > > > > 
> > > > > > >     The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> > > > > > >     requires the driver probe() to deliberately place the HW one of three
> > > > > > >     CLKREQ# modes:
> > > > > > > 
> > > > > > >     (a) CLKREQ# driven by the RC unconditionally
> > > > > > >     (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > > > >     (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > > > > > 
> > > > > > >     The HW+driver can tell the difference between downstream devices that
> > > > > > >     need (a) and (b), but does not know when to configure (c).  Further, the
> > > > > > >     HW may cause a CPU abort on boot if guesses wrong regarding the need for
> > > > > > >     (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
> > > > > > >     that (c) is desired.  Setting this property only makes sense when the
> > > > > > >     downstream device is L1SS-capable and the OS is configured to activate
> > > > > > >     this mode (e.g. policy==superpowersave).
> > > > > > > 
> > > > > > >     This property is already present in the Raspian version of Linux, but the
> > > > > > >     upstream driver implementaion that will follow adds more details and
> > > > > > 
> > > > > > typo, implementation
> > > > > > 
> > > > > > >     discerns between (a) and (b).
> > > > > > > 
> > > > > > > Regarding "brcm,completion-timeout-us"
> > > > > > > 
> > > > > > >     Our HW will cause a CPU abort if the L1SS exit time is longer than the
> > > > > > >     PCIe transaction completion abort timeout.  We've been asked to make this
> > > > > > >     configurable, so we are introducing "brcm,completion-timeout-us".
> > > > > > > 
> > > > > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > > > 
> > > > > > What happened here? Where is the changelog?
> > > > > 
> > > > > It is in the cover letter:
> > > > > 
> > > > > https://lore.kernel.org/all/20230411165919.23955-1-jim2101024@gmail.com/
> > > > > 
> > > > > but it does not look like the cover letter was copied to you or Rob.
> > > > 
> > > > As you said, I did not get it.
> > > 
> > > Yes, sorry about that; I use a wrapper over the "cocci_cc" script and
> > > I need to modify one or both scripts to send the cover to the
> > > superset of recipients in the constituent commits.
> > 
> > Try out 'b4'. It's much easier.
> > 
> > In any case, I don't read cover letters. Changes to a patch belong with
> > the patch.
> 
> This is not what most other maintainers do, and there does not appear to be
> a general consensus amongst maintainers that the changes belong in the
> individual patches, or in the cover letter. 

Well, I stole that phrase from someone else (gregkh). 

> Some trees like the networking
> tree do merge commits of patch sets where the cover letter is used as part
> of the merge commit message. Other maintainers don't, and some want the
> change log after the '---' and some do not.

I'm not aware of anyone except for DRM wanting the changelog in the 
final commits, but that's really a different issue.

I'm pretty sure no one will complain about a changelog in the patches. I 
guess you just have to duplicate it if you think it should be in both. 
b4 could be taught to do that I suppose. IMO, the cover letter should 
have a higher level changelog than the individual patches.

Rob
