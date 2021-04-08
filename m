Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9138358ADC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhDHRHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:07:03 -0400
Received: from foss.arm.com ([217.140.110.172]:54900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232721AbhDHRGi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 13:06:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C9EE106F;
        Thu,  8 Apr 2021 10:06:26 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BEB13F792;
        Thu,  8 Apr 2021 10:06:23 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix runtime PM imbalance in pex_ep_event_pex_rst_deassert
Date:   Thu,  8 Apr 2021 18:06:17 +0100
Message-Id: <161790156432.1262.12744088516106608861.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210408072700.15791-1-dinghao.liu@zju.edu.cn>
References: <20210408072700.15791-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Apr 2021 15:26:58 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the runtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.

Applied to pci/tegra, thanks!

[1/1] PCI: tegra: Fix runtime PM imbalance in pex_ep_event_pex_rst_deassert
      https://git.kernel.org/lpieralisi/pci/c/571cdd5294

Thanks,
Lorenzo
