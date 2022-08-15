Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6B593C5C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbiHOUNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbiHOULD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 16:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B57A187;
        Mon, 15 Aug 2022 11:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C2F6123D;
        Mon, 15 Aug 2022 18:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B6C433D7;
        Mon, 15 Aug 2022 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660589819;
        bh=K7aRSGfKbZpZCxx9Aa4laIn4DrgTGdCFJK7d2L2MWhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DmNDGire7TyGMXUCep8i6GfVnqI3mDcHMZcpL15d5U+6Q4d2SacM+AqkoLR24WJ3T
         KE//ju1GdArumc4cwAqVQMjWpX4wzH3KoLiGYvk88r3CKo8816FMT05fszVxSg9sjG
         Ja1oCABuMtf5OfwYE2OTb0wXw312wp3PpWK093stbOWoXBZHUMFGGSBpvD0sxOHMZD
         TbHWVifQXU9G40UeuozSQMDq1g6qZ1eCgS7azJsKphwdy7isAvYMPUaadtfLjCN1Qh
         gNAk87lPo+4g7EAkogxkFYzx84Nhz1SgqtfsDRAmkirUQPcR7OabHeW89udXLa9W+V
         qBt6Q9RNU95Dw==
Date:   Mon, 15 Aug 2022 13:56:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manyi Li <limanyi@uniontech.com>
Cc:     bhelgaas@google.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220815185658.GA1960534@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713112612.6935-1-limanyi@uniontech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject line should say what the patch *does*, not what *should*
happen.

On Wed, Jul 13, 2022 at 07:26:12PM +0800, Manyi Li wrote:
> Startup log of ASUSTeK X456UJ Notebook show:
> [    0.130563] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [   48.092472] pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> [   48.092479] pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> [   48.092481] pcieport 0000:00:1c.5:    [ 0] RxErr
> [   48.092490] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> [   48.092504] pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> [   48.092506] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5

No need for timestamps in commit log because they're not relevant to
this issue.  Please use quote style, i.e., blank line before and after
the quote and indent the quote two spaces:

  Startup log of ... shows:

    ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
    ...
    pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)

Can you please open a report at https://bugzilla.kernel.org and attach
the complete dmesg log and the complete "sudo lspci -vv" output before
and after this patch?  Then include the bugzilla URL in the commit
log.

I assume the patch prevents the RxErr from being reported, but I'd
like to know why, or at least have a plausible explanation of how
enabling ASPM might lead to a Receiver Error.

I'd also like to know why the "can't find device of ID00e5" happens.

Since it's not obvious from the patch, mention that "reporting ASPM
support to BIOS" happens via the _OSC Support field.

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
>  	}
>  }
>  
> -- 
> 2.20.1
> 
> 
> 
