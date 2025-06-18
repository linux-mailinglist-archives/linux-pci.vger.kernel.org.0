Return-Path: <linux-pci+bounces-30053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77985ADE94E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CE317E22B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7228505F;
	Wed, 18 Jun 2025 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ra2d7/oT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF415D1
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243349; cv=none; b=bKWLNJhPVIdePU/x8sWi1voNnGAN3+EZSMJDmgemiMK+sOOswdWZqXUxhppLVa87eGSecak3pNRXvPeRQAR1HbSBxIGHQHgIwVxBitWSc8Bo9h1I8DzFrSDP5d0kZ99H0Zs/cauzWVysw7NmMHt6Uj4de1NcHwFwpm3jgXin1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243349; c=relaxed/simple;
	bh=V4y1DqjjYhSRgJ7qNBSvdXvsny7bdB99TpkFxm4XmJs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IioAnrXCiUEXjubjLyl4O2gLUGHW5hNFGI58RW0bcSjdIViBHT2Z22R5AkiM42gUR/JPuE1jTujSxHn/b1b/nZtPDWziyDklUNxqJgGVWf/plI1CeUoT2R9LZqWbffDS100AIw3Sw76gypR9GaISuoXN1DBKjIcBAPwKxYpleG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ra2d7/oT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so12804131a12.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750243344; x=1750848144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wHukETbloS3taj+byKKfr4kaIRZygvwm7xKORKM1+IQ=;
        b=ra2d7/oT3ORQGl0y20LbZSyGhorvgh8TZTGJtU7XsJGF7PxZ4HFtrh7wStHjdGUx56
         vave92reLCuT9PR4bMPdAgvyZ+MFMg1ZxG0b+AW+MpU9eOCiK5x8bv7AIVhWs35reWXc
         Monwsy4ZrKwpY1iZ5dZBOmyxj7jtY6nm+SHpj3aqH1uBUlTMvADsOkSKQAUheEUFxA5q
         UcOfPtZm2yZ+Rw+JN+uY6bFedoC7bWbqv1EXFpDpBolh+eCMgdFiHrgXx7j6Sg/VoHI+
         bkhMiPj+fc7GjXc/0Ls63mDSSw7Kh27FjPrFHSBbOLaIYkemIeMEi53+BxsmabFk/ps5
         OUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750243344; x=1750848144;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHukETbloS3taj+byKKfr4kaIRZygvwm7xKORKM1+IQ=;
        b=rDxoQg2CVMdjWk84B0pBlMaYdWZg1k7ehq0Xs8PQ2JUVzSAa8WJGpxhi+D9hR+tXvx
         Q8r4AAvzZU9R9xkR2YCWBkxebuVRjeeYYuNJnkxoLzF9zLTCft2Zdk5xsJ/3llsSs9OO
         RYz9zkw8LzqC4JhJsz3dJ1pZlRF4DuQZu74Hi/tpUR8d38GyVFr1EjWhr48XRGc/wSwC
         WSS/sAJvnLd8M/HW7K4gE/ubnKAIG4fzIAND22fNVm0BWMI4ejj28UxaTvk2Htm4pOQs
         DDnrfhoInMKJlnj5SaGMZQgDP8vo0U6u4A5ke5rt0xRnq5U/ps6Ql6X7yP3OpTnMRqGi
         x9pA==
X-Forwarded-Encrypted: i=1; AJvYcCVi2DrQR8iA6nXyyBaGKDCRkLfhqkmwZQSTUetnX2kUyG3p5URKspFqF2FdTXoFvtATelNpP/7e6QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu++g3KY0J1Z6M6fr5SjPcxuT7PoY5vMr382bqIF+ru/9mVigo
	2hawrfFJ8hkCzV66ATB4BMr3vw/nvSK7639NwGW2VnQBBLgPw888SbGGRwtLT/helMg=
X-Gm-Gg: ASbGncsAE/w+IqH/Xp8nVCvjcNN5Tbf7v7E1UfPnlKUs+7Bf6/zW2eX/gb8KB5F+Tm+
	RnqPc9k4Jw6RlcnA7zH/3xZBp7/qm/qCd4jqJQudc0ceCjx4jZ5lBHLHT3f4LsdviLeeTwlzE3F
	HceBv7y6OwoDSr8FggixD9Y+qvnamau3KIKm20HD67RpNd/qePM9n5/ARy7eLsbZWUAB9zNbHic
	vlFs5Fd0RjDH8UHjllifiWX0FAc4RXsnQc3k5+mnuNqFtvcdm9A06sohnA7TQBtbnTmhwkaXG2c
	HHjnrLw/EVoASPv7TUUWxpgYXnkWXuftfrTQ9Ao6H1PqFVP7UxQ1m4QdQaWDjRMxQQYUK5Q=
