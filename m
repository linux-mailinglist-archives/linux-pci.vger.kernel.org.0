Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F366572E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 10:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbjAKJSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 04:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjAKJRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 04:17:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3EECC7
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 01:16:01 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fy8so35124645ejc.13
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGj8jgAyFszET7QdJP3q6l/SlbFxu+eKlrahuw4x3Dc=;
        b=cNcZIO2f7f772HEebAFRwcoFge2/LG159lSKUVerbwlVlzrarX197dtdhGbZ8bM1L7
         ffOD3vHRe1lrKD3yi5p5ipupi0ft5VK5DL6RNekDLcYMCDRC+/BHnOEvbZIKQZoQnxe/
         S47KZwOcioj3Ncx14lJJl/QdgwwSOgvGk+2g/EUERhvvL4eEPlRScHL2FDTq3gRXaGTw
         7eQ9CLKOCYNjT2vp6pjVjLUFPRXyXwiw/fQNYS72Dp7N6vEdDySAP8xzIoPpaXzHhqoy
         z9bHn7aeJxUEsaKlBlOCSgg2Ro61n3fZrBxY4pDJX954mLI8Jmdkf6zDxTI9eTCOnsOe
         CJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGj8jgAyFszET7QdJP3q6l/SlbFxu+eKlrahuw4x3Dc=;
        b=8Qml8+Oim/Th43eVIHArUx83iRii1hpxUqxaYI3d4/F5ORskTv0K4gr4kGvNe60bUx
         lDM1eTOq+sfh0spuNfbkoCv8hAn5w5mGbxxMIHsSLdzntdHkF/EVdVFhNgBw/Y6Mv43m
         JcJzXiNTxQnaAOF0pjXZNguFUb1kgPJSvgmXU4nqAjr1zyGe38P4gaXrhcpmQRgOXwWx
         Rh8m9o8H0aoajEn/EP9eIfUSDZQfklvIzfSY1IlW9Zlm2TPdXzvW6nmNoIG/BSmXtVQX
         iSwyZwMHe9pwJt6esP/VCBlHMlNrWDosiYbuOiDGyLOnOKZ31PCnMamGrDZ3HD88Rs5c
         iVtg==
X-Gm-Message-State: AFqh2ko+Tmpxg6pSnje4tuIw8na1beqAtT7TKdeyZgn8wRaGPC2i066C
        IQN1ZinFgkPzCRbQ7IJJVY/5DCZi1SI=
X-Google-Smtp-Source: AMrXdXviJt0ZQwnVOfcBN4gx4Gc2kN3b2WAsoeTsel7jlUGypxPLVpM/5R7sia6Xnj5FmyEK9lM/VA==
X-Received: by 2002:a17:907:7e8a:b0:84c:e89e:bb4c with SMTP id qb10-20020a1709077e8a00b0084ce89ebb4cmr31171143ejc.49.1673428560060;
        Wed, 11 Jan 2023 01:16:00 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:752d:cd68:6cff:3acf? ([2a02:908:1256:79a0:752d:cd68:6cff:3acf])
        by smtp.gmail.com with ESMTPSA id oz39-20020a1709077da700b008617cb00654sm83416ejc.212.2023.01.11.01.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:15:59 -0800 (PST)
Message-ID: <801745b6-3019-daa9-8ede-f4de10c3f64b@gmail.com>
Date:   Wed, 11 Jan 2023 10:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Content-Language: en-US
To:     linux-pci@vger.kernel.org
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230111085745.401710-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Forgot to add Felix as CC as well.

Am 11.01.23 um 09:57 schrieb Christian König:
> This reverts commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9.
>
> It's correct that the PCIe fabric routes Memory Requests based on the
> TLP address, but enabling the PASID mapping doesn't necessary mean that
> Memory Requests will have a PASID associated with them.
>
> The alternative is ATS which lets the device resolve the PASID+addr pair
> before a memory request is made into a routeable TLB address through the
> TA. Those resolved addresses are then cached on the device instead of
> in the IOMMU TLB.
>
> So the assumption that you mandatory need ACS to enabled PASID handling
> on a device is simply not correct, we need to take ATS into account as
> well.
>
> The patch caused failures with AMDs integrated GPUs because some of them
> only enable ATS but not ACS.
>
> For now just revert the patch until this is completely solved.
>
> CC: Jason Gunthorpe <jgg@nvidia.com>
> CC: Kevin Tian <kevin.tian@intel.com>
> CC: Lu Baolu <baolu.lu@linux.intel.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Tony Zhu <tony.zhu@intel.com>
> CC: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216865
> ---
>   drivers/pci/ats.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..c967ad6e2626 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -382,9 +382,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>   	if (!pasid)
>   		return -EINVAL;
>   
> -	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
> -		return -EINVAL;
> -
>   	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
>   	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>   

