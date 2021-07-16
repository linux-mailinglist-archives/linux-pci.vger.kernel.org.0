Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE90B3CB232
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhGPGHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 02:07:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42538 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhGPGHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 02:07:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 986931FE72;
        Fri, 16 Jul 2021 06:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626415498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMIb1E0LH4ttiFF4KNEjgDK3qmNBqfsw69TFe8p3iFo=;
        b=UymVGksTxrXxjz8FB9fwFF/sqr4t63nLbQUYL9S2kZQsO5eRLp/MIgEuztf0cWqjCNFv0S
        PjyV+2gJHUyYUkw5xghZbwBWOw+2VRHSul7azJdma6a9STzJBYGqddjAVWGbA8pGDBPS8H
        ZD0AODKZN6i9wgfKrTl/ItohrMUHTzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626415498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMIb1E0LH4ttiFF4KNEjgDK3qmNBqfsw69TFe8p3iFo=;
        b=aCoUXXG1JNpCRG5Hd9JkTDYPD3IZof37qzD/1BikybVohMKs1yJ3SwdfM54Q4so15iqFwf
        h57ipLYG2PSGw8AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 13B8013344;
        Fri, 16 Jul 2021 06:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id NRknM4kh8WDpOwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 06:04:57 +0000
Subject: Re: [PATCH 5/5] PCI/VPD: Allow access to valid parts of VPD if some
 is invalid
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-6-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0c4cd88c-4ebf-168d-4202-b596e5aab2ca@suse.de>
Date:   Fri, 16 Jul 2021 08:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-6-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/15/21 11:59 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously, if we found any error in the VPD, we returned size 0, which
> prevents access to all of VPD.  But there may be valid resources in VPD
> before the error, and there's no reason to prevent access to those.
> 
> "off" covers only VPD resources known to have valid header tags.  In case
> of error, return "off" (which may be zero if we haven't found any valid
> header tags at all).
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
D'oh. Of course.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
