Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A703A380D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFJXsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFJXsV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:48:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0375613DE;
        Thu, 10 Jun 2021 23:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623368784;
        bh=WDuWMsvpghvTRWcjdtYHJr/n7BDvdmoOD5B89LlGL4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=frORLSSxdxjCBOz8py5gGyu+Opfyl0zwNmCm5+dWqjfWVO6pwxREiFBpJq8l4Mqqd
         1yjFDQ8EHXh/PK8gAmUPjviIrsH6t/IG9QOIxJB3PtbLEo315ruyDfDvdxvEwREPSt
         L6j+DIHsJvD+7qEf0IYf8a9bZEEL7X/RQCLl4ozMeImTDjxmjZpFadMIY0gz0QftQT
         IrktjAPz99rRLZc5prXkTyoax8hJ+febfRMBxOL8Q6uKy4nvOdBwjFm2EZeS9xHl4E
         E7bDGOUkt4DbctCEou6tINIqDfbQHRf16LGDNQhYc1UICmSQDBNUILBE1sqstEwvUL
         qKG6TmfRZa63A==
Date:   Thu, 10 Jun 2021 18:46:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 26/34] docs: PCI: endpoint: pci-endpoint-cfs.rst: avoid
 using ReSt :doc:`foo` markup
Message-ID: <20210610234622.GA2795707@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5268f6eb75bc0fe000f4884bca0a17f01eddbc40.1622898327.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 05, 2021 at 03:18:25PM +0200, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

It'd be nice to know why we're doing this and what the benefit is.

Maybe if you know more about ReSt, it's obvious that using :doc:`foo`
is wrong and produces the wrong output or something.  But I don't
know.

I do think the pathname in the new text is easier for plain-text
readers to follow.

(What's the correct spelling of "ReSt", BTW?  The cover letter has
"ReST", this patch has "ReSt", wikipedia says "RST, ReST, or reST".)

But anyway,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/endpoint/pci-endpoint-cfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> index 696f8eeb4738..db609b97ad58 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> @@ -125,4 +125,4 @@ all the EPF devices are created and linked with the EPC device.
>  						| interrupt_pin
>  						| function
>  
> -[1] :doc:`pci-endpoint`
> +[1] Documentation/PCI/endpoint/pci-endpoint.rst
> -- 
> 2.31.1
> 
