Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F6678198
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjAWQg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 11:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAWQgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 11:36:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E25C2BEDE;
        Mon, 23 Jan 2023 08:36:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3820B80E1B;
        Mon, 23 Jan 2023 16:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506C0C433EF;
        Mon, 23 Jan 2023 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674491779;
        bh=AxBO3V3F1xrbiz/Mbhffwx/FnH412OzsVmPsuOaEMLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUKX/or37qqcXl54rVudS4L7c9LgcbyoESwmvzIP+WdYxcIFtgvGOr3QZzdgTGtWt
         vf/vfYxAPfinJy2bVOWntkWM+l3MnF7VRcKY51QLvD/Qf0NA2e5p/daQtDKbKefWY6
         pPe5LcZobi61A9ah9xc27hDW7PZK9nDBnsGlmPAG65KEwAfvWIV3z30SrW4rXVt5dc
         9bRmaI/rtS17WZRzZVd3/2ijy3LfqugfYz8gj95JEFrh/2nsG5HWRNnRyw8lyWhoe3
         AXw6V69DwCpmy/2z27RzOa+depb6XzvZINcMl1Uv+F3Y177yHjxXso4TT2PtKpfSnT
         2QeuXeuzNnFBg==
Received: by mail-vs1-f41.google.com with SMTP id 187so13500765vsv.10;
        Mon, 23 Jan 2023 08:36:19 -0800 (PST)
X-Gm-Message-State: AFqh2kpU9mNk219TD4bmUh6B2SzkLwqpION2W9TT/gXnoocS4LaRolxn
        nuxaQKy/ddEfkphE+VDguAs0A6VrEzHOwWfg3w==
X-Google-Smtp-Source: AMrXdXu3pCIoB8dsXe8Tvo5zBJoxkgd1o5Vu4tzxyPoIid2tct1oVfjZC2MhOb+NxgPmPOi4l8vIxC08ulBVxn321RU=
X-Received: by 2002:a67:f506:0:b0:3d3:c767:4570 with SMTP id
 u6-20020a67f506000000b003d3c7674570mr3764389vsn.85.1674491778189; Mon, 23 Jan
 2023 08:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com> <Y86vm0zDOeb1G3zh@axis.com>
In-Reply-To: <Y86vm0zDOeb1G3zh@axis.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jan 2023 10:36:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHi_1QJ4s28uM1b_Z2f+Nsu_CusAsqsx6vVOCCAPLMgw@mail.gmail.com>
Message-ID: <CAL_JsqLHi_1QJ4s28uM1b_Z2f+Nsu_CusAsqsx6vVOCCAPLMgw@mail.gmail.com>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 10:02 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Mon, Jan 23, 2023 at 04:32:55PM +0100, Lee Jones wrote:
> > On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
> > > Add a PCI driver which registers all child nodes specified in the
> > > devicetree.  It will allow platform devices to be used on virtual
> > > systems which already support PCI and devicetree, such as UML with
> > > virt-pci.
> > >
> > > The driver has no id_table by default; user space needs to provide one
> > > using the new_id mechanism in sysfs.
> >
> > This feels wrong for several reasons.
> >
> > Firstly, I think Greg (Cc:ed) will have something to say about this.
> >
> > Secondly, this driver does literally nothing.
>
> Well, it does do what the commit message says.  If there's another way
> of accomplishing that, I'm all ears.
>
> > Why can't you use of of the other, pre-existing "also register my
> > children" compatibles?
> >
> > See: drivers/bus/simple-pm-bus.c
> >      drivers/of/platform.c
>
> simple-pm-bus registers a platform driver, and drivers/of/platform.c
> works on the platform bus.  The driver added by this patch is a PCI
> driver.  So I don't understand how the files you mention could be used
> here?
>
> In case it helps, the relevant nodes in my UML devicetree look something
> like this:
>
>     virtio@2 {

dtc should complain about this...

>         compatible = "virtio,uml";

Binding?

>         virtio-device-id = <1234>;
>         ranges;
>
>         pci {
>                 #address-cells = <3>;
>                 #size-cells = <2>;
>                 ranges = <0x0000000 0 0 0 0xf0000000 0 0x20000>;
>                 compatible = "virtio,device4d2", "pci";

"pci" is not a valid compatible string.

>                 device_type = "pci";
>                 bus-range = <0 0>;
>
>                 platform_parent: device@0,0 {
>                         compatible = "pci494f,dc8";
>                         reg = <0x00000 0 0 0x0 0x10000>;
>                         ranges;
>
>                         uart@10000 {
>                                 compatible = "google,goldfish-tty";
>                                 reg = <0x00000 0 0x10000 0 0x10000>;

This is not a PCI device, so it shouldn't be using PCI addressing.
'ranges' needs an entry (for each BAR) to translate to just a normal
MMIO bus with 1 or 2 address/size cells. Maybe we want a 'simple-bus'
node for each BAR. The FPGA series needs the same things, but that
aspect hasn't really been addressed as the first issue is populating
the PCI devices dynamically.

The DT address translation code should support all this
(MMIO->PCI->MMIO), but I don't think there's any existing examples. An
example (that I can test) would be great. If the unittest had that
example, I'd be thrilled.

Rob
