Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5033F3EB7
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhHVIyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 04:54:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1455C061575;
        Sun, 22 Aug 2021 01:53:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d26so824288wrc.0;
        Sun, 22 Aug 2021 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hWrdUXFFT1hy7MQnE8Mf414YBD13mw+SDcsxULeOOEk=;
        b=rLgB4VALwSt44QTvaGD+817BpwPkoc8LU+mbN6W3sImV+OQ0RE7v03MbvyvI0qyzAZ
         5PsS4vEkUI39luGUxGYvw2gWjRelIji6wXOs56I/EZHtVxlhM+wsMFVpeyVKVPvJQO78
         qT+j6MmOVIzPEBkW4o0xSXVyBVHgHy5Z1kvScY54YyvVOkKndozqD1EBGd//Wtrz2Cyj
         rV7HkptEjvP1WCPzApY5zLx/jGB6YgnznLJGhBZcIiPXaVxmOR4JibVX3JGzqQkJAO8s
         q+CFf3WJFdDg0yTDkEFM0Q1CvPtYgf9ZHvcVuFwLQxtswYrPXS3Tf5HgZGI9KVBN6IPd
         eulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hWrdUXFFT1hy7MQnE8Mf414YBD13mw+SDcsxULeOOEk=;
        b=BNAhnTbB4kM+IpDZAzseiUIkpfALZmBJJAOF6hffsAuEtH+jtwbO6kulYUjPY0YGbV
         vxXW00/i2F9Rttij8yEQfA3jcDgGkoIcVYqdZC1ON8Hg82zYpVrzH3PmYH+pCfktIZpB
         mzc/OEraqKmM367/JqgZa9U81o8XcKqsPHm6qUJz9C7IraIK4vmZpdFb8neQoakt/xnr
         wgPUaJk8qKfWVzQm2BaccCBd4qNiFVM8IegNRcJZQJAjLQJQzyh0KPVGZuEAu89SSYv6
         CXhemEsmpjxKMdevO1hKoApcHMTJdpP0/yAuKbNZeCyYWqozDDlJePYWLrSM77at2suc
         RahA==
X-Gm-Message-State: AOAM5325TNo8SP4xui8BEXyOHANw1DvDyvpVKq5uiKEAZ+aw/AwzVTra
        RGQ7i+kAMPo7s109K72kUBGRf7sjfauJVw==
X-Google-Smtp-Source: ABdhPJy+9G/NDjSWeS03fUSf+0DXsM7P8UyIim0rVCaTq5iEuraxkSpc5tou6dJOpdol80OEeomilg==
X-Received: by 2002:adf:f748:: with SMTP id z8mr7770989wrp.25.1629622414727;
        Sun, 22 Aug 2021 01:53:34 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id e14sm6620743wrr.6.2021.08.22.01.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 01:53:34 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        sdonthineni@nvidia.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210819215655.84866-1-jeremy.linton@arm.com>
 <20210819215655.84866-4-jeremy.linton@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9796674a-5870-135c-2fdc-fb0d5347d7c7@gmail.com>
Date:   Sun, 22 Aug 2021 10:53:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210819215655.84866-4-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/19/2021 11:56 PM, Jeremy Linton wrote:
> Now that there is a bcm2711 quirk, it needs to be enabled when the
> MCFG is missing. Use an ACPI namespace _DSD property
> "linux-ecam-quirk-id" as an alternative to the MCFG OEM.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/acpi/pci_mcfg.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab975f612..4b991ee5c66c 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>   	ALTRA_ECAM_QUIRK(1, 13),
>   	ALTRA_ECAM_QUIRK(1, 14),
>   	ALTRA_ECAM_QUIRK(1, 15),
> +
> +	{ "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
> +	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
>   };
>   
>   static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> @@ -198,8 +201,18 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>   	u16 segment = root->segment;
>   	struct resource *bus_range = &root->secondary;
>   	struct mcfg_fixup *f;
> +	const char *soc;
>   	int i;
>   
> +	/*
> +	 * This may be a machine with a PCI/SMC conduit, which means it doesn't
> +	 * have an MCFG. Use an ACPI namespace definition instead.
> +	 */
> +	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
> +					 "linux-ecam-quirk-id", &soc)) {
> +		memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);

Being super paranoid here, can we use one of the "safe" string copy 
routines here just in case?

> +	}
> +
>   	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
>   		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
>   			if (f->cfgres.start)
> 

-- 
Florian
