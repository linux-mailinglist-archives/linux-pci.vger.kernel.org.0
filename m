Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F601DDC60
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgEVBEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 21:04:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35484 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVBEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 21:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590109467; x=1621645467;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gD0Mmp36tWWvKenJoMmkqjxvUYivz3GgCXTadY4Oz8w=;
  b=HBT+Hm9oV6Cz+xEpVqOlnkRNduxZKu1F2pJ20c2pI2b8ZbDTpOE4hjtK
   V+ezsKv/ct3wJN+DG+djxEWczfUIuUsLuohwFeXuGO5S4l/kAHo29m8Fv
   TDZj0n+Zyp+fyBY6IzszvB9uR011u7HM7Nk30uWtrGXlwWbOYS460Ca4Q
   EJ2Q6YsvPFx/myTvJ9Q6CNLrxC3nyl5z4BPisB0PSLkl/V5h8kn9a0b9+
   8YTK9L4+rQHAzoUtPq5hMqFMz2/PE9mxfEqG6cJbYzsd4piKqgsOK9QQu
   ninOxUy03BELBq5DwBC/afCXIxMnZfXm7Wl8N2q/JdIFm9bnIWgItB+xy
   A==;
IronPort-SDR: B44ijviYw1v1QuWJwGXqWJJooYnMdAYdXte37IjfXtzPeN2gZCv+oZrTaGkzbPi8mZApJMal1d
 Kox9oo5c4F09yYDkExlHF2ksVSo9J54N1qte/xOsFIVoY3vLdDci0ObPVvW9usLOlTpwoW/C/7
 s9Nxf+JPOQ03UH+2etv5u1UIiTr6S2ZkiW3R/Zt35amdHAv7LtF4VYnGb+w31dfqLnnUT/jNQ0
 fIT+Fvb8Yj0zszeHQnPtnOAzPmRjZHRfOZsQOJCEefpNbxxCO0KPaihHsxXC3sViKv4IieVZE9
 Xdc=
X-IronPort-AV: E=Sophos;i="5.73,419,1583164800"; 
   d="scan'208";a="241029128"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2020 09:04:37 +0800
IronPort-SDR: h//N3R+ZbkPdMBVbJ3azzyazXQ6IXamfjYGys/E4IT1UBptKjQ9V3LxBoa7r/eVswNF1Knnh6M
 4qHoB2ti0Qdc2VIsOuTkfK/7EycqRlTWA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:54:12 -0700
IronPort-SDR: AACqdndHAWEilkfGYIKngoypr3umi5vbJCaRoPmbK0qkzwOsO4+CjnpVaXW/N0fP5JJqCfwOGj
 Ul2DoX96QPaw==
WDCIronportException: Internal
Received: from unknown (HELO redsun52) ([10.149.66.28])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 18:04:11 -0700
Date:   Fri, 22 May 2020 02:04:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Paul Burton <paulburton@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: piix4-poweroff.c I/O BAR usage
In-Reply-To: <20200520135708.GA1086370@bjorn-Precision-5520>
Message-ID: <alpine.LFD.2.21.2005220144230.21168@redsun52.ssa.fujisawa.hgst.com>
References: <20200520135708.GA1086370@bjorn-Precision-5520>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

 Paul may or may not be reachable anymore, so I'll step in.

> This looks like it might be a bug:
> 
>   static const int piix4_pm_io_region = PCI_BRIDGE_RESOURCES;
> 
>   static int piix4_poweroff_probe(struct pci_dev *dev,
>                                   const struct pci_device_id *id)
>   {
>           ...
>           /* Request access to the PIIX4 PM IO registers */
>           res = pci_request_region(dev, piix4_pm_io_region,
>                                    "PIIX4 PM IO registers");
> 
> pci_request_region() takes a BAR number (0-5), but here we're passing
> PCI_BRIDGE_RESOURCES (13 if CONFIG_PCI_IOV, or 7 otherwise), which is
> the bridge I/O window.
> 
> I don't think this device ([8086:7113]) is a bridge, so that resource
> should be empty.

 Hmm, isn't the resource actually set up by `quirk_piix4_acpi' though?

> Based on this spec:
> https://www.intel.com/Assets/PDF/datasheet/290562.pdf,
> it looks like it should be the PIIX4 power management function at
> function 3, which has no standard PCI BARs but does have a PMBA (Power
> Management Base Address) at 0x40 and an SMBBA (SMBus Base Address) at
> 0x90 in config space.

 Correct, this is what Malta firmware reports for this function:

Bus = 0x00, Dev = 0x0a, Function = 0x03
Vendor Id = 0x8086 (Intel), Dev ID = 0x7113 (PIIX4 Power)
 Min Gnt = 0x00, Max Lat = 0x00, Lat Tim = 0x20
 Int Pin = None, Int Line = 0x09
 BAR count = 0x02
  IO:  Pos = 0x40, Base(CPU/PCI) = 0x18001000/0x00001000, Size = 0x00000100
  IO:  Pos = 0x90, Base(CPU/PCI) = 0x18001100/0x00001100, Size = 0x00000100

I'm somewhat familiar with this southbridge, although this was looong ago.

> I suppose on an ACPI system the regions described by PMBA and SMBBA
> might be described via ACPI, since they're not discoverable by
> standard PCI enumeration?  Pretty sure you don't have ACPI on MIPS
> though.
> 
> Maybe the driver should read PMBA and SMBBA and reserve those regions
> by hand with request_region()?

 Well, I think `quirk_piix4_acpi' covers it.  It dates back to 2.3.49 
AFAICT.  I can try to boot my Malta system over the weekend to see if 
there are any issues with it, but I'm fairly sure there is none here.

  Maciej
