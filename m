Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36470697AE5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 12:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBOLez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 06:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjBOLet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 06:34:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C834C37F3A
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 03:34:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7038CB820F6
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 11:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0276C433EF;
        Wed, 15 Feb 2023 11:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676460885;
        bh=HwJgywrUCMPCG1etREZFzA6s6K+qabnemuBDfVhk/sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sU2FD71mfHxOLcZ7SHbXWiHnPJVM98fk1vCM+YueI8nCaPQ7QLX0I/EibKwYHakSr
         4u0+FjYeqwga0hYEL6NSdBRLBTkndJv10rbzejiUBC+7HTocIQ7GL3p7MyJpwTfG0+
         AUHwrzKU/Nf4+x+vmdbat8YQD9JIB9jfJVOfOoeY=
Date:   Wed, 15 Feb 2023 12:34:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/12] pci: epf-test: Add debug and error messages
Message-ID: <Y+zDUmwj8+ibp3r0@kroah.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:50PM +0900, Damien Le Moal wrote:
> Make the pci-epf-test driver more verbose with dynamic debug messages
> using dev_dbg(). Also add some dev_err() error messages to help
> troubleshoot issues.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 69 +++++++++++++++----
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index f630393e8208..9b791f4a7ffb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];

note, volatile is almost always wrong, please fix that up.

thanks,

greg k-h
