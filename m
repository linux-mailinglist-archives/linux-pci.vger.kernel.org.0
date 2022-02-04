Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6D4A9CA4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiBDQGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 11:06:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51004 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiBDQGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 11:06:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 265EAB83818;
        Fri,  4 Feb 2022 16:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CDBC004E1;
        Fri,  4 Feb 2022 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643990778;
        bh=AwqDqSxat/pFIu3D+mTbSxknPJqAY3cma8RQiS/TFxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BOiGHvQHl5FbfOGzdxE9R+bMyVdJbkW8ItZb3RvslFXarHGY5u3pgenjNG/FXGICl
         tfKe5x75vVYbwnXhhO/ySyEXC5fGtrjl5QiE/p5SQUAbFUyHdpIoKneKyEMoZpHJ3P
         HtYLXQgVemhFSoJoBA2I4A3VZ7oOPC9PrRJUMuVdDEvTYGUFeX1Ed8rdtOt+xiC2V+
         59UbTph+g/4E3JLx3IDrEfeB8uDE7X+9PT9b4FbvY5MkVJFTyIL5tdkSBYvrZoHQVw
         ZGzb8BWlTF8acCXBLwvbSGJS00DArIME7W50fxSiEcTPA1aTI8PbZ/DgjD25OOMPyX
         nLIlNvRdQgVow==
Date:   Fri, 4 Feb 2022 10:06:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: uniphier-ep: Add support for non-legacy SoC
Message-ID: <20220204160616.GA183849@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643855786-23186-3-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 11:36:25AM +0900, Kunihiko Hayashi wrote:
> Define SoC data that includes pci_epc_features and boolean 'is_legacy'
> to distinguish between legacy SoC (ex. Pro5) and non-legacy SoC.

I'm not a big fan of "legacy" as a description because it conveys very
little information.  You're adding support for a "non-legacy" SoC, so
now there are "legacy" ones and "non-legacy" ones.  Next year there
will be another new SoC, and then there will be *two* kinds of
"legacy" ones that must be distinguished plus the next "non-legacy"
one.

You mentioned "Pro5" as an example of "legacy," which is a good start.
Are there any others?  If Pro5 is the only one, you could just use
"pro5" where you now use "legacy."

Bjorn
