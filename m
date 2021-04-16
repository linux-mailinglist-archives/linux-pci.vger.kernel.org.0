Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F055A3628B7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 21:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbhDPTgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 15:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235029AbhDPTgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 15:36:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B348F613B4;
        Fri, 16 Apr 2021 19:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618601757;
        bh=6nsEld/AHz4O3V/FKZ7eZE/3Z4jHZfTnVOsQzEoVmqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ShJQH/ttUPnvDeFENN/fYbcliDcNW0ltqfXcBNZR03iyBqiUkzSJdyydh/ucrgHsX
         V1JflqEgdN597Kkj4fknxjhvEighrLaFI5zAjq1G+t0mF+NzotuM/iZayFMO58yq7r
         EAuAUC/lXReWCducjwlBxEE3taFe3zwOuOzUOxLshx2W2WFFk3lse7Dd0uTJW4SlY1
         euMplf+CQXaWuEtLq2Xr9sd3bP/44hiFUl3exV9lJgi5Y3kJFWchu9j0uQtdH0LX8x
         FzzMZ7iz7asrNfOB+5Y8TDlSNQC6m/9J3ccwjN0Q6eppQ3ibfYJcfEoi+PMAN1rgKG
         HrzftFEpORahQ==
Date:   Fri, 16 Apr 2021 14:35:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: acpiphp:  Fixed coding style
Message-ID: <20210416193555.GA2747805@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301072145.19018-1-chakravarthikulkarni2021@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 01, 2021 at 12:51:45PM +0530, chakravarthikulkarni wrote:
> In this commit fixed coding style for braces and comments.
> 
> Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>

Applied to pci/hotplug for v5.13, thanks!

I dropped the comment change because it's really one comment that
should remain connected, so it doesn't seem like an improvement to me
to add comment start/stop in the middle.

> ---
>  drivers/pci/hotplug/acpiphp.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
> index a74b274a8c45..e0964600a78f 100644
> --- a/drivers/pci/hotplug/acpiphp.h
> +++ b/drivers/pci/hotplug/acpiphp.h
> @@ -80,8 +80,8 @@ struct acpiphp_bridge {
>  struct acpiphp_slot {
>  	struct list_head node;
>  	struct pci_bus *bus;
> -	struct list_head funcs;		/* one slot may have different
> -					   objects (i.e. for each function) */
> +	struct list_head funcs;		/* one slot may have different */
> +					/* objects (i.e. for each function) */
>  	struct slot *slot;
>  
>  	u8		device;		/* pci device# */
> @@ -148,8 +148,7 @@ static inline struct acpiphp_root_context *to_acpiphp_root_context(struct acpi_h
>   * ACPI has no generic method of setting/getting attention status
>   * this allows for device specific driver registration
>   */
> -struct acpiphp_attention_info
> -{
> +struct acpiphp_attention_info {
>  	int (*set_attn)(struct hotplug_slot *slot, u8 status);
>  	int (*get_attn)(struct hotplug_slot *slot, u8 *status);
>  	struct module *owner;
> -- 
> 2.17.1
> 
