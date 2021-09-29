Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9EF41CE4B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbhI2VjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344269AbhI2VjY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 17:39:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78CC1613CE;
        Wed, 29 Sep 2021 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632951462;
        bh=i/ZRP0e3eqVc1l2cMg7LgUU/gI2GtnZcCQZ3cbDlWok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bspG4lYQtfnmfwHWVDHgUtpkqwaJ+OA1p9ax7KnYkGm8JFlbd7c3pUMxSZOnu2jxb
         VROjPM6Lq2NvGHzXfYSiF5Uh5KuUhu5C5l3ZzDE7CPASXm6y5M3amigPdOsZI0l5XT
         QPF+7Uc7nkOjpYSC4a3YCCsisdtpkJOxAiEuBi0ilV8nK69bwG05xqP230hL7wpAjn
         6FSNcdbYCmhYHsKs8BZcWTW6eJUybndPNFOKJGwZX15QStp+4m8gAD6hUsKp/dq1k8
         Psm40jXa2oeJfWOl7Ghw0w4Ljn8GSUy60uPRBxPaNk7tsHLDJuoQT/njTkUd91/EV6
         EsE6G1sANdSsw==
Date:   Wed, 29 Sep 2021 16:37:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Ooi, Joyce" <joyce.ooi@intel.com>
Cc:     "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 pci 0/2] Update Mun Yew Tham as Pci Driver maintainer
Message-ID: <20210929213737.GA793548@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO1PR11MB4820E3A166F8C08A85125458F2A99@CO1PR11MB4820.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 05:25:06AM +0000, Ooi, Joyce wrote:
> > -----Original Message-----
> > From: Tham, Mun Yew <mun.yew.tham@intel.com>
> > Sent: Wednesday, September 29, 2021 1:10 PM
> > To: Ooi, Joyce <joyce.ooi@intel.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; Rob
> > Herring <robh@kernel.org>
> > Cc: Krzysztof Wilczyński <kw@linux.com>; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Tham, Mun Yew <mun.yew.tham@intel.com>
> > Subject: [PATCH V2 pci 0/2] Update Mun Yew Tham as Pci Driver maintainer
> > 
> > This is to update both Pci Driver For Altera Pcie Ip and Pci Msi Driver For
> > Altera Msi Ip maintainer.
> > 
> > Mun Yew Tham (2):
> >   Update Mun Yew Tham as Pci Driver For Altera Pcie Ip maintainer
> >   Update Mun Yew Tham as Pci Msi Driver For Altera Msi Ip maintainer
> > 
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Joyce Ooi <joyce.ooi@intel.com>

Seems like the original patch got lost.  All I can see is the
response, which isn't enough to apply this.  Can you (Mun Yew Tham, I
guess?) resend it?

Since you're becoming the maintainer for this, note that I
consistently capitalize "PCI", "PCIe", "MSI", "MSI-X", "IP", etc., so
they match the spec and common usage for acronyms and initialisms.

Bjorn
