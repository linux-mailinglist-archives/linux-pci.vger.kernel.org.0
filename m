Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108B33B97EB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 23:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhGAVDD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 17:03:03 -0400
Received: from smtp1.axis.com ([195.60.68.17]:19152 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAVDC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 17:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1625173232;
  x=1656709232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R0kTH48qWNKSufUjD7KoFSM5ezWEiVcEeIRKcZCw4ag=;
  b=du3ne0TCeCKn2RvMPT0//ZIzfiB1aXRe9dgXBU0VNNMKNPEM6ZQjvXyC
   aPmLSRHj9HHsktHDuS1Go04R265imdfnfxJ0dwlvFRkgeFHa3KVOVYpDO
   8EyLKxFSJcZGshYSDQ3Lwn6QzjIW9SqSFMz/zkSP1zKDCmfOwaqv3I9Gu
   DXyqUr9Ssw1lcRpHfRThDGjXlR2bd3LgXO6Z3PlaCn/5Iyi9+T6aITbBy
   z+nqFI8zSQ9tRjlSZbq/zpuX3biwtzDn9/B6WshG+gD4MCNQKHtPRQH8R
   FetBPKDpj24S/oqmoP35Of5l5QKyLmTBBVtgrFkK1B7CSY4vJ2uKySGZk
   A==;
Date:   Thu, 1 Jul 2021 23:00:30 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: artpec6: Remove local code block from within
 switch statement
Message-ID: <20210701210030.GO6299@axis.com>
References: <20210701204401.1636562-1-kw@linux.com>
 <20210701204401.1636562-2-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701204401.1636562-2-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 10:44:01PM +0200, Krzysztof Wilczyński wrote:
> At the moment, the switch statement in the artpec6_pcie_probe() has
> a local code block where the local variable "val" is defined and
> immediately used by the artpec6_pcie_readl() within this local scope.
> 
> This extra code block adds brackets at the same indentation level as the
> switch statement itself which can hinder readability of the code.
> 
> Thus, move the variable "val" declaration and definition at the top of
> the function where other variables are already present, and remove the
> extra code block from within the select statement.  This also is the
> preferred style in the PCI tree.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>


/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
