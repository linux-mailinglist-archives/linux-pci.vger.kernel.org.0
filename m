Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C41725B31E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIBRpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgIBRpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:45:08 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039052071B;
        Wed,  2 Sep 2020 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599068708;
        bh=RQZtL4W3u8ZFDrsxWq4Ue3tBbr4nUr6JJ8sRx70VO9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUZDNf+XmtjX9At928xAss9mWj/SKPVKJ8s/EDlXREeZfdTuuDQC88Qrq2T+TyQPt
         6KvnFE0zjihu+FhC1xswiwTyHlszEYw2GugQQ9vwa60vm8/O+UOpARv++nCP26z9NW
         hmsSGfsFrAdE8w0SA7Do6ce2fCf1fk9HW3rxm49c=
Received: by pali.im (Postfix)
        id 02C807BF; Wed,  2 Sep 2020 19:45:05 +0200 (CEST)
Date:   Wed, 2 Sep 2020 19:45:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] phy: marvell: comphy: Convert internal SMCC firmware
 return codes to errno
Message-ID: <20200902174505.wuflkak6dv57jxw6@pali>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-2-pali@kernel.org>
 <20200902161328.GE3050651@lunn.ch>
 <20200902165652.cvb74kgxx5uejpta@pali>
 <20200902170010.GF3050651@lunn.ch>
 <20200902170525.ksovu7ah3wbotkim@pali>
 <20200902172029.GG3050651@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902172029.GG3050651@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 September 2020 19:20:29 Andrew Lunn wrote:
> On Wed, Sep 02, 2020 at 07:05:25PM +0200, Pali Rohár wrote:
> > On Wednesday 02 September 2020 19:00:10 Andrew Lunn wrote:
> > > > > > +	switch (ret) {
> > > > > > +	case SMCCC_RET_SUCCESS:
> > > > > > +		return 0;
> > > > > > +	case SMCCC_RET_NOT_SUPPORTED:
> > > > > > +		return -EOPNOTSUPP;
> > > > > > +	default:
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > >  }
> > > > > 
> > > > > Hi Pali
> > > > > 
> > > > > Maybe this should be a global helper translating SMCCC_RET_* into a
> > > > > standard errno value?
> > > > > 
> > > > > 	 Andrew
> > > > 
> > > > Hello Andrew!
> > > > 
> > > > Well, I'm not sure if some standard global helper is the correct way for
> > > > marvell comphy handler. It returns 0 for success and -1 on error when
> > > > handler is not supported.
> > > 
> > > No, i was meaning just 
> > > 
> > > switch (ret) {
> > > case SMCCC_RET_SUCCESS:
> > > 	return 0;
> > > case SMCCC_RET_NOT_SUPPORTED:
> > > 	return -EOPNOTSUPP;
> > > default:
> > > 	return -EINVAL;
> > > }
> > 
> > But this is not a complete generic helper. There are more generic SMCC
> > return codes and generic helper should define and translate all of them.
> 
> /*
>  * Return codes defined in ARM DEN 0070A
>  * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
>  */
> #define SMCCC_RET_SUCCESS			0
> #define SMCCC_RET_NOT_SUPPORTED			-1
> #define SMCCC_RET_NOT_REQUIRED			-2
> #define SMCCC_RET_INVALID_PARAMETER		-3

Routines can use also other custom return codes. These are IIRC just
standard defined.

> I only see problems with SMCCC_RET_NOT_REQUIRED and what value to use
> for it. Do you have any idea what is actually means? A parameter was
> passed which was not required? Or that the call itself is not
> required? Looking at the uses of it currently in the kernel, it does
> not seem to be an actual error. So maybe just return 0?

I'm not sure. That is why I wrote that larger discussion about generic
helper is needed. There are for sure people who understand SMC better
and have deep insight.

For Marvell comphy we cannot use return code -2 as success like 0.
