Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2350B3FA2C1
	for <lists+linux-pci@lfdr.de>; Sat, 28 Aug 2021 03:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhH1BPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 21:15:39 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:56114 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhH1BPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 21:15:39 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 17S1EksB001842; Sat, 28 Aug 2021 10:14:46 +0900
X-Iguazu-Qid: 2wHHCQcimiqb2Jfnge
X-Iguazu-QSIG: v=2; s=0; t=1630113285; q=2wHHCQcimiqb2Jfnge; m=COs2fNyNW/e9aN1r8qfvg9hhyTI2VUC9qIXExnCc1c8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 17S1Ejue025732
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 28 Aug 2021 10:14:45 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 3475C10014D;
        Sat, 28 Aug 2021 10:14:45 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 17S1EiHP004416;
        Sat, 28 Aug 2021 10:14:45 +0900
Date:   Sat, 28 Aug 2021 10:14:43 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     robh+dt@kernel.org, bhelgaas@google.com, kishon@ti.com,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kw@linux.com,
        punit1.agrawal@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
X-TSB-HOP: ON
Message-ID: <20210828011443.njafshmejojm7t5t@toshiba.co.jp>
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <162998285902.30814.11206633831020646086.b4-ty@arm.com>
 <TYAPR01MB6252A29B56BBF8921822824F92C79@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <20210827094815.GA13112@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210827094815.GA13112@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Aug 27, 2021 at 10:48:15AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Aug 26, 2021 at 11:49:04PM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> > Hi,
> > 
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> > > Sent: Thursday, August 26, 2021 10:01 PM
> > > To: iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>; Rob Herring
> > > <robh+dt@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Kishon Vijay Abraham I <kishon@ti.com>; ishikawa yuji(石川 悠司
> > > ○ＲＤＣ□ＡＩＴＣ○ＥＡ開) <yuji2.ishikawa@toshiba.co.jp>; linux-arm-kernel@lists.infradead.org;
> > > linux-pci@vger.kernel.org; Krzysztof Wilczyński <kw@linux.com>; agrawal punit(アグラワル プニト □ＳＷＣ◯ＡＣＴ)
> > > <punit1.agrawal@toshiba.co.jp>; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host controller driver
> > > 
> > > On Wed, 11 Aug 2021 17:38:27 +0900, Nobuhiro Iwamatsu wrote:
> > > > This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
> > > > This provides DT binding documentation, device driver, MAINTAINER files.
> > > >
> > > > Best regards,
> > > >   Nobuhiro
> > > >
> > > > [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
> > > >
> > > > [...]
> > > 
> > > Applied to pci/dwc, thanks!
> > 
> > Thanks! But...
> > > 
> > > [1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
> > >       https://git.kernel.org/lpieralisi/pci/c/a655ce4000
> > > [2/3] PCI: visconti: Add Toshiba Visconti PCIe host controller driver
> > >       https://git.kernel.org/lpieralisi/pci/c/09436f819c
> > 
> > Only drivers/pci/controller/dwc/Makefile is applied. Could you check this?	
> 
> I fixed this. Please don't write patch versions changes in the commit
> log - I had to delete those myself, I did not notice while applying
> them.

Sorry about this.

> 
> Please let me know if the branch looks OK now.
> 

Looks good to me.
Thanks for your work.

> Lorenzo
> 
> > > [3/3] MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
> > >       https://git.kernel.org/lpieralisi/pci/c/34af7aace1
> > > 
> > > Thanks,
> > > Lorenzo
> > 

Best regards,
  Nobuhiro


