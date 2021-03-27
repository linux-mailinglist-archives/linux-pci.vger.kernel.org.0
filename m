Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96134B7C9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 15:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhC0Om5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0Omr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 10:42:47 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD9C0613B1;
        Sat, 27 Mar 2021 07:42:46 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id 33833140AE7;
        Sat, 27 Mar 2021 15:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1616856164; bh=nbYNsAK2One2JFvggre3QyTyFpQJQ7zSpNnqJUjIURM=;
        h=Date:From:To;
        b=gHQQoh7U/onyzxPBUweSPHiV5+X91lH1RlYcOfYSRYSyfpqbTVHBfwmk+H7AHP3si
         FgR6xYPEUZxB5fXDcr7rVcowKrKspJO3B+0pTLm3VM8eozVUH1QTVW6YUeXyXd2Zm2
         h9ZPLipHM14MFnXMOGeYaHeaQ8nQPVsJ9b5J6S7o=
Date:   Sat, 27 Mar 2021 15:42:13 +0100
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disallow retraining link for Atheros QCA98xx chips
 on non-Gen1 PCIe bridges
Message-ID: <20210327154213.571aa263@dellmb.labs.office.nic.cz>
In-Reply-To: <20210327132959.fwkphna7gg57aove@pali>
References: <20210326124326.21163-1-pali@kernel.org>
        <YF540gjh156QIirA@rocinante>
        <20210327132959.fwkphna7gg57aove@pali>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 27 Mar 2021 14:29:59 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> I can change this to 'if (!ret)' if needed, no problem.
>=20
> I use 'if (!val)' mostly for boolean and pointer variables. If
> variable can contain more integer values then I lot of times I use
> '=3D=3D'.

Comparing integer varibales with explicit literals is sensible, but
if a function returning integer returns 0 on success and negative value
on error, Linux kernel has a tradition of using just
  if (!ret)
or=20
  if (ret)

Marek
