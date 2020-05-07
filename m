Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845251C9B5B
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGTsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:48:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41729 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEGTsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 15:48:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id 19so6318585oiy.8
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 12:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHRZN4QXlV+VTyC/AzhlPZ69XG/vCfyxvZQTQirVX+E=;
        b=gH9B0eEGpZHfRm5tWfUjNuRf9jtAEIVCe0xcWQppqiiucUwRB3FptwuHkf2Wmcr93Y
         Fx49Lm7+FDl4JHRyruQ9l3h7UpacrA3TffhlXstD0HTKmqH+LqUiWzqapF1UQOTkdkaY
         y+nrE60NNOCbI2crWHmDcr1dteOhrrcSSTs5IUAe/v1wpj5Pc0DtgHHKJ46cyE+tHTl0
         1O7VR+eeddSH2ryy73ejww2Fm6jOnrIOgpX0Axg6QPnz+vmLF6WwN/oxBs4yTmANNc06
         wZrG0hgmhcOmvG+dxxeQlaJELnhfioTvo7N9zKvlIMpz8zyWOo2K1rDeh0TT6Lf0ZhA2
         PkZw==
X-Gm-Message-State: AGi0PuaUqM9Yk9coaoO6dCtJy3oT+FuLhALZHWqonvmuc5hUFCrciF7V
        dYX8x7ywqIgw+H3StILw2g==
X-Google-Smtp-Source: APiQypILJLNc50XQ5VRltSyZuU/r8YcWYOnXY7wrfzXiXdXAghGO/XkEOBAVXJI72WGG0sjssrVdxQ==
X-Received: by 2002:aca:5358:: with SMTP id h85mr7805471oib.42.1588880896928;
        Thu, 07 May 2020 12:48:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z24sm1555927otq.75.2020.05.07.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:48:16 -0700 (PDT)
Received: (nullmailer pid 32173 invoked by uid 1000);
        Thu, 07 May 2020 19:48:15 -0000
Date:   Thu, 7 May 2020 14:48:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 1/5] PCI: pci-bridge-emul: Fix PCIe bit conflicts
Message-ID: <20200507194815.GA32105@bogus>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
 <20200414203005.5166-2-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414203005.5166-2-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Apr 2020 16:30:01 -0400, Jon Derrick wrote:
> This patch fixes two bit conflicts in the pci-bridge-emul driver:
> 
> 1. Bit 3 of Device Status (19 of Device Control) is marked as both
>    Write-1-to-Clear and Read-Only. It should be Write-1-to-Clear.
>    The Read-Only and Reserved bitmasks are shifted by 1 bit due to this
>    error.
> 
> 2. Bit 12 of Slot Control is marked as both Read-Write and Reserved.
>    It should be Read-Write.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
