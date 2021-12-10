Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EF470896
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 19:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhLJS0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 13:26:48 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:46886 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbhLJS0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 13:26:47 -0500
Received: by mail-oo1-f45.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso2585825ood.13;
        Fri, 10 Dec 2021 10:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFB47AVNO/VW1/LXFDlNTFblZA7KWFWWfiZyQLw6U3k=;
        b=wQptJNpLpyiyi85pt/B1mPWAMxPQlTivBa2+0K6bqqKwIe3kfXlwhVXaErAWDNUVWg
         NsiDjGfh2wVlec1ow9xbwpMJ+8wlMY4ta2vrhitej16slLJp/JHgoDCNrOb4Qu5wgK6/
         XZQc0Oq/V3qvSL2+fSYZ82BZe2D/pM5L0iDJMlNJneYTsndQ5twMd+np7q+ddAWOWPB2
         aQEzA6rNZbNLlmSvGjqxiN5RO5GyP6/6Ry9oyEuPXqvLa2Aus/N6yeiljxToTEj0WDKn
         ebfcdxSxuxtj9si+s7PL42Eh1TnjKHskVVrl4x62cpldhgbsvrI6tgbnTGAMNyBXaaN4
         28oA==
X-Gm-Message-State: AOAM533YD1RaNsQu04TEil3Qk2SVHJ252sDHA44Hf76BXzTV+eaWZ120
        EGAfAXlEJ4OWijWWCMG49A==
X-Google-Smtp-Source: ABdhPJyc3ABoNJrwZumo7EOyB4hnzXp9P/PIrPs0V7cqsiJUEPu3u1vyvJiJXOR7j6Ncv9hPUJqJPg==
X-Received: by 2002:a4a:9292:: with SMTP id i18mr9366597ooh.90.1639160591772;
        Fri, 10 Dec 2021 10:23:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v19sm638482ott.13.2021.12.10.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:23:10 -0800 (PST)
Received: (nullmailer pid 1650238 invoked by uid 1000);
        Fri, 10 Dec 2021 18:23:09 -0000
Date:   Fri, 10 Dec 2021 12:23:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <YbObDXLXX5WR6qvp@robh.at.kernel.org>
References: <20211209211407.8102-1-jim2101024@gmail.com>
 <20211209211407.8102-4-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209211407.8102-4-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 04:14:01PM -0500, Jim Quinlan wrote:
> Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
> added to the Linux PCI subsystem that will allocate and turn on/off
> regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
> vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
> device.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/63
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
