Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8FF0A7AD2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 07:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDFm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 01:42:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42215 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIDFm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 01:42:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so4052770pfi.9
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2019 22:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/vKI/xtQQlEFNhFbyn9evKm0aZnte8W4Hq+F88vuIdI=;
        b=E7HOIcOFXmqv1o8xG/+0CQv7Cb20qBLrKhBcpvho4TGNzUhwZJ2/dwDBI2YO6UHYpC
         pT8jGuqien6kU5G94FYeaZSNLz3c1lLlH3oKONHZQDCQMZwj+NfP0fQ8HSG/DyN6bqia
         AR7QscQrEQeVb3lOyEr8lXu0RGvU+dhsw67soFeVQZdRnfxIXYmKrOzXJMQ04GjXwE86
         b9rEQYxDJuncEXcCo8GmQ0jwdD8BYjvW1LNgqxk52E8pX5XQGg15N+p/2oCBVT19841h
         qPKthatg1oVRC5XP1Fu+ASx1LVu8sOIsh2244fsw/TUHSrHQC5kWIMdZmMHdcL9Gtk9h
         rg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/vKI/xtQQlEFNhFbyn9evKm0aZnte8W4Hq+F88vuIdI=;
        b=NdmuSbmr3BlsNAtHac2conkkf7ZEzirGdwlJeJWT8nLS4rjwqiowgAIe6ZTjlD+yEm
         YKGOh5+a4YBsVwX67itd8ENZqhEnlEu+ijYl8326XZnldt0A6FBl1u//kVvRHmu3HZbs
         oZHD7hmlM/uZPBERNWOeyR/iKgMhaTnEFXiCaIwT5Q4+Mrx6AMdkphUngff8zWwP4ijz
         u8yiq/f9UpLKDExDLlIBN5nTeScM86R7FYlLMO8w0JV9A6MmrOpsNY2b2/UT0Zq+loXI
         edAJOqZTkPM9gUwRAzTQge3RUmhA15BLP9G1kpMbpYSEUN07ieiFpfZUvTj7vfTw5O6C
         62dw==
X-Gm-Message-State: APjAAAUc5RO+7rrgCHvljnaQCfgejV1dRJzOIBueNaTngLzQoEvIoMl4
        Q/xH+mj2Ge2x0vYNGy0xhKs=
X-Google-Smtp-Source: APXvYqycDvwzhznYAgJsQ1bBhLESqy4XeRJ7wlvJq1+JUK0lZ1bSVQ0c71FiPGuNvgra0pyHGZrPLA==
X-Received: by 2002:a62:e802:: with SMTP id c2mr8693508pfi.212.1567575776084;
        Tue, 03 Sep 2019 22:42:56 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id b5sm29335714pfp.38.2019.09.03.22.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 22:42:55 -0700 (PDT)
Message-ID: <1edd23fd93386d8a69bc9280329b2d7c819155d4.camel@gmail.com>
Subject: Re: [PATCH v5 16/23] PCI: hotplug: movable BARs: Don't reserve
 IO/mem bus space
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Date:   Wed, 04 Sep 2019 15:42:50 +1000
In-Reply-To: <20190816165101.911-17-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
         <20190816165101.911-17-s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-08-16 at 19:50 +0300, Sergey Miroshnichenko wrote:
> A hotplugged bridge with many hotplug-capable ports may request
> reserving more IO space than the machine has. This could be overridden
> with the "hpiosize=" kernel argument though.
> 
> But when BARs are movable, there are no need to reserve space anymore:
> new BARs are allocated not from reserved gaps, but via rearranging the
> existing BARs. Requesting a precise amount of space for bridge windows
> increases the chances of adding the new bridge successfully.

It wouldn't hurt to reserve some memory space to prevent unnecessary
BAR shuffling at runtime. If it turns out that we need more space then
we can always fall back to re-assigning the whole tree.

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index c7b7e30c6284..7d64ec8e7088 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1287,7 +1287,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  
>  	case PCI_HEADER_TYPE_BRIDGE:
>  		pci_bridge_check_ranges(bus);
> -		if (bus->self->is_hotplug_bridge) {
> +		if (bus->self->is_hotplug_bridge && !pci_movable_bars_enabled()) {
>  			additional_io_size  = pci_hotplug_io_size;
>  			additional_mem_size = pci_hotplug_mem_size;
>  		}

