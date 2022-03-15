Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302C4D9526
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 08:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbiCOHXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiCOHXs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 03:23:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9A14AE3A;
        Tue, 15 Mar 2022 00:22:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A15DB68AFE; Tue, 15 Mar 2022 08:22:33 +0100 (CET)
Date:   Tue, 15 Mar 2022 08:22:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Patrick Huang <patrick.huang@amd.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Disable LTR for simple suspend
Message-ID: <20220315072233.GA2288@lst.de>
References: <20220314135537.1565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314135537.1565-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 08:55:37AM -0500, Mario Limonciello wrote:
> Some drives from SSSTC are showing stability problems after s0i3
> entry when the Linux kernel is in s2idle loop if LTR has been
> enabled. This leads to failures to resume.
> 
> This appears to be a firmware issue specific to SSSTC SSDs, but to
> avoid this class of problem, disable LTR when going into s2idle and
> simple suspend has been set.

This seems like a giant hammer to do this for all NVMe devices,
why not quirk the specific ones?

> +static void nvme_suspend_ltr(struct device *dev, bool disable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> +
> +	if (disable) {
> +		u16 word;
> +
> +		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &word);
> +		ndev->restore_ltr = word & PCI_EXP_DEVCTL2_LTR_EN;
> +		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> +					   PCI_EXP_DEVCTL2_LTR_EN);
> +	} else if (ndev->restore_ltr) {
> +		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> +					 PCI_EXP_DEVCTL2_LTR_EN);
> +	}
> +}

The calling conventions of this function are rather strange by
mixing up two very different things.

I think two PCI-level helpers to disable LTR and return the status
it ways in and to enable LTR would be really nice to have here.

>  	if (ndev->last_ps == U32_MAX ||
>  	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
>  		goto reset;
> @@ -3239,6 +3259,11 @@ static int nvme_suspend(struct device *dev)
>  
>  	ndev->last_ps = U32_MAX;
>  
> +	/* If using s2idle with simple suspend, disable LTR to avoid problems. */

Overly long line here.
