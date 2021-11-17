Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38832454F5E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 22:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhKQVfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 16:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhKQVe7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 16:34:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5190C061570
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 13:31:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d27so7316626wrb.6
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=95W2C1E8r+p3qYfzaxdRnETijblYuybK4iW6YwLMhGE=;
        b=U74vNO5AdKfp12jZzAmRC5gg0Pj9N4KQLNbuY4YFWupeSj7O4HGwti6cYZg5lgtLzs
         3dDhDd8UdOLaz+xN3jo3amI+xjieuwVB/D8BCi+fqjxeIGYQLy2udteP2pbwpqy96Rlk
         GvK0p/CCxFUrf8HCSIsEVynO2tK4geKlKK+a0NyQUKoww0WMFfBAZSTbayOFY5Zo7qX0
         85RF6r3liic0omewnoXCHrfqOvbS8UQev9d9CCQWhW+hbpZJwIleoD0QPtuuIIWue8Jy
         zyCp3TUiLNB4C/W72YdItC7qE5+uQdTOZNPq2FooMp3doeYIDXwzzrCjKz/jFbSL68zZ
         rP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=95W2C1E8r+p3qYfzaxdRnETijblYuybK4iW6YwLMhGE=;
        b=gWkCJSKslmK36oE4UXW+YqoYRhUZtySZbgHo3ZSsJyEzFE2hJnQttTAWU63NH5DaFn
         qs1BuMJtUNcPzwVsmD27W+vLOfn7opHKfX+YiuYh5jcyYSXVjr8EJljL3f/5AXLS83RC
         NxBF55jH/XMsBC+nPBxZqq7tkHpHi9jkFX/N8lHHAEVOOBZubSaCb1eVJfO91nOWo32X
         LDMOCKx9LUwgyys63HIRxEHQB7UhQ2bDVSgbs9ckWCQeyLy0qMYnRYR7fWY6Sqa/n4g0
         /lDAmQR/0mllMHrE8m5xcElWhhaA582K4p88jc3mCcV1yUYrMs5zYV+5saqRNECYq6r6
         MTQQ==
X-Gm-Message-State: AOAM530+bayu3JLORy8aLGp+gue92oImlVFUb0v45yaRL3t1K/upc26W
        aUmpYZQ1foahm5Rr4GUwYYI1TNmhfI4=
X-Google-Smtp-Source: ABdhPJzMGGxZsiCGrN3DsyjjMhNDYv3VVYuy8npPKVIAtjM44nUfi97C2c9+Tel7Cc6veytHWAjnaQ==
X-Received: by 2002:a5d:42cc:: with SMTP id t12mr24093573wrr.129.1637184717624;
        Wed, 17 Nov 2021 13:31:57 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:f0f5:b870:7292:e828? (p200300ea8f1a0f00f0f5b8707292e828.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:f0f5:b870:7292:e828])
        by smtp.googlemail.com with ESMTPSA id z7sm6469833wmi.33.2021.11.17.13.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 13:31:57 -0800 (PST)
Message-ID: <e3d20c2f-f1be-507e-5ddc-df3241aef1c0@gmail.com>
Date:   Wed, 17 Nov 2021 22:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] PCI/VPD: Add simple sanity check to pci_vpd_size()
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <223ffa56-7c2c-643a-d3a0-2175e85f6603@gmail.com>
In-Reply-To: <223ffa56-7c2c-643a-d3a0-2175e85f6603@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.10.2021 20:37, Heiner Kallweit wrote:
> We have a problem with a device where each VPD read returns 0x33 [0].
> This results in a valid VPD structure (except the tag id) and
> therefore pci_vpd_size() scans the full VPD address range.
> On an affected system this took ca. 80s.
> 
> That's not acceptable, on the other hand we may not want to re-add
> the old tag checks. In addition these tag check still wouldn't be able
> to avoid the described scenario 100%.
> Instead let's add a simple sanity check on the number of found tags.
> A VPD image conforming to the PCI spec [1] can have max. 4 tags:
> id string, ro section, rw section, end tag.
> 
> [0] https://lore.kernel.org/lkml/20210915223218.GA1542966@bjorn-Precision-5520/
> [1] PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a4fc4d069..921470611 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -56,6 +56,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  {
>  	size_t off = 0, size;
>  	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
> +	int num_tags = 0;
>  
>  	while (pci_read_vpd_any(dev, off, 1, header) == 1) {
>  		size = 0;
> @@ -63,6 +64,10 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
>  			goto error;
>  
> +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
> +		if (++num_tags > 4)
> +			goto error;
> +
>  		if (header[0] & PCI_VPD_LRDT) {
>  			/* Large Resource Data Type Tag */
>  			if (pci_read_vpd_any(dev, off + 1, 2, &header[1]) != 2) {
> 

Can this one be picked up for next?
