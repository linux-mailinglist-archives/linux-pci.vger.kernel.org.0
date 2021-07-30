Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC583DB332
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhG3GHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 02:07:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhG3GHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jul 2021 02:07:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF63822366;
        Fri, 30 Jul 2021 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627625228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRsRDdlU685DLppRdDKEQo/+HbPb42shZouwAcyZngU=;
        b=FNAezWsX80MDG+FnFUI+PsLwtpwsYDRKkrzCnsoO37hA0/k+p8Li5RlMEJYKsjDg7OnQ8K
        s4xN8VmQjdZ2oIo8IR1/EoAhSy/1Rf5H7doP5HM9yRgZg4XVIAHmZ3JtuB2mILvqFyOZai
        w4LD/Yw66RXGh6tnAPpwLmR3nfm1Ipk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627625228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRsRDdlU685DLppRdDKEQo/+HbPb42shZouwAcyZngU=;
        b=mBfHNKgX8olLyh5WKNYPcMuVXLQ5b7EhDJUK19FsuhVAokyeHu76aFDXlyvLOrJyy+ClvN
        ZgY+4tFN7SCw8+Bw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AEA0213748;
        Fri, 30 Jul 2021 06:07:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Tg5NKQyXA2GbbQAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 30 Jul 2021 06:07:08 +0000
Subject: Re: [PATCH v2 4/6] PCI/VPD: Reject resource tags with invalid size
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20210729184234.976924-1-helgaas@kernel.org>
 <20210729184234.976924-5-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <562a0dc2-4318-9f68-28e8-fcc094d5fba4@suse.de>
Date:   Fri, 30 Jul 2021 08:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729184234.976924-5-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/29/21 8:42 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> VPD is limited in size by the 15-bit VPD Address field in the VPD
> Capability.  Each resource tag includes a length that determines the
> overall size of the resource.  Reject any resources that would extend past
> the maximum VPD size.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
