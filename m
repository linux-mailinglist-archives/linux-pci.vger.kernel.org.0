Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0E1A4B16
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJUWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 16:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgDJUWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 16:22:55 -0400
Received: from localhost (mobile-166-170-220-109.mycingular.net [166.170.220.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0022020732;
        Fri, 10 Apr 2020 20:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586550175;
        bh=Z1jN8Grsq+grHOKsdqVHFXucXIaNAuutpqwhUMHJRJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yPSNS8/JcNcwDz+37Mih4Y4Ae1VPy4JxjZZEwNw/4/YLofuUVamNOV7rG4w5ZLjqy
         +jaeHpJXfxm1SS58djsXckcs2t5UdeMsHcacSwES4GTaOJRhsYEgdVvR/Q7hkzDMVO
         kqd0cAPgE1QZU3dJYfVfRA3UhzDOnk/+7dxJ9o2U=
Date:   Fri, 10 Apr 2020 15:22:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
Message-ID: <20200410202252.GA11837@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a43a1a-d271-7652-db62-1a7c55cd135b@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 09:28:07AM +0800, Yicong Yang wrote:
> Hi Bolarinwa,
> 
> I notice some drivers use these functions and if there is an error,
> pass the error code directly to the userspace. As it's our private
> error code, is it appropriate to pass or should we call
> pcibios_err_to_errno()(include/linux/pci.h, line 672) to do the
> conversion?

The whole point of this is to make the return values of the
pcie_capability_{read,write,etc}*() functions work the same as
the pci_{read,write}_config*() functions.

The latter return PCIBIOS_* error codes, so the former should as well.

When we do this, we do need to audit every caller of the
pcie_capability_{read,write}*() functions to make sure we don't break
them.  If some callers pass the error code directly to userspace, they
may need some change.

Yicong, can you point to the ones you noticed so Saheed can check them
out?

Bjorn

> On 2020/4/10 0:16, Bolarinwa Olayemi Saheed wrote:
> > Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> > Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> > ---
> >  drivers/pci/access.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 79c4a2ef269a..451f2b8b2b3c 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
> >  
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
