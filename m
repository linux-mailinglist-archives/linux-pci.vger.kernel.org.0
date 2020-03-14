Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17CE1858A7
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 03:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCOCQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 22:16:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46885 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCOCQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Mar 2020 22:16:59 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 6d6fd7fd2b52e13a; Sat, 14 Mar 2020 11:16:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Use scnprintf() for avoiding potential buffer overflow
Date:   Sat, 14 Mar 2020 11:16:57 +0100
Message-ID: <3406356.oH3LicebqW@kreacher>
In-Reply-To: <20200311070958.3791-1-tiwai@suse.de>
References: <20200311070958.3791-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, March 11, 2020 8:09:58 AM CET Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d1e666ef3fcc..f92df2533e7e 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -153,7 +153,7 @@ static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
>  	buf[0] = '\0';
>  	for (i = 0, entry = table; i < size; i++, entry++)
>  		if (word & entry->bit)
> -			len += snprintf(buf + len, sizeof(buf) - len, "%s%s",
> +			len += scnprintf(buf + len, sizeof(buf) - len, "%s%s",
>  					len ? " " : "", entry->desc);
>  
>  	dev_info(&root->device->dev, "_OSC: %s [%s]\n", msg, buf);
> 

Applied as 5.7 material, thanks!




