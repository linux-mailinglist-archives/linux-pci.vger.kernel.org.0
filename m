Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9416344323B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 17:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhKBQDF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 12:03:05 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38812 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhKBQDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 12:03:05 -0400
Received: by mail-ot1-f49.google.com with SMTP id c2-20020a056830348200b0055a46c889a8so9921202otu.5;
        Tue, 02 Nov 2021 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVZoZLYUpaZTi2RFg9sQqLoO8E1t6WatefP2gNVJXh0=;
        b=BElFdXZD8wmO+crOoTR43KGto43bFGM23Eo/9ypt4xmyJxUjZyBif34wUC5jgwOvFs
         bX0BM0vAsNvv1pJPPFp4/k0lpMEHQjN5sSJTGR5kXvhLCWFZqluEvIMOn5tGq0RGw9Wf
         jT8W0AloIHm5oSoU163GEu7CKaA8ienNGIujWvOe/Nq1jmEoGeXVq/rz3JqZqd+Uzlt0
         qROIXaizF1rqat7dy03rQ8ANJz/zDE4QvQ7fKvASFMvhPfrJlDZBbfYyLTJjdKlLbBVo
         ozci4HeqMVOY6Z0m609ciHJZsKw3M7qHvPYvj0JVdljf197/OzqhJDd8LkiMhn0UEoB5
         EEUg==
X-Gm-Message-State: AOAM532sBAGbCiHf2MIXk9kSqtV5/klYH1grgjolZyXLyiMWbENrnyap
        /MKJ2D6ffAXWwf0LitLXIg==
X-Google-Smtp-Source: ABdhPJy5Lv9+vYTWTHyrrDWVaGcPa3crXL5SfGnGCNqx3oF0uap1WO1+gdNe56Y4Qsn7XED5FXiGrA==
X-Received: by 2002:a05:6830:1293:: with SMTP id z19mr27624339otp.353.1635868829838;
        Tue, 02 Nov 2021 09:00:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p62sm600981oif.43.2021.11.02.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:00:29 -0700 (PDT)
Received: (nullmailer pid 2970063 invoked by uid 1000);
        Tue, 02 Nov 2021 16:00:28 -0000
Date:   Tue, 2 Nov 2021 11:00:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <YYFgmxMCnKtTlaqL@robh.at.kernel.org>
References: <20211029200319.23475-1-jim2101024@gmail.com>
 <20211029200319.23475-8-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029200319.23475-8-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 29, 2021 at 04:03:15PM -0400, Jim Quinlan wrote:
> This Broadcom STB PCIe RC driver has one port and connects directly to one
> device, be it a switch or an endpoint.  We want to be able to turn on/off
> any regulators for that device.  Control of regulators is needed because of
> the chicken-and-egg situation: although the regulator is "owned" by the
> device and would be best handled by its driver, the device cannot be
> discovered and probed unless its regulator is already turned on.

I think this can be done in a much more simple way that avoids the 
prior patches using the pci_ops.add_bus() (and remove_bus()) hook. 
add_bus is called before the core scans a child bus. In the handler, you 
just need to get the bridge device, then the bridge DT node, and then 
get the regulators and enable.  

Given we're talking about standard properties in a standard (bridge) 
node, I think the implementation for .add_bus should be common 
(drivers/pci/of.c). It doesn't scale to be doing this in every host 
bridge driver.

Rob
