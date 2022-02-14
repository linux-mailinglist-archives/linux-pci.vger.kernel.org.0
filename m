Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5D4B5516
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiBNPqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:46:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356013AbiBNPqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:46:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D726D;
        Mon, 14 Feb 2022 07:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B148C61313;
        Mon, 14 Feb 2022 15:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD385C340EB;
        Mon, 14 Feb 2022 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644853590;
        bh=ypkwro1J7DlbYw5w/3uL9p/1TnF6Qdw1cTOGQOtdg1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c0U/vNvgxNlRhTzZnEFFCR9aId6hPQBmgaHLTo+QXeG9M6se3Uo3eBniwaQ5IiqMC
         TqBW6QLwfKfh9+oZArZB9VUlt39D81a5wwq3y6zev029QTe93ZzrvhGkX7JwrXw5tR
         1IgBc+cGCNur3T+1wnnfN2wB4ygvoBqDnEZzJnS074vM6NQuYfTsDmSJyJ+8SKm7FN
         bzVUHj3r7qK3x4Bzp0He4EGuy7mgnIAvs0UD2Z6qxb/+j/X9jDdsL5ztXSSYF8e8GZ
         5cwlpktvcqcYGIXeW1KR22mhuke38YbW7r+LFhiLgggPbMJ9+vnWMOmJ4zZBp1F5hp
         AeN0j8m9ygFig==
Date:   Mon, 14 Feb 2022 09:46:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jan Palus <jpalus@fastmail.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI: mvebu: Fix merge conflicts in commit 91a8d79fc797
Message-ID: <20220214154628.GA8830@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214110228.25825-1-pali@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 12:02:28PM +0100, Pali Rohár wrote:
> Commit 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe
> Root Port via emulated bridge") was incorrectly applied from mailing list
> patch [1] to the linux git repository [2] probably due to resolving merge
> conflicts incorrectly. Fix it now.
> 
> [1] - https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
> [2] - https://git.kernel.org/linus/91a8d79fc797
> 
> Fixes: 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215540
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>

Applied to for-linus for v5.17 with the following commit log, thanks!

commit c49ae619905e ("PCI: mvebu: Fix device enumeration regression")
Author: Pali Rohár <pali@kernel.org>
Date:   Mon Feb 14 12:02:28 2022 +0100

    PCI: mvebu: Fix device enumeration regression

    Jan reported that on Turris Omnia (Armada 385), no PCIe devices were
    detected after upgrading from v5.16.1 to v5.16.3 and identified the cause
    as the backport of 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus
    of PCIe Root Port via emulated bridge"), which appeared in v5.17-rc1.

    91a8d79fc797 was incorrectly applied from mailing list patch [1] to the
    linux git repository [2] probably due to resolving merge conflicts
    incorrectly. Fix it now.

    [1] https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
    [2] https://git.kernel.org/linus/91a8d79fc797

    [bhelgaas: commit log]
    BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215540
    Fixes: 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge")
    Link: https://lore.kernel.org/r/20220214110228.25825-1-pali@kernel.org
    Link: https://lore.kernel.org/r/20220127234917.GA150851@bhelgaas
    Reported-by: Jan Palus <jpalus@fastmail.com>
    Signed-off-by: Pali Rohár <pali@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-mvebu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 71258ea3d35f..f8e82c5e2d87 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1329,7 +1329,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  		 * indirectly via kernel emulated PCI bridge driver.
>  		 */
>  		mvebu_pcie_setup_hw(port);
> -		mvebu_pcie_set_local_dev_nr(port, 0);
> +		mvebu_pcie_set_local_dev_nr(port, 1);
> +		mvebu_pcie_set_local_bus_nr(port, 0);
>  	}
>  
>  	pcie->nports = i;
> -- 
> 2.20.1
> 
