Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42F154E096
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiFPMMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFPMMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 08:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D344DE2E
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655381554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=jajldWPReQ1mtSlfvSWcdIUi99P1UJJy8BMkiu2fVec=;
        b=YaTTPwrDfale7zS8BZMy6LypK0v9DNA5s/AJJqOIrns50SQ7JgdpFDB0cPzo4f/l3wlWxR
        wHNfrB72AGN2xAyew9+BZduX0Kjs2gwt8fiAhwb01k77IPoDY6YSaEzOgkHis19mXMlPic
        N3UrHvilpexZVagmli9rjxTFQBRrKJI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-WraL2y2uPou7G6VE2C16Ug-1; Thu, 16 Jun 2022 08:12:30 -0400
X-MC-Unique: WraL2y2uPou7G6VE2C16Ug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 936251D33865;
        Thu, 16 Jun 2022 12:12:30 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-0-23.rdu2.redhat.com [10.22.0.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0148E40C141F;
        Thu, 16 Jun 2022 12:12:29 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Hans de Goede" <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        "Zack Rusin" <zackr@vmware.com>
Subject: pci=no_e820 report for vmware fusion
Date:   Thu, 16 Jun 2022 08:12:28 -0400
Message-ID: <1B1241E1-6C7E-42CF-9690-1F47E9F3A6B2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My VMWare Fusion linux VM's display stopped working after an update, 
with:

[.558514] vmwgfx 0000:00:0f.0: vgaarb: deactivate vga console
[.559964] Console: switching to colour dummy device 80x25
[.583703] vmwgfx 0000:00:0f.0: [drm] FIFO at 0x00000000c0000000 size is 
8192 kiB
[.583783] vmwgfx 0000:00:0f.0: [drm] VRAM at 0x00000000e8000000 size is 
131072 kiB
[.583845] vmwgfx 0000:00:0f.0: [drm] Running on SVGA version 2.
[.583863] vmwgfx 0000:00:0f.0: [drm] Capabilities: rect copy, cursor, 
cursor bypass, cursor bypass 2, 8bit emulation, alpha cursor, extended 
fifo, multimon, pitchlock, irq mask, display topology, gmr, traces, 
gmr2, screen object 2, command buffers, command buffers 2, gbobject, dx,
[.583865] vmwgfx 0000:00:0f.0: [drm] DMA map mode: Caching DMA mappings.
[.584003] vmwgfx 0000:00:0f.0: [drm] Legacy memory limits: VRAM = 4096 
kB, FIFO = 256 kB, surface = 0 kB
[.584006] vmwgfx 0000:00:0f.0: [drm] MOB limits: max mob size = 131072 
kB, max mob pages = 98304
[.584008] vmwgfx 0000:00:0f.0: [drm] Max GMR ids is 64
[.584009] vmwgfx 0000:00:0f.0: [drm] Max number of GMR pages is 65536
[.584010] vmwgfx 0000:00:0f.0: [drm] Maximum display memory size is 
131072 kiB
[.619664] vmwgfx 0000:00:0f.0: [drm] Screen Target display unit 
initialized
[.638401] vmwgfx 0000:00:0f.0: [drm] Fifo max 0xffffffff min 0xffffffff 
cap 0xffffffff
[.638406] vmwgfx 0000:00:0f.0: [drm] FIFO memory is not usable. Driver 
failed to initialize.
[.638407] [drm:vmw_request_device [vmwgfx]] *ERROR* Unable to initialize 
the device.

(There's also quite a lot of pci badness entries before this, left out
for brevity).

I bisected the issue to:
4c5e242d3e93 x86/PCI: Clip only host bridge windows for E820 regions

and to confirm that was the problem I attempted a revert of that commit 
on
v5.19-rc1.  The revert had a conflict which pointed me to this commit:
fa6dae5d8208 x86/PCI: Add kernel cmdline options to use/ignore E820 
reserved regions

So - I've added "pci=no_e820" to my kernel parameters, which allows 
vmwgfx
to work properly again, and I'm reporting it here as requested in the 
commit
adding that parameter.

I'm happy to provide more information if needed, or test.

Ben

