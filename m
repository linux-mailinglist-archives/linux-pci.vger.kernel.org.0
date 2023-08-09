Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1622776205
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjHIOFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjHIOFm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 10:05:42 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2D1022108
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 07:05:41 -0700 (PDT)
Received: (qmail 197404 invoked by uid 1000); 9 Aug 2023 10:05:40 -0400
Date:   Wed, 9 Aug 2023 10:05:40 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Fix nomenclature for USB and PCI wireless devices
Message-ID: <cce342f1-55b9-49ba-81a9-cc9e83735ff9@rowland.harvard.edu>
References: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
 <2023080940-overhand-fondly-7ef7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080940-overhand-fondly-7ef7@gregkh>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 02:16:48PM +0200, Greg KH wrote:
> On Tue, Aug 08, 2023 at 08:44:48PM -0400, Alan Stern wrote:
> > A mouse that uses a USB connection is called a "USB mouse" device (or
> > "USB mouse" for short), not a "mouse USB" device.  By analogy, a WiFi
> > adapter that connects to the host computer via USB is a "USB wireless"
> > device, not a "wireless USB" device.  (The latter term more properly
> > refers to a defunct Wireless USB specification, which described a
> > technology for sending USB protocol messages over an ultra wideband
> > radio link.)
> > 
> > Similarly for a WiFi adapter card that plugs into a PCIe slot: It is a
> > "PCIe wireless" device, not a "wireless PCIe" device.
> > 
> > Rephrase the text in the kernel source where the word ordering is
> > wrong.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Can you accept this patch, or should I ask Johannes Berg or Kalle Valo 
to merge it through the wireless subsystem?

Alan Stern
