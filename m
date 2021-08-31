Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561FD3FC9EC
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhHaOjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 10:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhHaOjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 10:39:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0C6F60F91;
        Tue, 31 Aug 2021 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420721;
        bh=6obG3EWY8MJUaRtOjEQePHAgTbi/IVRVmFayceuFgCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZYavu6YjFg1t3BR4Zr8XkA/4j7Z4avQ85Hbzti7gbafz+rs7wqpf/Kjp3K/k7hS5
         jBTFpCzrNVFCYd3gAEL7QayYgs4SDb7Be4u4lj+pxa8blm7gkwswM87ODsD3CwhWkg
         WoYoPGrSEI3NMAYzY/XUjbU4lXuF6pGDk98hde/LeKGaUAOZZE67HLLcylEGo2j4Fa
         p2BoMB3p8FZr5kDoNzmpwdw4zN0PzWPhpdjhgIRRxoJ/ZiOL2xgFCvA+ytThp/C57w
         Oc9QkcaXiSeHHWBfzJHEpBSynjuPfR6APgBlXr1SHeE5iOj33d0i6+DpphviMxwZEN
         VXgDqrKtSHAUg==
Date:   Tue, 31 Aug 2021 15:38:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 3/3] PCI: Set dma-can-stall for HiSilicon chips
Message-ID: <20210831143835.GA31947@willie-the-truck>
References: <20210826182624.GA3694827@bjorn-Precision-5520>
 <225e905d-b7b2-c740-de94-2f4aece75f59@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225e905d-b7b2-c740-de94-2f4aece75f59@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 08:12:12PM +0100, Robin Murphy wrote:
> On 2021-08-26 19:26, Bjorn Helgaas wrote:
> > [+cc Will, Robin, Joerg, hoping for an ack]
> > 
> > On Tue, Jul 13, 2021 at 10:54:36AM +0800, Zhangfei Gao wrote:
> > > HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
> > > actually on the AMBA bus. These fake PCI devices can support SVA via
> > > SMMU stall feature, by setting dma-can-stall for ACPI platforms.
> > > 
> > > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > > ---
> > >   drivers/pci/quirks.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 5d46ac6..03b0f98 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -1823,10 +1823,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
> > >   static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
> > >   {
> > > +	struct property_entry properties[] = {
> > > +		PROPERTY_ENTRY_BOOL("dma-can-stall"),
> > 
> > "dma-can-stall" is used in arm_smmu_probe_device() to help set
> > master->stall_enabled.
> > 
> > I don't know the implications, so it'd be nice to get an ack from a
> > maintainer of that code.
> 
> If it helps,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> Normally stalling must not be enabled for PCI devices, since it would break
> the PCI requirement for free-flowing writes and may lead to deadlock. We
> expect PCI devices to support ATS and PRI if they want to be fault-tolerant,
> so there's no ACPI binding to describe anything else, even when a "PCI"
> device turns out to be a regular old SoC device dressed up as a RCiEP and
> normal rules don't apply.
> 
> I'm taking it on trust that stalling really is safe for all possible
> matching devices here (in general, deadlock may still be possible in the SoC
> interconnect depending on topology, hence why it's an explicit opt-in even
> for platform devices), but TBH either way I think I'd rather have this as a
> quirk in the kernel under our control, than have vendors attempt to play
> tricks with _DSD properties out in the field :)

I think a comment next to the quirk echoing the commit message and your
first paragraph above would be really helpful here.

Will
