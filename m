Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44C3ACE4C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhFRPLC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhFRPLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 11:11:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA85C06175F
        for <linux-pci@vger.kernel.org>; Fri, 18 Jun 2021 08:08:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso6128639wms.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Jun 2021 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BB8SswcEaNjvxfv5/SYWvaIhulUyrjsY7Tim+J287Po=;
        b=yZmbw54fJezM3UObaPBhSLvrX2gSA9+LSWtH2qYk8jxMojG6lI4YXcKvqvsvQQTWIE
         lKA9iT6D1d2pROZ95mRBVhxjLinX2g0RwgNXx44mtfn7OyIZ+Tr3yT4TzvkeeNuMehuE
         q+74TUg2i0XDPXq1zmBmBmtPyIHQnYUJxckq3BZpSYji7LI0HpPGRGG5GfW3cMZP3FAT
         pSnY2lWSuurXxwZ2+2fuKJEZkaIHtSKYQaCG+GP4MMvstlaqbVqmTSvo9SFUYGVZPjaN
         mr9bjoIs4vlySv5nbPD0ujzQtferv/pkjS1KsqRY1eNHlYcmhfiTDdUPOu7R5J4tkiqm
         1D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BB8SswcEaNjvxfv5/SYWvaIhulUyrjsY7Tim+J287Po=;
        b=NEp+wUL94tGVjTCHCfAA7u2Vy9Df7U/DFkgOGtBJ8Oq0+szsjnMfaoF9nSks+sTbCx
         7FLN8YNjnSGFnnmy5jg9IXmdTg+fdxAg3W1OSUO3n4xYt3klFUjCijkkM7Z1RgLveDbn
         1+mozakl7Im1xSNoW8oNa7nRUhUVbVSNTJGPVpFrl1M0A24D6BVRsWszES3juPbpjkXh
         ZYeYQ8wSnhYozLH2PpCOzIgilDYg8nKagn+VtEuIqpGYWOszpc2EOETAPSSD4hX/Cdmh
         d0e+hEVyzUQLIRUmJuwlvD51229jo7F+rga2YgUYUbr7Wlupc+SY9JT5mUtw9wxyeM5C
         44cA==
X-Gm-Message-State: AOAM531BnNPNVv/dgEqIIPta8Y/hF5ru7qf00cAOdSveuEX31DLNEPnB
        D6U0crUYo02gDTDRFc+Bbtrjmw==
X-Google-Smtp-Source: ABdhPJxDHp+81lE3UaKhD8t72YZzpU4a1NRKPGAQoLZH13xKQADxUrtdW0KvDdrw21Ae2pn6NnLEOA==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr10760262wmb.167.1624028931071;
        Fri, 18 Jun 2021 08:08:51 -0700 (PDT)
Received: from [10.1.3.24] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u12sm9276925wrr.40.2021.06.18.08.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 08:08:50 -0700 (PDT)
Subject: Re: [PATCH] PCI: dwc: meson add quirk
To:     Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Artem Lapkin <email2tema@gmail.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        art@khadas.com, Nick Xie <nick@khadas.com>, gouwa@khadas.com
References: <20210618063821.1383357-1-art@khadas.com>
 <CAFBinCB6bHy6Han0+oUcuGfccv1Rh_P0Gows1ezWdV4eA267tg@mail.gmail.com>
 <CAL_JsqK+zjf2r_Q9gE8JwJw+Emn+JB4wOyH7eQct=kBvpUKstw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9b27444c-ea13-0dd2-a671-cef27e03b35c@baylibre.com>
Date:   Fri, 18 Jun 2021 17:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK+zjf2r_Q9gE8JwJw+Emn+JB4wOyH7eQct=kBvpUKstw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/06/2021 16:30, Rob Herring wrote:
> On Fri, Jun 18, 2021 at 6:12 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Artem,
>>
>> On Fri, Jun 18, 2021 at 8:38 AM Artem Lapkin <email2tema@gmail.com> wrote:
>>>
>>> Device set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
>>> was find some issue with HDMI scrambled picture and nvme devices
>>> at intensive writing...
>>>
>>> [    4.798971] nvme 0000:01:00.0: fix MRRS from 512 to 256
>>>
>>> This quirk setup same MRRS if we try solve this problem with
>>> pci=pcie_bus_perf kernel command line param
>> thank you for investigating this issue and for providing a fix!
>>
>> [...]
>>> +static void meson_pcie_quirk(struct pci_dev *dev)
>>> +{
>>> +       int mrrs;
>>> +
>>> +       /* no need quirk */
>>> +       if (pcie_bus_config != PCIE_BUS_DEFAULT)
>>> +               return;
>>> +
>>> +       /* no need for root bus */
>>> +       if (pci_is_root_bus(dev->bus))
>>> +               return;
>>> +
>>> +       mrrs = pcie_get_readrq(dev);
>>> +
>>> +       /*
>>> +        * set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
>>> +        * was find some issue with HDMI scrambled picture and nvme devices
>>> +        * at intensive writing...
>>> +        */
>>> +
>>> +       if (mrrs != MAX_READ_REQ_SIZE) {
>>> +               dev_info(&dev->dev, "fix MRRS from %d to %d\n", mrrs, MAX_READ_REQ_SIZE);
>>> +               pcie_set_readrq(dev, MAX_READ_REQ_SIZE);
>>> +       }
>>> +}
>>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_pcie_quirk);
> 
> Isn't this going to run for everyone if meson driver happens to be enabled?

It should be enabled only when the Amlogic bridge is present, thus similar filtering as keystone & loongon
is needed, but with such filtering we could reuse ks_pcie_quirk() and loongson_mrrs_quirk() as is.

> 
>> it seems that other PCIe controllers need something similar. in
>> particular I found pci-keystone [0] and pci-loongson [1]
>> while comparing your code with the two existing implementations two
>> things came to my mind:
>> 1. your implementation slightly differs from the two existing ones as
>> it's not walking through the parent PCI busses (I think this would be
>> relevant if there's another bridge between the host bridge and the
>> actual device)
>> 2. (this is a question towards the PCI maintainers) does it make sense
>> to have this MRRS quirk re-usable somewhere?
> 
> Yes. Ideally, the max size could just be data in the bus or bridge
> struct and perhaps some flags too, then the core can handle
> everything.

AFAIL Simply moving ks_pcie_quirk() and loongson_mrrs_quirk() to core with the amlogic pci IDS added would be sufficient here.

Neil

> 
> Rob
> 

