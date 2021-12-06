Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773E746951F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 12:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbhLFLnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 06:43:15 -0500
Received: from foss.arm.com ([217.140.110.172]:54930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241994AbhLFLnO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 06:43:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D76751042;
        Mon,  6 Dec 2021 03:39:45 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.33.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5077B3F73D;
        Mon,  6 Dec 2021 03:39:44 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH linux-next] PCI: qcom-ep: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Mon,  6 Dec 2021 11:39:36 +0000
Message-Id: <163879076227.16791.16581448019672961369.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211027112931.37182-1-kw@linux.com>
References: <20211027112931.37182-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 27 Oct 2021 11:29:31 +0000, Krzysztof Wilczyński wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> This change is as per suggestions from Coccinelle, e.g.,
>   drivers/pci/controller/dwc/pcie-qcom-ep.c:556:2-9: line 556 is redundant because platform_get_irq() already prints an error
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: qcom-ep: Remove surplus dev_err() when using platform_get_irq_byname()
      https://git.kernel.org/lpieralisi/pci/c/549bf94dd2

Thanks,
Lorenzo
