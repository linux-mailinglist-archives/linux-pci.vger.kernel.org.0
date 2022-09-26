Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E475EB4BE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 00:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIZWpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIZWpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 18:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7D63FE;
        Mon, 26 Sep 2022 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B68F612E7;
        Mon, 26 Sep 2022 22:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F9CC433D7;
        Mon, 26 Sep 2022 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664232304;
        bh=cUtzvwGQvd2Ow1SY0ZECPOrLqVJpgTMsKtMEKiLNw0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DM33jnOUDfmg9yiXQybCFQ5+OdLzcz5NuxH/wopER/MPRfZbVz9QVcExNtUUQv8KI
         sZLCMJjcNAZKWMLAOeRk7x81U1UdUhTzwTxTskuJMovavfPi7S6qbUIJxpCbfAV+Vv
         9Zxcb/9N6G6TYlhmN8OfOMN1nMz5CHfsZKJRuQQRpZNouZr/0ddX3ZNZfX86qU/u+W
         p7/0sxOrusyxPRmbgrQlngL/BL00+vfR7VqEaI7Cq6O+MkRlv4dTF0gQ0n4jXRFnjo
         frwLMsv05AWrgVxSFiekA/P4Qg203GlFxDWWL+btH/cmERXN0qOQw+6RF2HvnqLQne
         8/hsMtz4qElPw==
Received: by mail-vk1-f181.google.com with SMTP id k14so4160078vkk.0;
        Mon, 26 Sep 2022 15:45:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf2TyFdp6h/MJeEGTKL9otlz7rXtDiOH8+q01iLy9XUnZxCkLnfE
        FiD7kO6CKi8vli1GSY1i3nGKDSujrN4On/f4yA==
X-Google-Smtp-Source: AMsMyM7wC4yByxpxIaR8Svkq6Cx2zw5rjKAa9XCbrWV+4wDC6BoRsEsVbez5bQF6lzXc83bU4uKmMtUsDlUABID3vVA=
X-Received: by 2002:a1f:240f:0:b0:3a3:7b48:81cd with SMTP id
 k15-20020a1f240f000000b003a37b4881cdmr9868743vkk.19.1664232303792; Mon, 26
 Sep 2022 15:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com> <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
In-Reply-To: <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Sep 2022 17:44:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
Message-ID: <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 6:15 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 8/29/22 16:43, Lizhi Hou wrote:
> > This patch series introduces OF overlay support for PCI devices which
> > primarily addresses two use cases. First, it provides a data driven method
> > to describe hardware peripherals that are present in a PCI endpoint and
> > hence can be accessed by the PCI host. An example device is Xilinx/AMD
> > Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
> > driver -- often used in SoC platforms -- in a PCI host based system. An
> > example device is Microchip LAN9662 Ethernet Controller.
> >
> > This patch series consolidates previous efforts to define such an
> > infrastructure:
> > https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
> > https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> >
> > Normally, the PCI core discovers PCI devices and their BARs using the
> > PCI enumeration process. However, the process does not provide a way to
> > discover the hardware peripherals that are present in a PCI device, and
> > which can be accessed through the PCI BARs. Also, the enumeration process
> > does not provide a way to associate MSI-X vectors of a PCI device with the
> > hardware peripherals that are present in the device. PCI device drivers
> > often use header files to describe the hardware peripherals and their
> > resources as there is no standard data driven way to do so. This patch> series proposes to use flattened device tree blob to describe the
> > peripherals in a data driven way.
>
> > Based on previous discussion, using
> > device tree overlay is the best way to unflatten the blob and populate
> > platform devices.
>
> I still do not agree with this statement.  The device tree overlay
> implementation is very incomplete and should not be used until it
> becomes more complete.  No need to debate this right now, but I don't want
> to let this go unchallenged.

Then we should remove overlay support. The only way it becomes more
complete is having actual users.

But really, whether this is the right solution to the problem is
independent of the state of kernel overlay support.

> If there is no base system device tree on an ACPI based system, then I
> am not convinced that a mixed ACPI / device tree implementation is
> good architecture.

Most/all of this series is needed for a DT system in which the PCI
devices are not populated in the DT.

>  I might be more supportive of using a device tree
> description of a PCI device in a detached device tree (not linked to
> the system device tree, but instead freestanding).  Unfortunately the
> device tree functions assume a single system devicetree, with no concept
> of a freestanding tree (eg, if a NULL device tree node is provided to
> a function or macro, it often defaults to the root of the system device
> tree).  I need to go look at whether the flag OF_DETACHED handles this,
> or if it could be leveraged to do so.

Instead of worrying about a theoretical problem, we should see if
there is an actual problem for a user.

I'm not so worried about DT functions themselves, but places which
have 'if ACPI ... else (DT) ...' paths.

Rob
