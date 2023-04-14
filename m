Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F026E2830
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDNQRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNQRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE81CA
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE06864901
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16284C433EF;
        Fri, 14 Apr 2023 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681489030;
        bh=EPqed3WD54+nkojq22/wiKyatqiQsaDtlNVRCIdIBNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pm+VtlYWxYnA7fzcAM1QF4A0CL/FF1z0J7lzjWFsStcIJQ+KDIWNCdPz1bJ6Wan3+
         zoHmnNoHP9N3SmsNTF34S3JpKaUgFYUSn3IDgh5BiONkcTmZnWgF06Lp2j+XPU6A+M
         miXed46PzJWo3+oN0G6/U9HDeCqMZ+asIyuf57sdJCjiC3PPA4rIP3ZL1FKaOcXij2
         9g2d9UfMKCZ2jBSC9YU50s7QsCaKTqx0I7OdF/tzwN6o6P2dIc36cxSLFkeaiftt+M
         jZTW6ac5BNIZYULII5JI/skTgDVT9tbnbCIEMr3HxcW8IAHuw5JwplJHWmsk5yO2AL
         K1DBgagu8v++w==
Date:   Fri, 14 Apr 2023 11:17:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 13/17] PCI: epf-test: Simplify transfers result print
Message-ID: <20230414161708.GA198332@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-14-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:53PM +0900, Damien Le Moal wrote:
> In pci_epf_test_print_rate(), instead of open coding a reduction loop to
> allow for a division by a 32-bits ns value, simply use div64_u64() to
> calculate the transfer rate. To match the printed unit of KB/s, this
> calculation divides the rate by 1000 instead of 1024 (that would be
> KiB/s unit).
> 
> The format of the results printed by pci_epf_test_print_rate() is also
> changed to be more compact without the double new line. dev_info() is
> used instead of pr_info().

"Change the format ...  Use dev_info() instead of ..."

I know I'm a little OCD about this.  More detail:
https://cbea.ms/git-commit/#imperative
