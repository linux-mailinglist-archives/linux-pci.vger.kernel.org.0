Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D5296700
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898454AbgJVWJ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 18:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506687AbgJVWJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 18:09:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15942C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DOYfrupo23QV+e+gX1emS3emaW6u2eUoQFF+OYx7Bow=; b=OVtsB+tsoal7Dp9Il99VIFqFX
        K8Mo9ZUhDhdD4gof7dwwoavf+7bNMDPC2KE8inqZEjVPoJs0iNcOmNEcx2aLw+02oweVDBIGP9pO4
        rRg65KTN0GeA0xMuwgKNhCknAVhG/6OT+j06UpyPFCx9jFuzpiNxLjYPJUrjkermH9gAI2mKLp+C8
        CpIcDFLFba94fU1SCPUu1Pv72VPR7bULn1Rqg0IamqoAMx/Dr+PSVuQLSv3wP2G73HtZbnsZcxXz9
        fVpV43vcVw25HS5l/m29Y3UTujncUvsqoSYfCsePI54oD23Iug8/8MlBd3JReTxYxeMJt2DomDJGZ
        hEWrvUbxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49706)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVilw-0002de-ST; Thu, 22 Oct 2020 23:09:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVilw-0007mq-CU; Thu, 22 Oct 2020 23:09:24 +0100
Date:   Thu, 22 Oct 2020 23:09:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Fix duplicate resource requests
Message-ID: <20201022220924.GX1551@shell.armlinux.org.uk>
References: <20201022220038.1339854-1-robh@kernel.org>
 <20201022220507.GW1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022220507.GW1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 11:05:07PM +0100, Russell King - ARM Linux admin wrote:
> > @@ -1001,9 +995,12 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
> >  		pcie->realio.name = "PCI I/O";
> >  
> >  		pci_add_resource(&bridge->windows, &pcie->realio);
> > +		ret = devm_request_resource(dev, &iomem_resource, &pcie->realio);
> 
> I think you're trying to claim this resource against the wrong parent.

Fixing this to ioport_resource results in in working PCIe.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
