Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B040B08B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhINOZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhINOZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 10:25:49 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF85C061574;
        Tue, 14 Sep 2021 07:24:31 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mQ9MC-0003hi-5m; Tue, 14 Sep 2021 10:24:20 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id D948856008F; Tue, 14 Sep 2021 10:24:19 -0400 (EDT)
Date:   Tue, 14 Sep 2021 10:24:19 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>, todd.fujinaka@intel.com,
        Hisashi T Fujinaka <htodd@twofifty.com>
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
Message-ID: <20210914142419.GA32324@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>, todd.fujinaka@intel.com,
        Hisashi T Fujinaka <htodd@twofifty.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
 <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
 <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
 <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 07:51:22AM +0200, Heiner Kallweit wrote:
 
 > > Sorry to reply from my personal account. If I did it from my work
 > > account I'd be top-posting because of Outlook and that goes over like a
 > > lead balloon.
 > > 
 > > Anyway, can you send us a dump of your eeprom using ethtool -e? You can
 > > either send it via a bug on e1000.sourceforge.net or try sending it to
 > > todd.fujinaka@intel.com
 > > 
 > > The other thing is I'm wondering is what the subvendor device ID you
 > > have is referring to because it's not in the pci database. Some ODMs
 > > like getting creative with what they put in the NVM.
 > > 
 > > Todd Fujinaka (todd.fujinaka@intel.com)
 > 
 > Thanks for the prompt reply. Dave, could you please provide the requested
 > information?

sent off-list.

	Dave
