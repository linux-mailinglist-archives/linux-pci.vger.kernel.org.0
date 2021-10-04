Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4D420852
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhJDJeo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 05:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhJDJeo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 05:34:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 478AA6126A;
        Mon,  4 Oct 2021 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633339975;
        bh=Z4f1/4rYjc3uLKwhC3Kg8ONX9AqFIF/VhNIJvCFkTL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o4Xy/CHxsbxS8SgQsNQQfMd0/xc7nvwlMotzFGnbU1jnRekM4FPT88oMVp9PeDz0X
         bK1yZIP50L/wuBR+MB716SFi0cociJq9Tdjvd1C6ou0C4sjO8ihNU+lblWJu9YsaTM
         AyKnh6xKXOlznDT1NlTJVk6bPaeyRGWcCb/8HWP5aPF9QwX89fcQCSlGHTgJl5OF5M
         emPKOCGehYOEEcUDWuWee+eSnR4NH/JUS2w0mQnobJcIypi0YPWakigdxM4uV1+z6O
         zP0pr5sIzLm28YautbctoIJ4H3+mZIe7UspGPh42oR1s4AchzPsM9TVVmBzpB5hL9E
         5NXCwe4tGgjWQ==
Date:   Mon, 4 Oct 2021 11:32:51 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 01/13] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20211004113251.053a02c6@thinkpad>
In-Reply-To: <20211004084350.GB22336@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
        <20211001195856.10081-2-kabel@kernel.org>
        <20211004084350.GB22336@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 Oct 2021 09:43:50 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Oct 01, 2021 at 09:58:44PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
> > Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >  include/uapi/linux/pci_regs.h | 6 ++++++
> >  1 file changed, 6 insertions(+) =20
>=20
> This requires Bjorn's ACK.

Lorenzo, Bjorn already sent his Reviewed-by for this patch. Did you not
receive it?

Marek
