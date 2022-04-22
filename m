Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29150C2C8
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiDVW76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiDVW7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7015CF49;
        Fri, 22 Apr 2022 15:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EAC961F77;
        Fri, 22 Apr 2022 22:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7EC385A0;
        Fri, 22 Apr 2022 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650666275;
        bh=JpCuibTDnOetl+PLrbkZUpdEWAAZR0B2yf5RKC+PzJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sM6SdleQJ3yL55lXpYxCTJl6NBwHVOz54NGi3BcQe4xYtDpylu+BJWVyB511FDlaz
         yHyf/Qf2XpuQtmurpDr0VLxOUqQiJpgRRYOnaxXW3ptcS1PRmkntJzzaUZNZywmiEo
         LfKyrtqnEUZHjQMdPmlRYcuipPXm5vM6B9yxmM/xC5Gt9si7hHUV06IRKFYuShCRU1
         HR9NGtEuLu15niZJ4AFAa9Wgur9EOGCvx8x+xUKhVlA9T4gZiHttPZIDqmN+7s0M+4
         C96KZWIhH2v+IWe1YLbkyKEjOP4ZcACghEcLtEDnXC6AJWC1bnqlLTWeGB68RUEqiO
         X6SQZbAHxxK5Q==
Date:   Fri, 22 Apr 2022 17:24:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, baolu.lu@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        david.e.box@linux.intel.com
Subject: Re: [PATCH v4 1/2] PCI/AER: Disable AER service when link is in
 L2/L3 ready, L2 and L3 state
Message-ID: <20220422222433.GA1464120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408153159.106741-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rajvi, David]

On Fri, Apr 08, 2022 at 11:31:58PM +0800, Kai-Heng Feng wrote:
> On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> some errors reported by AER:
> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> 
> So disable AER service to avoid the noises from turning power rails
> on/off when the device is in low power states (D3hot and D3cold), as
> PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> (D3hot), L2 (D3cold with aux power) and L3 (D3cold).

Help me walk through what's happening here, because I'm never very
confident about how error reporting works.  I *think* the Unsupported
Request error means some request was in progress and was not
completed.  I don't think a link going down should by itself cause
an Unsupported Request error because there's no *request*.

I have a theory about what happened here.  Decoding the TLP Header
(from PCIe r6.0, sec 2.2.1.1, 2.2.8.10) gives:

  34000000 (0011 0100 ...):
    Fmt               001        4 DW header, no data
    Type           1 0100        Msg, Local - Terminate at Receiver

  08000052 (0800 ... 0101 0010)
    Requester ID     0800        00:08.0
    Message Code     0101 0010   PTM Request

From your lspci in bugzilla, 08:00 has PTM enabled.  So my theory is
that:

  - 08:00.0 sent a PTM Request Message (a Posted Request)
  - 00:1d.0 received the PTM Request Message
  - The link transitioned to DL_Down
  - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
    Unsupported Request
  - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
    own PTM Enable was clear, it would also be treated as an
    Unsupported Request

So I suspect we should disable PTM on 08:00.0 before putting it in a
low-power state.  If you manually disable PTM on 08:00.0, do these
errors stop happening?

David did something like this [1], but just for Root Ports.  That
looks wrong to me because sec 6.21.3 says we should not have PTM
enabled in an Upstream Port (i.e., in a downstream device like
08:00.0) unless it is already enabled in the Downstream Port (i.e., in
the Root Port 00:1d.0).

Nit: can you remove the timestamps from the log?  They add clutter but
no useful information.

[1] https://git.kernel.org/linus/a697f072f5da

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4:
>  - Explicitly states the spec version.
>  - Wording change. 
> 
> v3:
>  - Remove reference to ACS.
>  - Wording change.
> 
> v2:
>  - Wording change.
> 
>  drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b270..e4e9d4a3098d7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int aer_suspend(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +
> +	aer_disable_rootport(rpc);
> +	return 0;
> +}
> +
> +static int aer_resume(struct pcie_device *dev)
> +{
> +	struct aer_rpc *rpc = get_service_data(dev);
> +
> +	aer_enable_rootport(rpc);
> +	return 0;
> +}
> +
>  /**
>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>   * @dev: pointer to Root Port, RCEC, or RCiEP
> @@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  }
>  
>  static struct pcie_port_service_driver aerdriver = {
> -	.name		= "aer",
> -	.port_type	= PCIE_ANY_PORT,
> -	.service	= PCIE_PORT_SERVICE_AER,
> -
> -	.probe		= aer_probe,
> -	.remove		= aer_remove,
> +	.name			= "aer",
> +	.port_type		= PCIE_ANY_PORT,
> +	.service		= PCIE_PORT_SERVICE_AER,
> +	.probe			= aer_probe,
> +	.suspend		= aer_suspend,
> +	.resume			= aer_resume,
> +	.runtime_suspend	= aer_suspend,
> +	.runtime_resume		= aer_resume,
> +	.remove			= aer_remove,
>  };
>  
>  /**
> -- 
> 2.34.1
> 