X-Google-Smtp-Source: AGHT+IGFpo3an5XwUx+UUifXicu+oHy6MxcbWKYujoj3RjQCa3dywfv1orWpbvXYbymhtzzffg2TlQ==
X-Received: by 2002:a05:6402:2348:b0:605:878:3557 with SMTP id 4fb4d7f45d1cf-608d09475f9mr15451171a12.16.1750243343967;
        Wed, 18 Jun 2025 03:42:23 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48f33c6sm9485186a12.30.2025.06.18.03.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 03:42:23 -0700 (PDT)
Message-ID: <ec58721e-0121-47d0-9226-d72bc6605680@tuxon.dev>
Date: Wed, 18 Jun 2025 13:42:21 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v8 5/5] PCI: of: Create device-tree PCI host bridge node
To: Herve Codina <herve.codina@bootlin.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250224141356.36325-1-herve.codina@bootlin.com>
 <20250224141356.36325-6-herve.codina@bootlin.com>
 <594d284e-afce-446a-9fcb-a67b157ef6dc@tuxon.dev>
 <20250611165617.641c7c09@bootlin.com>
 <3258d453-f262-4f1c-822b-5310a8346a2d@tuxon.dev>
 <20250617090029.03283ea6@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250617090029.03283ea6@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Herve, Rob, Bjorn, Lizhi,

On 17.06.2025 10:00, Herve Codina wrote:
> Hi Claudiu,
> 
> On Fri, 13 Jun 2025 16:36:16 +0300
> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> 
> ...
> 
>> I pointed to the wrong function. It's not of_pci_make_host_bridge_node()
>> [1] but of_pci_make_dev_node() which creates a node with a similar naming
>> and makes things not working on my side.
>>
>> [1] https://elixir.bootlin.com/linux/v6.15/source/drivers/pci/of.c#L694
> 
> Ok, so your issue is not related patches applied from the "PCI: of: Create
> device-tree PCI host bridge node" series.
>   https://lore.kernel.org/all/20250224141356.36325-6-herve.codina@bootlin.com/

That's true, I was wrongly pointing it.

> 
> Indeed, this series add the node creation for the host bridge with
> of_pci_make_host_bridge_node() but you pointed now of_pci_make_dev_node()
> which is the creation for PCI device node and this function was not modify by the
> series.
> 
> of_pci_make_host_bridge_node() should not create anything. Can you confirm on your
> side that it doesn't create any nodes.

I confirm it doesn't create any node.

> 
> If so, maybe the problem comes from of_irq_parse_raw() or similar.
> 
> ...
> 
>>
>>>
>>> On this system, I didn't observed any issues but of course, the PCIe drivers are
>>> different.
>>> Also, on my system, no node were created by of_pci_make_host_bridge_node().  
>>
>> Sorry for the confusion, it is of_pci_make_dev_node() on my side which
>> creates the node.
>>
>>>
>>> To be honest, I didn't re-test recently to see if something has been broken.
>>> I can do that on my side with my system.
> 
> I have re-tested and I confirm that I have no issue on my system.

Thank you for doing this.

