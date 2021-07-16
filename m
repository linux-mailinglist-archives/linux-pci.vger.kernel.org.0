Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A103CB22E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 08:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhGPGGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 02:06:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhGPGGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jul 2021 02:06:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4B2922ADF;
        Fri, 16 Jul 2021 06:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626415426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sonqn85OwhABdkod21g6sntqtZo4q2TdakNoiG7TzEw=;
        b=v1PICAt3wnYTmhXq985JFIZJFRejk5qt8u6T3ZPT8AQVa+5Ti4oAWAzD7JFe4gisH5NTp0
        WT5v3weB0l2mlSPwmVfi5RbnygupwQ7rfDGNknHi4p+5lARsac33CXkPIWEsk/9SaoFwk2
        P54NXzLb8lA9k9H1hnz6JvKMZCXArMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626415426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sonqn85OwhABdkod21g6sntqtZo4q2TdakNoiG7TzEw=;
        b=VvheIT2iRb0S+g5ul8/TEanswU5zcIljjWsIpI/pYtqwo6AmOzUypn+yUgXbZmksYLXo4Z
        Sc2X9gkWOQg6zKAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A7D8113344;
        Fri, 16 Jul 2021 06:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BachJ0Ih8WA7OwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 06:03:46 +0000
Subject: Re: [PATCH 4/5] PCI/VPD: Don't check Large Resource types for
 validity
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-5-helgaas@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1b0fd08b-4603-d7af-b936-95a3e451ee0c@suse.de>
Date:   Fri, 16 Jul 2021 08:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-5-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/15/21 11:59 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> VPD consists of a series of Small and Large Resources.  Computing the size
> of VPD requires only the length of each, which is specified in the generic
> tag of each resource.  We only expect to see ID_STRING, RO_DATA, and
> RW_DATA in VPD, but it's not a problem if it contains other resource types.
> 
> Drop the validity checking of Large Resource items.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/vpd.c | 37 ++++++++++++++-----------------------
>   1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 9c2744d79b53..d7a4a9f05bd6 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -82,31 +82,22 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>   		if (header[0] & PCI_VPD_LRDT) {
>   			/* Large Resource Data Type Tag */
>   			tag = pci_vpd_lrdt_tag(header);
> -			/* Only read length from known tag items */
> -			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
> -			    (tag == PCI_VPD_LTIN_RO_DATA) ||
> -			    (tag == PCI_VPD_LTIN_RW_DATA)) {
> -				if (pci_read_vpd(dev, off+1, 2,
> -						 &header[1]) != 2) {
> -					pci_warn(dev, "failed VPD read at offset %zu",
> -						 off + 1);
> -					return 0;
> -				}
> -				size = pci_vpd_lrdt_size(header);
> -
> -				/*
> -				 * Missing EEPROM may read as 0xff.
> -				 * Length of 0xffff (65535) cannot be valid
> -				 * because VPD can't be that large.
> -				 */
> -				if (size > PCI_VPD_MAX_SIZE)
> -					goto error;
> -				off += PCI_VPD_LRDT_TAG_SIZE + size;
> -			} else {
> -				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
> -					 tag, off);
> +			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
> +				pci_warn(dev, "failed VPD read at offset %zu",
> +					 off + 1);
>   				return 0;
>   			}
> +			size = pci_vpd_lrdt_size(header);
> +
> +			/*
> +			 * Missing EEPROM may read as 0xff.  Length of
> +			 * 0xffff (65535) cannot be valid because VPD can't
> +			 * be that large.
> +			 */
> +			if (size > PCI_VPD_MAX_SIZE)
> +				goto error;
> +
> +			off += PCI_VPD_LRDT_TAG_SIZE + size;
>   		} else {
>   			/* Short Resource Data Type Tag */
>   			tag = pci_vpd_srdt_tag(header);
> 
I'm not entirely happy with this; we really have to rely on well-formed 
VPD tags for the protocol to work correctly, and that's why I took the 
cautious approach. But with the check for missing EEPROM I hope we've 
covered the most common causes for invalid tags. Let's see how it goes.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
