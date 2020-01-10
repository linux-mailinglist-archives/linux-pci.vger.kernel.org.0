Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F84137428
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgAJQzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 11:55:40 -0500
Received: from foss.arm.com ([217.140.110.172]:48516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgAJQzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 11:55:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04EA830E;
        Fri, 10 Jan 2020 08:55:40 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C308B3F6C4;
        Fri, 10 Jan 2020 08:55:38 -0800 (PST)
Date:   Fri, 10 Jan 2020 16:55:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: qcom: Add support for SDM845 PCIe
Message-ID: <20200110165533.GA885@e121166-lin.cambridge.arm.com>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
 <20191227012349.GG1908628@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227012349.GG1908628@ripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 26, 2019 at 05:23:49PM -0800, Bjorn Andersson wrote:
> On Wed 06 Nov 16:16 PST 2019, Bjorn Andersson wrote:
> 
> Bjorn, this still applies nicely on linux-next and works as expected.
> Could you please apply it? Or would you like me to resend it with
> people's tags picked up?

Applied to pci/qcom for v5.6, thanks.

Lorenzo

> Regards,
> Bjorn
> 
> > This adds support necessary for the two PCIe controllers found in Qualcomm
> > SDM845.
> > 
> > Bjorn Andersson (2):
> >   dt-bindings: PCI: qcom: Add support for SDM845 PCIe
> >   PCI: qcom: Add support for SDM845 PCIe controller
> > 
> >  .../devicetree/bindings/pci/qcom,pcie.txt     |  19 +++
> >  drivers/pci/controller/dwc/pcie-qcom.c        | 150 ++++++++++++++++++
> >  2 files changed, 169 insertions(+)
> > 
> > -- 
> > 2.23.0
> > 