> 
>>>
>>> On your side, maybe you can have look at the Armada PCIe driver and see if
>>> something could explain your behavior. I am not sure that you need to add the
>>> pci@0,0 node in your DT.  
>>
>> I can't find a driver that uses the approach I'm trying in my patches. This
>> approach was suggested in the review process [2] by Rob who mentioned that
>> now we should be able drop legacy interrupt controller nodes. There are
>> some Apple device trees that points the interrupt-map to the port node (the
>> way I tried in my workaround) [3], but I can't find more than that.
>>
>> The topology in my case is:
>>
>> root@smarc-rzg3s:~# lspci -t
>> -[0000:00]---00.0-[01]----00.0
>>
>> root@smarc-rzg3s:~# lspci
>> 00:00.0 PCI bridge: Renesas Technology Corp. Device 0033
>> 01:00.0 Non-Volatile memory controller: Micron Technology Inc 2550 NVMe SSD
>> (DRAM-less) (rev 01)
>>
>> When not working pci@0,0 is exported as follows in rootfs:
>>
>> root@smarc-rzg3s:~# ls /sys/firmware/devicetree/base/soc/pcie@11e40000 -l
>> -r--r--r--    1 root     root             4 Jan 12 10:28 #address-cells
>> -r--r--r--    1 root     root             4 Jan 12 10:28 #interrupt-cells
>> -r--r--r--    1 root     root             4 Jan 12 10:28 #size-cells
>> -r--r--r--    1 root     root             8 Jan 12 10:28 bus-range
>> -r--r--r--    1 root     root            13 Jan 12 10:28 clock-names
>> -r--r--r--    1 root     root            24 Jan 12 10:28 clocks
>> -r--r--r--    1 root     root            26 Jan 12 10:28 compatible
>> -r--r--r--    1 root     root             4 Jan 12 10:28 device-id
>> -r--r--r--    1 root     root             4 Jan 12 10:28 device_type
>> -r--r--r--    1 root     root            28 Jan 12 10:28 dma-ranges
>> -r--r--r--    1 root     root             0 Jan 12 10:28 interrupt-controller
>> -r--r--r--    1 root     root           144 Jan 12 10:28 interrupt-map
>> -r--r--r--    1 root     root            16 Jan 12 10:28 interrupt-map-mask
>> -r--r--r--    1 root     root           164 Jan 12 10:28 interrupt-names
>> -r--r--r--    1 root     root             4 Jan 12 10:28 interrupt-parrent
> 
> Why parrent instead of parent in interrupt-parrent ?

Sorry about that, I did the wrong copy-paste here. This was from my various
experiments (and yes, it was a typo in there in my device tree). The point
I was trying to emphasize here is about the presence of the pci@0,0 node
and its content, along with the pci topology (considering this might give
you some clue).

> 
>> -r--r--r--    1 root     root           192 Jan 12 10:28 interrupts
>> -r--r--r--    1 root     root             5 Jan 12 10:28 name
>> -r--r--r--    1 root     root             4 Jan 12 10:28 num-lanes
>> drwxr-xr-x    2 root     root             0 Jan 12 10:17 pci@0,0
>> -r--r--r--    1 root     root             4 Jan 12 10:28 phandle
>> -r--r--r--    1 root     root             4 Jan 12 10:28 pinctrl-0
>> -r--r--r--    1 root     root             8 Jan 12 10:28 pinctrl-names
>> -r--r--r--    1 root     root             4 Jan 12 10:28 power-domains
>> -r--r--r--    1 root     root            28 Jan 12 10:28 ranges
>> -r--r--r--    1 root     root            16 Jan 12 10:28 reg
>> -r--r--r--    1 root     root             4 Jan 12 10:28 renesas,sysc
>> -r--r--r--    1 root     root            63 Jan 12 10:28 reset-names
>> -r--r--r--    1 root     root            56 Jan 12 10:28 resets
>> -r--r--r--    1 root     root             5 Jan 12 10:28 status
>> -r--r--r--    1 root     root             4 Jan 12 10:28 vendor-id
>> root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~# ls
>> /sys/firmware/devicetree/base/soc/pcie@11e40000/pci@0,0 -l
>> -r--r--r--    1 root     root             4 Jan 12 10:17 #address-cells
>> -r--r--r--    1 root     root             4 Jan 12 10:17 #interrupt-cells
>> -r--r--r--    1 root     root             4 Jan 12 10:17 #size-cells
>> -r--r--r--    1 root     root             8 Jan 12 10:17 bus-range
>> -r--r--r--    1 root     root            41 Jan 12 10:17 compatible
>> -r--r--r--    1 root     root             4 Jan 12 10:17 device_type
>> -r--r--r--    1 root     root           144 Jan 12 10:17 interrupt-map
>> -r--r--r--    1 root     root            16 Jan 12 10:17 interrupt-map-mask
>> -r--r--r--    1 root     root            32 Jan 12 10:17 ranges
>> -r--r--r--    1 root     root            20 Jan 12 10:17 reg
>> root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~# cat
>> /sys/firmware/devicetree/base/soc/pcie@11e40000/pci@0,0/compatible
>> pci1912,33pciclass,060400pciclass,0604root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~#
>> root@smarc-rzg3s:~#
>>
>> In case I describe a port in device tree, it works because the pci@0,0 is
>> not created anymore when device is enumerated and thus the interrupt
>> parsing is working.
>>
>> Herve: do you have some hints?
> 
> First interrupt-parrent in your /sys/firmware/devicetree/base/soc/pcie@11e40000
> files.
> 
> If it is just a typo in this email, maybe the interrupt parsing itself.
> 
> Can you provide an extract for the DT with nodes created at runtime.
> I mean can you run 'dtc -I dtb -O dts /proc/device-tree' and provide the output

