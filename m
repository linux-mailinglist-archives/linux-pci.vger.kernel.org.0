Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A5678179
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 17:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjAWQb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjAWQbZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 11:31:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A5E29E0F;
        Mon, 23 Jan 2023 08:31:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4A960F89;
        Mon, 23 Jan 2023 16:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801E5C433D2;
        Mon, 23 Jan 2023 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674491484;
        bh=6IfgOcum2gcVYU1kyOtSd1JBd1Ps0O92g/32DAGgyWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2ztuD0bELDmW6cyWLq00lGxLC9w2npeBI9wEG/tIx654z/SK4IGqXtppB4HAfQcG
         TuKDhr5uBOyZHknyuumgf+5HDL+vAtAVblN2gM6guZADpCLeziRkR+tcKvSOmEQDar
         dPQwPlo9MxFMivREynyzVsrCaG8fL3MzFqxl6nD0=
Date:   Mon, 23 Jan 2023 17:31:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y862WTT03/JxXUG8@kroah.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86op9oh5ldrZQyG@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 03:32:55PM +0000, Lee Jones wrote:
> On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
> 
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

Yes, this isn't ok.  Please write a real driver for the hardware under
control here, and that would NOT be a MFD driver (hint, if you want to
split up a PCI device into different drivers, use the aux bus code, that
is what it is there for.)

thanks,

greg k-h
