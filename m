Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2221EA3A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgGNHiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 03:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgGNHix (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 03:38:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F482084C;
        Tue, 14 Jul 2020 07:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594712333;
        bh=D9X12rzUdjdFj13IA0SQy7lT+r0nIG2ebG23ZycYooo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjbVNXfqwfJCMrv83a4TBW2KQlgSPYZoRCZ2dyPGQ1L0rB7E0Ao5fqRdVamRJCVaQ
         XW+aGrhAPXs0BGRK58cXBAhBQvMQs8dcotHaCXyDWKOoN7mgnc1S/yVL8puPbnyTe0
         lg6Q2vZI1zLrG9u+Oyyj9aRQpRso4NfJVV1eFU80=
Received: by pali.im (Postfix)
        id 340C8842; Tue, 14 Jul 2020 09:38:50 +0200 (CEST)
Date:   Tue, 14 Jul 2020 09:38:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200714073850.rvuknigpj3jt7kp4@pali>
References: <20200702083036.12230-1-pali@kernel.org>
 <20200709113509.GB19638@e121166-lin.cambridge.arm.com>
 <20200709122208.rmfeuu6zgbwh3fr5@pali>
 <20200709144701.GA21760@e121166-lin.cambridge.arm.com>
 <20200709150959.wq6zfkcy4m6hvvpl@pali>
 <20200710091800.GA3419@e121166-lin.cambridge.arm.com>
 <20200713082747.e3q3ml3wpbszn4j7@pali>
 <20200713112325.GA25865@e121166-lin.cambridge.arm.com>
 <20200713145003.foarsdixquicvivy@pali>
 <20200713164140.GA29307@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713164140.GA29307@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 13 July 2020 17:41:40 Lorenzo Pieralisi wrote:
> On Mon, Jul 13, 2020 at 04:50:03PM +0200, Pali Rohár wrote:
> > On Monday 13 July 2020 12:23:25 Lorenzo Pieralisi wrote:
> > > I will go over the thread again but I suspect I can merge the patch even
> > > though I still believe there is work to be done to understand the issue
> > > we are facing.
> > 
> > Just to note that pci-mvebu.c also checks if pcie link is up before
> > trying to access the real PCIe interface registers, similarly as in my
> > patch.
> 
> I understand - that does not change my opinion though, the link check
> is just a workaround, it'd be best if we pinpoint the real issue which
> is likely to a HW one.

Lorenzo, if you have an idea how to debug this issue or if you would
like to see some test results, let me know. I can do some tests, but I
currently really do not know more then what I wrote in previous emails.

In my opinion, problem is in HW which Marvell has not documented nor
proved that it exists. Other option is that problem is in Compex card
which can be triggered only by Marvell aardvark HW.
