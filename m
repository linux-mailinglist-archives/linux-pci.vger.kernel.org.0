Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF542C201
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhJMOCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 10:02:53 -0400
Received: from foss.arm.com ([217.140.110.172]:39720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhJMOCw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 10:02:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C866D6E;
        Wed, 13 Oct 2021 07:00:49 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABE123F694;
        Wed, 13 Oct 2021 07:00:47 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Simon Xue <xxm@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Wed, 13 Oct 2021 15:00:42 +0100
Message-Id: <163413363029.8588.8606291946135635809.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210818093406.157788-1-xxm@rock-chips.com>
References: <20210818093406.157788-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Aug 2021 17:34:06 +0800, Simon Xue wrote:
> Document DT bindings for PCIe controller found on Rockchip SoC.
> 
> 

Applied to pci/dt, thanks!

[1/1] dt-bindings: rockchip: Add DesignWare based PCIe controller
      https://git.kernel.org/lpieralisi/pci/c/af7cda832f

Thanks,
Lorenzo
