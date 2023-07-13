Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A848775294C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGMRD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGMRD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 13:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6B52700;
        Thu, 13 Jul 2023 10:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6E6D61AED;
        Thu, 13 Jul 2023 17:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C31C433C8;
        Thu, 13 Jul 2023 17:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689267837;
        bh=+qeyXsRrQ/U2yh6VTcdgE7vMtiDddsPP8kKRqmBbsC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ldRUBCz1IijQ2TRJznDuOdfdNLVlCgTn8OwirEAkjEQzdy1+SVvxmVgg9yF8qf3RA
         GSXMDzrmc6CeMhEJsIwtEMxbWUjWfbKynBYzA6xfO57OQya8HgKi6EL4OOnMmdz6gG
         SExAd79qm0KKzjb/zY0GM2xLCz/VUcQXe8f6RJzA1Njuk13+5tUeQGunZGFFlAe2Px
         RxjqZMvof3cZguglyIFIalImEJlJsBQts9MCTAkLboqfs9rDNy0hcNgm3Eiilqd+pk
         PK71+MiET4cGnHEmQN8mC7+H1Soki7SRRL+GnMBzzs0j1+4FqW0LJBGIqygWYCmfYm
         ARAT3V8JMvRTA==
Date:   Thu, 13 Jul 2023 12:03:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
Message-ID: <20230713170355.GA323073@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8715f2b298c04422db311666eb2409464c29458b.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 11:04:50PM -0400, Radu Rendec wrote:
> On Thu, 2023-06-29 at 17:11 -0500, Bjorn Helgaas wrote:
> ...

> > If converting from chained to normal handlers can be done safely, I
> > would definitely be in favor if doing it across all of drivers/pci/ at
> > once so they're all consistent.  Otherwise that code just gets copied
> > to new drivers, so the issue persists and spreads.
> 
> I think the conversion can be done safely, meaning that it won't break
> the drivers. And by the way, there are other IRQ drivers (outside the
> PCI space) that use chained interrupts.
> 
> Unfortunately, it seems we are going in circles. Chained interrupts are
> bad because they let IRQ storms go unnoticed and lock up the system,
> but converting them to regular interrupts is also bad because it breaks
> the userspace ABI.
> 
> I am willing to help clean up this mess, but I think first we need to
> come up with a solution that's acceptable for everybody. I was hoping
> Marc and Thomas would chime in, but unfortunately that hasn't happened
> yet - other than each of them pointing out (separately) what is wrong
> with each approach.

I don't think Marc or Thomas are going to chime in with a fully-formed
solution.  I think to make progress, you (or Pali, or somebody) will
have to try to address Marc and Thomas' comments, make a proposal, and
we can iterate on it.

Bjorn
