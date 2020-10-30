Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB22A07C1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJ3OXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 10:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgJ3OXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 10:23:42 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4422076E;
        Fri, 30 Oct 2020 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604067821;
        bh=U8oNwRzNkefmzZKa0lgNqYV87NZYbnjlIeNv+BnIDOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rti43ooGnmRvJvKtYWyt24jHKVAFkGRQqGqJJ/zN1HMjZmcQE+48nmlQq6CQMgkQj
         XRUH/R0Psue+SGZ3sCWqhtBKXAm8txfUID9FTd3BdTVXvoSVi6PKTDQX+7/JzwcuOJ
         V+D0o+9ckOpMML8pr2sIQf4sYUpU4tHwkp/hSjjk=
Received: by pali.im (Postfix)
        id C6E0086D; Fri, 30 Oct 2020 15:23:37 +0100 (CET)
Date:   Fri, 30 Oct 2020 15:23:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201030142337.yushrdcuecycfhcu@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201030112331.meqg6lvultyn6v54@pali>
 <87k0v7n9y9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0v7n9y9.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 30 October 2020 14:02:22 Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> > My experience with that WLE900VX card, aardvark driver and aspm code:
> >
> > Link training in GEN2 mode for this card succeed only once after reset.
> > Repeated link retraining fails and it fails even when aardvark is
> > reconfigured to GEN1 mode. Reset via PERST# signal is required to have
> > working link training.
> >
> > What I did in aardvark driver: Set mode to GEN2, do link training. If
> > success read "negotiated link speed" from "Link Control Status Register"
> > (for WLE900VX it is 0x1 - GEN1) and set it into aardvark. And then
> > retrain link again (for WLE900VX now it would be at GEN1). After that
> > card is stable and all future retraining (e.g. from aspm.c) also passes.
> >
> > If I do not change aardvark mode from GEN2 to GEN1 the second link
> > training fails. And if I change mode to GEN1 after this failed link
> > training then nothing happen, link training do not success.
> >
> > So just speculation now... In current setup initialization of card does
> > one link training at GEN2. Then aspm.c is called which is doing second
> > link retraining at GEN2. And if it fails then below patch issue third
> > link retraining at GEN1. If A38x/pci-mvebu has same problem as aardvark
> > then second link retraining must be at GEN1 (not GEN2) to workaround
> > this issue.
> >
> > Bjorn, Toke: what about trying to hack aspm.c code to never do link
> > retraining at GEN2 speed? And always force GEN1 speed prior link
> > training?
> 
> Sounds like a plan. I poked around in aspm.c and must confess to being a
> bit lost in the soup of registers ;)
> 
> So if one of you can cook up a patch, that would be most helpful!

I modified Bjorn's patch, explicitly set tls to 1 and added debug info
about cls (current link speed, that what is used by aardvark). It is
untested, I just tried to compile it.

Can try it?

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..f934c0b52f41 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -206,6 +206,27 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	unsigned long end_jiffies;
 	u16 reg16;
 
+	u32 lnkcap2;
+	u16 lnksta, lnkctl2, cls, tls;
+
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &lnkcap2);
+	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &lnksta);
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
+	cls = lnksta & PCI_EXP_LNKSTA_CLS;
+	tls = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
+
+	pci_info(parent, "lnkcap2 %#010x sls %#04x lnksta %#06x cls %#03x lnkctl2 %#06x tls %#03x\n",
+		lnkcap2, (lnkcap2 & 0x3F) >> 1,
+		lnksta, cls,
+		lnkctl2, tls);
+
+	tls = 1;
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+					PCI_EXP_LNKCTL2_TLS, tls);
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
+	pci_info(parent, "lnkctl2 %#010x new tls %#03x\n",
+		lnkctl2, tls);
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
@@ -227,6 +248,8 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 			break;
 		msleep(1);
 	} while (time_before(jiffies, end_jiffies));
+	pci_info(parent, "lnksta %#06x new cls %#03x\n",
+		lnksta, (cls & PCI_EXP_LNKSTA_CLS));
 	return !(reg16 & PCI_EXP_LNKSTA_LT);
 }
 
