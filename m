Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F25EC0C0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiI0LO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiI0LOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 07:14:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0857565807
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 04:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44DEDB81B1B
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 11:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EDC433C1;
        Tue, 27 Sep 2022 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277241;
        bh=lVYuYBHbpOk4XfSOSXHqxiv9KB8vmVBtkER0Cdob1AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLw06jM8ypiZdZZtN3gvYM4ujPaUpcDm/f03uYUfD/p1X8A6h/MkJeriHEQuh/Sxz
         MJYKfCM25d7y3S6OCOW81VqV/wfunTwLCDJrp2oP9YapVt2XeZ+tlclp9wqPmmDhmK
         LT3PXaxKm3pNKMUL1kBoKKI9tts5nNRzBKPeT3Y8G1850FQssrLPJ1mBNawZ4aT2WF
         BGgZhmI0Jy3zE5yP2mY40ZjHBqW1qSfKl25voKyVg1GNfpoUACbpg4UjRBytpMBjeG
         DVelcN6ccwIqm9OXCOIBDFHFq/7SK/KNSTAK/dcfl19XYoDev6yGNVd1jT3joeKU/r
         b6qi4sU/6gn8A==
Received: by pali.im (Postfix)
        id E6843795; Tue, 27 Sep 2022 13:13:57 +0200 (CEST)
Date:   Tue, 27 Sep 2022 13:13:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <20220927111357.wctpynl6lmr5ei3a@pali>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-4-kabel@kernel.org>
 <YxtUR0+dBZut8QZH@lpieralisi>
 <20220916182302.4eba1b48@dellmb>
 <YzK0Zo6+5OoVwirK@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzK0Zo6+5OoVwirK@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello! Just briefly from my side, but Marek would probably answer it
better.

On Tuesday 27 September 2022 10:29:26 Lorenzo Pieralisi wrote:
> Better, certainly. Question, also related to Marc's query. Do you
> rely on the hotplug (emulated IRQ) to be run _before_ carrying on
> with PCI config space accesses following a link-up detection ?

During PCI config space access is PCI core code holding atomic raw spin
lock, so link-up check from PCI config space can throw emulated HP IRQ
only _after_ config space is finished (when IRQs are unmasked again). So
it happens after (not before).

> How was the jiffies + 1 expiration time determined ?

jiffies + 1 was chosen as the earliest possible time when HP IRQ can be
thrown. Somebody said to me (year or more ago, no remember who and
when) that I cannot use just "jiffies", I have to use "jiffies + 1", so
timer would be scheduled after my call finish, which is after PCI config
space access finish. jiffies + 1 should be the earliest possible time
with the highest priority.

> I assume you
> want to run the emulated HP IRQ asap - the question though is
> how fast should it be ?

HP IRQ should be thrown _ASAP_ when we know that link is up, so PCIe HP
driver can handle it and do its job. Just like for hardware which fully
and correctly supports link up HP IRQs.
