Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A11C46BE
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEDTGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 15:06:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:56527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgEDTGi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 15:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588619183;
        bh=C+isCjntLYt9kqlli5LSKtDu8IdWLHTZ5RJUWs7zbXM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UHnf72akfI+ig976rUPUvYEE/g44QCfj5/+G+3sMt1sXdGrPRWSKofoPKDgiRn3TA
         tdv1hD0HR7F2fWWNDS8EQJgF5EG3sTw7fzdUjDHyEmeXsjSohNFYAcNaH1rdu55SEv
         M6X8XMRxOATlr337Obt4+JEARXw50d88WQOTFb64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.164] ([37.4.249.134]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1jKfvL1y9Y-00FSFH; Mon, 04
 May 2020 21:06:23 +0200
Subject: Re: [PATCH v7 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, helgaas@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, f.fainelli@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, RayJui <rjui@broadcom.com>,
        ScottBranden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200429164734.21506-1-nsaenzjulienne@suse.de>
 <20200429164734.21506-3-nsaenzjulienne@suse.de>
 <5fce05ca-5d7e-f4cc-be34-0764fbe4edff@gmx.net>
 <d105712418b93ebce7c0498d05eea77171892366.camel@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <b9b02ec0-0cb7-995a-40ce-ed38b78dfe46@gmx.net>
Date:   Mon, 4 May 2020 21:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d105712418b93ebce7c0498d05eea77171892366.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:JZFObt6Lk3DQRXt5KLfTd6EmGQIybewYIU19LjW8nO9jbS567Pa
 shT7uvbZLy3upf6B2GVztaX/RCAkdmnOiLCzmrl3dxPY7dM8awJ2+2Ue1OgQiCinNqEP5Gz
 805JHhEefUDbD+u8N5NXVpu03EunuqFgq0HDp2DmoDmnQ0dxyNfBGX5Ph5LLD7I+dKrrqfV
 32Uh4GWXZ7afJ7HmSpVUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ctWgi5jAtY=:Ir/e6Xdi2cSRtGMJ+KSoIy
 c+oPGotCSd0Sh3VpUue+y1jolaLc3f5equZDJwXF5RHsf+veLkJN0dVkRULMEjhpPIpYunJKQ
 FaGks40bInyiWe0DCFP0dZr/gYgh2TKrOlI7Z3p4DUxsCr59sUqzAo47sBDoufvVNGUYB+Fcx
 tbtelpQq8+z/WYP8jWUnxOrMn1IYrV7YtxkN3lhyGtEju5EAceu9I8owFdujj5+dNpibJmbIy
 lyNbQ5FHdjmS0xjIHdW1NndW7Vy4NSatxaub6o76E4wbwSQdOy2QjZCHuUXEOswJGPL22TcIw
 xAsRYX+BCyyZvyOuF5ig3zammnavIh8Zp5Fb5yAM2Slt2bJAKk29WZ39jfo9ySCdO2mT4l9eb
 1I8Ecenbf3o1oTS7gwTp4ePwzlgVYSbai4izB6UkcHRPLgZ0dNlgMSiY5zwiPT9/qTgsxEiaM
 FqymPDrZ3otiNCiMvfQ4+YTBKxDhgqbR9QoL+1KTwc91NT0JcvPfCC8rkiKB5ZchGaW+sPNBB
 /RafI4PpXK/WZfHwHnknsFg2xu0hsgrfi/2uF3T9WF8swwkpTz7D+9A/L4Iuc2n/lNy9gx89j
 +M9S414OEW4rTuwdu1IF/QpmXfO8u8B7TnWcOErLu5NbRmmJmyqQ5232TeM4RKhJ7CiUSrnhC
 h9Bv8x+WMNAjBuuhA2yj4+Ca5WgyaX7/ZsizkMEw4WZQHoW1VOuznymeRe0DVLzgb9UYLV5jx
 2RoOoWDfRi5ersuUxfCWJIokjthUGi9Do+cEmK32bquozqQOY7peSM1/ziNOztk/Clfno5BwW
 vRvzjAr7/MflYO+DT7lw3o5CmXKJdN7E9UGyxAjkpH/DDJgs2cHkcXfyV72Fxy8hSCU1K4npg
 r8x/hbhmo+kGGmUgFI5bThflHMsURunQ/uoMle9lzEW1YTfv2BDwJG4N1ZqAIv0GC8LtHnLvr
 kbHk4dZkWw/30g90Q+KntOMpeCO2lyEdKKGRpaOOSAYdIrOyblvKwWaIfdj3YerwKdjUab0hm
 PlA8UyYVWrumqZCgirbAo+uqgS11j0oWj0vspgVk9Qjf9vUNZwx0LGvK0kqH2gXpHWDv4+/2S
 CKa/bdzMXbOLbTjoIu3Fv0Ai45WIz/M3WGPBr1lGzXH/zPFP9oTqdfyCCDlP5BVyyFexaL9h8
 61kbkM8Q6vNhfWK2fU/dLsIiUkJF8RHrzjwD0jv/SvlowqtX2skClroSweUYx0ROsNc20O1y0
 yP+28L1sA+veTCg9S
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

Am 04.05.20 um 10:59 schrieb Nicolas Saenz Julienne:
> Hi Stefan, thanks for the review!
>
> On Sat, 2020-05-02 at 11:05 +0200, Stefan Wahren wrote:
>>> +	if (version)
>>> +		goto exit;
>>> +
>>> +	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
>>> +		   PCI_FUNC(pdev->devfn) << 12;
>>> +
>>> +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
>>> +				    &dev_addr, sizeof(dev_addr));
>>> +	/* Wait for vl805 to startup */
>>> +	udelay(200);
>> I know, it makes it harder to read but do we really want to wait
>> unnecessarily if rpi_firmware_property failed?
> Yes, I figured that it wouldn't hurt much at that faulty state, and you'll be
> waiting some extra 5s further down the line in quirk_usb_handoff_xhci().
>
> But if you feel it's more correct I'll be happy to change it.

no, i don't insist on that.

Best regards
Stefan

