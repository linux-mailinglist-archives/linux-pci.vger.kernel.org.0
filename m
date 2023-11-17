Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631877EF063
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjKQKao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjKQKan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:30:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C798131;
        Fri, 17 Nov 2023 02:30:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8B3C433C7;
        Fri, 17 Nov 2023 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700217040;
        bh=5GTodjIFYK3+cnDn/z8EfJv/gMxH/BGnB0nWLlAzxEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuSThNAwH1MfJunYOe28kslPlu44S5J0JAkJPuY3v4rgiTy5E6ZobP+TAr3bCm/cN
         siDSE8JpO29RINiiQP5ViFcsohJ/ZQ4UEfcTxxJ+jCHr/5z5cr00DbHwmgbR362l26
         OK6aTsrFZTRSSJRi+qju/VI5E6D6Bcj/6uICNYL6sK+ujEFALEVQNZKRlb4rgsxT5W
         f/FzTXowZsumJ5FFwZPZHhNkEbUbgumNiwgg+2N1niiXSLf/4NM881jBUmbfmrv/xz
         vO428BOnJamwe+M1mhRUW/2NKOEvYSmcSuG1kKfgQrz3RdO1YrwxpY6vjyQcYRcsMa
         3n2En4M7aUp4g==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3w7T-0000av-0s;
        Fri, 17 Nov 2023 11:30:40 +0100
Date:   Fri, 17 Nov 2023 11:30:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
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
Message-ID: <ZVdAz4glDioMx5Zw@hovoldconsulting.com>
References: <20231114135553.32301-2-johan+linaro@kernel.org>
 <202311152225.ZdVv0ufT-lkp@intel.com>
 <ZVTsf9A05HQ9UYT-@hovoldconsulting.com>
 <20231117102724.GI250770@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117102724.GI250770@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 17, 2023 at 03:57:24PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Nov 15, 2023 at 05:06:23PM +0100, Johan Hovold wrote:
> > On Wed, Nov 15, 2023 at 10:26:40PM +0800, kernel test robot wrote:
> >  
> > > >> drivers/pci/pcie/aspm.c:1186: warning: expecting prototype for pci_enable_link_state(). Prototype was for pci_enable_link_state_locked() instead
> > > 
> > > 
> > > vim +1186 drivers/pci/pcie/aspm.c
> > > 
> > >   1172	
> > >   1173	/**
> > >   1174	 * pci_enable_link_state - Clear and set the default device link state so that
> > 
> > I apparently forgot to update the name here to
> > 
> > 	pci_enable_link_state_locked
> > 
> 
> While fixing the name, please add locking information in description as well.

It's already there:

	Context: Caller holds pci_bus_sem read lock.

Johan
