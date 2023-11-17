Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CA7EF047
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbjKQK1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345756AbjKQK1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:27:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFFC127;
        Fri, 17 Nov 2023 02:27:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C94C433C8;
        Fri, 17 Nov 2023 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700216853;
        bh=ji1627U40qRm86ia0liZUcuU5aE0fVlG99CCELmMFGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsgrErCR1IsvEaWW8MLG+SMZSB577k4HFfxlmB4hPOJ9/9ok3ktcOVEGx11cdm+O/
         fqjsAimQeElJsazhuNx+dD0t+gfcS+ldvGvkHQRF+ekleahXv7adpNoGbuQPXYK9pX
         EWrbhU4bTReKWWPTmlRET0aia7cYkYPubwav2RjuKfIpgdHS3tEscgsexbMiar7roI
         Ip9kkcZsoCtvSdV4Kyk5pHqzBw2oe696n0rsvdIAfZ8sLpmrcjbZEb7pF8zLa5XNhR
         2a/b1FtZwvvRQNEw+KA/VQuBJebNq2LgMNYVnFOXQnOsfrv7qXFRw2yOgnhbHzY1Nv
         jJUFk6tk2h+jA==
Date:   Fri, 17 Nov 2023 15:57:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 1/6] PCI/ASPM: Add locked helper for enabling link state
Message-ID: <20231117102724.GI250770@thinkpad>
References: <20231114135553.32301-2-johan+linaro@kernel.org>
 <202311152225.ZdVv0ufT-lkp@intel.com>
 <ZVTsf9A05HQ9UYT-@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVTsf9A05HQ9UYT-@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 05:06:23PM +0100, Johan Hovold wrote:
> On Wed, Nov 15, 2023 at 10:26:40PM +0800, kernel test robot wrote:
>  
> > >> drivers/pci/pcie/aspm.c:1186: warning: expecting prototype for pci_enable_link_state(). Prototype was for pci_enable_link_state_locked() instead
> > 
> > 
> > vim +1186 drivers/pci/pcie/aspm.c
> > 
> >   1172	
> >   1173	/**
> >   1174	 * pci_enable_link_state - Clear and set the default device link state so that
> 
> I apparently forgot to update the name here to
> 
> 	pci_enable_link_state_locked
> 

While fixing the name, please add locking information in description as well.

- Mani

> [ ... ]
> 
> >   1184	 */
> >   1185	int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
> 
> Perhaps this can be fixed up when applying, or otherwise I'll respin.
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
