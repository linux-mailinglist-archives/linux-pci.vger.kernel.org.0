Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AC470917
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbhLJSrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 13:47:41 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35601 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 13:47:40 -0500
Received: by mail-oi1-f170.google.com with SMTP id m6so14436078oim.2;
        Fri, 10 Dec 2021 10:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rlreThK0Sey0EGMizq9uyfo3hzBqI9k/YwHzDsxWXlI=;
        b=JX8FmQ0/oji75PDjnepH4JDLUydc2JUj1HUUBMpdMQlPARTEpuWKRLTOr4sD5sKbxz
         u4MSAFMGXhia582DqPv2M7OAl/XFdrWq/KzqHs49xtBj3Uf6l7KM3NkTtfkzctmFOm96
         DnqtH5cFAKeHUc6bfVjLMQzU7evK4NmGwbr5M1oG6Yqa6H0d3lBB6qdSCtOlg6gEh3lu
         GiTqpHLCy0rBpjUFKkZVWBdPsmN3MIa0D/Bro9l/tnG2nZp0SNvFa8NLclJSGH1xTCdV
         dRsK7UbLR91op4gZhpGIs+gRJHvvzyPYF+qhCUbCbivyldNCwDZuE0ddDPZ9bHmfC5dI
         rNSA==
X-Gm-Message-State: AOAM533RWbaNz6pUO4ERFave3uKvReFoN2lGTyqfrWb7TEGEXAJroOL9
        bElBs0BnDo6wHfPrEOE7j+PoTiis5Q==
X-Google-Smtp-Source: ABdhPJyp/UbVF+mB50ua6SkSEbILc6yqej1hsUMidJLzHaqYNUkPeNuWk9tk1mgGwLLU2y+Yg7NaCQ==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr13549366oie.36.1639161845115;
        Fri, 10 Dec 2021 10:44:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m22sm768027ooj.8.2021.12.10.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:44:04 -0800 (PST)
Received: (nullmailer pid 1681795 invoked by uid 1000);
        Fri, 10 Dec 2021 18:44:03 -0000
Date:   Fri, 10 Dec 2021 12:44:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v10 0/7] PCI: brcmstb: root port turns on sub-device power
Message-ID: <YbOf836C58fUSmCO@robh.at.kernel.org>
References: <20211209211407.8102-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 04:13:58PM -0500, Jim Quinlan wrote:
> v10 -- Bindings commit example: in comment, refer to bridge under
>        controller node as a root port. (Pali)
>     -- Bindings commit example: remove three properties that are not
>        appropriate for a PCIe endpoint node. (Rob)
> 
> v9  -- Simplify where this mechanism works: instead of looking for
>        regulators below every bridge, just look for them at the
>        bridge under the root bus (root port).  Now there is no
>        modification of portdrv_{pci,core}.c in this submission.
>     -- Although Pali is working on support for probing native
>        PCIe controller drivers, this work may take some time to
>        implement and it still might not be able to accomodate
>        our driver's requirements (e.g. vreg suspend/resume control).
>     -- Move regulator suspend/resume control to Brcm RC driver.  It
>        must reside there because (a) in order to know when to
>        initiate linkup during resume and (b) to turn on the
>        regulators before any config-space accesses occur.

You now have a mixture of 'generic' add/remove_bus hooks and the host 
controller suspend/resume managing the regulators. I think long term, 
the portdrv is going to be the right place for all of this with some 
interface defined for link control. So I think this solution moves 
sideways rather than towards anything common.

Unfortunately, the only leverage maintainers have to get folks to care 
about any refactoring is to reject features. We're lucky to find anyone 
to test refactoring when posted if done independently. There's a long 
list of commits of PCI hosts that I've broken to prove that. So it's 
up to Lorenzo and Bjorn on what they want to do here.

Rob
