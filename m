Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E1F8CCA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLK1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 05:27:12 -0500
Received: from foss.arm.com ([217.140.110.172]:59620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbfKLK1M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 05:27:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC6781FB;
        Tue, 12 Nov 2019 02:27:11 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25BD63F534;
        Tue, 12 Nov 2019 02:27:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:27:06 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: rcar: Fix missing MACCTLR register setting
 in initialize sequence
Message-ID: <20191112102706.GA12685@e121166-lin.cambridge.arm.com>
References: <1572951089-19956-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1572951089-19956-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20191111144236.GB9653@e121166-lin.cambridge.arm.com>
 <TYAPR01MB4544F0F0BCAC5116731D15A9D8770@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4544F0F0BCAC5116731D15A9D8770@TYAPR01MB4544.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[removed CC stable]

On Tue, Nov 12, 2019 at 01:48:03AM +0000, Yoshihiro Shimoda wrote:

[...]

> I'm sorry. I think I should not drop a sentence "because the bit 0 is
> set to 1 on reset" which has the reverted patch from this version. Also,
> the note seems to be difficult to understand. So, I'll rewrite this log
> like below. Is it acceptable?
> 
> ---
> According to the R-Car Gen2/3 manual,

Is this a publicly available manual ? If yes we provide a link, if
not I will reword the sentence below.

> "Be sure to write the initial value (= H'80FF 0000) to MACCTLR before
> enabling PCIETCTLR.CFINIT" because the bit 0 of MACCTLR is set to 1 on
> reset. To avoid unexpected behaviors, this patch fixes it.
> 
> Note that the SPCHG bit (bit 24) of MACCTLR register description said
> "Only writing 1 is valid and writing 0 is invalid", but this "invalid"
> means "ignored", not "prohibited". So, even if the driver writes
> the SPCHG to 0, there is no problem.

I know understand it, let me know if we can add a link to a manual
(plus section/paragraph, etc.), I will rewrite the commit log
accordingly.

Thanks,
Lorenzo

> ---
> 
> Best regards,
> Yoshihiro Shimoda
> 
