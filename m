Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB16B5520D9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiFTP1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiFTP1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 11:27:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07531198;
        Mon, 20 Jun 2022 08:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 880EEB81210;
        Mon, 20 Jun 2022 15:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CACFC3411B;
        Mon, 20 Jun 2022 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655738852;
        bh=C160ci2Jg/MpBwPywHpQUs6DyohwjJWURvf3+rO7Gk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1HGH3mQcRoX+mNi/4tHHGxCNMQ1nHYEjBZhMp+Do+RBgGPC8+bAYHo8/U6E3ClmS
         SA69tjtH53L5ejhbO4yMOO4CX6o7+fMy9IZlUPoka4dgkstqmWWZWZlO03Kmp1Wyla
         +t1ZBl8LLLWsjmtK9K5fQzlyNVkq4NM4Vi4TVnSaOpsjc2zcFm8FCcNSNFTkhaZf3l
         smZjMh+TWQwRwy3HSqgwIbne/OvyfMUSZrpoPT2xsOJWBeMNTJoa8r+7MuSxK2w7Rb
         rzUszD5a81ct93P5Ax80i2Y/bMoMpbx29RBcOhIHHDwEhlm9ZLhbAzkZJFOfqgB6Tx
         9l62jW8mbiO0A==
Date:   Mon, 20 Jun 2022 09:27:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leo Savernik <l.savernik@aon.at>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216147] New: NVMe quirk needed
 for multiple Micron MTFDKBA2T0TFH SSDs]
Message-ID: <YrCR4Bjcto09kJyQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20220619132039.GA1243474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619132039.GA1243474@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 19, 2022 at 08:20:39AM -0500, Bjorn Helgaas wrote:
> The proposed patch itself (also see attachment):
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b925a5f4afc3..2e5c33f3b868 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] = {
> NVME_QUIRK_128_BYTES_SQES |
>                                 NVME_QUIRK_NO_DEEPEST_PS |
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +       { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
> +               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
>         { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>         { 0, }
>  };

Coould you send this as an actual patch to the mailing list so we can include
it in the next pull request?
