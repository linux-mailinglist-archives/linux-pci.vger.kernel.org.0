Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03D91CF1A
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfENSbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 14:31:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35064 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENSbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 14:31:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id n14so9270135otk.2;
        Tue, 14 May 2019 11:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ot0Rh9qUIJF0O8H2q+zaBnNjlSpg3oyUgqIQhJfipk=;
        b=sfIxYbXElu/bcfO4zqts9PiJXK/RkIKUN4QxuJIzBfTAk131aOnDtLD4NGEqCzlLZI
         78kWNkSb1HL7UW8WKQeA9dgTi0ZZMeLgJNFDWx7ESsXT6wPLRpMuLHQgWCUxM7GKg66G
         uEdn0LPqNwNcJ5gIlEx8v7XdxEe0Q68ucPwSdDryLi/CeShNF+81IDwFxoQSFw+3yBsM
         DYaVUJd2DCLsMOvQ0Alx7lqaph7UXFCPrd8lvKQynafUWiDy1e7zkAggJGrPH9e1RXlA
         IaMa6D51+Bw/fFc6iSN7cixji81PjMVjNkTO8PRTXryAaFxbPmIdRguI4VXxnT3pvbZy
         SUrQ==
X-Gm-Message-State: APjAAAVtFwSTLsmidNG2d46FLaVimMSz4I208Xgbo0eTcHkIDwJ4kFdc
        2dcJ9Sb3+yNM9/myZCslsQ==
X-Google-Smtp-Source: APXvYqzja2UaVB3pN4oCGsDDfiE9EKeFY/k/M0kNLuhwCimZN2YRS6ChwktHFMmjHTce7/UnKJRfnA==
X-Received: by 2002:a9d:6411:: with SMTP id h17mr22321238otl.290.1557858667155;
        Tue, 14 May 2019 11:31:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e133sm6500067oif.44.2019.05.14.11.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:31:05 -0700 (PDT)
Date:   Tue, 14 May 2019 13:31:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 27/29] PCI: OF: Add of_pci_get_reset_gpio() to parse
 reset-gpios from DT
Message-ID: <20190514183105.GA32636@bogus>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
 <20190513180744.16493-28-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513180744.16493-28-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 13, 2019 at 11:37:42PM +0530, Manikanta Maddireddy wrote:
> This new helper function could be used by host drivers to get the reset
> GPIO descriptor. If the property isn't assigned, it will return NULL to
> the caller.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3: New patch to add helper function to parse "reset-gpios"
> 
>  drivers/pci/of.c       | 18 ++++++++++++++++++
>  include/linux/of_pci.h | 10 ++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9454c90980c9..2a0282115ff0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -6,6 +6,7 @@
>   */
>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>  
> +#include <linux/gpio/consumer.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -224,6 +225,23 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
>  
> +/**
> + * of_pci_get_reset_gpio() - Get PCI reset gpio descriptor.
> + *
> + * @node: device node
> + *
> + * Returns PCI reset gpio descriptor from DT, or an ERR_PTR() if the
> + * required property is invalid.
> + */
> +struct gpio_desc *of_pci_get_reset_gpio(struct device *dev,
> +					struct device_node *node,
> +					int dflags, char *label)
> +{
> +	return devm_gpiod_get_from_of_node(dev, node, "reset-gpios", 0, dflags,
> +					   label);
> +}

There's nothing PCI specific about this and 'reset-gpios' is pretty 
widely used. Either we should have this somewhere common or perhaps not 
worth a wrapper to save 1 parameter.

Also, I believe you can pass just 'reset' so the deprecated form 
'reset-gpio' can also be supported. 

Rob
