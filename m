Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2D68A90E
	for <lists+linux-pci@lfdr.de>; Sat,  4 Feb 2023 09:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBDIuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Feb 2023 03:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBDIuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2023 03:50:23 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3E17148;
        Sat,  4 Feb 2023 00:50:20 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0DCF1300002D0;
        Sat,  4 Feb 2023 09:50:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E72C5275D55; Sat,  4 Feb 2023 09:50:18 +0100 (CET)
Date:   Sat, 4 Feb 2023 09:50:18 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, Zeno Davatz <zdavatz@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "fbdev: Remove conflicting devices on PCI bus"
Message-ID: <20230204085018.GA31758@wunner.de>
References: <20230203230909.2058637-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203230909.2058637-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 05:09:09PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 145eed48de278007f646b908fd70ac59d24ed81a.
> 
> Zeno Davatz reported that 145eed48de27 ("fbdev: Remove conflicting devices
> on PCI bus") caused a console hang.  The machine was actually still usable
> via ssh, etc., but there was no activity on the console.
> 
> Reverting 145eed48de27 for the nvidiafb on that system fixed the problem.
> 
> Revert 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus") since
> we don't know what caused the problem.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216859

Shouldn't that rather be:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216859
Fixes: 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus")
Cc: stable@vger.kernel.org # v6.1+

?

> Reported-by: Zeno Davatz <zdavatz@gmail.com>
> Tested-by: Zeno Davatz <zdavatz@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
