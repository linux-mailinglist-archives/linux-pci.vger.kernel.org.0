Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A301357ED
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgAIL2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 06:28:34 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51466 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgAIL2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 06:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XBQ7YSDKaGefQuT+N4f2xVlGbixhEq0PXxbll+D7NZE=; b=xiPw2/XqAg3k8AUG8DihFK5vY
        Ce6HPopQhhmgJOMJURZUMDq7mmmWWoDcze3D5y/ZeOcigz7l7KfhomjYvVtfi9x0RIY+O5+815QSk
        xiqI9UBC/Qr9+ZOKgiCgr9IngY0XWIDv0KyFXbP/zKlUiF6lH8vCsECcc3GM1VbMz7x8AQ8xl1MIx
        4ui8g64W2WagWmCbD7z9gaschivtDA4XjAsmfD5KOHt5DlMRlsbNGAAz2FyVOsNd/HN5O9KK/ARaT
        OtoC00lFbC8mHwVmScN7lkYjmgtFUnLEflletfuGBQ4gItcWIXBN8TNx1l5b3kB2xJGKZn6CfmVNi
        5E3MgA6Cg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36030)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ipVzC-0004gX-Eq; Thu, 09 Jan 2020 11:28:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ipVz6-0000Sn-IU; Thu, 09 Jan 2020 11:28:16 +0000
Date:   Thu, 9 Jan 2020 11:28:16 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Message-ID: <20200109112816.GP25745@shell.armlinux.org.uk>
References: <20200109060657.1953-1-shawn.guo@linaro.org>
 <CH2PR12MB40073FCB953227A37F7A1A91DA390@CH2PR12MB4007.namprd12.prod.outlook.com>
 <20200109111457.GA18850@T480>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109111457.GA18850@T480>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 07:14:58PM +0800, Shawn Guo wrote:
> Hi Gustavo,
> 
> Thanks for taking a look.
> 
> On Thu, Jan 09, 2020 at 10:37:14AM +0000, Gustavo Pimentel wrote:
> > Hi Shawn,
> > 
> > On Thu, Jan 9, 2020 at 6:6:57, Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > > Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
> > 
> > Remove double space before "In that..." 
> 
> Hmm, that was intentional.  My writing practice is using two spaces
> after a period and single space after a comma.  Is it a bad habit?

Mine too.  It is not a bad habit, it's just a different style, but
some people can't cope with other people having different styles
and feel an urge to try and make them conform to their own ideals.
At the end of the day, it is personal style, and should *not* be
commented on, IMHO.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
