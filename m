Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A333B97E2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhGAVCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 17:02:08 -0400
Received: from smtp1.axis.com ([195.60.68.17]:19115 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhGAVCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 17:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1625173177;
  x=1656709177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=53cbPrL/BqBfqsi+XFO6AhQ2NXIxqrG4Dytf1cbqaqk=;
  b=LAPjwtdAP423KIQlPYLTirsgllHL3P4FHut/sErwJwd+FuUa+qEGm7f8
   Zi2OM9yhZSLWd0jxAWWuh3fWWTcY21c8BRQ8XuNTkzRvZ80PInw160bes
   mC6im8zw1r0FBTV3DXHR+I4cr2TgxVk/efA+2eIzJX01D34VJETj6SEfp
   +fqncTBiRTbYJqJAwot9InPIgN0LFMlRXjf1JsQZAxCelZ+NTaTRv5kMw
   iKLUhLu/tqfE+1Qqa5YUGMKL3PELdlwzz46OlifA8soaMdeCVSJX7FWP6
   O0Nv5CGbhkX1ZHBhfMsYu/vflu/XQCj7uDcxgsPRIBvZAg9Ab+ROUQKP6
   Q==;
Date:   Thu, 1 Jul 2021 22:59:36 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: artpec6: Remove surplus break statement
 after return
Message-ID: <20210701205936.GN6299@axis.com>
References: <20210701204401.1636562-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701204401.1636562-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 10:44:00PM +0200, Krzysztof Wilczyński wrote:
> As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
> dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
> code") the function artpec6_add_pcie_ep() has been removed and the call
> to the dw_pcie_ep_init() has been moved into artpec6_pcie_probe().
> 
> This change left a break statement behind that is not needed any more as
> as the function artpec6_pcie_probe() return immediately after making
> a call to dw_pcie_ep_init().
> 
> Thus remove this surplus break statement that became a dead code.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>


/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
