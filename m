Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6013A5FD39B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 05:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJMDt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 23:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMDt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 23:49:26 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C511B2F3
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 20:49:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 068005803F6;
        Wed, 12 Oct 2022 23:49:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Oct 2022 23:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665632962; x=1665636562; bh=7Xu3WAbIeT
        3msy3mJnCikbC/d3pvfoC4qbTOoSPMVaA=; b=mAvuXsfIyIgdduxNJNFcVKe6VG
        fbfjydLagjvL11+WrRamRpqb4DM2Ck0C55UNV1Sqdmci2AjnaXr11e8xMoa6JO32
        CbICRGJ/6J/507OZDBQWHoNF8a/Z2utqTl/Ed+vGyQg+Wq2ApSt7732+jmPfMmoD
        8cyvrwUwjj1Eq0WN9ed+UMmtNpMkk3CWrz/2cqJYzxWR0aZoRkOzN1w4AIHAgugy
        v/M4Cg/lQIPv1c1ZwP4ijAiCsUSPrEPScJ42i5+0iUSIgaJ8cMKu+EVh5ZeLEs9s
        dPjmBnfUdqO6RpI/TGbqzXE6K0dZLHhIsEPKRqAljCw02rqNFL9weurBolOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665632962; x=1665636562; bh=7Xu3WAbIeT3msy3mJnCikbC/d3pv
        foC4qbTOoSPMVaA=; b=exdyFdgLTOfGM+dol2M4wNHsSXEdiOcMANhvOBYHfxbU
        EAkTaYyl002MWukVrFoRki9RunQKVIR0NUgbIEBX7wLtxqoUYCYtr7tEWknarN2l
        LqX1N1SgI5gKhRth1ZswzJOGdV9fzLgovEit9cWRyywZjPQnDAQxeOldqkwHIfhR
        VN1hKCpG5d1UTJmBXWWFRRhYM6VLR0zlwNtJRhqzbTUiF9Mcoyx5YE+ra4JycNdM
        g1eV46rcT0Jo/X84pldVVz1GdefKqzSL9klRdDRh2R80iSB6OoGh9RpAm0sXiPWD
        rD2lYjLKIe35U4scoLONTY/epdSKfogMRwp8y5ag7g==
X-ME-Sender: <xms:wYpHY1CevNI0Xka50VoWgZOoB0xPkZrVk7-2Pzh7vghyYpQPdPR_1w>
    <xme:wYpHYzhkQcoLaGb-APdKX40roqhPB06IX_WpieL68LKuN6m6AbL0y43KrIQgtAGWG
    OMV5bcKF3IQvjKF7S4>
X-ME-Received: <xmr:wYpHYwlU4shXXvI6c_8-grlcEX0CxmO4ERlxY4vrky2XsCfW9xEAz673eec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdehvddttdfhfefhtdfgleehfeeggfdujeeuveekudevkedvgeejtddtfefgleei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghoug
    gvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:wYpHY_xJDWs2VDtPHNd7CFFAEcLf_TQA7IET7hOfZTD2E2iz-v1O5Q>
    <xmx:wYpHY6SstH0OAPqDJwyKZQQ6CDZUmeYpsPxonCDSVQcwjQUHsrcV1Q>
    <xmx:wYpHYyZ2H7mMTx9HL2P3nrQSBGa7AdAXAiOWqeku6Mn8oofqfSg73Q>
    <xmx:wYpHY9IYbV4D9gOtiwibZoDcYeekZdpBUg6nss_BOUSc-BGTapAwhA>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Oct 2022 23:49:21 -0400 (EDT)
Date:   Wed, 12 Oct 2022 22:48:57 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <20221013034857.hr2gq5gkuryygpcm@sequoia>
References: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
 <20220826154933.GB39334@sequoia>
 <20220914144105.GB169602@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914144105.GB169602@sequoia>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-09-14 09:41:05, Tyler Hicks wrote:
> On 2022-08-26 10:49:39, Tyler Hicks wrote:
> > On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > 
> > > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> > > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > > mode, so that it's more likely that a hot-added device will work in
> > > a system with an optimized MPS configuration.
> > > 
> > > Obviously, the Linux itself optimizes the MPS settings in the
> > > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > > for these modes.
> > > 
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > ---
> > 
> > Hi Bjorn - We have some interest in this patch and I am hoping it can be
> > considered in preparation for v6.1. I took a look at it and it makes
> > sense to me but I'm not an expert in this area. Thanks!
> 
> Ping. Do you expect to get any free cycles to review this in prep for
> v6.1?

Ping now that you've got the v6.1 PR out for the PCI subsystem. Thanks. 

> 
> Tyler
> 
> > 
> > Tyler
> > 
> > >  drivers/pci/probe.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 17a969942d37..2c5a1aefd9cb 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2034,7 +2034,9 @@ static void pci_configure_mps(struct pci_dev *dev)
> > >  	 * Fancier MPS configuration is done later by
> > >  	 * pcie_bus_configure_settings()
> > >  	 */
> > > -	if (pcie_bus_config != PCIE_BUS_DEFAULT)
> > > +	if (pcie_bus_config != PCIE_BUS_DEFAULT &&
> > > +	    pcie_bus_config != PCIE_BUS_SAFE &&
> > > +	    pcie_bus_config != PCIE_BUS_PERFORMANCE)
> > >  		return;
> > >  
> > >  	mpss = 128 << dev->pcie_mpss;
> > > @@ -2047,7 +2049,7 @@ static void pci_configure_mps(struct pci_dev *dev)
> > >  
> > >  	rc = pcie_set_mps(dev, p_mps);
> > >  	if (rc) {
> > > -		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
> > > +		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_peer2peer\" and report a bug\n",
> > >  			 p_mps);
> > >  		return;
> > >  	}
> > > -- 
> > > 2.17.1
> > > 
