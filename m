Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDCB2C8893
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 16:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgK3Psp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 10:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgK3Psp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 10:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606751238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2cfl5p+/dsT1o38syXwn2awNxPJz7kQnbcKay1wI6o=;
        b=YXhHp9bqenrB6Et9QiDohMxn3Rt69Jz9De0/7VlkQTWeUbL3QKbsq/xJ06qWiKkMUWG07R
        uigcEWdDBfwl6Ei3vDuuumBniTJ1PuZOPzdkyLxMJ23FLAiaRnICP0dUp1c1RZBD0DwhQD
        0kvECIIPyZHGOWcKObCYsiYFuDAUyno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-UvQ6Pl1bOp2HNYlzvAMwmw-1; Mon, 30 Nov 2020 10:46:59 -0500
X-MC-Unique: UvQ6Pl1bOp2HNYlzvAMwmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A230E803658;
        Mon, 30 Nov 2020 15:46:23 +0000 (UTC)
Received: from w520.home (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C58960C93;
        Mon, 30 Nov 2020 15:46:22 +0000 (UTC)
Date:   Mon, 30 Nov 2020 08:46:22 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chiqijun <chiqijun@huawei.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        yin.yinshi@huawei.com, cloud.wangxiaoyun@huawei.com,
        zengweiliang.zengweiliang@huawei.com, chenlizhong@huawei.com
Subject: Re: [PATCH] PCI: Add pci reset quirk for Huawei Intelligent NIC
 virtual function
Message-ID: <20201130084622.0b71d526@w520.home>
In-Reply-To: <20201128232919.GA929748@bjorn-Precision-5520>
References: <20201128061825.2629-1-chiqijun@huawei.com>
        <20201128232919.GA929748@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 28 Nov 2020 17:29:19 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Sat, Nov 28, 2020 at 02:18:25PM +0800, Chiqijun wrote:
> > When multiple VFs do FLR at the same time, the firmware is
> > processed serially, resulting in some VF FLRs being delayed more
> > than 100ms, when the virtual machine restarts and the device
> > driver is loaded, the firmware is doing the corresponding VF
> > FLR, causing the driver to fail to load.
> > 
> > To solve this problem, add host and firmware status synchronization
> > during FLR.  
> 
> Is this because the Huawei Intelligent NIC isn't following the spec,
> or is it because Linux isn't correctly waiting for the FLR to
> complete?

Seems like a spec compliance issue, I don't recall anything in the spec
about coordinating FLR between VFs.
 
> If this is a Huawei Intelligent NIC defect, is there documentation
> somewhere (errata) that you can reference?  Will it be fixed in future
> designs, so we don't have to add future Device IDs to the quirk?
> 
> > Signed-off-by: Chiqijun <chiqijun@huawei.com>
> > ---
> >  drivers/pci/quirks.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index f70692ac79c5..bd6236ea9064 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3912,6 +3912,71 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> >  	return 0;
> >  }
> >  
> > +#define PCI_DEVICE_ID_HINIC_VF  0x375E
> > +#define HINIC_VF_FLR_TYPE       0x1000
> > +#define HINIC_VF_OP             0xE80
> > +#define HINIC_OPERATION_TIMEOUT 15000
> > +
> > +/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
> > +static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
> > +{
> > +	unsigned long timeout;
> > +	void __iomem *bar;
> > +	u16 old_command;
> > +	u32 val;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	bar = pci_iomap(pdev, 0, 0);
> > +	if (!bar)
> > +		return -ENOTTY;
> > +
> > +	pci_read_config_word(pdev, PCI_COMMAND, &old_command);
> > +
> > +	/*
> > +	 * FLR cap bit bit30, FLR ACK bit: bit18, to avoid big-endian conversion
> > +	 * the big-endian bit6, bit10 is directly operated here
> > +	 */
> > +	val = readl(bar + HINIC_VF_FLR_TYPE);
> > +	if (!(val & (1UL << 6))) {
> > +		pci_iounmap(pdev, bar);
> > +		return -ENOTTY;
> > +	}


I don't know exactly what this is testing, but it seems like a
feature/capability test that can fail, why is it not done as part of
the probe?  Can we define bit 6 with a macro?  Same for bit 10 in the
VF op register below.

> > +
> > +	val = readl(bar + HINIC_VF_OP);
> > +	val = val | (1UL << 10);
> > +	writel(val, bar + HINIC_VF_OP);
> > +
> > +	/* Perform the actual device function reset */
> > +	pcie_flr(pdev);
> > +
> > +	pci_write_config_word(pdev, PCI_COMMAND,
> > +			      old_command | PCI_COMMAND_MEMORY);
> > +
> > +	/* Waiting for device reset complete */
> > +	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);

Yikes, 15s timeout!

> > +	do {
> > +		val = readl(bar + HINIC_VF_OP);
> > +		if (!(val & (1UL << 10)))
> > +			goto reset_complete;
> > +		msleep(20);
> > +	} while (time_before(jiffies, timeout));
> > +
> > +	val = readl(bar + HINIC_VF_OP);
> > +	if (!(val & (1UL << 10)))
> > +		goto reset_complete;
> > +
> > +	pci_warn(pdev, "Reset dev timeout, flr ack reg: %x\n",
> > +		 be32_to_cpu(val));
> > +
> > +reset_complete:
> > +	pci_write_config_word(pdev, PCI_COMMAND, old_command);
> > +	pci_iounmap(pdev, bar);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> >  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
> >  		 reset_intel_82599_sfp_virtfn },
> > @@ -3923,6 +3988,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> >  	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
> >  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> >  		reset_chelsio_generic_dev },
> > +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
> > +		reset_hinic_vf_dev },
> >  	{ 0 }
> >  };
> >  
> > -- 
> > 2.17.1
> >   
> 

