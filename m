Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028B5512E6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiFTIfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbiFTIfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 04:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF012ABA;
        Mon, 20 Jun 2022 01:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B5961312;
        Mon, 20 Jun 2022 08:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63960C341C4;
        Mon, 20 Jun 2022 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655714129;
        bh=13hg9vAkkqd9KUoEdzPHfQiVrLh+Dwj/Z4m2brBRv/E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wt+Hw/L1fCzUcxbpNqWYqN7YvWq3lC2gopJ/YTr0pvKv5ePS0hf6ox+9pLrR9aITY
         C1vqDTMKGnMOtLPSjMrCQrjgcghuqnfKSTuO0QqRky7mwXK+5WC+1ddnQB8TveAXQD
         P6MR/B5fVAYSr0e4bmc9p0kLYd1BE6ulJAeMed/fj5stiNuQhqNCO5IO4FdFH61+4v
         izmuPnWbF1E0mhqvCA5ziag9h2ALMkYp+RmQuZvCTBdS4VvPz1wt6sgQYiLLr8a92p
         ZPybJjNFOUxq1s6JLDLCnAkQzH+ORNu9izrifoBC70Do0114sBeMuhrs6Ad5thN1Tb
         NKot9bhO4uzRQ==
Message-ID: <e3411d6c-ec64-f20e-4c58-13245fe255b5@kernel.org>
Date:   Mon, 20 Jun 2022 10:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
Cc:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
References: <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p3>
 <20220614013042epcms2p36f88b7eb7f879fefb2f3fbd4548ad705@epcms2p3>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220614013042epcms2p36f88b7eb7f879fefb2f3fbd4548ad705@epcms2p3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/06/2022 03:30, Wangseok Lee wrote:
> Add support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> 

(...)

> +
> +enum artpec8_pcie_isolation {
> +	PCIE_CLEAR_ISOLATION = 0,
> +	PCIE_SET_ISOLATION = 1
> +};
> +
> +enum artpec8_pcie_reg_bit {
> +	PCIE_REG_BIT_LOW = 0,
> +	PCIE_REG_BIT_HIGH = 1
> +};

Remove this enum. This is redefinition of true/false or 1/0.

Best regards,
Krzysztof
