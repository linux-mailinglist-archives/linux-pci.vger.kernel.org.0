Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31496798F8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjAXNPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 08:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXNPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 08:15:23 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEA3C286;
        Tue, 24 Jan 2023 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674566114;
  x=1706102114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4ohU+IZCiap51TFkcMjgBOhcJ2qkxrD93kr53aJ4Ho=;
  b=SIMf9frKpHZKmaqGb/Ne7xa/ud0zL2zj/KIyA7x2qDPrRReJEpwBuQl+
   6iDE1hSD2d6MGQTT45OLGfhqu/LIZCcCmxMuSZDDcEpv6tQZgAcAEU8+m
   4c9ogFODHNysFzkNQdXk+C/HqZSw4X5XKVB6NmUvAn4IYlFIaUSuIXXl0
   OBfo9H1BD0IEbtXdPKlYsECSqIHBqnhyNnpgz6UpBhwU1CPEm35GrQ+V+
   KaN5ckVLhWiVH5c5EH6yyk8uDhPNogpDRK+XSMIAfR3+VoYwCvhRI6Jrq
   uW1RtSXOTKsK8bd4KwGE+EPs0rTsrMiRPo5BcH8jw6sQ/xDjSoHaJMvhW
   g==;
Date:   Tue, 24 Jan 2023 14:15:11 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y8/Z3+clVN4MbH/i@axis.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
 <Y86vm0zDOeb1G3zh@axis.com>
 <CAL_JsqLHi_1QJ4s28uM1b_Z2f+Nsu_CusAsqsx6vVOCCAPLMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLHi_1QJ4s28uM1b_Z2f+Nsu_CusAsqsx6vVOCCAPLMgw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 05:36:06PM +0100, Rob Herring wrote:
> On Mon, Jan 23, 2023 at 10:02 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> dtc should complain about this...

It probably does, the test framework currently doesn't report these to
the test runner/writer; maybe it should.

> >         compatible = "virtio,uml";
> 
> Binding?

There was some discussion earlier about whether a binding was needed
here (you were on CC):

 https://lore.kernel.org/lkml/20211222103417.GB25135@axis.com/

> 
> >         virtio-device-id = <1234>;
> >         ranges;
> >
> >         pci {
> >                 #address-cells = <3>;
> >                 #size-cells = <2>;
> >                 ranges = <0x0000000 0 0 0 0xf0000000 0 0x20000>;
> >                 compatible = "virtio,device4d2", "pci";
> 
> "pci" is not a valid compatible string.

I think it's there since I based this tree off from
arch/x86/platform/ce4100/falconfalls.dts.  I see that there is some code
in arch/x86/kernel/devicetree.c to handle this compatible and register
all platform devices under that.  Do we need something like that for UML
instead of this patch?

> 
> >                 device_type = "pci";
> >                 bus-range = <0 0>;
> >
> >                 platform_parent: device@0,0 {
> >                         compatible = "pci494f,dc8";
> >                         reg = <0x00000 0 0 0x0 0x10000>;
> >                         ranges;
> >
> >                         uart@10000 {
> >                                 compatible = "google,goldfish-tty";
> >                                 reg = <0x00000 0 0x10000 0 0x10000>;
> 
> This is not a PCI device, so it shouldn't be using PCI addressing.
> 'ranges' needs an entry (for each BAR) to translate to just a normal
> MMIO bus with 1 or 2 address/size cells. Maybe we want a 'simple-bus'
> node for each BAR. The FPGA series needs the same things, but that
> aspect hasn't really been addressed as the first issue is populating
> the PCI devices dynamically.

Yes, this ranges stuff can be fixed in the Python code which generates
these trees.

In my cases the devicetree blob contains all the devices under the PCI
devices, see my other email.

> The DT address translation code should support all this
> (MMIO->PCI->MMIO), but I don't think there's any existing examples. An
> example (that I can test) would be great. If the unittest had that
> example, I'd be thrilled.

Anyone can run what I'm running since it uses UML and there is no real
hardware, but the setup is a bit more complicated than an in-kernel
unit test since there is a virtio backend in userspace which implements
the "hardware".  If you want to try it:

 git remote add vwax https://github.com/vwax/linux.git
 git fetch vwax
 git checkout vmax/roadtest/platform-wip
 make -C tools/testing/roadtest/ -j24 OPTS="-v -k platform"

You should see a "PASSED roadtest/tests/base/test_platform.py::test_foo"
if it works.  See Documentation/dev-tools/roadtest.rst for more info.
As mentioned in the other email, the only patches to the kernel proper
in that tree are already posted ones and WIP fixes.
