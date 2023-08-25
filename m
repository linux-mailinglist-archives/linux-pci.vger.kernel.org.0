Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C8788428
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjHYJ6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbjHYJ5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D8EC;
        Fri, 25 Aug 2023 02:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09CDB65077;
        Fri, 25 Aug 2023 09:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E644C433C7;
        Fri, 25 Aug 2023 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957472;
        bh=wn9Jkh1bYBgb1o1HoYf8KaFX/k0+aRWiPyJQ3YOQzAM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Nw0z3ikUigrenXf2bcAAH5FuI3grGcJ/Xe7DRASViJrR1o4kJB/+hUzJqgKURSO24
         d4gDQZ8daMI/6yqagTHHw2Sy7tetCjvfo1nE5QqA2+4TdZLhcMhRIz2vsVjM/Ymujs
         hU9/rDUW05qLSXHQ35azXAZ9COpm9QChJeSNWz9GQ/zLidExkzS5RAa6Y2btS+XF50
         IRBfI4UuJhs6SV4xI7TzCW7lueECJqbTlRqWGO/9uCYgW8v/2Qy8n0Rr5mYwAKGjR+
         WVOJBhALsbhiuk98XcB9vi1R6mnWI85DmNRygapFg/pRVH543Yz/glQbLz0MeWQO5k
         546Q12Ti/S5cA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Fix nomenclature for USB and PCI wireless devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
References: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295746927.1850672.3516049215752193747.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 09:57:51 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:

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
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch applied to wireless-next.git, thanks.

5d7cf67f72ae Fix nomenclature for USB and PCI wireless devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

