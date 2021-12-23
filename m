Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87CD47E682
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 17:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhLWQnI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 11:43:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42822 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhLWQnI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 11:43:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C9261EF4;
        Thu, 23 Dec 2021 16:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEDEC36AE9;
        Thu, 23 Dec 2021 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640277787;
        bh=NL161JDeCDIM/xYNPhiC2ONE2NUXcY75vDiM159xu5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PksqG2PWGf4RtwEqs6ZBvoY/axiIf4Sf9R3Q7ijq4zxConWpi5QScPKc1J1wRl1YF
         VPF4WLJVQSBOF2NRURrWTMuicoXgsqwIjnpbSQsuQgoljTVFBjcGJNKaj8npFSXmQE
         R6dJzXmYW79WzXlhCyFB48jys5FQTOZCrHWYG+Tt+INp9LcH2fj57ufedZZxcqA0ws
         R6BF0NiWq1QW6X9qweE3WjJoIlLzKSMV5IfrmL+Xf3T8S2mwhFephLL76xGB5J37QS
         FkfBcAUKj+cBc8LAqtRQhzvzdcXDb6FoAZjyU4z3C6PUqelnTlpgN0uZzij3k8e2J0
         MOqQT2HPVMHtw==
Date:   Thu, 23 Dec 2021 10:43:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 17/23] PCI: mt7621: Rename mt7621_pci_ to mt7621_pcie_
Message-ID: <20211223164305.GA1270275@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H_dTkp6_1Loq973JqotW26GtRYQv-vdQ2i6Heo7oGCL3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 23, 2021 at 07:10:22AM +0100, Sergio Paracuellos wrote:
> On Thu, Dec 23, 2021 at 2:11 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Rename mt7621_pci_* structs and functions to mt7621_pcie_* for consistency
> > with the rest of the file.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 36 ++++++++++++++--------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index 4138c0e83513..b8fea7afdb1b 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -93,8 +93,8 @@ struct mt7621_pcie_port {
> >   * reset lines are inverted.
> >   */
> >  struct mt7621_pcie {
> > -       void __iomem *base;
> >         struct device *dev;
> > +       void __iomem *base;
> 
> This change is unrelated to the commit message and the rest of the
> changes of this patch.
> ...

> Other than that minor unrelated change, this looks good to me:
> 
> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks, I added a mention of the struct member reorder.

Bjorn
