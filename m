Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18482A094B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfH1SPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:15:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48554 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfH1SPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 14:15:32 -0400
Received: from [104.132.1.107] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i32TX-0000Wu-Cc; Wed, 28 Aug 2019 20:15:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Properly handle optional regulators
Date:   Wed, 28 Aug 2019 20:15:15 +0200
Message-ID: <1801971.F4Ds6vmZ8I@phil>
In-Reply-To: <20190828150737.30285-1-thierry.reding@gmail.com>
References: <20190828150737.30285-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, 28. August 2019, 17:07:37 CEST schrieb Thierry Reding:
> From: Thierry Reding <treding@nvidia.com>
> 
> regulator_get_optional() can fail for a number of reasons besides probe
> deferral. It can for example return -ENOMEM if it runs out of memory as
> it tries to allocate data structures. Propagating only -EPROBE_DEFER is
> problematic because it results in these legitimately fatal errors being
> treated as "regulator not specified in DT".
> 
> What we really want is to ignore the optional regulators only if they
> have not been specified in DT. regulator_get_optional() returns -ENODEV
> in this case, so that's the special case that we need to handle. So we
> propagate all errors, except -ENODEV, so that real failures will still
> cause the driver to fail probe.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

on a rk3399-gru-scarlet with no 12v regulator defined and pcie-wifi
keeping on working with this patch:

Tested-by: Heiko Stuebner <heiko@sntech.de>

Change itself also looks correct,

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for doing that cleanup
Heiko


