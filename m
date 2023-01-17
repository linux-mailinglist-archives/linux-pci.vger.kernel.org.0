Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9866D6BE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 08:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjAQHOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 02:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjAQHOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 02:14:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9005C2196C
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 23:14:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0917567373; Tue, 17 Jan 2023 08:14:01 +0100 (CET)
Date:   Tue, 17 Jan 2023 08:14:00 +0100
From:   "'hch@lst.de'" <hch@lst.de>
To:     Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "'hch@lst.de'" <hch@lst.de>
Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for
 SN730 WD SSD
Message-ID: <20230117071400.GA15364@lst.de>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com> <DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
> 
> A bug was found in SN730 WD SSD that causes occasional false AER reporting
> of correctable errors. While functionally harmless, this causes error
> messages to appear in the system log (dmesg) which, in turn, causes
> problems in automated platform validation tests. Since the issue can not
> be fixed by FW, customers asked for correctable error reporting to be
> quirked out in the kernel for this particular device.
> 
> The patch was manually verified. It was checked that correctable errors
> are still detected but ignored for the target device (SN730), and are both
> detected and reported for devices not affected by this quirk.
> 
> Signed-off-by: Alexey Bogoslavsky mailto:alexey.bogoslavsky@wdc.com
> ---
>  drivers/pci/pcie/aer.c  | 3 +++
>  drivers/pci/quirks.c    | 6 ++++++
>  include/linux/pci.h     | 1 +
>  include/linux/pci_ids.h | 4 ++++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d7ee79d7b192..5cc24d28b76d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -721,6 +721,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  		goto out;
>  	}
>  
> +	if ((info->severity == AER_CORRECTABLE) && dev->ignore_correctable_errors)

No need for the inner braces.

> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WESTERN_DIGITAL, PCI_DEVICE_ID_WESTERN_DIGITAL_SN730, wd_ignore_correctable_errors);

Overly long line.  Also wd_ seems like an odd prefix, I'd do pci_
instead.

But overall I'm not really sure it's worth adding code just to surpress
a harmless warning.
