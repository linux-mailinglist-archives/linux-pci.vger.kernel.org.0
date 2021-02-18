Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5815531F321
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 00:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBRXd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 18:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBRXd4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 18:33:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9DF864EB8;
        Thu, 18 Feb 2021 23:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613691195;
        bh=r8wYBiYSc8JSSVKz0juViq5OtE+nP++D7BABD8XUIy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sYS30CvjUMSK7xvw4uT46NXq3SlilX5C2MHK4KSfbX3JCszqLGQb5S6ZV8L4yyQM+
         NKrANau0TZlIYgCc3cueJ1H1tC995BaeG9GObY1ufNWPUzKLciJ1ibnFkP8/UVwbHJ
         Tldod2usSqdtowmwB+LhBDbMxKPYpWJr7sOOZ0Ja5uU/32b0DfN4Q1WiYg1wsxeHOu
         kIaT+3LDFwyTxs+20R8Vh9RSDhUpEiAka7ehcMv3oESA51PnGgWkT3OUkCx4ojPzX+
         nCUioPmWTPi5hu3ea3udPuYO53F3ZRZeB1LVmYKaIysJjDzBypH72aToD1phqC0iqE
         8d4mQMuurLRvw==
Date:   Thu, 18 Feb 2021 17:33:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen Lin <chen45464546@163.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
Subject: Re: [PATCH] PCI: hotplug: Remove unused function pointer typedef
 acpiphp_callback
Message-ID: <20210218233313.GA1147787@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613443120-4279-1-git-send-email-chen45464546@163.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 16, 2021 at 10:38:40AM +0800, Chen Lin wrote:
> From: Chen Lin <chen.lin5@zte.com.cn>
> 
> Remove the 'acpiphp_callback' typedef as it is not used.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>

Applied to pci/hotplug for v5.12, thanks!

> ---
>  drivers/pci/hotplug/acpiphp.h |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
> index a2094c0..a74b274 100644
> --- a/drivers/pci/hotplug/acpiphp.h
> +++ b/drivers/pci/hotplug/acpiphp.h
> @@ -176,9 +176,6 @@ struct acpiphp_attention_info
>  int acpiphp_register_hotplug_slot(struct acpiphp_slot *slot, unsigned int sun);
>  void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
>  
> -/* acpiphp_glue.c */
> -typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
> -
>  int acpiphp_enable_slot(struct acpiphp_slot *slot);
>  int acpiphp_disable_slot(struct acpiphp_slot *slot);
>  u8 acpiphp_get_power_status(struct acpiphp_slot *slot);
> -- 
> 1.7.9.5
> 
> 
