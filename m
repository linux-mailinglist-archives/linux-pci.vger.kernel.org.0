Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB7FB09
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfD3OG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 10:06:27 -0400
Received: from foss.arm.com ([217.140.101.70]:48040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfD3OG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 10:06:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64DCD80D;
        Tue, 30 Apr 2019 07:06:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85A763F719;
        Tue, 30 Apr 2019 07:06:24 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:06:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [RFC PATCH v1] PCI: qcom: Use quirk to override incorrect device
 class
Message-ID: <20190430140621.GB18742@e121166-lin.cambridge.arm.com>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 12, 2019 at 06:34:55PM +0100, Marc Gonzalez wrote:
> On 12/03/2019 18:18, Marc Gonzalez wrote:
> 
> > On 12/03/2019 13:42, Stanimir Varbanov wrote:
> > 
> >> I wonder, in case that dw_pcie_setup_rc() already has a write to
> >> PCI_CLASS_DEVICE configuration register to set it as a bridge do we
> >> still need to do the above fixup?
> > 
> > I don't know, I don't have an affected device. Unless the msm8998 /is/ affected,
> > and dw_pcie_setup_rc() actually fixes it?
> 
> I think you hit the nail on the head...
> 
> If I comment out
> //dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> from dw_pcie_setup_rc()
> then pci_class() returns 0xff000000 instead of 0x6040000
> 
> So perhaps you're right: the quirk can be omitted altogether.
> Unless it is not possible to program the device class on older chips?

Marc,

I would drop this patch from the PCI queue since in a different
form it was already merged, please let me know if I am wrong.

Thanks,
Lorenzo
