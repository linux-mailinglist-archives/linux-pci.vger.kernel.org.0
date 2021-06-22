Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9E3AFAC4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 04:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFVCHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 22:07:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:14707 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFVCHj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 22:07:39 -0400
IronPort-SDR: wF2sSkZm2jhURPSwsRDwOzpzOr9gVndzTI0IbcnUOMnAaxiGVrS2isLLs7SwAmczZHbHUPl7Ws
 9IBGZogY3Rhw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203955518"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="203955518"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 19:05:24 -0700
IronPort-SDR: dLdw0mYa572hkEWgSGeMhCBpF7mlTIUXdEFSv85ioGGyeb0SniKyr3vmVizlAGg4dgBU+dFXJA
 S/uIZjF15L1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="490101021"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2021 19:05:18 -0700
Cc:     baolu.lu@linux.intel.com, robdclark@chromium.org,
        linux-kernel@vger.kernel.org, saravanak@google.com,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        quic_c_gdjako@quicinc.com, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, joel@joelfernandes.org,
        rajatja@google.com, sonnyrao@chromium.org, vbadigan@codeaurora.org
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Douglas Anderson <dianders@chromium.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
Date:   Tue, 22 Jun 2021 10:03:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/22/21 7:52 AM, Douglas Anderson wrote:
> @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
>   
>   static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   					    struct iommu_group *group,
> -					    unsigned int type)
> +					    unsigned int type,
> +					    struct device *dev)
>   {
>   	struct iommu_domain *dom;
>   
> @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   	if (!dom)
>   		return -ENOMEM;
>   
> +	/* Save the strictness requests from the device */
> +	if (dev && type == IOMMU_DOMAIN_DMA) {
> +		dom->request_non_strict = dev->request_non_strict_iommu;
> +		dom->force_strict = dev->force_strict_iommu;
> +	}
> +

An iommu default domain might be used by multiple devices which might
have different "strict" attributions. Then who could override who?

Best regards,
baolu
