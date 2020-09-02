Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20525B2DA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBRUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:20:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38596 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBRUm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:20:42 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kDWQv-00Cv40-OY; Wed, 02 Sep 2020 19:20:29 +0200
Date:   Wed, 2 Sep 2020 19:20:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] phy: marvell: comphy: Convert internal SMCC firmware
 return codes to errno
Message-ID: <20200902172029.GG3050651@lunn.ch>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-2-pali@kernel.org>
 <20200902161328.GE3050651@lunn.ch>
 <20200902165652.cvb74kgxx5uejpta@pali>
 <20200902170010.GF3050651@lunn.ch>
 <20200902170525.ksovu7ah3wbotkim@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902170525.ksovu7ah3wbotkim@pali>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 07:05:25PM +0200, Pali Rohár wrote:
> On Wednesday 02 September 2020 19:00:10 Andrew Lunn wrote:
> > > > > +	switch (ret) {
> > > > > +	case SMCCC_RET_SUCCESS:
> > > > > +		return 0;
> > > > > +	case SMCCC_RET_NOT_SUPPORTED:
> > > > > +		return -EOPNOTSUPP;
> > > > > +	default:
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > >  }
> > > > 
> > > > Hi Pali
> > > > 
> > > > Maybe this should be a global helper translating SMCCC_RET_* into a
> > > > standard errno value?
> > > > 
> > > > 	 Andrew
> > > 
> > > Hello Andrew!
> > > 
> > > Well, I'm not sure if some standard global helper is the correct way for
> > > marvell comphy handler. It returns 0 for success and -1 on error when
> > > handler is not supported.
> > 
> > No, i was meaning just 
> > 
> > switch (ret) {
> > case SMCCC_RET_SUCCESS:
> > 	return 0;
> > case SMCCC_RET_NOT_SUPPORTED:
> > 	return -EOPNOTSUPP;
> > default:
> > 	return -EINVAL;
> > }
> 
> But this is not a complete generic helper. There are more generic SMCC
> return codes and generic helper should define and translate all of them.

/*
 * Return codes defined in ARM DEN 0070A
 * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
 */
#define SMCCC_RET_SUCCESS			0
#define SMCCC_RET_NOT_SUPPORTED			-1
#define SMCCC_RET_NOT_REQUIRED			-2
#define SMCCC_RET_INVALID_PARAMETER		-3

I only see problems with SMCCC_RET_NOT_REQUIRED and what value to use
for it. Do you have any idea what is actually means? A parameter was
passed which was not required? Or that the call itself is not
required? Looking at the uses of it currently in the kernel, it does
not seem to be an actual error. So maybe just return 0?

	Andrew
