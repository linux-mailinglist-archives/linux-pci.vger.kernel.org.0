Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FCB769D36
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGaQzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjGaQzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 12:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA71728;
        Mon, 31 Jul 2023 09:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74CA96123A;
        Mon, 31 Jul 2023 16:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C182C433C8;
        Mon, 31 Jul 2023 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690822499;
        bh=P+oZaYwkspIaNJxLa9jftp8BzKB/m6+tOlqYJtPkrv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lZhTM58/UsAB7ghAERsf/f2VKck7rHwk4a29K7eBveq/fkUzLUIxsJzg+nzCl69uF
         XW7wkrLRDvCuuCPcMGbdN2Rz8illQSPfAc/J0x2h21xWzQbsKFidB5mklaeLONcHi/
         f68Hko0+LxX7gglkr8ey32Wt33KU+DLHwa5GUUzG/giKw9AptTvtH1ZRTHQJlmbjQa
         BOOf1ytXM190mCZTL2VwE+XF7JB6PY1cILASQsnZOvG8j8GMM24lExSYAD/yl76cbc
         NbwYpr/6wGXNar3QDMX4Cc347Ld6s2c/ryVzxHA4ShnAwNjXA9fB1E4imN0iJTzA2C
         Uzai8WiNb60ag==
Date:   Mon, 31 Jul 2023 11:54:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mani@kernel.org, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
        robh+dt@kernel.org, roy.zang@nxp.com, shawnguo@kernel.org,
        zhiqiang.hou@nxp.com
Subject: Re: [PATCH v5 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitionse
Message-ID: <20230731165457.GA13422@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMPjiBYQV20N5kdu@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 11:49:28AM -0400, Frank Li wrote:
> On Fri, Jul 28, 2023 at 09:02:38PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jul 24, 2023 at 05:58:29PM -0400, Frank Li wrote:
> > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > ...

> > > +static void dw_pcie_set_dstate(struct dw_pcie *pci, pci_power_t dstate)
> > > +{
> > > +	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> > > +	u16 val;
> > > +
> > > +	val = dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> > > +	val &= ~PCI_PM_CTRL_STATE_MASK;
> > > +	val |= ((u16 __force)dstate) & PCI_PM_CTRL_STATE_MASK;
> > 
> > Why can't just,
> > 
> > val |= dstate;
> 
> fixed a build warning.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202307211904.zExw4Q8H-lkp@intel.com/

This is the sparse warning from the lkp URL:

  sparse warnings: (new ones prefixed by >>)
  >> drivers/pci/controller/dwc/pcie-designware-host.c:824:13: sparse: sparse: invalid assignment: |=
  >> drivers/pci/controller/dwc/pcie-designware-host.c:824:13: sparse:    left side has type unsigned int
  >> drivers/pci/controller/dwc/pcie-designware-host.c:824:13: sparse:    right side has type restricted pci_power_t

We have a zillion of those warnings already (try "make C=2 drivers/pci/").

Personally I think it's better to omit the ugly cast and live with the
warning for now.  Someday somebody will figure a better way to use
pci_power_t that will fix all these warnings at once.  I'd rather wait
for that fix than clutter all the uses with casts like this.

Bjorn
