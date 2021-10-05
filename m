Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A94221AC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhJEJIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:08:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhJEJID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 05:08:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A03F16D;
        Tue,  5 Oct 2021 02:06:13 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F053F66F;
        Tue,  5 Oct 2021 02:06:12 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Remove unused assignment to variable ret
Date:   Tue,  5 Oct 2021 10:06:06 +0100
Message-Id: <163342475495.28942.12201407043947934116.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211003025439.84783-1-kw@linux.com>
References: <20211003025439.84783-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 3 Oct 2021 02:54:39 +0000, Krzysztof Wilczyński wrote:
> Previously, the maximum link speed was set following an "fsl,max-link-speed"
> property read, and should the read failed, then the PCIe generation was
> manually set to PCIe Gen1 and thus limiting the link speed to 2.5 GT/s.
> 
> Code refactoring completed in the commit 39bc5006501c ("PCI: dwc:
> Centralize link gen setting") changed to the logic that was previously
> used to limit the maximum link speed leaving behind an unused assignment
> to a variable "ret".
> 
> [...]

Applied to pci/imx6, thanks!

[1/1] PCI: imx6: Remove unused assignment to variable ret
      https://git.kernel.org/lpieralisi/pci/c/65315ec52c

Thanks,
Lorenzo
