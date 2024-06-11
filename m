Return-Path: <linux-pci+bounces-8595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25434904038
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F92A1F2535E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62C38390;
	Tue, 11 Jun 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FAXcNqXS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510E2F50A
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120351; cv=none; b=Jk2+ZiyjKRkf28zqRd18726LcKWmQmZ0Zt/C4wgAimsuO0GtJyBLWROGM0jdYKDbEwZyVLB5j8IKCBubJx5chWNkXoHH4iZcK1IoNSOGqDA8hO+CqHu6iipoa3s5HIExEjW7JPD2+rYAKSpK/NdZLSB3hje0KqOuNzix2EyeNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120351; c=relaxed/simple;
	bh=OTaL90AXV5eLd7cwrRGQ6YBQCVQKp35jIqJFQ1iMDAc=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cZmetBBUK3JNBAsKKQjDFb3Lk4mbkBbruGBwFbditVDjMxntdx5XoQ0H07NQ99ftmbujnkASrz6ysgBVvwMrHqh/hSFBl9xnlurv7uVPsCWhCzEcgMAPXcfdo1kHWc5elpZ78f3bLI+JF1v/Z5SmMO8Oes6y9iym9H0SxYFdFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FAXcNqXS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a62ef52e837so715925866b.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718120346; x=1718725146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hLG3B4Y+fGWVVVSqMDpP2O4ocS16RJ3mfLQLjDGSKMU=;
        b=FAXcNqXSV5pzEq2B9cnkll0/geRAUviZ7LxQF8B4EfZk1vZ/uRHgmzrrbftN8h1xJI
         gqXFEFJS1cppmNBgWZoTKr77URR+GxTnn+flLC55oPLfhXrbGtEMeUhMbDUJkxhKt9bF
         BXkuRfgXa5jUDr6bUzVhMggF7LbTzI08LscuGazw4DHWUk3hCJ7a5Xgh8Os40tu+YT45
         vcWTjyPXvQ1E8Dge8X7tsr9AVMyXb8jL6x6nnIwLBGdJ3yyAK1Hmb6kon1woeh6zXvqp
         NkVvOyJ5hqL+hfzKYANWv4zcgo4j2F0aekkm0TeHOfmEhLl58nAjyd0jPlDWAUh/lKFy
         QL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718120346; x=1718725146;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLG3B4Y+fGWVVVSqMDpP2O4ocS16RJ3mfLQLjDGSKMU=;
        b=Faad/j8iLlAHc2o5Hv9T9XG+bh5hZTbyNzVZ7iCL+17dc2foGiPsoetjleBqllObhr
         cuyZh6eavx+9lGVJlZyNX1htRA+g9HkgvfRQw5uGviTKpQ854ufPmKsbdjeZfnsLTNm9
         X/ACJPTlJQYdR6fRURqoZ95zas74d+e/hsNa2cIYOSejzmQvKbPLZXEFI7+Bbzul+iRt
         +3+7ylky18DfFVNHPp2HbRVX9gxtxM0BDiI2n8esUkDIebfXSOuc5csZvjpXT3dJEB3Z
         6Qy+pWqF3j0QmlHZkxeZQJ01N6D/RydmVesSIeoGTrt3xWSrsBcVgrAtai96/NRZyT83
         JX2A==
X-Forwarded-Encrypted: i=1; AJvYcCWHloRKxdJYgXe3fNjDEE70vOt0MkYDuIZ9eQNhJeHFJfOUPEFF0IigKiVsLtKo+0AZ7Bz82csvGxR0ZY2/uvht5gntjHa/R4L1
X-Gm-Message-State: AOJu0YylKqnAy/yvlq/aGVyU6BzgCj768EoZFOFOiXIZ0jaHnVVPW8cd
	+9Ztw0pUUtj/YOS/JxrUKp8hdpfvDH1lNnSw72jE+Y4dJzV4N/phW3xSur5nTYA=
X-Google-Smtp-Source: AGHT+IGAiKP4S1ta0ypfd8GPYxs98AzoX0FvmrkDa7V2d9yDAJ1SdodaZM4gcGz3kq8Xk2Ny5tPKCw==
X-Received: by 2002:a17:906:128d:b0:a6f:40d5:e287 with SMTP id a640c23a62f3a-a6f40d5e332mr58510666b.74.1718120346331;
        Tue, 11 Jun 2024 08:39:06 -0700 (PDT)
