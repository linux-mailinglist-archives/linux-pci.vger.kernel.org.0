Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D368635746D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355369AbhDGSgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDGSgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 14:36:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44297C06175F;
        Wed,  7 Apr 2021 11:36:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a12so13539914pfc.7;
        Wed, 07 Apr 2021 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t0pIiiT98/ffosAzDqF1bE5J3E9ujwJqQoC1fmcx5CE=;
        b=fKTuMjGr9bgkeRZEUEDjFan7Vza2w0jXMH+IRVTMwj96/617d9721JXHsbSbQTEaVg
         dwbFppUIWWyQ7qezqEZ2+ZNya7SuPL9OGEJG1z65G79/rBJk+vbQyhg6lctYAua18KDP
         tpEDA2uVh/+ZSnod8Ubv5Fu/w0H5uIAwY6pDZsXuUX5JuFSkSUKea0MoUMuhFECkh5V/
         yhicxnCbaU+GTbUydF08n7E5+9Bkgpoa6eRb0yqcEv61kWsTohv/xDES/2JPdIjkTrZN
         wvf529udX52u9PhgLrAMZ3PjA6SaX9O3xyL28MRI2m2PUap9PZt7YWmt4CfPgGjbO2kk
         5SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0pIiiT98/ffosAzDqF1bE5J3E9ujwJqQoC1fmcx5CE=;
        b=aiVWtT0RI8PJEGkMlEyeOSvRuN0sUNXIiO5tgISuu+zHCm9/Nw6WDH7bVRzWPZ007Y
         cPOBkarR3/stFTOLM7NuY9nZzK2C4UvzEDmqbRJA8F88MogdBFtxFr11TqGf8dhLgWpE
         PcZs4GdnkNh0xqso/pItr8HZ1d7AwvfUJW1KLplE/O1zSVjSp/qzRMRqmcZSddFkpRSq
         R9TTCP0LJGCCzj2D3Enntyi0rknI+6CbSmkVAetyshFohPS1M37UAEpRRdL6SHPfwZSD
         vE7HV0WxS8TU8GOwAbupmMJiGcHbxu9w1b929//i/Jwa3MejGmKvhyCUhJJq5koi4LgD
         HvFQ==
X-Gm-Message-State: AOAM532F0gd3dhldt35JJtjkH7WnKqKxxWSPpxCONps5ix8OlLv+R7SC
        gwfq+JuQwo+qEgnRhtsZr6Z1ZYPAdFg=
X-Google-Smtp-Source: ABdhPJwlnS2HnTPLDUaVE/j0PFmdNF8G4NjB6RGboOPZKV9mHKhGtsb+Hcp1c3NZNIcC1WSUH4Khig==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr4638353pgs.206.1617820565321;
        Wed, 07 Apr 2021 11:36:05 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c2sm1449860pfo.53.2021.04.07.11.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:36:04 -0700 (PDT)
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
To:     Mark Brown <broonie@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
 <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
 <20210407112713.GB5510@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <03852d1a-1ee4-fd29-8523-4673c35f83cd@gmail.com>
Date:   Wed, 7 Apr 2021 11:35:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407112713.GB5510@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/7/2021 4:27 AM, Mark Brown wrote:
> On Tue, Apr 06, 2021 at 02:25:49PM -0400, Jim Quinlan wrote:
> 
>> I'm a little confused -- here is how I remember the chronology of the
>> "DT bindings" commit reviews, please correct me if I'm wrong:
> 
>> o JimQ submitted a pullreq for using voltage regulators in the same
>> style as the existing "rockport" PCIe driver.
>> o After some deliberation, RobH preferred that the voltage regulators
>> should go into the PCIe subnode device's DT node.
>> o JimQ put the voltage regulators in the subnode device's DT node.
>> o MarkB didn't like the fact that the code did a global search for the
>> regulator since it could not provide the owning struct device* handle.
>> o RobH relented, and said that if it is just two specific and standard
>> voltage regulators, perhaps they can go in the parent DT node after
>> all.
>> o JimQ put the regulators back in the PCIe node.
>> o MarkB now wants the regulators to go back into the child node again?
> 
> ...having pointed out a couple of times now that there's no physical
> requirement that the supplies be shared between slots never mind with
> the controller.  Also note that as I've said depending on what the
> actual requirements of the controller node are you might want to have
> the regulators in both places, and further note that the driver does not
> have to actively use everything in the binding document (although if
> it's not using something that turns out to be a requirement it's likely
> to run into hardware where that causes bugs at some point).
> 
> Frankly I'm not clear why you're trying to handle powering on PCI slots
> in a specific driver, surely PCI devices are PCI devices regardless of
> the controller?

There is no currently a way to deal with that situation since you have a
chicken and egg problem to solve: there is no pci_device created until
you enumerate the PCI bus, and you cannot enumerate the bus and create
those pci_devices unless you power on the slots/PCIe end-points attached
to the root complex. There are precedents like the rockchip PCIe RC
driver, and yes, we should not be cargo culting this, which is why we
are trying to understand what is it that should be done here and there
has been conflicting advice, or rather our interpretation has led to
perceiving it as a conflicting.

If the regulator had a variation where it supported passing a
device_node reference to look up regulator properties, we could solve
this generically for all devices, that does not exist, and you stated
you will not accept changes like those, fair enough.

When you suggested to look at soundwire for an example of "software
devices", we did that but it was not clear where the sdw_slave would be
created prior to sdw_slave_add(), but this does not matter too much.

Let us say we try to solve this generically using the same idea that we
would pre-populate pci_device prior to calling pci_scan_child_bus(). We
could do something along these lines:

- pci_scan_child_bus() would attempt to walk the list of device_node
children from the PCIe root complex's device_node and call
pci_alloc_dev() for each of these devices that it finds, along with
calling device_initialize() and ensuring that pci_dev::device::of_node
is set correctly by calling pci_set_of_node()/set_dev_node(). Finally we
call list_add_tail() with the pci_bus_sem semaphore held to add that
pci_device to bus->devices such that we can later find them

- from there on we try to get the regulators of those pci_device objects
we just allocated and we try to enable their regulators, either based on
a specific list of supplies or just trying to enable all supplied declared.

- now pci_scan_child_bus() will attempt to scan the bus for real by
reading the pci_device objects ID but we already have such objects, so
we need to update pci_scan_device() to search bus::devices and if
nothing is found we allocate one

Is that roughly what you have in mind as to what should be done?
-- 
Florian
