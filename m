Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1E4650B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfFNQx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 12:53:57 -0400
Received: from foss.arm.com ([217.140.110.172]:38198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQx5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 12:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C10C028;
        Fri, 14 Jun 2019 09:53:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D45B3F694;
        Fri, 14 Jun 2019 09:53:55 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:53:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
References: <20190516055307.25737-28-mmaddireddy@nvidia.com>
 <20190604132233.GT16519@ulmo>
 <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
 <cb2dd446-1275-7179-33ac-e5c237d81da6@nvidia.com>
 <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
 <20190614152304.GK15526@ulmo>
 <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
 <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 10:00:49PM +0530, Manikanta Maddireddy wrote:

[...]

> GPIO based PERST# is per-platform requirement.
> If DT prop is not present, then devm_gpiod_get_from_of_node() returns
> NULL gpio_desc.
> 
> struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
>                                          const char *propname, int index,
>                                          enum gpiod_flags dflags,
>                                          const char *label)
> {
>         struct gpio_desc *desc;
>         unsigned long lflags = 0;
>         enum of_gpio_flags flags;
>         bool active_low = false;
>         bool single_ended = false;
>         bool open_drain = false;
>         bool transitory = false;
>         int ret;
> 
>         desc = of_get_named_gpiod_flags(node, propname,
>                                         index, &flags);
> 
>         if (!desc || IS_ERR(desc)) {
> */* If it is not there, just return NULL */****if (PTR_ERR(desc) == -ENOENT)****return NULL;*
>                 return desc;
>         }
> 	...
> 
> }

Ok. My point then is that you have no way to enforce this requirement on
platforms that actually need it, I do not even know if there is a
way you can do it (I was thinking along the lines of using a
compatible string to detect whether the GPIO #PERST reset is mandatory)
but maybe this is not even a SOC property.

Maybe what I am asking is overkill, I just wanted to understand.

I was just asking a question to understand how you handle the case
where a GPIO pin definition is missing in DT for a platform that
actually needs it, the driver will probe but nothing will work.

It would be good to describe this and capture it in the commit log.

Thanks,
Lorenzo
