Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7623978C5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhFARKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 13:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233088AbhFARKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 13:10:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D183A613BD;
        Tue,  1 Jun 2021 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622567349;
        bh=+zihr/1dEKecjbWZMyMZhBb9qPM7c1gIEBulDvTqimQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fLk9ycFh5NQo2Oa/bZxFbggvXPPmgSF8wXKvfSvN3ilA0Nvq3bmGfKHyzgVnXJ+mh
         pD0aVmlqSDEmGUufkpDe2D4b/lGueKiQFU4rh2Fb8Xf1ErGqDw92JWbjLvG5MHv/+Q
         0EbHFrLxFc4wNVTpWENe4p6+BdSaQnbIIuJQPEsNlNLy37kLe8KwQeybw/EAHw2HuW
         nXRAFyroEMjEH6dpanyRy36RQ9VtoywQ2wl2YiP15sUeexJlkDXQz0j8Kzs/fbnm/U
         c2YK48S+0hsDImlNMmofWGb4CK9b4yzDn4BJWZjHcV59Q0l2E1YzmtXPaSMWRinrJX
         1Gvo45q7lYdJQ==
Date:   Tue, 1 Jun 2021 12:09:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org,
        =?iso-8859-1?Q?R=F6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: Add Max Payload Size quirk for ASMedia ASM1062 SATA
 controller
Message-ID: <20210601170907.GA1949035@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528001208.z4g4f7wlu65dxypj@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Fri, May 28, 2021 at 02:12:08AM +0200, Pali Rohár wrote:
> On Tuesday 11 May 2021 18:16:12 Marek Behún wrote:
> > Ping? :)
> > 
> > Marek
> 
> Bjorn: Gentle reminder :)

The current patch [1] doesn't look mergeable as-is.

  - "ASM1062 SATA controller causes an External Abort on controllers
    which support Max Payload Size >= 512" doesn't sound like a
    correct description.

    That description suggests the problem is with the *PCI
    controller*, not with the ASM1062.  I think that's incorrect; I
    think the problem is with the ASM1062.

    I would expect something like "ASM1062 advertises Max_Payload_Size
    Supported of 512, but in fact it cannot handle TLPs with payload
    size of 512."

  - Also, "External Abort" is an arch-specific description.  Ideally
    we would know the PCIe error.  Probably ASM1062 reports a
    Malformed TLP error when it receives a data payload of 512 bytes,
    and Aardvark, DesignWare, etc convert this to an arm64 External
    Abort.

  - "this problem first appeared ... after 8a3ebd8de328 ..." seems
    only marginally relevant.  It seems to have exposed the latent
    ASM1062 defect.  We *could* say something about how the defect was
    masked by the fact that many PCI bridges only support MPS <= 256,
    and 8a3ebd8de328 would then be relevant because it effectively
    limits MPS.

  - A bugzilla link is in the email thread; thanks for that.
    Somebody needs to include it in a revised commit log.

  - The "For some reason DECLARE_PCI_FIXUP_HEADER does not work"
    comment in the code needs explanation.  If we need to change all
    the quirks to EARLY quirks, we should do that.  If this one needs
    to be different from the others, we need to explain *why*, not
    just "for some reason."

I know some of these were addressed in the email thread, and I could
synthesize some of those responses into a commit log, but it would be
better if you collected things up into a v2 posting.

[1] https://lore.kernel.org/r/20210317115924.31885-1-kabel@kernel.org)
