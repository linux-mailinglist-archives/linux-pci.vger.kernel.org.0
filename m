Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8538B697228
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBNX4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjBNX4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:56:10 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E32413C
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676418969; x=1707954969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pEnLWNUeiDXooxyuVty+8cCKql27+XR1BGKYZjuILOw=;
  b=QFVdVrnQWRBrC5HWhPEZvfWMHTCamzvA++afssabAQ5F7jdgOCyoxJXK
   PXDnsX2aEOodeC+RJT7jrod9yQ4DvOppIGIlEr8rbQPQ0qNEapBARhJ1X
   Bqqs1eUpf05yhoKGV6nExqfSLp79ZKGKaIKDf43O4tnCjw2t4VKGZha0K
   rG/KbYyKKeGQWIxDTM52tHVrth6ZroVyEuZjn6PA+NN4zlXCFKsgcIwsN
   eqUt+qPzS2Y1KIvpf20NrjYk2wkUGFj4V4ch7QreHC434DYy93xw+nUlL
   gbn6IAYdQ+2/ISk3spXx2vVqyJv5t3ItAojbd649V/5VWqAP5IjbnBxj7
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="335284580"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 07:56:08 +0800
IronPort-SDR: SXDOQxaVgPKC/kqrYbJQk+uTc9IvxA9z0fRS6cicZaLjxO6Cd7MoEfT29f2rmB2DA7Yo2zNL55
 qo3VyNhohj7U05pekfJitG6AazkhKoYS3KNt5XiyIVp59sS6POFPZp65uUjuAHaSWbJtk3UCpt
 GPkOO3c8j2/+gvUhbQHATKXWBkqeehPz2/foYwng2/uIlPpAR5Vm9zeXE1y0/42Qz7mV4wiLDd
 dFZfPxZlEqpoGVPyYIQSKiD5IZHi5t2YZWXvzO1w/6coQSmvb8lRuEzX/cjVZo6wXbPqvavQaX
 Qng=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:07:30 -0800
IronPort-SDR: 0tSLlQT9cBFC+3RNmsD6hnL6QBkfIsoOevvHQp5WKFJMXIESAV5GbRgS90tJ/M9VN2zcEEkKgh
 JMC5eVyHCW8F+qFoa+pPMUacmAhfswL+g0/OfaOGRodKlH+63t6H+GACyBruE2hyZQxb0Tp+cP
 otrYA9nslfjnLEaMMbAPqzyedfZrVzMAUh0u/lDJYXvseCytP7WAS4WubSpi+dVRqzoK52s2hB
 Go66xE3Wr5LZ4R6zIFwb37dn21vRW7yHXtPacwSgaYDK8M8Uqjv20snu/dMukTIV61k0DW7aju
 AKY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:56:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGdQH5Gnjz1RwqL
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 15:56:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676418966; x=1679010967; bh=pEnLWNUeiDXooxyuVty+8cCKql27+XR1BGK
        YZjuILOw=; b=ikPUjaoUBrwQzD0XtJBdPMNlUgHr9DIs/NZUcygVDiRPAgQWpRN
        GH4ICJUSMCYC73uHMjkCKsKzF/v5w/QgmRt9hR5POPV32S8hDk220xWZdU0oytDo
        qAXQpf2021exeZ5/ZTgO0BKKx5ohsspoKFwX5lt9UG1261LW/spWaQ9aKHmZyDzZ
        9878KXRrPX1hX+KRVSQQaJAG1W4BMGJfjhr0fi6WShB7hQbZAPVUYL9gcbzXx08f
        vGwpE77XRMOM5EmEnA7j+ciioKnKW4vvEa9U0NCHvV3NcWiQgsHVz4y6C6RjUmO5
        Yp62eaCXHahoZbnK4blMKgmZZ8ikXQketbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OZykQFtf80pA for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 15:56:06 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGdQC15SSz1RvLy;
        Tue, 14 Feb 2023 15:56:02 -0800 (PST)
Message-ID: <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 08:56:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-2-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-2-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Remove write accesses to registers that are marked "unused" (and
> therefore read-only) in the technical reference manual (TRM)
> (see RK3399 TRM 17.6.8.1)
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

I checked the TRM and indeed these registers are listed as unused.
However, with this patch, nothing work for me using a Pine rockpro64
board. Keeping this patch, your series (modulo some other fixes, more
emails coming) is making things work !

So I think the bug is with the TRM, not the code. THinking logically about
htis, it makes sense: this is programming the address translation unit to
translate mmio & dma between host PCI address and local CPU space address.
If we never set the PU address, how can that unit possibly ever translate
anything ?

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index d1a200b93..d5c477020 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -61,10 +61,6 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
>  			    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
>  	rockchip_pcie_write(rockchip, 0,
>  			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
> -	rockchip_pcie_write(rockchip, 0,
> -			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(region));
> -	rockchip_pcie_write(rockchip, 0,
> -			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
>  }
>  
>  static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
> @@ -114,12 +110,6 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
>  		     PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
>  		addr1 = upper_32_bits(cpu_addr);
>  	}
> -
> -	/* CPU bus address region */
> -	rockchip_pcie_write(rockchip, addr0,
> -			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r));
> -	rockchip_pcie_write(rockchip, addr1,
> -			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
>  }
>  
>  static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,

-- 
Damien Le Moal
Western Digital Research

