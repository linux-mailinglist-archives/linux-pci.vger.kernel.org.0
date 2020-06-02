Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6629D1EC4B3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBV5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgFBV5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 17:57:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F3C08C5C0;
        Tue,  2 Jun 2020 14:57:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so224146wrp.2;
        Tue, 02 Jun 2020 14:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x7AN5XUNLuQTYg56C70ga61tHZwFYIHa2AHQltczmFg=;
        b=U0M5kO/8jyb/C740fEOYcR40kb1ux5x8uoxnQ9CONuX5Qf2+HD4+DUjHVay4hDowBx
         emMBMfxfr0F+a7T6SH/gc6www4bjdTGBTxtrIr+bz30R+/swZKMnVC/CfMPIImjvUB8f
         B+jsJqM46921FPCCtudANp8fvg9Ajl5OeqGjiehUVoiYQ9ovWDxjK72hDl+R1Ab/MV2Q
         O4aS08d2IrlbGJYXzYfOJNRJ4YhXUGrNCYKN3RckPEaPwYX0cCQi9RovM/eUg9DYZ7Yt
         +s7RQRJ6Ie3Mf8+yNLYSrqdr7fHtNKS47Um0woaZYpsO2nq9dMLoneWLzGRhnrlk2X7/
         /bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x7AN5XUNLuQTYg56C70ga61tHZwFYIHa2AHQltczmFg=;
        b=OjggjLVx2nMtuanJ+LlJkL8bPMWBeuvSixewFMHiwQDjnsiSupjzZU40gQSlxHxz1U
         FA3LA/VOQiZEfvS3orfnjkeo0r8xizt9ZVJWWOOIL46UJcCKViaaIGr078muQlfe8wwd
         vMI1rmXDIM/pN6EI//NPWWMW5sPpHd08uOxdEAUG38kz/y57z7wu9J5aeoIqKZn26l8Q
         Xm07pBwrstz/g2p31VlE8c7RL8HUWNZtGhEsJ5wjmqMA80CXfTOsxgSta0wmIeyH3FL1
         y7TXDEUzpT6XrGq+8Zt3c0kbh+QOAE6wdtsNNaobeb73DgwI1Gu+yKkOudF+kwtO/Car
         Z+qw==
X-Gm-Message-State: AOAM531g5I8zROVlA/PKvzThJF8k8cXxM4Su6Qvc0TUp8uzlM4pIerna
        JKA0KZUJi8CkxTVNVRmMB+3tFu5I
X-Google-Smtp-Source: ABdhPJy4YSjVEqczNAzcxEmsNN/lUYdvDuqjTKqzm2pWbMKypz5vH+9xQ5nc74+DxdvTResbkxAWHA==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr28203147wrm.34.1591135064541;
        Tue, 02 Jun 2020 14:57:44 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b201sm208844wmb.36.2020.06.02.14.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:57:44 -0700 (PDT)
Subject: Re: [PATCH v8 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-5-nsaenzjulienne@suse.de>
 <7cbe4da8ba4a1524824473f8c58720f412a00fc2.camel@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <edcbc0a6-f901-d8ff-748f-73017397799d@gmail.com>
Date:   Tue, 2 Jun 2020 14:57:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7cbe4da8ba4a1524824473f8c58720f412a00fc2.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/2/2020 3:05 AM, Nicolas Saenz Julienne wrote:
> On Tue, 2020-05-05 at 18:13 +0200, Nicolas Saenz Julienne wrote:
>> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
>> loaded directly from an EEPROM or, if not present, by the SoC's
>> VideoCore. Inform VideoCore that VL805 was just reset.
>>
>> Also, as this creates a dependency between USB_PCI and VideoCore's
>> firmware interface, and since USB_PCI can't be set as a module neither
>> this can. Reflect that on the firmware interface Kconfg.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> ---
> 
> It was pointed out to me on the u-boot mailing lists that all this could be
> implemented trough a reset controller. In other words have xhci get the reset
> controller trough device-tree, assert it, ultamately causing the firmware
> routine to be run.

That is actually a clever way to solve that problem.

> 
> As much as it pains me to go over stuff that's already 'fixed', it seems to me
> it's a better solution. On one hand we get over the device-tree dependency mess
> (see patch #3), and on the other we transform a pci-quirk into something less
> hacky.
> 
> That said, before getting my hands dirty, I was wondering if there is any
> obvious reasons why I shouldn't do this, note that:
> 
> - We're talking here of a PCIe XCHI device, maybe there's an issue integrating
>   it with DT, given the fact that, as of today, it's not really represented
>   there.

You can always provide a PCIe device representation within the Device
Tree, this is not very common, but it is sometimes useful for e.g.:
assigning MAC addresses, see this example for instance:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi#n647

(does not assign a MAC address, but it could). This should allow your
XHCI pci_device::of_node pointer to point to node declared in the Device
Tree. There you could add a 'resets' property accordingly.

> 
> - There is no reset controller support in xhci-pci, maybe there are good
>   reasons why. For instance, it's not something that's reflected in any way in
>   the spec.

It seems to me this is not usually necessary for PC systems, so it was
not really needed until now. Maybe you can write a small wrapper around
xhci-pci.c, similar to what xhci-plat.c does which is responsible for
grabbing and releasing the reset.
-- 
Florian
