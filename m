Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64757010B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiGKLrE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiGKLqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 07:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CF138;
        Mon, 11 Jul 2022 04:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A7161032;
        Mon, 11 Jul 2022 11:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB43C34115;
        Mon, 11 Jul 2022 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657539864;
        bh=UzO+eoR2gdyxbkEMVthgFEEl4Ykpah7DCyZuEQPq10Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WNSpR05ZZxJDxOIL4hVvtm/ZOwUx8D3fS8wEjhaksFhkHpS+7eehFd6qT72jjiZJ6
         m+lyR1sAAUGOR93ZKpLBBcfGr60+Xco6Zb0ChJLGgB/vMy6Gja1ZABJ/eFDPA30HrH
         f11jzaWn9ycQ2xxAi4I3QiDLv0kwhmF8VMSk+VsRDTl3WWbLRlv+bJOLjxvGpReZrZ
         fDcHF54eKcyy31+mBtzmmuW8Ek7m1XQYPL9AQ5DC3q++V1q17yDe+AMl6/MdRgrhL/
         Np9gk2WnyMPhzUHZEFjRRuD36lcevfL0EpfGjkOHe9xqrD2tQrKwVHFHdvhd/Ei1H1
         ByJOAiwqWpAGA==
Date:   Mon, 11 Jul 2022 13:44:18 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Dispose INTx irqs prior to removing INTx
 domain
Message-ID: <20220711134418.69f20344@thinkpad>
In-Reply-To: <20220709161858.15031-1-pali@kernel.org>
References: <20220709161858.15031-1-pali@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat,  9 Jul 2022 18:18:58 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Documentation for irq_domain_remove() says that all mapping within the
> domain must be disposed prior to domain remove.
>=20
> Currently INTx irqs are not disposed in pci-mvebu.c device unbind callback
> which cause that kernel crashes after unloading driver and trying to read
> /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.
>=20
> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx inter=
rupts")
> Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
