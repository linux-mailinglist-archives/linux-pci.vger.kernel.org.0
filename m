Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4417E5B468D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIJOGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIJOGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 10:06:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D94E84A;
        Sat, 10 Sep 2022 07:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1303CE0A1A;
        Sat, 10 Sep 2022 14:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61178C433C1;
        Sat, 10 Sep 2022 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662818767;
        bh=OFpRE1VwxpZ9JTn1yIeWnRbRrNomn1uihAu3p5Z1QbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+rxC7XZvgkmp9GZDTGAGPre5zHY089yDIYv/aes6SzF6GoPrV1bTRWWLa3SJT263
         uO50/lxhefH8pxmLe7zZCGMYDObLSWvJqxQgQLa1qaWyMjoMsKZt7BA3jm+Z0Ft4dc
         uekQdbLq8akcmoi1XYCTfJ8xnFQLI6yes5ECAfoY=
Date:   Sat, 10 Sep 2022 16:06:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: PCI: Rework acpi_get_pci_dev()
Message-ID: <YxyZzJkj4B1grGqK@kroah.com>
References: <2661914.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2661914.mvXUDI8C0e@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 10, 2022 at 03:23:46PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The PCI device returned by acpi_get_pci_dev() needs to be registered,
> so if it corresponds to an ACPI device object, the struct acpi_device
> representing that object must be registered too and, moreover, it
> should be the ACPI companion of the given PCI device.  Thus it should
> be sufficient to look for it in the ACPI device object's list of
> physical nodes associated with it.
> 
> Modify the code accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/pci_root.c |   81 ++++++++----------------------------------------
>  1 file changed, 15 insertions(+), 66 deletions(-)

Nice, less code is always better :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
