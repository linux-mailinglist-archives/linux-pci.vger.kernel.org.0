Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A993CB222
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 07:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhGPGBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 02:01:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41284 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhGPGBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 02:01:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C96121FE77;
        Fri, 16 Jul 2021 05:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626415121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYIigAxYwispkLuMBrPkid9orRqcsiYIuekYbWks1Y4=;
        b=iYiycSOPSEOVVhQ94xubr0XPtmwfAzMosr9rhZhUbkWV8MvzW5Qqz4Ntsm6bFgWD3doI+u
        BU3NkADbYtnPGPPnDhiMkr98zaH0h1snutm4x1DqQrB8sUYt3njCC3u0NX4WkaGLfGJQrq
        RbvxH1a6vJlE/1hJF1cwYN8KtNDtrQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626415121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYIigAxYwispkLuMBrPkid9orRqcsiYIuekYbWks1Y4=;
        b=UEcL4hvyMhr/D5ENi1lbGWyTUO8JzcMRFZWDihZBdGRPZEP9IEC+CMXVsXO+AveQQm3Qk6
        /ZrprqCh/Wzph5AA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A858B13344;
        Fri, 16 Jul 2021 05:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ZF1pJxEg8WCxOQAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:58:41 +0000
Subject: Re: [PATCH 1/5] PCI/VPD: Correct diagnostic for VPD read failure
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-2-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6ae09029-46fb-bb19-e182-459e2e501108@suse.de>
Date:   Fri, 16 Jul 2021 07:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/15/21 11:59 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously, when a VPD read failed, we warned about an "invalid large
> VPD tag".  Warn about the VPD read failure instead.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 26bf7c877de5..7bfb8fc4251b 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -92,8 +92,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>   			    (tag == PCI_VPD_LTIN_RW_DATA)) {
>   				if (pci_read_vpd(dev, off+1, 2,
>   						 &header[1]) != 2) {
> -					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
> -						 tag, off + 1);
> +					pci_warn(dev, "failed VPD read at offset %zu",
> +						 off + 1);
>   					return 0;
>   				}
>   				off += PCI_VPD_LRDT_TAG_SIZE +
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
