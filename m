Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDEE714EB1
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjE2QtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE2QtQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 12:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4DAD;
        Mon, 29 May 2023 09:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3D261EF6;
        Mon, 29 May 2023 16:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA260C433D2;
        Mon, 29 May 2023 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685378954;
        bh=wnzcITc/ykHWp69sIWEQPsoi76/Mz+ZrxV5hFCoG58A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3+68QinoA9FQ9tljy4B70D1mL6G2DCblWTUU0TxwmL827g808lr74VKpDBbCPC9c
         Hq8cvTyWQwzdiVULZdMdu+61weGDIaWl2GRI2EAca2Tfhg0yQ4cxGVxJahwB+5ljhY
         2uaqDR0P2QM8Jlvhz3DFetaPg9uC+Ke58lqJh0+Jlsyvd9Q48SpImZKROv1QuOlWnK
         jRopqMpdhG+CUgioUiXbdNq7GHNZVgEEGLQVo6EollOu3vN2eQycH7UpHUMWPHCZZn
         FZUlPMWzear7OxZYSOlRZK+gc21ejFJK/1Ek+GE8rfSBlbMst/pZw3c/NSzcI1qs2g
         hIbwi22mMOoFg==
Date:   Mon, 29 May 2023 22:18:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
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
Message-ID: <20230529164856.GE5633@thinkpad>
References: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> 
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

What is there to fix during suspend? Currently, Qcom PCIe driver just votes for
low interconnect bandwidth and keeps the resources (clocks, regulators) ON
during suspend. So there is no way the device would move to D3Cold.

Earlier Qcom reported that during suspend, link down event happens when the
resources are turned OFF without waiting for the link to enter L1ss. But as I
said above, we are _not_ turning OFF any resources.

I believe this patch is addressing an issue that is caused by an out-of-tree
patch.

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்
