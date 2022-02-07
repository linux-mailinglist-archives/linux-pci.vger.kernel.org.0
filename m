Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7644AB583
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 08:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiBGHEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 02:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiBGGzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 01:55:38 -0500
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:55:33 PST
Received: from mail.tambre.ee (mail.tambre.ee [IPv6:2a01:7e01:e001:cc::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B0DC043185;
        Sun,  6 Feb 2022 22:55:32 -0800 (PST)
Received: from [172.16.1.108] (unknown [194.204.61.131])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: raul)
        by mail.tambre.ee (Postfix) with ESMTPSA id 249867EB02;
        Mon,  7 Feb 2022 08:47:26 +0200 (EET)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.tambre.ee 249867EB02
Authentication-Results: mail.tambre.ee; dmarc=fail (p=reject dis=none) header.from=tambre.ee
Authentication-Results: mail.tambre.ee; spf=fail smtp.mailfrom=tambre.ee
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tambre.ee 249867EB02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tambre.ee; s=201812;
        t=1644216446; bh=1ZuSZkK917+DnbsBJTyoKnsNI3AbwbnGFtaNh1AErE8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wOHR/Bbmhh6Zh+XHczx2X0WjMYtd3PP60SzboIictEX28QeQkfOtl1UKOxSkIxoY2
         SOOxEUqfTq+y+xPTWTRcQqYagfE58hP8e7eH5zQ+RIKiUlEU6Oc0W5VLhOFe+wYEbb
         OxS5Ji36pH7WzTmHCYgHIYCKJ1uoWRaAddTbmdD6/yvWNrSTBYcA3AygkhNPuRetc7
         bpzDvgLycBGe6Pn638YaKrICwH+vTpOhddcGwnq1s3XzcUWEycRxRFr4q/l8cbas+M
         CHUY+yK1FZuDSYlWfXupJ/M5bcVTTQs9kMae8BlHPGVL0LHDKbhKtI51sSqpC8DIpK
         O1+s4ytj8wg5w==
Message-ID: <dcbf28db-d47a-a2e1-dae1-48f17f9a703a@tambre.ee>
Date:   Mon, 7 Feb 2022 08:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V1 04/10] dt-bindings: PHY: P2U: Add support for Tegra234
 P2U block
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com,
        krzysztof.kozlowski@canonical.com, p.zabel@pengutronix.de,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-5-vidyas@nvidia.com>
From:   Raul Tambre <raul@tambre.ee>
In-Reply-To: <20220205162144.30240-5-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-02-05 18:21, Vidya Sagar wrote:
> Subject:
> [PATCH V1 04/10] dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
> From:
> Vidya Sagar <vidyas@nvidia.com>
> Date:
> 2022-02-05, 18:21
> 
> To:
> <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>, 
> <robh+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
> CC:
> <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>, 
> <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>, 
> <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>, 
> <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>, 
> <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>, 
> <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, 
> <sagar.tv@gmail.com>
> 
> 
> Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
> module instantiated once for each PCIe lane between Synopsys DesignWare
> core based PCIe IP and Universal PHY block.
> 
> Signed-off-by: Vidya Sagar<vidyas@nvidia.com>
> ---
>   .../bindings/phy/phy-tegra194-p2u.yaml          | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> index 9a89d05efbda..6ba1f69b1126 100644
> --- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> @@ -4,7 +4,7 @@
>   $id:"http://devicetree.org/schemas/phy/phy-tegra194-p2u.yaml#"
>   $schema:"http://devicetree.org/meta-schemas/core.yaml#"
>   
> -title: NVIDIA Tegra194 P2U binding
> +title: NVIDIA Tegra194 & Tegra234 P2U binding
>   
>   maintainers:
>     - Thierry Reding<treding@nvidia.com>
> @@ -12,13 +12,17 @@ maintainers:
>   description: >
>     Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
>     Speed) each interfacing with 12 and 8 P2U instances respectively.
> +  Tegra234 has three PHY bricks namesly HSIO, NVHS and GBE (Gigabit Ethernet)

typo: namely
