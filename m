Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18E121C04
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfEQQuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 12:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfEQQuC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 12:50:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB5B21743;
        Fri, 17 May 2019 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558111802;
        bh=kFZlUc7Kt6Y5tB602xYCCbIM0EixJLlMH/LAIbzGcys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DK7sIDJ3VDMuQ4gqvjpOD7FVQkt2orVXETIUl6AgK6G7dolWGftCPo2wn8IZAOXW
         GqnH7+rqoGu4C1KbkNeM29POfN/5pFuWK4sC4GKos6eDA6BZfeuU82bQyhxtDS7uA/
         txwcsYoaTzcUmS9X3EcTQXw48pEdCHZLRHDeXcbg=
Date:   Fri, 17 May 2019 11:50:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Karthikeyan M <m.karthikeyan@mobiveil.co.in>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Message-ID: <20190517165000.GA49425@google.com>
References: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20190510134811.GG235064@google.com>
 <20190510163551.GH235064@google.com>
 <AM6PR04MB57818B273DB942376CBE5E72840B0@AM6PR04MB5781.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB57818B273DB942376CBE5E72840B0@AM6PR04MB5781.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 17, 2019 at 03:03:19PM +0000, Z.q. Hou wrote:
> Hi Bjorn,
> 
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: 2019年5月11日 0:36
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>; Karthikeyan M
> > <m.karthikeyan@mobiveil.co.in>
> > Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>;
> > linux-pci@vger.kernel.org; lorenzo.pieralisi@arm.com
> > Subject: Re: [PATCH 1/1] PCI: mobiveil: Update maintainers list
> > 
> > On Fri, May 10, 2019 at 08:48:11AM -0500, Bjorn Helgaas wrote:
> > > On Tue, May 07, 2019 at 07:45:16AM -0400, Subrahmanya Lingappa wrote:
> > > > Add Karthikeyan M and Z.Q. Hou as new maintainers of Mobiveil
> > > > controller driver.
> > > >
> > > > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > >
> > > I'd like to include this ASAP so patches get sent to the right place,
> > > and I want to make sure we spell the names and email addresses
> > > correctly.
> > >
> > > Zhiqiang, you consistently use "Hou Zhiqiang <Zhiqiang.Hou@nxp.com>"
> > > for sign-offs [1] (except for "Z.q. Hou" in email headers).  Can you
> > > ack that the updated patch below is correct for you?
> > >
> > > Karthikeyan, I don't see any email or commits from you yet, so I'd
> > > really like your ack along with the canonical name/email address you prefer.
> > > There is another Karthikeyan already in MAINTAINERS, so hopefully we
> > > can avoid any confusion.
> > >
> > > [1] git log --format="%an <%ae>" --author=[Zz]hiqiang
> > 
> > I went ahead and applied the patch below for v5.2, but if you want to tweak
> > the names/addresses, I can update them if you tell me soon.
> 
> Sorry for my delay reply, I'm on paternity leave.
> It's OK for me.

No problem, the patch is already in Linus' tree.

Congratulations on your child!

Bjorn