Received: from localhost (host-79-27-228-9.retail.telecomitalia.it. [79.27.228.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef7913eb8sm537255666b.178.2024.06.11.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:39:06 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 11 Jun 2024 17:39:23 +0200
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>, clement.leger@bootlin.com
Subject: Raspberry Pi5 - RP1 driver - RFC
Message-ID: <ZmhvqwnOIdpi7EhA@apocalypse>
Mail-Followup-To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>, clement.leger@bootlin.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
I'm on the verge of reworking the RP1 driver from downstream in order for it to be
in good shape for upstream inclusion.
RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting a pletora
of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, etc.) whose registers
are all reachable starting from an offset from the BAR address.
The main point here is that while the RP1 as an endpoint itself is discoverable via
usual PCI enumeraiton, the devices it contains are not discoverable and must be
declared e.g. via the devicetree. This is an RFC about the correct approach to use
in integrating the driver and registering the subdevices.


--- CURRENT DOWNSTREAM APPROACH ---

The DTS shows something like this (see [1] and [2]):

pcie {
	compatible = "brcm,bcm2712-pcie";
	#address-cells = <0x03>;
	#size-cells = <0x02>;
	ranges = <0x2000000 0x00 0x00   0x1f 0x00   0x00 0xfffffffc>;
	...

	rp1 {
		compatible = "simple-bus";
		#address-cells = <0x02>;
               	#size-cells = <0x02>;

		ranges = <0xc0 0x40000000   0x2000000 0x00 0x00   0x00 0x400000>;
		...

		serial@34000 {
			compatible = "arm,pl011-axi";
			reg = <0xc0 0x40034000   0x00 0x100>;
			...
		};
	};
};

The PCI bar address here is at CPU physical address 0x1f00000000 and the RP1 driver
probe function calls of_platform_populate() on the 'rp1' node to register the platform
drivers for each subdevices (e.g. in the above example: 'serial@34000').

Pros:
- quite straightforward to implement
- RP1's dts resides in the directory it should (possibly but not necessarily) belong to,
  e.g. somewhere under arch/*/boot/dts/...

Cons:
- the board dts must manually override 'pcie' ranges (in this case 0x1f00000000)
  depending on the BAR address value, while it should be retrieved by reading the PCI
  config register instead
- the probe() function retieves a reference to 'rp1' node via of_find_node_by_name(NULL, 
  "rp1"), harcoding the node name. This is not desirable since the node name is then set
  in stone, or otherwise if the node name needs to be changed it must be changed either
  in the dts *and* in driver code.


--- ROB HERRING, LIZHI HOU (et al.) PROPOSED APPROACH ---

A proposal (see [3]) presented at  LPC advise to create a PCI bridge DT node ('pcie') leveraging
the current OF dynamic infrastructure, adding a dtb overlay ('rpi1' node in the example
above) on top of it during probe and rearranging the 'ranges' mapping dynamically.
This sounds like the correct approach and is somewhat used in at least a couple of drivers
(namely for Alveo U50 card and MicroChip LAN9662 SoC) but AFAIK none of them made their way
to mainline, leaving some doubts about the applicability of this paradigm.

Pros:
- no need to provide the BAR address manually since it will be discovered and automatically
  amended into the 'ranges' property
- no harcoded reference to 'rp1' node since the endpoint node will be reparented to the 'pcie'
  node automatically
- the core OF dynamic infrastructure on which to base these changes are basically already in 
  mainline (see [4] for discussions)

Cons (albeit I'd consider them minor ones):
- CONFIG_PCI_DYNAMIC_OF_NODES must be enabled
- the dtb should probably reside somewhere near the driver source code, e.g. in drivers/mfd/...


--- AUXILIARY BUS APPROACH ---

The thread in [5] seems to advise to use the auxiliary bus for this kind of devices. In this
case, here's the drawbacks:

- as stated in kernel docs for aux bus (cit.) "need a mechanism to connect and provide access
  to a shared object allocated by the auxiliary_device’s registering driver...", and again 
  (cit.) "A key requirement for utilizing the auxiliary bus is that there is no dependency on
  a physical bus...These individual devices split from the core cannot live on the platform
  bus as they are not physical devices that are controlled by DT/ACPI". Those statements are
  of course at the opposite of how RP1 behaves
- subdevices drivers may need rework in order to cope with the auxiliary bus, while we need to
  use the already existing drivers without modifications

so, for all of the above (and probably other cons I'm not aware of right now), the auxiliary bus
does not seems feasible to be used, but I'm mentioning it just because of the discussionin in [5]
that let me wonder whether I may be missing something relevant here.


CONCLUSIONS

All in all, I'd say Rob's approach should be the way to go, any thoughts about it will be
greatly appreciated.

Many thanks,
Andrea della Porta

Link:
- [1]: https://github.com/raspberrypi/linux/blob/rpi-6.6.y/arch/arm/boot/dts/broadcom/rp1.dtsi
- [2]: https://github.com/raspberrypi/linux/blob/rpi-6.6.y/drivers/mfd/rp1.c
- [3]: https://lpc.events/event/17/contributions/1421/attachments/1337/2680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
- [4]: https://lore.kernel.org/lkml/20230419231155.GA899497-robh@kernel.org/t/
- [5]: https://lore.kernel.org/lkml/Y862WTT03%2FJxXUG8@kroah.com/

