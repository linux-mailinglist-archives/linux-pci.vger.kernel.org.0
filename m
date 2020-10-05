Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC898283EE5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgJESkk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 5 Oct 2020 14:40:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgJESkk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 14:40:40 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kPVPZ-0008Be-RQ
        for linux-pci@vger.kernel.org; Mon, 05 Oct 2020 18:40:38 +0000
Received: by mail-pg1-f199.google.com with SMTP id n24so6295374pgl.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 11:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxxY5hOmSO6qtZjMRL3JNa4hhIFzs0ULtV6GyWEV/cw=;
        b=P8gULxzsSJwS+3g5so2kns4txrnVRyF89pr5uk3RGBjU1lrHuBira5HXMi6NEZo8VC
         5wkBzlZLKz9vig8XFoPoQMdphslvZe5MyS49eLqtq+vwuxgO3d3bP4mD7E/Gj1DKZWB2
         2DfmYXaJKaWHU5JOyEWatqjDNa9ARsdc6iYmmMrrd+icM65s3wE98JmYsMPmTNNlo6NJ
         hWSF6S+D6FRxsJDdGHCRrbEide5vIxWoAj123NQ5b5mM6JT0zae+JYZVeVnRY5j+sStd
         LLPbYEYzvOpulan/A8I0p+Q9RIol+4yd8AXgxUUfP+gecMxcTxUCHn3U1jbvEjGvqMku
         6Y+g==
X-Gm-Message-State: AOAM532uWRIL7eWTZxeIbSy7aF8f1Sdj0gEYusA5wM1QdNeNF7G1iLqo
        1gejvqao5lPshunjPk+JbzFWkHtha2e4r78VoptyhowGijzoR9WviWqUPX8mFPQJTyud9t3ruiD
        SWNqO5kzznJExEFaMCEZAcpyg9sTn8gBHgQ4CfQ==
X-Received: by 2002:a65:5185:: with SMTP id h5mr828449pgq.37.1601923236167;
        Mon, 05 Oct 2020 11:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7Gh646eckSWleHa8CsLKPrEyGlJDvdti4AwQqbkNRgsJLohkCFtTD9VkihxkAziEAvfEx9Q==
X-Received: by 2002:a65:5185:: with SMTP id h5mr828422pgq.37.1601923235733;
        Mon, 05 Oct 2020 11:40:35 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id i9sm652998pfq.53.2020.10.05.11.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 11:40:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201002221830.GA2822405@bjorn-Precision-5520>
Date:   Tue, 6 Oct 2020 02:40:32 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>, jonathan.derrick@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <98360545-DC08-44A9-B096-ACF6823EF85D@canonical.com>
References: <20201002221830.GA2822405@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
>> BIOS may not be able to program ASPM for links behind VMD, prevent Intel
>> SoC from entering deeper power saving state.
> 
> It's not a question of BIOS not being *able* to configure ASPM.  I
> think BIOS could do it, at least in principle, if it had a driver for
> VMD.  Actually, it probably *does* include some sort of VMD code
> because it sounds like BIOS can assign some Root Ports to appear
> either as regular Root Ports or behind the VMD.
> 
> Since this issue is directly related to the unusual VMD topology, I
> think it would be worth a quick recap here.  Maybe something like:
> 
>  VMD is a Root Complex Integrated Endpoint that acts as a host bridge
>  to a secondary PCIe domain.  BIOS can reassign one or more Root
>  Ports to appear within a VMD domain instead of the primary domain.
> 
>  However, BIOS may not enable ASPM for the hierarchies behind a VMD,
>  ...
> 
> (This is based on the commit log from 185a383ada2e ("x86/PCI: Add
> driver for Intel Volume Management Device (VMD)")).

Ok, will just copy the portion as-is if there's patch v2 :)

> 
> But we still have the problem that CONFIG_PCIEASPM_DEFAULT=y means
> "use the BIOS defaults", and this patch would make it so we use the
> BIOS defaults *except* for things behind VMD.
> 
>  - Why should VMD be a special case?

Because BIOS doesn't handle ASPM for it so it's up to software to do the job.
In the meantime we want other devices still use the BIOS defaults to not introduce any regression.

> 
>  - How would we document such a special case?

I wonder whether other devices that add PCIe domain have the same behavior?
Maybe it's not a special case at all...

I understand the end goal is to keep consistency for the entire ASPM logic. However I can't think of any possible solution right now.

> 
>  - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
>    SoC power state problem?

Yes.

> 
>  - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?

This will break many systems, at least for the 1st Gen Ryzen desktops and laptops.
All PCIe ASPM are not enabled by BIOS, and those systems immediately freeze once ASPM is enabled.

Kai-Heng

> 
> Link to previous discussion for the archives:
> https://lore.kernel.org/r/49A36179-D336-4A5E-8B7A-A632833AE6B2@canonical.com
> 
>> So enable ASPM for links behind VMD to increase battery life.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/controller/vmd.c | 22 +++++++++++++++++++++-
>> 1 file changed, 21 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index f69ef8c89f72..058fdef9c566 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -417,6 +417,22 @@ static int vmd_find_free_domain(void)
>> 	return domain + 1;
>> }
>> 
>> +static const struct pci_device_id vmd_mobile_bridge_tbl[] = {
>> +	{ PCI_VDEVICE(INTEL, 0x9a09) },
>> +	{ PCI_VDEVICE(INTEL, 0xa0b0) },
>> +	{ PCI_VDEVICE(INTEL, 0xa0bc) },
>> +	{ }
>> +};
>> +
>> +static int vmd_enable_aspm(struct device *dev, void *data)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
>> +
>> +	return 0;
>> +}
>> +
>> static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>> {
>> 	struct pci_sysdata *sd = &vmd->sysdata;
>> @@ -603,8 +619,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>> 	 * and will fail pcie_bus_configure_settings() early. It can instead be
>> 	 * run on each of the real root ports.
>> 	 */
>> -	list_for_each_entry(child, &vmd->bus->children, node)
>> +	list_for_each_entry(child, &vmd->bus->children, node) {
>> +		if (pci_match_id(vmd_mobile_bridge_tbl, child->self))
>> +			device_for_each_child(&child->self->dev, NULL, vmd_enable_aspm);
> 
> Wouldn't something like this be sufficient?
> 
>  list_for_each_entry(dev, &child->devices, bus_list)
>    vmd_enable_aspm(dev);
> 
>> 		pcie_bus_configure_settings(child);
>> +	}
>> 
>> 	pci_bus_add_devices(vmd->bus);
>> 
>> -- 
>> 2.17.1

