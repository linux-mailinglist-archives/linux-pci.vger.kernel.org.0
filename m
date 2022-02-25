Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF94C4493
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 13:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiBYMZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 07:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiBYMZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 07:25:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12C320E7AE;
        Fri, 25 Feb 2022 04:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96CCFB82F7B;
        Fri, 25 Feb 2022 12:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00583C340E7;
        Fri, 25 Feb 2022 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645791895;
        bh=cSQNpBISw0MlYXiiY3XgnX1pKxAMGAwP//OJtPfreTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwGZUaoCOgsdUuXBm54rN2MROfbhe7Ixmm084Pw0jBXJyna/O+U1jQSHYm06O6XsI
         ZjDDwyiDRgZ10heeyYGUj1hjK3QjZ2miuFKOv0WhLXW0Y69Jr0FpA4OA6rSWNs8LuZ
         RossxCTPTzuTcqs/tFVhRTkvcrYCVvYWCe+Xp0X/48OzIyRybuJh9vlFx4hCdso88i
         iWAf7mQt0a841UqiANX8P2Ew8SJRJLVX+ZlmvOHs++qTPIR/l23yCdHTvx3kkaBAg9
         kWZ9CgRX/LI28ljzOivmW+CCdWBBhgvNJQdghuIGOqmKWih9aIOVAV4X/SAbG4API0
         P+6c5feTQNTdw==
Received: by pali.im (Postfix)
        id 109B37EF; Fri, 25 Feb 2022 13:24:51 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:24:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220225122451.fa2fiyzohwme2d66@pali>
References: <20220222163158.1666-3-pali@kernel.org>
 <20220224202843.GA291544@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220224202843.GA291544@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 February 2022 14:28:43 Bjorn Helgaas wrote:
> On Tue, Feb 22, 2022 at 05:31:54PM +0100, Pali Rohár wrote:
> > These macros allows to easily compose and extract Slot Power Limit and
> > Physical Slot Number values from Slot Capability Register.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> >  include/uapi/linux/pci_regs.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 108f8523fa04..3fc9a4cac630 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -591,10 +591,13 @@
> >  #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
> >  #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
> >  #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value */
> > +#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value shift */
> 
> Is there a way to use FIELD_PREP() and FIELD_GET() instead?  It seems
> like that's what the cool kids are doing now.

This is possible too.

I have proposed a patch with _SHIFT macros as this is the way how are
other macros in this file defined and used.

> At first I didn't really like them, but they do remove the need for
> adding _SHIFT macros that have to be manually related to the other.
> 
> >  #define  PCI_EXP_SLTCAP_SPLS	0x00018000 /* Slot Power Limit Scale */
> > +#define  PCI_EXP_SLTCAP_SPLS_SHIFT	15 /* Slot Power Limit Scale shift */
> >  #define  PCI_EXP_SLTCAP_EIP	0x00020000 /* Electromechanical Interlock Present */
> >  #define  PCI_EXP_SLTCAP_NCCS	0x00040000 /* No Command Completed Support */
> >  #define  PCI_EXP_SLTCAP_PSN	0xfff80000 /* Physical Slot Number */
> > +#define  PCI_EXP_SLTCAP_PSN_SHIFT	19 /* Physical Slot Number shift */
> >  #define PCI_EXP_SLTCTL		0x18	/* Slot Control */
> >  #define  PCI_EXP_SLTCTL_ABPE	0x0001	/* Attention Button Pressed Enable */
> >  #define  PCI_EXP_SLTCTL_PFDE	0x0002	/* Power Fault Detected Enable */
> > -- 
> > 2.20.1
> > 
