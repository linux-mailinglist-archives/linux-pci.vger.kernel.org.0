Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9852C348
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiERT0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiERT0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 15:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A431DC8
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 12:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E64E2B821A6
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 19:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7BBC385A9;
        Wed, 18 May 2022 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652901963;
        bh=PjHtLEt9xDAGD6Wi0W0Dmg6YFuFG0On9+1me7OexZQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWFaLuVUhkw1nRyvNpqefOD7R+bW9Jg4yzMKo9PtzgSIsIh3FecqX/n1Qk+cerT7K
         +eZLG+/dv/LcudTlZdsYdGIEx7JWPSU+u3u4dpbsbisW6EIVmHW8OabPiq5a/3+hHK
         LAfnlDsbsQRJ64ym6Dcu2zgGEC1WJ3fGvj2+er2mj2596Bn7140Z39/XUAK24FApr3
         GZOy/YeGIk0KMfWT/EqAKLC1gzvMI/rKYnDQewrtzoap7uLlirxpd1TjMttdWCaybo
         MbicaCL2NVnGEyRJMbA4tXwDsOjtK7utis2syDkjEK4UcWH9Uwc5i1k2lj6XKUjpcS
         CaB1yg4fFj1QA==
Received: by pali.im (Postfix)
        id AB8BE5E6; Wed, 18 May 2022 21:26:00 +0200 (CEST)
Date:   Wed, 18 May 2022 21:26:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220518192600.usgzcaca565kt66h@pali>
References: <20220220193346.23789-5-kabel@kernel.org>
 <20220518192322.GA1155024@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518192322.GA1155024@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 18 May 2022 14:23:22 Bjorn Helgaas wrote:
> On Sun, Feb 20, 2022 at 08:33:32PM +0100, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > These macros allows to easily compose and extract Slot Power Limit and
> > Physical Slot Number values from Slot Capability Register.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> We talked about using FIELD_PREP() / FIELD_GET(), which I think would
> remove the need for the *_SHIFT macros.  But we can always do that
> later.

I have already done this for pci-mvebu.c driver and patch was merged:
https://lore.kernel.org/linux-pci/20220412094946.27069-5-pali@kernel.org/

IIRC we have decided to not use those *_SHIFT macros as it would flood
public uapi file and from this file we cannot remove macros due to
userspace backward compatibility.

> > ---
> >  include/uapi/linux/pci_regs.h | 3 +++
> >  1 file changed, 3 insertions(+)
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
