Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53ED6973C2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 02:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBOBju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 20:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjBOBjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 20:39:49 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07702ED57
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 17:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676425188; x=1707961188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oy+5bs8bztFCfWMEixVu7mADVC2yPYRnwRT4aa/6byw=;
  b=CD2V0OaMg4+QxV0hD8pqvu1QhRBWaRmxUR46+/JKy6iiiIR063XrRVdn
   I9NSakAu3yLPQewAj0gHe7eJJJ8vpBEBM2v2f/FLMa7ElJ5uGs0oo3VEQ
   GamYMWaSfCAWFM74IoG3aQyh//c4Q+38XaS0dcujlJEGYu5c51THsf8yc
   aV5+umKXyoTuP2bEhJpDVDye9HsBinylVl4gyDX3atam0BA9w+hMOuT28
   yMnKb6XtRbsurOmcdiMvU+bUXNqyVZ0/V/GJ2zbeoScnyTt0jN2wxY8FN
   IeuaGZKjl6EWiwjRT/dzuj6NhW1gTHv0kBTerfFebQm2+1OujtCWT8H+n
   g==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223117983"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 09:39:46 +0800
IronPort-SDR: lKcQ0Wv++nMxgSydGY5e6/PJQBafDA2gO2OYb3Gw8tPkge5HIfahaPzuO0BXqtqh1j0D8BL8ub
 u7rlnaAwRC4cAcJZ7yz0DuwqoWuY+oerZTfeUBKhg9ugmt7crpbiP86J5U3ZYajA93YOLTeDFu
 MRYSgz7GLi7Q6dsBzXCxNz4YkSw7U+4Fmds8EDSq+x8Req71ZY/UfTJ/8/1iW80a3Z56yq9OOA
 ds0n8hjUVFs5xVBRv+1N33SWYgxY1qHSzXYbq6D3uaQeOxI+bfT17zW9V/ZpJymSMY27rM3EEF
 mns=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 16:56:53 -0800
IronPort-SDR: JdZ3RRKeNmMbMYeXLzuyZ8xkqZj3qAE+iUJd0WM8Yb3XdLD/6qbGJIPI9KZOp0ux6PR8BEhKvr
 D2jjmgmoArzSSSHed/MBSp/byiK/Z2dUuqNz841n+YLi4WliRDPf5y7C6qFo45HIC1VA2bGANa
 2VT3+G26/QTdqqMG7xHaSxKIftrL9xTzeoAAv2YYAI+1Y7OwnFvx7bBC0mkDirhfd1KuRTgLuB
 AUuZLLczBByH5B+BaoIgljWoP1wG7sOLKLECHn5vBhpWg2gQwh+Ad6MpCtrnnpWTnPTfldIeGk
 +OA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 17:39:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGgjs46D8z1RwvL
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 17:39:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676425184; x=1679017185; bh=oy+5bs8bztFCfWMEixVu7mADVC2yPYRnwRT
        4aa/6byw=; b=fOcVMEdSFlGAd1ybZTpNogWSvYjl6ZCDZG1CJdrrh3tdQynF8wa
        MiE+19cVjiqq46ifzKZt3mxvuVEwCLksA7+QuHAQFOrZXLb3FSsKJ9slXisXT5RL
        XtBXMPaA9sCvCGH4/YoQC/LBjVRj/wkb8gVLj5pjWMOFbRu7bhcOw2qStLyVJbNf
        An1Mz9pv71TC3lt6OYaeHptV0N2JoQwSvZc2ceRcyXlNadb74ugk8Bi6Da47/Iq1
        SX01+63gwt+kDdCYfffcA0zaZJo/RUHyNng7i880SK1HA1qWSrszc+APpciLlVrt
        aaI4vSIi1tGdYbKPTNcod6fNrykE32mZZPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e14H6wDv890B for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 17:39:44 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGgjn1BCDz1RvLy;
        Tue, 14 Feb 2023 17:39:40 -0800 (PST)
Message-ID: <ebbddcfa-99e5-efda-0eab-fbd61a33e2c3@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 10:39:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 9/9] PCI: rockchip: Add parameter check for RK3399 PCIe
 endpoint core set_msi()
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
 <20230214140858.1133292-10-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-10-rick.wertenbroek@gmail.com>
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
> The RK3399 PCIe endpoint core supports only a single PCIe physcial
> function (function number 0), therefore return -EINVAL if set_msi() is
> called with a function number greater than 0.
> The PCIe standard only allows the multi message capability (MMC) value
> to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
> called with a MMC value of over 0x5.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index b7865a94e..80634b690 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
>  	u32 flags;
>  
> +	if (fn) {
> +		dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
> +		return -EINVAL;
> +	}

Checking this here is late... Given that at most only one physical
function is supported, the check should be in rockchip_pcie_parse_ep_dt().
Something like:

	err = of_property_read_u8(dev->of_node, "max-functions",
                                  &ep->epc->max_functions);

        if (err < 0 || ep->epc->max_functions > 1)

                ep->epc->max_functions = 1;

And all the macros with the (fn) argument could also be simplified
(argument fn removed) since fn will always be 0.

> +
> +	if (mmc > 0x5) {
> +		dev_err(&epc->dev, "Number of MSI IRQs cannot be more than 32\n");

Long line. Please split it after the comma.

> +		return -EINVAL;
> +	}
> +
>  	flags = rockchip_pcie_read(rockchip,
>  				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
>  				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);

Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
here all the time.

-- 
Damien Le Moal
Western Digital Research

