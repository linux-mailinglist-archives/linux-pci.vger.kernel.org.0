Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8555281669
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbgJBPUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 11:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBPUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 11:20:11 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC440206CD;
        Fri,  2 Oct 2020 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601652011;
        bh=fqSCukVDlsMpkC+PkEqHdkZiISDcCnwTzThulySokbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9nU/Jy8hnofat18Cf2Q0N/1NaHB0jD+Z5Z+rMRfK6SPq8PhmjUVRNlSjt9JgH9Ng
         6+KqTbU4NPZT923tmNw8UYS4jaRSilj92pkulDoOaXzXQOQFXorDUDVboH0d86Mk/P
         nlThDFcOo7xvh+qAAbOAzNkwd0ZTOTMOEQfyQlSg=
Received: by pali.im (Postfix)
        id 951E7E79; Fri,  2 Oct 2020 17:20:08 +0200 (CEST)
Date:   Fri, 2 Oct 2020 17:20:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
Message-ID: <20201002152008.shwmbchkooczzgyd@pali>
References: <20200902144344.16684-1-pali@kernel.org>
 <20201002133713.GA24425@e121166-lin.cambridge.arm.com>
 <20201002142616.dxgdneg2lqw4pxie@pali>
 <20201002143851.GA25575@e121166-lin.cambridge.arm.com>
 <20201002145237.r2troxmgbq2bf3ep@pali>
 <20201002150300.GA25684@e121166-lin.cambridge.arm.com>
 <20201002150701.bvatgxygq4rjssly@pali>
 <20201002151547.GA25740@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002151547.GA25740@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 02 October 2020 16:15:47 Lorenzo Pieralisi wrote:
> On Fri, Oct 02, 2020 at 05:07:01PM +0200, Pali Rohár wrote:
> 
> [...]
> 
> > > I will apply the stable tag and dependency, it should be fine.
> > 
> > Ok! I thought that according to stable-kernel-rules.html that dependent
> > commit could be added after stable email address separated with # char.
> > At least this is how I understood stable-kernel-rules.html and its
> > section:
> > 
> >   "Additionally, some patches submitted via Option 1 may have additional
> >    patch prerequisites which can be cherry-picked."
> 
> That's what I did - pci/aardvark branch.

Great, thank you!

I will be monitoring backport emails in case it would not be correctly
detected/cherrypicked.
