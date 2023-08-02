Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4E076D761
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjHBTGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHBTGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 15:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247A2129;
        Wed,  2 Aug 2023 12:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F37061AC3;
        Wed,  2 Aug 2023 19:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69053C433C8;
        Wed,  2 Aug 2023 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691003168;
        bh=R0/Y/OgJC88hx/QGYFFgUJRv81sXFf1ZczNdRm7daqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KOOusFW+uebA8FXjwEmlh+Nd3frDaJQtci1gV7iasXPYsXDDAoDmgrq73Y2MzzyVg
         vAphdNYEWuXni7ENa4e4VakRc95edEuNwXIJ7Q6w6IJhGiC7jZBy/2Oqeihcd2yz2e
         fZWuP452I2OLpG9vs6+cc3jyyoaK4Z6e/4HW4VOLCqbnrRfXA5vXDsfqoYKj+Fn4PK
         8VzSmjHw+eCEYUVg4Uhc2DMul1EdBeLYifQHi0+XzkibNwG/57TsTwwA9HErhcmrsC
         kd/uES1wXLtD8UGH1JMrFTJA98m7cjGpWpHZhtCYEW8EtUNJe7AZ66OKP9/AAyO765
         1maO9DwLPofEA==
Date:   Wed, 2 Aug 2023 14:06:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     mani@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v7 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230802190606.GA64564@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMqj/4Yc6U5YqmHJ@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 02:44:52PM -0400, Frank Li wrote:
> On Wed, Aug 02, 2023 at 11:31:38AM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 02, 2023 at 11:57:47AM -0400, Frank Li wrote:
> > > Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
> > > handling.

> > > +	 * PCI Express Base Specification Rev 4.0 Section 5.3.3.2.1 PME
> > > +	 * Synchronization Recommends 1ms to 10ms timeout to check L2 ready.
> > > +	 */
> > > +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > > +				1000, 10000, false, pci);

> > It would really be great to have a #define for this since the bare
> > numbers are not very meaningful and they're not specific to DWC so a
> > #define would let us find similar situations in other drivers.
> 
> how about define as
> 
> #define PCI_PME_TO_L2_TIMEOUT 10000
> 
> ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
>                            PCI_PME_TO_L2_TIMEOUT/10, PCI_PME_TO_L2_TIMEOUT, false, pci);
> 
> where is good place PCI_PME_TO_L2_TIMEOUT in?
> 
> pcie-designware.h or pci.h?

I think drivers/pci/pci.h since it's only useful inside drivers/pci,
and it's not specific to dwc.

Maybe "PCIE_" (not "PCI_") since this is a PCIe-specific thing.
You could put it next to PCIE_LINK_RETRAIN_TIMEOUT_MS and add a "_US"
suffix so we know what the units are.

Bjorn
