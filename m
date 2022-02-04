Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298C74A9307
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbiBDEWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 23:22:41 -0500
Received: from mx.socionext.com ([202.248.49.38]:53535 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbiBDEWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 23:22:40 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Feb 2022 13:22:39 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 729652083C4C;
        Fri,  4 Feb 2022 13:22:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 4 Feb 2022 13:22:39 +0900
Received: from [10.212.182.146] (unknown [10.212.182.146])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6DA46C1E22;
        Fri,  4 Feb 2022 13:22:38 +0900 (JST)
Subject: Re: [PATCH 1/3] dt-bindings: PCI: uniphier-ep: Add bindings for NX1
 SoC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1643855786-23186-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1643855786-23186-2-git-send-email-hayashi.kunihiko@socionext.com>
 <1643896226.748637.252333.nullmailer@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <75e28f0b-6a47-8a76-bd8e-aebb99649064@socionext.com>
Date:   Fri, 4 Feb 2022 13:22:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1643896226.748637.252333.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2022/02/03 22:50, Rob Herring wrote:
> On Thu, 03 Feb 2022 11:36:24 +0900, Kunihiko Hayashi wrote:
>> Update PCI endpoint binding document for UniPhier NX1 SoC. Add a
> compatible
>> string, clock and reset lines for the SoC to the document.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 22
> +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml:24
> :9: [warning] too many spaces after hyphen (hyphens)
> ./Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml:25
> :9: [warning] too many spaces after hyphen (hyphens)
> 
> dtschema/dtc warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1587871
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

I ran dt_binding_check, however, after installing 'yamllint' I've found
this warning. I'll resend it.

Thank you,

---
Best Regards
Kunihiko Hayashi
