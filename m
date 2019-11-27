Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6010AE58
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfK0K7j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 05:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfK0K7j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Nov 2019 05:59:39 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648862071E
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2019 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574852378;
        bh=MCpEOE5vXkp/TLtWfq/5Qoio1Rf8C0b6msp7BvaJnCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sitl8TCjgEMU+PW0gRQBGFqnl1wr5qAURH2zuVSPssYVBxEr0mYz83XBunhWtc0gA
         GYy2jci5Wy6nWetFKQaCV7Y+7DnApNEJK1C73tWX07HWh9Pv1uaGwrl9pC5eGjeOwS
         YXiuYGd8jbL8Dk6QKU+IIwO6Fmu6dUVXpp34scnc=
Received: by mail-qk1-f173.google.com with SMTP id m16so19031538qki.11
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2019 02:59:38 -0800 (PST)
X-Gm-Message-State: APjAAAUDaA8GpsFXGCVIlHOi4Dao2CjMIc+6Tw3J3h0hoNRlQR5j8glM
        7T/deJPKUnDoFslyiEkvUNY3EjH86s0u6tk1xAM=
X-Google-Smtp-Source: APXvYqwTN9F0eFceWFgZarzm5oysR9AAku3lU/GSNSvf682xFJhgeujv+L5Fas9b6peKSRsiGE4+Hie8jf/usIrOSbE=
X-Received: by 2002:a05:620a:1327:: with SMTP id p7mr3630409qkj.148.1574852377544;
 Wed, 27 Nov 2019 02:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20191115135842.119621-1-wei.liu@kernel.org> <20191126230524.GA197236@google.com>
In-Reply-To: <20191126230524.GA197236@google.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Wed, 27 Nov 2019 10:59:26 +0000
X-Gmail-Original-Message-ID: <CAHd7Wqw49hB3++Td00=xccgJoqPLye_DvYv8+PYjxHWbDm5DVg@mail.gmail.com>
Message-ID: <CAHd7Wqw49hB3++Td00=xccgJoqPLye_DvYv8+PYjxHWbDm5DVg@mail.gmail.com>
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Nov 2019 at 23:05, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 15, 2019 at 01:58:42PM +0000, Wei Liu wrote:
> > CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> > in.  Removing the ifdef will allow us to build the driver as a module.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>
> Sorry, I missed this thinking it would be under drivers/pci/controller
> and hence handled by Lorenzo.
>
> So I guess this doesn't fix a build problem, but without this patch,
> we just don't run the quirk if the driver is a module, right?
>

Yes, this is correct.

Without this patch, the quirk doesn't get to run if the driver is a module.

Wei.
