Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E0123DFF8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHFR4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgHFR4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2020 13:56:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881AAC061574
        for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2020 10:55:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so44301173wro.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2020 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VLToQkSGb9Fyj+rMmCyIoE12BtD4sRvLhirgEOkP9W4=;
        b=aiclBWRQsaqlr4rxoQqEFfHk424DkMeqTmreM/zu7IQoemedoiGmY1RO05MmpZR6+P
         w7xGe9fU76E3VMZ7Isj9CVyq5FEg4I8VDs+q0YobHeP9Ohy4GB5+BKuoR/WEUbUXJdph
         UquQ9WkUAjpPvjtyL6o6gTPDC/x9qzlzrlEYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VLToQkSGb9Fyj+rMmCyIoE12BtD4sRvLhirgEOkP9W4=;
        b=S+sjxR5bUikN14upeM3XQaRgzaeeZzj+HWpX7W5Q2qAtD71EIskvoSgNp6S1yGSbyI
         9h45le7ppGzxph/jgPwfUS6jRL8goURpyAEoXNV2Nvxz4RsxwEcTuwx+hTodSy/OC6tu
         YagpdOlkHEeW4330PrLSj9teF8GM70fe57dZcE5XDl2c2pO4F9pU9GvmHm3YRI7/juRs
         j30akNE1xVkYGFjliF3zfpAR2USuBYaBReD9hT+IIaCrbKEfd9JpmhlkaGaWsQUm1n8q
         4niuq1YZQ/0TpUQieNb/MoXleq+psQJFTZP9bNGEU2EWpAYa9kdGb9XwHE7FC5reQJ3X
         AfAQ==
X-Gm-Message-State: AOAM532Pz+qWHIg2IRGVIw/4QXOV8TxeJRllaUJRLX6HzpuKpTS4/xeI
        hhVW30h8GF3FUBmazdVEbk32Ow==
X-Google-Smtp-Source: ABdhPJzbtHnvN2YvogoQjvg6Nr1wWat0eDA9t2hrW3lsNiU9zCFscq1A7+T3HDp3Wo7bjV+9E+cWiQ==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr8403518wrg.102.1596736558012;
        Thu, 06 Aug 2020 10:55:58 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l11sm6978590wme.11.2020.08.06.10.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 10:55:57 -0700 (PDT)
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <16cbd3f5-722a-cf8b-487e-82a0bbf95053@broadcom.com>
Date:   Thu, 6 Aug 2020 10:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good.

On 2020-08-05 9:14 p.m., Mark Tomlinson wrote:
> For hardware that only supports 32-bit writes to PCI there is the
> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> messages was introduced by fb2659230120, but rate-limiting is not the
> best choice here. Some devices may not show the warnings they should if
> another device has just produced a bunch of warnings. Also, the number
> of messages can be a nuisance on devices which are otherwise working
> fine.
>
> This patch changes the ratelimit to a single warning per bus. This
> ensures no bus is 'starved' of emitting a warning and also that there
> isn't a continuous stream of warnings. It would be preferable to have a
> warning per device, but the pci_dev structure is not available here, and
> a lookup from devfn would be far too slow.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> changes in v4:
>  - Use bitfield rather than bool to save memory (was meant to be in v3).
>
>  drivers/pci/access.c | 9 ++++++---
>  include/linux/pci.h  | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..b452467fd133 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	 * write happen to have any RW1C (write-one-to-clear) bits set, we
>  	 * just inadvertently cleared something we shouldn't have.
>  	 */
> -	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> -			     size, pci_domain_nr(bus), bus->number,
> -			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +	if (!bus->unsafe_warn) {
> +		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> +			 size, pci_domain_nr(bus), bus->number,
> +			 PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +		bus->unsafe_warn = 1;
> +	}
>  
>  	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	tmp = readl(addr) & mask;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 34c1c4f45288..85211a787f8b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -626,6 +626,7 @@ struct pci_bus {
>  	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
>  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
>  	unsigned int		is_added:1;
> +	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
>  };
>  
>  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)

