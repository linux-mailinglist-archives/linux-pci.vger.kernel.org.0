Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1C4BABA7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 22:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiBQVWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 16:22:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbiBQVWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 16:22:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B680203;
        Thu, 17 Feb 2022 13:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84CA461257;
        Thu, 17 Feb 2022 21:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75F3C340E8;
        Thu, 17 Feb 2022 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645132909;
        bh=7wRGQ9XUjUEObWwDI/pOFW5a3xf50Zwu7W8VBniCA4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlGbtVRJwew4w65b0/yRW3mxGNMD7ByyGXhc5REppHbx4FdCb5ysmtZinrxuB8qYo
         qIfFfynKrObf6KP+FknPb+Qr4N33gx32K4sDI/ceitc5U4SFmmuW0sVQNuQZLyCLZx
         1uNowKlUVdCCW2VVsjCI5GanpA88/t5O4N42zVo/wJgNoNQvGqnb9sWXj+qcICvq/X
         xjpsB0YKvAmwap+0XpvOi3L2XkfVbt2TTj99tSPFuTEZ0owmi/j2mu0OdQd6+5ORnp
         O6z3ps7s0gC6BNBgCr0HzZEDD285hecuPgB7LAkIE+ey+sL5A85+N2/UqvwQFX+iZw
         Lmfrf7JZ3HC9g==
Received: by pali.im (Postfix)
        id DEDFB1187; Thu, 17 Feb 2022 22:21:45 +0100 (CET)
Date:   Thu, 17 Feb 2022 22:21:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/2] PCI: Add defines for normal and
 subtractive PCI bridges
Message-ID: <20220217212145.fvwc2axp6nyeqs36@pali>
References: <20220214114109.26809-1-pali@kernel.org>
 <20220217211134.GA305475@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217211134.GA305475@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 17 February 2022 15:11:34 Bjorn Helgaas wrote:
> On Mon, Feb 14, 2022 at 12:41:08PM +0100, Pali Rohár wrote:
> > Add following two new PCI class codes defines into pci_ids.h include file:
> > 
> >   PCI_CLASS_BRIDGE_PCI_NORMAL
> >   PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE
> > 
> > And use these defines in all kernel code for describing PCI class codes for
> > normal and subtractive PCI bridges.
> 
> Looks good; is this another case?
> 
>   drivers/pci/controller/pci-mvebu.c:     dev_rev |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;

Yes! It is.

> >  static void quirk_sb1250_ht(struct pci_dev *dev)
> >  {
> > -	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> > +	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
