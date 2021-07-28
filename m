Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA2C3D921C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhG1PgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 11:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235710AbhG1PgG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 11:36:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96D9060EB2;
        Wed, 28 Jul 2021 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627486564;
        bh=R7+ExG2cGt1JjNkEYM6JWYU8bpH3ZX043RBskfp7S+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X1J5lvqv0UtM7s22u6Bcz7C7RX4lnKQ/cRgdlBlycimDRR1PxDr5W1NwqMUVg/l+g
         v1xEA0JXds/ShOYGwygyj+BO4Ndp5wKd5+ZcgIZMBOHR6UvQc2QVbMDu/Jkp9qazMY
         PlKS8G1Pz2TxeBveHBBfqCrDovXdba2jnojGQlDZ85HvCjDor5pRCInIuhZ+f/TFC8
         87bFjbO4o7Rp/Y1S1MTa5eXKA6i2S+dxfLiPs6HmuAXWsOdAgkFa5ghHL8LSAYD3Fn
         A5yCZl7tAQI4xx3WqAo03ddRHPvcpA1zpegA+z/RA7U+LVB8J9HYiQYKxjekHxs3dL
         LpTBi9a6nMrTQ==
Date:   Wed, 28 Jul 2021 10:36:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210728153603.GA821650@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728012740.GA90475@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 03:27:40AM +0200, Krzysztof Wilczyński wrote:

> > > +	options = kstrndup(buf, count, GFP_KERNEL);
> > 
> > I assume the kstrndup() is because strsep() writes into the buffer?
> 
> Yes, Amey added kstrndup() in v6 following my recommendation as per:
> 
>   https://lore.kernel.org/linux-pci/20210606125800.GA76573@rocinante.localdomain/
> 
> This was to avoid removing the const quantifier through a type cast
> given that the signature of the function denotes that the buffer is
> a pointer to immutable string, as per:
> 
>   https://elixir.bootlin.com/linux/v5.14-rc3/source/include/linux/device/driver.h#L137

Ah, right, thanks!  Definitely prefer not to cast away the constness.

I guess the strings here are short (<100 chars max), so no big deal to
duplicate them.  Sorry for the noise!
