Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE41A4D79
	for <lists+linux-pci@lfdr.de>; Sat, 11 Apr 2020 04:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDKCVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 22:21:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36946 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgDKCVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 22:21:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03B2LeCO087819;
        Fri, 10 Apr 2020 21:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586571700;
        bh=nIXY7QAeXSv8f9XHkzJPsSyBosxDw+h4kY/edLG+RLk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zFfH/Ijy0vVIAU66wul/eHxMcqaa/j2W/sKnCWZm+5r+SIGuyCTiY4sH49KIi3dWk
         qt+DIl0ua2SFyX1x5Cx4dtzaP2ieps9q+P2+73Af07bjwmhK1udIK1bGoL1VY+mH+W
         kuBCMOyw6Oj4CFZ0ht9vXVWQMj9FVLXDEPaewKpM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03B2LegC083286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Apr 2020 21:21:40 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 10
 Apr 2020 21:21:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 10 Apr 2020 21:21:40 -0500
Received: from [10.250.133.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03B2LVFq000372;
        Fri, 10 Apr 2020 21:21:33 -0500
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cadence: Deprecate inbound/outbound
 specific bindings
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200327104727.4708-1-kishon@ti.com>
 <20200327104727.4708-2-kishon@ti.com> <20200410163817.GA24330@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <86f6679d-1a5d-16fe-fe1a-f7ae8f46617a@ti.com>
Date:   Sat, 11 Apr 2020 07:51:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410163817.GA24330@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/10/2020 10:08 PM, Rob Herring wrote:
> On Fri, 27 Mar 2020 16:17:25 +0530, Kishon Vijay Abraham I wrote:
>> Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits for
>> host mode as both these could be derived from "ranges" and "dma-ranges"
>> property. "cdns,max-outbound-regions" property would still be required
>> for EP mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
>>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
>>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
>>  .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
>>  .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
>>  5 files changed, 37 insertions(+), 11 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob!

Regards
Kishon
