Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850125B22F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIBQ44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 12:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBQ4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 12:56:55 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44AEF20767;
        Wed,  2 Sep 2020 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599065815;
        bh=3L0UKK9I3jzsNDU7uoBmqoLSAuzEp6xeiPAyAHHY3TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwzQTWVBLJdtXjHBNJVsqNMDwSOSHw+Behn/R2Ao0hmf3cDm71pOIk6ineflrY7kJ
         Q6oSoFXIYha4Fwo9EU6zTDiY/DnjBeXnaX6jrJp0anvhufdI1xvo9a+2B+s9RUUiMD
         fpmy/PnDjNQ2VqFsG1fku138mjpokMEKcm3GRWzo=
Received: by pali.im (Postfix)
        id EF6FA7BF; Wed,  2 Sep 2020 18:56:52 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:56:52 +0200
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
Message-ID: <20200902165652.cvb74kgxx5uejpta@pali>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-2-pali@kernel.org>
 <20200902161328.GE3050651@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902161328.GE3050651@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 September 2020 18:13:28 Andrew Lunn wrote:
> On Wed, Sep 02, 2020 at 04:43:43PM +0200, Pali Rohár wrote:
> > Driver ->power_on and ->power_off callbacks leaks internal SMCC firmware
> > return codes to phy caller. This patch converts SMCC error codes to
> > standard linux errno codes. Include file linux/arm-smccc.h already provides
> > defines for SMCC error codes, so use them instead of custom driver defines.
> > Note that return value is signed 32bit, but stored in unsigned long type
> > with zero padding.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
> >  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
> >  2 files changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> > index 1a138be8bd6a..810f25a47632 100644
> > --- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> > +++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> > @@ -26,7 +26,6 @@
> >  #define COMPHY_SIP_POWER_ON			0x82000001
> >  #define COMPHY_SIP_POWER_OFF			0x82000002
> >  #define COMPHY_SIP_PLL_LOCK			0x82000003
> > -#define COMPHY_FW_NOT_SUPPORTED			(-1)
> >  
> >  #define COMPHY_FW_MODE_SATA			0x1
> >  #define COMPHY_FW_MODE_SGMII			0x2
> > @@ -112,10 +111,19 @@ static int mvebu_a3700_comphy_smc(unsigned long function, unsigned long lane,
> >  				  unsigned long mode)
> >  {
> >  	struct arm_smccc_res res;
> > +	s32 ret;
> >  
> >  	arm_smccc_smc(function, lane, mode, 0, 0, 0, 0, 0, &res);
> > +	ret = res.a0;
> >  
> > -	return res.a0;
> 
> > +	switch (ret) {
> > +	case SMCCC_RET_SUCCESS:
> > +		return 0;
> > +	case SMCCC_RET_NOT_SUPPORTED:
> > +		return -EOPNOTSUPP;
> > +	default:
> > +		return -EINVAL;
> > +	}
> >  }
> 
> Hi Pali
> 
> Maybe this should be a global helper translating SMCCC_RET_* into a
> standard errno value?
> 
> 	 Andrew

Hello Andrew!

Well, I'm not sure if some standard global helper is the correct way for
marvell comphy handler. It returns 0 for success and -1 on error when
handler is not supported.

Generic SMCC helper would need to support also other values which are
defined/used by SMCC. And I'm not sure if some helpers cannot define and
use also non-standard codecs.

I think that such generic helper would need larger discussion and aim of
these patches is to fix PCIe support on Armada 3720 HW which is broken
since mentioned commit when users use factory firmware. So patches could
be easily backported to stable kernels.

On Espressobin is kernel stored on uSD card, so updating it is simple
and easy -- as opposite of updating ATF firmware which is stored in SPI.
