Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C4A5ED12F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 01:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiI0XsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 19:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiI0XsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 19:48:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449571B349C;
        Tue, 27 Sep 2022 16:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0010DB81E34;
        Tue, 27 Sep 2022 23:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97460C433D6;
        Tue, 27 Sep 2022 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664322476;
        bh=zu8DhpREBxnDbXHPKtFL4jUKQOyG5JcebqzNX6Tenm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MOlI3JUxeVWF2QXGdc01RE6z3qlVfDvOfDP8VejyhCVCNgjG69H7v79chXSvMynKT
         szeKFD6I4MCCwO82ncuimmWIAd8hfY3kpoQVjFfMeQ5hREknO/hA7Ty6FnSXMunX04
         yuBB+MueV89oC4ofJVoh2Nx4m8qQxDRQhXAcj6rA5mebMYgQtA2/fSY7iLR4C1uSNb
         Q1oNI+XgZxk0XdtHo3fmWD6tocUWtEFT8UMx8jZ8jhG6ywZeIzwWadmN5vptlRXLe3
         jGXqi8hYbVA9cTkgOG7VUovJ0sAXkbfNiagNUqm+UOxLtZU3jZDCbQUK25IbarN3ZI
         eHzMHzAb2Otig==
Date:   Tue, 27 Sep 2022 18:47:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     bhelgaas@google.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, darren@os.amperecomputing.com,
        corbet@lwn.net, yangyicong@hisilicon.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: update the links for aer-inject git tree
Message-ID: <20220927234755.GA1750512@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805105238.345599-1-shijie@os.amperecomputing.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 05, 2022 at 10:52:38AM +0000, Huang Shijie wrote:
> The aer-inject tree has been moved to:
>     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> Update the links.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v1 --> v2: Modified the commit message and the title.
> v2 --> v3: Change the commit message again.
> ---
>  Documentation/PCI/pcieaer-howto.rst | 2 +-
>  drivers/pci/pcie/Kconfig            | 2 +-
>  drivers/pci/pcie/aer_inject.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..b31fc9a0edbc 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -294,7 +294,7 @@ After reboot with new kernel or insert the module, a device file named
>  Then, you need a user space tool named aer-inject, which can be gotten
>  from:
>  
> -    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> +    https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/

I don't get it.  Both links work fine for me.  Do the cgit links
redirect to pub/scm, but cgit is deprecated?  I'm happy to apply if
that's the case, but I'd like a pointer to the reason for the change,
e.g., email that says cgit is being deprecated.

Bjorn
