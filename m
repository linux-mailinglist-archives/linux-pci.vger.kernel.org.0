Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96BE697D21
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 14:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjBONZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 08:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjBONZB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 08:25:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B5331E37
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 05:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 522B361B6B
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 13:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F900C433EF;
        Wed, 15 Feb 2023 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676467474;
        bh=6fnE0TBCtFaEXmn9Caf119uGHoUY4UB3VWkbQUraWYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVqOClWCAigfwaEVxb4YCesgX1qgmVGesI2jh4vUfAkPt2AtSqL0T899CwBQmRqog
         n7Xw/vnG8L9wRRyB+NaKs6BzAoWDIdF2SC9amk4nTGYB60QahueTzVWXqA2eLYtQ6/
         LphIJott8I4ckhI+ZN4SqswOKs+WXmK4ZpX7BeDA=
Date:   Wed, 15 Feb 2023 14:24:31 +0100
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
Message-ID: <Y+zdD8G0NJIdiClo@kroah.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
 <Y+zDUmwj8+ibp3r0@kroah.com>
 <e71ad0dc-2250-7ffc-6d96-745e2da40694@opensource.wdc.com>
 <Y+zJqp9cXelKro6t@kroah.com>
 <077adda6-ef9f-5c31-c041-97342317f1d2@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077adda6-ef9f-5c31-c041-97342317f1d2@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 09:18:48PM +0900, Damien Le Moal wrote:
> On 2/15/23 21:01, Greg Kroah-Hartman wrote:
> > On Wed, Feb 15, 2023 at 08:45:50PM +0900, Damien Le Moal wrote:
> >> On 2/15/23 20:34, Greg Kroah-Hartman wrote:
> >>> On Wed, Feb 15, 2023 at 12:21:50PM +0900, Damien Le Moal wrote:
> >>>> Make the pci-epf-test driver more verbose with dynamic debug messages
> >>>> using dev_dbg(). Also add some dev_err() error messages to help
> >>>> troubleshoot issues.
> >>>>
> >>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >>>> ---
> >>>>  drivers/pci/endpoint/functions/pci-epf-test.c | 69 +++++++++++++++----
> >>>>  1 file changed, 56 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> >>>> index f630393e8208..9b791f4a7ffb 100644
> >>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> >>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> >>>> @@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
> >>>>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >>>>  	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> >>>
> >>> note, volatile is almost always wrong, please fix that up.
> >>
> >> OK. Will think of something else.
> > 
> > If this is io memory, use the proper accessors to access it.  If it is
> > not io memory, then why is it marked volatile at all?
> 
> This is a PCI bar memory. So I can simply copy the structure locally with
> memcpy_fromio() and memcpy_toio().

Great, please do so instead of trying to access it directly like this,
which will break on some platforms.

thanks,

greg k-h
