Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664B42D095C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 04:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgLGDZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 22:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgLGDZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 22:25:52 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B71C0613D1
        for <linux-pci@vger.kernel.org>; Sun,  6 Dec 2020 19:25:11 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id p126so13944280oif.7
        for <linux-pci@vger.kernel.org>; Sun, 06 Dec 2020 19:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C2Ix5oeKbqJKBSFQum17pYUeNiQgWG4qBDaCP6pF+9E=;
        b=pzZKsSd8MbNoUDnMdPCVc5u6LHTCjTVi1zdUIqAWpWGrKhn2SS+tAQeQc1vQfqA/M1
         uo8emwG4ei0ap7lYcKus+vFJPiNL9SkPX5E4aXMBBvKSXAMv+GrpZrRpXHAngVWkMhZd
         klK8iivt8DWyHnAvHGkqeKM1A5/ecGxXpIvop6wwC85CtjCZLEoGJz1YariaxwQOd4Zm
         uqNOHPLKB8eFtTXr1BHAUBlQr03aC+bJPtTF9wkNuDxCLJUuwzK8mgvxbRXeo+ieU7Zu
         dGmAKaT/2GABKN60dHgCOR2thZ66V1CUcFOY5jb1kZDWWyVqgLj/rGwqLg55Mz3hUZyh
         iFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C2Ix5oeKbqJKBSFQum17pYUeNiQgWG4qBDaCP6pF+9E=;
        b=KUN/B9+OsN2FY9hYR+KscFe6+cwaD8It7vqdH53tLpg9GC+GRB5CXYrUJ3ODzbelyl
         9sq57KkcK5zfxC/pmvRI199ip1E/J+ds5wL2q2q6RBKVYHHiYufLKkPDxoHLtfUd/QEt
         fz/glHbisGONAvw8gqFw3jb9dTR6/zGxzWGJyFuU+aLwApiz601o1bZ4mATR4e9AmpvS
         1iUbMOGlQ+OHuohQ1aP0aGrF+sZf/JFnhqBHWDhHWQoJJ9sKp12thHQ1k3Igrn1vg3bw
         Y0ocw8ruZxg6jAkBg6YtibmKfO0i6z0M9Kqz0NYh1P1SgECydy5mI2vPa1cqwwFVPw21
         eEXg==
X-Gm-Message-State: AOAM531ER6haM38ewWbjI15Pt1dBWAqDsP2Ao0N5SIXlp1XMbKNTE29E
        GnQ7XlEqshwFdBvORm/GKuA=
X-Google-Smtp-Source: ABdhPJzczOydwnK1CTI9pP9bxm9+oAl7Jgo4Mw8k7GQ6HD6zylEV81DWrC05uDG06SC4srcr560HGA==
X-Received: by 2002:aca:3d0b:: with SMTP id k11mr11306704oia.122.1607311511211;
        Sun, 06 Dec 2020 19:25:11 -0800 (PST)
Received: from ?IPv6:2600:1700:dfe0:49f0:98c0:b1b6:3436:9662? ([2600:1700:dfe0:49f0:98c0:b1b6:3436:9662])
        by smtp.gmail.com with ESMTPSA id k5sm2350693oot.30.2020.12.06.19.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 19:25:10 -0800 (PST)
Subject: Re: [PATCH v6 1/5] PCI: Unify ECAM constants in native PCI Express
 drivers
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201129230743.3006978-1-kw@linux.com>
 <20201129230743.3006978-2-kw@linux.com> <X808JJGeIREwqIjb@rocinante>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <094b314f-7f61-d0fd-fd63-c9c4da9e84a8@gmail.com>
Date:   Sun, 6 Dec 2020 19:25:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X808JJGeIREwqIjb@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+JimQ,

On 12/6/2020 12:16 PM, Krzysztof Wilczyński wrote:
> Hello Nicolas, Florian and Florian,
> 
> [...]
>> -/* Configuration space read/write support */
>> -static inline int brcm_pcie_cfg_index(int busnr, int devfn, int reg)
>> -{
>> -	return ((PCI_SLOT(devfn) & 0x1f) << PCIE_EXT_SLOT_SHIFT)
>> -		| ((PCI_FUNC(devfn) & 0x07) << PCIE_EXT_FUNC_SHIFT)
>> -		| (busnr << PCIE_EXT_BUSNUM_SHIFT)
>> -		| (reg & ~3);
>> -}
>> -
>>  static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>>  					int where)
>>  {
>> @@ -716,7 +704,7 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>>  		return PCI_SLOT(devfn) ? NULL : base + where;
>>  
>>  	/* For devices, write to the config space index register */
>> -	idx = brcm_pcie_cfg_index(bus->number, devfn, 0);
>> +	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
>>  	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
>>  	return base + PCIE_EXT_CFG_DATA + where;
>>  }
> [...]
> 
> Passing the hard-coded 0 as the "reg" argument here never actually did
> anything, thus the 32 bit alignment was never correctly enforced.
> 
> My question would be: should this be 32 bit aligned?  It seems like the
> intention was to perhaps make the alignment?  I am sadly not intimately
> familiar with his hardware, so I am not sure if there is something to
> fix here or not.
> 
> Also, I wonder whether it would be safe to pass the offset (the "where"
> variable) rather than hard-coded 0?
> 
> Thank you for help in advance!
> 
> Bjorn also asked the same question:
>   https://lore.kernel.org/linux-pci/20201120203428.GA272511@bjorn-Precision-5520/
> 
> Krzysztof
> 

-- 
Florian
