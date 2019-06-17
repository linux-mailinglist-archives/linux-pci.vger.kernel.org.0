Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464B447FDA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 12:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFQKj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 06:39:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFQKj2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 06:39:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A408344;
        Mon, 17 Jun 2019 03:39:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 829DD3F246;
        Mon, 17 Jun 2019 03:41:11 -0700 (PDT)
Date:   Mon, 17 Jun 2019 11:39:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190617103921.GA20619@e121166-lin.cambridge.arm.com>
References: <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
 <20190614152304.GK15526@ulmo>
 <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
 <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
 <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
 <1c662f82-8329-5e1b-58bf-b2fe1643adb0@nvidia.com>
 <20190617094839.GE18020@e121166-lin.cambridge.arm.com>
 <0f9bb97d-5a30-a654-0cc6-a57a7bd894c8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f9bb97d-5a30-a654-0cc6-a57a7bd894c8@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 03:57:09PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 17-Jun-19 3:18 PM, Lorenzo Pieralisi wrote:
> > On Fri, Jun 14, 2019 at 10:53:13PM +0530, Manikanta Maddireddy wrote:
> >
> > [...]
> >
> >>> Ok. My point then is that you have no way to enforce this requirement on
> >>> platforms that actually need it, I do not even know if there is a
> >>> way you can do it (I was thinking along the lines of using a
> >>> compatible string to detect whether the GPIO #PERST reset is mandatory)
> >>> but maybe this is not even a SOC property.
> >>>
> >>> Maybe what I am asking is overkill, I just wanted to understand.
> >>>
> >>> I was just asking a question to understand how you handle the case
> >>> where a GPIO pin definition is missing in DT for a platform that
> >>> actually needs it, the driver will probe but nothing will work.
> >>>
> >>> It would be good to describe this and capture it in the commit log.
> >>>
> >>> Thanks,
> >>> Lorenzo
> >> I can't think of a easy way to enforce this requirement. As you said
> >> compatible string is per SOC, so we can't use it for a platform.
> >> This issue is present on only one platform, so it is hard to miss the
> >> DT property. That is the reason for publishing this patch with out this
> >> enforcement in driver.
> >>
> >> I thought for changing PERST# to GPIO for all platform, but testing is
> >> a tedious job. Also I don't have Tegra20 and Tegra30 platforms.
> > I can't help with that.
> >
> >> Do you want me to drop the patch or update the limitation in the commit
> >> log?
> > It is Thierry's call, if he is OK with it fine by me, please do
> > update the commit log, it will help everybody understand.
> >
> > Lorenzo
> 
> Sure, I will update the commit log in V5.
> Please let me know if you completed reviewing this series, I will
> send V5 addressing review comments in this patch.

Post v5, we should be able to get it in v5.3, thanks.

Lorenzo
