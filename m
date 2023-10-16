Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1097CAF75
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjJPQdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjJPQdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 12:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508183F7;
        Mon, 16 Oct 2023 09:25:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4E9C433C8;
        Mon, 16 Oct 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697473515;
        bh=9/hvt23CkWCSd3t6m1C0dNGRoz/pDYrD0zUCEPxSYzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kiSnPKMNWSc95QJN5Az/vICl/XNckWm+QRY8UKi+Q+sgo8Kd1v1mfRpTIZLxZLbUk
         l5F8vNrg1UbMfoa4oRxpvtjO1rkGvCGVfIhxta/gcuOkdYZ/hE7oXDLHxlok/gn5yI
         XTPh/f6xrE1xZ/5JuAKxAYsbR+DOPQzzrnr4+VX8dNMbEo3O/OlVESsC9mo2iFmV8Q
         MciK2/Nq/ach9GVBOF97X9rCnLqxQEYsTczGmFw93BX1W4N1XGLr1gpydUVV7EofJR
         wAtIZ6+TuoliVQwBK7n0klE/d7D4yWx2gw4Gl8tp57B4ZDVmQRHWMJGRCeHO6pIwnX
         S8KWc+1PpKGHQ==
Date:   Mon, 16 Oct 2023 11:25:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        imx@lists.linux.dev, Rob Herring <robh@kernel.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Zang <roy.zang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>, Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCH 2/3] PCI: layerscape: add suspend/resume for ls1021a
Message-ID: <20231016162512.GA1212231@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1gmJiz8+PKIuwp@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 12:11:04PM -0400, Frank Li wrote:
> On Mon, Oct 16, 2023 at 10:22:11AM -0500, Bjorn Helgaas wrote:

> > Obviously Lorenzo *could* edit all your subject lines on your behalf,
> > but it makes everybody's life easier if people look at the existing
> > code and follow the style when making changes.
> 
> Understand, but simple mark 'a' and 'A' to me. I will update patches and
> take care for next time instead search whole docuemnt to guess which one
> violated. I know I make some mistakes at here. But I am working on many
> difference kernel subsystems, some require upper case, some require low
> case, someone doesn't care.

Right, that's why I always suggest following the example of the
surrounding code and history.  English is the only language I know,
but I speculate that this typographical detail probably doesn't make
sense in languages that don't have a similar upper/lowercase
distinction.

Thanks for persevering; we'd be having a lot more trouble if I tried
to send emails in your native language ;)

Bjorn