That was a good hint. Thank for it.

> related to PCI nodes including the PCIe controller ?

I continued yesterday to investigate this.

To me it looks like there is an issue with interrupt-map property for the
node created with of_pci_make_dev_node(), whose content is populated with
data retrieved after the interrupt was checked to be a valid map.

With the current linux-next and the driver I'm working on [1] the pci dts
node obtained from /proc/device-tree is as follows:

pcie@11e40000 {
    power-domains = <0x02>;
    dma-ranges = <0x42000000 0x00 0x48000000 0x00 0x48000000 0x00 0x38000000>;
    pinctrl-names = "default";
    #address-cells = <0x03>;
    bus-range = <0x00 0xff>;
    pinctrl-0 = <0x21>;
    clock-names = "aclk\0pm";
    resets = <0x02 0x53 0x02 0x54 0x02 0x55 0x02 0x56 0x02 0x57 0x02 0x58
0x02 0x59>;
    interrupts = <0x00 0x18b 0x04 0x00 0x18c 0x04 0x00 0x18d 0x04 0x00
0x18e 0x04 0x00 0x18f 0x04 0x00 0x190 0x04 0x00 0x191 0x04 0x00 0x192 0x04
0x00 0x193 0x04 0x00 0x194 0x04 0x00 0x195 0x04 0x00 0x196 0x04 0x00 0x197
0x04 0x00 0x198 0x04 0x00 0x199 0x04 0x00 0x19a 0x04>;
    clocks = <0x02 0x01 0x65 0x02 0x01 0x66>;
    interrupt-map = <0x00 0x00 0x00 0x01 0x1f 0x00 0x00 0x00 0x00
                     0x00 0x00 0x00 0x02 0x1f 0x00 0x00 0x00 0x01
                     0x00 0x00 0x00 0x03 0x1f 0x00 0x00 0x00 0x02
                     0x00 0x00 0x00 0x04 0x1f 0x00 0x00 0x00 0x03>;
    #size-cells = <0x02>;
    renesas,sysc = <0x20>;
    device_type = "pci";
    interrupt-map-mask = <0x00 0x00 0x00 0x07>;
    num-lanes = <0x01>;
    compatible = "renesas,r9a08g045s33-pcie";
    ranges = <0x3000000 0x00 0x30000000 0x00 0x30000000 0x00 0x8000000>;
    #interrupt-cells = <0x01>;
    status = "okay";
    vendor-id = <0x1912>;
    interrupt-names =
"serr\0serr_cor\0serr_nonfatal\0serr_fatal\0axi_err\0inta\0intb\0intc\0intd\0msi\0link_bandwidth\0pm_pme\0dma\0pcie_evt\0msg\0all";
    reg = <0x00 0x11e40000 0x00 0x10000>;
    phandle = <0x1f>;
    reset-names =
"aresetn\0rst_b\0rst_gp_b\0rst_ps_b\0rst_rsm_b\0rst_cfg_b\0rst_load_b";
    device-id = <0x33>;
    interrupt-controller;

    pci@0,0 {
        #address-cells = <0x03>;
        bus-range = <0x01 0xff>;
        interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x00
                         0x10000 0x00 0x00 0x02 0x1f 0x00 0x11e40000 0x00 0x01
                         0x10000 0x00 0x00 0x03 0x1f 0x00 0x11e40000 0x00 0x02
                         0x10000 0x00 0x00 0x04 0x1f 0x00 0x11e40000 0x00
0x03>;
        #size-cells = <0x02>;
        device_type = "pci";
        interrupt-map-mask = <0xffff00 0x00 0x00 0x07>;
        compatible = "pci1912,33\0pciclass,060400\0pciclass,0604";
        ranges = <0x82000000 0x00 0x30000000 0x82000000 0x00 0x30000000
0x00 0x100000>;
        #interrupt-cells = <0x01>;
        reg = <0x00 0x00 0x00 0x00 0x00>;
    };
};

