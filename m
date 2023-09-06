Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918F793877
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjIFJkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjIFJkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 05:40:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38651BB;
        Wed,  6 Sep 2023 02:40:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so4995558a12.0;
        Wed, 06 Sep 2023 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693993217; x=1694598017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9Vb47gswGc4CRFmCgVTREKIby3QhfxygfFTeY7yqU8=;
        b=SZ5DPSaBZtfZj9QtIGZSY4NR1KxRJkc/QMXW17GhW+2hsNX7I1ccja4g2U+5Eivv+Z
         A7p/0aE8XI/AOPAPbjmSnnkcQdD8mLq3/Gvo5/StG/x9ZdBUIk9nNYz0MA08Xz9/zQ5s
         Y99+NJpEDL7rQYm+Ep6Ns0VFfZySKaCC2TgPCy1Fr04yacxAmTQsltzf+Qdb0bfBA7qA
         g06TxD4gka/iPx75pbKV6RdgI8q3JWhNUmyQ9apjA5EKseKBdtNlmdGviVrBHfvpijL8
         tRsK2ToeJvp82EGb3XOrmKZZuUex3rDSPxpm+Wr4CafVgJTcdAhKVZJIpSDZsVIcEMDL
         ZFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993217; x=1694598017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9Vb47gswGc4CRFmCgVTREKIby3QhfxygfFTeY7yqU8=;
        b=F8/C7Dpu0O2wbJjw8bTqmvhH0NY79O0BxddL53QoAI5T1Q2JjNP/d2H2Se+vgccTpX
         F8iFnUR4ScpQwknzY1KzwKNG783RsnRNyTSy0EfMVCZwl3Bsax7RD/C0JbrDCJQaIo8o
         RMNdggzfRWxaYwXhHcN12XQdRTQrBBJSVmRnkNCtD6JE7SSqNrGiVjvjVszreTXOcLdf
         VZbCDdcxyh1CHuf+i1G7kNSfkLY30Hf0Ka8S//RIVd5pTHXvTMR3gjKdid0xaifKWCj2
         VIt6mwura09dHqT795WKZace/H/z4xpJu+YFKHvf+xyggRNDvnj0RgUeCZF9pAovhWS/
         O7hg==
X-Gm-Message-State: AOJu0YzaeoG5b75zqZ8DtbF2Otwop4tMiQcMyjSvSMqCgKMnbhh7n8Ca
        bIgkX/QSUfN3avAvwBAhx/Q=
X-Google-Smtp-Source: AGHT+IGAFjVUBWoiL4jFZIhLJ5+kFxpO6Qwb5IlvPalw7IqLnbbVI5DXHgXOw/07cUZAyzy2ptzREw==
X-Received: by 2002:aa7:c750:0:b0:522:3ef1:b1d with SMTP id c16-20020aa7c750000000b005223ef10b1dmr1598365eds.6.1693993216912;
        Wed, 06 Sep 2023 02:40:16 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.97.6])
        by smtp.gmail.com with ESMTPSA id es9-20020a056402380900b0052e9b50dafdsm599052edb.33.2023.09.06.02.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:40:12 -0700 (PDT)
Message-ID: <10509692-ce04-e225-5a27-abc955554bdc@gmail.com>
Date:   Wed, 6 Sep 2023 11:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To:     suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
 <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
 <2adfa653-ac35-d560-be52-c92848a1eef5@gmail.com>
 <b51d49f3-e3de-6b8d-9cb4-df5c03f3cdc0@loongson.cn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <b51d49f3-e3de-6b8d-9cb4-df5c03f3cdc0@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 06.09.23 um 11:08 schrieb suijingfeng:
> Well, welcome to correct me if I'm wrong.

You seem to have some very basic misunderstandings here.

The term framebuffer describes some VRAM memory used for scanout.

This framebuffer is exposed to userspace through some framebuffer 
driver, on UEFI platforms that is usually efifb but can be quite a bunch 
of different drivers.

When the DRM drivers load they remove the previous drivers using 
drm_aperture_remove_conflicting_pci_framebuffers() (or similar 
function), but this does not mean that the framebuffer or scanout 
parameters are modified in any way. It just means that the framebuffer 
is just no longer exposed through this driver.

Take over is the perfectly right description here because that's exactly 
what's happening. The framebuffer configuration including the VRAM 
memory as well as the parameters for scanout are exposed by the newly 
loaded DRM driver.

In other words userspace can query through the DRM interfaces which 
monitors already driven by the hardware and so in your terminology 
figure out which is the primary one.

It's just that as Thomas explained as well that this completely 
irrelevant to any modern desktop. Both X and Wayland both iterate the 
available devices and start rendering to them which one was used during 
boot doesn't really matter to them.

Apart from that ranting like this and trying to explain stuff to people 
who obviously have much better background in the topic is not going to 
help your patches getting upstream.

Regards,
Christian.

