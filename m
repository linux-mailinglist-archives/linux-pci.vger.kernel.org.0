Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1727573C81
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 20:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGMS25 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGMS24 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 14:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6271116C;
        Wed, 13 Jul 2022 11:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC7261D90;
        Wed, 13 Jul 2022 18:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F05C34114;
        Wed, 13 Jul 2022 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657736935;
        bh=WvV3WldDe1f1LghaQOrfJG/QtY0fIbOeTNpt6zJ0Gqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sb9+oLr/wAAxKp7cFxgoMvjpYNovqENtr+XZv/LO+r2Iqza//3PrgBEwNC6o4HoEb
         Rrqu4c+OJRpYHjFP33ryL7Nt4zC2RnaVP3aMzoYXP8VMMBgIzv5B46ce218Jf3YRDx
         XmJpDI/+DoRq1VnRWNn2M1C0y6PcOfdgfGV0Vsx8d6SaSTlINOqbR6VONbLGmvWK30
         GsvDbKAIRKX/Xykj9U/fqsTcDECeVC2lg92crZa5Wki4SkauXotiK3umUOfg+3U5YZ
         35F2N/zTxqnZ5V95x02LBGHCnDeeGCdxUSaJcV1qcdrGu4YNHICIbNlwlP+fc4rRGW
         eq1OiDVHnvgsA==
Date:   Wed, 13 Jul 2022 13:28:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manyi Li <limanyi@uniontech.com>
Cc:     bhelgaas@google.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220713182852.GA841582@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713112612.6935-1-limanyi@uniontech.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kai-Heng, Vidya, who also have ASPM patches in flight]

On Wed, Jul 13, 2022 at 07:26:12PM +0800, Manyi Li wrote:
> Startup log of ASUSTeK X456UJ Notebook show:
> [    0.130563] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [   48.092472] pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [   48.092479] pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> [   48.092481] pcieport 0000:00:1c.5:    [ 0] RxErr
> [   48.092490] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> [   48.092504] pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> [   48.092506] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5

Can you elaborate on the connection between the FADT ASPM bit and the
AER logs above?

What problem are we solving here?  A single corrected error being
logged?  An infinite stream of errors?  A device that doesn't work at
all?

We don't need the dmesg timestamps unless they contribute to
understanding the problem.  I don't think they do in this case.

> Signed-off-by: Manyi Li <limanyi@uniontech.com>
> ---
>  drivers/pci/pcie/aspm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc..b173d3c75ae7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1359,6 +1359,7 @@ void pcie_no_aspm(void)
>  	if (!aspm_force) {
>  		aspm_policy = POLICY_DEFAULT;
>  		aspm_disabled = 1;
> +		aspm_support_enabled = false;

This makes pcie_no_aspm() work the same as booting with
"pcie_aspm=off".  That might be reasonable.

I do wonder why we need both "aspm_disabled" and
"aspm_support_enabled".  And I wonder why we need to set "aspm_policy"
when we're disabling ASPM.  But those aren't really connected to your
change here.

>  	}
>  }
>  
> -- 
> 2.20.1
> 
> 
> 
