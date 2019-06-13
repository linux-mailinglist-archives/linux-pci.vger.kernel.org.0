Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB044DEA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfFMU5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMU5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 16:57:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBAA2147A;
        Thu, 13 Jun 2019 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560459442;
        bh=ynYXrVPpg6dMM+W2dK/RdVD0nFgDHcTYdgal/Qhx8Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWlcQbiLe3rTPsZji+iFlViw6PrJntxG8S0JZevnNOTMhHHjmxZcOHB3pSTOiunUo
         gLpdLf+LonjG2jYsPB4oXCRMic8z2mKlq+MNB6LqPJeEfSDuWNq7fvnMAttvPWOXuX
         O++HrLO3wfuiFefro6+QZAEjOHCaO5EBMVBvpSdU=
Date:   Thu, 13 Jun 2019 15:57:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de
Subject: Re: [PATCH v2 0/2] PCI: device link quirk for NVIDIA GPU
Message-ID: <20190613205720.GK13533@google.com>
References: <20190606092225.17960-1-abhsahu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606092225.17960-1-abhsahu@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 02:52:23PM +0530, Abhishek Sahu wrote:
> * v2:
> 
> 1. Make the pci device link helper function generic which can be
>    used for other multi-function PCI devices also.
> 2. Minor changes in comments and commit logs.
> 
> * v1:
> 
> NVIDIA Turing GPU [1] has hardware support for USB Type-C and
> VirtualLink [2]. The Turing GPU is a multi-function PCI device
> which has the following four functions:
> 
> 	- VGA display controller (Function 0)
> 	- Audio controller (Function 1)
> 	- USB xHCI Host controller (Function 2)
> 	- USB Type-C USCI controller (Function 3)
> 
> Currently NVIDIA and Nouveau GPU drivers only manage function 0.
> Rest of the functions are managed by other drivers. These functions
> internally in the hardware are tightly coupled. When function 0 goes
> in runtime suspended state, then it will do power gating for most of
> the hardware blocks. Some of these hardware blocks are used by
> the other PCI functions, which leads to functional failure. In the
> mainline kernel, the device link is present between
> function 0 and function 1.  This patch series deals with creating
> a similar kind of device link between function 0 and
> functions 2 and 3.
> 
> [1] https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf
> [2] https://en.wikipedia.org/wiki/VirtualLink
> 
> Abhishek Sahu (2):
>   PCI: Code reorganization for creating device link
>   PCI: Create device link for NVIDIA GPU

Applied to pci/misc for v5.3, thanks!
