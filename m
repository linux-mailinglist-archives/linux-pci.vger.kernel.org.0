Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E36775EA8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHIMQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 08:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D2DF;
        Wed,  9 Aug 2023 05:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D22963834;
        Wed,  9 Aug 2023 12:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A486C433C8;
        Wed,  9 Aug 2023 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691583410;
        bh=fhlCDOO7YuFkzPjnTCoHyb9IK82UtrqsMxIb95H7Xv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpgT9uOnkBuyZhTSRICFZ96AajV0o2W3kbp1aw6iQd0BBoWDMPc46Lvx0InOvAHp6
         HQjPlNjD465TJSGMRgVgN/uAycgZXIue+eJZaN4UZOkyn8CL3gaCHkqfFRfVPSL50g
         xEVEiU6yNCGBWfwQn05gJyVXWFKtunUb/u3gDzcU=
Date:   Wed, 9 Aug 2023 14:16:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Fix nomenclature for USB and PCI wireless devices
Message-ID: <2023080940-overhand-fondly-7ef7@gregkh>
References: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 08:44:48PM -0400, Alan Stern wrote:
> A mouse that uses a USB connection is called a "USB mouse" device (or
> "USB mouse" for short), not a "mouse USB" device.  By analogy, a WiFi
> adapter that connects to the host computer via USB is a "USB wireless"
> device, not a "wireless USB" device.  (The latter term more properly
> refers to a defunct Wireless USB specification, which described a
> technology for sending USB protocol messages over an ultra wideband
> radio link.)
> 
> Similarly for a WiFi adapter card that plugs into a PCIe slot: It is a
> "PCIe wireless" device, not a "wireless PCIe" device.
> 
> Rephrase the text in the kernel source where the word ordering is
> wrong.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
