Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87433303AE6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404589AbhAZK5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 05:57:06 -0500
Received: from foss.arm.com ([217.140.110.172]:33318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404554AbhAZK46 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 05:56:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1EBD6E;
        Tue, 26 Jan 2021 02:56:10 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.43.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E284B3F66B;
        Tue, 26 Jan 2021 02:56:08 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
Date:   Tue, 26 Jan 2021 10:55:58 +0000
Message-Id: <161165853056.18662.6546479628438785039.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210120105246.23218-1-michael@walle.cc>
References: <20210120105246.23218-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Jan 2021 11:52:46 +0100, Michael Walle wrote:
> fw_devlink will defer the probe until all suppliers are ready. We can't
> use builtin_platform_driver_probe() because it doesn't retry after probe
> deferral. Convert it to builtin_platform_driver().

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: layerscape: Convert to builtin_platform_driver()
      https://git.kernel.org/lpieralisi/pci/c/538157be1e

Thanks,
Lorenzo
