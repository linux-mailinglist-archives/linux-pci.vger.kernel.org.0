Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAE1C9DE2
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGVtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:49:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42819 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:49:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id i13so6609505oie.9;
        Thu, 07 May 2020 14:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+K99SXnOq1F0ZjGFhanj1w7QeN74kq3HeaG8Lj+To9M=;
        b=Vtv11yw9JLcRIiZl3lRUcfIYY/NUebo0pIvVCSnXQu17pKTgpRB4Kv4ypGWHuVhIri
         OT6gbZnnwmlMLz6xHKsxRB1LqBiF+VtpELzmG0zvuYyz9TkWFQs+r++q8tDZXCDIHAUI
         El3jd/kTX5KQ6pYj5usTf2dObyIE4M0QsZqgHX8Sj2dcYa2YuUmlbkrO1CdoXMMEN36F
         rv+qWEYt6w+OIi3OrZa6uUt3pXYevHhO+BSOOpu0RGBQvaeAxD9VRKojbGxSvcqDftbQ
         z9FY9mPKYp5c+SocRsROkSAI4/+yXWi3iKS2N7xvhPRlHV08CI35Meg4bPxrm5Nj7Ice
         6CzA==
X-Gm-Message-State: AGi0PuaL6nLcELYPNMLKlOhI/xQwvsicFEOe+v4TGrGhclFe1tCT+lsW
        3gVqVoPQ6xES6OCcUWEw4Q==
X-Google-Smtp-Source: APiQypKdSAfXlYDSJkrzlHUQWVZ3sDz1eGY4XlY4moRp5cxhz0qwaJnHQ2p2QyHEOMcpweAS8N35kw==
X-Received: by 2002:aca:447:: with SMTP id 68mr7898114oie.94.1588888159223;
        Thu, 07 May 2020 14:49:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b25sm1671203otj.7.2020.05.07.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:49:18 -0700 (PDT)
Received: (nullmailer pid 1308 invoked by uid 1000);
        Thu, 07 May 2020 21:49:17 -0000
Date:   Thu, 7 May 2020 16:49:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when  present
Message-ID: <20200507214917.GA876@bogus>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161318.26200-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  5 May 2020 18:13:16 +0200, Nicolas Saenz Julienne wrote:
> xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
> RPi4's VideoCore firmware interface to be up and running. It's possible
> for both initializations to race, so make sure it's available prior to
> starting.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> ---
> 
> Changes since v6:
> - Add more complete comment
> 
>  drivers/pci/controller/pcie-brcmstb.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
