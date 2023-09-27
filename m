Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DBC7B0AD3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjI0RHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 13:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0RHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 13:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1AE5;
        Wed, 27 Sep 2023 10:07:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5FDC433CA;
        Wed, 27 Sep 2023 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695834437;
        bh=ww8RDx9hkAQpnQEyKaBryIAZS7sFZDCDMf/pXai+c9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pONniO0Wh/r657qy6wzumxLdiRzPPpwd5i5nolw/BqVERxHHVS13jzYKlPW/cqtZM
         v8sxdbM0gJh+HkGRDYS0dxo2G9ulEQ/L0ziwKzZLVrPtSaEws2hXWDj6qNUz2slwUc
         0K1VsnlFFGiOF8SRTviD38W4tFKZK25/ljWADwS1jKOZGHYMMQ75O3XscT/9i4zSz1
         TKMB4mn/0ntURaEZZoAXkIYlFBW0Jdxpl3UByarb8geZGVfZw1LIJ/NZZtpgQrLPuy
         /w9DehAbGSlOWQUIzo8lMKhXGLBj5JvcH2QBxGo02OoDG7z5nOPFp+h3xhO2je9YT+
         t67pZWP6WrurQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5048156976cso2810847e87.2;
        Wed, 27 Sep 2023 10:07:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YzewQ3TrswF6TktxSRXSTCcclJLMYYBXLha+te2kXY2mPlHKr1Y
        2aAzbc4ZcbJ/oCMLK4gJ4fJon4MlW+XBMPxSfQ==
X-Google-Smtp-Source: AGHT+IGOLYTox/AsEEvFcAMKFEwLQY4eI4MKNQ5mu482nElyCsj5ZwnSX1DOvDq1FlFAXqyncxX32XFlR0U+KrDkKh0=
X-Received: by 2002:a05:6512:11c6:b0:502:d35b:5058 with SMTP id
 h6-20020a05651211c600b00502d35b5058mr1936935lfr.4.1695834435296; Wed, 27 Sep
 2023 10:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230926155351.31117-1-robh@kernel.org> <20230926155613.33904-3-robh@kernel.org>
 <20230927-utmost-copied-6982126a7f00@spud>
In-Reply-To: <20230927-utmost-copied-6982126a7f00@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Sep 2023 12:07:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFxAf1MA2qhENGFH6Rim2ePWf8Y3RGxiUGyH3uKMC63Q@mail.gmail.com>
Message-ID: <CAL_JsqLFxAf1MA2qhENGFH6Rim2ePWf8Y3RGxiUGyH3uKMC63Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: brcm,iproc-pcie: Fix 'msi' child
 node schema
To:     Conor Dooley <conor@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 10:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Sep 26, 2023 at 10:56:09AM -0500, Rob Herring wrote:
> > The 'msi' child node schema is missing constraints on additional proper=
ties.
> > It turns out it is incomplete and properties for it are documented in t=
he
> > parent node by mistake. Move the reference to msi-controller.yaml and
> > the custom properties to the 'msi' node. Adding 'unevaluatedProperties'
> > ensures all the properties in the 'msi' node are documented.
> >
> > With the schema corrected, a minimal interrupt controller node is neede=
d
> > to properly decode the interrupt properties since the example has
> > multiple interrupt parents.
>
> I suppose this is an ABI break, but the patch just makes the binding
> match the example and intent.

It also matches what the in tree users do, so not an ABI break. I
imagine the .txt binding just listed out properties and the conversion
carried that over.

> Feels like of all the patches doing the
> unevaluatedProperty additions, this one is the most deserving of a fixes
> tag, since the original binding just seems to be completely wrong?

Yes, though the example fix is a dependency, so probably not worth backport=
ing.

Fixes: 905b986d099c ("dt-bindings: pci: Convert iProc PCIe to YAML")

Rob
