Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE546780BC
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjAWQCt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 11:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAWQCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 11:02:48 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCFCDE9;
        Mon, 23 Jan 2023 08:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674489757;
  x=1706025757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMQj3dXdt191RDB2ZQJX06tDQ+tkoWfkbTYDTVaJLbY=;
  b=UcAGVQnX2iUrmHJs9ozP3yRUWu6a0qMwiWiYv9FA3/zDr9dTQddcF+ie
   pNwT5MMe/RKRV/5ymUjKKKt7a+eFC6Lvcc0HI2eZyzGcZQjwvlvPxIUCx
   4AUO4TiJNpkF3Z/nYUbY3qrAFOQUL+uuqPlHzk3e8fgxskDr5SPlQRcwz
   xCiRllryJViqUmkOQMWGQBuc2X3RxPKeWLyHBJD4aTsb0EqHWAs9sIkqE
   KzhsI/69fzbCLJ4bkZerQr/QOkoaKHgZVYpcIl8qN6MzzvZ9qLdnD5lWU
   8IYBVLMdZvhl0RO/vppCKcpsaFK7y8f07sQ9+pucMNdiL39WStpN0aC7V
   w==;
Date:   Mon, 23 Jan 2023 17:02:35 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Lee Jones <lee@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y86vm0zDOeb1G3zh@axis.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y86op9oh5ldrZQyG@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 04:32:55PM +0100, Lee Jones wrote:
> On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
> > Add a PCI driver which registers all child nodes specified in the
> > devicetree.  It will allow platform devices to be used on virtual
> > systems which already support PCI and devicetree, such as UML with
> > virt-pci.
> > 
> > The driver has no id_table by default; user space needs to provide one
> > using the new_id mechanism in sysfs.
> 
> This feels wrong for several reasons.
> 
> Firstly, I think Greg (Cc:ed) will have something to say about this.
> 
> Secondly, this driver does literally nothing.  

Well, it does do what the commit message says.  If there's another way
of accomplishing that, I'm all ears.

> Why can't you use of of the other, pre-existing "also register my
> children" compatibles?
> 
> See: drivers/bus/simple-pm-bus.c
>      drivers/of/platform.c

simple-pm-bus registers a platform driver, and drivers/of/platform.c
works on the platform bus.  The driver added by this patch is a PCI
driver.  So I don't understand how the files you mention could be used
here?

In case it helps, the relevant nodes in my UML devicetree look something
like this:

    virtio@2 {
        compatible = "virtio,uml";
        virtio-device-id = <1234>;
        ranges;

        pci {
                #address-cells = <3>;
                #size-cells = <2>;
                ranges = <0x0000000 0 0 0 0xf0000000 0 0x20000>;
                compatible = "virtio,device4d2", "pci";
                device_type = "pci";
                bus-range = <0 0>;

                platform_parent: device@0,0 {
                        compatible = "pci494f,dc8";
                        reg = <0x00000 0 0 0x0 0x10000>;
                        ranges;

        		uart@10000 {
        		        compatible = "google,goldfish-tty";
        		        reg = <0x00000 0 0x10000 0 0x10000>;
        		};
                };
        };
    };
