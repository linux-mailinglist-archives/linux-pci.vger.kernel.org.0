Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DB523336
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiEKMiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242499AbiEKMh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 08:37:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D45BC2317FA;
        Wed, 11 May 2022 05:37:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7F5EED1;
        Wed, 11 May 2022 05:37:58 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D94A3F66F;
        Wed, 11 May 2022 05:37:56 -0700 (PDT)
Date:   Wed, 11 May 2022 13:37:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Dominic Rath <dominic.rath@ibv-augsburg.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
Message-ID: <YnuuIQgwt45zUEcR@lpieralisi>
References: <20220429105627.GA28438@lpieralisi>
 <20220429192825.GA82239@bhelgaas>
 <20220505144347.GA19346@JADEVM-DRA>
 <CAH9NwWcU71gZ2woZ7ePRvuwz=_T+F7V6VOYLyAqPhTy1j6xxPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWcU71gZ2woZ7ePRvuwz=_T+F7V6VOYLyAqPhTy1j6xxPA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 05, 2022 at 04:48:17PM +0200, Christian Gmeiner wrote:

[...]

> > > I think the proposed subject of "Enable Controller to respond to
> > > received PTM Requests" is somewhat misleading, though, because PTM
> > > responses still aren't enabled until we set PTM Enable.  I suggest
> > > something like:
> > >
> > >   PCI: cadence: Allow PTM Responder to be enabled
> >
> > I'll ask Christian for permission to resend his patch with the subject
> > changed.
> >
> 
> I will send a new version tomorrow with an improved subject line.

Hi Christian,

just asking if you are about to post a new version to pick it up.

Thanks,
Lorenzo
