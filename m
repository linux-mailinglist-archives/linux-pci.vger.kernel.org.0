Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD406A3EF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfGPIdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 04:33:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44315 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfGPIdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 04:33:40 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so38512713iob.11
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vzap+4xNNS/hHS/OOE+FonbCO2y8T5Sdhg9a7mHxxZc=;
        b=AaPIi+ZVWCk/ycH5zSap9Rfc6OBIq8nWE4hDYFCzrfkpayybwdWvEMTHnmCQG971mx
         9CtvU5rGuw2gVobtAw8Mq/PnDLZ+pUwo3H94CiyLluMRjG2ZWD/fxPTqjgpKNbXCUz3V
         /lanFrBrhxNZHcHw3VDagNcDaRqqNL46FP6517DmjB6RXG6oRWdwyUye+YtndjdHt1nA
         OaniCWCE/qlkdYf1FPNL9lXF5e5kwCxNNE4tpuPNLr5JyGTL4mVE5RD4BSEm3a9YhNQR
         F6aF2y6am9XnIv+bEyE28koSvp+1zQonYZc4NUydXFlRNqjZjpEL1Af33v0CK0JP3I7Y
         3OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vzap+4xNNS/hHS/OOE+FonbCO2y8T5Sdhg9a7mHxxZc=;
        b=GeDuJ6ZgVesEzNfDVBATkEeaLHNbBEIKvKLAP4pa6LKwpcGk1vqRqeA1argUi7etXs
         NRImImlyeAuewkNHeXfyjiFsaWlJ48/SF7OOQoarIc/2WNYdqKw6oeZSPnA0xQqv1rBS
         Jne07YUQBtULVRJyOVF6Ojz40pH02MF2rkj5kCAyqUE9sa+wx+koOGXyaUjsiJJHfraB
         N3F4xy7QDiKZPGvDzNWGj4SA8LoHdTOmT4p1KwZEHpOiAx39MifwGBWbqBdh/XUCPZy7
         OAOFPA2pVhXGOKazo3oIufZGZCmtwL+amZ7v+7C2hVmJQ+AlhLtGik4/jijKo7vDbZ+V
         uV/A==
X-Gm-Message-State: APjAAAUCt1tljiXOyaCqRz7g2+T5sBdaU04eeztV6XOHcfMeUypb5jfl
        +NRnurUbHL2rCaROOQZYtuIl801b2ta+SLTr6Bk=
X-Google-Smtp-Source: APXvYqya0V5jarXyUeFdaG8e6dAJp0uRcbmGkv63/kgCGx/E6oESR+tWIfI7iA022SDAuIC6+cpN6bRaSLxuJRf8wpY=
X-Received: by 2002:a02:7f15:: with SMTP id r21mr34328068jac.120.1563266019706;
 Tue, 16 Jul 2019 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <1563200177-8380-1-git-send-email-jaz@semihalf.com> <20190715143046.r3ja32rfntagqrqr@shell.armlinux.org.uk>
In-Reply-To: <20190715143046.r3ja32rfntagqrqr@shell.armlinux.org.uk>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Tue, 16 Jul 2019 10:33:28 +0200
Message-ID: <CAH76GKNKLm8y1PsF3uSiUpqDqh28XEepnkCAM_69Yp=vjHsn6w@mail.gmail.com>
Subject: Re: [PATCH] PCI: pci-bridge-emul: fix big-endian support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Russell

pon., 15 lip 2019 o 16:30 Russell King - ARM Linux admin
<linux@armlinux.org.uk> napisa=C5=82(a):
> This is insufficient - pci-bridge-emul.h needs to be fixed up to use
> __le32 and __le16.
>
> It is a good idea to check such changes with sparse - a tool originally
> written by Linus, which is able to detect incorrect endian accesses
> (iow, access to LE members without using a LE accessor.)  Such checks
> rely on using the right types.

Thank you for pointing this out - it is really usefully tool. I will
send v2 soon.

regards,
Grzegorz
