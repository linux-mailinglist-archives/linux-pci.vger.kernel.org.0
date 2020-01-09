Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9103136028
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgAIS37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 13:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbgAIS37 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 13:29:59 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6552072A;
        Thu,  9 Jan 2020 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578594598;
        bh=uJrGvHiJ0jLq+t8TWq4ljCMDSX4ZBF5RxHoNG5ABlW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=enobhZX2ZoNb9qAxtib8xHmL6/fRDwaisFCRxj4Rf1j/PP+QUuT4XMXvvEjJutjZd
         e4G20pdiCUCoBAbKSHVFkYdRPe1UlgHbwnyfEU7pQKpRqdYsUB+RmsrG/dTLhRwBb/
         wyy+Wwp8up5gxnEbTfpHUH+L5SbaGIyk5w0VLXNg=
Date:   Thu, 9 Jan 2020 12:29:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Message-ID: <20200109182957.GA252973@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB4007CC62E0939BAAABA0E64FDA390@CH2PR12MB4007.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 12:24:17PM +0000, Gustavo Pimentel wrote:
> On Thu, Jan 9, 2020 at 11:14:58, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Hi Gustavo,
> > 
> > Thanks for taking a look.
> > 
> > On Thu, Jan 09, 2020 at 10:37:14AM +0000, Gustavo Pimentel wrote:
> > > Hi Shawn,
> > > 
> > > On Thu, Jan 9, 2020 at 6:6:57, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > 
> > > > Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
> > > 
> > > Remove double space before "In that..." 
> > 
> > Hmm, that was intentional.  My writing practice is using two spaces
> > after a period and single space after a comma.  Is it a bad habit?
> 
> I thought it was a typo. I personally don't have anything against it, but 
> I didn't see this style on the comments till now. To keep the coherence 
> between all patches, I know that Bjorn and Lorenzo like to have it the 
> most standardized possible. It is OK by Lorenzo and Bjorn, it's fine for 
> me too.

Eagle eyes!  I was taught in the dark ages of typewriters to use two
spaces after a period, but I don't really care either way.  If I
rework a commit log for other reasons I might use two spaces, and I
frequently use vim 'gq' to reformat paragraphs to use the whole line
width, and I think that inserts two spaces (by default), so I try to
be consistent at least within each commit log.  But either is really
fine with me.

Thanks for taking the time to read and pay attention to commit logs!

Bjorn
