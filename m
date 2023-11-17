Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60837EF10B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbjKQKu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjKQKuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:50:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333FD5A;
        Fri, 17 Nov 2023 02:50:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0501CC433C8;
        Fri, 17 Nov 2023 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700218217;
        bh=HvWpi6K5JMfOG02tS6wIaBqmihK/4R9WAkRywr1PWk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVsv6nmFrCOWliGgEylZ3eoOcL1B5/EIqny6OK8ESrckYwnkPxK6aqSYHZ9CEGzCa
         GGQpTgbrqmFdyE891FwxMfG1G4KVsyEEKTPFnjkJRor4Tv3sznOpH5R4+gWjeLR2a/
         djecHn0lDy1Hqk7BLjpJwstd/jTkXhs4fpp7VXJuUWW07C9d+GBc5922K7Zpv46EER
         eoiGZmr+BSlobU9naNZ+zpqGXUFnJCr4cwHMYZsbBD8MuaqSsaM3I6uvlFT6kuD3SE
         y7FjuSVjofKwnc5UqvK7nXifpd2n3VVaurBW+68KBu6DDfVFrSwc/dmX0/TsQ6gzP5
         yHb3gRw/hGd5w==
Date:   Fri, 17 Nov 2023 16:20:07 +0530
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
Message-ID: <20231117105007.GQ250770@thinkpad>
References: <20231114135553.32301-2-johan+linaro@kernel.org>
 <202311152225.ZdVv0ufT-lkp@intel.com>
 <ZVTsf9A05HQ9UYT-@hovoldconsulting.com>
 <20231117102724.GI250770@thinkpad>
 <ZVdAz4glDioMx5Zw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVdAz4glDioMx5Zw@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 17, 2023 at 11:30:39AM +0100, Johan Hovold wrote:
> On Fri, Nov 17, 2023 at 03:57:24PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Nov 15, 2023 at 05:06:23PM +0100, Johan Hovold wrote:
> > > On Wed, Nov 15, 2023 at 10:26:40PM +0800, kernel test robot wrote:
> > >  
> > > > >> drivers/pci/pcie/aspm.c:1186: warning: expecting prototype for pci_enable_link_state(). Prototype was for pci_enable_link_state_locked() instead
> > > > 
> > > > 
> > > > vim +1186 drivers/pci/pcie/aspm.c
> > > > 
> > > >   1172	
> > > >   1173	/**
> > > >   1174	 * pci_enable_link_state - Clear and set the default device link state so that
> > > 
> > > I apparently forgot to update the name here to
> > > 
> > > 	pci_enable_link_state_locked
> > > 
> > 
> > While fixing the name, please add locking information in description as well.
> 
> It's already there:
> 
> 	Context: Caller holds pci_bus_sem read lock.

Ah, I was looking for it in the description. Fine then!

- Mani

> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
