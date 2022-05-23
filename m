Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393B353123A
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiEWOUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiEWOUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 10:20:45 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C75A17A;
        Mon, 23 May 2022 07:20:43 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4D8E1100D5844;
        Mon, 23 May 2022 16:20:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 13E602ED3E7; Mon, 23 May 2022 16:20:42 +0200 (CEST)
Date:   Mon, 23 May 2022 16:20:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sheng Bi <windy.bi.enflame@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
Message-ID: <20220523142042.GA19286@wunner.de>
References: <20220516165740.6256af51.alex.williamson@redhat.com>
 <20220518115432.76183-1-windy.bi.enflame@gmail.com>
 <20220520064148.GA20418@wunner.de>
 <CAGdb+H2_pX4TzG=sJ8XE6KiyWW9niJQawCbcDN2byxDfybukiA@mail.gmail.com>
 <20220521124910.GA13556@wunner.de>
 <CAGdb+H19bfbXM1cPJvhh6gixJbF7Sk=v53d9VpvWY8HEs0mSKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGdb+H19bfbXM1cPJvhh6gixJbF7Sk=v53d9VpvWY8HEs0mSKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 22, 2022 at 01:37:50AM +0800, Sheng Bi wrote:
> On Sat, May 21, 2022 at 8:49 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Sat, May 21, 2022 at 04:36:10PM +0800, Sheng Bi wrote:
> > > If so, I also want to align the polling things mentioned in the
> > > question from Alex, since pci_dev_wait() is also used for reset
> > > functions other than SBR. To Bjorn, Alex, Lucas, how do you think if
> > > we need to change the polling in pci_dev_wait() to 20ms intervals, or
> > > keep binary exponential back-off with probable unexpected extra
> > > timeout delay.
> >
> > The exponential backoff should probably be capped at some point
> > to avoid excessive wait delays.  I guess the rationale for
> > exponential backoff is to not poll too frequently.
> > Capping at 20 msec or 100 msec may be reasonable, i.e.:
> >
> > -               delay *= 2;
> > +               delay = min(delay * 2, 100);
> 
> Capping at 20 or 100 msec seems reasonable to me. Btw, since 20 msec
> is not a long time in these scenarios, how about changing to a fixed
> 20 msec interval?

The callers of pci_dev_wait() seem to wait for the spec-defined
delay and only call pci_dev_wait() to allow for an additional period
that non-compliant devices may need.  That extra delay can be expected
to be low, which is why it makes sense to start with a short poll interval
and gradually extend it.  So the algorithm seems to be reasonable and
I wouldn't recommend changing it to a constant interval unless that
fixes something which is currently broken.

Thanks,

Lukas
