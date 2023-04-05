Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B8B6D7BF3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjDELur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbjDELuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 07:50:46 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615619A1;
        Wed,  5 Apr 2023 04:50:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5A465582376;
        Wed,  5 Apr 2023 07:50:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 07:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680695444; x=1680699044; bh=zQlWYtVpffDPNaN/W+FRH19H3U4y1mSyepB
        pvfmz0io=; b=d/BjLmvKaKa4k49dQJ7knYYlWBme4oeyYCFvJiyX8FkVQJSfw1x
        UtB2sQGTIuDPrFhl6FsPMMHJ3a4XgWYuXkBKz3F2qCjYhdkFTFAIkezWsL7uaod/
        0dWrJEc0yYslj37jUTgYwJMH4Il7hrybnQGCy1RvmWDLPk6miqzcvnn/QPRYdTRk
        x40AFz85DPwrL6WbuUEgzqihP1x/JJdTrSMpWofjZ+HKBafHgGY/hbLDpM391+9I
        86OFnuP8R27y3+3hvMbmZODhXbq2iQHasqUXnF7Un5xPNMC+48fNxVHhKtuCy/J1
        Hm6uvuiuFQMLk2zKQiFhNHgZdfFNFMfD6qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680695444; x=1680699044; bh=zQlWYtVpffDPNaN/W+FRH19H3U4y1mSy
        epBpvfmz0io=; b=frudSLj4wAS4pmeVPPIydjO4UAjlavwktxIjHlu7ZPBVQlBU
        NV0VQOhLX4Jzl/Odpgg7nHDl4O9WplZErF+iZYpQVaJhJZIsKZoKxLB36ZdlUJqo
        IxFq7zBwe3oVOM0azaIcLKuH6gM6mW0gqsq9n4VdgMn7xbtWnfhJ5CwPEvjOiuLh
        rQBhcm/54xa+eIkFzRn38GA6Ira6KULIBvWKgIqsuIzgrqHgDel/Wtj56Js/Ovjt
        w6LO3sMTCTQZUlxrUFhQTPWTO4F05jgS1mmoBB4nLt5jpjACaTqy+ZVxhuaPg/ox
        VEmEMMyb1EIRkszHQbr+09Zn2XXk73YnxTXL0w==
X-ME-Sender: <xms:k2AtZJ56YGZOfODcwsQdPbjl4c7sLJUgy0pvAoBJvSioQ0aIUu9fQA>
    <xme:k2AtZG5F3Jq7I-T6q-qVBdyhjsobwFcnJsIi6vHkUHeLRM0SzLtotFXq_87Jqpko7
    dOUEmr2POteDtXyORc>
X-ME-Received: <xmr:k2AtZAe88jKOWMPkpGvkQEPaTEwn2mkZfo1tIls5eL_iVmXbf8m-FjINYQiINxB4yInMWcVHvt1Cgfpefbf54DC3MW6YQ2Dx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:k2AtZCLFn3MsL7gvd8wLG3CuLJxW5n4nOynka_DFT-9dKDo-5HArGQ>
    <xmx:k2AtZNI_vzkrEL29tDoOReEqqmQdlYAOjJ3ikWnYHgDRFgUWB8I6hA>
    <xmx:k2AtZLx0Q9wrt2PaHPg5EvkLjtauj_XsM7xEVyFGCJ92O-OgjTnXoQ>
    <xmx:lGAtZN47bdywGM6YzmvH9sB_j4rYKZqy6gKJDAtWyhTKORP9ky-uM1l0goA>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 07:50:38 -0400 (EDT)
Message-ID: <c14a2e98-1ca0-35c5-ae05-b44c1baafa7f@fastmail.com>
Date:   Wed, 5 Apr 2023 20:50:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 10/11] PCI: rockchip: Don't advertise MSI-X in PCIe
 capabilities
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
 <20230404082426.3880812-11-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <20230404082426.3880812-11-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/4/23 17:24, Rick Wertenbroek wrote:
> The RK3399 PCIe endpoint controller cannot generate MSI-X IRQs.
> This is documented in the RK3399 technical reference manual (TRM)
> section 17.5.9 "Interrupt Support".
> 
> MSI-X capability should therefore not be advertised. Remove the
> MSI-X capability by editing the capability linked-list. The
> previous entry is the MSI capability, therefore get the next
> entry from the MSI-X capability entry and set it as next entry
> for the MSI capability. This in effect removes MSI-X from the list.
> 
> Linked list before : MSI cap -> MSI-X cap -> PCIe Device cap -> ...
> Linked list now : MSI cap -> PCIe Device cap -> ...
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 15 +++++++++++++++
>  drivers/pci/controller/pcie-rockchip.h    |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 924b95bd736c..20c768287870 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -510,6 +510,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	size_t max_regions;
>  	struct pci_epc_mem_window *windows = NULL;
>  	int err, i;
> +	u32 cfg_msi, cfg_msix_cp;
>  
>  	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
>  	if (!ep)
> @@ -584,6 +585,20 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  
>  	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
>  

Nit: Adding a comment here about what this is doing and why would be nice. E.g.
something like:

	/*
	 * MSI-X is not supported but the controller still advertises by default
	 * the MSI-X capability, which can lead to the RC-side attempting to use
	 * MSI-X. Avoid this by skipping the MSI-X capability entry in the
	 * chain of PCIe capabilities: get the next pointer from the
	 * MSI-X entry and set that in the MSI capability entry. This way
	 * the MSI-X entry is skipped (left out of the linked-list).
	 */

> +	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> +				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +
> +	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
> +
> +	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> +					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
> +					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
> +
> +	cfg_msi |= cfg_msix_cp;
> +
> +	rockchip_pcie_write(rockchip, cfg_msi,
> +			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE, PCIE_CLIENT_CONFIG);
>  
>  	return 0;
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 1558eae298ae..a21070ea7166 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -226,6 +226,8 @@
>  #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
>  #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
>  #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
> +#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET		8
> +#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK			GENMASK(15, 8)
>  #define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
> @@ -233,6 +235,9 @@
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
> +#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG			0xb0
> +#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET		8
> +#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK		GENMASK(15, 8)
>  #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
>  #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
>  #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn) \

