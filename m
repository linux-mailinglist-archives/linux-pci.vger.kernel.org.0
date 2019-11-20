Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18F10426D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfKTRsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 12:48:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfKTRsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 12:48:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so575318wmi.5;
        Wed, 20 Nov 2019 09:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gb5aW3R/KOwRkVEvqWdyeVDOFlNOArlGLF6/Wf4S7KY=;
        b=o4N3n5Pd7xMvM3x6YL9p7RkLA0EaB/gwGYDulzXpofsMxMfBVWzMxAYm+VAQafUko9
         uGE+Mm3kQsnpCU/PRAcHHpEmsCyW4quf2NcgU0OC0k5Z9kL3e2ONCUQGTdvWSu57Ir37
         Nl/GXiX+9oEFJuUY2QxToBjBCh0hDTWFm4pxxnapc6gndzXSMPM16dh8jnmN+jo9YxMm
         Rp8zhNM4Luchw1G2R5zZoACrL2AlIC1gRWVOCMgKJLEvqj0qluAao6YLldT8MG1zscDL
         qMnU9qGaOTo61E38pKd7uxcDP6NIigQAyxy8dge1PUq/84Vr6srhVZIb2Gt4bUzVPe/2
         kdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gb5aW3R/KOwRkVEvqWdyeVDOFlNOArlGLF6/Wf4S7KY=;
        b=ktAPCe9wJqpiB9oGvexJ1rxo1oC3cMnJtYweqXmDKDv1yQ1Ywj53AYXGBRawtq7TE8
         bennNIann5zRegPMFSSLlh5iQpjhWfENTBFMlZhUDjAkRt5yem1ffxx9+T0ju1XP3CAc
         IRzb0J8kE5ubcFotaeM5JKki4vsHVYEGQclC/PGB+0QWGClLvoRxC6aUcy9WLgwwhErZ
         AbDb67C4zcCy/QxwiI7BI5PBS/6CVUdWmZx89QSAvsKt0dLOhP6uFoOq323K5ygUb7SZ
         PrNU6yW542SWwfXEG9bVheNISektxMOCdcq0XVhgtQXGCGnBf+TaMBODY+wjERw/KfT7
         5pGg==
X-Gm-Message-State: APjAAAX7INy2mX41TPYWcLkAZNSYEXDLn9nFME5tRp9mkpHXuhH82skN
        UADaKMfjEzB6d4WfWU2K9Sfh/JUwuW4=
X-Google-Smtp-Source: APXvYqwXdDQUtrOZSro2T2/CaWB+MPqo3m0UdZTaIiLCvG0M8O7HDp8aMnaddseMLcQwky08IkX0ag==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr4849653wml.170.1574272132571;
        Wed, 20 Nov 2019 09:48:52 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t14sm31266663wrw.87.2019.11.20.09.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:48:51 -0800 (PST)
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
References: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
 <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
Date:   Wed, 20 Nov 2019 17:48:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Cc: linux-pci@vger.kernel.org
+Cc: Bjorn Helgaas <bhelgaas@google.com>
+Cc: Logan Gunthorpe <logang@deltatee.com>

On 11/5/19 12:17 PM, James Sewart wrote:
> Any comments on this?
> 
> Cheers,
> James.
> 
>> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
>>
>> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
>> PCI devices. The devfn for a transaction is used as an index into a lookup table
>> storing the origin of a transaction on the other side of the bridge.
>>
>> This patch aliases all possible devfn's to the NTB device so that any transaction
>> coming in is governed by the mappings for the NTB.
>>
>> Signed-Off-By: James Sewart <jamessewart@arista.com>
>> ---
>> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 320255e5e8f8..647f546e427f 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
>>
>> +/*
>> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
>> + * are used to forward responses to the originator on the other side of the
>> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
>> + * turned on.
>> + */
>> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
>> +{
>> +	if (!pdev->dma_alias_mask)
>> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
>> +					      sizeof(long), GFP_KERNEL);
>> +	if (!pdev->dma_alias_mask) {
>> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
>> +		return;
>> +	}
>> +
>> +	// PLX NTB may use all 256 devfns
>> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, quirk_PLX_NTB_dma_alias);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, quirk_PLX_NTB_dma_alias);
>> +
>> /*
>>  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
>>  * not always reset the secondary Nvidia GPU between reboots if the system
>> -- 
>> 2.19.1
>>
>>
> 

Thanks,
          Dmitry
