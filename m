Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7D4B70A4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiBOPa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 10:30:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiBOPaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 10:30:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7CB0A7D
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 07:28:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFB8614C2
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 15:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A016C340F3;
        Tue, 15 Feb 2022 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644938921;
        bh=OYTfQ8VxABysvJ/puRnzPJFu0b6HhvyFQK3GmBLh4Nk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O9LjVVtQ7V77C5ZLMRP1JjkFOAHco3pIg5afEf7bX70fNfyxyrCf4ohBuphHEMknS
         7/txVcJiY53bnGBqkgg3xTnPW2qzBsvxTdh7DdalBMkzsdYNIu//ZlPr6g4nldEe2C
         +1/+EYj5Gr8iuA5Fxh/Fau9Qq7sBpMqlSxgROtqNuGTG+XfU9izkzys4KUgZpGivDB
         RjA6y9DhyuMA6xRUhpRoEi0tcV5X05HeEZFgPa5S8psyGSFk7IzAtiTxVE9Dwy3GwQ
         2K/XVhKIbi6IY/zwtdUvglFPwBGpZn07jXuCCFukUJnPFm/2Zp/q2QspkTkvhdeyN1
         d6Ry1hpNzgzCQ==
Date:   Tue, 15 Feb 2022 09:28:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Sunil Goutham <sgoutham@marvell.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, sunil.goutham@gmail.com
Subject: Re: [PATCH] PCI: Add Marvell Octeon devices to PCI IDs
Message-ID: <20220215152838.GA109355@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YguaAbHelW0/l9lm@unreal>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 02:18:09PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 14, 2022 at 05:55:10PM +0530, Sunil Goutham wrote:
> > Add Marvell (Cavium) OcteonTx2 and CN10K devices
> > to PCI ID database.
> > 
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > ---
> >  include/linux/pci_ids.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index aad54c6..5fd187b 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2357,6 +2357,21 @@
> >  #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
> >  
> >  #define PCI_VENDOR_ID_CAVIUM		0x177d
> > +#define PCI_DEVICE_ID_OCTEONTX2_PTP	0xA00C
> > +#define PCI_DEVICE_ID_CN10K_PTP		0xA09E
> > +#define PCI_DEVICE_ID_OCTEONTX2_CGX	0xA059
> > +#define PCI_DEVICE_ID_CN10K_RPM		0xA060
> > +#define PCI_DEVICE_ID_OCTEONTX2_CPTPF	0xA0FD
> > +#define PCI_DEVICE_ID_OCTEONTX2_CPTVF	0xA0FE
> > +#define PCI_DEVICE_ID_CN10K_CPTPF	0xA0F2
> > +#define PCI_DEVICE_ID_CN10K_CPTVF	0xA0F3
> > +#define PCI_DEVICE_ID_OCTEONTX2_RVUAF	0xA065
> > +#define PCI_DEVICE_ID_OCTEONTX2_RVUPF	0xA063
> > +#define PCI_DEVICE_ID_OCTEONTX2_RVUVF	0xA064
> > +#define PCI_DEVICE_ID_OCTEONTX2_LBK	0xA061
> > +#define PCI_DEVICE_ID_OCTEONTX2_LBKVF	0xA0F8
> > +#define PCI_DEVICE_ID_OCTEONTX2_SDPPF	0xA0F6
> > +#define PCI_DEVICE_ID_OCTEONTX2_SDPVF	0xA0F7
> 
> If I recall correctly, this file is for device IDs that are used in more
> than one subsystem. It is not supposed to be updated for every octeon device.

Right; if these are just used in one driver, the #define should go in
that driver to help make merges easier.  If they're used in several
places, they can go here.  But please:

  - Include patches to the users in the series
  - Include the "vendor" tag in the device #defines to avoid conflicts
  - Use lower-case hex to match the surrounding context

Also consider adding these to https://pci-ids.ucw.cz/ in any case,
which will make "lspci" show useful names.

Bjorn
