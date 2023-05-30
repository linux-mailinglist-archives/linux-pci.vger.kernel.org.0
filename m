Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F138A716ACD
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 19:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjE3RYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 13:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjE3RXl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 13:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA47171F;
        Tue, 30 May 2023 10:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BEFC63114;
        Tue, 30 May 2023 17:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E8C4339B;
        Tue, 30 May 2023 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467363;
        bh=fDJgY69hwhL+3CR1eSDi7/Wi+6ZsYK6idV3Bjue83t4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AsG5JlLrY2cX845sSfS5azR6HQlCeFCiUku4z/OI1kmprAYseS23AbN8f98Fi3rmd
         BA5ktDXruURv3Z6Sj+PwOCi77xwz8oDiQ9RRjbK0eW43FCaIb9nuhxtJkBYBcF7vUx
         YkhX0ew6QPMf4muutU04vUK13p55mqmaogiwV8NngHd19MzL5J1bNtZeOY1pcUQD89
         zjoLp7ouFi8Y+Z+1ac+s5gDXOlx03/oPKhf2ifkC7WldqVKoVdi2aekuaz3m+++IhM
         01gfSG/NnM4S7lqg9W54Ay/DL93i+9E/51uGOkDGkQlGHbGJikAPmsClSl/8L6KNFd
         06bnLO8U5F/EQ==
Date:   Tue, 30 May 2023 12:22:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3] PCI: Add suspend fixup for SSD on sc7280
Message-ID: <ZHYw4mQ5I3y2XibL@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530102613.v3.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Manivannan]

On Tue, May 30, 2023 at 10:26:29AM +0800, Owen Yang wrote:
> Implement this workaround to correct NVMe suspend process.
> 
> SSD will randomly crashed at 100~250+ suspend/resume cycle. Phison and
> Qualcomm found that its due to NVMe entering D3cold instead of L1ss.
> https://partnerissuetracker.corp.google.com/issues/275663637
> 
> According to Qualcomm. This issue has been found last year and they have
> attempt to submit some patches to fix the pci suspend behavior.
> (ref:https://patchwork.kernel.org/project/linux-arm-msm/list/?
> series=665060&state=%2A&archive=both).
> But somehow these patches were rejected because of its complexity. And
> we've got advise from Google that it will be more efficient that we
> implement a quirks to fix this issue.
> 
> The DECLARE_PCI_FIXUP_SUSPEND function has already specify the PCI device
> ID. And this SSD will only be used at our Chromebook device only.

I'll wait for your response to Manivannan:
https://lore.kernel.org/r/20230529164856.GE5633@thinkpad

If the issue is caused by an out-of-tree patch, this fix needs to stay
with that patch.  If the issue doesn't happen with the current
upstream kernel, this patch isn't relevant for upstream.

> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
> Changes in v3:
> - Adjust comment about issue behavior, ASPM, and the sc7280 connection.
> - Fix multi-line code comment.
> 
> Changes in v2:
> - Fix subject line style from "drivers: pci: quirks:" to "PCI:"
> - Adjust comment.
> 
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f4e2a88729fd..6d895a4da4b5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5945,6 +5945,21 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
>  
> +/* 
> + * In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD will enter
> + * D3cold instead of L1ss.It cause the device will randomly crash after
> + * suspend within 100~250+ cycles of suspend/resume test.
> + *
> + * After adding this fixup.We've verified that 10 devices passed
> + * the suspend/resume 2500 cycles test.
> + */
> +static void phison_suspend_fixup(struct pci_dev *pdev)
> +{
> +	msleep(30);
> +}
> +DECLARE_PCI_FIXUP_SUSPEND(0x1987, 0x5013, phison_suspend_fixup);
> +DECLARE_PCI_FIXUP_SUSPEND(0x1987, 0x5015, phison_suspend_fixup);
> +
>  static void rom_bar_overlap_defect(struct pci_dev *dev)
>  {
>  	pci_info(dev, "working around ROM BAR overlap defect\n");
> -- 
> 2.17.1
> 