The pci@0,0 is created by:

pci_host_probe() ->
  pci_bus_add_devices() ->
    pci_bus_add_device() ->
      of_pci_make_dev_node() ->
        of_pci_add_properties() ->
          of_pci_prop_intr_map()

for bridge->child_ops populated in rzg3s_pcie_probe() (child->ops in
pci_bus_add_devices() is bridge->child_ops populated in rzg3s_pcie_probe()).

static int rzg3s_pcie_probe(struct platform_device *dev)
{
	// ...

        bridge->sysdata = host;

        bridge->ops = &rzg3s_pcie_root_ops;

        bridge->child_ops = &rzg3s_pcie_child_ops;

        ret = pci_host_probe(bridge);


	// ...
}

On my side, on child bus is connected a NVMe device.

When it is enumerated pci_assign_irq() is called for it, call trace as follows:

[    0.599711]  of_irq_parse_and_map_pci+0x1e4/0x284
[    0.599727]  pci_assign_irq+0x130/0x158
[    0.599743]  pci_device_probe+0x5c/0x234
[    0.599757]  really_probe+0xbc/0x2a0
[    0.599771]  __driver_probe_device+0x78/0x12c
[    0.599786]  driver_probe_device+0x40/0x160
[    0.599800]  __device_attach_driver+0xb8/0x134
[    0.599815]  bus_for_each_drv+0x80/0xdc
[    0.599835]  __device_attach+0xa8/0x1b0
[    0.599849]  device_attach+0x14/0x20
[    0.599863]  pci_bus_add_device+0xec/0x198
[    0.599882]  pci_bus_add_devices+0x38/0x84
[    0.599900]  pci_bus_add_devices+0x64/0x84
[    0.599919]  pci_host_probe+0x90/0x108
[    0.599932]  rzg3s_pcie_probe+0x3c8/0x4f0

Activating the of_print_phandle_args("of_irq_parse_raw: ", out_irq) debug
from of_irq_parse_raw() prints the following:

of_irq_parse_raw:  /soc/pcie@11e40000/pci@0,0:00000001

requesting INTA.

From this I understand the interrupt is requested from the pci@0,0 node
created by of_pci_make_dev_node() for child bus device. This matches the
1st interrupt-map of the pci@0,0 node:

interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x00>

and then the of_irq_parse_raw() goes to the node with phandle 0x1f
(pcie@11e40000) and tries to find a map for IRQ "0x00 0x11e40000 0x00 0x00"
entry but this one is not there.

Updating the interrupt-map property of pcie@11e40000 node by adding
<0x00 0x00 0x00 0x00 0x1f 0x00 0x00 0x00 0x00> entry solves the issue I'm
seeing:

    interrupt-map = <0x00 0x00 0x00 0x00 0x1f 0x00 0x00 0x00 0x00
                     0x00 0x00 0x00 0x01 0x1f 0x00 0x00 0x00 0x00
                     0x00 0x00 0x00 0x02 0x1f 0x00 0x00 0x00 0x01
                     0x00 0x00 0x00 0x03 0x1f 0x00 0x00 0x00 0x02
                     0x00 0x00 0x00 0x04 0x1f 0x00 0x00 0x00 0x03>;

The code that updates the interrupt map for the node created by
of_pci_make_dev_node() is of_pci_prop_intr_map(). This looks in the IRQ
mapping tree for an INTx interrupt match and looks it up to the parent node
than can provide this interrupt. If a match is found it returns the match
for the node that can provide the interrupt. And this information is used
to populate the interrupt-map property of the node that can is created by
of_pci_make_dev_node().

The following diff I tried solves the problem I see:

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 506fcd507113..7d7f469a1db6 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -243,6 +243,10 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev,
struct of_changeset *ocs,
                }
                of_property_read_u32(out_irq[i].np, "#address-cells",
                                     &addr_sz[i]);
