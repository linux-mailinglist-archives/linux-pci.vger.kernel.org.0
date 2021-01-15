Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A442F7493
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 09:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhAOIu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 03:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbhAOIu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 03:50:57 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2556C061757;
        Fri, 15 Jan 2021 00:50:16 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so16782010iow.1;
        Fri, 15 Jan 2021 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPMXpX5qpR3CJZ1K+xbqsLksYzchwvV9Jojvc6tLjhw=;
        b=jRQrdRvhWftgoG6phrV/VhF0KOZLhPah28jYzmicAmueBvd1MFi3hSlwffrNn0shpM
         ZCi8bvAtr/YhKpyNUO+wBpuU5e/ZHB48a7h6Wc4n6IObAMFkEKxlyEva+4V9xbAoQroQ
         qPjKyCcLmL7J4ps5+25ofW+8IqNePnLfLBzmkQTJeR27Xf2odYwGABDbD62Y9xwVQCAd
         6i6dBh5WxXHD3EaNYNGfJ/Qz1w3gFZ4E8pxVDtlCOOuxQtynifzxGKOMUmLCmPyWj4Nh
         AI/8fd0j8LHrEB+YycTFfVW28Vzv5rGP3Ls49nTcU5T4CVYHkd6UoL9fmkQege42qQ8V
         dyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPMXpX5qpR3CJZ1K+xbqsLksYzchwvV9Jojvc6tLjhw=;
        b=QmxJuq+MYsUoHlf0ljAiWkKY+E9IUWNxnCnyHhHiPJh8bC2eYs6OjtCdz0sB9xzh6i
         C98Gn/9DNCwxIke6dGXOUFPuU1auS6fSvZDs+RUBLBQxHTMipFyTPQKCGAZNH5Ub4NP4
         EoP+6zNchVZtuF7Idjdhsv1ogGqQqYl8L3QIQe0N0LPZaGmpOAQV54mEAEBzc+3LoWMR
         GMZG+zHtBcVtKL6DDRd5Vb2CrFYkxYTorMcEsYlQfqwRUhr/nA4QzcDQKJZ6T/bG9uXi
         8oV/mGukkXGq3r0X3g+WIhpKLbJ77MokRj0xV4cijpVGydtt9nXFhsB/fzZt9HVOe/8u
         SedQ==
X-Gm-Message-State: AOAM532vMwfjBoIzWgCja1u+Y6nhxmN/g4T4eGFMwE+7WNYVLOIp240y
        2FC/svXWirovFaut1rLOH0uH+wqdGOIHSmGjcvoYnwSNT3+cqw==
X-Google-Smtp-Source: ABdhPJxp/9Hdim39Vq4JepGKeoqre+PYKGQU0++N9W5WVVTwNmBxH7ZptHnnW74tuInQu/DuLsmMFN1qGnsB3uN5dyY=
X-Received: by 2002:a05:6e02:1447:: with SMTP id p7mr10137889ilo.93.1610700615983;
 Fri, 15 Jan 2021 00:50:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHKzcEPuwZFei+6RehMn1yzRD45k_xfMgGC2Ma4eeR9y5rnFow@mail.gmail.com>
 <20210114205142.GA2021118@bjorn-Precision-5520>
In-Reply-To: <20210114205142.GA2021118@bjorn-Precision-5520>
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date:   Fri, 15 Jan 2021 09:49:40 +0100
Message-ID: <CAHKzcEPcw_6XSQ5hqbgxAKY9P0MOeRo68WoWyRo27gp-FCw68g@mail.gmail.com>
Subject: Re: Hook up a PCIe device into the thermal framework
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> > topology that DT modification will not work and still I have no device
> > node.
>
> I'm absolutely not a DT expert, but I assume that a thermal zone would
> be associated with some resource fixed by the platform, such as a fan,
> so I would think a thermal zone would have to be described in terms of
> the platform physical topology, not the PCI device type.

The thermal zone needs a temperature sensor device to read out
temperature and also some cooling devices which are mapped to specific
zone trips.
In a below scenario, when TZ hists the wifi_allert0 trip it will run
the fan but if the temp still rises it will try to dissipate the heat
by running some actions within wifi adapter eg. switch off some
antennas.

[...]
wifi_thermal: wifi-thermal {
    thermal-sensors = <&wifi_device>;
    trips {
        wifi_alert0: wifi-alert0 {
            temperature = <90000>;
            hysteresis = <5000>;
            type = "active";
        };

        wifi_alert1: wifi-alert1 {
            temperature = <110000>;
            hysteresis = <5000>;
            type = "passive";
        };

        cooling-maps {
            map0 {
                 trip = <&wifi_alert0>;
                 cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
            };
            map1 {
                 trip = <&wifi_alert1>;
                 cooling-device = <&wifi_device THERMAL_NO_LIMIT
THERMAL_NO_LIMIT>;
            };
        };
};
[...]

My problem is not a cooling method but the binding of the PCI device
(it has a thermal sensor) with the thermal zone

    thermal-sensors = <&wifi_device>;     // wifi_devcie does not
exist until I will statically define it under PCI controller

The point here is that defining wifi_device under the controller I
need to reflect the PCI topology. Which is fair as DT should reflect
the HW connection. Even if I define a wifi_device anywhere in DT and
assuming the PCI core will search whole DT and not only subnodes of
the controller/bridge/switch here likely comes another problem. What
should be the key to search for the device node? PCI addresses devices
by bus:device: function and this is known after PCI scan.

To me seems that so far no one found a good way to handle thermal
within PCI devices, so some drivers statically create TZ and handle it
within the driver. This way, unfortunately, we lose the flexibility of
thermal control from a system-wide perspective. WiFi adapter is not
aware of the fan for example.

/Waldek
