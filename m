Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55954D8E23
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 21:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiCNUbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 16:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiCNUbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 16:31:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C93333980A;
        Mon, 14 Mar 2022 13:30:02 -0700 (PDT)
Received: from jpiotrowski-Surface-Book-3 (ip-037-201-215-233.um10.pools.vodafone-ip.de [37.201.215.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2E6E5205836B;
        Mon, 14 Mar 2022 13:30:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E6E5205836B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647289802;
        bh=Fks9i7pn0mLZFjX0LLugNfOXGZa5Y/Q/DFVFR48RSsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6fVzMnuBHzNLsMNZgWE/rnNHJ1FwAZutcCEBtgwykRYHTUDFcmjVXcOQqFnZKGPf
         AWZMbPsMpQU72RJQ16Zx6/dgXvxiJSQUrv1bIS9GabKuPputsm5ssCS3bXcr4ZjIso
         aw7p+zaed2TbhKEoyPBKABzoWs/ADUBZTPQurDKU=
Date:   Mon, 14 Mar 2022 21:29:53 +0100
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Dusty Mabe <dustymabe@redhat.com>
Cc:     Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, x86@kernel.org, maz@kernel.org
Subject: Re: [tip: irq/urgent] PCI/MSI: Mask MSI-X vectors only on success
Message-ID: <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 01:04:55PM -0400, Dusty Mabe wrote:
> 
> 
> On 3/14/22 12:49, Stefan Roese wrote:
> 
> > I've added Dusty to Cc, as he (and others) already have been dealing
> > with this issue AFAICT.
> > 
> > Dusty, could you perhaps chime in with the latest status? AFAIU, it's
> > related to potential issues with the Xen version used on these systems?
> 
> Thanks Stefan,
> 
> Yes. My understanding is that the issue is because AWS is using older versions
> of Xen. They are in the process of updating their fleet to a newer version of
> Xen so the change introduced with Stefan's commit isn't an issue any longer.
> 
> I think the changes are scheduled to be completed in the next 10-12 weeks. For
> now we are carrying a revert in the Fedora Kernel.
> 
> You can follow this Fedora CoreOS issue if you'd like to know more about when
> the change lands in their backend. We work closely with one of their partner
> engineers and he keeps us updated. https://github.com/coreos/fedora-coreos-tracker/issues/1066
> 
> Dusty

Thanks for the link and explanation. What a fun coincidence that we hit this in
Flatcar Container Linux as well. We've reverted the commit in our kernels for
the time being, and will track that issue.

Thanks,
Jeremi
