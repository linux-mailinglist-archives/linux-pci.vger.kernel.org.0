Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EDB463A7B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhK3PrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 10:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhK3PrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 10:47:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429ACC06174A;
        Tue, 30 Nov 2021 07:43:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08094B81A2E;
        Tue, 30 Nov 2021 15:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713FFC53FC7;
        Tue, 30 Nov 2021 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638287032;
        bh=xV+MrXI1P5OrMeClY2oJlSEliMrz395H0OKQ1VlrMOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r3MOZpgL1b9Ha89LJqV1MwVgaZJQq0z1HVWC79GTmzb4XOLqQM9hbicN+qZIKDVBh
         xtOeBSG2lXU2uinTXvOAhgcgbT3kUd31rYzWsmN8oFW9NakckUmm3YdwseYR9HAx05
         sAxq3IkPab/kfmTNPa2yBu64uL0SdJwIprpNb1unVRejcDLKYNnI+WEYNrk+7vyHAc
         yUvmE3Lg/i0a7eXnGravLMHDqKoLWze5sEYDTA1NuKWbr1jPM1OlxsJ1pEI6j2foRb
         aJkgUWztfzcphZRep3znqf+Udqm8rijJfn+JivXyP9wg0HRFVaxlaAHuvPyEIaqxD8
         IkkarTwERyeuQ==
Date:   Tue, 30 Nov 2021 09:43:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16()
 return instead of u16
Message-ID: <20211130154351.GA2738262@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaXc3mlBbhvEkZCX@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 09:12:14AM +0100, Krzysztof Wilczyński wrote:
> Hello!
> 
> [...]
> > > > cpu_to_be16() returns __be16 value but the driver uses u16 and that's
> > > > incorrect. Fix it by using __be16 as the datatype of bdf_be variable.
> > > 
> > > It would be "data type" in the above.
> > > 
> > > Not really a requirement to do so, but you could include the actual
> > > warning, as sometimes this is useful for reference later, as per:
> > > 
> > >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30: warning: incorrect type in initializer (different base types)
> > >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    expected unsigned short [usertype] bdf_be
> > >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    got restricted __be16 [usertype]
> > > 
> > 
> > I usually do but as per Bjorn's comment I thought it is not recommended for PCI
> > subsystem (or maybe I misread his comments). Will add.
> 
> Ah right.  I must have missed his comment too.  I usually include warnings
> myself, where applicable.  Let's wait for what Bjorn says, just in case, so
> that we avoid adding something he does not want to have included in the
> commit message.

I think it's nice to include the warning in the commit log (and even
the way to *generate* the warning if it's more complicated than
"make") because that helps others verify the commit.

I just don't want the warning to be the *reason* for the commit
because it's too easy to focus on quickly removing the warning without
fully understanding whether there is an underlying defect.

Bjorn
