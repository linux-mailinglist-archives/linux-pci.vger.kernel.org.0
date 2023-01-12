Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE11667E75
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 19:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjALSz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 13:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjALSz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 13:55:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC3287912;
        Thu, 12 Jan 2023 10:25:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593DA6213B;
        Thu, 12 Jan 2023 18:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867E5C433EF;
        Thu, 12 Jan 2023 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673547923;
        bh=7E80cFZGxF2ybWEYKWVeToLIO7ZFtLVaNaJj6DWrgtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rXcTrjNcq6AOHbgz725RLARmoWDfgUQOF4mZ1FavcoZeG+r/Ahb5BWnkvg2lrlD3M
         xW/H2kQi+QifH3v7qlvSknWQs1ONJh/b3qZBjYPdekHFJplvzPuNm8a4fDBQWWWZBV
         268pM833VrVzCS7stzhlbIvrmpsl9jgQhfq5Hjej0QtR/d1i+pyra6v4dvtncnGvim
         12K9MDJKrqZ3+PWgeFHalHjtXjPA13RymwPO7QbnLvioyAJl4hx5J23sMiZJJdP8hA
         xgdn6KKmmY9w6/2Xl+bhh5eHM4fr8CRZ4ED9TTI5o3QUXh+aX/0heczhPxd/N8B28U
         RU0MXGL4cPOHQ==
Date:   Thu, 12 Jan 2023 12:25:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        treding@nvidia.com, jonathanh@nvidia.com, mmaddireddy@nvidia.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vsethi@nvidia.com,
        linuxppc-dev@lists.ozlabs.org, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI/AER: Configure ECRC only AER is native
Message-ID: <20230112182522.GA1778254@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112072111.20063-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 12:51:11PM +0530, Vidya Sagar wrote:
> As the ECRC configuration bits are part of AER registers, configure
> ECRC only if AER is natively owned by the kernel.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Applied to pci/aer for v6.3, thanks!

> ---
> v2:
> * Updated kernel-parameters.txt document based on Bjorn's suggestion
> 
>  Documentation/admin-guide/kernel-parameters.txt | 4 +++-
>  drivers/pci/pcie/aer.c                          | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 426fa892d311..8f85a1230525 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4242,7 +4242,9 @@
>  				specified, e.g., 12@pci:8086:9c22:103c:198f
>  				for 4096-byte alignment.
>  		ecrc=		Enable/disable PCIe ECRC (transaction layer
> -				end-to-end CRC checking).
> +				end-to-end CRC checking). Only effective if
> +				OS has native AER control (either granted by
> +				ACPI _OSC or forced via "pcie_ports=native")
>  				bios: Use BIOS/firmware settings. This is the
>  				the default.
>  				off: Turn ECRC off
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e2d8a74f83c3..730b47bdcdef 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -184,6 +184,9 @@ static int disable_ecrc_checking(struct pci_dev *dev)
>   */
>  void pcie_set_ecrc_checking(struct pci_dev *dev)
>  {
> +	if (!pcie_aer_is_native(dev))
> +		return;
> +
>  	switch (ecrc_policy) {
>  	case ECRC_POLICY_DEFAULT:
>  		return;
> -- 
> 2.17.1
> 
