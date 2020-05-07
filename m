Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27291C9DF2
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGVw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:52:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35817 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:52:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id k110so5900245otc.2;
        Thu, 07 May 2020 14:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CU/jhaPmhAqWWMxE+0ciw1zj8C+7RdKkmDqSPqeUli8=;
        b=ECf0ToFO/iFtn71D4Kvx0tUpUrFRTQFNS8AwPf1AEerJpYWqShI01SNy/ud8UUea88
         xDkqT/WojV6XxNF6HczHC/1IhoNkYRxkBsWABoP2mED4eouVtBAyeDCI+lrVYo0nbxW/
         4Evwul7yLpuDrnTXV4fBN6uzGQFhDXqv0ulcglcX8P72RlAbElH9cggm6V4vlGRYpMea
         ErW5nNRZvh1H9pb6fRdGOZw0Vwm99f9aOh23YhMFNdShOIC3lqYNe+bI6zlEpfhmCR/O
         PTABrbBdr6OhJyzECgQmnyKcuP3Cjq1g4JyO+rT6kZm1K5U7/N2Y0JN5D9kXPg2PDo+t
         zVxQ==
X-Gm-Message-State: AGi0PuYoFJOtqifihA2XGYureuniW90G7TYOvf6T25RkkPVAJMAqlKS1
        TkNs88uDjz/1tTqYSxiteg==
X-Google-Smtp-Source: APiQypI1zeZzisqllNqDsttAgfTLEwQGuSYUTjKm2oOFsg8op6zupqbBMYh9erodVZ5cDOxXvTFLIw==
X-Received: by 2002:a9d:592:: with SMTP id 18mr11812118otd.337.1588888378253;
        Thu, 07 May 2020 14:52:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w62sm1680584oia.32.2020.05.07.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:52:57 -0700 (PDT)
Received: (nullmailer pid 8285 invoked by uid 1000);
        Thu, 07 May 2020 21:52:56 -0000
Date:   Thu, 7 May 2020 16:52:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Message-ID: <20200507215256.GA8228@bogus>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161318.26200-5-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  5 May 2020 18:13:17 +0200, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideoCore. Inform VideoCore that VL805 was just reset.
> 
> Also, as this creates a dependency between USB_PCI and VideoCore's
> firmware interface, and since USB_PCI can't be set as a module neither
> this can. Reflect that on the firmware interface Kconfg.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> Changes since v5:
>  - Fix Kconfig issue with allmodconfig
> 
> Changes since v4:
>  - Do not split up error message
> 
> Changes since v3:
>  - Add more complete error message
> 
> Changes since v1:
>  - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
>    gets compiled when needed.
> 
>  drivers/firmware/Kconfig      |  3 ++-
>  drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
