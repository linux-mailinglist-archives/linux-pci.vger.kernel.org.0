Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DED25B2A4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBRF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 13:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgIBRF2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 13:05:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602D220709;
        Wed,  2 Sep 2020 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599066327;
        bh=Ejn1rK35gdtDaSRIW2e8y9RuTwb7J/O+r5vI8fVSakY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjuWRhqrFg6LXVMz50q6G03zbMqUwL3ZU9vcjlxkGTLyxzFWxVorUvUkMq/fxAogG
         /Mq7R1HGgt61+byfHF+nsyVsmtD9000UFJ+wCvkkNTWazGZxMYTzCCgcy+6dAd006C
         GKVgDjGuHpar5EVfAmLQVdGWX0R9UxCCxj6FxCKM=
Received: by pali.im (Postfix)
        id 5D0B77BF; Wed,  2 Sep 2020 19:05:25 +0200 (CEST)
Date:   Wed, 2 Sep 2020 19:05:25 +0200
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
Message-ID: <20200902170525.ksovu7ah3wbotkim@pali>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-2-pali@kernel.org>
 <20200902161328.GE3050651@lunn.ch>
 <20200902165652.cvb74kgxx5uejpta@pali>
 <20200902170010.GF3050651@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902170010.GF3050651@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 September 2020 19:00:10 Andrew Lunn wrote:
> > > > +	switch (ret) {
> > > > +	case SMCCC_RET_SUCCESS:
> > > > +		return 0;
> > > > +	case SMCCC_RET_NOT_SUPPORTED:
> > > > +		return -EOPNOTSUPP;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > >  }
> > > 
> > > Hi Pali
> > > 
> > > Maybe this should be a global helper translating SMCCC_RET_* into a
> > > standard errno value?
> > > 
> > > 	 Andrew
> > 
> > Hello Andrew!
> > 
> > Well, I'm not sure if some standard global helper is the correct way for
> > marvell comphy handler. It returns 0 for success and -1 on error when
> > handler is not supported.
> 
> No, i was meaning just 
> 
> switch (ret) {
> case SMCCC_RET_SUCCESS:
> 	return 0;
> case SMCCC_RET_NOT_SUPPORTED:
> 	return -EOPNOTSUPP;
> default:
> 	return -EINVAL;
> }

But this is not a complete generic helper. There are more generic SMCC
return codes and generic helper should define and translate all of them.
