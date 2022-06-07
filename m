Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD553F6D6
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 09:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiFGHGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 03:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiFGHGC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 03:06:02 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1AE278D;
        Tue,  7 Jun 2022 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654585561;
  x=1686121561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jWbsuIHrJN+5cFdPKLPeOfPe1+7UnUxLU2zZVZpE3PY=;
  b=nhSmlwywDOlSGrBjWrx79Wu3VyksoP0aluKzVBa9jMpf0P4vkP70q4y/
   4W160qmvnseY/6OrA8G0wM5ukOgaZt6hMOrnzELt8rWxnpNYpj8lyZZGH
   2DjWL/Uutms46DDepJRXi6kD3VOXoIzJ4nAJLhmM0m+c4vtioPs5Jsucq
   +cKBuFdlnzI6TP8/6cHeNJfiJwtPk7DYobDuP6ykSa+N5Otu9RCV3ti0C
   1OeRFgj9vJPJz7Kvi+1yt7osjtDY+B9nvMUtCZG4v+dzSRpXk0HDpeE/t
   aQl0mO3MKPP7eg12U1JzWV3xixK7q0J17174CTG6uub/yk522djVxQLtZ
   w==;
Date:   Tue, 7 Jun 2022 09:05:58 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Wangseok Lee <wangseok.lee@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        "Dongjin Yang" <dj76.yang@samsung.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add maintainer for Axis ARTPEC-8
 PCIe PHY driver
Message-ID: <20220607070558.GZ18902@axis.com>
References: <20220603024347epcms2p48d01596e10b251bec077581a6c609c48@epcms2p4>
 <20220603160913.GA80202@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220603160913.GA80202@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 06:09:13PM +0200, Bjorn Helgaas wrote:
> In subject:
> 
>   MAINTAINERS: Add Axis ARTPEC-8 PCIe PHY maintainers
> 
> to put the important things first so they don't get chopped off by
> "git log --oneline" and similar.
> 
> On Fri, Jun 03, 2022 at 11:43:47AM +0900, Wangseok Lee wrote:
> > Add maintainer for Axis ARTPEC-8 PCIe PHY.
> > 
> > Add Jesper Nilsson <jesper.nilsson@axis.com> and
> > Lars Persson <lars.persson@axis.com> as Maintainer for these files.
> 
> s/Maintainer/maintainers/
> 
> > ARTPEC-8 is the SoC platform of Axis Communications
> > and PCIe phy is designed based on Samsung PHY.
> 
> s/phy/PHY/ to match other uses.
> 
> Rewrap all of above to fill 75 columns.
> 
> > Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> 
> Obviously we'll look for acks from Jesper and Lars.

:-)

> Also would be good if Jesper explicitly acked the fact that his
> existing "PCIE DRIVER FOR AXIS ARTPEC" entry also matches the new
> pcie-artpec8.c driver:
> 
>   PCIE DRIVER FOR AXIS ARTPEC
>   M:      Jesper Nilsson <jesper.nilsson@axis.com>
>   L:      linux-arm-kernel@axis.com
>   L:      linux-pci@vger.kernel.org
>   S:      Maintained
>   F:      Documentation/devicetree/bindings/pci/axis,artpec*
>   F:      drivers/pci/controller/dwc/*artpec*

Yes, both the ARTPEC-6 and ARTPEC-8 models of the DWC PCIe drivers
is intended to match this entry.

It can be made explicit if that is preferred.

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
