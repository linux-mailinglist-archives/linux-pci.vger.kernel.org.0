Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF53CB223
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 07:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhGPGCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 02:02:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhGPGCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 02:02:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C12F1FE72;
        Fri, 16 Jul 2021 05:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626415147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCblBYeEU4nd7DNf1lV5Oh3mb0dZf/aFJYP9wR0QqHE=;
        b=GjC1hVGFsGpruh8y8lT604EsfP7gQZzsZ8BJEvbO+u+PvtyljWFou7aO55KcZHJg+Dmcsl
        YvEH1N7GjodG1GuV9mEbovWzPfOUQbrfbQIU9p2Df6cMPiNPYa2blAWRRlFaYlPXFiYyiN
        Y33Up0/hLfvgfhsKeGejiXxDSf8/mpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626415147;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCblBYeEU4nd7DNf1lV5Oh3mb0dZf/aFJYP9wR0QqHE=;
        b=fdsW8NvltKZL0R7NldOG2rrhx5jovT0QGP+LkbtmM609odCV5hWOEh7odrN2ov1dTnCzVE
        M7d40sP4DVB19sBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 00B0013344;
        Fri, 16 Jul 2021 05:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xCOBOiog8WDcOQAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:59:06 +0000
Subject: Re: [PATCH 2/5] PCI/VPD: Check Resource tags against those valid for
 type
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-3-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <923539de-b10a-d0a6-917d-cf364a6af6ef@suse.de>
Date:   Fri, 16 Jul 2021 07:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-3-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/15/21 11:59 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously, we checked for PCI_VPD_STIN_END, PCI_VPD_LTIN_ID_STRING, etc.,
> outside the Large and Small Resource cases, so we checked Large Resource
> tags against a Small Resource name and vice versa.
> 
> Move these tests into the Large and Small Resource cases, so we only check
> PCI_VPD_STIN_END for Small Resources and PCI_VPD_LTIN_* for Large
> Resources.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
