Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB767AF72
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjAYKPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 05:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYKPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 05:15:42 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225DF773;
        Wed, 25 Jan 2023 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674641741;
  x=1706177741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlFVmobLzB8+d7JlS4oaIjn/VGWKDV7B/1AmomosFQQ=;
  b=hWx0QgsiIGF9na8abYLhZXyG7/BW5wfhEELEtuRAMgwzf5llmIldwB+P
   KuL099WRhCm0QL9ykzSLe3XDOH39C+lnkMP2813ekf454iF4BrEs5/NKw
   1GDbGRFTfml5FJPrdATaDsytiZgpN71oZ+rl/E/bCcG3dVxjmOaA+6W+p
   oQoypo79jPVDM6+5CXIzf37YwOjKF1rgZhGjkAyKz0mF0oSp2y2hojJls
   Oj31LtdCXoK5fw1pj3735R/tjeJdwGgm0gFZJMjiZIgBQYNTnvkR6Ryln
   CzYphq/AEzJfhHvZqcX+KVkkPVxDu5jHKOAXi+yuUgTEEVvzKPykiPuRF
   w==;
Date:   Wed, 25 Jan 2023 11:15:38 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>, <robh@kernel.org>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y9EBSmOoE5+83jS5@axis.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
 <Y862WTT03/JxXUG8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y862WTT03/JxXUG8@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 05:31:21PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 23, 2023 at 03:32:55PM +0000, Lee Jones wrote:
> > On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
> > 
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
> 
> Yes, this isn't ok.  Please write a real driver for the hardware under
> control here, and that would NOT be a MFD driver (hint, if you want to
> split up a PCI device into different drivers, use the aux bus code, that
> is what it is there for.)

I hope it's clear from my other replies in this thread that the entire
purpose of this driver is to allow arbitrary platform devices to be used
via a PCI device in virtual environments like User Mode Linux in order
to test existing platform drivers using mocked hardware.

Given this "hardware", it's not clear what a "real driver" would do
differently.  The auxiliary bus cannot be used since it naturally does
not support platform devices.  A hard coded list of sub-devices cannot
be used since arbitrary platform devices with arbitrary devicetree
properties need to be supported.

I could move this driver to drivers/bus/ and pitch it as a
"PCI<->platform bridge for testing in virtual environments", if that
makes more sense.
