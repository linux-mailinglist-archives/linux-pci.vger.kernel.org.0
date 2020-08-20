Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4169B24B02C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgHTHaP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 03:30:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:26636 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHTHaO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 03:30:14 -0400
IronPort-SDR: 8bBDYl41AyOx7NDwWl206ipj+SdbHB5Qhpi5KFLKwK5o04ELkZXK2noc/khjdoEsg7IIxDTmVg
 FbF0k9dXR1pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="155225865"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="155225865"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 00:30:13 -0700
IronPort-SDR: V0bNGK+unpSW220Mv1SyOPGZuGAnuaTlwOCopnjwvfUbDavGw+l76ufZosNkFRFVu19fHTMzAO
 M3q/6zpbWVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="497513364"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2020 00:30:13 -0700
Received: from [10.249.73.140] (ekotax-MOBL.gar.corp.intel.com [10.249.73.140])
        by linux.intel.com (Postfix) with ESMTP id 0595558045A;
        Thu, 20 Aug 2020 00:30:11 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: PCI: intel,lgm-pcie: Fix matching on all
 snps,dw-pcie instances
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
References: <20200819222002.2059917-1-robh@kernel.org>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <e089ab71-e203-7d24-c1a5-6213c925b153@linux.intel.com>
Date:   Thu, 20 Aug 2020 15:30:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819222002.2059917-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/20/2020 6:20 AM, Rob Herring wrote:
> The intel,lgm-pcie binding is matching on all snps,dw-pcie instances
> which is wrong. Add a custom 'select' entry to fix this.
>
> Fixes: e54ea45a4955 ("dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller")
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dilip Kota <eswara.kota@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'll take this via the DT tree.
>
> Rob
>
>   Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> index 64b2c64ca806..a1e2be737eec 100644
> --- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> @@ -9,6 +9,14 @@ title: PCIe RC controller on Intel Gateway SoCs
>   maintainers:
>     - Dilip Kota <eswara.kota@linux.intel.com>
>   
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: intel,lgm-pcie
> +  required:
> +    - compatible
> +
>   properties:
>     compatible:
>       items:

Reviewed-by: Dilip Kota <eswara.kota@linux.intel.com>

Regards,
Dilip
