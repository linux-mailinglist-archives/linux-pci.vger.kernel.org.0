Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D596F352A
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjEARon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjEARon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 13:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCD1A4
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 10:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950B160FE8
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 17:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C03C433EF;
        Mon,  1 May 2023 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682963081;
        bh=l45KaNKEwM2WOBlw6nXGgjqSL+qfWU5VYRYg9+gW3ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kdlcjbsIDVv7N7bPToLfa6MOCynQqq1bQW71egJkXWns/e4L6/IiAapLj8xOrdzin
         fzUabicOyQHnlW/wq42fAkhxaxFOvvUiuXWNmMMF4vtuZOris6wtSc2vhVzfhaYLTo
         YERC63OngUjurI45XLBV7tkUJZK/DeP3iL3b9mvwDMlgVNstk0NXqpRqi5AuX+xzrD
         NaM3T1Yt36GFyV4SU6RTTZPoS/AH9iz60aEUeHJOTbxYYGahO41KxMcsLMJmfKCXXs
         r9Gan7nB3+liiov2ckYqJNJGi7u7e380/fV2YTdUDS6Wg8D3VIkQYonJeHx45GpA9G
         Yqn4dP8JtcNsg==
Date:   Mon, 1 May 2023 12:44:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH 2/3] PCI/ASPM: Set ASPM_STATE_L1 when class driver
 enables L1ss
Message-ID: <20230501174439.GA592767@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411111034.1473044-3-ajayagarwal@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Nirmal, Jonathan, since vmd is the only caller of
pci_enable_link_state()]

On Tue, Apr 11, 2023 at 04:40:33PM +0530, Ajay Agarwal wrote:
> Currently the aspm driver does not set ASPM_STATE_L1 bit in
> aspm_default when the class driver requests L1SS ASPM state.
> This will lead to pcie_config_aspm_link() not enabling the
> requested L1SS state. Set ASPM_STATE_L1 when class driver
> enables L1ss.

Since vmd is currently the only caller of pci_enable_link_state(), and
it supplies PCIE_LINK_STATE_ALL:

  #define PCIE_LINK_STATE_ALL (PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
                               PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
                               PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
                               PCIE_LINK_STATE_L1_2_PCIPM)

I don't think this makes any functional difference at this point,
right?

> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5765b226102a..7c9935f331f1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1170,16 +1170,16 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_default |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> -		/* L1 PM substates require L1 */
> -		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
> +		link->aspm_default |= ASPM_STATE_L1;
> +	/* L1 PM substates require L1 */
>  	if (state & PCIE_LINK_STATE_L1_1)
> -		link->aspm_default |= ASPM_STATE_L1_1;
> +		link->aspm_default |= ASPM_STATE_L1_1 | ASPM_STATE_L1;

IIUC, this:

  pci_enable_link_state(PCIE_LINK_STATE_L1_1)

currently doesn't actually enable L1.1 because the caller didn't
supply "PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1".

I'm not sure that's a problem -- the driver can easily supply both if
it wants both.

For devices that support only L1,
"pci_enable_link_state(PCIE_LINK_STATE_L1_1)" would implicitly enable
L1 even though L1.1 is not supported, which seems a little bit weird.

>  	if (state & PCIE_LINK_STATE_L1_2)
> -		link->aspm_default |= ASPM_STATE_L1_2;
> +		link->aspm_default |= ASPM_STATE_L1_2 | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> -		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
> +		link->aspm_default |= ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1;
>  	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> -		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
> +		link->aspm_default |= ASPM_STATE_L1_2_PCIPM | ASPM_STATE_L1;
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> -- 
> 2.40.0.577.gac1e443424-goog
> 
