Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385075A462D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiH2Jes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 05:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiH2Jen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 05:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60BF5C977;
        Mon, 29 Aug 2022 02:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E42A60F61;
        Mon, 29 Aug 2022 09:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0E6C433C1;
        Mon, 29 Aug 2022 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661765672;
        bh=Ha7dPQQt8ROs3mVSwSdR/iJAj2vnJKDi274nVUfFx2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShdId/P+BPxRRnzSDYp5021K7jSBepOheJ/pdQpDzhMHQ32qy9qvSSLsJCHViqOq3
         XX7WezEX/OF5wV62UETeyglC2ZTASTy8+MU/4/Odt6mrcmc0DMQaQmMJDo5rRryRwK
         4f+o88jXTy7AgDvOIhQHe7MC09u2giYqUYlBFXlsXOVdUXHJ4cDNwkIrv17kC9Oi7E
         gWbbJ0uxZsG9V9zFi0pe/3lp8vxS2zVaGkxJ5PKp2PSMOLHi7NF593NVbx9zbQLIsa
         4jUXJbT705B3r7ynAHDZ6CYO5GonMavGdhrVIuWDS56pTiBjv+BEybs6qiX5pcnnE9
         FCk4vNLB1QQQw==
Received: by pali.im (Postfix)
        id 12D687DE; Mon, 29 Aug 2022 11:34:29 +0200 (CEST)
Date:   Mon, 29 Aug 2022 11:34:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Add support for PCI Bridge Subsystem
 Vendor ID on emulated bridge
Message-ID: <20220829093428.4danatwennps55dr@pali>
References: <20220711221823.12154-1-pali@kernel.org>
 <20220711225915.13896-1-pali@kernel.org>
 <YwyHdMv1JsQNuVGS@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwyHdMv1JsQNuVGS@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 29 August 2022 11:31:32 Lorenzo Pieralisi wrote:
> On Tue, Jul 12, 2022 at 12:59:15AM +0200, Pali Rohár wrote:
> > Register with Subsystem Device/Vendor ID is at offset 0x2c. Export is via
> > emulated bridge.
> 
> "Export it..." I suppose.

Yes, it is a typo :-(

> So in short, this patch enables support for the Subsystem Device/Vendor
> ID - by reading it in the PCI controller config space and storing it
> in the emulated bridge control structures, so that it is exposed in
> the respective PCI capability.

Yes, it reads it from internal aardvark registers and stores it into the
emulated bridge config space.

> Correct ?
> 
> Thanks,
> Lorenzo
> 
> > After this change Subsystem ID is visible in lspci output at line:
> > 
> >   Capabilities: [40] Subsystem
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Changes in v2:
> > * Fix wrong rebase, do not add PCIE_CORE_EXP_ROM_BAR_REG
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 74511f015168..060936ef01fe 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -32,6 +32,7 @@
> >  #define PCIE_CORE_DEV_ID_REG					0x0
> >  #define PCIE_CORE_CMD_STATUS_REG				0x4
> >  #define PCIE_CORE_DEV_REV_REG					0x8
> > +#define PCIE_CORE_SSDEV_ID_REG					0x2c
> >  #define PCIE_CORE_PCIEXP_CAP					0xc0
> >  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
> >  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
> > @@ -982,6 +983,8 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	/* Indicates supports for Completion Retry Status */
> >  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> >  
> > +	bridge->subsystem_vendor_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) & 0xffff;
> > +	bridge->subsystem_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) >> 16;
> >  	bridge->has_pcie = true;
> >  	bridge->data = pcie;
> >  	bridge->ops = &advk_pci_bridge_emul_ops;
> > -- 
> > 2.20.1
> > 
