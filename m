Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E45463570
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbhK3Naf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbhK3NaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:30:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E8C061574;
        Tue, 30 Nov 2021 05:27:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC22ECE198C;
        Tue, 30 Nov 2021 13:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB477C53FC7;
        Tue, 30 Nov 2021 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278816;
        bh=oTFEEwqhOiMlyQDxIN/zHG5v6yAlxLysusAqTHkqh48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dPf8Xmn7Sx0OJmtrJn6J597wPnoJt5rIRpulE6li0lHbQ3DvApCVjF+PZ0BeHPu2V
         aihAHcDJMAGIoumxjZunhyDru7Kfp+mitAiJkWsH78CITarU+FKXLWLa6TD31cnJEr
         FhiqzpPB2h95nbHD4adZLoIIXp2xRgwAFvkLYslyvJn9LrWtTpMiHJsMMRS2ttBVLZ
         vRAsYIdIibfVTjzJmyPsfWm61SYZ66m9KpOGR0bSJY2XjU0/JslRVQzC/KD5B3zKsk
         NlPJiMboadUcGPxW45edlTGl+uSI3bTYHlO8nPBmNTni6Aba7bzDVOvpjPqWlbHr2B
         cFC/CrfvVEfsw==
Date:   Tue, 30 Nov 2021 14:26:52 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: pci-bridge-emul: Various fixes
Message-ID: <20211130142652.30654ce5@thinkpad>
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Nov 2021 16:59:38 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> This patch series contains various fixes for pci-bridge-emul code.
> This code is used only by pci-aardvark.c and pci-mvebu.c drivers.
>=20
> Pali Roh=C3=A1r (6):
>   PCI: pci-bridge-emul: Make expansion ROM Base Address register
>     read-only
>   PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config
>     space
>   PCI: pci-bridge-emul: Add definitions for missing capabilities
>     registers
>   PCI: pci-bridge-emul: Fix definitions of reserved bits
>   PCI: pci-bridge-emul: Correctly set PCIe capabilities
>   PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
>=20
>  drivers/pci/controller/pci-aardvark.c |   4 +-
>  drivers/pci/controller/pci-mvebu.c    |   8 ++
>  drivers/pci/pci-bridge-emul.c         | 113 ++++++++++++++++++++++----
>  3 files changed, 108 insertions(+), 17 deletions(-)
>=20

I will send v2 of this series with the third patch dropped, since it
will be applied via aardvark batch 3 series.

Marek
