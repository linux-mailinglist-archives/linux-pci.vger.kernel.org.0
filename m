Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985C419E77B
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDDUKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Apr 2020 16:10:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38166 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgDDUKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Apr 2020 16:10:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so5448518pfo.5;
        Sat, 04 Apr 2020 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iO+ngN86VFXx54+srkKFZzGqdoZULXS+GdNkT3PonxI=;
        b=FVvg1HtDBM/7tDegAZQAn2Y5rUZk/jMiu5p4ekstLNIxQhfSG5Sv9hW8t3yeq8ytpe
         dUSi9JRCuOtFc8zkOHCIqK4BpzEvQ3cwwpvxjJhNOAhqk9gB5mhyhH0N6UAnsnpnKUii
         PafCh1SIhham0yPIcVgjm+ukXUp8sUfE4n51mNo9ddB8R/K5ski7D2T+yJTx9vGWy/m6
         fLmD/uNq1RzlA6Xuap9UumKPLJ7dXx4AahReImBjDoSiDN/c6stxgBdokzKn36oAVloA
         NNgOgpi2TfPs9l7HvYeO3pJ0rh4RoflJb2/CbEhUABasGvx7pERJPJiMVryfEjeF7If6
         2FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iO+ngN86VFXx54+srkKFZzGqdoZULXS+GdNkT3PonxI=;
        b=T7YZsosWDDkx2BqbQpoOdFEuaQ2BLIImmrTWVKbGKu4jTkY6G4gL+afFSrZyBfOFFJ
         ORGpQQdjMZVLwEbBn2X3OOkRI5u8Z2DcU6wTXzxFDyqhLZpS7f0+Kslbu63qHeRnlhmH
         Sidl/m2vrFZCahh9C0N06H2K6vq0rgSBbRsOU5IQ7BYnyoMA+2yChQ7Ad7pSP4T34tix
         T7JCgtBi1RWggDilGLhk9haKOmYBVD9CE+61ygLu9A8m5GSy7ktSD8dQ3/zUJBu5c2mb
         aZqUdEfISkw7iTAd12t0rl6ah/0q5CiSY/HhsA5gptESCqtS67mJ2kH39yt0E4TUv4eL
         Ow2g==
X-Gm-Message-State: AGi0PuZgFgu2cZBEAS2LkPNkrgY480SUp0NLA/yrrnwRvgTfXAwBFrv/
        P4ywOkB+WJeUCOH0dhsgwoo=
X-Google-Smtp-Source: APiQypKayJb8b63Pn0nC4PVqoPfNggo+/qdegfaffA4HaBvrVg7K3Azt0e3jqkujs/D5hY0aicrJ9A==
X-Received: by 2002:a63:8c53:: with SMTP id q19mr14697410pgn.222.1586030999123;
        Sat, 04 Apr 2020 13:09:59 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id 144sm8294488pfx.184.2020.04.04.13.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 13:09:57 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com,
        Rob Herring <robh+dt@kernel.org>
References: <20200402193820.GA32107@google.com>
 <6b81402dd7ab6431f69dba301ce07822cb8dd753.camel@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <dee8d364-e08d-61ae-d242-c347d1b73272@gmail.com>
Date:   Sat, 4 Apr 2020 13:09:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6b81402dd7ab6431f69dba301ce07822cb8dd753.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/4/2020 12:20 PM, Nicolas Saenz Julienne wrote:
> On Thu, 2020-04-02 at 14:38 -0500, Bjorn Helgaas wrote:
>> [+cc Rob for DT platform device dependency question]
>>
>> On Thu, Apr 02, 2020 at 04:27:23PM +0200, Nicolas Saenz Julienne wrote:
> 
> [...]
> 
>>> Sorry it wasn't clear enough, I'll redo this comment. Also note that
>>> the PCIe bus and the XHCI chip are hardwired, so that's the only
>>> device that'll ever be available on the bus.
>>>
>>> VIA805's XHCI firmware has to be loaded trough RPi's firmware
>>> mailbox in between the PCIe bus probe and the subsequent USB probe.
>>> Note that a PCI reset clears the firmware. The only mechanism
>>> available in between the two operations are PCI Fixups. These are
>>> limited in their own way, as I can't return -EPROBE_DEFER if the
>>> firmware interface isn't available yet. Hence the need for an
>>> explicit dependency between pcie-brcmstb and raspberrypi's firmware
>>> mailbox device.
>>>
>>> Your concern here showcases this series' limitations. From a high
>>> level perspective it's not clear to me who should be responsible for
>>> downloading the firmware. 
>>
>> I think it's fairly common for drivers to download firmware to their
>> devices.  I guess there's not really any need to download the firmware
>> until a driver wants to use the device, right?
>>
>>> And I get the feeling I'm abusing PCI fixups. I haven't found any
>>> smart way to deal with this three way dependency of
>>> platform/non-platform devices.
>>
>> So IIUC, the three-way dependency involves:
>>
>>   1) brcm_pcie_probe(), which initialize the PCI host controller
>>   platform device, enumerates PCI devices, and makes them available
>>   for driver binding,
> 
> Yes, and also resets the PCI bus, which will clear VL805's firmware (the XHCI
> chip).
> 
>>   2) the firmware mailbox initialization (maybe
>>   rpi_firmware_probe()?),
>>
>>   3) quirk_usb_early_handoff(), which downloads firmware to the VL805
>>   PCI USB adapter via rpi_firmware_init_vl805(), which uses the
>>   firmware mailbox?
> 
> And yes, that's the general idea.
> 
>> Is there some way to express a dependency between
>> "raspberrypi,bcm2835-firmware" (the platform device claimed by
>> rpi_firmware_probe() and "brcm,bcm2711-pcie"?  If we could ensure that
>> rpi_firmware_probe() runs before brcm_pcie_probe(), would that solve
>> part of this?
> 
> That's ultimately what this patch tries to achieve. If there was a way to
> offload it to DT it would be way nicer.

Have you looked whether device links between producer/consumer could
help here? AFAICT there is not usually a way to express an ordering
dependency other than by referencing symbols from a different module,
which falls apart when everything gets built into the kernel obviously
and then you are at the mercy of the linking order and initicall levels.

https://www.kernel.org/doc/html/v4.13/driver-api/device_link.html
-- 
Florian
