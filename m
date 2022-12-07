Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC718646383
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLGV4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 16:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGV4L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 16:56:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5063D5B;
        Wed,  7 Dec 2022 13:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86B4161BA9;
        Wed,  7 Dec 2022 21:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B46C433C1;
        Wed,  7 Dec 2022 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670450169;
        bh=gEYTNmacgKJxqisPli8O3MFeQnqOQgkhZN0A5c7VPWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eGhUiK/9t1orhE9FKIhT+41yvZiOYWhnOBaN9JfQI43Ai0JJOZiDCRe4y9s+Lhq7Z
         zl0oLhqqS6D/cJnQCYunHG4K4AC/2vX3gtf+fueoN5AxztNEXF/3m5GCse1/SQOmgm
         YjVC/vNjuqVe9cxCRc/Ww/I8iZu7HKfxi65pouwWBYZSD8Rt5gc6nflzENEBdtJoRp
         JbvesL/zFDR8aWfx409blR+hvVO9gtg5HVuuFS+U2onQFuvcqjHrcELlva9PxeE0gV
         r8BkEYXlNy9lmlWz7iK5EpNPntY1XQjJdWhxrJl9uq+oga+HlJ2lYPRqOU0cv8zhF8
         zzKZK57py9tjg==
Date:   Wed, 7 Dec 2022 15:56:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Jan Rueth <rueth@comsys.rwth-aachen.de>
Subject: Re: [PATCH] PCI/ASPM: Call pcie_aspm_sanity_check() as late as
 possible
Message-ID: <20221207215608.GA1471870@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006115950.821736-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jan]

On Thu, Oct 06, 2022 at 01:59:50PM +0200, Stephen Kitt wrote:
> In pcie_aspm_init_link_state(), a number of checks are made to
> determine whether the function should proceed, before the result of
> the call to pcie_aspm_sanity_check() is actually used. The latter
> function doesn't change any state, it only reports a result, so
> calling it later doesn't make any difference to the state of the
> devices or the information we have about them. But having the call
> early reportedly can cause null-pointer dereferences; see
> https://unix.stackexchange.com/q/322337 for one example with
> pcie_aspm=off (this was reported in 2016, but the relevant code hasn't
> changed since then).

Thanks, Stephen!

That stackexchange report doesn't have much information, but it looks
similar to this old report from Jan Rueth, which I'm sorry to say I
never got resolved:

  https://bugzilla.kernel.org/show_bug.cgi?id=187731
  https://lore.kernel.org/all/4cec62c2-218a-672b-8c12-d44e8df56aae@comsys.rwth-aachen.de/#t

And Jan's patch is almost identical to yours :)

I hope to get this resolved, but I don't have time to work on it
before the upcoming merge window, which will probably open Sunday.
And then it's holiday time, so it may be January before I get back to
it.  I'm just dropping the links here as breadcrumbs for picking this
back up.

Bjorn

> This moves the call to pcie_aspm_sanity_check() just before the result
> is actually used, giving all the other checks a chance to run first.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/pci/pcie/aspm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a8aec190986c..38df439568b7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -889,7 +889,7 @@ static void pcie_aspm_update_sysfs_visibility(struct pci_dev *pdev)
>  void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link;
> -	int blacklist = !!pcie_aspm_sanity_check(pdev);
> +	int blacklist;
>  
>  	if (!aspm_support_enabled)
>  		return;
> @@ -923,6 +923,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	 * upstream links also because capable state of them can be
>  	 * update through pcie_aspm_cap_init().
>  	 */
> +	blacklist = !!pcie_aspm_sanity_check(pdev);
>  	pcie_aspm_cap_init(link, blacklist);
>  
>  	/* Setup initial Clock PM state */
> 
> base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
> -- 
> 2.30.2
> 
