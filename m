Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1823DB327
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 08:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhG3GEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 02:04:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhG3GEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jul 2021 02:04:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E0CF2238B;
        Fri, 30 Jul 2021 06:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627625070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsh0Hh6MnNbKPqV7Ft1dm0wDgyG++wyyp/97vUv85js=;
        b=ZQYvOoQ7a3oYWr+WNY9ZQygaE7dnRY0THGAEBg7L73GwQptNXzkCIRety6HJsk9bn7YJpc
        MOSmcrDuNAZOwSrGXChuLEtYIkuLzd4WPKUgJkVkEuB7xp1xSH8eaUa+UPytXMQ3u8f5Wz
        F9vvR/ezPK7Nu3ewnLinjkhJDizE8nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627625070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsh0Hh6MnNbKPqV7Ft1dm0wDgyG++wyyp/97vUv85js=;
        b=kkiGOgWihMg+c8KRyyRxLpmW2AHhoPvyyxxVQrHXWrVVDem2D1kkNsC7AGCuWcYYVKQRLR
        Dl0nmvoMjOsneVBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 28EEC13748;
        Fri, 30 Jul 2021 06:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pt4tCW6WA2HWbAAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 30 Jul 2021 06:04:30 +0000
Subject: Re: [PATCH v2 3/6] PCI/VPD: Treat initial 0xff as missing EEPROM
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20210729184234.976924-1-helgaas@kernel.org>
 <20210729184234.976924-4-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4ebcfea3-aea1-f689-9754-94e7c1e250a6@suse.de>
Date:   Fri, 30 Jul 2021 08:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729184234.976924-4-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/29/21 8:42 PM, Bjorn Helgaas wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Previously we assumed that the first tag being 0x00 meant an EEPROM was
> missing.  The first tag being 0xff means the same thing; check for that
> also.
> 
> [bhelgaas: rework error mesage]
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
