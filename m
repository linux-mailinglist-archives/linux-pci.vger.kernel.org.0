Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5D4C1AA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSTop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 15:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbfFSTop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 15:44:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E3F214AF;
        Wed, 19 Jun 2019 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560973484;
        bh=yjvBRq+DtWFeYQQ0aVLPM8y9YJxLgOYEAnGn0YPlSvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONDoeco1yRZuy/Jx6ZLiYYHWa7hXF64Jrnz7Z5WlZcgLwSNSW1jfLhz1VIAKQDPE6
         gaSckKMj9ziQXATvOuyQpFsd9NQ6EJ0kkGi6ULdR7V8QlTuI1kjDpl/5wInx0P8Be4
         /suRPOgd/fBM87E71bsJNvEYetN1YRC8b5fpk7IE=
Date:   Wed, 19 Jun 2019 14:44:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, mj@ucw.cz,
        bjorn@helgaas.com
Subject: Re: [PATCH v4 0/3] lspci: Update verbose help and show_range()
Message-ID: <20190619194440.GA189077@google.com>
References: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619164858.84746-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 10:48:55AM -0600, Kelsey Skunberg wrote:
> Changes since v1:
>   - Expand changes into more patches for easier review.
>   - Combine three patches for lspci.c into patchset.
> 
>   * Patch 1: lspci: Include -vvv option in help
>     No changes made. Added to series for review.
> 
>   * Patch 2: lspci: Remove unnecessary !verbose check in show_range()
>     Move into it's own patch since v1. Dead code which checks for
>     verbosity to be true.
> 
>   * Patch 3: lspci: Replace output for bridge with empty range from
>     "None" to "[empty]"
>     Patch builds off Patch 2 to change show_range() output to be more
>     consistent between each level of verbosity.
> 
> Changes since v2:
>   * Patch 1: Update commit log to imperative mood
> 
>   * Patch 2: Fix logical error
>         Previous:
>         (base > limit || verbose < 3)
>         New:
>         (base > limit && verbose < 3)
> 
>   * Patch 3: Fix logical error
>         Previous:
>         base > limit
>         New:
>         base <= limit
> 
> Changes since v3:
>   * Patch 1 and 2: No change
>   * Patch 3: Change output from "[empty]" to "[disabled]"
> 
> Kelsey Skunberg (3):
>   lspci: Include -vvv option in help
>   lspci: Remove unnecessary !verbose check in show_range()
>   lspci: Change output for bridge with empty range to "[disabled]"
> 
>  lspci.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

These look great to me, thanks for doing this.  FWIW:

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
