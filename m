Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9E3E1561
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbhHENKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 09:10:15 -0400
Received: from foss.arm.com ([217.140.110.172]:45322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240055AbhHENKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 09:10:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 967CC1042;
        Thu,  5 Aug 2021 06:10:00 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11E553F719;
        Thu,  5 Aug 2021 06:09:58 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Fix runtime PM imbalance in rcar_pcie_ep_probe
Date:   Thu,  5 Aug 2021 14:09:52 +0100
Message-Id: <162816897692.18338.7803269041100813329.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408072402.15069-1-dinghao.liu@zju.edu.cn>
References: <20210408072402.15069-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Apr 2021 15:24:02 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the runtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: Fix runtime PM imbalance in rcar_pcie_ep_probe()
      https://git.kernel.org/lpieralisi/pci/c/1e29cd9983

Thanks,
Lorenzo
