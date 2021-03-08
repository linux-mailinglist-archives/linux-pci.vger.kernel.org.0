Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29D331AFA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 00:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCHXgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 18:36:36 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39423 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHXf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 18:35:57 -0500
Received: by mail-wr1-f43.google.com with SMTP id b18so13251261wrn.6;
        Mon, 08 Mar 2021 15:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K67rR2cz1Q7CfHsvPx+dMATB9DP+9YT/J61wglUubUU=;
        b=XSXLXD7bSgmNIwkJMdsQc5yVGbO6uxcvymq/gXvgUXZF/H6yjLGz89wDLKfDp1MCZv
         YSPwU14eGBsype4wsS5TQIfiSYaKnt/HLQnFeQFOG3xXv/GGZq8HdB12Q3dQLGju71qw
         P2oISYFClL7jmpVQIvqWJwTd4ItwnyT2VqVXBEnGJ2kNkvMt3HAx8S9h+p5X58gKGwvn
         POS+GGujkx/jPq1w/ABqMUiA/pIkXiL2nu5q2FLKcg+3J1eXMKU68eZHHRicj2qaw2nK
         zrS0PYSZlK1Ne9xIFRKOOBLXVPDIOa+QKw59MyFUnc9r05VS7HnWei1tF2MoaIX3Qyr/
         QIKw==
X-Gm-Message-State: AOAM531saXBqdHndJ4FKVXqzeOCKAE/y9BEjSdY4qHlSyGW3eQDyNGxK
        598JxEnHtf7pqrjr73RwFUk=
X-Google-Smtp-Source: ABdhPJxIo5ED286zGo5sDuM1NNSlbW7hAT37M57yIHfxV5NJ+vlrAPXSTvl4w23Q5VzJFHh51Jut6A==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr5345694wrr.302.1615246556238;
        Mon, 08 Mar 2021 15:35:56 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u3sm20897860wrt.82.2021.03.08.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:35:55 -0800 (PST)
Date:   Tue, 9 Mar 2021 00:35:54 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] nPCI: brcmstb: Use reset/rearm instead of
 deassert/assert
Message-ID: <YEa02utsc/thd8FV@rocinante>
References: <20210308195037.1503-1-jim2101024@gmail.com>
 <20210308195037.1503-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308195037.1503-3-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patches over!

> The Brcmstb PCIe RC uses a reset control "rescal" for certain chips.  This
[...]

A small suggestion: it would be nicer to mention "Broadcom STB" rather
than "Brcmstb" in the sentence above.

[...]
> +err1:
> +	reset_control_rearm(pcie->rescal);
> +err0:
>  	clk_disable_unprepare(pcie->clk);
>  	return ret;
[...]

A small nitpick.  Now that there are two labels on the error recovery
path, it might be better to name both of these labels a little bit
better.  Some examples from the PCI tree:

  error_clock_unprepare
  err_disable_clock
  err_disable_clk
  err_clk_disable
  
So it could be:

  err_reset:                                <-- or err_rearm or even err_reset_rearm, etc.
  	reset_control_rearm(pcie->rescal);
  err_disable_clk:
   	clk_disable_unprepare(pcie->clk);

What do you think?

Krzysztof
