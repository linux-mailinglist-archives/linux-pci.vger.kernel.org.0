Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC25B8AD6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiINOlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 10:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiINOlP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 10:41:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D848786D3
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 07:41:10 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id D69402052E28;
        Wed, 14 Sep 2022 07:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D69402052E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663166470;
        bh=GMuwTZAezbx6Z/vQk4enlQL+EO5XZGSuBgZQ+wC1ixI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZx8rrNvD8LNDz9PaBD8hryhxqGMVxWEJYp3rx/E1jtMJGDAW9weHOCrMt9S43tcD
         k4UHm+oIaFuTPaUQbOIP91Bw91rW4r20c1fc6+EYiWR4FA+7mUH9e4xcg1YyxSH2cq
         7oLNFn2QYytbB+1jfDQuJqCFaUlkY8VcKo3HIfeM=
Date:   Wed, 14 Sep 2022 09:41:05 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20220914144105.GB169602@sequoia>
References: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
 <20220826154933.GB39334@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826154933.GB39334@sequoia>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-26 10:49:39, Tyler Hicks wrote:
> On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > mode, so that it's more likely that a hot-added device will work in
> > a system with an optimized MPS configuration.
> > 
> > Obviously, the Linux itself optimizes the MPS settings in the
> > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > for these modes.
> > 
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> 
> Hi Bjorn - We have some interest in this patch and I am hoping it can be
> considered in preparation for v6.1. I took a look at it and it makes
> sense to me but I'm not an expert in this area. Thanks!

Ping. Do you expect to get any free cycles to review this in prep for
v6.1?

Tyler

> 
> Tyler
> 
> >  drivers/pci/probe.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d37..2c5a1aefd9cb 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2034,7 +2034,9 @@ static void pci_configure_mps(struct pci_dev *dev)
> >  	 * Fancier MPS configuration is done later by
> >  	 * pcie_bus_configure_settings()
> >  	 */
> > -	if (pcie_bus_config != PCIE_BUS_DEFAULT)
> > +	if (pcie_bus_config != PCIE_BUS_DEFAULT &&
> > +	    pcie_bus_config != PCIE_BUS_SAFE &&
> > +	    pcie_bus_config != PCIE_BUS_PERFORMANCE)
> >  		return;
> >  
> >  	mpss = 128 << dev->pcie_mpss;
> > @@ -2047,7 +2049,7 @@ static void pci_configure_mps(struct pci_dev *dev)
> >  
> >  	rc = pcie_set_mps(dev, p_mps);
> >  	if (rc) {
> > -		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
> > +		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_peer2peer\" and report a bug\n",
> >  			 p_mps);
> >  		return;
> >  	}
> > -- 
> > 2.17.1
> > 
