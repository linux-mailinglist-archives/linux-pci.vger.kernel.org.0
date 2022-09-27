Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09E5EC8C4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiI0P5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiI0P53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:57:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC604DF10
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 08:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73FBDCE19CE
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 15:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B9EC433C1;
        Tue, 27 Sep 2022 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664294234;
        bh=AP0yvi+xNBHfgk9amxtHM4EwDwHpYgIKDtg3jxHprIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBUS9s/SQi7lULWKftZBuxS2KEdhgwNZsfkNQF3CznWTz/wsIAn2D+KkIK8tYivu7
         RpjQQa3gtXzIMu5SnmqaCQdLlZivOPr32jQ3KHsRJjaM8vOF0qdxgbiQ0pH4779dHe
         w1/58xuOKnj4B+AaaaQ/aVbyutfT2VTVubonhl1VYZDjORbnUUPYC3Hp4tsAUW5eZU
         Vy0j90p7pBzXACliOsQ9AULPjpgjaWb/fSks/NX7NSdd9KijX7SA6VzvLInFuZFXUF
         ie+k+H6/7l9gPpO3oS4Gms3gJ7NpP2KFYOj0MnT9lHSIUAa4dlpMcSBTkEMaKA/BKc
         06E8G37Mu8n3Q==
Date:   Tue, 27 Sep 2022 17:57:09 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/11] PCI: aardvark: Add support for DLLSC and hotplug
 interrupt
Message-ID: <YzMdVb5o6oHmyck9@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-4-kabel@kernel.org>
 <YxtUR0+dBZut8QZH@lpieralisi>
 <20220916182302.4eba1b48@dellmb>
 <YzK0Zo6+5OoVwirK@lpieralisi>
 <20220927111357.wctpynl6lmr5ei3a@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927111357.wctpynl6lmr5ei3a@pali>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 01:13:57PM +0200, Pali Rohár wrote:
> Hello! Just briefly from my side, but Marek would probably answer it
> better.
> 
> On Tuesday 27 September 2022 10:29:26 Lorenzo Pieralisi wrote:
> > Better, certainly. Question, also related to Marc's query. Do you
> > rely on the hotplug (emulated IRQ) to be run _before_ carrying on
> > with PCI config space accesses following a link-up detection ?
> 
> During PCI config space access is PCI core code holding atomic raw spin
> lock, so link-up check from PCI config space can throw emulated HP IRQ
> only _after_ config space is finished (when IRQs are unmasked again). So
> it happens after (not before).
> 
> > How was the jiffies + 1 expiration time determined ?
> 
> jiffies + 1 was chosen as the earliest possible time when HP IRQ can be
> thrown. Somebody said to me (year or more ago, no remember who and
> when) that I cannot use just "jiffies", I have to use "jiffies + 1", so
> timer would be scheduled after my call finish, which is after PCI config
> space access finish. jiffies + 1 should be the earliest possible time
> with the highest priority.
> 
> > I assume you
> > want to run the emulated HP IRQ asap - the question though is
> > how fast should it be ?
> 
> HP IRQ should be thrown _ASAP_ when we know that link is up, so PCIe HP
> driver can handle it and do its job. Just like for hardware which fully
> and correctly supports link up HP IRQs.

My question really is - what are we expecting the HP core code to fix up
?

And related, is it safe to carry on with the PCI config space access
till the IRQ is actually emulated to carry out those actions ?

Lorenzo
