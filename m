Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FC711A01
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbjEYWKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjEYWKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 18:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D3C12F;
        Thu, 25 May 2023 15:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A109D64B8D;
        Thu, 25 May 2023 22:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D109CC433D2;
        Thu, 25 May 2023 22:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685052633;
        bh=GICPxmeMSLHJJ2bS0drEJtpZ8BdqsvczeM+s9pyEXR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ObXl45XugUdH+acc1ChFRJxlBJT11kmUi30HaoOtvZAX6uhkh0XzGrAvL+7Q0OTbf
         Jrss0NqKDneQSsVAersnFSGMbwt0aGQnX7Ns5dYDwzacOEGw7+OBdogccAwn1fhj3r
         XMP6JJdEIeYF9jsfNSqHkJsjG6EV/IHLb4OAgv/2XYQbUqheBr2giAp4ThrCo3JgGk
         2H1xfSavlCdAW4U02FCdX9G3sr1GoSE8RzJGxSsYBaoEh9TX+wpCjCCRM0XjEQiI6W
         6qql+YjuW8CkA9ZOCcrXppEW6KhzwMEJ4YwcdVtcyEP5AZWJZ7pkZl4f43TtRLHdVA
         q1YGxj76k5fuA==
Date:   Thu, 25 May 2023 17:10:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] drivers: pci: quirks: Add suspend fixup for SSD on
 sc7280
Message-ID: <ZG/c1+/mCp/PfFSO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 25, 2023 at 04:35:12PM +0800, Owen Yang wrote:
> Implement this workaround until Qualcomm fixed the
>  correct NVMe suspend process.

Thanks for the patch.  Before I can do anything, this needs:

  - Subject line in style of the file (use "git log --oneline
    drivers/pci/quirks.c").

  - Format commit log correctly (fill 75 columns, no leading spaces).

  - Description of incorrect behavior.  What does the user see?  If
    there's a bug report, include a link to it.

  - Multi-line code comments in style of the file (look at existing
    comments in the file).

  - Details of "the correct ASPM state".  ASPM may be enabled or
    disabled by the user, so you can't assume any particular ASPM
    configuration.

  - Details on the Qualcomm sc7280 connection.  This quirk would
    affect Phison SSDs on *all* platforms, not just sc7280.  I don't
    want to slow down suspend on all platforms just for a sc7280
    issue.

  - Drop the "until Qualcomm fixes NVMe suspend" text.  Even if
    Qualcomm fixes something, we can't just drop this quirk because
    there will be platforms in the field that don't have the Qualcomm
    fix.

Bjorn

> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f4e2a88729fd..b57876dc2624 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5945,6 +5945,16 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
>  
> +/* In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD won't enter
> + * the correct ASPM state properly. Therefore. Implement this workaround
> + * until Qualcomm fixed the correct NVMe suspend process*/
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
