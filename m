Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6903D3B3537
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFXSJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 14:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXSJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 14:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 156DE613C2;
        Thu, 24 Jun 2021 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624558045;
        bh=pjMUPrrv0IdP4953FNP37zcXZsFA4aLGtJ+obsfpazk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=neRWxIrqAWWOEkcLHfsWvPPyu8qHYf6O9+nesgtq1VQP8radZCRQXZ+6VtdUNm3oM
         Jp1zCSR/ylOCpKO5BlnlUOIO9weCvaYDoXX3gjSTGd8jp1Sa1D98qOuliarKECNB6+
         dkHjIORbEU19r8Tu9ljhk7hpIEvvIWVL4ewuBZ/TevsuSdCb22xCwD4RS675vQQmqV
         vceDnsfcanJD99jLvxstqp93LMtoYINKrJJ+jPhPG53JwJcnx8OiJZmcR8BCVJKJyX
         R/Ol8oQQwbhgxUsOUYuP7uXFkCyHNCbZd92VHTzEZWd7zXidEx7t7NgzIldikW2ICX
         KkRRor4L7EWEQ==
Date:   Thu, 24 Jun 2021 13:07:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v10] PCI: rockchip: Add Rockchip RK356X host controller
 driver
Message-ID: <20210624180723.GA3543267@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624021548.447301-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This needs a new driver name.  We already have a "rockchip" driver
(drivers/pci/controller/pcie-rockchip-host.c) and this one needs a
different name that we can use in the subject line and similar places,
e.g., something like:

  PCI: rockchip-dwc: 

Using "rockchip" for the other driver might have been a mistake.  We
should probably use something a little more specific for this driver
to leave room for Rockchip to produce future hardware that may require
a *third* driver.

On Thu, Jun 24, 2021 at 10:15:47AM +0800, Simon Xue wrote:
> Add a driver for the DesignWare-based PCIe controller found on
> RK356X. The existing pcie-rockchip-host driver is only used for
> the Rockchip-designed IP found on RK3399.
