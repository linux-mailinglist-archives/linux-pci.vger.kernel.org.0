Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C208150D0DB
	for <lists+linux-pci@lfdr.de>; Sun, 24 Apr 2022 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiDXJnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbiDXJnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 05:43:41 -0400
Received: from mail.tambre.ee (mail.tambre.ee [IPv6:2a01:7e01:e001:cc::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492925C62;
        Sun, 24 Apr 2022 02:40:35 -0700 (PDT)
Received: from [IPV6:2001:7d0:8a11:4700:c4d5:f1b8:fb37:c140] (c140-fb37-f1b8-c4d5-4700-8a11-07d0-2001.dyn.estpak.ee [IPv6:2001:7d0:8a11:4700:c4d5:f1b8:fb37:c140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: raul)
        by mail.tambre.ee (Postfix) with ESMTPSA id 0406480063;
        Sun, 24 Apr 2022 12:40:31 +0300 (EEST)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.tambre.ee 0406480063
Authentication-Results: mail.tambre.ee; dmarc=fail (p=reject dis=none) header.from=tambre.ee
Authentication-Results: mail.tambre.ee; spf=fail smtp.mailfrom=tambre.ee
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tambre.ee 0406480063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tambre.ee; s=201812;
        t=1650793232; bh=1O0toTBquK9KiT+VEn92hd5P+unHn/BII6vbA++Qp2o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mzalCyDNVx0FOQrusC4u733EigupzX86l6VGu2yc0xZS2KYyKuv39TrtFsmh497LT
         KkBSPTsn5tFwHO/u18BMXBl3TE3akS9jLhJ36VffGLP/utQ0MW9zHwrsofyKPhEtGB
         DKRUK3BiHXXEZwY+zL8gx8Wj+UrLyRGhXUW9o6S+bZ9KyCRtjn/bzKSiQ+qGORyFkK
         rUe8zmWlbCdtZ7drjIe7ObyiUVXeFIsVvNpayMfL+2ay9Nf8xZ3pS+BzGG5mlbxA8q
         dpjWDvNNpQN806y3RP41OxzIXH3t8srzs9+svpdnwyE2bmqOjjYA6tz405pUFJo9MX
         hpuwoaQl1l4DA==
Message-ID: <1a2a1190-f5d9-e37a-60c0-c7e544b3f24c@tambre.ee>
Date:   Sun, 24 Apr 2022 12:40:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2 8/8] PCI: tegra: Add Tegra234 PCIe support
Content-Language: en-GB
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com, krzk@kernel.org,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220423124858.25946-1-vidyas@nvidia.com>
 <20220423124858.25946-9-vidyas@nvidia.com>
From:   Raul Tambre <raul@tambre.ee>
In-Reply-To: <20220423124858.25946-9-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-04-23 15:48, Vidya Sagar wrote:
> +	/*
> +	 * Controller-5 doesn't need to have its state set by BPMP-FW in
> +	 * Tegra194
> +	 */
> +	if (pcie->cid == 5 && pcie->of_data->version == 0x490A)

Maybe use TEGRA194_DWC_IP_VER like elsewhere?