+               /* Restore the arguments of the next level parent if a map
was found. */
+               out_irq[i].np = pnode;
+               out_irq[i].args_count = 1;
+               out_irq[i].args[0] = pin;
        }

        list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {

With this, the live pcie device tree node is as follows:

pcie@11e40000 {
    power-domains = <0x02>;
    dma-ranges = <0x42000000 0x00 0x48000000 0x00 0x48000000 0x00 0x38000000>;
    pinctrl-names = "default";
    #address-cells = <0x03>;
    bus-range = <0x00 0xff>;
    pinctrl-0 = <0x21>;
    clock-names = "aclk\0pm";
    resets = <0x02 0x53 0x02 0x54 0x02 0x55 0x02 0x56 0x02 0x57 0x02 0x58
0x02 0x59>;
    interrupts = <0x00 0x18b 0x04 0x00 0x18c 0x04 0x00 0x18d 0x04 0x00
0x18e 0x04 0x00 0x18f 0x04 0x00 0x190 0x04 0x00 0x191 0x04 0x00 0x192 0x04
0x00 0x193 0x04 0x00 0x194 0x04 0x00 0x195 0x04 0x00 0x196 0x04 0x00 0x197
0x04 0x00 0x198 0x04 0x00 0x199 0x04 0x00 0x19a 0x04>;
    clocks = <0x02 0x01 0x65 0x02 0x01 0x66>;
    interrupt-map = <0x00 0x00 0x00 0x01 0x1f 0x00 0x00 0x00 0x00
                     0x00 0x00 0x00 0x02 0x1f 0x00 0x00 0x00 0x01
                     0x00 0x00 0x00 0x03 0x1f 0x00 0x00 0x00 0x02
                     0x00 0x00 0x00 0x04 0x1f 0x00 0x00 0x00 0x03>;
    #size-cells = <0x02>;
    renesas,sysc = <0x20>;
    device_type = "pci";
    interrupt-map-mask = <0x00 0x00 0x00 0x07>;
    num-lanes = <0x01>;
    compatible = "renesas,r9a08g045s33-pcie";
    ranges = <0x3000000 0x00 0x30000000 0x00 0x30000000 0x00 0x8000000>;
    #interrupt-cells = <0x01>;
    status = "okay";
    vendor-id = <0x1912>;
    interrupt-names =
"serr\0serr_cor\0serr_nonfatal\0serr_fatal\0axi_err\0inta\0intb\0intc\0intd\0msi\0link_bandwidth\0pm_pme\0dma\0pcie_evt\0msg\0all";
    reg = <0x00 0x11e40000 0x00 0x10000>;
    phandle = <0x1f>;
    reset-names =
"aresetn\0rst_b\0rst_gp_b\0rst_ps_b\0rst_rsm_b\0rst_cfg_b\0rst_load_b";
    device-id = <0x33>;
    interrupt-controller;

    pci@0,0 {
        #address-cells = <0x03>;
        bus-range = <0x01 0xff>;
        interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x01
                         0x10000 0x00 0x00 0x02 0x1f 0x00 0x11e40000 0x00 0x02
                         0x10000 0x00 0x00 0x03 0x1f 0x00 0x11e40000 0x00 0x03
                         0x10000 0x00 0x00 0x04 0x1f 0x00 0x11e40000 0x00
0x04>;
        #size-cells = <0x02>;
        device_type = "pci";
        interrupt-map-mask = <0xffff00 0x00 0x00 0x07>;
        compatible = "pci1912,33\0pciclass,060400\0pciclass,0604";
        ranges = <0x82000000 0x00 0x30000000 0x82000000 0x00 0x30000000
0x00 0x100000>;
        #interrupt-cells = <0x01>;
        reg = <0x00 0x00 0x00 0x00 0x00>;
    };
};

Note the interrupt-map property of pci@0,0 changes.

This started to reproduce on my side after the CONFIG_PCI_DYNAMIC_OF_NODES
was enabled in ARM64 defconfig through commits:

b8e22cf599d1 ("arm64: defconfig: Enable OF_OVERLAY option")
10c68f40b86e ("arm64: defconfig: Enable RP1 misc/clock/gpio drivers")

Rob, Bjorn, Lizhi, PCI experts,

Can you please let me know your input on this?

Do you consider there is something wrong with the driver I'm working on
(series [1])?

Thank you for your support,
Claudiu

[1]
https://lore.kernel.org/all/20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com

>>
>> Rob: do you know some device trees where the interrupt-map points to the
>> node itself as suggested in [2] so that I can check is something is missing
>> on my side?
>>
>> Thank you,
>> Claudiu
>>
>> [2] https://lore.kernel.org/all/20250509210800.GB4080349-robh@kernel.org/
>> [3]
>> https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/apple/t8112.dtsi#L951
>>
> 
> Best regards,
> Hervé
> 


