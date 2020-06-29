Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1020D2C9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgF2Sv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 14:51:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18046 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgF2Svx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2020 14:51:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef9ed360000>; Mon, 29 Jun 2020 06:31:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 06:31:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Jun 2020 06:31:47 -0700
Received: from [10.26.75.188] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 13:31:40 +0000
Subject: Re: [PATCH V3 1/2] arm64: tegra: Re-order PCIe aperture mappings to
 support ACPI boot
To:     Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <andrew.murray@arm.com>, <treding@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
 <20200110191500.9538-2-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d52db35b-dbf8-a706-9611-95448cf6a69e@nvidia.com>
Date:   Mon, 29 Jun 2020 14:31:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200110191500.9538-2-vidyas@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593437494; bh=Y32CfHcMUWKKF9wD0CLFw8La6QEVGFVAMOsFhmKdfEU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SHCJ5JM/tbcA1imuBapYWSJr6z+o4OojHikk4j61y7FE/MkNF54FhwyT08IMnjadW
         lHTOBpjK6/7Fj289JNT9INlUuWwXTI4Y+81NRoDs7DLuDK5EPg/dW/qU4MZ9DmvAVM
         gfivYDmVRoUITMwz4H+8CmISt8nEBI9bJSy48Vxzfqo6sixPDGCsAOi0qEeAM2wAAc
         PkYY7LbPQa7d8ZiPLf6HDYMfg4wYlUEIkOribMuqvsIMFnRfI2n1mCzvkn1F1e8VIj
         lMpP0hNtbkeybDwNSPr8ubqADxgY+pBCDAy5o4lvgK4vnUiAVenSFo2B9sXKEgYsJ3
         Z2KSQjp2XTjsg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sagar,

On 10/01/2020 19:14, Vidya Sagar wrote:
> Re-order Tegra194's PCIe aperture mappings to have IO window moved to
> 64-bit aperture and have the entire 32-bit aperture used for accessing
> the configuration space. This makes it to use the entire 32MB of the 32-bit
> aperture for ECAM purpose while booting through ACPI.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Any reason why we should not merge this change, even if patch 2/2 is not
accepted? If there is no harm in us merging this, this would be one less
change for us to carry out-of-tree. If so, can you update and re-post
for 5.9?

Cheers
Jon

-- 
nvpublic
