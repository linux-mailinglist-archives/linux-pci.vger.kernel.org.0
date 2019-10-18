Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B480DBFEA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406746AbfJRIaS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Oct 2019 04:30:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfJRIaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 04:30:17 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iLNeJ-0004MI-Qq
        for linux-pci@vger.kernel.org; Fri, 18 Oct 2019 08:30:15 +0000
Received: by mail-pl1-f199.google.com with SMTP id 99so3270959plc.18
        for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2019 01:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9HnLyuAc2KszW2sCbnW2TVqDttn2ZhGYOZuSbcGb+Ao=;
        b=PR0PsZCJjaNdX4Gylzs9XsxhjLfWyakACt8K5N537rBKhEn7QwOWeXJv+1DElJgPji
         Et+II/F8US+fNYR67h3jM7/8M6prAVg1HSpl/36sJGRHhVBAptWMlT9W1Q+Vn9Vy0H8G
         UN3yzi8Bl+rx0reD0uc4kmB15h0QPDeukWtvo0fLTjd5Z/Go521V6gzmdqsEKm9ykEoo
         mR++NrhZuElmY9m1laH5Adllu+JoVI5aIBK4sF+s6RzpTAnhnqAIQ563q1276E8V0nms
         kY5NIOAbNKq+eHwxtQIgXC/BmnGCsTSlk/1txmlmFrR0F0jICpmHgmPwPrrEH8UTvWt5
         nHkA==
X-Gm-Message-State: APjAAAVRVymgExlfYYbnbYH4S4K2Gkhm4eJC5KadQyNPcFe5TUTtPQYd
        uAHd5BZFDtVqwYye8BnQIMIrLfVGUT4QPVbV669yGmynWVwsY7eMIYYQXjUgMolWwPO6E3KwC70
        UmG/GewBmmX1gxh99cFu2fm9O9ycJodJlx/CCwA==
X-Received: by 2002:a17:902:aa86:: with SMTP id d6mr8878184plr.268.1571387414555;
        Fri, 18 Oct 2019 01:30:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/HstgLPTWdbdqHW8QWIvwRL6LLMXn5En0TaPY+gU76l2aPXRwvWmgbm5PxCa/kgGW3UqDQg==
X-Received: by 2002:a17:902:aa86:: with SMTP id d6mr8878156plr.268.1571387414189;
        Fri, 18 Oct 2019 01:30:14 -0700 (PDT)
Received: from 2001-b011-380f-3c42-80b6-0157-ba58-fc96.dynamic-ip6.hinet.net (2001-b011-380f-3c42-80b6-0157-ba58-fc96.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:80b6:157:ba58:fc96])
        by smtp.gmail.com with ESMTPSA id f185sm6882160pfb.183.2019.10.18.01.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:30:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH v6 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hr23ah3g9.wl-tiwai@suse.de>
Date:   Fri, 18 Oct 2019 16:30:11 +0800
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4C18DF4A-FAE8-4762-AF65-F892A4845297@canonical.com>
References: <20191018073848.14590-1-kai.heng.feng@canonical.com>
 <s5hr23ah3g9.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3601)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Oct 18, 2019, at 16:18, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Fri, 18 Oct 2019 09:38:47 +0200,
> Kai-Heng Feng wrote:
>> 
>> A driver may want to know the existence of _PR3, to choose different
>> runtime suspend behavior. A user will be add in next patch.
>> 
>> This is mostly the same as nouveau_pr3_present().
>> 
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> It's confusing -- this particular change isn't reported by the test
> bot, but only about the lack of the CONFIG_ACPI ifdef.

Hmm, because the test bot asked to add the tag.
If it's not appropriate will you drop it? I can also send a v7.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v6:
>> - Only define the function when CONFIG_ACPI is set.
>> v5:
>> - Add wording suggestion from Bjorn.
>> v4:
>> - Let caller to find its upstream port device.
>> 
>> drivers/pci/pci.c   | 18 ++++++++++++++++++
>> include/linux/pci.h |  2 ++
>> 2 files changed, 20 insertions(+)
>> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e7982af9a5d8..1df99d9e350e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5856,6 +5856,24 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>> 	return 0;
>> }
>> 
>> +#ifdef CONFIG_ACPI
>> +bool pci_pr3_present(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	if (acpi_disabled)
>> +		return false;
>> +
>> +	adev = ACPI_COMPANION(&pdev->dev);
>> +	if (!adev)
>> +		return false;
>> +
>> +	return adev->power.flags.power_resources &&
>> +		acpi_has_method(adev->handle, "_PR3");
>> +}
>> +EXPORT_SYMBOL_GPL(pci_pr3_present);
>> +#endif
>> +
>> /**
>>  * pci_add_dma_alias - Add a DMA devfn alias for a device
>>  * @dev: the PCI device for which alias is added
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index f9088c89a534..1d15c5d49cdd 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2310,9 +2310,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>> 
>> void
>> pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
>> +bool pci_pr3_present(struct pci_dev *pdev);
>> #else
>> static inline struct irq_domain *
>> pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>> +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>> #endif
>> 
>> #ifdef CONFIG_EEH
>> -- 
>> 2.17.1
>> 

