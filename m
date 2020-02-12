Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD2159F9C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgBLDmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 22:42:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35391 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgBLDmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 22:42:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so727159oie.2;
        Tue, 11 Feb 2020 19:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tPe7sTayWWBZzGlUQCbzCqIvW36rOIyLLoO5hc2eptg=;
        b=gJKKvum6+KIMyQN1PT+4Un6tw/8+QshaMNQ8mn5RqgeKGhTRxgwgelkAr6wxrbRV9t
         uHLre/owowED3HIc7UcGZkOZjePv6fbvWHkiIvUqIW5JXBHyBaKgags/NjJkjwmFMhRd
         i3AOcnHgZpPcA7Q9Ouet1OkI4YVgxBj2qV15/U/YX6iQoOjlwFKFz3i+J7P1nYfkduv4
         DEdv37YzbBI96VoFqKaZ6xBlIR3hgDAPYH3NIcWUcpuEKegMfinMe82NouApPsq0rMmn
         CQ0/4lm8nPQv+um2HdtxV+gXbrkhVbV+3qHEfty5jMWfj3swql9iAYxmJRiW5VSJPmlS
         EHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPe7sTayWWBZzGlUQCbzCqIvW36rOIyLLoO5hc2eptg=;
        b=ny4H10wZ7kod1Dydrkk+bS09NZn3B9Ulwi1uQBZkc5q2yV92+Hx6FjNXZjBHa57nww
         XYQmojnGSQlhPFU8xzOBcr+mcdI+S48EEQTOwRmtHGLIDJ5jh3SAXR9Z0Hl4O0Okz1Ny
         V4FMMz8mjfoEYvYaHVdoHe6tJ31G7SyWzMKVN0Y3OWLkZNOUXRwYXwkbocKbZE49vJWy
         C69jVXL8HJBS4molHzGAPuQRvwsaTEKjF7hkPrwd136qAqx5nJd8LdfNC+YGbQGH33+B
         We8IvKYyztBRlYrsufQRKSG3uqYXmG7IgtqYe1SL8jEL73FqS95G7C6KXmlC8GCV7IXt
         kihQ==
X-Gm-Message-State: APjAAAWomU0O3DEWD0p/y5sQVgKEwr/rLe5riwwllt4tvgQsZ12wRtF4
        tDwq6jp3NpVW/a18hUv+0tI=
X-Google-Smtp-Source: APXvYqxdHgCrQE5Sx0ptTXpecq6+yGFDYQopgvYcRQyajlZHP/h3n8YaFQ0tl474G661j4BKcUFwmA==
X-Received: by 2002:aca:1c09:: with SMTP id c9mr5137811oic.85.1581478962535;
        Tue, 11 Feb 2020 19:42:42 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m69sm1928958otc.78.2020.02.11.19.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 19:42:41 -0800 (PST)
Date:   Tue, 11 Feb 2020 20:42:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 5/6] PCI: rcar: Add support for rcar PCIe controller
 in endpoint mode
Message-ID: <20200212034239.GA38314@ubuntu-m2-xlarge-x86>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208183641.6674-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lad,

On Sat, Feb 08, 2020 at 06:36:40PM +0000, Lad Prabhakar wrote:
> This patch adds support for rcar PCIe controller to work in endpoint mode.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/Kconfig        |   7 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pcie-rcar-ep.c | 492 ++++++++++++++++++++++++++++++++++
>  drivers/pci/controller/pcie-rcar.h    |   6 +
>  4 files changed, 506 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
> 

<snip>

> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> new file mode 100644
> index 0000000..32a7fca
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-rcar-ep.c

<snip>

> +static int rcar_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> +				struct pci_epf_bar *epf_bar)
> +{
> +	struct rcar_pcie *ep = epc_get_drvdata(epc);
> +	dma_addr_t cpu_addr = epf_bar->phys_addr;
> +	int flags = epf_bar->flags | LAR_ENABLE | LAM_64BIT;
> +	enum pci_barno bar = epf_bar->barno;
> +	u64 size = 1ULL << fls64(epf_bar->size - 1);
> +	u32 mask;
> +	int idx;
> +	int err;
> +
> +	idx = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
> +	if (idx >= ep->num_ib_windows) {
> +		dev_err(ep->dev, "no free inbound window\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO)
> +		flags |= IO_SPACE;
> +
> +	ep->bar_to_atu[bar] = idx;
> +	/* use 64 bit bars */
> +	set_bit(idx, ep->ib_window_map);
> +	set_bit(idx + 1, ep->ib_window_map);
> +
> +	if (cpu_addr > 0) {
> +		unsigned long nr_zeros = __ffs64(cpu_addr);
> +		u64 alignment = 1ULL << nr_zeros;
> +
> +		size = min(size, alignment);
> +	} else {
> +		size = size;
> +	}

We received a report from the 0day bot that clang warns that this is
unnecessary. Would you mind removing it if you have to spin up a new
version?

You can view the full report here:

https://groups.google.com/d/msg/clang-built-linux/KHUKw5L8yxw/Mb7KRMG7BQAJ

Cheers,
Nathan
