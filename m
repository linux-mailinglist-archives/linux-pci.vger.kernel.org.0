Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6719D2FB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbgDCJBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:01:47 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:49570 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390595AbgDCJBr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:01:47 -0400
Received: from [192.168.1.4] (212-5-158-241.ip.btc-net.bg [212.5.158.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 596D7CFB0;
        Fri,  3 Apr 2020 12:01:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1585904504; bh=EKR3xtECeHY0HmIwexSCYtXNNqfKBdPLj3t2R7S6Qs0=;
        h=Subject:To:Cc:From:Date:From;
        b=pMikx87MoPJJH0TpBkHLHZ+/IaFu1zzrYSOTx7Er4YUi9wzhJFhWFnOUIIq2jiQC+
         pCy8gAk+cmja01Sn1X2EV6JakSIeGxgVu9DOjCNlePqk1oJt3Cl/YUk5M4MNMukF9o
         bJluTaD9YYPuReHkJNhCkkML8RFpAOtnK6h4fpow3evdBkVyYKYOKDBd27HLLqMaK+
         yecmZQoZxfKKzXoT7CELbFNRKd57rtJkBymduvk3Y0RFF7gkLXNsHiZYOxib5GOsjG
         9UN7WGXAJLiBvBfZWfzpUhDEB3gNRdbQNFtffKJvMkEn8YiorqyoLsK7yCelibFHOG
         34T872L2AfnYQ==
Subject: Re: [PATCH v2 00/10] Multiple fixes in PCIe qcom driver
To:     Ansuel Smith <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <092baa78-24f0-258b-d7c8-fba62b779d96@mm-sol.com>
Date:   Fri, 3 Apr 2020 12:01:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402121148.1767-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

Please run "checkpatch --strict" for the next version.

On 4/2/20 3:11 PM, Ansuel Smith wrote:
> This contains multiple fix for PCIe qcom driver.
> Some optional reset and clocks were missing.
> Fix a problem with no PARF programming that cause kernel lock on load.
> Add support to force gen 1 speed if needed. (due to hardware limitation)
> Add ipq8064 rev 2 support that use a different tx termination offset.
> 
> v2:
> * Drop iATU programming (already done in pcie init)
> * Use max-link-speed instead of force-gen1 custom definition
> * Drop MRRS to 256B (Can't find a realy reason why this was suggested)
> * Introduce a new variant for different revision of ipq8064
> 
> Abhishek Sahu (1):
>   PCIe: qcom: change duplicate PCI reset to phy reset
> 
> Ansuel Smith (7):
>   PCIe: qcom: add missing ipq806x clocks in PCIe driver
>   devicetree: bindings: pci: add missing clks to qcom,pcie
>   PCIe: qcom: Fixed pcie_phy_clk branch issue
>   PCIe: qcom: add missing reset for ipq806x
>   devicetree: bindings: pci: add ext reset to qcom,pcie
>   PCIe: qcom: fix init problem with missing PARF programming
>   devicetree: bindings: pci: add ipq8064 rev 2 variant to qcom,pcie
> 
> Sham Muthayyan (2):
>   PCIe: qcom: add ipq8064 rev2 variant and set tx term offset
>   PCIe: qcom: add Force GEN1 support
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  56 +++++++-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 134 +++++++++++++++---
>  2 files changed, 167 insertions(+), 23 deletions(-)
> 

-- 
regards,
Stan
