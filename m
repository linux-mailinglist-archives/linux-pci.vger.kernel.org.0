Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB07624D1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 23:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGYVvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 17:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGYVvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 17:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0C1FEC;
        Tue, 25 Jul 2023 14:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4171E6191D;
        Tue, 25 Jul 2023 21:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74192C433C7;
        Tue, 25 Jul 2023 21:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690321863;
        bh=cwjUnEpKd3inLxZNqE7zRhpjdwyHJ4S8/pVBZkwz308=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N0KmrS+Trg21R+yMce2RP23J9qPMmSNIHzReUW1Q/AhJC+dk9d0P8sfBK020Wzhnr
         /fhY2gBE/ptvVz/faQJIWeYKcS4bDVHhD4kshaSfK/czF6/6xsuq7qwxIYk4FqfsgC
         mi+mPvsISS/+tGs/jJHtxGJ4rtDT0wg516ZGy0b0jwtS1OG3zMU9eOcIpiD7RubsGu
         5CRyNL29fFg/6x74F0N8eaVJ1dAS1vKFWnNS1PqvLF0m2tn3zp14gYNEfSpr0JY96D
         FrNbLLTuuamFv/H6uyANqzO+o0sOagUImBc2XeZotshXqsGdVhT0X3VftOhdmU2Ypq
         +CnTLmQV38LXg==
Date:   Tue, 25 Jul 2023 16:51:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 4/6] PCI/VGA: Move the new_state assignment out the loop
Message-ID: <20230725215101.GA667452@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c8ca3a6-5898-ccba-cd01-9622215ddd10@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 09:02:14PM +0800, suijingfeng wrote:
> PING, please !

Don't worry, these are not forgotten.  Your other series seems more
important, so that's what I've been paying attention to.

> On 2023/7/11 21:43, Sui Jingfeng wrote:
> > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > 
> > In the vga_arbiter_notify_clients() function, the value of the 'new_state'
> > variable will be 'false' on systems that have more than one PCI VGA card.
> > Its value will be 'true' on systems that have one or no PCI VGA compatible
> > card. In other words, its value is not relevant to the iteration, so move
> > the assignment () out of the loop.
> > 
> > For a system with multiple video cards, this patch saves the redundant
> > assignment.
> > 
> > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > ---
> >   drivers/pci/vgaarb.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > index 668139f7c247..4c448c758bab 100644
> > --- a/drivers/pci/vgaarb.c
> > +++ b/drivers/pci/vgaarb.c
> > @@ -1468,22 +1468,20 @@ static void vga_arbiter_notify_clients(void)
> >   {
> >   	struct vga_device *vgadev;
> >   	unsigned long flags;
> > -	uint32_t new_decodes;
> > -	bool new_state;
> > +	bool state;
> >   	if (!vga_arbiter_used)
> >   		return;
> > +	state = (vga_count > 1) ? false : true;
> > +
> >   	spin_lock_irqsave(&vga_lock, flags);
> >   	list_for_each_entry(vgadev, &vga_list, list) {
> > -		if (vga_count > 1)
> > -			new_state = false;
> > -		else
> > -			new_state = true;
> >   		if (vgadev->set_decode) {
> > -			new_decodes = vgadev->set_decode(vgadev->pdev,
> > -							 new_state);
> > -			vga_update_device_decodes(vgadev, new_decodes);
> > +			unsigned int decodes;
> > +
> > +			decodes = vgadev->set_decode(vgadev->pdev, state);
> > +			vga_update_device_decodes(vgadev, decodes);
> >   		}
> >   	}
> >   	spin_unlock_irqrestore(&vga_lock, flags);
> 
