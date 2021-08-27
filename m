Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB323F97A9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbhH0JtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 05:49:21 -0400
Received: from foss.arm.com ([217.140.110.172]:38190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245045AbhH0JtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 05:49:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418FC31B;
        Fri, 27 Aug 2021 02:48:23 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8E5C3F766;
        Fri, 27 Aug 2021 02:48:21 -0700 (PDT)
Date:   Fri, 27 Aug 2021 10:48:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     robh+dt@kernel.org, bhelgaas@google.com, kishon@ti.com,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kw@linux.com,
        punit1.agrawal@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
Message-ID: <20210827094815.GA13112@lpieralisi>
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <162998285902.30814.11206633831020646086.b4-ty@arm.com>
 <TYAPR01MB6252A29B56BBF8921822824F92C79@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYAPR01MB6252A29B56BBF8921822824F92C79@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 11:49:04PM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> > Sent: Thursday, August 26, 2021 10:01 PM
> > To: iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>; Rob Herring
> > <robh+dt@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Kishon Vijay Abraham I <kishon@ti.com>; ishikawa yuji(石川 悠司
> > ○ＲＤＣ□ＡＩＴＣ○ＥＡ開) <yuji2.ishikawa@toshiba.co.jp>; linux-arm-kernel@lists.infradead.org;
> > linux-pci@vger.kernel.org; Krzysztof Wilczyński <kw@linux.com>; agrawal punit(アグラワル プニト □ＳＷＣ◯ＡＣＴ)
> > <punit1.agrawal@toshiba.co.jp>; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host controller driver
> > 
> > On Wed, 11 Aug 2021 17:38:27 +0900, Nobuhiro Iwamatsu wrote:
> > > This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
> > > This provides DT binding documentation, device driver, MAINTAINER files.
> > >
> > > Best regards,
> > >   Nobuhiro
> > >
> > > [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
> > >
> > > [...]
> > 
> > Applied to pci/dwc, thanks!
> 
> Thanks! But...
> > 
> > [1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
> >       https://git.kernel.org/lpieralisi/pci/c/a655ce4000
> > [2/3] PCI: visconti: Add Toshiba Visconti PCIe host controller driver
> >       https://git.kernel.org/lpieralisi/pci/c/09436f819c
> 
> Only drivers/pci/controller/dwc/Makefile is applied. Could you check this?	

I fixed this. Please don't write patch versions changes in the commit
log - I had to delete those myself, I did not notice while applying
them.

Please let me know if the branch looks OK now.

Lorenzo

> > [3/3] MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
> >       https://git.kernel.org/lpieralisi/pci/c/34af7aace1
> > 
> > Thanks,
> > Lorenzo
> 
> Best regards,
>   Nobuhiro
