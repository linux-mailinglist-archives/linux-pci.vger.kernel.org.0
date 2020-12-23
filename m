Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA142E21E1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Dec 2020 22:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgLWVF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 16:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgLWVF0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Dec 2020 16:05:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB2C82246B;
        Wed, 23 Dec 2020 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608757486;
        bh=EvlI3xLiJ6AxG6iBz0S4MmgXorYn8mIuiSvkee7Dqo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SWl8PyIctLq3cEmM8IL7CqcOM7RYgf9r3RqewM7n8qlbUvtnhMguXwr748VzmNqh9
         AKjdk3v6LCx6EYluWvmc0gTvMYYKqkFsyY6CJub1MPTneazXqMQ511QPwGmnFcTyZj
         ijxphozqVkwg2VmYbtomnv5Qzfr6g/R4X8IGTUGZSGIg89Jpeh36sPYZOGZ94RI6GL
         RAknVayAIGlqJP8wD/2GSp8GptdPxsgoVSbdTKzd+6edhh0YYAg6UFnGoav+0dBYn3
         NYGD3JYcCSUGbVjUPvvo/oYr2O2tUk71moeyDtum6ZrkAtV8feiVeljeGNLOHmPXan
         0LhGP/mLC0A1g==
Date:   Wed, 23 Dec 2020 15:04:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-pci@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>
Subject: Re: pcie-rockchip-ep.c coverity issue #1437163
Message-ID: <20201223210444.GA322275@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a290a9-678b-b08d-25b4-8299f2f2c916@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Wed, Oct 28, 2020 at 08:34:45AM +0800, Shawn Lin wrote:
> On 2020/10/28 0:16, Bjorn Helgaas wrote:
> > Hi Shawn,
> > 
> > Please take a look at this issue reported by Coverity:
> > 
> > 332 static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
> > 333 {
> > 334        struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> > 335        struct rockchip_pcie *rockchip = &ep->rockchip;
> > 336        u16 flags;
> > 337
> > 338        flags = rockchip_pcie_read(rockchip,
> > 339                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> > 340                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> > 
> > CID 1437163 (#2 of 2): Operands don't affect result
> > (CONSTANT_EXPRESSION_RESULT) result_independent_of_operands: flags &
> > (65536UL /* 1UL << 16 */) is always 0 regardless of the values of its
> > operands. This occurs as the logical operand of !.
> > 
> > 341        if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
> > 342                return -EINVAL;
> 
> Actually it should be BIT(0) instead of BIT(16),
> I will fix it, thanks.

Just a quick reminder about this and the similar issue in
rockchip_pcie_ep_send_msi_irq().

Your response above didn't seem to make it to the archive, so maybe
your patch to fix it also got lost?

Krzysztof also pointed out that rockchip_pcie_read() returns u32,
while flags is only u16.

Bjorn
