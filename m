Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020E69746A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 03:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjBOCi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 21:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjBOCi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 21:38:58 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE4279BA
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 18:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676428737; x=1707964737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LRGknKhxil6Qohqe+Jm3wtRMBjwrnnr85uMuaDhF6bI=;
  b=L2Lc9J39N6VF0bBx+z/QBKgWz60ZRGRx7YSdNbzWtN2aizvUsTBz/IlP
   gDTkJi2LsB9grqnhT0dIRCRLOizTEaPGD0W6k9wGE0dTS1pIqUUU03G9e
   AZhWRAyAvtNMvbRIMC6PAYJrrGy/4J+/3dFiqDpAJwVkjwqca3ZrVszhT
   7rLwQSIzHGJjeuaA7h3DUr7it2SGbCUHQ90JVm6y+xYNQxWJ1k8Lj6NEV
   ukuSdMvtHhwSGi3S9bKVm/waWanS0a1VEcspQx39xRX57pGxFuimqx93U
   HeLnxEXQOiadV5oj/ujTD7vbrjHndcD7z4SQ3JUx5jzZVFbAeCR905ZKe
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="335295975"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 10:38:55 +0800
IronPort-SDR: b7DYzLQq7EbTFuRv185/xtGc4A+7vc1/QGkkzGXw8eSwyEuRmWTFLVpaF8oWkkN1laNRpTSR4y
 AT62dYZQKPv06Vguyf9OZtLimMof5oSVDpdBviap6kgshx5QlUE7pAqOaqx9fCAqegBnecjJoM
 rEKLOXj7NbOjiLxpwNkTpbeyFhwM5XH/jsD3njQRzYROHvNYt5UzdVavrFGBGnhXfBrfGhAcaL
 3TZF0Egc4IoxFzO24LOfeIuBaE0DSF07Pfr360QJInHnrHJUnz0BwQqtp1WdyKe3WO2ymhon6h
 Pac=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 17:50:17 -0800
IronPort-SDR: yITQX1M3UDhUhhLv0wmybJV3GyvWnsJgvCIduJ78wtzprgi+CbuJ0mUyE+QPtuGgNupkaYmBhf
 fZVBKe+46S9DkFcD3TTkIxxkoqTEIUdICANyD1unA49rLnRzIBeUFRCXoNv0DhTbSslmLle/E9
 QD1hX08Tah0yHQf08pXHojZMNLquSTZrd3z4I8frweqBP9bc9eMpoXGHmK3OJxnMOJseFrg0ni
 doEfVWQC3Pg3n+dkX47YAGVmuyhFzy6bCAl73+B75CcPvn8QdwzzxsoUMBfSnQjEg7o3Hrlfqq
 msQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:38:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGj270Cbsz1RWy3
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 18:38:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676428733; x=1679020734; bh=LRGknKhxil6Qohqe+Jm3wtRMBjwrnnr85uM
        uaDhF6bI=; b=HFn/XTBOmCRXwNl1rv11Q40ZgxO+WDnGEOvySfbGvYcTidahx62
        0dVss0hxRSODx5fmEDRcNRrAHVRULPb3zexnP5C/mfGiyT6aeU3BOxWRtMwjOJ20
        B2GOfq0VTpQeTF8/ZoDgSiQst/+PTxvXfh06iiHVdxMPDEaffExqQK3d6zbPOb/k
        aJcrxb8uak5xKl3NmDtG0eMHfhOaCoDo67SwHXZbY4nVgVeQD6CutSyDih5ZtImx
        5eh8YjmMo6I2absY993+zR8I2QAFKKlc2fVkSODrt/eTiSxshauQ8EXXvLSpw2Zm
        oIr7IE34agdo4CiA1rbFyt7aWmy7dWyz3mw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ewlHsC9tTasb for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 18:38:53 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGj222VYbz1RvLy;
        Tue, 14 Feb 2023 18:38:50 -0800 (PST)
Message-ID: <ccdc6924-c35f-4a29-fabb-587271fc929c@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 11:38:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/9] PCI: rockchip: Fix legacy IRQ generation for
 RK3399 PCIe endpoint core
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        stable@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-8-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-8-rick.wertenbroek@gmail.com>
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
> Fix legacy IRQ generation for RK3399 PCIe endpoint core according to
> the technical reference manual (TRM). Assert and deassert legacy
> interrupt (INTx) through the legacy interrupt control register
> ("PCIE_CLIENT_LEGACY_INT_CTRL") instead of manually generating a PCIe
> message. The generation of the legacy interrupt was tested and validated
> with the PCIe endpoint test driver.
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 38 +++++------------------
>  drivers/pci/controller/pcie-rockchip.h    |  6 ++++
>  2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index cbc281a6a..ca5b363ba 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -328,45 +328,23 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
>  					 u8 intx, bool is_asserted)
>  {
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u32 r = ep->max_regions - 1;
> -	u32 offset;
> -	u32 status;
> -	u8 msg_code;
> -
> -	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
> -		     ep->irq_pci_fn != fn)) {
> -		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
> -					     AXI_WRAPPER_NOR_MSG,
> -					     ep->irq_phys_addr, 0, 0);
> -		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;

By the way, ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR is now unused. Remove it
too please.

-- 
Damien Le Moal
Western Digital Research

