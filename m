Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218AD54E29D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377286AbiFPN4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 09:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiFPN4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 09:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C9A546B2A
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655387772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9feRghszYV8xvkI5BqWFGTxy3KTR5NsSues86hER40=;
        b=a5Ypfzhugl0cPHRZoyt3nNmUoGpCcsZtT2ZVua0jAslCuJC+W61gca0Mj0Ha3w5dwCjuKG
        DWt/tPNkMIDE03iPz6XtgX4ASm5XQSCzw4vS0ZHcGPrnPG/wTk5wmtO8Z5eiO66yabLqes
        h9aQnVlw28/I3IQw3BehLfWSCt8Waok=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-l7uPGrEWNsuA2jIyIzWZsQ-1; Thu, 16 Jun 2022 09:56:11 -0400
X-MC-Unique: l7uPGrEWNsuA2jIyIzWZsQ-1
Received: by mail-ej1-f72.google.com with SMTP id kf3-20020a17090776c300b0070d149300e9so644276ejc.15
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 06:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n9feRghszYV8xvkI5BqWFGTxy3KTR5NsSues86hER40=;
        b=n2PTmbbAGyAgTMAEwsKBOZNwkyGaMHedvlhfhWfiVt2kjwmiega9A8k+h/BQfckdDY
         OyRlU3tb8Ul7SL7U38SCZuTU+u955bz5eF0+L1YHKKJtN4quJ8JEn3pSi9A7CVVAKv2k
         JSyt3jABK76UqUu5chvggpEcY2Vb73R9DQxs1PlnKHngWJewLcK4nHzIxwabdDYPqly7
         pC9F1zoeFzmzFF9U2KslrW9mx0uMcar+8ZH7s3uV6FGtjctPNRWPGT8k9vA6NFA6tOpL
         VPkUeLmrq+q2/YuSr+AiN9yBhLUU1WxXcAO0nSVfbZibI7RM2AQiQVrrZaB2wvwW7vaC
         9xCQ==
X-Gm-Message-State: AJIora/t67+ucI/Ob7Y4zF9USBMra9fcJ5BXGjk4Sd5ddV9TGeJNiK4g
        1IYnvF6AUyeXUIPYzZvn5t9egl/8n4n4YUUaRV8bxrt15TOUq0B+d3zjG5sIkVmV7wTdgnbb66h
        GPoDa99r9BAgFzM1D59bc
X-Received: by 2002:a17:906:73cf:b0:713:f60a:8f9 with SMTP id n15-20020a17090673cf00b00713f60a08f9mr4888033ejl.124.1655387769345;
        Thu, 16 Jun 2022 06:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJEScIirHhMMIK6Tlca88G+WaA8xTSV8IZHL2ILBi3TADRY3kVWavfK7rJvl/5eL7RtQuhhg==
X-Received: by 2002:a17:906:73cf:b0:713:f60a:8f9 with SMTP id n15-20020a17090673cf00b00713f60a08f9mr4888022ejl.124.1655387769178;
        Thu, 16 Jun 2022 06:56:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b006fee7b5dff2sm800662ejo.143.2022.06.16.06.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:56:08 -0700 (PDT)
Message-ID: <f1d628c4-5866-5776-cda3-adbce9a42c66@redhat.com>
Date:   Thu, 16 Jun 2022 15:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: pci=no_e820 report for vmware fusion
Content-Language: en-US
To:     Benjamin Coddington <bcodding@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Zack Rusin <zackr@vmware.com>
References: <1B1241E1-6C7E-42CF-9690-1F47E9F3A6B2@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1B1241E1-6C7E-42CF-9690-1F47E9F3A6B2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/16/22 14:12, Benjamin Coddington wrote:
> My VMWare Fusion linux VM's display stopped working after an update, with:
> 
> [.558514] vmwgfx 0000:00:0f.0: vgaarb: deactivate vga console
> [.559964] Console: switching to colour dummy device 80x25
> [.583703] vmwgfx 0000:00:0f.0: [drm] FIFO at 0x00000000c0000000 size is 8192 kiB
> [.583783] vmwgfx 0000:00:0f.0: [drm] VRAM at 0x00000000e8000000 size is 131072 kiB
> [.583845] vmwgfx 0000:00:0f.0: [drm] Running on SVGA version 2.
> [.583863] vmwgfx 0000:00:0f.0: [drm] Capabilities: rect copy, cursor, cursor bypass, cursor bypass 2, 8bit emulation, alpha cursor, extended fifo, multimon, pitchlock, irq mask, display topology, gmr, traces, gmr2, screen object 2, command buffers, command buffers 2, gbobject, dx,
> [.583865] vmwgfx 0000:00:0f.0: [drm] DMA map mode: Caching DMA mappings.
> [.584003] vmwgfx 0000:00:0f.0: [drm] Legacy memory limits: VRAM = 4096 kB, FIFO = 256 kB, surface = 0 kB
> [.584006] vmwgfx 0000:00:0f.0: [drm] MOB limits: max mob size = 131072 kB, max mob pages = 98304
> [.584008] vmwgfx 0000:00:0f.0: [drm] Max GMR ids is 64
> [.584009] vmwgfx 0000:00:0f.0: [drm] Max number of GMR pages is 65536
> [.584010] vmwgfx 0000:00:0f.0: [drm] Maximum display memory size is 131072 kiB
> [.619664] vmwgfx 0000:00:0f.0: [drm] Screen Target display unit initialized
> [.638401] vmwgfx 0000:00:0f.0: [drm] Fifo max 0xffffffff min 0xffffffff cap 0xffffffff
> [.638406] vmwgfx 0000:00:0f.0: [drm] FIFO memory is not usable. Driver failed to initialize.
> [.638407] [drm:vmw_request_device [vmwgfx]] *ERROR* Unable to initialize the device.
> 
> (There's also quite a lot of pci badness entries before this, left out
> for brevity).
> 
> I bisected the issue to:
> 4c5e242d3e93 x86/PCI: Clip only host bridge windows for E820 regions
> 
> and to confirm that was the problem I attempted a revert of that commit on
> v5.19-rc1.  The revert had a conflict which pointed me to this commit:
> fa6dae5d8208 x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions
> 
> So - I've added "pci=no_e820" to my kernel parameters, which allows vmwgfx
> to work properly again, and I'm reporting it here as requested in the commit
> adding that parameter.
> 
> I'm happy to provide more information if needed, or test.

Commit 4c5e242d3e93 breaking things is a known issue and a rever for this is pending:

https://lore.kernel.org/linux-pci/20220612144325.85366-1-hdegoede@redhat.com/

Regards,

Hans

