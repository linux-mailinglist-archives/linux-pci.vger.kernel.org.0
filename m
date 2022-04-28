Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3303513243
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbiD1LUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiD1LUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:20:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481EB546AC
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C505B82C88
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 11:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F730C385A0;
        Thu, 28 Apr 2022 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651144607;
        bh=/s/78RD6T24Id7kM+k9Xv990mnYTK3r237lb4FSWOhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJhC5Gpxf4dr3sRFPhJaSyoYGCizmQ2eNYZW2g3TvCAaljDgruuBmYdc3eXYNoqjx
         wENf8WE5568u55QVVvYvqjkZKjZLKikZ5FHd6o5E6K6vCwn3nrDPP9pyu4Ve8l8uYG
         xwWJxiWbAr8/XOBpxirfDJUEITt/ZMHPzKUInOlNKafxIjN8SmMEsGT6RHGOMmk5NR
         p31Lls7NYY8sCe48dcd18+Xh7ImRodaKBqQ+ylUwS++88wIJqk+YzPo+RbQxzRD6wj
         dLFvRby/sJIFhfr+JlbIJSkZMek2fQzS7p58VctBW6Ahm9TaX0AqLnNLQ8POV6rs3i
         Uf+zagayoj9gg==
Received: by pali.im (Postfix)
        id BBE358A0; Thu, 28 Apr 2022 13:16:44 +0200 (CEST)
Date:   Thu, 28 Apr 2022 13:16:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220428111644.n3cfa6ba6etljycw@pali>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-5-kabel@kernel.org>
 <20220428110926.GA32469@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428110926.GA32469@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 28 April 2022 12:09:26 Lorenzo Pieralisi wrote:
> On Sun, Feb 20, 2022 at 08:33:32PM +0100, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > These macros allows to easily compose and extract Slot Power Limit and
> > Physical Slot Number values from Slot Capability Register.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> >  include/uapi/linux/pci_regs.h | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> This patch can be dropped, correct ?

Yes!

And note that 'slot-power-limit-milliwatt' DT property patch you took
into pci/power-slot branch.

> Thanks,
> Lorenzo
> 
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index bee1a9ed6e66..d825e17e448c 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -591,10 +591,13 @@
> >  #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
> >  #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
> >  #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value */
> > +#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value shift */
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
> > 2.34.1
> > 
