Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061AE3BDB49
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGFQYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 12:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhGFQYr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 12:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B30161C23;
        Tue,  6 Jul 2021 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625588528;
        bh=QTLRfV9sHdHS7pS+1Sr8ncVUzTJBLmHY17mt0+PAkc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tUbqxQlKftBKpcZ11sqoLSFpJ5Vys6JVMBdh2a/1HBEdcfrvV7+amyCs6LH97hOBZ
         vSjI3xuXd9o58UakYQ/jKSrLltRmh54dFjTj7Z9diOd0w6Rw+W0aC5pgGl0S5567dH
         cIy7ZfSELybQk2fVZKIUq1WqYYJ1/dNSNItoDnhbUumDl62DRKFTB8rGAaeCrgZaVT
         Cax8qHY+BHRX8N9i8AOnvVRcDMpEqiflPcb+Sd6ajDIju0EcCja/yNoV4eZhj3auYf
         4fYKN+i4aVx/8Ui0N8h3A2X04ElBwsTQSXpcUBcDVjA91gxo4Y+zlwFL/CGI6g8QU1
         hSkiFx2ze5GGw==
Date:   Tue, 6 Jul 2021 11:22:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Scott Murray <scott@spiteful.org>,
        Tom Joseph <tjoseph@cadence.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Fix kernel-doc formatting
Message-ID: <20210706162201.GA800251@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210703151306.1922450-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 03, 2021 at 03:13:02PM +0000, Krzysztof Wilczyński wrote:
> Fix kernel-doc formatting of function pci_dev_set_io_state(), and
> resolve build time warnings related to kernel-doc:
> 
>   drivers/pci/pci.h:337: warning: Function parameter or member 'dev' not described in 'pci_dev_set_io_state'
>   drivers/pci/pci.h:337: warning: Function parameter or member 'new' not described in 'pci_dev_set_io_state'
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

I squashed these together and applied to pci/kernel-doc for v5.14,
thanks!

> ---
>  drivers/pci/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 37c913bbc6e1..c1ac65cc4572 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -324,8 +324,8 @@ struct pci_sriov {
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> - * @dev - pci device to set new error_state
> - * @new - the state we want dev to be in
> + * @dev: pci device to set new error_state
> + * @new: the state we want dev to be in
>   *
>   * Must be called with device_lock held.
>   *
> -- 
> 2.32.0
> 
