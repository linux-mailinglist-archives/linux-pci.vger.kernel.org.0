Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2178C7DBF1E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 18:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjJ3RjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjJ3RjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 13:39:17 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1C9F;
        Mon, 30 Oct 2023 10:39:15 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6cd0963c61cso2784910a34.0;
        Mon, 30 Oct 2023 10:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687554; x=1699292354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL5sPl/w8vDjf8pBGkQ+f7hcgojiJXVMhJqzcYyf7Xo=;
        b=dCQ7Ee+lErEoXsaC4hw/xHHHuJCiFpcOfFO8jI6389ycXCTEbTErklPdR9vdYvSSlV
         63BmXBXt4dp96hRmErIPEP+FXgcC/lbtjpx/CS6tSm391Q3BFllSZiKCJKUNOUdkjFMB
         DUzfHyhM/HResygCTgvoLavHM+S/HsWIGLTftdxsK87XB3q/qMsvl//JXH+j0AlhMZAm
         Jw437zljnY/qWOkooRZ5nqXtyafEgvxRSddew68fBU1LXFOdP7CHbAQl9LWLDOwkgFnl
         1eANUTzPJnl6zkgT5adx0EOGYZR03MnlJLz+QSnQvEGOzB9oq0Vx1JOIkDScZ5kdNq8G
         f/uQ==
X-Gm-Message-State: AOJu0YxfC5SMnKgcbxH+jfB04xpKwIfSnSVvxrdT+zf++nhM3s3EsaK2
        +NTifCVDoJEnmQh4C9GY2ysw1IAnkA==
X-Google-Smtp-Source: AGHT+IGSdyjzY+Dn3bq4Bh7ap3Gr2pddOrv8053BF0SjTVwXZIpxBstB5fwM7hv+revgOdMeLxprvA==
X-Received: by 2002:a05:6830:16:b0:6be:fd51:cb6d with SMTP id c22-20020a056830001600b006befd51cb6dmr8298349otp.31.1698687554377;
        Mon, 30 Oct 2023 10:39:14 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id d15-20020a4ae82f000000b0057b74352e3asm1829619ood.25.2023.10.30.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:39:13 -0700 (PDT)
Received: (nullmailer pid 1558666 invoked by uid 1000);
        Mon, 30 Oct 2023 17:39:11 -0000
Date:   Mon, 30 Oct 2023 12:39:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory
 atu reg
Message-ID: <20231030173911.GA1483352-robh@kernel.org>
References: <20231027145422.40265-1-nks@flawful.org>
 <20231027145422.40265-2-nks@flawful.org>
 <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
 <ZTvh51PGCBhSjURY@x1-carbon>
 <CAL_JsqKu9VxUrEbvyV0EFi-HhXstitu1sk0jQpbYqTDKY4N3=A@mail.gmail.com>
 <ZTz6VaFtO28JZw48@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTz6VaFtO28JZw48@x1-carbon>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 28, 2023 at 12:11:02PM +0000, Niklas Cassel wrote:
> On Fri, Oct 27, 2023 at 12:03:15PM -0500, Rob Herring wrote:
> > On Fri, Oct 27, 2023 at 11:15 AM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
> > >
> > > Hello Rob,
> > >
> > > On Fri, Oct 27, 2023 at 10:58:28AM -0500, Rob Herring wrote:
> > > > On Fri, Oct 27, 2023 at 9:56 AM Niklas Cassel <nks@flawful.org> wrote:
> > > > >
> > > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > > >
> > > > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > > > using:
> > > > >
> > > > > allOf:
> > > > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > >
> > > > > and snps,dw-pcie.yaml does have the atu reg defined, in order to be
> > > > > able to use this reg, while still making sure 'make CHECK_DTBS=y'
> > > > > pass, we need to add this reg to rockchip-dw-pcie.yaml.
> > > > >
> > > > > All compatible strings (rockchip,rk3568-pcie and rockchip,rk3588-pcie)
> > > > > should have this reg.
> > > > >
> > > > > The regs in the example are updated to actually match pcie3x2 on rk3568.
> > > >
> > > > Breaking compatibility on these platforms is okay because ...?
> > >
> > > I don't follow, could you please elaborate?
> > 
> > A DT which was valid without 'atu' region is now not valid with this
> > change. If I'm reading this schema with the change, then not having
> > 'atu' is an error and the OS can treat it as an error. If it does,
> > then it wouldn't work with existing DTs. You cannot add new required
> > properties or required entries.
> > 
> > If you can say no users of the affected platforms care (e.g. only you
> > have a board) or the binding is not yet in use, then it's fine. But
> > you have to state that justification. I suspect that is not the case
> > here.
> 
> FWIW, I had "atu" as optional in v2 of this series.

Right, that was "correct".

> Since I made the effort in v3 to add "atu" to all the existing users of the
> rockchip binding, I thought that marking it required in the rockchip binding
> would help ensure that any future rockchip platform does not forget to add
> "atu".

It would nice to test both this kind of thing and compatibility. The 
only way I know of to do that is with 'deprecated' keyword which still 
needs support in dtschema to remove all the deprecated schemas (which 
would then cause warnings). That's not hard, I just haven't done it 
yet.

To use 'deprecated' here, you could do something like this:

items:
  - ...
  - ...
  - ...
  - ...
allOf:
  - deprecated: true
    minItems: 3

However, that would also not work because we implicitly add 'minItems: 
4', but that could be fixed.

For 'required', we'd need a 'oneOf' with 2 lists of required properties 
which is kind of ugly.


> I know that DT has to be backwards compatible, but the device driver works
> fine with a DT that lacks "atu" (even though you will not be able to detect
> all iATUs), so an old DT would still work.
> 
> But yes, running make CHECK_DTBS=y with the new binding, would not pass for
> an old DT.
> 
> I get your point, you can never add a required property or entries to an
> existing compatible (this is in use).

We may test for this at some point. I want to be able to test for ABI 
breaks rather than catch them in reviews. Right now I'm just kicking 
around ideas in my head on how to do that...


> If we look at snps,dw-pcie.yaml, "atu" is optional, so that correlates to
> the device driver being able to work without "atu" specified.
> 
> Since the rockchip driver doesn't get "atu" itself, but relies on the common
> code to get it, it should obviously be optional also for the rockchip binding.

The way this binding works is snps,dw-pcie.yaml defines the set of 
common properties. The SoC specific binding still has to define which 
ones it uses. It's some duplication, but there's not really any way 
around it on these licensed IPs unless the bindings are complete up 
front.

> I guess my problem is that I just want to inherit the entry from the common
> binding...
> 
> Is there no DT keyword to extend an existing binding, so that you inherit all
> the properties/entries from that common binding, while still allowing you to
> define (or overload) additional properties/entries?
> 
> Even if there is no way to inherit all properties/entries from a common binding,
> it would be nice to be able to inherit a specific property/entry using a
> "inherit" keyword, such that you get the same definition (optional/required) as
> the parent binding.

The only way to inherit is via a $ref. We can only add more constraints 
to a parent/referenced binding.

You could have a $ref to 
"snps,dw-pcie.yaml#/properties/reg-names/items/oneOf/3" to get the 4th 
reg-name in the list of common properties. I wouldn't recommend doing 
that because I think it will be fragile and difficult to maintain.

Rob
