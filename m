Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C591F47F6B8
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 13:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhLZMPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 07:15:03 -0500
Received: from foss.arm.com ([217.140.110.172]:40072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhLZMOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Dec 2021 07:14:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 150FB6D;
        Sun, 26 Dec 2021 04:14:46 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.38.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB09B3F5A1;
        Sun, 26 Dec 2021 04:14:43 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marcel.ziswiler@toradex.com, Richard Zhu <hongxing.zhu@nxp.com>,
        kw@linux.com, tharvey@gateworks.com, l.stach@pengutronix.de,
        bhelgaas@google.com, robh@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8] PCI: imx: Add the imx8mm pcie support
Date:   Sun, 26 Dec 2021 12:14:36 +0000
Message-Id: <164052085510.22541.12108392945712538273.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1640312885-31142-1-git-send-email-hongxing.zhu@nxp.com>
References: <1640312885-31142-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Dec 2021 10:28:04 +0800, Richard Zhu wrote:
> Based on previous review patch-set [1] and no function changes, create
> one update for the last patch only after merge the comments provided
> by Krzysztof.
> - Clean up codes. Drop the redundant inner break, and use the dev_err_probe
>   replace dev_err in _probe().
> - To be consistent, let the error message to be all lower-case letters.
> - Add one comment to explain that there is one single bare break for
>   i.MX8MM in imx6_pcie_init_phy()
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: imx: Add the imx8mm pcie support
      https://git.kernel.org/lpieralisi/pci/c/178e244cb6

Thanks,
Lorenzo
