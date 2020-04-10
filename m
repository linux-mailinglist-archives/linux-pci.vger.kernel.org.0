Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F601A4B56
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDJUmh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 16:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDJUmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 16:42:37 -0400
Received: from localhost (mobile-166-170-220-109.mycingular.net [166.170.220.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3242063A;
        Fri, 10 Apr 2020 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551357;
        bh=A4WsCxIwO8LiVYvzga6hpNqHs5oyUxeEWvviTh9Uzfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dqvuGN7O1rLZoJW8rRQ4sdoutNZiJ5RAU/FEBP8iv0bcqex7SinWbRQDkrikwy+eU
         hgLOx7sFywLH92EE8w0l56KVWmUScSHuEFd7/SzmTgCi42uRAqE73j2wTcs2Sf3HOG
         vIHeSHEY6qH0FpiY4yrZnXtfjQybedEHmmNS35OQ=
Date:   Fri, 10 Apr 2020 15:42:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] Replace -EINVAL with a positive error number
Message-ID: <20200410204235.GA8175@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410170713.2029-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 07:07:13PM +0200, Bolarinwa Olayemi Saheed wrote:

Hi Saheed,

Thanks for the patch!  This is a tricky area and we'll have to proceed
carefully.  A few procedural nits:

1) This is labeled v2, but it looks the same as the first posting.  If
it *is* the same, there's no need to repost it.  You can check
https://lore.kernel.org/linux-pci/ to see if it made it to the mailing
list.

If v2 is different from v1, please include a note about what changed
since v1.

2) This needs a commit log, even if it repeats the subject.  The
subject is the title, the log itself is the body, and we need both.

It should include the rationale for the change, e.g., in this case
we're trying to make the return values of the pcie_capability_*()
accessors consistent with the plain pci_*config*() accessors.

3) The subject doesn't make sense: -EINVAL doesn't appear in the patch
at all.  And pcibios_err_to_errno() always returns a *negative*
number, not a positive number.  But most importantly, it's a little
too low-level -- it needs to say something about the purpose of the
patch.

4) This patch appears to be made to apply on top of your original
patch [1], since it expects:

>  	if (pos & 1)
> -		return PCIBIOS_BAD_REGISTER_NUMBER;

But a revised patch (v2, v3, etc) doesn't get added on top of previous
versions; it completely *replaces* previous versions.  In general,
patches you post should apply cleanly on my "master" branch [2], which
generally is the -rc1 tag.

And finally, the most important and tricky part:

5) We need some indication that this change is safe for all callers,
so we need to audit them all and either include a note that no changes
are needed, or include the changes in this patch so everything that
worked before this patch also works after this patch.

We're not trying to change any behavior (unless we trip over a bug
when auditing the callers).

The current situation is that pcie_capability_*() accessors can return
0, -EINVAL, or PCIBIOS_FUNC_NOT_SUPPORTED, etc (PCIBIOS_* errors are
all positive).  That makes it harder than it should be for callers to
check for errors.

[1] https://lore.kernel.org/r/20200409161609.2034-1-refactormyself@gmail.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=master

> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/access.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 451f2b8b2b3c..d5460eb92c12 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  
>  	*val = 0;
>  	if (pos & 1)
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> +		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  
>  	*val = 0;
>  	if (pos & 3)
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> +		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
> -- 
> 2.17.1
> 
