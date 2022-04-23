Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4C50CB3F
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiDWOjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDWOjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 10:39:43 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Apr 2022 07:36:45 PDT
Received: from mail.tambre.ee (mail.tambre.ee [IPv6:2a01:7e01:e001:cc::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783A203F65;
        Sat, 23 Apr 2022 07:36:45 -0700 (PDT)
Received: from [IPV6:2001:7d0:8a11:4700:d8bd:7f1f:5e8b:fc58] (fc58-5e8b-7f1f-d8bd-4700-8a11-07d0-2001.dyn.estpak.ee [IPv6:2001:7d0:8a11:4700:d8bd:7f1f:5e8b:fc58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: raul)
        by mail.tambre.ee (Postfix) with ESMTPSA id 8855980062;
        Sat, 23 Apr 2022 17:27:24 +0300 (EEST)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.tambre.ee 8855980062
Authentication-Results: mail.tambre.ee; dmarc=fail (p=reject dis=none) header.from=tambre.ee
Authentication-Results: mail.tambre.ee; spf=fail smtp.mailfrom=tambre.ee
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tambre.ee 8855980062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tambre.ee; s=201812;
        t=1650724045; bh=9gYBnH9KPURUghbXDsxTxayhdYgcj3IoMHz0DPDiA00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YFgvVKD7HJJ9Dxt3j4BzH1t+gogs0lTsdo/enGYiXmC3VXwnRvQ3t57zMMt0iZ+9u
         Jq8Tz1pauz57NTsXO5SiXynbah+A6+ha5nqC4k3sxntLvGPG2geobXEyLphQ+AuEVQ
         iYiQV19jWpvftSMs3dpA1XLNdylbAPuz7lv1tjUks0SW91D1PlFhJEePXndrLmM+rD
         ikX5KpU9FGz3Rx+vUhn+9sQ3swxSMHZHaYzK1pi93hOFGrD7CbbqSH1P+dV0WtViIl
         wKd75cZX/ZjdDfdzDOf0+l2ccErKsDzSqYtZDX96R7FvnavUjmMR5kBTQidW+GsD0V
         CqQNvyZsmn+0w==
Message-ID: <50b80804-e95c-2137-5d74-2451e5bb826f@tambre.ee>
Date:   Sat, 23 Apr 2022 17:27:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2 2/8] dt-bindings: PCI: tegra: Add device tree support
 for Tegra234
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
 <20220423124858.25946-3-vidyas@nvidia.com>
From:   Raul Tambre <raul@tambre.ee>
In-Reply-To: <20220423124858.25946-3-vidyas@nvidia.com>
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
> @@ -47,16 +64,33 @@ Required properties:
>     "p2u-N": where N ranges from 0 to one less than the total number of lanes
>   - nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
>     by controller-id. Following are the controller ids for each controller.
> +  Tegra194:
> +  ---------
>       0: C0
>       1: C1
>       2: C2
>       3: C3
>       4: C4
>       5: C5
> +  Tegra194:

Should this be Tegra234?

> +  ---------
> +    0 : C0
> +    1 : C1
> +    2 : C2
> +    3 : C3
> +    4 : C4
> +    5 : C5
> +    6 : C6
> +    7 : C7
> +    8 : C8
> +    9 : C9
> +    10: C10

