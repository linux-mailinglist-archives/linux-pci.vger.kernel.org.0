Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7850E1F2089
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 22:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgFHUNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgFHUNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 16:13:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA4C08C5C2;
        Mon,  8 Jun 2020 13:13:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so18864195wrc.7;
        Mon, 08 Jun 2020 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jVlgVc/GdIbK4y0NjDmH2j1F9bPmxyBu0CijBkevcuM=;
        b=GxIa0nqH3YUvqdMVrSneYuxpK1li2NwjOC2tWa3ClFigHXItIT4pCIhWKCGPN2Bymx
         Zg62Ie4jnV1UlyOpeipP+9nzTvFNmVqLlAhssoN2o9wqGjw/otPOjhmxKV0GLj2Hc0Im
         vov50u7EGIh1TN9NEv5+NxVlULBtyE2M7GkVaBpV6vmDBNDTxAs1DFMZLQMi9R1UCNE5
         uYGxTe4vRw2mmCAenIBFOdWLTY3KL05EHCLHzKw0Oob/Sz4GJstY9gIa388V83hDUUu9
         sWlnW+1ZhVctL3goGD9+QZ8Dz3TavvBgXdQwKjqt9Gr/4K5D9C02vU0nY7XxmM+WVsSi
         k40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jVlgVc/GdIbK4y0NjDmH2j1F9bPmxyBu0CijBkevcuM=;
        b=eaobM8l49eojxux1vWIDI79wbgVQ9cbMt57nOtmwTPjs4Arv9d7NHoLAuhiZLmqQav
         GwHcQhIX5t9yxN0lmdu37vvFkgyVCQ7jJncT0A0b3+kX0vbsB3pJP+OABe5RSe/KjOKn
         DE6iEyVqI/NtHdGCE7Z+x+ZTDDUqOFY8FxQSyBA3cd1/TFEJ0pQ2f5PF8/sDV0DhWSSN
         +iuMxG/uEGjTrQk5GFl3wCbGCaLRJHd3xdDLw35jM/uNqi6TzzubROByEnkq46scFbnE
         nF8GReIwDBBQ2h1pzhO0Yj8Y+Wrd9+HB+Bcn/3uHGfbAIU4AIpq3fHPhOH1utBkmg2xK
         dNyQ==
X-Gm-Message-State: AOAM530XFLo+8pidssqQT+oz1Gn30AxgmQ9rWDXpHGgveUycE6tsIUSx
        YBm/8HSl0esuw3iWm/MqjXE=
X-Google-Smtp-Source: ABdhPJz8p+SkU30y3q1K8nACUgnVpvdsIVwmKe+81wFUlwKOO2+ifmHhPj6JqE0sNud54W5ZsPxS3Q==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr474621wrt.341.1591647221781;
        Mon, 08 Jun 2020 13:13:41 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id r4sm813582wro.32.2020.06.08.13.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 13:13:40 -0700 (PDT)
Subject: Re: [PATCH 2/9] reset: Add Raspberry Pi 4 firmware USB reset
 controller
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        robh@kernel.org, mathias.nyman@linux.intel.com,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
 <20200608192701.18355-3-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7e88dd76-5b75-c326-6f89-42a69bfe1ede@gmail.com>
Date:   Mon, 8 Jun 2020 13:13:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608192701.18355-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
> that implements the xHCI. After a PCI fundamental reset, VL805's
> firmware may either be loaded directly from an EEPROM or, if not
> present, by the SoC's co-processor, VideoCore. RPi4's VideoCore OS
> contains both the non public firmware load logic and the VL805 firmware
> blob.
> 
> We control this trough a reset controller device that's able to trigger
> the aforementioned process when relevant.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

[snip]

> +static int rpi_usb_reset_reset(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct rpi_usb_reset *priv = to_rpi_usb(rcdev);
> +	u32 dev_addr;
> +	int ret;
> +
> +	/*
> +	 * The pci device address is expected like this:
> +	 *
> +	 * PCI_BUS << 20 | PCI_SLOT << 15 | PCI_FUNC << 12
> +	 *
> +	 * But since rpi's PCIe setup is hardwired, we know the address in
> +	 * advance.
> +	 */
> +	dev_addr = 0x100000;

You could encode the device address as part of the reset identifier,
such that if we ever have more devices to reset, then we only need to
define new identifiers for them, and internally within your reset
controller provide you can resolve that reset identifier 0 is PCI_BUS <<
20 | PCI_SLOT << 15 | PCI_FUN << 12 for instance.

This would make your reset controller define a "#reset-cells" property
to 1 now, such that no further DT ABI breakage would occur if you were
to extend it later on.
-- 
Florian
