Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26FE18D856
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCTTWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 15:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCTTWs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 15:22:48 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E582070A;
        Fri, 20 Mar 2020 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584732167;
        bh=rWnoP1riuCvNNYCzIbjMc7qlfY3uiyflNfFYWPDEhU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NpDppWNKQ52upTUQbZAmJIh9nI/tN1HMTzOR3Qs7mOPciRLiMc0lgnqKXeEPAwLF5
         Q8pLQUUDBVSo97ubsDW9mZhsUzY3xeXt5riduh5LmplytDICjotdFfocsS1k7uQluD
         Bkvx+fL8sfG+MJOjO8Qxuo1arUqbwlLPm/Z2HXFw=
Date:   Fri, 20 Mar 2020 14:22:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] pcie: qcom: add tx term offset support
Message-ID: <20200320192245.GA242952@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-7-ansuelsmth@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:49PM +0100, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add tx term offset support to pcie qcom driver
> need in some revision of the ipq806x soc

The usual (s/pcie/PCIe/, s/soc/SoC/, wrap to fill 75 columns, add
period at end).  Apply to all patches.

> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	(0x1f << 16)
> +#define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		(x << 16)

Since the rest of the file uses BIT(), I think it would make sense to
use GENMASK() here.  And below, of course.

> +static inline void
> +writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)

Follow coding style of rest of file, i.e.,

  static inline void writel_masked(...)

The name "writel_masked" suggests that we're writing "val & mask" to a
register, but that's not what's happening.  This is really a "clear
some bits and set others" operation.

The names are wordy, but we do have pci_clear_and_set_dword(),
pcie_capability_clear_and_set_word(), etc., functions that work
similarly.

> +{
> +	u32 val = readl(addr);
> +
> +	val &= ~clear_mask;
> +	val |= set_mask;
> +	writel(val, addr);
> +}

> +	/* Set Tx termination offset */

Capitalize consistently with other comments in the file.  Below also.
Hmm, I see the file is already a bit of a mess in that regard.  So
just do what you can.
