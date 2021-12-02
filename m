Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899FC46609D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 10:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356504AbhLBJrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 04:47:53 -0500
Received: from foss.arm.com ([217.140.110.172]:60386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356560AbhLBJr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 04:47:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9121435;
        Thu,  2 Dec 2021 01:44:05 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.32.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1BC3F7D7;
        Thu,  2 Dec 2021 01:44:04 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tim Harvey <tharvey@gateworks.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH] PCI: imx: do not remap invalid res
Date:   Thu,  2 Dec 2021 09:43:57 +0000
Message-Id: <163843822274.25378.13456341880706122163.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211101180243.23761-1-tharvey@gateworks.com>
References: <20211101180243.23761-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Nov 2021 11:02:43 -0700, Tim Harvey wrote:
> On imx6 and perhaps others when pcie probes you get a:
> imx6q-pcie 33800000.pcie: invalid resource
> 
> This occurs because the atu is not specified in the DT and as such it
> should not be remapped.
> 
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: imx: do not remap invalid res
      https://git.kernel.org/lpieralisi/pci/c/6e5ebc96ec

Thanks,
Lorenzo
