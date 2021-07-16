Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A13CB227
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 08:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGPGDc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 02:03:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhGPGDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 02:03:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 801681FE78;
        Fri, 16 Jul 2021 06:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626415236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXTx1jJn16eV2r22CbIGZfIeQDA+J+B+QbdU0gish4M=;
        b=l0j0NDeLlwVUBviO9pW8UurYqo3905j7m5iwQLP8hUpiNSZohbx2IcWaNnfqIla5eQgG5E
        dJfeaJT+hrWZiDGiceGP4YRGxw7T9YQ4nb4584xpWxSb9Wa4TJ2+QhmMLR6gMw/Hy8P9Uv
        BHEQGORmn8IJhOcvorw7S35tzj/SiOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626415236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXTx1jJn16eV2r22CbIGZfIeQDA+J+B+QbdU0gish4M=;
        b=zbgX2f0eKymZqvFQQrXUTGVofJajjy693M+yo06v5sPar8Rqvkrk02O4al+UF+LSj3Ji2A
        oSMof9UTiK7dyyAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5C52E13344;
        Fri, 16 Jul 2021 06:00:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LzaZFYQg8WB6OgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 06:00:36 +0000
Subject: Re: [PATCH 3/5] PCI/VPD: Consolidate missing EEPROM checks
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-4-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3fa5546c-aa58-6331-fec9-1f8ec6d98182@suse.de>
Date:   Fri, 16 Jul 2021 08:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-4-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/15/21 11:59 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> A missing VPD EEPROM typically reads as either all 0xff or all zeroes.
> Both cases lead to invalid VPD resource items.  A 0xff tag would be a Large
> Resource with length 0xffff (65535).  That's invalid because VPD can only
> be 32768 bytes, limited by the size of the address register in the VPD
> Capability.
> 
> A VPD that reads as all zeroes is also invalid because a 0x00 tag is a
> Small Resource with length 0, which would result in an item of length 1.
> This isn't explicitly illegal in PCIe r5.0, sec 6.28, but the format is
> derived from PNP ISA, which *does* say "a small resource data type may be
> 2-8 bytes in size" (Plug and Play ISA v1.0a, sec 6.2.2.
> 
> Check for these invalid tags and return VPD size of zero if we find them.
> If they occur at the beginning of VPD, assume it's the result of a missing
> EEPROM.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 36 +++++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
Very good idea.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
