Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A102A7AC6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 07:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfIDFhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 01:37:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43363 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfIDFhN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 01:37:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so6397244pgb.10
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2019 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uE8xeQ7vNKg/s6NUUP8wb0BKxjOZa8xbhpDvYMGFXO0=;
        b=F++lDZyrC2eVfSHOVXko4T72RXSBTSeAwJG9fgn3u+9G8PDwCa14qTG/cIwj22Rf8g
         t7Jj5s6mmPoxTiaGxRI+uL++ezS8u99rA7WC/BfzO0bw/YcMls1HLcjRefL/HWcWtpdm
         ikM3u7yNhgXgUbQH677gq7iYdwGzCBexvY1TB9j4y6VN6fklGpWW4Pb8vcth+gyivJ8v
         EW1g5vhaK1gxoCf9BwoXYdLp55WYwSZ6cFe+IHAAkBw7drh+BpzACjY/BzEXxDmbx0PW
         MZ0lCGNx2sRsS+fhekgSWR/JTXrnIX2zl5xglYiOuNxAE6BXtthXoFQJ4ym0MIN7pmNW
         yUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uE8xeQ7vNKg/s6NUUP8wb0BKxjOZa8xbhpDvYMGFXO0=;
        b=jbEZF041KGTiXyeFlMo+2E6Z/aJsB7BwATvhF34lTZRE6yTpJAQ8SjFF8xz3B2LVTU
         sJswrNjE3R9zDIWMlBbm+Ef8ANzR/ZzWhmcflCZkdXO4d78A87cqbVcTv9LWtRVZ+To+
         fvZlX3Xvk2yyuutqi+voJaTuozwoAf5wTPLFqXdXD3+ekMiLZNzOH3CJHLASBOo+zYFZ
         7xtbqAjPthF4rSn1e8+psEmainzwcW3r3xgtredHzTjvDkE4zAtSyXq+bUValLYE7v9G
         RAfxsPYhHc8g1v7HcRU/QKmDHkkgjk+D0xpbQCsBbAsqCA5nMsy1au6O4oeiF7svYDFZ
         VWBQ==
X-Gm-Message-State: APjAAAWow8NaNx5CVt6WlKALaXcPf/PEqqSANqPLSc5Tl6Qp7R4s2CqN
        tkIpnMg9zifH5dHew0WuMBkCPxqu
X-Google-Smtp-Source: APXvYqyEFAAw+BNftadAQ4oorLGOkbtIzvUAeY+P0+LwqoUZPLjHBY7F2Cw7K1dHnhI8XPJEakvcZQ==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr3254703pjb.30.1567575432983;
        Tue, 03 Sep 2019 22:37:12 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id q33sm2063273pja.29.2019.09.03.22.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 22:37:12 -0700 (PDT)
Message-ID: <026a6bfbfd8268c5158bc48fb43907cc13442561.camel@gmail.com>
Subject: Re: [PATCH v5 18/23] powerpc/pci: Handle BAR movement
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Date:   Wed, 04 Sep 2019 15:37:07 +1000
In-Reply-To: <20190816165101.911-19-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
         <20190816165101.911-19-s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-08-16 at 19:50 +0300, Sergey Miroshnichenko wrote:
> Add pcibios_rescan_prepare()/_done() hooks for the powerpc platform. Now if
> the device's driver supports movable BARs, pcibios_rescan_prepare() will be
> called after the device is stopped, and pcibios_rescan_done() - before it
> resumes. There are no memory requests to this device between the hooks, so
> it it safe to rebuild the EEH address cache during that.
> 
> CC: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/kernel/pci-hotplug.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 0b0cf8168b47..18cf13bba228 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -144,3 +144,13 @@ void pci_hp_add_devices(struct pci_bus *bus)
>  	pcibios_finish_adding_to_bus(bus);
>  }
>  EXPORT_SYMBOL_GPL(pci_hp_add_devices);
> +
> +void pcibios_rescan_prepare(struct pci_dev *pdev)
> +{
> +	eeh_addr_cache_rmv_dev(pdev);
> +}
> +
> +void pcibios_rescan_done(struct pci_dev *pdev)
> +{
> +	eeh_addr_cache_insert_dev(pdev);
> +}

Is this actually sufficent? The PE number for a device is largely
determined by the location of the MMIO BARs. If you move a BAR far
enough the PE number stored in the eeh_pe would need to be updated as
well.

