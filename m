Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4C1B66E5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 00:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDWWiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 18:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgDWWiW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 18:38:22 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E33020CC7;
        Thu, 23 Apr 2020 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587681501;
        bh=iz9jJI3DI6YjweFrlkyfnOVkgol0maDQnLbHgWyWixw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sgGX8vChTGjpeNJhv5L/1MUgORrhw3ZnfSuFc9xuYdkRgT+7X50x4JkW7i2u4Tb98
         xkA7mYkD1a2jGmzcxZDXoip1J6jnAbVkLvd3A1SwjmbjQV8PyNvDZS1gNRIdLXD4kb
         485wGR5460nMDsl+3rFMnoHJO9D32mleU1KeOIks=
Date:   Thu, 23 Apr 2020 17:38:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC] pci: Make return value of pcie_capability_read*()
 consistent
Message-ID: <20200423223819.GA248903@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f70efc-0ff6-a53f-9a86-d52e053e6a69@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 23, 2020 at 07:55:17PM +0800, Yicong Yang wrote:
> On 2020/4/19 14:51, Bolarinwa Olayemi Saheed wrote:

> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 79c4a2ef269a..451f2b8b2b3c 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
> 
> Maybe provide some comments for the function, to notify the outside
> users to do the error code conversion.

A short function comment about the set of possible return values
wouldn't hurt.  We don't have those for pci_read_config_word() and
friends, and there are several pcie_capability_*() functions.  I don't
think it's worth repeating the comment for every function, so maybe we
could just extend the existing comment at pcie_capability_read_word().

> BTW, pci_{read, write}_config_*() may also have the issues that
> export the private err code outside. You may want to solve these in
> a series along with this patch.

If you see a specific issue, please point it out.

I looked at pci_read_config_word(), and it can return
PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, or the return
value from bus->ops->read().

I looked at all the users of PCIBIOS_*.  There's really no interesting
use of any of them except by pcibios_err_to_errno() and
xen_pcibios_err_to_errno(), so I'm not sure it's even worth keeping
them.

But I think it's probably more work to excise all of them than it is
to simply make pci_read_config_word() and pcie_capability_read_word()
return the same set of error values.  So I think we should do this
first.

> >  	*val = 0;
> >  	if (pos & 1)
> > -		return -EINVAL;
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> >  
> >  	if (pcie_capability_reg_implemented(dev, pos)) {
> >  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> > @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
> >  
> >  	*val = 0;
> >  	if (pos & 3)
> > -		return -EINVAL;
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> >  
> >  	if (pcie_capability_reg_implemented(dev, pos)) {
> >  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
> 
