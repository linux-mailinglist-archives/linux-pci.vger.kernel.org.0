Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58FC6517C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 07:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfGKFgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 01:36:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34528 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKFgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 01:36:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id q128so1812145ywc.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2019 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePwg27Q7oE7ZBh+JC517Tz8x4ebhoe5lFwuorWlrxE0=;
        b=L/LNowbwhm4QGq/ZOr/DekD2HA/dA1iCujHnDWinHiymR2i9YhtW3x3by4zZHTbMsc
         YDIg3IHYtMRV4KiKXKaO6wmQBuEdKjFNujsJfD8f8sUvjPwP3H6J6PwCxC6uBd7+enag
         Yz6oWdgVzcBFGgXAsYNpUOWmZVbPB64r7j8v4aFih/FxDtH01pRl558QzOigM9W46UBs
         OZAMb0zhSslQkhona9gqEx+5OR5o2T7kKvtLV1xObsPJ6PTMqQ7Vf0foUlH5/hOoJqcO
         Q+P7vtn6uf/FeLyFNQsQajcgagsWHA+If0oFh3bhiuy42WzyvvPbUVLVuSmTxj20OIDn
         vsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePwg27Q7oE7ZBh+JC517Tz8x4ebhoe5lFwuorWlrxE0=;
        b=hTOeUeQNqu/L3lV9JXk3ZxnHCUC5XtypwrvcaK/DeIlcJUG3nZulYdw396vE8pymiu
         60GFsdPiUe6CDPyiuS5iHF3RwStKkdRorZz3FuUbilQOKoShb5674Y66Z1D3sj3Mw7VA
         VIzCnDVtN9RlYJmhfPL+Zta+NgPDCAuW3LV9t8VK5WJMfBXG3wsbXGECFf8FKKFZnRWA
         KdCRC70Q39uF2m2XbtY9EMHx0mr+Ei1C21ZFUvxWeG/C3aQE0T2OhCY4RIuvBwePzfvW
         VB/qqi8NdmtztaGHN+CV8xW6qm+qG09ikC/lTsJ1eh+wd1LCIzpWv2r+Y6aSIrBDwXzk
         nNgg==
X-Gm-Message-State: APjAAAXQND/dtntYASNnZBI3KtsPCHxJHbyZlJJWpH3XPnJ1CwIcIoXz
        eemZjSFKjhrZVFMLiBenBO4XX+PngkMjuib6bs1ICg==
X-Google-Smtp-Source: APXvYqx4oXgd2Pac+M4XQoyC2tT/r1Z8DS3ACr/3x2jveogSOU7qp6grlaWmQH8R8xaM2yGYzE5WG8XMzxHVST0339E=
X-Received: by 2002:aed:3644:: with SMTP id e62mr1364770qtb.80.1562823396672;
 Wed, 10 Jul 2019 22:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190708051744.24039-1-drake@endlessm.com> <20190710224716.GD35486@google.com>
In-Reply-To: <20190710224716.GD35486@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 11 Jul 2019 13:36:25 +0800
Message-ID: <CAD8Lp47=5PtYWV3Gu3kH3uTsdFHm4NhOsNPQcy=7or_Og_p7NA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Expose hidden NVIDIA HDA controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 6:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> I applied this (slightly revised as below) to pci/misc and I think we
> can still squeeze it in for v5.3.

Thanks. Tested briefly and it seems to be working fine!
