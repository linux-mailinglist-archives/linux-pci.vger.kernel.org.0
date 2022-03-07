Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F974D00B7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiCGOJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 09:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCGOJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 09:09:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA64F9F9;
        Mon,  7 Mar 2022 06:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08ED9B81597;
        Mon,  7 Mar 2022 14:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69539C340F6;
        Mon,  7 Mar 2022 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646662089;
        bh=xwPfd4oUhK0TVFJjZo+icYnrwgPQRppqm/ixqy4gIXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m0rwrj7qlWY/EyMdyBJDNDEXDikR7zso2HjNnW2bUT9o1A26Z6NnUbCPYSVY1RmPf
         mGLDda0SKzo3lVxS7xagvMe2G1eaiWjq2BhjmBPcGekL8DLRK7IJhXYVgBXgFLt9Ck
         R9wqRIsgMmZkxmZkfjt6rADhYIiG7lg9XJcEWOHIAW7ryAoeX1DBuSCa3qM3MIN3xm
         I/joxteK4oZIZKHgO1MOXDCAK3E4ASHeK3vTzy0pIecSTGa4hFGS/te+bynMH4/D64
         eLY3+8pz/lNH8B3i8y3RZLki77q3sGh6go+bkBa4nW/1D96msiY+BEy58B+mWbU3b4
         p8In8A0fCdEIA==
Received: by mail-ej1-f47.google.com with SMTP id gb39so32160956ejc.1;
        Mon, 07 Mar 2022 06:08:09 -0800 (PST)
X-Gm-Message-State: AOAM531JljW453JfrmNmnVLPB0//iT+fzdc1Vopd3m7/ZBVQK++j3vcT
        xzgNGhVETwIP9bGuG18mjJprEBd7VjOeXCs7gA==
X-Google-Smtp-Source: ABdhPJzMof6nh2tIW5O1gtyTBMRNuW0EC9U2ehitf8RLTVsZTMRoiK03mrkYD78lkZPwnTij7Nwt3mVGPNKa945XkG4=
X-Received: by 2002:a17:906:a38e:b0:6da:a1f9:f9ee with SMTP id
 k14-20020a170906a38e00b006daa1f9f9eemr8781198ejz.27.1646662087585; Mon, 07
 Mar 2022 06:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20220305052304.726050-1-lizhi.hou@xilinx.com> <20220305052304.726050-3-lizhi.hou@xilinx.com>
 <e4c058e9-6549-4ce2-be05-d09d5b1a9fc9@redhat.com>
In-Reply-To: <e4c058e9-6549-4ce2-be05-d09d5b1a9fc9@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Mar 2022 08:07:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzxq8T=obPQwXeNyqedQOKkmm8hwHdfVgKr15EyAgBnQ@mail.gmail.com>
Message-ID: <CAL_JsqKzxq8T=obPQwXeNyqedQOKkmm8hwHdfVgKr15EyAgBnQ@mail.gmail.com>
Subject: Re: [PATCH V1 RESEND 2/4] Documentation: devicetree: bindings: add
 binding for PCIe endpoint bus
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Max Zhen <maxz@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Yu Liu <yliu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 6, 2022 at 9:37 AM Tom Rix <trix@redhat.com> wrote:
>
> Lizhi,
>
> Sorry for the delay, I am fighting with checking this with 'make
> dt_binding_check'
>
> There is a recent failure in linux-next around display/mediatek,*
> between next-20220301 and next-20220302 that I am bisecting.

There's already patches for that posted.

Just use 'make -k'.

>
> There are a couple of checkpatch --strict warnings for this set, the
> obvious one is adding to the MAINTAINERS for new files.
>
> Tom
>
> On 3/4/22 9:23 PM, Lizhi Hou wrote:
> > Create device tree binding document for PCIe endpoint bus.
> >
> > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> > ---
> >   .../devicetree/bindings/bus/pci-ep-bus.yaml   | 72 +++++++++++++++++++
> >   1 file changed, 72 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> > new file mode 100644
> > index 000000000000..0ca96298db6f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/pci-ep-bus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PCIe Endpoint Bus binding
> > +
> > +description: |
> > +  PCIe device may use flattened device tree to describe apertures in its
> > +  PCIe BARs. The Bus PCIe endpoint node is created and attached under the
> > +  device tree root node for this kind of device. Then the flatten device
> > +  tree overlay for this device is attached under the endpoint node.
> > +
> > +  The aperture address which is under the endpoint node consists of BAR
> > +  index and offset. It uses the following encoding:
> > +
> > +    0xIooooooo 0xoooooooo
> > +
> > +  Where:
> > +
> > +    I = BAR index
> > +    oooooo oooooooo = BAR offset
> > +
> > +  The endpoint is compatible with 'simple-bus' and contains 'ranges'
> > +  property for translating aperture address to CPU address.


This binding is completely confusing because 'PCIe endpoint' is
generally used (in context of bindings and Linux) for describing the
endpoint's system (i.e. the internal structure of a PCIe device (e.g.
add-in card) from the view of its own processor (not the host
system)). This binding seems to be describing the host system's view
of a PCIe device. We already have that! That's just the PCI bus
binding[1] which has existed for ~25 years.

For a non-DT system, what you are going to need here is some way to
create DT nodes of the PCI bus hierarchy or at least from your device
back up to the host bridge. I would suggest you solve that problem
separately from implementing the FPGA driver by making it work first
on a DT based system.

Rob

[1] https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
