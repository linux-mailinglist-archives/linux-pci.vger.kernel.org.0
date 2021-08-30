Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E73FB291
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhH3Ihl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3Ihl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:37:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDB1460E90;
        Mon, 30 Aug 2021 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630312608;
        bh=U1Bz+TRPE0qWHJ914Agg77D2LCyxrGJYD98I0IgzduI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ACAJ/8opjlZkYWqPkc/po7IKe6UsMR372P2D3M0nWcSwPziCe9rfvwHFNzmGkBF77
         AdBnGtgHa3hwiaxGlK/KK6q3dz0IRISJ9AwpWxgij42rEdZ/zS5TEVsPRWC4eHZz6F
         C5TMhkXbp9q6yLx/NEs0LfsNm/h0K6aGqPmFcM1BTdYDyP0+v1p5a/VCJJw1ngpb21
         rp2//0piv30bOzwAhhoXQiOEUpSWjgx1m1jp/VrhZeorH9SOMM/rvVJtoFHSpdFPmx
         vi0VzTg+CE57l/Ls6Gd8yAlNxNq/HlCPAX8mQLhVdFFIREOqUMDG7AWum71adhq0VU
         D6NlaGykdHhaw==
Message-ID: <44ad79081412af289c68e74cdecb6a2baa2e873c.camel@kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Aug 2021 10:36:43 +0200
In-Reply-To: <20210826071557.29239-3-jeremy.linton@arm.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
         <20210826071557.29239-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jeremy,
sorry for the late reply, I've been on vacation.

On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:

[...]

> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus,
> +					unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	void __iomem *base = cfg->win;
> +	int idx;
> +	u32 up;
> +
> +	/* Accesses to the RC go right to the RC registers if slot==0 */
> +	if (pci_is_root_bus(bus))
> +		return PCI_SLOT(devfn) ? NULL : base + where;
> +
> +	/*
> +	 * Assure the link is up before sending requests downstream. This is done
> +	 * to avoid sending transactions to EPs that don't exist. Link flap
> +	 * conditions/etc make this race more probable. The resulting unrecoverable
> +	 * SERRORs will result in the machine crashing.
> +	 */
> +	up = readl(base + PCIE_MISC_PCIE_STATUS);
> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
> +		return NULL;
> +
> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
> +		return NULL;

Couldn't this be integrated in the original brcm_pcie_map_conf()? IIUC there is
nothing ACPI specific about it. It'd also make for less code duplication.

Regards,
Nicolas

